-- Optimized SQL Script for Alerts Processing
-- Combines the best optimizations from both versions for maximum performance

USE [DeviceConfiguration.DataProcessing];
SET NOCOUNT ON;

-- Input Configuration Group IDs - Modify these as needed
DECLARE @configGroupIds [dbo].[SelectionIds];
INSERT INTO @configGroupIds
VALUES
    (-4706039627829598783), (199325999668202366), (-8457480704780512749), (2677576181771254477),
    (2823596733503101975), (1538687544172856721), (-4229490949371290982), (-2384730484822060182),
    (7440653181116775134), (8283011099424745956), (6270824666272621435), (-8949632091574047260),
    (-8207503568458137854), (-1215659196319016695), (6152593781035096689), (2974831301785092008),
    (3962657782447665558), (-3546122059729481997), (5567431191665092749), (-5883907305683060856),
    (461085753557650606), (3502599370431462499), (-7369294648932782097), (-8787908773382047661),
    (7287834424358043214), (3977693385065534239), (3545130468931642729), (75472660843825717),
    (-6236293196728745404), (-2473474416939851345), (-4815071576473298740), (-2317285672350580067),
    (3504428657675998019), (4462868102626601662), (3052323964734261303), (2610836696632034535),
    (3273233624147396660), (-8388558004121944370), (5295170289666896775), (7909417651692360436),
    (-7590346313175141016), (6277877287032876699), (-576980630916973063);

-- OPTIMIZED APPROACH: Use single temp table with clustered primary key for all operations
CREATE TABLE #UnitResults (
    MobileUnitId BIGINT PRIMARY KEY CLUSTERED,
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
    -- Firmware columns
    InstalledFirmwareName NVARCHAR(50),
    PreferredFirmwareName NVARCHAR(50),
    PreferredFirmwareVersionId BIGINT,
    FirmwareType INT,
    IsFirmwareOutdated BIT DEFAULT 0,
    -- Alert columns
    IsMissingParameters BIT DEFAULT 0,
    MessageAlertCode NVARCHAR(2) DEFAULT '00',
    LastMessageStatusDateUtc DATETIME
);

-- Declare variables for constants (better performance than CTEs across multiple statements)
DECLARE @UNIT_IMEI BIGINT = 9188780602356317147;
DECLARE @SERIAL_NUMBER BIGINT = -6167220489794283114;
DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;
DECLARE @PreferedFirmwareVersionPropId BIGINT = 4015466679217121645;
DECLARE @FM3xBASDDR INT = 2;
DECLARE @FMCANDDMs INT = 3;
DECLARE @FM3XXX_MOBILE_DEVICE_RANGE BIGINT = 6773205951411395052;
DECLARE @MSG_SENDCONFIG INT = 254;
DECLARE @MSG_SENDFIRMWARE INT = 103;
DECLARE @MSG_SENDSETTINGS INT = 255;

-- Get property keys
DECLARE @PropIMEIKey INT = (SELECT TOP 1 PropertyKey FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @UNIT_IMEI);
DECLARE @PropStreamaxKey INT = (SELECT TOP 1 PropertyKey FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @StreamaxSerialNumber);
DECLARE @FWVersionPropKey INT = (SELECT TOP 1 PropertyKey FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @PreferedFirmwareVersionPropId);
-- Single comprehensive INSERT for all basic unit information
INSERT INTO #UnitResults (
    MobileUnitId, AssetId, ConfigurationGroupId, ConfigurationGroupKey, MobileDeviceKey, MobileUnitKey,
    ConfigurationStatusId, ConfigurationStatus, ConfigurationStatusDate, LegacyOrgId, LegacyVehicleId,
    [UniqueIdentifier], Serialnumber, StreamaxSerialNumber, ConfigurationGenerationNotes, ConfigurationGenerationWarning,
    LibraryKey, EventTemplateKey, LocationTemplateKey, MobileDeviceTemplateKey
)
SELECT
    mu.MobileUnitId,
    amu.AssetId,
    tcg.ConfigurationGroupId,
    tcg.ConfigurationGroupKey,
    mu.MobileDeviceKey,
    mu.MobileUnitKey,
    mu.[ConfigurationStatus] AS ConfigurationStatusId,
    cs.[Description] AS ConfigurationStatus,
    mu.DateUpdated AS ConfigurationStatusDate,
    amu.LegacyOrgId,
    amu.LegacyVehicleId,
    [UniqueIdentifier] = CASE WHEN mu.UniqueIdentifier IS NULL THEN mup.Value ELSE mu.UniqueIdentifier END,
    mus.Value AS Serialnumber,
    StreamaxSerialNumber = COALESCE(mus2.Value, mup2.Value),
    mu.ConfigurationGenerationNotes,
    mu.ConfigurationGenerationWarning,
    tcg.LibraryKey,
    tcg.EventTemplateKey,
    tcg.LocationTemplateKey,
    tcg.MobileDeviceTemplateKey
