---
created: 2023-03-27T07:35
updated: 2024-10-22T14:10
status: busy
comment: 
priority: 1
---
# OE-509 UI Asset Upload FW

Date: 2024-08-28 Time: 13:15
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-08-28]]
JIRA:OE-509 UI Asset Upload FW
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-509)

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

- [x] Upload FW to the selected assets that are not running the selected preferred FW version (ensure you ignore assets that are on the version and don’t reload) ✅ 2024-10-22
- [x] When selecting “Upload FW” open the Upload FW modal ✅ 2024-09-09
- [x] Green header: Upload firmware ✅ 2024-09-10
- [x] Text: Are you sure you want to upload Firmware to {{xxxxx}} assets? ✅ 2024-09-10
- [x] In the bottom right corner is a grey Cancel and green Upload button ✅ 2024-09-09
- [x] When the user selects cancel then close the modal and don’t submit anything ✅ 2024-09-09
- [x] When the user selects Upload then queues the upload ✅ 2024-09-09
- [x] Close the modal and display a green toast message on the screen that states: ✅ 2024-09-10
	- [x] Firmware upload request successful ✅ 2024-09-10

Currently, users aren’t able to schedule FW uploads to FMs from the Config groups page  
When a user selects Upload FW and then send the request to the Scheduler the same would happen if a user requested it from the Scheduler uploads page  
We won’t manage the schedule from config groups but should be able to send the request to the Scheduler system

### Further Information

- This is for the Assets List Panel
- We do a version check and only load the FW to the assets that don't have the version loaded currently. We will either:
       - Get the FW versions for all Selected Assets, to know which may get the upload, we get this from Frangular API as #D, **OR**
    - It could potentially just all happen in the API, but doesn’t influence THIS story.
  - The actual upload firmware logic will be in the new Frangular API as # 6.3

This forms part of the Assets Lists Actions dropdown:
![[OE-507 UI Asset Config Compile Actions.png]]

## Currently how it works

### FE

![[OE-509 UI Asset Upload FW Are you sure.png]]



```txt
https://integration.mixtelematics.com/DynaMiX.API/config-admin/-7094567047859310012/config_groups/asset/1415760817642536960/firmware
Request Method:
POST

Payload: {AssetIds: null}

ERROR?????
```

### Languaging

- [x] LANGUAGE: ✅ 2024-09-10
	- [x] Upload firmware ✅ 2024-09-10
	- MOVED to [[OE-513 Outstanding DEV]]: Are you sure you want to upload Firmware to {{xxxxx}} assets?
	- [x] Cancel ✅ 2024-09-10
	- [x] Upload ✅ 2024-09-10
- [x] Toast Notification ✅ 2024-09-10
	- [x] Firmware upload request successful ✅ 2024-09-10
- [x] Unable to upload firmware ✅ 2024-09-10
	- [x] An asset was unable to upload firmware ✅ 2024-09-10
	- Moved to [[OE-513 Outstanding DEV]]: {{notUploadedFWAssets.length}} of the selected assets were unable to upload firmware

### More info

.UploadAssetFirmware
.uploadAssetFirmware

> NEW methods and booleans
	uploadFWModalShow
	uploadFWModalClose
	uploadFW
	uploadFWErrorModalShow
	uploadFWErrorModalClose
	notUploadedFWAssets
	uploadAssetsFW

```pot

msgid "Firmware upload"
msgstr ""

msgid "Are you sure you want to upload firmware?"
msgstr ""

msgid "Firmware upload requested for asset(s)"
msgstr ""

msgid "Unable to upload firmware"
msgstr ""

msgid "An asset was unable to upload firmware"
msgstr ""

msgid "{{notUploadedFWAssets.length}} of the selected assets were unable to upload firmware"
msgstr ""

```
	
### BE

