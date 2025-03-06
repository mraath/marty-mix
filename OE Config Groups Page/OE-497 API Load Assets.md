---
created: 2023-03-27T07:35
updated: 2025-01-30T11:48
status: busy
comment: 
priority: 1
---

# OE-497 API Load Assets

Date: 2024-04-18 Time: 07:31
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-04-18]]
JIRA:OE-497 API Load Assets
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-497)

This reminded me of the multiline thing I worked on: [[DIE-492 Config File Connected Lines]]
- Esp this SQL: [[DIE-492 MobileUnit_GetAllMobileUnitLines 1.sql]] which I will re-use and simplify to get overwritten values
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

## Descriptions

- This will be a call on the new Frangular API to load a list of assets for the selected config groups.
- In the UI where this triggers please note we should possibly only call this eg. 3 seconds after the last select was made, the API will be hammered potentially.
    - [x] The current thought it to only add the newly selected Config Group’s assets to the assets list, so only load the last clicked config group’s asset. ✅ 2024-05-08
- Please also see the NEW UI design for the columns needed.
- Currently, these are the columns:

## Columns

- [x] Alerts icon - display alert count for each asset - [[OE-515 Alerts Column Assets Panel]] ✅ 2024-05-08
- [x] Flagged assets icon ✅ 2024-05-08
- [x] Asset ID ✅ 2024-05-08
- [x] Asset description - clickable link to navigate to asset level config ✅ 2024-05-08
- [x] Registration - Asset registration ✅ 2024-05-08
- [x] Site ✅ 2024-05-08
- [x] Fleet number ✅ 2024-05-08
- [x] Last position - if possible the last position. Only need to be updated when the page is refreshed? ✅ 2024-05-08
	- last position
	- FE: LastAvl
		- (assetDetails.AssetConfigDetails.LastAvl)
		- v.LastAVL
		- 
	- latestAVLInfo.dateOfRecording
	- assetDetails.AssetConfigDetails.LastAvl (ToHistoricalTimeZone)
	- LOTS of different sources in GetLatestPositionsForAssetsByAssetIds
		- BASE_BEACON_FUNCTIONALITY = -2156593089855370790L
		- mobileunit].[MobileUnit_GetAllAssetsThatHaveDeviceEnabled
		- position.TimeOfReadingposition.TimeOfReading
		- p.Timestamp
		- ConvertUtcToTargetTimeZone
		- position.TimeOfReading
		- 
- [x] IMEI ✅ 2024-05-08
	- ..... [dynamix].[Assets_GetExtendedSummaries]
	- 
- [x] Serial number ✅ 2024-05-08
- [x] Mobile device - Mobile device associated with config group ✅ 2024-05-08
- [x] Config compile status ✅ 2024-05-08
- [x] Config compile status time ???????????? ✅ 2024-05-08
	- [x] TODO: MR: Don't think we have this.... ✅ 2024-05-08
- [x] Configuration status ✅ 2024-05-08
- [x] Configuration status time ✅ 2024-05-08
- [x] Comms log (messageStatusDate formatted OR LastLogEntry) ✅ 2024-05-08
- [x] Configuration group name ✅ 2024-05-08
- [x] Mobile device template - Mobile device template linked to config group - green hyperlink that opens the template ✅ 2024-05-08
- [x] Event template - Event template linked to config group - green hyperlink that opens the template ✅ 2024-05-08
- [x] Location template - Location template linked to config group - green hyperlink that opens the template ✅ 2024-05-08
- [x] FW version - Preferred FW version configured on Asset level -Mobile device connected to the Mobile device template ✅ 2024-05-08
	- [x] Check values ✅ 2024-05-08
	- [x] Also - where does multi stuff values come from - more than one selected on Template? ✅ 2024-05-08
- [x] CAN script - CAN script connected to Asset level Mobile device template (if 2 connected then display names below each other) - a green hyperlink that opens Asset Level mobile device template CAN script ✅ 2024-05-08
- [x] Speed - Speed source connected to Asset level Mobile device template such as Speed sender, J1708 CAN Speed, GPS velocity as speed ✅ 2024-05-08
- [x] RPM - RPM source connected to Asset level mobile device template such as RPM signal or J1708 CAN RPM ✅ 2024-05-08
- [x] Fuel - Fuel source connected to Asset level Mobile device template such as EDM fuel flow meter or J1708 CAN Fuel ✅ 2024-05-08
- [x] SP - shows whether Streamax is connected or not. Configured on Asset level Mobile device template ✅ 2024-05-08
- [x] MiX Vision serial number - serial number (entered on Mobile device settings page when commissioning Streamax) for the Streamax device connected - if possible (NEW) ✅ 2024-05-08
- [x] HOS - Shows whether DTCO or BYOD/ELD is in use. Configured on the Asset level Mobile device template ✅ 2024-05-08

## IN CODE

- [x] Dates: ToHistoricalTimeZone used in code??? -- 1187: C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs ✅ 2024-10-28
- [x] FW Version - test values ✅ 2024-10-28
- [x] FW Version multiselect??? ✅ 2024-10-28
- [x] Comms log (messageStatusDate formatted OR LastLogEntry) ✅ 2024-05-08
	- [x] lastLogEntry ✅ 2024-10-28
	- BE: schedule.LastLogEntry
```txt
var message = latestMesaMessagesDict[id];
ZonedDateTime mobileDateTime = new ZonedDateTime(message.MessageStatusDateUtc.DateTime, TimeZoneInfo.Utc);
ZonedDateTime zdt = mobileDateTime.ToHistoricalTimeZone(id, timezoneResource, sourceDataTimezone);
var dtConverter = DateFormatConverter.Instance;
var dateTimeInfo = dtConverter.GetRegionalFormatForDate(user.LocaleId, user.LanguageCode);
var shortDate = zdt.DateTime.ToString(dateTimeInfo.ShortDatePattern);
var shortTime = zdt.DateTime.ToString(dateTimeInfo.ShortTimePattern);
var shortDateTime = $"{shortDate} {shortTime} ({zdt.TimeZoneShortName})";
var cellVal = shortDateTime; //: {message.MessageStatus.GetDescription()}";
```

- [x] Last Position - moved into [[OE-519 API Populate Lastposition for Asset List]] ✅ 2024-05-08
- [x] --TODO: MR: Find out if Overridden FW could have more than one version ✅ 2024-10-28
- [x] Config compile status time ???????????? DONT HAVE THIS ✅ 2024-10-28

## REPOS

- [x] DB - Have to move to API db else dont have access to DataProcessing ✅ 2024-05-02
	- [x] [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups] ✅ 2024-05-02
	- Config/MR/OE-497 Asset List Panel.24.8.INT.ORI
- [x] Common ✅ 2024-05-08
	- [x] OE-497: TMP client create ✅ 2024-05-06
	- [x] [INT PR](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/102457) ✅ 2024-05-08
	- [x] [DEV PR](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/102459) ✅ 2024-05-08
- [x] API ✅ 2024-10-28
	- [x] DB ✅ 2024-10-28
		- [state].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]
		- [x] [Dev PR](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/102119) ✅ 2024-05-08
		- [x] INT PR ✅ 2024-10-28
	- [x] API ✅ 2024-10-28
		- GetConfigurationGroupsMultiselectAssetsList
			- "configuration-groups-multiselect/groupId/{groupId}/assets-list"
		- [x] [DEV PR](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/102461) ✅ 2024-10-28
			- [x] Bring in Common DEV ✅ 2024-10-28
		- [x] INT PR ✅ 2024-10-28
			- [x] Bring in Common DEV ✅ 2024-10-28
