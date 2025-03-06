---
status: closed
date: 2023-09-05
comment: 
priority: 1
---

# QA-6016 Error when changing Template SP line

Date: 2023-09-05 Time: 08:52
Parent:: [[Streamax]]
Friend:: [[2023-09-05]]
JIRA:QA-6016 Error when changing Template SP line
[QA-6016 QA - MiX Vision - Streamax - Mobile Device Template: Error received when changing the mobile template from the SP line - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-6016)

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

## Outstanding in this file

- [ ] Local: 🟧 
- [ ] Dev: 🟨 
- [ ] INT: 🟩 
- [ ] UAT: 🟦 
- [ ] PROD: 🟪

## Branch

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...
- **Common**: XXX Branch Name
	- [ ] Local files committed
		- [ ] Local Nuget: xxxName
	- [ ] PR DEV: xxxURL
		- [ ] Nuget DEV: xxxName
	- [ ] PR INT: xxxURL
		- [ ] Nuget INT: xxxName
- **Client**: XXX Branch Name
	- [ ] Local files committed
		- [ ] Local Nuget: xxxName
	- [ ] PR DEV: xxxURL
		- [ ] Nuget DEV: xxxName
	- [ ] PR INT: xxxURL
		- [ ] Nuget INT: xxxName
- **API**: XXX Branch Name
	- [ ] Local files committed
	- [ ] PR DEV: xxxURL
	- [ ] PR INT: xxxURL


## Testing notes

- What to test
- Passed or failed with images

## Description

Testing on UAT R23.13  
ORG: QA Salesforce_1 (Pty) Ltd (R)  
ORG ID: -3239007612472481813  
Serial: 007100D520  
Asset ID: 1256669229598232576

**Steps to replicate:**

1. Navigate to Mobile device templates
2. Select the Streamax Camera(M1N)
3. Select the Streamax camera in the SP line
4. Select the (C6D) peripheral from he drop down menu and click “Save”
5. An update Mobile device template modal displays…Click the Yes option

**BUG**: A ‘Mobile device template update failed’ pop-up message displays, and “an error has occurred modal” displays.


Camera lyn - deur active
STM decomm 
**nie commissioned**
- nie stuur
Change


## Error in image

(It doesnt have all the text as the image was cut off, I made the OCR all one line)

Response status code does not Indicate success: 500 ({"ErrorMessage":"Unable to commission the Streamax device. Please try again. 
assetld:1431436952294498304; stmDewceTypeld:311792233444052589; stmSerialNumber:;  tmDewceDescriptlonStreamax C6D A1. Exception:","StackTrace":" 

at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.MoblleI authToken, Int64 groupld, Int64 mobileDewceTemplateld, Int64 deviceTypeld, String deviceDescnption) In at
DynaMiX.DeviceConfig.Services.APl.Controllers.TemplateLevel <>c_DisplayClass4_O.b_O() in 124\r\n at MiX.Dewcelntegratlon.Core.Controllers.ControllerBase.Handlé route, Action method) In 183","

## Find the code

xxx

## Reproduce

