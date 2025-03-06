---
created: 2023-09-22T17:05
updated: 2023-10-24T09:55
---

This is found in the [[DaylightSavingsManager]]

This code basically does the following:
- It adjusts the Organisation's DST making use of async tasks
- It then also sets the units'DST making use of tasks.
It all happens within a second to kick it all off.
It then starts performing all of them asynchronously.

## Controller

Called from [[AdjustDaylightSavingsForOrganisationsAndMobileUnitsController]]

## Eg. of what will happen


![[TECHDEBT-190 Move DST to API]]

## Summary of work done on this method

[[Code Review TECHDEBT-190]]

## Code Path

C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DaylightSavingsManager.cs
