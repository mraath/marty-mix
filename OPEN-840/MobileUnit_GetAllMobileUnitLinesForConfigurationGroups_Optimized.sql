CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_Optimized]
  @configGroupIds   [dbo].[SelectionIds] READONLY
AS
BEGIN
  SET NOCOUNT ON;

  --This is a 1:1 translation of the original stored procedure into a CTE-based format.
  --Each CTE corresponds to a temporary table in the original version to ensure identical logic.

  DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
  DECLARE @STREAMAX_STANDALONE_DEVICE_KEY INT = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE DeviceId = -1064000195705392069);

  WITH GeneralConfigGroupInfo AS (
    -- Mirrors the original's @GeneralConfigGroupInfo table
    SELECT
      tcg.ConfigurationGroupId,
      dd.DeviceKey,
      tcg.MobileDeviceTemplateKey,
      tcg.LibraryKey,
      tcg.ConfigurationGroupKey,
      dmd.Description AS MobileDevice
    FROM @configGroupIds cg
      INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.id
      INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey AND tcg.LibraryKey = mdt.LibraryKey
      INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
      INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
  ),
  MobileUnits AS (
    -- Mirrors the original's #mobileUnits table
    SELECT
      g.ConfigurationGroupId,
      mu.MobileUnitId,
      mu.MobileUnitKey,
      mu.MobileDeviceKey,
      (CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber
    FROM GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber
  ),
  AllConfigGroupLines AS (
    -- Mirrors the original's @AllConfigGroupLines table
    SELECT
      g.ConfigurationGroupId,
      dl.[Name] AS WireName,
      lpd.[Description] AS Connection,
      dl.LineId
    FROM GeneralConfigGroupInfo g
    LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey] = g.[DeviceKey]
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
    LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
    INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey] AND g.LibraryKey = td.LibraryKey
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
    CROSS APPLY ( 
      SELECT [LineKey] = tpd.[LineKey]
      FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
      WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey] AND tpd.[LineKey]=dmdl.[LineKey]
    ) pd
    LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) ON dmdlpd.[MobileDeviceKey] = g.DeviceKey AND dmdlpd.[LineKey] = pd.[LineKey] AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey
  ),
  EffectiveLines AS (
    -- Mirrors the original's @EffectiveByMobileUnitId table
    SELECT
      mu.MobileUnitId,
      dl.[Name] AS WireName,
      lpd.[Description] AS Connection,
      pd.[IsOverridden],
      dl.LineId
    FROM MobileUnits mu
    INNER JOIN GeneralConfigGroupInfo g ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON dd.[DeviceKey] = td.[DeviceKey]
    CROSS APPLY ( 
      SELECT
        [LineKey] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN opd.[LineKey] ELSE tpd.[LineKey] END,
        [IsOverridden] = CAST(CASE WHEN opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL THEN 1 ELSE 0 END AS BIT)
      FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
      LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) ON opd.[MobileUnitKey] = mu.[MobileUnitKey] AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
      WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)
        OR (opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))
    ) pd
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = pd.[LineKey]
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) ON dmdlpd.[MobileDeviceKey] = mu.[MobileDeviceKey] AND dmdlpd.[LineKey] = pd.[LineKey] AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey
  ),
  MobileUnitLines AS (
    -- Mirrors the original's @MobileUnitLines table
    SELECT
      mu.MobileUnitId,
      cgl.ConfigurationGroupId,
      cgl.LineId,
      cgl.WireName,
      eff.IsOverridden,
      [Connection] = CASE WHEN eff.IsOverridden = 1 THEN eff.Connection ELSE cgl.Connection END
    FROM MobileUnits mu
    INNER JOIN AllConfigGroupLines cgl ON cgl.ConfigurationGroupId = mu.ConfigurationGroupId
    LEFT JOIN EffectiveLines eff ON eff.MobileUnitId = mu.MobileUnitId AND eff.LineId = cgl.LineId
  )
  -- Final SELECT, exactly matching the original's structure
  SELECT
    mu.MobileUnitId,
    CanScriptLineId = STUFF((
      SELECT ', ' + CAST(l.[LineId] AS NVARCHAR(MAX))
      FROM MobileUnitLines l
      WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.MobileUnitId = mu.MobileUnitId
      AND (l.WireName = 'C1' OR l.WireName = 'C2')
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    CanScript = STUFF((
      SELECT ', ' + l.[Connection]
      FROM MobileUnitLines l
      WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.MobileUnitId = mu.MobileUnitId
      AND (l.WireName = 'C1' OR l.WireName = 'C2')
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    Speed = CASE
      WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
      WHEN g.MobileDevice LIKE 'FM%' THEN (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName LIKE ('F%')
          AND l.Connection LIKE '%SPEED%'
      )
      ELSE (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName = 'Speed'
      )
    END,
    RPM =   CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName LIKE ('F%')
          AND l.Connection LIKE '%RPM%'
      )
      ELSE (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName = 'RPM'
      )
    END,
    Fuel =  CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName LIKE ('F%')
          AND l.Connection LIKE '%Fuel%'
      )
      ELSE (
        SELECT [Connection]
        FROM MobileUnitLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
        AND l.MobileUnitId = mu.MobileUnitId
        AND l.WireName = 'Fuel'
      )
    END,
    SP =    (
      SELECT [Connection]
      FROM MobileUnitLines l
      WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.MobileUnitId = mu.MobileUnitId
      AND l.WireName = 'SP'
    ),
    MiXVisionSerialnumber = mu.StreamaxSerialNumber,
    HOS =   (
      SELECT [Connection]
      FROM MobileUnitLines l
      WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.MobileUnitId = mu.MobileUnitId
      AND l.WireName = 'HOS'
    )
  FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu 
      ON mu.ConfigurationGroupId = g.ConfigurationGroupId;

END;
