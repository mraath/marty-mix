---
status: closed
date: 2022-10-24
comment: Lightning issue
priority: 8
---

Date: 2022-10-24 Time: 10:19
Parent:: xxxx
Friend:: [[2022-10-24]]
JIRA:QA-5464 

# QA-5464 Data Exclusions Quarantined events still show

## Image


## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.13 |     |
| Local |     |

## Branch
Config/MR/Bug/QA-5464 Data Exclusions Quarantined events still show.xx.xx.ORI

## Learned
- Erika is the PO
- Assigned to Lightning

## Description

Testing on UAT 22.15  
Org: QA Live Lightning  
Org id: -2654620699520264046  
Asset id: 1263548102673657856

Steps to replicate:

Navigate to MANAGE - OPERATIONS -> Data exclusion  
Add a new Data exclusion query  
**Data query criteria:** Filter on Assets | Select a asset | Date selection: Last month | Query type: Events  
Submit

**BUG:** After the ETL has run and all relevant emails and checks where performed, it seem that the events that are being quarantined are still displayed on the Detailed Event Report

*HOWEVER*
	- [MiX Telematics - Assets](https://uat.mixtelematics.com/#/fleet-admin/asset/details?id=1263548102673657856&orgId=-3050897502994317689)
	- id=1263548102673657856
	- orgId=-3050897502994317689

## Code sections

## Files

## Resources

## Notes

