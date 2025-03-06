---
status: busy
date: 2023-09-26
comment: 
priority: 1
---

# OEM-570 Remove AEMP on the Mobile device settings page when changing the device type

Date: 2023-09-26 Time: 14:49
Parent:: ==xxxx==
Friend:: [[2023-09-26]]
JIRA:OEM-570 Remove AEMP on the Mobile device settings page when changing the device type
==URL TO JIRA==

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

## Description

The AEMP shouldn't show under New mobile device type
![[Pasted image 20230926144920.png | 300]]

## Branches
- OEM-542 branch
- PR to INT
	- [Pull request 91393: OEM-570: Removed AEMP from devices on Change Mobile Device - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/91393)
	- 

## Code

- FE: C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Templates\asset-commissioning.html
	- changeMobileDeviceTemplate.devices
- BE: C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs
	- GetAssetCommissioning
		- +- Line 695
		- changeMobileDeviceTemplate.Devices.Add(mobileDeviceCarrier);
		- definitionLevelManager.GetMobileDevices
			- ConfigAdminRepository.GetMobileDevices
		- AEMP = 7089198383589898700
		- 717 ?????
		- changeMobileDeviceTemplate.ConfigGroups.Add(configurationGroupCarrier);
		- 

## Testing



