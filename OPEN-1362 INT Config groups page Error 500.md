---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-19T09:51
---

# OPEN-1362 INT Config groups page Error 500

Date: 2026-01-15 Time: 12:33
Parent:: [[timezone]]
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
CorrelationId:1748371667841667072|/api/configuration-groups-multiselect/groupId/-5401647754082838271/mobile-units/1646589414582132736/get-overridden-info|01/15/2026 04:23:20|Error:System.NullReferenceException: Object reference not set to an instance of an object. at MiX.DeviceIntegration.Common.TimeZones.ZonedDateTime.ConvertUtcToTargetTimeZone(DateTime utcDateTime, TimeZoneInfo targetTimeZoneInfo) at MiX.DeviceIntegration.Common.TimeZones.ZonedDateTime.ToTimeZone(DateTime dt, TimeZoneInfo sourceTimeZone, TimeZoneInfo targetTimeZone) at MiX.DeviceIntegration.Common.TimeZones.ZonedDateTime.ToTimeZone(ZonedDateTime zdt, TimeZoneInfo targetTimeZone) at MiX.DeviceIntegration.Common.TimeZones.ZonedDateTime.ToTimeZone(TimeZoneInfo targetTimeZoneInfo) at MiX.Config.Frangular.API.Converters.ConfigurationGroupConverters.ZonedDateTimeCarrier(DateTimeOffset dateTime, TimeZoneInfo timeZoneInfo) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Converters/ConfigurationGroupConverters.cs:
line 132 

at MiX.Config.Frangular.API.Converters.ConfigurationGroupConverters.<>c__DisplayClass4_0.<ToConfigurationGroupDifferencesCarrier>b__0(MobileUnitDifference mu) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Converters/ConfigurationGroupConverters.cs:
line 115 

at System.Linq.Enumerable.SelectListIterator`2.ToList() at MiX.Config.Frangular.API.Converters.ConfigurationGroupConverters.ToConfigurationGroupDifferencesCarrier(List`1 mobileUnitDifference, Int64 groupId, Int64 assetId, TimeZoneInfo timeZoneInfo) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Converters/ConfigurationGroupConverters.cs:
line 113 

at MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.GetOverriddenInformationForMobileUnit(String groupId, String mobileUnitId) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:
line 299 

at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:line 119 at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)

https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-5401647754082838271/mobile-units/1646589414582132736/get-overridden-info
```

![[Pasted image 20260115153105.png]]

![[Pasted image 20260115153538.png]]

- NOT happening locally
- Happening INT
- Local > Local FR API > INT API - NOPE
- https://app.axiom.co/powerfleet-cpve/query?qid=hVK9Xjc2hmW-t8wcaw&relative=1
- Timezone: TimeZone lookup failed. Name: 'Africa/Johannesburg' not found in Globalisation Client
- The shortcode when I test locally is: "CAT/SAST", when I run it on INT it is "Africa/Johannesburg"

#### Code

![[Pasted image 20260119094712.png]]

![[Pasted image 20260119095105.png]]





### Error 2
![[Pasted image 20260115123934.png|500]]

#### Log 2

https://app.axiom.co/powerfleet-cpve/query?qid=B9EImS7icQK-t8xmiq

```ts
/api/configuration-groups/organisation/xxxxx/query-options




Error 500 - OK x Correlationlc17474004233116917 76| api/configuration-groups/organisation/6161510139338182415/query-options
|01/12/2026 12:04:28|Error:MiX Core.Clients.HitpRetries+ HUpinvalldRequesLEXCeption: Response status code does not indicate success: 500 (Error occured at /2 nisatic 1 15/details |Date:01/12/2026 12:04:28 | Correlation!d:1747400555935383552 Error:System. 
NullReferenceException: Object reference not set to afffistance of an object. 

at MiX Fleet. Semce;u.-:gu:.smps.nrgamsamncrmpmanager.cemr:nﬁsaxmnmmmsyncq|m54 organisationld) in Jhomejusts/work/1/s/MIX Fleet Services.Logic/Groups/OrganisationGroupManager.cs 
line 622 

at MiX Fleet Services. Api.Core GroupsControlier. GetOrganisationDetailAsync(Int64 organisationid) in Jhomejvsts/work/1/s/MiX. Fleet Services.Api. Core/Controllers/GroupsController.cs 
line 909 

at Microsoft.AspNetCore.Mvc. Infrastructure. ActionMethodExecutor. TaskOfiActionResult Executor.Execute(ActionContext actionContext, ‘ IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object(] arguments) at Microsoft.AspNetCore.Mve.Infrastructure. ControllerActioninvaker. <InvokeActionMethodAsync>g_Logged|12_1(ControllerActioninvoker invoker) at ~ Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActioninvoker.<InvokeNextActionFilterAsync>g._Awaited| 10_0(ControllerActioninvoker invoker, ‘ Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at | (oo
```


## CODE

## Devs message

Hey, I am working on two erorrs.
I am running out of time for today though as I have to leave here in 50 mins to take my kids somewhere.
So if this needs to be done today, could someone please take over.

OPEN-1362: Has two issues in Frangular API:
1) Globalisation Client not getting the timezones we sent it, although a few weeks ago this worked. They say we should use short code. Tried. Doesnt yet work... cache?
2) GetOrganisationDetailAsync when clicking and resizing columns in the config group left pane - I can't duplicate this, Amy is busy trying.
OPEN-1371
3) When setting the user preference to Chinese (traditional), while loading ALERTs, it throws a bug in Config.Api. Not happening for English.

Thanks - M
## Branch

> Branch: Config/MR/Feature/OPEN-1362_ConfiggroupsPageError500Clean.INT

## PR

- [x] [OPEN-1362 > INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/136897) ✅ 2026-01-16
	- [ ] https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/136902

