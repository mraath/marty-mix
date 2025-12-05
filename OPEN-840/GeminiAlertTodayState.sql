
-- =================================================================================================================
-- 1. NEW Multi-Statement Table-Valued Function for Firmware Info
-- This function encapsulates the logic from the original [state].[MobileUnit_GetMobileUnitFirmwareInfo]
-- stored procedure, but is designed to be used in a set-based manner with CROSS APPLY.
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
    -- The entire body of the original [state].[MobileUnit_GetMobileUnitFirmwareInfo] procedure is placed here.
    -- The output parameters are replaced by an INSERT statement into the return table variable @FirmwareInfo.

    SET NOCOUNT ON;

    -- CONSTANTS (Copied from original SP)
    DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;
    DECLARE @PreferedFirmwareVersionPropId BIGINT = 4015466679217121645;
    DECLARE @FM200Plus INT = 0, @FM3xBASDDR INT = 2, @FMCANDDMs INT = 3, @FMHOSDBDDM INT = 5, @FMTerminal INT = 1, @MiX2310i INT = 6, @FM3D INT = 7, @ROVIII INT = 9, @TABSBEACONFW INT = 10, @TABSPBSFW INT = 11, @MiX4000 INT = 15, @MiX6000 INT = 16, @MiX2000 INT = 17, @ROVIIII INT = 18, @ROVIIV INT = 19, @MiX6000LTE INT = 20, @MiX3000 INT = 21;
    DECLARE @FM3XXX_MOBILE_DEVICE_RANGE BIGINT = 6773205951411395052, @BASE_FM_FUNCTIONALITY BIGINT = -4443154563661222391, @SCRIPTABLE_CAN_BUS BIGINT = -2374460998933609581, @HOURS_OF_SERVICE BIGINT = 7622806356726782531, @SYSTEM_TERMINAL BIGINT = -7786317619852719241, @MIX3000_FIRMWARE BIGINT = -1056138116899142373, @MIX4000_FW BIGINT = 4999121101837382283, @MIX2000_FIRMWARE BIGINT = -6130542022605112303, @MIX2310_FIRMWARE BIGINT = -6701434148427672311, @FM3D_FW BIGINT = -6696558636443726452, @ROVIII_FIRMWARE_PACKAGE BIGINT = -8240710130213624706, @ROVIIII_FIRMWARE_PACKAGE BIGINT = 7621659214296776294, @ROVIIV_FIRMWARE_PACKAGE BIGINT = -7704231156642700278, @TABS_PBS_FIRMWARE BIGINT = 4309165355632585315, @TABS_BEACON_FIRMWARE BIGINT = 2229325472509295665, @MIX6000_FIRMWARE BIGINT = 7031964624791253468, @MIX6000LTE_FIRMWARE BIGINT = -7449984837957825032;
    DECLARE @FM3316i BIGINT = 873035855993834515, @FM33x6 BIGINT = -9096330589235079600, @FM2000 BIGINT = -1840564510281932398, @FM2000_HV BIGINT = -4778860267039095909, @FM2001 BIGINT = -5858009722316757743, @FM2100 BIGINT = 4650434075306181696, @FM2100_HV BIGINT = -7990768985497297820, @FM2300 BIGINT = 3527221626955903837, @FM2300_HV BIGINT = -2584440882719714179, @FM3106 BIGINT = 6009028139816724904, @FM32x0 BIGINT = -8283040575705223110, @FM32x1 BIGINT = -2638857266241007532, @FM33x0 BIGINT = 6710364014173584261, @FM33x1 BIGINT = -90599922128129323, @FM33x5 BIGINT = -2135111653303591150, @FM_Tracer BIGINT = -5604407714490286122;

    -- Local variables to hold the results before inserting
    DECLARE @InstalledFirmwareName NVARCHAR(50) = NULL;
    DECLARE @PreferredFirmwareName NVARCHAR(50) = NULL;
    DECLARE @IsFirmwareOutdated BIT = 0;
    DECLARE @InstalledFirmwareVersionId BIGINT = NULL;
    DECLARE @PreferredFirmwareVersionId BIGINT = NULL;
    DECLARE @FirmwareType INT = NULL;
    DECLARE @FMBasDevice BIT = 0;
    DECLARE @IsCanBasIncompatible BIT = 0;

    -- INSTALLED FW (Name and VersionId)
    SELECT TOP 1 @InstalledFirmwareName = mus.[Value]
    FROM [state].[MobileUnitState] mus WITH (NOLOCK)
    WHERE mus.[MobileUnitId] = @MobileUnitId AND mus.[PropertyId] = @FIRMWARE_VERSION;

    IF @InstalledFirmwareName IS NOT NULL
    BEGIN
        SELECT TOP 1 @InstalledFirmwareVersionId = dfw.FirmwareVersionId
        FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK)
        WHERE dfw.[Name] = @InstalledFirmwareName;
    END;

    -- PREFERRED FW VERSION
    WITH FWPropKey AS (
        SELECT TOP 1 PropertyKey FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @PreferedFirmwareVersionPropId
    ),
    TemplateFW AS (
        SELECT DISTINCT
            tdpr.TemplateDevicePropertyKey,
            CASE WHEN ISNUMERIC(tdpr.[Value]) = 1 THEN CAST(tdpr.[Value] AS BIGINT) ELSE NULL END AS TemplateFirmwareVersionId
        FROM [DeviceConfiguration].[template].[MobileDeviceTemplates] tmdt WITH (NOLOCK)
        INNER JOIN FWPropKey fpk ON 1=1
        INNER JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK) ON ddd.ParentDeviceKey = tmdt.MobileDeviceKey
        INNER JOIN [DeviceConfiguration].[template].[DeviceProperties] tdpr WITH (NOLOCK) ON tdpr.DeviceKey = ddd.ChildDeviceKey AND tdpr.PropertyKey = fpk.PropertyKey
        WHERE tmdt.MobileDeviceTemplateKey = @MobileDeviceTemplateKey AND tmdt.LibraryKey = @LibraryKey AND tmdt.MobileDeviceKey = @MobileDeviceKey
          AND tdpr.LibraryKey = @LibraryKey AND tdpr.MobileDeviceTemplateKey = @MobileDeviceTemplateKey AND tdpr.Value IS NOT NULL
    ),
    OverrideFW AS (
        SELECT DISTINCT
            tfw.TemplateDevicePropertyKey,
            CASE WHEN ISNUMERIC(muodp.[Value]) = 1 THEN CAST(muodp.[Value] AS BIGINT) ELSE NULL END AS OverriddenFirmwareVersionId
        FROM [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties] muodp WITH (NOLOCK)
        INNER JOIN TemplateFW tfw ON muodp.TemplateDevicePropertyKey = tfw.TemplateDevicePropertyKey
        WHERE muodp.MobileUnitKey = @MobileUnitKey AND muodp.Value IS NOT NULL
    ),
    PreferredFW AS (
        SELECT COALESCE(ofw.OverriddenFirmwareVersionId, tfw.TemplateFirmwareVersionId) AS PreferredFirmwareVersionId
        FROM TemplateFW tfw
        LEFT JOIN OverrideFW ofw ON tfw.TemplateDevicePropertyKey = ofw.TemplateDevicePropertyKey
    )
    SELECT TOP 1
        @PreferredFirmwareVersionId = pfw.PreferredFirmwareVersionId,
        @PreferredFirmwareName = dfw.Name
    FROM PreferredFW pfw
    INNER JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK) ON pfw.PreferredFirmwareVersionId = dfw.FirmwareVersionId;

    -- DETERMINE IF PREFERRED FW IS OUTDATED
    IF @PreferredFirmwareVersionId IS NOT NULL
    BEGIN
        SELECT TOP 1 @FirmwareType = dfw.FirmwareType
        FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK)
        INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw WITH (NOLOCK) ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey
        WHERE dfw.FirmwareVersionId = @PreferredFirmwareVersionId AND lfw.LibraryKey = @LibraryKey;

        IF @FirmwareType IS NOT NULL
        BEGIN
            SELECT TOP 1 @FMBasDevice = 1
            FROM [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK)
            INNER JOIN [DeviceConfiguration].[definition].[Devices] ddParent WITH (NOLOCK) ON ddParent.DeviceKey = ddd.ParentDeviceKey
            WHERE ddd.ChildDeviceKey = @MobileDeviceKey AND ddParent.DeviceId = @FM3XXX_MOBILE_DEVICE_RANGE;

            IF @FirmwareType = @FMCANDDMs
            BEGIN
                 SELECT TOP 1 @IsCanBasIncompatible = 1
                 FROM [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK)
                 WHERE dd.DeviceKey = @MobileDeviceKey
                   AND dd.DeviceId IN (@FM3316i, @FM33x6, @FM2000, @FM2000_HV, @FM2001, @FM2100, @FM2100_HV, @FM2300, @FM2300_HV, @FM3106, @FM32x0, @FM32x1, @FM33x0, @FM33x1, @FM33x5, @FM_Tracer);
            END;

            DECLARE @AnchorDeviceId BIGINT = CASE @FirmwareType WHEN @FM3xBASDDR THEN @BASE_FM_FUNCTIONALITY WHEN @FM200Plus THEN @BASE_FM_FUNCTIONALITY WHEN @FMCANDDMs THEN @SCRIPTABLE_CAN_BUS WHEN @FMHOSDBDDM THEN @HOURS_OF_SERVICE WHEN @FMTerminal THEN @SYSTEM_TERMINAL WHEN @MiX3000 THEN @MIX3000_FIRMWARE WHEN @MiX4000 THEN @MIX4000_FW WHEN @MiX2000 THEN @MIX2000_FIRMWARE WHEN @MiX2310i THEN @MIX2310_FIRMWARE WHEN @FM3D THEN @FM3D_FW WHEN @ROVIII THEN @ROVIII_FIRMWARE_PACKAGE WHEN @ROVIIII THEN @ROVIIII_FIRMWARE_PACKAGE WHEN @ROVIIV THEN @ROVIIV_FIRMWARE_PACKAGE WHEN @TABSPBSFW THEN @TABS_PBS_FIRMWARE WHEN @TABSBEACONFW THEN @TABS_BEACON_FIRMWARE WHEN @MiX6000 THEN @MIX6000_FIRMWARE WHEN @MiX6000LTE THEN @MIX6000LTE_FIRMWARE ELSE NULL END;

            IF @AnchorDeviceId IS NOT NULL
            BEGIN
                DECLARE @FilteredVersions TABLE (VersionNumber INT, FirmwareVersionId BIGINT, FWName NVARCHAR(50));
                INSERT INTO @FilteredVersions (VersionNumber, FirmwareVersionId, FWName)
                SELECT
                    ROW_NUMBER() OVER (ORDER BY dfw.Name),
                    dfw.FirmwareVersionId,
                    dfw.Name
                FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK)
                INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw WITH (NOLOCK) ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey
                WHERE dfw.FirmwareType = @FirmwareType AND lfw.LibraryKey = @LibraryKey;

                IF @IsCanBasIncompatible = 1 AND @FirmwareType = @FMCANDDMs BEGIN DELETE FROM @FilteredVersions WHERE FWName LIKE 'E%'; END
                IF @FirmwareType = @FM3xBASDDR AND @FMBasDevice = 0 BEGIN DELETE FROM @FilteredVersions; END

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

    -- Insert the final results into the return table
    INSERT INTO @FirmwareInfo (InstalledFirmwareName, PreferredFirmwareName, IsFirmwareOutdated)
    VALUES (ISNULL(@InstalledFirmwareName, ''), ISNULL(@PreferredFirmwareName, ''), ISNULL(@IsFirmwareOutdated, 0));

    RETURN;
