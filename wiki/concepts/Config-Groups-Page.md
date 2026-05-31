---
type: concept
name: Config Groups Page
aliases:
  - OE Config Groups
  - Configuration Groups Page
  - Frangularisation
  - OE
sources:
  - OE Config Groups Page/ (54 files)
  - OE/ (18 files)
  - OE BUGS/ (files)
last_updated: 2026-05-28
---

The Config Groups Page is the Frangular UI feature that replaced the legacy Angular 1.x configuration group management interface. The OE (Operations Enablement) epic drove the rebuild with React/Angular, new permissions model, and multi-select config groups.

## Core Ideas

- Built under the OE-xxx Jira project (Operations Enablement) — separate from the OPEN project
- Key epic: OE-513 (Configuration Groups — Frangularisation and enhancements)
- Replaced legacy config group management with modern UI
- Supports: multi-select config groups, asset list panel, auditing, OEM enrollment, filters

## Key OE Stories (Completed)

| Ticket | Description |
|---|---|
| OE-478 | Domain registration |
| OE-479 | New permissions |
| OE-480 | Navigation item |
| OE-481 | iFrame integration |
| OE-482 | Replace OLD with NEW |
| OE-483 | Auditing findings |
| OE-484 | SEED Frangular UI |
| OE-485 | Holding page — Config Group multiselect + Assets list |
| OE-513 | All SQL involved |
| OE-538 | Authentication and permissions |

## Known Bugs (OE BUGS)

- OE-533: Diff mobile types result in 0 asset count still in CG
- Various spinner, language, column selector, kebab menu styling issues

## Connections

- [[Ops-Tools]] — current project that maintains Config Groups page
- [[Config-Delta-Tool]] — uses config data from Config Groups
- [[DynaMiX-Backend]] — backend data source for Config Groups
