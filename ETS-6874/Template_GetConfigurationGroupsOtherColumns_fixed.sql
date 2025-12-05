--NEWER CG OTHER
USE DeviceConfiguration;

DECLARE  @groupId BIGINT = -7094567047859310012;

  
  


  --VARIABLES
  DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;

  DECLARE @FWVersion SMALLINT = 
        (SELECT PropertyKey
  FROM [definition].[Properties] WITH (NOLOCK)
  WHERE PropertyId = @PreferedFirmwareVersion);


  -- GENERAL INFORMATION
  DECLARE @GeneralConfigGroupInfo TABLE
    (
    ConfigurationGroupId     BIGINT,
    ConfigurationGroupKey    INT,
    MobileDeviceTemplateKey  BIGINT,
    LibraryKey               INT,
    DeviceKey                INT,
    MobileDevice             NVARCHAR(50)
    )
  INSERT INTO @GeneralConfigGroupInfo
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


  -- ASSET COUNT
  -- Mobile Units
  DECLARE @MobileUnits TABLE
    (
    ConfigurationGroupId  BIGINT,
    ConfigurationGroupKey INT,
    MobileUnitKey         INT
    )
  INSERT INTO @MobileUnits
  SELECT g.ConfigurationGroupId, mu.ConfigurationGroupKey, (mu.MobileUnitKey)
  FROM @GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON amu.MobileUnitKey = mu.MobileUnitKey
  -- Asset Count per Config Group
  DECLARE @AssetsCount TABLE
    (
    ConfigurationGroupId BIGINT,
    AssetsCount          INT
    )
  INSERT INTO @AssetsCount
  SELECT g.ConfigurationGroupId, Count(mu.MobileUnitKey)
  FROM @GeneralConfigGroupInfo g
    INNER JOIN @MobileUnits mu ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
  GROUP BY g.ConfigurationGroupId


  -- FLAGS
  DECLARE @BlackFlagsCount TABLE
    (
    ConfigurationGroupId BIGINT,
    BlackFlagsCount      INT
    )
  INSERT INTO @BlackFlagsCount
  SELECT ConfigurationGroupId, COUNT(MobileUnitKey)
  FROM
    (
        SELECT DISTINCT mu.ConfigurationGroupId AS ConfigurationGroupId, mu.MobileUnitKey AS MobileUnitKey
    FROM @MobileUnits mu
      --Overwritten Events
      LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK) ON events.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = mu.MobileUnitKey
      --Overwritten Device Info
      LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK) ON devices.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
      LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK) ON properties.MobileUnitKey = mu.MobileUnitKey AND properties.PersistOnReset = 0
      LEFT JOIN [mobileunit].[OverridenPeripheralDevices] peripherals WITH (NOLOCK) ON peripherals.MobileUnitKey = mu.MobileUnitKey
    WHERE 
        (
            events.MobileUnitKey IS NOT NULL
      OR eventActions.MobileUnitKey IS NOT NULL
      OR thresholds.MobileUnitKey IS NOT NULL
      OR devices.MobileUnitKey IS NOT NULL
      OR params.MobileUnitKey IS NOT NULL
      OR paramsCan.MobileUnitKey IS NOT NULL
      OR properties.MobileUnitKey IS NOT NULL
      OR peripherals.MobileUnitKey IS NOT NULL
        )
    ) AS uniqueRows
  GROUP BY ConfigurationGroupId


  -- LINES
  DECLARE @AllConfigGroupLines TABLE  
    (
    [ConfigurationGroupId] BIGINT,
    [WireName]             NVARCHAR(200),
    [Connection]           NVARCHAR(200),
    [LineId]               NVARCHAR(50)
    );
  INSERT INTO @AllConfigGroupLines
  SELECT
    [ConfigurationGroupId] = g.ConfigurationGroupId,
    [WireName] = dl.[Name],
    [Connection] = lpd.[Description],
    [LineId] = dl.LineId
  FROM @GeneralConfigGroupInfo g
    LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey]   = g.DeviceKey
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
    LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
    --Template Devices
    INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
      AND g.LibraryKey = td.LibraryKey
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
    -- Peripheral devices
    CROSS APPLY 
        ( SELECT
      [LineKey] = tpd.[LineKey]
    FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
    WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
      AND tpd.[LineKey]=dmdl.[LineKey]
        ) pd
    LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]
    -- Lines
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
    ON dmdlpd.[MobileDeviceKey]      = g.DeviceKey --mu.[MobileDeviceKey]
      AND dmdlpd.[LineKey]             = pd.[LineKey]
      AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
    -- Get connected device
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey


  -- NEW FIRMWARE BELOW



----------------------------------------------------------------------------------------------------

