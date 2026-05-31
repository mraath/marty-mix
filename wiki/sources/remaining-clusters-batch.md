---
type: source
title: Remaining Clusters — Batch Ingest (SRs, SQL, Done, QA, AC, Frangular, Root, misc)
date_ingested: 2026-05-28
original_file: Multiple folders (356+ files)
---

## Summary

Batch ingest of all remaining un-tagged vault files across 12 folders. Files tagged with `wiki_ingested: 2026-05-28`. Key new wiki content extracted: Alerts Feature (4-alert system for Config Groups), DynaMiX.Backend entity, Decommissioning Automation concept. Also covers AU infrastructure setup notes, service request history (SRs/), SQL reference queries, completed work (Done/), QA test cases, AC Config API tickets, Frangular UI notes, and miscellaneous root notes.

## Files Tagged by Folder

| Folder | Count | Notes |
|---|---|---|
| `SRs/` | 53 | Service request investigation history |
| `SQL/` | 37 | Reusable database queries (alerts, config, auditing) |
| `Done/` | 54 | Completed tickets across all project areas |
| `QA/` | 27 | QA test cases and validation notes |
| `AC/` | 7 | AC (Config API) tickets — DynamicCAN, install profiles, fuel type |
| `Frangular/` | 7 | Frangular UI development notes |
| `content/` | 77 | Content folder — mixed project docs |
| `Notes/` | 2 | Additional notes (ZAGOV already captured separately) |
| `Parked/` | 2 | Parked/deferred items |
| `I3/` | 4 | I3 project files |
| `Spaces/` | 1 | Spaces-related note |
| Root | 85 | Root-level vault notes (alerts, guides, briefings, tools) |

## Key Takeaways

- **Alerts Feature**: 4-alert composite system for Config Groups page (`state.MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups`) — config stale (5d), FW stale (3d), FW outdated (2 versions), missing parameters
- **DynaMiX.Backend** identified as core system for DST, alerts, Config Groups, and device integration — **not to be called from Automation/Ops Tools** (team convention)
- **AC tickets**: Relate to `Config.Api` / `MiX.ConfigInternal.Api.Client` — DynamicCAN endpoints, installation profiles, fuel type, org ID handling
- **AU_Setup.md**: Additional AU infrastructure detail (API GW invoke URL `oroqo28ut0`, VPC Link `53iyqq`, Python scripts in `Powerfleet.Automation`)
- **SR-19946**: ALG DST fix (similar to SAAS-10447 OMAN setup — copied FMTimeAdjuster from OMN to ALG)

## Wiki Pages Created

- [[Alerts-Feature]] — concept created
- [[DynaMiX-Backend]] — entity created
- [[Decommissioning-Automation]] — concept created
