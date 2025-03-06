-- Get all F lines for FM units with Fuel connected
DECLARE @AllConfigGroupLines TABLE  
(
    OrgId BIGINT,
    [ConfigurationGroupId] BIGINT,
    [WireName] nvarchar(200),
    [Connection] nvarchar(200),
    DeviceType INT
);

INSERT INTO @AllConfigGroupLines
Select
    ll.groupId,
    [ConfigurationGroupId] = tcg.ConfigurationGroupId,
    [WireName] = dl.[Name],
    [Connection] = lpd.[Description],
    DeviceType = dd.DeviceType
FROM library.Libraries ll WITH (NOLOCK)
INNER JOIN template.ConfigurationGroups tcg WITH (NOLOCK) on tcg.LibraryKey = ll.LibraryKey
INNER JOIN template.MobileDeviceTemplates mdt WITH (NOLOCK) 
    ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
    AND tcg.LibraryKey = mdt.LibraryKey

INNER JOIN definition.Devices dd WITH (NOLOCK) on mdt.MobileDeviceKey = dd.DeviceKey
INNER JOIN definition.MobileDevices dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey

--join definition.MobileDevices dmd WITH (NOLOCK) on dd.DeviceKey = dmd.DeviceKey
LEFT JOIN   [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey]   = dd.DeviceKey
LEFT JOIN   [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
LEFT JOIN  [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]

--Template Devices
INNER JOIN  [template].[Devices] td WITH (NOLOCK) 
    ON td.[MobileDeviceTemplateKey] = tcg.[MobileDeviceTemplateKey]
    AND tcg.LibraryKey = td.LibraryKey
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

WHERE 
--ll.GroupId = @groupId
dmd.Description LIKE 'FM%' 
AND dl.[Name] LIKE ('F%') --ANY Frequency line
AND lpd.[Description] LIKE '%Fuel%'

SELECT * FROM @AllConfigGroupLines
