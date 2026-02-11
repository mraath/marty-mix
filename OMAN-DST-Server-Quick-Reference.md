---
created: 2026-02-11T15:48
updated: 2026-02-11T17:14
---
# OMAN Daylight Savings Server Information

## Quick Reference

**Server:** HSOMNIIS18  
**API:** FMTimeAdjuster.Api  
**Gateway:** omntsg.mixtelematics.com  
### Other OMAN Servers
- HSOMNAPP03
- HSOMNAPP09
- HSOMNMSMQ03
- HSOMNIIS14
- HSOMNIIS15
- HSOMNIIS18, 19 (Dynamix API servers)

---

## Setup & Troubleshooting

### IIS Setup (HSOMNIIS18)

1. **Ensure FMTimeAdjuster.Api is running**
   - Should show green 404 when browsing (this is good for the API)
   - If errors appear, check the config file

2. **Common Issues:**
   - **Automapper Error:** Fix in the config file (see reference images in original notes)
   - After fixing config, API should load successfully with green 404

### Jumpbox Tool Setup

1. **Run the FMTimeAdapter app** on the jumpbox
2. **Check log files** for any errors (see Log Files section below)

---

## Log Files & Debugging

### OMAN Log File Location
**Primary Log:** `L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log`

### What to Search For
- **"DST Manager"** - UI tool logging (debug level only)
- Look for command execution confirmations
- Check for error messages or exceptions

### Centralized Logging
- **Logz.io** - Also contains DST-related logs
- Search term: "DST Manager"

### Troubleshooting Steps
1. **Check the API log** on HSOMNIIS18 at the location above
2. **Search for "DST Manager"** to see if commands went through
3. **Verify in SQL** - Check messages table for Command 45 entries
4. **Check Logz.io** for centralized logging across environments
5. **Review error messages** - Common issues include Automapper config errors

### Similar Setup (ALG Reference)
- ALG Server: HSATSDMXIIS01
- ALG Log: `L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api`

---

## What is Command 45?

Command 45 is the **Daylight Savings Time (DST) adjustment command** that updates timezone deviations on mobile units/assets.

### Command Format
- **FM Command:** `CommandID=45;Params=dword:{param1},dword:{param2},dword:{param3};`
- **Mesa Command:** `"CommandId":45,"Param1":{param1},"Param2":{param2},"Param3":{param3},`

### Parameters
- **Param1:** Before deviation: SiteOffset - OrgOffset (in seconds)
- **Param2:** After deviation: SiteOffset - OrgOffset (in seconds)
- **Param3:** Deviation date in Unix time (946688400 = no DST in Windows)

---

## API Endpoints

### Swagger
Format: `/sendcommand/{orgId}/{assetId}/{typeId}`

Examples:
- Org only: `https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/{orgId}/null/null`
- Asset only: `https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/null/{assetId}/null`

### Other Environments
- **INT:** http://api.deviceconfig.int.development.domain.local
- **DEV:** http://config.dev.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api
- **OMN:** http://api.deviceconfig.omn.production.local

---

## Related JIRA Tickets

- **SAAS-10447:** DST Tool in OMAN 18.17 (main ticket)
- **SR-19946:** ALG DTS fix (similar issue)
- **CONFIG-3387:** App or Report for Command 45
- **SR-8111:** FMTimeAdjuster Fix (20.11.PROD)

---

## Key Notes

1. **Last Run:** Tool was last successfully run in 2020
2. **Environment:** OMAN uses 18.17 version (older production environment)
3. **Gateway:** Use `omntsg.mixtelematics.com` (NOT atsats.mixtelematics.com)
4. **.NET Framework:** May need .NET Framework 4.5.2+ to run the tool
5. **Triggers:** Command 45 can be triggered by:
   - Moving an asset to another site
   - Manual tool execution
   - Automated DST service

---

## Verification

### Check if Commands Were Sent

**SQL Queries available in:** `c:\Projects\marty-mix\DST\Command 45.md`

Quick checks:
1. Check **messages** table in SQL
2. Try on **Swagger** endpoint
3. **Check the log file** for "DST Manager" (see Log Files section above)
4. Verify Org timezone offset and Site timezone offset
5. Use online Unix time converter for param3 validation

### Message Statuses
- 1 = New
- 4 = Sent
- 9 = Received
- 10 = Accepted
- 13 = Acknowledged
- 14 = Expired

---

## Reference Files

All detailed documentation located in:
- `c:\Projects\marty-mix\OMAN DST Command 45 Setup.md`
- `c:\Projects\marty-mix\Need Parent\SAAS-10447 DST Tool in OMAN 18.17.md`
- `c:\Projects\marty-mix\Need Parent\Oman.md`
- `c:\Projects\marty-mix\DST\Command 45.md` (comprehensive 743-line reference)

---

*Last Updated: 2026-02-11*  
*Based on work done: 2023-2024*
