---
created: 2025-05-05T11:56
updated: 2026-05-28T00:00
sprint: 2026-05-25
wiki_ingested: 2026-05-28
---
> [!Information] Writing tools to make the clients' lives easier.

## TODO — Active Action Items

```dataviewjs
function callout(text, type) {
	const allText = `> [!${type}]\n` + text;
	const lines = allText.split('\n');
	return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

**OPEN-1653** (Config Compare & Diff Engine) — Done ✅

---

## Current Sprint Focus

> **Marthinus** → Config Delta / Audit Tool + Paperclip POC
> **Cornel** → Salesforce integration

### Engineering Directives (from boss)

See full context: [[Operations Tools Looking forward 20260316]]

1. **Data via API** — All data loading and writes go through the API as far as possible.
2. **UI via Agents** — UI and analyses are built by AI agents. Make it fast and visually premium: use graphs, maps wherever possible. API endpoints get updated as data changes.
3. **Well-commented code** — AI can handle commenting. This is a non-negotiable going forward.
4. **API code available to agents** — Give agents access to the API codebase. They can commit and create PRs. **We approve PRs — not AI** (at least for now).
5. **JIRA specs must be thorough** — Agents need well-specced tickets and code access to do good work.
6. **Weekly sync** — Team sessions planned for sharing knowledge and making tech decisions. If something is urgent, don't wait — ask freely.

---

## Links

| Resource        | URL                                                                                                                                   |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Sprint Board    | [Sprint Board](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/7014/backlog)                                       |
| My Board        | [My Tickets](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/7014?assignee=557058%3A456930fd-5aba-4785-9fea-2811fca22597) |
| Kanban          | [Kanban](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/6981)                                                     |
| Repo Overview   | [Azure DevOps](https://dev.azure.com/MiXTelematics/OperationsTools)                                                                      |
| Repo Dev Branch | [development](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation?path=%2F&version=GBdevelopment&_a=contents) |

---

## Stories — Active Sprint

> Epic: [OPEN-1264](https://powerfleet.atlassian.net/browse/OPEN-1264) — Unity MX Installation QC Automation - Phase 1

### Assigned to Me (Marthinus)

> Shows all active tickets — everything except Done, Cancelled, and Closed.
> Last synced: 2026-05-28

| Ticket | Summary | Status | Note | Description |
| ------ | ------- | ------ | ---- | ----------- |
| OPEN-2461 | API - Add deployment pipeline to ZAGOV environment | On Hold | 3 pts | Add Azure DevOps pipeline for `Powerfleet.Automation` targeting ZAGOV; auto-triggers on `integration → production` merge, mirroring the UAE pipeline (OPEN-2424). |
| OPEN-2462 | UI - Add deployment pipeline to ZAGOV environment | On Hold | 3 pts | Same as OPEN-2461 but for `Powerfleet.Automation.UI`; mirrors the UAE UI pipeline (OPEN-2426). |
| OPEN-2360 | Fix undecoded EventId and ParameterId values in Config Delta diff view | Committed | Defect | Raw numeric IDs (e.g. `601707137285611900`) shown in diff view instead of human-readable names. Fix: route EventId/ParameterId through the existing event/parameter lookup service in the UI. |
| OPEN-2362 | Fix AI chatbot hallucinations due to missing event/parameter name context | Committed | Defect | Chatbot conflates TEG event thresholds with wrong events because the decoded event/parameter dictionary is not injected into the prompt. Fix: include the lookup context in the chatbot prompt for the current diff. |
| OPEN-2363 | API - Load device data from MiX APIs for Config Delta workflow | Committed | 3 pts | Add a standalone method to retrieve device state from MiX APIs specifically for the Config Delta workflow path — originally descoped from OPEN-1756. Must surface errors to caller, not swallow them. |
| OPEN-2438 | OMAN — Investigate porting DST CommandLine tool from AU (v18.17 compat) | Proposed | Watch item | Investigate feasibility of porting the DST CommandLine tool from AU to Oman, checking v18.17 compatibility. No active work yet. |

---

## Full Sprint Overview (_synced 2026-05-28_)

> All non-Done tickets in the current active sprint.

### In Progress Dev (13 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2610](https://powerfleet.atlassian.net/browse/OPEN-2610) | AUTO-API - Add in-process token session cache to reduce MiX Auth login floods | Grant | 3 | Story |
| [OPEN-2504](https://powerfleet.atlassian.net/browse/OPEN-2504) | Camera calibration not available for MDM-managed iOS devices | Ivan Morris | - | Defect |
| [OPEN-2493](https://powerfleet.atlassian.net/browse/OPEN-2493) | TechTool Access and Delete: unable to access config groups page | Jan Moppel | - | Defect |
| [OPEN-2485](https://powerfleet.atlassian.net/browse/OPEN-2485) | Hide Actions Dropdown behind Permission | Jako Malan | 3 | Story |
| [OPEN-2452](https://powerfleet.atlassian.net/browse/OPEN-2452) | Config script calibration value queries | Martin Rademeyer | 5 | Story |
| [OPEN-2371](https://powerfleet.atlassian.net/browse/OPEN-2371) | Script usage config queries | Zonika Smit | 5 | Story |
| [OPEN-2192](https://powerfleet.atlassian.net/browse/OPEN-2192) | Upgrade ZA scripts with clear supercedance | Martin Rademeyer | 5 | Story |
| [OPEN-2187](https://powerfleet.atlassian.net/browse/OPEN-2187) | Implement compiled config Consolidated Json producer for Cellocator customer event conditions | Paul Roux | 3 | Story |
| [OPEN-2107](https://powerfleet.atlassian.net/browse/OPEN-2107) | DEFECT | Config groups | Asset panel | Filters results should auto-apply | Pallavi Jadhav | - | Defect |
| [OPEN-1882](https://powerfleet.atlassian.net/browse/OPEN-1882) | OEM Enrollment not shown on the new Config Groups Page | Pallavi Jadhav | 4 | Story |
| [OPEN-1823](https://powerfleet.atlassian.net/browse/OPEN-1823) | Investigate Action - Hook into Salesforce | Jako Malan | 8 | Story |
| [OPEN-1287](https://powerfleet.atlassian.net/browse/OPEN-1287) | Android 14: Discard window looks weird | Tim Lücke | - | Defect |
| [OPEN-1266](https://powerfleet.atlassian.net/browse/OPEN-1266) | Assignee filter selector is not ordered alphabetically | Ivan Morris | - | Defect |

### In Code Review (4 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2587](https://powerfleet.atlassian.net/browse/OPEN-2587) | Empty state should not be displayed during initial load | Ivan Morris | - | Defect Sub-task |
| [OPEN-2538](https://powerfleet.atlassian.net/browse/OPEN-2538) | PL File Management - Org setting flag | Zonika Smit | 3 | Story |
| [OPEN-2525](https://powerfleet.atlassian.net/browse/OPEN-2525) | Create a reference storage for PL File usage | Zonika Smit | 3 | Story |
| [OPEN-2473](https://powerfleet.atlassian.net/browse/OPEN-2473) | Crash in SyncManager.handleSyncResponse | Ivan Morris | - | Defect |

### Ready for Review (15 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2613](https://powerfleet.atlassian.net/browse/OPEN-2613) | CT-UI - Forward client IP address in auth proxy route | Grant | 1 | Story |
| [OPEN-2611](https://powerfleet.atlassian.net/browse/OPEN-2611) | CT-API - Replace deprecated GetAuthToken with LoginWithMfaRenewalAsync | Grant | 2 | Story |
| [OPEN-2609](https://powerfleet.atlassian.net/browse/OPEN-2609) | AUTO-API - Replace deprecated LoginAsync with LoginWithMfaRenewalAsync | Grant | 3 | Story |
| [OPEN-2503](https://powerfleet.atlassian.net/browse/OPEN-2503) | Add two-layer Family/Device grid and multiselect filters to KB Driver Behavior Thresholds | Grant | 2 | Story |
| [OPEN-2500](https://powerfleet.atlassian.net/browse/OPEN-2500) | Add Category, Mnemonic, and Type multiselect filters to Event x Action Matrix | Grant | 2 | Story |
| [OPEN-2499](https://powerfleet.atlassian.net/browse/OPEN-2499) | Convert Event x Action Matrix to parent-child grid with Category as parent | Grant | 1 | Story |
| [OPEN-2498](https://powerfleet.atlassian.net/browse/OPEN-2498) | Add Group, Input Definition, Alt Definition, and Device Families filters to Line Capability Matrix | Grant | 3 | Story |
| [OPEN-2497](https://powerfleet.atlassian.net/browse/OPEN-2497) | Convert Line Capability Matrix to parent-child grid with Group as parent | Grant | 1 | Story |
| [OPEN-2495](https://powerfleet.atlassian.net/browse/OPEN-2495) | Add Description multiselect filter to Mobile Device Lines Matrix | Grant | 1 | Story |
| [OPEN-2491](https://powerfleet.atlassian.net/browse/OPEN-2491) | Add Family multiselect filter to Device Line Matrix | Grant | 1 | Story |
| [OPEN-2490](https://powerfleet.atlassian.net/browse/OPEN-2490) | Add Category, Format, and Units multiselect filters to Parameter Category Matrix | Grant | 2 | Story |
| [OPEN-2489](https://powerfleet.atlassian.net/browse/OPEN-2489) | Convert Parameter Category Matrix to parent-child grid with Category as parent | Grant | 1 | Story |
| [OPEN-2488](https://powerfleet.atlassian.net/browse/OPEN-2488) | Add Format Type multiselect filter to Property Reference Matrix | Grant | 1 | Story |
| [OPEN-2487](https://powerfleet.atlassian.net/browse/OPEN-2487) | Convert Property Reference Matrix to parent-child grid with Format Type as parent | Grant | 2 | Story |
| [OPEN-1072](https://powerfleet.atlassian.net/browse/OPEN-1072) | Support provisioning of Samsara asset / vehicle gateway in POS | Zonika Smit | 7 | Story |

### Ready for QA (2 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2590](https://powerfleet.atlassian.net/browse/OPEN-2590) | Languaging has not been applied to the Column headers | Amy Rodger | - | Defect Sub-task |
| [OPEN-1013](https://powerfleet.atlassian.net/browse/OPEN-1013) | Support Signal Count in CAN Script FMS | Unassigned | 4 | Story |

### In Progress QA (3 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2359](https://powerfleet.atlassian.net/browse/OPEN-2359) | Outline buttons are corrupted (wrong height) | Unathi Loni | - | Defect |
| [OPEN-1639](https://powerfleet.atlassian.net/browse/OPEN-1639) | Improve task list loading behaviour - testing | Unathi Loni | 5 | Story |
| [OPEN-1243](https://powerfleet.atlassian.net/browse/OPEN-1243) | SalesForce - UI Update | Amy Rodger | 4 | Story |

### In Progress (other) (2 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2559](https://powerfleet.atlassian.net/browse/OPEN-2559) | Document Install BFF architecture drafts | Matthias Clasen | 2 | Task |
| [OPEN-2188](https://powerfleet.atlassian.net/browse/OPEN-2188) | Spike: Design Config API contract for Cellocator customer events | Zonika Smit | 2 | Spike |

### On Hold (2 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2461](https://powerfleet.atlassian.net/browse/OPEN-2461) | API - Add deployment pipeline to ZAGOV environment | **Marthinus Raath** | 3 | Story |
| [OPEN-2462](https://powerfleet.atlassian.net/browse/OPEN-2462) | UI - Add deployment pipeline to ZAGOV environment | **Marthinus Raath** | 3 | Story |

### Identified (1 ticket)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2483](https://powerfleet.atlassian.net/browse/OPEN-2483) | INT Defect - Motorq_Ford - VIN (Unique identifier already in use) | Ashley Sikweza | - | Defect |

### Committed (13 tickets)

> Sprint ceremonies + Marthinus's 3 tickets.

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2363](https://powerfleet.atlassian.net/browse/OPEN-2363) | API - Load device data from MiX APIs for Config Delta workflow | **Marthinus Raath** | 3 | Story |
| [OPEN-2362](https://powerfleet.atlassian.net/browse/OPEN-2362) | Fix AI chatbot hallucinations due to missing event/parameter name context | **Marthinus Raath** | - | Defect |
| [OPEN-2360](https://powerfleet.atlassian.net/browse/OPEN-2360) | Fix undecoded EventId/ParameterId in Config Delta diff view | **Marthinus Raath** | - | Defect |
| [OPEN-2558](https://powerfleet.atlassian.net/browse/OPEN-2558) | Risk Assessment - Config 26.13 | Zonika Smit | - | Task |
| [OPEN-2556](https://powerfleet.atlassian.net/browse/OPEN-2556) | Daily Merge - API, Core, Client 26.13 | Unassigned | - | Task |
| [OPEN-2555](https://powerfleet.atlassian.net/browse/OPEN-2555) | Daily Merge - UI, Backend, DB 26.13 | Unassigned | - | Task |
| [OPEN-2554](https://powerfleet.atlassian.net/browse/OPEN-2554) | Deploy to VIR 26.13 | Zeshan Khan | - | Task |
| [OPEN-2553](https://powerfleet.atlassian.net/browse/OPEN-2553) | Deploy to UAE 26.13 | Zeshan Khan | - | Task |
| [OPEN-2552](https://powerfleet.atlassian.net/browse/OPEN-2552) | Deploy to DUB 26.13 | Zeshan Khan | - | Task |
| [OPEN-2551](https://powerfleet.atlassian.net/browse/OPEN-2551) | Deploy to ENT 26.13 | Zeshan Khan | - | Task |
| [OPEN-2550](https://powerfleet.atlassian.net/browse/OPEN-2550) | Deploy to ZA 26.13 | Zeshan Khan | - | Task |
| [OPEN-2549](https://powerfleet.atlassian.net/browse/OPEN-2549) | Deploy to SYD 26.13 | Zeshan Khan | - | Task |
| [OPEN-2358](https://powerfleet.atlassian.net/browse/OPEN-2358) | Spike: Approach for Mock Config API for Cellocator customer event definitions | Unassigned | 2 | Spike |

### Ready for Sprint (4 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2599](https://powerfleet.atlassian.net/browse/OPEN-2599) | Record coverage baselines and set regression-blocking thresholds across all repos | Grant | 3 | Story |
| [OPEN-2598](https://powerfleet.atlassian.net/browse/OPEN-2598) | Add Coverlet coverage collection and dotnet test to Automation and ConfigTools.API pipelines | Grant | 2 | Story |
| [OPEN-2343](https://powerfleet.atlassian.net/browse/OPEN-2343) | Setup AWS infrastructure for ZAGOV environment (RT-46) | Tim Lücke | 2 | Task |
| [OPEN-2032](https://powerfleet.atlassian.net/browse/OPEN-2032) | Update versioning scheme | Ivan Morris | 1 | Story |

### Backlog (5 tickets)

| Ticket | Summary | Assignee | Points | Type |
|--------|---------|----------|--------|------|
| [OPEN-2558](https://powerfleet.atlassian.net/browse/OPEN-2558) | Risk Assessment - TechTool - 26.13 | Matthias Clasen | - | Task |
| [OPEN-2548](https://powerfleet.atlassian.net/browse/OPEN-2548) | Support investigation of long running UPSERT_TASK requests | Tim Lücke | 1 | Task |
| [OPEN-2134](https://powerfleet.atlassian.net/browse/OPEN-2134) | [i] Update app version & readme | Unassigned | - | Sub-task |
| [OPEN-2133](https://powerfleet.atlassian.net/browse/OPEN-2133) | [a] Update app version & readme | Unassigned | - | Sub-task |
| [OPEN-2132](https://powerfleet.atlassian.net/browse/OPEN-2132) | Add guide to Wiki | Unassigned | - | Sub-task |
> Items confirmed for this sprint. Only things to focus on NOW or already in flight.

### 1. Paperclip — UI Agentic Development Setup

- **What**: Set up [paperclipai/paperclip](https://github.com/paperclipai/paperclip) — open-source orchestration for zero-human companies
- **Reference**: [YouTube demo](https://youtu.be/HJ-dwefABss?si=0RbaGBod88kRzhYz)
- **Status**: ❌ [OPEN-1971](https://powerfleet.atlassian.net/browse/OPEN-1971) — **Cancelled**
- **Note**: POC cancelled

### 2. S3 / DB Persistence — Diff/Cases Runtime Files

- **What**: Files written at runtime (`cases/`, `diff.json`) live only in container memory — lost on every ECS restart. Now replacing S3 with DB persistence.
- **Status**: ✅ [OPEN-2029](https://powerfleet.atlassian.net/browse/OPEN-2029) — **Done**
- **Note**: DB persistence shipped and confirmed working

### 3. Config Compare & Diff — OPEN-1653

- **What**: UI - Select source and comparison configs for same-asset config compare & diff
- **Status**: ✅ [OPEN-1653](https://powerfleet.atlassian.net/browse/OPEN-1653) — **Done**
- **Note**: Boss called this second priority ("second story to focus on")

### 4. Chatbot: Config Fix Suggestions

- **What**: Chatbot analyses config diff and *proposes* fixes — user approves → config improves
- **Status**: 📋 [OPEN-2028](https://powerfleet.atlassian.net/browse/OPEN-2028) — **Committed / Reassigned to Ignus Crous** (2026-04-13)
- **Note**: Big value-add — needs API write endpoint to apply suggestions

### 5. Two AWS Environments — ZA + ENT

- **ZA**: ✅ Fully deployed — `automation-api.za.mixtelematics.com` / `automation.za.mixtelematics.com`
- **ENT**: CI/CD pipeline done (OPEN-1929/1931). AWS infra (ECS, ALB, DNS) still needs to be set up. 🎫 Ticket needed.
- **Reference**: [[Automation Infrastructure Setup Guide]], [[Global_Deployment_Guide]]

---

## Future Stories / Roadmap

> These stories are groomed/proposed but **not yet in the active sprint**. Keep for future planning.

### OPEN-1651 — Frequency-Based Config Polling *(Proposed)*

- Currently you can set up a test manually, but the idea is to **schedule it** — run on certain intervals automatically
- Manager should not have to go in and re-trigger it every time
- When the schedule runs → **generate and send a document** (report) automatically
- The scheduling + document generation is part of this story's scope

### OPEN-1667 — Export Results *(Committed — Marthinus)*

- Covers: chatbot results + diff output → one clean exportable document
- Proposed document structure:
  1. **Brief summary** — what is happening with the diff
  2. **Key action points / serious alerts** — things the user must pay attention to
  3. **Full Q&A transcript** — every question the user asked + every chatbot answer
- Export as a nicely formatted document (PDF / similar)

### OPEN-1664 — AI Agent / Custom Analysis (Chatbot) *(Proposed)*

- "Super Seed" was mentioned in notes — exact meaning unclear, needs revisiting
- No firm direction yet — needs more planning before starting

### OPEN-1745 — Drift Explanation & Impact *(Committed)*

- Need to **ask Mike** what the impact definition should be
- Get feedback from Mike before implementing

### OPEN-1654 — Full Org Config Retrieval *(Cancelled)*

- ~~Cancelled~~ — was potentially massive in scope. Confirm with boss if still relevant.

### WhatsApp → API Call *(No ticket yet)*

- **What**: Trigger an API endpoint via WhatsApp message (n8n or similar)
- **Reference**: [[Research/WhatsApp to API via n8n]] — Discord as test phase, Meta WhatsApp Cloud API for prod
- **Note**: Scope and target endpoint TBD — create ticket when ready to pick up

---

## API Fixes — Weekend 2026-03-14 (Boss)

Boss made the following fixes and self-approved the PR. Relevant context for INT deploy:

- Video API URL corrected
- `AssetSummary` null OrgId fixed
- `Positions` → `LatestPositions`; `Events` → `EventsSince`; `Trips` → `TripsSince`
- `GetSinceAsync` has known perf issues with large datasets — **note for QBR/analytics sprint**
- Future: `HelperManager` refactor story to be created — config-driven loading

---

## PROD — AWS Environments

### AU

Sydney · ap-southeast-2

- https://automation-api-au.mixtelematics.com/swagger/index.html
- https://automation-au.mixtelematics.com

### ZA

- https://automation-api.za.mixtelematics.com
- https://automation.za.mixtelematics.com

> **Domain note:** Used `automation.za.mixtelematics.com` / `automation-api.za.mixtelematics.com` (not the `-za.` pattern like AU). The `*.mixtelematics.com` cert in this ZA account is **expired**, so only `*.za.mixtelematics.com` works. If you want the `-za.` style, a new ACM cert for `*.mixtelematics.com` would need to be requested and validated via the shared DNS account.

**OpenAI key setup (ZA):** Via console: ECS → Task Definitions → `za-powerfleet-automation-ui` → Create new revision → add env vars → update the service.

| Key                        | Value                                                  |
| -------------------------- | ------------------------------------------------------ |
| `OPENAI_API_TYPE`        | `azure`                                              |
| `OPENAI_API_BASE`        | `https://aura-ai-assistant-int-eu.openai.azure.com/` |
| `OPENAI_API_VERSION`     | `2024-08-01-preview`                                 |
| `OPENAI_DEPLOYMENT_NAME` | `gpt-4.1`                                            |
| `OPENAI_API_KEY`         | _(the key — stored in ECS task def)_                |

