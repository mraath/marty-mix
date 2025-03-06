---
created: 2023-03-27T07:35
updated: 2024-11-20T09:06
status: busy
comment: 
priority: 1
---

# OE-510 UI Asset Reset Flag

Date: 2024-08-22 Time: 12:00
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-08-22]]
JIRA:OE-510 UI Asset Reset Flag
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-510)

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

- Repos: 
	- [x] FR UI, ✅ 2024-08-28
	- [x] FR API, ✅ 2024-08-27
	- [x] Client, ✅ 2024-08-27
	- [x] API ✅ 2024-08-27
- Languaging
	- [x] Action ✅ 2024-08-22
	- [x] Modals ✅ 2024-08-28

This forms part of the Assets Lists Actions dropdown:
![[OE-507 UI Asset Config Compile Actions.png]]

## Steps

- First see where it happens in the old Code
- [x] MODAL to add ✅ 2024-08-28

### FE

- [x] MODAL ✅ 2024-08-28
      Languaging
	- [x] Reset to group config ✅ 2024-08-28
	- [x] Are you sure you want to reset the asset's configuration to that of the configuration group? ✅ 2024-08-28
		- The languaging has now changed.... to
		- Are you sure you want to reset x (amount) asset(s) configuration to that of the configuration group?
	- [x] Cancel ✅ 2024-08-28
	- [x] Reset ✅ 2024-08-28
- [x] MODAL 2 ✅ 2024-08-28
      Languaging
	- [x] Unable to reset to group config ✅ 2024-08-28
	- [x] An asset was unable to reset to the configuration group ✅ 2024-08-28
	- [x] {{notResetAssets.length}} of the selected asset(s) were unable to reset to the new configuration group ✅ 2024-08-28
- [x] Asset devices successfully reset to group configuration ✅ 2024-08-28

### BE

resetDevices
RESET_DEVICE_TO_CONFIG_GROUP
ResetDeviceToConfigGroup
ResetAssetMobileUnit(authToken, orgId, assetId, ResetType.Devices) //Devices = 1 //Resets to device template only
DeviceConfigClient.MobileUnits.ResetAssetMobileUnit(authToken, assetId, resetType, orgId)

### FR UI
- [x] Call the client method ✅ 2024-08-28
      Carrier: IdsCarrier.Ids

### FR API
- [x] Add method to call the new client method ✅ 2024-08-27
      MiX.ConfigInternal.Api.Client.2024.14.20240826.1
      PR: [Pull request 109223: OE-510: Merged into INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/109223)
- [x] Make use of actual INT client not temp local ✅ 2024-08-26

### CLIENT
- string url = $"{PostPutApiUrl}/groupId/{groupId}/mobile-units/{mobileUnitId}/reset/{resetType}?authToken={authToken}";
- [x] Add internal client to call API ✅ 2024-08-26
      PR: [Pull request 109149: OE-510: Added new client method to reset multiple mobile units - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/109149)

### API
- public const string ResetAssetMobileUnit = "groupId/{groupId}/mobile-units/{mobileUnitId}/reset/{resetType}";
- public const string **ResetAssetMobileUnits** = "groupId/{groupId}/mobile-units/reset/{resetType}";
	- [Swagger UI](http://localhost/DynaMiX.DeviceConfig.Services.Api/swagger/ui/index#!/MobileUnit/MobileUnit_ResetAssetMobileUnits)
- [x] Add API method to multicall the single one ✅ 2024-08-23
      PR: [Pull request 109148: OE-510: New end-point to reset multiple mobile units - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/109148)
- [x] And others? resetAssetMobileUnits ✅ 2024-10-28

## Test

Test: 
```txt
1
-7094567047859310012
[1415760817642536960,1086004667345240064]
{ "ids": "1415760817642536960,1086004667345240064" }
http://localhost/DynaMiX.DeviceConfig.Services.Api
```

## Branch 

> **BRANCH**: Config/MR/Feature/OE-510.INT

URI: http://localhost/DynaMiX.API/config-admin/organisations/-7094567047859310012/assets/1403102293298126848/reset-device-to-config-group




