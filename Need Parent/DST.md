---
aliases:
  - Daylight Savings Time
created: 2023-09-22T15:11
updated: 2023-10-24T09:36
---
## Intro

This is the concept of Timezones and adjusting it by one hour for certain countries when the country goed in or out of Winter.
This is an absolute pain.

## Different DST

- OrgTimezone
- AssetTimezone
- SiteTimezone

## Code

This is used within  [[DynaMiX.Services.DaylightSavingAdjustment]]

## Moving parts ?

![[DST Moving Parts.excalidraw]]

## Enhancement

![[TECHDEBT-190 Move DST to API]]

The command code was not yet [[async]] on INT
I will have a quick look to see if it now is?
