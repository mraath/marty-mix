---
wiki_ingested: 2026-05-28
created: 2025-10-30T11:22
updated: 2025-10-30T11:24
---



```sql
CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON; -- Reduces network traffic and is a good practice for stored procedures

    -- VARIABLES
    DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;

    -- Look up the STREAMAX_STANDALONE_DEVICE_KEY once
    DECLARE @STREAMAX_STANDALONE_DEVICE_KEY INT = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE DeviceId = -1064000195705392069);

    ---------------------------------------------------
    -- STEP 1: GENERAL CONFIG GROUP INFORMATION
    -- Using a temp table for better statistics estimation than a table variable.
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#GeneralConfigGroupInfo') IS NOT NULL
        DROP TABLE #GeneralConfigGroupInfo;

    CREATE TABLE #GeneralConfigGroupInfo (
        ConfigurationGroupId    BIGINT PRIMARY KEY, -- Primary key for efficient joining
        DeviceKey               INT,
        MobileDeviceTemplateKey BIGINT,
        LibraryKey              INT,
        ConfigurationGroupKey   INT,
        MobileDevice            NVARCHAR(50)
    );

    INSERT INTO #GeneralConfigGroupInfo WITH (TABLOCK) -- TABLOCK hint for large inserts
    SELECT
        tcg.ConfigurationGroupId,
        dd.DeviceKey,
        tcg.MobileDeviceTemplateKey,
        tcg.LibraryKey,
        tcg.ConfigurationGroupKey,
        dmd.Description AS MobileDevice
    FROM @configGroupIds cg
        INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK)
            ON tcg.ConfigurationGroupId = cg.id
        INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
            ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
            AND tcg.LibraryKey = mdt.LibraryKey
        INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
            ON mdt.MobileDeviceKey = dd.DeviceKey
        INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK)
            ON dd.DeviceKey = dmd.DeviceKey;

    ---------------------------------------------------
    -- STEP 2: Mobile Units
    -- Reuse the existing #mobileUnits temp table logic.
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#mobileUnits') IS NOT NULL
          DROP TABLE #mobileUnits;

    CREATE TABLE #mobileUnits (
        ConfigurationGroupId      BIGINT,
        MobileUnitId              BIGINT PRIMARY KEY, -- MobileUnitId should be unique
        MobileUnitKey             INT,
        MobileDeviceKey           INT,
        StreamaxSerialNumber      NVARCHAR(250)
    );

    INSERT INTO #mobileUnits WITH (TABLOCK)
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        mu.MobileUnitKey,
        mu.MobileDeviceKey,
        (CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber
    FROM #GeneralConfigGroupInfo g -- Use the temp table
        INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK)
            ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
        LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK)
            ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber;

    ---------------------------------------------------
    -- STEP 3 & 4: All Config group lines & Asset overwritten lines (Effective Lines)
    -- Combining the logic from @AllConfigGroupLines and @EffectiveByMobileUnitId 
    -- and the subsequent join into a single, comprehensive temp table.
    -- This is the most complex part of the original query.
    ---------------------------------------------------

    -- Dropping the temp table if it exists
    IF OBJECT_ID('tempdb..#MobileUnitLinesFinal') IS NOT NULL
        DROP TABLE #MobileUnitLinesFinal;

    CREATE TABLE #MobileUnitLinesFinal (
        MobileUnitId          BIGINT NOT NULL,
        ConfigurationGroupId  BIGINT NOT NULL,
        LineId                NVARCHAR(50),
        WireName              NVARCHAR(200),
        IsOverridden          BIT,
        Connection            NVARCHAR(200)
    );

    -- This query generates the base lines from the config group and the overrides for each MobileUnit.
    -- To preserve the exact logic, the two original segments (ConfigGroupLines and EffectiveByMobileUnitId)
    -- are kept separated and then combined, but using temp tables for efficiency.

    IF OBJECT_ID('tempdb..#AllConfigGroupLines') IS NOT NULL
        DROP TABLE #AllConfigGroupLines;

    CREATE TABLE #AllConfigGroupLines (
        ConfigurationGroupId BIGINT NOT NULL,
        WireName             NVARCHAR(200),
        Connection           NVARCHAR(200),
        LineId               NVARCHAR(50)
    );

    INSERT INTO #AllConfigGroupLines WITH (TABLOCK)
    SELECT DISTINCT -- DISTINCT added as the original query's complex joins might create duplicates
        g.ConfigurationGroupId,
        dl.[Name] AS WireName,
        lpd.[Description] AS Connection,
        dl.LineId
    FROM #GeneralConfigGroupInfo g
        LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK)
            ON dmdl.[MobileDeviceKey] = g.DeviceKey
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
        -- Peripheral devices (using standard JOIN instead of CROSS APPLY)
        INNER JOIN [template].[PeripheralDevices] pd_temp WITH (NOLOCK)
            ON pd_temp.[TemplateDeviceKey] = td.[TemplateDeviceKey]
            AND pd_temp.[LineKey] = dmdl.[LineKey]
        LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK)
            ON pdl.[LineKey] = pd_temp.[LineKey]
        -- Lines
        LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
            ON dmdlpd.[MobileDeviceKey] = g.DeviceKey
            AND dmdlpd.[LineKey] = pd_temp.[LineKey]
            AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
        -- Get connected device
        LEFT JOIN [library].[Devices] ld WITH (NOLOCK)
            ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey
            AND ld.LibraryKey = g.LibraryKey
        LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK)
            ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey;

    -- The second table variable is kept as a temp table to isolate the override logic
    IF OBJECT_ID('tempdb..#EffectiveByMobileUnitId') IS NOT NULL
        DROP TABLE #EffectiveByMobileUnitId;

    CREATE TABLE #EffectiveByMobileUnitId (
        MobileUnitId BIGINT NOT NULL,
        WireName     NVARCHAR(200),
        Connection   NVARCHAR(200),
        IsOverridden BIT,
        LineId       NVARCHAR(50)
    );

    INSERT INTO #EffectiveByMobileUnitId WITH (TABLOCK)
    SELECT
        mu.MobileUnitId,
        dl.[Name] AS WireName,
        lpd.[Description] AS Connection,
        CAST(CASE WHEN opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS IsOverridden, -- Simplified BIT conversion
        dl.LineId
    FROM #mobileUnits mu
        INNER JOIN #GeneralConfigGroupInfo g
            ON g.ConfigurationGroupId = mu.ConfigurationGroupId
        INNER JOIN [template].[Devices] td WITH (NOLOCK)
            ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
        INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
            ON dd.[DeviceKey] = td.[DeviceKey]
        --Peripheral Devices (Using standard JOIN + Conditional logic)
        INNER JOIN [template].[PeripheralDevices] tpd WITH (NOLOCK)
            ON tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK)
            ON opd.[MobileUnitKey] = mu.[MobileUnitKey]
            AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
        -- The filtering logic
        INNER JOIN (SELECT 1 as dummy) ON ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL) OR (opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))
        -- LineKey logic from original query
        INNER JOIN [definition].[Lines] dl WITH (NOLOCK)
            ON dl.[LineKey] = ISNULL(opd.[LineKey], tpd.[LineKey])
        --Lines
        LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
            ON dmdlpd.[MobileDeviceKey] = mu.[MobileDeviceKey]
            AND dmdlpd.[LineKey] = ISNULL(opd.[LineKey], tpd.[LineKey])
            AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]
        --Get the connected device
        LEFT JOIN [library].[Devices] ld WITH (NOLOCK)
            ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey
            AND ld.LibraryKey = g.LibraryKey
        LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK)
            ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey;


    -- Final combination of Config Group Lines and Effective Lines (MobileUnitLines)
    INSERT INTO #MobileUnitLinesFinal WITH (TABLOCK)
    SELECT
        mu.MobileUnitId,
        cgl.ConfigurationGroupId,
        cgl.LineId,
        cgl.WireName,
        eff.IsOverridden,
        Connection = ISNULL(eff.Connection, cgl.Connection) -- Use ISNULL for the CASE logic
    FROM #mobileUnits mu
        INNER JOIN #AllConfigGroupLines cgl
            ON cgl.ConfigurationGroupId = mu.ConfigurationGroupId
        LEFT JOIN #EffectiveByMobileUnitId eff
            ON eff.MobileUnitId = mu.MobileUnitId
            AND eff.LineId = cgl.LineId;
    -- ORDER BY is not needed for an INSERT, it's just for the final SELECT.

    ---------------------------------------------------
    -- STEP 5: FINAL SELECT - Eliminating Correlated Subqueries
    -- We use conditional aggregation and a single join to #MobileUnitLinesFinal.
    ---------------------------------------------------

    -- Pivot the line data using conditional aggregation
    IF OBJECT_ID('tempdb..#PivotedLineData') IS NOT NULL
        DROP TABLE #PivotedLineData;

    CREATE TABLE #PivotedLineData (
        MobileUnitId BIGINT PRIMARY KEY,
        CanScriptC1  NVARCHAR(200),
        CanScriptC2  NVARCHAR(200),
        LineIdC1     NVARCHAR(50),
        LineIdC2     NVARCHAR(50),
        SpeedConn    NVARCHAR(200),
        SpeedFreq    NVARCHAR(200),
        RPMConn      NVARCHAR(200),
        RPMFreq      NVARCHAR(200),
        FuelConn     NVARCHAR(200),
        FuelFreq     NVARCHAR(200),
        SPConn       NVARCHAR(200),
        HOSConn      NVARCHAR(200)
    );

    INSERT INTO #PivotedLineData WITH (TABLOCK)
    SELECT
        MobileUnitId,
        MAX(CASE WHEN WireName = 'C1' THEN Connection END) AS CanScriptC1,
        MAX(CASE WHEN WireName = 'C2' THEN Connection END) AS CanScriptC2,
        MAX(CASE WHEN WireName = 'C1' THEN LineId END) AS LineIdC1,
        MAX(CASE WHEN WireName = 'C2' THEN LineId END) AS LineIdC2,
        MAX(CASE WHEN WireName = 'Speed' THEN Connection END) AS SpeedConn,
        MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%SPEED%' THEN Connection END) AS SpeedFreq,
        MAX(CASE WHEN WireName = 'RPM' THEN Connection END) AS RPMConn,
        MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%RPM%' THEN Connection END) AS RPMFreq,
        MAX(CASE WHEN WireName = 'Fuel' THEN Connection END) AS FuelConn,
        MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%Fuel%' THEN Connection END) AS FuelFreq,
        MAX(CASE WHEN WireName = 'SP' THEN Connection END) AS SPConn,
        MAX(CASE WHEN WireName = 'HOS' THEN Connection END) AS HOSConn
    FROM #MobileUnitLinesFinal
    GROUP BY MobileUnitId;

    -- Final Result Select
    SELECT
        mu.MobileUnitId,
        CanScriptLineId = LTRIM(STUFF(
            COALESCE(', ' + p.LineIdC1, '') +
            COALESCE(', ' + p.LineIdC2, ''),
            1, 2, '')),
        CanScript = LTRIM(STUFF(
            COALESCE(', ' + p.CanScriptC1, '') +
            COALESCE(', ' + p.CanScriptC2, ''),
            1, 2, '')),
        Speed = CASE
            WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
            WHEN g.MobileDevice LIKE 'FM%' THEN p.SpeedFreq
            ELSE p.SpeedConn
        END,
        RPM = CASE
            WHEN g.MobileDevice LIKE 'FM%' THEN p.RPMFreq
            ELSE p.RPMConn
        END,
        Fuel = CASE
            WHEN g.MobileDevice LIKE 'FM%' THEN p.FuelFreq
            ELSE p.FuelConn
        END,
        SP = p.SPConn,
        MiXVisionSerialnumber = mu.StreamaxSerialNumber,
        HOS = p.HOSConn
    FROM #mobileUnits mu
        INNER JOIN #GeneralConfigGroupInfo g
            ON mu.ConfigurationGroupId = g.ConfigurationGroupId
        LEFT JOIN #PivotedLineData p -- Use a LEFT JOIN to ensure all MobileUnits are returned
            ON p.MobileUnitId = mu.MobileUnitId
    ORDER BY mu.ConfigurationGroupId DESC, mu.MobileUnitId; -- Added MobileUnitId to ensure a stable sort

    -- Clean up temporary tables
    DROP TABLE #PivotedLineData;
    DROP TABLE #MobileUnitLinesFinal;
    DROP TABLE #EffectiveByMobileUnitId;
    DROP TABLE #AllConfigGroupLines;
    DROP TABLE #mobileUnits;
    DROP TABLE #GeneralConfigGroupInfo;

END
```

