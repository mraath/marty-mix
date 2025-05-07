USE [DeviceConfiguration.DataProcessing];

-- Declare necessary constants from the original SP
DECLARE @PreferedFirmwareVersionPropId BIGINT = 4015466679217121645;
DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;

-- Declare a variable to hold the specific ConfigurationGroupIds
DECLARE @TargetConfigGroupIds dbo.SelectionIds;

-- *** USER INPUT REQUIRED HERE ***
-- Populate the variable with the specific ConfigurationGroupIds
-- Example:
-- INSERT INTO @TargetConfigGroupIds (id) VALUES (123), (456), (789);
-- Replace the example values with the actual IDs you provide.
INSERT INTO @TargetConfigGroupIds (id)
VALUES --(-4717128997316087817);

(3744429100126254243), (-2440320943995442748), (-8601070457854353823),(-3751550636977100219),(-188994457358791832),(-3539031602115732476),(-6732880824993784265),(61756661440635962),(5347252666355409446),(-4682479239161263365),(-1508296197039288250),(-8958682396246293176),(-8864395233107620198),(-1325082746264596693),(-4003628735172700822),(-9076606996180062319),(-4717128997316087817),(7972458021988004916),(8815476176116823518),(4919764585535166399),(-7838770298250680961),(-2748008063263561295),(-6935626891522280445),(1490244259299731130),(-4258849611457539337),(159897983233803411),(-6284968178773227668);



-- CTE 1: Get basic Mobile Unit info using the TVF (Including ConfigurationGroupId)
WITH MobileUnitBasicInfo AS (
    SELECT
        bi.MobileUnitId,
        bi.MobileUnitKey,
        bi.MobileDeviceKey,
        bi.LibraryKey,
        bi.MobileDeviceTemplateKey,
        bi.ConfigurationGroupId -- Added ConfigurationGroupId
    FROM [state].[udfGetMobileUnitBasicInfoForConfigGroups](@TargetConfigGroupIds) bi
),
-- CTE 2: Get Installed Firmware details
InstalledFW AS (
    SELECT
        mubi.*, -- Includes ConfigurationGroupId now
        mus.Value AS InstalledFirmwareName,
        dfw.FirmwareVersionId AS InstalledFirmwareVersionId,
        dfw.FirmwareType
    FROM MobileUnitBasicInfo mubi
    LEFT JOIN [state].[MobileUnitState] mus WITH (NOLOCK)
        ON mubi.MobileUnitId = mus.MobileUnitId AND mus.PropertyId = @FIRMWARE_VERSION
    LEFT JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK)
        ON mus.Value = dfw.Name -- Join on Name from state
    WHERE mus.Value IS NOT NULL -- Only consider units with reported firmware
      AND dfw.FirmwareVersionId IS NOT NULL -- Only consider known firmware names
),
-- CTE 3: Find the PropertyKey for the preferred firmware setting
FWPropKey AS (
    SELECT TOP 1 PropertyKey -- Assuming only one such property exists
    FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK)
    WHERE PropertyId = @PreferedFirmwareVersionPropId
),






