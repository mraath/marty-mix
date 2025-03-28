---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-28T10:27
---

# QA-7242 Cant view Black Flag modal

Date: 2025-03-27 Time: 10:30
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-03-27]]
JIRA:QA-7242 Cant view Black Flag modal
[QA-7242 QA - Configuration groups (Beta): Unable to click on flag to open the "Configuration differences from group" Modal - Jira](https://csojiramixtelematics.atlassian.net/browse/QA-7242)


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

Black flag not clickable

> Version 25.6 beta
> BRANCH: Config/MR/BUG/QA-7242_BlackFlagNotClickable25.6.UAT.ORI

- Path: C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Controllers\ConfigGroupsLandingController.ts
	- Line 998
- Look for "Configuration differences from group" in the original HTML
- FE: configDiff
- BE: GET_CONFIG_DIFFERENCE
	- GetConfigDifference
	- mobileUnitManager.GetConfigurationGroupDifferences
		- ToConfigurationGroupDifferencesCarrier
	- DeviceConfigClient.MobileUnits.GetOverriddenInformationForMobileUnit
- OLD Client: GetOverriddenInformationForMobileUnit = "mobile-units/{mobileUnitId}/get-overridden-info"
	- /get-overridden-info
- New Client: /mobile-units/{mobileUnitId}/get-overridden-info
	- mobileunitrepo.GetOverriddenInformationForMobileUnit
- Config API: mum.GetOverriddenInformationForMobileUnit
	- 

- [ ] Permission: canViewConfigDifference = allPermissions[ConfigConstants.Permissions.ASSET_LEVEL_BLACK_FLAG_REASON
	- await _authorisationProxy.Authorise(authToken, Permissions.ASSET_LEVEL_BLACK_FLAG_REASON, groupId).ConfigureAwait(false);
- [ ] FR API: Add method to call New Client method
- [ ] Call above from FR UI
- [ ] Do UI logic

## Implementation

- GetOverriddenInformationForMobileUnit
	- api/configuration-groups-multiselect/mobile-units/{mobileUnitId}/get-overridden-info
- getOverriddenInformationForMobileUnit
- MobileUnitDifference
- FR API:
	- 
	- man: public async Task<List<MobileUnitDifference GetOverriddenInformationForMobileUnit(long mobileUnitId, long? correlationId = null)


- FR API
	- api/configuration-groups-multiselect/groupId/{groupId}/mobile-units/{mobileUnitId}/get-overridden-info

## Testing

- id=-8798513244981487643
- orgId=-7094567047859310012
- Auth: bab5800f-2c61-4635-9284-2147ef7d3968