END;
GO

-- =================================================================================================================
-- 2. OPTIMIZED Stored Procedure
-- This is the modified version of [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups].
-- It uses a temporary table and CROSS APPLY with the new TVF to eliminate the cursor.
-- =================================================================================================================
CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Get the basic info for all mobile units into a temp table.
    -- Using a temp table (#) is generally better for larger datasets than a table variable (@).
    CREATE TABLE #BasicInfo
    (
        MobileUnitId BIGINT PRIMARY KEY,
        AssetId BIGINT,
        ConfigurationGroupId BIGINT,
        ConfigurationGroupKey INT,
        MobileDeviceKey INT,
        MobileUnitKey INT,
        ConfigurationStatusId INT,
        ConfigurationStatus NVARCHAR(50),
        ConfigurationStatusDate DATETIME,
        LegacyOrgId INT,
        LegacyVehicleId INT,
        [UniqueIdentifier] NVARCHAR(250),
        Serialnumber NVARCHAR(250),
        StreamaxSerialNumber NVARCHAR(250),
        ConfigurationGenerationNotes NVARCHAR(MAX),
        ConfigurationGenerationWarning NVARCHAR(MAX),
        LibraryKey INT,
        EventTemplateKey INT,
        LocationTemplateKey INT,
        MobileDeviceTemplateKey INT
    );

    INSERT INTO #BasicInfo
    EXEC [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] @configGroupIds;

    -- Step 2: Combine results using APPLY for all functions and joins.
    -- The cursor is replaced by CROSS APPLYing the new TVF.
    SELECT
        -- Alert Code Construction:
        -- Alert 1 & 2: From MobileUnit_GetMobileUnitMessageAlerts
        -- Alert 3: From the new Firmware TVF
        -- Alert 4: Hardcoded to 0 as the original SP logic was commented out.
        Alerts = CONCAT(
                    ISNULL(msgAlerts.MessageAlertCode, '00'),
                    CAST(ISNULL(fw.IsFirmwareOutdated, 0) AS CHAR(1)),
                    '0' -- IsMissingParameters is hardcoded to 0
                 ),
        bi.MobileUnitId,
        bi.Serialnumber,
        bi.ConfigurationGroupId,
        NULL as CommsLog, -- This was NULL in the original query
        CAST(lastMsg.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc,
        fw.InstalledFirmwareName AS FWVersion,
        fw.PreferredFirmwareName AS PreferredFWVersion
    FROM #BasicInfo bi
    -- Apply the new firmware function for each mobile unit
    CROSS APPLY [state].[MobileUnit_GetUnitFirmwareInfoTVF](bi.MobileUnitId, bi.MobileUnitKey, bi.MobileDeviceKey, bi.LibraryKey, bi.MobileDeviceTemplateKey) AS fw
    -- Apply the existing message alert function
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](bi.MobileUnitId) AS msgAlerts
    -- Use OUTER APPLY for the last message date as it might not exist
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageDate](bi.MobileUnitId) AS lastMsg;

    -- Clean up the temp table
    DROP TABLE #BasicInfo;

END;
GO
