---
status: closed
date: 2023-05-12
comment: 
priority: 1
---

# MIX3K-89 Missing upgrade firmware button for MiX3000 devices

Date: 2023-05-12 Time: 14:51
Parent:: ==xxxx==
Friend:: [[2023-05-12]]
JIRA:MIX3K-89 Missing upgrade firmware button for MiX3000 devices
[MIX3K-89 Missing upgrade firmware button for MiX3000 devices - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/MIX3K-89)

## Branch

- BE: Config/MR/Bug/MIX3K-89_3K_Missing_Firmware_Upload_23.9_INT
	- Nuget (common - busy & client - next), Code (Local) (DEV)
- Client: Config/MR/Bug/MIX3K-89_3K_Missing_Firmware_Upload_23.9_INT
	- Nuget (common) (Local) (DEV) 
- API: Config/MR/Bug/MIX3K-89_3K_Missing_Firmware_Upload_23.9_INT
	- Nuget (common), Code (Local) (DEV)
	- [x] Push TESTS fix to INT
- Common: Config/MR/Bug/MIX3K-89_3K_Missing_Firmware_Upload_23.9_INT
	- Code (Local) (DEV)

## PRs to DEV

- MIX3K-89: Added logic missed for the MiX3000.
- Common: Nuget. Core. DEV: MiX.DeviceIntegration.Common.2023.5.17.2-_beta_
- Client: MiX.DeviceConfig.Api.Client.2023.9.20230518.1-_beta_.nupkg

## PRs to INT

- MIX3K-89 is being deployed to INT with many moving parts.
- Herewith the first of about 4 to come.
- Common PR: [Pull request 84191: MIX3K-89: Added logic missed for the MiX3000. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/84191)
	- MiX.DeviceIntegration.Common.2023.9.20230523.1
- Client PR: [Pull request 84193: MIX3K-89: Upgraded Common to the latest Nuget. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/84193)
	- TMP Branch: Config/MR/Bug/MIX3K-89_3K_Missing_Firmware_Upload_23.9_INT_NA
	- MiX.DeviceConfig.Api.Client.2023.9.20230523.1
- API PR: [Pull request 84194: MIX3K-89: Merged into INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/84194)
	- Branch: Config/MR/Bug/MIX3K-89_3K_Missing_Firmware_Upload_23.9_INT
	- Pull in Changes: Done
	- Pull in Common: Done
	- Pull in Client: Done
- BE PR: [Pull request 84199: MIX3K-89: Merged to INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/84199)
	- Branch: Config/MR/Bug/MIX3K-89_3K_Missing_Firmware_Upload_INT_NA
	- Pull in Changes: Code
	- Pull in Common: 
	- Pull in Client: 

## Next Steps

- Common: MiX.DeviceIntegration.Common.2023.9.20230515.4-alpha.nupkg (Local), need DEV then INT
	- Local: [Pipelines - Run MIX3K-89_3K_Missing_Firmware_Upload_23.9_INT_2023.05.15.4 logs (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build/results?buildId=242273&view=logs&j=fd490c07-0b22-5182-fac9-6d67fe1e939b&t=11e7ea89-affe-5194-cdc6-0171c3394706)
- API: Pull common local, then DEV then INT
	- DEV: [Pull request 84000: MIX3K-89: Merge to DEV. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/84000)
- Client: Pull common local, then DEV then INT
	- DEV: [Pull request 84001: MIX3K-89: Merged to DEV. NUGET. Common. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/84001)
- BE: Pull Client Local, then DEV then INT

## Comments

- [x] I have added the logic. Just finalising a few things before pushing it to DEV for testing.

## Description

- ![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Button Missing.png]]
- Search for "Upload firmware"
	- carrier.Actions.Add(_uploadFirmwareAction);
	- This is only added for 4k, 6k, 2k
	- Need to add this for 3k

## Findings

- Configuration Group
	- confgGroupCapabilities
	- DeviceConfigClient.ConfigurationGroups.GetConfigurationGroupCapabilitiesForConfigurationGroupsList
	- config-group-capabilities
	- [x] See if this includes 3k, else add it
	- Then copy logic for other group
- Asset
	- capabilities
	- DeviceConfigClient.MobileUnits.GetMobileUnitCapabilitiesForConfigurationGroupsAssetList
	- configuration-groups-asset-list-capabilities
	- [x] See if this includes 3k, else add it
	- Then copy logic for other group_asset

## Zonika double check

ID: 2661058860026395155 (Base Mesa?)

OK, the UI is now performing as expected...

### UI Results

Asset List

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Asset List.png]]

Configuration Group

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Configuration Group.png]]

### Code for this:

#### Configuration Groups

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Code Config Groups.png]]

#### Asset List Logic

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Asset List Code.png]]

#### Other logic

Some logic I found which I had a question about, but I will leave it as is:
![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices BaseMesa Question.png]]


