---
created: 2026-06-23T14:25
updated: 2026-06-23T14:26
---
# ConfigTools Test Gap Analysis — 2026-06-22

> **Status:** Analysis + comprehensive plan complete. Awaiting test org IDs per prod env before implementation starts.
> **Resume prompt:** "Open [[configtools-test-gap-analysis-2026-06-22]] and continue from the fix priority order — start with fix #1 Playwright Phase 3."
> **Last updated:** 2026-06-23 — brainstorm session complete, full plan written, see sections below.

---

## Context

Three production bugs were found manually during the ConfigTools regional rollout (ZA/ENT/UK/US/UAE/UAT). All three should have been caught earlier by the `w-automation-test-hub` skill. This doc captures the root causes and what needs to change.

Related: [[appsettings-audit-2026-06-22]]

---

## The Three Bugs

### Bug 1 — Wrong LightningResourceDataUrl (appsettings)

ZA/ENT/UK `appsettings.{ENV}.json` in ConfigTools.API had:

```
resourcedata.lght.dub.production.local
```

That's a private on-premise DNS name — only resolves inside the data centre, not from AWS ECS. Should be:

```
resourcedata.lght.dub.mixtelematics.com
```

Fixed via PRs #148458 (INT) + #148459 (prod). Real bug, but **not** the cause of the `UnAuthenticatedException` — that was Bug 2.

---

### Bug 2 — Missing authToken on backend save call (create-case/route.ts)

`create-case/route.ts` built the backend URL for `POST/PUT api/configdiff/cases` without appending `?authToken=...`.

ConfigTools.API reads the token via `[FromQuery] string authToken` — getting null → throws `UnAuthenticatedException`.

Every other backend call in that same file passed the token correctly. One-line miss. Fixed via PRs #148460 (INT) + #148461 (prod) — deployed 2026-06-22 as build `production_2026.06.22.4`.

---

### Bug 3 — Aurora RDS SG blocking ConfigTools ECS (ZA)

The ZA Aurora SG only had the Automation API ECS SG in its inbound rules on port 5432. ConfigTools ECS SG was not listed → every DB write timed out with:

```
Failed to connect to 10.76.3.63:5432
```

Fixed by adding the ConfigTools ECS SG to Aurora inbound rules for ZA. **Same fix is still needed for ENT/UK/US/UAE/UAT** as those envs are tested.

---

## Why the Skill Didn't Catch It

### Pipeline as-built

| Stage | Where | What runs |
|---|---|---|
| Stage 1 | INT only | Swagger gate → Health, PageLoad, Modal, Submit → CreateCase + DiffLoad (write) |
| Stage 2 | AU/ZA/ENT/US/UK | PageLoad only (`-NoRecord`) |
| Stage 3 | INT | Playwright — **commented out, not running** |

---

### Bug 1 — Config lint gap

- INT appsettings use different (working) URLs → Stage 1 never sees the bad hostname
- Stage 2 post-deploy smoke only runs `PageLoad` — `LightningResourceDataUrl` is called during diff generation, not page load, so even on ZA the bad URL is never exercised
- No pipeline step checks that prod appsettings hostnames match the allowed pattern

**Gap:** No appsettings lint step. No runtime dependency health check.

---

### Bug 2 — UI proxy layer untested (biggest miss)

Stage 1 `CreateCase` write test calls **ConfigTools.API directly** — it constructs the request itself and appends the authToken. The bug is one layer up in the **Next.js proxy** (`route.ts`). The API test never touches that file.

Phase 3 Playwright **would have caught this** — it drives browser → Next.js → route.ts → API → DB. That's the full real user path.

Phase 3 is commented out.

**Gap:** The UI proxy layer (`route.ts` files) is a structural blind spot. Only Playwright covers it.

---

### Bug 3 — No write validation on prod post-deploy

The pipeline explicitly says "Read-only suites only — no writes to production DBs." That's a correct safety rule. But the consequence: you can deploy to ZA, pass all smoke tests, and have a DB that's completely unreachable from ECS. You only find out when a user tries to save.

**Gap:** No alternative validation that the write path works from ECS. No SG pre-deploy check.

---

## Fix Priority Order

### Fix 1 — Activate Phase 3 Playwright (highest leverage)

**Catches:** Bug 2 and the entire class of UI proxy bugs across all `route.ts` files.

The pipeline YAML already has Phase 3 scaffolded (lines 170–196 in `pipeline/automation-test.yml`) — it's just commented out. Needs:
- Playwright test for CreateCase full E2E (browser → Next.js → API → DB roundtrip)
- Uncomment Stage 3 block
- Wire up `CONFIGTOOLS_ENV=INT` and auth credentials in pipeline variables