/*
-- Check what properties exist for your config groups
SELECT 
  g.ConfigurationGroupId,
  g.MobileDeviceTemplateKey,
  g.DeviceKey,
  tdpr.*
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
ORDER BY g.ConfigurationGroupId


-- Check if the PropertyKey filter is the issue
SELECT 
  g.ConfigurationGroupId,
  @FWVersion as 'Looking_For_PropertyKey',
  tdpr.PropertyKey,
  tdpr.DeviceKey,
  g.DeviceKey as 'Expected_DeviceKey',
  tdpr.*
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.PropertyKey = @FWVersion
ORDER BY g.ConfigurationGroupId



-- Run this to see what's causing multiple results
SELECT 
  g.ConfigurationGroupId,
  g.ConfigurationGroupKey,
  g.MobileDeviceTemplateKey,
  g.DeviceKey,
  tdpr.*, -- This will show ALL columns from DeviceProperties so we can see the structure
  fw.Name as 'FWName'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.PropertyKey = @FWVersion
    AND tdpr.DeviceKey = g.DeviceKey
  INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) 
    ON fw.FirmwareVersionId = tdpr.Value
ORDER BY g.ConfigurationGroupId
*/


/*
-- Check if the PropertyKey filter is the issue
SELECT 
  g.ConfigurationGroupId,
  @FWVersion as 'Looking_For_PropertyKey',
  tdpr.PropertyKey,
  tdpr.DeviceKey,
  g.DeviceKey as 'Expected_DeviceKey',
  CASE WHEN tdpr.DeviceKey = g.DeviceKey THEN 'MATCH' ELSE 'NO MATCH' END as 'DeviceKey_Match',
  tdpr.*
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.PropertyKey = @FWVersion
    
    
    --SIMPLIFY: TODO: MR: Remove again
    WHERE g.ConfigurationGroupId IN (-7668187040444806181, -3251388662902899727)

ORDER BY g.ConfigurationGroupId
*/


/*
-- Find which device in the template is the actual mobile device
SELECT 
  g.ConfigurationGroupId,
  g.DeviceKey as 'MainMobileDeviceKey_From_Template',
  td.DeviceKey as 'TemplateDeviceKey',
  dd.*,  -- Show all columns from Devices
  md.DeviceKey as 'IsMobileDevice_DeviceKey',
  CASE WHEN md.DeviceKey IS NOT NULL THEN 'YES' ELSE 'NO' END as 'IsActualMobileDevice'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = td.DeviceKey
  LEFT JOIN [definition].[MobileDevices] md WITH (NOLOCK)
    ON md.DeviceKey = td.DeviceKey
WHERE g.ConfigurationGroupId IN (-7668187040444806181, -3251388662902899727)
ORDER BY g.ConfigurationGroupId, IsActualMobileDevice DESC
*/

/*
-- Check what devices 57 and 82 actually are (the ones with firmware)
SELECT 
  dd.DeviceKey,
  dd.*,
  md.DeviceKey as 'IsMobileDevice',
  CASE WHEN md.DeviceKey IS NOT NULL THEN 'YES - MOBILE DEVICE' ELSE 'NO - PERIPHERAL' END as 'DeviceType'
FROM [definition].[Devices] dd WITH (NOLOCK)
  LEFT JOIN [definition].[MobileDevices] md WITH (NOLOCK)
    ON md.DeviceKey = dd.DeviceKey
WHERE dd.DeviceKey IN (20, 57, 82, 197, 317, 174)
ORDER BY dd.DeviceKey

-- Show only devices that have firmware assigned
SELECT 
  g.ConfigurationGroupId,
  td.DeviceKey,
  dd.SystemName,
  CASE WHEN md.DeviceKey IS NOT NULL THEN 'MOBILE DEVICE' ELSE 'PERIPHERAL' END as 'Type',
  tdpr.Value as 'FirmwareVersionId',
  fw.Name as 'FirmwareName'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = td.DeviceKey
  LEFT JOIN [definition].[MobileDevices] md WITH (NOLOCK)
    ON md.DeviceKey = td.DeviceKey
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)  -- Changed to INNER JOIN
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = td.DeviceKey
    AND tdpr.PropertyKey = @FWVersion
  INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK)  -- Changed to INNER JOIN
    ON fw.FirmwareVersionId = tdpr.Value
WHERE g.ConfigurationGroupId IN (-7668187040444806181, -3251388662902899727)
ORDER BY g.ConfigurationGroupId, Type DESC, td.DeviceKey
*/

