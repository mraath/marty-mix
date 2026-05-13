---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-03-06T09:11
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

- [x] **Step 1b:** Compare `RedisServerUrl` + `RedisDatabaseIndex` across all web.configs on IIS18 and IIS19.
  - **RESULT (2026-03-06): ALL IDENTICAL — RedisServerUrl=10.25.2.23, RedisDatabaseIndex=2 on both nodes, both APIs. Root Cause A (Redis mismatch) ELIMINATED.**
- [ ] **Step 1c:** Telnet to Redis (10.25.2.23:6379) from HSOMNIIS18 to confirm it is reachable
- [ ] **Step 1 (verify):** Re-check HSOMNIIS19 log for `UnauthenticatedException` — confirm still present and check date of latest entries
- [x] **NEW — Run tool directly on IIS server:** Ran tool on HSOMNIIS19 — **SUCCESS (2026-03-06 00:25).** Log on IIS18 shows: "Daylight savings adjustment starting" → "Updating: Schlumberger-OPG-Oman - Arabian Standard Time - C311824/C3100000257 [1 asset(s)]" → "Adjustment for assets completed." Asset -5059187462885730598 (vehicle 768). Root cause = **jumpbox cannot reach IIS APIs over network** — tool must be run directly on the IIS server.
- [x] **Step 2 — DB confirmed:** `CommandID=45` rows found in `dbo.messages` for vehicle 768 and a second FM asset. Messages queued and processed correctly.
- [x] **RESOLVED — All outstanding steps closed.** Steps 3 & 4 (logical device checks) no longer needed — the tool works end-to-end when run on the IIS server.
- [x] ~~If Redis config is confirmed as root cause: raise with the OMAN infra team~~ — Redis config is NOT the issue

---

## Shorter Description

DST Command 45 (timezone deviation update) is not being sent to FM units in OMAN (version 18.17, `Schlumberger-OPG-Oman` database, OrgID `700083822000352569`). Mix4000 units work; FM units do not. OMAN is on an **unsupported version (18.17)** — no code deployments to this environment are expected.

> **Key context:** Mix4000 (Mesa) uses the new DeviceConfig/DIS path. FM uses the legacy `MessagingManager.AddMessage` path. Both paths share the same initial guard checks in `SendCommandToUpdateAssetTimezoneDeviation`.

---

## Affected Vehicles (Reported by Riaan Serfontein)

Database: `Schlumberger-OPG-Oman` | OrgID: `700083822000352569`

| Asset ID             | FM Vehicle ID | Registration |
| :------------------- | :------------ | :----------- |
| -5059187462885730598 | 768           | 1047 MS      |
| -91969000178729676   | 925           | 1126 WA      |
| 4855187782355671943  | 881           | 1220 BK      |
| -1956273178738781837 | 840           | 2584 DA      |
| 843258748896216425   | 1000          | 3032 MS      |
| -3512887242421783741 | 1001          | 3174 MA      |
| -346828344956229991  | 916           | 4005 BM      |
| -3699420126742982453 | 579           | 4120 WK      |
| 7528555069186003893  | 589           | 4290 MA      |
| -8204281797198858810 | 1011          | 4672 DK      |
| -3890793920675579590 | 847           | 7598 MS      |
| 1676695123364614970  | 10210         | 9960 TB      |

---

## Root Cause Analysis

### Root Cause A — Authentication Failure (Redis Session Mismatch) ← ELIMINATED

> **Finding (2026-03-05):** A LOT of `UnauthenticatedException` in the log.
> **Finding (2026-03-06):** Redis config is IDENTICAL on all four web.configs (IIS18 + IIS19, both APIs): RedisServerUrl=10.25.2.23, RedisDatabaseIndex=2. Mismatch is NOT the cause.
> **Real cause of UnauthenticatedException:** Tool was being run from the jumpbox — network/firewall blocks the jumpbox from properly routing auth + command to the same IIS node. Running the tool directly on HSOMNIIS19 succeeded immediately.

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

| Root Cause                                                                                                                                   | Status                          | Evidence                                                                                   | Fixable on 18.17?                                                                              |
| :------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------ | :----------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------- |
| **A: Redis session mismatch** — `FMTimeAdjuster.Api` web.config has wrong/mismatched `RedisServerUrl` or `RedisDatabaseIndex` vs DynaMiX.Api | **ELIMINATED (2026-03-06)**     | All four web.configs identical: RedisServerUrl=10.25.2.23, RedisDatabaseIndex=2            | N/A                                                                                            |
| Redis server unreachable from IIS process                                                                                                    | Not investigated — not needed   | N/A                                                                                        | N/A                                                                                            |
| **Tool run from jumpbox — network prevents correct routing to IIS APIs**                                                                     | **ROOT CAUSE — CONFIRMED & RESOLVED (2026-03-06)** | Tool run on HSOMNIIS19 succeeded; DB confirmed `CommandID=45` messages queued for FM assets | Yes — run the tool directly on HSOMNIIS19. Under `C:\Projects\` there are two tool versions — use the **older one** (same as the jumpbox version). The newer one does not work. |
| **B: Missing `REMOTE_COMMAND` logical device on FM assets**                                                                                  | Not needed — tool worked end-to-end | N/A                                                                                    | N/A                                                                                            |
| OMAN on unsupported v18.17                                                                                                                   | Permanent                       | Environment fact                                                                           | No — upgrade is the real fix                                                                   |
	
> **Important:** Since OMAN is on unsupported v18.17, any "fix" is a workaround. The supported path is upgrading OMAN to the current version. Document these findings for the upgrade justification.

### JIRA Comment — Copy/Paste Ready

**Root Cause & Resolution**

The DST Command 45 adjustment was not being sent to FM units because the **FMTimeAdjuster tool was being run from the jumpbox**. Due to network/firewall restrictions in the OMAN environment, the jumpbox cannot correctly route requests to the IIS APIs — this caused every authentication attempt to fail with `UnauthenticatedException`, preventing any commands from being dispatched.

**Resolution:** The tool was run directly on **HSOMNIIS19**. The IIS log confirmed successful execution — "Adjustment for assets completed" — and the `Schlumberger-OPG-Oman` database was verified to contain the expected `CommandID=45` messages for the affected FM assets. A second FM asset was tested and also confirmed working.

**Going forward:** The FMTimeAdjuster tool must always be run **directly on HSOMNIIS19** (not the jumpbox) in the OMAN environment. On HSOMNIIS19 under `C:\Projects\` there are **two versions of the tool** — only the **older one** (the same version that was previously on the jumpbox) works correctly. Do not use the newer version. Due to the load balancer, execution may be logged on either IIS18 or IIS19 — this is expected behaviour.

No code changes were required. No web.config changes were required (Redis settings were verified identical across all nodes).

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

**Excalidraw Diagram:** [[ETS-8669 DST OMAN Command 45 Flow.excalidraw]]


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
