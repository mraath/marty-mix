USE DeviceConfiguration
GO

--CREATE PROCEDURE reports.sprReportGetConfigLocationTemplates (
DECLARE @OrganisationId       INT = 5
DECLARE @iSiteID              INT = 0
DECLARE @LocationTemplateKey  INT = 2
DECLARE @SQL NVARCHAR(MAX),
        @DBName NVARCHAR(200)

IF OBJECT_ID('tempdb..#LocationInfo') IS NOT NULL
    DROP TABLE #LocationInfo
IF OBJECT_ID('tempdb..#LocationNames') IS NOT NULL
    DROP TABLE #LocationNames
IF OBJECT_ID('tempdb..#AssetDetails') IS NOT NULL
    DROP TABLE #AssetDetails

CREATE TABLE #LocationInfo
(
  OrgID                    INT,
  sConnectDatabase         NVARCHAR(200),
  VehicleID                INT,
  ConfigGroupName          NVARCHAR(200),
  DeviceTemplateName       NVARCHAR(2000),
  EventTemplateName        NVARCHAR(200),
  LocationTemplateName     NVARCHAR(200),
  DmxLocationID            BIGINT,
  SpeedLimit               NVARCHAR(200),
  WarningDelay             NVARCHAR(200),
  SpeedBuffer              NVARCHAR(200),
  RecordingDelay           NVARCHAR(200),
  ActiveMessagePriority    NVARCHAR(200),
  ActiveMessageForSpeed    NVARCHAR(200),
  ActiveMessageForDuration NVARCHAR(200)
)


CREATE TABLE #LocationNames
(
  VehicleID     INT,
  DmxLocationID BIGINT,
  LocationName  NVARCHAR(200)
)

CREATE TABLE #AssetDetails
(
  VehicleID      INT,
  VehicleDetails NVARCHAR(200),
  SiteID         INT,
  SiteName       NVARCHAR(200)
)

INSERT INTO #LocationInfo
  (
  OrgID,
  sConnectDatabase,
  VehicleID,
  ConfigGroupName,
  DeviceTemplateName,
  EventTemplateName,
  LocationTemplateName,
  DmxLocationID,
  SpeedLimit,
  WarningDelay,
  SpeedBuffer,
  RecordingDelay,
  ActiveMessagePriority,
  ActiveMessageForSpeed,
  ActiveMessageForDuration
  )
SELECT DISTINCT
  OrgID             = do.OrganisationId,
  sConnectDatabase  = o.sConnectDatabase,
  VehicleID         = amu.LegacyVehicleID,
  ConfigGroup       = cg.[Name],
  DeviceTemplate    = mdt.[Name],
  EventTemplate     = tet.[Name],
  LocationTemplateName  = lt.[Name],
  DmxLocationId,
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
FROM template.LocationTemplates lt WITH (NOLOCK)
  INNER JOIN template.Locations tl WITH (NOLOCK) ON lt.LocationTemplateKey = tl.LocationTemplateKey
  INNER JOIN library.Locations ll WITH (NOLOCK) ON tl.LibraryLocationKey = ll.LibraryLocationKey
    AND lt.LibraryKey = ll.LibraryKey
  INNER JOIN library.Libraries l WITH (NOLOCK) ON lt.LibraryKey = l.LibraryKey
  INNER JOIN FMOnlineDB.dynamix.Organisations do WITH (NOLOCK) ON do.GroupId = l.GroupId
  INNER JOIN FMOnlineDB.dbo.Organisation o WITH (NOLOCK) ON o.liOrgID = do.OrganisationId
  INNER JOIN template.MobileDeviceTemplates mdt WITH (NOLOCK) ON mdt.LibraryKey = l.LibraryKey
  INNER JOIN template.ConfigurationGroups cg WITH (NOLOCK) ON mdt.MobileDeviceTemplateKey = cg.MobileDeviceTemplateKey
  INNER JOIN template.[EventTemplates] tet WITH (NOLOCK) ON cg.EventTemplateKey = tet.EventTemplateKey
  INNER JOIN mobileunit.MobileUnits mmu WITH (NOLOCK) ON cg.ConfigurationGroupKey = mmu.ConfigurationGroupKey
  INNER JOIN mobileunit.AssetMobileUnits amu WITH (NOLOCK) ON mmu.MobileUnitKey = amu.MobileUnitKey
WHERE o.liOrgID = @OrganisationId
  AND lt.LocationTemplateKey = @LocationTemplateKey

SELECT @DBName = sConnectDatabase
FROM #LocationInfo

SET @SQL = 'USE [' + @DBName + '] 
      INSERT INTO #LocationNames (VehicleID, DmxLocationId, LocationName )
      SELECT li.VehicleID, li.DmxLocationId, aml.sLocationName
      FROM #LocationInfo li WITH (NOLOCK)
      INNER JOIN dynamix.MapLocations ml WITH (NOLOCK) ON ml.DmxLocationId = li.DmxLocationId
      INNER JOIN dbo.MapLocations aml WITH (NOLOCK) ON ml.MapLocationKey = aml.liLocationId'

RAISERROR (N'Scanning Org ID %d: %s', 10, 1, @OrganisationID, @DBName) WITH NOWAIT
EXEC sp_executesql @SQL;
PRINT @SQL

SET @SQL = 'USE [' + @DBName + ']
    INSERT INTO #AssetDetails (VehicleID, VehicleDetails, SiteID, SiteName)
    SELECT v.iVehicleID, v.sDesc, s.liSiteID, s.sName
    FROM dbo.Vehicles v WITH (NOLOCK) INNER JOIN dbo.Sites s WITH (NOLOCK) ON v.liSiteID = s.liSiteID
    INNER JOIN #LocationInfo li WITH (NOLOCK) ON li.VehicleID = v.iVehicleID
    WHERE s.liSiteID = ' + CONVERT(VARCHAR(100), @iSiteID)

RAISERROR (N'Scanning Org ID %d: %s', 10, 1, @OrganisationID, @DBName) WITH NOWAIT
EXEC sp_executesql @SQL;
PRINT @SQL

SELECT DISTINCT
  a.VehicleID,
  a.VehicleDetails,
  a.SiteID,
  a.SiteName,

  l.ConfigGroupName,
  l.DeviceTemplateName,
  l.EventTemplateName,
  l.LocationTemplateName,
  ln.LocationName,

  CONVERT(DECIMAL(18,2), l.SpeedLimit) AS SpeedLimit,
  CONVERT(INT, l.WarningDelay) AS WarningDelay,
  CONVERT(DECIMAL(18,2), l.SpeedBuffer) AS SpeedBuffer,
  CONVERT(INT, l.RecordingDelay) AS RecordingDelay,
  CONVERT(NVARCHAR(100), ActiveMessagePriority) AS ActiveMessagePriority,
  CONVERT(INT, l.ActiveMessageForDuration) AS ActiveMessageForDuration,
  CONVERT(DECIMAL(18,2), l.ActiveMessageForSpeed) AS ActiveMessageForSpeed
FROM #AssetDetails a
  INNER JOIN #LocationInfo l ON a.VehicleID = l.VehicleID
  INNER JOIN #LocationNames ln ON l.DmxLocationID = ln.DmxLocationID
    AND l.VehicleID = ln.VehicleID

GO
