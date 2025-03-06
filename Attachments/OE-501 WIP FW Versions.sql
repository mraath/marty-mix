USE DeviceConfiguration;
DECLARE @GroupId BIGINT = 1686880341835301320; --1686880341835301320 -1983255592473789111


DECLARE @FWVersion SMALLINT = 
    (SELECT PropertyKey FROM definition.Properties WHERE PropertyId = 4015466679217121645);

DECLARE @FWVersions TABLE  
(
    [ConfigurationGroupId] BIGINT,
    [FWName] nvarchar(50)
);

INSERT INTO @FWVersions
Select
    [ConfigurationGroupId] = tcg.ConfigurationGroupId,
    [FWName] = fw.name
FROM library.Libraries ll WITH (NOLOCK)
INNER JOIN template.ConfigurationGroups tcg WITH (NOLOCK) on tcg.LibraryKey = ll.LibraryKey
INNER JOIN template.MobileDeviceTemplates mdt WITH (NOLOCK) 
    ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
    AND tcg.LibraryKey = mdt.LibraryKey
INNER JOIN definition.Devices dd WITH (NOLOCK) on mdt.MobileDeviceKey = dd.DeviceKey
--Template Devices
INNER JOIN  [template].[Devices] td WITH (NOLOCK) 
    ON td.[MobileDeviceTemplateKey] = tcg.[MobileDeviceTemplateKey]
    AND tcg.LibraryKey = td.LibraryKey
INNER JOIN  [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
INNER JOIN template.DeviceProperties tdpr 
    ON tdpr.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey 
    AND tdpr.PropertyKey = @FWVersion
    AND tdpr.DeviceKey = tdd.DeviceKey
INNER JOIN definition.FirmwareVersions fw ON fw.FirmwareVersionId = tdpr.Value
WHERE ll.GroupId = @groupId

--SELECT * FROM @FWVersions
-- 39 including multiples


-- Try to comma seperate multiples

Select
    tcg.ConfigurationGroupId,
    tcg.Name,
    FWVersions = STUFF((
            SELECT ', ' + fw.FWName
            FROM @FWVersions fw
            WHERE fw.ConfigurationGroupId = tcg.ConfigurationGroupId
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '')
FROM library.Libraries ll WITH (NOLOCK)
INNER JOIN template.ConfigurationGroups tcg WITH (NOLOCK) on tcg.LibraryKey = ll.LibraryKey
WHERE ll.GroupId = @groupId

