

DECLARE @sConnectDatabase NVARCHAR(500) = 'AEMP_2023';

-- SQL OE-497 Asset Info to be pulled into Dynamic SQL

-- MobileUnits to return, this will hold all info returned
IF OBJECT_ID('tempdb..#assets') IS NOT NULL
    DROP TABLE #assets;

CREATE TABLE #assets (
    AssetDescription NVARCHAR(500),
    Registration  NVARCHAR(50),
    Sitename NVARCHAR(500),
    FleetNumber INT
);

--Get all asset information
INSERT INTO #assets
    SELECT
    v.sDesc as AssetDescription,
    v.sRegNo as Registration,
    s.sName as [Site], 
    a.FleetNumber
    FROM #mobileUnits mu
    INNER JOIN dbo.Vehicles v WITH (NOLOCK) ON v.iVehicleID = mu.LegacyVehicleId
    INNER JOIN  [dynamix].Assets a WITH (NOLOCK) ON v.iVehicleID  = a.VehicleId  
    INNER JOIN dbo.Sites s WITH (NOLOCK) ON s.liSiteID = v.liSiteID
    INNER JOIN dynamix.Sites ds WITH (NOLOCK) ON ds.SiteID = v.liSiteID

--SELECT * FROM #assets
