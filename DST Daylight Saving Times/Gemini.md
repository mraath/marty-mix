---
created: 2026-02-19T10:51
updated: 2026-02-19T13:06
---
# Daylight Saving Time (DST) & Command 45 Summary

![[DST Architecture.excalidraw]]

This document serves as the primary reference for DST operations, particularly concerning the Oman server environment and Command 45. It consolidates findings from previous investigations, server logs, and configuration notes.

## 1. Environment Versions & Clients

There are two primary versions of the DST environment relevant to our operations:

### 1.1 Oman Server (Version 18.17)
*   **Version:** 18.17.3 (Older technology).
*   **Server Name:** `HSOMNIIS18`.
*   **API:** `FMTimeAdjuster.Api`.
*   **Gateway:** `omntsg.mixtelematics.com` (Note: Do NOT use `atsats.mixtelematics.com`).
*   **Client Compatibility:** Because 18.17 uses older technology, the **latest client cannot be used**. You must use the **OLD 18.17 compatible `FMTimeAdapter` app**.
*   **Tool Location:** The compatible tool is located on the **jumpbox** (e.g., `c:\projects\DaylightSavingsTime.22.2` or similar legacy paths).

### 1.2 Latest Version
*   Used in other environments (e.g., ALG, INT).
*   Uses newer client/API structures.

---

## 2. Command 45 Overview

**Command 45** is the instruction sent to mobile units to update their timezone deviation settings.

*   **Function:** Adjusts the offset between the Site Timezone and the Organisation Timezone.
*   **Triggers:**
    *   Moving an asset to a new site.
    *   Manual execution via the DST Tool.
    *   Automated DST service.

### Command Structure
*   **FM Command:** `CommandID=45;Params=dword:{param1},dword:{param2},dword:{param3};`
*   **Mesa Command:** `"CommandId":45,"Param1":{param1},"Param2":{param2},"Param3":{param3},`

*   **Param1:** Time difference (seconds) *before* deviation (SiteOffset - OrgOffset).
*   **Param2:** Time difference (seconds) *after* deviation (SiteOffset - OrgOffset).
*   **Param3:** Deviation date in Unix Time. (Note: `946688400` indicates no DST in Windows).

---

## 3. Oman Server Setup & Troubleshooting

### 3.1 IIS Setup (HSOMNIIS18)
To ensure the `FMTimeAdjuster.Api` is functioning correctly on the Oman server:

1.  **Verify API Status:**
    *   Browse to the API endpoint.
    *   A **Green 404** error indicates the API is running correctly.
    *   **Endpoint Example:** `https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/{orgId}/null/null`

2.  **Common Errors & Fixes:**
    *   **Automapper Error:** If the API fails to load (yellow screen of death), it is likely an Automapper configuration issue in the `web.config`.
    *   **Fix:** Ensure the configuration matches the 18.17 compatible format (refer to `OMAN DST Command 45 Setup.md` for specific XML snippets if needed).
    *   **.NET Framework:** The tool and API may require .NET Framework 4.5.2+ capabilities.

### 3.2 Running the Tool
1.  Access the **Jumpbox**.
2.  Run the **18.17 compatible `FMTimeAdapter` app**.
3.  **URL Config:** For the **old tool**, you must use this specific URL: `https://om.mixtelematics.com`.
4.  Check log files for errors (see below).

---

## 4. Logs & Verification

### 4.1 Log File Location (Oman Server)
The primary log file for the DST service on the Oman server is located at:
`L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log`

### 4.2 Searching Logs
When troubleshooting, search for the following terms in the log file or via centralized logging:

*   **"DST Manager"** (Indicates UI tool logging, often Debug level).
*   **"updateAssetTimezoneDeviation"**
*   **"Command 45"**

### 4.3 Logz.io Queries
You can use Logz.io to trace these events. Use the following filters:

**Service Filter:**
*   `StartDSTAdjustment`
*   `DynaMiX.Services.DaylightSavingAdjustment`

**Search Phrases:**
*   `DST Manager`
*   `Next adjustment`
*   `Starting adjuster`
*   `Adjustment for sites starting`
*   `Updating organisation`
*   `Command used`
*   `failure`

### 4.4 SQL Verification
To verify if commands were actually sent:

1.  Check the `messages` table in the relevant database.
2.  Look for `CommandID=45` in `sParams` (FM) or `CommandId":45` in `ParamsJson` (Mesa).
3.  **Status Codes:**
    *   `1`: New
    *   `4`: Sent
    *   `9`: Received
    *   `10`: Accepted
    *   `13`: Acknowledged

---

## 5. Ongoing Investigation: Mobile Unit Issues

**Current Status:**
There are reports of mobile units on the Oman server that **cannot accept Command 45**.

**Next Steps:**
1.  Investigate the specific device types involved.
2.  Review the code for the 18.17 adapter to see how it constructs the command for these specific units.
3.  Analyze the `FMTimeAdjuster.Api.log` specifically for rejections or formatting errors related to these units.
4.  Determine if the "older tech" on Oman is generating a command format that newer firmware on these devices rejects, or vice-versa.

