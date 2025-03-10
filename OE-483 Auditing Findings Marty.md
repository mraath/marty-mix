---
created: 2025-03-10T11:49
updated: 2025-03-10T12:42
---
- 77:  getConfigurationGroupsMultiselect (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselect
   - OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/config_groups
   - OLD BE: GET_CONFIG_GROUPS_LIST
	   - 
   - Was there Auditing?
   - Is the same Auditing still in tact?
   - Authorisation

- 702:  getConfigurationGroupsOtherColumns (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsOtherColumns
   - OLD UI: xxxxx
   - OLD BE: xxxxxx
   - Was there Auditing?
   - Is the same Auditing still in tact?
   - Authorisation

- 723:  getConfigurationGroupsAlerts (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsAlerts
   - OLD UI: xxxxx
   - OLD BE: xxxxxx
   - Was there Auditing?
   - Is the same Auditing still in tact?
   - Authorisation

- 1510: getConfigurationGroupsMultiselectAssetsList (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsList
   - OLD UI: xxxxx
   - OLD BE: xxxxxx
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
   - Was there Auditing?
   - Is the same Auditing still in tact?
   - Authorisation
	   - OLD one has
	   - [ ] New one doesnt
