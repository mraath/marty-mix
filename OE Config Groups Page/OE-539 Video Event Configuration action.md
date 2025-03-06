---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-28T14:48
---

# OE-539 Video Event Configuration action

Date: 2024-10-25 Time: 10:45
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-10-25]]
Friend:: [[OE-496 API Config Groups and columns]]
JIRA:OE-539 Video Event Configuration action
[OE-539 Add Video Event Configuration Action for Config Groups - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-539)

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

## Current Code

- FE:
	- static VideoEventConfigurationLanding: string = "/config-admin/video-event-configuration";
	- "VideoEventConfiguration": { iconClass: "icon-report", title: "Video event configuration", eventName: ConfigGroupsLandingController.VideoEventConfigurationEvent }
	- VideoEventConfigurationEvent
		- onVideoEventConfiguration
		- videoEventConfigurationClicked
		- this.location.setPath(MiXFleet.ConfigAdmin.Routes.VideoEventConfigurationLanding, { id: row.configGroupId });
	- [x] Add the SetPath > config-admin/video-event-configuration ✅ 2024-10-25
	- PR: [Pull request 113530: OE-539: Added logic to accept showing Video Event Configuration - Repos](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/113530)
- BE:
	- [x] Look at the logic when to send down this action ✅ 2024-10-25
	- ConfigurationGroupCapabilitiesForConfigurationGroupsList confgGroupCapabilities = DeviceConfigClient.ConfigurationGroups.GetConfigurationGroupCapabilitiesForConfigurationGroupsList("", orgId, null).ConfigureAwait(false).GetAwaiter().GetResult();
	- HashSet long hsSPLineConfigGroups = new HashSet long (confgGroupCapabilities.SPLineGroups);
	- if (hsSPLineConfigGroups.Contains(entity.ConfigurationGroupId))
			{carrier.Actions.Add(_videoEventConfigurationAction);}
	- confgGroupCapabilities.SPLineGroups
	- Add above logic to FR API
- Common
	- eg. RemoveAccess
	- **VideoEventAccess**
	- [x] ConfigurationGroupsMultiselectListCarrier ✅ 2024-10-25
	- [x] ConfigurationGroupMultiselectCarrier ✅ 2024-10-25
	- Branch: Config/MR/Feature/OE-539_VideoEventConfig_INT
	- PR: [Pull request 113458: OE-539 Added access to Video Event Configuration - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/113458)
	- Ver: ==MiX.DeviceIntegration.Common.2024.17.20241025.1==
- API
	- [x] Add Common Nuget ✅ 2024-10-25
	- [x] Add Logic ✅ 2024-10-25
	- TEST:
		- b2beb8a5-4892-4fa8-8b2c-6012945a2d21
		- -4493495256567590976
		- PASSED
	- PR: [Pull request 113459: OE-514: Location template saved to configuration group - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/113459)
	- [Pull request 113468: OE-539: Upgraded nuget. Added logic to populate access tp view Video Event Configuration - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/113468)
- Client
	- [x] Add in Common Nuget ✅ 2024-10-25
	- [Pull request 113461: OE-539: Upgraded Common Nuget - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/113461)
	- ==MiX.ConfigInternal.Api.Client.2024.17.20241025.1==
- FR API
	- [x] Add the BE logic here ✅ 2024-10-25
	- [x] Add in Common Nuget ✅ 2024-10-25
	- [x] Add Client Nuget ✅ 2024-10-25
	- eg. RemoveAccess
		- ConfigurationGroupConverters
		- FR API: ConfigurationGroupsMultiselectCarrier
	- Swagger: Passed
	- [Pull request 113475: OE-439: Upgraded Common, Client Nuget. Added VideoEventAccess Logic. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/113475)
- FR UI:
	- [x] Add the icon when needed (look where added delete/remove) ✅ 2024-10-25
	- "VideoEventConfiguration": { iconClass: "icon-report", title: "Video event configuration", eventName: ConfigGroupsLandingController.VideoEventConfigurationEvent }
	- [x] Tooltip? (Video event configuration) ✅ 2024-10-28
	- [x] Add the drop down again? - col size not great as is - ==YES== ✅ 2024-10-28
	- eg. editConfigGroup
	- showVideoEventConfiguration
	- PR" [Pull request 113648: OE-539: Added row actions to handle single and multiple actions for CG - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/113648)
	- 
- Languaging (Just Test)
	- [x] Video event configuration ✅ 2024-10-28
	- [ ] Remove

## Current Implementation

![[OE-539 Video Event Configuration action dropdowns and actions.png|300]]

- PR: Simplified menu: [Pull request 113651: OE-539: Simplified actions menu as per PO. WIP fix column selector. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/113651)
- Fixed column selector: [Pull request 113652: OE-539: Fixed column selector - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/113652)
- 
## TEST DATA

![[OE Swagger Test]]