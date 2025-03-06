```sql
IF OBJECT_ID('tempdb..#AssetDetails') IS NOT NULL
 DROP TABLE #AssetDetails

CREATE TABLE #AssetDetails
(
 VehicleID INT,
 VehicleDetails NVARCHAR(200),
 SiteID INT,
 SiteName NVARCHAR(200)
)
```

[[sql]] [[table]]