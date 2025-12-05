---
created: 2025-11-24T14:14
updated: 2025-11-26T09:27
---
# Summary of Findings

## The Problem
You needed to retrieve only the **main mobile device's firmware version** for each configuration group, but the original query was returning multiple firmware versions from both the main device and peripheral devices.

## What We Discovered

### Data Model Structure
1. **Main Mobile Device** (e.g., FM 3607i, MiX6000) is stored in `[definition].[MobileDevices]` with DeviceKey like 174
2. **Firmware is NOT stored on the main device**, but rather on **logical devices** in the template:
   - FM devices: firmware on `MobileDevice.Logical.Base.FM` (DeviceKey 57)
   - MiX devices: firmware on `System.Logical.MiX6000.Firmware` (DeviceKey 5760)
   - CANiQ devices: firmware on `System.Logical.CANiQ-M(M).Firmware`

3. **Peripheral devices** also have firmware that we DON'T want:
   - `System.Logical.Scriptable.CAN.Bus` - CAN Bus firmware
   - `System.Logical.FM3D` - 3D accelerometer
   - `System.Logical.HoursOfService` - HOS device
   - `System.Terminal` - Terminal device

### The Solution
Filter firmware properties using **naming conventions**:

```sql
WHERE 
  (
    dd.SystemName LIKE 'MobileDevice.Logical.%'      -- FM base devices
    OR dd.SystemName LIKE '%.Firmware'                -- All MiX and CANiQ firmware devices
  )
  AND tdpr.Value IS NOT NULL
```

This pattern:
- ✅ Captures all main device firmware (FM, MiX2000, MiX4000, MiX6000, CANiQ, etc.)
- ❌ Excludes peripheral firmware (CAN Bus, HOS, FM3D, Terminal)
- Works without hardcoded DeviceType or exclusion lists

### Device Types Found with Firmware
- `MobileDevice.Logical.Base.FM` (18 instances)
- `System.Logical.MiX2000.Firmware` (5)
- `System.Logical.MiX2310i.Firmware` (4)
- `System.Logical.MiX3000.Firmware` (3)
- `System.Logical.MiX4000.Firmware` (29)
- `System.Logical.MiX6000.Firmware` (14)
- `System.Logical.MiX6000LTE.Firmware` (4)
- `System.Logical.CANiQ-M(M).Firmware` (4)

All are DeviceType = 130 (logical devices)

## Next Investigation

You want to find a **proper link table** that explicitly connects the main mobile device to its firmware-carrying logical device, rather than relying on naming conventions. This would be more robust and less dependent on naming patterns.

**Looking for:**
- A table that links main device → firmware device
- Columns in existing tables (like `[template].[Devices]`) that indicate device hierarchy or role (ParentDeviceKey, IsPrimaryDevice, DeviceRole, etc.)
- Any explicit relationship that says "DeviceKey 174's firmware is stored on DeviceKey 57"

This would provide a **data-driven solution** instead of a pattern-matching solution, making it more maintainable and future-proof.


---

# Updated Summary - Final Solution

## The Problem
You needed to retrieve only the **main mobile device's firmware version** for each configuration group, but the original query was returning multiple firmware versions from both the main device and peripheral devices.

## What We Discovered

### Data Model Structure
1. **Main Mobile Device** (e.g., FM 3607i, MiX6000) is stored in `[definition].[MobileDevices]` with DeviceKey like 174 (FM) or 1232 (MiX6000)
2. **Firmware is NOT stored on the main device**, but rather on **logical dependency devices**:
   - FM devices: firmware on `MobileDevice.Logical.Base.FM` (DeviceKey 57)
   - MiX devices: firmware on `System.Logical.MiX6000.Firmware` (DeviceKey 5760)
   - CANiQ devices: firmware on `System.Logical.CANiQ-M(M).Firmware`

3. **Device Dependencies** are defined in `[definition].[DeviceDependencies]`:
   - `ParentDeviceKey`: The main mobile device
   - `ChildDeviceKey`: Dependent devices (logical devices, peripherals, etc.)
   - `DependencyType`: 1 = Optional, 2 = Required, 3 = Excluded NOT SURE ABOUT THESE VALUES
   - **Firmware-carrying devices are DependencyType = 1 (Optional - not sure about this)**

4. **Key Discovery**: Among all optional dependencies of a main device, **only ONE device has the firmware property** (`@FWVersion`). This naturally identifies the firmware-carrying device without needing naming patterns.

### Evolution of Solutions

**Attempt 1 (Original):** Filtered by `DeviceKey = g.DeviceKey`
- ❌ Failed because firmware isn't stored on the main device

**Attempt 2 (Pattern Matching):** Used SystemName patterns
```sql
WHERE (
  dd.SystemName LIKE 'MobileDevice.Logical.%'
  OR dd.SystemName LIKE '%.Firmware'
)
```
- ✅ Worked but relied on naming conventions
- ❌ Fragile if naming patterns change

