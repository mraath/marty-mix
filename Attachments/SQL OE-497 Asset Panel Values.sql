-- Working on OE-497: Getting Asset Panel info

USE DeviceConfiguration;

/*
-- TODO: MR: Replace this with the Ids thing you pass in...
DECLARE @GroupIds TABLE ( Id     BIGINT );
--INSERT INTO @GroupIds VALUES (-1983255592473789111); -- AEMP: 9
INSERT INTO @GroupIds VALUES (-7094567047859310012); -- Engineering: Bench Units: 93
*/

-- TODO: MR: Replace this with Ids
DECLARE @ConfigGroupIds TABLE ( Id     BIGINT );
INSERT INTO @ConfigGroupIds VALUES (94799400351670928);
INSERT INTO @ConfigGroupIds VALUES (-3282103926377568329);
INSERT INTO @ConfigGroupIds VALUES (-550196789150550556);
INSERT INTO @ConfigGroupIds VALUES (4091401922862075433);
INSERT INTO @ConfigGroupIds VALUES (-8547159231914649341);
INSERT INTO @ConfigGroupIds VALUES (7095290595195709547);
INSERT INTO @ConfigGroupIds VALUES (2861735045286896188);
INSERT INTO @ConfigGroupIds VALUES (6312310801007676949);
INSERT INTO @ConfigGroupIds VALUES (-8756741745537914599);
INSERT INTO @ConfigGroupIds VALUES (-731886823934436369);
INSERT INTO @ConfigGroupIds VALUES (-1204285497117683688);
INSERT INTO @ConfigGroupIds VALUES (889908641437327249);
INSERT INTO @ConfigGroupIds VALUES (-1826672241723827656);
INSERT INTO @ConfigGroupIds VALUES (-4366193155933191679);
INSERT INTO @ConfigGroupIds VALUES (7270785342402232596);
INSERT INTO @ConfigGroupIds VALUES (-3704258575158913780);
INSERT INTO @ConfigGroupIds VALUES (828086250433762377);
INSERT INTO @ConfigGroupIds VALUES (8422481933901788983);
INSERT INTO @ConfigGroupIds VALUES (-7668041119015801648);
INSERT INTO @ConfigGroupIds VALUES (-423281617970763466);
INSERT INTO @ConfigGroupIds VALUES (-8226461363431857553);
INSERT INTO @ConfigGroupIds VALUES (1045666776747542500);
INSERT INTO @ConfigGroupIds VALUES (7052806703847727911);
INSERT INTO @ConfigGroupIds VALUES (-2424888961984893794);
INSERT INTO @ConfigGroupIds VALUES (8288777415571963058);
INSERT INTO @ConfigGroupIds VALUES (-8764188128737825615);
INSERT INTO @ConfigGroupIds VALUES (-3588099924597016740);
INSERT INTO @ConfigGroupIds VALUES (4025638254087962841);
INSERT INTO @ConfigGroupIds VALUES (6400288601982606224);
INSERT INTO @ConfigGroupIds VALUES (6445447026508234957);
INSERT INTO @ConfigGroupIds VALUES (-2459404397312440018);
INSERT INTO @ConfigGroupIds VALUES (-7143760793963292589);
INSERT INTO @ConfigGroupIds VALUES (2822649632688492172);
INSERT INTO @ConfigGroupIds VALUES (3398222997906777512);
INSERT INTO @ConfigGroupIds VALUES (7509875402727941550);
INSERT INTO @ConfigGroupIds VALUES (-4945076687542719021);
-- ConfigGroupIds
/*
    -- ALL overwritten FW Versions
    INSERT INTO @ConfigGroupIds VALUES (-7193205268329688567);
    INSERT INTO @ConfigGroupIds VALUES (-3798194295803321659);
    -- ALL overwritten Config Groups (before FW)
    INSERT INTO @ConfigGroupIds VALUES (-6039078778185809084);
    INSERT INTO @ConfigGroupIds VALUES (-2723417818245426945);
    INSERT INTO @ConfigGroupIds VALUES (1989001888637459309);
    INSERT INTO @ConfigGroupIds VALUES (5918913735931167160);
    -- ALL Config Groups
    INSERT INTO @ConfigGroupIds VALUES (-9078750292130215188);
    INSERT INTO @ConfigGroupIds VALUES (-8871627763454545305);
    INSERT INTO @ConfigGroupIds VALUES (-8642220154752102213);
    INSERT INTO @ConfigGroupIds VALUES (-8507561780508819492);
    INSERT INTO @ConfigGroupIds VALUES (-8126655682067440340);
    INSERT INTO @ConfigGroupIds VALUES (-7668187040444806181);
    INSERT INTO @ConfigGroupIds VALUES (-7653538731568077332);
    INSERT INTO @ConfigGroupIds VALUES (-7629839428314466340);
    INSERT INTO @ConfigGroupIds VALUES (-7392764503748298046);
    INSERT INTO @ConfigGroupIds VALUES (-7388214892984705840);
    INSERT INTO @ConfigGroupIds VALUES (-7193205268329688567);
    INSERT INTO @ConfigGroupIds VALUES (-6836621200088256507);
    INSERT INTO @ConfigGroupIds VALUES (-6578464666737983883);
    INSERT INTO @ConfigGroupIds VALUES (-6366678994605550120);
    INSERT INTO @ConfigGroupIds VALUES (-6328313109361883502);
    INSERT INTO @ConfigGroupIds VALUES (-6234566316505424845);
    INSERT INTO @ConfigGroupIds VALUES (-6151357456724753887);
    INSERT INTO @ConfigGroupIds VALUES (-6084966262084607888);
    INSERT INTO @ConfigGroupIds VALUES (-6039078778185809084);
    INSERT INTO @ConfigGroupIds VALUES (-5912082017677079777);
    INSERT INTO @ConfigGroupIds VALUES (-5831608836261800088);
    INSERT INTO @ConfigGroupIds VALUES (-5390337933230695538);
    INSERT INTO @ConfigGroupIds VALUES (-5340634987676521615);
    INSERT INTO @ConfigGroupIds VALUES (-5159253166163790691);
    INSERT INTO @ConfigGroupIds VALUES (-4067179943998429825);
    INSERT INTO @ConfigGroupIds VALUES (-3893536691584770708);
    INSERT INTO @ConfigGroupIds VALUES (-3798194295803321659);
    INSERT INTO @ConfigGroupIds VALUES (-3695105512554797542);
    INSERT INTO @ConfigGroupIds VALUES (-3366261590319731458);
    INSERT INTO @ConfigGroupIds VALUES (-3251388662902899727);
    INSERT INTO @ConfigGroupIds VALUES (-2803813420773469362);
    INSERT INTO @ConfigGroupIds VALUES (-2723417818245426945);
    INSERT INTO @ConfigGroupIds VALUES (-2705378436500757533);
    INSERT INTO @ConfigGroupIds VALUES (-2573155336697877595);
    INSERT INTO @ConfigGroupIds VALUES (-2413576874196688261);
    INSERT INTO @ConfigGroupIds VALUES (-2374899645906010889);
    INSERT INTO @ConfigGroupIds VALUES (-2320806248371712183);
    INSERT INTO @ConfigGroupIds VALUES (-2310911944299775966);
    INSERT INTO @ConfigGroupIds VALUES (-2238488267113308810);
    INSERT INTO @ConfigGroupIds VALUES (-2147059355369176559);
    INSERT INTO @ConfigGroupIds VALUES (-1635591222982510535);
    INSERT INTO @ConfigGroupIds VALUES (-1624999688046064271);
    INSERT INTO @ConfigGroupIds VALUES (-1323496424401963304);
    INSERT INTO @ConfigGroupIds VALUES (-1304497542036362428);
    INSERT INTO @ConfigGroupIds VALUES (-1136609960426082090);
    INSERT INTO @ConfigGroupIds VALUES (-383605210349505097);
    INSERT INTO @ConfigGroupIds VALUES (60036256406525452);
    INSERT INTO @ConfigGroupIds VALUES (109085691516371965);
    INSERT INTO @ConfigGroupIds VALUES (767833652034630589);
    INSERT INTO @ConfigGroupIds VALUES (881148683257612107);
    INSERT INTO @ConfigGroupIds VALUES (1223784011986591945);
    INSERT INTO @ConfigGroupIds VALUES (1232298188016006398);
    INSERT INTO @ConfigGroupIds VALUES (1240957115574012888);
    INSERT INTO @ConfigGroupIds VALUES (1287625066743264402);
    INSERT INTO @ConfigGroupIds VALUES (1364631742777966163);
    INSERT INTO @ConfigGroupIds VALUES (1913716828197566524);
    INSERT INTO @ConfigGroupIds VALUES (1914130474156726014);
    INSERT INTO @ConfigGroupIds VALUES (1989001888637459309);
    INSERT INTO @ConfigGroupIds VALUES (2237002883694620525);
    INSERT INTO @ConfigGroupIds VALUES (2505696365882641504);
    INSERT INTO @ConfigGroupIds VALUES (2774332741699767269);
    INSERT INTO @ConfigGroupIds VALUES (3168786260864673578);
    INSERT INTO @ConfigGroupIds VALUES (3189959622678903378);
    INSERT INTO @ConfigGroupIds VALUES (3362884251134407151);
    INSERT INTO @ConfigGroupIds VALUES (3559248872843565414);
    INSERT INTO @ConfigGroupIds VALUES (3739189965094689367);
    INSERT INTO @ConfigGroupIds VALUES (3774723236452900354);
    INSERT INTO @ConfigGroupIds VALUES (3780592447908270856);
    INSERT INTO @ConfigGroupIds VALUES (3813205176926613669);
    INSERT INTO @ConfigGroupIds VALUES (4129288096883125748);
    INSERT INTO @ConfigGroupIds VALUES (4208572072426061348);
    INSERT INTO @ConfigGroupIds VALUES (4263282101255212968);
    INSERT INTO @ConfigGroupIds VALUES (4505193432618700901);
    INSERT INTO @ConfigGroupIds VALUES (4631052128945276764);
    INSERT INTO @ConfigGroupIds VALUES (5009320484667002586);
    INSERT INTO @ConfigGroupIds VALUES (5393406227254394582);
    INSERT INTO @ConfigGroupIds VALUES (5621177276048465690);
    INSERT INTO @ConfigGroupIds VALUES (5763517337881168111);
    INSERT INTO @ConfigGroupIds VALUES (5916945531324722255);
    INSERT INTO @ConfigGroupIds VALUES (5918913735931167160);
    INSERT INTO @ConfigGroupIds VALUES (6143152948325390557);
    INSERT INTO @ConfigGroupIds VALUES (6775426529790173259);
    INSERT INTO @ConfigGroupIds VALUES (6805621304279462498);
    INSERT INTO @ConfigGroupIds VALUES (7098363522480490423);
    INSERT INTO @ConfigGroupIds VALUES (7115023718153513169);
    INSERT INTO @ConfigGroupIds VALUES (7187708927592996236);
    INSERT INTO @ConfigGroupIds VALUES (7518319533563758380);
    INSERT INTO @ConfigGroupIds VALUES (7658261195834614566);
    INSERT INTO @ConfigGroupIds VALUES (8235264728202292851);
    INSERT INTO @ConfigGroupIds VALUES (8312559892687542597);
    INSERT INTO @ConfigGroupIds VALUES (8724893352726780856);
    INSERT INTO @ConfigGroupIds VALUES (8727678327962475491);
    INSERT INTO @ConfigGroupIds VALUES (8799631723342597089);
*/



