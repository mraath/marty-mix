USE [DeviceConfiguration.DataProcessing];

/*

-- =================================================================================================================
-- 1. NEW Multi-Statement Table-Valued Function for Firmware Info
-- This must be in its own batch.
-- =================================================================================================================
CREATE FUNCTION [state].[MobileUnit_GetUnitFirmwareInfoTVF]
(
    @MobileUnitId BIGINT,
    @MobileUnitKey INT,
    @MobileDeviceKey INT,
    @LibraryKey INT,
    @MobileDeviceTemplateKey INT
)
RETURNS @FirmwareInfo TABLE
(
    InstalledFirmwareName NVARCHAR(50),
    PreferredFirmwareName NVARCHAR(50),
    IsFirmwareOutdated BIT
)
AS
BEGIN

    -- CONSTANTS
    DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;
    DECLARE @PreferedFirmwareVersionPropId BIGINT = 4015466679217121645;
    DECLARE @FM200Plus INT = 0, @FM3xBASDDR INT = 2, @FMCANDDMs INT = 3, @FMHOSDBDDM INT = 5, @FMTerminal INT = 1, @MiX2310i INT = 6, @FM3D INT = 7, @ROVIII INT = 9, @TABSBEACONFW INT = 10, @TABSPBSFW INT = 11, @MiX4000 INT = 15, @MiX6000 INT = 16, @MiX2000 INT = 17, @ROVIIII INT = 18, @ROVIIV INT = 19, @MiX6000LTE INT = 20, @MiX3000 INT = 21;
    DECLARE @FM3XXX_MOBILE_DEVICE_RANGE BIGINT = 6773205951411395052, @BASE_FM_FUNCTIONALITY BIGINT = -4443154563661222391, @SCRIPTABLE_CAN_BUS BIGINT = -2374460998933609581, @HOURS_OF_SERVICE BIGINT = 7622806356726782531, @SYSTEM_TERMINAL BIGINT = -7786317619852719241, @MIX3000_FIRMWARE BIGINT = -1056138116899142373, @MIX4000_FW BIGINT = 4999121101837382283, @MIX2000_FIRMWARE BIGINT = -6130542022605112303, @MIX2310_FIRMWARE BIGINT = -6701434148427672311, @FM3D_FW BIGINT = -6696558636443726452, @ROVIII_FIRMWARE_PACKAGE BIGINT = -8240710130213624706, @ROVIIII_FIRMWARE_PACKAGE BIGINT = 7621659214296776294, @ROVIIV_FIRMWARE_PACKAGE BIGINT = -7704231156642700278, @TABS_PBS_FIRMWARE BIGINT = 4309165355632585315, @TABS_BEACON_FIRMWARE BIGINT = 2229325472509295665, @MIX6000_FIRMWARE BIGINT = 7031964624791253468, @MIX6000LTE_FIRMWARE BIGINT = -7449984837957825032;
    DECLARE @FM3316i BIGINT = 873035855993834515, @FM33x6 BIGINT = -9096330589235079600, @FM2000 BIGINT = -1840564510281932398, @FM2000_HV BIGINT = -4778860267039095909, @FM2001 BIGINT = -5858009722316757743, @FM2100 BIGINT = 4650434075306181696, @FM2100_HV BIGINT = -7990768985497297820, @FM2300 BIGINT = 3527221626955903837, @FM2300_HV BIGINT = -2584440882719714179, @FM3106 BIGINT = 6009028139816724904, @FM32x0 BIGINT = -8283040575705223110, @FM32x1 BIGINT = -2638857266241007532, @FM33x0 BIGINT = 6710364014173584261, @FM33x1 BIGINT = -90599922128129323, @FM33x5 BIGINT = -2135111653303591150, @FM_Tracer BIGINT = -5604407714490286122;

    DECLARE @InstalledFirmwareName NVARCHAR(50) = NULL, @PreferredFirmwareName NVARCHAR(50) = NULL, @IsFirmwareOutdated BIT = 0;
    DECLARE @InstalledFirmwareVersionId BIGINT = NULL, @PreferredFirmwareVersionId BIGINT = NULL, @FirmwareType INT = NULL;
    DECLARE @FMBasDevice BIT = 0, @IsCanBasIncompatible BIT = 0;

    SELECT TOP 1 @InstalledFirmwareName = mus.[Value] FROM [state].[MobileUnitState] mus WITH (NOLOCK) WHERE mus.[MobileUnitId] = @MobileUnitId AND mus.[PropertyId] = @FIRMWARE_VERSION;
    IF @InstalledFirmwareName IS NOT NULL
    BEGIN
        SELECT TOP 1 @InstalledFirmwareVersionId = dfw.FirmwareVersionId FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK) WHERE dfw.[Name] = @InstalledFirmwareName;
    END;

    WITH FWPropKey AS (SELECT TOP 1 PropertyKey FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @PreferedFirmwareVersionPropId),
    TemplateFW AS (SELECT DISTINCT tdpr.TemplateDevicePropertyKey, CASE WHEN ISNUMERIC(tdpr.[Value]) = 1 THEN CAST(tdpr.[Value] AS BIGINT) ELSE NULL END AS TemplateFirmwareVersionId FROM [DeviceConfiguration].[template].[MobileDeviceTemplates] tmdt WITH (NOLOCK) INNER JOIN FWPropKey fpk ON 1=1 INNER JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK) ON ddd.ParentDeviceKey = tmdt.MobileDeviceKey INNER JOIN [DeviceConfiguration].[template].[DeviceProperties] tdpr WITH (NOLOCK) ON tdpr.DeviceKey = ddd.ChildDeviceKey AND tdpr.PropertyKey = fpk.PropertyKey WHERE tmdt.MobileDeviceTemplateKey = @MobileDeviceTemplateKey AND tmdt.LibraryKey = @LibraryKey AND tmdt.MobileDeviceKey = @MobileDeviceKey AND tdpr.LibraryKey = @LibraryKey AND tdpr.MobileDeviceTemplateKey = @MobileDeviceTemplateKey AND tdpr.Value IS NOT NULL),
    OverrideFW AS (SELECT DISTINCT tfw.TemplateDevicePropertyKey, CASE WHEN ISNUMERIC(muodp.[Value]) = 1 THEN CAST(muodp.[Value] AS BIGINT) ELSE NULL END AS OverriddenFirmwareVersionId FROM [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties] muodp WITH (NOLOCK) INNER JOIN TemplateFW tfw ON muodp.TemplateDevicePropertyKey = tfw.TemplateDevicePropertyKey WHERE muodp.MobileUnitKey = @MobileUnitKey AND muodp.Value IS NOT NULL),
    PreferredFW AS (SELECT COALESCE(ofw.OverriddenFirmwareVersionId, tfw.TemplateFirmwareVersionId) AS PreferredFirmwareVersionId FROM TemplateFW tfw LEFT JOIN OverrideFW ofw ON tfw.TemplateDevicePropertyKey = ofw.TemplateDevicePropertyKey)
    SELECT TOP 1 @PreferredFirmwareVersionId = pfw.PreferredFirmwareVersionId, @PreferredFirmwareName = dfw.Name FROM PreferredFW pfw INNER JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK) ON pfw.PreferredFirmwareVersionId = dfw.FirmwareVersionId;

    IF @PreferredFirmwareVersionId IS NOT NULL
    BEGIN
        SELECT TOP 1 @FirmwareType = dfw.FirmwareType FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK) INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw WITH (NOLOCK) ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey WHERE dfw.FirmwareVersionId = @PreferredFirmwareVersionId AND lfw.LibraryKey = @LibraryKey;
        IF @FirmwareType IS NOT NULL
        BEGIN
            SELECT TOP 1 @FMBasDevice = 1 FROM [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK) INNER JOIN [DeviceConfiguration].[definition].[Devices] ddParent WITH (NOLOCK) ON ddParent.DeviceKey = ddd.ParentDeviceKey WHERE ddd.ChildDeviceKey = @MobileDeviceKey AND ddParent.DeviceId = @FM3XXX_MOBILE_DEVICE_RANGE;
            IF @FirmwareType = @FMCANDDMs
            BEGIN
                 SELECT TOP 1 @IsCanBasIncompatible = 1 FROM [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK) WHERE dd.DeviceKey = @MobileDeviceKey AND dd.DeviceId IN (@FM3316i, @FM33x6, @FM2000, @FM2000_HV, @FM2001, @FM2100, @FM2100_HV, @FM2300, @FM2300_HV, @FM3106, @FM32x0, @FM32x1, @FM33x0, @FM33x1, @FM33x5, @FM_Tracer);
            END;
            DECLARE @AnchorDeviceId BIGINT = CASE @FirmwareType WHEN @FM3xBASDDR THEN @BASE_FM_FUNCTIONALITY WHEN @FM200Plus THEN @BASE_FM_FUNCTIONALITY WHEN @FMCANDDMs THEN @SCRIPTABLE_CAN_BUS WHEN @FMHOSDBDDM THEN @HOURS_OF_SERVICE WHEN @FMTerminal THEN @SYSTEM_TERMINAL WHEN @MiX3000 THEN @MIX3000_FIRMWARE WHEN @MiX4000 THEN @MIX4000_FW WHEN @MiX2000 THEN @MIX2000_FIRMWARE WHEN @MiX2310i THEN @MIX2310_FIRMWARE WHEN @FM3D THEN @FM3D_FW WHEN @ROVIII THEN @ROVIII_FIRMWARE_PACKAGE WHEN @ROVIIII THEN @ROVIIII_FIRMWARE_PACKAGE WHEN @ROVIIV THEN @ROVIIV_FIRMWARE_PACKAGE WHEN @TABSPBSFW THEN @TABS_PBS_FIRMWARE WHEN @TABSBEACONFW THEN @TABS_BEACON_FIRMWARE WHEN @MiX6000 THEN @MIX6000_FIRMWARE WHEN @MiX6000LTE THEN @MIX6000LTE_FIRMWARE ELSE NULL END;
            IF @AnchorDeviceId IS NOT NULL
            BEGIN
                DECLARE @FilteredVersions TABLE (VersionNumber INT, FirmwareVersionId BIGINT, FWName NVARCHAR(50));
                INSERT INTO @FilteredVersions (VersionNumber, FirmwareVersionId, FWName) SELECT ROW_NUMBER() OVER (ORDER BY dfw.Name), dfw.FirmwareVersionId, dfw.Name FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK) INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw WITH (NOLOCK) ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey WHERE dfw.FirmwareType = @FirmwareType AND lfw.LibraryKey = @LibraryKey;
                IF @IsCanBasIncompatible = 1 AND @FirmwareType = @FMCANDDMs BEGIN DELETE FROM @FilteredVersions WHERE FWName LIKE 'E%'; END;
                IF @FirmwareType = @FM3xBASDDR AND @FMBasDevice = 0 BEGIN DELETE FROM @FilteredVersions; END;
                DECLARE @PreferredVersionNumber INT, @LatestVersionNumber INT;
                SELECT @PreferredVersionNumber = VersionNumber FROM @FilteredVersions WHERE FirmwareVersionId = @PreferredFirmwareVersionId;
                SELECT @LatestVersionNumber = MAX(VersionNumber) FROM @FilteredVersions;
                IF @PreferredVersionNumber IS NOT NULL AND @LatestVersionNumber IS NOT NULL AND (@LatestVersionNumber - @PreferredVersionNumber) > 2
                BEGIN
                    SET @IsFirmwareOutdated = 1;
                END;
            END;
        END;
    END;

    INSERT INTO @FirmwareInfo (InstalledFirmwareName, PreferredFirmwareName, IsFirmwareOutdated) VALUES (ISNULL(@InstalledFirmwareName, ''), ISNULL(@PreferredFirmwareName, ''), ISNULL(@IsFirmwareOutdated, 0));
    RETURN;
END;
GO

PRINT 'Function created successfully. Creating procedure...';
GO

-- =================================================================================================================
-- 2. OPTIMIZED Stored Procedure
-- This must be in its own batch.
-- =================================================================================================================
DROP PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized];

CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #BasicInfo (MobileUnitId BIGINT PRIMARY KEY, AssetId BIGINT, ConfigurationGroupId BIGINT, ConfigurationGroupKey INT, MobileDeviceKey INT, MobileUnitKey INT, ConfigurationStatusId INT, ConfigurationStatus NVARCHAR(50), ConfigurationStatusDate DATETIME, LegacyOrgId INT, LegacyVehicleId INT, [UniqueIdentifier] NVARCHAR(250), Serialnumber NVARCHAR(250), StreamaxSerialNumber NVARCHAR(250), ConfigurationGenerationNotes NVARCHAR(MAX), ConfigurationGenerationWarning NVARCHAR(MAX), LibraryKey INT, EventTemplateKey INT, LocationTemplateKey INT, MobileDeviceTemplateKey INT);
    INSERT INTO #BasicInfo EXEC [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] @configGroupIds;

    SELECT
        Alerts = CONCAT(ISNULL(msgAlerts.MessageAlertCode, '00'), CAST(ISNULL(fw.IsFirmwareOutdated, 0) AS CHAR(1)), '0'),
        bi.MobileUnitId, bi.Serialnumber, bi.ConfigurationGroupId, NULL as CommsLog,
        CAST(lastMsg.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc,
        fw.InstalledFirmwareName AS FWVersion, fw.PreferredFirmwareName AS PreferredFWVersion
    FROM #BasicInfo bi
    CROSS APPLY [state].[MobileUnit_GetUnitFirmwareInfoTVF](bi.MobileUnitId, bi.MobileUnitKey, bi.MobileDeviceKey, bi.LibraryKey, bi.MobileDeviceTemplateKey) AS fw
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](bi.MobileUnitId) AS msgAlerts
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageDate](bi.MobileUnitId) AS lastMsg;

    DROP TABLE #BasicInfo;
END;
GO

PRINT 'Procedure created successfully.';
PRINT '-------------------------------------------------';
PRINT 'Now, preparing to execute the procedure...';
GO


*/



