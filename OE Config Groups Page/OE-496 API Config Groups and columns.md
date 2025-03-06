---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-01-30T11:48
---

# OE-496 API Get config Groups and columns

Date: 2024-02-05 Time: 11:09
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-02-05]]
JIRA:OE-496 API Get config Groups and columns
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-496)

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

![[OE-496 API Config Groups and columns Columns needed.png]]

## Description

- [x] Select all checkbox ✅ 2024-02-26
- [x] Error icon - display error count - rules for errors will be define in separate task ✅ 2024-03-05
	- Will be done as part of: [[OE-515 Alerts Column Assets Panel]]
- [x] Name - Configuration group name ✅ 2024-02-26
- [x] Asset count - Nr of assets assigned to config group ✅ 2024-02-26
- [x] Flag icon - Nr of assets flagged within config group ✅ 2024-02-27
	- Configuration differences from group
	- eg. DeviceConfigClient.MobileUnits.GetConfigChangedFlagForMobileUnits
	- /mobile-units-changed-flag
		- mobileUnitsWithOverridenEvents
			- [mobileunit].[MobileUNit_GetMobileUnitsWithOverwrittenEventsIds]
		- mobileUnitsWithOverridenDevices
			- [mobileunit].[MobileUnit_GetMobileUnitsWithOverwrittenDevicesIds]
		- 
- [x] Mobile device - Mobile device associated to config group ✅ 2024-02-26
- [x] Mobile device template - Mobile device template linked to config group - green hyperlink that opens the template ✅ 2024-02-26
- [x] Event template - Event template linked to config group - green hyperlink that opens the template ✅ 2024-02-26
- [x] Location template - Location template linked to config group - green hyperlink that opens the template ✅ 2024-02-26
- [x] FW version - Preferred FW version configured on Mobile device connected to the Mobile device template ✅ 2024-02-27
- [x] CAN script - CAN script connected to Mobile device template ✅ 2024-03-06
	- [x] (if 2 connected then display names below each other) - ✅ 2024-03-06
	- [x] green hyperlink that opens CAN script ✅ 2024-03-06
- [x] Speed - Speed source connected to Mobile device template such as Speed sender, J1708 CAN Speed, GPS velocity as speed - ✅ 2024-02-28
	- [x] MiX2000 is always GPS velocity as speed, ✅ 2024-02-27
	- [x] MiX4000/6000/3000 have a Speed line, ✅ 2024-02-27
	- [x] FM we would probably have to look for the speed peripheral as it can be connected to any of the Frequency lines  (Paul could help with this) ✅ 2024-02-28
- [x] RPM - RPM source connected to Mobile device template such as RPM signal or J1708 CAN RPM - ✅ 2024-02-28
	- [x] MiX4000/6000/3000 have a RPM line, ✅ 2024-02-28
	- [x] FM we would probably have to look for the RPM peripheral as it can be connected to any of the Frequency lines  (Paul could help with this) ✅ 2024-02-28
- [x] Fuel - Fuel source connected to Mobile device template such as EDM fuel flow meter or J1708 CAN Fuel - ✅ 2024-02-28
	- [x] MiX4000/6000/3000 have a Fuel line, ✅ 2024-02-28
	- [x] FM we would probably have to look for the RPM peripheral as it can be connected to any of the Frequency lines (Paul could help with this) ✅ 2024-02-28
- [x] NA: Column selector - the last column is a column selector - a user should be able to select/deselect all columns except Name as this is a required column ✅ 2024-02-26
- [x] SP - shows whether Streamax is connected or not. Configured on Mobile device template ✅ 2024-03-06
- [x] HOS - Shows whether DTCO or BYOD/ELD is in use. Configured on the Mobile device template (HOS Line) ✅ 2024-03-06

## UI Columns

- Alerts icon - display error count - see below for details
- Flagged assets icon - Number of assets flagged within the config group
- Name - Configuration group name
- Asset count - Number of assets assigned to config group
- Mobile device - Mobile device associated with config group
- Mobile device template - Mobile device template linked to config group - green hyperlink that opens the template
- Event template - Event template linked to config group - green hyperlink that opens the template
- Location template - Location template linked to config group - green hyperlink that opens the template
- FW version - Preferred FW version configured on the Mobile device connected to the Mobile device template
- CAN script - CAN script connected to Mobile device template (if 2 connected then display names below each other) - a green hyperlink that opens CAN script on the Template level
- Speed - Speed source connected to Mobile device template such as Speed sender, J1708 CAN Speed, GPS velocity as speed
- RPM - RPM source connected to Mobile device template such as RPM signal or J1708 CAN RPM
- Fuel - Fuel source connected to Mobile device template such as EDM fuel flow meter or J1708 CAN Fuel
- SP - shows whether Streamax is connected or not. Configured on Mobile device template
- HOS - Shows whether DTCO or BYOD/ELD is in use. Configured on the Mobile device template (HOS Line)

