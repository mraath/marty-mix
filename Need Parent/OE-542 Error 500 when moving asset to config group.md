---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-30T12:19
---

# OE-542 Error 500 when moving asset to config group

Date: 2024-10-30 Time: 10:53
Parent:: [[OE-521 Unallocated Assets assign to Config group]]
Friend:: [[2024-10-30]]
JIRA:OE-542 Error 500 when moving asset to config group
[OE-542 Error 500 when moving asset to config group - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-542)


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

```c#
CorrelationId:1588148780134440960|/api/configuration-groups-multiselect/groupId/-5401647754082838271/assets/configuration-groups/-2440320943995442748/update-assets-config-group|10/30/2024 01:14:46|Error:System.Argument
Exception: Invalid asset Ids supplied (Parameter 'assetIds') at 
MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.==UpdateAssetsConfigurationGroup==(String groupId, String configGroupId, AssetIdsCarrier assetIds) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:line 171 at 

Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync() --- End of stack trace from previous location --- at 
Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) at 
Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) at 
Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at 
MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:line 119 at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)
```


- Dont remove incompatible assets if unallocated
- PR: [Pull request 113828: OE-542: Dont remove incompatible assets if unallocated - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/113828)


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...