-- =================================================================================================================
-- 3. EXECUTE the new procedure
-- This is the actual test execution batch.
-- =================================================================================================================

-- Declare the table variable that the stored procedure expects
DECLARE @MyConfigGroupIds [dbo].[SelectionIds];

-- !!! IMPORTANT !!!
-- Insert the ConfigurationGroupIds you want to test into this table variable.
-- Replace the values 1, 2, 3 with real IDs from your database.

INSERT INTO @MyConfigGroupIds (id) 
VALUES (-2803813420773469362), (2557659825063191210), (-6039078778185809084), (3189959622678903378), (1989001888637459309), (-9078750292130215188), (-3274353763833670263), (1232298188016006398), (4631052128945276764), (-3251388662902899727), (-1806774282659967806), (5918913735931167160), (8799631723342597089), (-8162147584136025918), (-1307004388228739243), (-6257508969252238550), (8312559892687542597), (-1323496424401963304), (-2524931806030160341), (3681922843152348030), (3209265185920104888), (5621177276048465690), (-8126655682067440340), (-6836621200088256507), (3780592447908270856), (1223784011986591945), (-3366261590319731458), (-7392764503748298046), (-7629839428314466340), (7187708927592996236), (-1635591222982510535), (-6151357456724753887), (-5912082017677079777), (-5390337933230695538), (-4067179943998429825), (1364631742777966163), (-7653538731568077332), (-7668187040444806181), (4208572072426061348), (3362884251134407151), (-3893536691584770708), (-6084966262084607888), (3774723236452900354), (-2723417818245426945), (-3836116117686479120), (-7382401016514304197), (7518319533563758380), (3813205176926613669), (5916945531324722255), (-5159253166163790691), (-2147059355369176559), (60036256406525452), (767833652034630589), (-6328313109361883502), (1287625066743264402), (2505696365882641504), (1240957115574012888), (-2374899645906010889), (3739189965094689367), (8235264728202292851), (-1136609960426082090), (4505193432618700901), (6775426529790173259), (-3798194295803321659), (-8871627763454545305), (-2110415703208626075), (-5801394207784667707), (4309917650092943416), (6143152948325390557), (2237002883694620525), (-6366678994605550120), (881148683257612107), (-7944209854350725335), (3559248872843565414), (3168786260864673578), (7598006177779832207), (-1923500799342536831), (-1733893171984566420), (-8642220154752102213), (5009320484667002586), (-8507561780508819492), (7115023718153513169), (8724893352726780856), (-383605210349505097), (-2310911944299775966), (1735562267874004226), (-2320806248371712183), (-5340634987676521615), (4263282101255212968); -- LESS, but Alerts:


