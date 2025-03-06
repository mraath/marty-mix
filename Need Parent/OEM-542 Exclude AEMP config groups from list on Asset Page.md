---
status: busy
date: 2023-09-15
comment: 
priority: 1
---

# OEM-542 Exclude AEMP config groups from list on Asset Page

Date: 2023-09-15 Time: 16:17
Parent:: [[AEMP]]
Friend:: [[2023-09-15]]
JIRA:OEM-542 Exclude AEMP config groups from list on Asset Page
[OEM-542 Exclude AEMP config groups from list on Asset Page - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/OEM-542)

## Relates to:

[OEM-544 Create new AEMP mobile device type - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/OEM-544)

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

- AEMP confiq group to asset manually . High impact
	- C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Templates\asset-details.html
	- GET: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/-4224457008471550025/asset/undefined/duplicate/false/get
	- .configGroups
		- C:\Projects\Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.API\Constants\ApiControllerRoutes.cs
		- GetAssetDetailsAsync
		- C:\Projects\Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.API\Controllers\AssetDetailsController.cs
			- GetAssetDetailsAsync
			- +- Line 151
			- _configAdminManager.GetConfigurationGroupsAsync
			- C:\Projects\Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.Logic\ConfigAdminManager\ConfigAdminManager.cs
				- GetConfigurationGroupsAsync
				- DeviceConfigClient.ConfigurationGroups.GetFilteredConfigurationGroupsForAsset
				- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Routes\TemplateLevel\ConfigurationGroupControllerRoutes.cs
					- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Controllers\TemplateLevel\ConfigurationGroupController.cs
						- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\ConfigurationGroupManager.cs
							- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\TemplateLevel\ConfigurationGroup.cs
								- [template].[Template_GetFilteredConfigurationGroupsForAssetId]
									- Return only those for MobileDeviceKey
									- OR All
									- [x] I think if we just change this to never include AEMP CG if MobileDeviceKey is null, it should work ✅ 2023-09-20
- [x] Cant add/ ✅ 2023-09-20
- [x] Cant remove ✅ 2023-09-20

- On the MobileDeviceSettings Tab also 
- [x] hide the ChangeMobileDevice button ✅ 2023-09-20
	- C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Templates\asset-commissioning.html
		- Unique identifier type called
		- Try to find the DeviceTypeName
			- form.DeviceTypeName = mobileDevice.Description
			- AEMP (from the DB MobileDevices)
			- definitionLevelManager.GetMobileDevice(mobileDeviceTemplate.DefinitionDeviceId)
				- Context.MobileDevices.FirstOrDefault(m => m.MobileDeviceId == definitionMobileDeviceId)
		- GET: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944
		- Returns: AssetConfigSummary
			- [x] Maybe on this ADD IsAEMP (Form.DeviceTypeName already has what we need? Maybe field.contains("AEMP")) IS this safe? ✅ 2023-09-20
			- [x] In UI hide button if IsAEMP ✅ 2023-09-20

## Device XML

![[XML MobileDevices AEMP]]

## Development

### Branch
- FE: Config/MR/Feature/OEM-542_Exclude_AEMP_ConfigGroup.23.15.INT_ORI
	- INT: [Pull request 91187: OEM-542: Hide button for units with Logical HasBlackManualCommissioning enabled. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/91187)
- DB: Config/MR/Feature/OEM-542_Exclude_AEMP_ConfigGroup.23.15.INT_ORI
	- INT: [Pull request 91109: OEM-542: Added logic to exclude config groups with AEMP if the unit doesn't h... - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/91109)
- BE: Config/MR/Feature/OEM-542_Exclude_AEMP_ConfigGroup.23.15.INT_ORI
	- INT: [Pull request 91188: OEM-542: Added HasBlockManualCommissioning logical test to hide Change Mobile... - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/91188)

## Test cases

- Make available (first needed eg. Ford OEM)
- Device and CG test. Correct. All but CG there as expected.
- INT: OR: -1983255592473789111
- [[SQL TEST Configuration Group AEMP Stored Proc OEM-542]]
- Test stored proc - ORG but no Asset - worked
![[OEM-542 Exclude AEMP config groups from list on Asset Page Test Stored Proc Org No Asset.png|400]]
- Asset Id: 1441016203391774720
- Test SProc": Org and Asset - Worked
![[OEM-542 Exclude AEMP config groups from list on Asset Page Test SProc with Org and Asset.png|400]]
- [x] Now overwrite the Stored Proc Temp ✅ 2023-09-20
- [x] Add new Asset (NON AEMP) ✅ 2023-09-20
- [x] Ensure AEMP not in list ✅ 2023-09-20
- [x] Save AEMP Asset - use previous ✅ 2023-09-20
- [x] Ensure only AEMP in list ✅ 2023-09-20
- [x] Ensure if AEMP is NOT in the org that the Stored Proc WONT fall over ✅ 2023-09-20
- [x] DB: PR to INT ✅ 2023-09-20
	- [Pull request 91109: OEM-542: Added logic to exclude config groups with AEMP if the unit doesn't h... - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/91109)
- [x] Test local UI to not show button ✅ 2023-09-20
![[OEM-542 Exclude AEMP config groups from list on Asset Page UI Change mobile device button removed.png|400]]
- [x] UI: PR to INT ✅ 2023-09-20
	- [Pull request 91107: OEM-542: Removing the button for AEMP. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/91107)
- 

### Asset Details

- Test Cases
- [x] (TEST) The current call takes an assetID for commissioned assets it returns the list of config groups witht he same type - this needs to be unchanged ✅ 2023-09-20
- [x] For not commissioned assets it returns the full list of config groups, the AEMP group should be excluded from this list ✅ 2023-09-20

### Mobile Device Settings

- [x] Ensure the button is no longer there ✅ 2023-09-20


### Sql Tests

- [x] DEV: Supplied the ORG, but NO Asset, so should return CGs, but NO AEMP. ✅ 2023-09-20

| ConfigurationGroupId | ConfigurationGroupName                       | MobileUnitCount |
| -------------------- | -------------------------------------------- | --------------- |
| 7079562693275531946  | Default configuration group for Navistar OEM | 0               |

- [x] Supply both (Asset should be for AEMP), should ONLY get AEMP CG. ✅ 2023-09-20

Worked well

## CHANGE work to make use of logicals

- Stored proc
- select ParentDeviceKey from definition.DeviceDependencies where ChildDeviceKey in (select DeviceKey from definition.Devices where DeviceId = 5367522731798878433)
- UI
- [[BlockManalCommisioning]] - to block from being assigned to assets page (OEM-542)
- Form.HasBlockManualCommissioning
- [x] BE needs: form.hasBlockManualCommissioning ✅ 2023-09-21
	- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs
		- GetAssetCommissioning
		- PopulateCarrier
			- streamaxEnabled = resolvedMobileDevice.IsDeviceEnabled(ConfigConstants.LogicalDevices.STREAMAX);
- [x] FE also changed ✅ 2023-09-21
- [x] DB still needed PR ✅ 2023-09-21

## INT Testing

- [x] DO UI test for ✅ 2023-09-21
	- [x] CG NOT shows ✅ 2023-09-21
	- [x] CG Shows ✅ 2023-09-21
	- [x] Button NOT shows ✅ 2023-09-21
	- [x] Button Shows ✅ 2023-09-21

