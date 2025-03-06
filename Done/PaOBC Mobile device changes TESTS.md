# PaOBC Mobile device changes TESTS:
  Error when:
  
  - M2310i > back PaOBC (OBC-571) (error - but actully saves) (!Unsupported command type)
  
  [mobileunit].[MobileUnit_GetDefinitionMobileDeviceType]

  SendOBCCommissioningRequest

  ![](MiX2kToPaOBC.png)

  "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <RequestId>1067576024561405952</RequestId>
  <AuthToken>dc649c4b-248d-4523-ae85-aeff90209035</AuthToken>
  <AccountId>2779462498498119425</AccountId>
  <RequestJson>{\"ConfigGroupId\":\"-445479206320168060\",\"MobileNumber\":\"+2755555555\",\"IsMobilePhone\":true,\"IsFM\":false,\"deviceTypeId\":\"-7688187356053930045\"}</RequestJson>
  <RequestUrl>PUT http://localhost:80/DynaMiX.API/fleet-admin/assets/commissioning/2364975042774694384/1066119140542562304/change-mobile-device</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! A task was canceled.
\tException Type: System.Threading.Tasks.TaskCanceledException
\tStack trace    at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(String callerMemberName, String callerFilePath, Int32 callerLineNumber) in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\ElasticRetryStrategy.cs:line 110
   at MiX.Core.Retries.RetryStrategy.<ExitRetryAsync>d__33.MoveNext() in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\RetryStrategy.cs:line 362
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at MiX.Core.Retries.RetryStrategy.<ExecuteActionWithTraceAsync>d__29`1.MoveNext() in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\RetryStrategy.cs:line 295
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<GetAsync>d__11`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<Get>d__10`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitRepository.<SendCommissioningRequest>d__16.MoveNext() in F:\\vsts-agent\\_work\\35\\s\\MiX.DeviceConfig.Api.Client\\Repositories\\MobileUnitRepository.cs:line 231
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.SendOBCCommissioningRequest(String authToken, Int64 orgId, Int64 assetId) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 1100
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.ChangeMobileDevice(String authToken, Int64 orgId, Int64 assetId, AssetChangeMobileDeviceFormCarrier carrier) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 228
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_3(Object args) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 149
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__2(Object args) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 530
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 281
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 190
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 120
",

  "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <RequestId>1066382468759863296</RequestId>
  <AuthToken>87a7db2e-d969-42b1-b26c-5ee0f2868e4d</AuthToken>
  <AccountId>2779462498498119425</AccountId>
  <RequestJson>{\"ConfigGroupId\":\"-445479206320168060\",\"MobileNumber\":\"+27333333333\",\"IsMobilePhone\":true,\"IsFM\":false,\"deviceTypeId\":\"-7688187356053930045\"}</RequestJson>
  <RequestUrl>PUT http://localhost:80/DynaMiX.API/fleet-admin/assets/commissioning/2364975042774694384/1066143972785176576/change-mobile-device</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! Response status code does not indicate success: 500 ({\"ErrorMessage\":\"Specified argument was out of the range of valid values.\\r\\nParameter name: Unsupported command type\",\"StackTrace\":\"   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.ValidateCommandType(MobileUnitCommand muc) in D:\\\\b\\\\2\\\\_work\\\\263\\\\s\\\\DynaMiX.DeviceConfig.Logic\\\\Managers\\\\MobileUnitLevel\\\\CommandSenders\\\\MobileUnitCommandSender.cs:line 77\\r\\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.ValidateCommand(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\\\b\\\\2\\\\_work\\\\263\\\\s\\\\DynaMiX.DeviceConfig.Logic\\\\Managers\\\\MobileUnitLevel\\\\CommandSenders\\\\MobileUnitCommandSender.cs:line 32\\r\\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(CurrentUserSession session, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, String value) in D:\\\\b\\\\2\\\\_work\\\\263\\\\s\\\\DynaMiX.DeviceConfig.Logic\\\\Managers\\\\MobileUnitLevel\\\\MobileUnitCommandsManager.cs:line 156\\r\\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3) in D:\\\\b\\\\2\\\\_work\\\\263\\\\s\\\\DynaMiX.DeviceConfig.Logic\\\\Managers\\\\MobileUnitLevel\\\\MobileUnitCommandsManager.cs:line 70\\r\\n   at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitCommandsController.<>c__DisplayClass0_0.<SendCommandToMobileUnit>b__0() in D:\\\\b\\\\2\\\\_work\\\\263\\\\s\\\\DynaMiX.DeviceConfig.Services.API\\\\Controllers\\\\MobileUnitLevel\\\\MobileUnitCommandsController.cs:line 48\\r\\n   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in D:\\\\b\\\\2\\\\_work\\\\263\\\\s\\\\DynaMiX.DeviceConfig.API.Core\\\\Controllers\\\\ControllerBase.cs:line 46\",\"ExceptionType\":\"System.ArgumentOutOfRangeException\"}).
\tException Type: MiX.Core.Clients.HttpRetries+HttpInvalidRequestException
\tStack trace    at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(String callerMemberName, String callerFilePath, Int32 callerLineNumber) in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\ElasticRetryStrategy.cs:line 103
   at MiX.Core.Retries.RetryStrategy.<ExitRetryAsync>d__33.MoveNext() in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\RetryStrategy.cs:line 362
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at MiX.Core.Retries.RetryStrategy.<ExecuteActionWithTraceAsync>d__29`1.MoveNext() in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\RetryStrategy.cs:line 295
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<GetAsync>d__11`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<Get>d__10`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitRepository.<SendCommissioningRequest>d__16.MoveNext() in F:\\vsts-agent\\_work\\35\\s\\MiX.DeviceConfig.Api.Client\\Repositories\\MobileUnitRepository.cs:line 231
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.SendOBCCommissioningRequest(String authToken, Int64 orgId, Int64 assetId) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 1100
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.ChangeMobileDevice(String authToken, Int64 orgId, Int64 assetId, AssetChangeMobileDeviceFormCarrier carrier) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 228
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_3(Object args) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 149
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__2(Object args) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 530
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 281
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 190
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 120
",

  "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <RequestId>1066503522238709760</RequestId>
  <AuthToken>13d9f494-1805-42e2-8b27-c5397c684205</AuthToken>
  <AccountId>2779462498498119425</AccountId>
  <RequestJson>{\"ConfigGroupId\":\"-445479206320168060\",\"MobileNumber\":\"+27555555555\",\"IsMobilePhone\":true,\"IsFM\":false,\"deviceTypeId\":\"-7688187356053930045\"}</RequestJson>
  <RequestUrl>PUT http://localhost:80/DynaMiX.API/fleet-admin/assets/commissioning/2364975042774694384/1066143972785176576/change-mobile-device</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! A task was canceled.
\tException Type: System.Threading.Tasks.TaskCanceledException
\tStack trace    at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(String callerMemberName, String callerFilePath, Int32 callerLineNumber) in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\ElasticRetryStrategy.cs:line 110
   at MiX.Core.Retries.RetryStrategy.<ExitRetryAsync>d__33.MoveNext() in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\RetryStrategy.cs:line 362
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at MiX.Core.Retries.RetryStrategy.<ExecuteActionWithTraceAsync>d__29`1.MoveNext() in D:\\b\\1\\_work\\292\\s\\MiX.Core\\Retries\\RetryStrategy.cs:line 295
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<GetAsync>d__11`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.<Get>d__10`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitRepository.<SendCommissioningRequest>d__16.MoveNext() in F:\\vsts-agent\\_work\\35\\s\\MiX.DeviceConfig.Api.Client\\Repositories\\MobileUnitRepository.cs:line 231
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.SendOBCCommissioningRequest(String authToken, Int64 orgId, Int64 assetId) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 1100
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.ChangeMobileDevice(String authToken, Int64 orgId, Int64 assetId, AssetChangeMobileDeviceFormCarrier carrier) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 228
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_3(Object args) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 149
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__2(Object args) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 530
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 281
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 190
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 120
",




- M4K > FM (shouldn't display unique identifier) (OBC-579) (same as prod - error - but actually saves)

  Set up a M4k [mr4k5]
  Change to FM
    Ensure NO Number shows
    Ensure it saved OK
    Ensure it persists OK
  
  ERROR
  "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <RequestId>1066412105354940416</RequestId>
  <AuthToken>87a7db2e-d969-42b1-b26c-5ee0f2868e4d</AuthToken>
  <AccountId>2779462498498119425</AccountId>
  <RequestJson>{\"AssetName\":\"gadija tamper test\",\"HasBeenCommissioned\":true,\"DeviceTypeName\":\"FM 3707i/3717i\",\"MobileDeviceId\":\"6183256567829462590\",\"HasDeviceTypeIdentifier\":false,\"DeviceTypeIdentifierTitle\":null,\"IridiumImei\":\"\",\"IridiumContract\":\"\",\"IridiumError\":null,\"IridiumSatelliteCapable\":false,\"HasIridiumImei\":false,\"CanDeactivateIridiumAccount\":false,\"CommunicationCapable\":false,\"SimCardPinCode\":\"\",\"GprsCapable\":false,\"GprsEnabled\":false,\"GprsApnPointName\":null,\"GprsApnUsername\":null,\"GprsApnPassword\":null,\"GsmCapable\":false,\"GsmEnabled\":false,\"GsmMsisdnNumber\":null,\"SmsCapable\":false,\"SmsEnabled\":false,\"SmsMobileDeviceNumber\":null,\"SmsMessageCentreNumber\":null,\"SatelliteCapable\":false,\"SatalliteDeviceId\":\"\",\"UploadScheduleId\":null,\"HasUploadSchedule\":false,\"IsMesaBased\":true,\"CanEditDetails\":true,\"CanEditSmsDetails\":true,\"CanEditGsmDetails\":true,\"CanEditSimPin\":true,\"CanEditApnName\":true,\"CanEditMobileDevice\":true,\"CanRemoveMobileDevice\":true,\"CanEditSatelliteDetails\":true,\"CanEditIridiumSatelliteDetails\":true,\"CompileCapable\":true,\"CanCompileConfig\":true,\"CanUploadConfig\":true,\"CanViewCommsLog\":true,\"OrgIsMiXTalkEnabled\":true,\"MiXTalkIMEI\":null,\"MiXTalkSIMNumber\":null,\"MiXTalkCarrierID\":0,\"MiXTalkCarriers\":[{\"CarrierID\":1,\"Carrier\":\"MTN\"},{\"CarrierID\":2,\"Carrier\":\"Vodacom\"},{\"CarrierID\":4,\"Carrier\":\"Telkom SA Ltd\"}],\"CommissioningStatus\":{\"CommissioningStatus\":\"Not available\",\"CommandType\":\"MasterNumber\",\"CreationDateUtc\":null,\"ExpiryDateUtc\":null,\"MessageStatusDateUtc\":null},\"ShowOBCResendCommissioningSMS\":false,\"Tabs\":null,\"OrgIsStreamaxEnabled\":true,\"StreamaxDeviceTypes\":[{\"Id\":\"-5579312442939220400\",\"Description\":\"C6D 3.0\"},{\"Id\":\"-9102939309951600390\",\"Description\":\"C6D AI\"}],\"StreamaxSerialNumber\":null,\"StreamaxDeviceTypeID\":null,\"DeviceIsStreamaxEnabled\":true,\"deviceTypeIdentifierValueUI\":\"111112222233311\"}</RequestJson>
  <RequestUrl>PUT http://localhost:80/DynaMiX.API/fleet-admin/assets/commissioning/2364975042774694384/1066119140542562304</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! An error occurred while updating the entries. See the inner exception for details.
\tException Type: System.Data.Entity.Infrastructure.DbUpdateException
\tStack trace    at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at DynaMiX.Data.ConfigAdmin.ConfigAdminDbContext.SaveChanges(ISession session) in C:\\Projects\\DynaMiX.Backend\\Data\\DynaMiX.Data\\ConfigAdmin\\ConfigAdminDbContext.cs:line 282
   at DynaMiX.Data.ConfigAdmin.ConfigAdminRepository.SaveEFContext() in C:\\Projects\\DynaMiX.Backend\\Data\\DynaMiX.Data\\ConfigAdmin\\ConfigAdminRepository.cs:line 417
   at DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.MobileUnitManager.DoUpdateMobileDevice(String authToken, IMobileDevice resolvedMobileDeviceFromUi, Int64 orgId, Nullable`1 assetId) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\MobileUnitLevel\\MobileUnitManager.cs:line 1689
   at DynaMiX.Logic.ConfigAdmin.MobileDeviceManager.UpdateMobileDevice(String authToken, Int64 orgId, IMobileDevice fromUi, Nullable`1 assetId) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\MobileDeviceManager.cs:line 135
   at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary`2 propertyValueDictionaryFromUi, Int64 correlationId) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\FleetAdmin\\AssetCommissioningManager.cs:line 162
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 1074
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_2(Object args) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 148
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__2(Object args) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 501
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 148
EXCEPTION! An error occurred while updating the entries. See the inner exception for details.
\tException Type: System.Data.Entity.Core.UpdateException
\tStack trace    at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
EXCEPTION! Cannot insert the value NULL into column 'Value', table 'DeviceConfiguration.mobileunit.OverridenDeviceProperties'; column does not allow nulls. INSERT fails.
The statement has been terminated.
\tException Type: System.Data.SqlClient.SqlException
\tStack trace    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at System.Data.Entity.Infrastructure.Interception.InternalDispatcher`1.Dispatch[TTarget,TInterceptionContext,TResult](TTarget target, Func`3 operation, TInterceptionContext interceptionContext, Action`3 executing, Action`3 executed)
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.NonQuery(DbCommand command, DbCommandInterceptionContext interceptionContext)
   at System.Data.Entity.Core.Mapping.Update.Internal.DynamicUpdateCommand.Execute(Dictionary`2 identifierValues, List`1 generatedValues)
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
",
    "token": "tRpCBInLUMWJFIqcSKHdKRyjkDqJUK",