/*
-- Check library devices and their firmware
SELECT 
  g.ConfigurationGroupId,
  g.LibraryKey,
  g.DeviceKey as 'MainDeviceKey_174',
  ld.DeviceKey as 'LibraryDeviceKey',
  ld.LibraryDeviceKey as 'LibraryDeviceId',
  dd.SystemName
FROM @GeneralConfigGroupInfo g
  INNER JOIN [library].[Devices] ld WITH (NOLOCK)
    ON ld.LibraryKey = g.LibraryKey
    AND ld.DeviceKey IN (57, 82, 174)  -- Check the relevant devices
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = ld.DeviceKey
WHERE g.ConfigurationGroupId IN (-7668187040444806181, -3251388662902899727)
*/





-- FW VERSION - Pure data-driven approach using DeviceDependencies
DECLARE @FWVersions TABLE  
(
  [ConfigurationGroupId] BIGINT,
  [FWName]               NVARCHAR(50)
);

INSERT INTO @FWVersions
SELECT DISTINCT
  [ConfigurationGroupId] = g.ConfigurationGroupId,
  [FWName] = fw.Name
FROM @GeneralConfigGroupInfo g
  -- Find optional logical device dependencies for the main mobile device
  INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
    ON dep.ParentDeviceKey = g.DeviceKey
    AND dep.DependencyType = 1 -- Optional dependencies
  -- Join template.Devices on the child device from dependencies
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
    AND td.DeviceKey = dep.ChildDeviceKey
  -- Get firmware properties from the dependency device
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = td.DeviceKey
    AND tdpr.PropertyKey = @FWVersion
  -- Get the firmware version details
  INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) 
    ON fw.FirmwareVersionId = tdpr.Value
WHERE tdpr.Value IS NOT NULL
















/*
-- Debug query for NULL firmware cases
DECLARE @problemConfigGroupId BIGINT = -6328313109361883502;

-- First, see what devices are in this template
SELECT 
  'Devices in Template' as QueryType,
  g.ConfigurationGroupId,
  td.DeviceKey,
  dd.SystemName,
  dd.DeviceType,
  CASE WHEN md.DeviceKey IS NOT NULL THEN 'MOBILE DEVICE' ELSE 'OTHER' END as 'Type'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = td.DeviceKey
  LEFT JOIN [definition].[MobileDevices] md WITH (NOLOCK)
    ON md.DeviceKey = td.DeviceKey
WHERE g.ConfigurationGroupId = @problemConfigGroupId

-- Second, see which devices have firmware properties
SELECT 
  'Devices with Firmware Properties' as QueryType,
  g.ConfigurationGroupId,
  td.DeviceKey,
  dd.SystemName,
  dd.DeviceType,
  tdpr.Value as 'FirmwareVersionId',
  fw.Name as 'FirmwareName'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = td.DeviceKey
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = td.DeviceKey
    AND tdpr.PropertyKey = @FWVersion
  LEFT JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK)
    ON fw.FirmwareVersionId = tdpr.Value
WHERE g.ConfigurationGroupId = @problemConfigGroupId
*/

/*
-- Test: See what we get if we ONLY filter by DeviceType 130
SELECT 
  g.ConfigurationGroupId,
  td.DeviceKey,
  dd.SystemName,
  dd.DeviceType,
  fw.Name as 'FirmwareName'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = td.DeviceKey
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = td.DeviceKey
    AND tdpr.PropertyKey = @FWVersion
  INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) 
    ON fw.FirmwareVersionId = tdpr.Value
WHERE 
  dd.DeviceType = 130
  AND dd.SystemName NOT LIKE '%CAN.Bus%'  -- Exclude CAN Bus firmware
  AND tdpr.Value IS NOT NULL
  AND g.ConfigurationGroupId IN (-7668187040444806181, -3251388662902899727, -6328313109361883502)  -- Your test cases
ORDER BY g.ConfigurationGroupId
*/

/*
-- See what logical device types have firmware properties
SELECT DISTINCT
  dd.SystemName,
  COUNT(*) as 'Count'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = td.DeviceKey
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = td.DeviceKey
    AND tdpr.PropertyKey = @FWVersion
WHERE 
  dd.DeviceType = 130
  AND dd.SystemName NOT LIKE '%CAN.Bus%'
  AND tdpr.Value IS NOT NULL
GROUP BY dd.SystemName
ORDER BY dd.SystemName
*/

/*
-- See what device types have firmware properties
SELECT DISTINCT
  dd.DeviceType,
  dd.SystemName,
  COUNT(*) as 'Count'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = td.DeviceKey
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = td.DeviceKey
    AND tdpr.PropertyKey = @FWVersion
WHERE 
  (
    dd.SystemName LIKE 'MobileDevice.Logical.%'
    OR dd.SystemName LIKE '%.Firmware'
  )
  AND tdpr.Value IS NOT NULL
GROUP BY dd.DeviceType, dd.SystemName
ORDER BY dd.DeviceType, dd.SystemName
*/

