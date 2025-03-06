
To test if the [[Device]] exist

```sql
SELECT * FROM DeviceConfiguration.definition.MobileDevices
WHERE Description LIKE '%hino%'
SELECT * FROM DeviceConfiguration.definition.Devices
WHERE SystemName LIKE '%hino%'
```
