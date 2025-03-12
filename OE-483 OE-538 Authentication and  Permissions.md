---
created: 2025-03-11T09:20
updated: 2025-03-12T10:28
---

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

## My findings


- ConfigGroups: CAN_ACCESS_CONFIGURATION_GROUPS

- [x] 77:  getConfigurationGroupsMultiselect ✅ 2025-03-12
	- Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselect
		- configuration-groups-multiselect/groupId/{groupId}
	- Config.Api
		- GetConfigurationGroupsMultiselect
		- [x] Already has the same auth ✅ 2025-03-12
	- **OLD** UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/config_groups
	- OLD BE: GET_CONFIG_GROUPS_LIST
	- GetConfigGroupListPage
		- DeviceConfigClient.ConfigurationGroups.GetConfigurationGroupSummaries
		- configuration-groups/groupId/{groupId}
		- [x] await _authorisationProxy.Authorise(authToken, Permissions.CAN_ACCESS_CONFIGURATION_GROUPS, groupId).ConfigureAwait(false); ✅ 2025-03-12
   - Authorisation? YES
	   - [x] Not sure it is in new ✅ 2025-03-12

- [x] 702:  getConfigurationGroupsOtherColumns (GET shouldn't audit anything) ✅ 2025-03-12
	- Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsOtherColumns
	- [x] Authorisation? Use as for GET_CONFIG_GROUPS_LIST ✅ 2025-03-12

- [x] 723:  getConfigurationGroupsAlerts (GET shouldn't audit anything) ✅ 2025-03-12
	- Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsAlerts
	- GetConfigurationGroupsMultiselectAssetAlertsList
	- CAN_ACCESS_CONFIGURATION_GROUPS
	- [x] Authorisation? Use as for GET_CONFIG_GROUPS_LIST ✅ 2025-03-12

- [ ] 1510: getConfigurationGroupsMultiselectAssetsList (GET shouldn't audit anything)
	- Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsList
		- 
	- **OLD** UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-1983255592473789111/config_groups/-1452809276394549164/assetlist
	- OLD BE: GET_CONFIG_GROUP_ASSETS
		- GetConfigGroupAssetList
		- DeviceConfigClient.MobileUnits.GetMobileUnitSummariesForConfigurationGroupMobileUnitSummary
	- Client
		- groupId/{groupId}/configuration-group/{configurationGroupId}/mobile-units-summary
		- _deviceConfigRepo.GetMobileUnitSummariesForConfigurationGroup
	- [x] Authorisation: <mark class="hltr-green">NONE</mark> ✅ 2025-03-12

- [ ] Also the Alerts , OtherColumns, etc

- [ ] 1605: getConfigurationGroupsMultiselectAssetsListUnallocated (GET shouldn't audit anything)
	- Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsListUnallocated
	- OLD UI: xxxxx
	- OLD BE: xxxxxx
	- [ ] Authorisation


- [ ] 2081: uploadMobileUnitsFirmware
	- Client: ConfigInternalClient.MobileUnits.UploadMobileUnitsFirmware
	- OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/-1983255592473789111/config_groups/asset/1469654901081403392/firmware
	- OLD BE: UPLOAD_ASSET_FIRMWARE
		- UploadAssetFirmware
		- configurationGroupManager.UploadAssetFirmware
			- DeviceConfigClient.MobileUnitCommands.AreMobileUnitsSupportedForUpdateFirmwareCommand ✅
			- DeviceConfigClient.MobileUnitCommands.UpdateMobileUnitFirmware
			- SendCommandToMobileUnit
		- UploadAssetFirmwareOldWay
	- New 
		- groupId/{groupId}/mobile-units/upload-firmware
		- UploadMobileUnitsFirmware
		- mum.UploadMobileUnitsFirmware
			- disSupportedUnits
			- SendCommandToMobileUnit
			- UploadAssetFirmwareOldWay
	- [ ] Authorisation

- [ ] 2148: uploadConfigGroupsFirmware
	- NEW
		- Client:ConfigInternalClient.MobileUnits.UploadConfigGroupsFirmware
		- groupId/{groupId}/config-groups/upload-firmware
		- Config API: UploadConfigGroupsFirmware
			- mum.UploadConfigGroupsFirmware
			- UploadMobileUnitsFirmware
	- OLD
		- UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/-1983255592473789111/configuration_groups/-1452809276394549164/firmware
		- BE: UPLOAD_CONFIGURATION_GROUP_FIRMWARE
			- UploadConfigurationGroupFirmware
			- configurationGroupManager.UploadConfigurationGroupFirmware
		- Client
			- UpdateMobileUnitFirmware
	- [ ] Authorisation

- [x] 2228: resetAssetMobileUnits ✅ 2025-03-11
	- Client: ConfigInternalClient.MobileUnits.ResetAssetMobileUnits
		- {PostPutApiUrl}/groupId/{groupId}/mobile-units/reset/{resetType}?authToken={authToken}
	- Config.Api
		- ResetAssetMobileUnits
		- mum.ResetAssetMobileUnits
			- multiple: ResetAssetMobileUnit
				- ResetAssetMobileUnit LOGIC IS THE SAME
	- **OLD** UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-1983255592473789111/assets/1466026638581260288/reset-device-to-config-group
	- OLD BE: RESET_DEVICE_TO_CONFIG_GROUP > ResetDeviceToConfigGroup
		- DeviceConfigClient.MobileUnits.ResetAssetMobileUnit
	- OLD Client
		- groupId/{groupId}/mobile-units/{mobileUnitId}/reset/{resetType}
	- OLD API:
		- ResetAssetMobileUnit
		- man.ResetAssetMobileUnitConfigGroup
			- [x] authorisationProxy.Authorise(authToken, Permissions.CAN_RESET_ASSETS_TO_CONFIGURATION_GROUP).ConfigureAwait(false).GetAwaiter().GetResult(); ✅ 2025-03-11
			- ResetAssetMobileUnit
				- ResetAssetMobileUnit LOGIC IS THE SAME
	   - Authorisation <mark class="hltr-red">Outstanding</mark>
		   - OLD one has
		   - [x] New one doesnt ✅ 2025-03-11
			   - In new ResetAssetMobileUnits, just add... as a first line
			   - _authorisationProxy.Authorise(authToken, Permissions.CAN_RESET_ASSETS_TO_CONFIGURATION_GROUP).ConfigureAwait(false).GetAwaiter().GetResult();

