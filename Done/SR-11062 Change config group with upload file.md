# SR-11062 Change config group with upload file

/import

INT: ORG: MR Test

- Error"
  2021-08-30 13:13:11 AssetId 1167679893996003328 retrieved MobileUnit configurationGroupID 4796642020391311472
  2021-08-30 13:13:12 AssetId 1167679893996003328 new configurationGroupID -6275835608516656377
  2021-08-30 13:13:12 old configId 4796642020391311472
  2021-08-30 13:13:12 Changes taking place
  2021-08-30 13:13:19 RESET TO GROUP CONFIG elapsed time: 6831
  2021-08-30 13:13:19 UpdateAssetConfigGroup exception An error occurred while updating the entries. See the inner exception for details.System.Data.Entity.Core.UpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: The UPDATE permission was denied on the object 'MobileUnits', database 'DeviceConfiguration', schema 'dynamix'.
    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
    --- End of inner exception stack trace ---
    at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
    at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
    at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
    at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
    at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
    at System.Data.Entity.Internal.InternalContext.SaveChanges()
  2021-08-30 13:13:20 Sending success notification
  2021-08-30 13:13:20 Generating email notification
  2021-08-30 13:13:20 Translating email notification
  2021-08-30 13:13:20 GetAdvancedTranslation New
  2021-08-30 13:13:20 Translation Error for Assets import request succeeded - en_gb - mixfleet_backend - 
  2021-08-30 13:13:20 Sending email Assets import request succeeded to email address maletsham@mixtel.com
  2021-08-30 13:13:20 QueueMessageToSendViaEmail Sending message to notification Api to email:maletsham@mixtel.com , subject :Assets import request succeede...
  2021-08-30 13:18:11 Deserializing D:\Imports\AssetImports/df9e0069-488f-4bb7-958a-7d277b772aea.csv for maletsham@mixtel.com...
  2021-08-30 13:18:14 Starting to process file D:\Imports\AssetImports/df9e0069-488f-4bb7-958a-7d277b772aea.csv
  2021-08-30 13:18:14 Processing 1 records...
  2021-08-30 13:18:15 Completed processing file D:\Imports\AssetImports/df9e0069-488f-4bb7-958a-7d277b772aea.csv with errors: False
  2021-08-30 13:18:15 Updating 1 assets for orgId 673348881058963259
  2021-08-30 13:18:30 Adding 1 assets for orgId 673348881058963259
  2021-08-30 13:18:35 UpdateAssetDetails config update -6275835608516656377
  2021-08-30 13:18:42 AssetId 1167679893996003328 excell configurationGroupID -6275835608516656377
  2021-08-30 13:18:57 AssetId 1167679893996003328 retrieved MobileUnit configurationGroupID 4796642020391311472
  2021-08-30 13:18:57 AssetId 1167679893996003328 new configurationGroupID -6275835608516656377
  2021-08-30 13:19:10 old configId 4796642020391311472
  2021-08-30 13:19:10 Changes taking place
  2021-08-30 13:19:11 RESET TO GROUP CONFIG elapsed time: 461
  2021-08-30 13:29:19 UpdateAssetConfigGroup exception An error occurred while updating the entries. See the inner exception for details.System.Data.Entity.Core.UpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: The UPDATE permission was denied on the object 'MobileUnits', database 'DeviceConfiguration', schema 'dynamix'.
    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
    --- End of inner exception stack trace ---
    at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
    at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
    at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
    at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
    at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
    at System.Data.Entity.Internal.InternalContext.SaveChanges()


