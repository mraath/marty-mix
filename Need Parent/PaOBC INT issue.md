
## Online latest files for PaOBC Commissioning Client

[MyMiX.PaOBC.Commissioning.Management.Client.csproj - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Mobile/_git/MyMiX.PhoneAsOBC?path=/MyMiX.PaOBC.Commissioning.Management.Client/MyMiX.PaOBC.Commissioning.Management.Client.csproj)

## Final Notes

that nuget package wasn't one of those which caused issues in the HOS service before
 I think you can update it and if it fails to run , we can always downgrade it afterwards
Maybe once that deployment goes through, you should keep an eye on the HOS service logs for errors

## Test Data

Org: MyMiX 2019 - 3
Asset: Stephan's iPhone
Asset Id: 1012050582994825216
Mobile Number: +27829245596
- Change mobile device
- remove mobile device
- "Decommissioning failed" Unable to reach the mobile device
enige Mobile Pone asset

BE > ChangeMobileDevice > error

## Flow Chart of PaOBC issue

![[PaOBC Decommissioning failed]]

## Newer Error

```xml
DEBUG 2023-01-16T00:46:33+00:00 [tid:10  ] GetMobileUnit(1) - SharedMobileUnitDetailsCache updated with: {"AssetId":1012050582994825216,"MobileUnitId":1012050582994825216,"UniqueIdentifier":"+27829245596","OrganisationId":4686848533662217157,"LegacyVehicleId":9,"LegacyOrganisationId":9269,"MobileDeviceType":7}
DEBUG 2023-01-16T00:46:33+00:00 [tid:10  ] Response for MobileUnitMapping, MobileUnitId=1012050582994825216 and UniqueIdentifier=+27829245596
ERROR 2023-01-16T00:46:33+00:00 [tid:10  ] System.IO.FileNotFoundException: Could not load file or assembly 'MiX.Core.Serialization.NewtonsoftJson, Version=2021.2.9.1, Culture=neutral, PublicKeyToken=null' or one of its dependencies. The system cannot find the file specified.
File name: 'MiX.Core.Serialization.NewtonsoftJson, Version=2021.2.9.1, Culture=neutral, PublicKeyToken=null'
   at MyMiX.PaOBC.Commissioning.Management.Client.CommissioningApiClient.RegisterRepository(String apiUrl, Func`1 retryFactory, TimeSpan timeout, HttpClient customRestClient)
   at DynaMiX.Services.API.Client.PaOBCConnect.PaOBCProxy..ctor() in D:\a\1\s\DynaMiX.Services.API.Client\PaOBC.Connect\PaOBCProxy.cs:line 34

WRN: Assembly binding logging is turned OFF.
To enable assembly bind failure logging, set the registry value [HKLM\Software\Microsoft\Fusion!EnableLog] (DWORD) to 1.
Note: There is some performance penalty associated with assembly bind failure logging.
To turn this feature off, remove the registry value [HKLM\Software\Microsoft\Fusion!EnableLog].

