---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-15T12:44
---

# OPEN-1362 INT Config groups page Error 500

Date: 2026-01-15 Time: 12:33
Parent:: ==xxxx==
Friend:: [[2026-01-15]]
JIRA:error
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1362)


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


### Error 1

![[Pasted image 20260115123948.png|500]]

#### Log 1

```ts
CorrelationId:1748371667841667072|/api/configuration-groups-multiselect/groupId/-5401647754082838271/mobile-units/1646589414582132736/get-overridden-info|01/15/2026 04:23:20|Error:System.NullReferenceException: Object reference not set to an instance of an object. at MiX.DeviceIntegration.Common.TimeZones.ZonedDateTime.ConvertUtcToTargetTimeZone(DateTime utcDateTime, TimeZoneInfo targetTimeZoneInfo) at MiX.DeviceIntegration.Common.TimeZones.ZonedDateTime.ToTimeZone(DateTime dt, TimeZoneInfo sourceTimeZone, TimeZoneInfo targetTimeZone) at MiX.DeviceIntegration.Common.TimeZones.ZonedDateTime.ToTimeZone(ZonedDateTime zdt, TimeZoneInfo targetTimeZone) at MiX.DeviceIntegration.Common.TimeZones.ZonedDateTime.ToTimeZone(TimeZoneInfo targetTimeZoneInfo) at MiX.Config.Frangular.API.Converters.ConfigurationGroupConverters.ZonedDateTimeCarrier(DateTimeOffset dateTime, TimeZoneInfo timeZoneInfo) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Converters/ConfigurationGroupConverters.cs:line 132 at MiX.Config.Frangular.API.Converters.ConfigurationGroupConverters.<>c__DisplayClass4_0.<ToConfigurationGroupDifferencesCarrier>b__0(MobileUnitDifference mu) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Converters/ConfigurationGroupConverters.cs:line 115 at System.Linq.Enumerable.SelectListIterator`2.ToList() at MiX.Config.Frangular.API.Converters.ConfigurationGroupConverters.ToConfigurationGroupDifferencesCarrier(List`1 mobileUnitDifference, Int64 groupId, Int64 assetId, TimeZoneInfo timeZoneInfo) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Converters/ConfigurationGroupConverters.cs:line 113 at MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.GetOverriddenInformationForMobileUnit(String groupId, String mobileUnitId) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:line 299 at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:line 119 at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)

https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-5401647754082838271/mobile-units/1646589414582132736/get-overridden-info
```

### Error 2
![[Pasted image 20260115123934.png|500]]

#### Log 2

```ts
```

## CODE


## Branch

> Branch: Config/MR/Feature/OPEN-1362_ConfiggroupsPageError500.INT

## PR

- [ ] OPEN-1362 > DEV
- [ ] OPEN-1362 > INT
- [ ] OPEN-1362 > UAT
- [ ] OPEN-1362 > PROD
