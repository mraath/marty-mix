---
status: parked
date: 2023-02-14
comment: SRE?
priority: 6
created: 2023-02-14T03:21
updated: 2024-11-29T08:22
---

# SR-14616 Black flag on asset not showing what is black flagged

Date: 2023-02-14 Time: 09:21
Parent:: [[Black Flag]]
Friend:: [[2023-02-14]]
JIRA:SR-14616 Black flag on asset not showing what is black flagged
[SR-14616 Black flag on asset not showing what is black flagged - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14616)

## Findings

- There are two calls to the Backend for this part of black flags
- The first to see if there are any overwritten values
- This is done when building up the list of Assets
- The Second call is done when you click on the Blackflag icon
- This then build up the rows for the modal (which in this case is blank)
- [x] I will have a look to see why the blackflag is shown, but this modal is blank
- It could most likely be because they look are built up differently
- The blackflag is shown because there are rows in the OverridenEventActions Table.
- The modal converts the OverridenEventActions table as such:
	- It breaks it up in 
		- IsEnabled (Will be lost of no ActionSettings changes)
		- Delay (will be lost if no ActionSettings changes)
		- ActionSettings
			- 

## SQL
``` SQL
-- Initial Black Flag findings
USE DeviceConfiguration;
DECLARE @mobileUnitKey INT = (SELECT MobileUnitKey FROM mobileunit.MobileUnits mu WHERE mu.MobileUnitId = 1326202764362162176);
--SELECT @mobileUnitKey;

/*
SELECT * FROM mobileunit.OverridenEvents WHERE MobileUnitKey = @mobileUnitKey
SELECT * FROM mobileunit.OverridenEventActions WHERE MobileUnitKey = @mobileUnitKey
SELECT * FROM mobileunit.OverridenEventConditionThresholds WHERE MobileUnitKey = @mobileUnitKey
SELECT * FROM mobileunit.OverridenDevices WHERE MobileUnitKey = @mobileUnitKey
SELECT * FROM mobileunit.OverridenDeviceParameters WHERE MobileUnitKey = @mobileUnitKey
SELECT * FROM mobileunit.OverridenCanParameters WHERE MobileUnitKey = @mobileUnitKey
SELECT * FROM mobileunit.OverridenDeviceProperties WHERE MobileUnitKey = @mobileUnitKey
SELECT * FROM mobileunit.OverridenPeripheralDevices WHERE MobileUnitKey = @mobileUnitKey
*/
-- EF attempt
WITH MobileUnitData AS (
    SELECT mu.MobileUnitKey, mu.MobileUnitId
    FROM mobileunit.MobileUnits mu WITH (NOLOCK)
), OverridenEventActionData AS (
    SELECT oea.MobileUnitKey, oea.OverridenEventActionId, oea.TemplateEventActionKey, oea.IsEnabled, oea.Delay, oea.ActionSettings, oea.DateUpdated, oea.UserName
    FROM mobileunit.OverridenEventActions oea WITH (NOLOCK)
), TemplateEventActionData AS (
    SELECT tea.TemplateEventActionId, tea.EventTemplateKey, tea.EventKey, tea.EventActionType, tea.IsEnabled, tea.Delay, tea.ActionSettings,tea.TemplateEventActionKey
    FROM Template.EventActions tea WITH (NOLOCK)
), TemplateEventData AS (
    SELECT te.EventTemplateKey, te.EventKey
    FROM Template.Events te WITH (NOLOCK)
), EventTemplateData AS (
    SELECT et.EventTemplateKey, et.LibraryKey
    FROM Template.EventTemplates et WITH (NOLOCK)
), DefinitionEventData AS (
    SELECT de.EventKey, de.EventId, de.ReturnParameterKey
    FROM definition.Events de WITH (NOLOCK)
), LibraryEventData AS (
    SELECT le.LibraryKey, le.EventKey, le.Description
    FROM Library.Events le WITH (NOLOCK)
), LibraryParameterData AS (
    SELECT lp.LibraryKey, lp.ParameterKey
    FROM Library.Parameters lp WITH (NOLOCK)
)
SELECT 
oea.OverridenEventActionId AS Id, 
mu.MobileUnitId AS MobileUnitId, 
tea.TemplateEventActionId AS TemplateEventActionId, 
de.EventId AS DefinitionEventId, 
tea.EventActionType AS EventActionType, 
le.Description AS Description, 
oea.IsEnabled AS IsEnabled, 
oea.Delay AS Delay, 
oea.ActionSettings AS ActionSettings, 
tea.IsEnabled AS TemplateIsEnabled, 
tea.Delay AS TemplateDelay, 
tea.ActionSettings AS TemplateActionSettings, 
oea.DateUpdated AS DateUpdated, 
oea.UserName AS UserName
FROM MobileUnitData mu
INNER JOIN OverridenEventActionData oea ON mu.MobileUnitKey = oea.MobileUnitKey
INNER JOIN TemplateEventActionData tea ON oea.TemplateEventActionKey = tea.TemplateEventActionKey
INNER JOIN TemplateEventData te ON tea.EventTemplateKey = te.EventTemplateKey AND tea.EventKey = te.EventKey
INNER JOIN EventTemplateData et ON te.EventTemplateKey = et.EventTemplateKey
INNER JOIN DefinitionEventData de ON te.EventKey = de.EventKey
INNER JOIN LibraryEventData le ON et.LibraryKey = le.LibraryKey AND te.EventKey = le.EventKey
LEFT OUTER JOIN LibraryParameterData lp ON et.LibraryKey = lp.LibraryKey AND de.ReturnParameterKey = lp.ParameterKey
WHERE oea.MobileUnitKey = @mobileUnitKey;
```


