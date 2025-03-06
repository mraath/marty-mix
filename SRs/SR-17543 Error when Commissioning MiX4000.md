---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-03-04T14:18
---

# SR-17543 Error when Commissioning MiX4000

Date: 2024-02-22 Time: 11:01
Parent:: [[DST|Daylight Savings Time]]
Friend:: [[2024-02-22]]
JIRA:SR-17543 Error when Commissioning MiX4000
[JIRA](https://csojiramixtelematics.atlassian.net/browse/SR-17543)


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

- Select Org and create an Asset( MiX4000 ) 
- Once the asset is successfully created navigate to Mobile Device Settings in the Asset Page. 
- Insert the Unique Identifier and select save

```txt
EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
<ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RequestId>1488718874909892608</RequestId>
  <AuthToken>377c32fb-1726-4741-975c-81e995f9c9d0</AuthToken>
  <AccountId>8661006584938685151</AccountId>
  <RequestJson>{"AssetName":"015: NON-HOS, (SI) Magix, OBDII Petrol WiredIgn Rev 1.3.0.3, I1-Brakes &gt;6v - M4K","HasBeenCommissioned":false,"DeviceTypeName":"MiX4000","MobileDeviceId":"6183256567829462590","HasDeviceTypeIdentifier":true,"DeviceTypeIdentifierTitle":"Unique identifier","DeviceTypeIdentifierValue":"866233052539103","ConfigChanged":true,"IridiumImei":"","IridiumContract":"","IridiumPlanName":"","IridiumError":null,"IridiumSatelliteCapable":false,"HasIridiumImei":false,"CanDeactivateIridiumAccount":false,"CommunicationCapable":false,"SimCardPinCode":"","GprsCapable":false,"GprsEnabled":false,"GprsApnPointName":null,"GprsApnUsername":null,"GprsApnPassword":null,"GsmCapable":false,"GsmEnabled":false,"GsmMsisdnNumber":null,"SmsCapable":false,"SmsEnabled":false,"SmsMobileDeviceNumber":null,"SmsMessageCentreNumber":null,"SatelliteCapable":false,"SatalliteDeviceId":"","UploadScheduleId":702,"HasUploadSchedule":true,"IsMesaBased":false,"CanEditDetails":true,"CanEditSmsDetails":true,"CanEditGsmDetails":true,"CanEditSimPin":true,"CanEditApnName":true,"CanEditMobileDevice":true,"CanRemoveMobileDevice":true,"CanEditSatelliteDetails":true,"CanEditIridiumSatelliteDetails":true,"CompileCapable":true,"CanCompileConfig":true,"CanUploadConfig":true,"CanViewCommsLog":true,"OrgIsMiXTalkEnabled":false,"MiXTalkIMEI":null,"MiXTalkSIMNumber":null,"MiXTalkCarrierID":0,"MiXTalkCarriers":null,"CommissioningStatus":null,"ShowOBCResendCommissioningSMS":false,"Tabs":null,"OrgIsStreamaxEnabled":false,"StreamaxDeviceTypes":null,"StreamaxSerialNumber":null,"DeviceIsStreamaxEnabled":true,"CanEditStreamaxDetails":true,"IsStreamaxStandAlone":false,"IsStreamaxPeripheralConnected":false,"HasBlockManualCommissioning":false}</RequestJson>
  <RequestUrl>PUT http://us.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/6777738908823677426/1162938988822102016</RequestUrl>
</ApiRequestInfo>
	Exception Type: System.Exception
EXCEPTION! Unable to send update timezone message for all the assets.FAILURE: Remote message for asset 1162938988822102016 not sent. MiX.Core.Retries.RetryLimitExceededException: The limit for retries has been exceeded.
   at MiX.Core.Retries.RetryStrategy.<ExecuteActionAsync>d__31`1.MoveNext() in D:\b\1\_work\1888\s\MiX.Core\Retries\RetryStrategy.cs:line 368
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<GetAsync>d__13`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<Get>d__10`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitCommandsRepository.<SendCommandToMobileUnit>d__4.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.Logic.AsyncResultExtension.ToSync[T](Task`1 task, Boolean configureAwait) in D:\b\1\_work\1742\s\Logic\DynaMiX.Logic\AsyncResultExtension.cs:line 13
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.SendCommandToMobileDevice(String authToken, Int64 organisationId, Command cmd, Int64 correlationId, Nullable`1 disSupportedUnit) in D:\b\1\_work\1742\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 212
   at 
   
   DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.DeviceIntegrationManager.SendCommandToUpdateAssetTimezoneDeviation(String authToken, Int64 orgId, Double secondsBefore, Double secondsAfter, Double ctime, List`1 assetIds, String currentUser, Int64 correlationId, DSTOptionalFields dstOptionalFields) in D:\b\1\_work\1742\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs:line 1320
	Exception Type: System.InvalidOperationException
	Stack trace    at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.DeviceIntegrationManager.SendCommandToUpdateAssetTimezoneDeviation(String authToken, Int64 orgId, Double secondsBefore, Double secondsAfter, Double ctime, List`1 assetIds, String currentUser, Int64 correlationId, DSTOptionalFields dstOptionalFields) in D:\b\1\_work\1742\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs:line 1258
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.DeviceIntegrationManager.UpdateAssetTimezoneDeviation(String authToken, Int64 orgId, Int64 newSiteId, List`1 assetIds, UserProfile currentUserProfile, Int64 correlationId, DSTOptionalFields dstOptionalFields) in D:\b\1\_work\1742\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs:line 1025
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in 


D:\b\1\_work\1742\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 1318
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__15_2(Object args) in D:\b\1\_work\1742\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 146
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__2(Object args) in D:\b\1\_work\1742\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 503
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\1\_work\1742\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 288
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\1742\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 215
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\1742\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 149
```


## Logs

- https://app.logz.io/#/goto/78093ad9f3bd715e263220cbfb04fcd8?switchToAccountId=157279

## Duplicate Issue

- US
- MR Test Asset: [MiX Telematics - Assets](https://us.mixtelematics.com/#/fleet-admin/asset/details?id=1497556025358700544&orgId=6777738908823677426&mobileNumber=)
- LOG: https://app.logz.io/#/goto/e02822001e1f89687f826d3cb889ac2b?switchToAccountId=157279
- Deleted asset
- Check local log
- id=1497556025358700544
- orgId=6777738908823677426
- e051fd7c-fad7-4f51-b6c1-514bbe876b2e

## Next idea

- Search IMEI
- eg. POST /devices/569741335654154/commands
- IMEI number above
- Redo the original test and keep track of the IMEI

- [MiX Telematics - Assets](https://us.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1498626702152286208&orgId=6777738908823677426)
- id=1498626702152286208
- orgId=6777738908823677426
- IMEI=123456789987654
- 00:33 (Save IMEI)
- DIDNT FAIL

- [MiX Telematics - Assets](https://us.mixtelematics.com/#/fleet-admin/asset/details?id=1498634641484587008&orgId=6777738908823677426&mobileNumber=)
- id=1498634641484587008
- orgId=6777738908823677426
- IMEI=123456789987654
- DIDNT FAIL

- [MiX Telematics - Assets](https://us.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1498636545325309952&orgId=6777738908823677426)
- id=1498636545325309952
- orgId=6777738908823677426
- IMEI=123456789987654
- DIDNT FAIL

## NEXT STEP

- [x] Use NO RETRIES ✅ 2024-03-04
	- CommandManager.SendCommandToMobileDevice
	- _httpNoRetriesButWithElasticStrategy
	- ?? _httpNoRetriesLongTimeout ? Jako
- Try redoing this again
	- 123456789987654
	- LD-01: NON-HOS, (SI) Magix, OBDII P, I1-Brakes OS-80 EOS-90, HA-6.21, HB-6.84 - M4K
	- LD-01: NON-HOS, OBDII, P, I1-Brakes >6v, I3-RF Switch, HA-6.5, HB-7.5, OR-5000, OS-78 - M4K
- Log 11:41 4th Mar
	- https://app.logz.io/#/goto/0c437402b553393db599c49a1d96907e?switchToAccountId=157279
	- SYD mostly - no US
	- USe this one: 
	- RequestUrl>PUT http://au.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/-3051715179341039640/1498991548492115968</RequestUrl>
	- -3051715179341039640
	- 1498991548492115968
	- IMEI: 863427060343283
	- Comms
- Next eg.
	- 1501234056848412672
	- IMEI: 863427060336162
- 3rd 
	- 1499401346147876864
	- IMEI: 863427060339737
	- Comms
- 4th
	- 1501212010248605696
	- IMEI: 863427060313039
	- Comms
- I tried this for four different issues found, each time it is preceded by the comms error
	- [LOGZ](https://app.logz.io/#/goto/41f4822100a558c987cb26c398e7fac7?switchToAccountId=157279)
- [[SQL SR-17543 Find ORG and IMEI based on AssetId]]

## Screenshot of the issue