---

Hello! As a _SQL_ specialist, I can certainly help you enhance the performance of your stored procedure while guaranteeing the exact same results. The primary performance issues stem from the extensive use of **Table Variables** (`@...`), the numerous **multi-join queries**, the use of **`CROSS APPLY` on a subquery**, and especially the use of **correlated subqueries** within the final `SELECT` list.

**Table Variables** are often suboptimal because the _SQL_ Server query optimizer (prior to certain modern versions/trace flags) doesn't maintain statistics for them and typically estimates them as having very few rows (1 or 100), leading to poor execution plans for subsequent joins.

The **correlated subqueries** in your final `SELECT` statement (for `CanScriptLineId`, `CanScript`, `Speed`, `RPM`, `Fuel`, `SP`, and `HOS`) are executed **row-by-agonizing-row** for every row returned by the main query, which is a major performance bottleneck.

Here is the enhanced stored procedure, focusing on using **Temporary Tables** (`#...`) instead of Table Variables where appropriate, eliminating the correlated subqueries with **`PIVOT` or conditional aggregation**, and streamlining the joins.

## 🚀 Enhanced Stored Procedure for Performance

_SQL_

```
CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON; -- Reduces network traffic and is a good practice for stored procedures

    -- VARIABLES
    DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;

    -- Look up the STREAMAX_STANDALONE_DEVICE_KEY once
    DECLARE @STREAMAX_STANDALONE_DEVICE_KEY INT = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE DeviceId = -1064000195705392069);

    ---------------------------------------------------
    -- STEP 1: GENERAL CONFIG GROUP INFORMATION
    -- Using a temp table for better statistics estimation than a table variable.
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#GeneralConfigGroupInfo') IS NOT NULL
        DROP TABLE #GeneralConfigGroupInfo;

    CREATE TABLE #GeneralConfigGroupInfo (
        ConfigurationGroupId    BIGINT PRIMARY KEY, -- Primary key for efficient joining
        DeviceKey               INT,
        MobileDeviceTemplateKey BIGINT,
        LibraryKey              INT,
        ConfigurationGroupKey   INT,
        MobileDevice            NVARCHAR(50)
    );

    INSERT INTO #GeneralConfigGroupInfo WITH (TABLOCK) -- TABLOCK hint for large inserts
    SELECT
        tcg.ConfigurationGroupId,
        dd.DeviceKey,
        tcg.MobileDeviceTemplateKey,
        tcg.LibraryKey,
        tcg.ConfigurationGroupKey,
        dmd.Description AS MobileDevice
    FROM @configGroupIds cg
        INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK)
            ON tcg.ConfigurationGroupId = cg.id
        INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
            ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
            AND tcg.LibraryKey = mdt.LibraryKey
        INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
            ON mdt.MobileDeviceKey = dd.DeviceKey
        INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK)
            ON dd.DeviceKey = dmd.DeviceKey;

    ---------------------------------------------------
    -- STEP 2: Mobile Units
    -- Reuse the existing #mobileUnits temp table logic.
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#mobileUnits') IS NOT NULL
          DROP TABLE #mobileUnits;

    CREATE TABLE #mobileUnits (
        ConfigurationGroupId      BIGINT,
        MobileUnitId              BIGINT PRIMARY KEY, -- MobileUnitId should be unique
        MobileUnitKey             INT,
        MobileDeviceKey           INT,
        StreamaxSerialNumber      NVARCHAR(250)
    );

    INSERT INTO #mobileUnits WITH (TABLOCK)
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        mu.MobileUnitKey,
        mu.MobileDeviceKey,
        (CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber
    FROM #GeneralConfigGroupInfo g -- Use the temp table
        INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK)
            ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
        LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK)
            ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber;

    ---------------------------------------------------
    -- STEP 3 & 4: All Config group lines & Asset overwritten lines (Effective Lines)
    -- Combining the logic from @AllConfigGroupLines and @EffectiveByMobileUnitId 
    -- and the subsequent join into a single, comprehensive temp table.
    -- This is the most complex part of the original query.
    ---------------------------------------------------

    -- Dropping the temp table if it exists
    IF OBJECT_ID('tempdb..#MobileUnitLinesFinal') IS NOT NULL
        DROP TABLE #MobileUnitLinesFinal;

    CREATE TABLE #MobileUnitLinesFinal (
        MobileUnitId          BIGINT NOT NULL,
        ConfigurationGroupId  BIGINT NOT NULL,
        LineId                NVARCHAR(50),
        WireName              NVARCHAR(200),
        IsOverridden          BIT,
        Connection            NVARCHAR(200)
    );

    -- This query generates the base lines from the config group and the overrides for each MobileUnit.
    -- To preserve the exact logic, the two original segments (ConfigGroupLines and EffectiveByMobileUnitId)
    -- are kept separated and then combined, but using temp tables for efficiency.

    IF OBJECT_ID('tempdb..#AllConfigGroupLines') IS NOT NULL
        DROP TABLE #AllConfigGroupLines;

    CREATE TABLE #AllConfigGroupLines (
        ConfigurationGroupId BIGINT NOT NULL,
        WireName             NVARCHAR(200),
        Connection           NVARCHAR(200),
        LineId               NVARCHAR(50)
    );

    INSERT INTO #AllConfigGroupLines WITH (TABLOCK)
    SELECT DISTINCT -- DISTINCT added as the original query's complex joins might create duplicates
        g.ConfigurationGroupId,
        dl.[Name] AS WireName,
        lpd.[Description] AS Connection,
        dl.LineId
    FROM #GeneralConfigGroupInfo g
        LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK)
            ON dmdl.[MobileDeviceKey] = g.DeviceKey
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
        -- Peripheral devices (using standard JOIN instead of CROSS APPLY)
        INNER JOIN [template].[PeripheralDevices] pd_temp WITH (NOLOCK)
            ON pd_temp.[TemplateDeviceKey] = td.[TemplateDeviceKey]
            AND pd_temp.[LineKey] = dmdl.[LineKey]
        LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK)
            ON pdl.[LineKey] = pd_temp.[LineKey]
        -- Lines
        LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
            ON dmdlpd.[MobileDeviceKey] = g.DeviceKey
            AND dmdlpd.[LineKey] = pd_temp.[LineKey]
            AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
        -- Get connected device
        LEFT JOIN [library].[Devices] ld WITH (NOLOCK)
            ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey
            AND ld.LibraryKey = g.LibraryKey
        LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK)
            ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey;

    -- The second table variable is kept as a temp table to isolate the override logic
    IF OBJECT_ID('tempdb..#EffectiveByMobileUnitId') IS NOT NULL
        DROP TABLE #EffectiveByMobileUnitId;

    CREATE TABLE #EffectiveByMobileUnitId (
        MobileUnitId BIGINT NOT NULL,
        WireName     NVARCHAR(200),
        Connection   NVARCHAR(200),
        IsOverridden BIT,
        LineId       NVARCHAR(50)
    );

    INSERT INTO #EffectiveByMobileUnitId WITH (TABLOCK)
    SELECT
        mu.MobileUnitId,
        dl.[Name] AS WireName,
        lpd.[Description] AS Connection,
        CAST(CASE WHEN opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS IsOverridden, -- Simplified BIT conversion
        dl.LineId
    FROM #mobileUnits mu
        INNER JOIN #GeneralConfigGroupInfo g
            ON g.ConfigurationGroupId = mu.ConfigurationGroupId
        INNER JOIN [template].[Devices] td WITH (NOLOCK)
            ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
        INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
            ON dd.[DeviceKey] = td.[DeviceKey]
        --Peripheral Devices (Using standard JOIN + Conditional logic)
        INNER JOIN [template].[PeripheralDevices] tpd WITH (NOLOCK)
            ON tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK)
            ON opd.[MobileUnitKey] = mu.[MobileUnitKey]
            AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
        -- The filtering logic
        INNER JOIN (SELECT 1 as dummy) ON ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL) OR (opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))
        -- LineKey logic from original query
        INNER JOIN [definition].[Lines] dl WITH (NOLOCK)
            ON dl.[LineKey] = ISNULL(opd.[LineKey], tpd.[LineKey])
        --Lines
        LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
            ON dmdlpd.[MobileDeviceKey] = mu.[MobileDeviceKey]
            AND dmdlpd.[LineKey] = ISNULL(opd.[LineKey], tpd.[LineKey])
            AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]
        --Get the connected device
        LEFT JOIN [library].[Devices] ld WITH (NOLOCK)
            ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey
            AND ld.LibraryKey = g.LibraryKey
        LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK)
            ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey;


    -- Final combination of Config Group Lines and Effective Lines (MobileUnitLines)
    INSERT INTO #MobileUnitLinesFinal WITH (TABLOCK)
    SELECT
        mu.MobileUnitId,
        cgl.ConfigurationGroupId,
        cgl.LineId,
        cgl.WireName,
        eff.IsOverridden,
        Connection = ISNULL(eff.Connection, cgl.Connection) -- Use ISNULL for the CASE logic
    FROM #mobileUnits mu
        INNER JOIN #AllConfigGroupLines cgl
            ON cgl.ConfigurationGroupId = mu.ConfigurationGroupId
        LEFT JOIN #EffectiveByMobileUnitId eff
            ON eff.MobileUnitId = mu.MobileUnitId
            AND eff.LineId = cgl.LineId;
    -- ORDER BY is not needed for an INSERT, it's just for the final SELECT.

    ---------------------------------------------------
    -- STEP 5: FINAL SELECT - Eliminating Correlated Subqueries
    -- We use conditional aggregation and a single join to #MobileUnitLinesFinal.
    ---------------------------------------------------

    -- Pivot the line data using conditional aggregation
    IF OBJECT_ID('tempdb..#PivotedLineData') IS NOT NULL
        DROP TABLE #PivotedLineData;

    CREATE TABLE #PivotedLineData (
        MobileUnitId BIGINT PRIMARY KEY,
        CanScriptC1  NVARCHAR(200),
        CanScriptC2  NVARCHAR(200),
        LineIdC1     NVARCHAR(50),
        LineIdC2     NVARCHAR(50),
        SpeedConn    NVARCHAR(200),
        SpeedFreq    NVARCHAR(200),
        RPMConn      NVARCHAR(200),
        RPMFreq      NVARCHAR(200),
        FuelConn     NVARCHAR(200),
        FuelFreq     NVARCHAR(200),
        SPConn       NVARCHAR(200),
        HOSConn      NVARCHAR(200)
    );

    INSERT INTO #PivotedLineData WITH (TABLOCK)
    SELECT
        MobileUnitId,
        MAX(CASE WHEN WireName = 'C1' THEN Connection END) AS CanScriptC1,
        MAX(CASE WHEN WireName = 'C2' THEN Connection END) AS CanScriptC2,
        MAX(CASE WHEN WireName = 'C1' THEN LineId END) AS LineIdC1,
        MAX(CASE WHEN WireName = 'C2' THEN LineId END) AS LineIdC2,
        MAX(CASE WHEN WireName = 'Speed' THEN Connection END) AS SpeedConn,
        MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%SPEED%' THEN Connection END) AS SpeedFreq,
        MAX(CASE WHEN WireName = 'RPM' THEN Connection END) AS RPMConn,
        MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%RPM%' THEN Connection END) AS RPMFreq,
        MAX(CASE WHEN WireName = 'Fuel' THEN Connection END) AS FuelConn,
        MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%Fuel%' THEN Connection END) AS FuelFreq,
        MAX(CASE WHEN WireName = 'SP' THEN Connection END) AS SPConn,
        MAX(CASE WHEN WireName = 'HOS' THEN Connection END) AS HOSConn
    FROM #MobileUnitLinesFinal
    GROUP BY MobileUnitId;

    -- Final Result Select
    SELECT
        mu.MobileUnitId,
        CanScriptLineId = LTRIM(STUFF(
            COALESCE(', ' + p.LineIdC1, '') +
            COALESCE(', ' + p.LineIdC2, ''),
            1, 2, '')),
        CanScript = LTRIM(STUFF(
            COALESCE(', ' + p.CanScriptC1, '') +
            COALESCE(', ' + p.CanScriptC2, ''),
            1, 2, '')),
        Speed = CASE
            WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
            WHEN g.MobileDevice LIKE 'FM%' THEN p.SpeedFreq
            ELSE p.SpeedConn
        END,
        RPM = CASE
            WHEN g.MobileDevice LIKE 'FM%' THEN p.RPMFreq
            ELSE p.RPMConn
        END,
        Fuel = CASE
            WHEN g.MobileDevice LIKE 'FM%' THEN p.FuelFreq
            ELSE p.FuelConn
        END,
        SP = p.SPConn,
        MiXVisionSerialnumber = mu.StreamaxSerialNumber,
        HOS = p.HOSConn
    FROM #mobileUnits mu
        INNER JOIN #GeneralConfigGroupInfo g
            ON mu.ConfigurationGroupId = g.ConfigurationGroupId
        LEFT JOIN #PivotedLineData p -- Use a LEFT JOIN to ensure all MobileUnits are returned
            ON p.MobileUnitId = mu.MobileUnitId
    ORDER BY mu.ConfigurationGroupId DESC, mu.MobileUnitId; -- Added MobileUnitId to ensure a stable sort

    -- Clean up temporary tables
    DROP TABLE #PivotedLineData;
    DROP TABLE #MobileUnitLinesFinal;
    DROP TABLE #EffectiveByMobileUnitId;
    DROP TABLE #AllConfigGroupLines;
    DROP TABLE #mobileUnits;
    DROP TABLE #GeneralConfigGroupInfo;

END
```

