---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-29T12:30
---

# OE-638 Reset Black Flag

Date: 2025-03-14 Time: 08:39
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-03-14]]
JIRA:OE-638 Reset Black Flag
[OE-638 Reset config group is not successfully resetting the asset to the config group - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-638)


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

## Shorter Description

- Permissions.**CAN_RESET_ASSETS_TO_CONFIGURATION_GROUP**
- **OLD** UI
	- whatToReset
		- "Reset to group config"
		- this.resetConfigGroupClicked
			- code
				- whatToReset = 0
				- If ONE changes
					- events not device > 0
					- device not events > 1
					- resetOneConfigModalForm
				- ELSE both
					- resetBothConfigModalForm
					- Chose 0, 1, 2 (both)
				- resetConfigurationModalButtons
					- cancel OR
					- modalButtonResetClicked
						- this.resetAsset(this._currentRow);
						- resetEvents / resetDevices / reset
		- DeviceConfig**Client**.MobileUnits.GetConfigChangedFlagForMobileUnits
			- row.areConfigurationEventsDifferentToConfigGroup
				- [x] assetConfigFlags[mobileUnit.MobileUnitId].EventChanged ✅ 2025-05-23
			- row.isConfigurationDeviceDifferentToConfigGroup
				- [x] assetConfigFlags[mobileUnit.MobileUnitId].DeviceChanged ✅ 2025-05-23
	- **Old Client**: 
		- GetConfigChangedFlagForMobileUnits
			- groupId/{groupId}/mobile-units-changed-flag
	- Config.**API**"
		- GetConfigChangedFlagForMobileUnits
			- groupId/{groupId}/mobile-units-changed-flag
		- man.GetConfigChangedFlagForMobileUnits
		- [x] Just call the above and send it down to FE for different Choices ✅ 2025-05-23
			- For now just do it for everything? NO CHOICE
		- Permissions.CAN_ACCESS_CONFIGURATION_GROUPS
		- _deviceConfigRepo.GetConfigChangedFlagForMobileUnits
			- GetMobileUnitsWithOverwrittenEventsIds
				- SQL: [mobileunit].[MobileUNit_GetMobileUnitsWithOverwrittenEventsIds]
			- GetMobileUnitsWithOverwrittenDevicesIds
				- SQL: [mobileunit].[MobileUnit_GetMobileUnitsWithOverwrittenDevicesIds]
			- 
- OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/assets/1450923827225116672/reset-events-to-config-group
	- UI: **resetEvents**
	- eventtype: 0
	- **RESET_EVENTS_TO_CONFIG_GROUP**
	- ResetEventsToConfigGroup
	- <mark class="hltr-yellow">ResetAssetMobileUnit (event > 0)</mark>
	- DeviceConfigClient.MobileUnits.ResetAssetMobileUnit
	- OLD Client: 
		- ResetAssetMobileUnit
		- groupId/{groupId}/mobile-units/{mobileUnitId}/reset/{resetType}
	- Config.Api:
		- ResetAssetMobileUnit
		- groupId/{groupId}/mobile-units/{mobileUnitId}/reset/{resetType}
		- man.ResetAssetMobileUnitConfigGroup
			- Permissions.CAN_RESET_ASSETS_TO_CONFIGURATION_GROUP
			- Based on type.... 0 = events.... 
	- https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/assets/963923937065295872/reset-device-to-config-group
	- UI: **resetDevices**
	- eventtype: 1
		- **RESET_DEVICE_TO_CONFIG_GROUP**
		- ResetDeviceToConfigGroup
		- <mark class="hltr-yellow">ResetAssetMobileUnit (type = 1)</mark>
		- 
	- ? MESA: WhatToReset : 1
	- 
	- 
- NEW UI: https://mixconfigfrangularapi.mixdevelopment.com/api/groupId/-7094567047859310012/mobile-units/reset/1
	- SEEMS like the wrong type is being sent
	- FR API: ResetAssetMobileUnits
		- _configurationGroupManager.ResetAssetMobileUnits
		- ConfigInternalClient.MobileUnits.
	- Internal Client: groupId/{groupId}/mobile-units/reset/{resetType}
	- Config.Api:
		- ResetAssetMobileUnits
		- groupId/{groupId}/mobile-units/reset/{resetType}
		- mum.ResetAssetMobileUnits
		- Permissions.CAN_RESET_ASSETS_TO_CONFIGURATION_GROUP
		- for loop: ResetAssetMobileUnit


## Current Steps

PR: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/121337

- [x] TODO: MUST allow the user going forward to select based on Above findings. ✅ 2025-05-23

STEPS

- [x] Lazy load: GetConfigChangedFlagForMobileUnits ✅ 2025-05-27
	- [mobileunit].[MobileUNit_GetMobileUnitsWithOverwrittenEventsIds] (libraryId)
	- [mobileunit].[MobileUnit_GetMobileUnitsWithOverwrittenDevicesIds] (libraryId)
	- 
	- [x] Show lazy load indication ✅ 2025-05-26
	- [x] FR UI: Enable the reset and show the icon ✅ 2025-05-27
		- ddAssetsActions
		- configAssetsActionsEnabled