-- CTE 4: Find the Template Preferred Firmware VersionId
TemplateFW AS (
    SELECT DISTINCT -- Use DISTINCT as joins might create duplicates
        i.MobileUnitId,
        tdpr.TemplateDevicePropertyKey,
        TRY_CAST(tdpr.Value AS BIGINT) AS TemplateFirmwareVersionId
    FROM InstalledFW i
    INNER JOIN [DeviceConfiguration].[template].[MobileDeviceTemplates] tmdt WITH (NOLOCK)
        ON tmdt.MobileDeviceTemplateKey = i.MobileDeviceTemplateKey AND tmdt.LibraryKey = i.LibraryKey AND tmdt.MobileDeviceKey = i.MobileDeviceKey
    INNER JOIN FWPropKey fpk ON 1=1 -- Ensure PropertyKey exists
    INNER JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK)
        ON ddd.ParentDeviceKey = tmdt.MobileDeviceKey -- Link template's device to its children
    INNER JOIN [DeviceConfiguration].[template].[DeviceProperties] tdpr WITH (NOLOCK)
        ON tdpr.DeviceKey = ddd.ChildDeviceKey -- Property is on the child device
        AND tdpr.PropertyKey = fpk.PropertyKey
        AND tdpr.LibraryKey = i.LibraryKey
        AND tdpr.MobileDeviceTemplateKey = i.MobileDeviceTemplateKey
    WHERE tdpr.Value IS NOT NULL -- Only consider templates where the FW property is set
),
-- CTE 5: Find Overridden Preferred Firmware VersionId
OverrideFW AS (
    SELECT DISTINCT -- Use DISTINCT
        i.MobileUnitKey,
        tfw.TemplateDevicePropertyKey, -- Include to join correctly
        TRY_CAST(muodp.[Value] AS BIGINT) AS OverriddenFirmwareVersionId
    FROM [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties] muodp WITH (NOLOCK)
    INNER JOIN TemplateFW tfw ON muodp.TemplateDevicePropertyKey = tfw.TemplateDevicePropertyKey
    INNER JOIN InstalledFW i ON muodp.MobileUnitKey = i.MobileUnitKey -- Link back to base info
    WHERE muodp.Value IS NOT NULL
),
-- CTE 6: Determine the actual Preferred Firmware VersionId
PreferredFW AS (
    SELECT
        tfw.MobileUnitId,
        -- Use COALESCE for override, ensuring we only take overrides linked to the specific template property
        COALESCE(ofw.OverriddenFirmwareVersionId, tfw.TemplateFirmwareVersionId) AS PreferredFirmwareVersionId
    FROM TemplateFW tfw
    -- Correctly link override based on MobileUnit AND the specific TemplateDevicePropertyKey
    LEFT JOIN OverrideFW ofw ON tfw.TemplateDevicePropertyKey = ofw.TemplateDevicePropertyKey
                           AND tfw.MobileUnitId = (SELECT TOP 1 i.MobileUnitId FROM InstalledFW i WHERE i.MobileUnitKey = ofw.MobileUnitKey) -- Subquery might be slow, consider alternative join if possible
),
-- CTE 7: Get Preferred Firmware Name
PreferredFWName AS (
    SELECT DISTINCT -- Use DISTINCT
        pfw.MobileUnitId,
        pfw.PreferredFirmwareVersionId,
        dfw.Name AS PreferredFirmwareName
    FROM PreferredFW pfw
    INNER JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK)
        ON pfw.PreferredFirmwareVersionId = dfw.FirmwareVersionId
),
-- CTE 8: Calculate Available Versions and Ranks for each relevant FirmwareType/LibraryKey
AvailableFWRanks AS (
    SELECT
        dfw.FirmwareType,
        lfw.LibraryKey,
        dfw.FirmwareVersionId,
        dfw.Name,
        ROW_NUMBER() OVER (PARTITION BY dfw.FirmwareType, lfw.LibraryKey ORDER BY dfw.Name) AS VersionNumber
    FROM [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK)
    INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw WITH (NOLOCK)
        ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey
),
-- CTE 9: Find the latest rank per type/library
LatestRank AS (
    SELECT
        FirmwareType,
        LibraryKey,
        MAX(VersionNumber) AS LatestVersionNumber
    FROM AvailableFWRanks
    GROUP BY FirmwareType, LibraryKey
),
-- Final Step: Combine everything and calculate the difference
FinalComparison AS (
    SELECT
        i.MobileUnitId,
        i.ConfigurationGroupId, -- Carry ConfigurationGroupId through
        i.InstalledFirmwareName,
        pfn.PreferredFirmwareName,
        i.FirmwareType,
        i.LibraryKey,
        pfn.PreferredFirmwareVersionId,
        afr_pref.VersionNumber AS PreferredVersionNumber,
        lr.LatestVersionNumber,
        (lr.LatestVersionNumber - afr_pref.VersionNumber) AS VersionDifference
    FROM InstalledFW i
    INNER JOIN PreferredFWName pfn ON i.MobileUnitId = pfn.MobileUnitId -- Only units with a preferred FW
    LEFT JOIN AvailableFWRanks afr_pref ON i.FirmwareType = afr_pref.FirmwareType AND i.LibraryKey = afr_pref.LibraryKey AND pfn.PreferredFirmwareVersionId = afr_pref.FirmwareVersionId
    LEFT JOIN LatestRank lr ON i.FirmwareType = lr.FirmwareType AND i.LibraryKey = lr.LibraryKey
)
-- Select the MobileUnitIds based on the difference
SELECT
    fc.MobileUnitId,
    CASE
        WHEN fc.VersionDifference > 2 THEN 'Outdated (>2 Versions Behind)'
        ELSE 'Not Outdated (<=2 Versions Behind)'
    END AS Status,
    -- Add expected outcome for the test harness later
    CASE
        WHEN fc.VersionDifference > 2 THEN 1 -- Expected @IsFirmwareOutdated = 1
        ELSE 0 -- Expected @IsFirmwareOutdated = 0
    END AS ExpectedIsFirmwareOutdated,
    fc.ConfigurationGroupId, -- Added ConfigurationGroupId to final output
    fc.InstalledFirmwareName,
    fc.PreferredFirmwareName,
    fc.PreferredVersionNumber,
    fc.LatestVersionNumber,
    fc.VersionDifference
FROM FinalComparison fc
WHERE fc.VersionDifference IS NOT NULL -- Only include units where comparison was possible
ORDER BY Status, fc.ConfigurationGroupId, MobileUnitId; -- Added ConfigurationGroupId to ORDER BY
