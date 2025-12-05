USE [DeviceConfiguration];
GO

-- This script breaks down the final query into smaller, sequential steps.
-- Run each block of code one by one to find exactly where the error occurs.

-- =================================================================
-- Setup: Declare variables and insert data
-- =================================================================
PRINT 'Step 1: Declaring variables and populating table. This should pass.';

DECLARE @configGroupIds [dbo].[SelectionIds];
INSERT INTO @configGroupIds (id)
VALUES
    (-2803813420773469362), (2557659825063191210), (-6039078778185809084), (3189959622678903378), (1989001888637459309), (-9078750292130215188), (-3274353763833670263), (1232298188016006398), (4631052128945276764), (-3251388662902899727), (-1806774282659967806), (5918913735931167160), (8799631723342597089), (-8162147584136025918), (-1307004388228739243), (-6257508969252238550), (8312559892687542597), (-1323496424401963304), (-2524931806030160341), (3681922843152348030), (3209265185920104888), (5621177276048465690), (-8126655682067440340), (-6836621200088256507), (3780592447908270856), (1223784011986591945), (-3366261590319731458), (-7392764503748298046), (-7629839428314466340), (7187708927592996236), (-1635591222982510535), (-6151357456724753887), (-5912082017677079777), (-5390337933230695538), (-4067179943998429825), (1364631742777966163), (-7653538731568077332), (-7668187040444806181), (4208572072426061348), (3362884251134407151), (-3893536691584770708), (-6084966262084607888), (3774723236452900354), (-2723417818245426945), (-3836116117686479120), (-7382401016514304197), (7518319533563758380), (3813205176926613669), (5916945531324722255), (-5159253166163790691), (-2147059355369176559), (60036256406525452), (767833652034630589), (-6328313109361883502), (1287625066743264402), (2505696365882641504), (1240957115574012888), (-2374899645906010889), (3739189965094689367), (8235264728202292851), (-1136609960426082090), (4505193432618700901), (6775426529790173259), (-3798194295803321659), (-8871627763454545305), (-2110415703208626075), (-5801394207784667707), (4309917650092943416), (6143152948325390557), (2237002883694620525), (-6366678994605550120), (881148683257612107), (-7944209854350725335), (3559248872843565414), (3168786260864673578), (7598006177779832207), (-1923500799342536831), (-1733893171984566420), (-8642220154752102213), (5009320484667002586), (-8507561780508819492), (7115023718153513169), (8724893352726780856), (-383605210349505097), (-2310911944299775966);

DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
DECLARE @STREAMAX_STANDALONE_DEVICE_KEY INT = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE DeviceId = -1064000195705392069);
GO

-- =================================================================
-- Step 2: Base CTEs (GeneralConfigGroupInfo, MobileUnits)
-- =================================================================
PRINT 'Step 2: Running the first two CTEs (GeneralConfigGroupInfo, MobileUnits). You said this part was fine.';

