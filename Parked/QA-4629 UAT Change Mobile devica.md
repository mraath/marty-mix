---
status : parked
date : 2021-06-25
priority : 8
comment : When nothing to do
---

JIRA:QA-4629
[QA-4629 PROD: Asset - Change mobile device: Error occurred while updating the entries - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/QA-4629)

# QA-4629 UAT Change Mobile devica

## Image


## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Lang  | UI    | BE    | Client | API   | Common | DB    |
| ----- | ----- | ----- | ------ | ----- | ------ | ----- |
| 22.6  | 22.6  | 22.6  | 22.6   | 22.6  | 22.6   | 22.6  |
| Local | Local | Local | Local  | Local | Local  | Local |

## Branch
Config/MR/Bug/zz_Sizaan QA-4629 UAT Change Mobile devica.xx.xx.ORI

## Learned

## Description

## Code sections

## Files

## Resources

## Notes


 #qa

# QA-4629 [UAT] Change Mobile device


## Newer notes
- [ ] Nicole wants to know if it happens on all FM units or only this one
	- [x] NO Unique Id
		- [x] 4k to FM 3507i/3517i
		- [x] 4k to FM 3300...
		- [x] 4k to FM 3607...
		- [ ] 4k to FM 3707...
	- [ ] Unique Id
		- [ ] 4k to FM 3507i/3517i
		- [ ] 4k to FM 3300... (nope)
		- [ ] 4k to FM 3607...
		- [ ] 4k to FM 3707...
- [ ] We could hide the option
- [ ] What causes the error?
  
