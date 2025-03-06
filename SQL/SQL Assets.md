```sql
DECLARE @mobileUnitId BIGINT = 3056091971474160310;
USE HalliburtonNorthAmerica_2015;

SELECT a.VinNumber, a.VinSource, *
/*
  a.AssetId,
  [VehicleStatus] = es.sValue,
  [DownloadVehicleNow] = ed.sValue,
  [VehicleLastOdo] = v.fLastOdo
  */
FROM
  dbo.Vehicles v
  INNER JOIN
  dynamix.Assets a
  ON a.VehicleId = v.iVehicleID
WHERE
  a.AssetId = @mobileUnitId
```