-- LOTS, but NO ALERTS: VALUES (-4706039627829598783),(199325999668202366), (-8457480704780512749),(2677576181771254477),(2823596733503101975),(1538687544172856721), (-4229490949371290982), (-2384730484822060182),(7440653181116775134),(8283011099424745956),(6270824666272621435), (-8949632091574047260), (-8207503568458137854), (-1215659196319016695),(6152593781035096689),(2974831301785092008),(3962657782447665558), (-3546122059729481997),(5567431191665092749), (-5883907305683060856),(461085753557650606),(3502599370431462499), (-7369294648932782097), (-8787908773382047661),(7287834424358043214),(3977693385065534239),(3545130468931642729),(75472660843825717), (-6236293196728745404), (-2473474416939851345), (-4815071576473298740), (-2317285672350580067),(3504428657675998019),(4462868102626601662),(3052323964734261303),(2610836696632034535),(3273233624147396660), (-8388558004121944370),(5295170289666896775),(7909417651692360436), (-7590346313175141016),(6277877287032876699), (-576980630916973063);








PRINT 'Executing procedure with the selected IDs...';

-- Execute the old

EXEC [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups] @configGroupIds = @MyConfigGroupIds;

-- Execute the new, optimized stored procedure
EXEC [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized] @configGroupIds = @MyConfigGroupIds;

