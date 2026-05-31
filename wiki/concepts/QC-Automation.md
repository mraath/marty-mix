---
type: concept
name: QC Automation
aliases:
  - Quality Check Automation
  - QC Phase 1
sources:
  - Operations Tools.md
last_updated: 2026-05-28
---

QC Automation is the automated quality-check workflow in [[Ops-Tools]] that validates device installations and configurations. Phase 1 is complete, covering CAN peripherals, video status, odometer/distance consistency, and Salesforce case linkage.

## Core Ideas

- Support staff supplies IMEI(s) + Salesforce case info to trigger a QC run
- API checks: video status, CAN peripheral, speed source, RPM source, odometer vs trip distance
- Multiple IMEIs can be submitted in a single run (OPEN-1737)
- Results feed back to Salesforce (OPEN-1243)

## Key Tickets (Phase 1 — Done)

| Ticket | Description |
|---|---|
| OPEN-1293 | Create QC Automation API and Logic |
| OPEN-1493 | UI for Salesforce case info |
| OPEN-1725-1728 | Multi-IMEI parameter changes (background) |
| OPEN-1729 | UI update for QC |
| OPEN-1737 | Allow multiple IMEIs |
| OPEN-1300 | CAN peripheral, speed source, RPM source checks (Grant) |
| OPEN-1607 | Odometer vs trip distance consistency check (Grant) |

## Connections

- [[Ops-Tools]] — parent project
- [[Config-Delta-Tool]] — sister feature
- [[Decommissioning-Automation]] — shares UI and API structure
