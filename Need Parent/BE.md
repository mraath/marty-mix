---
created: 2023-09-22T09:25
updated: 2024-05-16T06:13
aliases:
  - DynaMiX.Backend
---

## Intro

Forms part of the [[Code]] as a whole.
Most of this logic is being moved into different teams' repos
[[Device Configuration]] team has moved over to our [[DynaMiX.DeviceConfig]]

## Utilities

Some of the code in the BE is specifically for Utilities used by different teams, etc.
I think our [[Configuration Compiler]] is one of them

## Services

Many services also exist here: 
- [[DynaMiX.Services.DaylightSavingAdjustment]] which sets all the [[DST]] for orgs and assets.

## Transforms

[[BE Build Transform]]

## Issues

- Green Monster not showing due to SQL timeout [[BE SQL Timeout]]
- Clean Build [[BE Issue Not opening]]