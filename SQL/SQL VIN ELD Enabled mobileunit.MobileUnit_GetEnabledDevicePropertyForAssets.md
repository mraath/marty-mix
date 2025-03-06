---
created: 2023-11-29T08:41
updated: 2023-11-29T13:40
---

```sql
USE DeviceConfiguration;

DECLARE  @deviceId       BIGINT = 7622806356726782531;
DECLARE  @propertyId     BIGINT = 9060590998656351498;
DECLARE  @assetIds       TABLE (Id BIGINT);
INSERT INTO @assetIds  Values (1465832551445032960);
  
DECLARE @deviceKey INT = (SELECT DeviceKey FROM [definition].[Devices] WHERE [DeviceId] = @deviceId);

DECLARE @propertyKey INT;
DECLARE @mobileUnitOnly BIT;

SELECT 
  @propertyKey = [PropertyKey],
  @mobileUnitOnly = [MobileUnitOnly]
FROM [definition].[Properties] WHERE [PropertyId] = @propertyId;


IF @mobileUnitOnly = 0
BEGIN
  SELECT DISTINCT
    mu.[MobileUnitId],
    mdt.[MobileDeviceTemplateId],
    [DeviceId]                      = @deviceId,
    [PropertyId]                    = @propertyId,
    [IsOverridden]                  = CAST(CASE WHEN odp.[TemplateDevicePropertyKey] IS NOT NULL THEN 1 ELSE 0 END AS BIT),
    [Value]                         = CASE WHEN odp.[TemplateDevicePropertyKey] IS NOT NULL THEN odp.[Value] ELSE tdp.[Value] END,
    [IsMobileUnitOnly]              = @mobileUnitOnly
  FROM
    [mobileunit].[MobileUnits] mu
      INNER JOIN
    [template].[ConfigurationGroups] cg ON mu.[ConfigurationGroupKey] = cg.[ConfigurationGroupKey]
      INNER JOIN
    [template].[MobileDeviceTemplates] mdt ON mdt.[MobileDeviceTemplateKey] = cg.[MobileDeviceTemplateKey]
      INNER JOIN
    [template].[DeviceProperties] tdp ON cg.[MobileDeviceTemplateKey] = tdp.[MobileDeviceTemplateKey] AND  tdp.PropertyKey = @propertyKey AND tdp.DeviceKey = @deviceKey
      INNER JOIN
    [template].[Devices] td ON td.[MobileDeviceTemplateKey] = cg.[MobileDeviceTemplateKey] AND td.[DeviceKey] = tdp.[DeviceKey]
      INNER JOIN
    @assetIds ids ON ids.id = mu.MobileUnitId
      INNER JOIN
    [definition].[Properties] dp ON dp.PropertyKey = tdp.PropertyKey
      LEFT JOIN
    [mobileunit].[OverridenDeviceProperties] odp ON mu.[MobileUnitKey] = odp.[MobileUnitKey] AND tdp.[TemplateDevicePropertyKey] = odp.[TemplateDevicePropertyKey]
      LEFT JOIN
    [mobileunit].[OverridenDevices] od ON od.TemplateDeviceKey = td.TemplateDeviceKey AND mu.MobileUnitKey = od.MobileUnitKey
  WHERE 
    CAST(CASE WHEN od.[IsEnabled] IS NOT NULL THEN od.[IsEnabled] ELSE td.IsEnabled END AS BIT) = 1
	  
END
ELSE 
  SELECT DISTINCT
    mu.[MobileUnitId],
    mdt.[MobileDeviceTemplateId],
    [DeviceId]                        = @deviceId,
    [PropertyId]                      = @propertyId,
    [IsOverridden]                    = CAST(0 AS BIT),
    mup.[Value],
    [IsMobileUnitOnly]                = @mobileUnitOnly
  FROM
    [mobileunit].[MobileUnits] mu
      INNER JOIN
    [template].[ConfigurationGroups] cg ON mu.[ConfigurationGroupKey] = cg.[ConfigurationGroupKey]
      INNER JOIN
    [template].[MobileDeviceTemplates] mdt ON mdt.[MobileDeviceTemplateKey] = cg.[MobileDeviceTemplateKey]
      INNER JOIN
    [mobileunit].[MobileUnitProperties] mup ON mu.[MobileUnitKey] = mup.[MobileUnitKey] AND mup.[PropertyKey] = @propertyKey AND mup.[DeviceKey] = @deviceKey
      INNER JOIN
    [template].[Devices] td ON td.[MobileDeviceTemplateKey] = cg.[MobileDeviceTemplateKey] AND td.[DeviceKey] = @deviceKey
      INNER JOIN
    @assetIds ids ON ids.id = mu.MobileUnitId
       LEFT JOIN
    [mobileunit].[OverridenDevices] od ON od.TemplateDeviceKey = td.TemplateDeviceKey AND mu.MobileUnitKey = od.MobileUnitKey
  WHERE 
    CAST(CASE WHEN od.[IsEnabled] IS NOT NULL THEN od.[IsEnabled] ELSE td.IsEnabled END AS BIT) = 1;
```