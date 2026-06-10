---
tags: [work, testing, pipelines, configtools, playwright, debug]
date: 2026-06-04
related: [[Operations Tools]]
---

# 2026-06-04 — Failed Pipeline Tests Analysis

Three ADO test pipelines failed after PRs merged to `integration`. Investigation via REST API logs revealed the causes.

---

## Issue 1: ConfigTools.UI UI Tests — what happened?

Neither removing nor adding broke things — it's new functionality with no tests. OPEN-2681 (William) fixed the Docker image so the `Data/architecture` files actually ship. This activated 10 API endpoints that were always in the code but never properly deployed. OPEN-2689 then added proxy routes in the UI (`/api/proxy/devices`, `/api/proxy/devices/{slug}`) to call two of them. Neither PR wrote integration tests. The coverage gate correctly caught both gaps. **Tests are out of sync with new code — the gate is working exactly as designed.**

**The 10 now-exposed API endpoints:**
```
GET /api/devices, /api/devices/{slug}
GET /api/peripherals, /api/peripherals/{slug}
GET /api/properties, /api/properties/{slug}
GET /api/parameters, /api/parameters/{slug}
GET /api/events, /api/events/{slug}
```

---

## Issue 2: ConfigTools.API API Tests — same thing?

Yes. Same root cause — OPEN-2681's Docker fix surfaced 10 endpoints in swagger that weren't there before. The test registry wasn't updated. **Tests out of sync, gate working correctly.**

---

## Issue 3: Automation.UI Scenarios — data issue?

Yes, entirely data/device state. 21 failed: all 10 FCP tests fail because `STA_IMEI_FCPLUS` is empty (no FC Plus vehicle configured in INT). 4 LATE tests fail because they require specific device timing states. 6 MIX tests fail because specific INT devices aren't in the required QC failure states. **Infrastructure is working perfectly — the tests ran for 37 minutes and 25/46 passed.** The gaps are purely test device data.

---

## "Why did it happen if the scan should run first?"

The scan **did** run first — and it **did** fail. That's exactly what you see: 26s and 30s runs where tests never executed. The gate is working. The problem is architectural: the scan runs post-merge, so the gap is caught too late. Developer merged → CI caught it → developer already gone. **The real fix is catching it pre-merge.**

---

## Brainstormed Solution

### Tier 1 — First Win: Never Reach CI With Gaps (ADO Branch Policy)

Add a build validation policy to the `integration` branch in ADO for ConfigTools.API and ConfigTools.UI. Before any PR can complete, the coverage scan runs as a PR check. If it fails, the PR is blocked. The developer fixes it before merging — CI never sees it.

This is the surgical fix. It costs zero infra — ADO already supports this. The scan scripts already exist. We just wire them as branch policies.

### Tier 2 — When It Still Slips Through: Actionable Teams Messages

When the post-merge gate fails, the Teams card should tell you exactly what to do, not just "failed." Proposed enhanced card:

```
🔴 ConfigTools.API — Swagger Coverage Gate Failed
integration | #20260603.5 | William R.

⚠️  10 NEW endpoints need tests:
  GET /api/devices
  GET /api/devices/{slug}
  GET /api/peripherals
  GET /api/peripherals/{slug}
  + 6 more (see artifact)

[View Build]  [How to Fix]  [Exclude Endpoints]
```

- **"How to Fix"** — links to a doc/wiki page with exact commands
- **"Exclude Endpoints"** — triggers a pipeline running the scan in `--auto-exclude` mode, adds new endpoints to the registry with `pending: true`, raises a PR automatically. Developer merges → CI goes green. Tests tracked as debt.

### Tier 3 — For Scenarios: Device Health Pre-Check

Add a "Device Health" step at the start of `scenario-tests.yml` that runs a 30-second pre-check — verifies each `STA_IMEI_*` env var is set. If empty, skip those suites with a warning rather than running 35 minutes of tests that will all fail. Teams message says: *"FCP suite skipped — STA_IMEI_FCPLUS not configured."* Much cleaner than 21 red failures.

---

## Related tickets
- [[OPEN-2681]] — Docker fix that exposed the 10 new endpoints
- [[OPEN-2689]] — Added proxy routes without tests
- [[OPEN-2583]] — Scenario tests pipeline (Powerfleet.Automation.UI)
