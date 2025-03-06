---
status: parked
date: 2023-04-12
comment:
priority: 3
---

# CONFIG-3667 GPRS Communications tickbox was unselected

Date: 2023-04-12 Time: 07:50
Parent:: ==xxxx==
Friend:: [[2023-04-12]]
JIRA:CONFIG-3667 GPRS Communications tickbox was unselected
[CONFIG-3667 GPRS Communications tickbox was unselected - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-3667)

## Description

- GPRS Communications tickbox was unselected
- Manually or Automatically
- Dynamix > Manage > Config Admin > Configuration groups > Select your group (In this case Jaco’s Rovi II) > Select your asset on the right (J2 Rovi II INT #4 in this case) > Select GSM modem > scroll down to GPRS Communications

## Investigation

- device id="-791413463416547768" type="130" systemName="System.Logical.Comms.GPRS" legacyId="-210001" logical label="GPRS communications" uisortorder="13000"

## SQL

```sql
USE DeviceCOnfiguration;

SELECT TOP 10 * FROM [template].[ConfigurationGroups]
WHERE Name like '%Jaco%'

--Jaco’s Rovi II is: 
/*
ConfigurationGroupKey	ConfigurationGroupId	LibraryKey	Name			MobileDeviceTemplateKey	EventTemplateKey
17085					-8224419174944708073	34			Jaco's Rovi II	22595					19255
*/

SELECT TOP 10 * FROM library.Libraries
WHERE LibraryKey = 34

-- GroupId = -1670888073009243017

-- ORG INFO:
-----------------------------------------
--Get Organisation based on long group id
-----------------------------------------
DECLARE @GroupId BIGINT = -1670888073009243017;
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId

DECLARE @lorgID INT = (SELECT OrganisationId
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId)

SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID

-- ORG NAME: GHOS US Testing

-- Asset: J2 Rovi II INT #4
/*
https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=1306728765080326144
https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/mobile-device?assetId=1306728765080326144
https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/mobile-device/edit?assetId=1306728765080326144&lineId=5677155256367341334


Edit peripheral device: S2 - (Landile Test Mobile template)
S2 - GSM modem (Extended Device)
Features and settings
GPRS Communications
*/

-- Get Asset / Mobile Unit info
-- assetId=1306728765080326144
SELECT top 10 * FROM mobileunit.AssetMobileUnits WHERE AssetId = 1306728765080326144
--MobileUnitKey = 90532

/*
WHERE DOES THIS COME IN?:
device id="-791413463416547768" type="130" systemName="System.Logical.Comms.GPRS" legacyId="-210001" logical label="GPRS communications" uisortorder="13000"
-- NONE OF THESE :)
SELECT Top 10 * FROM [mobileunit].[OverridenDeviceParameters] WHERE OverridenDeviceParameterId = -791413463416547768
SELECT Top 10 * FROM [mobileunit].[OverridenDeviceProperties]
SELECT Top 10 * FROM [mobileunit].[OverridenEventActions]
SELECT Top 10 * FROM [mobileunit].[OverridenEventConditionThresholds]
SELECT Top 10 * FROM [mobileunit].[OverridenEvents]
SELECT Top 10 * FROM [mobileunit].[OverridenPeripheralDevices]
*/

-- GEt Template Device Key
Select TOP 10 * from definition.Devices WHERE DeviceId = -791413463416547768
-- DeviceKey: 97

-- Get original template
SELECT TOP 10 * FROM [template].[MobileDeviceTemplates]
WHERE MobileDeviceTemplateKey = 22595 -- from: [template].[ConfigurationGroups]

-- TEMPLATE VALUE for GPRS Communications
Select TOP 10 * from [template].[Devices] 
WHERE DeviceKey = 97
AND LibraryKey = 34
AND MobileDeviceTemplateKey = 22595

-- Mobile Unit's overridden values
SELECT Top 10 * FROM [mobileunit].[OverridenDevices]
WHERE MobileUnitKey = 90532
--Nothing anymore, because he changed it back to default

--Now check the audit table for this table
SELECT * FROM [audit].[mobileunit_OverridenDevices_CT]
WHERE MobileUnitKey = 90532
AND TemplateDeviceKey = 3128325 -- from: [template].[Devices]
-- AND templateDeviceKey = 97 (NOPE, not the same, get template... deviceKey)

SELECT * FROM [reports].[vwAudit_mobileunit_OverridenDevices_CT]
WHERE MobileUnitKey = 90532
AND TemplateDeviceKey = 3128325


SELECT * FROM template.devices
WHERE TemplateDeviceKey IN (3128356,3128318,3128370,3128352,3128381,3128368,3128381,3128370,3128368,3128356,3128352,3128318)


------------- NOTHING BELOW IS NEEDED
/*
Select TOP 10 * FROM [template].[ConfigurationGroups] WHERE LibraryKey = 34
Select TOP 10 * from [mobileunit].[MobileUnits]
Select TOP 10 * from [template].[MobileDeviceTemplates]
Select TOP 10 * from [template].[PeripheralDevices]

SELECT Top 10 * FROM [mobileunit].[OverridenDeviceParameters] WHERE OverridenDeviceParameterId = -791413463416547768
SELECT Top 10 * FROM [mobileunit].[OverridenDeviceProperties]
SELECT Top 10 * FROM [mobileunit].[OverridenEventActions]
SELECT Top 10 * FROM [mobileunit].[OverridenEventConditionThresholds]
SELECT Top 10 * FROM [mobileunit].[OverridenEvents]
SELECT Top 10 * FROM [mobileunit].[OverridenPeripheralDevices]
*/











SELECT * FROM
[audit].[mobileunit_OverridenDevices_CT]
WHERE MobileUnitKey = 90532
--Where TemplateDeviceKey = 3128325

SELECT * FROM template.devices
WHERE TemplateDeviceKey IN 
(3128356,3128318,3128370,3128352,3128381,3128368)

SELECT * FROM definition.devices
WHERE DeviceKey IN (10,113,190,209,60,132)


```

```sql
Select top 20 * from DeviceConfiguration.[reports].vwAudit_mobileunit_MobileUnitProperties_CT where (mobileunitkey = 408600 and propertykey = 370) or value = '300534063100980' order by ChangeDate


```

## Jira comment

I have not been able to find this specific device being overwritten.

Currently I could only find these overwritten for this specific device by Jaco De Clerck on this time stamp: 2023-04-06 06:29:41 +00:00
System.Logical.Roaming.AllowGPRSUpload
System.Logical.Roaming.AllowGPRSMessages
System.Logical.Roaming.AllowGPRSConnect
System.Logical.Roaming.AllowGPRSAutoTripDownload
System.Logical.Roaming.AllowGPRSDownload
System.Logical.Roaming.AllowGPRSCommands

I will continue my investigation.
