---
status : PROD
date: 2022-09-27
comment : PASSED UAT
priority: 7
---

Date: 2022-07-14 Time: 11:19
Friend: 
JIRA:SR-13285
[SR-13285 MiX4000 GMTOffset not found for this group id: 0 - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-13285)

# SR-13285 GTMOffset is 0

## Image


## Development work

- API > Dynamix.DeviceConfig

| API   | x   |
| ----- | --- |
| 22.9  |     |
| Local |     |

## Branch
Config/MR/Bug/SR-13285_GMTOffsetZero.22.9.PROD.ORI

## TEST

id=1180585053986516992&
orgId=-8441185520557948197

- UpdateAssetTimezoneDeviation = 45 (to get the pending one there)
- SendConfiguration = 102 (for the actual test, to pick up the pending issue)


"StackTrace": " at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.GetConfigurationDataFiles(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\MarthinusR\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MobileUnitCommandSender.cs:line 56\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MiX4k6kCommandSender.PackageCommand(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\MarthinusR\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MiX4k6kCommandSender.cs:line 142\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(CurrentUserSession session, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, String value) in D:\\MarthinusR\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 183\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3) in D:\\MarthinusR\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 74\r\n at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitCommandsController.<>c__DisplayClass0_0.<SendCommandToMobileUnit>b__0() in D:\\MarthinusR\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Services.API\\Controllers\\MobileUnitLevel\\MobileUnitCommandsController.cs:line 48\r\n at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in D:\\MarthinusR\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 46",




## FIX


D:\MarthinusR\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MessageSenders\MiXConnectMessageSender.cs
if (pendingTimezoneUpdate != null)
{
	pendingTimezoneUpdate.UserName = username;
	pendingTimezoneUpdate.GroupId = muc.GroupId; //assuming since sending the message the groupid wouldn't have changed
	SendTimeZoneUpdateCommand(commsProxy, pendingTimezoneUpdate); //TODO: MR: Think this is the error
}


## Description

## Code sections

## Files

## Resources

## Notes

