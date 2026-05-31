---
type: raw
title: OPEN-2438 — OMAN DST CommandLine Tool Investigation
jira: https://powerfleet.atlassian.net/browse/OPEN-2438
sprint: Operations Tools Sprint 26.13
assignee: Marthinus Raath
status: Ready for Grooming (manually move to In Progress Dev on board)
created: 2026-05-28
---

# OPEN-2438 — OMAN: Investigate porting DST CommandLine tool from AU (v18.17 compatibility)

---

## Ticket Description (from Jira)

During the AU DST investigation (2026-05-14, see OPEN-2437), a third DST mechanism was discovered: a command-line tool (`DaylightSavingsTimeAdjusterCommandline`) written specifically for AU orgs where the automatic service does not trigger DST correctly. This tool runs in a loop on an interval until a configured `EndDate`.

Riaan Serfontein has indicated that OMAN may need a similar solution going forward. OMAN currently runs version 18.17 (unsupported legacy) while the commandline tool is built against the current codebase (~v26.x). A direct port is therefore not straightforward.

### Investigation Scope

- Determine what API endpoints the commandline tool calls and whether OMAN v18.17 exposes compatible equivalents
- Assess whether the tool can be built against the 18.17 codebase, or whether a separate legacy-compatible version is feasible
- Consider whether the correct long-term fix is upgrading OMAN rather than backporting the tool
- Document findings and recommendation

**Output:** A clear recommendation on whether and how to support the DST CommandLine tool for OMAN, with effort estimate.

**Reference:** AU commandline tool lives on `HSSYDATS02` at `C:\Projects\DST Command Line\appsettings.json`. Root cause in AU was an expired `EndDate` field that caused the tool to silently stop running.

---

## Key Finding Summary

The CommandLine tool calls two modern Config.Api endpoints introduced in July 2023 (CONFIG-3387, ~v23.7):
- `POST /outdated-daylight-savings` — finds assets with wrong DST params
- `POST /send-command-to-outdated-daylight-savings` — sends Command 45

OMAN v18.17 does NOT have these endpoints. They predate OMAN's version by ~5 years. A direct port is a dead end.

What CAN work — OMAN already has `FMTimeAdjuster.Api` running on HSOMNIIS18/19 with a `/sendcommand/{orgId}/null/null` endpoint that achieves the same result. The pragmatic solution is a thin looping wrapper (console app or PowerShell) that calls this existing endpoint every N minutes — same pattern as the modern tool but targeting the legacy API that already works.

In short — we can't just reuse the existing logic, but we can learn from it and adapt it, and potentially it could be not too much effort.

---

## What the CommandLine Tool Actually Does

**Location (AU):** `C:\Projects\DST Command Line\` on `HSSYDATS02`
**Purpose:** Handles orgs where the automatic `DaylightSavingAdjustmentService` doesn't reliably trigger. Loops every N minutes and forces Command 45 to any outdated assets.

**Flow:**
```
Reads appsettings.json → OrgIds, MinutesInterval, EndDate, TypeIds
Every N minutes until EndDate:
    POST /outdated-daylight-savings    → get assets with wrong DST params
    POST /send-command-to-outdated-daylight-savings → send Command 45 to those assets
```

**appsettings.json (AU example):**
```json
{
  "AppName": "DynaMiX.DeviceConfig.Utilities.DaylightSavingsTimeAdjusterCommandline",
  "Env": "SYD",
  "EndDate": "2025/07/10",
  "MinutesInterval": "60",
  "OrgIds": "-2028909786913159060",
  "AssetIds": "",
  "TypeIds": "MiX4k"
}
```

**NuGet client:** `MiX.ConfigInternal.Api.Client` (modern, ~v26.x)

⚠️ **Critical gotcha:** Silently stops when `EndDate` expires — no error, no alert. AU's problem was exactly this.

---

## Can OMAN v18.17 Run This Tool? — Initial Findings

### The two endpoints the tool calls

| Endpoint | Route | Introduced |
|---|---|---|
| Get outdated assets | `POST /outdated-daylight-savings` | CONFIG-3387, mid-2023 (~v23.7) |
| Send commands | `POST /send-command-to-outdated-daylight-savings` | CONFIG-3387, mid-2023 (~v23.7) |

### The verdict: **NO — direct port is not feasible**

These two endpoints do not exist in OMAN v18.17. OMAN's DeviceConfig API (`http://api.deviceconfig.omn.production.local`) is the v18.17 era Config.Api, which predates these endpoints by approximately 5 years.

