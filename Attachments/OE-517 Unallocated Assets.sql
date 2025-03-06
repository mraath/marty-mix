USE DeviceConfiguration;

/*
USE EttienneBenchUnitsDONOTEDIT_2020;
SELECT
  [AssetId] = a.AssetId,
  [LegacyVehicleId] = v.iVehicleID,
  [Description] = v.sDesc,
  [LastOdo] = v.fLastOdo,
  [LastTrip] = v.dtLastTrip,
  [LastEngineSeconds] = v.liLastEngineSeconds,
  [DisplayTimeZone] = g.[DisplayTimeZone]
FROM dynamix.Assets a
INNER JOIN dbo.Vehicles v ON a.VehicleId = v.iVehicleID
INNER JOIN [DynaMiX].[DynaMiX_Groups].[Groups] g ON g.[GroupId] = a.GroupId	
INNER JOIN [DynaMiX].[DynaMiX].[GroupTypes] gt ON g.[GroupTypeKey] = gt.[GroupTypeKey]
WHERE a.AssetId = 1547913034322440192
*/




-- TESTING OE Multi config groups ASSETS - UNALLOCATED
DECLARE @orgId BIGINT = -4493495256567590976

-- Get Legacy Org Id
DECLARE @legacyOrgId INT = 
    (SELECT OrganisationId 
        FROM [FMOnlineDB].[dynamix].[Organisations] 
        WHERE GroupId = @orgId);
-- Get DB Name
DECLARE @sConnectDatabase NVARCHAR(250) =
    (SELECT sConnectDatabase
        FROM [FMOnlineDB].[dbo].[Organisation] fmo WITH (NOLOCK)
        WHERE liOrgID = @legacyOrgId);

SELECT @sConnectDatabase;


  -- ASSET DATABASE INFORMATION
  -- Mobile Units (to exclude for unallocated assets)
  IF OBJECT_ID('tempdb..#mobileUnits') IS NOT NULL
      DROP TABLE #mobileUnits;
  CREATE TABLE #mobileUnits
  (
    LegacyVehicleId                INT
  )
  INSERT INTO #mobileUnits
  SELECT
    amu.LegacyVehicleId [LegacyVehicleId]
  FROM [DeviceConfiguration].[mobileunit].[AssetMobileUnits] amu WITH (NOLOCK)
    WHERE amu.LegacyOrgId = @legacyOrgId;

  -- Assets 
  IF OBJECT_ID('tempdb..#assets') IS NOT NULL
      DROP TABLE #assets;
  CREATE TABLE #assets
  (
    AssetDescription NVARCHAR(500),
    Registration     NVARCHAR(50),
    Sitename         NVARCHAR(500),
    FleetNumber      NVARCHAR(50),
    AssetId          NVARCHAR(50),
    LegacyVehicleId  INT
  );
  DECLARE @SQL NVARCHAR(MAX);
  SET @SQL = N'USE ' + QUOTENAME(@sConnectDatabase) + N';
      --Get all asset information
      INSERT INTO #assets
          SELECT
          v.sDesc as AssetDescription,
          v.sRegNo as Registration,
          s.sName as [Sitename], 
          a.FleetNumber,
          a.AssetId,
          v.iVehicleID [LegacyVehicleId]
          FROM dbo.Vehicles v WITH (NOLOCK)
          INNER JOIN  [dynamix].Assets a WITH (NOLOCK) 
              ON v.iVehicleID  = a.VehicleId  
          INNER JOIN dbo.Sites s WITH (NOLOCK) 
              ON s.liSiteID = v.liSiteID
          WHERE v.iVehicleID NOT IN (SELECT LegacyVehicleId FROM #mobileUnits)
              '
  EXEC sp_executesql @SQL;


  -- Put it all together
  SELECT
    Alerts = NULL,
    Flagged = NULL,
    AssetId = a.AssetId,
    a.LegacyVehicleId,
    a.AssetDescription,
    a.Registration,
    a.Sitename,
    a.FleetNumber,
    Lastposition = NULL,
    [IMEI] = NULL,
    Serialnumber = NULL,
    MobileDevice = NULL,
    ConfigCompileStatus = NULL,
    ConfigurationStatus = NULL,
    ConfigurationStatusDate = NULL,
    CommsLog = NULL,
    MessageStatusDateUtc = NULL,
    LastLogEntry = NULL,
    ConfigurationGroupId = NULL,
    ConfigurationGroupName = NULL,
    MobileDeviceTemplateId = NULL,
    MobileDeviceTemplateName = NULL,
    EventTemplateId = NULL,
    EventTemplateName = NULL,
    LocationTemplateId = NULL,
    LocationTemplateName = NULL,
    FWVersion = NULL,
    CanScriptLineId = NULL,
    CanScript = NULL,
    Speed = NULL,
    RPM = NULL,
    Fuel = NULL,
    SP = NULL,
    MiXVisionSerialnumber = NULL,
    HOS = NULL
  FROM #assets a
