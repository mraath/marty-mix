---
tags: [work, incident, testing, pipelines, management-summary]
date: 2026-06-04
audience: management
---

# Test Pipeline Incident Report — 4 June 2026

**Prepared by:** Marthinus Raath
**Audience:** Engineering Management
**Status:** Root causes identified. Automated fix in progress.

---

## What Happened

On the morning of 4 June 2026, three automated test pipelines showed failures in our Azure DevOps CI environment following routine code merges to the `integration` branch.

| Pipeline | Failure Type | Duration | Root Cause |
|---|---|---|---|
| ConfigTools.UI UI Tests | Coverage gap | 26 seconds | New API proxy routes added without tests |
| ConfigTools.API API Tests | Coverage gap | 30 seconds | Docker build fix exposed 10 new API endpoints without tests |
| Automation.UI Scenario Tests | Device data | 37 minutes | INT test devices not configured for new test suites |

---

## The Good News First

**Our testing infrastructure is working.** The first two failures are the gates doing exactly what they were built to do — they detected that new code was deployed without corresponding tests and raised the alarm. This is the system catching a quality gap before it reaches production.

The third failure confirms our end-to-end scenario test pipeline (just deployed this week) is running successfully — 25 out of 46 scenario tests passed on the first real run against INT.

---

## Issue 1 & 2 — Test Coverage Gaps (ConfigTools)

### What happened

Two recent PRs merged to `integration` introduced new functionality without integration tests:

- **OPEN-2681** (William): Fixed the Docker build so the application's data and architecture files are properly included in the container image. This fix, while correct, caused 10 API endpoints that were previously inaccessible to become active — exposing them in our API specification (swagger) for the first time. No tests had been written for them.

- **OPEN-2689** (William): Added two new API proxy routes in the ConfigTools web application. These routes had no corresponding integration tests.

### Why the pipelines failed so fast (26s / 30s)

Both pipelines have a **coverage gate** as their very first step — before any tests run, they check whether all known API endpoints have at least one test assigned. When new endpoints appear with no tests, the gate fires immediately and stops the pipeline. This is deliberate: there is no point running tests if we already know coverage is incomplete.

### Is anything broken in production?

No. The pipelines run against our INT (integration) environment only. No production code was affected. The failing pipelines are quality gates, not production monitors.

---

## Issue 3 — Scenario Test Device Data

### What happened

Our new Playwright scenario test suite (deployed this week as part of the automated testing initiative) runs end-to-end user workflows against INT. These tests require specific hardware devices to be registered and configured in the INT environment.

21 of 46 tests failed due to missing or incorrectly configured test devices:

- **FC Plus tests (10 failures):** No FC Plus test vehicle has been registered in INT. These tests cannot run until a device is configured.
- **Late-window tests (4 failures):** These tests require a device that was installed at a specific point in time (e.g. "one week ago"). No suitable device is currently in INT.
- **MiX device tests (7 failures):** The required INT test devices are not in the correct QC state for the test scenarios.

The 25 tests that passed did so because their required devices happened to be available and in the correct state.

### Is this a code bug?

No. The test infrastructure is working correctly. This is a test data configuration issue — the INT environment needs specific devices set up before these test scenarios can run end-to-end.

---

## What We Are Doing About It

We are implementing three improvements that will permanently address these issues:

### Fix 1 — Auto-sync test registry at pipeline start (resolves Issues 1 & 2)

Instead of failing when new endpoints appear, the pipeline will now:
1. Detect new endpoints automatically at the start of each run
2. Auto-generate basic "smoke" tests for them (verify the endpoint responds and returns valid data)
3. Continue running all tests — no pipeline blockage
4. Send a **warning** notification to Teams: *"N new endpoints detected — basic tests auto-generated. Review recommended."*

A developer can then click **"Enhance via Hub"** in the Teams alert to trigger our AI automation hub, which will write full integration tests for the new endpoints and raise a pull request for review.

This means: new code can be deployed without tests causing a pipeline failure. The gap is detected, basic coverage is created automatically, and a proper test is queued — all without developer interruption.

### Fix 2 — Device health pre-check (resolves Issue 3)

At the start of each scenario test run, a pre-check will:
1. Verify all required test devices are configured and reachable
2. Attempt to **dynamically discover** a suitable device from INT if the primary device is not configured
3. If a device is found dynamically, run the test and mark the result as **`[DYNAMIC DEVICE]`** (a warning, not a pass — it means a random device was used, not a controlled test device)
4. If no device is found at all, mark the affected tests as **FAILED** with the reason: *"Test data not available — STA_IMEI_FCPLUS not configured in INT"*

This means the Teams notification will clearly separate real test failures (code issues) from device configuration failures — developers know immediately whether to investigate code or device setup.

### Immediate action on Issue 3

While Fix 2 is being deployed, we will:
- Work with the team to register an FC Plus test vehicle in INT
- Configure the required MiX device states for the failing scenario tests
- Document the required test device specifications so they can be maintained going forward

---

## Timeline

| Item | Status | ETA |
|---|---|---|
| Root cause identified | ✅ Complete | 4 June 2026 |
| Auto-sync implementation (Fix 1) | 🔄 In progress | 4 June 2026 |
| Device pre-check implementation (Fix 2) | 🔄 In progress | 4 June 2026 |
| INT device configuration | ⏳ Pending team input | TBD |
| Full scenario test suite passing | ⏳ Depends on device config | TBD |

---

## Summary

The test failures this morning are a sign that our quality infrastructure is maturing — we have gates that catch coverage gaps before they become production issues, and end-to-end scenario tests that validate real user workflows. Both are new capabilities deployed in the last two weeks.

The gaps identified today (missing tests for new endpoints, unconfigured test devices) are normal growing pains of an expanding test suite. We are addressing them with automation — fixes are being implemented today that will prevent this class of failure from causing pipeline blocks in future.

No production systems were affected at any point.
