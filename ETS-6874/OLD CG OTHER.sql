--OLD CG OTHER
USE DeviceConfiguration;

DECLARE  @groupId BIGINT = -7094567047859310012;

  --VARIABLES
  DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;

  DECLARE @FWVersion SMALLINT = 
        (SELECT PropertyKey
  FROM [definition].[Properties] WITH (NOLOCK)
  WHERE PropertyId = @PreferedFirmwareVersion);


  -- GENERAL INFORMATION
  DECLARE @GeneralConfigGroupInfo TABLE
    (
    ConfigurationGroupId     BIGINT,
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


  -- ASSET COUNT
  -- Mobile Units
  DECLARE @MobileUnits TABLE
    (
    ConfigurationGroupId  BIGINT,
    ConfigurationGroupKey INT,
    MobileUnitKey         INT
    )
  INSERT INTO @MobileUnits
  SELECT g.ConfigurationGroupId, mu.ConfigurationGroupKey, (mu.MobileUnitKey)
  FROM @GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON amu.MobileUnitKey = mu.MobileUnitKey
  -- Asset Count per Config Group
  DECLARE @AssetsCount TABLE
    (
    ConfigurationGroupId BIGINT,
    AssetsCount          INT
    )
  INSERT INTO @AssetsCount
  SELECT g.ConfigurationGroupId, Count(mu.MobileUnitKey)
  FROM @GeneralConfigGroupInfo g
    INNER JOIN @MobileUnits mu ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
  GROUP BY g.ConfigurationGroupId


  -- FLAGS
  DECLARE @BlackFlagsCount TABLE
    (
    ConfigurationGroupId BIGINT,
    BlackFlagsCount      INT
    )
  INSERT INTO @BlackFlagsCount
  SELECT ConfigurationGroupId, COUNT(MobileUnitKey)
  FROM
    (
        SELECT DISTINCT mu.ConfigurationGroupId AS ConfigurationGroupId, mu.MobileUnitKey AS MobileUnitKey
    FROM @MobileUnits mu
      --Overwritten Events
      LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK) ON events.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = mu.MobileUnitKey
      --Overwritten Device Info
      LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK) ON devices.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK) ON properties.MobileUnitKey = mu.MobileUnitKey AND properties.PersistOnReset = 0
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


  -- LINES
  DECLARE @AllConfigGroupLines TABLE  
    (
    [ConfigurationGroupId] BIGINT,
    [WireName]             NVARCHAR(200),
    [Connection]           NVARCHAR(200),
    [LineId]               NVARCHAR(50)
    );
  INSERT INTO @AllConfigGroupLines
  SELECT
    [ConfigurationGroupId] = g.ConfigurationGroupId,
    [WireName] = dl.[Name],
    [Connection] = lpd.[Description],
    [LineId] = dl.LineId
  FROM @GeneralConfigGroupInfo g
    LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey]   = g.DeviceKey
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
    LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
    --Template Devices
    INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
      AND g.LibraryKey = td.LibraryKey
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
    -- Peripheral devices
    CROSS APPLY 
        ( SELECT
      [LineKey] = tpd.[LineKey]
    FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
    WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
      AND tpd.[LineKey]=dmdl.[LineKey]
        ) pd
    LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]
    -- Lines
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
    ON dmdlpd.[MobileDeviceKey]      = g.DeviceKey --mu.[MobileDeviceKey]
      AND dmdlpd.[LineKey]             = pd.[LineKey]
      AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
    -- Get connected device
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey


  -- FW VERSION
  DECLARE @FWVersions TABLE  
    (
    [ConfigurationGroupId] BIGINT,
    [FWName]               NVARCHAR(50)
    );
  INSERT INTO @FWVersions
  SELECT
    [ConfigurationGroupId] = g.ConfigurationGroupId,
    [FWName] = fw.Name
  FROM @GeneralConfigGroupInfo g
    -- Template Devices
    INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
      AND g.LibraryKey = td.LibraryKey
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
    INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
      AND tdpr.PropertyKey = @FWVersion
      AND tdpr.DeviceKey = tdd.DeviceKey
    INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = tdpr.Value


  -- Put it all together
  SELECT
    Flagged = b.BlackFlagsCount,
    g.ConfigurationGroupId,
    a.AssetsCount,
    FWVersion = STUFF((
                SELECT ', ' + fw.FWName
    FROM @FWVersions fw
    WHERE fw.ConfigurationGroupId = g.ConfigurationGroupId
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    CanScriptLineId = STUFF((
                SELECT ', ' + [LineId]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND (l.WireName = 'C1' OR l.WireName = 'C2')
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    CanScript = STUFF((
                SELECT ', ' + [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND (l.WireName = 'C1' OR l.WireName = 'C2')
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    Speed = CASE
                    WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed' --Business rule on OE-20, this is always the value for MiX2000
                    WHEN g.MobileDevice LIKE 'FM%' THEN
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName LIKE ('F%') --ANY Frequency line
      AND l.Connection LIKE '%SPEED%'
                        )
                    ELSE 
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName = 'Speed')
                END,
    RPM =   CASE
                    WHEN g.MobileDevice LIKE 'FM%' THEN
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName LIKE ('F%') --ANY Frequency line
      AND l.Connection LIKE '%RPM%'
                        )
                    ELSE
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName = 'RPM')
                END,
    Fuel =  CASE
                    WHEN g.MobileDevice LIKE 'FM%' THEN
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName LIKE ('F%') --ANY Frequency line
      AND l.Connection LIKE '%Fuel%'
                        )
                    ELSE
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName = 'Fuel')
                END,
    SP =    (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'SP'),
    HOS =   (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'HOS')
  FROM @GeneralConfigGroupInfo g
    LEFT JOIN @AssetsCount a ON a.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN @BlackFlagsCount b ON b.ConfigurationGroupId = g.ConfigurationGroupId
