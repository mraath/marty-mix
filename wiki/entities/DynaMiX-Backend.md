---
type: entity
entity_type: System
name: DynaMiX Backend
aliases:
  - DynaMiX.Backend
  - BE
  - DynaMiX API
  - DynaMiX.Services.Api
sources:
  - Paul Stored Proc to see configuration for mobileunit.md
  - Walkthrough - Decommissioning UI & Auth Updates.md
  - DST Daylight Saving Times/DST Code Paths.md
  - DST Daylight Saving Times/DST Debug Guide.md
last_updated: 2026-08-26
---

DynaMiX.Backend is the core .NET backend system for MiX Telematics device configuration, fleet management, and operations. It hosts `DeviceIntegrationManager`, the DST service, and many admin modules. The primary API is `DynaMiX.Services.Api`.

## Key Facts

- **Repo**: `C:\Projects\DynaMiX.Backend`
- **Language**: C# / .NET Framework
- **Key class**: `DeviceIntegrationManager.cs` — `Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\`
- **DST service**: `Services\Daylight Saving Adjustment\` — runs nightly at 00:00:01
- **FMTimeAdjuster API**: `Services\FMTimeAdjuster\` — manual DST tool API
- **NancyModules**: `FleetAdmin\`, `ConfigAdmin\`, `Assets\`, `AssetsAndDrivers\` — HTTP routing layer

## Key Modules / Paths

| Component | Path |
|---|---|
| `DeviceIntegrationManager` | `Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs` (line ~1225 for DST) |
| DST Adjustment Service | `Services\Daylight Saving Adjustment\DynaMiX.Services.DaylightSavingAdjustment\` |
| FMTimeAdjuster.Api | `Services\FMTimeAdjuster\` |
| App configs (per-env) | `Services\Daylight Saving Adjustment\.config\app.{ENV}.config` |
| Asset commissioning | `NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs` |
| Org group membership | `NancyModules\FleetAdmin\OrgGroupMembershipModule.cs` |
| Iridium account/provisioning | `Logic\DynaMiX.Logic\Operations\IridiumManager.cs` (`GetIridiumAccountInfo`, `AddIridiumContractToAsset`) — called from `AssetCommissioningManager.UpdateIridiumSatelliteDetailsIfEnabled` |

## Key Stored Procedures

- `[mobileunit].[mobileUnit_GetGenerationData]` — retrieves full device config generation data for a mobile unit
- `[state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]` — alert calculator for Config Groups page

## Auth

- `DynaMiX.Services.Api` — authentication endpoint (`/authentication/token`) writes session to Redis
- Both APIs in DST flow must share identical `RedisServerUrl` + `RedisDatabaseIndex` in `web.config`

## IMPORTANT: Do Not Call from Automation/Ops Tools

> Per team convention: **NEVER call DynaMiX.Backend from Automation or Ops Tools** — rewrite in Automation API or Config.Api instead. (Reason: prior incidents where Backend coupling broke the isolation boundary.)

## Connections

- [[Config-Api]] — modern DeviceConfig API that replaced/extends DynaMiX.Backend capabilities
- [[Command-45]] — DST command dispatched through `DeviceIntegrationManager`
- [[DST]] — DST service lives in DynaMiX.Backend
- [[FMTimeAdjuster]] — FMTimeAdjuster.Api hosted here
- [[Alerts-Feature]] — alert calculation stored procs called from Backend
- [[Config-Groups-Page]] — Backend powers Config Groups data
- [[Iridium-Integration]] — Backend hosts `FLEET (DynaMiX)`, the API-side endpoint of the Iridium satellite integration