---

## 6. Recent Issues (Feb 2026)

For details on the latest reported issues, including specific vehicle lists and chat logs with Riaan Serfontein, see:
[[DST Daylight Saving Times/Latest Oman Issues]]

---

## 7. Deep Dive: Command Flow & Error Handling (Investigated Feb 2026)

Based on the code trace, here is exactly how the tool works and where it fails.

### 7.1 Architecture & Call Chain
The architecture diagram above has been updated to reflect this detailed flow:

1.  **Client (FMTimeAdjuster):**
    *   **File:** `Utilities\DynaMiX.ConfigDevice.FMTimeAdapter\...\FMTimeAdjuster.cs`
    *   **Action:** Sends HTTP POST to `/{api}/sendcommand/{orgId}/{assetId}/{typeId}`.
    *   **Error Trigger:** If the response is **NOT 200 OK**, it shows the popup: *"Not all commands were sent"*.

2.  **API Controller (FMTimeAdjusterModule):**
    *   **File:** `Services\FMTimeAdjuster\...\Controllers\FMTimeAdjusterModule.cs`
    *   **Action:** Calls `DaylightSavingAdjuster.AdjustDayLightSavings`.
    *   **Logic:** Catches ANY exception and throws it up the stack (returning 500/Error to client).

3.  **Service Logic (DaylightSavingAdjuster):**
    *   **File:** `Services\FMTimeAdjuster\...\FM Time Adjuster\DaylightSavingAdjuster.cs`
    *   **Logic:** Iterates through the requested Asset IDs.
    *   **Error Handling:** It wraps individual asset updates in a try-catch. If *any* asset fails, it sets `errors = true`.
    *   **Final Verification:** At the end of the loop, if `errors == true`, it throws generic exception: *"Errors found while sending commands"*. This triggers the Client UI error.

4.  **Backend Logic (DeviceIntegrationManager):**
    *   **File:** `Logic\...\MobileUnitLevel\DeviceIntegrationManager.cs`
    *   **Method:** `SendCommandToUpdateAssetTimezoneDeviation`
    *   **Validation Check:**
        *   It checks if the asset is "Time Zone Aware" (FM or Mesa).
        *   **CRITICAL CHECK:** It checks if `LogicalDevices.REMOTE_COMMAND` is available for that asset.
    *   **Failure Logging:**
        *   If `REMOTE_COMMAND` is missing: Logs `>   FAILURE: Remote message for asset {AssetId} not sent. Not all required logical devices connected.`
        *   If Exception during send: Logs `>   FAILURE: Remote message for asset {AssetId} not sent. {Exception}`

### 7.2 How to Debug "Not all commands were sent"
Because the UI error is generic, you **MUST** look at the logs on the server (**HSOMNIIS18**).

1.  Open `L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log`.
2.  Search **specifically** for this string:
    `FAILURE: Remote message for asset`
3.  You will find one of two things:
    *   **"Not all required logical devices connected"**: The unit config in the DB is missing the `REMOTE_COMMAND` logical device.
    *   **Exception Message**: An actual crash/error occurred while queuing the command.

---

## 8. Extended Dependency Chain (Investigated Feb 2026)

The investigation revealed that the command flow extends beyond the standard Backend logic into the **DeviceConfig** service layer.

### 8.1 Call Path & Repositories

**Authentication Flow:**
- **Tool** -> **DynaMiX.Api** (`/authentication/token`)
- **Repo:** `DynaMiX.Backend`
- **Result:** Returns `AuthToken` used for subsequent command calls.

**Command Flow:**
1.  **FMTimeAdjuster Utility** (`DynaMiX.Backend` repo)
2.  **FMTimeAdjuster.Api** (`DynaMiX.Backend` repo)
3.  **CommandManager** (`DynaMiX.Backend` repo) -> Uses `MobileUnitCommandsProxy`.
4.  **DynaMiX.DeviceConfig.Services.API** (`DynaMiX.DeviceConfig` repo) -> Receives request via `MobileUnitCommandsController`.
5.  **Dispatch** -> **Comms Client 4k/6k** (MiX Connect) & **DB** (FM Messages).

### 8.2 DeviceConfig Log Search Terms
If the `FMTimeAdjuster.Api` logs show success but the command doesn't arrive, check the **DeviceConfig API** logs (often centralized in Logz.io or Axiom under `DynaMiX.Services.API` or similar):

*   **Search String 1:** `"Received SendCommandToMobileUnit Request"`
*   **Search String 2:** `"UpdateAssetTimezoneDeviation"` (This is the friendly name for Command 45 used in log formatting).
*   **Search String 3:** `"groupId="` or `"mobileUnitId="` to filter for the specific asset.

**Example DeviceConfig Log:**
`Received SendCommandToMobileUnit Request (groupId=123, mobileUnitId=456, commandId=UpdateAssetTimezoneDeviation, ...)`
