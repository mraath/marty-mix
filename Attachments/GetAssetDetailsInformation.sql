/*
SELECT * 
FROM mobileunit.MobileUnits mu WITH (NOLOCK)
  INNER JOIN template.ConfigurationGroups cg WITH (NOLOCK) ON cg.ConfigurationGroupKey = mu.ConfigurationGroupKey
WHERE cg.LocationTemplateKey IS NOT NULL
*/

--Donny's
--assetId=6934857543195929626
--1230279699646066688
--1058595422649217024

DECLARE @mobileUnitId BIGINT = 1058595422649217024;

--Configuration status
DECLARE @configurationStatus TABLE (
  StatusId            INT,
  ConfigurationStatus NVARCHAR(50)
);

INSERT INTO @configurationStatus
VALUES(0, 'Not commissioned');
INSERT INTO @configurationStatus
VALUES(1, 'Configuration changed');
INSERT INTO @configurationStatus
VALUES(2, 'Compile requested');
INSERT INTO @configurationStatus
VALUES(3, 'Compiling');
INSERT INTO @configurationStatus
VALUES(4, 'Compile failed');
INSERT INTO @configurationStatus
VALUES(5, 'Ready for upload');
INSERT INTO @configurationStatus
VALUES(6, 'Upload requested');
INSERT INTO @configurationStatus
VALUES(7, 'Uploading configuration');
INSERT INTO @configurationStatus
VALUES(8, 'Upload success');
INSERT INTO @configurationStatus
VALUES(9, 'Upload failed');
INSERT INTO @configurationStatus
VALUES(10, 'Plug generated');
INSERT INTO @configurationStatus
VALUES(11, 'Configuration accepted');
INSERT INTO @configurationStatus
VALUES(12, 'Configuration rejected');
INSERT INTO @configurationStatus
VALUES(13, 'Unit rollback');
INSERT INTO @configurationStatus
VALUES(14, 'Configuration warning');

--Get MobileUnit Information needed
USE DeviceConfiguration;

DECLARE @configuration TABLE (
  LegacyVehicleId         INT,
  LegacyOrgId             INT,
  MobileUnitId            BIGINT,
  ConfigurationGroup      NVARCHAR(250),
  DeviceTemplate          NVARCHAR(250),
  EventTemplate           NVARCHAR(250),
  LocationTemplate        NVARCHAR(250),
  ConfigurationStatus     NVARCHAR(50),
  ConfigurationStatusDate DATETIME
 );

INSERT INTO @configuration
SELECT
  amu.LegacyVehicleId,
  amu.LegacyOrgId,
  mu.MobileUnitId,
  cg.Name ConfigurationGroup,
  mdt.Name DeviceTemplate,
  et.Name EventTemplate,
  lt.Name LocationTemplate,
  cs.ConfigurationStatus ConfigurationStatus,
  mu.DateUpdated ConfigurationStatusDate
--TODO: MR: Format for User @ UI
FROM mobileunit.MobileUnits mu WITH (NOLOCK)
  INNER JOIN mobileunit.AssetMobileUnits amu WITH (NOLOCK)
  ON amu.MobileUnitKey = mu.MobileUnitKey
  INNER JOIN template.ConfigurationGroups cg WITH (NOLOCK)
  ON cg.ConfigurationGroupKey = mu.ConfigurationGroupKey
  LEFT JOIN template.MobileDeviceTemplates mdt WITH (NOLOCK)
  ON mdt.MobileDeviceTemplateKey = cg.MobileDeviceTemplateKey
  LEFT JOIN template.EventTemplates et WITH (NOLOCK)
  ON et.EventTemplateKey = cg.EventTemplateKey
  LEFT JOIN template.LocationTemplates lt WITH (NOLOCK)
  ON lt.LocationTemplateKey = cg.LocationTemplateKey
  LEFT JOIN @configurationStatus cs
  ON cs.StatusId = mu.ConfigurationStatus
WHERE mu.MobileUnitId = @mobileUnitId;

--Legacy info
DECLARE @legacyVehicleId INT = (SELECT TOP 1
  LegacyVehicleId
FROM @configuration);
DECLARE @legacyOrgId INT = (SELECT TOP 1
  LegacyOrgId
FROM @configuration);

--Organisation information
--TODO: MR: Use global vars here
DECLARE @sConnectDatabase NVARCHAR(250);
SELECT @sConnectDatabase = 
  sConnectDatabase
FROM FMOnlineDB.dbo.Organisation
WHERE liOrgID = @legacyOrgId;

--Vehicle information
IF OBJECT_ID('tempdb..#AssetDetails') IS NOT NULL
    DROP TABLE #AssetDetails
CREATE TABLE #AssetDetails
(
  VehicleID      INT,
  VehicleDetails NVARCHAR(200),
  SiteID         INT,
  SiteName       NVARCHAR(200)
)

/*
DECLARE @vehicle TABLE (
  VehicleID      INT,
  VehicleDetails NVARCHAR(250),
  SiteID         INT,
  SiteName       NVARCHAR(250)
);
*/

DECLARE @SQL NVARCHAR(MAX) = 'USE [' + @sConnectDatabase + ']
    INSERT INTO #AssetDetails (VehicleID, VehicleDetails, SiteID, SiteName)
    SELECT v.iVehicleID, v.sDesc, s.liSiteID, s.sName
    FROM dbo.Vehicles v WITH (NOLOCK) 
    INNER JOIN dbo.Sites s WITH (NOLOCK) 
      ON v.liSiteID = s.liSiteID
    WHERE v.iVehicleID = '+ CONVERT(VARCHAR(100), @legacyVehicleId);
-- +  @legacyVehicleId
--WHERE s.liSiteID = ' + CONVERT(VARCHAR(100), @iSiteID)
EXEC sp_executesql @SQL;


/*


 ConfigGroup       = cg.[Name],
  DeviceTemplate    = mdt.[Name],
  EventTemplate     = tet.[Name],

--Get Asset Information needed
SELECT v.iVehicleID, v.sDesc, s.liSiteID, s.sName
FROM dbo.Vehicles v WITH (NOLOCK)
  INNER JOIN dbo.Sites s WITH (NOLOCK) ON v.liSiteID = s.liSiteID
WHERE 

--Return merged Information needed
*/

--TEST
SELECT *
FROM #AssetDetails
SELECT *
FROM @configuration