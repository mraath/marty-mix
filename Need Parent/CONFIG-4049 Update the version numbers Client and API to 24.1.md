---
created: 2023-11-14T12:53
updated: 2023-11-14T19:10
---
JIRA:CONFIG-4049

Jira: [CONFIG-4049 Update Nuget Versions to 24.1 - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-4049) Update Nuget Versions to 24.1 - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-4049)

## Branch

- Config/MR/Ver/24.1
- CONFIG-4049: Upgrade Version to 24.1

## Steps

Update the version numbers on int for:
- [x] MiX.DeviceIntegration.Core ✅ 2023-11-14
	- [Pull request 94400: CONFIG-4049: Upgrade Version to 24.1 - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/94400)
	- MiX.DeviceIntegration.Common.2024.1.20231114.1
- [x] MiX.DeviceConfig ✅ 2023-11-14
	- [Pull request 94401: CONFIG-4049: Upgrade Version to 24.1 - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/94401)
	- MiX.ConfigInternal.Api.Client.2024.1.20231114.1

## Once built - Consume in API and BE

Once done:
- [x] API ✅ 2023-11-14
	- [x] MiX.DeviceIntegration.Common ✅ 2023-11-14
	- [x] MiX.DeviceIntegration.Core ✅ 2023-11-14
	- [x] MiX.DeviceConfig.Api.Client ✅ 2023-11-14
	- [x] ?NA!  MiX.ConfigInternal.Api.Client ✅ 2023-11-14
	- [x] [Pull request 94410: CONFIG-4049: Upgrade Nuget Version to 24.1 - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/94410) ✅ 2023-11-14
- [x] BE ✅ 2023-11-14
	- [x] MiX.DeviceIntegration.Common ✅ 2023-11-14
	- [x] ?NA! MiX.DeviceIntegration.Core ✅ 2023-11-14
	- [x] MiX.DeviceConfig.Api.Client ✅ 2023-11-14
	- [x] MiX.ConfigInternal.Api.Client ✅ 2023-11-14
	- [x] [Pull request 94424: CONFIG-4049: Upgrade Version to 24.1 - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/94424) ✅ 2023-11-14
