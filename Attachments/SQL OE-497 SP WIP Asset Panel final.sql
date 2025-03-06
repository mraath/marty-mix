-- Working on OE-497: Semi final Stored Proc

USE DeviceConfiguration;

-- TODO: MR: Replace this with Ids
DECLARE @configGroupIds TABLE ( Id     BIGINT );
INSERT INTO @configGroupIds VALUES (-4366193155933191679); --
INSERT INTO @configGroupIds VALUES (7270785342402232596); --

-- FROM HERE will become the STORED PROC


--- VARIABLES ---

-- Send messages types
DECLARE @typeList TABLE
(
	Id BIGINT
) --types to get messages sent for
INSERT INTO @typeList VALUES (254); -- SendConfig
INSERT INTO @typeList VALUES (103); -- SendFirmware
INSERT INTO @typeList VALUES (255); -- SendSettings

DECLARE @ScriptableCan INT = 125;
DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;
DECLARE @UNIT_IMEI BIGINT = 9188780602356317147;
DECLARE @SERIAL_NUMBER BIGINT = -6167220489794283114;
DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;

DECLARE @PropIMEIKey INT = 
(
    SELECT [PropertyKey]
    FROM [definition].[Properties] dp WITH (NOLOCK)
    WHERE dp.PropertyId = @UNIT_IMEI
);

DECLARE @FWVersion SMALLINT = 
(
    SELECT PropertyKey
    FROM [definition].[Properties] WITH (NOLOCK)
    WHERE PropertyId = @PreferedFirmwareVersion
);



-- GENERAL CONFIG GROUP INFORMATION

DECLARE @GeneralConfigGroupInfo TABLE
(
    ConfigurationGroupId     BIGINT,
    ConfigurationGroupKey    INT,
    ConfigurationGroupName   NVARCHAR(250),
    MobileDevice             NVARCHAR(50),
    MobileDeviceTemplateId   BIGINT,
    MobileDeviceTemplateName NVARCHAR(250),
    EventTemplateId          BIGINT,
    EventTemplateName        NVARCHAR(250),
    LocationTemplateId       BIGINT,
    LocationTemplateName     NVARCHAR(250),
    DeviceKey                INT,
    MobileDeviceTemplateKey  BIGINT,
    LibraryKey               INT
)
INSERT INTO @GeneralConfigGroupInfo
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
    tcg.LibraryKey
FROM @configGroupIds cg
INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) 
    ON tcg.ConfigurationGroupId = cg.Id
INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
    ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
    AND tcg.LibraryKey = mdt.LibraryKey
INNER JOIN [definition].[Devices] dd WITH (NOLOCK) 
    ON mdt.MobileDeviceKey = dd.DeviceKey
INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) 
    ON dd.DeviceKey = dmd.DeviceKey
LEFT JOIN [template].[EventTemplates] tet WITH (NOLOCK)
    ON tcg.EventTemplateKey = tet.EventTemplateKey
    AND tcg.LibraryKey = tet.LibraryKey
LEFT JOIN [template].[LocationTemplates] tlt WITH (NOLOCK)
    ON tcg.LocationTemplateKey = tlt.LocationTemplateKey
    AND tcg.LibraryKey = tlt.LibraryKey



-- ERRORS
-- TODO: MR: OE-515 This will be a new story to get the rules for errors to be displayed for a config group
-- For now I will just return a blank value below



-- ASSET DATABASE INFORMATION

-- Mobile Units
IF OBJECT_ID('tempdb..#mobileUnits') IS NOT NULL
    DROP TABLE #mobileUnits;

