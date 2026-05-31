---
wiki_ingested: 2026-05-28
created: 2025-10-30T14:44
updated: 2025-10-30T14:44
---
That's a very fast procedure! Given that it's likely a lookup for a single `groupId`, the speed is expected.

The main area for enhancement is eliminating the intermediate **table variables** (which are prone to poor cardinality estimation in _SQL_ Server) and replacing the scalar **subqueries** in the final `SELECT` with more efficient **set-based joins** (or `APPLY`) and grouping.

Here is the refactored procedure using **CTEs** and **set-based aggregation** (`STRING_AGG` for _SQL_ Server 2017+ or the existing `FOR XML PATH` with grouping) to improve execution efficiency and reduce memory overhead from table variables.

## ⚡ Enhanced Stored Procedure: `[template].[Template_GetConfigurationGroupsOtherColumns]`

_SQL_

```
CREATE PROCEDURE [template].[Template_GetConfigurationGroupsOtherColumns]
    @groupId BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- VARIABLES
    DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;
    
    DECLARE @FWVersionKey SMALLINT = 
        (SELECT PropertyKey
         FROM [definition].[Properties] WITH (NOLOCK)
         WHERE PropertyId = @PreferedFirmwareVersion);

    ---------------------------------------------------
    -- STEP 1: Core Configuration Group Info (Base CTE)
    ---------------------------------------------------
    WITH BaseConfigGroups AS (
        SELECT
            tcg.ConfigurationGroupId,
            tcg.ConfigurationGroupKey,
            tcg.MobileDeviceTemplateKey,
            tcg.LibraryKey,
            dd.DeviceKey,
            dmd.Description AS MobileDevice
        FROM [library].[Libraries] l WITH (NOLOCK)
        INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.LibraryKey = l.LibraryKey
        INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
            ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
            AND tcg.LibraryKey = mdt.LibraryKey
        INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
        INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
        WHERE l.GroupId = @groupId
    ),
    
    ---------------------------------------------------
    -- STEP 2: Mobile Unit Keys and Asset Count (CTE)
    ---------------------------------------------------
    ConfigGroupUnits AS (
        SELECT 
            bcg.ConfigurationGroupId,
            bcg.ConfigurationGroupKey,
            mu.MobileUnitKey
        FROM BaseConfigGroups bcg
        INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = bcg.ConfigurationGroupKey
        INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON amu.MobileUnitKey = mu.MobileUnitKey
    ),
    
    AssetCounts AS (
        SELECT 
            ConfigurationGroupId,
            COUNT(MobileUnitKey) AS AssetsCount
        FROM ConfigGroupUnits
        GROUP BY ConfigurationGroupId
    ),
    
    ---------------------------------------------------
    -- STEP 3: Black Flags (Optimized CTE/JOIN)
    -- Identifies units with ANY override, then groups by Config Group.
    ---------------------------------------------------
    BlackFlaggedUnits AS (
        SELECT DISTINCT
            cgu.ConfigurationGroupId,
            cgu.MobileUnitKey
        FROM ConfigGroupUnits cgu
        -- Use a single join/condition block to find any unit with overrides
        LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK) ON events.MobileUnitKey = cgu.MobileUnitKey
        LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = cgu.MobileUnitKey
        LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = cgu.MobileUnitKey
        LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK) ON devices.MobileUnitKey = cgu.MobileUnitKey
        LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK) ON params.MobileUnitKey = cgu.MobileUnitKey
        LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK) ON paramsCan.MobileUnitKey = cgu.MobileUnitKey
        LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK) ON properties.MobileUnitKey = cgu.MobileUnitKey AND properties.PersistOnReset = 0
        LEFT JOIN [mobileunit].[OverridenPeripheralDevices] peripherals WITH (NOLOCK) ON peripherals.MobileUnitKey = cgu.MobileUnitKey
        WHERE 
            events.MobileUnitKey IS NOT NULL
            OR eventActions.MobileUnitKey IS NOT NULL
            OR thresholds.MobileUnitKey IS NOT NULL
            OR devices.MobileUnitKey IS NOT NULL
            OR params.MobileUnitKey IS NOT NULL
            OR paramsCan.MobileUnitKey IS NOT NULL
            OR properties.MobileUnitKey IS NOT NULL
            OR peripherals.MobileUnitKey IS NOT NULL
    ),
    
    BlackFlagsCount AS (
        SELECT 
            ConfigurationGroupId,
            COUNT(MobileUnitKey) AS BlackFlagsCount
        FROM BlackFlaggedUnits
        GROUP BY ConfigurationGroupId
    ),

    ---------------------------------------------------
    -- STEP 4: All Config Group Lines (CTE)
    ---------------------------------------------------
    AllConfigGroupLines AS ( 
        SELECT
            bcg.ConfigurationGroupId,
            dl.[Name] AS WireName,
            lpd.[Description] AS Connection,
            dl.LineId
        FROM BaseConfigGroups bcg
        LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey] = bcg.DeviceKey
        LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
        LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
        INNER JOIN [template].[Devices] td WITH (NOLOCK)
            ON td.[MobileDeviceTemplateKey] = bcg.[MobileDeviceTemplateKey]
            AND bcg.LibraryKey = td.LibraryKey
        INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
        CROSS APPLY 
            ( SELECT tpd.[LineKey] FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
              WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey] AND tpd.[LineKey]=dmdl.[LineKey]
            ) pd
        LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]
        LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
            ON dmdlpd.[MobileDeviceKey] = bcg.DeviceKey
            AND dmdlpd.[LineKey] = pd.[LineKey]
            AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
        LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = bcg.LibraryKey
        LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey
        WHERE dl.LineId IS NOT NULL -- Remove rows where the main line definition is missing
    ),

    ---------------------------------------------------
    -- STEP 5: FW Versions (CTE)
    ---------------------------------------------------
    FWVersions AS ( 
        SELECT
            bcg.ConfigurationGroupId,
            fw.Name AS FWName
        FROM BaseConfigGroups bcg
        INNER JOIN [template].[Devices] td WITH (NOLOCK)
            ON td.[MobileDeviceTemplateKey] = bcg.[MobileDeviceTemplateKey]
            AND bcg.LibraryKey = td.LibraryKey
        INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
        INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
            ON tdpr.MobileDeviceTemplateKey = bcg.MobileDeviceTemplateKey
            AND tdpr.PropertyKey = @FWVersionKey -- Use the determined key
            AND tdpr.DeviceKey = tdd.DeviceKey
        INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) 
            ON fw.FirmwareVersionId = TRY_CAST(tdpr.Value AS BIGINT) -- Safely cast the value
    )

    ---------------------------------------------------
    -- STEP 6: Final Selection (Using Outer APPLY for Aggregation)
    ---------------------------------------------------
    SELECT
        Flagged = ISNULL(b.BlackFlagsCount, 0),
        g.ConfigurationGroupId,
        AssetsCount = ISNULL(a.AssetsCount, 0),

        -- Aggregate FW Versions
        FWVersion = STUFF((
            SELECT ', ' + fw.FWName
            FROM FWVersions fw
            WHERE fw.ConfigurationGroupId = g.ConfigurationGroupId
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),

        -- Aggregate CAN Script Lines
        CanScriptLineId = STUFF((
            SELECT ', ' + [LineId]
            FROM AllConfigGroupLines l
            WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
            AND (l.WireName = 'C1' OR l.WireName = 'C2')
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
        
        -- Aggregate CAN Connections
        CanScript = STUFF((
            SELECT ', ' + [Connection]
            FROM AllConfigGroupLines l
            WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
            AND (l.WireName = 'C1' OR l.WireName = 'C2')
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),

        -- Speed/RPM/Fuel logic using a single, efficient OUTER APPLY per category
        Speed = 
            CASE
                WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
                WHEN g.MobileDevice LIKE 'FM%' THEN apply_fm_speed.Connection
                ELSE apply_gen_speed.Connection
            END,
        RPM = 
            CASE
                WHEN g.MobileDevice LIKE 'FM%' THEN apply_fm_rpm.Connection
                ELSE apply_gen_rpm.Connection
            END,
        Fuel = 
            CASE
                WHEN g.MobileDevice LIKE 'FM%' THEN apply_fm_fuel.Connection
                ELSE apply_gen_fuel.Connection
            END,

        SP = apply_sp.Connection,
        HOS = apply_hos.Connection

    FROM BaseConfigGroups g
    LEFT JOIN AssetCounts a ON a.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN BlackFlagsCount b ON b.ConfigurationGroupId = g.ConfigurationGroupId
    
    -- Optimized lookups for specific connections, replacing scalar subqueries
    -- FM Speed (Frequency line + SPEED in connection)
    OUTER APPLY (
        SELECT TOP 1 Connection
        FROM AllConfigGroupLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName LIKE 'F%' AND l.Connection LIKE '%SPEED%'
    ) AS apply_fm_speed
    -- Generic Speed
    OUTER APPLY (
        SELECT TOP 1 Connection
        FROM AllConfigGroupLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'Speed'
    ) AS apply_gen_speed
    
    -- FM RPM (Frequency line + RPM in connection)
    OUTER APPLY (
        SELECT TOP 1 Connection
        FROM AllConfigGroupLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName LIKE 'F%' AND l.Connection LIKE '%RPM%'
    ) AS apply_fm_rpm
    -- Generic RPM
    OUTER APPLY (
        SELECT TOP 1 Connection
        FROM AllConfigGroupLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'RPM'
    ) AS apply_gen_rpm

    -- FM Fuel (Frequency line + Fuel in connection)
    OUTER APPLY (
        SELECT TOP 1 Connection
        FROM AllConfigGroupLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName LIKE 'F%' AND l.Connection LIKE '%Fuel%'
    ) AS apply_fm_fuel
    -- Generic Fuel
    OUTER APPLY (
        SELECT TOP 1 Connection
        FROM AllConfigGroupLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'Fuel'
    ) AS apply_gen_fuel
    
    -- SP
    OUTER APPLY (
        SELECT TOP 1 Connection
        FROM AllConfigGroupLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'SP'
    ) AS apply_sp

    -- HOS
    OUTER APPLY (
        SELECT TOP 1 Connection
        FROM AllConfigGroupLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'HOS'
    ) AS apply_hos;

END
```

