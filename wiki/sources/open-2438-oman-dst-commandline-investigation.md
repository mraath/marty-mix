---
type: source
title: OPEN-2438 — OMAN DST CommandLine Tool Investigation
date_ingested: 2026-07-20
original_file: raw/OPEN-2438 OMAN DST CommandLine Tool Investigation.md
jira: https://powerfleet.atlassian.net/browse/OPEN-2438
assignee: Marthinus Raath
sprint: Operations Tools Sprint 26.13
---

## Summary

Investigation into porting the AU DST CommandLine tool (`DaylightSavingsTimeAdjusterCommandline`) to OMAN v18.17. The tool was discovered during the AU DST investigation (OPEN-2437) and handles orgs where the automatic `DaylightSavingAdjustmentService` doesn't trigger reliably.

**Key Finding:** A direct port is **not feasible**. The tool calls two Config.Api endpoints (`POST /outdated-daylight-savings` and `POST /send-command-to-outdated-daylight-savings`) introduced in CONFIG-3387 (~v23.7, mid-2023). OMAN v18.17 does not have these endpoints — they predate OMAN's version by ~5 years.

## Recommended Path

Build a **thin looping wrapper** around OMAN's existing `FMTimeAdjuster.Api` (running on HSOMNIIS18/19). The `/sendcommand/{orgId}/null/null` endpoint achieves the same outcome as the modern CommandLine tool's two-step flow. Must run directly on HSOMNIIS19 (jumpbox can't reach IIS APIs — see [[ETS-8669]]).

**Critical gotcha:** The AU root cause was an expired `EndDate` field in `appsettings.json` that caused the tool to silently stop — no error, no alert. The new tool must set a far-future EndDate or make it configurable, with log/alert on stop.

## What the CommandLine Tool Does

| Property | Value |
|---|---|
| Location (AU) | `C:\Projects\DST Command Line\` on `HSSYDATS02` |
| Purpose | Loops every N minutes, forces Command 45 to outdated assets |
| Config | `appsettings.json` — OrgIds, MinutesInterval, EndDate, TypeIds |
| NuGet client | `MiX.ConfigInternal.Api.Client` (modern ~v26.x) |

**Flow:**
```
Reads appsettings.json → OrgIds, MinutesInterval, EndDate, TypeIds
Every N minutes until EndDate:
    POST /outdated-daylight-savings    → get assets with wrong DST params
    POST /send-command-to-outdated-daylight-savings → send Command 45
```

## The Two Modern Endpoints

| Endpoint | Route | Introduced |
|---|---|---|
| Get outdated assets | `POST /outdated-daylight-savings` | CONFIG-3387, mid-2023 (~v23.7) |
| Send commands | `POST /send-command-to-outdated-daylight-savings` | CONFIG-3387, mid-2023 (~v23.7) |

**OMAN verdict:** These endpoints do not exist in v18.17. Direct port is a dead end.

## Options Evaluated

| Option | Effort | Risk | Recommendation |
|---|---|---|---|
| **1. Thin wrapper around FMTimeAdjuster.Api** | Low | Low | ✅ Recommended near-term |
| **2. Backport to v18.17 codebase** | High | High | ❌ Avoid — old .NET Framework, missing endpoints |
| **3. Upgrade OMAN to current** | Very High | Medium | ✅ Correct long-term answer, likely out of scope |

## OMAN's Legacy FMTimeAdjuster.Api

- Running on HSOMNIIS18/19
- Endpoint: `GET /sendcommand/{orgId}/null/null`
- Sends Command 45 to all assets in the org that need it
- Same outcome as the modern tool's two-step flow, via a single existing endpoint
- URL pattern: `https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/{orgId}/null/null`

## Affected Org

- **Schlumberger-OPG-Oman** — OrgID `700083822000352569` (from [[ETS-8669]])

## Open Questions (from raw)

- [ ] Does Riaan Serfontein need this urgently (before next DST transition) or is it "nice to have"?
- [ ] Is there an upcoming OMAN upgrade plan that would make this irrelevant?
- [ ] Auth for FMTimeAdjuster.Api loop tool — baked in (local machine trust) or explicit credentials needed?
- [ ] What other org IDs are affected in OMAN?

## Connections

- [[ETS-8669]] — jumpbox auth root cause; tool must run on HSOMNIIS19
- [[OMAN-DST-Server-Quick-Reference]] — server map
- [[FMTimeAdjuster]] — the legacy API this wrapper would call
- [[DaylightSavingAdjustmentService]] — the automatic service that fails in some orgs
- [[Command-45]] — the command being sent
- [[Config-Api]] — modern endpoints (not available in OMAN v18.17)