CREATE TABLE #mobileUnits
(
    ConfigurationGroupId        BIGINT,
    ConfigurationGroupKey       INT,
    AssetId                     BIGINT,
    MobileUnitKey               INT,
    MobileDeviceKey             INT,
    MobileUnitId                BIGINT,
    ConfigurationStatus         NVARCHAR(50),
    ConfigurationStatusDate     DATETIME,
    LegacyOrgId                 INT,
    LegacyVehicleId             INT,
    [UniqueIdentifier]          NVARCHAR(250),
    [Serialnumber]              NVARCHAR(250),
    StreamaxSerialNumber        NVARCHAR(250),
    ConfigurationGenerationNotes NVARCHAR(MAX),
    ConfigurationGenerationWarning NVARCHAR(MAX)
)
INSERT INTO #mobileUnits
SELECT 
    g.ConfigurationGroupId [ConfigurationGroupId], 
    mu.ConfigurationGroupKey [ConfigurationGroupKey], 
    amu.AssetId [AssetId],  
    mu.MobileUnitKey [MobileUnitKey], 
    mu.MobileDeviceKey [MobileDeviceKey],
    mu.MobileUnitId [MobileUnitId],
    cs.[Description] [ConfigurationStatus], 
    mu.DateUpdated [ConfigurationStatusDate], 
    amu.LegacyOrgId [LegacyOrgId],
    amu.LegacyVehicleId [LegacyVehicleId],
    [UniqueIdentifier] = CASE WHEN mu.UniqueIdentifier IS NULL THEN mup.value ELSE mu.UniqueIdentifier END,
    mus.Value [Serialnumber],
    StreamaxSerialNumber = CASE WHEN (ap.Value is null) THEN mu.UniqueIdentifier ELSE ap.Value END,
    mu.ConfigurationGenerationNotes,
    mu.ConfigurationGenerationWarning
FROM @GeneralConfigGroupInfo g
INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) 
    ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) 
    ON mu.MobileUnitKey = amu.MobileUnitKey
INNER JOIN [definition].[ConfigurationStatuses] cs WITH (NOLOCK) 
    ON cs.[ConfigurationStatus] = mu.[ConfigurationStatus]
LEFT JOIN [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK) 
    ON mu.[MobileUnitKey] = mup.[MobileUnitKey] 
    AND mup.[PropertyKey] = @PropIMEIKey
LEFT JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] mus WITH (NOLOCK) 
    ON mus.[MobileUnitId] = mu.[MobileUnitId] 
    AND mus.[PropertyId] = @SERIAL_NUMBER
LEFT JOIN mobileunit.AssetProperties ap WITH (NOLOCK) 
    ON mu.MobileUnitId = ap.AssetId and ap.PropertyId  = @StreamaxSerialNumber;


-- Messages for Mesa
DECLARE @typelistmu TABLE
(
    mobId  BIGINT,
    typeId BIGINT,
    PRIMARY KEY (typeId,mobId)
)
INSERT INTO @typelistmu
SELECT m.MobileUnitId, t.id
FROM @typeList t
        CROSS JOIN #mobileUnits m
GROUP BY m.MobileUnitId, t.id

DECLARE @mesaMessages TABLE
(
    MessageSubType          INT,
    MessageStatusDateUtc    DATETIME,
    MessageStatus           INT,
    MobileUnitId            BIGINT
)
INSERT INTO @mesaMessages
SELECT c.MessageSubType,
    MessageStatusDateUtc,
    MessageStatus,
    MobileUnitId
FROM 
(
    SELECT 
        mum.MessageSubType,
        mum.CreationDateUtc,
        mum.MessageStatusDateUtc,
        mum.MessageId,
        mum.MessageStatus,
        mum.MessageKey,
        ROW_NUMBER() OVER ( PARTITION BY mum.MobileUnitId ORDER BY mum.MessageStatusDateUtc DESC ) AS rn, MobileUnitId
    FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum  WITH (NOLOCK)
        JOIN @typelistmu muIds
        ON muIds.mobId = mum.MobileUnitId
        AND mum.MessageSubType = muIds.typeId
) c
WHERE       rn IN (1)
ORDER BY    MobileUnitId,c.MessageSubType, MessageStatusDateUtc


