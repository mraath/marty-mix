---
wiki_ingested: 2026-05-28
created: 2025-03-26T14:39
updated: 2025-03-26T14:51
---
FR UI: module.updateAssetsConfigurationGroup
FR API: configurationGroupManager.UpdateAssetsConfigurationGroup
	await ConfigInternalClient.Assets.UpdateAssetsConfigurationGroup
Client: assets/configuration-groups/{configGroupId}/update-assets-config-group
API: UpdateAssetsConfigurationGroup
	await man.UpdateAssetsConfigurationGroup
	theTasks.Add(assetId, UpdateAssetConfigGroupAsync(authToken, groupId, assetId, configurationGroupId))
	
