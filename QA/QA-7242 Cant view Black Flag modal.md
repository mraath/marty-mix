---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-04-03T10:47
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
> BRANCH: MR/BUG/QA-7242-BlackFlagNotClickable

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

- NA - Nicole: Permission: canViewConfigDifference = allPermissions[ConfigConstants.Permissions.ASSET_LEVEL_BLACK_FLAG_REASON
	- await _authorisationProxy.Authorise(authToken, Permissions.ASSET_LEVEL_BLACK_FLAG_REASON, groupId).ConfigureAwait(false);
- [x] FR API: Add method to call New Client method ✅ 2025-04-02
	- [x] PR: [Pull request 122350: QA-7242_GettingBlackFlagDiffs - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/122350) ✅ 2025-04-02
- [x] Call above from FR UI ✅ 2025-04-02
- [x] Do UI logic ✅ 2025-04-02

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

```json
"groupDifferences": [
    {
      "definitionId": "string",
      "configType": "string",
      "configObjectSetting": "string",
      "configObject": "string",
      "templateValue": "string",
      "assetValue": "string",
      "userName": "string",
      "dateTime": {
        "dateTime": "2025-03-28T06:23:26.047Z",
        "isoDateTimeString": "string",
        "timeZoneName": "string",
        "timeZoneShortCode": "string",
        "localName": "string"
      }
    }
  ]
```

- FR UI
	- getOverriddenInformationForMobileUnit
		- EG: getAssetDisplayTimeZone
	- getOverriddenInformationForMobileUnit(param: IOrganisationAndAssetsParameters): Observable<ConfigurationGroupDifferenceCarrierList;
	- 



## Testing

- id=-8798513244981487643
- orgId=-7094567047859310012
- Auth: bab5800f-2c61-4635-9284-2147ef7d3968

## Languaging to be done

- [x] Configuration differences from group ✅ 2025-04-02
- [x] Config type ✅ 2025-04-02
- [x] Config object setting ✅ 2025-04-02
- [x] Config object ✅ 2025-04-02
- [x] Template value ✅ 2025-04-02
- [x] Asset value ✅ 2025-04-02
- [x] User name ✅ 2025-04-02
- [x] Date/time ✅ 2025-04-02
- [x] No records available. ✅ 2025-04-02



- [x] PR: [Pull request 122349: QA-7242: Added the Black Flags Modal - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/122349) ✅ 2025-04-03
- [ ] PR: Fix Styling: [Pull request 122454: QA-7242: Black Flag Modal styling - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/122454)

## Deploy to 25.6

- [ ] FR UI: [Pull request 122455: QA-7242: Adding Black Flag Modal - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/122455)
- [ ] FR API: [Pull request 122456: QA-7242 Added modal and Getting Black Flag Diffs - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/122456)