```c#
public static readonly RouteDefinition UPLOAD_ASSET_FIRMWARE = new RouteDefinition(APISettings.Current.ApiBaseUrl, APISettings.Current.ConfigAdminBaseUrl, "/{orgId}/config_groups/asset/{id}/firmware", Core.Http.Constants.HTTPVerbs.POST);

//Method
UploadAssetFirmware(string authToken, long orgId, long assetId)
configurationGroupManager.UploadAssetFirmware(authToken, orgId, assetId)

//Manager: ConfigurationGroupManager
//NEW WAY
var disSupportedUnits = DeviceConfigClient.MobileUnitCommands.AreMobileUnitsSupportedForUpdateFirmwareCommand(authToken, orgId, new List<long> { assetId }).ToSync();
bool isAvailableInDis = false;
if (disSupportedUnits.TryGetValue(assetId, out isAvailableInDis) && isAvailableInDis) // consume new commands proxy
{
	DeviceConfigClient.MobileUnitCommands.UpdateMobileUnitFirmware(authToken, orgId, assetId).ToSync();
}
else // old way of upload firmware
{
	UploadAssetFirmwareOldWay(authToken, orgId, assetId);
}

//OLD WAY
IMobileUnitManager mobileUnitManager = DependencyResolver.GetInstance<IMobileUnitManager>(_context);
IMobileDevice mobileDevice = mobileUnitManager.GetResolvedMobileDevice(assetId);
string imei = mobileDevice.UnitIdentifier;
IMiXConnectRepository miXConnectRepository = DependencyResolver.GetInstance<IMiXConnectRepository>(_context);

ILogicalDevice logicalDevice = mobileDevice.AllLogicalDevices.FirstOrDefault(x => x.DefinitionDeviceId == ConfigConstants.LogicalDevices.MIX2XXX_MOBILE_DEVICE_RANGE);
if (logicalDevice == null)
	logicalDevice = mobileDevice.AllLogicalDevices.FirstOrDefault(x => x.DefinitionDeviceId == ConfigConstants.LogicalDevices.MIX4000);

string firmwareVersionId = logicalDevice.Properties.First(x => x.DefinitionPropertyId == ConfigConstants.Properties.PREFERED_FIRMWARE_VERSION).Value;

if (string.IsNullOrEmpty(firmwareVersionId))
	throw new Exception(ConfigConstants.ErrorMessages.ConfigAdmin.FIRMWARE_UPLOAD_NOT_ALL_SETTINGS_SET_SINGLE_ASSET);

FirmwareVersion fw = ConfigAdminRepository.GetFirmwareVersionById(firmwareVersionId.ToLong());
if (string.IsNullOrEmpty(fw.Name))
{
	throw new Exception(ConfigConstants.ErrorMessages.ConfigAdmin.FIRMWARE_UPLOAD_NOT_ALL_SETTINGS_SET_SINGLE_ASSET);
}
else
{
	miXConnectRepository.UpdateFirmware(imei, fw.Name);
}
```

### Client PROXY

```c#
UpdateMobileUnitFirmware(string authToken, long groupId, long mobileUnitId)
SendCommandToMobileUnit(authToken, groupId, mobileUnitId, (int)CommandIdType.SendFirmware, null, null, null, null)
JsonResponse res = DoPost(MobileUnitCommandsControllerRoutes.SendCommandToMobileUnit, null,
		new RequestParameter("preferredTransport", preferredTransport.HasValue ? preferredTransport.ToString() : "", RequestParameter.RequestParameterType.QueryString),
		new RequestParameter("param1", param1.HasValue ? param1.ToString() : "", RequestParameter.RequestParameterType.QueryString),
		new RequestParameter("param2", param2.HasValue ? param2.ToString() : "", RequestParameter.RequestParameterType.QueryString),
		new RequestParameter("param3", param3.HasValue ? param3.ToString() : "", RequestParameter.RequestParameterType.QueryString),
		new RequestParameter("authToken", authToken, RequestParameter.RequestParameterType.QueryString),

		new RequestParameter("groupId", groupId.ToString(), RequestParameter.RequestParameterType.UrlSegment),
		new RequestParameter("mobileUnitId", mobileUnitId.ToString(), RequestParameter.RequestParameterType.UrlSegment),
		new RequestParameter("commandId", commandId.ToString(), RequestParameter.RequestParameterType.UrlSegment)
		);

```

### API

```c#
//SINGLE
public const string SendCommandToMobileUnit = "groupIds/{groupId}/mobile-units/{mobileUnitId}/command/{commandId}";
//Mutiple
public const string SendCommandToMobileUnits2 = "groupIds/{groupId}/command/{commandId}/mobile-units";

return await mucm.SendCommandToMobileUnit(authToken, groupId, mobileUnitId, commandId, preferredTransport, param1, param2, param3).ConfigureAwait(false);

```
## SP 2

