---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-07-08T10:02
---

# OE-491 UI Assets List Panel

Date: 2024-05-17 Time: 15:11
Parent:: ==xxxx==
Friend:: [[2024-05-17]]
JIRA:OE-491 UI Assets List Panel
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-491)

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

## REPOS

- API: 496, 491 (INT, DEV)
	- Config/MR/Feature/OE-496-CG-OE-497-Asset.INT.ORI
- FR API: 496 (DEV)
	- 
- FR U: 491 (DEV)

## Description

- This will be a call on the new Frangular API to load a list of assets for the selected config groups.
- [x] In the UI where this triggers please note we should possibly only call this eg. 3 seconds after the last select was made, the API will be hammered potentially. ✅ 2024-06-07
    - The current thought it to only add the newly selected Config Group’s assets to the assets list, so only load the last clicked config group’s asset.
- Please also see the NEW UI design for the columns needed.
- Currently, these are the columns:

### Columns

- [x] Alerts icon - display alert count for each asset (HANDLED IN ANOTHER STORY) ✅ 2024-05-31
- [x] Flagged assets icon ✅ 2024-05-31
- [x] Asset ID ✅ 2024-05-31
	- [x] Diff Value - investigate ✅ 2024-06-27
	- [x] Show short value ✅ 2024-06-27
- [x] Asset description - ✅ 2024-05-31
	- [x] clickable link goes to Edit Asset Configuration ✅ 2024-06-04
	- [x] https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=1450923827225116672 ✅ 2024-06-04
	- [x] http://localhost/MiXFleet.UI/#  /config-admin/configuration-groups/asset/events?assetId=1174121359466622976 ✅ 2024-06-04
	- [x] OLD UI: editAssetEventTemplate ✅ 2024-06-04
	- [x] Open new page ✅ 2024-06-04
	- [x] LOST work - retest ✅ 2024-06-05
	- [x] http://localhost/MiXFleet.UI/#/config-admin/configuration-groups/asset/events?assetId=1174121359466622976&duplicate=0 ✅ 2024-06-05
- [x] Registration - Asset registration ✅ 2024-05-31
- [x] Site ✅ 2024-05-31
- [x] Fleet number ✅ 2024-05-31
	- [x] Find one with values ✅ 2024-06-04
- [x] Last position - if possible the last position. Only need to be updated when the page is refreshed? ✅ 2024-05-31
	- [x] Find one with vals ✅ 2024-06-06
	- HANDLED AS OE-519
- [x] IMEI ✅ 2024-05-31
- [x] Serial number ✅ 2024-05-31
- [x] Mobile device - Mobile device associated with config group ✅ 2024-05-31
- [x] Config compile status ✅ 2024-05-31
	- [x] Get one with same values ✅ 2024-06-04
- [x] Config compile status time ? **Not in old one** ✅ 2024-06-28
- [x] Configuration status ✅ 2024-05-31
- [x] Configuration status time ✅ 2024-05-31
- [x] Comms log ✅ 2024-05-31
	- [x] Link to Comms Log ✅ 2024-06-05
	- [x] NEW Window ✅ 2024-06-05
	- [x] http://localhost/MiXFleet.UI/#/config-admin/comms-log?id=1488621931651624960&orgId=-7094567047859310012&device=MiX4000&modal=true ✅ 2024-06-21
	- [x] http://localhost/MiXFleet.UI/#/config-admin/comms-log?id=1415760817642536960&orgId=-7094567047859310012&device=MiX6000%2BLTE&modal=true ✅ 2024-06-21
	- [x] NEW: http://localhost/MiXFleet.UI/#/config-admin/comms-log?id=1312134441394237440&orgId=-7094567047859310012&device=MiX4000&modal=true ✅ 2024-06-21
	- 
	- [x] OLD: http://localhost/MiXFleet.UI/#/config-admin/comms-log?id=1450923827225116672&orgId=-7094567047859310012&device=MiX4000&modal=true ✅ 2024-06-21
	- [x] NEW: http://localhost/MiXFleet.UI/#/config-admin/comms-log?id=1450923827225116672&orgId=-7094567047859310012&device=MiX4000&modal=true ✅ 2024-06-21
	- [x] ONLY MESA should get the link - not all! ✅ 2024-06-20
