-- OE-501 Get all column values needed for config groups

USE DeviceConfiguration;

DECLARE @groupId BIGINT = -8441185520557948197; -- BIG: 1686880341835301320; -- MR: -1983255592473789111 Amy: -5401647754082838271 Can?: -2407502219195576592 FMFuelFline: 2364975042774694384 -- DynaMiX Test Units 2018: -8441185520557948197

--SELECT * FROM library.Libraries ll where ll.GroupId = @groupId
-- https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/peripherals?templateId=6520052505408055527&lineId=7859185854233145787

DECLARE @ScriptableCan INT = 125;
DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;


DECLARE @FWVersion SMALLINT = 
    (SELECT PropertyKey FROM definition.Properties 
        WHERE PropertyId = @PreferedFirmwareVersion);

-- GENERAL INFORMATION

DECLARE @GeneralConfigGroupInfo TABLE
(
    ConfigurationGroupId BIGINT, 
    ConfigurationGroupKey INT,
    ConfigurationGroupName NVARCHAR(250), 
    MobileDevice NVARCHAR(50),
    MobileDeviceTemplateId BIGINT, 
    MobileDeviceTemplateName NVARCHAR(250), 
    EventTemplateId BIGINT, 
    EventTemplateName NVARCHAR(250),
    LocationTemplateId BIGINT, 
    LocationTemplateName NVARCHAR(250),
    DeviceKey INT,
    MobileDeviceTemplateKey BIGINT,
    LibraryKey INT
)

INSERT INTO @GeneralConfigGroupInfo
SELECT
    tcg.ConfigurationGroupId, 
    tcg.ConfigurationGroupKey,
    tcg.Name as ConfigurationGroupName, 
    dmd.Description as MobileDevice,
    mdt.MobileDeviceTemplateId, 
    mdt.Name as MobileDeviceTemplateName, 
    tet.EventTemplateId, 
    tet.Name as EventTemplateName,
    tlt.LocationTemplateId,
    tlt.Name as LocationTemplateName,
    dd.DeviceKey,
    tcg.MobileDeviceTemplateKey,
    tcg.LibraryKey
FROM library.Libraries l
INNER JOIN template.ConfigurationGroups tcg WITH (NOLOCK) ON tcg.LibraryKey = l.LibraryKey
INNER JOIN template.MobileDeviceTemplates mdt WITH (NOLOCK) 
    ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
    AND tcg.LibraryKey = mdt.LibraryKey
INNER JOIN definition.Devices dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
INNER JOIN definition.MobileDevices dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
LEFT JOIN template.EventTemplates tet WITH (NOLOCK) 
    ON tcg.MobileDeviceTemplateKey = tet.EventTemplateKey
    AND tcg.LibraryKey = tet.LibraryKey
LEFT JOIN template.LocationTemplates tlt WITH (NOLOCK) 
    ON tcg.LocationTemplateKey = tlt.LocationTemplateKey
    AND tcg.LibraryKey = tlt.LibraryKey
WHERE l.GroupId = @groupId


-- ERRORS

-- TODO: MR: OE-515 This will be a new story to get the rules for errors to be displayed for a config group
-- For now I will just return a blank value below


-- ASSET COUNT

-- Mobile Units
DECLARE @MobileUnits TABLE
(
    ConfigurationGroupId BIGINT, 
    ConfigurationGroupKey INT,
    MobileUnitKey INT
)
INSERT INTO @MobileUnits
SELECT g.ConfigurationGroupId, mu.ConfigurationGroupKey, (mu.MobileUnitKey)
FROM @GeneralConfigGroupInfo g
INNER JOIN mobileunit.MobileUnits mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey

