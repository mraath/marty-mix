Date: 2022-07-19 Time: 10:51
Friend: 
JIRA:CONFIG-3320
[CONFIG-3320 Salesforce errors when creating and deleting assets containing a VIN on DEV - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/CONFIG-3320)

# Config-3320 Salesforce Issue

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
Config/MR/Bug/Config-3320 Salesforce Issue.xx.xx.ORI

## TEST

VIN: 5TFDW5F1XCXC23013

## ERROR

Response status code does not indicate success: 500 (Error occured at Route:/api/assets/update-sales-force/False/site-id-availability |Date:7/19/2022 12:00:58 PM |CorrelationId:1286079914460442624 |Error:Amazon.SimpleNotificationService.Model.ValidationException: Registration Number MRV1 is in use. at MiX.Fleet.Services.Logic.Assets.AssetsManager.ValidateAssetForCreate(Asset asset, Int64 orgId) in D:\b\1\_work\21\s\MiX.Fleet.Services.Logic\Assets\ **AssetsManager** .cs:line 2091 at MiX.Fleet.Services.Logic.Assets.AssetsManager.AddAsync(String authToken, Int64 accountId, Int64 orgId, Asset asset, Boolean updateSalesForce, Boolean updateCanProtocol, Nullable`1 correlationId) in D:\b\1\_work\21\s\MiX.Fleet.Services.Logic\Assets\AssetsManager.cs:line 890 at MiX.Fleet.Services.Api.Core.AssetsController.AddWithSiteIdAvailabilityAsync(Asset asset, Boolean updateSalesForce, Boolean updateAdditionalAssets, Boolean updateCanProtocol) in D:\b\1\_work\21\s\MiX.Fleet.Services.Api.Core\Controllers\AssetsController.cs:line 2327 at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.g__Logged|12_1(ControllerActionInvoker invoker) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.g__Awaited|24_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.Rethrow(ResourceExecutedContextSealed context) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.g__Awaited|19_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.g__Logged|17_1(ResourceInvoker invoker) at Microsoft.AspNetCore.Builder.RouterMiddleware.Invoke(HttpContext httpContext) at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.Invoke(HttpContext context) at MiX.Core.Telemetry.Web.DurationMetricsMiddleware.InvokeAsync(HttpContext context) at MiX.Fleet.Services.Api.Core.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in D:\b\1\_work\21\s\MiX.Fleet.Services.Api.Core\Middelware\SessionMiddelware.cs:line 146 at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)).  
**Stack trace:**  

   at MiX.Core.Retries.RetryStrategy.d__29`1.MoveNext() in D:\b\1\_work\1123\s\MiX.Core\Retries\RetryStrategy.cs:line 304
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Core.Clients.HttpRetries.d__12`1.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at MiX.Fleet.Services.Api.Client.AssetsRepository.d__59.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at DynaMiX.Logic.FleetAdmin.AssetManager.AddAsset(String authToken, Int64 siteId, Nullable`1 configGroupid, Asset asset, Int64 correlationId, List`1 additionalFields, Boolean& hasSiteIdAvailability) in ==C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\Assets\AssetManager.cs:line 1389==
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetDetailsModule.AddAssetDetails(String authToken, Int64 orgId, AssetCarrier carrier) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetDetailsModule.cs:line 374
   at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetDetailsModule.<.ctor>b__23_3(Object args) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetDetailsModule.cs:line 132
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.b__1(Object args) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 499
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.b__1() in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148

  
**Error no: 1286079914460442624**

## Learned

## Description
From what we can see this only happens when:
- The user captures a VIN number
- The user works on DEV
Currently I can't see anything straight forward that could be responsible for this.
I have gone through the code backwards, but can't see something.

From my discussion with Timothy it seems to happen due to the logic finding the same Registration Number.
The problem is I would make up something very unique and it would still happen.
This makes me think that it might write  the Reg No to the DB somewhere else before checking?
The other thing is this only happens when there is a VIN typed in... 

For now I can't see anything for Config team to do, however, it could very well be something which will come back to us, maybe the Fleet code calls something on our side which might have an issue.

I am therefor assigning it to the Fleet team for now.

## Code sections

## Files

## Resources

## Notes