- Added MR STM on UAT
- Just followed my img steps and got the error
- 1436305161436598272
```txt
Response status code does not indicate success: 500 ({"ErrorMessage":"Unable to commission the Streamax device. Please try again. assetId:1431436952294498304; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescriptionStreamax C6D AI. Exception:","StackTrace":" at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.MobileDeviceTemplateManager.UpdateMobileDeviceTemplateStreamaxDeviceDescriptions(String authToken, Int64 groupId, Int64 mobileDeviceTemplateId, Int64 deviceTypeId, String deviceDescription) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\TemplateLevel\\MobileDeviceTemplateManager.cs:line 94\r\n at DynaMiX.DeviceConfig.Services.API.Controllers.TemplateLevel.MobileDeviceTemplateController.<>c__DisplayClass4_0.b__0() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Services.API\\Controllers\\TemplateLevel\\MobileDeviceTemplateController.cs:line 124\r\n at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledVoidResponse(String route, Action method) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 183","ExceptionType":"System.Exception"}).
```
- Log: https://app.logz.io/#/goto/cfb5406ab3e8b88bb29b45669e05fc85?switchToAccountId=157279
```json
EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
<ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RequestId>1436305161436598272</RequestId>
  <AuthToken>205e984b-dbd8-4bc1-ade9-d31c4adbe455</AuthToken>
  <AccountId>7261693113146365683</AccountId>
  <RequestJson>{"DoTacho":false,"SelectedPeripheralDevice":{"Id":"311792233444052589","DeviceName":"Streamax C6D AI (Standalone)","DeviceTypeId":null,"CanDoTacho":false,"PropertyValues":[],"CalibratableParameters":[],"LogicalDevices":[{"Id":"-3284031844214289263","IsEnabled":true,"CanEnableOrDisable":false,"ShowEnableDisableCheckBox":true,"DeviceName":"Camera Channel Naming","PropertyValues":[{"Id":"4880795389236549736","Value":"","ValueFormatType":32,"DisplayUnits":null},{"Id":"8986368806182725986","Value":"50","ValueFormatType":20,"DisplayUnits":null}],"CameraChannelData":[{"Id":"1142","Channel":"CH1","SelectedCameraId":"126","SelectedCameraName":"rear"},{"Id":"1143","Channel":"CH2","SelectedCameraId":"1777","SelectedCameraName":"New left"},{"Id":"1144","Channel":"CH3","SelectedCameraId":"50","SelectedCameraName":"In Cab"},{"Id":"1145","Channel":"CH4","SelectedCameraId":"51","SelectedCameraName":"Road"},{"Id":"1146","Channel":"CH5","SelectedCameraId":"1776","SelectedCameraName":"New right"}],"CameraNames":[{"Id":null,"Name":"","IsEditable":true},{"Id":"49","Name":"Driver","IsEditable":true},{"Id":"50","Name":"In Cab","IsEditable":true},{"Id":"51","Name":"Road","IsEditable":true},{"Id":"126","Name":"rear","IsEditable":false},{"Id":"127","Name":"Side","IsEditable":false},{"Id":"143","Name":"Road-Side","IsEditable":false},{"Id":"144","Name":"New camera","IsEditable":false},{"Id":"1728","Name":"New Test camera","IsEditable":false},{"Id":"1744","Name":"Horse &amp; Trailer In Cab","IsEditable":false},{"Id":"1745","Name":"Horse &amp; Trailer Road Facing","IsEditable":false},{"Id":"1746","Name":"Horse &amp; Trailer Right side","IsEditable":false},{"Id":"1747","Name":"Horse &amp; Trailer Left side","IsEditable":false},{"Id":"1748","Name":"Horse &amp; Trailer Rear","IsEditable":false},{"Id":"1773","Name":"New In Cab","IsEditable":false},{"Id":"1774","Name":"New Road","IsEditable":false},{"Id":"1775","Name":"New Rear","IsEditable":false},{"Id":"1776","Name":"New right","IsEditable":false},{"Id":"1777","Name":"New left","IsEditable":false}],"CanChangeCameraNames":true,"Rows":[{"Id":"49","Description":"Driver","Actions":[],"IsEditable":false},{"Id":"50","Description":"In Cab","Actions":[],"IsEditable":false},{"Id":"51","Description":"Road","Actions":[],"IsEditable":false},{"Id":"126","Description":"rear","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"127","Description":"Side","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"143","Description":"Road-Side","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"144","Description":"New camera","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1728","Description":"New Test camera","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1744","Description":"Horse &amp; Trailer In Cab","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1745","Description":"Horse &amp; Trailer Road Facing","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1746","Description":"Horse &amp; Trailer Right side","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1747","Description":"Horse &amp; Trailer Left side","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1748","Description":"Horse &amp; Trailer Rear","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1773","Description":"New In Cab","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1774","Description":"New Road","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1775","Description":"New Rear","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1776","Description":"New right","Actions":["Edit","Remove"],"IsEditable":true},{"Id":"1777","Description":"New left","Actions":["Edit","Remove"],"IsEditable":true}],"AddCameraName":{"Id":null,"Description":"Temp","Actions":[],"IsEditable":false}}],"DynamicCANParameters":[]},"LogicalDevices":null,"PropertyValues":null,"CalibratableParameters":null}</RequestJson>
  <RequestUrl>POST https://uat.mixtelematics.com:443/DynaMiX.API/config-admin/organisations/-3239007612472481813/mobile-device-templates/7618733668577385446/line-settings/4376715893163448311</RequestUrl>
</ApiRequestInfo>
	Exception Type: System.Exception
EXCEPTION! Response status code does not indicate success: 500 ({"ErrorMessage":"Unable to commission the Streamax device. Please try again. assetId:1431436952294498304; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescriptionStreamax C6D AI. Exception:","StackTrace":"   at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.MobileDeviceTemplateManager.UpdateMobileDeviceTemplateStreamaxDeviceDescriptions(String authToken, Int64 groupId, Int64 mobileDeviceTemplateId, Int64 deviceTypeId, String deviceDescription) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\TemplateLevel\\MobileDeviceTemplateManager.cs:line 94\r\n   at DynaMiX.DeviceConfig.Services.API.Controllers.TemplateLevel.MobileDeviceTemplateController.<>c__DisplayClass4_0.<UpdateMobileDeviceTemplateStreamaxDeviceDescriptions>b__0() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Services.API\\Controllers\\TemplateLevel\\MobileDeviceTemplateController.cs:line 124\r\n   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledVoidResponse(String route, Action method) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 183","ExceptionType":"System.Exception"}).
	Exception Type: MiX.Core.Clients.HttpRetries+HttpInvalidRequestException
	Stack trace    at MiX.Core.Retries.RetryStrategy.<ExecuteActionAsync>d__31`1.MoveNext() in D:\b\1\_work\1571\s\MiX.Core\Retries\RetryStrategy.cs:line 379
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<ExecuteWithSuccessAsync>d__21.MoveNext() in D:\b\1\_work\1571\s\MiX.Core\Clients\HttpRetries.cs:line 227
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<ExecuteWithSuccessAsync>d__20.MoveNext() in D:\b\1\_work\1571\s\MiX.Core\Clients\HttpRetries.cs:line 197
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.DeviceConfig.Api.Client.Repositories.TemplateMobileDeviceTemplatesRepository.<UpdateMobileDeviceTemplateStreamaxDeviceDescriptions>d__1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.MobileDeviceTemplateCrudModule.UpdateLineDetails(String authToken, Int64 orgId, Int64 mobileDeviceTemplateId, Int64 lineId, DeviceDetailsFormCarrier form) in D:\b\1\_work\1522\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\MobileDeviceTemplateCrudModule.cs:line 465
   at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.MobileDeviceTemplateCrudModule.<.ctor>b__1_8(Object args) in D:\b\1\_work\1522\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\MobileDeviceTemplateCrudModule.cs:line 101
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__1(Object args) in D:\b\1\_work\1522\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in D:\b\1\_work\1522\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 282
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\b\1\_work\1522\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 191
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\b\1\_work\1522\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 121
```
- ==Unable to commission the Streamax device. Please try again==
- ==POST== https://uat.mixtelematics.com:443/DynaMiX.API/config-admin/organisations/-3239007612472481813/mobile-device-templates/7618733668577385446/line-settings/4376715893163448311
- public static readonly RouteDefinition ==UPDATE_LINE_DETAILS== = new RouteDefinition(API_BASE_URL, BASE_PATH, "/organisations/{orgId}/mobile-device-templates/{mobileDeviceTemplateId}/line-settings/{lineId}", Core.Http.Constants.HTTPVerbs.==POST==);
```txt
C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\MobileDeviceTemplateCrudModule.cs

