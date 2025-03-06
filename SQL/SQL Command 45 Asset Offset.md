
Parent:: [[Command 45]]

## Asset Information and Site Offset

```sql
-- ASSET INFORMATION

USE TotalSouthAfrica_2016;

--Site timezone
SELECT v.sDesc, s.sName, v.liSiteID, ds.GroupId, g.DisplayTimeZone, g.*
FROM dbo.Vehicles v
INNER JOIN dbo.Sites s ON s.liSiteID = v.liSiteID
INNER JOIN dynamix.Sites ds ON ds.SiteID = v.liSiteID
INNER JOIN [DynaMiX].[DynaMiX_Groups].[Groups] g ON g.GroupId = ds.GroupId
WHERE v.iVehicleID = 893 -- TODO: REPLACE THIS
```
