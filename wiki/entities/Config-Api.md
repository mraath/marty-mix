---
type: entity
entity_type: System
name: Config.Api
aliases:
  - DeviceConfig API
  - MobileUnitCommandsController
  - Config Internal API
  - MiX.ConfigInternal.Api.Client
sources:
  - DST Daylight Saving Times/DST Code Paths.md
  - DST Daylight Saving Times/DST Debug Guide.md
last_updated: 2026-05-28
---

Config.Api is the internal DeviceConfig REST API that sits between client tools/services and the device messaging layer. It handles [[Command-45]] dispatch, config retrieval, and mobile unit management. The modern client NuGet is `MiX.ConfigInternal.Api.Client`.

## Key Facts

- **Repo:** `C:\Projects\Config.Api`
- **INT Swagger:** `http://ecs-api.config.int.priv/swagger/index.html`
- **DEV Swagger:** `http://api.deviceconfig.dev.priv/swagger/index.html`
- **OMAN internal:** `http://api.deviceconfig.omn.production.local`
- **NuGet client (modern):** `MiX.ConfigInternal.Api.Client`
- **NuGet client (old):** `MiX.DeviceConfig.Api.Client`

## DST-Relevant Endpoints

| Controller | Verb | Route | Purpose |
|---|---|---|---|
| MobileUnitCommandsController | POST | `daylight-savings` | Send DST command |
| MobileUnitCommandsController | POST | `outdated-daylight-savings` | Get assets with wrong DST params |
| MobileUnitCommandsController | POST | `send-command-to-outdated-daylight-savings` | Send to outdated list |
| MobileUnitCommandsController | GET | `groupIds/{groupId}/mobile-units-list/dstcommandsqueued` | Get last year's DST commands |
| OrganisationController | POST | `daylight-savings/mobile-units` | Adjust all orgs (fire and forget) |
| OrganisationController | POST | `daylight-savings` | Adjust for orgs |

## Internal DST Flow

```
DaylightSavingsManager.SendDaylightSavingsCommandToMobileUnits()
  → For each asset:
      MobileUnitCommandsManager.SendCommandToMobileUnit(CommandId=45, p1, p2, p3)
        ├─ [FM]   → MessagingManager → [dbo].[messages] (asset org DB)
        └─ [Mesa] → device-family CommandSender → [state].[MobileUnitMessage]
```

## Connections

- [[Command-45]] — primary DST command dispatched through this API
- [[FMTimeAdjuster]] — calls this API to send DST commands
- [[DaylightSavingAdjustmentService]] — calls this API via `MiX.ConfigInternal.Api.Client`
- [[DynaMiX-Backend]] — legacy backend that also dispatches via this API
- [[Ops-Tools]] — Powerfleet.Automation calls into Config.Api for device data