- [x] Configuration group name ✅ 2024-05-31
- [x] Mobile device template - Mobile device template linked to config group - ✅ 2024-05-31
	- [x] green hyperlink that opens the MD template ✅ 2024-06-04
	- [x] http://localhost/MiXFleet.UI/#/config-admin/templates/mobile-devices/edit?id=-509631762869654139 ✅ 2024-06-04
- [x] Event template - Event template linked to config group - ✅ 2024-05-31
	- [x] green hyperlink that opens the Event template ✅ 2024-06-04
	- [x] http://localhost/MiXFleet.UI/#/config-admin/templates/events/edit?id=3734458975993561092&duplicate=0 ✅ 2024-06-04
	- &duplicate=0 is EXTRA
	- [x] http://localhost/MiXFleet.UI/#/config-admin/templates/events/edit?id=-2641877325531634950 ✅ 2024-06-04
- [x] Location template - Location template linked to config group - ✅ 2024-05-31
	- [x] green hyperlink that opens the template ✅ 2024-06-04
	- [x] Find one with values ✅ 2024-06-04
	- [x] http://localhost/MiXFleet.UI/#/config-admin/templates/locations/edit?id=-4289658368052134957&duplicate=0 ✅ 2024-06-04
- [x] FW version - Preferred FW version configured on **Asset level** ✅ 2024-05-31
	- [x] Get one with values ✅ 2024-06-04
- [x] CAN script - CAN script connected to **Asset level** mobile device template ✅ 2024-05-31
	- [x] (if 2 connected then display names belo each other) - ✅ 2024-05-31
	- [x] green hyperlink that opens **Asset Level** mobile device template CAN script ✅ 2024-06-07
	- [x] CONFIG GROUP ✅ 2024-06-06
		- [x] NEW: /#/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=-2043420209342905840 ✅ 2024-06-06
		- [x] OLD: /#/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=401558247868188484 ✅ 2024-06-07
		- [x] NEW: /#/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=401558247868188484 ✅ 2024-06-06
		- [x] OLD: /#/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=-2043420209342905840 ✅ 2024-06-06
	- [x] Asset (Use above CG to get an asset - get OLD links, then new, compare) ✅ 2024-06-07
		- [x] OLD: /#/config-admin/configuration-groups/asset/mobile-device/edit?assetId=1488621931651624960&lineId=401558247868188484 ✅ 2024-06-07
		- [x] NEW: /#/config-admin/configuration-groups/asset/mobile-device/edit?assetId=1450923827225116672&lineId=-2043420209342905840 ✅ 2024-06-07
		- [x] /#/config-admin/configuration-groups/asset/mobile-device/edit?assetId=1450923827225116672&lineId=401558247868188484 ✅ 2024-06-07
- [x] Speed - Speed source connected to **Asset level** Mobile device template such as Speed sender, J1708 CAN Speed, GPS velocity as speed ✅ 2024-05-31
	- [x] Get one with values ✅ 2024-06-04
- [x] RPM - RPM source connected to **Asset level** mobile device template such as RPM signal or J1708 CAN RPM ✅ 2024-05-31
	- [x] Get one with values ✅ 2024-06-04
- [x] Fuel - Fuel source connected to **Asset level** Mobile device template such as EDM fuel flow meter or J1708 CAN Fuel ✅ 2024-05-31
	- [x] Get one with values ✅ 2024-06-04
- [x] SP - shows whether Streamax is connected or not. Configured on **Asset level** Mobile device template ✅ 2024-05-31
	- [x] Get one with values ✅ 2024-06-04
- [x] MiX Vision serial number - serial number (entered on Mobile device settings page when commissioning Streamax) for the Streamax device connected - if possible (NEW) ✅ 2024-05-31
	- [x] Get one with values ✅ 2024-06-07
	- [x] Doesnt seem to pull through from DB - Fix SP ✅ 2024-06-07
	- [x] -2110415703208626075 ✅ 2024-06-07
- [x] HOS - Shows whether DTCO or BYOD/ELD is in use. Configured on the **Asset level** Mobile device template ✅ 2024-05-31
	- [x] Get one with values ✅ 2024-06-04