### Core

- [x] Simple Carrier class ✅ 2024-09-02
      PR: [Pull request 109514: OE-509: Added simplified carrier to be used with Uploading FW - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/109514)

### API
- [x] Add new FW Upload Method ✅ 2024-08-30
      UploadMobileUnitsFirmware = "groupId/{groupId}/mobile-units/upload-firmware"
      [Swagger UI](http://localhost/DynaMiX.DeviceConfig.Services.Api/swagger/ui/index#!/MobileUnit/MobileUnit_UploadMobileUnitsFirmware)
      MiX.DeviceIntegration.Common.2024.14.20240902.1
      uploadMobileUnitsFirmware
      PR: [Pull request 109593: OE-509: Added the asset upload FW end-point and logic. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/109593)

### TEST API

```txt
-7094567047859310012
[1415760817642536960,1086004667345240064]
{ "ids": "1415760817642536960,1086004667345240064" }

http://localhost/DynaMiX.DeviceConfig.Services.Api

[
	{
		"AssetId": -6001402197670163376,
		"IMEI": "358014092582732",
		"MobileDevice": "MiX2000",
		"FWVersion": "4.8.57"
	},
	{
		"AssetId": 1557797963201785856,
		"IMEI": "869595060637427",
		"MobileDevice": "MiX2000",
		"FWVersion": "4.8.57"
	}
]



```

### ERRORS

```txt
CorrelationId:1567872412014252032|/api/groupId/-7094567047859310012/mobile-units/upload-firmware|09/04/2024 02:23:43|Error:System.NullReferenceException: Object reference not set to an instance of an object. at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExitRetryAsync(CancellationToken cancellationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExecuteActionAsync[T](Func`1 func, CancellationToken cancellationToken, Action`1 validateResult, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.GetAsync[T](Func`1 requestFunc, CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.GetAsync[T](Func`1 requestFunc) at MiX.ConfigInternal.Api.Client.Repositories.InternalMobileUnitRepository.UploadMobileUnitsFirmware(String authToken, Int64 groupId, List`1 assets, Nullable`1 correlationId) at MiX.Config.Frangular.Logic.ConfigurationGroupManager.ConfigurationGroupManager.UploadMobileUnitsFirmware(String authToken, Int64 groupIdL, List`1 assets, Nullable`1 correlationId) in /home/vsts/work/1/s/MiX.Config.Frangular.Logic/ConfigurationGroupManager/ConfigurationGroupManager.cs:line 85 at MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.UploadMobileUnitsFirmware(String groupId, List`1 assets) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:line 220 at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync() --- End of stack trace from previous location --- at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:line 119 at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)