-- Asset DB Part (dynamic sql)
DECLARE @legacyOrgId INT = (SELECT TOP 1 LegacyOrgId FROM #mobileUnits);

DECLARE @sConnectDatabase NVARCHAR(250);
SELECT @sConnectDatabase = sConnectDatabase
FROM [FMOnlineDB].[dbo].[Organisation] WITH (NOLOCK)
WHERE liOrgID = @legacyOrgId;

IF OBJECT_ID('tempdb..#assets') IS NOT NULL
    DROP TABLE #assets;

CREATE TABLE #assets (
    AssetDescription NVARCHAR(500),
    Registration  NVARCHAR(50),
    Sitename NVARCHAR(500),
    FleetNumber NVARCHAR(50),
    LegacyVehicleId INT
);

IF OBJECT_ID('tempdb..#schedule') IS NOT NULL
    DROP TABLE #schedule;
CREATE TABLE #schedule
(
    [ScheduleId] INT,
	[AssetId] BIGINT,
	[LastRun] DATETIME,
    [LastLogEntry] NVARCHAR(500)
)

DECLARE @SQL NVARCHAR(MAX);
SET @SQL = N'USE ' + QUOTENAME(@sConnectDatabase) + N';
    --Get all asset information
    INSERT INTO #assets
        SELECT
        v.sDesc as AssetDescription,
        v.sRegNo as Registration,
        s.sName as [Sitename], 
        a.FleetNumber,
        mu.LegacyVehicleId
        FROM #mobileUnits mu
        INNER JOIN dbo.Vehicles v WITH (NOLOCK) 
            ON v.iVehicleID = mu.LegacyVehicleId
        INNER JOIN  [dynamix].Assets a WITH (NOLOCK) 
            ON v.iVehicleID  = a.VehicleId  
        INNER JOIN dbo.Sites s WITH (NOLOCK) 
            ON s.liSiteID = v.liSiteID
        INNER JOIN dynamix.Sites ds WITH (NOLOCK) 
            ON ds.SiteID = v.liSiteID

    ;WITH ScheduleLogIds as 
    (
        SELECT 
            MAX(DataScheduleLogID) DataScheduleLogID, 
            a.VehicleId, 
            a.AssetId
        FROM dbo.DataScheduleLog dsl WITH (NOLOCK)
        JOIN dbo.DataSchedule ds WITH (NOLOCK) 
            ON ds.liSchedId = dsl.liSchedId 
        JOIN dynamix.Assets a WITH (NOLOCK) 
            ON a.VehicleId = ds.liObjectID		
        JOIN #mobileUnits mu 
            ON mu.MobileUnitId = a.AssetId
        WHERE CAST((CAST(bUploadConfig as tinyint) + CAST(bUploadDDRs as tinyint) + 
                bUploadDDRs +  ucUploadTerminalScript + ucUploadTerminalDDM + 
                ucUploadTerminalDB + ucUploadCanDDM + ucUploadExtendedConfigBIN) as bit) = 1
        GROUP by
            a.VehicleId , a.AssetId
    )

    INSERT INTO #schedule
    SELECT 
        [ScheduleId] = ads.UploadScheduleId,
        [AssetId] = logIds.AssetId,
        [LastRun] = ds.dtLastRun,
        [LastLogEntry] = [dynamix].[GetLatestScheduleLogMsgByScheduleId] (ds.[liSchedID], null)
    FROM ScheduleLogIds logIds WITH (NOLOCK)
    JOIN dynamix.AssetDataSchedules ads WITH (NOLOCK) 
        ON ads.AssetId = logIds.AssetId
    JOIN dbo.DataSchedule ds WITH (NOLOCK) 
        ON ds.liObjectId = logIds.VehicleId 
        AND ds.liSchedID = ads.UploadScheduleId
            '
EXEC sp_executesql @SQL;



-- FLAGS

