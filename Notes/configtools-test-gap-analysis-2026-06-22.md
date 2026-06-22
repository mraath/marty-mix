# ConfigTools Test Gap Analysis — 2026-06-22

> **Status:** Analysis complete. Fixes not yet started.
> **Resume prompt:** "Open [[configtools-test-gap-analysis-2026-06-22]] and continue from the fix priority order — start with fix #1 Playwright Phase 3."

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

---

*Created: 2026-06-22 | Skill: w-automation-test-hub | Related tickets: OPEN-2360, OPEN-2362*