Client

C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\MobileDeviceTemplateManager.cs
```
- DynaMiX.API.TemplateLevel.MobileDeviceTemplateCrudModule.UpdateLineDetails
	- MiX.DeviceConfig.Api.Client.Repositories.TemplateMobileDeviceTemplatesRepository.UpdateMobileDeviceTemplateStreamaxDeviceDescriptions
		- DynaMiX.DeviceConfig > Logic.Managers.TemplateLevel.MobileDeviceTemplateManager.UpdateMobileDeviceTemplateStreamaxDeviceDescriptions

## Debug Log on UAT

```log
DEBUG 2023-09-07T01:02:25+00:00 [tid:47  ] Updating STM Device Description for assetId: 1256669229598232576. DB values: serial 007100D520, device type id: -565349616809011552, device description: Streamax camera, standalone: True, isStmAsset: True
DEBUG 2023-09-07T01:02:25+00:00 [tid:47  ] Updating STM Device Description for assetId: 1256669229598232576 to Streamax C6D AI (311792233444052589)
DEBUG 2023-09-07T01:02:26+00:00 [tid:77  ] STM Device Commissioning or Update result:{"Success":true,"Error":"","CorrelationId":1436305160076451840}, assetId 1256669229598232576, correlationId 1436305160076451840
DEBUG 2023-09-07T01:02:26+00:00 [tid:47  ] Updating STM Device Description for assetId: 1431436952294498304, device type id: 311792233444052589, device description: Streamax C6D AI
DEBUG 2023-09-07T01:02:26+00:00 [tid:47  ] Updating STM Device Description for assetId: 1431436952294498304. DB values: serial , device type id: -565349616809011552, device description: Streamax camera, standalone: True, isStmAsset: True
DEBUG 2023-09-07T01:02:26+00:00 [tid:47  ] Updating STM Device Description for assetId: 1431436952294498304 to Streamax C6D AI (311792233444052589)
ERROR 2023-09-07T01:02:26+00:00 [tid:47  ] System.Exception: Unable to commission the Streamax device. Please try again. assetId:1431436952294498304; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescriptionStreamax C6D AI. Exception: ---> System.ArgumentException: providerDevice.UniqueId cannot be null or empty
   at MiX.Video.Services.API.Client.Repositories.AssetsRepository.<AddOrUpdateProviderDeviceAsync>d__5.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.<ActionStreamaxForMiXVideo>d__100.MoveNext() in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:line 1782
   --- End of inner exception stack trace ---
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.<ActionStreamaxForMiXVideo>d__100.MoveNext() in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:line 1804
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.UpdateStreamaxDeviceDescription(String authToken, Int64 assetId, Int64 deviceTypeId, String deviceDescription, Boolean isTemplateChange) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:line 1967
ERROR 2023-09-07T01:02:26+00:00 [tid:47  ] System.Exception: Unable to commission the Streamax device. Please try again. assetId:1431436952294498304; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescriptionStreamax C6D AI. Exception:
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.UpdateStreamaxDeviceDescription(String authToken, Int64 assetId, Int64 deviceTypeId, String deviceDescription, Boolean isTemplateChange) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:line 1978
   at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.MobileDeviceTemplateManager.UpdateMobileDeviceTemplateStreamaxDeviceDescriptions(String authToken, Int64 groupId, Int64 mobileDeviceTemplateId, Int64 deviceTypeId, String deviceDescription) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\MobileDeviceTemplateManager.cs:line 88