- FM > M4K (should display unique identifier) (OBC-579) (same as prod, but better re unique id) (passes)
  
  Tested

- PaOBC > FM (QA-4062) (error - but actually saves) (!Looks like vals are old - replace form vals in UI before save?)
  
  Set up paObc [paobc]

  "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <RequestId>1066409404151861248</RequestId>
  <AuthToken>87a7db2e-d969-42b1-b26c-5ee0f2868e4d</AuthToken>
  <AccountId>2779462498498119425</AccountId>
  <RequestJson>{\"AssetName\":\"Default mobile device template for Mobile Phone\",\"HasBeenCommissioned\":false,\"DeviceTypeName\":\"FM 3707i/3717i\",\"MobileDeviceId\":\"-7688187356053930045\",\"HasDeviceTypeIdentifier\":false,\"DeviceTypeIdentifierTitle\":null,\"IridiumImei\":\"\",\"IridiumContract\":\"\",\"IridiumError\":null,\"IridiumSatelliteCapable\":false,\"HasIridiumImei\":false,\"CanDeactivateIridiumAccount\":false,\"CommunicationCapable\":false,\"SimCardPinCode\":\"\",\"GprsCapable\":false,\"GprsEnabled\":false,\"GprsApnPointName\":null,\"GprsApnUsername\":null,\"GprsApnPassword\":null,\"GsmCapable\":false,\"GsmEnabled\":false,\"GsmMsisdnNumber\":null,\"SmsCapable\":false,\"SmsEnabled\":false,\"SmsMobileDeviceNumber\":null,\"SmsMessageCentreNumber\":null,\"SatelliteCapable\":false,\"SatalliteDeviceId\":\"\",\"UploadScheduleId\":null,\"HasUploadSchedule\":false,\"IsMesaBased\":false,\"CanEditDetails\":true,\"CanEditSmsDetails\":true,\"CanEditGsmDetails\":true,\"CanEditSimPin\":true,\"CanEditApnName\":true,\"CanEditMobileDevice\":true,\"CanRemoveMobileDevice\":true,\"CanEditSatelliteDetails\":true,\"CanEditIridiumSatelliteDetails\":true,\"CompileCapable\":true,\"CanCompileConfig\":true,\"CanUploadConfig\":true,\"CanViewCommsLog\":false,\"OrgIsMiXTalkEnabled\":true,\"MiXTalkIMEI\":null,\"MiXTalkSIMNumber\":null,\"MiXTalkCarrierID\":0,\"MiXTalkCarriers\":[{\"CarrierID\":1,\"Carrier\":\"MTN\"},{\"CarrierID\":2,\"Carrier\":\"Vodacom\"},{\"CarrierID\":4,\"Carrier\":\"Telkom SA Ltd\"}],\"CommissioningStatus\":{\"CommissioningStatus\":\"Not available\",\"CommandType\":\"MasterNumber\",\"CreationDateUtc\":null,\"ExpiryDateUtc\":null,\"MessageStatusDateUtc\":null},\"ShowOBCResendCommissioningSMS\":true,\"Tabs\":null,\"OrgIsStreamaxEnabled\":true,\"StreamaxDeviceTypes\":null,\"StreamaxSerialNumber\":null,\"StreamaxDeviceTypeID\":null,\"DeviceIsStreamaxEnabled\":false,\"deviceTypeIdentifierValueUI\":\"+2741433223\"}</RequestJson>
  <RequestUrl>PUT http://localhost:80/DynaMiX.API/fleet-admin/assets/commissioning/2364975042774694384/1066143972785176576</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! An error occurred while updating the entries. See the inner exception for details.
\tException Type: System.Data.Entity.Infrastructure.DbUpdateException
\tStack trace    at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at DynaMiX.Data.ConfigAdmin.ConfigAdminDbContext.SaveChanges(ISession session) in C:\\Projects\\DynaMiX.Backend\\Data\\DynaMiX.Data\\ConfigAdmin\\ConfigAdminDbContext.cs:line 282
   at DynaMiX.Data.ConfigAdmin.ConfigAdminRepository.SaveEFContext() in C:\\Projects\\DynaMiX.Backend\\Data\\DynaMiX.Data\\ConfigAdmin\\ConfigAdminRepository.cs:line 417
   at DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.MobileUnitManager.DoUpdateMobileDevice(String authToken, IMobileDevice resolvedMobileDeviceFromUi, Int64 orgId, Nullable`1 assetId) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\MobileUnitLevel\\MobileUnitManager.cs:line 1689
   at DynaMiX.Logic.ConfigAdmin.MobileDeviceManager.UpdateMobileDevice(String authToken, Int64 orgId, IMobileDevice fromUi, Nullable`1 assetId) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\MobileDeviceManager.cs:line 135
   at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary`2 propertyValueDictionaryFromUi, Int64 correlationId) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\FleetAdmin\\AssetCommissioningManager.cs:line 162
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 1074
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_2(Object args) in C:\\Projects\\DynaMiX.Backend\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 148
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__2(Object args) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 501
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in C:\\Projects\\DynaMiX.Backend\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 148
EXCEPTION! An error occurred while updating the entries. See the inner exception for details.
\tException Type: System.Data.Entity.Core.UpdateException
\tStack trace    at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
EXCEPTION! Cannot insert the value NULL into column 'Value', table 'DeviceConfiguration.mobileunit.OverridenDeviceProperties'; column does not allow nulls. INSERT fails.
The statement has been terminated.
\tException Type: System.Data.SqlClient.SqlException
\tStack trace    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at System.Data.Entity.Infrastructure.Interception.InternalDispatcher`1.Dispatch[TTarget,TInterceptionContext,TResult](TTarget target, Func`3 operation, TInterceptionContext interceptionContext, Action`3 executing, Action`3 executed)
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.NonQuery(DbCommand command, DbCommandInterceptionContext interceptionContext)
   at System.Data.Entity.Core.Mapping.Update.Internal.DynamicUpdateCommand.Execute(Dictionary`2 identifierValues, List`1 generatedValues)
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
",
    "token": "tRpCBInLUMWJFIqcSKHdKRyjkDqJUK",

- FM > PaOBC (Works)

- PaOBC > M4k (QA-4062) (works)

  test

- M4k > PaOBC (works)

- PaOBC > M2310i (works)


One of the problems I have with the Change Mobile Device is this...
When wanting to change this, it looks at the current Mobile info to decide what to show or not.
It looks at the assetConfigSummary.isTDI

It gets it from the back-end from here:
bool isTDI = resolvedMobileDevice.IsDeviceEnabled(LogicalDevices.BASE_TDI_FUNCTIONALITY) && (!isMix2K) && (!isTeltonika);

I don't think the above is relevant when changing a mobile device






ChangeMobilePhoneTemplate

FE:
filteredConfigGroups
identifierTitle
isBeacon
isMobilePhone

Both:
devices - options
ConfigGroups
ConfigGroupId
MobileNumber  <-- must still be used better

BE:


$dynamicScope.form.deviceTypeIdentifierValue (mobileNumber)


INIT:
var currentDevice = $dynamicScope.changeMobileDeviceTemplate.devices.singleOrDefault(x => x.name === $dynamicScope.form.deviceTypeName);
$dynamicScope.changeMobileDeviceTemplate.deviceTypeId = currentDevice ? currentDevice.deviceTypeId : null;

CHANGE OPEN:
$dynamicScope.modalScope.$parent.form.deviceTypeIdentifierValueUI = $dynamicScope.modalScope.$parent.form.deviceTypeIdentifierValue;
$dynamicScope.changeMobileDeviceTemplate.mobileNumber = $dynamicScope.form.deviceTypeIdentifierValue;

SAVE:
$dynamicScope.modalScope.$parent.form.deviceTypeIdentifierValue = $dynamicScope.modalScope.$parent.form.deviceTypeIdentifierValueUI;
undefine most things



## xxxxxxxxxxxxxx
