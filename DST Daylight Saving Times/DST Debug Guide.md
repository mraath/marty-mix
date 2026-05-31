---
created: 2026-05-14
updated: 2026-05-14
wiki_ingested: 2026-05-28
---

# DST Debug Guide — Daylight Saving Time Troubleshooting

> **Who is this for?** Any developer who needs to investigate a DST failure. This guide covers both failure modes and has environment-specific checklists at the bottom.

---

## The Two Failure Modes

When a DST issue is reported, it always falls into one of two categories:

### Mode 1 — The Manual Tool Fails

The **FMTimeAdjuster manual tool** is a Windows application used by support staff to trigger DST Command 45 for a specific org or asset. It connects to the `FMTimeAdjuster.Api` running on the IIS server.

**Symptoms:**
- Support staff runs the tool and gets an "Authentication error"
- Mix4000 units update fine but FM units do not
- Tool appears to log in successfully but then fails

**Where to start:** → [Manual Tool Debug Steps](#manual-tool-debug-steps)

---

### Mode 2 — The Automatic DST Service Fails

The **DaylightSavingAdjustmentService** is a Windows Service that runs automatically on a schedule. It scans all assets and sends Command 45 to any that are out of sync. This is the set-and-forget path.

**Symptoms:**
- No DST issues were reported during daylight saving transitions
- DST adjustments are behind or never applied across a whole region/environment
- The service appears to be stopped or erroring on the server

**Where to start:** → [Automatic Service Debug Steps](#automatic-service-debug-steps)

---

## How the System Works

### The Two Code Paths

```
SUPPORT STAFF (Manual)                    SCHEDULED (Automatic)
     │                                           │
FMTimeAdjuster Tool                  DaylightSavingAdjustmentService
     │                                           │  (Windows Service)
     ▼                                           ▼
FMTimeAdjuster.Api (IIS)           DynaMiX.Services.Api (IIS)
     │                                           │
     └──────────────┬────────────────────────────┘
                    ▼
        DeviceIntegrationManager.cs
        SendCommandToUpdateAssetTimezoneDeviation()
                    │
           For each asset check:
           ├─ Has BASE_FM_FUNCTIONALITY?    → FM path
           ├─ Has BASE_MESA_FUNCTIONALITY?  → Mesa/Mix4000 path
           └─ Neither?                     → SILENTLY SKIPPED
                    │
           Also check:
           └─ Has REMOTE_COMMAND?          → if missing → FAILURE (logged at Debug level)
                    │
          ┌─────────┴──────────┐
          ▼                    ▼
     FM Legacy Path       Mesa/Mix4000 Path
  MessagingManager          DeviceConfig API
  [dbo].[messages]    [state].[MobileUnitMessage]
  (asset org DB)         (DataProcessing DB)
```

### What is Command 45?

**Command 45** = `UpdateAssetTimezoneDeviation` — tells a device what its timezone offset is before and after the DST transition.

| Parameter | Meaning |
|---|---|
| Param1 | Seconds before DST change (SiteOffset - OrgOffset) |
| Param2 | Seconds after DST change (SiteOffset - OrgOffset) |
| Param3 | Unix timestamp of the DST change (946688400 = "no DST") |

**FM format:** `CommandID=45;Params=dword:{p1},dword:{p2},dword:{p3};`
**Mesa format:** `"CommandId":45,"Param1":{p1},"Param2":{p2},"Param3":{p3}`

### How Authentication Works (FMTimeAdjuster Path)

This is the most common failure point for the manual tool:

```
1. Tool logs in:
   POST /authentication/token → DynaMiX.Api
     → Writes session token to Redis (e.g. index 2)

2. Tool sends DST command:
   POST /sendcommand/... → FMTimeAdjuster.Api
     → Reads Redis to validate session token

⚠️  CRITICAL: Both APIs MUST point at the SAME Redis server + database index.
    If they differ → session is NEVER found → UnauthenticatedException on every call.
```

---

## Manual Tool Debug Steps

### Step 1 — Find the Log

Go to the IIS server for the environment (see [Per-Environment Setup](#per-environment-setup)) and open:

```
L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log
```

Use Ctrl+F to search for:

| Search term | What it means |
|---|---|
| `UnauthenticatedException` | Auth failing — Redis mismatch OR wrong URL OR tool on wrong machine |
| `FAILURE:` | Command dispatch failures after auth |
| `DST Manager` | Successful command dispatch entries |
| `Adjustment for assets completed` | All commands sent successfully |

**A flood of `UnauthenticatedException` = systematic failure**, not a random glitch.

---

### Step 2 — Check Which Machine the Tool Is Running On

> **⚠️ CRITICAL LESSON (learned in OMAN, March 2026):** The tool MUST be run directly on the IIS server. Running it from a jumpbox causes 100% auth failures because the network/firewall blocks the jumpbox from correctly routing requests to the IIS APIs.

**Correct:** Run `FMTimeAdjusterCommandline` directly on the IIS server (e.g. via RDP session on the server itself).

**Wrong:** Run the tool from a jumpbox or your local machine.

If this was the issue → re-run on the correct server and confirm success.

---

### Step 3 — Check Redis Configuration (if still failing)

If running on the correct server still fails with `UnauthenticatedException`, the Redis config is mismatched.

On the IIS server, open both config files in Notepad and compare:

**File 1 — FMTimeAdjuster.Api:**
```
C:\inetpub\wwwroot\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\web.config
```
(or wherever IIS has it under `L:\WebServices\...`)

**File 2 — DynaMiX.Api:**
```
C:\inetpub\wwwroot\DynaMiX.Api\web.config
```

Search (Ctrl+F) for these keys in both files:
- `RedisServerUrl`
- `RedisDatabaseIndex`

**They must be identical.** If they differ → that is the root cause. Update the FMTimeAdjuster.Api `web.config` to match DynaMiX.Api.

---

### Step 4 — Verify the API is Reachable

Open a browser on the server and navigate to the FMTimeAdjuster.Api URL (see [Per-Environment Setup](#per-environment-setup)).

- **Green 404** = API is running correctly (this is the expected result for a Nancy API)
- **Error page / not found** = API is down → check IIS on the server

---

### Step 5 — Check if Commands Were Queued in the Database

If auth passes but you are unsure if commands made it to devices, check the database.

**For FM units** (asset org database, e.g. `Schlumberger-OPG-Oman`):

```sql
SELECT iVehicleID, sParams, dtStarts, dtExpires, sNotes
FROM dbo.messages
WHERE iVehicleID IN (768, 925)   -- replace with affected vehicle IDs
AND sParams LIKE '%CommandID=45%'
ORDER BY dtStarts DESC
```

**For Mesa/Mix4000 units** (DataProcessing database):

```sql
SELECT MobileUnitId, ParamsJson, CreatedOn
FROM state.MobileUnitMessage
WHERE ParamsJson LIKE '%"CommandId":45%'
ORDER BY CreatedOn DESC
```

**What to look for:**

| Result | Meaning |
|---|---|
| No rows at all | Command was never queued — failure is auth or silent skip |
| Rows with status 1 (New) | Queued but not yet sent |
| Rows with status 4 (Sent) | Sent — device may be offline |
| Rows with status 14 (Expired) | Sent but device never acknowledged |

Message status codes: `1=New, 4=Sent, 9=Received, 10=Accepted, 13=Acknowledged, 14=Expired`

---

### Step 6 — Check Logical Devices (if commands never queue)

If Step 5 shows no rows at all, the asset is either being silently skipped or hitting a "FAILURE" log.

Run this SQL on the `DeviceConfiguration` database (`DSINTSQL01` for INT, or the relevant server):

```sql
-- Check logical devices for the affected assets
SELECT mu.MobileUnitId, ld.Name, ld.LogicalDeviceId
FROM mobileunit.MobileUnits mu
JOIN mobileunit.MobileUnitLogicalDevices muld ON muld.MobileUnitId = mu.MobileUnitId
JOIN definition.LogicalDevices ld ON ld.LogicalDeviceId = muld.LogicalDeviceId
WHERE mu.MobileUnitId IN (<AssetId1>, <AssetId2>)   -- use AssetId not VehicleId
AND ld.LogicalDeviceId IN (
  -4443154563661222391,   -- BASE_FM_FUNCTIONALITY
   2661058860026395155,   -- BASE_MESA_FUNCTIONALITY
  -7255325733681205281    -- REMOTE_COMMAND
)
```

**What to look for:**

| Result | Meaning |
|---|---|
| Neither FM nor Mesa present | Asset silently skipped — no command ever sent |
| FM or Mesa present, but no REMOTE_COMMAND | "FAILURE" log entry — needs REMOTE_COMMAND logical device added |
| All three present | Config looks fine — issue is elsewhere |

---

## Automatic Service Debug Steps

### Step 1 — Find the Server

The `DaylightSavingAdjustmentService` is a Windows Service. It runs on the DynaMiX application server for each environment (see [Per-Environment Setup](#per-environment-setup)).

RDP into the server and open **Services** (`services.msc`). Search for:
```
DynaMiX.Services.DaylightSavingAdjustment
```

Check:
- Is it **Running**? If stopped → start it and note the time.
- When did it **last start**? (right-click → Properties → recent events)

---

### Step 2 — Check the Service Log

Log path is configured in `app.config` per environment. For most environments:

```
L:\Services\DynaMiX.Services.DaylightSavingAdjustment\DynaMiX.Services.DaylightSavingAdjustment.log
```

Use a text editor or `type` in Command Prompt. Search for:

| Search term | Meaning |
|---|---|
| `Starting` | Service started a run |
| `Daylight savings adjustment starting` | About to process an org |
| `Adjustment for assets completed` | Run completed successfully |
| `Exception` | Error — read the full stack trace |
| `RunDaylightSavingsCommand = false` | Feature is disabled in config — turn it on |

---

### Step 3 — Check the App Config

On the server, find the service config file. It should be next to the `.exe`:

```
L:\Services\DynaMiX.Services.DaylightSavingAdjustment\App.config
```

Key settings to check:

| Setting | Description | Expected value |
|---|---|---|
| `RunDaylightSavingsCommand` | Master on/off switch | `true` |
| `RunAtTimeLocal` | Time of day it runs | Usually `00:00:01` |
| `DynaMixApiUrl` | API it connects to | Correct env URL (see below) |
| `DynaMixApiUsername` | Service account | `config@mixtel.com` |
| `ConfigServicesApiServerUrl` | DeviceConfig API URL | Correct env URL |

---

### Step 4 — Check Axiom

If you cannot access the server directly or need more history:

1. Go to **[app.axiom.co](https://app.axiom.co/)** → click **"Continue with SAML"** → slug: **`powerfleet`**
2. Search for any of these terms depending on what you need:

| Search term | What it finds |
|---|---|
| `DST Manager` | General DST service activity |
| `DynaMiX.Services.DaylightSavingAdjustment` | Service-level logs |
| `StartDSTAdjustment` | When a run kicks off |
| `Adjustment for sites starting` | Per-org adjustment progress |
| `UnauthenticatedException` | Auth failures (manual tool path) |
| `FAILURE:` | Command dispatch failures |
| `UpdateAssetTimezoneDeviation` | DeviceConfig API command calls |

3. Filter by environment / time range

Axiom captures logs from all environments and is often faster than RDP for a quick sanity check.

---

### Step 5 — Check Windows Event Viewer for Crashes

If the service is stopped and you cannot find a reason in the log:

1. RDP into the server
2. Open **Event Viewer** (`eventvwr.msc`)
3. Go to: `Windows Logs → Application`
4. Filter by Source: `DynaMiX.Services.DaylightSavingAdjustment` or `.NET Runtime`
5. Look for crash events with red X icons

---

## Per-Environment Setup

---

### OMAN (OMN) — v18.17 (Unsupported Legacy)

> **Warning:** OMAN runs version 18.17 which is no longer supported. No code deployments to this environment are expected. Any fix here is a workaround only. The proper fix is an upgrade.

| Item | Value |
|---|---|
| IIS Servers | `HSOMNIIS18`, `HSOMNIIS19` |
| Support utility server | `HSOMNATS01` |
| Other servers | `HSOMNAPP03`, `HSOMNAPP09`, `HSOMNMSMQ03` |
| External gateway | `omntsg.mixtelematics.com` |
| DynaMiX API | `https://om.mixtelematics.com/DynaMiX.Services.Api` |
| FMTimeAdjuster.Api | `https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api` |
| DeviceConfig API (internal) | `http://api.deviceconfig.omn.production.local` |
| API log path | `L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log` |
| DST Service log path | `L:\Services\DynaMiX.Services.DaylightSavingAdjustment\DynaMiX.Services.DaylightSavingAdjustment.log` |
| Redis server | `10.25.2.23`, database index `2` |
| Org example (Schlumberger) | OrgID `700083822000352569`, DB `Schlumberger-OPG-Oman` |

**OMAN-specific gotchas:**
- Tool must be run **directly on HSOMNIIS19** — not from the jumpbox (network blocks auth routing)
- On HSOMNIIS19 there are **two versions** of the tool — use the **older one** (same version as was previously on the jumpbox). The newer version is incompatible with v18.17
- Load balancer may write logs on either IIS18 or IIS19 — this is normal
- Redis config on all four web.configs (`HSOMNIIS18` + `HSOMNIIS19`, both APIs) must be identical

**Related notes:** [[OMAN-DST-Server-Quick-Reference]], [[ETS-8669 OMAN Command 45 DST issue]], [[DST Daylight Saving Times/Latest Oman Issues]]

---

### Australia (AU / SYD)

> **Investigation status (2026-05-14):** Service failure reported — currently under investigation.

**Server reference:**
- [[Production Servers]] — full production server list (includes AU / SYD hostnames)
- [[Need Parent/Development Servers]] — development/INT server list

**AU / SYD server map (from Production wiki, last checked 2026-05-14):**

| Server | Function | Notes |
|---|---|---|
| **HSSYDIIS46-47** | `DynaMiX.Services.Api` | **Start here — DST Windows service runs here** |
| **HSSYDIIS44-45** | DynaMiX API + DynaMiX UI | Auth API — DST service connects to this |
| HSSYDIIS55-56 | Config API | |
| HSSYDIIS41 | Config API | MiX Integrate only |
| HSSYDAPC01-02 | FM Downloader | Gateway: `sydtsg.mixtelematics.com` |
| HSSYDAPP14-17 | DIS (active/passive) | |
| HSSYDAPP35 | Devices | |

| Item | Value |
|---|---|
| Environment code | `HSSYD` / `SYD` |
| DynaMiX API | `https://au.mixtelematics.com/DynaMiX.Services.Api` |
| Device Config API (internal) | `http://api.deviceconfig.syd.production.local` |
| Authentication API (internal) | `http://api.authentication.syd.production.local` |
| Fleet Services API (internal) | `http://api.fleet.syd.production.local` |
| SQL Server | `SQL07LST.sydney.production.local` |
| Database | `FMOnlineDB` |
| Service account | `config@mixtel.com` / `c0nf1gsvc!` |
| DST Service log path | `L:\Services\DynaMiX.Services.DaylightSavingAdjustment\DynaMiX.Services.DaylightSavingAdjustment.log` |
| App config source | `DynaMiX.Backend\Services\Daylight Saving Adjustment\.config\app.HSSYD.config` |

**AU-specific notes:**
- AU uses the **automatic Windows Service** path (`DaylightSavingAdjustmentService`), not the legacy FMTimeAdjuster.Api
- Start debug at [Automatic Service Debug Steps](#automatic-service-debug-steps)
- Check Windows Event Viewer for service crashes — AU has had untracked service restarts before
- *(Update this section as investigation progresses)*

---

### ALG

| Item | Value |
|---|---|
| IIS Server | `HSATSDMXIIS01` |
| API log path | `L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api` |
| Setup | Copied from OMAN — same gotchas apply |

**Related notes:** [[Setting up DST Command 45 in ALG]]

---

### INT / DEV (for testing)

| Item | Value |
|---|---|
| DeviceConfig API | `http://api.deviceconfig.int.development.domain.local` |
| FMTimeAdjuster.Api (DEV) | `http://config.dev.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api` |
| SQL Server | `DSINTSQL01` (Windows auth, `-E` flag) |
| Database | `DeviceConfiguration` |

```powershell
# Quick DB check on INT
sqlcmd -S DSINTSQL01 -d DeviceConfiguration -E -Q "SELECT TOP 5 * FROM mobileunit.MobileUnits"
```

---

## Quick Reference — Code Locations

| Component | Repo | Path |
|---|---|---|
| Automatic DST Service | `DynaMiX.Backend` | `Services\Daylight Saving Adjustment\` |
| `DaylightSavingAdjuster.cs` | `DynaMiX.Backend` | `Services\FMTimeAdjuster\...\FM Time Adjuster\` |
| `DeviceIntegrationManager.cs` | `DynaMiX.Backend` | `Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\` (line ~1225) |
| Manual commandline tool | `DynaMiX.DeviceConfig` | `DynaMiX.DeviceConfig.Utilities.DaylightSavingsTimeAdjusterCommandline\` |
| Windows Service tool | `DynaMiX.DeviceConfig` | `DynaMiX.DeviceConfig.Utilities.DaylightSavingsService\` |
| Legacy FMTimeAdjuster tool | `DynaMiX.DeviceConfig` | `DaylightSavingsTimeAdjuster\` |
| App configs | `DynaMiX.Backend` | `Services\Daylight Saving Adjustment\.config\app.{ENV}.config` |

---

## Related Notes

- [[ETS-8669 OMAN Command 45 DST issue]] — full root cause analysis of the Oman 2026 incident
- [[OMAN-DST-Server-Quick-Reference]] — quick server reference for OMAN
- [[DST Daylight Saving Times/Latest Oman Issues]] — Feb 2026 investigation chat log
- [[OMAN DST Command 45 Setup]] — original OMAN setup guide
- [[Setting up DST Command 45 in ALG]] — ALG environment parallel setup
- [[Need Parent/DST Moving Parts]] — architecture diagram (Excalidraw)