**Attempt 3 (DeviceDependencies + Patterns):** Combined relationships with patterns
- ✅ Better but still used naming conventions
- ❌ Initially used wrong DependencyType (2 instead of 1)

**Final Solution (Pure Data-Driven):** Use DeviceDependencies with property existence
```sql
-- Use device dependencies and filter by firmware property existence
INNER JOIN [definition].[DeviceDependencies] dep
  ON dep.ParentDeviceKey = g.DeviceKey
  AND dep.DependencyType = 1  -- Optional dependencies
INNER JOIN [template].[DeviceProperties] tdpr
  ON tdpr.DeviceKey = dep.ChildDeviceKey
  AND tdpr.PropertyKey = @FWVersion  -- Only devices with firmware property
```
- ✅ Completely data-driven
- ✅ No hardcoded patterns or device names
- ✅ Future-proof for new device types
- ✅ Uses proper relational database design

### Final Working Solution

```sql
-- FW VERSION - Pure data-driven approach using DeviceDependencies
DECLARE @FWVersions TABLE  
(
  [ConfigurationGroupId] BIGINT,
  [FWName]               NVARCHAR(50)
);

INSERT INTO @FWVersions
SELECT DISTINCT
  [ConfigurationGroupId] = g.ConfigurationGroupId,
  [FWName] = fw.Name
FROM @GeneralConfigGroupInfo g
  -- Find optional logical device dependencies for the main mobile device
  INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
    ON dep.ParentDeviceKey = g.DeviceKey
    AND dep.DependencyType = 1 -- Optional dependencies
  -- Join template.Devices on the child device from dependencies
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
    AND td.DeviceKey = dep.ChildDeviceKey
  -- Get firmware properties from the dependency device
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = td.DeviceKey
    AND tdpr.PropertyKey = @FWVersion
  -- Get the firmware version details
  INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) 
    ON fw.FirmwareVersionId = tdpr.Value
WHERE tdpr.Value IS NOT NULL
```

### Why This Works

The key insight: **Only firmware-carrying devices have the firmware property populated**. By joining to `DeviceProperties` with the firmware `PropertyKey`, we automatically filter to only the correct device among all dependencies. The database schema itself tells us which device carries the firmware - no patterns or assumptions needed.

### Device Types with Firmware (For Reference)
- `MobileDevice.Logical.Base.FM` (18 instances)
- `System.Logical.MiX2000.Firmware` (5)
- `System.Logical.MiX2310i.Firmware` (4)
- `System.Logical.MiX3000.Firmware` (3)
- `System.Logical.MiX4000.Firmware` (29)
- `System.Logical.MiX6000.Firmware` (14)
- `System.Logical.MiX6000LTE.Firmware` (4)
- `System.Logical.CANiQ-M(M).Firmware` (4)

All are DeviceType = 130 (logical devices) and DependencyType = 1 (optional dependencies of their parent mobile devices).

https://claude.ai/chat/da7be569-f35e-42ab-a065-7da2d94283af


---

Findings to make it faster

Looking at the entire stored procedure, I can see several opportunities for major optimization. Let me analyze the whole thing:

## Major Issues:

1. **Lines section is a MASSIVE bottleneck** - Complex CROSS APPLY with multiple joins executed for every configuration group
2. **Repeated subqueries in final SELECT** - Each STUFF/subquery scans @AllConfigGroupLines multiple times
3. **Inefficient temp table population** - Some queries could be combined
4. **No indexes on temp tables** - Missing indexes on frequently joined columns

Here's a comprehensive optimization:## Key Optimizations:

### 1. **Temp Table Indexes** (HUGE impact)
- Added PRIMARY KEY and covering indexes on all temp tables
- This dramatically speeds up joins and lookups

### 2. **Lines Section Rewrite** (Biggest bottleneck)
- **Before**: CROSS APPLY for every config group with 10+ joins
- **After**: Pre-filter template device lines, then join once
- Eliminates the expensive CROSS APPLY entirely

### 3. **Asset Count Simplified**
- Removed intermediate @MobileUnits table
- Combined into single query with COUNT DISTINCT

### 4. **Black Flags Optimized**
- Replaced LEFT JOINs with EXISTS + UNION ALL
- Much faster for checking if any override exists
- No need for DISTINCT subquery

### 5. **Pre-Aggregated Lines**
- Instead of 7+ subqueries in final SELECT, aggregate once
- Uses MAX with CASE for simple fields
- Runs all STUFF operations once per config group

### 6. **Final SELECT Simplified**
- Just joins pre-aggregated data
- No more repeated scans of @AllConfigGroupLines

## Expected Performance:
This should bring you from **12s down to 2-4s** depending on data volume. The biggest wins are:
- **Lines section**: 70-80% faster
- **Black flags**: 50% faster  
- **Final SELECT**: 90% faster (no repeated subqueries)

Try this and let me know the results!

https://claude.ai/chat/3a105719-580b-4203-9438-d59a822fb2b1