-- The rest is from the Config groups SP

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

DECLARE @PropIMEIKey INT = (
    SELECT [PropertyKey]
    FROM [definition].[Properties] dp WITH (NOLOCK)
    WHERE dp.PropertyId = @UNIT_IMEI
);

DECLARE @FWVersion SMALLINT = 
    (SELECT PropertyKey
FROM [definition].[Properties] WITH (NOLOCK)
WHERE PropertyId = @PreferedFirmwareVersion);



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
FROM @ConfigGroupIds cg
--INNER JOIN [library].[Libraries] l WITH (NOLOCK) ON gi.Id = l.GroupId
INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.Id
INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
    AND tcg.LibraryKey = mdt.LibraryKey
INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
LEFT JOIN [template].[EventTemplates] tet WITH (NOLOCK)
ON tcg.EventTemplateKey = tet.EventTemplateKey
    AND tcg.LibraryKey = tet.LibraryKey
LEFT JOIN [template].[LocationTemplates] tlt WITH (NOLOCK)
ON tcg.LocationTemplateKey = tlt.LocationTemplateKey
    AND tcg.LibraryKey = tlt.LibraryKey




-- ERRORS
-- TODO: MR: OE-515 This will be a new story to get the rules for errors to be displayed for a config group
-- For now I will just return a blank value below