/*
-- Debug: See what dependencies exist for our known devices
SELECT 
  'Dependencies for Main Devices' as QueryType,
  g.ConfigurationGroupId,
  g.DeviceKey as 'MainDeviceKey',
  g.MobileDevice,
  dep.ParentDeviceKey,
  dep.ChildDeviceKey,
  dep.DependencyType,
  dd_child.SystemName as 'ChildDeviceSystemName'
FROM @GeneralConfigGroupInfo g
  LEFT JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
    ON dep.ParentDeviceKey = g.DeviceKey
  LEFT JOIN [definition].[Devices] dd_child WITH (NOLOCK)
    ON dd_child.DeviceKey = dep.ChildDeviceKey
WHERE g.ConfigurationGroupId IN (-7668187040444806181, -3251388662902899727, -6328313109361883502)
ORDER BY g.ConfigurationGroupId, dep.DependencyType, dep.ChildDeviceKey
*/

/*
-- Compare firmware devices vs non-firmware optional dependencies
SELECT 
  g.ConfigurationGroupId,
  dep.ChildDeviceKey,
  dd.SystemName,
  dd.DeviceType,
  -- Check if this device has firmware properties
  CASE WHEN tdpr.Value IS NOT NULL THEN 'HAS FIRMWARE' ELSE 'NO FIRMWARE' END as 'HasFirmwareProperty',
  tdpr.Value as 'FirmwareVersionId',
  fw.Name as 'FirmwareName'
FROM @GeneralConfigGroupInfo g
  INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
    ON dep.ParentDeviceKey = g.DeviceKey
    AND dep.DependencyType = 1 -- Optional dependencies
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK)
    ON dd.DeviceKey = dep.ChildDeviceKey
  -- Check if this device is in the template
  LEFT JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
    AND td.DeviceKey = dep.ChildDeviceKey
  -- Check if it has firmware properties
  LEFT JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = dep.ChildDeviceKey
    AND tdpr.PropertyKey = @FWVersion
  LEFT JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK)
    ON fw.FirmwareVersionId = tdpr.Value
WHERE g.ConfigurationGroupId IN (-7668187040444806181, -3251388662902899727, -6328313109361883502)
ORDER BY g.ConfigurationGroupId, HasFirmwareProperty DESC, dd.SystemName
*/




















-------------------------------------------------------------------------------------------------------

  -- Put it all together
  SELECT
    tcg.Name,
    Flagged = b.BlackFlagsCount,
    g.ConfigurationGroupId,
    a.AssetsCount,
    FWVersion = STUFF((
                SELECT ', ' + fw.FWName
    FROM @FWVersions fw
    WHERE fw.ConfigurationGroupId = g.ConfigurationGroupId
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    CanScriptLineId = STUFF((
                SELECT ', ' + [LineId]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND (l.WireName = 'C1' OR l.WireName = 'C2')
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    CanScript = STUFF((
                SELECT ', ' + [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND (l.WireName = 'C1' OR l.WireName = 'C2')
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    Speed = CASE
                    WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed' --Business rule on OE-20, this is always the value for MiX2000
                    WHEN g.MobileDevice LIKE 'FM%' THEN
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName LIKE ('F%') --ANY Frequency line
      AND l.Connection LIKE '%SPEED%'
                        )
                    ELSE 
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName = 'Speed')
                END,
    RPM =   CASE
                    WHEN g.MobileDevice LIKE 'FM%' THEN
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName LIKE ('F%') --ANY Frequency line
      AND l.Connection LIKE '%RPM%'
                        )
                    ELSE
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName = 'RPM')
                END,
    Fuel =  CASE
                    WHEN g.MobileDevice LIKE 'FM%' THEN
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName LIKE ('F%') --ANY Frequency line
      AND l.Connection LIKE '%Fuel%'
                        )
                    ELSE
                        (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.WireName = 'Fuel')
                END,
    SP =    (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'SP'),
    HOS =   (SELECT [Connection]
    FROM @AllConfigGroupLines l
    WHERE l.ConfigurationGroupId = g.ConfigurationGroupId AND l.WireName = 'HOS')
  FROM @GeneralConfigGroupInfo g
    LEFT JOIN @AssetsCount a ON a.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN @BlackFlagsCount b ON b.ConfigurationGroupId = g.ConfigurationGroupId
    
    --SIMPLIFY: TODO: MR: Remove again
    --WHERE g.ConfigurationGroupId IN (-7668187040444806181, -3251388662902899727)



  LEFT JOIN [template].[ConfigurationGroups] tcg 
    ON tcg.ConfigurationGroupId  = g.ConfigurationGroupId

  ORDER BY tcg.Name 

/*
This should give you:
Config Group -7668187040444806181 → E15.08.09 (only)
Config Group -3251388662902899727 → E19.03.07 (only)
*/


