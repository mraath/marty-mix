---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-17T12:56
---

# OE-517 Unallocated Assets

Date: 2024-07-09 Time: 14:56
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-07-09]]
JIRA:OE-517 Unallocated Assets
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-517)

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

## Image Summary

FROM @GeneralConfigGroupInfo g
    INNER JOIN [DeviceConfiguration].[mobileunit].[MobileUnits] mu WITH (NOLOCK)
    ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    INNER JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] mus WITH (NOLOCK)
    ON mus.[MobileUnitId] = mu.[MobileUnitId]
      AND mus.[PropertyId] = @SERIAL_NUMBER


## Description

- [x] To the right of the Assets header is a “Show unallocated” checkbox ✅ 2024-07-09
- [x] To the right of the is an information icon ✅ 2024-07-09
- TODO: When **hovering** over this display the following help text:  
	- [x] Assets that have not been assigned to a config group are considered unallocated. ✅ 2024-07-09
- [x] When a user selects the checkbox then ✅ 2024-07-12
	- [x] display all unallocated assets (assets that have not been assigned to a config group) and ✅ 2024-07-12
	- [x] hide all other assets ✅ 2024-07-12
	- [x] There will be limited info available for these assets as they don’t have a config so we’ll only display what we have and leave the cells blank where we don’t have info ✅ 2024-07-12
- [x] A user is then able to select all or multi-select a number of assets ✅ 2024-07-12
- [x] When this is done then the actions dropdown should become available ✅ 2024-07-15
- [x] The user should then be able to select “Move to config group” ✅ 2024-07-15
- [x] When the user deselects the Show unallocated checkbox then display the users previous config group selection ✅ 2024-07-12

### Call In old CG

Request URL:
https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/config_groups/0/assetlist
Request Method:
POST
{
  "fromCache": false,
  "page": 1,
  "pageSize": 50,
  "sortField": "description",
  "sortDirection": 0,
  "filters": [
    {
      "FieldName": "type",
      "Value": "Unallocated"
    }
  ]
}

eg result