**Supporting evidence:**
- CONFIG-3387 ("App or Report for Command 45") shipped on INT in July 2023 — well after v18.17
- The `MiX.ConfigInternal.Api.Client` NuGet used by the commandline tool is the modern client — OMAN doesn't have the matching API to back it
- The tool is compiled against the current ~v26.x .NET codebase; OMAN would require a specific legacy build

---

## Brainstorm — Options

### Option 1: Thin looping wrapper around FMTimeAdjuster.Api (RECOMMENDED near-term)

OMAN already has `FMTimeAdjuster.Api` running on `HSOMNIIS18/19`. This API has an endpoint that does exactly what we need:

```
GET /sendcommand/{orgId}/null/null
```

This sends Command 45 to all assets in the org that need it — the same outcome as the modern CommandLine tool's two-step flow.

**What to build:** A simple .NET console app (or even a PowerShell script) that:
1. Calls `https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/{orgId}/null/null` every N minutes
2. Reads config from a local JSON file (OrgId, interval, EndDate)
3. Logs success/failure to a local file
4. ⚠️ Must run directly on HSOMNIIS19 (jumpbox can't reach IIS APIs — ETS-8669 lesson)

**Effort:** Low — essentially a loop + HTTP call. Could use the exact same console app pattern as the modern tool but swapping endpoints.

**Risk:** Same as existing manual tool — must run on IIS server. Auth needs to be baked in (pre-authenticated or using the server's local network trust).

**Gotcha to avoid:** Set a far-future `EndDate` or make it configurable, and add a log/alert when it stops. The AU problem was silent expiry.

---

### Option 2: Backport CommandLine tool to v18.17 codebase

Build the existing `DaylightSavingsTimeAdjusterCommandline` against the 18.17 codebase.

**Problems:**
- Requires the old 18.17 Config.Api project — the endpoints (`/outdated-daylight-savings`) literally don't exist, so you'd need to add them to the 18.17 API
- That means touching a repo that hasn't been deployed since 2018/2019
- Old .NET Framework version, old NuGet packages, old NuGet feeds — painful build setup
- OMAN is unsupported — no code deployments expected. Adding new API endpoints is a significant deployment event.

**Effort:** High. **Risk:** High. **Recommendation:** Avoid.

---

### Option 3: Upgrade OMAN (correct long-term fix)

Bring OMAN up to a supported version. Once on a current version:
- The `DaylightSavingAdjustmentService` (nightly service) would handle DST automatically
- No CommandLine tool needed at all
- No "run it on the IIS server" workaround

**Effort:** Very high (full environment upgrade). **Timeline:** Unknown. **Recommendation:** This is the RIGHT answer, but likely outside the scope of this spike.

---

## Recommendation

**Short term:** Build a thin Option 1 wrapper targeting OMAN's existing `FMTimeAdjuster.Api`. Low risk, leverages proven infrastructure. Must run on HSOMNIIS19 directly.

**Long term:** Escalate OMAN upgrade to remove the dependency on workarounds entirely.

**Recommendation to document in Jira:** The investigation finding is that a direct port of the modern CommandLine tool is not feasible due to missing API endpoints in v18.17. The pragmatic path is a new lightweight loop calling the legacy `FMTimeAdjuster.Api` endpoint, deployable to HSOMNIIS19.

---

## Open Questions

- [ ] Does Riaan Serfontein need this urgently (before next DST transition) or is it a "nice to have"?
- [ ] Is there an upcoming OMAN upgrade plan that would make this irrelevant?
- [ ] Is auth for the FMTimeAdjuster.Api loop tool baked in (local machine trust) or does it need explicit credentials?
- [ ] What org IDs are affected in OMAN? (Schlumberger-OPG-Oman, OrgID `700083822000352569` — from ETS-8669)

---

## Related Notes

- [[ETS-8669 OMAN Command 45 DST issue]] — jumpbox auth root cause, tool must run on HSOMNIIS19
- [[OMAN DST Command 45 Setup]] — OMAN FMTimeAdjuster setup guide
- [[DST Daylight Saving Times/DST Code Paths]] — full trace of all 4 DST entry points
- [[DST Daylight Saving Times/DST Debug Guide]] — per-environment server details
- [[OMAN-DST-Server-Quick-Reference]] — server map