## Marvin error when clicking on Firmware Upgrade

Error: 1395859729885569024

### Original Exception

```log
EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
<ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RequestId>1395859729885569024</RequestId>
  <AuthToken>2d4cf5e8-da1c-46cb-850f-75b56f550bb6</AuthToken>
  <AccountId>-9033922775801889309</AccountId>
  <RequestJson>{"AssetIds":null}</RequestJson>
  <RequestUrl>POST http://config.dev.mixtelematics.com:80/DynaMiX.API/config-admin/7018027399675734769/config_groups/asset/1395801807940722688/firmware</RequestUrl>
</ApiRequestInfo>
	Exception Type: System.Exception
EXCEPTION! The limit for retries has been exceeded.
	Exception Type: MiX.Core.Retries.RetryLimitExceededException
	Stack trace    at MiX.Core.Retries.RetryStrategy.<ExecuteActionAsync>d__31`1.MoveNext() in D:\b\1\_work\1046\s\MiX.Core\Retries\RetryStrategy.cs:line 368
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.ValidateEnd(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at MiX.Core.Clients.HttpRetries.<GetAsync>d__13`1.MoveNext() in D:\b\1\_work\1046\s\MiX.Core\Clients\HttpRetries.cs:line 125
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.ValidateEnd(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at MiX.Core.Clients.HttpRetries.<Get>d__10`1.MoveNext() in D:\b\1\_work\1046\s\MiX.Core\Clients\HttpRetries.cs:line 87
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.ValidateEnd(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitCommandsRepository.<SendCommandToMobileUnit>d__3.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.ValidateEnd(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitCommandsRepository.<UpdateMobileUnitFirmware>d__10.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.ValidateEnd(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at DynaMiX.Logic.AsyncResultExtension.ToSync[T](Task`1 task, Boolean configureAwait) in D:\b\1\_work\928\s\Logic\DynaMiX.Logic\AsyncResultExtension.cs:line 13
   at DynaMiX.Logic.ConfigAdmin.TemplateLevel.ConfigurationGroupManager.UploadAssetFirmware(String authToken, Int64 orgId, Int64 assetId) in D:\b\1\_work\928\s\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs:line 398
   at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupActionsModule.UploadAssetFirmware(String authToken, Int64 orgId, Int64 assetId) in D:\b\1\_work\928\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupActionsModule.cs:line 227
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__1(Object args) in D:\b\1\_work\928\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in D:\b\1\_work\928\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 282
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\b\1\_work\928\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 191
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\b\1\_work\928\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 121
	EXCEPTION! Response status code does not indicate success: 500 ({"ErrorMessage":"Specified argument was out of the range of valid values.\r\nParameter name: Not all required logical devices connected","StackTrace":"   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.ValidateRequiredLogicalDevices(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MobileUnitCommandSender.cs:line 227\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.ValidateCommand(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MobileUnitCommandSender.cs:line 33\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(CurrentUserSession session, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, String value, Dictionary`2 paramDictionary) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 182\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, Dictionary`2 paramDictionary) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 74\r\n   at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitCommandsController.<>c__DisplayClass0_0.<SendCommandToMobileUnit>b__0() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Services.API\\Controllers\\MobileUnitLevel\\MobileUnitCommandsController.cs:line 48\r\n   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 46","ExceptionType":"System.ArgumentOutOfRangeException"}).
	Exception Type: MiX.Core.Clients.HttpRetries+HttpInvalidRequestException
	Stack trace    at MiX.Core.Clients.HttpRetries.<EnsureSuccessStatusCode>d__25.MoveNext() in D:\b\1\_work\1046\s\MiX.Core\Clients\HttpRetries.cs:line 316
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.ValidateEnd(Task task)
   at MiX.Core.Clients.HttpRetries.<ExecuteHttp>d__24`1.MoveNext() in D:\b\1\_work\1046\s\MiX.Core\Clients\HttpRetries.cs:line 304
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.ValidateEnd(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at MiX.Core.Retries.RetryStrategy.<ExecuteActionAsync>d__31`1.MoveNext() in D:\b\1\_work\1046\s\MiX.Core\Retries\RetryStrategy.cs:line 359
```



### Summary of Exception

I short, the log showed this under that error message.

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Logical not connected.png]]

When I look at this asset, it has nothing connected on GSM, so can't send a command:

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Nothing Connected.png]]

I added the GSM module and it then worked.

I also tried this on one of my devices. It also didn't work.
I then saw it had no unique id. Once added it worked.

For both of these it gave the message "Firmware Upload requested" with no error.

### Analysis on my device

Some information is not filled in or devices not connected, as per the error above.
I have tried on mine, got a similar issue.
I will continue investigation.
Mine needed:
- Unique Identifier
- When I tried again, it gave me a message "Firmware Upload requested" with no error

My connected devices on the unit that works:

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Working Device with Connections.png]]

I think it is data related.