{
  "CanViewConfigDifference": true,
  "Items": [
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "891045912992641024",
      "VehicleId": 25,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "1a_danielBench2_4000",
        "Disabled": true
      },
      "Registration": "359739072540545",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "1357762213225021440",
      "VehicleId": 122,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "asdasd",
        "Disabled": true
      },
      "Registration": "asdasdasdasd",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "-5741934008120200948",
      "VehicleId": 17,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "Edwe 4000 bench unit 3",
        "Disabled": true
      },
      "Registration": "359315075835750",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "1240074017994993664",
      "VehicleId": 110,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "Jono MiX3000 EG912",
        "Disabled": true
      },
      "Registration": "862096042559612",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "5471039436101346631",
      "VehicleId": 10,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "LandileFMBenchUnitTest",
        "Disabled": true
      },
      "Registration": "357330050228378",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "-7624792815399856369",
      "VehicleId": 66,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "Martin se MiX4000",
        "Disabled": true
      },
      "Registration": "359739072540495",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Martha UTC",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "-8154404092019945206",
      "VehicleId": 35,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "MIX4000_OBDII_TEST_WINSTON_VW",
        "Disabled": true
      },
      "Registration": "TIGUAN",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "6110269613484206734",
      "VehicleId": 15,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "MiX4000FW Regression 1",
        "Disabled": true
      },
      "Registration": "359315075813708",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "MiX4000FW Regression Stand",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "385546989186155125",
      "VehicleId": 40,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "MiX4000FW Regression 2",
        "Disabled": true
      },
      "Registration": "359315071770241",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "MiX4000FW Regression Stand",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "428038740665402589",
      "VehicleId": 41,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "MiX4000FW Regression 3",
        "Disabled": true
      },
      "Registration": "359315071774284",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "MiX4000FW Regression Stand",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "9037182319420900846",
      "VehicleId": 42,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "MiX4000FW Regression 4",
        "Disabled": true
      },
      "Registration": "359315071708167",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "MiX4000FW Regression Stand",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "-6093589015108786614",
      "VehicleId": 43,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "MiX4000FW Regression 5",
        "Disabled": true
      },
      "Registration": "359316077041215",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "MiX4000FW Regression Stand",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "718292796933432336",
      "VehicleId": 6,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "MR Test FM",
        "Disabled": true
      },
      "Registration": "MRTFM",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "MR Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "1342332343944847360",
      "VehicleId": 119,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "Peter Number",
        "Disabled": true
      },
      "Registration": "DV40",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "1430998670705991680",
      "VehicleId": 129,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "Tristan's Mix4000",
        "Disabled": true
      },
      "Registration": "12341234",
      "FleetNumber": null,
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Bench",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "1377406610580889600",
      "VehicleId": 124,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "Tristan's MiX4000",
        "Disabled": true
      },
      "Registration": "862096048039445",
      "FleetNumber": "1",
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    },
    {
      "FirmwareVersion": "-",
      "VinMatch": false,
      "AssetId": "1090810795210461184",
      "VehicleId": 97,
      "IsConfigurationDifferentToConfigGroup": false,
      "AreConfigurationEventsDifferentToConfigGroup": false,
      "IsConfigurationDeviceDifferentToConfigGroup": false,
      "IsMesaBased": false,
      "IsPhoneBased": false,
      "CanScheduleUploads": false,
      "Description": {
        "Title": "ViviersS_MiX4000",
        "Disabled": true
      },
      "Registration": "359315071747884",
      "FleetNumber": "359315071747884",
      "ConfigGroupId": "Unallocated",
      "ConfigGroupDescription": null,
      "ConfigurationStatus": "Not commissioned",
      "ConfigurationStatusEnum": 0,
      "ConfigurationStatusTime": null,
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
      "MobileDeviceType": null,
      "Imei": null,
      "SerialNumber": null,
      "Actions": [],
      "MobileDeviceTemplate": {
        "Title": "",
        "Disabled": true
      },
      "EventTemplate": {
        "Title": "",
        "Disabled": true
      },
      "LocationTemplate": {
        "Title": "",
        "Disabled": true
      },
      "MobileDeviceTemplateId": null,
      "EventTemplateId": null,
      "LocationTemplateId": null,
      "ScheduleId": null,
      "LastLogEntry": {
        "Title": "",
        "Disabled": false
      },
      "Site": "Default Site",
      "ConfigurationStatusReason": "",
      "isConfigurationStatusReasonAvailable": false
    }
  ],
  "ItemIds": null,
  "ItemIdsFiltered": null,
  "Query": {
    "FromCache": false,
    "DateLoaded": null,
    "Page": 1,
    "PageSize": 50,
    "SortField": "description",
    "SortDirection": 0,
    "Filters": [
      {
        "FieldName": "type",
        "Value": "Unallocated"
      }
    ],
    "GroupIds": null
  },
  "RowCount": 17,
  "PageCount": 1,
  "Page": 1,
  "PageSize": 50,
  "SortField": "description",
  "SortDirection": 0,
  "Filters": [
    {
      "FieldName": "type",
      "Value": "Unallocated"
    }
  ],
  "AvailableListItemTypeFilters": [],
  "ListItemTypeFilterFieldName": "type",
  "HyperMedia": {
    "Links": [
      {
        "ModifyData": false,
        "ExcludeBodyFromResponse": false,
        "Rel": "downloadConfigFile",
        "Uri": "DynaMiX.API/config-admin/organisations/-7094567047859310012/asset/:assetId/downloadConfigFile",
        "Verb": "GET",
        "Params": {
          "assetId": "@assetId"
        },
        "Host": null,
        "SuppressAuthentication": false
      },
      {
        "ModifyData": false,
        "ExcludeBodyFromResponse": false,
        "Rel": "downloadPendingConfigFile",
        "Uri": "DynaMiX.API/config-admin/organisations/-7094567047859310012/asset/:assetId/downloadConfigPendingFile",
        "Verb": "GET",
        "Params": {
          "assetId": "@assetId"
        },
        "Host": null,
        "SuppressAuthentication": false
      },
      {
        "ModifyData": false,
        "ExcludeBodyFromResponse": false,
        "Rel": "downloadMobileunitConfigFile",
        "Uri": "DynaMiX.API/config-admin/organisations/-7094567047859310012/asset/:assetId/downloadMobileUnitConfigFile",
        "Verb": "GET",
        "Params": {
          "assetId": "@assetId"
        },
        "Host": null,
        "SuppressAuthentication": false
      }
    ],
    "Validations": {
      "FormName": null,
      "ValidationRules": {},
      "HasMonitoredEvents": false
    }
  }
}

### Callstack

organisations.*config_groups.*assetlist
BE:       public static readonly RouteDefinition GET_CONFIG_GROUP_ASSETS = new RouteDefinition(APISettings.Current.ApiBaseUrl, BASE_PATH, "/organisations/{orgId}/config_groups/{id}/assetlist", Core.Http.Constants.HTTPVerbs.POST);
GetConfigGroupAssetList
loadUnallocated
assetManager.GetAssetSummaries(authToken, organisationId)

Fleet Client: ApiControllerRoutes.MiXFleetServicesApi.AssetController.GetSummaryList

### Code

Stored Proc: [state].[MobileUnit_GetUnallocatedAssets]
API: GetConfigurationGroupsMultiselectAssetsListUnallocated
Client: HttpGet
FR API: getConfigurationGroupsMultiselectAssetsListUnallocated
FR UI: xxxxxxx


## STEPS

- [x] Stored Proc - DONE on INT ✅ 2024-07-11
	- [state].[MobileUnit_GetUnallocatedAssets]
- NEXT:
	- [x] API ✅ 2024-07-11
	- [x] Client ✅ 2024-07-12
	- [x] FR API ✅ 2024-07-12
	- [x] FR UI ✅ 2024-07-12





---

---------

![[OE Swagger Test]]