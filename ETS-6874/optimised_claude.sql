CREATE PROCEDURE [template].[Template_GetConfigurationGroupsOtherColumns]
  @groupId BIGINT
AS
BEGIN

  --VARIABLES
  DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;

  DECLARE @FWVersion SMALLINT = 
        (SELECT PropertyKey
  FROM [definition].[Properties] WITH (NOLOCK)
  WHERE PropertyId = @PreferedFirmwareVersion);


  -- GENERAL INFORMATION
  DECLARE @GeneralConfigGroupInfo TABLE
    (
    ConfigurationGroupId     BIGINT PRIMARY KEY CLUSTERED,
    ConfigurationGroupKey    INT,
    MobileDeviceTemplateKey  BIGINT,
    LibraryKey               INT,
    DeviceKey                INT,
    MobileDevice             NVARCHAR(50)
    )
  INSERT INTO @GeneralConfigGroupInfo
  SELECT
    tcg.ConfigurationGroupId,
    tcg.ConfigurationGroupKey,
    tcg.MobileDeviceTemplateKey,
    tcg.LibraryKey,
    dd.DeviceKey,
    dmd.Description AS MobileDevice
  FROM [library].[Libraries] l WITH (NOLOCK)
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.LibraryKey = l.LibraryKey
    INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
    ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
      AND tcg.LibraryKey = mdt.LibraryKey
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
    INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
  WHERE l.GroupId = @groupId


  -- ASSET COUNT - Simplified to single query
  DECLARE @AssetsCount TABLE
    (
    ConfigurationGroupId BIGINT PRIMARY KEY CLUSTERED,
    AssetsCount          INT
    )
  INSERT INTO @AssetsCount
  SELECT 
    g.ConfigurationGroupId, 
    COUNT(DISTINCT amu.MobileUnitKey)
  FROM @GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) 
      ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) 
      ON amu.MobileUnitKey = mu.MobileUnitKey
  GROUP BY g.ConfigurationGroupId


  -- FLAGS - Optimized with EXISTS
  DECLARE @BlackFlagsCount TABLE
    (
    ConfigurationGroupId BIGINT PRIMARY KEY CLUSTERED,
    BlackFlagsCount      INT
    )
  INSERT INTO @BlackFlagsCount
  SELECT 
    g.ConfigurationGroupId,
    COUNT(DISTINCT mu.MobileUnitKey)
  FROM @GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) 
      ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
  WHERE EXISTS (
    SELECT 1 FROM [mobileunit].[OverridenEvents] WITH (NOLOCK) 
    WHERE MobileUnitKey = mu.MobileUnitKey
    UNION ALL
    SELECT 1 FROM [mobileunit].[OverridenEventActions] WITH (NOLOCK) 
    WHERE MobileUnitKey = mu.MobileUnitKey
    UNION ALL
    SELECT 1 FROM [mobileunit].[OverridenEventConditionThresholds] WITH (NOLOCK) 
    WHERE MobileUnitKey = mu.MobileUnitKey
    UNION ALL
    SELECT 1 FROM [mobileunit].[OverridenDevices] WITH (NOLOCK) 
    WHERE MobileUnitKey = mu.MobileUnitKey
    UNION ALL
    SELECT 1 FROM [mobileunit].[OverridenDeviceParameters] WITH (NOLOCK) 
    WHERE MobileUnitKey = mu.MobileUnitKey
    UNION ALL
    SELECT 1 FROM [mobileunit].[OverridenCanParameters] WITH (NOLOCK) 
    WHERE MobileUnitKey = mu.MobileUnitKey
    UNION ALL
    SELECT 1 FROM [mobileunit].[OverridenDeviceProperties] WITH (NOLOCK) 
    WHERE MobileUnitKey = mu.MobileUnitKey AND PersistOnReset = 0
    UNION ALL
    SELECT 1 FROM [mobileunit].[OverridenPeripheralDevices] WITH (NOLOCK) 
    WHERE MobileUnitKey = mu.MobileUnitKey
  )
  GROUP BY g.ConfigurationGroupId


  -- FW VERSION - Optimized with reordered joins
  DECLARE @FWVersions TABLE  
  (
    [ConfigurationGroupId] BIGINT,
    [FWName]               NVARCHAR(50)
  );

  INSERT INTO @FWVersions
  SELECT DISTINCT
    g.ConfigurationGroupId,
    fw.Name
  FROM @GeneralConfigGroupInfo g
    INNER JOIN [template].[Devices] td WITH (NOLOCK)
      ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
      AND td.LibraryKey = g.LibraryKey
    INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
      ON tdpr.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
      AND tdpr.DeviceKey = td.DeviceKey
      AND tdpr.PropertyKey = @FWVersion
      AND tdpr.Value IS NOT NULL
      AND ISNUMERIC(tdpr.Value) = 1
    INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
      ON dep.ChildDeviceKey = td.DeviceKey
      AND dep.ParentDeviceKey = g.DeviceKey
      AND dep.DependencyType = 1
    INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) 
      ON fw.FirmwareVersionId = CAST(tdpr.Value AS BIGINT)


  -- Get all line information in one go
  DECLARE @AllLines TABLE
  (
    ConfigurationGroupId BIGINT,
    WireName NVARCHAR(200),
    Connection NVARCHAR(200),
    LineId NVARCHAR(50)
  )
  
  INSERT INTO @AllLines
  SELECT
    g.ConfigurationGroupId,
    dl.[Name] AS WireName,
    lpd.[Description] AS Connection,
    dl.LineId
  FROM @GeneralConfigGroupInfo g
    INNER JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) 
      ON dmdl.MobileDeviceKey = g.DeviceKey
    INNER JOIN [definition].[Lines] dl WITH (NOLOCK) 
      ON dl.LineKey = dmdl.LineKey
    INNER JOIN [template].[Devices] td WITH (NOLOCK)
      ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
      AND td.LibraryKey = g.LibraryKey
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) 
      ON tdd.DeviceKey = td.DeviceKey
    INNER JOIN [template].[PeripheralDevices] tpd WITH (NOLOCK)
      ON tpd.TemplateDeviceKey = td.TemplateDeviceKey
      AND tpd.LineKey = dmdl.LineKey
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
      ON dmdlpd.MobileDeviceKey = g.DeviceKey
      AND dmdlpd.LineKey = dmdl.LineKey
      AND dmdlpd.PeripheralDeviceKey = tdd.DeviceKey
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) 
      ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey 
      AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) 
      ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey

  -- Now aggregate the line data
  DECLARE @LineData TABLE
  (
    ConfigurationGroupId BIGINT PRIMARY KEY CLUSTERED,
    CanScriptLineId NVARCHAR(MAX),
    CanScript NVARCHAR(MAX),
    Speed NVARCHAR(200),
    RPM NVARCHAR(200),
    Fuel NVARCHAR(200),
    SP NVARCHAR(200),
    HOS NVARCHAR(200),
    FreqSpeed NVARCHAR(200),
    FreqRPM NVARCHAR(200),
    FreqFuel NVARCHAR(200)
  )

  INSERT INTO @LineData
  SELECT
    ConfigurationGroupId,
    CanScriptLineId = STUFF((
      SELECT ', ' + LineId
      FROM @AllLines al2
      WHERE al2.ConfigurationGroupId = al.ConfigurationGroupId
        AND (al2.WireName = 'C1' OR al2.WireName = 'C2')
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    CanScript = STUFF((
      SELECT ', ' + Connection
      FROM @AllLines al2
      WHERE al2.ConfigurationGroupId = al.ConfigurationGroupId
        AND (al2.WireName = 'C1' OR al2.WireName = 'C2')
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    Speed = MAX(CASE WHEN WireName = 'Speed' THEN Connection END),
    RPM = MAX(CASE WHEN WireName = 'RPM' THEN Connection END),
    Fuel = MAX(CASE WHEN WireName = 'Fuel' THEN Connection END),
    SP = MAX(CASE WHEN WireName = 'SP' THEN Connection END),
    HOS = MAX(CASE WHEN WireName = 'HOS' THEN Connection END),
    FreqSpeed = MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%SPEED%' THEN Connection END),
    FreqRPM = MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%RPM%' THEN Connection END),
    FreqFuel = MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%Fuel%' THEN Connection END)
  FROM @AllLines al
  GROUP BY ConfigurationGroupId


  -- FINAL RESULT
  SELECT
    Flagged = b.BlackFlagsCount,
    g.ConfigurationGroupId,
    a.AssetsCount,
    FWVersion = STUFF((
      SELECT ', ' + fw.FWName
      FROM @FWVersions fw
      WHERE fw.ConfigurationGroupId = g.ConfigurationGroupId
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    ld.CanScriptLineId,
    ld.CanScript,
    Speed = CASE
      WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
      WHEN g.MobileDevice LIKE 'FM%' THEN ld.FreqSpeed
      ELSE ld.Speed
    END,
    RPM = CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN ld.FreqRPM
      ELSE ld.RPM
    END,
    Fuel = CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN ld.FreqFuel
      ELSE ld.Fuel
    END,
    SP = ld.SP,
    HOS = ld.HOS
  FROM @GeneralConfigGroupInfo g
    LEFT JOIN @AssetsCount a ON a.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN @BlackFlagsCount b ON b.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN @LineData ld ON ld.ConfigurationGroupId = g.ConfigurationGroupId

END