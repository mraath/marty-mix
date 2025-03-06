---
created: 2023-10-12T12:21
updated: 2024-10-02T13:40
---
This comes from helpful [[sql]] snippets

```sql
USE DeviceConfiguration;

DECLARE @IMEI NVARCHAR(50) = '351579052020383'; --Replace IMEI
DECLARE @id BIGINT =                  -- OR set MobileUnitID here and remove next line
    (Select MobileUnitId FROM mobileunit.MobileUnits WHERE UniqueIdentifier = @IMEI);

SELECT @id as MobileUnitId;

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

--DSV ONLY (Multiple time zone) L3B-UI only
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE OrganisationId = @lorgID
```
