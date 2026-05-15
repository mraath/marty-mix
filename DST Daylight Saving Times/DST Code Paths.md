---
created: 2026-05-15
updated: 2026-05-15T14:44
---

# DST Code Paths — Command 45

Complete trace of every entry point that triggers `UpdateAssetTimezoneDeviation` (Command 45), through to final delivery to the device.

See also: [[DST Architecture]] | [[Command 45]] | [[DST Debug Guide]]

---

## The Four Entry Points

### Entry 1 — UI / API Events (DynaMiX.Backend)

All these call sites funnel into `DeviceIntegrationManager.UpdateAssetTimezoneDeviation()`.

| File | Class | Method | Trigger |
|---|---|---|---|
| `NancyModules/FleetAdmin/OrgGroupMembershipModule.cs:431` | OrgGroupMembershipModule | `MoveAssetsToSite()` | Asset moved to a different site |
| `NancyModules/FleetAdmin/OrgGroupMembershipModule.cs:672` | OrgGroupMembershipModule | `UpdateSite()` | Site timezone changes |
| `NancyModules/FleetAdmin/OrgGroupMembershipModule.cs:706` | OrgGroupMembershipModule | `MergeToSite()` | Site merge |
| `NancyModules/FleetAdmin/Assets/AssetCommissioningModule.cs:1676` | AssetCommissioningModule | `CommissionAsset()` | Asset commissioned with site |
| `NancyModules/ConfigAdmin/AssetMaintenance/AssetMaintenanceModule.cs:546` | AssetMaintenanceModule | `ChangeAssetConfigurationGroup()` | Config group changed |
| `Services/MiXFleet.Mobile/…/Modules/Data/DataModule.cs:1046` | DataModule | `CreateAsset()` | Mobile: new asset created |
| `Services/MiXFleet.Mobile/…/Modules/Data/DataModule.cs:1079` | DataModule | `UpdateAsset()` | Mobile: asset site or group changed |
| `Services/MiXFleet.Mobile/…/Modules/AssetsAndDriversModule.cs:181` | AssetsAndDriversModule | `CreateAsset()` | Mobile: new asset |
| `Services/MiXFleet.Mobile/…/Modules/AssetsAndDriversModule.cs:220` | AssetsAndDriversModule | `UpdateAsset()` | Mobile: asset updated |

**Flow from Entry 1:**
```
[Any of the above call sites]
  └─► DeviceIntegrationManager.UpdateAssetTimezoneDeviation(authToken, orgId, siteId, assetIds, ...)
        └─► DeviceIntegrationManager.SendCommandToUpdateAssetTimezoneDeviation(...)
              Calculates: param1 = SiteOffset-OrgOffset before DST (seconds)
                          param2 = SiteOffset-OrgOffset after DST (seconds)
                          param3 = Unix timestamp of DST transition (946688400 = no DST)
              Filters:    only FM/Mesa units with REMOTE_COMMAND logical device
              └─► CommandManager.SendCommandToMobileDevice(cmd, assetId, ...)
                    ├─ [DIS unit — M4K/M6K] → DeviceConfigClient.MobileUnitCommands.SendCommandToMobileUnit()
                    │                            → HTTP → Config.Api → device
                    └─ [Legacy unit — M2K]  → SendCommandToMobileDeviceOldWay()
                                               → MessagingManager.AddMessage()
                                               → [dbo].[messages] (Asset Org DB)
```

> `DeviceConfigClient` here is the old client name; the modern equivalent is `MiX.ConfigInternal.Api.Client`.

---

### Entry 2 — Windows Tool (DaylightSavingsTimeAdjusterNew)

Redesigned in 2023 (ticket: CONFIG-3387). WinForms app, runs on jumpbox (HSSYDATS02 for AU, HSOMNIIS19 for OMAN). Calls Config.Api directly — no Backend involved.

