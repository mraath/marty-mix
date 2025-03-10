---
created: 2025-03-10T11:49
updated: 2025-03-10T15:08
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

- 77:  getConfigurationGroupsMultiselect (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselect
   - OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/config_groups
   - OLD BE: GET_CONFIG_GROUPS_LIST
	   - GetConfigGroupListPage
		   - 216: ConfigurationGroups.GetConfigurationGroupSummaries(authToken
		   - configuration-groups/groupId/{groupId}
		   - [ ] await _authorisationProxy.Authorise(authToken, Permissions.CAN_ACCESS_CONFIGURATION_GROUPS, groupId).ConfigureAwait(false);
   - Was there Auditing? <mark class="hltr-green">NO</mark>
   - Authorisation? YES
	   - [ ] Not sure it is in new

- 702:  getConfigurationGroupsOtherColumns (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsOtherColumns
   - Was there Auditing? <mark class="hltr-green">NO</mark> - this is a new call
   - [ ] Authorisation? Use as for GET_CONFIG_GROUPS_LIST

- 723:  getConfigurationGroupsAlerts (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsAlerts
   - Was there Auditing? <mark class="hltr-green">NO</mark> - this is a new call
   - [ ] Authorisation? Use as for GET_CONFIG_GROUPS_LIST

- 1510: getConfigurationGroupsMultiselectAssetsList (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsList
   - OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-1983255592473789111/config_groups/-1452809276394549164/assetlist
   - OLD BE: GET_CONFIG_GROUP_ASSETS
	   - GetConfigGroupAssetList
	- Client
	   - groupId/{groupId}/configuration-group/{configurationGroupId}/mobile-units-summary
	   - 
   - Was there Auditing?
   - Is the same Auditing still in tact?
   - Authorisation

- 1605: getConfigurationGroupsMultiselectAssetsListUnallocated (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsListUnallocated
   - OLD UI: xxxxx
   - OLD BE: xxxxxx
   - Was there Auditing?
   - Is the same Auditing still in tact?
   - Authorisation

- 2081: uploadMobileUnitsFirmware
   - Client: ConfigInternalClient.MobileUnits.UploadMobileUnitsFirmware
   - OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/-1983255592473789111/config_groups/asset/1469654901081403392/firmware
   - OLD BE: UPLOAD_ASSET_FIRMWARE
	   - UploadAssetFirmware
	   - configurationGroupManager.UploadAssetFirmware
		   - DeviceConfigClient.MobileUnitCommands.AreMobileUnitsSupportedForUpdateFirmwareCommand
		   - DeviceConfigClient.MobileUnitCommands.UpdateMobileUnitFirmware
		   - UploadAssetFirmwareOldWay
- New 
	- groupId/{groupId}/mobile-units/upload-firmware
	- UploadMobileUnitsFirmware
	- mum.UploadMobileUnitsFirmware
		- 

- 2148: uploadConfigGroupsFirmware
	- Client:ConfigInternalClient.MobileUnits.UploadConfigGroupsFirmware

- 2228: resetAssetMobileUnits
	- Client: ConfigInternalClient.MobileUnits.ResetAssetMobileUnits
		- {PostPutApiUrl}/groupId/{groupId}/mobile-units/reset/{resetType}?authToken={authToken}
	- Config.Api
		- ResetAssetMobileUnits
		- mum.ResetAssetMobileUnits
			- multiple: ResetAssetMobileUnit
				- ResetAssetMobileUnit LOGIC IS THE SAME
	- OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-1983255592473789111/assets/1466026638581260288/reset-device-to-config-group
	- OLD BE: RESET_DEVICE_TO_CONFIG_GROUP > ResetDeviceToConfigGroup
		- DeviceConfigClient.MobileUnits.ResetAssetMobileUnit
	- OLD Client
		- groupId/{groupId}/mobile-units/{mobileUnitId}/reset/{resetType}
	- OLD API:
		- ResetAssetMobileUnit
		- man.ResetAssetMobileUnitConfigGroup
			- [ ] authorisationProxy.Authorise(authToken, Permissions.CAN_RESET_ASSETS_TO_CONFIGURATION_GROUP).ConfigureAwait(false).GetAwaiter().GetResult();
			- ResetAssetMobileUnit
				- ResetAssetMobileUnit LOGIC IS THE SAME
   - Was there Auditing? <mark class="hltr-green">NO</mark>
   - Is the same Auditing still in tact?
   - Authorisation <mark class="hltr-red">Outstanding</mark>
	   - OLD one has
	   - [ ] New one doesnt
		   - In new ResetAssetMobileUnits, just add... as a first line
			   - _authorisationProxy.Authorise(authToken, Permissions.CAN_RESET_ASSETS_TO_CONFIGURATION_GROUP).ConfigureAwait(false).GetAwaiter().GetResult();
