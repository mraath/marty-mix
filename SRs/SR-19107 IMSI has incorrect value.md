---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-04T16:34
---

# SR-19107 IMSI has incorrect value

Date: 2024-09-10 Time: 15:47
Parent:: ==xxxx==
Friend:: [[2024-09-10]]
JIRA:SR-19107 IMSI has incorrect value
[SR-19107 Discrepancies in IMSI/IMEI Reporting Post 3G to 4G Upgrade Comparing Mix fleet manager to mobile device admin - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-19107)


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
## BRANCH

- [x] Work off of: 24.13 ✅ 2025-03-04

## Shorter Description

Commissioning Server > 3rd party tool
ZA has the Mobile Device Admin page
WHEN from FM 37 to MiX 4000 (3G to 4G upgrade)

EG
Chevron Barrow Island dataset
different IMSI number in Fleet Manager vs. the Commissioning Server
SIM management portal > will have the old device it was registered on before moving to the new Mobile unit

example IMEI: 863427061358397
Mobile device admin group: MiX MEA - Production - AU - M2M

![[SR-19107 IMSI has incorrect value IMSI diff.png]]

## Findings

- The IMEI seen in the SIM management portal could potentially look like that, from what I understand this will reflect the device on which it was registered, not the actual device we are looking into.
- Taking the above into consideration the IMEI is fine.
- The IMSI is the next thing to consider.
	- The modal will most likely show the latest value
	- IT might be a time issue by which the Assets list doesn't yet reflect the latest version
- [x] I will get the different values from the database ✅ 2024-09-11
- [x] I will then give feedback ✅ 2024-09-11

[[Discrepancy between Asset List Page and Diagnostics values]]

## Check the values in the database

```sql
-- SQL07LST\INDIA
DECLARE @MobileUnitId BIGINT = 2030626110269687202;
DECLARE @AssetId BIGINT = (Select AssetId FROM [DeviceConfiguration].[mobileunit].[AssetMobileUnits] WHERE AssetMobileUnitId = @MobileUnitId)
DECLARE @MobileUnitKey INT = (Select MobileUnitKey FROM [DeviceConfiguration].[mobileunit].[MobileUnits] WHERE MobileUnitId = @MobileUnitId)
DECLARE @UNIT_IMSI_KEY INT = (SELECT [PropertyKey]  FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK)   WHERE dp.PropertyId  = 3870542574174346252);

SELECT * FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitState]
WHERE PropertyId = 6851923534434202573
AND MobileUnitId = @MobileUnitId

SELECT * FROM [DeviceConfiguration].[mobileunit].[MobileUnitProperties] mup WITH (NOLOCK)
where mup.[PropertyKey] = @UNIT_IMSI_KEY
AND mup.MobileUnitKey = @MobileUnitKey

-- Audit had no results - guess it went to warehousing
SELECT * FROM [DeviceConfiguration].[audit].[mobileunit_AssetProperties_CT] amup WITH (NOLOCK)
where amup.[PropertyKey] = @UNIT_IMSI_KEY
AND amup.AssetId = @AssetId
```

![[SR-19107 IMSI has incorrect value Value diff.png]]


## Chat to DP

Hey there. I am looking into: SR-19107
It's the typical **Asset Page** list value <> **Diagnostics** window.
This time it is for the **IMSI**.
They come from these two places:
- [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] (PropertyId = 6851923534434202573)
- [DeviceConfiguration].[mobileunit].[MobileUnitProperties] (3870542574174346252)
Off of the top of your heads, do you know why they would be different values?
Who should be setting them?
(Most likely we have a finger in the pie, I just first wanted to double check with you)

## Shashi's reply

Morning, we **set** the **state** value **when** we get a:
- ColdBoot or 
- VersionChanged message
I'm not sure why we need to though , because we never use the state value anywhere that I can see
Those two UDP messages seem to contain the IMSI 
Or some kind of value for IMSI 

Shashi assumes the MUP value will be correct... I will ask SR team

## Dante's reply

He said the bottom one is the correct one... which is the diagnostics one.... which is the DP State... not what Shashi thought...
I will investigate his Audit quickly

FM IMSI audit. 
(which means if it was replaced by a MESA device)
Conclusion by Dante: the mobile device admin is currently correct.

![[SR-19107 IMSI has incorrect value IMSI Audit.png]]

## Zonika Reply

