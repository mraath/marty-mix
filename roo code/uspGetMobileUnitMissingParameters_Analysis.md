---
created: 2025-04-08T14:44
updated: 2025-04-08T15:51
---
# Analysis and Plan for `uspGetMobileUnitMissingParameters` Logic

## Objective

To create a SQL stored procedure that accurately replicates the C# logic for determining if a mobile unit has "missing parameters" for any of its enabled events. This corresponds to the `EventStatus.NoParameters` state in the C# code (`MobileUnitEventsModule.cs`).

## C# Logic Summary

The determination involves these key steps in the C# code (`MobileUnitManager.cs` and related files):

1.  **Resolve Hardware Configuration:** Start with the `MobileDeviceTemplate` and apply all overrides specific to the `MobileUnit` (`OverridenDevices`, `OverridenPeripheralDevices`, `MobileUnitProperties`, etc.) to get the `ResolvedMobileDevice`.
2.  **Filter Enabled Devices:** Consider only the main device and logical/peripheral devices that are marked as `IsEnabled` in the resolved configuration.
3.  **Identify Supported Parameters:** Fetch parameters (`LibraryDeviceParameters`) associated *only* with the *enabled* devices within the current `Library`. This forms the `AllSupportedParameters` list. The C# code achieves this by querying `LibraryDeviceParameters` filtered by `LibraryId`, implicitly ensuring both the device and parameter exist in the library context.
4.  **Analyze Events:** For each event in the `EventTemplate`:
    *   Check if the event itself is enabled (considering `OverridenEvents`).
    *   If enabled, check its conditions (`EventConditions`).
    *   If any condition has `IsRequired = true` and its corresponding parameter is *not* in the `AllSupportedParameters` list, the event is *not* considered "monitored".
5.  **Set Status:** In `MobileUnitEventsModule.cs`, if an event `evnt` is enabled (`evnt.IsEnabled`) but is *not* in the `config.MonitoredEvents` list (due to step 4), its status is set to `EventStatus.NoParameters`. The check for `EventType = 10` (MiX Vision) happens *after* this check and leads to a different status (`EventStatus.NoPeripheral`), so it does not affect the `NoParameters` determination.

## SQL Implementation Plan

Create a new stored procedure `[state].[uspGetMobileUnitMissingParameters_FromCSharpLogic]` that performs the following:

1.  **Fetch Core IDs:** Get `@MobileUnitKey`, `@MobileDeviceKey`, `@LibraryKey`, `@MobileDeviceTemplateKey`, `@EventTemplateKey` for the input `@MobileUnitId`. Includes fallback logic if the primary function `udfGetMobileUnitBasicInfoForConfigGroups` fails or is unsuitable.
2.  **Determine Enabled Hardware (CTEs):**
    *   `BaseTemplateDevices`: Get devices from `template.Devices`.
    *   `EffectiveDeviceStatus`: Apply `mobileunit.OverridenDevices` to logical devices.
    *   `EnabledDeviceIds`: Apply `mobileunit.OverridenPeripheralDevices` logic (based on `LineId`) and combine with enabled logical devices and the main device ID.
3.  **Identify Supported Parameters (CTE):**
    *   `AllSupportedParameters`: Join `definition.DeviceParameters`, `definition.Devices`, `definition.Parameters`, `library.Parameters`, and crucially `library.Devices`. Filter using `EnabledDeviceIds` and `@LibraryKey` to get parameters supported by the active hardware in the correct library context, matching the C# approach.
4.  **Analyze Events and Conditions (CTE):**
    *   `EventParameterSupport`: Join `template.Events`, `definition.Events`, `mobileunit.OverridenEvents`, `template.EventConditions`, `definition.Parameters`. Check if each condition parameter exists in `AllSupportedParameters`. Excludes bracket parameters and hidden events.
5.  **Set Final Flag:** `SELECT TOP 1 @IsMissingParameters = 1` if any row in `EventParameterSupport` meets the criteria: `IsEventEnabled = 1`, `IsConditionParamRequired = 1`, and `IsConditionParamSupported = 0`. The `EventType <> 10` filter is **removed** to match C# logic.

## Final Proposed SQL Code