/*
-----------------

-- Create temp tables to store results from both procedures
    CREATE TABLE #OriginalResults
    (
        Alerts NVARCHAR(10),
        MobileUnitId BIGINT,
        Serialnumber NVARCHAR(250),
        ConfigurationGroupId BIGINT,
        CommsLog NVARCHAR(MAX),
        MessageStatusDateUtc DATETIME,
        FWVersion NVARCHAR(50),
        PreferredFWVersion NVARCHAR(50),
        RowNumber INT IDENTITY(1,1)
    );

    CREATE TABLE #OptimizedResults
    (
        Alerts NVARCHAR(10),
        MobileUnitId BIGINT,
        Serialnumber NVARCHAR(250),
        ConfigurationGroupId BIGINT,
        CommsLog NVARCHAR(MAX),
        MessageStatusDateUtc DATETIME,
        FWVersion NVARCHAR(50),
        PreferredFWVersion NVARCHAR(50),
        RowNumber INT IDENTITY(1,1)
    );

    PRINT 'Executing original procedure...';
    -- Execute original procedure and store results
    INSERT INTO #OriginalResults (Alerts, MobileUnitId, Serialnumber, ConfigurationGroupId, CommsLog, MessageStatusDateUtc, FWVersion, PreferredFWVersion)
    EXEC [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups] @configGroupIds = @MyConfigGroupIds;

    PRINT 'Executing optimized procedure...';
    -- Execute optimized procedure and store results
    INSERT INTO #OptimizedResults (Alerts, MobileUnitId, Serialnumber, ConfigurationGroupId, CommsLog, MessageStatusDateUtc, FWVersion, PreferredFWVersion)
    EXEC [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized] @configGroupIds = @MyConfigGroupIds;

    -- Get row counts
    DECLARE @OriginalRowCount INT = (SELECT COUNT(*) FROM #OriginalResults);
    DECLARE @OptimizedRowCount INT = (SELECT COUNT(*) FROM #OptimizedResults);

    -- Summary comparison
    PRINT '';
    PRINT '=== COMPARISON SUMMARY ===';
    PRINT 'Original procedure rows: ' + CAST(@OriginalRowCount AS VARCHAR(10));
    PRINT 'Optimized procedure rows: ' + CAST(@OptimizedRowCount AS VARCHAR(10));
    
    IF @OriginalRowCount = @OptimizedRowCount
        PRINT '✓ Row counts match';
    ELSE
        PRINT '✗ Row counts differ by ' + CAST(ABS(@OriginalRowCount - @OptimizedRowCount) AS VARCHAR(10)) + ' rows';

    -- Find rows only in original
    SELECT 
        'Only in Original' as DifferenceType,
        o.*
    INTO #OnlyInOriginal
    FROM #OriginalResults o
    LEFT JOIN #OptimizedResults opt ON o.MobileUnitId = opt.MobileUnitId
    WHERE opt.MobileUnitId IS NULL;

    -- Find rows only in optimized
    SELECT 
        'Only in Optimized' as DifferenceType,
        opt.*
    INTO #OnlyInOptimized
    FROM #OptimizedResults opt
    LEFT JOIN #OriginalResults o ON opt.MobileUnitId = o.MobileUnitId
    WHERE o.MobileUnitId IS NULL;

    -- Find rows with different values
    SELECT 
        'Value Differences' as DifferenceType,
        o.MobileUnitId,
        o.Serialnumber as Original_Serialnumber,
        opt.Serialnumber as Optimized_Serialnumber,
        o.Alerts as Original_Alerts,
        opt.Alerts as Optimized_Alerts,
        o.ConfigurationGroupId as Original_ConfigurationGroupId,
        opt.ConfigurationGroupId as Optimized_ConfigurationGroupId,
        o.CommsLog as Original_CommsLog,
        opt.CommsLog as Optimized_CommsLog,
        o.MessageStatusDateUtc as Original_MessageStatusDateUtc,
        opt.MessageStatusDateUtc as Optimized_MessageStatusDateUtc,
        o.FWVersion as Original_FWVersion,
        opt.FWVersion as Optimized_FWVersion,
        o.PreferredFWVersion as Original_PreferredFWVersion,
        opt.PreferredFWVersion as Optimized_PreferredFWVersion,
        CASE 
            WHEN o.Serialnumber <> opt.Serialnumber THEN 'Serialnumber'
            WHEN o.Alerts <> opt.Alerts THEN 'Alerts'
            WHEN o.ConfigurationGroupId <> opt.ConfigurationGroupId THEN 'ConfigurationGroupId'
            WHEN ISNULL(o.CommsLog, '') <> ISNULL(opt.CommsLog, '') THEN 'CommsLog'
            WHEN ISNULL(o.MessageStatusDateUtc, '1900-01-01') <> ISNULL(opt.MessageStatusDateUtc, '1900-01-01') THEN 'MessageStatusDateUtc'
            WHEN ISNULL(o.FWVersion, '') <> ISNULL(opt.FWVersion, '') THEN 'FWVersion'
            WHEN ISNULL(o.PreferredFWVersion, '') <> ISNULL(opt.PreferredFWVersion, '') THEN 'PreferredFWVersion'
        END as DifferentColumn
    INTO #ValueDifferences
    FROM #OriginalResults o
    INNER JOIN #OptimizedResults opt ON o.MobileUnitId = opt.MobileUnitId
    WHERE NOT (
        o.Serialnumber = opt.Serialnumber
        AND o.Alerts = opt.Alerts
        AND o.ConfigurationGroupId = opt.ConfigurationGroupId
        AND ISNULL(o.CommsLog, '') = ISNULL(opt.CommsLog, '')
        AND ISNULL(o.MessageStatusDateUtc, '1900-01-01') = ISNULL(opt.MessageStatusDateUtc, '1900-01-01')
        AND ISNULL(o.FWVersion, '') = ISNULL(opt.FWVersion, '')
        AND ISNULL(o.PreferredFWVersion, '') = ISNULL(opt.PreferredFWVersion, '')
    );

    DECLARE @OnlyInOriginalCount INT = (SELECT COUNT(*) FROM #OnlyInOriginal);
    DECLARE @OnlyInOptimizedCount INT = (SELECT COUNT(*) FROM #OnlyInOptimized);
    DECLARE @ValueDifferencesCount INT = (SELECT COUNT(*) FROM #ValueDifferences);

    PRINT 'Rows only in original: ' + CAST(@OnlyInOriginalCount AS VARCHAR(10));
    PRINT 'Rows only in optimized: ' + CAST(@OnlyInOptimizedCount AS VARCHAR(10));
    PRINT 'Rows with value differences: ' + CAST(@ValueDifferencesCount AS VARCHAR(10));

    -- Calculate match percentage
    DECLARE @TotalRows INT = @OriginalRowCount + @OptimizedRowCount;
    DECLARE @MatchingRows INT = @OriginalRowCount - @OnlyInOriginalCount - @ValueDifferencesCount;
    DECLARE @MatchPercentage DECIMAL(5,2) = 
        CASE 
            WHEN @OriginalRowCount = 0 THEN 0
            ELSE CAST(@MatchingRows AS DECIMAL) / CAST(@OriginalRowCount AS DECIMAL) * 100
        END;

    PRINT 'Match percentage: ' + CAST(@MatchPercentage AS VARCHAR(10)) + '%';
    
    IF @MatchPercentage = 100.00
        PRINT '✓ Perfect match - procedures return identical results';
    ELSE IF @MatchPercentage >= 95.00
        PRINT '⚠ Good match - minor differences detected';
    ELSE
        PRINT '✗ Poor match - significant differences detected';

    -- Show detailed differences if requested
    IF @ShowDetails = 1 AND (@OnlyInOriginalCount > 0 OR @OnlyInOptimizedCount > 0 OR @ValueDifferencesCount > 0)
    BEGIN
        PRINT '';
        PRINT '=== DETAILED DIFFERENCES ===';

        IF @OnlyInOriginalCount > 0
        BEGIN
            PRINT '';
            PRINT 'ROWS ONLY IN ORIGINAL (' + CAST(@OnlyInOriginalCount AS VARCHAR(10)) + ' rows):';
            SELECT * FROM #OnlyInOriginal;
        END

        IF @OnlyInOptimizedCount > 0
        BEGIN
            PRINT '';
            PRINT 'ROWS ONLY IN OPTIMIZED (' + CAST(@OnlyInOptimizedCount AS VARCHAR(10)) + ' rows):';
            SELECT * FROM #OnlyInOptimized;
        END

        IF @ValueDifferencesCount > 0
        BEGIN
            PRINT '';
            PRINT 'ROWS WITH VALUE DIFFERENCES (' + CAST(@ValueDifferencesCount AS VARCHAR(10)) + ' rows):';
            SELECT 
                MobileUnitId,
                DifferentColumn,
                Original_Alerts, Optimized_Alerts,
                Original_Serialnumber, Optimized_Serialnumber,
                Original_ConfigurationGroupId, Optimized_ConfigurationGroupId,
                Original_MessageStatusDateUtc, Optimized_MessageStatusDateUtc,
                Original_FWVersion, Optimized_FWVersion,
                Original_PreferredFWVersion, Optimized_PreferredFWVersion
            FROM #ValueDifferences
            ORDER BY MobileUnitId;
        END
    END

    -- Performance comparison
    PRINT '';
    PRINT '=== PERFORMANCE COMPARISON ===';
    
    -- Test original procedure performance
    DECLARE @StartTimeOriginal DATETIME = GETDATE();
    INSERT INTO #OriginalResults (Alerts, MobileUnitId, Serialnumber, ConfigurationGroupId, CommsLog, MessageStatusDateUtc, FWVersion, PreferredFWVersion)
    EXEC [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups] @configGroupIds = @MyConfigGroupIds;
    DECLARE @EndTimeOriginal DATETIME = GETDATE();
    DECLARE @OriginalDuration INT = DATEDIFF(MILLISECOND, @StartTimeOriginal, @EndTimeOriginal);

    -- Test optimized procedure performance
    DECLARE @StartTimeOptimized DATETIME = GETDATE();
    INSERT INTO #OptimizedResults (Alerts, MobileUnitId, Serialnumber, ConfigurationGroupId, CommsLog, MessageStatusDateUtc, FWVersion, PreferredFWVersion)
    EXEC [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized] @configGroupIds = @MyConfigGroupIds;
    DECLARE @EndTimeOptimized DATETIME = GETDATE();
    DECLARE @OptimizedDuration INT = DATEDIFF(MILLISECOND, @StartTimeOptimized, @EndTimeOptimized);

    PRINT 'Original procedure duration: ' + CAST(@OriginalDuration AS VARCHAR(10)) + ' ms';
    PRINT 'Optimized procedure duration: ' + CAST(@OptimizedDuration AS VARCHAR(10)) + ' ms';
    
    IF @OptimizedDuration < @OriginalDuration
    BEGIN
        DECLARE @ImprovementPercentage DECIMAL(5,2) = 
            CAST((@OriginalDuration - @OptimizedDuration) AS DECIMAL) / CAST(@OriginalDuration AS DECIMAL) * 100;
        PRINT '✓ Optimized procedure is ' + CAST(@ImprovementPercentage AS VARCHAR(10)) + '% faster';
    END
    ELSE IF @OptimizedDuration > @OriginalDuration
    BEGIN
        DECLARE @DegradationPercentage DECIMAL(5,2) = 
            CAST((@OptimizedDuration - @OriginalDuration) AS DECIMAL) / CAST(@OriginalDuration AS DECIMAL) * 100;
        PRINT '✗ Optimized procedure is ' + CAST(@DegradationPercentage AS VARCHAR(10)) + '% slower';
    END
    ELSE
        PRINT '⚠ Both procedures have similar performance';

    -- Clean up temp tables
    DROP TABLE #OriginalResults;
    DROP TABLE #OptimizedResults;
    DROP TABLE #OnlyInOriginal;
    DROP TABLE #OnlyInOptimized;
    DROP TABLE #ValueDifferences;

    PRINT '';
    PRINT '=== COMPARISON COMPLETE ===';

-----------------
*/