-- Asset Count per Config Group
DECLARE @AssetsCount TABLE
(
    ConfigurationGroupId BIGINT, 
    AssetsCount INT
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
    BlackFlagsCount INT
)
INSERT INTO @BlackFlagsCount
SELECT ConfigurationGroupId, COUNT(MobileUnitKey)
FROM
(
    SELECT DISTINCT mu.ConfigurationGroupId as ConfigurationGroupId, mu.MobileUnitKey as MobileUnitKey
    FROM @MobileUnits mu
    --Overwritten Events
    LEFT JOIN mobileunit.OverridenEvents events WITH (NOLOCK) ON events.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenEventActions eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenEventConditionThresholds thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = mu.MobileUnitKey
    --Overwritten Device Info
    LEFT JOIN mobileunit.OverridenDevices devices WITH (NOLOCK) ON devices.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenDeviceParameters params WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenCanParameters paramsCan WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenDeviceProperties properties WITH (NOLOCK) ON properties.MobileUnitKey = mu.MobileUnitKey and properties.PersistOnReset = 0
    LEFT JOIN mobileunit.OverridenPeripheralDevices peripherals WITH (NOLOCK) ON peripherals.MobileUnitKey = mu.MobileUnitKey
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


-- 


-- LINES
-- TODO: MR: FIX by also looking at the LibraryKey

/*
SELECT TOP 10 * 
FROM library.PeripheralDevices lpd
INNER JOIN library.Devices ld ON ld.LibaryDeviceKey = lpd.LibaryDeviceKey AND ld.LibraryKey = -1 //xxxxxxxxxxx
*/

-- 
-- SELECT TOP 10 * FROM library.Devices

DECLARE @AllConfigGroupLines TABLE  
(
    [ConfigurationGroupId] BIGINT,
    [WireName] nvarchar(200),
    [Connection] nvarchar(200),
    [LineId] nvarchar(50)
);

INSERT INTO @AllConfigGroupLines
Select
    [ConfigurationGroupId] = g.ConfigurationGroupId,
    [WireName] = dl.[Name],
    [Connection] = lpd.[Description],
    [LineId] = dl.LineId
FROM @GeneralConfigGroupInfo g
LEFT JOIN   [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey]   = g.DeviceKey
LEFT JOIN   [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
LEFT JOIN  [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]

-- SELECT * FROM definition.Lines Where LineId = 7859185854233145787

--Template Devices
INNER JOIN  [template].[Devices] td WITH (NOLOCK) 
    ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
    AND g.LibraryKey = td.LibraryKey
INNER JOIN  [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]

-- Peripheral devices
CROSS APPLY 
    ( SELECT 
            [LineKey] = tpd.[LineKey]
        FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
        WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND tpd.[LineKey]=dmdl.[LineKey]
    ) pd
left JOIN  [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]

--Lines
LEFT JOIN  [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) 
    ON dmdlpd.[MobileDeviceKey]      = g.DeviceKey --mu.[MobileDeviceKey]
    AND dmdlpd.[LineKey]             = pd.[LineKey]
    AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]

-- Get connected device
LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK)ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey


-- FW VERSION
-- TODO: MR: FIX by also looking at the LibraryKey

DECLARE @FWVersions TABLE  
(
    [ConfigurationGroupId] BIGINT,
    [FWName] nvarchar(50)
);

INSERT INTO @FWVersions
Select
    [ConfigurationGroupId] = g.ConfigurationGroupId,
    [FWName] = fw.name
FROM @GeneralConfigGroupInfo g
--Template Devices
INNER JOIN  [template].[Devices] td WITH (NOLOCK) 
    ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
    AND g.LibraryKey = td.LibraryKey

INNER JOIN  [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
INNER JOIN template.DeviceProperties tdpr 
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey 
    AND tdpr.PropertyKey = @FWVersion
    AND tdpr.DeviceKey = tdd.DeviceKey
INNER JOIN definition.FirmwareVersions fw ON fw.FirmwareVersionId = tdpr.Value


-- Put it all together

SELECT 
    Alerts = null,
    Flagged = b.BlackFlagsCount,
    g.ConfigurationGroupId,
    g.ConfigurationGroupName,
    a.AssetsCount, 
    g.MobileDevice,
    g.MobileDeviceTemplateId,
    g.MobileDeviceTemplateName,
    g.EventTemplateId,
    g.EventTemplateName,
    g.LocationTemplateId,
    g.LocationTemplateName,
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
                --BE: 478: C:\Projects\DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\M6k_Modules\GenerateBinaries\SettingsCompile.cs   
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    Speed = CASE --TODO: MR: Ensure this is correct as I did this blindly
                WHEN g.MobileDevice LIKE 'MiX2%' then 'GPS velocity as speed' --Business rule on OE-20, this is always the value for MiX2000
                WHEN g.MobileDevice LIKE 'FM%' then
                    (Select [Connection] from @AllConfigGroupLines l 
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId 
                        AND l.WireName LIKE ('F%') --ANY Frequency line
                        --TODO: MR: Double check this!
                        AND l.Connection LIKE '%SPEED%'
                    )
                ELSE 
                    (Select [Connection] from @AllConfigGroupLines l 
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId 
                        AND l.WireName = 'Speed')
            END,
    RPM =   CASE
                WHEN g.MobileDevice LIKE 'FM%' then
                    (Select [Connection] from @AllConfigGroupLines l 
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId 
                        AND l.WireName LIKE ('F%') --ANY Frequency line
                        --TODO: MR: Double check this!
                        AND l.Connection LIKE '%RPM%'
                    )
                ELSE
                    (Select [Connection] from @AllConfigGroupLines l 
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId 
                        AND l.WireName = 'RPM')
            END,
    Fuel =  CASE
                 WHEN g.MobileDevice LIKE 'FM%' then
                    (Select [Connection] from @AllConfigGroupLines l 
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId 
                        AND l.WireName LIKE ('F%') --ANY Frequency line
                        --TODO: MR: Double check this!
                        AND l.Connection LIKE '%Fuel%'
                    )
                ELSE
                    (Select [Connection] from @AllConfigGroupLines l 
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId 
                        AND l.WireName = 'Fuel')
            END,
    SP =    (Select [Connection] from @AllConfigGroupLines l WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'SP'),
    HOS =   (Select [Connection] from @AllConfigGroupLines l WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'HOS')
FROM @GeneralConfigGroupInfo g
LEFT JOIN @AssetsCount a ON a.ConfigurationGroupId = g.ConfigurationGroupId
LEFT JOIN @BlackFlagsCount b on b.ConfigurationGroupId = g.ConfigurationGroupId

