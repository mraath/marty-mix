---
created: 2023-10-24T08:17
updated: 2023-11-14T12:54
---
JIRA:CONFIG-4015

Update the version numbers on int for:
- [x] MiX.DeviceConfig and ✅ 2023-10-24
- [x] MiX.DeviceIntegration.Core ✅ 2023-10-24

Once done:
- [x] Build the latest versions and ✅ 2023-10-27
	- MiX.DeviceConfig.Api.Client.23.17.0                             (BE, API)  
	- ?  (MiX.ConfigInternal.Api.Client.2023.17.20231026.1) (BE, API NA)
	- MiX.DeviceIntegration.Common.2023.17.20231026.1  (BE, API)
	- ? MiX.DeviceIntegration.Core       Safet                                 (BE NA, API)
- [x] update the Config API and ✅ 2023-10-31
	- [x] Config/MR/Nuget_Ver_INT_23.17_ORI ✅ 2023-10-26
	- [x] PR: [Pull request 93462: Upgraded nugets - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/93462) ✅ 2023-10-27
	- [x] Deploy ✅ 2023-10-31
- [x] Backend with the new versions ✅ 2023-10-31
	- [x] Config/MR/Nuget_Ver_INT_23.17_ORI ✅ 2023-10-26
	- [x] [Pull request 93323: Upgraded Nuget Versions - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/93323) ✅ 2023-10-26
	- [x] Deploy ✅ 2023-10-31


## PRs

Upgraded the version to 23.17
Core: [Pull request 93148: Upgraded the version to 23.17 - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/93148)
Client: [Pull request 93149: Upgraded to ver 23.17 - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/93149)
