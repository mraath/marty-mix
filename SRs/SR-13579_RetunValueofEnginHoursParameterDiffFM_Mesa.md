---
status: resolved
date: 2022-09-27
comment: Nicole > Russell > Wynand HOTFIX PROD 23.2
priority: 8
created: 2022-09-27T15:18
updated: 2024-10-02T13:17
---

Date: 2022-09-27 Time: 09:18
Parent:: xxxx
Relates to: MX46-979
PO: Nicole
Friend:: [[2022-09-27 1]]
JIRA:SR-13579
[SR-13579 RW - Return value of Engine hours parameter differs between FM and MiX 4000 - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-13579)


Implementation: https://jira.mixtelematics.com/browse/MX46-1089

# SR-13579_RetunValueofEnginHoursParameterDiffFM_Mesa

## Image

![[Engine hours report.excalidraw]]

## Development work

## Branch
Config/MR/Bug/SR-13579_RetunValueofEnginHoursParameterDiffFM_Mesa.xx.xx.ORI

## Learned

## Description

CTN
1. Why does the same <mark class="hltr-grey">event</mark> have different <mark class="hltr-grey">return value</mark> for the <mark class="hltr-orange">FM</mark> and <mark class="hltr-orange">M4k</mark>  
2. Client wants the <mark class="hltr-red">actual EngineHours</mark> for the Ticker events <mark class="hltr-grey">not Delta</mark>

FM3xxx:               <mark class="hltr-grey">Engine Hour</mark> reading is received
<mark class="hltr-red">Mix4000</mark>:             <mark class="hltr-red">Engine hour delta</mark> appears to be received


## Code sections

## Files

## Resources

## Notes