## Read Description

- Unit Info if needed eg.
	- IDC: ==UK==
	- Database: FMC
	- Vehicle ID: 1032
	- Asset ID: 1326202764362162176
- Description of issue from Jira
	- Issue: Black flag on asset not showing what is black flagged
![[SR-14616 Black flag on asset not showing what is black flagged.png | 500]]

## See it happen

- Duplicate this on the environment mentioned using MFM
- UI calls this URI
	- Request URL: https://uk.mixtelematics.com/DynaMiX.API/config-admin/organisations/8594184883209124020/config_groups/6177982511386081048/assetlist
	- Calls this BE
		- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs
		- Calls muProxy.GetConfigChangedFlagForMobileUnits
			- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API.Client\Proxies\MobileUnitLevel\MobileUnitProxy.cs
				- groupId/{groupId}/mobile-units-changed-flag
					- Repo > GetConfigChangedFlagForMobileUnits
						- GetMobileUnitsWithOverwrittenEventsIds
							- [x] [mobileunit].[MobileUNit_GetMobileUnitsWithOverwrittenEventsIds]
								- mobileunit.OverridenEvents
								- mobileunit.OverridenEventActions
								- mobileunit.OverridenEventConditionThresholds
						- GetMobileUnitsWithOverwrittenDevicesIds
							- [x] [mobileunit].[MobileUnit_GetMobileUnitsWithOverwrittenDevicesIds]
								- mobileunit.OverridenDevices
								- mobileunit.OverridenDeviceParameters
								- mobileunit.OverridenCanParameters
								- mobileunit.OverridenDeviceProperties
								- mobileunit.OverridenPeripheralDevices
- The UI returns this
	- "IsConfigurationDifferentToConfigGroup": true,
	- "AreConfigurationEventsDifferentToConfigGroup": true,
	- "IsConfigurationDeviceDifferentToConfigGroup": false,
		- showGroupDiffInfo
		- Calls BE: pageData.configDiff
			- Request URL: https://uk.mixtelematics.com/DynaMiX.API/config-admin/organisations/8594184883209124020/config-difference/1326202764362162176
			- result from BE: data["groupDifferences"]
			- /organisations/{orgId}/config-difference/{assetId}
				- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs
					- mobileUnitManager.GetConfigurationGroupDifferences
						- muProxy.GetOverriddenInformationForMobileUnit
							- mobile-units/{mobileUnitId}/get-overridden-info
								- _deviceConfigRepo.GetMobileUnitAggregate
									- mu.OverriddenDevices
									- mu.OverriddenPeripheralDevices
									- mu.OverriddenDeviceProperties
									- OverriddenDeviceParameters
									- OverriddenEvents
									- OverriddenEventConditionThresholds
									- OverriddenEventActions
									- OverriddenCanParameters
									- 
					- convert to carrier?
