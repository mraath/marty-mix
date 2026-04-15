---
created: 2025-05-05T11:56
updated: 2026-04-15T10:50
sprint: "2026-03-30"
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

- [ ] **OPEN-1971** (Paperclip / Central Agent Server) — actively in progress, continue
- [ ] **OPEN-2029** (Persist Config Diff to Database) — actively in progress, continue
- [ ] **OPEN-2045** (Session Timeout 30 min) — In Progress QA, needs sign-off
- [ ] **OPEN-2046** (Force login on new session) — In Progress QA, needs sign-off
- [ ] **OPEN-1653** (Config Compare & Diff Engine) — Committed, pick up next

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
| Kanban          | [Kanban](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/6981)                                                     |
| Repo Overview   | [Azure DevOps](https://dev.azure.com/MiXTelematics/OperationsTools)                                                                      |
| Repo Dev Branch | [development](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation?path=%2F&version=GBdevelopment&_a=contents) |

---

## Stories — Active Sprint

> Epic: [OPEN-1264](https://powerfleet.atlassian.net/browse/OPEN-1264) — Unity MX Installation QC Automation - Phase 1

### Assigned to Me (Marthinus)

> Shows all active tickets — everything except Done, Cancelled, and Closed.

| Ticket                                                      | Summary                                                                   | Status                       | Note                                                                           |
| ----------------------------------------------------------- | ------------------------------------------------------------------------- | ---------------------------- | ------------------------------------------------------------------------------ |
| [OPEN-2045](https://powerfleet.atlassian.net/browse/OPEN-2045) | UI - Implement 30-minute inactivity session timeout                       | **In Progress QA** 🧪  | Needs QA sign-off                                                              |
| [OPEN-2046](https://powerfleet.atlassian.net/browse/OPEN-2046) | UI - Force login when starting a new application session                  | **In Progress QA** 🧪  | Needs QA sign-off                                                              |
| [OPEN-1971](https://powerfleet.atlassian.net/browse/OPEN-1971) | [POC] Paperclip Standalone Agentic Server — Centralised AI Orchestration | **In Progress Dev** 🔄 | [[OPEN-1971]]                                                                  |
| [OPEN-2029](https://powerfleet.atlassian.net/browse/OPEN-2029) | Persist Config Diff to Database (Replace File-Based Storage)              | **In Progress Dev** 🔄 |                                                                                |
| [OPEN-1653](https://powerfleet.atlassian.net/browse/OPEN-1653) | UI - Select source and comparison configs for same-asset config compare   | **Committed** 📋      | Pick up after 2029 or in parallel                                              |

### Other Active (FYI)

| Ticket                                                      | Summary                                                                            | Status         | Assignee     |
| ----------------------------------------------------------- | ---------------------------------------------------------------------------------- | -------------- | ------------ |
| [OPEN-2028](https://powerfleet.atlassian.net/browse/OPEN-2028) | Configure Standard OpenAI API Key for Paperclip Agents and Automation              | **Committed** 📋 | Ignus Crous |

### Other Active (FYI)

| Ticket                                                      | Summary                                                                            | Status         | Assignee     |
| ----------------------------------------------------------- | ---------------------------------------------------------------------------------- | -------------- | ------------ |
| [OPEN-2028](https://powerfleet.atlassian.net/browse/OPEN-2028) | Configure Standard OpenAI API Key for Paperclip Agents and Automation              | **Committed** 📋 | Ignus Crous |

---

## Sprint Intake — 2026-03-30 (This Sprint)

> Items confirmed for this sprint. Only things to focus on NOW or already in flight.

### 1. Paperclip — UI Agentic Development Setup

- **What**: Set up [paperclipai/paperclip](https://github.com/paperclipai/paperclip) — open-source orchestration for zero-human companies
- **Reference**: [YouTube demo](https://youtu.be/HJ-dwefABss?si=0RbaGBod88kRzhYz)
- **Status**: 🔄 [OPEN-1971](https://powerfleet.atlassian.net/browse/OPEN-1971) — **In Progress Dev**
- **Note**: Also covers central agent server

### 2. S3 / DB Persistence — Diff/Cases Runtime Files

- **What**: Files written at runtime (`cases/`, `diff.json`) live only in container memory — lost on every ECS restart. Now replacing S3 with DB persistence.
- **Status**: 🔄 [OPEN-2029](https://powerfleet.atlassian.net/browse/OPEN-2029) — **In Progress Dev**
- **Note**: Confirm feature works before tackling further persistence architecture

### 3. Config Compare & Diff — OPEN-1653

- **What**: UI - Select source and comparison configs for same-asset config compare & diff
- **Status**: 📋 [OPEN-1653](https://powerfleet.atlassian.net/browse/OPEN-1653) — **Committed** — pick up next
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

### OPEN-1667 — Export Results *(Proposed)*

- Covers: chatbot results + diff output → one clean exportable document
- Proposed document structure:
  1. **Brief summary** — what is happening with the diff
  2. **Key action points / serious alerts** — things the user must pay attention to
  3. **Full Q&A transcript** — every question the user asked + every chatbot answer
- Export as a nicely formatted document (PDF / similar)

### OPEN-1664 — AI Agent / Custom Analysis (Chatbot) *(Proposed)*

- "Super Seed" was mentioned in notes — exact meaning unclear, needs revisiting
- No firm direction yet — needs more planning before starting

### OPEN-1745 — Drift Explanation & Impact *(Proposed)*

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
