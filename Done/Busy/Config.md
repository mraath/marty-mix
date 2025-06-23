---
created: 2022-07-15T16:27
updated: 2025-06-23T09:40
---

## New Team Members

- Setup: [[DynaMiX-EnvironmentSetup-031022-1311-12.pdf]]
- Nicole [videos](https://mixtelematics-my.sharepoint.com/personal/zeshan_khan_mixtelematics_com/_layouts/15/stream.aspx?id=%2Fpersonal%2Fzeshan%5Fkhan%5Fmixtelematics%5Fcom%2FDocuments%2FRecordings%2FConfig%20Admin%20and%20DynaMiX%20Overview%2D20220209%5F133450%2DMeeting%20Recording%2Emp4&ga=1&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E08912a44%2D4871%2D486b%2D8f11%2Da36244108db7)
- Zonika walking them through Hi-Level concepts.
- VPN (docx in folder)
	- [Forticlient](https://www.fortinet.com/support/product-downloads#vpn): 
	- ![[Config Modal Setup.png|400]]
	- Logged a ticket
- AZURE Access: Zonika/Jacques
- [[Maybe MAC things to install for new people]]
- High level:
	- FE > BE > Client > API > Repo (Asset DB, Deviceconfig DB, DP DB)
	- FE > FR UI > FR API > Client > API > Repo (Deviceconfig, DP)
	- ![[HighLevelRepos.excalidraw.png|400]]
- DOC x for Time Tracking in Jira



## Related

[[Operations Tools]]

## High level

Our [[Team]] is mostly involved in:
- Setting Device Configuration
- Reading Configuration
- Reading Events, etc
- [Ingestion Graph](https://lucid.app/lucidchart/a4d1f22c-0658-47a6-ae77-690b9fbd63f5/edit?viewport_loc=-2009%2C-741%2C7114%2C3468%2C0_0&invitationId=inv_90396901-5ba6-4538-b587-53419fb016e7) (Zeshan)
- 

## Handy Stored Procs

[[Paul Stored Proc to see configuration for mobileunit]]

## Image overview WIP

![[Config Overview WIP.excalidraw]]

## Production Deployment

### UAT

- Backend devices 
	- eg. BUILD Pipeline
		- [Pipelines - Run 23.14_2023.10.05.1 logs (azure.com)](https://dev.azure.com/MiXTelematics/Common/_build/results?buildId=286386&view=logs&j=fd490c07-0b22-5182-fac9-6d67fe1e939b&t=2b63c4a0-b19b-56f0-8782-52ea6d0a00d6)
	- eg. Release for Morne
		- [PROD_DynaMiX.Backend_Devices - PROD_DynaMiX.Backend_Devices_23.14_2023.10.05.1_1 - Pipelines (azure.com)](https://dev.azure.com/MiXTelematics/Common/_releaseProgress?_a=release-pipeline-progress&releaseId=41399)
- [[DynaMiX.DeviceConfig]] API
	- eg. BUILD Pipeline
		- [Pipelines - Run 23.14_2023.10.05.1 logs (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build/results?buildId=286387&view=logs&j=fd490c07-0b22-5182-fac9-6d67fe1e939b&t=f3a1fb01-64b7-5972-1fe4-c75100d5d4bf)
	- eg. Release for Morne
		- [PROD-Config.API - PROD-Config.API_23.14_2023.10.05.1_1 - Pipelines (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_releaseProgress?_a=release-pipeline-progress&releaseId=32035)

### PROD

- Usually a timeschedule is put out and then it is assigned to a member
[]()

## New code

1. Current Api Url (INT): [http://dsintiis09/](http://dsintiis09/)
2. New Api Url (INT): [http://ecs-api.config.int.priv/swagger/index.html](http://ecs-api.config.int.priv/swagger/index.html)

[[New Config API]]

eg. old API > new API PR: [Pull request 113172: CONFIG-4348: Merging new code from Existing Api - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/113172)


## Team SR Issues

Herewith a link to the SRs and Bugs I could find ⁠
![Smile](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/20_f.png?v=v82)
I THINK grab from the top...
- [Team Issues](https://csojiramixtelematics.atlassian.net/issues/?filter=12814)

Process of testing and workflow

[[Team workflow progress testing]]

## Sprint Report

- [Team Config - Agile Board - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/jira/software/c/projects/CONFIG/boards/100/reports/sprint-retrospective?sprint=3314)

## Deployment Rotation

- [Deployment Rotation Config](https://teams.microsoft.com/l/entity/0d820ecd-def2-4297-adad-78056cde7c78/_djb2_msteams_prefix_987693413?context=%7B%22channelId%22%3A%2219%3Ab5c45f4bc39c4bdfaf82ac1bef07f4a0%40thread.skype%22%7D&groupId=8b12a01e-f9e1-4afa-8f3b-14710a475838&tenantId=d19b542a-1500-4712-a713-be8d79882cb5)


![[Copied Rotation]]
## Members

Maybe here is a good place to add you own notes in a separate file:

- [[Marty]]
- 