**File to edit:** `C:\Projects\SDLC\.agent\skills\w-automation-test-hub\pipeline\automation-test.yml`

---

### Fix 2 — Appsettings hostname lint (quick win, ~30 min)

**Catches:** Bug 1 and any future `.local` / private DNS hostnames sneaking into prod config.

Add a pipeline step to Stage 1 that greps all `appsettings.*.json` files for `.local` hostnames and fails the build:

```powershell
# Pseudo-code — wire into Stage 1 as new job
$badHosts = Select-String -Path "appsettings.*.json" -Pattern "\.local" -Recurse
if ($badHosts) { Write-Error "Prod appsettings contain private hostnames"; exit 1 }
```

Allowlist pattern: everything must match `*.mixtelematics.com` or `localhost` (INT only).

**Where to add:** New job in Stage 1 of `pipeline/automation-test.yml`, before APITests_ReadOnly.

---

### Fix 3 — DB write canary endpoint (belt-and-suspenders)

**Catches:** Bugs 2 + 3 together on every prod post-deploy.

Add `GET /health/db-write-check` to ConfigTools.API: insert a sentinel row → read it back → delete it → return 200/500. No user-visible data.

Add this to Stage 2 smoke on each prod env. If ZA Aurora SG blocks the ECS task, it fails immediately after deploy — not when a user hits Save.

**Files to add/edit:**
- ConfigTools.API: new health controller action
- `w-automation-test-hub/systems/configtools/test-registry.json`: register the new endpoint
- `pipeline/automation-test.yml`: add `DbWriteCheck` suite to Stage 2

---

### Fix 4 — Aurora SG pre-deploy gate (proactive infra check)

**Catches:** Bug 3 before it causes user impact.

Add a pre-deploy step that queries the Aurora SG inbound rules via AWS CLI and fails if the ConfigTools ECS SG is not present:

```powershell
$sgRules = aws ec2 describe-security-groups --group-ids $AuroraSgId --profile $AwsProfile | ConvertFrom-Json
$hasRule = $sgRules.SecurityGroups[0].IpPermissions | Where-Object { 
    $_.UserIdGroupPairs.GroupId -contains $ConfigToolsEcsSgId -and $_.FromPort -eq 5432 
}
if (-not $hasRule) { Write-Error "Aurora SG does not allow ConfigTools ECS on 5432"; exit 1 }
```

**SG IDs to use (ZA):**
- Aurora SG: `sg-02a06d5852fffe3ba`
- ConfigTools ECS SG: `sg-07252ec6f55150ae4`

Same pattern needed for ENT/UK/US/UAE/UAT — SG IDs will differ per env.

---

## Structural Gaps Summary

| Gap | Bugs it caused | Fix |
|---|---|---|
| INT config ≠ prod config, no lint | Bug 1 | Appsettings hostname lint (Fix 2) |
| UI proxy layer (route.ts) untested | Bug 2 | Activate Playwright Phase 3 (Fix 1) |
| No write validation on prod post-deploy | Bugs 2 + 3 | DB write canary (Fix 3) |
| No infra state check before deploy | Bug 3 | Aurora SG pre-deploy gate (Fix 4) |

---

## Open Items (still needed)

- [ ] Aurora SG fix for ENT/UK/US/UAE/UAT (same as ZA fix — add ConfigTools ECS SG to each Aurora inbound)
- [ ] Implement Fix 1: Playwright Phase 3 CreateCase E2E
- [ ] Implement Fix 2: Appsettings lint step
- [ ] Implement Fix 3: DB write canary endpoint
- [ ] Implement Fix 4: Aurora SG pre-deploy gate
- [ ] Collect test org IDs + asset IDs per prod env (user action — see below)

---

## Detailed Bug Analysis — Why Each Was Missed + How We Now Catch It

### Bug 1 — Wrong `LightningResourceDataUrl` (`.local` hostname)

**Why tests missed it:**
- INT uses its OWN appsettings with correct URLs. Phase 1 only runs against INT. The broken prod hostname never touched a test environment.
- Phase 2 post-deploy smoke only exercises `PageLoad`. The bad URL is only called during *diff generation*, not page load. Even running against ZA, the broken DNS never fires.
- Nothing in the pipeline ever reads appsettings files to validate them.

**How we'll catch it now (Fix 2 — Appsettings Lint):**
Add a lint step to `ConfigTools.API api-tests.yml` that runs before deploy. Clones the repo and greps all `appsettings.*.json` for `.local` hostnames — fails the build if any found. Allowlist: `*.mixtelematics.com` or `localhost` (INT only). Catches any future private DNS name at PR time, not post-deploy.

