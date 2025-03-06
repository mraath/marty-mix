---
created: 2023-11-15T11:36
updated: 2023-11-15T11:36
---

```sql
-- Check overwritten propteries esp PSKKey
DECLARE @mobileUnitId BIGINT = 1159262212995481600; 

DECLARE @mobileUnitKey INT = (SELECT MobileUnitKey FROM [DeviceConfiguration].[mobileunit].MobileUnits WHERE MobileUnitId = @mobileUnitId);

SELECT top 10 * FROM [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties]
WHERE MobileUnitKey = @mobileUnitKey

-- Get the property key for PSKKey (208)
SELECT top 10 * FROM [DeviceConfiguration].[definition].[Properties] 
WHERE PropertyId = 3707347343900294912

-- Grab the value from the template
SELECT TOP 10 * FROM [DeviceConfiguration].[template].[DeviceProperties]
WHERE TemplateDevicePropertyKey IN
(SELECT TemplateDevicePropertyKey
FROM [DeviceConfiguration].[template].[DeviceProperties]
WHERE PropertyKey = 208
AND Value like '0%'
)

```
