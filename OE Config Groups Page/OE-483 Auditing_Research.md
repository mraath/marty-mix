---
created: 2025-03-10T10:47
updated: 2025-03-10T11:42
---
# Auditing

Nicole would like to know if we kept all current Auditing in place.
We need to check that the new implementation doesn't remove any auditing.
I had a look at our Frangular UI to see which calls we make.

Herewith the "this.module" instances I found.
*Please compare* these to the old BE auditing logic (if any)
I have assigned them to the best of my knowledge.
Please let me know if I something should be tested by someone else.

## I think these are not applicable

654:  getQueryOptionsAsync
2587: getOrgDisplayTimeZone
2612: getAssetDisplayTimeZone
1538: getConfigurationGroupsMultiselectAssetLinesList
1560: getConfigurationGroupsMultiselectAssetAlertsList

## Marty needs to check these

677:  getConfigurationGroupsMultiselect
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselect

702:  getConfigurationGroupsOtherColumns
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsOtherColumns

723:  getConfigurationGroupsAlerts
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsAlerts

1510: getConfigurationGroupsMultiselectAssetsList
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsList

1605: getConfigurationGroupsMultiselectAssetsListUnallocated
   - Client: InternalConfigurationGroupsRepository.GetConfigurationGroupsMultiselectAssetsListUnallocated

2228: resetAssetMobileUnits
   - Client: ConfigInternalClient.MobileUnits.ResetAssetMobileUnits

## Pallavi needs to check these

1104: deleteConfigurationGroup
   - Client: InternalConfigurationGroupsRepository.DeleteConfigurationGroup

1682: updateAssetsConfigurationGroup
   - Client: ConfigInternalClient.Assets.UpdateAssetsConfigurationGroup

3207: getConfigurationGroupTemplate
   - Client: ConfigInternalClient.InternalConfigurationGroupsRepository.GetConfigurationGroupTemplate

3285: createConfigurationGroup
   - Client: ConfigInternalClient.InternalConfigurationGroupsRepository.CreateConfigurationGroup

3309: updateConfigurationGroup
   - Client: ConfigInternalClient.InternalConfigurationGroupsRepository.UpdateConfigurationGroup

3344: getConfigurationGroup
   - Client: ConfigInternalClient.InternalConfigurationGroupsRepository.GetConfigurationGroup

## Justus needs to check these (He might have already)

2081: uploadMobileUnitsFirmware
   - Client: ConfigInternalClient.MobileUnits.UploadMobileUnitsFirmware

2148: uploadConfigGroupsFirmware
   - Client:ConfigInternalClient.MobileUnits.UploadConfigGroupsFirmware

2688: uploadConfiguration
   - Has this been Implemented. My codebase only seems to return a blank object.

## Sanity check

I might have missed something.
Please feel free to let me know.
