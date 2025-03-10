---
created: 2025-03-10T11:49
updated: 2025-03-10T12:26
---
- 77:  getConfigurationGroupsMultiselect (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselect
   - OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/config_groups
   - OLD BE: GET_CONFIG_GROUPS_LIST
	   - 
   - Was there Auditing?
   - Is the same Auditing still in tact?

- 702:  getConfigurationGroupsOtherColumns (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsOtherColumns
   - OLD UI: xxxxx
   - OLD BE: xxxxxx
   - Was there Auditing?
   - Is the same Auditing still in tact?

- 723:  getConfigurationGroupsAlerts (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsAlerts
   - OLD UI: xxxxx
   - OLD BE: xxxxxx
   - Was there Auditing?
   - Is the same Auditing still in tact?

- 1510: getConfigurationGroupsMultiselectAssetsList (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsList
   - OLD UI: xxxxx
   - OLD BE: xxxxxx
   - Was there Auditing?
   - Is the same Auditing still in tact?

- 1605: getConfigurationGroupsMultiselectAssetsListUnallocated (GET shouldn't audit anything)
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsListUnallocated
   - OLD UI: xxxxx
   - OLD BE: xxxxxx
   - Was there Auditing?
   - Is the same Auditing still in tact?

- 2228: resetAssetMobileUnits
	- Client: ConfigInternalClient.MobileUnits.ResetAssetMobileUnits
		- 
	- OLD UI: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-1983255592473789111/assets/1466026638581260288/reset-device-to-config-group
	- OLD BE: RESET_DEVICE_TO_CONFIG_GROUP > ResetDeviceToConfigGroup
		- DeviceConfigClient.MobileUnits.ResetAssetMobileUnit
	- Client
		- groupId/{groupId}/mobile-units/{mobileUnitId}/reset/{resetType}
	- OLD API:
		- ResetAssetMobileUnit
		- man.ResetAssetMobileUnitConfigGroup
		- 
   - Was there Auditing?
   - Is the same Auditing still in tact?
