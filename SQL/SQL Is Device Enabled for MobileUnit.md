---
created: 2023-10-12T11:05
updated: 2025-03-06T12:00
---
To test if a [[Device]] is enabled for a mobileunit

```sql
DECLARE @MobileUnitId BIGINT = 1307418444008112128;    -- Replace MobileUnitId
DECLARE @deviceId BIGINT = -9075836125967806082;       -- Replace DeviceId

/*
TrackAndTrace: -454496733429815087
DME_HIDDEN: -9075836125967806082
TELTONIKA_FMB001 = 4006004756113529772
TELTONIKA_FM3001 = 8390531593309277252
BASE_BEACON_FUNCTIONALITY = -2156593089855370790
OEM_Logical = -7567965444832338102
*/

USE DeviceConfiguration;

SELECT DISTINCT mu.MobileUnitId, CASE WHEN md.[TemplateDeviceKey] IS NOT NULL THEN md.[IsEnabled] ELSE td.[IsEnabled] END as [Enabled]
    FROM mobileunit.MobileUnits mu
    INNER JOIN template.ConfigurationGroups cg WITH(NOLOCK) on cg.ConfigurationGroupKey = mu.ConfigurationGroupKey
    INNER JOIN [template].[Devices] td with (nolock) ON cg.[MobileDeviceTemplateKey] = td.[MobileDeviceTemplateKey]
    INNER JOIN [definition].[Devices] dd with (nolock) ON dd.DeviceKey = td.DeviceKey 
    LEFT JOIN [mobileunit].[OverridenDevices] md with (nolock) ON mu.[MobileUnitKey] = md.[MobileUnitKey] AND td.[TemplateDeviceKey] = md.[TemplateDeviceKey]
    WHERE mu.MobileUnitId = @MobileUnitId 
    AND dd.DeviceId = @deviceId

```
