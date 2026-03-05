---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-15T12:39
---
							
# ETS-8669 OMAN Command 45 DST issue

Date: 2026-03-05 Time: 16:20
Parent:: ==xxxx==
Friend:: [[2026-03-05]]
JIRA:ETS-8669 OMAN Command 45 DST issue
[JIRA](https://powerfleet.atlassian.net/browse/ETS-8669)


## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Start Here Tomorrow — Priority Checklist

- [ ] **Step 1b (CRITICAL):** On HSOMNIIS18, open both `web.config` files in Notepad and compare `RedisServerUrl` and `RedisDatabaseIndex`:
  - `C:\inetpub\wwwroot\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\web.config`
  - `C:\inetpub\wwwroot\DynaMiX.Api\web.config`
  - They MUST be identical — mismatch = confirmed root cause of `UnauthenticatedException`
- [ ] **Step 1c:** Telnet to the Redis host on port 6379 from HSOMNIIS18 to confirm Redis is reachable (`telnet <redis-host> 6379`)
- [ ] **Step 1 (verify):** Open the FMTimeAdjuster.Api log on HSOMNIIS19 (`L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\...log`) and confirm `UnauthenticatedException` is still present — check date of latest entries
- [ ] **Step 2:** Run the `dbo.messages` SQL query (see Step 2 below) on `Schlumberger-OPG-Oman` for vehicles 768, 925, 881, 840 — confirm no `CommandID=45` rows exist (expected: none, since auth never passes)
- [ ] **Step 3:** Run logical device SQL (see Step 3 below) for those same vehicles — check if `BASE_FM_FUNCTIONALITY` and `REMOTE_COMMAND` are both present
- [ ] **Step 4:** Run the same logical device query for a known-working Mix4000 asset — confirm it has `BASE_MESA_FUNCTIONALITY` + `REMOTE_COMMAND`
- [ ] **Document findings** in this note and update the Findings Summary table below
- [ ] If Redis config is confirmed as root cause: raise with the OMAN infra team to align `FMTimeAdjuster.Api` web.config Redis settings with `DynaMiX.Api` (no code deploy needed)

---

## Shorter Description

DST Command 45 (timezone deviation update) is not being sent to FM units in OMAN (version 18.17, `Schlumberger-OPG-Oman` database, OrgID `700083822000352569`). Mix4000 units work; FM units do not. OMAN is on an **unsupported version (18.17)** — no code deployments to this environment are expected.

> **Key context:** Mix4000 (Mesa) uses the new DeviceConfig/DIS path. FM uses the legacy `MessagingManager.AddMessage` path. Both paths share the same initial guard checks in `SendCommandToUpdateAssetTimezoneDeviation`.

---

## Affected Vehicles (Reported by Riaan Serfontein)

Database: `Schlumberger-OPG-Oman` | OrgID: `700083822000352569`

| Asset ID | FM Vehicle ID | Registration |
| :--- | :--- | :--- |
| -5059187462885730598 | 768 | 1047 MS |
| -91969000178729676 | 925 | 1126 WA |
| 4855187782355671943 | 881 | 1220 BK |
| -1956273178738781837 | 840 | 2584 DA |
| 843258748896216425 | 1000 | 3032 MS |
| -3512887242421783741 | 1001 | 3174 MA |
| -346828344956229991 | 916 | 4005 BM |
| -3699420126742982453 | 579 | 4120 WK |
| 7528555069186003893 | 589 | 4290 MA |
| -8204281797198858810 | 1011 | 4672 DK |
| -3890793920675579590 | 847 | 7598 MS |
| 1676695123364614970 | 10210 | 9960 TB |

---

## Root Cause Analysis

### Root Cause A — Authentication Failure (Redis Session Mismatch) ← CONFIRMED

> **Finding (2026-03-05):** A LOT of `UnauthenticatedException` in the log = every single request failing auth, not intermittently. This is a **systematic config problem**, not a flaky load balancer.

**How auth actually works (traced through code):**

```
1. Tool logs in:
   POST /authentication/token → DynaMiX.Api
     → AuthenticationManager.Login()
     → SessionRepository.AddSession(user)
     → CacheProvider.Set(authToken, session)  ← WRITES session to Redis

2. Tool sends DST command:
   POST /sendcommand/... → FMTimeAdjuster.Api
     → DaylightSavingAdjuster (line 28-29):
         RedisCache.RedisServerUrl = CoreSettings.Current.RedisServerUrl  ← from web.config
         RedisCache.DatabaseIndex  = CoreSettings.Current.RedisDatabaseIndex
     → groupRepository.GetSites(authToken, orgId)
       → AuthenticationManager.ValidateSession(authToken)
         → SessionRepository.GetSession(authToken)
           → CacheProvider.Get<Session>(authToken)  ← READS from Redis
           → returns NULL → throws UnauthenticatedException
```

**Why EVERY call fails:** `DynaMiX.Api` and `FMTimeAdjuster.Api` must point at the **same Redis server and database index**. If `FMTimeAdjuster.Api`'s `web.config` has wrong, empty, or mismatched `RedisServerUrl` / `RedisDatabaseIndex`, the session written by `DynaMiX.Api` can never be found → 100% failure rate.

**Three possible reasons for this:**

| Reason | How to confirm |
| :--- | :--- |
| `RedisServerUrl` / `RedisDatabaseIndex` mismatch between DynaMiX.Api and FMTimeAdjuster.Api web.configs | Compare the two web.config files on HSOMNIIS18 |
| Redis server is not running or unreachable from the IIS process | Ping/telnet the Redis port (default 6379) from HSOMNIIS18 |
| Tool is authenticating against the **wrong URL** (e.g., INT instead of `https://om.mixtelematics.com`) — session written to INT Redis, OMAN Redis has nothing | Check what URL is set in the tool's `txtEnvironment` field when logging in |

**Relevant code:**
- `DynaMiX.Backend\Data\DynaMiX.Data\Users\SessionRepository.cs` — sessions stored via `CacheProvider` (Redis)
- `DynaMiX.Backend\Core\DynaMiX.Core\Caching\Core2CacheProvider.cs` — Redis implementation
- `DynaMiX.Backend\Services\FMTimeAdjuster\...\FM Time Adjuster\DaylightSavingAdjuster.cs` line 28–29 — Redis init

- **Evidence:** `DynaMiX.Common.UnauthenticatedException` repeated in HSOMNIIS19 log at `AuthenticationManager.ValidateSession`
- **Effect:** ALL commands fail — zero commands ever dispatched to any device type
- **OMAN unsupported v18.17:** This Redis config may never have been correctly set up for the FMTimeAdjuster.Api

### Root Cause B — Missing Logical Device on FM Assets (Silent Skip or FAILURE)

Code path: `DeviceIntegrationManager.cs → SendCommandToUpdateAssetTimezoneDeviation`

```
Line 1235: isUnitBaseFM   = DoesAssetHaveDeviceEnabled(assetId, BASE_FM_FUNCTIONALITY)
Line 1236: isUnitBaseMesa = DoesAssetHaveDeviceEnabled(assetId, BASE_MESA_FUNCTIONALITY)
Line 1237: isUnitTimeZoneAware = isUnitBaseFM || isUnitBaseMesa

if NOT isUnitTimeZoneAware → SILENTLY SKIPPED (no log entry, asset just ignored)

Line 1242: isUnitConnectedToRemoteCommand = DoesAssetHaveDeviceEnabled(assetId, REMOTE_COMMAND)
if NOT isUnitConnectedToRemoteCommand → logs FAILURE (Debug level only):
  ">   FAILURE: Remote message for asset {id} not sent. Not all required logical devices connected."
```

Logical device ID constants (from `LogicalDevices.cs`):
- `BASE_FM_FUNCTIONALITY` = `-4443154563661222391`
- `BASE_MESA_FUNCTIONALITY` = `2661058860026395155`
- `REMOTE_COMMAND` = `-7255325733681205281`

Mix4000 works because it has both `BASE_MESA_FUNCTIONALITY` and `REMOTE_COMMAND` configured. The FM units likely have one or both missing in the `DeviceConfiguration` database.

---

## Step-by-Step Debug Guide

> **Note:** Cannot copy/paste to OMAN servers. All steps below use short vehicle IDs (integers) and simple search terms you can type manually. Start with vehicle **768** (reg 1047 MS) as the test case.

### Step 1 — Confirm UnauthenticatedException in Logs ← START HERE

> **Status (2026-03-05): CONFIRMED — a LOT of `UnauthenticatedException` found in the log.**

Open a text editor on **HSOMNIIS19**:

```
L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log
```

Use Ctrl+F and search for:

| Search term | Meaning |
| :--- | :--- |
| `UnauthenticatedException` | **CONFIRMED** — auth failing on every call |
| `RedisServerUrl` | If logged at startup — note the URL being used |
| `FAILURE:` | Any other command failures after auth |

**A LOT of these = systematic Redis misconfiguration, NOT a flaky load balancer.**

---

### Step 1b — Compare web.config Redis Settings (KEY FIX STEP)

On **HSOMNIIS18**, open both config files in Notepad and compare these two values:

**File 1 — FMTimeAdjuster.Api:**
```
C:\inetpub\wwwroot\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\web.config
```
(or wherever IIS has it under `L:\WebServices\...`)

**File 2 — DynaMiX.Api:**
```
C:\inetpub\wwwroot\DynaMiX.Api\web.config
```

In each file, search (Ctrl+F) for:
- `RedisServerUrl`
- `RedisDatabaseIndex`

**They MUST match exactly.** If they differ, that is the root cause. The session written by DynaMiX.Api goes into one Redis DB; FMTimeAdjuster.Api looks in another and finds nothing.

---

### Step 1c — Check Redis is Running

On HSOMNIIS18 or the jumpbox, open a command prompt and type:

```
telnet <redis-server-hostname> 6379
```

Replace `<redis-server-hostname>` with the value you found in `RedisServerUrl` above.

- **Blank screen** = Redis is reachable
- **Connection refused / timeout** = Redis is down or wrong host — root cause confirmed

---

### Step 2 — Check if Command 45 Was Ever Queued (Messages Table)

Run on database **`Schlumberger-OPG-Oman`** (SQL Server on OMAN):

```sql
SELECT iVehicleID, sParams, dtStarts, dtExpires, sNotes
FROM dbo.messages
WHERE iVehicleID IN (768, 925, 881, 840)
AND sParams LIKE '%CommandID=45%'
ORDER BY dtStarts DESC
```

**Expected outcomes:**

| Result | Meaning |
| :--- | :--- |
| No rows | Command was NEVER queued — failure is before messaging (auth or silent skip) |
| Rows with `sNotes = 'New'` (status 1) | Queued but not yet sent |
| Rows with `sNotes = 'Sent'` (status 4) | Sent — device may be offline/rejecting |
| Rows with `sNotes = 'Expired'` (status 14) | Sent but device never acknowledged |

If **no rows** → proceed to Step 3 (the command never reached the queue).

---

### Step 3 — Check if FM Logical Device is Set on the Asset

Run on the same SQL Server (try both `Schlumberger-OPG-Oman` and `DeviceConfiguration` databases — in 18.17 `DeviceConfiguration` may be a schema within the org database):

```sql
-- Get asset ID from vehicle ID first
SELECT v.iVehicleID, a.AssetId
FROM Vehicles v
JOIN dynamix.Assets a ON a.VehicleId = v.iVehicleId
WHERE v.iVehicleID IN (768, 925, 881)
```

Note the AssetId values returned, then:

```sql
-- Check which logical devices are enabled for those assets
SELECT mu.MobileUnitId, ld.Name, ld.LogicalDeviceId
FROM mobileunit.MobileUnits mu
JOIN mobileunit.MobileUnitLogicalDevices muld ON muld.MobileUnitId = mu.MobileUnitId
JOIN definition.LogicalDevices ld ON ld.LogicalDeviceId = muld.LogicalDeviceId
WHERE mu.MobileUnitId IN (<AssetId from above>)
AND ld.LogicalDeviceId IN (
  -4443154563661222391,
  -7255325733681205281
)
```

Replace `<AssetId from above>` with the values from the first query.

**Expected outcomes:**

| Rows returned | Meaning |
| :--- | :--- |
| Both IDs present for an asset | Config looks correct — issue is elsewhere (auth or send failure) |
| Only `BASE_FM_FUNCTIONALITY` present, no `REMOTE_COMMAND` | **Root Cause B confirmed** — REMOTE_COMMAND is missing |
| Neither ID present | Asset not recognised as an FM unit at all — silently skipped |

---

### Step 4 — Confirm Mix4000 Has Both Devices (Comparison)

Pick a Mix4000 asset that DID succeed, run the same logical device query:

```sql
SELECT mu.MobileUnitId, ld.Name, ld.LogicalDeviceId
FROM mobileunit.MobileUnits mu
JOIN mobileunit.MobileUnitLogicalDevices muld ON muld.MobileUnitId = mu.MobileUnitId
JOIN definition.LogicalDevices ld ON ld.LogicalDeviceId = muld.LogicalDeviceId
WHERE mu.MobileUnitId = <working_mix4000_asset_id>
```

If Mix4000 shows `BASE_MESA_FUNCTIONALITY` (`2661058860026395155`) AND `REMOTE_COMMAND` (`-7255325733681205281`) — and the FM assets from Step 3 do NOT have `REMOTE_COMMAND` — **Root Cause B is confirmed.**

---

### Step 5 — Verify the API is Reachable on Both Nodes

Open a browser on the jumpbox and browse to:

```
https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/
```

A **green 404** = API running correctly.
An error page = API is down or misconfigured — check IIS on HSOMNIIS18/19.

Also try hitting each node directly if possible (by IP or hostname) to check if one node is broken.

---

## Findings Summary

| Root Cause | Status | Evidence | Fixable on 18.17? |
| :--- | :--- | :--- | :--- |
| **A: Redis session mismatch** — `FMTimeAdjuster.Api` web.config has wrong/mismatched `RedisServerUrl` or `RedisDatabaseIndex` vs DynaMiX.Api | **CONFIRMED** (lots of `UnauthenticatedException`) | HSOMNIIS19 log | Yes — update web.config to match, no code deploy needed |
| Redis server unreachable from IIS process | Possible (same symptom as above) | telnet check (Step 1c) | Yes — fix network/firewall or Redis service |
| Tool using wrong auth URL (not `https://om.mixtelematics.com`) | Possible | Check tool config | Yes — use correct URL |
| **B: Missing `REMOTE_COMMAND` logical device on FM assets** | Possible — only reachable once auth is fixed | SQL: Step 3 | Yes — DBA inserts rows into `mobileunit.MobileUnitLogicalDevices` |
| OMAN on unsupported v18.17 | Permanent | Environment fact | No — upgrade is the real fix |
	
> **Important:** Since OMAN is on unsupported v18.17, any "fix" is a workaround. The supported path is upgrading OMAN to the current version. Document these findings for the upgrade justification.

---

---

## Program Flow & Architecture

### Call Chain (Text)

```
FMTimeAdapter Tool (Jumpbox)
  │  POST /sendcommand/{orgId}/{assetId}/{typeId}
  │  Header: X-Auth: {token}
  ▼
FMTimeAdjuster.Api  (HSOMNIIS18 / HSOMNIIS19)
  │  FMTimeAdjusterModule.cs
  │  → NancyHelper.ExtractParameter(Request, "auth")  extracts X-Auth header
  ▼
DaylightSavingAdjuster.AdjustDayLightSavings()
  │  Sets RedisCache.RedisServerUrl  ← from web.config
  │  Sets RedisCache.DatabaseIndex   ← from web.config
  │
  ├─► [AUTH CHECK — happens on first manager call]
  │     AuthenticationManager.ValidateSession(authToken)
  │       └─► SessionRepository.GetSession(authToken)
  │               └─► CacheProvider.Get<Session>(authToken)
  │                       └─► RedisCache.Get(...)
  │                           ├─ Session found  → continues
  │                           └─ Session NULL   → throws UnauthenticatedException ✗
  │                                               (CURRENT FAILURE — lots of these)
  │
  ├─► orgRepository.GetOrganisationSummaries()   [gets all active orgs]
  ├─► groupRepository.GetSites(authToken, orgId) [gets all sites per org]
  └─► deviceIntegrationManager.UpdateAssetTimezoneDeviation(authToken, orgId, siteId, assetIds)
        │
        └─► SendCommandToUpdateAssetTimezoneDeviation()  [DeviceIntegrationManager.cs:1225]
              │
              │  For each asset:
              ├─► IsTheDeviceAvailableForAsset(assetId, BASE_FM_FUNCTIONALITY)   → isUnitBaseFM
              ├─► IsTheDeviceAvailableForAsset(assetId, BASE_MESA_FUNCTIONALITY) → isUnitBaseMesa
              │
              ├─[if NEITHER]──────────────────────────────────────────► SILENT SKIP (no log) ✗
              │
              └─[if EITHER]
                    │
                    ├─► IsTheDeviceAvailableForAsset(assetId, REMOTE_COMMAND)
                    │
                    ├─[REMOTE_COMMAND missing]──────────────────────────► FAILURE log (Debug) ✗
                    │   "FAILURE: Remote message for asset {id} not sent.
                    │    Not all required logical devices connected."
                    │
                    └─[REMOTE_COMMAND present]
                          │
                          └─► CommandManager.SendCommandToMobileDevice(authToken, orgId, command)
                                │
                                ├─► mucProxy.AreMobileUnitsSupportedForCommand(...)
                                │       [checks DeviceConfig/DIS service]
                                │
                                ├─[DIS = true  → Mix4000/Mesa path]──────────────────────────────┐
                                │   mucProxy.SendCommandToMobileUnit(...)                         │
                                │   → DeviceConfig API → [state].[MobileUnitMessage] (Mesa DB)   │
                                │                                                            ✓ WORKS
                                │
                                └─[DIS = false → FM legacy path]─────────────────────────────────┐
                                    SendCommandToMobileDeviceOldWay()                             │
                                    → MessagingManager.AddMessage(authToken, orgId, FMMessage)    │
                                    → [dbo].[messages] (org DB, sParams: "CommandID=45;...")  ✓ WORKS
                                                                                    (IF auth passes)
```

---

### ASCII Wireframe — Where It Breaks

```
┌─────────────────────────────────────────────────────────────────────┐
│                        JUMPBOX TOOL                                  │
│  [Login]──POST /authentication/token──────────────────────────────┐ │
│  [Send] ──POST /sendcommand/{orgId}/null/null (X-Auth: token)     │ │
└──────────────────────────────────────────────┬──────────────────┘ │
                                               │                    │
                         ┌─────────────────────▼────────────────┐  │
                         │   DynaMiX.Api  (HSOMNIIS18/19)        │  │
                         │   POST /authentication/token           │  │
                         │   → Session created                    │  │
                         │   → WRITES token to Redis ────────────┼──┼──► Redis DB (index N)
                         └───────────────────────────────────────┘  │
                                                                      │
                         ┌────────────────────────────────────────┐  │
                         │  FMTimeAdjuster.Api (HSOMNIIS18/19)    │◄─┘
                         │  POST /sendcommand/...                  │
                         │  → Extracts X-Auth token                │
                         │  → Calls DaylightSavingAdjuster         │
                         │  → ValidateSession(token)               │
                         │  → READS token from Redis ─────────────┼──► Redis DB (index M?)
                         │                                         │
                         │   ┌─ IF index N ≠ index M ────────────┼──► Session = NULL
                         │   │  OR wrong Redis host               │    UnauthenticatedException ✗
                         │   │                                     │
                         │   └─ IF same Redis + same index ───────┼──► Session FOUND ✓
                         └────────────────────────────────────────┘    Commands dispatched

KEY: Both web.configs must have IDENTICAL RedisServerUrl + RedisDatabaseIndex
```

**Excalidraw Diagram:** [[ETS-8669 DST OMAN Command 45 Flow]]

---

## Related Notes

- [[OMAN DST Command 45 Setup]]
- [[OMAN-DST-Server-Quick-Reference]]
- [[DST Daylight Saving Times/Latest Oman Issues]]
- [[DST Daylight Saving Times/Gemini]]
- Code: `DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs` line 1225

---

## Code


## Branch

> Branch: Config/MR/Feature/ETS-8669 OMAN Command 45 DST issue.INT

## PR

- [ ] ETS-8669 OMAN Command 45 DST issue > DEV
- [ ] ETS-8669 OMAN Command 45 DST issue > INT
- [ ] ETS-8669 OMAN Command 45 DST issue > UAT
- [ ] ETS-8669 OMAN Command 45 DST issue > PROD
