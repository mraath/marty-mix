---
status: closed
date: 2023-06-27
comment: 
priority: 8
---

# SR-15595 Assets reporting incorrect time

Date: 2023-06-27 Time: 22:06
Parent:: [[Command 45]]
Friend:: [[2023-06-27]]
JIRA:SR-15595 Assets reporting incorrect time
[SR-15595 M4K Unit reporting times in future - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15595)

## Branch

- xxxxxxxxxxxxxxxxxxxxxxxxx.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

Local: 🟧 Dev: 🟨 INT: 🟩 UAT: 🟦 PROD: 🟪
🟧🟨🟩🟦🟪

## PRs

- 

## Description

- DC: VIR
- Database: Halliburton North America  
- Vehicle: 13673154 - Pickup - 2022 Chevrolet 1500  
- Asset ID: 2705  
- IMEI: 353863118732043

## SQL

```sql

SELECT top 5 * FROM Fmonlinedb.dbo.organisation
WHERE sOrganisationName LIKE '%Halliburton North America%' --682

SELECT top 5 * FROM DeviceConfiguration.mobileunit.AssetMobileUnits WHERE LegacyOrgID = 682 and legacyvehicleid = 2705 --291262

select * from DeviceConfiguration.mobileunit.Mobileunits WHERE MobileUnitKey = 291262 --1241513025111339008


SELECT TOP 50
  MessageId, MessageSubType, ParamsJson, *
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum
WHERE ParamsJson LIKE '%"CommandId":45,%'
  AND mum.MobileUnitId = 1241513025111339008
```