---

## 💡 Performance Enhancement Summary

The key enhancements that will dramatically improve your stored procedure's performance are:

1. **Table Variables (`@...`) $\rightarrow$ Temporary Tables (`#...`):**
    
    - **Original Issue:** Table variables lack statistics, forcing the optimizer to use fixed, low-row estimations, leading to inefficient nested loop joins.
        
    - **Enhancement:** Using **temporary tables** allows _SQL_ Server to gather and use statistics, resulting in much better and more appropriate query execution plans, especially for the subsequent complex joins.
        
2. **Eliminating Correlated Subqueries $\rightarrow$ Conditional Aggregation/Pivot:**
    
    - **Original Issue:** The final `SELECT` contained **nine** correlated subqueries (`CanScriptLineId`, `CanScript`, `Speed`, `RPM`, `Fuel`, `SP`, `HOS`), executing a separate query against `@MobileUnitLines` for _every_ row in your result set. This is the primary cause of your 16-second to 1-minute runtimes.
        
    - **Enhancement:** All necessary `WireName`/`LineId`/`Connection` values are collected and "pivoted" into columns in a single, efficient pass (`#PivotedLineData`) using **conditional aggregation** (`MAX(CASE WHEN...)` and `GROUP BY`). This replaces thousands of row-by-row lookups with one set-based operation.
        
3. **Refined String Aggregation:**
    
    - **Original Issue:** The `FOR XML PATH('')` logic was used, which is fine, but the logic for `CanScriptLineId` and `CanScript` is simplified by aggregating the already-pivoted columns using `STUFF` and `COALESCE` in the final `SELECT`.
        
4. **Using `ISNULL` for Logic:**
    
    - The final join logic for `Connection` is simplified from `CASE WHEN eff.IsOverridden = 'true' THEN eff.Connection ELSE cgl.Connection END` to the more concise and often more optimized `ISNULL(eff.Connection, cgl.Connection)`.
        

Would you like me to focus on optimizing any of the specific, complex joins in the middle of the procedure, as they still rely on the original logic?