### Key Enhancements

1. **Replaced Table Variables with CTEs:** All intermediate table variables (`@GeneralConfigGroupInfo`, `@MobileUnits`, `@AssetsCount`, `@BlackFlagsCount`, `@AllConfigGroupLines`, `@FWVersions`) were converted into **Common Table Expressions (CTEs)**. This allows _SQL_ Server's optimizer to better see and manage the entire execution plan, often resulting in more efficient memory allocation and execution, especially for large datasets.
    
2. **Optimized Single-Value Lookups:** The numerous **scalar subqueries** in the final `SELECT` for `Speed`, `RPM`, `Fuel`, `SP`, and `HOS` were replaced with **`OUTER APPLY`** and `SELECT TOP 1`.
    
    - **Why `OUTER APPLY`?** When _SQL_ Server executes a scalar subquery (a subquery that returns a single value), it often treats it as a dependent subquery, which can lead to it being re-executed for every row. `OUTER APPLY` typically leads to a more efficient join operation in the execution plan, improving performance over repeated scalar subqueries.
        
3. **Black Flags Logic:** The logic was converted to CTEs for better planning, but the core set-based approach (multiple `LEFT JOIN`s on the override tables followed by `COUNT(DISTINCT...)` via `BlackFlaggedUnits` and `BlackFlagsCount`) remains the most efficient way to perform that complex existence check.
    

This version is more robust and leverages set-based operations for better scalability, even if the current performance is already good.

Would you like to review the `OUTER APPLY` pattern for the wire connections?