-- ASSET COUNT

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
-- TODO: MR: ToHistoricalTimeZone used in code??? -- 1187: C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs
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
INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON mu.MobileUnitKey = amu.MobileUnitKey
INNER JOIN [definition].[ConfigurationStatuses] cs WITH (NOLOCK) ON cs.[ConfigurationStatus] = mu.[ConfigurationStatus]
LEFT JOIN [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK) ON mu.[MobileUnitKey] = mup.[MobileUnitKey] AND mup.[PropertyKey] = @PropIMEIKey
-- TODO: MR: Should we include: [DynaMiX].[DynaMiX_Satellite].[AssetIridiumHistory]
LEFT JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] mus WITH (NOLOCK) ON mus.[MobileUnitId] = mu.[MobileUnitId] 
    AND mus.[PropertyId] = @SERIAL_NUMBER
LEFT JOIN mobileunit.AssetProperties ap (NOLOCK) on mu.MobileUnitId = ap.AssetId and ap.PropertyId  = @StreamaxSerialNumber;


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
FROM (
        SELECT mum.MessageSubType,
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
FROM [FMOnlineDB].[dbo].[Organisation]
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
        INNER JOIN dbo.Vehicles v WITH (NOLOCK) ON v.iVehicleID = mu.LegacyVehicleId
        INNER JOIN  [dynamix].Assets a WITH (NOLOCK) ON v.iVehicleID  = a.VehicleId  
        INNER JOIN dbo.Sites s WITH (NOLOCK) ON s.liSiteID = v.liSiteID
        INNER JOIN dynamix.Sites ds WITH (NOLOCK) ON ds.SiteID = v.liSiteID

    ;WITH ScheduleLogIds as 
    (
        SELECT 
            MAX(DataScheduleLogID) DataScheduleLogID, 
            a.VehicleId, 
            a.AssetId
        FROM dbo.DataScheduleLog dsl 
        JOIN dbo.DataSchedule ds on ds.liSchedId = dsl.liSchedId 
        JOIN dynamix.Assets a on a.VehicleId = ds.liObjectID		
        JOIN #mobileUnits mu on mu.MobileUnitId = a.AssetId
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
        --[NextRun] = ds.dtNextRun,
        --[DateProcessed] = ds.dtProcessed,
        --[Retries] = ds.ucRetries,
        --[MaxRetries] = ds.ucMaxRetries,
        --[LastEditedBy] = ds.LastEditedBy,
        [LastLogEntry] = [dynamix].[GetLatestScheduleLogMsgByScheduleId] (ds.[liSchedID], null)
    FROM ScheduleLogIds logIds 
    JOIN dynamix.AssetDataSchedules ads ON ads.AssetId = logIds.AssetId
    JOIN dbo.DataSchedule ds on ds.liObjectId = logIds.VehicleId and ds.liSchedID = ads.UploadScheduleId
            '
EXEC sp_executesql @SQL;


-----
-- DONE --
-- Alerts Other story
-- Asset ID
-- Configuration status
-- Configuration status time
-- Mobile device
-- Configuration group name
-- Mobile device template
-- Event template
-- Location template
-- Flagged: Make it asset specific
-- Asset description
-- Registration - Asset registration
-- Site
-- Fleet number
-- FW version - Asset Overwrite
-- CAN script - Asset Overwrite
-- Speed - Asset Overwrite
-- RPM - Asset Overwrite
-- Fuel - Asset Overwrite
-- SP - Asset Overwrite
-- HOS - Asset Overwrite
-- IMEI ****
    -- GetMobileUnitPropertiesForOrgAssets
        -- [mobileunit].[MobileUnit_GetMobileUnitPropertiesForOrgAssets]
            /*
                UNIT_IMEI BIGINT = 9188780602356317147 --********
                INSERT @PropKeys
                SELECT [PropertyId] AS PropId, [PropertyKey] AS PropKey
                FROM [definition].[Properties] dp WITH (NOLOCK)
                WHERE dp.PropertyId IN (	
                    @UNIT_IMEI
                );
                DECLARE @Properties TABLE (PropId BIGINT NOT NULL, MobileUnitId BIGINT NOT NULL, Value NVARCHAR(max) NULL);
                INSERT @Properties
                    SELECT pk.PropId AS PropId, mu.[MobileUnitId], mup.[Value]
                    FROM [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK)
                    INNER JOIN @PropKeys pk ON mup.[PropertyKey] = pk.[PropKey]
                    INNER JOIN @MobileUnits mu ON mup.[MobileUnitKey] = mu.[MUKey];
            */
    -- DoesUniqueIdentifierExistInAnyOrg
        -- GetMobileUnitByUniqueIdentifier
            /*
                UniqueIdentifier = CASE WHEN mu.UniqueIdentifier IS NULL THEN mup.value ELSE mu.UniqueIdentifier END
                FROM mobileUnit.MobileUnits mu
                LEFT JOIN mobileunit.MobileUnitProperties mup ON mu.MobileUnitKey = mup.MobileUnitKey
            */
    -- DoesUniqueIdentifierExistInAnyOrgIridium
        -- [DynaMiX_Satellite].[Iridium_GetAssetByImei]
            /*
            [DynaMiX].[DynaMiX_Satellite].[AssetIridiumHistory]
            */
    -- mu.UniqueIdentifier
    -- GetMobileUnitPropertiesForAssetsList (Same as above)
    -- GetMobileUnitUniqueIdentifier
        -- GetMobileDeviceUniqueIdentifierPropertyId
            /*
                SELECT PropertyId
                FROM definition.Properties dp 
                INNER JOIN [definition].[MobileDevices] dmd on dmd.UniqueIdentifierPropertyKey = dp.PropertyKey
                INNER JOIN mobileunit.MobileUnits mu on dmd.DeviceKey = mu.MobileDeviceKey
                WHERE MobileUnitId = @MobileUnitId
            */
        -- GetMobileUnitPropertyValue
            -- [mobileunit].[MobileUnit_GetMobileUnitPropertyValue]
            -- mobileunit.MobileUnitProperties
    -- GetMobileUnitPropertyValue(mobileUnitId, Properties.UNIT_IMEI)
        -- [mobileunit].[MobileUnit_GetMobileUnitPropertyValue]
    -- Properties.IMEI
        -- IMEI = -9029889041188248996
    -- MobileUnitProperties.FirstOrDefault(x => x.DefinitionPropertyId == Properties.UNIT_IMEI)
    /*
        --External properties
        DECLARE @externalProperties TABLE (MobileUnitId BIGINT, PropertyId BIGINT, [Name] NVARCHAR(200), [Value] NVARCHAR(200));
        INSERT INTO @externalProperties
        SELECT
            mu.MobileUnitId,
            dp.[PropertyId],
            dp.[PropertyName]     AS [Name],
            mup.[Value]
        FROM
            [mobileunit].[MobileUnits] mu WITH (NOLOCK)
            INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK)        ON mu.[MobileDeviceKey]        = dmd.[DeviceKey]
            INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK)    ON mu.[ConfigurationGroupKey]  = tcg.[ConfigurationGroupKey]
            INNER JOIN [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK) ON mu.[MobileUnitKey]          = mup.[MobileUnitKey]
            INNER JOIN [definition].[Properties] dp WITH (NOLOCK)            ON dp.[PropertyKey]           = mup.[PropertyKey]
        WHERE
                tcg.[LibraryKey] IN (SELECT [LibraryKey] FROM @libraryKeys)
                AND  dp.[PropertyId] IN (9188780602356317147)
    */
-- Serialnumber
    -- mobileUnit.MobileUnitSerialNumber
    -- asset.SerialNumber
    -- _deviceStateManager.GetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.SERIAL_NUMBER)
    -- SERIAL_NUMBER = -6167220489794283114
    -- [state].[MobileUnitState_GetStatesForMobileUnits]
        /*
            SELECT
                [MobileUnitId],
                [DeviceId],
                [PropertyId],
                [Value],
                [DateUpdated],
                [MessageDate]
            FROM
                [state].[MobileUnitState] mus WITH (NOLOCK) 
                INNER JOIN @mobileUnitIds mui ON mus.[MobileUnitId] = mui.[id]
                                            AND mus.[DeviceId]     = @deviceId
                                            AND mus.[PropertyId]   = @propertyId; -- SERIAL_NUMBER
        */
-- MiX Vision serial number - Mobile device settings page when commissioning Streamax
    -- NOPE: StreamaxProperties
    -- StreamaxSerialNumber
    -- connectedStreamaxInfo.FirstOrDefault().SerialNo
        -- GetConnectedStreamaxInfoForMobileUnits
        -- [library].[GetConnectedStreamaxInfo]
        /*
            case when (ap.Value is null) then mu.UniqueIdentifier else ap.Value end as SerialNo,
            left join mobileunit.AssetProperties ap (NOLOCK) on mu.MobileUnitId = ap.AssetId and ap.PropertyId  = -4477362625925416557

        */
-- Config compile status
    -- configurationGenerationNotesShort || configurationGenerationWarningShort ??? LANGUAGE
    -- ConfigurationGenerationNotes (Language!!!!)
    -- mu.[ConfigurationGenerationNotes], mu.[ConfigurationGenerationWarning]
-- Comms log
    -- Clicked: viewScheduleLog -- TODO: MR: Clicking
    -- dataProvider
    -- getConfigGroupAssets
        -- GET_CONFIG_GROUP_ASSETS
        -- uploadSchedules
        -- GetAssetUploadSchedulesForAssets
        -- GetAssetUploadSchedulesForAssets
            -- [dynamix].[AssetUploadSchedules_GetSummaryListForAssets]
        -- schedule (per asset)
        -- TODO: MR: LastRun.ToHistoricalTimeZone
            -- IsMesaBased???
                -- uploadEntries = DeviceConfigApi.DeviceConfigClient.MobileUnits.GetLatestUploadMessageStatusesForOrg
                --  dictLatestMesaMessages = uploadEntries.ToDictionary
                --  GetLastMesaLogEntry(dictLatestMesaMessages
                --  mucm.GetLastMessageStatusesForOrg(authToken, groupId, mobileUnitIds, new List<long> { (long)CommandIdType.SendConfig, (long)CommandIdType.SendFirmware, (long)CommandIdType.SendSettings, } )
                    -- SendConfig = 254, SendFirmware = 103, SendSettings = 255
                    -- mum.GetLastMessageStatusesForOrg(mobileUnitIds, messageTypeIds
                    -- _deviceConfigRepo.GetLastMessageStatusesForOrg(mobileUnitIds, messageTypeIds
                    -- [state].[MobileUnitMessage_GetLastMessageStatusesForMobileUnitListAndType]
                    /*
                        @typeList          [dbo].[SelectionIds] READONLY,
                        @mobileUnitIds     [dbo].[SelectionIds] READONLY
                        AS
                        BEGIN

                            CREATE TABLE #t
                            (
                                mobId  BIGINT NOT NULL,
                                typeId BIGINT NOT NULL,
                                PRIMARY KEY (typeId,mobId)
                            )

                            INSERT INTO #t
                            SELECT m.id, t.id
                            FROM @typeList t
                                    CROSS JOIN @mobileUnitIds m
                            GROUP BY m.id, t.id

                            SELECT c.MessageSubType,
                                MessageStatusDateUtc,
                                MessageStatus,
                                MobileUnitId
                            FROM (
                                    SELECT mum.MessageSubType,
                                    mum.CreationDateUtc,
                                    mum.MessageStatusDateUtc,
                                    mum.MessageId,
                                    mum.MessageStatus,
                                    mum.MessageKey,
                                    ROW_NUMBER() OVER ( PARTITION BY mum.MobileUnitId ORDER BY mum.MessageStatusDateUtc DESC ) AS rn, MobileUnitId
                                FROM [state].[MobileUnitMessage] mum  WITH (NOLOCK)
                                    JOIN #t muIds
                                    ON muIds.mobId = mum.MobileUnitId
                                        AND mum.MessageSubType = muIds.typeId
                                ) c
                            WHERE       rn IN (1)
                            ORDER BY    MobileUnitId,c.MessageSubType, MessageStatusDateUtc

                            DROP TABLE #t
                        */
                        --MessageStatusDateUtc --TODO: MR: ToHistoricalTimeZone --<<<<<<<<<<<<
                        -- lastLogEntry (.Title)
                        -- lastCommsLogEntry
                            -- schedule.LastLogEntry --<<<<<<<<<<<<
                            -- ConfigGroupAssetListItem
                            -- schedule
                            -- uploadSchedules
                            -- dataScheduleManager.GetAssetUploadSchedulesForAssets
                            -- [dynamix].[AssetUploadSchedules_GetSummaryListForAssets]

-- TODO --

-- CODE --
-- Last position - CLIENT
-- Date Translations

-- Double Check with PO --
-- Config compile status time

-----



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
    INNER JOIN @GeneralConfigGroupInfo g ON g.ConfigurationGroupId = mu.ConfigurationGroupId
  --INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dmd.DeviceKey = g.DeviceKey
  --INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.[ConfigurationGroupKey] = mu.[ConfigurationGroupKey]
  --INNER JOIN [library].[Libraries] ll WITH (NOLOCK) ON ll.[LibraryKey] = tcg.[LibraryKey]
  INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON dd.[DeviceKey] = td.[DeviceKey]
--Peripheral Devices
	CROSS APPLY ( SELECT
		[LineKey] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN opd.[LineKey] ELSE tpd.[LineKey] END,
		[IsOverridden] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN
										CASE WHEN opd.[LineKey] IS NOT NULL THEN 'true' 
										ELSE 'false' END
									 ELSE 'false' END,
		[Tacho] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN opd.[RecordInterval] ELSE tpd.[RecordInterval] END
    
	  FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
		LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) ON opd.[MobileUnitKey]     = mu.[MobileUnitKey]
		  AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
	  WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
		AND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)
		OR(opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))) pd
  LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = pd.[LineKey]
  --Lines
  LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) ON dmdlpd.[MobileDeviceKey]     = mu.[MobileDeviceKey]
    AND dmdlpd.[LineKey]             = pd.[LineKey]
    AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]
  --Get the connected device
  LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
  LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey


