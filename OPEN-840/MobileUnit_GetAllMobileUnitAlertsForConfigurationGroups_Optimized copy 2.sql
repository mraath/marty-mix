CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- CONSTANTS
    DECLARE @UNIT_IMEI BIGINT = CAST(9188780602356317147 AS BIGINT);
    DECLARE @SERIAL_NUMBER BIGINT = CAST(-6167220489794283114 AS BIGINT);
    DECLARE @STREAMAX_SERIAL_NUMBER BIGINT = CAST(-4477362625925416557 AS BIGINT);
    DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;
    DECLARE @PREFERED_FIRMWARE_VERSION_PROP_ID BIGINT = 4015466679217121645;
	
    -- DEVICE DRIVER TYPES
    DECLARE @FM3xBASDDR INT = 2;
    DECLARE @FMCANDDMs INT = 3;

    -- BASE DEVICES
    DECLARE @FM3XXX_MOBILE_DEVICE_RANGE BIGINT = 6773205951411395052;

    -- SPECIFIC DEVICE VERSIONS (for CAN incompatibility)
    DECLARE @FM3316i BIGINT = 873035855993834515;
    DECLARE @FM33x6 BIGINT = -9096330589235079600;
    DECLARE @FM2000 BIGINT = -1840564510281932398;
    DECLARE @FM2000_HV BIGINT = -4778860267039095909;
    DECLARE @FM2001 BIGINT = -5858009722316757743;
    DECLARE @FM2100 BIGINT = 4650434075306181696;
    DECLARE @FM2100_HV BIGINT = -7990768985497297820;
    DECLARE @FM2300 BIGINT = 352722162955903837;
    DECLARE @FM2300_HV BIGINT = -2584440882719714179;
    DECLARE @FM3106 BIGINT = 6009028139816724904;
    DECLARE @FM32x0 BIGINT = -8283040575705223110;
    DECLARE @FM32x1 BIGINT = -2638857266241007532;
    DECLARE @FM33x0 BIGINT = 6710364014173584261;
    DECLARE @FM33x1 BIGINT = -90599922128129323;
    DECLARE @FM33x5 BIGINT = -2135111653303591150;
    DECLARE @FM_Tracer BIGINT = -5604407714490286122;

    -- Get property keys once
    DECLARE @PropIMEIKey INT = (SELECT TOP 1 [PropertyKey] FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @UNIT_IMEI);
    DECLARE @PropFirmwareKey INT = (SELECT TOP 1 PropertyKey FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @PREFERED_FIRMWARE_VERSION_PROP_ID);

    -- Start of CTEs
    WITH MobileUnitBaseInfo AS (
        SELECT
            mu.MobileUnitId, amu.AssetId, tcg.ConfigurationGroupId, tcg.ConfigurationGroupKey,
            mu.MobileDeviceKey, mu.MobileUnitKey,
            tcg.LibraryKey, tcg.MobileDeviceTemplateKey
        FROM @configGroupIds cgids
        INNER JOIN [DeviceConfiguration].[template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cgids.id
        INNER JOIN [DeviceConfiguration].[mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
        INNER JOIN [DeviceConfiguration].[mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON mu.MobileUnitKey = amu.MobileUnitKey
    ),
    -- CTE to deterministically select a single preferred firmware for each mobile unit
    PreferredFirmware AS (
        SELECT MobileUnitId, PreferredFirmwareVersionId, Name AS PreferredFirmwareName, FirmwareType AS PreferredFirmwareType
        FROM (
            SELECT
                mubi.MobileUnitId,
                dfv.FirmwareVersionId,
                dfv.Name,
                dfv.FirmwareType,
                ROW_NUMBER() OVER(PARTITION BY mubi.MobileUnitId ORDER BY CASE WHEN odp.Value IS NOT NULL THEN 0 ELSE 1 END, ISNULL(odp.DateUpdated, tdp.DateUpdated) DESC) as rn
            FROM MobileUnitBaseInfo mubi
            INNER JOIN [DeviceConfiguration].[template].[DeviceProperties] tdp ON tdp.LibraryKey = mubi.LibraryKey AND tdp.MobileDeviceTemplateKey = mubi.MobileDeviceTemplateKey
            INNER JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd ON ddd.ParentDeviceKey = mubi.MobileDeviceKey AND tdp.DeviceKey = ddd.ChildDeviceKey
            LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties] odp ON tdp.TemplateDevicePropertyKey = odp.TemplateDevicePropertyKey AND odp.MobileUnitKey = mubi.MobileUnitKey
            INNER JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfv ON (CASE WHEN ISNUMERIC(odp.Value) = 1 THEN CAST(odp.Value AS BIGINT) WHEN ISNUMERIC(tdp.Value) = 1 THEN CAST(tdp.Value AS BIGINT) ELSE NULL END) = dfv.FirmwareVersionId
            WHERE tdp.PropertyKey = @PropFirmwareKey
        ) AS PrefFw
        WHERE rn = 1
    ),
    -- Pre-calculate version numbers for all firmware
    FirmwareVersionNumbers AS (
        SELECT dfv.FirmwareVersionId, lfv.LibraryKey, dfv.FirmwareType, ROW_NUMBER() OVER (PARTITION BY dfv.FirmwareType, lfv.LibraryKey ORDER BY dfv.Name) AS VersionNumber
        FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfv
        INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfv ON dfv.FirmwareVersionKey = lfv.FirmwareVersionKey
    ),
    -- Pre-calculate the latest version number for each firmware type in each library
    LatestFirmwareVersions AS (
        SELECT LibraryKey, FirmwareType, MAX(VersionNumber) AS LatestVersionNumber
        FROM FirmwareVersionNumbers
        GROUP BY LibraryKey, FirmwareType
    ),
    -- All final calculations are done here
    FinalCalculations AS (
        SELECT
            mubi.MobileUnitId,
            inst_fw.Value AS InstalledFirmwareName,
            pf.PreferredFirmwareName,
            CASE WHEN NULLIF(inst_fw.Value, '') IS NULL THEN '' ELSE LEFT(STUFF((SELECT RIGHT(REPLICATE('0',3) + val,3) FROM (SELECT value AS val FROM STRING_SPLIT(inst_fw.Value, '.')) AS s FOR XML PATH('')), 1, 0, ''), 15) END AS InstalledFirmwareAlpha,
            CASE WHEN NULLIF(pf.PreferredFirmwareName, '') IS NULL THEN '' ELSE LEFT(STUFF((SELECT RIGHT(REPLICATE('0',3) + val,3) FROM (SELECT value AS val FROM STRING_SPLIT(pf.PreferredFirmwareName, '.')) AS s FOR XML PATH('')), 1, 0, ''), 15) END AS PreferredFirmwareAlpha,
            CASE
                WHEN pf.PreferredFirmwareVersionId IS NULL THEN 0
                WHEN EXISTS (
                    SELECT 1 FROM [DeviceConfiguration].[definition].[DeviceDependencies] dd_fmbas
                    INNER JOIN [DeviceConfiguration].[definition].[Devices] dd_parent ON dd_parent.DeviceKey = dd_fmbas.ParentDeviceKey
                    WHERE dd_fmbas.ChildDeviceKey = mubi.MobileDeviceKey AND dd_parent.DeviceId = @FM3XXX_MOBILE_DEVICE_RANGE AND pf.PreferredFirmwareType = @FM3xBASDDR
                ) THEN 0
                WHEN pf.PreferredFirmwareType = @FMCANDDMs AND EXISTS (
                    SELECT 1 FROM [DeviceConfiguration].[definition].[Devices] dd
                    WHERE dd.DeviceKey = mubi.MobileDeviceKey AND dd.DeviceId IN (@FM3316i, @FM33x6, @FM2000, @FM2000_HV, @FM2001, @FM2100, @FM2100_HV, @FM2300, @FM2300_HV, @FM3106, @FM32x0, @FM32x1, @FM33x0, @FM33x1, @FM33x5, @FM_Tracer)
                ) AND pf.PreferredFirmwareName LIKE 'E%' THEN 0
                ELSE ISNULL(CASE WHEN (lfv.LatestVersionNumber - fvn.VersionNumber) > 2 THEN 1 ELSE 0 END, 0)
            END AS IsFirmwareOutdated
        FROM MobileUnitBaseInfo mubi
        LEFT JOIN PreferredFirmware pf ON mubi.MobileUnitId = pf.MobileUnitId
        LEFT JOIN [state].[MobileUnitState] inst_fw ON mubi.MobileUnitId = inst_fw.MobileUnitId AND inst_fw.PropertyId = @FIRMWARE_VERSION
        LEFT JOIN FirmwareVersionNumbers fvn ON pf.PreferredFirmwareVersionId = fvn.FirmwareVersionId AND mubi.LibraryKey = fvn.LibraryKey
        LEFT JOIN LatestFirmwareVersions lfv ON mubi.LibraryKey = lfv.LibraryKey AND pf.PreferredFirmwareType = lfv.FirmwareType
    ),
	MessageAlerts AS (
        SELECT 
            mubi.MobileUnitId,
            CONCAT(
                ISNULL(MAX(CASE WHEN mum.MessageSubType IN (254, 255) AND mum.CreationDateUtc < DATEADD(day, -5, GETUTCDATE()) AND mum.MessageStatus NOT IN (10, 12, 13, 25, 28) THEN '1' ELSE '0' END), '0'),
                ISNULL(MAX(CASE WHEN mum.MessageSubType = 103 AND mum.CreationDateUtc < DATEADD(day, -3, GETUTCDATE()) AND mum.MessageStatus NOT IN (10, 12, 13, 25, 28) THEN '1' ELSE '0' END), '0')
            ) AS MessageAlertCode
        FROM MobileUnitBaseInfo mubi
        LEFT JOIN [state].[MobileUnitMessage] mum WITH (NOLOCK) ON mubi.MobileUnitId = mum.MobileUnitId AND mum.MessageSubType IN (254, 255, 103)
        GROUP BY mubi.MobileUnitId
    )
    SELECT
        Alerts = CONCAT(
            ISNULL(ma.MessageAlertCode, '00'),
            CAST(ISNULL(fc.IsFirmwareOutdated, 0) AS CHAR(1)),
            CAST(0 AS CHAR(1)), -- Missing parameters is disabled
            (CASE WHEN (fc.InstalledFirmwareAlpha < fc.PreferredFirmwareAlpha) AND (fc.InstalledFirmwareAlpha <> '') AND (fc.PreferredFirmwareAlpha) <> '' THEN '1' ELSE '0' END)
        ),
        bi.MobileUnitId,
        s.Value AS Serialnumber,
        bi.ConfigurationGroupId,
        NULL as CommsLog,
        (SELECT MAX(mum.MessageStatusDateUtc) FROM [state].[MobileUnitMessage] mum WHERE mum.MobileUnitId = bi.MobileUnitId AND mum.MessageSubType IN (254, 103, 255)) AS MessageStatusDateUtc,
        fc.InstalledFirmwareName AS FWVersion,
        fc.PreferredFirmwareName AS PreferredFWVersion
    FROM MobileUnitBaseInfo bi
    LEFT JOIN FinalCalculations fc ON bi.MobileUnitId = fc.MobileUnitId
	LEFT JOIN MessageAlerts ma ON bi.MobileUnitId = ma.MobileUnitId
    LEFT JOIN [state].[MobileUnitState] s ON bi.MobileUnitId = s.MobileUnitId AND s.PropertyId = @SERIAL_NUMBER;

END;
GO