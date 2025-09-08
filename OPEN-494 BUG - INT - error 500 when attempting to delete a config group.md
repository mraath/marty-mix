---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-08T12:33
---

# OPEN-494

Date: 2025-09-08 Time: 10:47
Parent:: ==xxxx==
Friend:: [[2025-09-08]]
JIRA:OPEN-494
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-494)


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

(This could be a database-specific bug but please resolve it if possible ![slightly smiling face](https://pf-emoji-service--cdn.us-east-1.prod.public.atl-paas.net/standard/ef8b0642-7523-4e13-9fd3-01b65648acf6/32x32/1f642.png) )

Amy Bench Units

Configuration groups (beta) | MiX4000 device | 25.10 Regression CG | Remove

![[OPEN-494 BUG - INT - error 500 when attempting to delete a config group CG Remove.png]]

## Error Log
```error
CorrelationId:1688694917606637568|/api/configuration-groups-delete/495309904600710308/groupId/-5401647754082838271|08/03/2025 12:09:13|Error:MiX.Core.Clients.HttpRetries+HttpInvalidRequestException: Response status code does not indicate success: 500 ({"ExceptionMessage":"The DELETE statement conflicted with the REFERENCE constraint \u0022FK_MobileUnits_ConfigurationGroups\u0022. The conflict occurred in database \u0022DeviceConfiguration\u0022, table \u0022mobileunit.MobileUnits\u0022, column \u0027ConfigurationGroupKey\u0027.\nThe statement has been terminated.","ExceptionType":"System.Data.SqlClient.SqlException","StackTrace":" at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action\u00601 wrapCloseInAction)\n at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)\n at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean\u0026 dataReady)\n at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)\n at System.Data.SqlClient.SqlCommand.CompleteAsyncExecuteReader()\n at System.Data.SqlClient.SqlCommand.EndExecuteNonQueryInternal(IAsyncResult asyncResult)\n at System.Data.SqlClient.SqlCommand.EndExecuteNonQuery(IAsyncResult asyncResult)\n at System.Threading.Tasks.TaskFactory\u00601.FromAsyncCoreLogic(IAsyncResult iar, Func\u00602 endFunction, Action\u00601 endAction, Task\u00601 promise, Boolean requiresSynchronization)\n--- End of stack trace from previous location ---\n at Dapper.SqlMapper.ExecuteImplAsync(IDbConnection cnn, CommandDefinition command, Object param) in /_/Dapper/SqlMapper.Async.cs:line 646\n at Config.Api.DataAccess.ConfigRepository.DeleteConfigurationGroup(Int64 configurationGroupId) in /home/vsts/work/1/s/Config.Api.DataAccess/Repository/TemplateLevel/ConfigurationGroup.cs:line 838\n at Config.Api.DataAccess.ConfigRepository.DeleteConfigurationGroup(Int64 configurationGroupId) in /home/vsts/work/1/s/Config.Api.DataAccess/Repository/TemplateLevel/ConfigurationGroup.cs:line 852\n at Config.Api.Logic.Managers.TemplateLevel.ConfigurationGroupManager.DeleteConfigurationGroup(String authToken, Int64 configurationGroupId, Int64 groupId) in /home/vsts/work/1/s/Config.Api.Logic/Managers/TemplateLevel/ConfigurationGroupManager.cs:line 1142\n at Config.Api.Controllers.ConfigurationGroupLevel.ConfigurationGroupController.DeleteConfigurationGroup(String authToken, Int64 configurationGroupId, Int64 groupId) in /home/vsts/work/1/s/Config.Api/Controllers/ConfigurationGroupLevel/ConfigurationGroupController.cs:line 49\n at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(ActionContext actionContext, IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeActionMethodAsync\u003Eg__Logged|12_1(ControllerActionInvoker invoker)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeNextActionFilterAsync\u003Eg__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State\u0026 next, Scope\u0026 scope, Object\u0026 state, Boolean\u0026 isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeInnerFilterAsync\u003Eg__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeFilterPipelineAsync\u003Eg__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)\n at MiX.Core.Web.Abstractions.ConfigurationExtensions.\u003C\u003Ec__DisplayClass1_0.\u003C\u003CUseMiXRequestLogging\u003Eb__0\u003Ed.MoveNext()\n--- End of stack trace from previous location ---\n at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)\n at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider)\n at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context)\n at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)\n at Config.Api.Helpers.ExecutionTimeMiddleware.InvokeAsync(HttpContext httpContext) in /home/vsts/work/1/s/Config.Api/Helpers/ExecutionTimeMiddleware.cs:line 55\n at MiX.Core.Telemetry.Web.DurationMetricsMiddleware.InvokeAsync(HttpContext context)\n at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddlewareImpl.\u003CInvoke\u003Eg__Awaited|10_0(ExceptionHandlerMiddlewareImpl middleware, HttpContext context, Task task)"}). at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExitRetryAsync(CancellationToken cancellationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExecuteActionAsync[T](Func`1 func, CancellationToken cancellationToken, Action`1 validateResult, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.GetAsync[T](Func`1 requestFunc, CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.Get[T](Func`1 requestFunc) at MiX.ConfigInternal.Api.Client.Repositories.InternalConfigurationGroupsRepository.DeleteConfigurationGroup(String authToken, Int64 groupId, Int64 configurationGroupId, Nullable`1 correlationId) at MiX.Config.Frangular.Logic.ConfigurationGroupManager.ConfigurationGroupManager.DeleteConfigurationGroup(String authToken, Int64 groupIdL, Int64 configurationGroupIdL, Nullable`1 correlationId) in /home/vsts/work/1/s/MiX.Config.Frangular.Logic/ConfigurationGroupManager/ConfigurationGroupManager.cs:line 177 at MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.DeleteConfigurationGroup(String groupId, String configurationGroupId) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:line 430 at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:line 119 at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)
```

https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-delete/495309904600710308/groupId/-5401647754082838271

## Steps

These two were still connected:
MobileUnitId
1636801500414148608
1585809652770967552


