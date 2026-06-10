---
tags: [work, testing, devices, sql, scenario-tests, INT]
date: 2026-06-05
related: [[Operations Tools]]
---

# INT Test Device Data — 5 June 2026

Found via SQL queries against DSINTSQL01 (DeviceConfiguration database) using Windows integrated auth over VPN.

## Device Values for Scenario Test Pipeline (pipeline 2519)

| Pipeline Variable | Value | Device Type | Notes |
|---|---|---|---|
| `StaImeiMix40001` | `866561068905482` | MiX4000 Delta | Updated 2026-06-04, active |
| `StaDeviceIdCr100` | `962343` | Cellocator Asset Gateway | Updated 2026-05-27, status 5 (loaded) |
| `StaImeiFcplus` | **NOT FOUND** | FC Plus | FC Plus is in a separate NORDIC-env platform — needs team input |

## Backup options

**MiX4000 alternates** (if primary fails QC):
- `868581070565866` — MiX4000, updated 2026-06-04
- `866561068924947` — MiX4000, updated 2026-06-04
- `352739097418310` — Integration Regression MiX4000, updated 2026-06-05 (existing test device, no trips yet)

**CR100 alternates:**
- `2223866` — Cellocator Asset Gateway, updated 2026-05-27
- `2242795` — Cellocator Asset Gateway, updated 2026-05-27
- `2242894` — updated 2026-05-27

## How these were found

```powershell
sqlcmd -S "tcp:DSINTSQL01,1433" -d DeviceConfiguration -E -l 30 -t 25 -Q "
SELECT TOP 10
    mu.MobileUnitId, mu.UniqueIdentifier as IMEI, mdt.Name as DeviceType, mu.DateUpdated
FROM dynamix.MobileUnits mu WITH (NOLOCK)
JOIN dynamix.MobileDeviceTemplates mdt WITH (NOLOCK) ON mdt.MobileDeviceTemplateId = mu.MobileDeviceTemplateId
WHERE mdt.Name LIKE '%MiX4000%'
    AND LEN(mu.UniqueIdentifier) BETWEEN 14 AND 16
ORDER BY mu.DateUpdated DESC"
```

## Still needed from team

- **FC Plus vehicle ID** — must come from the FC Plus NORDIC-env platform. Ask whoever manages FC Plus INT environment.
- **LATE test device** — needs a device installed ≥7 days ago. ConfigurationStatus 5, trips recorded after install date.

## What these unlock

Setting these two variables will allow ~50+ scenario tests to run instead of showing as "device not configured":
- All Cellocator/CR100 tests (CEL category, 17 tests)
- Most MiX QC scenario tests (MIX category) — results depend on device state
