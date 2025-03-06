---
status: closed
date: 2023-02-10
comment: 
priority: 8
---

# SR-14595 Over speeding - TIERED event using deleted location

Date: 2023-02-10 Time: 16:33
Parent:: [[Events]]
Friend:: [[2023-02-10]]
JIRA:SR-14595 Over speeding - TIERED event using deleted location
[SR-14595 "Over speeding - TIERED" event using deleted location - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14595)

## Read Description

- Unit Info if needed eg.
	- IDC: UK ?? AU
	- Database: Rio Tinto - Australia
	- Unit Type: ==FM==
- Description of issue from Jira
	- Issue: "Over speeding - TIERED" event ID 12003 is using deleted location ID 2084
	- 64bit Location ID: 8016547324729417928
	- Location was deleted in March 2022
	- sLocationName: MJ 30 (1 )_Active SpeedZone Event (Deleted - #2084)
	- dmxLocationId: 8016547324729417928

## Method

- Searched in VSCode... 
	- found: 
	- < event id="-4596269900191457380" type="4" legacyId="12003" returnActionType="1" returnParameterId="-8773503912069575223" description="Speeding - On-board tiered" />
- Searched in Config.XML
	- found:  the event in the config file
- Searched in DIS Viewer
	- found:  a lot of that @LocId (2084) for that Event Id (12003)
- Searched the DB

## SQL
```sql
-- The SQL used for this search
-- ASSET DB
SELECT top 5 * FROM RioTintoAustralia_2010.dynamix.MapLocations WHERE DmxLocationId = 8016547324729417928
SELECT top 5 bDeleted, * FROM RioTintoAustralia_2010.dbo.MapLocations WHERE  liLocationID = 2084
-- Audit... (nothing really)
SELECT TOP 5 * FROM RioTintoAustralia_2010.audit.MapLocationsGeo WHERE  liLocationID = 2084

-- DeviceConfiguration DB
SELECT top 5 Deleted, * FROM DeviceConfiguration.library.Locations WHERE DmxLocationId = 8016547324729417928
-- Audit...
SELECT TOP 5 * FROM DeviceConfiguration.audit.library_Locations_CT WHERE DmxLocationId = 8016547324729417928
```
## SQL Results
![[SR-14595 Over speeding - TIERED event using deleted location.png | 500]]
## See it happen

- Duplicate this on the environment mentioned using MFM
- Database Administration: DB_Name: RioTintoAustralia_2010
- Find unit based on Short Id: 
	- No need - it is in the config file
	- 

## Search md in Projects folder for keywords

- Might have handled this before
- Update Links in Obsidian

## Units

- Check config file: zip > bin
- Check Files: UDP / Dat > DIS Viewer

## Workflow

- See where the data stopped
- Update Graphs in Obsidian
- Decide if we are still the correct team
- Sanity check William (DP)

## Any Development done?

? ==Replace with Template Development note==

