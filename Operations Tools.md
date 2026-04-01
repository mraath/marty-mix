---
created: 2025-05-05T11:56
updated: 2026-04-01T16:56
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

- [ ] Deploy to **INT** — verify with IMEI `352739097418310` (video-linked)
- [ ] Check [OPEN-1800](https://powerfleet.atlassian.net/browse/OPEN-1800) naming convention changes for UI impact
- [ ] Verify all open tickets are in the correct status on the sprint board
- [ ] **Answer all open questions on [OPEN-1832](https://powerfleet.atlassian.net/browse/OPEN-1832)** — boss flagged this as ready to tackle (2026-03-18)
- [ ] **Determine if [OPEN-1744](https://powerfleet.atlassian.net/browse/OPEN-1744) is still valid** — boss questions whether it has been superseded by OPEN-1832 (2026-03-18)
- [x] **OPEN-1832 already closed** — confirmed Done in Jira ✅
- [ ] **Pick up OPEN-1842 and OPEN-1843** — move to In Progress Dev
- [ ] **Create tickets** for: S3 persistence, Paperclip setup, WhatsApp→API, Central agent server, AWS ZA + 2nd region, Chatbot config-fix feature, Chatbot OpenAI keys
- [ ] **Confirm with William** which four stories he created for you

---

## Current Sprint Focus

> **Marthinus** → Config Delta / Audit Tool
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

| Resource        | URL                                                                                                                                      |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Sprint Board    | [Sprint Board](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/7014/backlog)                                       |
| Kanban          | [Kanban](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/6981)                                                     |
| Repo Overview   | [Azure DevOps](https://dev.azure.com/MiXTelematics/OperationsTools)                                                                      |
| Repo Dev Branch | [development](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation?path=%2F&version=GBdevelopment&_a=contents) |

---

## Stories — Active Sprint

> Epic: [OPEN-1264](https://powerfleet.atlassian.net/browse/OPEN-1264) — Unity MX Installation QC Automation - Phase 1

### Assigned to Me (Marthinus)

| Ticket | Summary | Status | Note |
|---|---|---|---|
| [OPEN-1832](https://powerfleet.atlassian.net/browse/OPEN-1832) | [[OPEN-1832 Add Test Case Creation Screen\|Add test case creation screen]] | In Progress Dev ★(1) | Branch: `Config/MR/Feature/OPEN-1832_TestCaseCreationScreen`. Open questions answered. **Subticket needed:** S3 integration for `standard.json` file browsing (standards hosted in S3 bucket, selectable from modal). Currently using local `data/testCase/` and `data/standards/` as file sources. |
| [OPEN-1744](https://powerfleet.atlassian.net/browse/OPEN-1744) | Allow the user to select the standard and the assets that need to be compared against it. | Ready for Grooming ★(2) | ⚠️ **Validity in question** — boss asks if this has been superseded by OPEN-1832. Review before picking up. |
| [OPEN-1788](https://powerfleet.atlassian.net/browse/OPEN-1788) | [[OPEN-1788 Add AI ChatBot Panel to the Configuration Delta Tool\|AI ChatBot Panel — Config Delta Tool]] | Ready for QA ★(3) | Branch: `Config/MR/Feature/OPEN-1788_AIChatBotPanel` |
| [OPEN-1842](https://powerfleet.atlassian.net/browse/OPEN-1842) | Investigate and Optimise Token Usage in AI ChatBot | Ready for Sprint | — |
| [OPEN-1843](https://powerfleet.atlassian.net/browse/OPEN-1843) | Enhance AI ChatBot Follow-Up Question Generation | Ready for Sprint | — |
| [OPEN-1913](https://powerfleet.atlassian.net/browse/OPEN-1913) | UI - Bootstrap Vitest and React Testing Library | Ready for Grooming | Grant — test setup foundation |
| [OPEN-1914](https://powerfleet.atlassian.net/browse/OPEN-1914) | UI - Add seed unit tests for core service and utility logic | Ready for Grooming | Grant — depends on OPEN-1913 |
| [OPEN-1915](https://powerfleet.atlassian.net/browse/OPEN-1915) | UI - Add mandatory test stage to Azure pipeline | Ready for Grooming | Grant — depends on OPEN-1913 |
| [OPEN-1916](https://powerfleet.atlassian.net/browse/OPEN-1916) | UI - Enforce test coverage on commit via Husky pre-commit hook | Ready for Grooming | Grant — depends on OPEN-1913 |
| [OPEN-1741](https://powerfleet.atlassian.net/browse/OPEN-1741) | Display item descriptions instead of raw IDs in all comparison views | Ready for QA | — |
| [OPEN-1742](https://powerfleet.atlassian.net/browse/OPEN-1742) | Add a summary dashboard panel to comparison results showing asset counts and per-section drift counts | Ready for QA | — |
| [OPEN-1743](https://powerfleet.atlassian.net/browse/OPEN-1743) | Exclude LastConfig, LastIMEI, and LastIMSI from configuration comparisons against the fleet standard | Ready for QA | — |
| [OPEN-1844](https://powerfleet.atlassian.net/browse/OPEN-1844) | Add GetConfigurationGroupSummaries API endpoint | In Code Review | Grant — blocks OPEN-1845, enables OPEN-1832 |
| [OPEN-1845](https://powerfleet.atlassian.net/browse/OPEN-1845) | Add ConfigConfigurationGroups API endpoint | Ready for QA | Grant — blocked by OPEN-1844, enables OPEN-1832 |
| [OPEN-1833](https://powerfleet.atlassian.net/browse/OPEN-1833) | Add ConfigAllowedOrganisationsAsync endpoint to load accessible organisations | Ready for QA | William King |
| [OPEN-1834](https://powerfleet.atlassian.net/browse/OPEN-1834) | Add GetActiveAssetListForOrganisationAsync endpoint to load active assets for a selected organisation | Ready for QA | Grant |

### Shared (Me + Boss)

| Ticket | Summary | Status | Note |
|---|---|---|---|
| [OPEN-1756](https://powerfleet.atlassian.net/browse/OPEN-1756) | Add manager to Automation API to load the necessary data to work with | ~~Cancelled~~ | Superseded |
| [OPEN-1757](https://powerfleet.atlassian.net/browse/OPEN-1757) | Add endpoint for the config delta tool in the API to allow user to do a comparison | ~~Cancelled~~ | Superseded |

### Boss's Tickets (FYI)

| Ticket | Summary | Status | Note |
|---|---|---|---|
| [OPEN-1300](https://powerfleet.atlassian.net/browse/OPEN-1300) | Add CAN peripheral, speed source, and RPM source checks to QC Automation | Committed | Boss |
| [OPEN-1607](https://powerfleet.atlassian.net/browse/OPEN-1607) | Add odometer vs trip distance consistency check to QC Automation | Committed | Boss |
| [OPEN-1800](https://powerfleet.atlassian.net/browse/OPEN-1800) | Enforce naming convention consistency across Powerfleet.Automation API - controllers, routes, and managers | In Progress QA | May cause minor UI impact |
| [OPEN-1928](https://powerfleet.atlassian.net/browse/OPEN-1928) | Create Azure CI/CD pipeline for Powerfleet.Automation (ZA) | Ready for Sprint | Grant — API ZA pipeline |
| [OPEN-1929](https://powerfleet.atlassian.net/browse/OPEN-1929) | Create Azure CI/CD pipeline for Powerfleet.Automation (ENT) | Ready for Sprint | Grant — API ENT pipeline |
| [OPEN-1930](https://powerfleet.atlassian.net/browse/OPEN-1930) | Create Azure CI/CD pipeline for Powerfleet.Automation.UI (ZA) | Ready for Sprint | Grant — UI ZA pipeline |
| [OPEN-1931](https://powerfleet.atlassian.net/browse/OPEN-1931) | Create Azure CI/CD pipeline for Powerfleet.Automation.UI (ENT) | Ready for Sprint | Grant — UI ENT pipeline |

---

## API Fixes — Weekend 2026-03-14 (Boss)

Boss made the following fixes and self-approved the PR. Relevant context for INT deploy:

- Video API URL corrected
- `AssetSummary` null OrgId fixed
- `Positions` → `LatestPositions`; `Events` → `EventsSince`; `Trips` → `TripsSince`
- `GetSinceAsync` has known perf issues with large datasets — **note for QBR/analytics sprint**
- Future: `HelperManager` refactor story to be created — config-driven loading

---

## Sprint Intake — 2026-03-30

Items captured this session. Tickets still to be created unless noted.

### 1. Paperclip — UI Agentic Development Setup
- **What**: Set up [paperclipai/paperclip](https://github.com/paperclipai/paperclip) — open-source orchestration for zero-human companies
- **Reference**: [YouTube demo](https://youtu.be/HJ-dwefABss?si=0RbaGBod88kRzhYz)
- **Status**: 🎫 Ticket needed
- **Note**: Evaluate for agentic UI development workflow integration

### 2. S3 Persistence — Diff/Cases Runtime Files
- **What**: Files written at runtime (`cases/`, `diff.json`) live only in container memory — lost on every ECS task restart. Need S3 (or EFS) for persistence.
- **Scope**: API ticket + UI ticket + deploy to PROD in future. Diff Test also affected.
- **Status**: 🎫 Tickets needed (API + UI + infra)
- **Note**: Confirm the feature works first before tackling persistence architecture (as per 2026-03-30 note)

### 3. ChatBot Token + Follow-Up Improvements *(Existing Tickets)*
- [OPEN-1842](https://powerfleet.atlassian.net/browse/OPEN-1842) — Investigate and Optimise Token Usage in AI ChatBot
- [OPEN-1843](https://powerfleet.atlassian.net/browse/OPEN-1843) — Enhance AI ChatBot Follow-Up Question Generation
- **Status**: Ready for Sprint → move to In Progress Dev when picking up

### 4. WhatsApp → API Call
- **What**: Trigger an API endpoint via WhatsApp message (n8n or similar)
- **Status**: 🎫 Ticket needed
- **Reference**: [[Research/WhatsApp to API via n8n]] — Discord as test phase, Meta WhatsApp Cloud API for prod
- **Note**: Scope and target endpoint TBD

### 5. Dedicated Central Agent Server
- **What**: Centralized Claude/AI agent server for team use (token centralization, fire-and-forget tasks)
- **Status**: 🎫 Ticket needed
- **Reference**: [[Research/Claude Agent Server]]

### 6. Two New AWS Environment Setups — ZA + ENT
- **What**: Deploy Powerfleet Automation to ZA and ENT regions. CI/CD pipeline stories already created by Grant (OPEN-1928–1931). AWS infrastructure setup still needed.
- **Status**: CI/CD tickets exist (Ready for Sprint). AWS infra tickets still needed.
- **Reference**: [[Automation Infrastructure Setup Guide]], [[Global_Deployment_Guide]]

### 7. Chatbot: Config Fix Suggestions
- **What**: Chatbot analyses config diff and *proposes* fixes (e.g. "reset X to Y") — user approves → config improves
- **Status**: 🎫 Ticket needed (new feature story)
- **Note**: Big value-add — needs API write endpoint to apply suggestions

### 8. Chatbot: OpenAI Keys
- **What**: Ensure all AI keys (`OPENROUTER_API_KEY`, `OPENROUTER_MODEL`, `GROQ_API_KEY`, `OPENAI_API_TYPE`, `OPENAI_API_BASE`, `OPENAI_API_VERSION`, `OPENAI_DEPLOYMENT_NAME`, `OPENAI_API_KEY`) are set in the ECS task definition for every environment deployed
- **Status**: ✅ Process captured — see AWS Regional Deployment Skill → Step 9. No separate ticket needed; this is a deployment checklist item.

### 9. Four UI Test Stories from Grant
- [OPEN-1913](https://powerfleet.atlassian.net/browse/OPEN-1913) — UI - Bootstrap Vitest and React Testing Library
- [OPEN-1914](https://powerfleet.atlassian.net/browse/OPEN-1914) — UI - Add seed unit tests for core service and utility logic
- [OPEN-1915](https://powerfleet.atlassian.net/browse/OPEN-1915) — UI - Add mandatory test stage to Azure pipeline
- [OPEN-1916](https://powerfleet.atlassian.net/browse/OPEN-1916) — UI - Enforce test coverage on commit via Husky pre-commit hook
- **Status**: All Ready for Grooming. OPEN-1913 is the foundation — others depend on it.

### 10. Close OPEN-1832
- **What**: Add test case creation screen to the Config Change Analysis Tool UI
- **Status**: ✅ Already marked **Done** in Jira — nothing to do.

---

## Stories — Completed / Reference

### QC Automation Phase 1 — Foundation

- [x] [OPEN-1729](https://powerfleet.atlassian.net/browse/OPEN-1729) — Change the UI for QC to accommodate the information needed to start checks ✅ 2026-03-09
- [x] [OPEN-1730](https://powerfleet.atlassian.net/browse/OPEN-1730) — Change the UI for Decomm to accommodate the information needed to start checks ✅ 2026-03-11
- [x] [OPEN-1737](https://powerfleet.atlassian.net/browse/OPEN-1737) — Change UI to allow for multiple IMEIs ✅ 2026-03-10
- [x] [OPEN-1576](https://powerfleet.atlassian.net/browse/OPEN-1576) — Add UI for support to supply Salesforce case info and start Decom Automation manually ✅ 2026-03-11
- Spike: [OPEN-1223](https://powerfleet.atlassian.net/browse/OPEN-1223) — Investigate QC Automation - Phase 1 ✅ Done
	- API Endpoint: [OPEN-1293](https://powerfleet.atlassian.net/browse/OPEN-1293) — Create QC Automation API and Logic ✅ Done
	- UI: [OPEN-1493](https://powerfleet.atlassian.net/browse/OPEN-1493) — [[OPEN-1493 UI for Salesforce case Info]] ✅ 2026-02-24
	- Video: [OPEN-1299](https://powerfleet.atlassian.net/browse/OPEN-1299) — Test video status for installed device 🔄 In Progress QA
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

- [OPEN-1526](https://powerfleet.atlassian.net/browse/OPEN-1526) — Investigate how to leverage AI to work with Salesforce information ⏸ On Hold
- [OPEN-1356](https://powerfleet.atlassian.net/browse/OPEN-1356) — Trigger QC API Endpoint 🔄 Ready for Grooming
- [OPEN-1328](https://powerfleet.atlassian.net/browse/OPEN-1328) — Create endpoint in Salesforce 🔄 Ready for Grooming
- [OPEN-1715](https://powerfleet.atlassian.net/browse/OPEN-1715) — [[OPEN-1715 Setup UI and API on AWS for AU]] — Setup UI and API on AWS for AU ✅ Done
- [PFI-3133](https://powerfleet.atlassian.net/browse/PFI-3133) — Operations Enablement Engineering Improvements 🔄 In Progress
	- [OPEN-455](https://powerfleet.atlassian.net/browse/OPEN-455) — CAN Logger App Enhancements 🔄 Proposed
- [OPEN-1631](https://powerfleet.atlassian.net/browse/OPEN-1631) — Develop and Implement tools to increase efficiency (Epic) 🔄 Formulating

---

## TEMP NOTE

```
OK - in the Terminal I ran: SAML2aws login -a AU --force  
This is to login to AU  
HOWEVER I need to log into ZA  
Could you create me another shortcut command like this  
But to go into ZA  
668736068906  
Ireland

eu-west-1  
  
And you can check where  
ZA-Config  
IS set up as a cluster - OK - lets first wait here - and then continue with the rest - lets first get that login shortcut

---

Setting up ZA on AWS for our Automation API and Automation UI.  
  
PLease use this skill:  
C:\Projects\Skills\.agent\skills\aws-regional-deployment-skill\SKILL.md  
  
To setup ZA  
At the end (or as part of the above) you also have to set tags  
C:\Projects\Skills\aws-tag-powerfleet-automation.md  
  
I have signed in on SAML for you to use AWS CLI
```


```
ENT
522301445307
Ireland
eu-west-1
ENT-Config
```


## Examples & Reference

- [[QBR Report for clients]]
- [[AI python to see data issues]]
- [[Operations Enablement]]
- [[Operations Tools Looking forward 20260316]] — source transcript: boss's sprint directives (Afrikaans)
