
POrtia Message about SerialNumbers in Config Group
	- MobileUnitSerialNumber
	- serialNumberProp
	- serialNumberPropertyKey
	- Properties.SERIAL_NUMBER
	- public const long SERIAL_NUMBER = -6167220489794283114; // SerialNo
	- EF.Tables.MobileUnitLevel.MobileUnitProperty
	- sl.MobileDeviceType == MobileDeviceType.MESA ? sn?.Value : sl.MobileUnitSerialNumber
		- sn = _deviceStateManager.GetStatesForMobileUnits(summaryList.Select(s => s.MobileUnitId).ToList(), LogicalDevices.ALL_MOBILE_UNITS, Properties.SERIAL_NUMBER
		- sl = _deviceConfigRepo.GetMobileUnitSummariesForConfigurationGroup !!** Wynand 3 monts ago (for CG)
			- _deviceConfigRepo.GetMobileUnitSummariesForConfigurationGroup
			- serialNumberPropertyKey = (from dp in Context.DefinitionProperties where dp.PropertyId == Properties.SERIAL_NUMBER
			- EF.Tables.MobileUnitLevel.MobileUnitProperty THIREN (5 weeks)
	- _deviceStateManager.GetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.SERIAL_NUMBER (mu) Jako 8 weeks
	- MobileUnitSerialNumber = serialNumberProp == null ? null : serialNumberProp.Value, THIREN 5 weeks [EF.Tables.MobileUnitLevel.MobileUnitProperty]
- Gets from: xxxxxxxxxxx
- Sets from: xxxxxxxxxxxx
	- C:\Projects\MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core.DeviceState\MobileUnitState.cs
	- UpdateSerialNumber
		- Called by? 
- It seems like the DP team updates this value. I has a look at some older chats of about 2 years ago with Russell Wilmot where he asked a similar question. Back then I mentioned that most likely Wynand on the DP team will be the best person to ask about this. From our code I can't see anywhere this is done.
```sql
Select top 100 mup.[Value], dd.SystemName, mup.* 
from DeviceConfiguration.mobileunit.MobileUnitProperties mup
INNER JOIN DeviceConfiguration.definition.Devices dd ON dd.DeviceKey = mup.DeviceKey
Where mup.PropertyKey = 
  (SELECT dp.PropertyKey
  FROM DeviceConfiguration.definition.Properties dp
  WHERE dp.PropertyId = -6167220489794283114)
/*
AND mup.MobileUnitKey = 
  (SELECT mu.MobileUnitKey
  FROM DeviceConfiguration.mobileunit.MobileUnits mu
  WHERE mu.MobileUnitId = 3602083798506161557)
*/

SELECT top 100 dd.SystemName, * 
FROM [DeviceConfiguration.DataProcessing].state.mobileunitstate mus
JOIN DeviceConfiguration.mobileunit.MobileUnits mu ON mu.MobileUnitId = mus.MobileUnitId
INNER JOIN DeviceConfiguration.definition.Devices dd ON dd.DeviceKey = mu.MobileDeviceKey
WHERE PropertyId = -6167220489794283114;

```
==DP team==