DECLARE @BlackFlagsCount TABLE
(
    MobileUnitKey   INT,
    BlackFlagged    INT
)
INSERT INTO @BlackFlagsCount
SELECT MobileUnitKey, 1 as BlackFlagged
FROM
(
    SELECT DISTINCT mu.MobileUnitKey AS MobileUnitKey
    FROM #mobileUnits mu
    --Overwritten Events
    LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK) 
        ON events.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK) 
        ON eventActions.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK) 
        ON thresholds.MobileUnitKey = mu.MobileUnitKey
    --Overwritten Device Info
    LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK) 
        ON devices.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK) 
        ON params.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK) 
        ON params.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK) 
        ON properties.MobileUnitKey = mu.MobileUnitKey 
        AND properties.PersistOnReset = 0
    LEFT JOIN [mobileunit].[OverridenPeripheralDevices] peripherals WITH (NOLOCK) 
        ON peripherals.MobileUnitKey = mu.MobileUnitKey
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



-- LINES

-- All Config group lines
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
LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) 
    ON dmdl.[MobileDeviceKey]   = g.DeviceKey
LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) 
    ON dl.[LineKey] = dmdl.[LineKey]
LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) 
    ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
--Template Devices
INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
    AND g.LibraryKey = td.LibraryKey
INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) 
    ON tdd.[DeviceKey] = td.[DeviceKey]
-- Peripheral devices
CROSS APPLY 
    ( 
        SELECT
        [LineKey] = tpd.[LineKey]
        FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
        WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND tpd.[LineKey]=dmdl.[LineKey]
    ) pd
LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK) 
    ON pdl.[LineKey] = pd.[LineKey]
-- Lines
LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
    ON dmdlpd.[MobileDeviceKey]      = g.DeviceKey --mu.[MobileDeviceKey]
    AND dmdlpd.[LineKey]             = pd.[LineKey]
    AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
-- Get connected device
LEFT JOIN [library].[Devices] ld WITH (NOLOCK) 
    ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) 
    ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey

-- Asset overwritten lines (Effective Lines)
DECLARE @EffectiveByMobileUnitId TABLE  
    (
    [MobileUnitId] BIGINT,
    [WireName]     NVARCHAR(200),
    [Connection]   NVARCHAR(200),
    [IsOverridden] BIT,
    [LineId]       NVARCHAR(50)
    );
INSERT INTO @EffectiveByMobileUnitId
SELECT
  [MobileUnitId] = mu.MobileUnitId,
  [WireName] = dl.[Name],
  [Connection] = lpd.[Description],
  [IsOverridden] = pd.[IsOverridden],
  [LineId] = dl.LineId
--General Mobileunit info
FROM #mobileUnits mu
INNER JOIN @GeneralConfigGroupInfo g 
    ON g.ConfigurationGroupId = mu.ConfigurationGroupId
INNER JOIN [template].[Devices] td WITH (NOLOCK) 
    ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
INNER JOIN [definition].[Devices] dd WITH (NOLOCK) 
    ON dd.[DeviceKey] = td.[DeviceKey]
--Peripheral Devices
    CROSS APPLY ( SELECT
        [LineKey] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN opd.[LineKey] ELSE tpd.[LineKey] END,
        [IsOverridden] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN
                                        CASE WHEN opd.[LineKey] IS NOT NULL THEN 'true' 
                                        ELSE 'false' END
                                        ELSE 'false' END,
        [Tacho] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN opd.[RecordInterval] ELSE tpd.[RecordInterval] END

        FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
        LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) 
            ON opd.[MobileUnitKey]     = mu.[MobileUnitKey]
            AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
        WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)
        OR (opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))) pd
  LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) 
    ON dl.[LineKey] = pd.[LineKey]
  --Lines
  LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) 
    ON dmdlpd.[MobileDeviceKey]     = mu.[MobileDeviceKey]
    AND dmdlpd.[LineKey]             = pd.[LineKey]
    AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]
  --Get the connected device
  LEFT JOIN [library].[Devices] ld WITH (NOLOCK) 
    ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey 
    AND ld.LibraryKey = g.LibraryKey
  LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK) 
    ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey

