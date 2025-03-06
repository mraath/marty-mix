---
status: closed
date: 2023-05-29
comment: 
priority: 8
---

# SR-15387 Issue enrolling assets

Date: 2023-05-29 Time: 14:25
Parent:: ==xxxx==
Friend:: [[2023-05-29]]
JIRA:SR-15387 Issue enrolling assets
[SR-15387 OEM - Stellantis: Unable to process enrollment of assets - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15387)

## Branch

- xxxxxxxxxxxxxxxxxxxxxxxxx.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## PRs

- 

## Description

Asset not found in selected organisation

### Intro 

#### Assets Pending configuration:  

Asset 1:  
Reg: ST0141LKW  
VID: 138  
64 Bit Asset ID: 1395200997257388032  
Config: Default configuration group for Stellantis OEM

Asset 2:  
Reg: ST0780LHV  
VID: 141  
64 Bit Asset ID: 1395201055998484480  
Config: Default configuration group for Stellantis OEM  
  
#### Assets that accepted configuration:  

Asset 1:  
Reg: ST0838LHV  
VID: 139  
64 Bit Asset ID: 1395201024214179840  
Config: Default configuration group for Stellantis OEM

Asset 2:  
Reg: ST0142LKW  
VID: 140  
64 Bit Asset ID: 1395201040190283776  
Config: Default configuration group for Stellantis OEM

### Asset 1

May 23, 2023 @ 17:39:48.595

Called DeviceConfig.MobileUnits.UpdateConfigurationStatus(), Vin=VF3M45GBULS171411, DC=UK, MobileUnitId=1382825224643297280, Status=ConfigurationAccepted, CorrelationId=, Message=, DeviceConfigValidationMessage=Asset not found in selected organisation

| Stellantis Demo1 | MiX Internal - Sales Demo | Passenger Vehicle | Available | 138 | ST0141LKW |
| ---------------- | ------------------------- | ----------------- | --------- | --- | --------- |
|                  |                           |                   |           |     |           |

id=1395200997257388032&orgId=-8132622465982899007

### Asset 2

May 23, 2023 @ 17:40:45.589

Called DeviceConfig.MobileUnits.UpdateConfigurationStatus(), Vin=VF3M45GBULS116719, DC=UK, MobileUnitId=1382828722479026176, Status=ConfigurationAccepted, CorrelationId=, Message=, DeviceConfigValidationMessage=Asset not found in selected organisation

| Stellantis Demo4 | MiX Internal - Sales Demo | Passenger Vehicle | Available | 141 | ST0780LHV |
| ---------------- | ------------------------- | ----------------- | --------- | --- | --------- |

id=1395201055998484480&orgId=-8132622465982899007