ERROR 2023-09-07T01:02:26+00:00 [tid:47  ] System.Exception: Unable to commission the Streamax device. Please try again. assetId:1431436952294498304; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescriptionStreamax C6D AI. Exception:
   at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.MobileDeviceTemplateManager.UpdateMobileDeviceTemplateStreamaxDeviceDescriptions(String authToken, Int64 groupId, Int64 mobileDeviceTemplateId, Int64 deviceTypeId, String deviceDescription) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\MobileDeviceTemplateManager.cs:line 94
   at DynaMiX.DeviceConfig.Services.API.Controllers.TemplateLevel.MobileDeviceTemplateController.<>c__DisplayClass4_0.<UpdateMobileDeviceTemplateStreamaxDeviceDescriptions>b__0() in D:\a\1\s\DynaMiX.DeviceConfig.Services.API\Controllers\TemplateLevel\MobileDeviceTemplateController.cs:line 124
   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledVoidResponse(String route, Action method) in D:\a\1\s\DynaMiX.DeviceConfig.API.Core\Controllers\ControllerBase.cs:line 183
DEBUG 2023-09-07T01:02:26+00:00 [tid:47  ] User agent: Service:DynaMiX API ClientMachine:HSUATIIS04 UserId: Host Details: Name:[api.deviceconfig.uat.production.local] [PUT] groupId/{groupId}/mobiledevicetemplateId/{mobileDeviceTemplateId}/devicetypeId/{deviceTypeId}/devicedescription/{deviceDescription}/update-streamax-device-descriptions time: 00:00:00.3480000 
DEBUG 2023-09-07T01:02:26+00:00 [tid:14  ] Updating STM Device Description for assetId: 1256669229598232576, device type id: 311792233444052589, device description: Streamax C6D AI
DEBUG 2023-09-07T01:02:26+00:00 [tid:14  ] Updating STM Device Description for assetId: 1256669229598232576. DB values: serial 007100D520, device type id: -565349616809011552, device description: Streamax camera, standalone: True, isStmAsset: True
DEBUG 2023-09-07T01:02:26+00:00 [tid:14  ] Updating STM Device Description for assetId: 1256669229598232576 to Streamax C6D AI (311792233444052589)
DEBUG 2023-09-07T01:02:26+00:00 [tid:73  ] STM Device Commissioning or Update result:{"Success":true,"Error":null,"CorrelationId":1436305161649315840}, assetId 1256669229598232576, correlationId 1436305161649315840
DEBUG 2023-09-07T01:02:26+00:00 [tid:14  ] Updating STM Device Description for assetId: 1431436952294498304, device type id: 311792233444052589, device description: Streamax C6D AI
DEBUG 2023-09-07T01:02:26+00:00 [tid:14  ] Updating STM Device Description for assetId: 1431436952294498304. DB values: serial , device type id: -565349616809011552, device description: Streamax camera, standalone: True, isStmAsset: True
DEBUG 2023-09-07T01:02:26+00:00 [tid:14  ] Updating STM Device Description for assetId: 1431436952294498304 to Streamax C6D AI (311792233444052589)
ERROR 2023-09-07T01:02:26+00:00 [tid:14  ] System.Exception: Unable to commission the Streamax device. Please try again. assetId:1431436952294498304; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescriptionStreamax C6D AI. Exception: ---> System.ArgumentException: providerDevice.UniqueId cannot be null or empty
   at MiX.Video.Services.API.Client.Repositories.AssetsRepository.<AddOrUpdateProviderDeviceAsync>d__5.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.<ActionStreamaxForMiXVideo>d__100.MoveNext() in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:line 1782
   --- End of inner exception stack trace ---
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.<ActionStreamaxForMiXVideo>d__100.MoveNext() in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:line 1804
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.UpdateStreamaxDeviceDescription(String authToken, Int64 assetId, Int64 deviceTypeId, String deviceDescription, Boolean isTemplateChange) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:line 1967
ERROR 2023-09-07T01:02:26+00:00 [tid:14  ] System.Exception: Unable to commission the Streamax device. Please try again. assetId:1431436952294498304; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescriptionStreamax C6D AI. Exception:
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.UpdateStreamaxDeviceDescription(String authToken, Int64 assetId, Int64 deviceTypeId, String deviceDescription, Boolean isTemplateChange) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:line 1978
   at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.MobileDeviceTemplateManager.UpdateMobileDeviceTemplateStreamaxDeviceDescriptions(String authToken, Int64 groupId, Int64 mobileDeviceTemplateId, Int64 deviceTypeId, String deviceDescription) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\MobileDeviceTemplateManager.cs:line 88
