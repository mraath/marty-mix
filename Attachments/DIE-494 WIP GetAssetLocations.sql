--Donny's
--assetId=6934857543195929626
--1230279699646066688 (happy)
--1058595422649217024

DECLARE @mobileUnitId BIGINT = 1230279699646066688;

USE DeviceConfiguration;

--Get MobileUnit Information needed
DECLARE @configuration TABLE (
  LegacyOrgId         INT,
  LibraryKey          INT,
  LocationTemplateKey INT,
  MobileUnitId        BIGINT
 );

INSERT INTO @configuration
SELECT
  amu.LegacyOrgId,
  lt.LibraryKey,
  lt.LocationTemplateKey,
  mu.MobileUnitId
FROM mobileunit.MobileUnits mu WITH (NOLOCK)
  INNER JOIN mobileunit.AssetMobileUnits amu WITH (NOLOCK)
  ON amu.MobileUnitKey = mu.MobileUnitKey
  INNER JOIN template.ConfigurationGroups cg WITH (NOLOCK)
  ON cg.ConfigurationGroupKey = mu.ConfigurationGroupKey
  LEFT JOIN template.LocationTemplates lt WITH (NOLOCK)
  ON lt.LocationTemplateKey = cg.LocationTemplateKey
WHERE mu.MobileUnitId = @mobileUnitId;

--Location info
IF OBJECT_ID('tempdb..#locations') IS NOT NULL
    DROP TABLE #locations

CREATE TABLE #locations
(
  MobileUnitId             BIGINT,
  DmxLocationID            BIGINT,
  SpeedLimit               NVARCHAR(200),
  WarningDelay             NVARCHAR(200),
  SpeedBuffer              NVARCHAR(200),
  RecordingDelay           NVARCHAR(200),
  ActiveMessagePriority    NVARCHAR(200),
  ActiveMessageForSpeed    NVARCHAR(200),
  ActiveMessageForDuration NVARCHAR(200)
);

INSERT INTO #locations
SELECT
  lt.MobileUnitId,
  ll.DmxLocationId,
  tl.SpeedLimit,
  tl.WarningDelay,
  tl.SpeedBuffer,
  tl.RecordingDelay,
  CASE tl.ActiveMessagePriority
      WHEN 100 THEN CONVERT(VARCHAR(100), 'Normal')
      WHEN 225 THEN CONVERT(NVARCHAR(100), 'Critical (Limited)')
      WHEN 250 THEN CONVERT(VARCHAR(100), 'Critical')
      ELSE CONVERT(VARCHAR(100), 'Unknown')
    END AS ActiveMessagePriority,
  ActiveMessageForSpeed   =
      CASE tl.EnableActiveMessageExcessiveSpeedLimit
        WHEN 1 THEN CONVERT(NVARCHAR(200), tl.ActiveMessageExcessiveSpeedLimit)
        ELSE ''
      END,
  ActiveMessageForDuration  =
      CASE tl.EnableActiveMessageDelay
        WHEN 1 THEN CONVERT(NVARCHAR(200), tl.ActiveMessageDelay)
        ELSE ''
      END
FROM @configuration lt
  LEFT JOIN template.Locations tl WITH (NOLOCK)
  ON lt.LocationTemplateKey = tl.LocationTemplateKey
  LEFT JOIN library.Locations ll WITH (NOLOCK)
  ON tl.LibraryLocationKey = ll.LibraryLocationKey
    AND lt.LibraryKey = ll.LibraryKey

--Legacy info
DECLARE @legacyOrgId INT = (SELECT TOP 1
  LegacyOrgId
FROM @configuration);

--Organisation information
DECLARE @sConnectDatabase NVARCHAR(250);
SELECT @sConnectDatabase = 
  sConnectDatabase
FROM FMOnlineDB.dbo.Organisation
WHERE liOrgID = @legacyOrgId;

--Location Names

IF OBJECT_ID('tempdb..#LocationNames') IS NOT NULL
    DROP TABLE #LocationNames

CREATE TABLE #LocationNames
(
  DmxLocationID    BIGINT,
  LocationName     NVARCHAR(200),
  LocationTypeDesc NVARCHAR(200)
)

DECLARE @SQL NVARCHAR(MAX) = 'USE [' + @sConnectDatabase + '] 
      INSERT INTO #LocationNames (DmxLocationId, LocationName, LocationTypeDesc )
      SELECT ml.DmxLocationId, aml.sLocationName, ld.LocationTypeDesc
      FROM #locations l
      INNER JOIN dynamix.MapLocations ml WITH (NOLOCK) ON ml.DmxLocationId = CONVERT(VARCHAR(100), l.DmxLocationId)
      INNER JOIN dbo.MapLocations aml WITH (NOLOCK) ON ml.MapLocationKey = aml.liLocationId
      LEFT JOIN fncGetLocationTypeDesc() ld ON ld.LocationType = aml.ucLocationType';
--WHERE ml.DmxLocationId = '+ ;

EXEC sp_executesql @SQL;

--TEST
SELECT
  ln.LocationName,
  ln.LocationTypeDesc,
  l.SpeedLimit,
  l.SpeedBuffer,
  l.WarningDelay,
  l.RecordingDelay,
  l.ActiveMessagePriority,
  l.ActiveMessageForDuration,
  l.ActiveMessageForSpeed
FROM @configuration c
  LEFT JOIN #locations l ON l.MobileUnitId = c.MobileUnitId
  LEFT JOIN #LocationNames ln ON ln.DmxLocationID = l.DmxLocationID
