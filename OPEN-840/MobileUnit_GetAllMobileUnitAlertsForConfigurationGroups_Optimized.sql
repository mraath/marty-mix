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
    DECLARE @OPEN_BRACKET BIGINT = 981729539706373388;
    DECLARE @CLOSE_BRACKET BIGINT = -8380423587615480304;

    -- DEVICE DRIVER TYPES
    DECLARE @FM200Plus INT = 0;
    DECLARE @FM3xBASDDR INT = 2;
    DECLARE @FMCANDDMs INT = 3;
    DECLARE @FMHOSDBDDM INT = 5;
    DECLARE @FMTerminal INT = 1;
    DECLARE @MiX2310i INT = 6;
    DECLARE @FM3D INT = 7;
    DECLARE @ROVIII INT = 9;
    DECLARE @TABSBEACONFW INT = 10;
    DECLARE @TABSPBSFW INT = 11;
    DECLARE @MiX4000 INT = 15;
    DECLARE @MiX6000 INT = 16;
    DECLARE @MiX2000 INT = 17;
    DECLARE @ROVIIII INT = 18;
    DECLARE @ROVIIV INT = 19;
    DECLARE @MiX6000LTE INT = 20;
    DECLARE @MiX3000 INT = 21;

    -- BASE DEVICES
    DECLARE @FM3XXX_MOBILE_DEVICE_RANGE BIGINT = 6773205951411395052;
    DECLARE @BASE_FM_FUNCTIONALITY BIGINT = -4443154563661222391;
    DECLARE @SCRIPTABLE_CAN_BUS BIGINT = -2374460998933609581;
    DECLARE @HOURS_OF_SERVICE BIGINT = 7622806356726782531;
    DECLARE @SYSTEM_TERMINAL BIGINT = -7786317619852719241;
    DECLARE @MIX3000_FIRMWARE BIGINT = -1056138116899142373;
    DECLARE @MIX4000_FW BIGINT = 4999121101837382283;
    DECLARE @MIX2000_FIRMWARE BIGINT = -6130542022605112303;
    DECLARE @MIX2310_FIRMWARE BIGINT = -6701434148427672311;
    DECLARE @FM3D_FW BIGINT = -6696558636443729452;
    DECLARE @ROVIII_FIRMWARE_PACKAGE BIGINT = -8240710130213624706;
    DECLARE @ROVIIII_FIRMWARE_PACKAGE BIGINT = 7621659214296776294;
    DECLARE @ROVIIV_FIRMWARE_PACKAGE BIGINT = -7704231156642700278;
    DECLARE @TABS_PBS_FIRMWARE BIGINT = 4309165355632585315;
    DECLARE @TABS_BEACON_FIRMWARE BIGINT = 2229325472509295665;
    DECLARE @MIX6000_FIRMWARE BIGINT = 7031964624791253468;
    DECLARE @MIX6000LTE_FIRMWARE BIGINT = -7449984837957825032;

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
    DECLARE @PropIMEIKey INT = (
        SELECT TOP 1 [PropertyKey]
        FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK)
        WHERE dp.PropertyId = @UNIT_IMEI
    );

    DECLARE @PropFirmwareKey INT = (
        SELECT TOP 1 PropertyKey
        FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK)
        WHERE PropertyId = @PREFERED_FIRMWARE_VERSION_PROP_ID
    );

    -- Main CTE to get all mobile units and their basic info
    WITH MobileUnitBaseInfo AS (
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
            CASE WHEN mu.UniqueIdentifier IS NULL THEN mup.Value ELSE mu.UniqueIdentifier END AS [UniqueIdentifier],
            mus.Value AS Serialnumber,
            CASE WHEN (ap.Value IS NULL) THEN mu.UniqueIdentifier ELSE ap.Value END AS StreamaxSerialNumber,
            mu.ConfigurationGenerationNotes,
            mu.ConfigurationGenerationWarning,
            tcg.LibraryKey,
            tcg.EventTemplateKey,
            tcg.LocationTemplateKey,
            tcg.MobileDeviceTemplateKey
        FROM @configGroupIds cgids
        INNER JOIN [DeviceConfiguration].[template].[ConfigurationGroups] tcg WITH (NOLOCK)
            ON tcg.ConfigurationGroupId = cgids.id
        INNER JOIN [DeviceConfiguration].[mobileunit].[MobileUnits] mu WITH (NOLOCK)
            ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
        INNER JOIN [DeviceConfiguration].[mobileunit].[AssetMobileUnits] amu WITH (NOLOCK)
            ON mu.MobileUnitKey = amu.MobileUnitKey
        INNER JOIN [DeviceConfiguration].[definition].[ConfigurationStatuses] cs WITH (NOLOCK)
            ON cs.[ConfigurationStatus] = mu.[ConfigurationStatus]
        LEFT JOIN [DeviceConfiguration].[mobileunit].[MobileUnitProperties] mup WITH (NOLOCK)
            ON mu.[MobileUnitKey] = mup.[MobileUnitKey]
            AND mup.[PropertyKey] = @PropIMEIKey
        LEFT JOIN [state].[MobileUnitState] mus WITH (NOLOCK)
            ON mus.[MobileUnitId] = mu.[MobileUnitId]
            AND mus.[PropertyId] = @SERIAL_NUMBER
        LEFT JOIN [DeviceConfiguration].[mobileunit].[AssetProperties] ap WITH (NOLOCK)
            ON mu.MobileUnitId = ap.AssetId
            AND ap.PropertyId = @STREAMAX_SERIAL_NUMBER
    ),
    -- Get firmware information for all units at once
    FirmwareInfo AS (
        SELECT 
            mubi.MobileUnitId,
            fw_state.Value AS InstalledFirmwareName,
            dfw_installed.FirmwareVersionId AS InstalledFirmwareVersionId,
            COALESCE(ofw.OverriddenFirmwareVersionId, tfw.TemplateFirmwareVersionId) AS PreferredFirmwareVersionId,
            dfw_preferred.Name AS PreferredFirmwareName,
            dfw_preferred.FirmwareType
        FROM MobileUnitBaseInfo mubi
        LEFT JOIN [state].[MobileUnitState] fw_state WITH (NOLOCK)
            ON fw_state.[MobileUnitId] = mubi.MobileUnitId
            AND fw_state.[PropertyId] = @FIRMWARE_VERSION
        LEFT JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw_installed WITH (NOLOCK)
            ON dfw_installed.[Name] = fw_state.Value
        LEFT JOIN [DeviceConfiguration].[template].[MobileDeviceTemplates] tmdt WITH (NOLOCK)
            ON tmdt.MobileDeviceTemplateKey = mubi.MobileDeviceTemplateKey 
            AND tmdt.LibraryKey = mubi.LibraryKey 
            AND tmdt.MobileDeviceKey = mubi.MobileDeviceKey
        LEFT JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK)
            ON ddd.ParentDeviceKey = tmdt.MobileDeviceKey
        LEFT JOIN [DeviceConfiguration].[template].[DeviceProperties] tdpr WITH (NOLOCK)
            ON tdpr.DeviceKey = ddd.ChildDeviceKey
            AND tdpr.PropertyKey = @PropFirmwareKey
            AND tdpr.LibraryKey = mubi.LibraryKey
            AND tdpr.MobileDeviceTemplateKey = mubi.MobileDeviceTemplateKey
        LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties] muodp WITH (NOLOCK)
            ON muodp.TemplateDevicePropertyKey = tdpr.TemplateDevicePropertyKey
            AND muodp.MobileUnitKey = mubi.MobileUnitKey
        CROSS APPLY (
            SELECT CASE 
                WHEN ISNUMERIC(tdpr.[Value]) = 1 THEN CAST(tdpr.[Value] AS BIGINT)
                ELSE NULL 
            END AS TemplateFirmwareVersionId
        ) AS tfw
        CROSS APPLY (
            SELECT CASE 
                WHEN ISNUMERIC(muodp.[Value]) = 1 THEN CAST(muodp.[Value] AS BIGINT)
                ELSE NULL 
            END AS OverriddenFirmwareVersionId
        ) AS ofw
        LEFT JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw_preferred WITH (NOLOCK)
            ON COALESCE(ofw.OverriddenFirmwareVersionId, tfw.TemplateFirmwareVersionId) = dfw_preferred.FirmwareVersionId
    ),
    -- Determine firmware outdated status for all units
    FirmwareOutdatedStatus AS (
        SELECT 
            fi.MobileUnitId,
            fi.InstalledFirmwareName,
            fi.PreferredFirmwareName,
            CASE 
                WHEN fi.PreferredFirmwareVersionId IS NULL OR fi.FirmwareType IS NULL THEN 0
                ELSE (
                    SELECT CASE 
                        WHEN (@LatestVersionNumber - @PreferredVersionNumber) > 2 THEN 1
                        ELSE 0
                    END
                    FROM (
                        SELECT 
                            ROW_NUMBER() OVER (PARTITION BY dfv.FirmwareType, lfv.LibraryKey ORDER BY dfv.Name) AS VersionNumber,
                            dfv.FirmwareVersionId
                        FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfv WITH (NOLOCK)
                        INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfv WITH (NOLOCK)
                            ON dfv.FirmwareVersionKey = lfv.FirmwareVersionKey 
                            AND lfv.LibraryKey = mubi.LibraryKey
                        WHERE dfv.FirmwareType = fi.FirmwareType
                          AND NOT (
                            EXISTS (
                                SELECT 1 FROM [DeviceConfiguration].[definition].[DeviceDependencies] dd_fmbas WITH (NOLOCK)
                                INNER JOIN [DeviceConfiguration].[definition].[Devices] dd_parent WITH (NOLOCK) 
                                    ON dd_parent.DeviceKey = dd_fmbas.ParentDeviceKey
                                WHERE dd_fmbas.ChildDeviceKey = mubi.MobileDeviceKey
                                  AND dd_parent.DeviceId = @FM3XXX_MOBILE_DEVICE_RANGE
                            ) AND fi.FirmwareType = @FM3xBASDDR
                          )
                          AND NOT (
                            fi.FirmwareType = @FMCANDDMs
                            AND EXISTS (
                                SELECT 1 FROM [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK)
                                WHERE dd.DeviceKey = mubi.MobileDeviceKey
                                  AND dd.DeviceId IN (
                                    @FM3316i, @FM33x6, @FM2000, @FM2000_HV, @FM2001, @FM2100, @FM2100_HV,
                                    @FM2300, @FM2300_HV, @FM3106, @FM32x0, @FM32x1, @FM33x0, @FM33x1,
                                    @FM33x5, @FM_Tracer
                                  )
                            )
                            AND dfv.Name LIKE 'E%'
                          )
                    ) AS versioned_fw
                    WHERE versioned_fw.FirmwareVersionId = fi.PreferredFirmwareVersionId
                ) CROSS JOIN (
                    SELECT MAX(VersionNumber) AS LatestVersionNumber
                    FROM (
                        SELECT 
                            ROW_NUMBER() OVER (PARTITION BY dfv.FirmwareType, lfv.LibraryKey ORDER BY dfv.Name) AS VersionNumber,
                            dfv.FirmwareVersionId
                        FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfv WITH (NOLOCK)
                        INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfv WITH (NOLOCK)
                            ON dfv.FirmwareVersionKey = lfv.FirmwareVersionKey 
                            AND lfv.LibraryKey = mubi.LibraryKey
                        WHERE dfv.FirmwareType = fi.FirmwareType
                    ) AS versioned_fw_all
                ) AS latest
                LEFT JOIN MobileUnitBaseInfo mubi ON mubi.MobileUnitId = fi.MobileUnitId
                LEFT JOIN (
                    SELECT ROW_NUMBER() OVER (PARTITION BY dfv.FirmwareType, lfv.LibraryKey ORDER BY dfv.Name) AS VersionNumber, dfv.FirmwareVersionId
                    FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfv WITH (NOLOCK)
                    INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfv WITH (NOLOCK)
                        ON dfv.FirmwareVersionKey = lfv.FirmwareVersionKey 
                        AND lfv.LibraryKey = mubi.LibraryKey
                    WHERE dfv.FirmwareType = fi.FirmwareType
                ) AS pref_fw ON pref_fw.FirmwareVersionId = fi.PreferredFirmwareVersionId
            )
        END AS IsFirmwareOutdated
        FROM FirmwareInfo fi
        LEFT JOIN MobileUnitBaseInfo mubi ON mubi.MobileUnitId = fi.MobileUnitId
    ),
    -- Get message alerts for all units
    MessageAlerts AS (
        SELECT 
            mubi.MobileUnitId,
            CONCAT(
                CAST(ISNULL(
                    CASE 
                        WHEN config_alert.IsConfigOrSettingAlert = 1 THEN '1'
                        ELSE '0'
                    END, '0') AS CHAR(1)),
                CAST(ISNULL(
                    CASE 
                        WHEN fw_alert.IsFirmwareAlert = 1 THEN '1'
                        ELSE '0'
                    END, '0') AS CHAR(1))
            ) AS MessageAlertCode
        FROM MobileUnitBaseInfo mubi
        LEFT JOIN (
            SELECT 
                mum.MobileUnitId,
                MAX(CASE
                    WHEN mum.MessageSubType IN (254, 255) -- Config or Settings
                        AND mum.CreationDateUtc < DATEADD(day, -5, GETUTCDATE())
                        AND mum.MessageStatus NOT IN (10, 12, 13, 25, 28) -- Not in known good statuses
                    THEN 1
                    ELSE 0
                END) AS IsConfigOrSettingAlert,
                MAX(CASE
                    WHEN mum.MessageSubType = 103 -- Firmware
                        AND mum.CreationDateUtc < DATEADD(day, -3, GETUTCDATE())
                        AND mum.MessageStatus NOT IN (10, 12, 13, 25, 28) -- Not in known good statuses
                    THEN 1
                    ELSE 0
                END) AS IsFirmwareAlert
            FROM [state].[MobileUnitMessage] mum WITH (NOLOCK)
            WHERE mum.MessageSubType IN (254, 103, 255) -- Relevant message types
            GROUP BY mum.MobileUnitId
        ) msg_alerts ON mubi.MobileUnitId = msg_alerts.MobileUnitId
        CROSS APPLY (
            SELECT 
                CASE 
                    WHEN msg_alerts.IsConfigOrSettingAlert = 1 THEN 1
                    ELSE 0
                END AS IsConfigOrSettingAlert,
                CASE 
                    WHEN msg_alerts.IsFirmwareAlert = 1 THEN 1
                    ELSE 0
                END AS IsFirmwareAlert
        ) config_alert
        CROSS APPLY (
            SELECT 
                CASE 
                    WHEN msg_alerts.IsFirmwareAlert = 1 THEN 1
                    ELSE 0
                END AS IsFirmwareAlert
        ) fw_alert
    ),
    -- Get last message date for all units
    LastMessageDates AS (
        SELECT 
            mum.MobileUnitId,
            MAX(mum.MessageStatusDateUtc) AS LastMessageStatusDateUtc
        FROM [state].[MobileUnitMessage] mum WITH (NOLOCK)
        WHERE mum.MessageSubType IN (254, 103, 255) -- Relevant message types
        GROUP BY mum.MobileUnitId
    )

    -- Final result combining all information
    SELECT
        Alerts = CONCAT(
            ISNULL(ma.MessageAlertCode, '00'),
            CAST(ISNULL(fos.IsFirmwareOutdated, 0) AS CHAR(1)),
            CAST(0 AS CHAR(1)) -- Missing parameters is disabled
        ),
        mubi.MobileUnitId,
        mubi.Serialnumber,
        mubi.ConfigurationGroupId,
        NULL as CommsLog,
        CAST(lmd.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc,
        fos.InstalledFirmwareName AS FWVersion,
        fos.PreferredFirmwareName AS PreferredFWVersion
    FROM MobileUnitBaseInfo mubi
    LEFT JOIN FirmwareOutdatedStatus fos ON mubi.MobileUnitId = fos.MobileUnitId
    LEFT JOIN MessageAlerts ma ON mubi.MobileUnitId = ma.MobileUnitId
    LEFT JOIN LastMessageDates lmd ON mubi.MobileUnitId = lmd.MobileUnitId;

END;
GO
