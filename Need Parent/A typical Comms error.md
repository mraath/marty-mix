---
created: 2023-11-13T07:42
updated: 2023-11-13T07:43
---
 the following logs OSD - Logz.io showing an error from comms System.EntryPointNotFoundException: A call to "POST /devices/569741335654154/commands" failed. 404 - The requested resource could not be found:



System.EntryPointNotFoundException: A call to "POST /devices/569741335654154/commands" failed. 404 - The requested resource could not be found.
   at MiX.Connect.Devices.Comms.Web.Api.Client.ResourceWrapperHelper.CheckForErrorResponse(IRestResponse& response, IRestRequest request, HttpStatusCode[] ignoredHttpStatusCodes) in /home/vsts/work/1/s/Devices/Comms/MiX.Connect.Devices.Comms.Web.Api.Client/EntityData/ResourceWrapperHelper.cs:line 66
   at MiX.Connect.Devices.Comms.Web.Api.Client.ResourceWrapperHelper.ProcessAddOrUpdateRequestAsync[T](String postUri, String putUri, T resource) in /home/vsts/work/1/s/Devices/Comms/MiX.Connect.Devices.Comms.Web.Api.Client/EntityData/ResourceWrapperHelper.cs:line 27
   at MiX.Connect.Devices.Comms.Web.Api.Client.CommandResourceWrapperCollection.Send(CommandResource commandResource) in /home/vsts/work/1/s/Devices/Comms/MiX.Connect.Devices.Comms.Web.Api.Client/EntityData/CommandResourceWrapperCollection.cs:line 34
   at DynaMiX.Services.API.Client.MiXConnect.MiXConnectProxy.<>c__DisplayClass9_0.<SendCommand>b__0() in D:\a\1\s\DynaMiX.Services.API.Client\MiX.Connect\MiXConnectProxy.cs:line 241
   at System.Threading.Tasks.Task`1.InnerInvoke()
   at System.Threading.Tasks.Task.Execute()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.Services.API.Client.MiXConnect.MiXConnectProxy.<SendCommand>d__9.MoveNext() in D:\a\1\s\DynaMiX.Services.API.Client\MiX.Connect\MiXConnectProxy.cs:line 239
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.Services.API.Client.MiXConnect.MiXConnectProxy.<SendCommand>d__2.MoveNext() in D:\a\1\s\DynaMiX.Services.API.Client\MiX.Connect\MiXConnectProxy.cs:line 80
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MessageSenders.MiXConnectMessageSender.SendTimeZoneUpdateCommand(IMiXConnectProxy commsProxy, MobileUnitCommand muc) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MessageSenders\MiXConnectMessageSender.cs:line 136
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MessageSenders.MiXConnectMessageSender.SendCommand(CurrentUserSession session, MobileUnitCommand muc) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MessageSenders\MiXConnectMessageSender.cs:line 110
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MiX4k6kCommandSender.SendCommand(CurrentUserSession session, IMobileUnitManager mum, MobileUnitCommand muc) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\CommandSenders\MiX4k6kCommandSender.cs:line 93
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(CurrentUserSession session, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, String value, Dictionary`2 paramDictionary) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitCommandsManager.cs:line 185
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, Dictionary`2 paramDictionary) in D:\a\1\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitCommandsManager.cs:line 75
   at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitCommandsController.<>c__DisplayClass0_0.<SendCommandToMobileUnit>b__0() in D:\a\1\s\DynaMiX.DeviceConfig.Services.API\Controllers\MobileUnitLevel\MobileUnitCommandsController.cs:line 50
   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in D:\a\1\s\DynaMiX.DeviceConfig.API.Core\Controllers\ControllerBase.cs:line 45