- ja dit kom in deur 'n asset sproc wat ons sproc roep as ek reg is
- Nie Fleet nie
- daardie sproc dink ek word uit **comms** uit geroep

## Current Step

- [x] I will ask SR team to let me know what the correct value is... then work it back from there ✅ 2024-10-02
- [x] Awaiting Dante feedback ✅ 2024-10-08
- [x] Zonika to potentially give feedback ✅ 2024-10-08
- [x] Asking Dante again to double check the correct value ✅ 2024-10-09
- Last week [[2025-02-11]] I drew this from all my notes:
![[WhatsApp Image 2025-02-18 at 11.21.23_6010a1ba.jpg]]
- From the above I can see...
	- The Asset List IMSI is incorrect. Stored under MobileUnit.Properties
		- [ ] Who sets these?
		- AvlParameter
		- IMSI received for AVL message from IMEI
			- [IMSI - Search Code - Home](https://dev.azure.com/MiXTelematics/_search?action=contents&text=IMSI&type=code&lp=custom-Collection&filters=ProjectFilters%7BCommon%7DRepositoryFilters%7BDatabase%7D&pageSize=25&result=DefaultCollection/Common/Database/GBIntegration//DynaMiX/Schemas/DynaMiX_SatelliteBilling/Tables/Tap2MtcRecords.sql)
		- DeleteFMChangeMobileUnitProperties
		- [ ] [dbo].[sprGetUnitIdentifiers]
			- 
		- [dbo].[sprVehicle_SaveUnitInfo], [dbo].[sprVehicleDownloadUpdateConfigDateVersion], [dbo].[cmdActiveVehicles_ResetLastUpdateTime], [dbo].[sprMixDisplay_SaveVersionInfo] ~~(A)~~, CVehicle::UpdateDeviceProperty (B)
			- [dbo].[cmdVehicleDevices_UpdateProperties] ([cmdVehicleDevices_UpdateProperties - Search Code - Home](https://dev.azure.com/MiXTelematics/_search?action=contents&text=cmdVehicleDevices_UpdateProperties&type=code&lp=custom-Collection&filters=&pageSize=25&result=DefaultCollection/Common/Database/GBIntegration//FMAsset/Asset.sqlproj))
				- [mobileunit].[DeviceProperty_UpdateFromLegacy]
			- [ ] (B) > Ask this team to check??
		- check: TABLE [dbo].[UnitIdentifiers_CT]
		- 

- [ ] Look at the Audit
- [ ] Figure out who sets MUP, when, why wasn't it set in this instance
- [ ] speak to Paul

- UnitIMSI
- https://dev.azure.com/MiXTelematics/Engineering/_git/MESA?path=/tools/FmCommsTest/FmSvrCpp/FmSvrCpp/Vehicle.cpp&_a=contents&version=GBDevelop
	- [dbo].[cmdVehicleDevices_UpdateProperties]
		- [mobileunit].[DeviceProperty_UpdateFromLegacy]


> Where does Commissioning come in?

## Current summary 2025-03-03

### Asset List - <mark class="hltr-red">Incorrect</mark>

I have confirmed that the IMSI is incorrect on the Asset List side. 
I now try to understand what sets, or is supposed to set, the IMSI. 

The best flow of data I could find is:
- ...MiXTelematics/**Engineering**/...git/MESA?path=/tools/FmCommsTest/FmSvrCpp/FmSvrCpp/Vehicle.cpp
	- UpdateDeviceProperty (Ettienne Steenkamp)
		- [dbo].[cmdVehicleDevices_UpdateProperties]
			- [mobileunit].[DeviceProperty_UpdateFromLegacy]

- [x] I will speak to the Engineering team (Ettienne Steenkamp) to ask if they can make sense of it. ✅ 2025-03-04

It is also called from here, however, to delete data (so this is non-relevant):
- DeleteFMChangeMobileUnitProperties

### Diagnostics - <mark class="hltr-green">Correct</mark>

So just to backtrack, the other place where the IMSI is saved is in the state tables.
These values are correct.
After speaking to the DP team, I understand that it gets set after:
- Coldboot
- VersionChanged

## Etttienne

FM > 4K
UDP logs
Reset message - elke 24 uur status
Commissioning vir Alpha > watter APN > nie UDP
AU....
Brazil > sim > eie imsi verander

- [ ] KYK UDP , elke 24 uur ook

