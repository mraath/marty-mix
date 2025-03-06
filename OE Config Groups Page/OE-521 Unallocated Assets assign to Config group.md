---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-09-26T21:53
---

# OE-521 Unallocated Assets assign to Config group

Date: 2024-07-11 Time: 12:07
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-07-11]]
JIRA:OE-521 Unallocated Assets assign to Config group
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-521)

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

## Image Summary

ADD IMAGE

## Description

- [x] When the user should then be able to select “Move to config group” ✅ 2024-07-22
	- [x] When this is selected then open the modal ✅ 2024-07-23
	- [x] Green header: Move to config group ✅ 2024-07-23
	- [x] Help text: You have selected x assets. Please select a configuration group to move these to: ✅ 2024-07-23
	- [x] Below this is a drop down list of available configrationg groups ✅ 2024-07-23
	- [x] The user needs to be able to also easily search for a specific config group so the select box should also double as a searchable field ✅ 2024-08-19
	- [x] Once the user has selected the config group then the user can select “Move” ✅ 2024-07-23
	- [x] This should then move the selected assets to said config group ✅ 2024-07-22
	- [x] Close the modal and display a green toast message on screen with text: Assets moved successfully ✅ 2024-07-26
	- [x] If it does fail for whatever reason then display the **error** on the screen as per usual ✅ 2024-08-19
## Code

FE: Changing configuration group

BE: MOVE_ASSETS_TO_CONFIGURATION_GROUP
UpdateAssetsConfigGroup
manager.UpdateAssetsConfigurationGroup
CGM.UpdateAssetsConfigurationGroup
- [x] Move this logic to the internals client in order to make this call from the FR API ✅ 2024-07-22
- [x] Make async the moveasset old api call... ✅ 2024-07-22
	- NA This method still uses proxies - replace

- Common: MiX.DeviceIntegration.Common.Entities.MobileUnitLevel IncompatibleAssets
- API: public const string UpdateAssetsConfigurationGroup = "groupId/{groupId}/assets/configuration-groups/{configGroupId}/update-assets-config-group";
- updateAssetsConfigurationGroup



```c#
Task<IncompatibleAssets> UpdateAssetsConfigurationGroup(string authToken, long groupId, List<long> assetIds, long configurationGroupId, long? correlationId = null);
```

- FR API
	- public const string UpdateAssetsConfigurationGroup = "api/configuration-groups-multiselect/groupId/{groupId}/assets/configuration-groups/{configGroupId}/update-assets-config-group";
	- UpdateAssetsConfigurationGroup
- FR UI
	- modalConfirm
	- ddAssetsActions
	- currentConfigGroup
	- dropdownConfigGroupChanged
	- updateAssetsConfigurationGroup
		- model: assetIds
		- param: groupId, configGroupId
	- [[Frangular Notifications]]

UPDATING being called:

http://localhost:5000/api/configuration-groups-multiselect/groupId/-7094567047859310012/assets/configuration-groups/-6836621200088256507/update-assets-config-group
{  "assetIds": "-5741934008120200948" }
limit for retries has been exceeded

UpdateAssetsConfigurationGroup = "groupId/{groupId}/assets/configuration-groups/{configGroupId}/update-assets-config-group";
UpdateAssetsConfigurationGroup = "api/configuration-groups-multiselect/groupId/{groupId}/assets/configuration-groups/{configGroupId}/update-assets-config-group";

## OLD Code

### BE