- [ ] When does the black flag show? Also indicate this in excalidraw

```JSON
{
      "FirmwareVersion": "4.12.12",
      "VinMatch": false,
      "AssetId": "1326202764362162176",
      "VehicleId": 1032,
      "IsConfigurationDifferentToConfigGroup": true,
      "AreConfigurationEventsDifferentToConfigGroup": true,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": true,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "Toyota Prado - 5484VKD",
        "Disabled": false
      },
      "Registration": "5484VKD",
      "FleetNumber": null,
      "ConfigGroupId": "6177982511386081048",
      "ConfigGroupDescription": "4K.2.02. MIX 4000 - LV -CAN: T.PRADO.2017_v1.0.0.9, [PB-I1], [CAN SB], [Iridium], [120 km/h]]",
      "ConfigurationStatus": "Configuration accepted",
      "ConfigurationStatusEnum": 11,
      "ConfigurationStatusTime": {
        "DateTime": "2023-02-12T13:03:22",
        "IsoDateTimeString": "2023-02-12T13:03:22",
        "TimeZoneName": "Arab Standard Time",
        "TimeZoneShortCode": "AST"
      },
      "ConfigurationGenerationNotes": null,
      "ConfigurationGenerationNotesShort": {
        "Title": "",
        "Disabled": true
      },
      "ConfigurationGenerationWarning": null,
      "ConfigurationGenerationWarningShort": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceType": "MiX4000",
      "Imei": "862096045422164",
      "SerialNumber": "57002861",
      "Actions": [
        "Reset",
        "Edit",
        "UploadFirmware",
        "DownloadConfigFile",
        "DownloadPendingConfigFile",
        "DownloadMobileunitConfigFile"
      ],
      "MobileDeviceTemplate": {
        "Title": "4K.2.02. MIX 4000 - CAN : CAN.TOYOTA.PRADO.JTEBU9FJ_HK.2017.v1.0.0.9, (PB-I1), [Iridium]",
        "Disabled": false
      },
      "EventTemplate": {
        "Title": "2.01. LV - CAN (CAN SB), PB, [120 km/h]",
        "Disabled": false
      },
      "LocationTemplate": {
        "Title": "LV_Speed_Limits",
        "Disabled": false
      },
      "MobileDeviceTemplateId": "-4562074561466797006",
      "EventTemplateId": "3377112547304786328",
      "LocationTemplateId": "354188990786431944",
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "2023/02/12 13:03 (AST)",
        "Disabled": false
      },
      "Site": "Surface",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
```


## Search md in Projects folder for keywords

- Might have handled this before
- Update Links in Obsidian


## Workflow

- See where the data stopped
- Update Graphs in Obsidian
- Decide if we are still the correct team
- Sanity check William (DP)

## Any Development done?

? ==Replace with Template Development note==

## SQL Done with Cornel

```sql
USE Deviceconfiguration;
SELECT * FROM mobileUnit.AssetMobileUnits WHERE Assetid = 5462472039999562707; -- << CHANGE TO: 1377470486370181120;
SELECT * FROM mobileUnit.MobileUnits WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenCanParameters WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenDeviceParameters WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenDeviceProperties WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenDevices WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenPeripheralDevices WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenEventActions WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenEventConditionThresholds WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenEventId WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenEvents WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.OverridenPeripheralDevices WHERE MobileUnitKey = 40271;
SELECT * FROM mobileunit.overridenEvent WHERE MobileUnitKey = 40271;
```