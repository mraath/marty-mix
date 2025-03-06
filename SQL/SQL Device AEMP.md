```sql
-- Test to see if the Device Type exists for AEMP
SELECT * FROM DeviceConfiguration.definition.MobileDevices
WHERE Description LIKE '%AEMP%'

SELECT * FROM DeviceConfiguration.definition.Devices
WHERE SystemName LIKE '%AEMP%' 
OR DeviceId = 7089198383589898700
```