```
DaylightSavingsTimeAdjusterNew (WinForms, C:\Projects\DaylightSavingsTimeAdjusterNew)
  └─► Step 1: POST /outdated-daylight-savings
        DaylightSavingsCommand { GroupIds, MobileUnitIds, TypeIds }
        ◄── List<AssetWithoutDST>  (shows assets with wrong/outdated params)

  └─► Step 2 (after user selects assets): POST /send-command-to-outdated-daylight-savings
        List<AssetDSTCommand> { GroupId, MobileUnitId, IsRemoteCommandConnected, Param1, Param2, Param3 }
        ◄── List<string>  (error list — empty = success)
```

NuGet used: `MiX.ConfigInternal.Api.Client` (formerly `MiX.ConfigInternal.Api.Client.2023.12.20230720.1.nupkg`)

---

### Entry 3 — Nightly Windows Service (DaylightSavingAdjustmentService)

Runs at `00:00:01` daily on the app server. Also implemented in `DynaMiX.Backend`.

```
DaylightSavingAdjuster.AdjustSiteDayLightSavingsSettings()  (scheduled)
  Checks: GetDSTCommandsForLastYear() — skips assets that already got correct command this year
  └─► DeviceIntegrationManager.UpdateAssetTimezoneDeviation(authToken, orgId, siteId, assetIdsToUpdate,
                                                             currentUser, correlationId, dstOptionalFields)
        └─► [same flow as Entry 1 from here]
```

Config check on server: `RunDaylightSavingsCommand = true` in app config.
Log: `L:\Services\DynaMiX.Services.DaylightSavingAdjustment\DynaMiX.Services.DaylightSavingAdjustment.log`

---

### Entry 4 — Command Line Tool (DaylightSavingsTimeAdjusterCommandline)

Written specifically for AU (SRE-212, Chevron Barrow Island). Loops every N minutes until `EndDate`. Calls Config.Api directly.

⚠️ **SILENTLY STOPS when EndDate in appsettings.json expires — no error, no alert.**

```
DaylightSavingsTimeAdjusterCommandline (exe, C:\Projects\DST Command Line\ on HSSYDATS02)
  Reads appsettings.json → OrgIds, MinutesInterval, EndDate, TypeIds
  Every N minutes until EndDate:
    └─► POST /outdated-daylight-savings  → get outdated assets
    └─► POST /send-command-to-outdated-daylight-savings  → send Command 45
```

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

---

## Config.Api — DST Endpoints

**Repo:** `C:\Projects\Config.Api`
**Controller:** `MobileUnitCommandsController` (route prefix: `.../mobileunits/`)

| Method | Verb | Route | Body | Returns |
|---|---|---|---|---|
| `SendDaylightSavingsCommandToMobileUnits` | POST | `daylight-savings` | `DaylightSavingsCommand` | `bool` |
| `GetAssetsWithOutdatedDaylightSavingsCommands` | POST | `outdated-daylight-savings` | `DaylightSavingsCommand` | `List<AssetWithoutDST>` |
| `SendCommandsToAssetsWithOutdatedDaylightSavingsCommands` | POST | `send-command-to-outdated-daylight-savings` | `List<AssetDSTCommand>` | `List<string>` (errors) |
| `GetDSTCommandsForLastYear` | GET | `groupIds/{groupId}/mobile-units-list/dstcommandsqueued` | — | `List<MobileUnitMessageDST>` |

**Controller:** `OrganisationController` (route prefix: `.../organisations/`)

| Method | Verb | Route | Returns |
|---|---|---|---|
| `AdjustDaylightSavingsForMobileUnits` | POST | `daylight-savings/mobile-units` | `void` |
| `AdjustDaylightSavingsForOrganisations` | POST | `daylight-savings` | `void` |

