---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-02-13T15:34
---

# OE-608 Error when loading YS_Bench Units

Date: 2025-02-13 Time: 11:43
Parent:: ==xxxx==
Friend:: [[2025-02-13]]
JIRA:OE-608 Error when loading YS_Bench Units
[[OE-608] Getting the an 500-OK error when trying to access the Config groups (beta) page on YS_Bench Units - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-608)


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

![[OE-608 Error when loading YS_Bench Units Error moving.png]]

```txt
Unathi and I are getting the following error when trying to access the Config groups (beta) page on YS_Bench Units
CorrelationId:1626677056258179073|/api/configuration-groups-multiselect/groupId/-6688118483549227136/alerts|02/13/2025 08:52:26|Error:MiX.Core.Clients.HttpRetries+HttpInvalidRequestException: Response status code does not indicate success: 500 ({"ExceptionMessage":"Error converting data type nvarchar to bigint.","ExceptionType":"System.Data.SqlClient.SqlException","StackTrace":" at System.Data.SqlClient.SqlCommand.\u003C\u003Ec.\u003CExecuteDbDataReaderAsync\u003Eb__126_0(Task\u00601 result)\n at System.Threading.Tasks.ContinuationResultTaskFromResultTask\u00602.InnerInvoke()\n at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)\n--- End of stack trace from previous location ---\n at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)\n at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task\u0026 currentTaskSlot, Thread threadPoolThread)\n--- End of stack trace from previous location ---\n at Dapper.SqlMapper.QueryAsync[T](IDbConnection cnn, Type effectiveType, CommandDefinition command) in /_/Dapper/SqlMapper.Async.cs:line 418\n at Config.Api.DataAccess.ConfigRepository.GetConfigurationGroupsMultiselectAssetAlertsList(List\u00601 configurationGroupIds) in /home/vsts/work/1/s/Config.Api.DataAccess/Repository/TemplateLevel/ConfigurationGroup.cs:line 266\n at Config.Api.DataAccess.ConfigRepository.GetConfigurationGroupsMultiselectAssetAlertsList(List\u00601 configurationGroupIds) in /home/vsts/work/1/s/Config.Api.DataAccess/Repository/TemplateLevel/ConfigurationGroup.cs:line 279\n at Config.Api.Logic.Managers.TemplateLevel.ConfigurationGroupManager.GetConfigurationGroupsMultiselectAssetAlertsList(String authToken, Int64 groupId, List\u00601 configurationGroupIds, Nullable\u00601 correlationId) in /home/vsts/work/1/s/Config.Api.Logic/Managers/TemplateLevel/ConfigurationGroupManager.cs:line 399\n at Config.Api.Controllers.ConfigurationGroupLevel.ConfigurationGroupController.GetConfigurationGroupsAlerts(String authToken, Int64 groupId, List\u00601 configurationGroupIds, Nullable\u00601 correlationId) in /home/vsts/work/1/s/Config.Api/Controllers/ConfigurationGroupLevel/ConfigurationGroupController.cs:line 104\n at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(ActionContext actionContext, IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeActionMethodAsync\u003Eg__Logged|12_1(ControllerActionInvoker invoker)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeNextActionFilterAsync\u003Eg__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State\u0026 next, Scope\u0026 scope, Object\u0026 state, Boolean\u0026 isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeInnerFilterAsync\u003Eg__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeFilterPipelineAsync\u003Eg__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)\n at MiX.Core.Web.Abstractions.ConfigurationExtensions.\u003C\u003Ec__DisplayClass1_0.\u003C\u003CUseMiXRequestLogging\u003Eb__0\u003Ed.MoveNext()\n--- End of stack trace from previous location ---\n at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)\n at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider)\n at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context)\n at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)\n at Config.Api.Helpers.ExecutionTimeMiddleware.InvokeAsync(HttpContext httpContext) in /home/vsts/work/1/s/Config.Api/Helpers/ExecutionTimeMiddleware.cs:line 55\n at MiX.Core.Telemetry.Web.DurationMetricsMiddleware.InvokeAsync(HttpContext context)\n at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddlewareImpl.\u003CInvoke\u003Eg__Awaited|10_0(ExceptionHandlerMiddlewareImpl middleware, HttpContext context, Task task)"}). at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExitRetryAsync(CancellationToken cancellationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExecuteActionAsync[T](Func`1 func, CancellationToken cancellationToken, Action`1 validateResult, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.GetAsync[T](Func`1 requestFunc, CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.Get[T](Func`1 requestFunc) at MiX.ConfigInternal.Api.Client.Repositories.InternalConfigurationGroupsRepository.GetConfigurationGroupsAlerts(String authToken, Int64 groupId, List`1 configurationGroupIds, Nullable`1 correlationId) at MiX.Config.Frangular.Logic.ConfigurationGroupManager.ConfigurationGroupManager.GetConfigurationGroupsAlerts(String authToken, Int64 orgId, List`1 configurationGroupIds, Nullable`1 correlationId) in /home/vsts/work/1/s/MiX.Config.Frangular.Logic/ConfigurationGroupManager/ConfigurationGroupManager.cs:line 55 at MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.GetConfigurationGroupsAlerts(String groupId, ConfigurationGroupIdsCarrier configurationGroupIds) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:line 136 at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:line 119 at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)

[https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-6688118483549227136/alerts](https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-6688118483549227136/alerts "https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupid/-6688118483549227136/alerts") He moved some assets from the DME config group to the Oyster config group, so I suspect it could have been that? DME CG: Default configuration group for Digital Matter

Oyster CG: Config Oyster Also, when he actioned the config group move, none of the assets he selected were moved to the new group ( but if you search for them manually, then they do appear in the config oyster group...)
```


![[OE-608 Error when loading YS_Bench Units After move-1.png]]


## TEST

- Testing on API > SQL
- Fixed in SQL using CTE, replaced stored PRoc - seems to work
- [Pull request 118937: OE-608: Fixed irrelevant muproperties issue resulting in type convertion issu... - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/118937?_a=files)
- 