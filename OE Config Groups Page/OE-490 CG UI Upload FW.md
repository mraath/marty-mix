---
created: 2023-03-27T07:35
updated: 2024-10-25T08:55
status: busy
comment: 
priority: 1
---

# OE-490 UI Upload FW

Date: 2024-09-09 Time: 11:46
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-09-09]]
JIRA:OE-490 UI Upload FW
[[OE-490] [UI] Upload firmware - #4.3 - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/OE-490)

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

> upload.*firmware|update.*firmware

- Upload FW to all assets in selected config groups that are **not running the selected preferred FW** version 
	- (ensure you ignore assets that are on the version and don’t reload)  
- [x] When selecting “Upload FW” open the Upload FW modal ✅ 2024-09-10
- [x] Green header: Upload firmware ✅ 2024-09-10

uploadConfigGroupFWModalShow
uploadConfigGroupFWModalClose
uploadConfigGroupFW
module.uploadConfigGroupsFirmware??

- [x] Text: Are you sure you want to upload Firmware to x config groups? ✅ 2024-09-10
- [x] In the bottom right corner is a ✅ 2024-09-10
	- [x] grey Cancel and ✅ 2024-09-10
	- [x] green Upload button ✅ 2024-09-10
- [x] When the user selects cancel then close the modal and don’t submit anything ✅ 2024-09-10
- [x] When the user selects Upload then queues the upload ✅ 2024-09-17
- [x] Close the modal and display a green toast message on the screen that states: ✅ 2024-09-17
	- [x] Firmware upload request successful ✅ 2024-09-17

Currently, users aren’t able to schedule FW uploads to FMs from the Config groups page  
When a user selects Upload FW and then sends the request to the Scheduler the same would happen if a user requested it from the Scheduler uploads page  
We won’t manage the schedule from config groups but should be able to send the request to the Scheduler system

### Further Information

- This is for the Configuration Groups Panel
- Upload firmware to all selected Config Groups' assets
- This is for all the assets in the config group which meet the FW Version criteria (**less than the latest**)
- For the Config Groups panel, we do a version check and only load the FW to the assets that don't have the version loaded currently. We will either:
    - Get the FW versions for all Selected Assets, to know which may get the upload, we get this from Frangular API as #D, **OR**
    - It could potentially just all happen in the API, but doesn’t influence THIS story.
- The actual upload firmware logic will be in the new Frangular API as # 6.3
## SP 2

### Languaging

- [x] Upload firmware ✅ 2024-09-18
- Moved to [[OE-513 Outstanding DEV]]: Are you sure you want to upload Firmware to x config groups?
- [x] Cancel ✅ 2024-09-18
- [x] Upload ✅ 2024-09-18
- [x] Firmware upload request successful ✅ 2024-09-18

## Branch

> Branch: Config/MR/Feature/OE-490 UI Upload FW.INT




This forms part of the actions dropdown:
![[OE-488 UI Config Compile Actions drop down.png]]

## BE

UploadConfigurationGroupFirmware
Get all mobileUnits
One by one
	IF DIS: DeviceConfigClient.MobileUnitCommands.UpdateMobileUnitFirmware
		**PROXY**: SendCommandToMobileUnit(authToken, groupId, mobileUnitId, (int)CommandIdType.SendFirmware
		**API**: mucs.SendCommand (2k, 4k)
			- fwVersion = await mum.GetPreferredFirmwareVersionForMobileUnit
				- firmwareVersionId = (await GetEffectiveDeviceProperty(orgId, mobileUnitId, logicalDeviceId.Value, Properties.PREFERED_FIRMWARE_VERSION
					- deviceConfigRepo.GetEffectiveMobileUnitDeviceProperty
						- [mobileunit].[MobileUnit_GetEnabledDevicePropertyForAssets]
							- 
				-  fw = await deviceConfigRepo.GetFirmwareVersionById firmwareVersionId
			- muc.FirmwareVersionName = fwVersion.Name
	ELSE: OLD WAY: miXConnectRepository.UpdateFirmware imei, fw.Name
- Make sure to override the asset FW with cg FW
Error:
- String.Format(ConfigConstants.ErrorMessages.ConfigAdmin.FIRMWARE_UPLOAD_NOT_ALL_SETTINGS_SET_CONFIG_GROUP, nUploadAllUnsuccessfull, mobileUnits.Count)

## Preferred vs Display

### Preferred

PREFERED_FIRMWARE_VERSION
    public const long PREFERED_FIRMWARE_VERSION = 4015466679217121645;

### Display

- Asset: 
	- [MobileUnit_GetAllMobileUnitsForConfigurationGroups]
	- PreferedFirmwareVersion BIGINT = 4015466679217121645 (SAME as above)
- CG: 
	- [template].[Template_GetConfigurationGroupsMultiselect]
	- 4015466679217121645


## Object needed

I think we will need this:
assetId
configurationGroupId
fwVersion
imei
mobileDevice

ADD TO: MobileUnitUploadFW
public long ConfigurationGroupId { get; set; }
public string ConfigurationFWVersion { get; set; }

ADD TO: MobileUnitUploadFWCarrier
public string ConfigurationGroupId { get; set; }
public string ConfigurationFWVersion { get; set; }

Fix up:
- [x] MobileUnitUploadFWCarrier ✅ 2024-09-13
- [x] MobileUnitUploadFW ✅ 2024-09-13
- [x] ConfigurationGroupFWCarrier ✅ 2024-09-17



## BRANCH REPOS

- Config/MR/Feature/OE-490_CG_FW_Upload.INT

- [x] Core ✅ 2024-09-12
	- MiX.DeviceIntegration.Common.2024.15.20240912.1
	- MiX.DeviceIntegration.Common.2024.15.20240913.1
	- MiX.DeviceIntegration.Common.2024.9.13.2
	- https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/110663
	- MiX.DeviceIntegration.Common.2024.15.20240916.1
- [x] API ✅ 2024-09-17
	- UploadConfigGroupsFirmware
	- public const string UploadConfigGroupsFirmware = "groupId/{groupId}/config-groups/upload-firmware";
	- [x] Add actual business logic to remove the overwritten FW versions and remove assets with the same FW version ✅ 2024-10-22
		- If so, check if FW Ver is old, only then update (this is NEW logic....)
		- If the Asset FW ver < CG FW then upload
		      Currently on the SendFW, it gets the FW, so I think we will first need to set the Unit's FW and then call the send.... (2k, 4k)
		      HOW? 
			      assetConfigDetails.FirmwareVersion = currentFirmware.newFirmware.versionNumber
			      fwVersion = await mum.GetPreferredFirmwareVersionForMobileUnit
				      **ID:** string firmwareVersionId = (await GetEffectiveDeviceProperty(orgId, mobileUnitId, logicalDeviceId.Value, Properties.PREFERED_FIRMWARE_VERSION).ConfigureAwait(false))?.Value;
						if (!string.IsNullOrEmpty(firmwareVersionId))
								**STR:** fw = await deviceConfigRepo.GetFirmwareVersionById(firmwareVersionId.ToLong()).ConfigureAwait(false);
						[mobileunit].[MobileUnit_GetEnabledDevicePropertyForAssets] ///////// Comes from here
						[mobileunit].[OverridenDeviceProperties]
			      **ValidateFirmwareChangeRequest** (Justus)
			      ? var dis_firmDataTask = man.GetStatesForMobileUnits(disDevices, LogicalDevices.ALL_MOBILE_UNITS, Properties.FIRMWARE_VERSION);
			      Does it go into the **overwritten** table? Then just remove what is in there, after you have the list, then do an upload???????? XXXXXXXX
			      Will be **blacklisted** (as the value is different)
			- Find out how we will know if this is the case
		      PR: xxxxxxxxxx
		      - Upload FW to all assets in selected config groups that are **not running the selected preferred FW** version 
		      - (ensure you ignore assets that are on the version and don’t reload)  
	- [Swagger UI](http://localhost/DynaMiX.DeviceConfig.Services.Api/swagger/ui/index#!/MobileUnit/MobileUnit_UploadConfigGroupsFirmware)
	- [Pull request 110642: OE-490: Added the controller to upload CG FW, for now it does it as it used to. In future we will add the PO logic once they are ready for us. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/110642)
- [x] Client ✅ 2024-09-17
	- Common
	- [Pull request 110645: OE-490: Added the CG FW Upload method to the client. Upgraded nuget. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/110645)
	- MiX.ConfigInternal.Api.Client.2024.15.20240916.1
	- [Pull requests - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=Config/MR/Feature/OE-490_CG_FW_Upload.INT&targetRef=integration&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679)
	- ConfigInternalClient.MobileUnits.UploadConfigGroupsFirmware
	- MiX.ConfigInternal.Api.Client.2024.15.20240916.1
- [x] FR API ✅ 2024-09-17
	- UploadConfigurationGroupsFirmware
	- [Pull request 110733: OE-490: Added controller to upload CG FW. Returning as hypermedia item. Nuget upgrade. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/110733)
- [x] FR UI ✅ 2024-09-17
	- uploadConfigurationGroupsFirmware > uploadConfigGroupsFirmware
	- ConfigurationGroupFWCarrier
	- ConfigurationGroupFWListCarrier
	- [Pull request 110734: OE-490: Added CG FW Upload modal and logic. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/110734)
	- uploadConfigGroupsFirmware
	- [Pull request 110747: OE-490: Issues with uploading. Added logging to check. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/110747)
	- [Pull request 110801: OE-490: FIXED the assets list being sent for CG FW Upload. Console out more info - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/110801)
	- 

### TEST

```txt
-7094567047859310012
[1415760817642536960,1086004667345240064]
{ "ids": "1415760817642536960,1086004667345240064" }

http://localhost/DynaMiX.DeviceConfig.Services.Api
```

- UI
```json
[
	{
		"assetId": "-6001402197670163376",
		"imei": "358014092582732",
		"mobileDevice": "MiX2000",
		"fwVersion": "4.8.57",
		"configurationGroupId": "111111111111",
		"configurationFWVersion": "4.8.57"
	},
	{
		"assetId": "1557797963201785856",
		"imei": "869595060637427",
		"mobileDevice": "MiX2000",
		"fwVersion": "4.8.57",
		"configurationGroupId": "22222222222",
		"configurationFWVersion": "4.8.57"
	}
]
```

- API
```json
[
	{
		"AssetId": -6001402197670163376,
		"IMEI": "358014092582732",
		"MobileDevice": "MiX2000",
		"FWVersion": "4.8.57",
		"ConfigurationGroupId": 111111111111,
		"ConfigurationFWVersion": "4.8.57"
	},
	{
		"AssetId": 1557797963201785856,
		"IMEI": "869595060637427",
		"MobileDevice": "MiX2000",
		"FWVersion": "4.8.57",
		"ConfigurationGroupId": 22222222222,
		"ConfigurationFWVersion": "4.8.57"
	}
]
```

## Errors

```json
CorrelationId:1572635400681263104|/api/groupId/-7094567047859310012/config-groups/upload-firmware|09/17/2024 05:50:09|Error:MiX.Core.Clients.HttpRetries+HttpInvalidRequestException: Response status code does not indicate success: 500 ({"ErrorMessage":"An item with the same key has already been added.","StackTrace":" at System.ThrowHelper.ThrowArgumentException(ExceptionResource resource)\r\n at System.Collections.Generic.Dictionary`2.Insert(TKey key, TValue value, Boolean add)\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.AreMobileUnitsSupported(String authToken, Int64 groupId, List`1 mobileUnitIds, Nullable`1 supportedCommand) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 533\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.<UploadMobileUnitsFirmware>d__269.MoveNext() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitManager.cs:line 6466\r\n--- End of stack trace from previous location where exception was thrown ---\r\n at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\r\n at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.<UploadConfigGroupsFirmware>d__270.MoveNext() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitManager.cs:line 6510\r\n--- End of stack trace from previous location where exception was thrown ---\r\n at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\r\n at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitController.<>c__DisplayClass37_0.<<UploadConfigGroupsFirmware>b__0>d.MoveNext() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Services.API\\Controllers\\MobileUnitLevel\\MobileUnitController.cs:line 801\r\n--- End of stack trace from previous location where exception was thrown ---\r\n at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\r\n at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n at MiX.DeviceIntegration.Core.Controllers.ControllerBase.<HandledResponseAsync>d__3`1.MoveNext() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 0","ExceptionType":"System.ArgumentException"}). at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExitRetryAsync(CancellationToken cancellationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExecuteActionAsync[T](Func`1 func, CancellationToken cancellationToken, Action`1 validateResult, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.GetAsync[T](Func`1 requestFunc, CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.GetAsync[T](Func`1 requestFunc) at MiX.ConfigInternal.Api.Client.Repositories.InternalMobileUnitRepository.UploadConfigGroupsFirmware(String authToken, Int64 groupId, List`1 assets, Nullable`1 correlationId) at MiX.Config.Frangular.Logic.ConfigurationGroupManager.ConfigurationGroupManager.UploadConfigGroupsFirmware(String authToken, Int64 groupIdL, List`1 assets, Nullable`1 correlationId) in /home/vsts/work/1/s/MiX.Config.Frangular.Logic/ConfigurationGroupManager/ConfigurationGroupManager.cs:line 91 at MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.UploadConfigGroupsFirmware(String groupId, ConfigurationGroupUploadFWListCarrier assets) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:line 263 at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:line 119 at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)
```

## After PO Meeting

 I asked previously about the business logic needed here. Previously it would just run the upload FW logic for each asset in the config group, based off of the asset's settings, however, in this story it want some other logic. I then asked if we should just remove the asset's overwritten preferred FW Version in order for the CG FW version to be selected. (Just dont reload the same version, ignore flagged vehicles, compare to FW field...)
 - [x] if FW Field == preferred FW version... ignore ✅ 2024-10-22
	 - Have to send this back with both stored procs
	 - Then added into common and DTOs
	 - Also in conversion
	 - Also in UI
	 - Then compare and remove from SENT list where the same

## Changed two word(s)

- [Pull request 113457: OE-490: Changed two values, asset(s) and group(s) - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/113457)

## Links

- Languaging: Asset Search: [MiX Telematics - Data centre administration](https://integration.mixtelematics.com/#/operations/data-centre-administration/asset-search)
- 