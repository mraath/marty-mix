
---
Parent: [[MIX_BE_MobileDeviceTemplateCrudModule]]
---



# GetDeviceDetails

- [x] AllowedValues - Why not populating

## Expand on these

- mobileDeviceTemplateManager
	- mobileDeviceTemplateManager.GetMobileDeviceTemplateAggregate > mobileDeviceTemplate > CreateFromTemplate(mobileDeviceTemplate) > cmd > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]
- definitionLevelManager
	- definitionLevelManager.GetAllDeviceDependencies > allDeviceDependencies > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]
	- definitionLevelManager.GetAllTrasportTypes > allTransportTypes > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]
	- definitionLevelManager.GetAllPropertyDefinitions > allProperties > ConfigAdminConverters.[[CreateDeviceDetailsCarrier]]
	- definitionLevelManager.GetAllLinkedLogicalDevices > allLinkedLogicals > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]
- libraryMobileDeviceManager
	- libraryMobileDeviceManager > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]
- libraryParameterManager
	- libraryParameterManager > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]
- libraryFirmwareManager
	- libraryFirmwareManager.GetLibraryFirmwareVersions > ==allFirmwareVersions== > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]
- libsProxy
	- libsProxy.OrgMiX2000NewDataProcessorEnabled > isOrgDIS > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]

- OrganisationManager
	- OrganisationManager.GetOrganisationDetail > isTachoForMiX2310iEnabled > [[MIX_BE_ConfigAdminConverters]].[[CreateDeviceDetailsCarrier]]

- page.Form.HyperMedia ...