---
wiki_ingested: 2026-05-28
---
You were right, the previous "cleaner" solution was not working because my assumption about the `DeviceDependencies` table was incomplete. Thank you for the feedback, it helped me find the correct relationship.

I've analyzed the `DevicesData.xml` file, which contains the source data for the dependencies, and I have a definitive answer and a new, robust solution.

### What Was Wrong Before?

1.  **My `DependencyType = 2` solution failed:** I hypothesized that the link between a main device and its firmware logical device was `DependencyType = 2` ('Required'). The data shows this link is actually **`DependencyType = 1`** ('Optional').
2.  **Direction was correct:** The main mobile device (e.g., MiX4000) is the `ParentDeviceKey`, and the logical firmware device is the `ChildDeviceKey`.
3.  **Why it returned NULL:** Since the query was looking for a `DependencyType` of `2`, the `JOIN` on the `DeviceDependencies` table found no matching rows, resulting in an empty `@FWVersions` table and a `NULL` final result.

### The Correct Data-Driven "Cleaner" Solution

The ideal solution is to use the `DeviceDependencies` table to find all children of the main device and then intelligently select the correct child. The `SystemName` still provides the best way to identify which of the children is the firmware-carrier.

This results in a hybrid approach that is much more reliable:

1.  **Traverse the Relationship:** We use `DeviceDependencies` to correctly find all devices that are children of the main mobile device.
2.  **Filter the Children:** We then use the `LIKE '%.Firmware'` clause on the `SystemName` of those children to pinpoint the specific logical device that holds the firmware.

This is a significant improvement because we are no longer guessing at the relationship; we are traversing a defined parent-child link and then applying a specific filter.

### The New SQL Logic

Here is the updated, correct query for the firmware section. I will also update the solution file with this logic.

```sql
  -- FW VERSION
  DECLARE @FWVersions TABLE  
    (
    [ConfigurationGroupId] BIGINT,
    [FWName]               NVARCHAR(50)
    );
  INSERT INTO @FWVersions
  SELECT
    g.ConfigurationGroupId,
    fw.Name
  FROM @GeneralConfigGroupInfo g
    -- Find the logical device that is a child of the main mobile device
    INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
        ON dep.ParentDeviceKey = g.DeviceKey
    -- Join to the child device's definition
    INNER JOIN [definition].[Devices] logical_fw_device WITH (NOLOCK)
        ON logical_fw_device.DeviceKey = dep.ChildDeviceKey
    -- Join to the template's instance of that child device
    INNER JOIN [template].[Devices] td WITH (NOLOCK)
        ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
        AND td.DeviceKey = logical_fw_device.DeviceKey 
    -- Now, get the property for that specific logical device, filtering by its name
    INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
        ON tdpr.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
        AND tdpr.DeviceKey = td.DeviceKey
        AND tdpr.PropertyKey = @FWVersion
        AND logical_fw_device.SystemName LIKE '%.Firmware' -- Filter to ensure it's a firmware device
    INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = tdpr.Value
```
This should now work correctly and is much more robust than the original name-based filtering alone.
