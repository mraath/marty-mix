---
status: closed
date: 2023-01-05
comment: 
priority: 8
---

Date: 2023-01-05 Time: 03:55
Parent:: xxxx
Friend:: [[2023-01-05]]
JIRA:SR-14302 Active event negative temperature incorrect
[[SR-14302] Active event negative temperature incorrect - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14302)

# SR-14302 Active event negative temperature incorrect

## Testing

## Next Steps

- Comment: From what I could see from the config file and udp file, things from our side seem in order. I will double check with Paul, however, I think it is safe to ask Firmware to pick this up. RIAAN, will you please assign to them? Thanks.

## Story Description

UK
4K > s1 > AutoSender 3 Zone Temperature Sensor v1.0.0.1
!! Info hub incorrect
Active Events: positive works, negative doesn't

FmConfigEventMessage
Legacy Event Id: -67

From Config:
Cold Chain - Temperature - S2
Event Id: 65469

From UDP
Type5Code: 65469


## Image

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.17 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-14302 Active event negative temperature incorrect.xx.xx.ORI