---

### Bug 2 — Missing `authToken` on backend save in `create-case/route.ts`

**Why tests missed it — the most important gap:**
Phase 1 `CT-CD-02` (`Test-CTCreateCase`) calls ConfigTools.API **directly** — it sends `POST /api/configdiff/cases?authToken=...` with the token in the URL. It constructs the request itself. It never touches `route.ts`.

The bug lived in the **Next.js proxy layer** — `create-case/route.ts` forgot to call `backendUrl.searchParams.append("authToken", authToken)`. No Phase 1 test ever touches that file because Phase 1 skips the UI entirely and goes straight to the C# API. There are **zero tests** that drive browser → Next.js → `route.ts` → API.

**How we'll catch it now (Fix 1 — Playwright Phase 3 Write Test):**
Phase 3 Playwright write test drives the real browser → Next.js form submission → `route.ts` → ConfigTools.API → Aurora DB. If `authToken` is ever missing from the backend call again, API returns 401, `route.ts` returns an error, and the test fails. This is the ONLY test layer that covers the proxy.

---

### Bug 3 — Aurora RDS SG not allowing ConfigTools ECS on port 5432

**Why tests missed it:**
Phase 2 post-deploy smoke is explicitly read-only — `PageLoad -NoRecord`. A page load never attempts a DB write. The SG blocks port 5432 from the ConfigTools ECS SG, but read operations (listing cases, fetching orgs) route through Fleet Services, not directly to Aurora. The first user action that hits Aurora (Create Case, Save) is the first thing that fails.

No pre-deploy gate checks infra state — the pipeline deploys and assumes the SG is correct.

**How we'll catch it now (Fix 3 + Fix 4):**
Two layers:
- **DB write canary** — `GET /health/db-write-check` on ConfigTools.API: insert a sentinel row, read it, delete it, return 200/500. Added to Stage 2 smoke on each prod env. Fails immediately after deploy if the SG blocks ECS from hitting Aurora.
- **Aurora SG pre-deploy gate** — PowerShell script reads Aurora SG inbound rules via AWS CLI before Stage 2. Fails if the ConfigTools ECS SG is not listed on port 5432.

---

## Comprehensive Plan — Full Architecture

### Phase structure (complete picture)

```
Phase 0 — [NEW] Infra gate (pre-deploy)
  └── Aurora SG pre-deploy check (Fix 4)

Phase 1 — API Tests (INT + prod envs)
  ├── [NEW] Tier 0: Appsettings lint — grep .local hostnames, fail on find (Fix 2)
  ├── Tier 1: Read-only (Health, Utility, Auth, ConfigDiff GET, ConfigCompare GET)
  └── Tier 2: Write (ConfigDiff write — CreateCase via API directly)

Phase 2 — Smoke (post-deploy, prod envs)
  ├── PageLoad (existing)
  └── [NEW] DBWriteCanary — GET /health/db-write-check (Fix 3)

Phase 3 — Playwright (browser-level, INT after deploy)
  ├── smoke.spec.ts — existing
  ├── config-delta.spec.ts — existing structural + [NEW] CreateCase write roundtrip (Fix 1)
  │     └── login → pick testOrg + testAssets → submit form → verify created → delete
  └── config-compare.spec.ts — existing structural

Phase 4 — Scenario Tests (full user journeys, INT)
  └── ConfigTools scenario suite (CT-API-*, CT-UI-*) — already in SDLC
```

---

## Test Org Architecture — The Data Foundation

### What already exists (caching pattern)

```
cache/configtools-{ENV}.json    ← stores token + orgId (55-min TTL, dynamic)
environments.json testAssetId   ← static single asset per env (currently null for all prod)
```

`Test-CTGetOrgs` already dynamically discovers and caches an `orgId`. Problem: in prod envs the test account has access to many orgs — we'd hit a different one each time. Fix: pin a dedicated test org per env.

### What we're adding to `environments.json`

```json
{
  "name": "ZA",
  "baseUrl": "https://configtools-api.za.mixtelematics.com",
  "uiUrl": "https://configtools.za.mixtelematics.com",
  "testOrgId":    "group-id-of-za-test-org",
  "testAssetId":  67890,
  "testAssetIds": [67890, 67891, 67892],
  "auroraSecurityGroupId": "sg-02a06d5852fffe3ba",
  "configToolsEcsSgId":    "sg-07252ec6f55150ae4"
}
```

### Test data priority order (4 sources)

