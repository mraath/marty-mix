USE [DeviceConfiguration.Dataprocessing];

/*
- Should have missing parameter: 
1403102293298126848,1415760817642536960,1450923827225116672,?? 1606749708247756800,?? 1522731665984569344,1444029372907753472,1606679698413109248
- Shouldnt have missing params: 
1596635336800804864,1626018637366906880,1631447698450665472
*/


-- Enhanced Script to analyze parameter support for udfIsMobileUnitMissingParameters verification
-- Automatically fetches required keys and uses correct description columns

-- 1. Define Inputs
DECLARE @TestMobileUnitId BIGINT = 1606749708247756800; -- Replace with MobileUnitId to test 1606749708247756800, 1522731665984569344, 1444029372907753472, 1606679698413109248

-- 2. Declare variables for fetched keys
DECLARE @TestMobileUnitKey INT;
DECLARE @TestMobileDeviceKey INT;
DECLARE @TestLibraryKey INT;
DECLARE @TestEventTemplateKey INT;
DECLARE @TestConfigurationGroupId BIGINT;
DECLARE @MobileDeviceTemplateKey INT;

-- 3. Fetch required keys using the basic info function
PRINT 'Fetching basic info for MobileUnitId: ' + CAST(@TestMobileUnitId AS VARCHAR);
DECLARE @InputIdsForBasicInfo [dbo].[SelectionIds];
SELECT TOP 1 @TestConfigurationGroupId = tcg.ConfigurationGroupId
FROM [DeviceConfiguration].[mobileunit].[MobileUnits] mu
INNER JOIN [DeviceConfiguration].[template].[ConfigurationGroups] tcg ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
WHERE mu.MobileUnitId = @TestMobileUnitId;

IF @TestConfigurationGroupId IS NULL BEGIN PRINT 'ERROR: Could not find ConfigurationGroupId for MobileUnitId: ' + CAST(@TestMobileUnitId AS VARCHAR); RETURN; END
INSERT INTO @InputIdsForBasicInfo (id) VALUES (@TestConfigurationGroupId);

SELECT TOP 1
    @TestMobileUnitKey = bi.MobileUnitKey, @TestMobileDeviceKey = bi.MobileDeviceKey,
    @TestLibraryKey = bi.LibraryKey, @TestEventTemplateKey = bi.EventTemplateKey,
    @MobileDeviceTemplateKey = bi.MobileDeviceTemplateKey
FROM [state].[udfGetMobileUnitBasicInfoForConfigGroups](@InputIdsForBasicInfo) bi
WHERE bi.MobileUnitId = @TestMobileUnitId;

IF @TestMobileUnitKey IS NULL OR @TestEventTemplateKey IS NULL BEGIN PRINT 'ERROR: Could not retrieve basic info keys (including EventTemplateKey) for MobileUnitId: ' + CAST(@TestMobileUnitId AS VARCHAR); RETURN; END
ELSE BEGIN PRINT 'Basic info keys retrieved successfully (MUKey=' + CAST(@TestMobileUnitKey AS VARCHAR) + ', DevKey=' + CAST(@TestMobileDeviceKey AS VARCHAR) + ', LibKey=' + CAST(@TestLibraryKey AS VARCHAR) + ', EventTmplKey=' + CAST(@TestEventTemplateKey AS VARCHAR) + ').'; END

-- 4. Replicate Function's Internal Logic - Focusing on Parameter Details
PRINT '--- Analyzing Parameter Support Details for MobileUnitId: ' + CAST(@TestMobileUnitId AS VARCHAR) + ' ---';

