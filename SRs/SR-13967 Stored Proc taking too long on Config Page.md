---
status: closed
date: 2022-10-31
comment: Checking LOG
priority: 1
---

Date: 2022-10-31 Time: 14:59
Parent:: xxxx
Friend:: [[2022-10-31]]
JIRA:SR-13967 Stored Proc taking too long on Config Page

# SR-13967 Stored Proc taking too long on Config Page

## Image

## Original issue

- <RequestUrl>POST [http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/2439978887618476175/config_groups/0/assetlist](http://uk.mixtelematics.com/DynaMiX.API/config-admin/organisations/2439978887618476175/config_groups/0/assetlist)</RequestUrl>  
</ApiRequestInfo>  
Exception Type: System.Exception  
**EXCEPTION! A task was canceled.**  
Exception Type: System.Threading.Tasks.TaskCanceledException  
Stack trace at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(String callerMemberName, String callerFilePath, Int32 callerLineNumber) in D:\b\2_work\1893\s\MiX.Core\Retries\ElasticRetryStrategy.cs:line 110  
at MiX.Core.Retries.RetryStrategy.<ExitRetryAsync>d__33.MoveNext() in D:\b\2_work\1893\s\MiX.Core\Retries\RetryStrategy.cs:line 362  
— End of stack trace from previous location where exception was thrown —  
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()  
at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)  
at MiX.Core.Retries.RetryStrategy.<ExecuteActionWithTraceAsync>d__29`1.MoveNext() in D:\b\2_work\1893\s\MiX.Core\Retries\RetryStrategy.cs:line 295  
— End of stack trace from previous location where exception was thrown —  
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()  
at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)  
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)  
at MiX.Core.Clients.HttpRetries.<GetAsync>d__12`1.MoveNext()  
— End of stack trace from previous location where exception was thrown —  
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()  
at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)  
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)  
at MiX.Core.Clients.HttpRetries.<Get>d__11`1.MoveNext()  
— End of stack trace from previous location where exception was thrown —  
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()  
at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)  
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)  
at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitRepository.<GetLatestUploadMessageStatusesForOrg>d__33.MoveNext()  
— End of stack trace from previous location where exception was thrown —  
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()  
at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)  
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)  
at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.GetConfigGroupAssetList(String authToken, Int64 orgId, Int64 configGroupId, ListQueryCarrier queryCarrier) in D:\b\3_work\61\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 633  
at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.<.ctor>b__14_3(Object args) in D:\b\3_work\61\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 108  
at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__1(Object args) in D:\b\3_work\61\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 499  
at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\3_work\61\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287  
at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\3_work\61\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214  
at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\3_work\61\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148

## Latest issue

- <RequestJson>{"AssetIds":["1330171864710946816"]}</RequestJson>
<RequestUrl>POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/2366487117609703219/config_groups/7369698011961357451/assets</RequestUrl>
</ApiRequestInfo>
Exception Type: System.Exception
EXCEPTION! Communication with the underlying transaction manager has failed.
Exception Type: System.Transactions.TransactionManagerCommunicationException
Stack trace at System.Transactions.TransactionInterop.GetOletxTransactionFromTransmitterPropigationToken(Byte[] propagationToken)
at System.Transactions.TransactionStatePSPEOperation.PSPEPromote(InternalTransaction tx)
at System.Transactions.TransactionStateDelegatedBase.EnterState(InternalTransaction tx)
at System.Transactions.EnlistableStates.Promote(InternalTransaction tx)
at System.Transactions.Transaction.Promote()
at System.Transactions.TransactionInterop.ConvertToOletxTransaction(Transaction transaction)
at System.Transactions.TransactionInterop.GetExportCookie(Transaction transaction, Byte[] whereabouts)
at System.Data.SqlClient.SqlInternalConnection.GetTransactionCookie(Transaction transaction, Byte[] whereAbouts)
at System.Data.SqlClient.SqlInternalConnection.EnlistNonNull(Transaction tx)
at System.Data.SqlClient.SqlInternalConnection.Enlist(Transaction tx)
at System.Data.ProviderBase.DbConnectionInternal.ActivateConnection(Transaction transaction)
at System.Data.ProviderBase.DbConnectionPool.PrepareConnection(DbConnection owningObject, DbConnectionInternal obj, Transaction transaction)
at System.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, UInt32 waitForMultipleObjectsTimeout, Boolean allowCreate, Boolean onlyOneCheckConnection, DbConnectionOptions userOptions, DbConnectionInternal& connection)
at System.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal& connection)
at System.Data.ProviderBase.DbConnectionFactory.TryGetConnection(DbConnection owningConnection, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal oldConnection, DbConnectionInternal& connection)
at System.Data.ProviderBase.DbConnectionInternal.TryOpenConnectionInternal(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
at System.Data.SqlClient.SqlConnection.TryOpenInner(TaskCompletionSource`1 retry)
at System.Data.SqlClient.SqlConnection.TryOpen(TaskCompletionSource`1 retry)
at System.Data.SqlClient.SqlConnection.Open()
at DynaMiX.Core.DataAccess.DALC.DALCBase.CreateConnection(String connectionString) in D:\b\1_work\146\s\Core\DynaMiX.Core.DataAccess\DALC\DALCBase.cs:line 131
at DynaMiX.Core.DataAccess.DALC.DALCBase.ExecReader(String connectionString, String commandText, Int32 commandTimeout, CommandType commandType, ParameterCacheMode cacheMode, Object[] parameterValues) in D:\b\1_work\146\s\Core\DynaMiX.Core.DataAccess\DALC\DALCBase.cs:line 327
at DynaMiX.Core.DataAccess.DALC.Sprocs.EntityListSproc`1.Execute(ExecutionContext context, DbConnection connection) in D:\b\1_work\146\s\Core\DynaMiX.Core.DataAccess\DALC\Sprocs\EntityListSproc.cs:line 31
at DynaMiX.Data.Groups.GroupsDb.GetParentGroupHierarchyForEntity(Int64 entityId, String entityType) in D:\b\1_work\146\s\Data\DynaMiX.Data\Groups\GroupsDb.cs:line 814
at DynaMiX.Logic.BaseApp.Authorisation.PermissionsResolver.Authorise(Int64 permissionId, Int64 accountId, String entityType, Int64 entityId) in D:\b\1_work\146\s\Logic\DynaMiX.Logic\BaseApp\Authorisation\PermissionsResolver.cs:line 280
at DynaMiX.Logic.BaseApp.Authorisation.AuthorisationManager.AuthoriseSession(String authToken, Int64 permissionId, String entityType, Int64 entityId, String action) in D:\b\1_work\146\s\Logic\DynaMiX.Logic\BaseApp\Authorisation\AuthorisationManager.cs:line 288
at DynaMiX.Logic.BaseApp.Authorisation.Aspects.AuthoriseEntityAttribute.OnEntry(MethodExecutionArgs args) in D:\b\1_work\146\s\Logic\DynaMiX.Logic\BaseApp\Authorisation\Aspects\AuthoriseEntityAttribute.cs:line 136
at DynaMiX.Logic.FleetAdmin.AssetManager.GetAsset(String authToken, Int64 assetId) in D:\b\1_work\146\s\Logic\DynaMiX.Logic\FleetAdmin\Assets\AssetManager.cs:line 0
at DynaMiX.Logic.ConfigAdmin.TemplateLevel.ConfigurationGroupManager.UpdateAssetsConfigurationGroup(String authToken, Int64 orgId, List`1 assetIds, Int64 configurationGroupId, Int64 correlationId) in D:\b\1_work\146\s\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs:line 257
at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.UpdateAssetsConfigGroup(String authToken, Int64 orgId, Int64 configGroupId, List`1 assetIds) in D:\b\1_work\146\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 851
at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.<.ctor>b__14_6(Object args) in D:\b\1_work\146\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 111
at DynaMiX.Core.Http.Nancy.ModuleBase.<>c_DisplayClass46_0`1.<RegisterRoute>b_1(Object args) in D:\b\1_work\146\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 499
at DynaMiX.Core.Http.Nancy.ModuleBase.<>c_DisplayClass27_1`1.<HandleTyped>b_1() in D:\b\1_work\146\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1_work\146\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1_work\146\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148
EXCEPTION! The MSDTC transaction manager was unable to pull the transaction from the source transaction manager due to communication problems. Possible causes are: a firewall is present and it doesn't have an exception for the MSDTC process, the two machines cannot find each other by their NetBIOS names, or the support for network transactions is not enabled for one of the two transaction managers. (Exception from HRESULT: 0x8004D02B)
Exception Type: System.Runtime.InteropServices.COMException
Stack trace at System.Transactions.Oletx.IDtcProxyShimFactory.ReceiveTransaction(UInt32 propgationTokenSize, Byte[] propgationToken, IntPtr managedIdentifier, Guid& transactionIdentifier, OletxTransactionIsolationLevel& isolationLevel, ITransactionShim& transactionShim)
at System.Transactions.TransactionInterop.GetOletxTransactionFromTransmitterPropigationToken(Byte[] propagationToken)

## Tests

- Specific: https://app.logz.io/#/dashboard/kibana/discover/?_a=(columns:!(message),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:AppName,negate:!f,params:(query:DynaMiX.Api),type:phrase),query:(match_phrase:(AppName:DynaMiX.Api))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:Env,negate:!f,params:(query:UK),type:phrase),query:(match_phrase:(Env:UK))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:(query:'%22http:%2F%2Fuk.mixtelematics.com:80%2FDynaMiX.API%2Fconfig-admin%2Forganisations%2F2439978887618476175%2Fconfig_groups%2F0%2Fassetlist%22'),type:phrase),query:(match_phrase:(message:'%22http:%2F%2Fuk.mixtelematics.com:80%2FDynaMiX.API%2Fconfig-admin%2Forganisations%2F2439978887618476175%2Fconfig_groups%2F0%2Fassetlist%22')))),index:'logzioCustomerIndex*',interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15d,to:now))&accountIds=157986&switchToAccountId=157279
- More: https://app.logz.io/#/dashboard/kibana/discover/?_a=(columns:!(message),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:AppName,negate:!f,params:(query:DynaMiX.Api),type:phrase),query:(match_phrase:(AppName:DynaMiX.Api))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:Env,negate:!f,params:(query:UK),type:phrase),query:(match_phrase:(Env:UK))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:!(config-admin%2Forganisations%2F2439978887618476175%2Fconfig_groups%2F0%2Fassetlist,'object%20named%20!'PK!''),type:phrases,value:'config-admin%2Forganisations%2F2439978887618476175%2Fconfig_groups%2F0%2Fassetlist,%20object%20named%20!'PK!''),query:(bool:(minimum_should_match:1,should:!((match_phrase:(message:config-admin%2Forganisations%2F2439978887618476175%2Fconfig_groups%2F0%2Fassetlist)),(match_phrase:(message:'object%20named%20!'PK!''))))))),index:'logzioCustomerIndex*',interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))&_g=(filters:!(),refreshInterval:(pause:!f,value:300000),time:(from:'2022-11-07T06:40:00.000Z',to:now))&switchToAccountId=157279&accountIds=157986
- 

## Stored Proc

- [state].[MobileUnitMessage_GetLastMessageStatusesForMobileUnitListAndType]
- Johan Steenkamp is daar om te help!
- CommandIdType.SendConfig = 254
- CommandIdType.SendFirmware = 103
- CommandIdType.SendSettings = 255

```sql
DECLARE @groupId BIGINT = -8441185520557948197

DECLARE @typeList TABLE (  id BIGINT);
DECLARE @mobileUnitIds TABLE (  id BIGINT);

INSERT INTO @typeList (id) VALUES (254) --SendConfig
INSERT INTO @typeList (id) VALUES (103) --SendFirmware
INSERT INTO @typeList (id) VALUES (255) --SendSettings

USE DeviceConfiguration;

INSERT INTO @mobileUnitIds
  (id)
SELECT MobileUnitId 
FROM mobileunit.MobileUnits WITH (NOLOCK)
WHERE ConfigurationGroupKey IN (
	SELECT ConfigurationGroupKey  
FROM template.ConfigurationGroups WITH (NOLOCK)
WHERE LibraryKey IN (
		SELECT LibraryKey 
FROM library.libraries WITH (NOLOCK)
WHERE GroupId = @groupId
	)
)

USE [DeviceConfiguration.DataProcessing];

SELECT c.MessageSubType,
  MessageStatusDateUtc,
  MessageStatus,
  MobileUnitId
FROM (
    SELECT mum.MessageSubType,
    mum.CreationDateUtc,
    mum.MessageStatusDateUtc,
    mum.MessageId,
    mum.MessageStatus,
    mum.MessageKey,
    ROW_NUMBER() OVER ( PARTITION BY mum.MobileUnitId ORDER BY mum.MessageStatusDateUtc DESC ) AS rn, MobileUnitId
  FROM @typeList ids
    JOIN [state].[MobileUnitMessage] mum  WITH (NOLOCK)
    ON mum.MessageSubType = ids.id
    JOIN @mobileUnitIds muIds
    ON muIds.id = mum.MobileUnitId
    ) c
WHERE       rn IN (1)
ORDER BY    MobileUnitId,c.MessageSubType, MessageStatusDateUtc
```

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.15 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-13967_Stored_Proc_taking_too_long.22.15.ORI

## Learned

## Description

## Code sections

## Files

## Resources

## Notes

