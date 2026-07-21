---
created: 2026-07-21T15:15
updated: 2026-07-21T15:15
---
# Wiki Index — Powerfleet Engineering Knowledge Base

> Auto-maintained by LLM. Last updated: 2026-07-21
> Total pages: 32 | Sources ingested: 18

## Entities

### Projects
- [Ops-Tools](entities/Ops-Tools.md) — Powerfleet.Automation project: Config Delta, QC, Decomm Automation, AWS environments, sprint state

### Systems
- [AWS-Environments](entities/AWS-Environments.md) — Master map of all AWS accounts, environment URLs, and auth methods
- [DynaMiX-Backend](entities/DynaMiX-Backend.md) — Core .NET backend; DeviceIntegrationManager, DST service, alerts SPs. NEVER call from Automation/Ops Tools.
- [Command-45](entities/Command-45.md) — `UpdateAssetTimezoneDeviation` DST device command; 4 entry points, FM/Mesa paths
- [Config-Api](entities/Config-Api.md) — Internal DeviceConfig API; DST endpoints, NuGet client, swagger URLs
- [DaylightSavingAdjustmentService](entities/DaylightSavingAdjustmentService.md) — Automatic nightly Windows Service for DST; debug checklist
- [FMTimeAdjuster](entities/FMTimeAdjuster.md) — Manual WinForms DST tool; CRITICAL: run on IIS server not jumpbox
- [OMAN-Environment](entities/OMAN-Environment.md) — v18.17 legacy environment; server map, DST gotchas
- [Powerfleet-Automation-AWS](entities/Powerfleet-Automation-AWS.md) — ECS/Fargate infra per environment; critical rules (ECR, SG, env vars, URL format)
- [ZAGOV-Environment](entities/ZAGOV-Environment.md) — ZA Gov isolated AWS account; Microsoft Entra auth, `powerfleet.com` domain, Aurora PostgreSQL
- [Powerfleet-GitHub-Enterprise](entities/Powerfleet-GitHub-Enterprise.md) — GHE at `powerfleet.ghe.com`; username `marthinus-raath`, `gh` CLI device-flow auth

### Concepts
- [DST](entities/DST.md) — Daylight Saving Time in MiX/Powerfleet context; two failure modes

### Tickets
- [ETS-8669](entities/ETS-8669.md) — OMAN Command 45 March 2026 incident; root cause: jumpbox auth routing; resolved

## Concepts

- [ADO-Pipeline-CI-Trigger-Override](concepts/ADO-Pipeline-CI-Trigger-Override.md) — Definition-level CI triggers override YAML trigger:none; pipeline IDs 2510/2511; trigger_tests pattern; SDLC 429 fix
- [Alerts-Feature](concepts/Alerts-Feature.md) — 4-alert system for Config Groups (config stale, FW stale, FW outdated, missing params); bit-string encoding
- [AWS-Deployment-Pattern](concepts/AWS-Deployment-Pattern.md) — Step-by-step new region deployment; prerequisites, 4 components, failure modes table
- [Config-Delta-Tool](concepts/Config-Delta-Tool.md) — Config comparison/diff/audit tool; AI chatbot, key tickets, future roadmap
- [Config-Groups-Page](concepts/Config-Groups-Page.md) — Frangularisation of Config Groups UI; OE epic, key stories, known bugs
- [Frangular-Local-Dev-Setup](concepts/Frangular-Local-Dev-Setup.md) — Run FRangular UI (local) → Frangular API (local) → DEV API; the one-line ConfigApiUrl change
- [Decommissioning-Automation](concepts/Decommissioning-Automation.md) — Decomm automation Phase 1; auth proxy pattern, Salesforce case flow
- [QC-Automation](concepts/QC-Automation.md) — Quality check automation Phase 1; IMEI submission, CAN/video/odometer checks
- [SA Income Tax Brackets](concepts/SA%20Income%20Tax%20Brackets.md) — SARS marginal tax brackets/rebates/thresholds (2025/26); used for salary/bonus after-tax analysis

## Sources

### DST / Command 45
- [dst-code-paths](sources/dst-code-paths.md) — Complete entry point trace for Command 45 (2026-05-15)
- [dst-debug-guide](sources/dst-debug-guide.md) — Full troubleshooting guide, per-env setup (2026-05-14)
- [ets-8669-oman-dst](sources/ets-8669-oman-dst.md) — OMAN Command 45 incident full RCA (March 2026)

### Ops Tools
- [operations-tools-master](sources/operations-tools-master.md) — `Operations Tools.md` master note
- [operations-tools-looking-forward](sources/operations-tools-looking-forward.md) — Boss sprint directives Mar 2026
- [github-login](sources/github-login.md) — `gh` CLI auth SOP for `powerfleet.ghe.com` (2026-05-29)

### AWS / Automation Infrastructure
- [automation-infra-setup-guide](sources/automation-infra-setup-guide.md) — ECS/ALB infrastructure setup guide
- [global-deployment-guide](sources/global-deployment-guide.md) — New region deployment guide; URL convention, API GW proxy pattern
- [au-automation-setup](sources/au-automation-setup.md) — AU setup + infrastructure audit; 4 failure modes documented
- [zagov-aws-deployment](sources/zagov-aws-deployment.md) — ZAGOV full infra reference; Aurora, Microsoft Entra, case-sensitivity bug

### Clusters (Batch Ingested)
- [open-tickets-cluster2](sources/open-tickets-cluster2.md) — 79 OPEN ticket notes tagged (2022–2026)
- [oe-config-groups-cluster3](sources/oe-config-groups-cluster3.md) — 71 OE/Config Groups ticket notes tagged
- [ets-tickets-cluster4](sources/ets-tickets-cluster4.md) — 9 ETS ticket notes tagged
- [remaining-clusters-batch](sources/remaining-clusters-batch.md) — 356 files tagged across SRs, SQL, Done, QA, AC, Frangular, root, misc

## Synthesis

_(none yet)_