--Overwritten Lines (feels like I do this twice)
DECLARE @MobileUnitLines TABLE  
    (
    [MobileUnitId] BIGINT,
    [ConfigurationGroupId] BIGINT,
    [LineId]       NVARCHAR(50),
    [WireName]     NVARCHAR(200),
    [IsOverridden] BIT,
    [Connection]   NVARCHAR(200)    
    );
INSERT INTO @MobileUnitLines
SELECT 
    mu.MobileUnitId,
    cgl.ConfigurationGroupId,
    cgl.LineId,
    cgl.WireName,
    eff.IsOverridden,
    [Connection] = CASE WHEN eff.IsOverridden = 'true' THEN eff.Connection ELSE cgl.Connection END
FROM #mobileunits mu
INNER JOIN @AllConfigGroupLines cgl 
    ON cgl.ConfigurationGroupId = mu.ConfigurationGroupId
LEFT JOIN @EffectiveByMobileUnitId eff 
    ON eff.MobileUnitId = mu.MobileUnitId 
    AND eff.LineId = cgl.LineId
Order by cgl.ConfigurationGroupId DESC, cgl.WireName DESC



-- FW VERSION

DECLARE @FWVersions TABLE  
(
    [ConfigurationGroupId]          BIGINT,
    [FWName]                        NVARCHAR(50),
    [TemplateDevicePropertyKey]     INT
);
INSERT INTO @FWVersions
SELECT
    [ConfigurationGroupId] = g.ConfigurationGroupId,
    [FWName] = fw.Name,
    tdpr.TemplateDevicePropertyKey --Used to check up the overwritten value
FROM @GeneralConfigGroupInfo g
-- Template Devices
INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
    AND g.LibraryKey = td.LibraryKey
INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) 
    ON tdd.[DeviceKey] = td.[DeviceKey]
INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.PropertyKey = @FWVersion
    AND tdpr.DeviceKey = tdd.DeviceKey
INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) 
    ON fw.FirmwareVersionId = tdpr.Value

-- Add the overwritten values next

DECLARE @AssetFWVersions TABLE  
(
    [MobileUnitKey]                 INT,
    [FWName]                        NVARCHAR(50)
);
INSERT INTO @AssetFWVersions
SELECT
    muopr.MobileUnitKey,
    dfw.Name [FWName]
FROM @FWVersions fw
INNER JOIN [mobileunit].[OverridenDeviceProperties] muopr WITH (NOLOCK)
    ON muopr.TemplateDevicePropertyKey = fw.TemplateDevicePropertyKey
INNER JOIN [definition].[FirmwareVersions] dfw WITH (NOLOCK) 
    ON dfw.FirmwareVersionId = muopr.Value


