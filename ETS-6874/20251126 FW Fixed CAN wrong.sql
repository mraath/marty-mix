CREATE PROCEDURE [template].[Template_GetConfigurationGroupsOtherColumns]
  @groupId BIGINT
AS
BEGIN

  SET NOCOUNT ON;

  --VARIABLES
  DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;

  DECLARE @FWVersion SMALLINT = 
        (SELECT PropertyKey
  FROM [definition].[Properties] WITH (NOLOCK)
  WHERE PropertyId = @PreferedFirmwareVersion);

  WITH GeneralConfigGroupInfo AS (
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
  ), MobileUnits AS (
    SELECT
      g.ConfigurationGroupId,
      mu.ConfigurationGroupKey,
      (mu.MobileUnitKey) AS MobileUnitKey
    FROM GeneralConfigGroupInfo g
      INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
      INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON amu.MobileUnitKey = mu.MobileUnitKey
  ), AssetsCount AS (
    SELECT
      ConfigurationGroupId,
      Count(MobileUnitKey) AS AssetsCount
    FROM MobileUnits
    GROUP BY ConfigurationGroupId
  ), BlackFlagsCount AS (
    SELECT
      ConfigurationGroupId,
      COUNT(MobileUnitKey) AS BlackFlagsCount
    FROM
      (
        SELECT DISTINCT
          mu.ConfigurationGroupId AS ConfigurationGroupId,
          mu.MobileUnitKey AS MobileUnitKey
        FROM MobileUnits mu
          --Overwritten Events
          LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK) ON events.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = mu.MobileUnitKey
          --Overwritten Device Info
          LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK) ON devices.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK) ON properties.MobileUnitKey = mu.MobileUnitKey
            AND properties.PersistOnReset = 0
          LEFT JOIN [mobileunit].[OverridenPeripheralDevices] peripherals WITH (NOLOCK) ON peripherals.MobileUnitKey = mu.MobileUnitKey
        WHERE
          (
            events.MobileUnitKey IS NOT NULL
            OR eventActions.MobileUnitKey IS NOT NULL
            OR thresholds.MobileUnitKey IS NOT NULL
            OR devices.MobileUnitKey IS NOT NULL
            OR params.MobileUnitKey IS NOT NULL
            OR paramsCan.MobileUnitKey IS NOT NULL
            OR properties.MobileUnitKey IS NOT NULL
            OR peripherals.MobileUnitKey IS NOT NULL
          )
      ) AS uniqueRows
    GROUP BY ConfigurationGroupId
  ), AllConfigGroupLines AS (
    SELECT
      [ConfigurationGroupId] = g.ConfigurationGroupId,
      [WireName] = dl.[Name],
      [Connection] = lpd.[Description],
      [LineId] = dl.LineId
    FROM GeneralConfigGroupInfo g
      LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey] = g.DeviceKey
      LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
      LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
      --Template Devices
      INNER JOIN [template].[Devices] td WITH (NOLOCK)
      ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
        AND g.LibraryKey = td.LibraryKey
      INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
      -- Peripheral devices
      CROSS APPLY
      (
        SELECT
          [LineKey] = tpd.[LineKey]
        FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
        WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
          AND tpd.[LineKey] = dmdl.[LineKey]
      ) pd
      LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]
      -- Lines
      LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
      ON dmdlpd.[MobileDeviceKey] = g.DeviceKey --mu.[MobileDeviceKey]
        AND dmdlpd.[LineKey] = pd.[LineKey]
        AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
      -- Get connected device
      LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey
        AND ld.LibraryKey = g.LibraryKey
      LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey
  ), FWVersions AS (
    SELECT DISTINCT
      g.ConfigurationGroupId,
      fw.Name AS FWName
    FROM GeneralConfigGroupInfo g
      -- Find optional logical device dependencies for the main mobile device
      INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
      ON dep.ParentDeviceKey = g.DeviceKey
        AND dep.DependencyType = 1
      -- Join template.Devices on the child device from dependencies
      INNER JOIN [template].[Devices] td WITH (NOLOCK)
      ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
        AND td.LibraryKey = g.LibraryKey
        AND td.DeviceKey = dep.ChildDeviceKey
      -- Get firmware properties from the dependency device
      INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
      ON tdpr.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
        AND tdpr.DeviceKey = td.DeviceKey
        AND tdpr.PropertyKey = @FWVersion
      -- Get the firmware version details
      INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = tdpr.Value
    WHERE tdpr.Value IS NOT NULL
  ), AggregatedFW AS (
    SELECT
      ConfigurationGroupId,
      STUFF((
        SELECT
          ', ' + FWName
        FROM FWVersions fw
        WHERE
          fw.ConfigurationGroupId = f.ConfigurationGroupId
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS FWVersion
    FROM FWVersions f
    GROUP BY ConfigurationGroupId
  ), PivotedLines AS (
    SELECT
      ConfigurationGroupId,
      MAX(CASE WHEN WireName IN ('C1', 'C2') THEN Connection END) AS CanScript,
      MAX(CASE WHEN WireName IN ('C1', 'C2') THEN LineId END) AS CanScriptLineId,
      MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%SPEED%' THEN Connection END) AS Speed_FM,
      MAX(CASE WHEN WireName = 'Speed' THEN Connection END) AS Speed_Other,
      MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%RPM%' THEN Connection END) AS RPM_FM,
      MAX(CASE WHEN WireName = 'RPM' THEN Connection END) AS RPM_Other,
      MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%Fuel%' THEN Connection END) AS Fuel_FM,
      MAX(CASE WHEN WireName = 'Fuel' THEN Connection END) AS Fuel_Other,
      MAX(CASE WHEN WireName = 'SP' THEN Connection END) AS SP,
      MAX(CASE WHEN WireName = 'HOS' THEN Connection END) AS HOS
    FROM AllConfigGroupLines
    GROUP BY ConfigurationGroupId
  )
  SELECT
    Flagged = b.BlackFlagsCount,
    g.ConfigurationGroupId,
    a.AssetsCount,
    fw.FWVersion,
    pl.CanScriptLineId,
    pl.CanScript,
    Speed = CASE
              WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed' --Business rule on OE-20, this is always the value for MiX2000
              WHEN g.MobileDevice LIKE 'FM%' THEN pl.Speed_FM
              ELSE pl.Speed_Other
            END,
    RPM =   CASE
              WHEN g.MobileDevice LIKE 'FM%' THEN pl.RPM_FM
              ELSE pl.RPM_Other
            END,
    Fuel =  CASE
              WHEN g.MobileDevice LIKE 'FM%' THEN pl.Fuel_FM
              ELSE pl.Fuel_Other
            END,
    pl.SP,
    pl.HOS
  FROM GeneralConfigGroupInfo g
    LEFT JOIN AssetsCount a ON a.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN BlackFlagsCount b ON b.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN PivotedLines pl ON pl.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN AggregatedFW fw ON fw.ConfigurationGroupId = g.ConfigurationGroupId;

END