**Internal flow inside Config.Api:**
```
DaylightSavingsManager.SendDaylightSavingsCommandToMobileUnits(authToken, groupIds, mobileUnitIds, typeIds)
  └─► For each asset:
        MobileUnitCommandsManager.SendCommandToMobileUnit(authToken, orgId, assetId,
          CommandIdType.UpdateAssetTimezoneDeviation (=45), null, param1, param2, param3)
          └─► [FM path]   → MessagingManager → [dbo].[messages]
          └─► [Mesa path] → device-family CommandSender → [state].[MobileUnitMessage]
```

Swagger:
- INT: `http://ecs-api.config.int.priv/swagger/index.html`
- DEV: `http://api.deviceconfig.dev.priv/swagger/index.html`

---

## MiX.ConfigInternal.Api.Client — DST Client Methods

**Repo:** `C:\Projects\MiX.DeviceConfig\MiX.ConfigInternal.Api.Client`

### InternalOrganisationRepository

| Method | Verb | Endpoint |
|---|---|---|
| `AdjustDaylightSavingsForMobileUnits(correlationId?)` | POST | `/organisations/daylight-savings/mobile-units` |
| `AdjustDaylightSavingsForOrganisations(correlationId?)` | POST | `/organisations/daylight-savings` |

### MobileUnitCommandsRepository (old client — MiX.DeviceConfig.Api.Client)

| Method | Verb | Endpoint |
|---|---|---|
| `SendDaylightSavingsCommandToMobileUnits(authToken, DaylightSavingsCommand)` | POST | `/daylight-savings` |
| `GetAssetsWithOutdatedDaylightSavingsCommands(authToken, DaylightSavingsCommand)` | POST | `/outdated-daylight-savings` |
| `SendCommandsToAssetsWithOutdatedDaylightSavingsCommands(authToken, List<AssetDSTCommand>)` | POST | `/send-command-to-outdated-daylight-savings` |
| `GetDSTCommandsForLastYear(authToken, groupId, now)` | GET | `/groupIds/{groupId}/mobile-units-list/dstcommandsqueued` |

---

## DTOs

```csharp
class DaylightSavingsCommand {
    string GroupIds;
    string MobileUnitIds;
    string TypeIds;
}

class AssetWithoutDST {
    long GroupId; long AssetId; long MobileUnitId;
    string OrganisationName; string AssetDesciption;
    string MobileDeviceTypeDescription;
    bool IsRemoteCommandConnected;
    uint Param1; uint Param2; uint Param3;
    string Status;
    bool MesaHasUniqueIdentifier;
}

class AssetDSTCommand {
    long GroupId; long MobileUnitId;
    bool IsRemoteCommandConnected;
    uint Param1; uint Param2; uint Param3;
}
```

---

## Asset Skip / Filter Rules

These apply inside `DeviceIntegrationManager` (Entry 1 & 3) and inside `DaylightSavingsManager` (Entries 2 & 4):

- Asset missing `BASE_FM_FUNCTIONALITY` **and** `BASE_MESA_FUNCTIONALITY` → silently skipped
- Asset missing `REMOTE_COMMAND` logical device → logged as `FAILURE` at Debug level, not sent
- Already received correct DST command this year (Entry 3 only) → skipped to avoid duplicates

---

## Cornell's Shortcut — Calling Config.Api Directly

No need to copy Backend param calculation logic. Config.Api handles everything.

**2-step process:**
```
1. POST /outdated-daylight-savings
   Body: { "GroupIds": "", "MobileUnitIds": "123,456", "TypeIds": "" }
   Response: List<AssetWithoutDST>  ← shows current vs correct params

2. POST /send-command-to-outdated-daylight-savings
   Body: [{ "GroupId": 0, "MobileUnitId": 123, "IsRemoteCommandConnected": true,
            "Param1": 3600, "Param2": 7200, "Param3": 1698620400 }]
   Response: List<string>  ← errors; empty = all sent OK
```

Or if you just want to fire-and-forget for an org:
```
POST /organisations/daylight-savings/mobile-units   (no body needed — runs for all orgs)
```