- [x] Client ✅ 2024-10-28
	- GetConfigurationGroupsMultiselectAssetsList
	- [x] OE-497 ✅ 2024-05-07
	- [x] [DEV PR](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/102460) ✅ 2024-05-08
	- [x] INT PR ✅ 2024-10-28
- [x] FR API ✅ 2024-10-28
	- [x] DEV ✅ 2024-10-28
		- [x] Upgrade Common ✅ 2024-10-28
		- [x] Upgrade Internal Client ✅ 2024-10-28
		- [x] PR ✅ 2024-10-28
	- [x] INT ✅ 2024-10-28
		- Have something done, need to upgrade below when INT is ready
		- [x] Upgrade Common ✅ 2024-10-28
		- [x] Upgrade Internal Client ✅ 2024-10-28
		- [x] PR ✅ 2024-10-28

## Swagger test


-4493495256567590976
[-4366193155933191679,7270785342402232596]

## Dates currently looks like this

- "CommsLog": "2024-01-31T09:02:14+08:00 (AWST)"
- [ ] It needs to become short date time

## Ask PO

- [ ] -- TODO: MR: Should we include: [DynaMiX].[DynaMiX_Satellite].[AssetIridiumHistory]
- [x]  ✅ 2024-10-28
## SQL

- 

## Mapping other stories' needs

![[OE-497 API Load Assets Mapping stories to Stored Proc.png|500]]


## Brainstorm

- CG > be
	- https://uk.mixtelematics.com/DynaMiX.API/config-admin/organisations/2035877590475814821/config_groups/0/assetlist
	- GET_CONFIG_GROUP_ASSETS
	- GetConfigGroupAssetList
	- 
## Testing

- [ ] Ensure for all columns above , the asset overwritten value (if available) is shown

## Overwritten Tables

LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK) ON events.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = mu.MobileUnitKey
--Overwritten Device Info
LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK) ON devices.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK) ON properties.MobileUnitKey = mu.MobileUnitKey AND properties.PersistOnReset = 0
LEFT JOIN [mobileunit].[OverridenPeripheralDevices] peripherals WITH (NOLOCK) ON peripherals.MobileUnitKey = mu.MobileUnitKey





