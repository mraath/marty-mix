---
type: entity
entity_type: System
name: DaylightSavingAdjustmentService
aliases:
  - DynaMiX.Services.DaylightSavingAdjustment
  - DST Windows Service
  - Automatic DST Service
sources:
  - DST Daylight Saving Times/DST Code Paths.md
  - DST Daylight Saving Times/DST Debug Guide.md
last_updated: 2026-05-28
---

The DaylightSavingAdjustmentService is a Windows Service running on the DynaMiX application server for each environment. It runs nightly at `00:00:01` and scans all assets — sending [[Command-45]] to any with outdated timezone deviation parameters.

## Key Facts

- **Schedule:** Daily at `00:00:01` local server time
- **Log path:** `L:\Services\DynaMiX.Services.DaylightSavingAdjustment\DynaMiX.Services.DaylightSavingAdjustment.log`
- **Master switch:** `RunDaylightSavingsCommand = true` in `App.config`
- **Skip logic:** Assets that already received the correct command this year are skipped to avoid duplicates
- Implemented in `DynaMiX.Backend` → `Services\Daylight Saving Adjustment\`
- Calls `DeviceIntegrationManager.UpdateAssetTimezoneDeviation()` — same flow as UI-triggered commands

## Key App.config Settings

| Setting | Expected Value |
|---|---|
| `RunDaylightSavingsCommand` | `true` |
| `RunAtTimeLocal` | `00:00:01` |
| `DynaMixApiUrl` | Correct env URL |
| `DynaMixApiUsername` | `config@mixtel.com` |
| `ConfigServicesApiServerUrl` | Correct env URL |

## Per-Environment Servers

| Environment | Service Host |
|---|---|
| AU/SYD | HSSYDIIS46-47 |
| OMAN | Not applicable (uses legacy FMTimeAdjuster path) |

## Debug Tips

1. Check `services.msc` — is it Running?
2. Check log for `Exception` or `RunDaylightSavingsCommand = false`
3. Check Axiom at `app.axiom.co` (SAML, slug: `powerfleet`) — search `DST Manager`
4. Check Windows Event Viewer (`eventvwr.msc`) → Application → `.NET Runtime` for crashes

## Connections

- [[Command-45]] — the command this service sends
- [[DST]] — parent concept
- [[DynaMiX-Backend]] — houses the service code
- [[Config-Api]] — downstream dispatch target
- [[TECHDEBT-190]] — proposal to move DST service out of DynaMiX.Backend to DeviceConfig repo
