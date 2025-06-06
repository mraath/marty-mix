---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-06T13:00
---

# OPEN-236 config group panel shows 2 assets but only 1 asset appears in the asset panel

Date: 2025-06-06 Time: 10:50
Parent:: [[Configuration Groups]]
Friend:: [[2025-06-06]]
JIRA:OPEN-236 config group panel shows 2 assets but only 1 asset appears in the asset panel
https://powerfleet.atlassian.net/browse/OPEN-236


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

Config group panel shows 2 assets but only 1 asset appears in the asset panel:

- Amy Bench Units
- Default configuration group for MiX4000

## Code

- getConfigGroups
	- getConfigurationGroupsMultiselect (THIS DOESNT get the AssetCount - it is lazy loaded)
		- _configurationGroupManager.GetConfigurationGroupsMultiselect
		- ConfigInternalClient.InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselect
			- configuration-groups-multiselect/groupId/{groupId}?authToken={authToken}
				- man.GetConfigurationGroupsMultiselect
				- [template].[Template_GetConfigurationGroupsMultiselect]
					- @groupId
	- Lazy loaded: Xxxxxxxxxxxxxxxxxxxxxxxxxx
		- 
- getConfigAssets
	- getConfigurationGroupsMultiselectAssetsList
		- _configurationGroupManager.GetConfigurationGroupsMultiselectAssetsList
		- ConfigInternalClient.InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsList
			- configuration-groups-multiselect/groupId/{groupId}/assets-list?authToken={authToken}
				- man.GetConfigurationGroupsMultiselectAssetsList
				- [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]
					- configGroupIds
