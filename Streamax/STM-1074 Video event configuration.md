---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-05-17T12:13
---

# STM-1074 Video event configuration

Date: 2024-03-07 Time: 14:18
Parent:: [[Streamax]]
Friend:: [[2024-03-07]]
JIRA:STM-1074 Video event configuration
[JIRA](https://csojiramixtelematics.atlassian.net/browse/STM-1074)

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

- The html is on the **Seed repo** on the branch: **ui-video-event-config**  
    `https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed`
- I will incorporate Shawn's HTML into our Frangular UI repo for the other devs to call
	- Common Repo
		- Add in the new Action
		- MiX.DeviceIntegration.Common
		- (NA) Config/MR/Feature/STM-1074_VideoEventConfiguration.24.6.ORI
			- VideoEventConfiguration
		- Config/MR/Feature/STM-1074_VideoEventConfiguration.24.6B.ORI
		- Enums.ConfigurationGroupAction.VideoEventConfiguration
		- [PR to DEV (NA)
		- [x] [PR to INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/99556) ✅ 2024-03-11
		- MiX.DeviceIntegration.Common.2024.3.11.1.nuspec
	- Need BE config group action item
		- Video event configuration
		- eg. UploadFirmware
			- Config/MR/Feature/STM-1074_VideoEventConfiguration.24.6.ORI
			- ConfigurationGroupsModule
				- private string _videoEventConfigurationAction = ConfigEnums.ConfigurationGroupAction.VideoEventConfiguration.GetDescription();
				- 
		- [x] PR to DEV ✅ 2024-03-14
		- [ ] PR to INT
	- Need OLD UI with iFrame pointing to new UI
		- video-event-configuration
		- VideoEventConfiguration
		- Config/MR/Feature/STM-1074_VideoEventConfiguration.24.6.ORI
		- angularNextVideoEventConfigUrl > angularNextConfigUrl
		- [x] PR to DEV ✅ 2024-03-14
		- [ ] PR to INT
	- Need NEW UI with Shawn's HTML
		- video-event-configuration
		- [PR into INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/99384)
		- [PR into DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/99385) 

- PDF:  [[STM-1074 More in-depth Steps to pull Shawn's wireframe in]]

## Shown as Temp implementation

![[STM-1074 Video event configuration New Action.png|300]]
![[STM-1074 Video event configuration Called Frangular Page.png|600]]


## Handover

- [[STM-1074 Handover to Pallavi]]
- The PR had been updated with DEV
- [ ] Roll back DEV part before uploading to INT
## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...


## TEST

- [MiX Telematics - Video event configuration](http://localhost/MiXFleet.UI/#/config-admin/video-event-configuration?id=4631052128945276764)
http://localhost/MiXFleet.UI/#/config-admin/video-event-configuration?id=4631052128945276764

## Links

[[Frangular Getting Started]]
[[STM-1074 Handover to Pallavi]]






var angularNextConfigUrl = "http://localhost:5001";


## TESTING

### Currently the FR-API hits the point but doesnt return values, I will figure this out (the authToken, orgId, groupIds are still hardcoded)

#### Setup

- [library].[GetLibraryEventsDetail]
	- added temporarily to INT DB
	- by running the stored proc against INT, without checking it in
- template.GetConfigurationGroupDetails

#### Test Values

71615d25-e3e9-4b55-b356-e6108540edfa
ConfigGroupId
7270785342402232596
Groupid
-4493495256567590976

## Questions

- [ ] When should the menu item be available?