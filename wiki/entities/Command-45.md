---
type: entity
entity_type: Concept
name: Command 45
aliases:
  - UpdateAssetTimezoneDeviation
  - DST Command
sources:
  - DST/Command 45.md
  - DST Daylight Saving Times/DST Code Paths.md
  - DST Daylight Saving Times/DST Debug Guide.md
  - ETS/ETS-8669 OMAN Command 45 DST issue.md
  - OMAN-DST-Server-Quick-Reference.md
last_updated: 2026-05-28
---

Command 45 (`UpdateAssetTimezoneDeviation`) is the device command that tells a MiX/Powerfleet asset what its timezone offset is before and after a DST transition. It is the core mechanism for keeping device clocks aligned with local time across all environments.

## Key Facts

- **Command ID:** 45
- **Function:** Updates timezone deviation on a mobile unit/asset
- **FM format:** `CommandID=45;Params=dword:{p1},dword:{p2},dword:{p3};`
- **Mesa format:** `"CommandId":45,"Param1":{p1},"Param2":{p2},"Param3":{p3}`
- **Param1:** Seconds before DST change (SiteOffset - OrgOffset)
- **Param2:** Seconds after DST change (SiteOffset - OrgOffset)
- **Param3:** Unix timestamp of DST change — `946688400` means "no DST"
- Applies to FM (legacy) and Mesa/Mix4000 devices via separate code paths
- If `BASE_FM_FUNCTIONALITY` and `BASE_MESA_FUNCTIONALITY` are both absent → asset is **silently skipped**
- If `REMOTE_COMMAND` logical device is missing → logs `FAILURE` at Debug level only

## The Four Entry Points

1. **DynaMiX.Backend UI/API events** — site moves, commissioning, config group changes → `DeviceIntegrationManager.UpdateAssetTimezoneDeviation()`
2. **FMTimeAdjuster manual tool** (WinForms) — runs on IIS server (NOT jumpbox), calls Config.Api directly
3. **DaylightSavingAdjustmentService** — nightly Windows service at 00:00:01, scans all assets
4. **DaylightSavingsTimeAdjusterCommandline** — AU-specific loop tool; ⚠️ silently stops when `EndDate` in appsettings.json expires

## Logical Device IDs Required

| Logical Device | ID |
|---|---|
| `BASE_FM_FUNCTIONALITY` | `-4443154563661222391` |
| `BASE_MESA_FUNCTIONALITY` | `2661058860026395155` |
| `REMOTE_COMMAND` | `-7255325733681205281` |

## Connections

- [[DST]] — parent concept
- [[FMTimeAdjuster]] — manual tool that sends this command
- [[DaylightSavingAdjustmentService]] — automatic service
- [[Config-Api]] — modern endpoint receiving the command
- [[DynaMiX-Backend]] — houses `DeviceIntegrationManager`
- [[ETS-8669]] — OMAN incident: tool was run from jumpbox, causing 100% auth failure
- [[OMAN-Environment]] — v18.17 legacy, special gotchas
- [[Ops-Tools]] — OPEN-2438: investigating porting DST CommandLine tool to OMAN

## Key Config.Api Endpoints

| Verb | Route | Purpose |
|---|---|---|
| POST | `daylight-savings` | Send DST command directly |
| POST | `outdated-daylight-savings` | List assets with wrong/outdated params |
| POST | `send-command-to-outdated-daylight-savings` | Send to outdated list |
| GET | `groupIds/{groupId}/mobile-units-list/dstcommandsqueued` | Get last-year DST commands |

## Open Questions

- [ ] Remove `DynaMiX.DeviceConfig.Utilities.DaylightSavingsService`? (noted in Command 45.md)
- [ ] OPEN-2438: Is the DST CommandLine tool portable to OMAN 18.17?
- [ ] FM status change issue: why is status changed 3 times if it always stays Pending?