## Others

- Users are able to select all, multi-select or select a single config group at a time
- When a group is selected then enable the Actions dropdown list at the top of the page

1) [ConfigurationGroupSummary](http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/ConfigurationGroup/ConfigurationGroup_GetConfigurationGroupSummaries)
- ConfigurationGroupId
- ConfigurationGroupName
- MobileUnitCount
2) [MobileDeviceTemplate](http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/MobileDeviceTemplate/MobileDeviceTemplate_GetConfigurationGroupSummaries)
- MobileDeviceType
- MobileDeviceTemplateId
- Name
- CurrentFirmwareVersion
3) Lines
- Eg. [Get The Lines](https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-4493495256567590976/mobile-device-template-lines/-1951388979136968032)
- BE Code (I think there was something newer)
- [x] Have a look for the latest GetLines in our API ✅ 2024-02-28
- Look through the list of lines, for the specific line, then get the connected device name
4) Get Configuration info
- BE: [Example](https://integration.mixtelematics.com/DynaMiX.API/config-admin/-5401647754082838271/configuration_groups/-2221726257111617269)
- Form.SelectedEventTemplateId + Data.EventTemplates (search id), get Title
- Can make this better
5) Scriptable Can line
- d.Line == "C1" && d.DeviceType == PeripheralDeviceType.ScriptableCan
  

## Last Steps

**BRANCH**: Config/MR/Feature/OE-501_ConfigurationGroupsMultiselect.24.6.ORI
**CHANGE**: Config/MR/Feature/OE-496_ConfigurationGroupsMultiselect.24.6.INT.ORI

- [x] Create SQL Stored Proc file ✅ 2024-03-18
	- Added Template_GetConfigurationGroupsMultiselect
	- [[SQL Config Group Get all Columns]]
- [x] DB ✅ 2024-10-28
	- BRANCH: Config/MR/Feature/OE-501_ConfigurationGroupsMultiselect.24.6.ORI
	- [PR to DEV](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/99324)
	- [x] PR TO INT (think the branch now has DEV stuff to roll back... ai) ✅ 2024-10-28
- [x] Common ✅ 2024-03-18
	- ConfigurationGroupMultiselect
	- MiX.DeviceIntegration.Common.2024.3.15.1.nuspec
	- NA PR to DEV
		- In order to get Pallavis merge things in, I will need to do a DEV build also
		- PR to DEV
	- [x] [PR to INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/99793) ✅ 2024-03-18
- [x] OLD API to call this stored proc ✅ 2024-10-28
	- GetConfigurationGroupsMultiselect = "configuration-groups-multiselect/groupId/{groupId}";
	- [x] Import latest Common Nuget ✅ 2024-03-18
	- [x] [PR to DEV 496](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/99940) ✅ 2024-03-20
		- Config/MR/Feature/OE-496_ConfigGRoupMultiselect_DEV
		- Need to import INT changes in here, but conflict between BETA and latest stable
		- MiX.DeviceIntegration.Common.2024.3.18.1-_beta_.nuspec
		- worked with orgid: 3222089765699420885
	- [x] PR to INT (ready to merge) 501 ✅ 2024-10-28
		- [x] CGM GetConfigurationGroupsMultiselect needs to call AWAIT _authorisationProxy.Authorise ✅ 2024-10-28
		- Try with OrgId: -1983255592473789111
- [x] Client to call this OLD API ✅ 2024-03-22
	- Config/MR/Feature/OE-496_ConfigurationGroupsMultiselect.24.6.INT.ORI
	- Code and test done
	- [x] [PR to DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/99946) ✅ 2024-03-20
		- Config/MR/Feature/OE-496_ConfigGRoupMultiselect_DEV
	- [x] PR to INT ✅ 2024-10-28
- [x] NEW API to call this Client ✅ 2024-10-28
	- INT BRANCH: Config/MR/Feature/OE-496_ConfigurationGroupsMultiselect.24.6.ORI
	- DEV BRANCH: Config/MR/Feature/OE-496_ConfigurationGroupsMultiselect.DEV
	- [x] Consume Common ✅ 2024-03-20
	- [x] Consume Client Nuget ✅ 2024-10-28
		- TMP local one consumed
			- MiX.ConfigInternal.Api.Client.2024.6.20240320.1-_alpha_._nupkg_
		- [x] Pull in DEV one ✅ 2024-03-22
			- [x] MiX.ConfigInternal.Api.Client.2024.6.20240320.1-_beta_._nupkg_ ✅ 2024-03-20
		- [x] Pull in INT one ✅ 2024-10-28
			- [x] xxxxxxxxxxxxxxxxxxxxxxxxxxxxx ????? ✅ 2024-10-28
	- [x] [PR to DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/100002) ✅ 2024-03-20
	- [x] [PR to DEV 2](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/100051) ✅ 2024-10-28
	- [x] PR to INT ✅ 2024-10-28
	- getConfigurationGroupsMultiselect