```c#
/// <summary>
/// Moves list of asset ids into new configuration group. 
/// Returns list of asset ids that is not compatible with new config group mobile unit and could not be moved.
/// </summary>
/// <returns>List of FAILED asset ids because of mobile unit compatibility</returns>
[Authorise]
public IncompatibleAssets UpdateAssetsConfigurationGroup(string authToken, long orgId, List<long> assetIds, long configurationGroupId, long correlationId)
	{
		IncompatibleAssets incompatibleAssets = new IncompatibleAssets();

		// Check if the Config Group we are moving to is blocked for manual commissioning
		Dictionary<long, bool> linkedBlockManualCommissioningLogical = DeviceConfigClient.ConfigurationGroups.GetAreDevicesLinkedToConfigurationGroup(authToken, configurationGroupId, new List<long> { ConfigConstants.LogicalDevices.BlockManualCommissioning_Logical }).ConfigureAwait(false).GetAwaiter().GetResult();

		bool isConfigGroupBlocked = false;

		if ((linkedBlockManualCommissioningLogical != null) && (linkedBlockManualCommissioningLogical.TryGetValue(ConfigConstants.LogicalDevices.BlockManualCommissioning_Logical, out isConfigGroupBlocked)))
		{
			if (isConfigGroupBlocked)
			{
				incompatibleAssets.BlockManualCommissioning = true;
				return incompatibleAssets;
			}
		}

		Dictionary<long, Task<UpdateResult>> theTasks = new Dictionary<long, Task<UpdateResult>>();

		foreach (long assetId in assetIds)
		{
			theTasks.Add(assetId, DeviceConfigClient.Assets.UpdateAssetConfigGroup(authToken, assetId, configurationGroupId));
		}

		Task.WhenAll(theTasks.Select(x => x.Value)).ConfigureAwait(false).GetAwaiter().GetResult();

		foreach (var item in theTasks)
		{
			var a = item.Value.Result;
			if (!a.Success && a.Message.Contains(ConfigConstants.ErrorMessages.ConfigAdmin.CONFIG_GROUP_ASSET_MOBILE_DEVICE_TYPE_CONFLICT))
				incompatibleAssets.IncompatibleAssetIds.Add(item.Key);
		}

		return incompatibleAssets;
	}
```

### FE

```c#
this.pageData.moveAssetsTemplate["moveAssets"]({ id: configGroup.configGroupId }).then((result: ConfigGroups.IMoveAssetsResult) => {
		if (result.incompatibleAssets.length === 0 && result.incompatibleVinAssetsDescriptions.length === 0 && (!result.blockManualCommissioning)) {
				if (result.assetIds.length === 1)
					this.alert.show(MiXFleet.Services.AlertType.Success, "Asset moved successfully");
				else
					this.alert.show(MiXFleet.Services.AlertType.Success, "Assets moved successfully");

				this.getConfigGroups();
				return;
		}
		else {
				this.scope.mobileDeviceIncompatibleModalButtons = [{
					title: 'OK', cssClass: 'btn btn-wide btn-success', clickFn: () => {
						if (result.incompatibleVinAssets.length !== 0) {
							this.moveAssetCount = assets.length - result.incompatibleAssets.length - result.incompatibleVinAssets.length;
							this.scope.$broadcast('showModal', 'mobileDeviceIncompatibleVinModal', {});
						}
					}
				}];
				this.scope.mobileDeviceIncompatibleVinModalButtons = [{
					title: 'OK', cssClass: 'btn btn-wide btn-success'}];

				this.scope.blockManualCommissioningModalButtons = [{
					title: 'OK', cssClass: 'btn btn-wide btn-success'
				}];

				this.scope.assetsMoveResult = result;
				if (result.incompatibleAssets.length !== 0) {
					this.scope.$broadcast('showModal', 'mobileDeviceIncompatibleModal', {});
				}
				else if (result.incompatibleVinAssets.length !== 0) {
					this.moveAssetCount = assets.length - result.incompatibleAssets.length - result.incompatibleVinAssets.length;
					this.scope.$broadcast('showModal', 'mobileDeviceIncompatibleVinModal', {});
				} else if (result.blockManualCommissioning === true) {
					this.scope.$broadcast('showModal', 'blockManualCommissioningModal', {});
				}

		}
		this.endUpdate();
		this.refresh();
});
```
## Outstanding

- [x] Shawn CSS for modal ✅ 2024-08-13

## Notes

http://localhost:5000/api/configuration-groups-multiselect/groupId/-7094567047859310012/assets/configuration-groups/-2803813420773469362/update-assets-config-group


```c#
this.module.updateAssetsConfigurationGroup({ groupId: this.organisationId, configGroupId: this.currentConfigGroup }, { assetIds: assetSelectedKeys })
      .pipe(takeWhile(() => this.alive))
      .subscribe((carrier: IConfigurationGroupIncompatibleAssets) => {

        // DO STUFF
        
      }, ((error) => {
        // SHOW ERROR
      })
      );
```


## Tests

- [Swagger UI](http://localhost/DynaMiX.DeviceConfig.Services.Api/swagger/ui/index#!/Asset/Asset_UpdateAssetsConfigurationGroup)
- 