-- Put it all together
SELECT
    Alerts = NULL, --As per above, this will be populated in a seperate story
    Flagged = b.BlackFlagged,
    mu.AssetId,
    a.AssetDescription,
    a.Registration,
    a.Sitename,
    a.FleetNumber,
    --In Code, Lastposition will come from the Lightning client
    mu.UniqueIdentifier [IMEI],
    mu.Serialnumber Serialnumber,
    g.MobileDevice,
    ConfigCompileStatus = CASE WHEN mu.configurationGenerationNotes IS NULL THEN mu.ConfigurationGenerationWarning ELSE mu.configurationGenerationNotes END,
    mu.ConfigurationStatus,
    mu.ConfigurationStatusDate,
    -- In Code, CommsLog would be mm.MessageStatusDateUtc in historical date, else sched.LastLogEntry
    mm.MessageStatusDateUtc,
    sched.LastLogEntry,
    g.ConfigurationGroupId,
    g.ConfigurationGroupName,
    g.MobileDeviceTemplateId,
    g.MobileDeviceTemplateName,
    g.EventTemplateId,
    g.EventTemplateName,
    g.LocationTemplateId,
    g.LocationTemplateName,
    FWVersion = CASE WHEN afw.FWName IS NOT NULL
                THEN
                    afw.FWName
                ELSE
                    STUFF((
                        SELECT ', ' + fw.FWName
                        FROM @FWVersions fw
                        WHERE fw.ConfigurationGroupId = g.ConfigurationGroupId
                        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '')
                END,

    CanScriptLineId = STUFF((
                SELECT ', ' + [LineId]
                FROM @MobileUnitLines l
                WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
                AND l.MobileUnitId = mu.MobileUnitId
                AND (l.WireName = 'C1' OR l.WireName = 'C2')
                FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    CanScript = STUFF((
                SELECT ', ' + [Connection]
                FROM @MobileUnitLines l
                WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
                AND l.MobileUnitId = mu.MobileUnitId 
                AND (l.WireName = 'C1' OR l.WireName = 'C2')
                FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),

    Speed = CASE
                WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed' --Business rule on OE-20, this is always the value for MiX2000
                WHEN g.MobileDevice LIKE 'FM%' THEN
                    (SELECT [Connection]
                        FROM @MobileUnitLines l
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
                        AND l.MobileUnitId = mu.MobileUnitId 
                            AND l.WireName LIKE ('F%') --ANY Frequency line
                            AND l.Connection LIKE '%SPEED%'
                    )
                ELSE 
                    (SELECT [Connection]
                        FROM @MobileUnitLines l
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
                        AND l.MobileUnitId = mu.MobileUnitId 
                            AND l.WireName = 'Speed')
            END,
    RPM =   CASE
                WHEN g.MobileDevice LIKE 'FM%' THEN
                    (SELECT [Connection]
                        FROM @MobileUnitLines l
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
                        AND l.MobileUnitId = mu.MobileUnitId 
                            AND l.WireName LIKE ('F%') --ANY Frequency line
                            AND l.Connection LIKE '%RPM%'
                    )
                ELSE
                    (SELECT [Connection]
                        FROM @MobileUnitLines l
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
                        AND l.MobileUnitId = mu.MobileUnitId 
                            AND l.WireName = 'RPM')
            END,
    Fuel =  CASE
                WHEN g.MobileDevice LIKE 'FM%' THEN
                    (SELECT [Connection]
                        FROM @MobileUnitLines l
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
                        AND l.MobileUnitId = mu.MobileUnitId 
                            AND l.WireName LIKE ('F%') --ANY Frequency line
                            AND l.Connection LIKE '%Fuel%'
                    )
                ELSE
                    (SELECT [Connection]
                        FROM @MobileUnitLines l
                        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
                        AND l.MobileUnitId = mu.MobileUnitId 
                            AND l.WireName = 'Fuel')
            END,
    SP =    (SELECT [Connection]
                FROM @MobileUnitLines l
                WHERE l.ConfigurationGroupId = g.ConfigurationGroupId 
                AND l.MobileUnitId = mu.MobileUnitId  
                AND l.WireName = 'SP'),
    MiXVisionSerialnumber = mu.StreamaxSerialNumber,
    HOS =   (SELECT [Connection]
                FROM @MobileUnitLines l
                WHERE l.ConfigurationGroupId = g.ConfigurationGroupId 
                AND l.MobileUnitId = mu.MobileUnitId  
                AND l.WireName = 'HOS')
FROM @GeneralConfigGroupInfo g
INNER JOIN #mobileUnits mu ON mu.ConfigurationGroupId = g.ConfigurationGroupId
INNER JOIN #assets a ON a.LegacyVehicleId = mu.LegacyVehicleId
LEFT JOIN @BlackFlagsCount b ON b.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN @AssetFWVersions afw ON afw.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN @mesaMessages mm ON mm.MobileUnitId = mu.MobileUnitId
LEFT JOIN #schedule sched ON sched.AssetId = mu.AssetId