## Old notes
  
  Asset - Change mobile device: Error occurred while updating the entries




  [[STM-471 Streamax Decommissioning and ReCommissioning]]: Decommission and Recommission of STM: WIP



  - ERROR LOG
      EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
    <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <RequestId>1145137997978439680</RequestId>
      <AuthToken>a399fbd3-6188-4a24-8e50-cf2701e99bbd</AuthToken>
      <AccountId>7261693113146365683</AccountId>
      <RequestJson>{"AssetName":"Berno MiX 4000 Bench 01","HasBeenCommissioned":false,"DeviceTypeName":"FM 3507i/3517i","MobileDeviceId":"6183256567829462590","HasDeviceTypeIdentifier":false,"DeviceTypeIdentifierTitle":null,"ConfigChanged":true,"IridiumImei":"","IridiumContract":"","IridiumError":null,"IridiumSatelliteCapable":false,"HasIridiumImei":false,"CanDeactivateIridiumAccount":false,"CommunicationCapable":false,"SimCardPinCode":"","GprsCapable":false,"GprsEnabled":false,"GprsApnPointName":null,"GprsApnUsername":null,"GprsApnPassword":null,"GsmCapable":false,"GsmEnabled":false,"GsmMsisdnNumber":null,"SmsCapable":false,"SmsEnabled":false,"SmsMobileDeviceNumber":null,"SmsMessageCentreNumber":null,"SatelliteCapable":false,"SatalliteDeviceId":"","UploadScheduleId":null,"HasUploadSchedule":false,"IsMesaBased":true,"CanEditDetails":true,"CanEditSmsDetails":true,"CanEditGsmDetails":true,"CanEditSimPin":true,"CanEditApnName":true,"CanEditMobileDevice":true,"CanRemoveMobileDevice":true,"CanEditSatelliteDetails":true,"CanEditIridiumSatelliteDetails":true,"CompileCapable":true,"CanCompileConfig":true,"CanUploadConfig":true,"CanViewCommsLog":true,"OrgIsMiXTalkEnabled":true,"MiXTalkIMEI":null,"MiXTalkSIMNumber":null,"MiXTalkCarrierID":0,"MiXTalkCarriers":[{"CarrierID":1,"Carrier":"MTN"},{"CarrierID":2,"Carrier":"Vodacom"},{"CarrierID":3,"Carrier":"Telkom SA Ltd"}],"CommissioningStatus":{"CommissioningStatus":"Not available","CommandType":"MasterNumber","CreationDateUtc":null,"ExpiryDateUtc":null,"MessageStatusDateUtc":null},"ShowOBCResendCommissioningSMS":false,"Tabs":null,"OrgIsStreamaxEnabled":false,"StreamaxDeviceTypes":null,"StreamaxSerialNumber":null,"DeviceIsStreamaxEnabled":true,"CanEditStreamaxDetails":true,"deviceTypeIdentifierValueUI":"132456789021212"}</RequestJson>
      <RequestUrl>PUT https://uat.mixtelematics.com:443/DynaMiX.API/fleet-admin/assets/commissioning/-3050897502994317689/1145135692008935424</RequestUrl>
    </ApiRequestInfo>
      Exception Type: System.Exception
    EXCEPTION! An error occurred while updating the entries. See the inner exception for details.
      Exception Type: System.Data.Entity.Infrastructure.DbUpdateException
      Stack trace    at System.Data.Entity.Internal.InternalContext.SaveChanges()
      at DynaMiX.Data.ConfigAdmin.ConfigAdminDbContext.SaveChanges(ISession session) in D:\b\1\_work\669\s\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminDbContext.cs:line 271
      at DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.MobileUnitManager.DoUpdateMobileDevice(String authToken, IMobileDevice resolvedMobileDeviceFromUi, Int64 orgId, Nullable`1 assetId) in D:\b\1\_work\669\s\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs:line 1694
      at DynaMiX.Logic.ConfigAdmin.MobileDeviceManager.UpdateMobileDevice(String authToken, Int64 orgId, IMobileDevice fromUi, Nullable`1 assetId) in D:\b\1\_work\669\s\Logic\DynaMiX.Logic\ConfigAdmin\MobileDeviceManager.cs:line 135
      at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary`2 propertyValueDictionaryFromUi, Int64 correlationId, Boolean configChanged) in D:\b\1\_work\669\s\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 157
      at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in D:\b\1\_work\669\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 1172
      at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_2(Object args) in D:\b\1\_work\669\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 154
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__2(Object args) in D:\b\1\_work\669\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 501
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\1\_work\669\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
      at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\669\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
      at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\669\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148
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



      "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <RequestId>1146156659778613248</RequestId>
  <AuthToken>0f1ed52e-7d34-4390-900a-9fd670a37077</AuthToken>
  <AccountId>-3808369611166108857</AccountId>
  <RequestJson>{\"AssetName\":\"MiX 4000 Events Tests\",\"HasBeenCommissioned\":false,\"DeviceTypeName\":\"FM 3507i/3517i\",\"MobileDeviceId\":\"6183256567829462590\",\"HasDeviceTypeIdentifier\":false,\"DeviceTypeIdentifierTitle\":null,\"ConfigChanged\":true,\"IridiumImei\":\"\",\"IridiumContract\":\"\",\"IridiumError\":null,\"IridiumSatelliteCapable\":false,\"HasIridiumImei\":false,\"CanDeactivateIridiumAccount\":false,\"CommunicationCapable\":false,\"SimCardPinCode\":\"\",\"GprsCapable\":false,\"GprsEnabled\":false,\"GprsApnPointName\":null,\"GprsApnUsername\":null,\"GprsApnPassword\":null,\"GsmCapable\":false,\"GsmEnabled\":false,\"GsmMsisdnNumber\":null,\"SmsCapable\":false,\"SmsEnabled\":false,\"SmsMobileDeviceNumber\":null,\"SmsMessageCentreNumber\":null,\"SatelliteCapable\":false,\"SatalliteDeviceId\":\"\",\"UploadScheduleId\":null,\"HasUploadSchedule\":false,\"IsMesaBased\":true,\"CanEditDetails\":true,\"CanEditSmsDetails\":true,\"CanEditGsmDetails\":true,\"CanEditSimPin\":true,\"CanEditApnName\":true,\"CanEditMobileDevice\":true,\"CanRemoveMobileDevice\":true,\"CanEditSatelliteDetails\":true,\"CanEditIridiumSatelliteDetails\":true,\"CompileCapable\":true,\"CanCompileConfig\":true,\"CanUploadConfig\":true,\"CanViewCommsLog\":true,\"OrgIsMiXTalkEnabled\":false,\"MiXTalkIMEI\":null,\"MiXTalkSIMNumber\":null,\"MiXTalkCarrierID\":0,\"MiXTalkCarriers\":null,\"CommissioningStatus\":null,\"ShowOBCResendCommissioningSMS\":false,\"Tabs\":null,\"OrgIsStreamaxEnabled\":false,\"StreamaxDeviceTypes\":null,\"StreamaxSerialNumber\":null,\"DeviceIsStreamaxEnabled\":true,\"CanEditStreamaxDetails\":true,\"deviceTypeIdentifierValueUI\":null}</RequestJson>
  <RequestUrl>PUT http://uk.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/7319726631395308757/1146156135637200896</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! An error occurred while updating the entries. See the inner exception for details.
\tException Type: System.Data.Entity.Infrastructure.DbUpdateException
\tStack trace    at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at DynaMiX.Data.ConfigAdmin.ConfigAdminDbContext.SaveChanges(ISession session) in D:\\b\\1\\_work\\619\\s\\Data\\DynaMiX.Data\\ConfigAdmin\\ConfigAdminDbContext.cs:line 271
   at DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.MobileUnitManager.DoUpdateMobileDevice(String authToken, IMobileDevice resolvedMobileDeviceFromUi, Int64 orgId, Nullable`1 assetId) in D:\\b\\1\\_work\\619\\s\\Logic\\DynaMiX.Logic\\ConfigAdmin\\MobileUnitLevel\\MobileUnitManager.cs:line 1694
   at DynaMiX.Logic.ConfigAdmin.MobileDeviceManager.UpdateMobileDevice(String authToken, Int64 orgId, IMobileDevice fromUi, Nullable`1 assetId) in D:\\b\\1\\_work\\619\\s\\Logic\\DynaMiX.Logic\\ConfigAdmin\\MobileDeviceManager.cs:line 135
   at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary`2 propertyValueDictionaryFromUi, Int64 correlationId, Boolean configChanged) in D:\\b\\1\\_work\\619\\s\\Logic\\DynaMiX.Logic\\FleetAdmin\\AssetCommissioningManager.cs:line 156
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in D:\\b\\1\\_work\\619\\s\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 1164
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_2(Object args) in D:\\b\\1\\_work\\619\\s\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets\\AssetCommissioningModule.cs:line 154
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__2(Object args) in D:\\b\\1\\_work\\619\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 501
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\\b\\1\\_work\\619\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\\b\\1\\_work\\619\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\\b\\1\\_work\\619\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 148
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
    "Machine": "HSDUBIIS12",


    EXCEPTION! <?xml version="1.0" encoding="utf-16"?> <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <RequestId>1136717368134545408</RequestId> <AuthToken>71354c9d-c7f3-4dde-8833-051b0f4bb2c7</AuthToken> <AccountId>5789538841525371353</AccountId> <RequestJson>{"AssetName":"SB Commissioning test M6k","HasBeenCommissioned":false,"DeviceTypeName":"FM 3607i/3617i","MobileDeviceId":"-7681409220681262334","HasDeviceTypeIdentifier":false,"DeviceTypeIdentifierTitle":null,"ConfigChanged":true,"IridiumImei":"","IridiumContract":"","IridiumError":null,"IridiumSatelliteCapable":false,"HasIridiumImei":false,"CanDeactivateIridiumAccount":false,"CommunicationCapable":false,"SimCardPinCode":"","GprsCapable":false,"GprsEnabled":false,"GprsApnPointName":null,"GprsApnUsername":null,"GprsApnPassword":null,"GsmCapable":false,"GsmEnabled":false,"GsmMsisdnNumber":null,"SmsCapable":false,"SmsEnabled":false,"SmsMobileDeviceNumber":null,"SmsMessageCentreNumber":null,"SatelliteCapable":false,"SatalliteDeviceId":"","UploadScheduleId":null,"HasUploadSchedule":false,"IsMesaBased":true,"CanEditDetails":true,"CanEditSmsDetails":true,"CanEditGsmDetails":true,"CanEditSimPin":true,"CanEditApnName":true,"CanEditMobileDevice":true,"CanRemoveMobileDevice":true,"CanEditSatelliteDetails":true,"CanEditIridiumSatelliteDetails":true,"CompileCapable":true,"CanCompileConfig":true,"CanUploadConfig":true,"CanViewCommsLog":true,"OrgIsMiXTalkEnabled":false,"MiXTalkIMEI":null,"MiXTalkSIMNumber":null,"MiXTalkCarrierID":0,"MiXTalkCarriers":null,"CommissioningStatus":null,"ShowOBCResendCommissioningSMS":false,"Tabs":null,"OrgIsStreamaxEnabled":false,"StreamaxDeviceTypes":null,"StreamaxSerialNumber":null,"DeviceIsStreamaxEnabled":true,"CanEditStreamaxDetails":true,"deviceTypeIdentifierValueUI":"995308982931044"}</RequestJson> <RequestUrl>PUT http://integration.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/6047289984099389068/1136707909532860416</RequestUrl> </ApiRequestInfo> Exception Type: System.Exception EXCEPTION! An error occurred while updating the entries. See the inner exception for details. Exception Type: System.Data.Entity.Infrastructure.DbUpdateException Stack trace at System.Data.Entity.Internal.InternalContext.SaveChanges() at DynaMiX.Data.ConfigAdmin.ConfigAdminDbContext.SaveChanges(ISession session) in D:\b\1_work\526\s\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminDbContext.cs:line 271 at DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.MobileUnitManager.DoUpdateMobileDevice(String authToken, IMobileDevice resolvedMobileDeviceFromUi, Int64 orgId, Nullable`1 assetId) in D:\b\1_work\526\s\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs:line 1694 at DynaMiX.Logic.ConfigAdmin.MobileDeviceManager.UpdateMobileDevice(String authToken, Int64 orgId, IMobileDevice fromUi, Nullable`1 assetId) in D:\b\1_work\526\s\Logic\DynaMiX.Logic\ConfigAdmin\MobileDeviceManager.cs:line 135 at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary`2 propertyValueDictionaryFromUi, Int64 correlationId, Boolean configChanged) in D:\b\1_work\526\s\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 156 at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in D:\b\1_work\526\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 1164 at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b_19_2(Object args) in D:\b\1_work\526\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 154 at DynaMiX.Core.Http.Nancy.ModuleBase.<>cDisplayClass46_0`1.<RegisterRoute>b2(Object args) in D:\b\1_work\526\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 501 at DynaMiX.Core.Http.Nancy.ModuleBase.<>cDisplayClass27_1`1.<HandleTyped>b_1() in D:\b\1_work\526\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1_work\526\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1_work\526\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148 EXCEPTION! An error occurred while updating the entries. See the inner exception for details. Exception Type: System.Data.Entity.Core.UpdateException Stack trace at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update() at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess) at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction) at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation) at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction) at System.Data.Entity.Internal.InternalContext.SaveChanges() EXCEPTION! Cannot insert the value NULL into column 'Value', table 'DeviceConfiguration.mobileunit.OverridenDeviceProperties'; column does not allow nulls. INSERT fails. The statement has been terminated. Exception Type: System.Data.SqlClient.SqlException Stack trace at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction) at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose) at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady) at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted) at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest) at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry) at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry) at System.Data.SqlClient.SqlCommand.ExecuteNonQuery() at System.Data.Entity.Infrastructure.Interception.InternalDispatcher`1.Dispatch[TTarget,TInterceptionContext,TResult](TTarget target, Func`3 operation, TInterceptionContext interceptionContext, Action`3 executing, Action`3 executed) at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.NonQuery(DbCommand command, DbCommandInterceptionContext interceptionContext) at System.Data.Entity.Core.Mapping.Update.Internal.DynamicUpdateCommand.Execute(Dictionary`2 identifierValues, List`1 generatedValues) at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