- [x] ? Should VIN Match be in here? It was in the old one - YES - Stripped out into [[OE-520 API changes to add the VIN Match column]] ✅ 2024-06-21
- [x] Registering the old UI send receive not always forms - reason - group not always ready from SelectionCriteria ✅ 2024-06-20


MiX.DeviceIntegration.Core.Metrics
MiX.DeviceIntegration.Core.Logging
MiX.DeviceIntegration.Core
MiX.DeviceIntegration.Common
MiX.DeviceIntegration.Core.Alerts
MiX.DeviceIntegration.Core.Queueing
MiX.DeviceIntegration.Queueing.Kafka
MiX.Connect.Dmt.Dtos
MiX.Connect.Dmt.Messages
MiX.Connect.Dmt.Web.Api.Client
MiX.Connect.Dtos
MiX.Connect.Serialization

## Questions to ask PO

- [x] Asset ID: Currently it shows a **short** value, I have it as the long value, which should it be? ✅ 2024-06-04
- Asset Description: The spec says clickable link to asset details page, however the old one would go to **Edit** Asset Configuration
- Config Compile Status Time: The old one didn't have this, I can't find something that will be the correct value. **Await feedback**
- [x] VIN Match: The old one had this, the new spec doesnt, should this be **added**? ✅ 2024-06-04

## Tester Notes

- [ ] Comms Log: Not all OLD and NEW values the same
- [ ] FW version: Diff values from between OLD and NEW
- [ ] PO: Config compile status time ? **Not in old one**

## OUTSTANDING

- [x] Columns Selector ✅ 2024-06-28
- [ ] sortChange
- [x] Users can select all, multi-select or select a single asset at a time ✅ 2024-06-28
	- [x] selectionChange ✅ 2024-06-28
	- [x] Do something with the selected assets: getSelectedAssetsInformation ✅ 2024-06-28
- [x] When at least 1 asset is selected then enable the Actions dropdown list at the top of the page ✅ 2024-06-28

## Branches

- Config/MR/Feature/OE-491 Asset List Panel.24.9.INT.ORI
- Config/MR/Feature/OE-491 Asset List Panel.24.9.DEV.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...


![[OE Swagger Test]]

{configurationGroupIds: ["-6039078778185809084"]}


## More things to add

BUSY:
fetchSelectionCriteriaGrid
setupConfigGroupsGrid


configAssetsColumnsOrdered



columnReordered

DONE:
lockedConfigAssetsColumns
linkConfigGroupsAssetsColumnSettings
configAssetsHiddenColumnSettings
configAssetColumnIcon
configAssetColumnMultiLink
SelectionCriteriaKeys.configAssetsColumnSettings
SelectionCriteriaKeys.configAssetsSelectedColumns
columnAssetSettingsDataMap
assetsColumnReordered
assetsColumnVisibilityChanged
showAssetsActionsForGridItem
showAssetsActions
showAssetsGridItemId
loadAssetsGridSortItems
assetsGridPager
assetsGridPagerItems
assetsSortChange
assetsSort
setupAssetsDictionary

## Eg Values

