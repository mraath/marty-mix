---
wiki_ingested: 2026-05-28
---
# Automation API Build Fixes — 2026-03-11

## Summary

Fixed a series of build-breaking issues in `Powerfleet.Automation` after a recent pull, and enforced the `IMiXServiceWrapper` pattern across all runtime data calls.

---

## Issue 1 — `AddTestAreaResult` / `AddMessage` / `RequestResult` / `TestArea` Not Found

### Root Cause
`HelperManager.AddTestAreaResult` and `HelperManager.AddMessage` were refactored to accept explicit `RequestResult`, `uniqueIdentifier`, and `MobileUnitAsset` parameters. The call sites in `QCManager` and `DecommissioningManager` were left calling them as if they were still local instance methods with just the text arguments.

Additionally, `HelperManager.cs` was missing `using Powerfleet.Automation.Common;` needed for `RequestResult` and `TestArea`.

### Fix
- Added `using Powerfleet.Automation.Common;` to `HelperManager.cs`
- Added `using Powerfleet.Automation.Logic.Managers;` to `QCManager.cs` and `DecommissioningManager.cs`
- Added private wrapper methods in both managers to forward to the static `HelperManager` methods using their instance fields:

**QCManager.cs:**
```csharp
private Task AddTestAreaResult(string area, string resultString)
    => HelperManager.AddTestAreaResult(_result, _currentCase?.UniqueIdentifier, _mobileUnitAsset, area, resultString);

private void AddMessage(string message)
    => HelperManager.AddMessage(_result, _currentCase?.UniqueIdentifier, _mobileUnitAsset, message);
```

**DecommissioningManager.cs:**
```csharp
private Task AddTestAreaResult(string area, string resultString)
    => HelperManager.AddTestAreaResult(_result, _decomCase?.UniqueIdentifier, _mobileUnitAsset, area, resultString);

private void AddMessage(string message)
    => HelperManager.AddMessage(_result, _decomCase?.UniqueIdentifier, _mobileUnitAsset, message);
```

---

## Issue 2 — Automation UI `RequestResult` Type Not Found

### Root Cause
`DecommissioningView.tsx` used `RequestResult` in `formatSingleResult()` but had not imported it from `@/lib/models/contracts`.

### Fix
```diff
- import { DecomCase, DecomResponse } from '@/lib/models/contracts';
+ import { DecomCase, DecomResponse, RequestResult } from '@/lib/models/contracts';
```

---

## Issue 3 — `GetMobileUnitSummary` Called Directly via `DeviceConfigClient`

### Root Cause
`HelperManager.DetermineMobileUnitSummaryAsync` used `_mixService` for the first call but then bypassed the wrapper for `GetMobileUnitSummary`.

### Fix
Added `GetMobileUnitSummaryAsync(string authToken, long mobileUnitId)` to `IMiXServiceWrapper`, `MiXServiceWrapper`, and `EnvironmentScopedServiceWrapper`, then updated the call site in `HelperManager.cs`.

---

## Issue 4 — `FleetServicesDataClient.Assets.GetSummaryAsync` Called Directly

### Root Cause
Same method `DetermineMobileUnitSummaryAsync` directly called `FleetServicesDataClient.Assets.GetSummaryAsync`, bypassing `IMiXServiceWrapper`.

### Fix
Added `GetAssetSummaryAsync(long groupId, long assetId)` to the interface and both implementations, then updated `HelperManager.cs` to use `_mixService.GetAssetSummaryAsync(...)`.

Note: `EnvironmentScopedServiceWrapper` uses its scoped `_securityAccounts`; `MiXServiceWrapper` uses `Initializer.FleetServicesApiSecurityAccount`.

---

## Files Changed

| File | Change |
|------|--------|
| `Powerfleet.Automation.Logic/Managers/HelperManager.cs` | Added `using`; replaced 2 direct client calls with `_mixService` |
| `Powerfleet.Automation.Logic/Managers/QC/QCManager.cs` | Added `using`; added 2 private wrapper methods |
| `Powerfleet.Automation.Logic/Managers/Decommissioning/DecommissioningManager.cs` | Added `using`; added 2 private wrapper methods |
| `Powerfleet.Automation.Logic/Services/IMiXServiceWrapper.cs` | Added `GetMobileUnitSummaryAsync` and `GetAssetSummaryAsync` to interface + `MiXServiceWrapper` impl |
| `Powerfleet.Automation.Logic/Services/EnvironmentScopedServiceWrapper.cs` | Added `GetMobileUnitSummaryAsync` and `GetAssetSummaryAsync` |
| `Powerfleet.Automation.UI/src/components/decommissioning/DecommissioningView.tsx` | Added `RequestResult` to import |

## Result

All runtime data calls in `Powerfleet.Automation` now route through `IMiXServiceWrapper`. Direct client calls (`DeviceConfigClient`, `FleetServicesDataClient`, `ResourceDataClient`) only remain in infrastructure registration files (`Initializer.cs`, `Startup.cs`, `EnvironmentContext.cs`) which is correct.
