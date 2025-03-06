---
status: closed
date: 2023-02-28
comment: 
priority: 8
---

# QA-5675 QA - Remora - Diagnostic Page Speed ,Odometer and asset site time not displaying

Date: 2023-02-28 Time: 15:46
Parent:: [[Remora]]
Friend:: [[Odometer]]
Friend:: [[Speed]]
Friend:: [[Asset Site Time]]
Friend:: [[2023-02-28]]
JIRA:QA-5675 QA - Remora - Diagnostic Page Speed ,Odometer and asset site time not displaying
[QA-5675 QA - Remora - Diagnostic Page Speed ,Odometer and asset site time not displaying - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-5675)

## Read Description

- Unit Info if needed eg.
		Database name: QA Salesforce 1
		orgId= 630719089906828293
		asset id= 911369537277108224&
		imei: 358014099114240
		Unit type: RemoraV2
		Device Template: Remora
		Name: UAT Regression Test Remora V2 (DO NOT EDIT)
		Reg No: 358014099114240
		id=911369537277108224
- Description of issue from Jira
	- XXXX

## Findings

### Initial Findings

Herewith the two sections mentioned in the issue.

The first has the following request url. It is clearly seen that the values displayed is as it was returned from the BE.
This shows that the FE is in order.
Next we will investigate the BE logic to see how we get the data.

Request URL: https://uat.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/630719089906828293/911369537277108224/diagnostics/Remora/asset/0

![[QA-5675 QA - Remora - Diagnostic Page Speed ,Odometer and asset site time not displaying.png]]

The second has the following request url. It is clearly seen that the values displayed is as it was returned from the BE.
This shows that the FE is in order.
Next we will investigate the BE logic to see how we get the data.

Request URL: https://uat.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/630719089906828293/911369537277108224/diagnostics/Remora/trip/0

![[QA-5675 QA - Remora - Diagnostic Page Speed ,Odometer and asset site time not displaying-1.png]]


### Further investigation in Code

There are two parts to the Diagnostics values referred to.
- Asset
- Trip

**Asset**: 
- The **Date Time** gets converted from the RawUnitDateTime.
- It reads this from the state stored procedure.
- If nothing is found it gets it from entity framework.

**Trip**:
- The **Speed**
	- Only when it is **IN trip** it will have data
	- It reads this from GPS_DATA cache in the Cache State.
- The **Odometer**
	- When it is **OUT of trip**
		- It will get this from LAST_TRIP_END_ODO cache in Cache state.
		- If it is not found in cache it will read the same from a state stored procedure.
	- When it is **IN trip**
		- It will read the UNIT_RAW_ODOMETER from cache in Cache state.
		- If it is not found in cache it will read the same from a state stored procedure.

### Data in the Database

- I can confirm that, for the properties questioned here, I could find no state values in the Database.
- I have not checked the cache

### Next steps to take

- After this I will reach out to the DP team to hear if this rings a bell with them.
- I will also double check with our team if something rings a bell with them.

## SQL

```sql
Use [DeviceConfiguration.DataProcessing];
SELECT
    [MobileUnitId],
    [DeviceId],
    [PropertyId],
    [Value],
    [DateUpdated],
    [MessageDate]
  FROM
    [state].[MobileUnitState] mus WITH (NOLOCK) 
 WHERE mus.[MobileUnitId] = 911369537277108224
    --AND mus.[DeviceId]     = 0 --ALL
    --AND mus.[PropertyId]   IN (5337640989681925810-4403033164446606692, -3166755750272960197 );
```

## See it happen

- Duplicate this on the environment mentioned using MFM

## If EVENT

- Search in VSCode in Projects folder
	- found: XXXX
- Searched in Config.XML for Event
	- found:  XXXX
	- Active / Passive
	- Conditions
- Searched in DIS Viewer for Event ID
	- found:  XXXX
- Searched the DB
	- found: XXXX

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

