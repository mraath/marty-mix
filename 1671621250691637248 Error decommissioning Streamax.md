---
created: 2025-06-18T08:01
updated: 2025-06-18T11:44
---
Hello!

I tried to delete your MR Streamax asset on my org (just doing cleanup) and got the following error

An unexpected error has occurred  
**Error no: 1671621250691637248**  
  
Response status code does not indicate success: 500 ({"ExceptionMessage":"Unable to decommission the Streamax device. Please try again. assetId:1669364541459320832; stmDeviceTypeId:311792233444052589; stmSerialNumber:; stmDeviceDescription:Streamax C6D AI. Exception:Response status code does not indicate success: 400 (Bad Request,\u0022ProviderDevice.UnitSerailNo cannot be null\u0022).","ExceptionType":"System.Exception","StackTrace":" at 

Config.Api.Logic.Managers.MobileUnitLevel.MobileUnitManager.DecommissionStreamax(String authToken, Int64 assetId) in 
/home/vsts/work/1/s/Config.Api.Logic/Managers/MobileUnitLevel/MobileUnitManager.cs:line 2423\n at 

Config.Api.Controllers.MobileUnitLevel.MobileUnitController.DecommissionStreamax(String authToken, Int64 assetId) in /home/vsts/work/1/s/Config.Api/Controllers/MobileUnitLevel/MobileUnitController.cs:line 553\n at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(ActionContext actionContext, IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeActionMethodAsync\u003Eg__Logged|12_1(ControllerActionInvoker invoker)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeNextActionFilterAsync\u003Eg__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State\u0026 next, Scope\u0026 scope, Object\u0026 state, Boolean\u0026 isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.\u003CInvokeInnerFilterAsync\u003Eg__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeFilterPipelineAsync\u003Eg__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)\n at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)\n at MiX.Core.Web.Abstractions.ConfigurationExtensions.\u003C\u003Ec__DisplayClass1_0.\u003C\u003CUseMiXRequestLogging\u003Eb__0\u003Ed.MoveNext()\n--- End of stack trace from previous location ---\n at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)\n at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider)\n at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context)\n at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)\n at Config.Api.Helpers.ExecutionTimeMiddleware.InvokeAsync(HttpContext httpContext) in /home/vsts/work/1/s/Config.Api/Helpers/ExecutionTimeMiddleware.cs:line 55\n at MiX.Core.Telemetry.Web.DurationMetricsMiddleware.InvokeAsync(HttpContext context)\n at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddlewareImpl.\u003CInvoke\u003Eg__Awaited|10_0(ExceptionHandlerMiddlewareImpl middleware, HttpContext context, Task task)"}).

OK

![[1671621250691637248 Error decommissioning Streamax.png]]
