---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-14T10:31
---

# OE-638 Reset Black Flag

Date: 2025-03-14 Time: 08:39
Parent:: [[OE-513]]
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

- **OLD** UI
	- whatToReset
		- "Reset to group config"
		- this.resetConfigGroupClicked
			- code
				- whatToReset = 0
				- 
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
		- 