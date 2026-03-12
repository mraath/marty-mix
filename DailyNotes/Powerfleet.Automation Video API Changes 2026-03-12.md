---
created: 2026-03-12T10:45
updated: 2026-03-12T14:10
---

# Powerfleet.Automation — Video API Changes

## Opsomming

Al die video-related veranderinge gemaak op 2026-03-12 in `Powerfleet.Automation`.

## Changes

**`Initializer.cs`**
- `using MiX.Video.Client` bygevoeg
- `VideoClient.RegisterRepository(...)` was uitgecomment — uncomment en fixed

**`Startup.cs`**
- `VideoApiUrl` en `Environment` was nooit na `GlobalSettings` gemap nie — beide bygevoeg in `CreateGlobalSettings`

**`IMiXServiceWrapper.cs`** *(MiXServiceWrapper)*
- `VideoRepository(dateFrom)` was verkeerd — dit het die date as die DataCentre key gebruik in plaas van `AppSettings.Settings.Environment`
- Vir nou return null — Video API het 'n retry issue, kom later terug daarna

**`EnvironmentScopedServiceWrapper.cs`**
- Dieselfde null return bygevoeg vir consistency

**`HelperManager.cs`**
- `videoCards` tasks uitgecomment in `Task.WhenAll` en die assignments — beide QC en ConfigDelta cases

## TODO
Soek vir `//TODO: MR: Video API fix pending` om al die bypassed calls op te tel wanneer die Video API issue aangespreek word.
