---
created: 2025-05-05T11:56
updated: 2026-04-08T10:00
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

- [X] **Review OPEN-1928–1931** (CI/CD pipelines) — all are now **Ready for Review**, approve or merge
- [X] **Pick up OPEN-1842 and OPEN-1843** — both In Progress Dev ✅
- [X] **QA sign-off on OPEN-1913, 1914, 1916** (Grant's test stories) — all Ready for QA
- [ ] **Create tickets** for: S3 persistence, Paperclip setup, WhatsApp→API, Central agent server, Chatbot config-fix feature
- [X] **OPEN-1800 naming convention** — Done ✅ (no UI impact action needed)
- [X] **OPEN-1744 validity** — Confirmed Cancelled ✅ (superseded by OPEN-1832)
- [X] **OPEN-1832** — Done ✅
- [X] **OPEN-1788 AI ChatBot Panel** — Done ✅
- [X] **OPEN-1741/1742/1743** — All Done ✅

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

| Ticket                                                      | Summary                                                        | Status                        | Note                                    |
| ----------------------------------------------------------- | -------------------------------------------------------------- | ----------------------------- | --------------------------------------- |
| [OPEN-1842](https://powerfleet.atlassian.net/browse/OPEN-1842) | Investigate and Optimise Token Usage in AI ChatBot             | **Committed** ⚡        | Pick up next — move to In Progress Dev |
| [OPEN-1843](https://powerfleet.atlassian.net/browse/OPEN-1843) | Enhance AI ChatBot Follow-Up Question Generation               | **In Progress Dev** 🔨  | [[OPEN-1843 Enhance AI ChatBot Follow-Up Question Generation]] |
| [OPEN-1928](https://powerfleet.atlassian.net/browse/OPEN-1928) | Create Azure CI/CD pipeline for Powerfleet.Automation (ZA)     | **Done** ✅ |                                         |
| [OPEN-1929](https://powerfleet.atlassian.net/browse/OPEN-1929) | Create Azure CI/CD pipeline for Powerfleet.Automation (ENT)    | **Done** ✅ |                                         |
| [OPEN-1930](https://powerfleet.atlassian.net/browse/OPEN-1930) | Create Azure CI/CD pipeline for Powerfleet.Automation.UI (ZA)  | **Done** ✅ |                                         |
| [OPEN-1931](https://powerfleet.atlassian.net/browse/OPEN-1931) | Create Azure CI/CD pipeline for Powerfleet.Automation.UI (ENT) | **Done** ✅ |                                         |

### Grant's Tickets (Needs QA)

| Ticket                                                      | Summary                                                        | Status                 | Note                       |
| ----------------------------------------------------------- | -------------------------------------------------------------- | ---------------------- | -------------------------- |
| [OPEN-1913](https://powerfleet.atlassian.net/browse/OPEN-1913) | UI - Bootstrap Vitest and React Testing Library                | **Done** ✅ | Foundation for 1914 + 1916 |
| [OPEN-1914](https://powerfleet.atlassian.net/browse/OPEN-1914) | UI - Add seed unit tests for core service and utility logic    | **Done** ✅ | Depends on OPEN-1913       |
| [OPEN-1916](https://powerfleet.atlassian.net/browse/OPEN-1916) | UI - Enforce test coverage on commit via Husky pre-commit hook | **Done** ✅ | Depends on OPEN-1913       |

### Recently Done (this sprint)

| Ticket                                                      | Summary                                               | Assignee                                 |
| ----------------------------------------------------------- | ----------------------------------------------------- | ---------------------------------------- |
| [OPEN-1928](https://powerfleet.atlassian.net/browse/OPEN-1928) | Create Azure CI/CD pipeline for Powerfleet.Automation (ZA)     | Marthinus                                |
| [OPEN-1929](https://powerfleet.atlassian.net/browse/OPEN-1929) | Create Azure CI/CD pipeline for Powerfleet.Automation (ENT)    | Marthinus                                |
| [OPEN-1930](https://powerfleet.atlassian.net/browse/OPEN-1930) | Create Azure CI/CD pipeline for Powerfleet.Automation.UI (ZA)  | Marthinus                                |
| [OPEN-1931](https://powerfleet.atlassian.net/browse/OPEN-1931) | Create Azure CI/CD pipeline for Powerfleet.Automation.UI (ENT) | Marthinus                                |
| [OPEN-1913](https://powerfleet.atlassian.net/browse/OPEN-1913) | UI - Bootstrap Vitest and React Testing Library                 | Grant                                    |
| [OPEN-1914](https://powerfleet.atlassian.net/browse/OPEN-1914) | UI - Add seed unit tests for core service and utility logic     | Grant                                    |
| [OPEN-1916](https://powerfleet.atlassian.net/browse/OPEN-1916) | UI - Enforce test coverage on commit via Husky pre-commit hook  | Grant                                    |
| [OPEN-1832](https://powerfleet.atlassian.net/browse/OPEN-1832) | Add test case creation screen                         | Marthinus                                |
| [OPEN-1788](https://powerfleet.atlassian.net/browse/OPEN-1788) | AI ChatBot Panel — Config Delta Tool                 | Marthinus                                |
| [OPEN-1741](https://powerfleet.atlassian.net/browse/OPEN-1741) | Display item descriptions instead of raw IDs          | Marthinus                                |
| [OPEN-1742](https://powerfleet.atlassian.net/browse/OPEN-1742) | Summary dashboard panel — asset + drift counts       | Marthinus                                |
| [OPEN-1743](https://powerfleet.atlassian.net/browse/OPEN-1743) | Exclude LastConfig/LastIMEI/LastIMSI from comparisons | Marthinus                                |
| [OPEN-1844](https://powerfleet.atlassian.net/browse/OPEN-1844) | Add GetConfigurationGroupSummaries API endpoint       | Grant                                    |
| [OPEN-1845](https://powerfleet.atlassian.net/browse/OPEN-1845) | Add ConfigConfigurationGroups API endpoint            | Grant                                    |
| [OPEN-1833](https://powerfleet.atlassian.net/browse/OPEN-1833) | Add ConfigAllowedOrganisationsAsync endpoint          | William King                             |
| [OPEN-1834](https://powerfleet.atlassian.net/browse/OPEN-1834) | Add GetActiveAssetListForOrganisationAsync endpoint   | Grant                                    |
| [OPEN-1744](https://powerfleet.atlassian.net/browse/OPEN-1744) | Allow user to select standard and assets              | ~~Cancelled~~ (superseded by OPEN-1832) |
| [OPEN-1915](https://powerfleet.atlassian.net/browse/OPEN-1915) | UI - Add mandatory test stage to Azure pipeline       | ~~Cancelled~~                           |

### Shared (Me + Boss)

| Ticket                                                      | Summary                                                                            | Status         | Note       |
| ----------------------------------------------------------- | ---------------------------------------------------------------------------------- | -------------- | ---------- |
| [OPEN-1756](https://powerfleet.atlassian.net/browse/OPEN-1756) | Add manager to Automation API to load the necessary data to work with              | ~~Cancelled~~ | Superseded |
| [OPEN-1757](https://powerfleet.atlassian.net/browse/OPEN-1757) | Add endpoint for the config delta tool in the API to allow user to do a comparison | ~~Cancelled~~ | Superseded |

### Boss's Tickets (FYI)

| Ticket                                                      | Summary                                                                  | Status       | Note                                       |
| ----------------------------------------------------------- | ------------------------------------------------------------------------ | ------------ | ------------------------------------------ |
| [OPEN-1300](https://powerfleet.atlassian.net/browse/OPEN-1300) | Add CAN peripheral, speed source, and RPM source checks to QC Automation | ~~Done~~ ✅ | Grant                                      |
| [OPEN-1607](https://powerfleet.atlassian.net/browse/OPEN-1607) | Add odometer vs trip distance consistency check to QC Automation         | ~~Done~~ ✅ | Grant                                      |
| [OPEN-1800](https://powerfleet.atlassian.net/browse/OPEN-1800) | Enforce naming convention consistency across Powerfleet.Automation API   | ~~Done~~ ✅ | William King — no UI impact action needed |

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
- **Status**: **Committed** — move to In Progress Dev and start work now

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

- [OPEN-1913](https://powerfleet.atlassian.net/browse/OPEN-1913) — UI - Bootstrap Vitest and React Testing Library → **Ready for QA**
- [OPEN-1914](https://powerfleet.atlassian.net/browse/OPEN-1914) — UI - Add seed unit tests for core service and utility logic → **Ready for QA**
- [OPEN-1915](https://powerfleet.atlassian.net/browse/OPEN-1915) — UI - Add mandatory test stage to Azure pipeline → ~~Cancelled~~
- [OPEN-1916](https://powerfleet.atlassian.net/browse/OPEN-1916) — UI - Enforce test coverage on commit via Husky pre-commit hook → **Ready for QA**
- **Status**: 1913 + 1914 + 1916 need QA. 1915 cancelled.

### 10. Close OPEN-1832

- **What**: Add test case creation screen to the Config Change Analysis Tool UI
- **Status**: ✅ Already marked **Done** in Jira — nothing to do.

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

---

If I am not mistaken for AU, we used the following public facing urls....
For AUtomation UI:
https://automation-au.mixtelematics.com/
For Automation API:
https://automation-api-au.mixtelematics.com/

If you could follow the same pattern it would be great
```

```
ENT
522301445307
Ireland
eu-west-1
ENT-Config
```

## PROD

### AU

Sydney
ap-southeast-2

- https://automation-api-au.mixtelematics.com/swagger/index.html
- https://automation-au.mixtelematics.com

### ZA

- https://automation-api.za.mixtelematics.com
- https://automation.za.mixtelematics.com

(**Domain note:** I used `automation.za.mixtelematics.com` / `automation-api.za.mixtelematics.com` (not the `-za.` pattern like AU). The `*.mixtelematics.com` cert in this ZA account is **expired**, so only `*.za.mixtelematics.com` works. If you want the `-za.` style, a new ACM cert for `*.mixtelematics.com` would need to be requested and validated via the shared DNS account.)

**Add OPENAI_API_KEY** — Via console: ECS → Task Definitions → `za-powerfleet-automation-ui` → Create new revision → add the key → update the service to use it.

OPENAI_API_KEY=AZURE_OPENAI_KEY_INT_REDACTED

### ENT

## What you still need to do

**1. Route 53 DNS** — The `mixtelematics.com` zone is not in this AWS account. Ask your DNS/infra team to create two A-record aliases pointing to `ZA-Config-ExternalALB-977038863.eu-west-1.elb.amazonaws.com` (hosted zone `Z32O12XQLNTSW2`):

- `automation-api.za.mixtelematics.com`
- `automation.za.mixtelematics.com`

**2. Rebuild the UI Docker image** — The `api-urls.ts` fix I made is in source only. The DEV image currently deployed doesn't have it, so the ZA UI will route API calls to the wrong URL. You need to build + push a new image to `668736068906.dkr.ecr.eu-west-1.amazonaws.com/za-powerfleet-automation-ui:latest`, then force a redeployment:

```bash
aws ecs update-service --cluster ZA-Config --service za-powerfleet-automation-ui --force-new-deployment --region eu-west-1
```

**3. Add OPENAI_API_KEY** — Via console: ECS → Task Definitions → `za-powerfleet-automation-ui` → Create new revision → add the key → update the service to use it.

**Domain note:** I used `automation.za.mixtelematics.com` / `automation-api.za.mixtelematics.com` (not the `-za.` pattern like AU). The `*.mixtelematics.com` cert in this ZA account is **expired**, so only `*.za.mixtelematics.com` works. If you want the `-za.` style, a new ACM cert for `*.mixtelematics.com` would need to be requested and validated via the shared DNS account.

**To fix it**, sign into the AU AWS account and do this via console:

1. ECS → Task Definitions → `au-powerfleet-automation-ui` → latest revision → **Create new revision**
2. Click the container → Environment variables, ensure all 5 are set:

| Key                        | Value                                                  |
| -------------------------- | ------------------------------------------------------ |
| `OPENAI_API_TYPE`        | `azure`                                              |
| `OPENAI_API_BASE`        | `https://aura-ai-assistant-int-eu.openai.azure.com/` |
| `OPENAI_API_VERSION`     | `2024-08-01-preview`                                 |
| `OPENAI_DEPLOYMENT_NAME` | `gpt-4.1`                                            |
| `OPENAI_API_KEY`         | _(the key)_                                          |

3. Save revision → update the `au-powerfleet-automation-ui` service to use the new revision.

> **Note:** The `OPENAI_API_BASE` above is the INT/EU endpoint — double-check AU has its own Azure OpenAI resource or if it shares the EU one, as that affects which key to use.

## Examples & Reference

- [[QBR Report for clients]]
- [[AI python to see data issues]]
- [[Operations Enablement]]
- [[Operations Tools Looking forward 20260316]] — source transcript: boss's sprint directives (Afrikaans)