### ENT

Account: `522301445307` · Ireland · eu-west-1 · Cluster: `ENT-Config`

> CI/CD pipelines done (OPEN-1929/1931). AWS infra (ECS, ALB, DNS) **still needs to be set up**. 🎫 Ticket needed.

---

## Stories — Completed / Reference

### QC Automation Phase 1 — Foundation

- [X] [OPEN-1729](https://powerfleet.atlassian.net/browse/OPEN-1729) — Change the UI for QC to accommodate the information needed to start checks ✅ 2026-03-09
- [X] [OPEN-1730](https://powerfleet.atlassian.net/browse/OPEN-1730) — Change the UI for Decomm to accommodate the information needed to start checks ✅ 2026-03-11
- [X] [OPEN-1737](https://powerfleet.atlassian.net/browse/OPEN-1737) — Change UI to allow for multiple IMEIs ✅ 2026-03-10
- [X] [OPEN-1576](https://powerfleet.atlassian.net/browse/OPEN-1576) — Add UI for support to supply Salesforce case info and start Decom Automation manually ✅ 2026-03-11

- Spike: [OPEN-1223](https://powerfleet.atlassian.net/browse/OPEN-1223) — Investigate QC Automation - Phase 1 ✅ Done
  - API Endpoint: [OPEN-1293](https://powerfleet.atlassian.net/browse/OPEN-1293) — Create QC Automation API and Logic ✅ Done
  - UI: [OPEN-1493](https://powerfleet.atlassian.net/browse/OPEN-1493) — [[OPEN-1493 UI for Salesforce case Info]] ✅ 2026-02-24
  - Video: [OPEN-1299](https://powerfleet.atlassian.net/browse/OPEN-1299) — Test video status for installed device ✅ Done
  - Decommissioning Phase 1: [OPEN-1545](https://powerfleet.atlassian.net/browse/OPEN-1545) — Decommissioning Automation - Phase 1 🔄 Authoring
    - Add Decomm Endpoint: [OPEN-1567](https://powerfleet.atlassian.net/browse/OPEN-1567) — Add Decommissioning Endpoint ✅ Done
- Background (API for OPEN-1737):
  - [OPEN-1725](https://powerfleet.atlassian.net/browse/OPEN-1725) — Update the starting Endpoint to receive new parameters ❌ Cancelled
  - [OPEN-1726](https://powerfleet.atlassian.net/browse/OPEN-1726) — Retrieve device and asset info using new parameters ✅ Done
  - [OPEN-1727](https://powerfleet.atlassian.net/browse/OPEN-1727) — Create a static class to handle shared information in logic layer ✅ Done
  - [OPEN-1728](https://powerfleet.atlassian.net/browse/OPEN-1728) — Change the way that peripherals are checked ✅ Done

### Customer Database

- Epic: [OPEN-1539](https://powerfleet.atlassian.net/browse/OPEN-1539) — R1: Consolidated Customer/Subscriber Database 🔄 Formulating
  - [OPEN-1495](https://powerfleet.atlassian.net/browse/OPEN-1495) — Investigate Customer Database requirements ⏸ On Hold

### Config Analysis Tool

- [OPEN-1494](https://powerfleet.atlassian.net/browse/OPEN-1494) — [[OPEN-1494 Config Analysis Tool]] — Investigate Config analyses tool to see where changes happened ✅ Done
- [OPEN-1624](https://powerfleet.atlassian.net/browse/OPEN-1624) — Config change analysis tool 🔄 In Progress

### Other

- [OPEN-1526](https://powerfleet.atlassian.net/browse/OPEN-1526) — Investigate how to leverage AI to work with Salesforce information ✅ Done
- [OPEN-1356](https://powerfleet.atlassian.net/browse/OPEN-1356) — Trigger QC API Endpoint 🔄 Ready for Grooming
- [OPEN-1328](https://powerfleet.atlassian.net/browse/OPEN-1328) — Create endpoint in Salesforce 🔄 Ready for Grooming
- [OPEN-1715](https://powerfleet.atlassian.net/browse/OPEN-1715) — [[OPEN-1715 Setup UI and API on AWS for AU]] — Setup UI and API on AWS for AU ✅ Done
- [PFI-3133](https://powerfleet.atlassian.net/browse/PFI-3133) — Operations Enablement Engineering Improvements 🔄 In Progress
  - [OPEN-455](https://powerfleet.atlassian.net/browse/OPEN-455) — CAN Logger App Enhancements 🔄 Proposed
- [OPEN-1631](https://powerfleet.atlassian.net/browse/OPEN-1631) — Develop and Implement tools to increase efficiency (Epic) 🔄 In Progress
- [OPEN-1300](https://powerfleet.atlassian.net/browse/OPEN-1300) — Add CAN peripheral, speed source, and RPM source checks to QC Automation ✅ Done (Grant)
- [OPEN-1607](https://powerfleet.atlassian.net/browse/OPEN-1607) — Add odometer vs trip distance consistency check to QC Automation ✅ Done (Grant)
- [OPEN-1800](https://powerfleet.atlassian.net/browse/OPEN-1800) — Enforce naming convention consistency across Powerfleet.Automation API ✅ Done (William King)

---

## Examples & Reference

- [[QBR Report for clients]]
- [[AI python to see data issues]]
- [[Operations Enablement]]
- [[Operations Tools Looking forward 20260316]] — source transcript: boss's sprint directives (Afrikaans)
- [[Diff Ideas — Future Roadmap]]
