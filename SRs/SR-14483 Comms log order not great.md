---
status: closed
date: 2023-01-25
comment: explained
priority: 8
---

Date: 2023-01-25 Time: 08:10
Parent:: xxxx
Friend:: [[2023-01-25]]
JIRA:SR-14483 Comms log order not great
[SR-14483 Comms log not in chronological order - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14483)

# SR-14483 Comms log order not great

## Testing

## Next Steps

- [x] Message Riaan
Hi @RiaanXXXXXX, in short, this is by design.
The Configuration Upload section consists of two separate message status types.
It consists of SendConfig (254) and SendSettings (255).
In the database, by design, it first orders by the individual message status type and then by date, time.
This will explain why you see the two block... one for each.
This also explains why the date time order looks fine, and then it jumps.
The jump happens where the new message status type gets displayed.
Please mark as closed if you are OK with this.
Maybe also speak to the PO if this is too confusing for the user.
Thanks

![[Pasted image 20230125082305.png]]


## Story Description

C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\CommsLog\CommsLogModule.cs
GetCommsLogConfig

It gets it for: SendConfig (254) and SendSettings (255)
DeviceConfigClient.MobileUnits.GetLastMessageStatusesForTypes
{PostPutApiUrl}/groupIds/{groupId}/mobile-units{mobileUnitId}/message-status-for-types?authToken={authToken}
API
Controller > Manager > GetLastMessageStatusesForTypes
[state].[MobileUnitMessage_GetLastMessageStatusesForTypes]



## Image

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.17 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-14483 Comms log order not great.xx.xx.ORI
