---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-22T17:00
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
				- [ ] assetConfigFlags[mobileUnit.MobileUnitId].EventChanged
			- row.isConfigurationDeviceDifferentToConfigGroup
				- [ ] assetConfigFlags[mobileUnit.MobileUnitId].DeviceChanged
	- **Old Client**: 
		- GetConfigChangedFlagForMobileUnits
			- groupId/{groupId}/mobile-units-changed-flag
	- Config.**API**"
		- GetConfigChangedFlagForMobileUnits
			- groupId/{groupId}/mobile-units-changed-flag
		- man.GetConfigChangedFlagForMobileUnits
		- [ ] Just call the above and send it down to FE for different Choices
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

- [ ] TODO: MUST allow the user going forward to select based on Above findings.

STEPS

- [ ] Lazy load: GetConfigChangedFlagForMobileUnits
	- [mobileunit].[MobileUNit_GetMobileUnitsWithOverwrittenEventsIds] (libraryId)
	- [mobileunit].[MobileUnit_GetMobileUnitsWithOverwrittenDevicesIds] (libraryId)
	- 
	- [ ] Show lazy load indication
	- [ ] FR UI: Enable the reset and show the icon
- [ ] Clicked: show modal to allow user to select
	- ResetType.Events == 0
	- ResetType.Devices == 1
	- ResetType.EventsAndDevices == 2
- [ ] Send through the correct thing to change
	- Seems to be ready
- [ ] TEST

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


## Implementation

lazyLoadingFlags: boolean = false;
lazyLoadingFlagsUnits: string = '';

"flagged": "flags",

BRANCH: Config/MR/Bug/OE-638_Reset_Black_Flag

public const string GetConfigChangedFlagForMobileUnits = "groupId/{groupId}/mobile-units-changed-flag";
DeviceConfigClient.MobileUnits.GetConfigChangedFlagForMobileUnits

- [ ] API to call client...