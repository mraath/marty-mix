
Parent:: [[Command 45]]

## Organisation Information
```sql
-- ORGANISATION INFO

DECLARE @OrgName NVARCHAR(100) = 'TotalEnergies-MS/AFR-South Africa-HV-D';
-- TODO: REPLACE THIS WITH THE SITE NAME

SELECT o.sconnectdatabase, o.sOrganisationName, liOrgID
FROM Fmonlinedb.dbo.organisation o
WHERE o.sOrganisationName LIKE '%' + @OrgName + ''

--Org TZ Offset
SELECT o.sconnectdatabase, liGMTOffset
FROM Fmonlinedb.dbo.organisation o
WHERE o.sOrganisationName LIKE '%' + @OrgName + ''

  
SELECT liGMTOffset, * FROM [FMOnlineDB].[audit].[Organisation_CT]
WHERE liOrgID = 3943
```
