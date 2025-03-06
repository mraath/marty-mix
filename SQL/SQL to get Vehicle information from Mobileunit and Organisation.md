From [[sql]]

```sql
-- Get Organisation information from mobileunit, then use that to get the below

USE AABernosDoomPatrol_2021;                    --REPLACE THIS with other sql info
DECLARE @mobileUnitId BIGINT = 1307418444008112128;    --Replace this

SELECT
  a.AssetId,
  [VehicleStatus] = es.sValue,
  [DownloadVehicleNow] = ed.sValue,
  [VehicleLastOdo] = v.fLastOdo,
  [TrailerOdo] = t.fSetOdometer
FROM
  dbo.Vehicles v
  INNER JOIN dynamix.Assets a ON a.VehicleId = v.iVehicleID
  LEFT JOIN ExtensionProperties es ON es.liObjectID = v.iVehicleID AND es.sAppID = 'FMSchedulerPro' AND es.sProperty = 'VehicleStatus'
  LEFT JOIN ExtensionProperties ed ON ed.liObjectID = v.iVehicleID AND ed.sAppID = 'FMSchedulerPro' AND ed.sProperty = 'DownloadVehicleNow'
  LEFT JOIN dbo.Trailers t ON t.liTrailerID = a.TrailerId
WHERE
  a.AssetId = @mobileUnitId
```
