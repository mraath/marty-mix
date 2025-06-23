---
created: 2025-06-23T09:40
updated: 2025-06-23T09:42
---
```sql
USE [DeviceConfiguration]
GO

DECLARE @return_value int

EXEC @return_value = [mobileunit].[mobileUnit_GetGenerationData]
		@mbi1eUnitId = 1666643037910753280

SELECT 'Return Value' = @return_value
GO
```
