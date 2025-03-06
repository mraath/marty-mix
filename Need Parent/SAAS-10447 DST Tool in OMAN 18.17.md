---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-11-19T12:58
---

# SAAS-10447 DST Tool in OMAN 18.17

Date: 2024-09-12 Time: 14:04
Parent:: [[Command 45]]
Friend:: [[2024-09-12]]
JIRA:SAAS-10447 DST Tool in OMAN 18.17
[SAAS-10447 Time Adjustment tool in OMAN - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SAAS-10447)

- Oman servers: [[Oman]]

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

## Shorter Description

![[Command 45 18.17 Oman Tool.png]]


## Russell chat

Last ran 2020

![[SAAS-10447 DST Tool in OMAN 18.17.png]]

Command is being sent though

![[SAAS-10447 DST Tool in OMAN 18.17 Command messages being sent.png]]


## Looking for the API

- https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/{orgId}/null/null
	- format: /sendcommand/{orgld}/{assetId}/{typeId}
	- eg. assetId only: https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/null/2364975042774694384/null
- https://integration.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api
	- eg.: https://integration.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/2364975042774694384/null/null
- http://config.dev.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api

## Log

- L:/WebServices/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log


## Herbie

- Herbie asked if we can find the FMTimeAdjuster.API on any production environment, then copy the binaries and adjust the config
- As far as I know it is not found anywhere
	- Def not on INT
	- DEV?
		- http://config.dev.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/null/-5241900497727550185/null
		- na
	- UAT?
	- UK?
		- https://uk.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/-526653425951115306%20/981983764404281344/null
		- na
	- US?
		- na
	- AU?
		- na
- As I though there was a fix for this tool:
	- Config/MR/Bug/SR-8111_FmTimeAdjusterFix_20.11.PROD
- .Net Framework issues to build the basic one:
	- [Fixing .NET Framework 4.5.2 Mismatch in C# Project - Claude](https://claude.ai/chat/70a42eb2-d58c-4d0f-ab01-6c5cafba1dc7)


## Martin chat

Sal daar nie iets op die Q drive wees onder die ou releases nie? Q:\Devel;opment\Release & Deployment\Heartbeat\XXversion?

OMN Dynamix API servers
![[SAAS-10447 DST Tool in OMAN 18.17-1.png]]
- HSOMNIIS18,19
- DynaMiX.DeviceConfig.FMTimeAdjuster.Api

## Result HSOMNIIS18

If I try to browse this I get the following error:

![[SAAS-10447 DST Tool in OMAN 18.17 Result IIS18.png]]

If I then copy the tool to this server and try to run it, I get this error:

![[SAAS-10447 DST Tool in OMAN 18.17 dot Net Needed.png|400]]

## Idea for service tool to do this manually

- [ ] Should we implement this?

![[SAAS-10447 DST Tool in OMAN 18.17 ORG Skip.png]]

![[SAAS-10447 DST Tool in OMAN 18.17 Assets skip.png]]

## Basic PR

- Not yet tested
- Had .Net framework issues
- [ ] [Pull requests - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Config/MR/Feature/SAAS-10447_DST_Tool_OMAN.18.17&targetRef=Release/18.17&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0)
