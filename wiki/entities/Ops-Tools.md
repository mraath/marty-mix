---
type: entity
entity_type: Project
name: Ops Tools
aliases:
  - Operations Tools
  - Powerfleet.Automation
  - OperationsTools
sources:
  - Operations Tools.md
  - Operations Tools Looking forward 20260316.md
  - Ops Tools Antigravity training.md
  - Operations Enablement.md
  - ConfigTools URLs.md
  - Diff Ideas — Future Roadmap.md
last_updated: 2026-05-28
---

Operations Tools (Ops Tools) is the engineering team and product suite at Powerfleet/MiX Telematics responsible for building internal tools that make clients' and operations staff's lives easier. The team owns the Powerfleet.Automation API & UI, the Config Tools (Config Delta/Diff), QC Automation, and Decommissioning Automation.

## Key Facts

- **Azure DevOps:** https://dev.azure.com/MiXTelematics/OperationsTools
- **Jira Project:** OPEN (Epic parent: OPEN-1264, OPEN-1631)
- **Primary engineer (Marthinus):** Config Delta / Audit Tool, AWS deployments
- **Cornel Coetzee:** Salesforce integration
- **Sprint board:** https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/7014/backlog

## Engineering Directives (from boss, March 2026)

1. **Data via API** — all data loading and writes go through the API
2. **UI via Agents** — AI agents build UI/analyses; graphs and maps wherever possible
3. **Well-commented code** — AI can handle this; non-negotiable
4. **API code available to agents** — agents can commit and create PRs; humans approve PRs
5. **Thorough Jira specs** — agents need well-specced tickets and code access
6. **Weekly sync** — team sessions for knowledge sharing; don't wait for urgent issues

## Active Features

| Feature | Key Tickets | Status |
|---|---|---|
| Config Delta / Diff Tool | OPEN-2029, OPEN-1653, OPEN-2360-2363 | Active |
| QC Automation | OPEN-1293, OPEN-1729, OPEN-1737 | Done (Phase 1) |
| Decommissioning Automation | OPEN-1567, OPEN-1576, OPEN-1730 | Done (Phase 1) |
| Salesforce Integration | OPEN-1823, OPEN-1243 | In Progress (Cornel/Jako) |
| AI Chatbot (Config Diff) | OPEN-1624, OPEN-2028 | Reassigned to Ignus Crous |

## AWS Environments

| Env | API | UI |
|---|---|---|
| AU (prod) | `automation-api-au.mixtelematics.com` | `automation-au.mixtelematics.com` |
| ZA (prod) | `automation-api.za.mixtelematics.com` | `automation.za.mixtelematics.com` |
| ENT | Pipelines done (OPEN-1929/1931); AWS infra pending | — |
| ZAGOV | On Hold (OPEN-2461/2462) | — |

## ConfigTools URLs

| Env | UI | API |
|---|---|---|
| INT | `configtools.mixdevelopment.com` | `configtools-api.mixdevelopment.com/swagger` |
| Others | `configtools.{env}.mixtelematics.com` | `configtools-api.{env}.mixtelematics.com` |

## Future Roadmap

- **OPEN-1651** — Frequency-Based Config Polling (scheduled auto-run + document generation)
- **OPEN-1667** — Export results (chatbot + diff → PDF)
- **OPEN-1745** — Drift Explanation & Impact (needs input from Mike)
- **VO Settings Diff** — Camera/video config in diff (complex, future ticket)
- **Trip Integrity Ratios** — Per-asset data quality checks
- **Asset-to-Asset Config Diff** — Compare two assets via chatbot

## Connections

- [[Config-Delta-Tool]] — the config comparison feature
- [[QC-Automation]] — quality check automation
- [[DynaMiX-Backend]] — upstream data source
- [[Config-Api]] — downstream API
- [[AWS]] — deployment platform

## Open Questions

- [ ] ENT environment AWS infra — ticket needed
- [ ] OPEN-2438: DST CommandLine tool port to OMAN
