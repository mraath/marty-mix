---
wiki_ingested: 2026-05-28
created: 2025-10-30T14:25
updated: 2025-10-30T14:28
---
This stored procedure is much better structured than the last one, as it already uses temporary tables and set-based joins for the core data. The main bottleneck here is the **Dynamic _SQL_** and the final **Black Flags** logic, which can be cleaned up and integrated more efficiently.

Here is the enhanced version of `[mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]`. I've made the following improvements:

1. **Refactored `GeneralConfigGroupInfo` and `#mobileUnits`:** Combined these into a single, comprehensive temporary table (`#UnitInfo`) to reduce data copies and make the subsequent joins cleaner.
    
2. **Optimized Black Flag Logic:** Integrated the complex `OR` conditions for `BlackFlagsCount` directly into a single, efficient `LEFT JOIN` and `CASE` statement in the final query, eliminating the need for a separate table variable and its implicit performance costs.
    
3. **Simplified Final Select:** Streamlined the final `SELECT` by referencing the central `#UnitInfo` table and directly calculating the `ConfigCompileStatus` value.
    

## 🚀 Enhanced Stored Procedure: `[mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]`

_SQL_

```
CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    --- CONSTANTS & KEYS ---
    
    -- Config Statuses
    DECLARE @CompileFailed INT = 4;
    DECLARE @ConfigurationWarning INT = 14;
    DECLARE @NotCommissioned INT = 0;
    
    -- Property IDs
    DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;
    DECLARE @UNIT_IMEI BIGINT = 9188780602356317147;
    DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
    DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;
    
    -- Device Key for Streamax Standalone Check
    DECLARE @STREAMAX_STANDALONE_DEVICE_KEY INT = (
        SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE DeviceId = -1064000195705392069
    );

    -- Property Keys for Lookup
    DECLARE @PropIMEIKey INT = (
        SELECT [PropertyKey] FROM [definition].[Properties] dp WITH (NOLOCK) WHERE dp.PropertyId = @UNIT_IMEI
    );
    DECLARE @FWVersionKey SMALLINT = (
        SELECT PropertyKey FROM [definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @PreferedFirmwareVersion
    );


    ---------------------------------------------------
    -- STEP 1: Consolidate Mobile Unit and Configuration Group Info
    -- Combines @GeneralConfigGroupInfo and #mobileUnits into a single, central #UnitInfo.
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#UnitInfo') IS NOT NULL
        DROP TABLE #UnitInfo;

    CREATE TABLE #UnitInfo (
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
        MobileDeviceType INT,
        
        -- Mobile Unit Fields
        MobileUnitId BIGINT PRIMARY KEY,
        MobileUnitKey INT,
        AssetId BIGINT,
        LegacyOrgId INT,
        LegacyVehicleId INT,
        MobileDeviceKey INT,
        ConfigurationStatusId INT,
        ConfigurationStatus NVARCHAR(50),
        ConfigurationStatusDate DATETIME,
        UniqueIdentifier NVARCHAR(250), -- Used for IMEI/Serial fallback
        StreamaxSerialNumber NVARCHAR(250),
        ConfigurationGenerationNotes NVARCHAR(MAX),
        ConfigurationGenerationWarning NVARCHAR(MAX)
    );

    INSERT INTO #UnitInfo WITH (TABLOCK)
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
        dmd.MobileDeviceType,
        
        -- Mobile Unit Columns
        mu.MobileUnitId,
        mu.MobileUnitKey,
        amu.AssetId,
        amu.LegacyOrgId,
        amu.LegacyVehicleId,
        mu.MobileDeviceKey,
        mu.[ConfigurationStatus] AS ConfigurationStatusId,
        cs.[Description] AS [ConfigurationStatus],
        mu.DateUpdated AS [ConfigurationStatusDate],
        ISNULL(mu.UniqueIdentifier, mup.Value) AS [UniqueIdentifier], -- IMEI fallback logic
        (CASE 
            WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier 
            ELSE ap.Value 
         END) AS StreamaxSerialNumber, -- Streamax Serial fallback logic
        mu.ConfigurationGenerationNotes,
        mu.ConfigurationGenerationWarning
    FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK)
        ON tcg.ConfigurationGroupId = cg.id
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK)
        ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
    INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK)
        ON mu.MobileUnitKey = amu.MobileUnitKey
    INNER JOIN [definition].[ConfigurationStatuses] cs WITH (NOLOCK)
        ON cs.[ConfigurationStatus] = mu.[ConfigurationStatus]
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
    LEFT JOIN [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK)
        ON mu.[MobileUnitKey] = mup.[MobileUnitKey]
        AND mup.[PropertyKey] = @PropIMEIKey -- For UniqueIdentifier (IMEI) lookup
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK)
        ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber;


    ---------------------------------------------------
    -- STEP 2: DYNAMIC SQL FOR ASSET AND SCHEDULE DATA
    -- This section remains largely unchanged due to the cross-database necessity.
    ---------------------------------------------------

    DECLARE @legacyOrgId INT = ( SELECT TOP 1 LegacyOrgId FROM #UnitInfo);

    DECLARE @sConnectDatabase NVARCHAR(250);
    SELECT @sConnectDatabase = sConnectDatabase
    FROM [$(Controller)].[dbo].[Organisation] fmo WITH (NOLOCK)
    WHERE fmo.liOrgID = @legacyOrgId;

    IF OBJECT_ID('tempdb..#assets') IS NOT NULL
        DROP TABLE #assets;

    CREATE TABLE #assets (
        AssetDescription NVARCHAR(500),
        Registration NVARCHAR(50),
        Sitename NVARCHAR(500),
        FleetNumber NVARCHAR(50),
        LegacyVehicleId INT
    );

    IF OBJECT_ID('tempdb..#schedule') IS NOT NULL
        DROP TABLE #schedule;
    CREATE TABLE #schedule (
        [ScheduleId] INT,
        [AssetId] BIGINT,
        [LastRun] DATETIME,
        [LastLogEntry] NVARCHAR(500)
    )

    -- Pass the keys to the dynamic SQL for efficient joining
    IF OBJECT_ID('tempdb..#DynSqlKeys') IS NOT NULL DROP TABLE #DynSqlKeys;
    CREATE TABLE #DynSqlKeys (MobileUnitId BIGINT, LegacyVehicleId INT, AssetId BIGINT);
    INSERT INTO #DynSqlKeys SELECT MobileUnitId, LegacyVehicleId, AssetId FROM #UnitInfo;

    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = N'
        -- Asset Info Query
        INSERT INTO #assets
        SELECT DISTINCT
            v.sDesc as AssetDescription,
            v.sRegNo as Registration,
            s.sName as [Sitename], 
            a.FleetNumber,
            ds.LegacyVehicleId
        FROM #DynSqlKeys ds WITH (NOLOCK)
        INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.dbo.Vehicles v WITH (NOLOCK) 
            ON v.iVehicleID = ds.LegacyVehicleId
        INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.[dynamix].Assets a WITH (NOLOCK) 
            ON v.iVehicleID = a.VehicleId 
        INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.dbo.Sites s WITH (NOLOCK) 
            ON s.liSiteID = v.liSiteID
        INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.[dynamix].Sites ds WITH (NOLOCK) 
            ON ds.SiteID = v.liSiteID;

        -- Schedule Info Query
        WITH ScheduleLogIds as 
        (
            SELECT 
                MAX(dsl.DataScheduleLogID) AS DataScheduleLogID, 
                a.VehicleId, 
                a.AssetId
            FROM #DynSqlKeys ds WITH (NOLOCK)
            INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.[dynamix].Assets a WITH (NOLOCK) 
                ON ds.AssetId = a.AssetId
            INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.dbo.DataSchedule dsched WITH (NOLOCK) 
                ON a.VehicleId = dsched.liObjectID
            INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.dbo.DataScheduleLog dsl WITH (NOLOCK)
                ON dsched.liSchedId = dsl.liSchedId 
            WHERE CAST((CAST(dsched.bUploadConfig as tinyint) + CAST(dsched.bUploadDDRs as tinyint) + 
                        dsched.bUploadDDRs + dsched.ucUploadTerminalScript + dsched.ucUploadTerminalDDM + 
                        dsched.ucUploadTerminalDB + dsched.ucUploadCanDDM + dsched.ucUploadExtendedConfigBIN) AS BIT) = 1
            GROUP BY a.VehicleId , a.AssetId
        )
        INSERT INTO #schedule
        SELECT 
            [ScheduleId] = ads.UploadScheduleId,
            logIds.AssetId,
            ds.dtLastRun,
            [LastLogEntry] = ' + QUOTENAME(@sConnectDatabase) + N'.[dynamix].[GetLatestScheduleLogMsgByScheduleId] (ds.[liSchedID], null)
        FROM ScheduleLogIds logIds
        INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.[dynamix].AssetDataSchedules ads WITH (NOLOCK) 
            ON ads.AssetId = logIds.AssetId
        INNER JOIN ' + QUOTENAME(@sConnectDatabase) + N'.dbo.DataSchedule ds WITH (NOLOCK) 
            ON ds.liObjectId = logIds.VehicleId 
            AND ds.liSchedID = ads.UploadScheduleId;
    ';
    EXEC sp_executesql @SQL;

    IF OBJECT_ID('tempdb..#DynSqlKeys') IS NOT NULL DROP TABLE #DynSqlKeys;

    ---------------------------------------------------
    -- STEP 3: OPTIMIZED BLACK FLAG LOGIC (Single Join)
    -- Instead of inserting into a separate table variable, use a LEFT JOIN + CASE.
    ---------------------------------------------------

    -- Final SELECT Statement
    SELECT
        NULL AS Alerts,
        -- Black Flag Logic: 1 if ANY override table has a record for this MobileUnitKey
        CASE
            WHEN events.MobileUnitKey IS NOT NULL OR eventActions.MobileUnitKey IS NOT NULL OR thresholds.MobileUnitKey IS NOT NULL
              OR devices.MobileUnitKey IS NOT NULL OR params.MobileUnitKey IS NOT NULL OR paramsCan.MobileUnitKey IS NOT NULL
              OR properties.MobileUnitKey IS NOT NULL OR peripherals.MobileUnitKey IS NOT NULL
            THEN 1 
            ELSE 0 
        END AS Flagged,
        
        ui.AssetId,
        ui.LegacyVehicleId,
        a.AssetDescription,
        a.Registration,
        a.Sitename,
        a.FleetNumber,
        NULL AS Lastposition,
        ui.UniqueIdentifier AS IMEI,
        NULL AS Serialnumber, -- Left as NULL as per original logic
        ui.MobileDevice,
        CASE 
            WHEN ui.ConfigurationStatusId IN (@CompileFailed, @ConfigurationWarning, @NotCommissioned) 
            THEN ISNULL(ui.ConfigurationGenerationWarning, ui.ConfigurationGenerationNotes)
            ELSE '' 
        END AS ConfigCompileStatus,
        ui.ConfigurationStatus,
        ui.ConfigurationStatusDate,
        NULL AS CommsLog,
        NULL AS MessageStatusDateUtc,
        sched.LastLogEntry,
        sched.ScheduleId,
        ui.ConfigurationGroupId,
        ui.ConfigurationGroupName,
        ui.MobileDeviceTemplateId,
        ui.MobileDeviceTemplateName,
        ui.EventTemplateId,
        ui.EventTemplateName,
        ui.LocationTemplateId,
        ui.LocationTemplateName,
        ui.MobileDeviceType,
        NULL AS FWVersion,
        NULL AS PreferredFWVersion,
        NULL AS CanScriptLineId,
        NULL AS CanScript,
        NULL AS Speed,
        NULL AS RPM,
        NULL AS Fuel,
        NULL AS SP,
        ui.StreamaxSerialNumber AS MiXVisionSerialnumber,
        NULL AS HOS
    FROM #UnitInfo ui
    INNER JOIN #assets a ON a.LegacyVehicleId = ui.LegacyVehicleId
    LEFT JOIN #schedule sched ON sched.AssetId = ui.AssetId
    
    -- --- BLACK FLAGS (Single Join Block) ---
    -- LEFT JOIN to check for the existence of any override record
    LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK)
      ON events.MobileUnitKey = ui.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK)
      ON eventActions.MobileUnitKey = ui.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK)
      ON thresholds.MobileUnitKey = ui.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK)
      ON devices.MobileUnitKey = ui.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK)
      ON params.MobileUnitKey = ui.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK)
      ON paramsCan.MobileUnitKey = ui.MobileUnitKey
    LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK)
      ON properties.MobileUnitKey = ui.MobileUnitKey AND properties.PersistOnReset = 0
    LEFT JOIN [mobileunit].[OverridenPeripheralDevices] peripherals WITH (NOLOCK)
      ON peripherals.MobileUnitKey = ui.MobileUnitKey
    -- --- END BLACK FLAGS ---

    GROUP BY -- Grouping is necessary because the LEFT JOINs for Black Flags can create duplicate rows.
        ui.AssetId, ui.LegacyVehicleId, a.AssetDescription, a.Registration, a.Sitename, a.FleetNumber, ui.UniqueIdentifier, 
        ui.MobileDevice, ui.ConfigurationStatusId, ui.ConfigurationGenerationWarning, ui.ConfigurationGenerationNotes, 
        ui.ConfigurationStatus, ui.ConfigurationStatusDate, sched.LastLogEntry, sched.ScheduleId, ui.ConfigurationGroupId, 
        ui.ConfigurationGroupName, ui.MobileDeviceTemplateId, ui.MobileDeviceTemplateName, ui.EventTemplateId, 
        ui.EventTemplateName, ui.LocationTemplateId, ui.LocationTemplateName, ui.MobileDeviceType, ui.StreamaxSerialNumber,
        events.MobileUnitKey, eventActions.MobileUnitKey, thresholds.MobileUnitKey, devices.MobileUnitKey, 
        params.MobileUnitKey, paramsCan.MobileUnitKey, properties.MobileUnitKey, peripherals.MobileUnitKey;


    ---------------------------------------------------
    -- STEP 4: Cleanup
    ---------------------------------------------------
    DROP TABLE #UnitInfo;
    DROP TABLE #assets;
    DROP TABLE #schedule;

END;
```

This version provides two key benefits:

1. **Reduced Temporary Objects:** We went from two initial table variables/temp tables to one (`#UnitInfo`), simplifying the initial data retrieval and subsequent joins.
    
2. **Efficient Black Flag Check:** The most significant gain is replacing the `INSERT INTO @BlackFlagsCount... SELECT DISTINCT` with a direct set of `LEFT JOIN` checks in the final `SELECT`. While the `GROUP BY` is still necessary to collapse the fan-out from the multiple `LEFT JOIN`s, this approach avoids iterating through and writing to a separate table variable, leading to a much faster execution plan for the flag check.
    

Would you like to review the dynamic _SQL_ section, or are you satisfied with the set-based optimization on the main application logic?