FROM @configGroupIds cg
INNER JOIN [DeviceConfiguration].[template].[ConfigurationGroups] tcg WITH (NOLOCK)
    ON tcg.ConfigurationGroupId = cg.id
INNER JOIN [DeviceConfiguration].[mobileunit].[MobileUnits] mu WITH (NOLOCK)
    ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
INNER JOIN [DeviceConfiguration].[mobileunit].[AssetMobileUnits] amu WITH (NOLOCK)
    ON mu.MobileUnitKey = amu.MobileUnitKey
INNER JOIN [DeviceConfiguration].[definition].[ConfigurationStatuses] cs WITH (NOLOCK)
    ON cs.[ConfigurationStatus] = mu.[ConfigurationStatus]
LEFT JOIN [DeviceConfiguration].[mobileunit].[MobileUnitProperties] mup WITH (NOLOCK)
    ON mu.[MobileUnitKey] = mup.[MobileUnitKey] AND mup.[PropertyKey] = @PropIMEIKey
LEFT JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] mus WITH (NOLOCK)
    ON mus.[MobileUnitId] = mu.[MobileUnitId] AND mus.[PropertyId] = @SERIAL_NUMBER
LEFT JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] mus2 WITH (NOLOCK)
    ON mus2.[MobileUnitId] = mu.[MobileUnitId] AND mus2.[PropertyId] = @StreamaxSerialNumber
LEFT JOIN [DeviceConfiguration].[mobileunit].[MobileUnitProperties] mup2 WITH (NOLOCK)
    ON mu.[MobileUnitKey] = mup2.[MobileUnitKey] AND mup2.[PropertyKey] = @PropStreamaxKey;

-- OPTIMIZED FIRMWARE PROCESSING: Set-based approach with minimal temp tables

-- Step 1: Get installed firmware names
WITH InstalledFW AS (
    SELECT
        mus.MobileUnitId,
        mus.[Value] AS InstalledFirmwareName
    FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] mus WITH (NOLOCK)
    INNER JOIN #UnitResults ur ON ur.MobileUnitId = mus.MobileUnitId
    WHERE mus.[PropertyId] = @FIRMWARE_VERSION
)
UPDATE ur
SET InstalledFirmwareName = ifw.InstalledFirmwareName
FROM #UnitResults ur
INNER JOIN InstalledFW ifw ON ur.MobileUnitId = ifw.MobileUnitId;

