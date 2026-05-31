---
type: concept
name: Config Delta Tool
aliases:
  - Config Diff Tool
  - Config Audit Tool
  - Config Compare
sources:
  - Operations Tools.md
  - Diff Ideas — Future Roadmap.md
  - OPEN/OPEN-2029 Persist Config Diff to Database.md
  - OPEN/OPEN-1653 UI - Select source and comparison configs for same-asset config comparison.md
last_updated: 2026-05-28
---

The Config Delta Tool is a core feature of [[Ops-Tools]] that allows comparing device configurations across assets, detecting drift, and providing AI-powered analysis of differences. It replaces the old S3-based runtime file storage with DB persistence.

## Core Ideas

- **Config diff:** Compare two config versions for the same asset, or two assets against each other
- **Event/Parameter decoding:** Raw numeric IDs (EventId, ParameterId) are resolved to human-readable names
- **AI Chatbot:** The diff is fed to a GPT chatbot that can answer questions and propose fixes
- **DB persistence:** Config diff cases and results stored in `configdiff` schema on DSINTSQL01 (OPEN-2029)
- **Export:** Future — export diff + chatbot Q&A to PDF (OPEN-1667)

## Key Tickets

| Ticket | Description | Status |
|---|---|---|
| OPEN-1653 | UI — select source/comparison configs for same-asset diff | Done ✅ |
| OPEN-2029 | Persist Config Diff cases/results to DB (replace S3) | Done ✅ |
| OPEN-2360 | Fix undecoded EventId/ParameterId in diff view | Committed |
| OPEN-2362 | Fix AI chatbot hallucinations (missing event/param names in prompt) | Committed |
| OPEN-2363 | Load device data from MiX APIs for Config Delta workflow | Committed |
| OPEN-1624 | ChatBot panel for Config Delta Tool | In Progress |
| OPEN-2028 | Chatbot config fix suggestions | Reassigned to Ignus Crous |
| OPEN-2103 | Config Delta Selection Boxes | — |
| OPEN-2104 | Config Delta Custom Standard File | — |

## Future Ideas

- **VO Settings Diff** — include video/camera config in diffs (complex, future)
- **Trip Integrity Ratios** — per-asset data quality over time
- **Asset-to-Asset Diff** — compare two different assets via chatbot
- **Scheduled polling** (OPEN-1651) — auto-run config checks on a schedule

## Connections

- [[Ops-Tools]] — parent project
- [[QC-Automation]] — sister feature
- [[DynaMiX-Backend]] — upstream data source for device config
- [[Config-Api]] — downstream for device data retrieval (OPEN-2363)