ERROR 2023-09-07T01:02:26+00:00 [tid:14  ] System.Exception: Unable to commission the Streamax device. Please try again. assetId:1431436952294498304; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescriptionStreamax C6D AI. Exception:
   at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.MobileDeviceTemplateManager.UpdateMobileDeviceTemplateStreamaxDeviceDescriptions(String authToken, Int64 groupId, Int64 mobileDeviceTemplateId, Int64 deviceTypeId, String deviceDescription) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\MobileDeviceTemplateManager.cs:line 94
   at DynaMiX.DeviceConfig.Services.API.Controllers.TemplateLevel.MobileDeviceTemplateController.<>c__DisplayClass4_0.<UpdateMobileDeviceTemplateStreamaxDeviceDescriptions>b__0() in D:\a\1\s\DynaMiX.DeviceConfig.Services.API\Controllers\TemplateLevel\MobileDeviceTemplateController.cs:line 124
   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledVoidResponse(String route, Action method) in D:\a\1\s\DynaMiX.DeviceConfig.API.Core\Controllers\ControllerBase.cs:line 183
DEBUG 2023-09-07T01:02:26+00:00 [tid:14  ] User agent: Service:DynaMiX API ClientMachine:HSUATIIS04 UserId: Host Details: Name:[api.deviceconfig.uat.production.local] [PUT] groupId/{groupId}/mobiledevicetemplateId/{mobileDeviceTemplateId}/devicetypeId/{deviceTypeId}/devicedescription/{deviceDescription}/update-streamax-device-descriptions time: 00:00:00.3290000 
```

## Fix & Test

- First duplicate locally
- deviceConfigRepo.GetAssetIdsForMobileDeviceTemplate is only called from this method...
- Fix it to only include commissioned ids....
- OR
- mu.ConfigurationStatus NOT IN (0, 17, 18) --Commissioned State only
- UAT: Version 23.13 beta
- 