[
  {
    "alerts": null,
    "flagged": null,
    "assetId": "1450923827225116672",
    "assetDescription": "[TGB] Mix4000 Bench",
    "registration": "DEF123GP",
    "sitename": "Default Site",
    "fleetNumber": 0,
    "lastposition": null,
    "imei": "357796109330284",
    "serialnumber": "47038509",
    "mobileDevice": "MiX4000",
    "configCompileStatus": "Generation complete",
    "configurationStatus": "Configuration changed",
    "configurationStatusDate": "2024/03/25 11:29 (CAT/SAST)",
    "commsLog": "2024/03/25 11:29 (CAT/SAST)",
    "configurationGroupId": "-6039078778185809084",
    "configurationGroupName": "[TGB] MIX4000 Config",
    "mobileDeviceTemplateId": "-2010776559895876483",
    "mobileDeviceTemplateName": "[TGB] - MIX4000 Mobile Template",
    "eventTemplateId": "-2641877325531634950",
    "eventTemplateName": "[TGB] - Event Template",
    "locationTemplateId": "0",
    "locationTemplateName": null,
    "fwVersion": null,
    "canScriptLineId": "-2043420209342905840, 401558247868188484",
    "canScript": "CAN: OBDII Petrol WiredIgn Rev 1.6.0.0[MX46-1285-1], Script.CAN.J1939.250KBPS.ACK_ENBL.v1.28.0.6_MX46-1285-1_MB_BETA009",
    "speed": null,
    "rpm": null,
    "fuel": null,
    "sp": null,
    "miXVisionSerialnumber": "357796109330284",
    "hos": null,
    "hyperMedia": null
  },
  {
    "alerts": null,
    "flagged": 1,
    "assetId": "1488621931651624960",
    "assetDescription": "[TGB] MiX4000 LTE",
    "registration": "862096045423758",
    "sitename": "Default Site",
    "fleetNumber": 0,
    "lastposition": null,
    "imei": "862096045423758",
    "serialnumber": "57000157",
    "mobileDevice": "MiX4000",
    "configCompileStatus": "Generation complete",
    "configurationStatus": "Configuration changed",
    "configurationStatusDate": "2024/04/11 19:03 (CAT/SAST)",
    "commsLog": "2024/04/11 19:03 (CAT/SAST)",
    "configurationGroupId": "-6039078778185809084",
    "configurationGroupName": "[TGB] MIX4000 Config",
    "mobileDeviceTemplateId": "-2010776559895876483",
    "mobileDeviceTemplateName": "[TGB] - MIX4000 Mobile Template",
    "eventTemplateId": "-2641877325531634950",
    "eventTemplateName": "[TGB] - Event Template",
    "locationTemplateId": "0",
    "locationTemplateName": null,
    "fwVersion": null,
    "canScriptLineId": "-2043420209342905840, 401558247868188484",
    "canScript": "CAN: OBDII Petrol WiredIgn Rev 1.6.0.0[MX46-1285-1], Script.CAN.J1939.250KBPS.ACK_ENBL.v1.28.0.6_MX46-1285-1_MB_BETA009",
    "speed": null,
    "rpm": null,
    "fuel": null,
    "sp": null,
    "miXVisionSerialnumber": "862096045423758",
    "hos": null,
    "hyperMedia": null
  }
]

## Notes


DB - Y
API - Y

CLIENT
- Interface
- Class
- Test class
(eg. GetConfigurationGroupsMultiselectAssetsList)

FR-API
- Pull in CLIENT
- Call from: Controller > Man > Repo > Client

FR-UI
- Module Call
- Hypermedia call
- Method call to get data
- Populate Grid Data obj (gridConfigGroups)
- Replace static grid with dynamic columns (as per CG) (configGroupsColumns)

Id: 1
movementStatus: false
errors: ""
assetDescription: "Asset 1"
assetID: "001"
assetSiteTime: ""
commsLog: ""
configCompileStatus: ""
configGroup: ""
configStatus: ""
configStatusTime: ""
eventTemplate: ""
firmwareVersion: ""
fleetNumber: ""
ignitionStatus: ""
imei: ""
lastPosition: ""
mobileDeviceTemplate: ""
mobileDeviceType: ""
registration: ""
serialNumber: ""
site: "", vin: ""
showActions: false



Alerts							NULL
Flagged							NULL
AssetId							1214706184788545536
AssetDescription				Bench FM duplicated
Registration					426043
Sitename
FleetNumber
Lastposition
IMEI
Serialnumber
MobileDevice
ConfigCompileStatus
ConfigurationStatus
ConfigurationStatusDate
CommsLog
MessageStatusDateUtc
LastLogEntry
ConfigurationGroupId
ConfigurationGroupName
MobileDeviceTemplateId
MobileDeviceTemplateName
EventTemplateId
EventTemplateName
LocationTemplateId
LocationTemplateName
FWVersion
CanScriptLineId
CanScript
Speed
RPM
Fuel
SP
MiXVisionSerialnumber
HOS



Default Site
NULL
NULL
NULL
NULL
FM 3607i/3617i
Generation complete
Ready for upload
2022-01-11 14:27:00.000
NULL
NULL
Schedule for VehicleID [22] on transport GPRS enqueued to controller queue. Most recent comms with vehicle: 1457 minutes ago
-4366193155933191679
Regression FM3607i config group
-5485316412779005287
bench FM
-4846060821351987880
Bench FM
NULL
NULL
E19.03.18
NULL
NULL
Speed sender
RPM signal
NULL
Streamax C6D AI
NULL
NULL