BEGIN TRY
    WITH Constants AS (
        SELECT OPEN_BRACKET = CAST(981729539706373388 AS BIGINT), CLOSE_BRACKET = CAST(-8380423587615480304 AS BIGINT)
    ),
    TemplateDevices AS (
        SELECT td.DeviceKey, dd.DeviceId
        FROM [DeviceConfiguration].[template].[MobileDeviceTemplates] tmdt WITH (NOLOCK)
        INNER JOIN [DeviceConfiguration].[template].[Devices] td WITH (NOLOCK) ON tmdt.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey AND tmdt.LibraryKey = td.LibraryKey
        INNER JOIN [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK) ON td.DeviceKey = dd.DeviceKey
        WHERE tmdt.LibraryKey = @TestLibraryKey AND tmdt.MobileDeviceKey = @TestMobileDeviceKey AND td.IsEnabled = 1
    ),
    AllSupportedParameters AS (
        -- Using the reverted version (without library.Devices join)
        SELECT DISTINCT dp.ParameterId
        FROM [DeviceConfiguration].[definition].[DeviceParameters] ddp WITH (NOLOCK)
        INNER JOIN TemplateDevices td ON ddp.DeviceKey = td.DeviceKey
        INNER JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK) ON dp.ParameterKey = ddp.ParameterKey
        INNER JOIN [DeviceConfiguration].[library].[Parameters] lpCheck WITH (NOLOCK) ON lpCheck.ParameterKey = dp.ParameterKey AND lpCheck.LibraryKey = @TestLibraryKey
    ),
    EventParameterDetails AS (
        -- Get details for each condition parameter of each enabled event
        SELECT
            te.EventKey,
            le.Description AS EventName,
            de.EventType,
            tec.ParameterKey AS ConditionParameterKey,
            dp.ParameterId AS ConditionParameterId,
            lp.Description AS ConditionParameterName,
            tec.IsRequired AS IsConditionParamRequired,
            CASE WHEN asp.ParameterId IS NOT NULL THEN 1 ELSE 0 END AS IsConditionParamSupported,
            ISNULL(muoe.IsEnabled, 1) AS IsEventEnabled
        FROM [DeviceConfiguration].[template].[Events] te WITH (NOLOCK)
        INNER JOIN [DeviceConfiguration].[definition].[Events] de WITH (NOLOCK) ON de.EventKey = te.EventKey
        INNER JOIN [DeviceConfiguration].[library].[Events] le WITH (NOLOCK) ON le.EventKey = de.EventKey AND le.LibraryKey = @TestLibraryKey
        LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenEvents] muoe WITH (NOLOCK) ON muoe.MobileUnitKey = @TestMobileUnitKey AND muoe.TemplateEventKey = te.EventKey
        LEFT JOIN [DeviceConfiguration].[template].[EventConditions] tec WITH (NOLOCK) ON tec.LibraryKey = te.LibraryKey AND tec.EventTemplateKey = @TestEventTemplateKey AND tec.EventKey = te.EventKey
        LEFT JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK) ON dp.ParameterKey = tec.ParameterKey
        LEFT JOIN [DeviceConfiguration].[library].[Parameters] lp WITH (NOLOCK) ON lp.ParameterKey = dp.ParameterKey AND lp.LibraryKey = @TestLibraryKey
        LEFT JOIN AllSupportedParameters asp ON asp.ParameterId = dp.ParameterId
        CROSS JOIN Constants const
        WHERE te.LibraryKey = @TestLibraryKey
          AND te.EventTemplateKey = @TestEventTemplateKey
          AND de.EventType != 0 -- Ignore Hidden events
          AND dp.ParameterId NOT IN (const.OPEN_BRACKET, const.CLOSE_BRACKET) -- Exclude brackets
    )
    -- *** Display the detailed parameter list for enabled events, including Peripheral status ***
    SELECT
        epd.EventName,
        epd.EventType,
        CASE WHEN epd.EventType = 10 THEN 1 ELSE 0 END AS IsPeripheralBasedEvent, -- <<< Added Column
        epd.ConditionParameterName,
        epd.IsConditionParamRequired,
        epd.IsConditionParamSupported,
        CASE
            WHEN epd.IsConditionParamRequired = 1 AND epd.IsConditionParamSupported = 0 THEN '*** MISSING REQUIRED ***'
            ELSE ''
        END AS Status
    FROM EventParameterDetails epd
    WHERE epd.IsEventEnabled = 1 -- Only show parameters for enabled events
    ORDER BY epd.EventName, epd.ConditionParameterName;

END TRY
BEGIN CATCH
    PRINT 'Error during verification logic:';
    PRINT ERROR_MESSAGE();
END CATCH

/* OLD Function no longer needed
-- Also show the function's final output for direct comparison
PRINT '';
PRINT '--- Function Output (IsMissingParameters Flag) ---';
SELECT * FROM [state].[udfIsMobileUnitMissingParameters](@TestMobileUnitId, @TestMobileUnitKey, @TestMobileDeviceKey, @TestLibraryKey, @TestEventTemplateKey);
*/

--DECLARE @IsMissingParameters BIT;
--SELECT * FROM [state].[uspIsMobileUnitMissingParameters](@TestMobileUnitId, @TestMobileUnitKey, @TestMobileDeviceKey, @TestLibraryKey, @MobileDeviceTemplateKey,  @TestEventTemplateKey, @IsMissingParameters)
--SELECT * FROM @IsMissingParameters

/* OLDER STORED PROC
DECLARE @RC int
EXECUTE @RC = [state].[uspIsMobileUnitMissingParameters] 
   @TestMobileUnitId, @TestMobileUnitKey, @TestMobileDeviceKey, @TestLibraryKey, @MobileDeviceTemplateKey,  @TestEventTemplateKey, @IsMissingParameters OUTPUT
SELECT @RC
*/


/*
-- Execute the Missing Parameters SP (new version based on C# logic) for the current unit
-- Declare the variable to hold the output
DECLARE @IsMissingParams BIT;
EXEC [state].[uspGetMobileUnitMissingParameters_FromCSharpLogic]
    @MobileUnitId = @TestMobileUnitId,
    @IsMissingParameters = @IsMissingParams OUTPUT;
-- Optional: Select the output value to see the result
SELECT @IsMissingParams AS MissingParametersResult;
*/


	
