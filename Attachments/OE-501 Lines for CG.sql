-- Procedure to retrieve all mobile unit lines. The can give a list of groupIds, mobileUnitIds, both or none (in which case ALL mobileunitIds' lines will be returned)
USE DeviceConfiguration;
DECLARE  @groupId BIGINT = 1686880341835301320;

DECLARE @AllConfigGroupLines TABLE  
    (
    [ConfigurationGroupId] BIGINT,
    [WireName] nvarchar(200),
    [Connection] nvarchar(200)
    );

INSERT INTO @AllConfigGroupLines
Select
    [ConfigurationGroupId] = tcg.ConfigurationGroupId,
    [WireName] = dl.[Name],
    [Connection] = lpd.[Description]
FROM library.Libraries ll WITH (NOLOCK)
INNER JOIN template.ConfigurationGroups tcg WITH (NOLOCK) on tcg.LibraryKey = ll.LibraryKey
INNER JOIN template.MobileDeviceTemplates mdt WITH (NOLOCK) on tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
INNER JOIN definition.Devices dd WITH (NOLOCK) on mdt.MobileDeviceKey = dd.DeviceKey

--join definition.MobileDevices dmd WITH (NOLOCK) on dd.DeviceKey = dmd.DeviceKey
LEFT JOIN   [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey]   = dd.DeviceKey
LEFT JOIN   [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
LEFT JOIN  [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]

--Template Devices
INNER JOIN  [template].[Devices] td WITH (NOLOCK) ON td.[MobileDeviceTemplateKey] = tcg.[MobileDeviceTemplateKey]
INNER JOIN  [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]

-- Peripheral devices
CROSS APPLY 
    ( SELECT 
            [LineKey] = tpd.[LineKey]
        FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
        WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND tpd.[LineKey]=dmdl.[LineKey]
    ) pd
left JOIN  [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]

--Lines
LEFT JOIN  [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) 
    ON dmdlpd.[MobileDeviceKey]      = dd.DeviceKey --mu.[MobileDeviceKey]
    AND dmdlpd.[LineKey]             = pd.[LineKey]
    AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]

-- Get connected device
LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = tcg.LibraryKey
LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK)ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey

WHERE ll.GroupId = @groupId
AND dl.[Name] IN ('Speed','RPM','Fuel','SP')


SELECT * FROM @AllConfigGroupLines
Order by ConfigurationGroupId








--SELECT top 10 * from [template].[PeripheralDevices]


--SELECT * FROM @AllConfigGroupLines

/*

-- Effective Lines ----------------------------------------------------------------------

DECLARE @EffectiveByMobileUnitId TABLE  
    (
    [GroupId] BIGINT,
    [WireName] nvarchar(200),
    [SortOrder] int,
    [WireIconPath] nvarchar(200),
    [Connection] nvarchar(200),
    [IsOverridden] bit);

INSERT INTO @EffectiveByMobileUnitId
SELECT
    [GroupId] = ll.GroupId,
    [WireName] = dl.[Name],
    [SortOrder] = CASE WHEN dl.DateUpdated IS NOT NULL THEN dl.[SortOrder] ELSE 0 END,
    [WireIconPath] = dl.[IdentifyingImageName],
    [Connection] = lpd.[Description],
    [IsOverridden] = pd.[IsOverridden]

--General Mobileunit info
FROM library.Libraries ll WITH (NOLOCK)
join template.ConfigurationGroups tcg WITH (NOLOCK) on tcg.LibraryKey = ll.LibraryKey
join template.MobileDeviceTemplates mdt WITH (NOLOCK) on tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
INNER JOIN  [template].[Devices] td WITH (NOLOCK) ON td.[MobileDeviceTemplateKey] = tcg.[MobileDeviceTemplateKey]
INNER JOIN  [definition].[Devices] dd WITH (NOLOCK) ON dd.[DeviceKey] = td.[DeviceKey]
join definition.MobileDevices dmd WITH (NOLOCK) on dd.DeviceKey = dmd.DeviceKey

--Peripheral Devices
CROSS APPLY ( SELECT 
                [LineKey] = tpd.[LineKey],
                [IsOverridden] ='false'
              FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
              WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
                AND (tpd.[LineKey] IS NOT NULL)
            ) pd
        left JOIN  [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = pd.[LineKey]

--Lines
LEFT JOIN  [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) ON dmdlpd.[MobileDeviceKey]     = dd.[DeviceKey]
                                                                                AND dmdlpd.[LineKey]             = pd.[LineKey]
                                                                                AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]

--Get the connected device
LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = tcg.LibraryKey
LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey

SELECT * FROM @EffectiveByMobileUnitId





-- Mashup of the two tables ----------------------------------------------------------------------

SELECT
    a.[GroupId],
    a.[ConfigurationGroupId],
    a.[ConfigurationGroupName],
    WireName = a.[WireName],
    SortOrder = a.[SortOrder],
    WireIconPath = a.[WireIconPath],
    Connection = a.[Connection],
    IsOverridden = a.[IsOverridden],
    EquivalentLineName = a.[EquivalentLineName]
FROM @AllConfigGroupLines a
LEFT JOIN @EffectiveByMobileUnitId eff ON eff.[GroupId] = a.[GroupId]
    AND eff.[WireName] = a.[WireName]
--WHERE eff.Connection is not NULL
Order by a.[ConfigurationGroupId], a.SortOrder


*/

