CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups_Optimized]
  @configGroupIds   [dbo].[SelectionIds] READONLY
AS
BEGIN
  SET NOCOUNT ON;

  CREATE TABLE #assets (
    AssetDescription NVARCHAR(500),
    Registration     NVARCHAR(50),
    Sitename         NVARCHAR(500),
    FleetNumber      NVARCHAR(50),
    LegacyVehicleId  INT
  );

  CREATE TABLE #schedule (
    [ScheduleId]   INT,
    [AssetId]      BIGINT,
    [LastRun]      DATETIME,
    [LastLogEntry] NVARCHAR(500)
  );

  CREATE TABLE #LegacyVehicleIds (LegacyVehicleId INT PRIMARY KEY, AssetId BIGINT);

  WITH MobileUnitsForGroups AS (
    SELECT amu.LegacyVehicleId, amu.AssetId
    FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.id
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
    INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON mu.MobileUnitKey = amu.MobileUnitKey
  )
  INSERT INTO #LegacyVehicleIds (LegacyVehicleId, AssetId)
  SELECT LegacyVehicleId, AssetId FROM MobileUnitsForGroups;

  DECLARE @sConnectDatabase NVARCHAR(250);
  DECLARE @legacyOrgId INT;

  SELECT TOP 1 @legacyOrgId = amu.LegacyOrgId
  FROM @configGroupIds cg
  INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.id
  INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
  INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON mu.MobileUnitKey = amu.MobileUnitKey;

  SELECT @sConnectDatabase = sConnectDatabase
  FROM [FMOnlineDB].[dbo].[Organisation] fmo WITH (NOLOCK) --TODO: MR: $(Controller) 
  WHERE fmo.liOrgID = @legacyOrgId;

  DECLARE @SQL NVARCHAR(MAX);
  SET @SQL = N'USE ' + QUOTENAME(@sConnectDatabase) + N';
    INSERT INTO #assets
    SELECT DISTINCT
      v.sDesc as AssetDescription,
      v.sRegNo as Registration,
      s.sName as [Sitename],
      a.FleetNumber,
      l.LegacyVehicleId
    FROM #LegacyVehicleIds l
    INNER JOIN dbo.Vehicles v WITH (NOLOCK) ON v.iVehicleID = l.LegacyVehicleId
    INNER JOIN [dynamix].Assets a WITH (NOLOCK) ON v.iVehicleID  = a.VehicleId
    INNER JOIN dbo.Sites s WITH (NOLOCK) ON s.liSiteID = v.liSiteID;

    WITH ScheduleLogIds AS (
      SELECT
        MAX(DataScheduleLogID) DataScheduleLogID,
        a.VehicleId,
        a.AssetId
      FROM dbo.DataScheduleLog dsl WITH (NOLOCK)
      JOIN dbo.DataSchedule ds WITH (NOLOCK) ON ds.liSchedId = dsl.liSchedId
      JOIN dynamix.Assets a WITH (NOLOCK) ON a.VehicleId = ds.liObjectID
      JOIN #LegacyVehicleIds l ON l.AssetId = a.AssetId
      WHERE CAST((CAST(bUploadConfig as tinyint) + CAST(bUploadDDRs as tinyint) +
              bUploadDDRs +  ucUploadTerminalScript + ucUploadTerminalDDM +
              ucUploadTerminalDB + ucUploadCanDDM + ucUploadExtendedConfigBIN) as bit) = 1
      GROUP by a.VehicleId, a.AssetId
    )
    INSERT INTO #schedule
    SELECT
      ads.UploadScheduleId,
      logIds.AssetId,
      ds.dtLastRun,
      [dynamix].[GetLatestScheduleLogMsgByScheduleId](ds.[liSchedID], null)
    FROM ScheduleLogIds logIds WITH (NOLOCK)
    JOIN dynamix.AssetDataSchedules ads WITH (NOLOCK) ON ads.AssetId = logIds.AssetId
    JOIN dbo.DataSchedule ds WITH (NOLOCK) ON ds.liObjectId = logIds.VehicleId AND ds.liSchedID = ads.UploadScheduleId;';

  EXEC sp_executesql @SQL;

  WITH GeneralConfigGroupInfo AS (
    SELECT
      tcg.ConfigurationGroupId,
      tcg.ConfigurationGroupKey,
      tcg.Name AS ConfigurationGroupName,
      dmd.Description AS MobileDevice,
      mdt.MobileDeviceTemplateId,
      mdt.Name AS MobileDeviceTemplateName,
      tet.EventTemplateId,
      tet.Name AS EventTemplateName,
      tlt.LocationTemplateId,
      tlt.Name AS LocationTemplateName,
      dd.DeviceKey,
      tcg.MobileDeviceTemplateKey,
      tcg.LibraryKey,
      dmd.MobileDeviceType
    FROM @configGroupIds cg
      INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.id
      INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey AND tcg.LibraryKey = mdt.LibraryKey
      INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
      INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
      LEFT JOIN [template].[EventTemplates] tet WITH (NOLOCK) ON tcg.EventTemplateKey = tet.EventTemplateKey AND tcg.LibraryKey = tet.LibraryKey
      LEFT JOIN [template].[LocationTemplates] tlt WITH (NOLOCK) ON tcg.LocationTemplateKey = tlt.LocationTemplateKey AND tcg.LibraryKey = tlt.LibraryKey
  ),
  MobileUnits AS (
    SELECT
      g.ConfigurationGroupId,
      mu.ConfigurationGroupKey,
      amu.AssetId,
      mu.MobileUnitKey,
      mu.MobileDeviceKey,
      mu.MobileUnitId,
      mu.[ConfigurationStatus] AS ConfigurationStatusId,
      cs.[Description] AS ConfigurationStatus,
      mu.DateUpdated AS ConfigurationStatusDate,
      amu.LegacyOrgId,
      amu.LegacyVehicleId,
      ISNULL(mu.UniqueIdentifier, mup.Value) AS [UniqueIdentifier],
      (CASE WHEN mu.MobileDeviceKey = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE DeviceId = -1064000195705392069) THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber,
      mu.ConfigurationGenerationNotes,
      mu.ConfigurationGenerationWarning
    FROM GeneralConfigGroupInfo g
      INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
      INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON mu.MobileUnitKey = amu.MobileUnitKey
      INNER JOIN [definition].[ConfigurationStatuses] cs WITH (NOLOCK) ON cs.[ConfigurationStatus] = mu.[ConfigurationStatus]
      LEFT JOIN [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK) ON mu.[MobileUnitKey] = mup.[MobileUnitKey] AND mup.[PropertyKey] = (SELECT [PropertyKey] FROM [definition].[Properties] dp WITH (NOLOCK) WHERE dp.PropertyId = 9188780602356317147)
      LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId  = -4477362625925416557
  ),
  BlackFlags AS (
    SELECT DISTINCT mu.MobileUnitKey, 1 AS BlackFlagged
    FROM MobileUnits mu
    WHERE EXISTS (SELECT 1 FROM [mobileunit].[OverridenEvents] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenEventActions] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenEventConditionThresholds] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenDevices] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenDeviceParameters] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenCanParameters] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenDeviceProperties] o WHERE o.MobileUnitKey = mu.MobileUnitKey AND o.PersistOnReset = 0)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenPeripheralDevices] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
  )
  SELECT
    NULL AS Alerts,
    bf.BlackFlagged AS Flagged,
    mu.AssetId,
    mu.LegacyVehicleId,
    a.AssetDescription,
    a.Registration,
    a.Sitename,
    a.FleetNumber,
    NULL AS Lastposition,
    mu.UniqueIdentifier AS IMEI,
    NULL AS Serialnumber,
    g.MobileDevice,
    CASE
      WHEN mu.ConfigurationStatusId IN (4, 14, 0) THEN
        ISNULL(mu.ConfigurationGenerationWarning, mu.ConfigurationGenerationNotes)
      ELSE ''
    END AS ConfigCompileStatus,
    mu.ConfigurationStatus,
    CONVERT(NVARCHAR(23), mu.ConfigurationStatusDate, 121) AS ConfigurationStatusDate,
    NULL AS CommsLog,
    NULL AS MessageStatusDateUtc,
    sched.LastLogEntry,
    sched.ScheduleId,
    g.ConfigurationGroupId,
    g.ConfigurationGroupName,
    g.MobileDeviceTemplateId,
    g.MobileDeviceTemplateName,
    g.EventTemplateId,
    g.EventTemplateName,
    g.LocationTemplateId,
    g.LocationTemplateName,
    g.MobileDeviceType,
    NULL AS FWVersion,
    NULL AS PreferredFWVersion,
    NULL AS CanScriptLineId,
    NULL AS CanScript,
    NULL AS Speed,
    NULL AS RPM,
    NULL AS Fuel,
    NULL AS SP,
    mu.StreamaxSerialNumber AS MiXVisionSerialnumber,
    NULL AS HOS
  FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu ON mu.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN #assets a ON a.LegacyVehicleId = mu.LegacyVehicleId
    LEFT JOIN BlackFlags bf ON bf.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN #schedule sched ON sched.AssetId = mu.AssetId;

  DROP TABLE #assets;
  DROP TABLE #schedule;
  DROP TABLE #LegacyVehicleIds;

END