-- Step 2: Get preferred firmware with optimized CTEs
WITH TemplateFW AS (
    SELECT 
        ur.MobileUnitId,
        ur.MobileUnitKey, 
        ur.LibraryKey, 
        ur.MobileDeviceTemplateKey, 
        ur.MobileDeviceKey, 
        tdpr.TemplateDevicePropertyKey,
        TRY_CAST(tdpr.[Value] AS BIGINT) AS TemplateFirmwareVersionId
    FROM #UnitResults ur
    INNER JOIN [DeviceConfiguration].[template].[MobileDeviceTemplates] tmdt WITH (NOLOCK)
        ON tmdt.MobileDeviceTemplateKey = ur.MobileDeviceTemplateKey 
        AND tmdt.LibraryKey = ur.LibraryKey 
        AND tmdt.MobileDeviceKey = ur.MobileDeviceKey
    INNER JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK)
        ON ddd.ParentDeviceKey = tmdt.MobileDeviceKey
    INNER JOIN [DeviceConfiguration].[template].[DeviceProperties] tdpr WITH (NOLOCK)
        ON tdpr.DeviceKey = ddd.ChildDeviceKey 
        AND tdpr.PropertyKey = @FWVersionPropKey
        AND tdpr.LibraryKey = ur.LibraryKey
        AND tdpr.MobileDeviceTemplateKey = ur.MobileDeviceTemplateKey
    WHERE tdpr.Value IS NOT NULL
),
OverrideFW AS (
    SELECT 
        muodp.MobileUnitKey,
        muodp.TemplateDevicePropertyKey,
        TRY_CAST(muodp.[Value] AS BIGINT) AS OverriddenFirmwareVersionId
    FROM [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties] muodp WITH (NOLOCK)
    WHERE muodp.Value IS NOT NULL
),
PreferredFW AS (
    SELECT
        tfw.MobileUnitId,
        COALESCE(ofw.OverriddenFirmwareVersionId, tfw.TemplateFirmwareVersionId) AS PreferredFirmwareVersionId,
        tfw.LibraryKey
    FROM TemplateFW tfw
    LEFT JOIN OverrideFW ofw ON tfw.TemplateDevicePropertyKey = ofw.TemplateDevicePropertyKey
                        AND ofw.MobileUnitKey = tfw.MobileUnitKey
),
PreferredFWDetails AS (
    SELECT 
        pfw.MobileUnitId,
        pfw.PreferredFirmwareVersionId,
        dfw.Name AS PreferredFirmwareName,
        dfw.FirmwareType
    FROM PreferredFW pfw
    INNER JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK)
        ON pfw.PreferredFirmwareVersionId = dfw.FirmwareVersionId
    INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw WITH (NOLOCK)
        ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey 
        AND lfw.LibraryKey = pfw.LibraryKey
)
UPDATE ur
SET 
    PreferredFirmwareName = pfd.PreferredFirmwareName,
    PreferredFirmwareVersionId = pfd.PreferredFirmwareVersionId, 
    FirmwareType = pfd.FirmwareType
FROM #UnitResults ur
INNER JOIN PreferredFWDetails pfd ON ur.MobileUnitId = pfd.MobileUnitId;

-- Step 3: Set-based firmware outdated calculation
WITH FilterFlags AS (
    SELECT 
        ur.MobileUnitId,
        ur.PreferredFirmwareVersionId,
        ur.FirmwareType,
        ur.LibraryKey,
        ur.MobileDeviceKey,
        -- Check if FMBas Device
        IsFMBasDevice = CASE WHEN EXISTS (
            SELECT 1 FROM [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK)
            INNER JOIN [DeviceConfiguration].[definition].[Devices] ddParent WITH (NOLOCK) ON ddParent.DeviceKey = ddd.ParentDeviceKey
            WHERE ddd.ChildDeviceKey = ur.MobileDeviceKey AND ddParent.DeviceId = @FM3XXX_MOBILE_DEVICE_RANGE
        ) THEN 1 ELSE 0 END,
        -- Check if CAN Incompatible
        IsCanBasIncompatible = CASE WHEN ur.FirmwareType = @FMCANDDMs AND EXISTS (
             SELECT 1 FROM [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK)
             WHERE dd.DeviceKey = ur.MobileDeviceKey
               AND dd.DeviceId IN (873035855993834515, -9096330589235079600, -1840564510281932398, -4778860267039095909, -5858009722316757743, 4650434075306181696, -7990768985497297820, 3527221626955903837, -2584440882719714179, 6009028139816724904, -8283040575705223110, -2638857266241007532, 6710364014173584261, -90599922128129323, -2135111653303591150, -5604407714490286122)
        ) THEN 1 ELSE 0 END
    FROM #UnitResults ur
    WHERE ur.PreferredFirmwareName IS NOT NULL AND ur.InstalledFirmwareName IS NOT NULL
      AND ur.PreferredFirmwareVersionId IS NOT NULL AND ur.FirmwareType IS NOT NULL
),
FilteredVersions AS (
    SELECT
        ff.MobileUnitId,
        dfw.FirmwareVersionId,
        dfw.Name,
        ROW_NUMBER() OVER (PARTITION BY ff.MobileUnitId ORDER BY dfw.Name) AS VersionNumber 
    FROM FilterFlags ff
    INNER JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK) ON dfw.FirmwareType = ff.FirmwareType
    INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw WITH (NOLOCK) ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey AND lfw.LibraryKey = ff.LibraryKey
    WHERE 
        NOT (ff.IsCanBasIncompatible = 1 AND ff.FirmwareType = @FMCANDDMs AND dfw.Name LIKE 'E%')
        AND NOT (ff.FirmwareType = @FM3xBASDDR AND ff.IsFMBasDevice = 0)
),
VersionRanked AS (
    SELECT
        fv.MobileUnitId,
        PreferredVersionNumber = fv.VersionNumber,
        LatestVersionNumber = MAX(fv.VersionNumber) OVER (PARTITION BY fv.MobileUnitId)
    FROM FilteredVersions fv
    INNER JOIN #UnitResults ur ON ur.MobileUnitId = fv.MobileUnitId
    WHERE fv.FirmwareVersionId = ur.PreferredFirmwareVersionId
)
UPDATE ur
SET IsFirmwareOutdated = 1
FROM #UnitResults ur
INNER JOIN VersionRanked vr ON ur.MobileUnitId = vr.MobileUnitId
WHERE (vr.LatestVersionNumber - vr.PreferredVersionNumber) > 2;

