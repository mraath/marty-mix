Audit sql for [[Odometer]]

```sql
USE [DeviceConfiguration.DataProcessing];

DECLARE @MobileUnitId BIGINT = 1392855913680777216 

-- Actual state
SELECT * FROM [state].[MobileUnitState]
WHERE PropertyId IN (-2956425554789101238,3244460969911708137,-4403033164446606692) --NEW_ODOMETER_SET, ASSET_LAST_DISPLAY_ODOMETER, LAST_TRIP_END_ODOMETER
AND MobileUnitId = @MobileUnitId
ORDER BY DateUpdated ASC

-- State History?
SELECT * FROM [state].[MobileUnitStateHistory]
WHERE PropertyId IN (-2956425554789101238,3244460969911708137,-4403033164446606692) --NEW_ODOMETER_SET, ASSET_LAST_DISPLAY_ODOMETER, LAST_TRIP_END_ODOMETER
AND MobileUnitId = @MobileUnitId
ORDER BY DateUpdated ASC

-- Unique ID?
SELECT * FROM DeviceConfiguration.mobileunit.MobileUnits mu
WHERE mu.MobileUnitId = @MobileUnitId

-- Audit mu, not really needed
SELECT * FROM DeviceConfiguration.[audit].[mobileunit_MobileUnits_CT] a_mu
WHERE a_mu.MobileUnitId = @MobileUnitId
ORDER BY ChangeDate ASC
```
