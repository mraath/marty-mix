---
created: 2024-02-06T08:43
updated: 2024-02-06T14:34
---
## Image

![[CONFIG-4030 TEST Get Pending Or Loaded Configuration Version For MobileUnit Command 102.png|300]]

Command 102

## Test notes

I did [the following swagger test](http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/MobileUnitCommands/MobileUnitCommands_SendCommandToMobileUnits2).
For these units:

I went to the following org. 
OrgId: -5401647754082838271 (Amy Bench Units)
After going to the Configuration Groups page I selected mobileunits, which had the following action options.
- Download config file
- Download pending config file

These are the mobile units I tested against with its results.
MobileUnitIds: 
- 1444029372907753472 (Rodger 6K LTE)
	- Response: { "1444029372907753472": "0" }
- 1463548887546023936 (Rodger 6K Bench)
	- Response: "1463548887546023936": "System.ArgumentOutOfRangeException: Specified argument was out of the range of valid values.\r\nParameter name: Configuration version error\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.GetConfigurationDataFiles(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MobileUnitCommandSender.cs:line 54\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MiX4k6kCommandSender.PackageCommand(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MiX4k6kCommandSender.cs:line 142\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(CurrentUserSession session, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, String value, Dictionary`2 paramDictionary) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 184\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnits2(String authToken, Int64 groupId, List`1 mobileUnitIds, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 107"
- 1458574791892566016 (Rodger 4K STM)
	- Response: "1458574791892566016": "System.ArgumentOutOfRangeException: Specified argument was out of the range of valid values.\r\nParameter name: Configuration version error\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.GetConfigurationDataFiles(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MobileUnitCommandSender.cs:line 54\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MiX4k6kCommandSender.PackageCommand(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MiX4k6kCommandSender.cs:line 142\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(CurrentUserSession session, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, String value, Dictionary`2 paramDictionary) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 184\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnits2(String authToken, Int64 groupId, List`1 mobileUnitIds, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 107"
- 1466202490018541568 (FM)
	- Response: "1466202490018541568": "System.ArgumentOutOfRangeException: Specified argument was out of the range of valid values.\r\nParameter name: Unsupported command type\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.ValidateCommandType(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MobileUnitCommandSender.cs:line 77\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MobileUnitCommandSender.ValidateCommand(IMobileUnitManager mum, MobileUnitCommand muc) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\CommandSenders\\MobileUnitCommandSender.cs:line 32\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(CurrentUserSession session, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3, String value, Dictionary`2 paramDictionary) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 183\r\n at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnits2(String authToken, Int64 groupId, List`1 mobileUnitIds, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitCommandsManager.cs:line 107"

From the above results only the one in the original example didn't have an error.
I don't know if this is the expected outcome?
I will keep it open.
Maybe I did something wrong?
Please give more instructions above in case the tests were incorrect.