-- OPTIMIZED MESSAGE ALERT PROCESSING
WITH KnownGoodStatuses AS (
    SELECT StatusId = 10 UNION ALL SELECT StatusId = 12 UNION ALL SELECT StatusId = 13 UNION ALL SELECT StatusId = 25 UNION ALL SELECT StatusId = 28
),
RankedMessages AS (
    SELECT
        mum.MobileUnitId,
        mum.MessageSubType,
        mum.CreationDateUtc,
        mum.MessageStatus,
        ROW_NUMBER() OVER (PARTITION BY mum.MobileUnitId, mum.MessageSubType ORDER BY mum.CreationDateUtc DESC) as RowNum
    FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum WITH (NOLOCK)
    INNER JOIN #UnitResults ur ON ur.MobileUnitId = mum.MobileUnitId
    WHERE mum.MessageSubType IN (@MSG_SENDCONFIG, @MSG_SENDFIRMWARE, @MSG_SENDSETTINGS)
),
LatestMessageStatus AS (
    SELECT
        rm.MobileUnitId,
        rm.MessageSubType,
        rm.CreationDateUtc,
        rm.MessageStatus
    FROM RankedMessages rm
    WHERE rm.RowNum = 1
),
MessageAlerts AS (
    SELECT
        lms.MobileUnitId,
        IsConfigOrSettingAlert = MAX(CASE
                                        WHEN lms.MessageSubType IN (@MSG_SENDCONFIG, @MSG_SENDSETTINGS) 
                                            AND lms.CreationDateUtc < DATEADD(day, -5, GETUTCDATE()) 
                                            AND kgs.StatusId IS NULL
                                        THEN 1 ELSE 0 END),
        IsFirmwareAlert = MAX(CASE
                                WHEN lms.MessageSubType = @MSG_SENDFIRMWARE
                                    AND lms.CreationDateUtc < DATEADD(day, -3, GETUTCDATE()) 
                                    AND kgs.StatusId IS NULL
                                THEN 1 ELSE 0 END)
    FROM LatestMessageStatus lms
    LEFT JOIN KnownGoodStatuses kgs ON lms.MessageStatus = kgs.StatusId
    GROUP BY lms.MobileUnitId
)
UPDATE ur
SET MessageAlertCode = CONCAT(
                            CAST(ma.IsConfigOrSettingAlert AS CHAR(1)),
                            CAST(ma.IsFirmwareAlert AS CHAR(1))
                        )
FROM #UnitResults ur
INNER JOIN MessageAlerts ma ON ur.MobileUnitId = ma.MobileUnitId;