- [x] Testers to test against actual UI info ✅ 2024-10-28
- [x] Ask Paul to look at the SQL ✅ 2024-10-28
- [x] DB should go somewhere like: [template].[Template_GetConfigurationGroupsMultiselect] ✅ 2024-10-28

http://nuget.mixtelematics.com/api/v2/FindPackagesById()?id='MiX.Core.Serialization.JsonText'&semVerLevel=2.0.0

## Code snippets

```txt
// Routes: 
C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Routes\TemplateLevel\ConfigurationGroupControllerRoutes.cs

		/// <summary>
		/// 
		/// </summary>
		public const string GetConfigurationGroupsMultiselect = "configuration-groups-multiselect/groupId/{groupId}";

// Controller: 
C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Controllers\TemplateLevel\ConfigurationGroupController.cs

		/// <summary>
		/// Get all info needed for the multiselect configuration group page
		/// </summary>
		/// <param name="authToken"></param>
		/// <param name="groupId"></param>
		/// <returns>A list of config groups</returns>
		[Route(ConfigurationGroupControllerRoutes.GetConfigurationGroupsMultiselect, Name = "GetConfigurationGroupsMultiselect")]
		[ResponseType(typeof(List<ConfigurationGroupMultiselect>))]
		[HttpGet]
		public async Task<HttpResponseMessage> GetConfigurationGroupsMultiselect(string authToken, long groupId)
		{
			return await HandledResponseAsync(ConfigurationGroupControllerRoutes.GetConfigurationGroupsMultiselect, async () =>
			{
				using (IConfigurationGroupManager man = DependencyRegistry.GetInstance<IConfigurationGroupManager>(false))
				{
					return await man.GetConfigurationGroupsMultiselect(authToken, groupId).ConfigureAwait(false);
				}
			}).ConfigureAwait(false);
		}

// Manager: 
C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\ConfigurationGroupManager.cs

		public async Task<List<ConfigurationGroupMultiselect>> GetConfigurationGroupsMultiselect(string authToken, long groupId)
		{
			_authorisationProxy.Authorise(authToken, Permissions.CAN_ACCESS_CONFIGURATION_GROUPS, groupId);
			return await _deviceConfigRepo.GetConfigurationGroupsMultiselect(groupId).ConfigureAwait(false);
		}


// Repo: 
C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\TemplateLevel\ConfigurationGroup.cs

		public async Task<List<ConfigurationGroupMultiselect>> GetConfigurationGroupsMultiselect(long groupId)
		{
			List<ConfigurationGroupMultiselect> results = null;

			using (SqlConnection conn = new SqlConnection(SettingsProviderFactory.GetProvider(CoreConstants.ServiceName).GetString(CoreConstants.SettingNames.DeviceConfigDb)))
			{
				await conn.OpenAsync().ConfigureAwait(false);
				var queryResults = await conn.QueryAsync<ConfigurationGroupMultiselect>("[template].[Template_GetConfigurationGroupsMultiselect]",
										new
										{
											@groupId = groupId
										},
										commandType: CommandType.StoredProcedure).ConfigureAwait(false);

				if (queryResults != null)
				{
					results = queryResults.ToList();
				}
			}

			return results;
		}


```


## New Story needed

[[OE-519 API Populate Lastposition for Asset List]]
Last position - if possible the last position. Only need to be updated when the page is refreshed?

## BLOCKER



## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...


## Build pipeline

- [x] Fix build pipeline ✅ 2024-10-28

Some links
- [MiX.Config.Frangular.API - Azure DevOps Services](https://dev.azure.com/MiXTelematics/DeviceIntegration/_apps/hub/ms.vss-ciworkflow.build-ci-hub?_a=edit-build-definition&id=1427)
- [Fleet.Services.Operations.UI - Azure DevOps Services](https://dev.azure.com/MiXTelematics/Fleet/_apps/hub/ms.vss-ciworkflow.build-ci-hub?_a=edit-build-definition&id=397)
- [Fleet.Services.Operations.API - Azure DevOps Services](https://dev.azure.com/MiXTelematics/Fleet/_apps/hub/ms.vss-ciworkflow.build-ci-hub?_a=edit-build-definition&id=396&view=Tab_Tasks)
- [Release-CD - Pipelines (azure.com)](https://dev.azure.com/MiXTelematics/Fleet/_releaseDefinition?definitionId=27&_a=definition-tasks&environmentId=67)
- [Pipelines - Runs for MiX.Config.Frangular.API (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build?definitionId=1427&_a=summary)
- [Pipelines - Run Development_2024.03.25.2 (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build/results?buildId=332612&view=results)

## Tests

![[OE Swagger Test]]
