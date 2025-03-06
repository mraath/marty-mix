---
created: 2024-04-16T09:22
updated: 2024-04-16T09:48
---
```sql
USE Deviceconfiguration;

SELECT top 10 * FROM [definition].[Events] 
WHERE EventId IN (6707552231300886991, 2456605873203796503, -886123622139984997)

-- Got EventKeys above: 3120, 3118, 3121
-- Next find values

SELECT * FROM [audit].[library_Events_CT] 
WHERE EventKey IN (3120, 3118, 3121)
AND LibraryKey = 126

SELECT * FROM [library].[Events] 
WHERE EventKey IN (3120, 3118, 3121)
AND LibraryKey = 126


-- Find closest to this?

SELECT * FROM [library].[Events] 
WHERE Description LIKE ('%SP2000%')
AND LibraryKey = 126

SELECT * FROM [audit].[library_Events_CT] 
WHERE Description LIKE ('%SP2000%')
AND LibraryKey = 126

-- No audit values older than 2024-04-05 found, so cant see who deleted this
-- Maybe ask Martin to check the Datawarehouse / DB Backup



-----------------------------------------
--Get Organisation based on long group id
-----------------------------------------
DECLARE @GroupId BIGINT = 4319985034254011442;
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId

DECLARE @lorgID INT = (SELECT OrganisationId
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId)

SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID

SELECT TOP 10 * FROM mobileunit.AssetMobileUnits amu
WHERE amu.LegacyOrgId = 321
SELECT * FROM mobileunit.MobileUnits mu
WHERE mu.MobileUnitKey = 30350
SELECT * FROM template.ConfigurationGroups tcg
WHERE tcg.ConfigurationGroupKey = 1210

```