-- OPTIMIZED LAST MESSAGE DATE
WITH LastMessage AS (
    SELECT
        mum.MobileUnitId,
        mum.MessageStatusDateUtc,
        ROW_NUMBER() OVER (PARTITION BY mum.MobileUnitId ORDER BY mum.MessageStatusDateUtc DESC) as rn
    FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum WITH (NOLOCK)
    INNER JOIN #UnitResults ur ON ur.MobileUnitId = mum.MobileUnitId
    WHERE mum.MessageSubType IN (@MSG_SENDCONFIG, @MSG_SENDFIRMWARE, @MSG_SENDSETTINGS)
)
UPDATE ur
SET LastMessageStatusDateUtc = lm.MessageStatusDateUtc
FROM #UnitResults ur
INNER JOIN LastMessage lm ON ur.MobileUnitId = lm.MobileUnitId AND lm.rn = 1;

-- OPTIMIZED MISSING PARAMETERS CHECK (simplified version)
WITH EventParameters AS (
    SELECT DISTINCT
        ur.MobileUnitId,
        le.EventKey,
        dp.ParameterId,
        ISNULL(asp.ParameterId, 0) AS IsSupported
    FROM #UnitResults ur
    INNER JOIN [DeviceConfiguration].[template].[EventTemplates] tet WITH (NOLOCK)
        ON tet.EventTemplateId = (SELECT EventTemplateId FROM #UnitResults WHERE MobileUnitId = ur.MobileUnitId) 
        AND tet.LibraryKey = ur.LibraryKey
    INNER JOIN [DeviceConfiguration].[template].[Events] te WITH (NOLOCK)
        ON te.EventTemplateKey = tet.EventTemplateKey AND te.LibraryKey = tet.LibraryKey
    INNER JOIN [DeviceConfiguration].[definition].[Events] de WITH (NOLOCK)
        ON de.EventKey = te.EventKey
    INNER JOIN [DeviceConfiguration].[library].[Events] le WITH (NOLOCK)
        ON le.EventKey = de.EventKey AND le.LibraryKey = ur.LibraryKey
    LEFT JOIN [DeviceConfiguration].[template].[EventConditions] tec WITH (NOLOCK)
        ON tec.LibraryKey = ur.LibraryKey AND tec.EventTemplateKey = te.EventTemplateKey AND tec.EventKey = te.EventKey
    LEFT JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK)
        ON dp.ParameterKey = tec.ParameterKey
    LEFT JOIN (
        SELECT DISTINCT dd.DeviceId, dp.ParameterId
        FROM [DeviceConfiguration].[definition].[DeviceParameters] ddp
        INNER JOIN [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK) ON dd.DeviceKey = ddp.DeviceKey
        INNER JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK) ON dp.ParameterKey = ddp.ParameterKey
        INNER JOIN [DeviceConfiguration].[library].[Parameters] lp WITH (NOLOCK) ON lp.ParameterKey = dp.ParameterKey
        INNER JOIN [DeviceConfiguration].[library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dd.DeviceKey AND ld.LibraryKey = lp.LibraryKey
    ) asp ON asp.ParameterId = dp.ParameterId
    WHERE de.EventType != 0 AND tec.IsRequired = 1
),
MissingParamCheck AS (
    SELECT 
        MobileUnitId,
        HasMissingParams = CASE WHEN COUNT(CASE WHEN IsSupported = 0 THEN 1 END) > 0 THEN 1 ELSE 0 END
    FROM EventParameters
    GROUP BY MobileUnitId
)
UPDATE ur
SET IsMissingParameters = mp.HasMissingParams
FROM #UnitResults ur
INNER JOIN MissingParamCheck mp ON ur.MobileUnitId = mp.MobileUnitId;

-- FINAL OPTIMIZED RESULT SET
SELECT
    Alerts = CONCAT(
                ISNULL(ur.MessageAlertCode, '00'),
                CAST(ISNULL(ur.IsFirmwareOutdated, 0) AS CHAR(1)),
                CAST(ISNULL(ur.IsMissingParameters, 0) AS CHAR(1))
             ),
    ur.MobileUnitId,
    ur.Serialnumber,
    ur.ConfigurationGroupId,
    NULL AS CommsLog,
    ur.LastMessageStatusDateUtc AS MessageStatusDateUtc,
    ur.InstalledFirmwareName AS FWVersion,
    ur.PreferredFirmwareName AS PreferredFWVersion
FROM #UnitResults ur
ORDER BY ur.MobileUnitId;

-- Clean up
DROP TABLE #UnitResults;