| Priority | Source | Where | Used for |
|---|---|---|---|
| 1 | `testOrgId` in `environments.json` | Static, per-env | Pinned test org — never drifts |
| 2 | Cached `orgId` in `cache/configtools-{ENV}.json` | Dynamic, 55-min TTL | Fallback when static not set |
| 3 | `testAssetId` in `environments.json` | Static, per-env | Version content + asset config tests |
| 4 | First asset discovered from org | Dynamic | Fallback when static not set |

### Self-healing org cache (same pattern as Automation device cache)

```
data/configtools/org-cache.json — per-env:
  { "ZA": { "testOrgId": "...", "assets": [...], "lastProbed": "2026-06-23T..." } }
```

- 6-hour TTL
- On cache miss: probe org list → validate test org exists + has assets → cache
- If test org is recreated with new IDs, next run re-probes and self-heals
- No manual intervention required once initial IDs are configured

---

## What Needs to Be Built — Full Deliverable List

### Files to create (new)

| File | Purpose | Fix |
|---|---|---|
| `SDLC/.agent/skills/w-automation-test-hub/scripts/lint-appsettings.ps1` | Grep repos for `.local` hostnames | Fix 2 |
| `SDLC/.agent/skills/w-automation-test-hub/scripts/check-aurora-sg.ps1` | Validate Aurora SG inbound rules via AWS CLI | Fix 4 |
| `ConfigTools.API`: `HealthController` action `db-write-check` | Insert sentinel row → read → delete → 200/500 | Fix 3 |

### Files to modify

| File | Change | Fix |
|---|---|---|
| `ConfigTools.UI/tests/config-delta.spec.ts` | Add `[api] authenticated write roundtrip` describe block | Fix 1 |
| `ConfigTools.UI/playwright-tests.yml` | Add `config-delta.spec.ts` to spec list; add `PLAYWRIGHT_CT_TEST_ORG_ID` + `PLAYWRIGHT_CT_TEST_ASSET_IDS` pipeline vars | Fix 1 |
| `SDLC/.agent/skills/w-automation-test-hub/systems/configtools/environments.json` | Add `testOrgId`, `testAssetIds`, `uiUrl` (prod), `auroraSecurityGroupId`, `configToolsEcsSgId` per env | All |
| `SDLC/.agent/skills/w-automation-swagger-test/scripts/configtools-run-tests.ps1` | Prefer `testOrgId` over dynamic discovery | Fix 1 |
| `SDLC/.agent/skills/w-automation-test-hub/pipeline/automation-test.yml` | Uncomment Stage 3; fix working dir to ConfigTools.UI; add appsettings lint to Stage 1; add DBWriteCanary + SG gate to Stage 2 | All |
| `SDLC/.agent/skills/w-automation-test-hub/systems/configtools/test-registry.json` | Register `CT-HC-02` (db-write-check endpoint) | Fix 3 |

---

## Data Collection — What You Need to Bring

For **each** prod env (ZA, ENT, UK, US, AE, UAT), collect:

1. **Org Group ID** — call `GET /api/configdiff/...` with a valid token, OR from the app org picker → inspect network → `api/config-allowed-organisations` response → `.GroupId`
2. **Asset IDs** — 2–3 assets from that org → `GET /api/config/assets/{orgId}` → `.AssetId` per item
3. **Asset with config history** — at least one asset that has stored config versions (needed for version content tests) — verify via `GET /api/config/asset-versions?assetId=X`
4. **Aurora SG IDs** — per env: the Aurora cluster security group ID + the ConfigTools ECS service security group ID

ZA SGs already known:
- Aurora SG: `sg-02a06d5852fffe3ba`
- ConfigTools ECS SG: `sg-07252ec6f55150ae4`

---

## Scalability Notes (for the boss's vision)

The hub is already designed to scale to new systems. Adding a new system requires:
1. Create `systems/<name>/environments.json` + `test-registry.json` + `scenario-suite.json`
2. Add a SDLC `Docs/Scenarios/<repo>/test-suite.json` entry for Phase 4
3. Adapt `api-tests.yml` / `playwright-tests.yml` templates (already parameterized by `HubSystem`)

The four pipeline YAML templates (`api-tests.yml`, `ui-tests.yml`, `playwright-tests.yml`, `scenario-tests.yml`) are the reusable skeleton. Any future Operations Tools app can be onboarded by filling in the system-specific config without touching the shared hub infrastructure.

**Current hub coverage:**
- `automation` — Powerfleet.Automation API + UI (Phases 1–4 live)
- `configtools` — ConfigTools API + UI (Phases 1–3 partially, Phase 3 write test pending)

---

*Created: 2026-06-22 | Updated: 2026-06-23 | Skill: w-automation-test-hub | Related tickets: OPEN-2360, OPEN-2362*
