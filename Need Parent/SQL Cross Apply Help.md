---
created: 2024-12-04T09:40
updated: 2024-12-04T09:41
---

```sql
--eg. of Cross Apply
SELECT dd.DeviceId, dp.ParameterId
FROM DeviceConfiguration.definition.DeviceParameters ddp --33057
CROSS APPLY 
(
  SELECT LibraryKey FROM @GeneralConfigGroupInfo 
) g
INNER JOIN DeviceConfiguration.definition.Devices dd ON dd.DeviceKey = ddp.DeviceKey --33057
INNER JOIN DeviceConfiguration.definition.Parameters dp ON dp.ParameterKey = ddp.ParameterKey --33057
INNER JOIN DeviceConfiguration.library.Parameters lp ON lp.ParameterKey = dp.ParameterKey AND lp.LibraryKey = g.LibraryKey --30970
INNER JOIN DeviceConfiguration.library.Devices ld ON ld.DeviceKey = dd.DeviceKey AND ld.LibraryKey = lp.LibraryKey --21476
INNER JOIN @AllDefinitionDeviceIds ids ON ids.DeviceId = dd.DeviceId
```
