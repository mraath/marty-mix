---
created: 2022-07-15T16:27
updated: 2024-02-29T16:10
---
# CONFIG-2958 Cant change PaOBC to FM

InnerException = InnerException = {"Cannot insert the value NULL into column 'Value', table 'DeviceConfiguration.mobileunit.OverridenDeviceProperties'; column does not allow nulls. INSERT fails.
The statement has been terminated."}

   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at DynaMiX.Data.ConfigAdmin.ConfigAdminDbContext.SaveChanges(ISession session) in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminDbContext.cs:line 282
   at DynaMiX.Data.ConfigAdmin.ConfigAdminRepository.SaveEFContext() in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminRepository.cs:line 418
   at DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.MobileUnitManager.DoUpdateMobileDevice(String authToken, IMobileDevice resolvedMobileDeviceFromUi, Int64 orgId, Nullable`1 assetId) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs:line 1701
   at DynaMiX.Logic.ConfigAdmin.MobileDeviceManager.UpdateMobileDevice(String authToken, Int64 orgId, IMobileDevice fromUi, Nullable`1 assetId) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileDeviceManager.cs:line 137
   at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary`2 propertyValueDictionaryFromUi, Int64 correlationId, Boolean configChanged) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 175
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 1228
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_2(Object args) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 160
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__2(Object args) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 501
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148

When creating PAOBC
    [0]: "-8253307904787534451: +27777777779" MSISDN
    [1]: "902507768079981239: " "" PIN_CODE
    [2]: "3931884001975002043: " - GPRS_CONTEXT
    [3]: "-5477939465635146779: " - USER
    [4]: "-5314406826919068631: " - PWD
    [5]: "4143363004589791866: " - SMS_MSISDN
    [6]: "-5986668090712501122: " - MESSAGE_CENTRE_NUMBER

TO FM
    [0]: "902507768079981239: " ""
    [1]: "3931884001975002043: " -
    [2]: "-5477939465635146779: " -
    [3]: "-5314406826919068631: " -
    **[4]: "-8253307904787534451: " -** MSISDN
    [5]: "4143363004589791866: " -
    [6]: "-5986668090712501122: " -

Creating 4000

    [0]: "-3905942074677113055: 012346578900000"
    [1]: "902507768079981239: " ""
    [2]: "3931884001975002043: " -
    [3]: "-5477939465635146779: " -
    [4]: "-5314406826919068631: " -
    [5]: "-8253307904787534451: " -
    [6]: "4143363004589791866: " -
    [7]: "-5986668090712501122: " -

TO FM




Cannot set property to null
mobileUnitManager.UpdateMobileDevice

Are you supposed to?

FE: Local

Config/MR/Bug/CONFIG-2958_PaOBCToFM_Broken.21.15.INT_ORI


EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
<ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RequestId>1179831968482721792</RequestId>
  <AuthToken>0ba8d864-1b29-4313-be5d-5e72cf4fc2e2</AuthToken>
  <AccountId>2779462498498119425</AccountId>
  <RequestJson>{"AssetName":"Default mobile device template for Mobile Phone","HasBeenCommissioned":false,"DeviceTypeName":"FM 3707i/3717i","MobileDeviceId":"2805417112665854608","HasDeviceTypeIdentifier":false,"DeviceTypeIdentifierTitle":null,"ConfigChanged":true,"IridiumImei":"","IridiumContract":"","IridiumError":null,"IridiumSatelliteCapable":false,"HasIridiumImei":false,"CanDeactivateIridiumAccount":false,"CommunicationCapable":false,"SimCardPinCode":"","GprsCapable":false,"GprsEnabled":false,"GprsApnPointName":null,"GprsApnUsername":null,"GprsApnPassword":null,"GsmCapable":false,"GsmEnabled":false,"GsmMsisdnNumber":null,"SmsCapable":false,"SmsEnabled":false,"SmsMobileDeviceNumber":null,"SmsMessageCentreNumber":null,"SatelliteCapable":false,"SatalliteDeviceId":"","UploadScheduleId":null,"HasUploadSchedule":false,"IsMesaBased":false,"CanEditDetails":true,"CanEditSmsDetails":true,"CanEditGsmDetails":true,"CanEditSimPin":true,"CanEditApnName":true,"CanEditMobileDevice":true,"CanRemoveMobileDevice":true,"CanEditSatelliteDetails":true,"CanEditIridiumSatelliteDetails":true,"CompileCapable":true,"CanCompileConfig":true,"CanUploadConfig":true,"CanViewCommsLog":false,"OrgIsMiXTalkEnabled":false,"MiXTalkIMEI":null,"MiXTalkSIMNumber":null,"MiXTalkCarrierID":0,"MiXTalkCarriers":null,"CommissioningStatus":null,"ShowOBCResendCommissioningSMS":true,"Tabs":null,"OrgIsStreamaxEnabled":false,"StreamaxDeviceTypes":null,"StreamaxSerialNumber":null,"DeviceIsStreamaxEnabled":false,"CanEditStreamaxDetails":true,"IsStreamaxStandAlone":false,"deviceTypeIdentifierValueUI":"+27777777776"}</RequestJson>
  <RequestUrl>PUT http://localhost:80/DynaMiX.API/fleet-admin/assets/commissioning/-8441185520557948197/1179559777040801792</RequestUrl>
</ApiRequestInfo>
	Exception Type: System.Exception
EXCEPTION! An error occurred while updating the entries. See the inner exception for details.
	Exception Type: System.Data.Entity.Infrastructure.DbUpdateException
	Stack trace    at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at DynaMiX.Data.ConfigAdmin.ConfigAdminDbContext.SaveChanges(ISession session) in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminDbContext.cs:line 282
   at DynaMiX.Data.ConfigAdmin.ConfigAdminRepository.SaveEFContext() in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminRepository.cs:line 418

   at DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.MobileUnitManager.DoUpdateMobileDevice(String authToken, IMobileDevice resolvedMobileDeviceFromUi, Int64 orgId, Nullable`1 assetId) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs:line 1701

   at DynaMiX.Logic.ConfigAdmin.MobileDeviceManager.UpdateMobileDevice(String authToken, Int64 orgId, IMobileDevice fromUi, Nullable`1 assetId) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileDeviceManager.cs:line 137

   at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary`2 propertyValueDictionaryFromUi, Int64 correlationId, Boolean configChanged) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 175

   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 1223
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_2(Object args) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 158
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__2(Object args) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 501
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148
EXCEPTION! An error occurred while updating the entries. See the inner exception for details.
	Exception Type: System.Data.Entity.Core.UpdateException
	Stack trace    at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
EXCEPTION! Cannot insert the value NULL into column 'Value', table 'DeviceConfiguration.mobileunit.OverridenDeviceProperties'; column does not allow nulls. INSERT fails.
The statement has been terminated.
	Exception Type: System.Data.SqlClient.SqlException
	Stack trace    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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