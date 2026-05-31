---
wiki_ingested: 2026-05-28
---
```sql
-- Configuration Group
SELECT top 10 *
FROM DeviceConfiguration.[template].[ConfigurationGroups] CG  WITH (NOLOCK)
INNER JOIN DeviceConfiguration.template.MobileDeviceTemplates MT  WITH (NOLOCK) ON MT.[MobileDeviceTemplateKey] = CG.[MobileDeviceTemplateKey]
WHERE cg.Name like '%AEMP%'
```