```sql
-- Stored procedure to determine if a Mobile Unit is missing required parameters for any enabled event,
-- based on analysis of the C# logic in MobileUnitManager and related classes.
IF OBJECT_ID('[state].[uspGetMobileUnitMissingParameters_FromCSharpLogic]', 'P') IS NOT NULL
    DROP PROCEDURE [state].[uspGetMobileUnitMissingParameters_FromCSharpLogic];
GO

CREATE PROCEDURE [state].[uspGetMobileUnitMissingParameters_FromCSharpLogic]
    @MobileUnitId BIGINT,
    @IsMissingParameters BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsMissingParameters = 0; -- Default to false

    DECLARE @MobileUnitKey INT, @MobileDeviceKey INT, @LibraryKey INT,
            @MobileDeviceTemplateKey INT, @EventTemplateKey INT;

    -- 1. Fetch Core IDs (Using existing function or direct query)
    --    Requires a reliable way to get these keys for the given MobileUnitId
    --    Using udfGetMobileUnitBasicInfoForConfigGroups as a placeholder - replace if needed
    BEGIN TRY
        -- Attempt to get basic info using the function
        -- Note: This function expects a table variable input; adapting for single ID
        DECLARE @ConfigGroupId BIGINT = (SELECT TOP 1 mu.ConfigurationGroupKey
                                         FROM [DeviceConfiguration].[mobileunit].[MobileUnits] mu
                                         WHERE mu.MobileUnitId = @MobileUnitId);

        IF @ConfigGroupId IS NOT NULL
        BEGIN
             DECLARE @InputIdsForBasicInfo [dbo].[SelectionIds];
             INSERT INTO @InputIdsForBasicInfo (id) VALUES (@ConfigGroupId);

             SELECT TOP 1
                 @MobileUnitKey = bi.MobileUnitKey, @MobileDeviceKey = bi.MobileDeviceKey,
                 @LibraryKey = bi.LibraryKey, @EventTemplateKey = bi.EventTemplateKey,
                 @MobileDeviceTemplateKey = bi.MobileDeviceTemplateKey
             FROM [state].[udfGetMobileUnitBasicInfoForConfigGroups](@InputIdsForBasicInfo) bi
             WHERE bi.MobileUnitId = @MobileUnitId;
        END

        -- Fallback or alternative: Direct query if function isn't suitable or fails
        IF @MobileUnitKey IS NULL -- Check if function failed or wasn't applicable
        BEGIN
             SELECT TOP 1
                 @MobileUnitKey = mu.MobileUnitKey,
                 @MobileDeviceKey = md.DeviceKey, -- Assuming MobileDeviceKey relates to definition.Devices
                 @LibraryKey = cg.LibraryKey,
                 @EventTemplateKey = cg.EventTemplateKey,
                 @MobileDeviceTemplateKey = cg.MobileDeviceTemplateKey
             FROM [DeviceConfiguration].[mobileunit].[MobileUnits] mu WITH (NOLOCK)
             INNER JOIN [DeviceConfiguration].[template].[ConfigurationGroups] cg WITH (NOLOCK) ON mu.ConfigurationGroupKey = cg.ConfigurationGroupKey
             INNER JOIN [DeviceConfiguration].[definition].[Devices] md WITH (NOLOCK) ON mu.MobileDeviceKey = md.DeviceKey -- Adjust join if MobileDeviceKey maps differently
             WHERE mu.MobileUnitId = @MobileUnitId;
        END

    END TRY
    BEGIN CATCH
         PRINT 'Error fetching initial keys for MobileUnitId ' + CAST(@MobileUnitId AS VARCHAR(20)) + ': ' + ERROR_MESSAGE();
         RETURN; -- Cannot proceed without keys
    END CATCH


    IF @MobileUnitKey IS NULL OR @LibraryKey IS NULL OR @MobileDeviceTemplateKey IS NULL OR @EventTemplateKey IS NULL BEGIN
        PRINT 'Could not find necessary keys (MobileUnitKey, LibraryKey, MobileDeviceTemplateKey, EventTemplateKey) for MobileUnitId ' + CAST(@MobileUnitId AS VARCHAR(20));
        RETURN; -- Cannot proceed
    END

    BEGIN TRY
        -- Constants
        DECLARE @OPEN_BRACKET BIGINT = 981729539706373388;
        DECLARE @CLOSE_BRACKET BIGINT = -8380423587615480304;

        -- 2. Determine Enabled Hardware Configuration
        --    CTE 1: Base Template Devices (Logical & Peripheral)
        WITH BaseTemplateDevices AS (
            SELECT
                td.TemplateDeviceKey,
                td.DeviceKey,
                dd.DeviceId AS DefinitionDeviceId,
                CASE WHEN dl.DeviceKey IS NOT NULL THEN 1 ELSE 0 END AS IsLogical,
                td.IsEnabled AS TemplateIsEnabled
            FROM [DeviceConfiguration].[template].[Devices] td WITH (NOLOCK)
            INNER JOIN [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK) ON td.DeviceKey = dd.DeviceKey
            LEFT JOIN [DeviceConfiguration].[definition].[LogicalDevices] dl WITH (NOLOCK) ON td.DeviceKey = dl.DeviceKey
            WHERE td.MobileDeviceTemplateKey = @MobileDeviceTemplateKey AND td.LibraryKey = @LibraryKey
        ),
        --    CTE 2: Apply Overrides to get Effective Enabled Status
        EffectiveDeviceStatus AS (
            SELECT
                btd.DefinitionDeviceId,
                btd.IsLogical,
                -- Apply Logical Overrides
                CASE
                    WHEN btd.IsLogical = 1 THEN ISNULL(od.IsEnabled, btd.TemplateIsEnabled)
                    ELSE btd.TemplateIsEnabled -- Initial assumption for non-logical
                END AS IsEnabledPrePeripheralOverride,
                btd.TemplateDeviceKey -- Needed for peripheral override join
            FROM BaseTemplateDevices btd
            LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenDevices] od WITH (NOLOCK)
                ON btd.TemplateDeviceKey = od.TemplateDeviceKey AND od.MobileUnitKey = @MobileUnitKey AND btd.IsLogical = 1
        ),
        --    CTE 3: Apply Peripheral Overrides (Focus on enablement via LineId)
        EnabledDeviceIds AS (
            SELECT eds.DefinitionDeviceId
            FROM EffectiveDeviceStatus eds
            WHERE eds.IsLogical = 1 AND eds.IsEnabledPrePeripheralOverride = 1 -- Enabled Logical Devices
            UNION -- Union handles distinct
            SELECT eds.DefinitionDeviceId
            FROM EffectiveDeviceStatus eds
            LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK)
                ON eds.TemplateDeviceKey = opd.TemplateDeviceId AND opd.MobileUnitKey = @MobileUnitKey
            WHERE eds.IsLogical = 0 -- Focus on Peripherals
              AND (
                    -- Enabled if Template says enabled AND NOT overridden to be disconnected (LineId IS NULL in override)
                    (eds.IsEnabledPrePeripheralOverride = 1 AND (opd.MobileUnitKey IS NULL OR opd.LineId IS NOT NULL))
                    OR
                    -- OR Enabled if Template says disabled BUT overridden to be connected (LineId IS NOT NULL in override)
                    (eds.IsEnabledPrePeripheralOverride = 0 AND opd.MobileUnitKey IS NOT NULL AND opd.LineId IS NOT NULL)
                  )
            UNION -- Add the main mobile device itself
            SELECT DeviceId FROM [DeviceConfiguration].[definition].[Devices] WITH (NOLOCK) WHERE DeviceKey = @MobileDeviceKey
        )
        -- 3. Identify Supported Parameters from Enabled Devices
        , AllSupportedParameters AS (
            SELECT DISTINCT dp.ParameterId
            FROM [DeviceConfiguration].[definition].[DeviceParameters] ddp WITH (NOLOCK)
            INNER JOIN [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK) ON ddp.DeviceKey = dd.DeviceKey
            INNER JOIN EnabledDeviceIds edi ON dd.DeviceId = edi.DefinitionDeviceId -- Filter by effectively enabled devices
            INNER JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK) ON dp.ParameterKey = ddp.ParameterKey
            INNER JOIN [DeviceConfiguration].[library].[Parameters] lp WITH (NOLOCK) ON lp.ParameterKey = dp.ParameterKey AND lp.LibraryKey = @LibraryKey
            INNER JOIN [DeviceConfiguration].[library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = ddp.DeviceKey AND ld.LibraryKey = @LibraryKey -- Ensure device is in library context
        )
        -- 4. Analyze Events and Conditions
        , EventParameterSupport AS (
            SELECT
                te.EventKey,
                -- de.EventType, -- Not needed for final check
                ISNULL(muoe.IsEnabled, 1) AS IsEventEnabled, -- Check override, default to enabled
                tec.IsRequired AS IsConditionParamRequired,
                dp.ParameterId AS ConditionParameterId,
                CASE WHEN asp.ParameterId IS NOT NULL THEN 1 ELSE 0 END AS IsConditionParamSupported
            FROM [DeviceConfiguration].[template].[Events] te WITH (NOLOCK)
            INNER JOIN [DeviceConfiguration].[definition].[Events] de WITH (NOLOCK) ON de.EventKey = te.EventKey
            LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenEvents] muoe WITH (NOLOCK)
                ON muoe.MobileUnitKey = @MobileUnitKey AND muoe.TemplateEventKey = te.EventKey -- Join for event enablement override
            LEFT JOIN [DeviceConfiguration].[template].[EventConditions] tec WITH (NOLOCK)
                ON tec.LibraryKey = te.LibraryKey AND tec.EventTemplateKey = te.EventTemplateKey AND tec.EventKey = te.EventKey
            LEFT JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK)
                ON dp.ParameterKey = tec.ParameterKey AND dp.ParameterId NOT IN (@OPEN_BRACKET, @CLOSE_BRACKET) -- Exclude brackets here
            LEFT JOIN AllSupportedParameters asp ON asp.ParameterId = dp.ParameterId -- Check against our calculated supported params
            WHERE te.LibraryKey = @LibraryKey
              AND te.EventTemplateKey = @EventTemplateKey
              AND de.EventType != 0 -- Ignore Hidden events (as per C# logic)
        )
        -- 5. Final Check: Find any enabled event with a missing required parameter
        SELECT TOP 1 @IsMissingParameters = 1
        FROM EventParameterSupport eps
        WHERE eps.IsEventEnabled = 1
          -- EventType <> 10 condition removed based on C# logic review
          AND eps.IsConditionParamRequired = 1
          AND eps.IsConditionParamSupported = 0; -- The core check: required but not supported

    END TRY
    BEGIN CATCH
        -- Basic error logging
        PRINT 'Error during parameter support analysis for MobileUnitId ' + CAST(@MobileUnitId AS VARCHAR(20)) + ': ' + ERROR_MESSAGE();
        -- Consider re-throwing or returning a specific error code/status
        -- SET @IsMissingParameters = NULL; -- Indicate error?
    END CATCH

END;
GO
