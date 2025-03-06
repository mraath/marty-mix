---
status: closed
date: 2022-09-29
comment: done
priority: 1
---

Date: 2022-09-29 Time: 14:10
Parent:: xxxx
Friend:: [[2022-09-29]]
JIRA:TEL-62

# TEL-62 Send Command Teltonika

## STEPS
- Zeshan Khan
- Go to live tracking(legacy).  
- Select the ttk asset > actions > Request Current Position/Send Commands
- Check in the DB that the commands thus created have their message status set as 22-Created

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.13 |     |
| Local |     |

## Branch
Config/MR/Bug/TEL-62 Send Command Teltonika.xx.xx.ORI

## Info
- id 4593059192263178630
- orgId -3314842661689357331

## Description

```sql
select top(10) *
from state.mbileunitmessage
where mobileunitid = 1202701476503e07232
and datepart (year, CreationDateUtc) = 2022

select *
from state .MobileUnitmessageStateHistory
where mobileunitid 1202701476503e07232
and datepart (year, MessageStatusDateUtc) = 2022
and datepart (FONTH, MessageStatusDateUtc) = 9

```

## Code sections

## Files

## Resources

## Notes