WITH GeneralConfigGroupInfo AS (
    SELECT
        tcg.ConfigurationGroupId,
        dd.DeviceKey,
        tcg.MobileDeviceTemplateKey,
        tcg.LibraryKey,
        tcg.ConfigurationGroupKey,
        dmd.Description AS MobileDevice
    FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = TRY_CAST(cg.id AS BIGINT)
    INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey AND tcg.LibraryKey = mdt.LibraryKey
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
    INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
),
MobileUnits AS (
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        mu.MobileUnitKey,
        mu.MobileDeviceKey,
        (CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber
    FROM GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber
)
SELECT TOP 10 * FROM MobileUnits;
GO

-- =================================================================
-- Step 3: Add the 'AllLines' CTE
-- =================================================================
PRINT 'Step 3: Adding the AllLines CTE. Check if the error happens here.';

WITH GeneralConfigGroupInfo AS (
    SELECT
        tcg.ConfigurationGroupId,
        dd.DeviceKey,
        tcg.MobileDeviceTemplateKey,
        tcg.LibraryKey,
        tcg.ConfigurationGroupKey,
        dmd.Description AS MobileDevice
    FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = TRY_CAST(cg.id AS BIGINT)
    INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey AND tcg.LibraryKey = mdt.LibraryKey
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
    INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
),
MobileUnits AS (
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        mu.MobileUnitKey,
        mu.MobileDeviceKey,
        (CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber
    FROM GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber
),
AllLines AS (
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        dl.LineId,
        dl.Name AS WireName,
        COALESCE(lpd_overridden.Description, lpd_template.Description) AS Connection,
        CASE WHEN opd.MobileUnitKey IS NOT NULL THEN 'true' ELSE 'false' END AS IsOverridden
    FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey AND g.LibraryKey = td.LibraryKey
    INNER JOIN [template].[PeripheralDevices] tpd WITH (NOLOCK) ON tpd.TemplateDeviceKey = td.TemplateDeviceKey AND tpd.LineKey IS NOT NULL
    LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) ON opd.MobileUnitKey = mu.MobileUnitKey AND opd.TemplateDeviceKey = tpd.TemplateDeviceKey AND opd.LineKey IS NOT NULL
    INNER JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.LineKey = COALESCE(opd.LineKey, tpd.LineKey)
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.DeviceKey = td.DeviceKey
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd_template WITH (NOLOCK) ON dmdlpd_template.MobileDeviceKey = g.DeviceKey AND dmdlpd_template.LineKey = tpd.LineKey AND dmdlpd_template.PeripheralDeviceKey = tdd.DeviceKey
    LEFT JOIN [library].[Devices] ld_template WITH (NOLOCK) ON ld_template.DeviceKey = dmdlpd_template.PeripheralDeviceKey AND ld_template.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd_template WITH (NOLOCK) ON lpd_template.LibraryDeviceKey = ld_template.LibraryDeviceKey
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd_overridden WITH (NOLOCK) ON dmdlpd_overridden.MobileDeviceKey = mu.MobileDeviceKey AND dmdlpd_overridden.LineKey = opd.LineKey AND dmdlpd_overridden.PeripheralDeviceKey = tdd.DeviceKey
    LEFT JOIN [library].[Devices] ld_overridden WITH (NOLOCK) ON ld_overridden.DeviceKey = dmdlpd_overridden.PeripheralDeviceKey AND ld_overridden.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd_overridden WITH (NOLOCK) ON lpd_overridden.LibraryDeviceKey = ld_overridden.LibraryDeviceKey
)
SELECT TOP 10 * FROM AllLines;
GO

-- =================================================================
-- Step 4: Add the 'PivotedLines' CTE
-- =================================================================
PRINT 'Step 4: Adding the PivotedLines CTE. Check if the error happens here.';

WITH GeneralConfigGroupInfo AS (
    SELECT
        tcg.ConfigurationGroupId,
        dd.DeviceKey,
        tcg.MobileDeviceTemplateKey,
        tcg.LibraryKey,
        tcg.ConfigurationGroupKey,
        dmd.Description AS MobileDevice
    FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = TRY_CAST(cg.id AS BIGINT)
    INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey AND tcg.LibraryKey = mdt.LibraryKey
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
    INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
),
MobileUnits AS (
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        mu.MobileUnitKey,
        mu.MobileDeviceKey,
        (CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber
    FROM GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber
),
AllLines AS (
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        dl.LineId,
        dl.Name AS WireName,
        COALESCE(lpd_overridden.Description, lpd_template.Description) AS Connection,
        CASE WHEN opd.MobileUnitKey IS NOT NULL THEN 'true' ELSE 'false' END AS IsOverridden
    FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey AND g.LibraryKey = td.LibraryKey
    INNER JOIN [template].[PeripheralDevices] tpd WITH (NOLOCK) ON tpd.TemplateDeviceKey = td.TemplateDeviceKey AND tpd.LineKey IS NOT NULL
    LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) ON opd.MobileUnitKey = mu.MobileUnitKey AND opd.TemplateDeviceKey = tpd.TemplateDeviceKey AND opd.LineKey IS NOT NULL
    INNER JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.LineKey = COALESCE(opd.LineKey, tpd.LineKey)
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.DeviceKey = td.DeviceKey
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd_template WITH (NOLOCK) ON dmdlpd_template.MobileDeviceKey = g.DeviceKey AND dmdlpd_template.LineKey = tpd.LineKey AND dmdlpd_template.PeripheralDeviceKey = tdd.DeviceKey
    LEFT JOIN [library].[Devices] ld_template WITH (NOLOCK) ON ld_template.DeviceKey = dmdlpd_template.PeripheralDeviceKey AND ld_template.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd_template WITH (NOLOCK) ON lpd_template.LibraryDeviceKey = ld_template.LibraryDeviceKey
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd_overridden WITH (NOLOCK) ON dmdlpd_overridden.MobileDeviceKey = mu.MobileDeviceKey AND dmdlpd_overridden.LineKey = opd.LineKey AND dmdlpd_overridden.PeripheralDeviceKey = tdd.DeviceKey
    LEFT JOIN [library].[Devices] ld_overridden WITH (NOLOCK) ON ld_overridden.DeviceKey = dmdlpd_overridden.PeripheralDeviceKey AND ld_overridden.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd_overridden WITH (NOLOCK) ON lpd_overridden.LibraryDeviceKey = ld_overridden.LibraryDeviceKey
),
PivotedLines AS (
    SELECT
        mu.MobileUnitId,
        g.MobileDevice,
        mu.StreamaxSerialNumber AS MiXVisionSerialnumber,
        MAX(CASE WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
                 WHEN g.MobileDevice LIKE 'FM%' AND l.WireName LIKE 'F%' AND l.Connection LIKE '%SPEED%' THEN l.Connection
                 WHEN l.WireName = 'Speed' THEN l.Connection
            END) AS Speed,
        MAX(CASE WHEN g.MobileDevice LIKE 'FM%' AND l.WireName LIKE 'F%' AND l.Connection LIKE '%RPM%' THEN l.Connection
                 WHEN l.WireName = 'RPM' THEN l.Connection
            END) AS RPM,
        MAX(CASE WHEN g.MobileDevice LIKE 'FM%' AND l.WireName LIKE 'F%' AND l.Connection LIKE '%Fuel%' THEN l.Connection
                 WHEN l.WireName = 'Fuel' THEN l.Connection
            END) AS Fuel,
        MAX(CASE WHEN l.WireName = 'SP' THEN l.Connection END) AS SP,
        MAX(CASE WHEN l.WireName = 'HOS' THEN l.Connection END) AS HOS
    FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    LEFT JOIN AllLines l ON mu.MobileUnitId = l.MobileUnitId
    GROUP BY
        mu.MobileUnitId,
        g.MobileDevice,
        mu.StreamaxSerialNumber
)
SELECT TOP 10 * FROM PivotedLines;
GO

-- =================================================================
-- Step 5: Add the 'AggregatedLines' CTE and Final SELECT
-- =================================================================
PRINT 'Step 5: Running the full query. Check if the error happens here.';

WITH GeneralConfigGroupInfo AS (
    SELECT
        tcg.ConfigurationGroupId,
        dd.DeviceKey,
        tcg.MobileDeviceTemplateKey,
        tcg.LibraryKey,
        tcg.ConfigurationGroupKey,
        dmd.Description AS MobileDevice
    FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = TRY_CAST(cg.id AS BIGINT)
    INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey AND tcg.LibraryKey = mdt.LibraryKey
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
    INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
),
MobileUnits AS (
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        mu.MobileUnitKey,
        mu.MobileDeviceKey,
        (CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber
    FROM GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber
),
AllLines AS (
    SELECT
        g.ConfigurationGroupId,
        mu.MobileUnitId,
        dl.LineId,
        dl.Name AS WireName,
        COALESCE(lpd_overridden.Description, lpd_template.Description) AS Connection,
        CASE WHEN opd.MobileUnitKey IS NOT NULL THEN 'true' ELSE 'false' END AS IsOverridden
    FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey AND g.LibraryKey = td.LibraryKey
    INNER JOIN [template].[PeripheralDevices] tpd WITH (NOLOCK) ON tpd.TemplateDeviceKey = td.TemplateDeviceKey AND tpd.LineKey IS NOT NULL
    LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) ON opd.MobileUnitKey = mu.MobileUnitKey AND opd.TemplateDeviceKey = tpd.TemplateDeviceKey AND opd.LineKey IS NOT NULL
    INNER JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.LineKey = COALESCE(opd.LineKey, tpd.LineKey)
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.DeviceKey = td.DeviceKey
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd_template WITH (NOLOCK) ON dmdlpd_template.MobileDeviceKey = g.DeviceKey AND dmdlpd_template.LineKey = tpd.LineKey AND dmdlpd_template.PeripheralDeviceKey = tdd.DeviceKey
    LEFT JOIN [library].[Devices] ld_template WITH (NOLOCK) ON ld_template.DeviceKey = dmdlpd_template.PeripheralDeviceKey AND ld_template.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd_template WITH (NOLOCK) ON lpd_template.LibraryDeviceKey = ld_template.LibraryDeviceKey
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd_overridden WITH (NOLOCK) ON dmdlpd_overridden.MobileDeviceKey = mu.MobileDeviceKey AND dmdlpd_overridden.LineKey = opd.LineKey AND dmdlpd_overridden.PeripheralDeviceKey = tdd.DeviceKey
    LEFT JOIN [library].[Devices] ld_overridden WITH (NOLOCK) ON ld_overridden.DeviceKey = dmdlpd_overridden.PeripheralDeviceKey AND ld_overridden.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd_overridden WITH (NOLOCK) ON lpd_overridden.LibraryDeviceKey = ld_overridden.LibraryDeviceKey
),
PivotedLines AS (
    SELECT
        mu.MobileUnitId,
        g.MobileDevice,
        mu.StreamaxSerialNumber AS MiXVisionSerialnumber,
        MAX(CASE WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
                 WHEN g.MobileDevice LIKE 'FM%' AND l.WireName LIKE 'F%' AND l.Connection LIKE '%SPEED%' THEN l.Connection
                 WHEN l.WireName = 'Speed' THEN l.Connection
            END) AS Speed,
        MAX(CASE WHEN g.MobileDevice LIKE 'FM%' AND l.WireName LIKE 'F%' AND l.Connection LIKE '%RPM%' THEN l.Connection
                 WHEN l.WireName = 'RPM' THEN l.Connection
            END) AS RPM,
        MAX(CASE WHEN g.MobileDevice LIKE 'FM%' AND l.WireName LIKE 'F%' AND l.Connection LIKE '%Fuel%' THEN l.Connection
                 WHEN l.WireName = 'Fuel' THEN l.Connection
            END) AS Fuel,
        MAX(CASE WHEN l.WireName = 'SP' THEN l.Connection END) AS SP,
        MAX(CASE WHEN l.WireName = 'HOS' THEN l.Connection END) AS HOS
    FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    LEFT JOIN AllLines l ON mu.MobileUnitId = l.MobileUnitId
    GROUP BY
        mu.MobileUnitId,
        g.MobileDevice,
        mu.StreamaxSerialNumber
),
AggregatedLines AS (
    SELECT
        l.MobileUnitId,
        CanScriptLineId = STUFF((
            SELECT ', ' + l2.LineId
            FROM AllLines l2
            WHERE l2.MobileUnitId = l.MobileUnitId
            AND l2.WireName IN ('C1', 'C2')
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
        CanScript = STUFF((
            SELECT ', ' + l2.Connection
            FROM AllLines l2
            WHERE l2.MobileUnitId = l.MobileUnitId
            AND l2.WireName IN ('C1', 'C2')
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '')
    FROM AllLines l
    GROUP BY l.MobileUnitId
)
SELECT
    p.MobileUnitId,
    al.CanScriptLineId,
    al.CanScript,
    p.Speed,
    p.RPM,
    p.Fuel,
    p.SP,
    p.MiXVisionSerialnumber,
    p.HOS
FROM PivotedLines p
LEFT JOIN AggregatedLines al ON p.MobileUnitId = al.MobileUnitId;
GO