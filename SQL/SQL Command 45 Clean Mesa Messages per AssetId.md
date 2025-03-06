---
created: 2024-03-27T14:08
updated: 2024-03-27T14:08
---
```sql
DECLARE @mobileUnitId BIGINT = 1447989472206643200;

DECLARE @configGroupKey INT = (SELECT ConfigurationGroupKey FROM mobileunit.MobileUnits mu WHERE mu.MobileUnitId = @mobileUnitId)


--SELECT * FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessageStateHistory]
DELETE FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessageStateHistory]
WHERE MessageKey IN 
(
	SELECT MessageKey FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] msg
	WHERE MobileUnitId IN
	(
		SELECT MobileUnitId
		FROM mobileunit.MobileUnits mu
		WHERE mu.ConfigurationGroupKey = @configGroupKey
	)
)


--SELECT * FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] msg
DELETE FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage]
WHERE MobileUnitId IN
(
	SELECT MobileUnitId
	FROM mobileunit.MobileUnits mu
	WHERE mu.ConfigurationGroupKey = @configGroupKey
)



--JOIN mobileunit.AssetMobileUnits amu ON amu.MobileKey = mu.MobileKey
--JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] msg WITH (NOLOCK) ON mu.MobileUnitId = msg.MobileUnitId
--JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessageStateHistory] msgh WITH (NOLOCK) ON msgh.MessageKey = msg.MessageKey

```