https://mixconfigfrangularapi.mixdevelopment.com/api/groupId/-7094567047859310012/mobile-units/upload-firmware
```

id: string
resultMessage: string
value: boolean

## API issue

https://app.logz.io/#/goto/84427346cd4f850f17e1f6bf504f0581?switchToAccountId=157279
DeviceFamily
Command
SendFirmware
message
MiX.Connect
https://app.logz.io/#/goto/0a1ae57a100bf8cf34f4a027c14aa467?switchToAccountId=157279


THESE FAILED:

-1509415348226618365,963923937065295872,-8798513244981487643,5462472039999562707,1260466398248566784,9041905456165491651

- (-1509415348226618365) MR TZ1
- (963923937065295872) EttienneS Quectel
- (-8798513244981487643) Jono MiX4000 INT 1
- (5462472039999562707) GADIJA - FM REGRESSION (FM) JUNE
- (1260466398248566784) Viviers_M4K_N

THIS SUCCEEDED:

8591433084324666187,9041905456165491651
https://app.logz.io/#/goto/88063769d66aba991b26070a71e29b66?switchToAccountId=157279

### Client
- [x] Add a method to call this new end point ✅ 2024-09-02
      UploadMobileUnitsFirmware
      PR: [Pull request 109516: OE-509: Added the new Upload FW method. Upgraded nuget for the carrier. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/109516)
      MiX.ConfigInternal.Api.Client.2024.14.20240902.1

### FR API
- [x] Consume the new client and call this method: MiX.ConfigInternal.Api.Client.2024.14.20240902.1 ✅ 2024-09-02
- [x] uploadMobileUnitsFirmware ✅ 2024-09-02
- [x] Send this down with Hypermedia ✅ 2024-09-02
      PR: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/109538
      [Pull request 109743: OE-509: Fixed the send and receive carrier. Upgraded nuget for carriers. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/109743)
      

### FR FE
- [x] Add confirmation Modal ✅ 2024-09-03
- [x] Add error Modal ✅ 2024-09-03
- [x] Add functionality to call this FR API method ✅ 2024-09-03
- [x] TEST These ✅ 2024-09-06
- [x] List string FR FE uploadMobileUnitsFirmware ✅ 2024-09-06

## Branch

> Branch: Config/MR/Feature/OE-509_UIAssetUploadFW.INT
> Common: MiX.DeviceIntegration.Common.2024.9.4.1

Ek tel nou die volgende op: OE-495, OE-490. As jy will click.
- [x] Test what config group currently does - send ID or string for FW? ✅ 2024-09-09
      NAME as STRING
- Start with CG upload... do you downgrade if diff from CG? NOPE
- MOVED to [[OE-513 Outstanding DEV]]: CAN Upload FW permissions?

## Post PO answer

 - [x] if FW Field == preferred FW version... ignore ✅ 2024-10-22
	 - Have to send this back with both stored procs
	 - Then added into common and DTOs
	 - Also in conversion
	 - Also in UI
	 - Then compare and remove from SENT list where the same

## Maybe this helps with curent FW

DECLARE @**PREFERED_FIRMWARE_VERSION** BIGINT = **4015466679217121645**;
DECLARE @PREFERED_FIRMWARE_VERSION_NEW_STRING BIGINT = -1146353906259277607;
DECLARE @PREFERED_ROVI_FIRMWARE_VERSION BIGINT = -1736714955260583986;
DECLARE @**FIRMWARE_VERSION** BIGINT = **642299852142387816**;

 where dd.DeviceId = @deviceId 
            AND 
                (dp.PropertyId = @PREFERED_FIRMWARE_VERSION OR
                dp.PropertyId = @PREFERED_FIRMWARE_VERSION_NEW_STRING OR
                dp.PropertyId = @PREFERED_ROVI_FIRMWARE_VERSION OR
                dp.PropertyId = @FIRMWARE_VERSION)
            AND td.IsEnabled = 1;

assetManager.GetMiX2310iAssetDiagnosticInfo
	
DeviceConfigClient.MobileUnits.GetDiagnosticsMobileDeviceDetails
	[state].[MobileUnitState_GetStatesForMobileUnits]
	DP
	
mix4kDetails.firmwareVersion = DeviceConfigClient.DeviceState.GetMobileUnitFirmwareVersion
	FIRMWARE_VERSION


### Look into?

- 3K: https://integration.mixtelematics.com/#/asset/diagnostics/MiX3000?id=1401709835162300416&orgId=-7094567047859310012&device=MiX3000&modal=true
	- Mobile device details
		- Firmware version	5.6.4
- 4K: https://integration.mixtelematics.com/#/asset/diagnostics/MiX4000?id=1086005172591616000&orgId=-7094567047859310012&device=MiX4000&modal=true
	- same
- FM: https://integration.mixtelematics.com/#/asset/diagnostics?id=-4601934880781338916&orgId=-7094567047859310012&device=FM+3707i%2F3717i&modal=true
	- General status information
		- Mobile device driver version	15.8.18.13
- 2K: https://integration.mixtelematics.com/#/asset/diagnostics?id=-6001402197670163376&orgId=-7094567047859310012&device=MiX2000&modal=true
	- Diagnostic info 
		- Firmware version	4.2.5
- [x] PreferredFWVersion (was FWVersion) ✅ 2024-10-22
	- [x] Change UI side ✅ 2024-10-22
- Replaced FWVersion, with installed

## Current Status

- Update Stored Procs
	- [state].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]
	- [state].[MobileUnit_GetUnallocatedAssets]
- COMMON Update
	- [x] Update: ConfigurationGroupMultiselectAssetsList ✅ 2024-10-17
	- [x] Update: ConfigurationGroupMultiselectAssetsListCarrier ✅ 2024-10-17
	- [Pull request 112842: OE-509: Added PreferredFWVersion - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/112842)
	- MiX.DeviceIntegration.Common.2024.16.20241017.1
- API
	- Upgraded Common
	- OE-509: Added PreferredFWVersion carrier convertion. Updated Nuget for Common.
	- [Pull request 112846: OE-509: Added PreferredFWVersion carrier convertion. Updated Nuget for Common. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/112846)
	- TEST SWAGGER
		- da040899-dbe0-4f5a-8df1-a33730a878e7
		- ORg
		- -4493495256567590976
		- Groups
		- [-4366193155933191679,7270785342402232596,-4067179943998429825]
- Client
	- Upgraded common nuget
	- [Pull request 112867: OE-509: Upgraded nuget to include Preferred FW Version - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/112867)
	- MiX.ConfigInternal.Api.Client.2024.16.20241017.1
	- Unit tests ran
- FR API
	- Nuget upgraded: Common, Client
	- [Pull request 112971: OE-509: Added PreferredFWVersion - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/112971)
- FR UI
	- [x] Add: preferredFWVersion ✅ 2024-10-22
		- allowedHiddenColumns
		- columnSettings
		- hiddenColumns
		- [Pull request 113170: OE-509: WIP: Add in preferredFWVersion field - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/113170)
		- 
	- **TEST**: FR API on INT > Swagger > if value for preferredFWVersion.... locally there are
	- SQL: INT
	- API: Local and IIS09
	- FR API: Local.... ????
		- https://mixconfigfrangularapi.mixdevelopment.com/swagger/index.html (INT)
		- ba264d6c-28b8-4022-994c-ab3aa7b96741
		- -4493495256567590976
		- -4366193155933191679,7270785342402232596,-4067179943998429825
	- [x] Move logic for prev FW Version ✅ 2024-10-21
	- [x] Languaging: Preferred FW version ✅ 2024-10-22
	- [x] ENSURE: selectedAssetKeys are updated correctly after deselecting some assets ✅ 2024-10-22
		- [x] ALSO test for config group ✅ 2024-10-22

## Zeshan test

```json
{
    "items": [
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1099108593160499200",
            "legacyVehicleId": "3",
            "assetDescription": "Bench 4000 speed sender",
            "registration": "7550245",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": "0",
            "mobileDevice": "MiX6000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/25 13:47 (AWST)",
            "commsLog": "2021/06/03 15:44 (AWST)",
            "configurationGroupId": "-7668041119015801648",
            "configurationGroupName": "Bench 6000",
            "mobileDeviceTemplateId": "1315677526247399325",
            "mobileDeviceTemplateName": "Bench 6000",
            "eventTemplateId": "-771805114519872957",
            "eventTemplateName": "Bench 6000",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": "4.8.35",
            "preferredFWVersion": null,
            "canScriptLineId": null,
            "canScript": null,
            "speed": "Speed from Speed sender",
            "rpm": "RPM from RPM signal",
            "fuel": null,
            "sp": "Streamax C6D AI",
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1101560659864555520",
            "legacyVehicleId": "4",
            "assetDescription": "Bench 4000 043",
            "registration": "1426043",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": "40000867",
            "mobileDevice": "MiX6000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/25 16:55 (AWST)",
            "commsLog": "2021/02/25 15:51 (AWST)",
            "configurationGroupId": "-7668041119015801648",
            "configurationGroupName": "Bench 6000",
            "mobileDeviceTemplateId": "1315677526247399325",
            "mobileDeviceTemplateName": "Bench 6000",
            "eventTemplateId": "-771805114519872957",
            "eventTemplateName": "Bench 6000",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": "4.8.35",
            "preferredFWVersion": null,
            "canScriptLineId": null,
            "canScript": null,
            "speed": "Speed from Speed sender",
            "rpm": "RPM from RPM signal",
            "fuel": null,
            "sp": "Streamax C6D AI",
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1101991670301691904",
            "legacyVehicleId": "5",
            "assetDescription": "MiX6000 Bench",
            "registration": "352739091778115",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": "61001773",
            "mobileDevice": "MiX6000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/25 16:56 (AWST)",
            "commsLog": "2021/03/04 16:42 (AWST)",
            "configurationGroupId": "-7668041119015801648",
            "configurationGroupName": "Bench 6000",
            "mobileDeviceTemplateId": "1315677526247399325",
            "mobileDeviceTemplateName": "Bench 6000",
            "eventTemplateId": "-771805114519872957",
            "eventTemplateName": "Bench 6000",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": "4.8.38",
            "preferredFWVersion": null,
            "canScriptLineId": null,
            "canScript": null,
            "speed": "Speed from Speed sender",
            "rpm": "RPM from RPM signal",
            "fuel": null,
            "sp": "Streamax C6D AI",
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1129837776359698432",
            "legacyVehicleId": "9",
            "assetDescription": "Oyster v2",
            "registration": "358014098040867",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": null,
            "mobileDevice": "MiX6000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/25 12:36 (AWST)",
            "commsLog": null,
            "configurationGroupId": "-7668041119015801648",
            "configurationGroupName": "Bench 6000",
            "mobileDeviceTemplateId": "1315677526247399325",
            "mobileDeviceTemplateName": "Bench 6000",
            "eventTemplateId": "-771805114519872957",
            "eventTemplateName": "Bench 6000",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": null,
            "preferredFWVersion": null,
            "canScriptLineId": null,
            "canScript": null,
            "speed": "Speed from Speed sender",
            "rpm": "RPM from RPM signal",
            "fuel": null,
            "sp": "Streamax C6D AI",
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1136386905693880320",
            "legacyVehicleId": "10",
            "assetDescription": "Oyster v2 recreate 2",
            "registration": "58014098040867",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": null,
            "mobileDevice": "MiX6000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/25 12:36 (AWST)",
            "commsLog": null,
            "configurationGroupId": "-7668041119015801648",
            "configurationGroupName": "Bench 6000",
            "mobileDeviceTemplateId": "1315677526247399325",
            "mobileDeviceTemplateName": "Bench 6000",
            "eventTemplateId": "-771805114519872957",
            "eventTemplateName": "Bench 6000",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": null,
            "preferredFWVersion": null,
            "canScriptLineId": null,
            "canScript": null,
            "speed": "Speed from Speed sender",
            "rpm": "RPM from RPM signal",
            "fuel": null,
            "sp": "Streamax C6D AI",
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1145028465125216256",
            "legacyVehicleId": "12",
            "assetDescription": "Oyster v2",
            "registration": "358014098117947",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": null,
            "mobileDevice": "MiX6000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/25 12:08 (AWST)",
            "commsLog": null,
            "configurationGroupId": "-7668041119015801648",
            "configurationGroupName": "Bench 6000",
            "mobileDeviceTemplateId": "1315677526247399325",
            "mobileDeviceTemplateName": "Bench 6000",
            "eventTemplateId": "-771805114519872957",
            "eventTemplateName": "Bench 6000",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": null,
            "preferredFWVersion": null,
            "canScriptLineId": null,
            "canScript": null,
            "speed": "Speed from Speed sender",
            "rpm": "RPM from RPM signal",
            "fuel": null,
            "sp": "Streamax C6D AI",
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1215335729996664832",
            "legacyVehicleId": "26",
            "assetDescription": "New FM asset test before imei shows",
            "registration": "23423",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": "40000867",
            "mobileDevice": "MiX6000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/25 12:38 (AWST)",
            "commsLog": null,
            "configurationGroupId": "-7668041119015801648",
            "configurationGroupName": "Bench 6000",
            "mobileDeviceTemplateId": "1315677526247399325",
            "mobileDeviceTemplateName": "Bench 6000",
            "eventTemplateId": "-771805114519872957",
            "eventTemplateName": "Bench 6000",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": "4.8.62",
            "preferredFWVersion": null,
            "canScriptLineId": null,
            "canScript": null,
            "speed": "Speed from Speed sender",
            "rpm": "RPM from RPM signal",
            "fuel": null,
            "sp": "Streamax C6D AI",
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1468673032566779904",
            "legacyVehicleId": "31",
            "assetDescription": "MR U Test FM24K",
            "registration": "MRTF24K",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": null,
            "mobileDevice": "MiX4000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/18 12:41 (AWST)",
            "commsLog": null,
            "configurationGroupId": "-8226461363431857553",
            "configurationGroupName": "Bench 4000 CAN",
            "mobileDeviceTemplateId": "-8953479898605404157",
            "mobileDeviceTemplateName": "Bench 4000 CAN",
            "eventTemplateId": "6964160016889067176",
            "eventTemplateName": "Bench 4000 CAN",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": null,
            "preferredFWVersion": null,
            "canScriptLineId": "401558247868188484",
            "canScript": "CAN: J1939 FMS FEF2 v1.4.0.3",
            "speed": "J1708/CAN - Speed",
            "rpm": "J1708/CAN - RPM",
            "fuel": "J1708/CAN - Fuel",
            "sp": null,
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1488972004638027776",
            "legacyVehicleId": "32",
            "assetDescription": "MR FM",
            "registration": "MRFM1",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": null,
            "mobileDevice": "MiX4000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/18 09:46 (AWST)",
            "commsLog": null,
            "configurationGroupId": "-8226461363431857553",
            "configurationGroupName": "Bench 4000 CAN",
            "mobileDeviceTemplateId": "-8953479898605404157",
            "mobileDeviceTemplateName": "Bench 4000 CAN",
            "eventTemplateId": "6964160016889067176",
            "eventTemplateName": "Bench 4000 CAN",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": null,
            "preferredFWVersion": null,
            "canScriptLineId": "401558247868188484",
            "canScript": "CAN: J1939 FMS FEF2 v1.4.0.3",
            "speed": "J1708/CAN - Speed",
            "rpm": "J1708/CAN - RPM",
            "fuel": "J1708/CAN - Fuel",
            "sp": null,
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1489579564942876672",
            "legacyVehicleId": "37",
            "assetDescription": "MR U FM 4",
            "registration": "MRFM4",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": null,
            "mobileDevice": "MiX4000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/18 12:42 (AWST)",
            "commsLog": "Schedule for VehicleID [37] on transport GPRS enqueued to controller queue. Most recent comms with vehicle: <none>",
            "configurationGroupId": "-8226461363431857553",
            "configurationGroupName": "Bench 4000 CAN",
            "mobileDeviceTemplateId": "-8953479898605404157",
            "mobileDeviceTemplateName": "Bench 4000 CAN",
            "eventTemplateId": "6964160016889067176",
            "eventTemplateName": "Bench 4000 CAN",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": null,
            "preferredFWVersion": null,
            "canScriptLineId": "401558247868188484",
            "canScript": "CAN: J1939 FMS FEF2 v1.4.0.3",
            "speed": "J1708/CAN - Speed",
            "rpm": "J1708/CAN - RPM",
            "fuel": "J1708/CAN - Fuel",
            "sp": null,
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 19,
            "mobileDeviceType": 3,
            "hyperMedia": null
        },
        {
            "alerts": null,
            "flagged": null,
            "assetId": "1547913034322440192",
            "legacyVehicleId": "40",
            "assetDescription": "MR U Unallocated 1",
            "registration": "MRU1",
            "sitename": "Default Site",
            "fleetNumber": null,
            "lastposition": null,
            "imei": null,
            "serialnumber": null,
            "mobileDevice": "MiX4000",
            "configCompileStatus": null,
            "configurationStatus": "Not commissioned",
            "configurationStatusDate": "2024/07/18 12:42 (AWST)",
            "commsLog": null,
            "configurationGroupId": "-8226461363431857553",
            "configurationGroupName": "Bench 4000 CAN",
            "mobileDeviceTemplateId": "-8953479898605404157",
            "mobileDeviceTemplateName": "Bench 4000 CAN",
            "eventTemplateId": "6964160016889067176",
            "eventTemplateName": "Bench 4000 CAN",
            "locationTemplateId": "0",
            "locationTemplateName": null,
            "fwVersion": null,
            "preferredFWVersion": null,
            "canScriptLineId": "401558247868188484",
            "canScript": "CAN: J1939 FMS FEF2 v1.4.0.3",
            "speed": "J1708/CAN - Speed",
            "rpm": "J1708/CAN - RPM",
            "fuel": "J1708/CAN - Fuel",
            "sp": null,
            "miXVisionSerialnumber": null,
            "hos": null,
            "scheduleId": 0,
            "mobileDeviceType": 3,
            "hyperMedia": null
        }
    ],
    "hyperMedia": null
}
```


## Next ?

xxxxx