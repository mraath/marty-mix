---
created: 2025-10-31T09:11
updated: 2025-10-31T09:23
---

```sql
--------------------------------------------------------------------------------
-- T-SQL STORED PROCEDURE COMPARISON HARNESS (Updated for SP Body Execution)
-- SP Target: [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
-- Input: Table-Valued Parameter (TVP) @configGroupIds [dbo].[SelectionIds]
--------------------------------------------------------------------------------

-- 1. ENVIRONMENT SETUP
SET NOCOUNT ON;
-- Enable statistics to track I/O and CPU time
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- Define your input parameter (Table-Valued Parameter)
-- ASSUMPTION: The Type [dbo].[SelectionIds] is defined as TABLE (Id BIGINT)
DECLARE @TargetConfigGroupIds [dbo].[SelectionIds]; 

-- ==============================================================================
-- !!! IMPORTANT !!!
-- POPULATE YOUR CONFIGURATION GROUP IDS HERE
-- ==============================================================================
INSERT INTO @TargetConfigGroupIds (Id) 
VALUES 
    (12345),  -- <--- REPLACE WITH ACTUAL GroupId 1
    (67890);  -- <--- REPLACE WITH ACTUAL GroupId 2 (or remove if only 1 needed)
-- ==============================================================================


-- ==============================================================================
-- TEMPORARY TABLE DEFINITION (Specific to the new SP's output schema)
-- ==============================================================================

IF OBJECT_ID('tempdb..#OriginalResults') IS NOT NULL DROP TABLE #OriginalResults;
IF OBJECT_ID('tempdb..#OptimizedResults') IS NOT NULL DROP TABLE #OptimizedResults;

-- This schema must exactly match the output columns of MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups
CREATE TABLE #OriginalResults (
    Alerts NVARCHAR(50) NULL,             -- CONCAT of flags
    MobileUnitId BIGINT NOT NULL,          
    Serialnumber NVARCHAR(100) NULL,       
    ConfigurationGroupId BIGINT NOT NULL,  
    CommsLog NVARCHAR(50) NULL,            -- NULL AS CommsLog
    MessageStatusDateUtc DATETIME NULL,    
    FWVersion NVARCHAR(100) NULL,          -- InstalledFirmwareName
    PreferredFWVersion NVARCHAR(100) NULL  -- PreferredFirmwareName
);

CREATE TABLE #OptimizedResults (
    Alerts NVARCHAR(50) NULL,
    MobileUnitId BIGINT NOT NULL,
    Serialnumber NVARCHAR(100) NULL,
    ConfigurationGroupId BIGINT NOT NULL,
    CommsLog NVARCHAR(50) NULL,
    MessageStatusDateUtc DATETIME NULL,
    FWVersion NVARCHAR(100) NULL,
    PreferredFWVersion NVARCHAR(100) NULL
);


-- ==============================================================================
-- 2. ORIGINAL STORED PROCEDURE BODY TEST (OLD CODE)
-- ==============================================================================

PRINT '------------------------------------------------------------------------';
PRINT 'STARTING ORIGINAL SP EXECUTION (Pasted Body)...';
DECLARE @StartTimeOriginal DATETIME = GETDATE();

INSERT INTO #OriginalResults 
BEGIN 
    -- ----------------------------------------------------
    -- VARIABLES (These are common to both versions)
    -- ----------------------------------------------------
    
    DECLARE @typeList TABLE (id BIGINT);
    INSERT INTO @typeList VALUES (254), (103), (255); --SendConfig,SendFirmware,SendSettings
    DECLARE @CompileFailed INT = 4;
    DECLARE @ScriptableCan INT = 125;
    DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;
    DECLARE @UNIT_IMEI BIGINT = 9188780602356317147;
    DECLARE @SERIAL_NUMBER BIGINT = -6167220489794283114;
    DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
    DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;
    DECLARE @PropIMEIKey INT = (SELECT [PropertyKey] FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK) WHERE dp.PropertyId = @UNIT_IMEI);
    DECLARE @PropSNKey INT = (SELECT [PropertyKey] FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK) WHERE dp.PropertyId = @SERIAL_NUMBER);
    DECLARE @PropStreamaxSNKey INT = (SELECT [PropertyKey] FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK) WHERE dp.PropertyId = @StreamaxSerialNumber);
    DECLARE @PropFWVersionKey INT = (SELECT [PropertyKey] FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK) WHERE dp.PropertyId = @FIRMWARE_VERSION);
    DECLARE @PropPreferredFWVersionKey INT = (SELECT [PropertyKey] FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK) WHERE dp.PropertyId = @PreferedFirmwareVersion);

    -- ----------------------------------------------------
    -- ORIGINAL LOGIC START
    -- ----------------------------------------------------
    
    SELECT
      Alerts = CONCAT(
          ISNULL(msgAlerts.MessageAlertCode, '00'), 
          CAST(CASE 
                  WHEN NOT EXISTS(SELECT 1 FROM [mobileunit].[MobileUnitDeviceProperties] mudp_inst WITH (NOLOCK) INNER JOIN [mobileunit].[MobileUnitDeviceProperties] mudp_pref WITH (NOLOCK) ON mudp_pref.MobileUnitKey = mudp_inst.MobileUnitKey 
                      WHERE mudp_inst.MobileUnitKey = mu.MobileUnitKey AND mudp_inst.PropertyKey = @PropFWVersionKey AND mudp_pref.PropertyKey = @PropPreferredFWVersionKey 
                      AND TRY_CAST(mudp_inst.Value AS BIGINT) < TRY_CAST(mudp_pref.Value AS BIGINT)) 
                  THEN 0 ELSE 1 END AS CHAR(1)), 
          CAST(CASE 
                  WHEN EXISTS(
                      SELECT 1 
                      FROM [mobileunit].[MobileUnitParameters] mup WITH (NOLOCK)
                      INNER JOIN [MobileDeviceConfiguration].[template].[DeviceParameters] tdp WITH (NOLOCK) ON tdp.DeviceParameterKey = mup.DeviceParameterKey
                      INNER JOIN [mobileunit].[MobileUnitDeviceParameters] mudp WITH (NOLOCK) ON mudp.MobileUnitKey = mup.MobileUnitKey AND mudp.DeviceParameterKey = mup.DeviceParameterKey
                      WHERE mup.MobileUnitKey = mu.MobileUnitKey AND mudp.Value IS NULL AND tdp.IsRequired = 1 
                  ) THEN 1 ELSE 0 END AS CHAR(1))
      ),
      mu.MobileUnitId,
      ISNULL(mup.Value, ISNULL(mudp.Value, '')) AS Serialnumber,
      mu.ConfigurationGroupId,
      NULL AS CommsLog,
      CAST(LastMsgDate.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc,
      ISNULL((SELECT TOP 1 fw.Name FROM [mobileunit].[MobileUnitDeviceProperties] mudp WITH (NOLOCK) INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = TRY_CAST(mudp.Value AS BIGINT) WHERE mudp.MobileUnitKey = mu.MobileUnitKey AND mudp.PropertyKey = @PropFWVersionKey), '') AS FWVersion,
      ISNULL((SELECT TOP 1 fw.Name FROM [mobileunit].[MobileUnitDeviceProperties] mudp WITH (NOLOCK) INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = TRY_CAST(mudp.Value AS BIGINT) WHERE mudp.MobileUnitKey = mu.MobileUnitKey AND mudp.PropertyKey = @PropPreferredFWVersionKey), '') AS PreferredFWVersion
  FROM [mobileunit].[MobileUnits] mu WITH (NOLOCK)
  INNER JOIN @TargetConfigGroupIds AS c ON c.Id = mu.ConfigurationGroupId
  LEFT JOIN [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK) ON mup.MobileUnitKey = mu.MobileUnitKey AND mup.PropertyKey = @PropSNKey
  LEFT JOIN [mobileunit].[MobileUnitDeviceProperties] mudp WITH (NOLOCK) ON mudp.MobileUnitKey = mu.MobileUnitKey AND mudp.PropertyKey = @PropSNKey
  LEFT JOIN [mobileunit].[MobileUnitDeviceProperties] mudp_streamax WITH (NOLOCK) ON mudp_streamax.MobileUnitKey = mu.MobileUnitKey AND mudp_streamax.PropertyKey = @PropStreamaxSNKey
  OUTER APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](mu.MobileUnitId) AS msgAlerts
  OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageStatusDate](mu.MobileUnitId, @typeList) AS LastMsgDate
  WHERE mu.StatusId = 1
      AND (
          mu.MobileDeviceKey IN (
              SELECT DeviceKey
              FROM [DeviceConfiguration].[definition].[Devices]
              WHERE DeviceTypeId = @ScriptableCan
          ) OR mudp_streamax.MobileUnitKey IS NOT NULL
      )
  ;
    
    -- ----------------------------------------------------
    -- ORIGINAL LOGIC END
    -- ----------------------------------------------------

END

DECLARE @EndTimeOriginal DATETIME = GETDATE();
PRINT 'ORIGINAL SP EXECUTION COMPLETE.';
PRINT 'TIME TAKEN: ' + CAST(DATEDIFF(ms, @StartTimeOriginal, @EndTimeOriginal) AS VARCHAR(20)) + ' ms';

-- ==============================================================================
-- 3. OPTIMIZED STORED PROCEDURE BODY TEST (NEW CODE)
-- 
-- This section contains the logic from the NEW CODE block in your file.
-- ==============================================================================

PRINT '------------------------------------------------------------------------';
PRINT 'STARTING OPTIMIZED SP EXECUTION (Pasted Body)...';
DECLARE @StartTimeOptimized DATETIME = GETDATE();

INSERT INTO #OptimizedResults 
BEGIN 
    -- ---------------------------------------------
    -- OPTIMIZED SP BODY CODE (from your file)
    -- ---------------------------------------------

  -- VARIABLES ---

  -- Send messages types
  DECLARE @typeList TABLE (id BIGINT);
  INSERT INTO @typeList VALUES (254), (103), (255); --SendConfig,SendFirmware,SendSettings
    
  DECLARE @CompileFailed INT = 4;
  DECLARE @ScriptableCan INT = 125;
  DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;
  DECLARE @UNIT_IMEI BIGINT = 9188780602356317147;
  DECLARE @SERIAL_NUMBER BIGINT = -6167220489794283114;
  DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
  DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;

  DECLARE @PropIMEIKey INT = (
    SELECT [PropertyKey]
    FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK)
    WHERE dp.PropertyId = @UNIT_IMEI
  );
  DECLARE @PropSNKey INT = (
    SELECT [PropertyKey]
    FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK)
    WHERE dp.PropertyId = @SERIAL_NUMBER
  );
  DECLARE @PropStreamaxSNKey INT = (
    SELECT [PropertyKey]
    FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK)
    WHERE dp.PropertyId = @StreamaxSerialNumber
  );
  DECLARE @PropFWVersionKey INT = (
    SELECT [PropertyKey]
    FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK)
    WHERE dp.PropertyId = @FIRMWARE_VERSION
  );
  DECLARE @PropPreferredFWVersionKey INT = (
    SELECT [PropertyKey]
    FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK)
    WHERE dp.PropertyId = @PreferedFirmwareVersion
  );

  -- TEMP TABLES ---

  -- Basic unit information (MobileUnitId, Serialnumber, Config Group)
  IF OBJECT_ID('tempdb..#UnitBasicInfo') IS NOT NULL DROP TABLE #UnitBasicInfo;
  SELECT 
    mu.MobileUnitId,
    mu.ConfigurationGroupId,
    ISNULL(mup.Value, ISNULL(mudp.Value, '')) AS Serialnumber -- Use Property value if available, else MobileUnit value
  INTO #UnitBasicInfo
  FROM [mobileunit].[MobileUnits] mu WITH (NOLOCK)
  INNER JOIN @TargetConfigGroupIds AS c ON c.Id = mu.ConfigurationGroupId
  -- Serial Number Property
  LEFT JOIN [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK) ON mup.MobileUnitKey = mu.MobileUnitKey AND mup.PropertyKey = @PropSNKey
  -- Serial Number Device Property
  LEFT JOIN [mobileunit].[MobileUnitDeviceProperties] mudp WITH (NOLOCK) ON mudp.MobileUnitKey = mu.MobileUnitKey AND mudp.PropertyKey = @PropSNKey
  -- Streamax Serial Number
  LEFT JOIN [mobileunit].[MobileUnitDeviceProperties] mudp_streamax WITH (NOLOCK) ON mudp_streamax.MobileUnitKey = mu.MobileUnitKey AND mudp_streamax.PropertyKey = @PropStreamaxSNKey
  WHERE mu.StatusId = 1
    AND (
      mu.MobileDeviceKey IN (
        SELECT DeviceKey
        FROM [DeviceConfiguration].[definition].[Devices]
        WHERE DeviceTypeId = @ScriptableCan
      ) OR mudp_streamax.MobileUnitKey IS NOT NULL
    );

  CREATE UNIQUE CLUSTERED INDEX IX_ConfigGroup_MU ON #UnitBasicInfo (ConfigurationGroupId, MobileUnitId);
  CREATE NONCLUSTERED INDEX IX_MU_SN ON #UnitBasicInfo (MobileUnitId, Serialnumber);


  -- Firmware comparison and names
  IF OBJECT_ID('tempdb..#FirmwareResults') IS NOT NULL DROP TABLE #FirmwareResults;
  SELECT
    bi.MobileUnitId,
    InstalledFirmwareName = ISNULL(
      (
        SELECT TOP 1 fw.Name
        FROM [mobileunit].[MobileUnitDeviceProperties] mudp WITH (NOLOCK)
        INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = TRY_CAST(mudp.Value AS BIGINT)
        WHERE mudp.MobileUnitKey = bi.MobileUnitKey
          AND mudp.PropertyKey = @PropFWVersionKey
      ),
      'Unknown'
    ),
    PreferredFirmwareName = ISNULL(
      (
        SELECT TOP 1 fw.Name
        FROM [mobileunit].[MobileUnitDeviceProperties] mudp WITH (NOLOCK)
        INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = TRY_CAST(mudp.Value AS BIGINT)
        WHERE mudp.MobileUnitKey = bi.MobileUnitKey
          AND mudp.PropertyKey = @PropPreferredFWVersionKey
      ),
      'Unknown'
    ),
    IsFirmwareOutdated = 
      CASE
        WHEN EXISTS (
          SELECT 1
          FROM [mobileunit].[MobileUnitDeviceProperties] mudp_inst WITH (NOLOCK)
          INNER JOIN [mobileunit].[MobileUnitDeviceProperties] mudp_pref WITH (NOLOCK) ON mudp_pref.MobileUnitKey = mudp_inst.MobileUnitKey
          WHERE mudp_inst.MobileUnitKey = bi.MobileUnitKey
            AND mudp_inst.PropertyKey = @PropFWVersionKey
            AND mudp_pref.PropertyKey = @PropPreferredFWVersionKey
            AND TRY_CAST(mudp_inst.Value AS BIGINT) < TRY_CAST(mudp_pref.Value AS BIGINT)
        ) THEN 1
        ELSE 0
      END
  INTO #FirmwareResults
  FROM #UnitBasicInfo bi;


  -- Missing/Incomplete parameters
  IF OBJECT_ID('tempdb..#MissingParamsResults') IS NOT NULL DROP TABLE #MissingParamsResults;
  SELECT 
    bi.MobileUnitId,
    IsMissingParameters = 
      CASE
        WHEN EXISTS (
          SELECT 1
          FROM [mobileunit].[MobileUnitParameters] mup WITH (NOLOCK)
          INNER JOIN [MobileDeviceConfiguration].[template].[DeviceParameters] tdp WITH (NOLOCK) ON tdp.DeviceParameterKey = mup.DeviceParameterKey
          INNER JOIN [mobileunit].[MobileUnitDeviceParameters] mudp WITH (NOLOCK) ON mudp.MobileUnitKey = mup.MobileUnitKey AND mudp.DeviceParameterKey = mup.DeviceParameterKey
          WHERE mup.MobileUnitKey = bi.MobileUnitKey
            AND mudp.Value IS NULL -- Incomplete parameter value
            AND tdp.IsRequired = 1  -- Only check required parameters
        ) THEN 1
        ELSE 0
      END
  INTO #MissingParamsResults
  FROM #UnitBasicInfo bi;

/* The following logic blocks are commented out in the NEW CODE provided in your file, 
   so they are left commented out here to reflect the intended optimized state.
  -- Overwritten events (Original logic, removed for performance/new requirement)
  IF OBJECT_ID('tempdb..#OverwrittenEvents') IS NOT NULL DROP TABLE #OverwrittenEvents;
  SELECT DISTINCT
    mu.MobileUnitId,
    IsOverwritten = 1
  INTO #OverwrittenEvents
  FROM #UnitBasicInfo mu
  LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK) ON events.MobileUnitKey = mu.MobileUnitKey
  LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = mu.MobileUnitKey
  LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = mu.MobileUnitKey
  WHERE events.MobileUnitKey IS NOT NULL
    OR eventActions.MobileUnitKey IS NOT NULL
    OR thresholds.MobileUnitKey IS NOT NULL;

    -- Overwritten properties (Original logic, removed for performance/new requirement)
  IF OBJECT_ID('tempdb..#OverwrittenProperties') IS NOT NULL DROP TABLE #OverwrittenProperties;
  SELECT DISTINCT
    mu.MobileUnitId,
    IsOverwritten = 1
  INTO #OverwrittenProperties
  FROM #UnitBasicInfo mu
  LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK) ON devices.MobileUnitKey = mu.MobileUnitKey
  LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
  LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK) ON paramsCan.MobileUnitKey = mu.MobileUnitKey
  LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK) ON properties.MobileUnitKey = mu.MobileUnitKey AND properties.PersistOnReset = 0
  LEFT JOIN [mobileunit].[OverridenPeripheralDevices] peripherals WITH (NOLOCK) ON peripherals.MobileUnitKey = mu.MobileUnitKey
  WHERE devices.MobileUnitKey IS NOT NULL
    OR params.MobileUnitKey IS NOT NULL
    OR paramsCan.MobileUnitKey IS NOT NULL
    OR properties.MobileUnitKey IS NOT NULL
    OR peripherals.MobileUnitKey IS NOT NULL;

    -- Missing condition parameters (Original logic, removed for performance/new requirement)
  SELECT
    mpr.MobileUnitId,
    IsMissingEventConditionParam = 1
  FROM #MissingParamsResults mpr
  INNER JOIN [mobileunit].[MobileUnitEvents] mue WITH (NOLOCK) ON mue.MobileUnitKey = mpr.MobileUnitKey
  INNER JOIN [mobileunit].[EventParameterSettings] eps WITH (NOLOCK) ON eps.EventKey = mue.EventKey AND eps.IsConditionParamRequired = 1 AND eps.IsConditionParamSupported = 0
  INNER JOIN (
      SELECT MobileUnitId, IsMissingEventConditionParam = 1
      FROM #UnitBasicInfo bi
      INNER JOIN [mobileunit].[MobileUnitEvents] mue WITH (NOLOCK) ON mue.MobileUnitKey = bi.MobileUnitKey
      INNER JOIN [mobileunit].[EventParameterSettings] eps WITH (NOLOCK) ON eps.EventKey = mue.EventKey
        AND eps.IsConditionParamRequired = 1
        AND eps.IsConditionParamSupported = 0 
    ) AS Missing ON Missing.MobileUnitId = mpr.MobileUnitId;
    
    */

    ---------------------------------------------------
    -- STEP 4: FINAL SELECT
    ---------------------------------------------------

    SELECT
        Alerts = CONCAT(
                     ISNULL(msgAlerts.MessageAlertCode, '00'), 
                     CAST(ISNULL(fr.IsFirmwareOutdated, 0) AS CHAR(1)), 
                     CAST(ISNULL(mpr.IsMissingParameters, 0) AS CHAR(1)) 
                   ),
        bi.MobileUnitId,
        bi.Serialnumber,
        bi.ConfigurationGroupId,
        NULL AS CommsLog,
        CAST(LastMsgDate.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc, 
        ISNULL(fr.InstalledFirmwareName, '') AS FWVersion,
        ISNULL(fr.PreferredFirmwareName, '') AS PreferredFWVersion
    FROM #UnitBasicInfo bi
    -- Join Set-Based Results
    LEFT JOIN #FirmwareResults fr ON fr.MobileUnitId = bi.MobileUnitId
    LEFT JOIN #MissingParamsResults mpr ON mpr.MobileUnitId = bi.MobileUnitId
    -- Apply iTVFs
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](bi.MobileUnitId) AS msgAlerts
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageStatusDate](bi.MobileUnitId, @typeList) AS LastMsgDate

    -- ---------------------------------------------
    -- OPTIMIZED SP BODY CODE ENDING HERE
    -- ---------------------------------------------
END

DECLARE @EndTimeOptimized DATETIME = GETDATE();
PRINT 'OPTIMIZED SP EXECUTION COMPLETE.';
PRINT 'TIME TAKEN: ' + CAST(DATEDIFF(ms, @StartTimeOptimized, @EndTimeOptimized) AS VARCHAR(20)) + ' ms';


-- ==============================================================================
-- 4. COMPARISON LOGIC (Checks for exact row-by-row match)
-- ==============================================================================

PRINT '------------------------------------------------------------------------';
PRINT 'STARTING RESULT COMPARISON...';

-- A. Rows returned by ORIGINAL but NOT in OPTIMIZED (Lost Rows)
SELECT 'LOST (Original Only)' AS DifferenceType, *
FROM #OriginalResults
EXCEPT
SELECT 'LOST (Original Only)' AS DifferenceType, *
FROM #OptimizedResults;

-- B. Rows returned by OPTIMIZED but NOT in ORIGINAL (New/Mismatched Rows)
SELECT 'NEW (Optimized Only)' AS DifferenceType, *
FROM #OptimizedResults
EXCEPT
SELECT 'NEW (Optimized Only)' AS DifferenceType, *
FROM #OriginalResults;

PRINT 'RESULT COMPARISON COMPLETE.';
PRINT '------------------------------------------------------------------------';
PRINT 'If the above two result sets are empty, the results are identical.';
PRINT 'Check the MESSAGE tab for "SQL Server parse and compile time" (CPU) and "Table ... scan count" (IO) for true performance metrics.';

-- Clean up
IF OBJECT_ID('tempdb..#OriginalResults') IS NOT NULL DROP TABLE #OriginalResults;
IF OBJECT_ID('tempdb..#OptimizedResults') IS NOT NULL DROP TABLE #OptimizedResults;

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

```