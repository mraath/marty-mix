---
type: entity
entity_type: Concept
name: DST
aliases:
  - Daylight Saving Time
  - Daylight Savings Time
sources:
  - Need Parent/DST.md
  - DST Daylight Saving Times/DST Code Paths.md
  - DST Daylight Saving Times/DST Debug Guide.md
last_updated: 2026-05-28
---

Daylight Saving Time (DST) in the Powerfleet/MiX context refers to the system of automatically or manually adjusting device timezone offsets when countries enter or exit DST. Assets must receive [[Command-45]] to keep their clocks correct.

## Key Facts

- Three timezone types involved: OrgTimezone, AssetTimezone, SiteTimezone
- The offset calculation: `SiteOffset - OrgOffset` (in seconds) for both before and after the DST transition
- Windows registry is the legacy source of DST data; the Globalisation API is the modern, preferred source
- If `param3 = 946688400` → no DST applies for that asset
- Affects FM units (legacy path) and Mesa/Mix4000 units (modern DeviceConfig path) differently

## The Two Failure Modes

1. **Manual tool fails** — FMTimeAdjuster authentication errors (usually Redis mismatch or tool run from wrong machine)
2. **Automatic service fails** — DaylightSavingAdjustmentService stopped or misconfigured

## Connections

- [[Command-45]] — the device command that implements the DST adjustment
- [[FMTimeAdjuster]] — manual tool for support staff
- [[DaylightSavingAdjustmentService]] — automatic nightly service
- [[Config-Api]] — modern API endpoints
- [[DynaMiX-Backend]] — legacy code path (`DeviceIntegrationManager`)
- [[OMAN-Environment]] — problem environment (v18.17 unsupported)
- [[TECHDEBT-190]] — move DST service to DeviceConfig repo
- [[TECHDEBT-372]] — use Globalisation API for DST timezone data
