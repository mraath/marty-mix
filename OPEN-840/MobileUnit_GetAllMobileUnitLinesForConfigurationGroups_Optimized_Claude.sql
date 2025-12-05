CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_Optimized_Claude]
  @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
  DECLARE @STREAMAX_STANDALONE_DEVICE_KEY INT = (
    SELECT [DeviceKey] 
    FROM [definition].[Devices] WITH (NOLOCK) 
    WHERE DeviceId = -1064000195705392069
  );

  -- Step 1: General Config Group Info with proper indexing
  CREATE TABLE #GeneralConfigGroupInfo (
    ConfigurationGroupId     BIGINT,
    DeviceKey                INT,
    MobileDeviceTemplateKey  BIGINT,
    LibraryKey               INT,
    ConfigurationGroupKey    INT,
    MobileDevice             NVARCHAR(50),
    INDEX IX_ConfigGroupId CLUSTERED (ConfigurationGroupId),
    INDEX IX_DeviceKey NONCLUSTERED (DeviceKey),
    INDEX IX_ConfigGroupKey NONCLUSTERED (ConfigurationGroupKey)
  );

  INSERT INTO #GeneralConfigGroupInfo
  SELECT
    tcg.ConfigurationGroupId,
    dd.DeviceKey,
    tcg.MobileDeviceTemplateKey,
    tcg.LibraryKey,
    tcg.ConfigurationGroupKey,
    dmd.Description
  FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) 
      ON tcg.ConfigurationGroupId = cg.id
    INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) 
      ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey 
      AND tcg.LibraryKey = mdt.LibraryKey
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) 
      ON mdt.MobileDeviceKey = dd.DeviceKey
    INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) 
      ON dd.DeviceKey = dmd.DeviceKey;

  -- Step 2: Mobile Units with proper indexing
  CREATE TABLE #MobileUnits (
    ConfigurationGroupId     BIGINT,
    MobileUnitId             BIGINT,
    MobileUnitKey            INT,
    MobileDeviceKey          INT,
    StreamaxSerialNumber     NVARCHAR(250),
    INDEX IX_MobileUnitId CLUSTERED (MobileUnitId),
    INDEX IX_ConfigGroupId NONCLUSTERED (ConfigurationGroupId),
    INDEX IX_MobileUnitKey NONCLUSTERED (MobileUnitKey)
  );

  INSERT INTO #MobileUnits
  SELECT
    g.ConfigurationGroupId,
    mu.MobileUnitId,
    mu.MobileUnitKey,
    mu.MobileDeviceKey,
    CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY 
         THEN mu.UniqueIdentifier 
         ELSE ap.Value 
    END
  FROM #GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) 
      ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) 
      ON mu.MobileUnitId = ap.AssetId 
      AND ap.PropertyId = @StreamaxSerialNumber;

  -- Step 3: All Config Group Lines
  CREATE TABLE #AllConfigGroupLines (
    ConfigurationGroupId BIGINT,
    WireName             NVARCHAR(200),
    Connection           NVARCHAR(200),
    LineId               NVARCHAR(50),
    INDEX IX_ConfigGroupId CLUSTERED (ConfigurationGroupId, LineId)
  );

  INSERT INTO #AllConfigGroupLines
  SELECT
    g.ConfigurationGroupId,
    dl.[Name],
    lpd.[Description],
    dl.LineId
  FROM #GeneralConfigGroupInfo g
    LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) 
      ON dmdl.[MobileDeviceKey] = g.DeviceKey
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) 
      ON dl.[LineKey] = dmdl.[LineKey]
    INNER JOIN [template].[Devices] td WITH (NOLOCK) 
      ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
      AND g.LibraryKey = td.LibraryKey
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) 
      ON tdd.[DeviceKey] = td.[DeviceKey]
    CROSS APPLY ( 
      SELECT [LineKey] = tpd.[LineKey]
      FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
      WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND tpd.[LineKey] = dmdl.[LineKey]
    ) pd
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) 
      ON dmdlpd.[MobileDeviceKey] = g.DeviceKey
      AND dmdlpd.[LineKey] = pd.[LineKey]
      AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) 
      ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey 
      AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) 
      ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey;

  -- Step 4: Effective Lines
  CREATE TABLE #EffectiveLines (
    MobileUnitId   BIGINT,
    WireName       NVARCHAR(200),
    Connection     NVARCHAR(200),
    IsOverridden   BIT,
    LineId         NVARCHAR(50),
    INDEX IX_MobileUnitId CLUSTERED (MobileUnitId, LineId)
  );

  INSERT INTO #EffectiveLines
  SELECT
    mu.MobileUnitId,
    dl.[Name],
    lpd.[Description],
    CAST(CASE WHEN opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL 
              THEN 1 ELSE 0 END AS BIT),
    dl.LineId
  FROM #MobileUnits mu
    INNER JOIN #GeneralConfigGroupInfo g 
      ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    INNER JOIN [template].[Devices] td WITH (NOLOCK) 
      ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) 
      ON dd.[DeviceKey] = td.[DeviceKey]
    CROSS APPLY ( 
      SELECT
        [LineKey] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL 
                         THEN opd.[LineKey] 
                         ELSE tpd.[LineKey] END
      FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
        LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) 
          ON opd.[MobileUnitKey] = mu.[MobileUnitKey]
          AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
      WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)
             OR (opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))
    ) pd
    LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK)
      ON opd.[MobileUnitKey] = mu.[MobileUnitKey]
      AND opd.[LineKey] = pd.[LineKey]
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) 
      ON dl.[LineKey] = pd.[LineKey]
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) 
      ON dmdlpd.[MobileDeviceKey] = mu.[MobileDeviceKey]
      AND dmdlpd.[LineKey] = pd.[LineKey]
      AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) 
      ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey
      AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) 
      ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey;

  -- Step 5: Mobile Unit Lines (matching original ORDER BY)
  CREATE TABLE #MobileUnitLines (
    MobileUnitId         BIGINT,
    ConfigurationGroupId BIGINT,
    LineId               NVARCHAR(50),
    WireName             NVARCHAR(200),
    IsOverridden         BIT,
    Connection           NVARCHAR(200),
    INDEX IX_Main CLUSTERED (ConfigurationGroupId DESC, WireName DESC, MobileUnitId)
  );

  INSERT INTO #MobileUnitLines
  SELECT
    mu.MobileUnitId,
    cgl.ConfigurationGroupId,
    cgl.LineId,
    cgl.WireName,
    ISNULL(eff.IsOverridden, 0),
    CASE WHEN ISNULL(eff.IsOverridden, 0) = 1 
         THEN eff.Connection 
         ELSE cgl.Connection END
  FROM #MobileUnits mu
    INNER JOIN #AllConfigGroupLines cgl 
      ON cgl.ConfigurationGroupId = mu.ConfigurationGroupId
    LEFT JOIN #EffectiveLines eff 
      ON eff.MobileUnitId = mu.MobileUnitId
      AND eff.LineId = cgl.LineId
  ORDER BY cgl.ConfigurationGroupId DESC, cgl.WireName DESC;

  -- Step 6: Pre-aggregate specific wire values to avoid correlated subqueries
  CREATE TABLE #AggregatedLines (
    MobileUnitId          BIGINT,
    ConfigurationGroupId  BIGINT,
    CanScriptLineId       NVARCHAR(MAX),
    CanScript             NVARCHAR(MAX),
    SpeedConnection       NVARCHAR(200),
    RPMConnection         NVARCHAR(200),
    FuelConnection        NVARCHAR(200),
    SPConnection          NVARCHAR(200),
    HOSConnection         NVARCHAR(200),
    FreqSpeedConnection   NVARCHAR(200),
    FreqRPMConnection     NVARCHAR(200),
    FreqFuelConnection    NVARCHAR(200),
    INDEX IX_Main CLUSTERED (MobileUnitId, ConfigurationGroupId)
  );

  INSERT INTO #AggregatedLines
  SELECT
    l.MobileUnitId,
    l.ConfigurationGroupId,
    -- CanScriptLineId (order by WireName DESC to match original)
    STUFF((
      SELECT ', ' + l2.LineId
      FROM #MobileUnitLines l2
      WHERE l2.MobileUnitId = l.MobileUnitId
        AND l2.ConfigurationGroupId = l.ConfigurationGroupId
        AND l2.WireName IN ('C1', 'C2')
      ORDER BY l2.WireName DESC
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    -- CanScript (order by WireName DESC to match original)
    STUFF((
      SELECT ', ' + l2.Connection
      FROM #MobileUnitLines l2
      WHERE l2.MobileUnitId = l.MobileUnitId
        AND l2.ConfigurationGroupId = l.ConfigurationGroupId
        AND l2.WireName IN ('C1', 'C2')
      ORDER BY l2.WireName DESC
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    -- Speed
    MAX(CASE WHEN l.WireName = 'Speed' THEN l.Connection END),
    -- RPM
    MAX(CASE WHEN l.WireName = 'RPM' THEN l.Connection END),
    -- Fuel
    MAX(CASE WHEN l.WireName = 'Fuel' THEN l.Connection END),
    -- SP
    MAX(CASE WHEN l.WireName = 'SP' THEN l.Connection END),
    -- HOS
    MAX(CASE WHEN l.WireName = 'HOS' THEN l.Connection END),
    -- Frequency lines for Speed
    MAX(CASE WHEN l.WireName LIKE 'F%' AND l.Connection LIKE '%SPEED%' 
             THEN l.Connection END),
    -- Frequency lines for RPM
    MAX(CASE WHEN l.WireName LIKE 'F%' AND l.Connection LIKE '%RPM%' 
             THEN l.Connection END),
    -- Frequency lines for Fuel
    MAX(CASE WHEN l.WireName LIKE 'F%' AND l.Connection LIKE '%Fuel%' 
             THEN l.Connection END)
  FROM #MobileUnitLines l
  GROUP BY l.MobileUnitId, l.ConfigurationGroupId;

  -- Final SELECT with pre-aggregated data
  SELECT
    mu.MobileUnitId,
    agg.CanScriptLineId,
    agg.CanScript,
    Speed = CASE
      WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
      WHEN g.MobileDevice LIKE 'FM%' THEN agg.FreqSpeedConnection
      ELSE agg.SpeedConnection
    END,
    RPM = CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN agg.FreqRPMConnection
      ELSE agg.RPMConnection
    END,
    Fuel = CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN agg.FreqFuelConnection
      ELSE agg.FuelConnection
    END,
    SP = agg.SPConnection,
    MiXVisionSerialnumber = mu.StreamaxSerialNumber,
    HOS = agg.HOSConnection
  FROM #GeneralConfigGroupInfo g
    INNER JOIN #MobileUnits mu 
      ON mu.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN #AggregatedLines agg
      ON agg.MobileUnitId = mu.MobileUnitId
      AND agg.ConfigurationGroupId = g.ConfigurationGroupId;

  -- Cleanup
  DROP TABLE IF EXISTS #GeneralConfigGroupInfo;
  DROP TABLE IF EXISTS #MobileUnits;
  DROP TABLE IF EXISTS #AllConfigGroupLines;
  DROP TABLE IF EXISTS #EffectiveLines;
  DROP TABLE IF EXISTS #MobileUnitLines;
  DROP TABLE IF EXISTS #AggregatedLines;

END;