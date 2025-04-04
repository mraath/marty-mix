---
created: 2025-04-04T11:13
updated: 2025-04-04T14:08
---
Now that the message alerts (digits 1 and 2) are aligned, let's move to the next potential source of difference: the **firmware outdated alert (digit 3)**.

**Refactored Logic (`uspGetMobileUnitFirmwareInfo`):**

1. Gets the installed firmware name/ID from `state.MobileUnitState`.
2. Determines the preferred firmware name/ID by checking `template.DeviceProperties` and looking for overrides in `mobileunit.OverridenDeviceProperties`.
3. Identifies the _type_ of the installed firmware.
4. Determines the correct "anchor" device ID based on the firmware type.
5. Checks device capabilities (FMBas, CAN incompatibility) based on the main `MobileDeviceKey`.
6. Filters the available firmware versions (`definition.FirmwareVersions` joined with `library.FirmwareVersions`) based on the firmware type, library, and applies FMBas/CAN incompatibility filters.
7. Assigns a sequential `VersionNumber` to the filtered, available versions.
8. Finds the `VersionNumber` for the _installed_ firmware and the `MAX(VersionNumber)` (latest available).
9. Sets the `IsFirmwareOutdated` output parameter to 1 if the difference between latest and installed version numbers is greater than 2.

**Original Stored Procedure Logic (Firmware Part):**

This was significantly more complex and interwoven in the original:

1. It gathered template/preferred firmware info into `@ConfigGroupsFWVersions` and overrides into `@AssetPreferredFWVersions`.
2. It got installed firmware from `state.MobileUnitState` into `@FWVersionInstalled`.
3. It built a complex `@filteredVersions` table containing available firmware versions per type/anchor, assigning version numbers.
4. It calculated the max version number per type/anchor into `@maxFirmwareVersion`.
5. It combined all this in `@MobileUnitFWVersions` and finally calculated the outdated flag (`OutdatedFW`) in `@MobileUnitFWOutdated` by comparing the installed version number (`ffw.VersionNumber`) against the max (`mfw.VersionNumber`).

**Potential Differences & Areas to Investigate:**

- **Determining "Latest" Version:** The method of assigning `ROW_NUMBER()` in the SP vs. the original might differ if the ordering isn't precisely the same (e.g., if version names aren't perfectly sequential). The original used `ROW_NUMBER() OVER (ORDER BY (SELECT NULL))` within many separate inserts into `@filteredVersions`, while the SP uses `ROW_NUMBER() OVER (ORDER BY dfw.FirmwareVersionKey)`. This ordering difference could affect the comparison if the > 2 check lands differently.
- **FMBas/CAN Filtering Logic:** While I tried to replicate the logic (checking `@FM3XXX_MOBILE_DEVICE_RANGE` dependency for FMBas, checking specific `DeviceIds` for CAN incompatibility), any subtle difference in how these checks are applied could lead to different sets of "available" firmware being considered. For example, the original checked `fw.MobileDeviceKey IN (SELECT DeviceKey FROM @FMBasDevices)`, while the SP checks dependencies based on the passed `@MobileDeviceKey`.
- **Logical Device Identification:** The SP attempts to find the relevant logical device (`@LogicalDeviceId`) to determine the firmware type anchor. The original SP derived this through joins in the `@ConfigGroupsFWVersions` CTE. Any mismatch here could lead to comparing against the wrong set of latest firmware.
- **Data Type Conversions:** Both use `TRY_CAST` for firmware IDs from properties/overrides, which should be consistent.

Do you see differences in the third digit of the `Alerts` code in your comparison results? If so, could you provide one or two `MobileUnitId` examples where this digit differs?

Let's get back to comparing the results. Now that the first two digits (message alerts) are aligned, have you noticed any differences in the **third digit** of the `Alerts` code between the original and refactored procedures in your test results? This digit represents the firmware outdated status calculated by `uspGetMobileUnitFirmwareInfo`.

If you are seeing differences, could you please provide one or two `MobileUnitId` examples where the third digit differs? Knowing the specific examples will help us trace the logic within the original SP and the new `uspGetMobileUnitFirmwareInfo` to find the discrepancy.

==Here are some examples==: 1113953193286172672, 1121885054700744704, 1096950484704075776, 1360022093041086464, 1519091697465741312

Based on our previous analysis, the most likely reasons for discrepancies in the firmware outdated calculation between the original procedure and the refactored `uspGetMobileUnitFirmwareInfo` are:

1. **Version Ordering (`ROW_NUMBER()`):** This is a strong candidate. The original procedure assigned version numbers using `ROW_NUMBER() OVER (ORDER BY (SELECT NULL))` across multiple `INSERT` statements into the `@filteredVersions` table variable. This ordering might be non-deterministic or rely on the physical order of rows in the source tables at the time. The refactored SP uses `ROW_NUMBER() OVER (ORDER BY dfw.FirmwareVersionKey)`. If the intended sequence for comparing "latest" vs. "installed" relies on the firmware _name_ (e.g., '1.70', '1.71', '1.80') rather than the `FirmwareVersionKey`, using `ORDER BY dfw.FirmwareVersionKey` could lead to a different sequence and thus a different result for the `(Latest - Installed) > 2` check.
2. **FMBas/CAN Filter Context:** The original procedure determined FMBas/CAN incompatibility based on the `MobileDeviceKey` derived through several joins leading into the `@MobileUnitFWVersions` table variable. The refactored SP uses the `@MobileDeviceKey` passed directly as an input parameter to perform these checks. If the `MobileDeviceKey` used in these two contexts represents a different device (e.g., the base mobile unit vs. a logical component) for a given `MobileUnitId`, the filtering of available firmware versions could differ, impacting the "latest" version calculation.
3. **Logical Device Identification:** Minor differences in identifying the specific logical device associated with the firmware property (`@LogicalDeviceId` in the SP) could lead to comparing against the wrong set of firmware versions.

**Recommendation:**

Let's first focus on the **Version Ordering**. Do you know if the firmware versions for a given type are intended to be ordered chronologically based on their `Name` or their `FirmwareVersionKey`?

- If ordering should be by `Name`, we should change `ORDER BY dfw.FirmwareVersionKey` to `ORDER BY dfw.Name` (or potentially `TRY_CAST(dfw.Name AS DECIMAL(10,2))` if names are numeric like '1.70') within the `ROW_NUMBER()` function inside `uspGetMobileUnitFirmwareInfo`.
- If ordering _should_ be by `FirmwareVersionKey`, then the refactored SP is likely correct in its ordering, and the discrepancy might lie elsewhere (like the FMBas/CAN filtering).

Knowing the intended ordering logic is key to aligning this calculation. What is the correct way to determine the sequence of firmware versions for the "latest vs. installed" comparison?

