---
created: 2024-03-04T14:18
updated: 2024-03-04T14:18
---
```sql
USE DeviceConfiguration;

DECLARE @id BIGINT = 1501212010248605696;

DECLARE @muKey INT = (SELECT MobileUnitKey
FROM DeviceConfiguration.mobileunit.AssetMobileUnits
WHERE AssetId = @id)

-- Organisation info based on long assetId 
SELECT *
FROM DeviceConfiguration.mobileunit.AssetMobileUnits
WHERE AssetId = @id
DECLARE @lorgID INT = (SELECT LegacyOrgId
FROM DeviceConfiguration.mobileunit.AssetMobileUnits
WHERE AssetId = @id)

--LegacyOrgId
SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID

SELECT * FROM mobileunit.MobileUnits WHERE MobileUnitKey =@muKey

--DSV ONLY (Multiple time zone) L3B-UI only
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE OrganisationId = @lorgID
```