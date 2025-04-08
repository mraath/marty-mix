---
created: 2025-04-08T16:56
updated: 2025-04-08T16:56
---
Okay, I've reviewed the original `MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql` procedure. It's quite complex as it calculates several different alert conditions simultaneously.

The relevant part for the "missing parameters" alert seems to be within the final `SELECT` statement, specifically the calculation for `Alert4` (lines 1088-1100 in the full procedure, based on the structure):

```sql
-- ... other alert calculations ...
Alert4 = CASE WHEN (
    SELECT TOP 1 1
    FROM @templateEvents te -- Events for the template
    INNER JOIN @templateEventConditions tec ON tec.EventKey = te.EventKey AND tec.EventTemplateKey = tcg.EventTemplateKey AND tec.LibraryKey = tcg.LibraryKey -- Conditions for the event
    INNER JOIN @definitionParameters dp ON dp.ParameterKey = tec.ParameterKey -- Definition parameter ID
    LEFT JOIN @mobileunitOverridenEvents muoe ON muoe.MobileUnitKey = mu.MobileUnitKey AND muoe.TemplateEventKey = te.EventKey -- Event override
    WHERE tec.IsRequired = 1 -- Only check required parameters
      AND ISNULL(muoe.IsEnabled, 1) = 1 -- Only check enabled events
      AND NOT EXISTS ( -- Check if the required parameter is NOT supported
          SELECT 1
          FROM @definitionDeviceParameters ddp -- Parameters defined for devices
          INNER JOIN @templateDevices td ON td.DeviceKey = ddp.DeviceKey AND td.MobileDeviceTemplateKey = tcg.MobileDeviceTemplateKey AND td.LibraryKey = tcg.LibraryKey -- Devices in the template
          INNER JOIN @definitionDevices dd ON dd.DeviceKey = td.DeviceKey
          -- Missing check for OverridenDevices/OverridenPeripheralDevices enablement here
          WHERE ddp.ParameterKey = tec.ParameterKey -- Match the parameter
            AND td.IsEnabled = 1 -- Check if the device is enabled *in the template*
      )
) = 1 THEN 1 ELSE 0 END,
-- ... rest of the SELECT ...
```

**Comparison and Why the Original Approach Was Incorrect:**

The core issue lies in how the original procedure determined if a required parameter was supported (the `NOT EXISTS` subquery):

1. **No Override Handling for Device Enablement:** The subquery checks `td.IsEnabled = 1` (line 1098). This `td` comes from `@templateDevices`, which is populated directly from `[template].[Devices]` (lines 117-134). It **does not** account for overrides defined in `[mobileunit].[OverridenDevices]` or `[mobileunit].[OverridenPeripheralDevices]`. The C# logic, however, explicitly applies these overrides _first_ to determine the _effective_ enabled state of each device before checking parameter support.
    - **Impact:** The original SQL could incorrectly determine that a parameter _is_ supported because the template says the device providing it is enabled, even if a mobile unit override actually _disables_ that specific device.
2. **No Check for Device Existence in Library:** The subquery joins `definition.DeviceParameters` to `template.Devices` and `definition.Devices`. It doesn't explicitly ensure that the device providing the parameter is actually part of the specific `Library` associated with the configuration group (unlike the C# code which effectively starts from `LibraryDeviceParameters`). While often implicitly true, it's less precise than the C# logic.
    - **Impact:** Less critical than the override issue, but could potentially lead to edge case inaccuracies if definitions and libraries diverge significantly.
3. **Potential Complexity/Performance:** While not strictly a logical error compared to the C#, embedding this complex subquery with `NOT EXISTS` inside the main `SELECT` for every mobile unit could be less efficient than the CTE-based approach in the new procedure, which calculates the set of supported parameters once per unit.

**In Summary:**

The primary reason your original attempt was inaccurate compared to the C# source of truth was its **failure to incorporate the mobile unit-specific device overrides** (`OverridenDevices` and `OverridenPeripheralDevices`) when determining which devices were actually enabled and therefore which parameters were truly supported by that specific unit's configuration. It relied too heavily on the base template's device enablement status. The new procedure (`uspGetMobileUnitMissingParameters_FromCSharpLogic`) explicitly models this override logic, mirroring the C# `GetResolvedMobileDevice` process, leading to the correct results.