- [x] Clicked: show modal to allow user to select ✅ 2025-05-29
	- ResetType.Events == 0
	- ResetType.Devices == 1
	- ResetType.EventsAndDevices == 2
- [x] Send through the correct thing to change ✅ 2025-05-29
	- Seems to be ready
- [x] TEST ✅ 2025-05-29

```c#
public class MobileUnitConfigFlag
{
	public long MobileUnitId { get; set; }
	public bool EventChanged { get; set; }
	public bool DeviceChanged { get; set; }
}

List<MobileUnitConfigFlag> mucf = DeviceConfigClient.MobileUnits.GetConfigChangedFlagForMobileUnits(authToken, organisationId).ConfigureAwait(false).GetAwaiter().GetResult();
Dictionary<long, MobileUnitConfigFlag> dictMobileUnitsConfigFlags = mucf.ToDictionary(x => x.MobileUnitId, y => y);
//ConvertToCarrier
carrier.AreConfigurationEventsDifferentToConfigGroup = assetConfigFlags.ContainsKey(mobileUnit.MobileUnitId) && assetConfigFlags[mobileUnit.MobileUnitId].EventChanged;
carrier.IsConfigurationDeviceDifferentToConfigGroup = assetConfigFlags.ContainsKey(mobileUnit.MobileUnitId) && assetConfigFlags[mobileUnit.MobileUnitId].DeviceChanged;
```

- [[Frangular Lazy Loading]]

```html
<form name="resetBothConfigModalForm">
	<strong dmx-translate>Please select one of the following options:</strong>
	<label class="radio mt-10"><input type="radio" ng-model="resetConfigTemplate.whatToReset" value="0"> <span dmx-translate>Reset events</span></label>
	<label class="radio"><input type="radio" ng-model="resetConfigTemplate.whatToReset" value="1"> <span dmx-translate>Reset mobile device settings</span></label>
	<label class="radio"><input type="radio" ng-model="resetConfigTemplate.whatToReset" value="2"> <span dmx-translate>Reset both</span></label>
</form>
```

- [ ] Translations
	- Please select one of the following options:
	- Reset events
	- Reset mobile device settings
	- Reset both

## Implementation

lazyLoadingFlags: boolean = false;
lazyLoadingFlagsUnits: string = '';

"flagged": "other" << CG
"flagged": "flags", << Asset



public const string GetConfigChangedFlagForMobileUnits = "groupId/{groupId}/mobile-units-changed-flag";

**FR API:** 
Route: public const string GetConfigChangedFlagForMobileUnits = "api/configuration-groups-multiselect/groupId/{groupId}/mobile-units-changed-flag";
Controller: new MethodCarrier("getConfigChangedFlagForMobileUnits", ApiControllerRoutes.ConfigurationGroup.GetConfigChangedFlagForMobileUnits, "Get"),
Manager: xxxxxxxxxx
Repo: xxxxxxxxxxxx (client)

MobileUnitConfigFlag -- GetConfigChangedFlagForMobileUnitsListCarrier

DeviceConfigClient.MobileUnits.GetConfigChangedFlagForMobileUnits
List MobileUnitConfigFlag mucf = DeviceConfigClient.MobileUnits.GetConfigChangedFlagForMobileUnits(authToken, organisationId).ConfigureAwait(false).GetAwaiter().GetResult();

- [x] API to call client... ✅ 2025-05-23

```cs
public class MobileUnitConfigFlag
{
	public long MobileUnitId { get; set; }
	public bool EventChanged { get; set; }
	public bool DeviceChanged { get; set; }
}
```

mobile-unit-config-flag-carrier
mobile-unit-config-flag-carrier-list
MobileUnitConfigFlagCarrierList

blackFlagsSources: IMobileUnitConfigFlagCarrier[] = [];

- [x] New Carrier - id to STRING!!!!! ✅ 2025-05-27

Core Class: MobileUnitConfigFlagCarrier
MiX.DeviceIntegration.Common.2025.9.20250526.1.nupkg

## TEST

OrgId: -5401647754082838271, -4493495256567590976
a45324cd-4548-436b-9b3d-d0781d0809cf


## Branch

**BRANCH**: Config/MR/Bug/OE-638_Reset_Black_Flag
Config/MR/Bug/OE-638_Reset_Black_Flag_DEV

## Code

### CORE

- [x] PR **INT**: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/125236 ✅ 2025-05-26

### FR API

- [x] PR **INT** FR API: [Pull request 125109: OE-638: Added GetConfigChangedFlagForMobileUnits FR API end point to get specific area of black flag - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/125109?_a=files) ✅ 2025-05-23
	- [x] NEW PR for new CORE nuget: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/125237 ✅ 2025-05-26
- [x] PR DEV FR API: [Pull request 125111: OE-638: Merge new end point to DEV - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/125111) ✅ 2025-05-23
	- [ ] NEW PR for Core: 

### FR UI

- [ ] PR **INT** FR UI: xxxxxxxxxxx
- [ ] PR DEV FR UI: xxxxxxxxxxx