ERROR 2023-01-16T00:46:33+00:00 [tid:10  ] Error creating communications client: PaOBCCommissioningApiUrl=http://commissioningapi.mymix.int.development.domain.local
ERROR 2023-01-16T00:46:33+00:00 [tid:10  ] System.IO.FileNotFoundException: Could not load file or assembly 'MiX.Core.Serialization.NewtonsoftJson, Version=2021.2.9.1, Culture=neutral, PublicKeyToken=null' or one of its dependencies. The system cannot find the file specified.
File name: 'MiX.Core.Serialization.NewtonsoftJson, Version=2021.2.9.1, Culture=neutral, PublicKeyToken=null'
   at MyMiX.PaOBC.Commissioning.Management.Client.CommissioningApiClient.RegisterRepository(String apiUrl, Func`1 retryFactory, TimeSpan timeout, HttpClient customRestClient)
   at DynaMiX.Services.API.Client.PaOBCConnect.PaOBCProxy..ctor() in D:\a\1\s\DynaMiX.Services.API.Client\PaOBC.Connect\PaOBCProxy.cs:line 34

WRN: Assembly binding logging is turned OFF.
To enable assembly bind failure logging, set the registry value [HKLM\Software\Microsoft\Fusion!EnableLog] (DWORD) to 1.
Note: There is some performance penalty associated with assembly bind failure logging.
To turn this feature off, remove the registry value [HKLM\Software\Microsoft\Fusion!EnableLog].

DEBUG 2023-01-16T00:46:33+00:00 [tid:10  ] User agent: unknown [unknown] [POST] groupIds/{groupId}/command/{commandId}/mobile-units time: 00:00:00.1570000 
DEBUG 2023-01-16T00:46:33+00:00 [tid:10  ] STATE Updating of 60 second state interval triggered
```

## Initial Error


```json
Exception Type: System.Exception EXCEPTION! Response status code does not indicate success: 500 ({"ErrorMessage":"Specified argument was out of the range of valid values.\r\nParameter name: Error creating communications client","StackTrace":" at DynaMiX.Services.API.Client.PaOBCConnect.PaOBCProxy..ctor() in D:\\a\\1\\s\\DynaMiX.Services.API.Client\\PaOBC.Connect\\PaOBCProxy.cs:line 42\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MessageSenders.PaOBCMessageSender.<>c.<.ctor>b__2_0() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MessageSenders\\PaOBCMessageSender.cs:line 32\r\n at MiX.DeviceIntegration.Core.Runtime.IOC.DependencyRegistry.CreateInstance[T](String name)\r\n at MiX.DeviceIntegration.Core.Runtime.IOC.DependencyRegistry.GetInstance[T](Boolean singleton, String name)\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MessageSenders.PaOBCMessageSender.SendCommand(CurrentUserSession session, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MessageSenders\\PaOBCMessageSender.cs:line 43\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.PaOBCCommandSender.SendCommand(CurrentUserSession session, IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\PaOBCCommandSender.cs:line 57\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(CurrentUserSession session, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, String value, Dictionary`2 paramDictionary) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 184\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, Dictionary`2 paramDictionary) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 74\r\n at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitCommandsController.<>c__DisplayClass0_0.<SendCommandToMobileUnit>b__0() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Services.API\\Controllers\\MobileUnitLevel\\MobileUnitCommandsController.cs:line 48\r\n at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 46","ExceptionType":"System.ArgumentOutOfRangeException"}). Exception Type: MiX.Core.Clients.HttpRetries+HttpInvalidRequestException Stack trace at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(String callerMemberName, String callerFilePath, Int32 callerLineNumber) in D:\b\2\_work\121\s\MiX.Core\Retries\ElasticRetryStrategy.cs:line 103 at MiX.Core.Retries.RetryStrategy.<ExitRetryAsync>d__33.MoveNext() in D:\b\2\_work\121\s\MiX.Core\Retries\RetryStrategy.cs:line 362 --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at MiX.Core.Retries.RetryStrategy.<ExecuteActionWithTraceAsync>d__29`1.MoveNext() in D:\b\2\_work\121\s\MiX.Core\Retries\RetryStrategy.cs:line 295 --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) at MiX.Core.Clients.HttpRetries.<GetAsync>d__12`1.MoveNext() --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) at MiX.Core.Clients.HttpRetries.<Get>d__11`1.MoveNext() --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitRepository.<SendCommissioningRequest>d__26.MoveNext() --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.SendOBCCommissioningRequest(String authToken, Int64 orgId, Int64 assetId) in D:\b\2\_work\115\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 1307 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__1(Object args) in D:\b\2\_work\115\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in D:\b\2\_work\115\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 282 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\b\2\_work\115\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 191 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\b\2\_work\115\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 121
```

## Potential fix

