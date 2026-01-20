---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-20T16:56
---

# OPEN-1371 INT Error 500 on Config Group Alerts CHINESE

Date: 2026-01-16 Time: 10:27
Parent:: [[timezone]]
Friend:: [[2026-01-16]]
JIRA:OPEN-1371 INT Error 500 on Config Group Alerts
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1371)


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

![[Pasted image 20260116102747.png]]

### Log

```cs
CorrelationId:1748104504199303168|/api/configuration-groups-multiselect/groupId/-5401647754082838271/alerts
|01/14/2026 10:41:43|Error:MiX.Core.Clients.HttpRetries+HttpInvalidRequestException: Response status code does not indicate success: 500 ({

"ExceptionMessage":"Object reference not set to an instance of an object.","ExceptionType":"System.NullReferenceException","StackTrace":" 

//API
at Config.Api.Logic.TimeZones.TimeZonesHelper.DateFormatConverter.GetRegionalFormatForDate(Int32 localeId, String languageCode) in /home/vsts/work/1/s/Config.Api.Logic/TimeZones/TimeZonesHelper.cs:
line 290
at Config.Api.Logic.TimeZones.TimeZonesHelper.GetShortDateTime(Nullable\u00601 dateTime, Int64 assetId, List\u00601 historicalTimeZones, MiXFleetUser userAccount) in /home/vsts/work/1/s/Config.Api.Logic/TimeZones/TimeZonesHelper.cs:
line 319
at Config.Api.Logic.Managers.TemplateLevel.ConfigurationGroupManager.ConvertAssetAlerts(String authToken, List\u00601 result, Int64 groupId, Nullable\u00601 correlationId) in /home/vsts/work/1/s/Config.Api.Logic/Managers/TemplateLevel/ConfigurationGroupManager.cs:
line 409
at Config.Api.Logic.Managers.TemplateLevel.ConfigurationGroupManager.GetConfigurationGroupsMultiselectAssetAlertsList(String authToken, Int64 groupId, List\u00601 configurationGroupIds, Nullable\u00601 correlationId) in /home/vsts/work/1/s/Config.Api.Logic/Managers/TemplateLevel/ConfigurationGroupManager.cs:
line 388
//API: GetConfigurationGroupsAlerts
at Config.Api.Controllers.ConfigurationGroupLevel.ConfigurationGroupController.GetConfigurationGroupsAlerts(String authToken, Int64 groupId, List\u00601 configurationGroupIds, Nullable\u00601 correlationId) in /home/vsts/work/1/s/Config.Api/Controllers/ConfigurationGroupLevel/ConfigurationGroupController.cs:
line 104

//Microsoft.AspNetCore
at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(ActionContext actionContext, IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeActionMethodAsync\u003Eg__Logged|12_1(ControllerActionInvoker invoker)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeNextActionFilterAsync\u003Eg__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State\u0026 next, Scope\u0026 scope, Object\u0026 state, Boolean\u0026 isCompleted)
at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeInnerFilterAsync\u003Eg__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeFilterPipelineAsync\u003Eg__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)
at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)
at MiX.Core.Web.Abstractions.ConfigurationExtensions.\u003C\u003Ec__DisplayClass1_0.\u003C\u003CUseMiXRequestLogging\u003Eb__0\u003Ed.MoveNext()
--- End of stack trace from previous location ---
at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)\n at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider)\n at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context)
at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)\n at Config.Api.Helpers.ExecutionTimeMiddleware.InvokeAsync(HttpContext httpContext) in /home/vsts/work/1/s/Config.Api/Helpers/ExecutionTimeMiddleware.cs:
line 55

at MiX.Core.Telemetry.Web.DurationMetricsMiddleware.InvokeAsync(HttpContext context)
at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddlewareImpl.\u003CInvoke\u003Eg__Awaited|10_0(ExceptionHandlerMiddlewareImpl middleware, HttpContext context, Task task)"}). 
at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) 
at MiX.Core.Retries.RetryStrategy.ExitRetryAsync(CancellationToken cancellationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) 
at MiX.Core.Retries.RetryStrategy.ExecuteActionAsync[T](Func`1 func, CancellationToken cancellationToken, Action`1 validateResult, String callerMemberName, String callerFilePath, Int32 callerLineNumber) 
at MiX.Core.Clients.HttpRetries.GetAsync[T](Func`1 requestFunc, CancellationToken cancelationToken, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.Get[T](Func`1 requestFunc) 


//CLIENT: GetConfigurationGroupsAlerts
at MiX.ConfigInternal.Api.Client.Repositories.InternalConfigurationGroupsRepository.GetConfigurationGroupsAlerts(String authToken, Int64 groupId, List`1 configurationGroupIds, Nullable`1 correlationId) 

//FR API: GetConfigurationGroupsAlerts
at MiX.Config.Frangular.Logic.ConfigurationGroupManager.ConfigurationGroupManager.GetConfigurationGroupsAlerts(String authToken, Int64 orgId, List`1 configurationGroupIds, Nullable`1 correlationId) in /home/vsts/work/1/s/MiX.Config.Frangular.Logic/ConfigurationGroupManager/ConfigurationGroupManager.cs:
line 55 
at MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.GetConfigurationGroupsAlerts(String groupId, ConfigurationGroupIdsCarrier configurationGroupIds) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:
line 136 


//Microsoft.AspNetCore
at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) 
at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) 
at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) 
at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) 
at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) 
at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) 
at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) 
at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) 

at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:
line 119
 
at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)
```

## Code

- **Chinese** (traditional) ALERTs bug

## Swagger test

b2f62e48-5863-47d0-b611-41add196e351
-5401647754082838271
[-2221726257111617269,-2440320943995442748,-3743982644936471179,7417790447252270150,-8709427607151919796,-3237025716664041701,-6151267166848528093]


## Missing

```txt
CultureInfo.GetCultures(CultureTypes.SpecificCultures) gets all the culture info for specific cultures in the system.
supportedCultures contains all the ones we support for eg. InsighReport

The problem is although our ids are found in supportedCultures, they are not found in CultureInfo.GetCultures.
This causes the issue we are having.
We found it for one, but it will do it for all of these...

    [0]: 1028
    [1]: 1064
    [2]: 1094
    [3]: 1117
    [4]: 1128
    [5]: 1131
    [6]: 1158
    [7]: 1164
    [8]: 2052
    [9]: 2074
    [10]: 2143
    [11]: 2155
    [12]: 3076
    [13]: 3098
    [14]: 3179
    [15]: 4100
    [16]: 5124 <<< The one Amy found

I will now have a look in other repos to see how it is handled there.
```

## Other repos

....

## Branch

> Branch: Config/MR/Feature/OPEN-1371_INTError500AlertsChinese.INT

## PR

- [ ] OPEN-1371 INT Error 500 on Config Group Alerts > DEV
- [ ] OPEN-1371 INT Error 500 on Config Group Alerts > INT
- [ ] OPEN-1371 INT Error 500 on Config Group Alerts > UAT
- [ ] OPEN-1371 INT Error 500 on Config Group Alerts > PROD
