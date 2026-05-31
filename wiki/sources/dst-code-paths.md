---
type: source
title: DST Code Paths — Command 45
date_ingested: 2026-05-28
original_file: DST Daylight Saving Times/DST Code Paths.md
---

## Summary

A complete trace of every code entry point that triggers `UpdateAssetTimezoneDeviation` (Command 45), through to final delivery to the device. Created 2026-05-15. Covers all four entry points: UI/API events in DynaMiX.Backend, the FMTimeAdjuster manual tool, the nightly DaylightSavingAdjustmentService, and the AU-specific CommandLine tool. Also documents all Config.Api DST endpoints, the client NuGet methods, and the asset skip/filter rules.

## Key Takeaways

- Four distinct entry points all ultimately call Config.Api's DST endpoints
- The CommandLine tool **silently stops** when `EndDate` in appsettings.json expires — no alert
- Assets missing `BASE_FM_FUNCTIONALITY` AND `BASE_MESA_FUNCTIONALITY` are silently skipped — no log entry
- Assets missing `REMOTE_COMMAND` logical device log a FAILURE at Debug level only (easy to miss)
- "Cornell's Shortcut": call Config.Api `/outdated-daylight-savings` + `/send-command-to-outdated-daylight-savings` directly — no need to replicate Backend param calculation logic

## New Entities/Concepts

- [[Command-45]] — entity created
- [[FMTimeAdjuster]] — entity created
- [[DaylightSavingAdjustmentService]] — entity created
- [[Config-Api]] — entity created

## Wiki Pages Updated

- [[Command-45]] — full endpoint and code path detail
- [[DST]] — code architecture added
- [[Config-Api]] — DST endpoints table added
