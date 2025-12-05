---
created: 2025-11-24T15:34
updated: 2025-11-24T15:34
---
Yes, you are correct to question the `LIKE` clause on `SystemName`. It is not a robust, long-term solution.

Based on a deeper investigation into the database schema, I have found a "linking table" that provides a much cleaner, data-driven way to find the main logical firmware device.

### The Linking Table: `[definition].[DeviceDependencies]`

This table explicitly defines parent-child relationships between devices. It contains the following key columns:
-   `ParentDeviceKey`: The `DeviceKey` of the main device.
-   `ChildDeviceKey`: The `DeviceKey` of a device that depends on the parent.
-   `DependencyType`: A number that defines the *kind* of relationship.

By inspecting the database's seed scripts, I found the definitions for `DependencyType`:
-   `1`: Optional
-   `2`: **Required**
-   `3`: Excluded

The relationship between a main mobile device and its firmware-carrying logical device is a **`Required`** dependency. The main device is the `Parent`, and the logical device is the `Child`.

### The "Cleaner" Data-Driven Solution

We can replace the fragile `LIKE` clauses with a `JOIN` to this table. The logic is as follows:

1.  Start with the main mobile device's `DeviceKey`.
2.  Find the `ChildDeviceKey` in `[definition].[DeviceDependencies]` where the `ParentDeviceKey` matches our main device and the `DependencyType` is `2` (Required).
3.  This `ChildDeviceKey` is the `DeviceKey` for the logical device that holds the firmware.
4.  Use this logical device's `DeviceKey` to get the property.

Here is what the revised SQL for the firmware section would look like:

```sql
  -- FW VERSION
  DECLARE @FWVersions TABLE  
    (
    [ConfigurationGroupId] BIGINT,
    [FWName]               NVARCHAR(50)
    );
  INSERT INTO @FWVersions
  SELECT
    [ConfigurationGroupId] = g.ConfigurationGroupId,
    [FWName] = fw.Name
  FROM @GeneralConfigGroupInfo g
    -- Find the required logical device dependency for the main mobile device
    INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
        ON dep.ParentDeviceKey = g.DeviceKey
        AND dep.DependencyType = 2 -- 'Required' dependency
    -- Join template.Devices on the CHILD key from the dependency table
    INNER JOIN [template].[Devices] td WITH (NOLOCK)
        ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
        AND td.DeviceKey = dep.ChildDeviceKey -- This is the logical firmware device
    -- Now that we have the correct logical device, get its properties
    INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
        ON tdpr.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
        AND tdpr.DeviceKey = td.DeviceKey -- td.DeviceKey is now the correct logical device
        AND tdpr.PropertyKey = @FWVersion
    INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = tdpr.Value
```

This approach is superior because it relies on a defined relationship in the data model rather than a naming convention, making it more reliable and maintainable.
