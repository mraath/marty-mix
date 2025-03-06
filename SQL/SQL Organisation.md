
```sql
------------------------------------------
-- Organisation info based on long assetId
------------------------------------------
  DECLARE @id as BIGINT = 1113579701291151360;
--1113579701291151360; --ASSETID

SELECT *
FROM DeviceConfiguration.mobileunit.AssetMobileUnits
WHERE AssetId = @id
DECLARE @lorgID INT = (SELECT LegacyOrgId
FROM DeviceConfiguration.mobileunit.AssetMobileUnits
WHERE AssetId = @id)

--DECLARE @lorgID INT = 5135

--LegacyOrgId
SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID

-----------------------------------------
--Get Organisation based on long group id
-----------------------------------------
DECLARE @GroupId BIGINT = 2689930065400163162;
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId

DECLARE @lorgID INT = (SELECT OrganisationId
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId)

SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID
```