-- NOW - just lines with overwritten included

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
INNER JOIN @AllConfigGroupLines cgl ON cgl.ConfigurationGroupId = mu.ConfigurationGroupId
--LEFT JOIN @EffectiveByMobileUnitId  ON eff.MobileUnitId = mu.MobileUnitId AND eff.LineId = cgl.LineId
LEFT JOIN @EffectiveByMobileUnitId eff ON eff.MobileUnitId = mu.MobileUnitId AND eff.LineId = cgl.LineId
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
INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.PropertyKey = @FWVersion
    AND tdpr.DeviceKey = tdd.DeviceKey
INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = tdpr.Value

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
INNER JOIN [mobileunit].[OverridenDeviceProperties] muopr ON muopr.TemplateDevicePropertyKey = fw.TemplateDevicePropertyKey
INNER JOIN [definition].[FirmwareVersions] dfw WITH (NOLOCK) ON dfw.FirmwareVersionId = muopr.Value


-- Put it all together
SELECT
Alerts = NULL,
Flagged = b.BlackFlagged,
mu.AssetId,
a.AssetDescription,
a.Registration,
a.Sitename,
a.FleetNumber,
'CLIENT CALL' [Lastposition], --TODO: MR: This will need to come from the Lightning client
mu.UniqueIdentifier [IMEI],
mu.Serialnumber Serialnumber,
g.MobileDevice,
ConfigCompileStatus = CASE WHEN mu.configurationGenerationNotes IS NULL THEN mu.ConfigurationGenerationWarning ELSE mu.configurationGenerationNotes END,
--, --TODO: MR
'TODO' ConfigCompileStatusDate, --TODO: MR:
mu.ConfigurationStatus,
mu.ConfigurationStatusDate,
-- TODO: MR: In Code, CommsLog would be mm.MessageStatusDateUtc in historical date, else sched.LastLogEntry
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
--TODO: MR: Find out if Overridden FW could have more than one version
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
-- TODO: MR: expound on this to show asset specific info
-- TODO: MR: I guess this will be blackflag info for this asset?
INNER JOIN #mobileUnits mu ON mu.ConfigurationGroupId = g.ConfigurationGroupId
INNER JOIN #assets a ON a.LegacyVehicleId = mu.LegacyVehicleId
LEFT JOIN @BlackFlagsCount b ON b.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN @AssetFWVersions afw ON afw.MobileUnitKey = mu.MobileUnitKey
LEFT JOIN @mesaMessages mm ON mm.MobileUnitId = mu.MobileUnitId
LEFT JOIN #schedule sched ON sched.AssetId = mu.AssetId
--ORDER BY g.ConfigurationGroupName, mu.AssetId

/*
--Trying to find Overwritten Vals for CG Ids to use for testing
LEFT JOIN @MobileUnitLines mul on mul.MobileUnitId = mu.MobileUnitId
WHERE mul.IsOverridden = 'true'
*/



/*
-- TESTERS
SELECT thisval = 
    STUFF((
            SELECT ', ' + [LineId]
            FROM @MobileUnitLines l
            WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
            AND l.MobileUnitId = mu.MobileUnitId 
            AND (l.WireName = 'C1' OR l.WireName = 'C2')
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '')
    FROM @GeneralConfigGroupInfo g
    INNER JOIN #mobileUnits mu ON mu.ConfigurationGroupId = g.ConfigurationGroupId

--@MobileUnitLines
*/
