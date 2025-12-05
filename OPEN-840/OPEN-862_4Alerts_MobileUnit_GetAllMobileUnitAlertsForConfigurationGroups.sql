CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_4Alerts]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- Create temp table to hold stored proc results
    DECLARE @BasicInfo TABLE
    (
        MobileUnitId BIGINT,
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
    -- Get the basic info
    INSERT INTO @BasicInfo
    EXEC [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] @configGroupIds;


    -- Basic information
    CREATE TABLE #UnitResults
    (
        MobileUnitId BIGINT,
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
        MobileDeviceTemplateKey INT,
        InstalledFirmwareName NVARCHAR(50),
        PreferredFirmwareName NVARCHAR(50),
        IsFirmwareOutdated BIT,
        IsMissingParameters BIT
    );

    -- Insert into final results with defaults for extra columns
    INSERT INTO #UnitResults
    SELECT 
        bi.*,
        CAST(NULL AS NVARCHAR(50)) AS InstalledFirmwareName,
        CAST(NULL AS NVARCHAR(50)) AS PreferredFirmwareName,
        CAST(0 AS BIT) AS IsFirmwareOutdated,
        CAST(0 AS BIT) AS IsMissingParameters
    FROM @BasicInfo bi;

    -- Add an index for faster updates/joins if dealing with many units
    CREATE CLUSTERED INDEX IX_UnitResults_MobileUnitId ON #UnitResults (MobileUnitId);

    -- Iterate to call the Firmware SP to populate results
    DECLARE @CurrentMobileUnitId BIGINT;
    DECLARE @CurrentMobileUnitKey INT;
    DECLARE @CurrentMobileDeviceKey INT;
    DECLARE @CurrentLibraryKey INT;
    DECLARE @CurrentMobileDeviceTemplateKey INT;

    DECLARE @InstalledFWName NVARCHAR(50);
    DECLARE @PreferredFWName NVARCHAR(50);
    DECLARE @IsFWOutdated BIT;
    DECLARE @IsMissingParams BIT;

    -- Using a cursor to call the SPs for each row
    DECLARE unit_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT MobileUnitId, MobileUnitKey, MobileDeviceKey, LibraryKey, MobileDeviceTemplateKey
        FROM #UnitResults;

    OPEN unit_cursor;
    FETCH NEXT FROM unit_cursor INTO @CurrentMobileUnitId, @CurrentMobileUnitKey, @CurrentMobileDeviceKey, @CurrentLibraryKey, @CurrentMobileDeviceTemplateKey;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Reset output params for safety
        SET @InstalledFWName = NULL; SET @PreferredFWName = NULL; SET @IsFWOutdated = 0;
        SET @IsMissingParams = 0;

        -- Execute the Firmware SP for the current unit
        EXEC [state].[MobileUnit_GetMobileUnitFirmwareInfo]
            @MobileUnitId = @CurrentMobileUnitId,
            @MobileUnitKey = @CurrentMobileUnitKey,
            @MobileDeviceKey = @CurrentMobileDeviceKey,
            @LibraryKey = @CurrentLibraryKey,
            @MobileDeviceTemplateKey = @CurrentMobileDeviceTemplateKey,
            @InstalledFirmwareName = @InstalledFWName OUTPUT,
            @PreferredFirmwareName = @PreferredFWName OUTPUT,
            @IsFirmwareOutdated = @IsFWOutdated OUTPUT;

        -- Execute the Missing Parameters SP for the current unit
        EXEC [state].[MobileUnit_GetMobileUnitMissingParameters]
            @MobileUnitId = @CurrentMobileUnitId,
            @IsMissingParameters = @IsMissingParams OUTPUT;

        -- Update the temp table with the results from both SPs
        UPDATE #UnitResults
        SET InstalledFirmwareName = @InstalledFWName,
            PreferredFirmwareName = @PreferredFWName,
            IsFirmwareOutdated = @IsFWOutdated,
            IsMissingParameters = @IsMissingParams
        WHERE MobileUnitId = @CurrentMobileUnitId;

        FETCH NEXT FROM unit_cursor INTO @CurrentMobileUnitId, @CurrentMobileUnitKey, @CurrentMobileDeviceKey, @CurrentLibraryKey, @CurrentMobileDeviceTemplateKey;
    END

    CLOSE unit_cursor;
    DEALLOCATE unit_cursor;

    -- Combine results using APPLY for iTVFs and join with the updated temp table
    SELECT
        Alerts = CONCAT(
                    ISNULL(msgAlerts.MessageAlertCode, '00'),           -- Alert 1 & 2
                    CAST(ISNULL(ur.IsFirmwareOutdated, 0) AS CHAR(1)),  -- Alert 3
                    CAST(ISNULL(ur.IsMissingParameters, 0) AS CHAR(1))  -- Alert 4
                 ),
        ur.MobileUnitId,
        ur.Serialnumber,
        ur.ConfigurationGroupId,
        NULL as CommsLog,
        CAST(LastMsgDate.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc, 
        ur.InstalledFirmwareName AS FWVersion,
        ur.PreferredFirmwareName AS PreferredFWVersion
    FROM #UnitResults ur
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](ur.MobileUnitId) AS msgAlerts
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageDate](ur.MobileUnitId) AS LastMsgDate;

    -- Clean up temp table
    DROP TABLE #UnitResults;

END;
GO
