---
created: 2023-11-20T10:50
updated: 2023-11-20T10:50
---

```sql
USE Deviceconfiguration;

-- Follow the money - get those values
-- Only one for each value, so this already shows that both CalAmps point to the same values, else we would see two for each
SELECT ldprop.[Value], ldprop.DeviceKey, dd.SystemName, dd.DeviceID, dld.DisplayLabel AS Logical, ldprop.PropertyKey, dprop.PropertyName, dprop.PropertyId, dprop.DisplayLabel
    FROM library.DeviceProperties ldprop
    INNER JOIN definition.Devices dd ON dd.DeviceKey = ldprop.DeviceKey
    LEFT JOIN definition.LogicalDevices dld ON dld.DeviceKey = ldprop.DeviceKey
    INNER JOIN definition.Properties dprop ON dprop.PropertyKey = ldprop.PropertyKey
    WHERE value IN ('133', '14416', '37', '259200') 
    AND LibraryKey = 2715


-- REST is purely figuring out values, above shows enough

SELECT top 10 * FROM definition.LogicalDevices WHERE DeviceKey in (974,2240,27244,27245)

-- Get the definition values
-- They were the base values expected
SELECT * FROM definition.Devices where DeviceKey IN (974,2240,27244,27245)
SELECT * FROM definition.Properties WHERE PropertyKey IN (318,487,164,487)

-- Let's see whats in the libraries
-- Only the two devices - that is fine
-- Only two properties with values, surely each device should save its own properties
--  In this case each device saved one property :-)
SELECT * FROM library.Devices where DeviceKey IN (27245,27244) AND LibraryKey = 2715
SELECT * FROM library.DeviceProperties WHERE PropertyKey IN (487,164) AND LibraryKey = 2715 AND DeviceKey IN (27245,27244)

-- NEXT, find out how the library linked up the same DeviceProperty for both these devices
-- Must be set up wrong are read wrong

/*
OK maar wag - ek sien nou daai twee properties behoort wel aan daai twee devices... want die devices na wie hul verwys is die logicals wat jy ook noem:

System.Logical.CalAmpAVLs
System.Logical.CalAmp.UnitPowerManagement

OK - so my verwagting sal dan wees dat elke ACTUAL device, eg. Calamp LITE + PREMIUM sy eie properties moet stoor... dis wat ek volgende sou investigate

--SELECT TOP 10 * FROM definition.Devices WHERE systemName like '%Calamp%'
--Lite, Premium
-- 27176, 27085

SELECT * FROM library.DeviceProperties WHERE LibraryKey = 2715 AND DeviceKey IN (27176, 27085)
-- AND PropertyKey IN (487,164)

--They don't have their own properties... WHAT?
-- OK - I'm going on weekend now :P
*/
```
