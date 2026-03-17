---
created: 2025-05-05T11:56
updated: 2026-03-17T00:00
---

> [!Information] Writing tools to make the clients' lives easier.

## TODO — UI Tasks (Next Up)

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

- [x] **OPEN-1729** — QC UI: Implement 3-line layout, hide firmware + peripherals ✅ 2026-03-09
- [x] **OPEN-1730** — Decomm UI: 2-line layout, ReadOnly UTC date (default = Now), combine with OPEN-1576 ✅ 2026-03-11
- [x] **OPEN-1737** — Multiple IMEI input: split on comma/space, build JSON array per IMEI ✅ 2026-03-10
- [x] **OPEN-1576** — Manual Decom trigger UI: overloaded endpoint returning JSON result ✅ 2026-03-11

- [ ] Deploy to DEV/INT — verify with IMEI `352739097418310` (video-linked)
- [ ] Check OPEN-1800 naming convention changes for UI impact
- [ ] Verify all open tickets are in the correct status on the sprint board

---

## Sprint Focus — Next Sprint

> **Marthinus** → Config Delta / Audit Tool
> **Cornel** → Salesforce integration

### Engineering Directives (from boss)

1. **Data via API** — All data loading and writes go through the API as far as possible.
2. **UI via Agents** — UI and analyses are built by AI agents. Make it fast and visually premium: use graphs, maps wherever possible. API endpoints get updated as data changes.
3. **Well-commented code** — AI can handle commenting. This is a non-negotiable going forward.
4. **API code available to agents** — Give agents access to the API codebase. They can commit and create PRs. **We approve PRs — not AI** (at least for now).
5. **JIRA specs must be thorough** — Agents need well-specced tickets and code access to do good work.
6. **Weekly sync** — Team sessions planned for sharing knowledge and making tech decisions. If something is urgent, don't wait — ask freely.

---

## Links

| Resource | URL |
|---|---|
| Sprint Board | [Sprint Board](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/7014/backlog) |
| Kanban | [Kanban](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/6981) |
| Repo Overview | [Azure DevOps](https://dev.azure.com/MiXTelematics/OperationsTools) |
| Repo Dev Branch | [development](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation?path=%2F&version=GBdevelopment&_a=contents) |

---

## Stories — Active Sprint

> Epic: [OPEN-1264](https://powerfleet.atlassian.net/browse/OPEN-1264) — Unity MX Installation QC Automation - Phase 1

### Assigned to Me (Marthinus)

| Ticket | Summary | Status | Note |
|---|---|---|---|
| [OPEN-1788](https://powerfleet.atlassian.net/browse/OPEN-1788) | [[OPEN-1788 Add AI ChatBot Panel to the Configuration Delta Tool\|AI ChatBot Panel — Config Delta Tool]] | In Progress Dev | Branch: `Config/MR/Feature/OPEN-1788_AIChatBotPanel` |
| [OPEN-1741](https://powerfleet.atlassian.net/browse/OPEN-1741) | Support descriptions instead of IDs (Config Delta) | — | Assigned to M |
| [OPEN-1742](https://powerfleet.atlassian.net/browse/OPEN-1742) | Add dashboard summary (Config Delta) | — | Assigned to M |
| [OPEN-1743](https://powerfleet.atlassian.net/browse/OPEN-1743) | Ignore certain differences in comparisons (Config Delta) | — | Assigned to M |
| [OPEN-1744](https://powerfleet.atlassian.net/browse/OPEN-1744) | Config Delta — parent story | — | Key epic for next sprint |
| [OPEN-1832](https://powerfleet.atlassian.net/browse/OPEN-1832) | Sub-ticket for OPEN-1744 | — | **Priority** — created by boss |
| [OPEN-1833](https://powerfleet.atlassian.net/browse/OPEN-1833) | Sub-ticket for OPEN-1744 | — | **Priority** — created by boss |
| [OPEN-1834](https://powerfleet.atlassian.net/browse/OPEN-1834) | Sub-ticket for OPEN-1744 | — | **Priority** — created by boss |

### Shared (Me + Boss)

| Ticket | Summary | Status | Note |
|---|---|---|---|
| [OPEN-1756](https://powerfleet.atlassian.net/browse/OPEN-1756) | TBD | — | Ek/M |
| [OPEN-1757](https://powerfleet.atlassian.net/browse/OPEN-1757) | TBD | — | Ek/M |

### Background / Dependencies (Backend — Not My Primary)

| Ticket | Summary | Notes |
|---|---|---|
| [OPEN-1725](https://powerfleet.atlassian.net/browse/OPEN-1725) | Update starting Endpoint to receive new parameters | API side of OPEN-1737 |
| [OPEN-1726](https://powerfleet.atlassian.net/browse/OPEN-1726) | Retrieve device & asset info using new parameters | Backend logic |
| [OPEN-1727](https://powerfleet.atlassian.net/browse/OPEN-1727) | Create static class for shared logic layer | Shared logic container |
| [OPEN-1728](https://powerfleet.atlassian.net/browse/OPEN-1728) | Change how peripherals are checked | API refactor; UI hides peripherals for now |

### Boss's Tickets (FYI)

| Ticket | Summary | Note |
|---|---|---|
| [OPEN-1300](https://powerfleet.atlassian.net/browse/OPEN-1300) | — | Boss |
| [OPEN-1607](https://powerfleet.atlassian.net/browse/OPEN-1607) | — | Boss |
| [OPEN-1800](https://powerfleet.atlassian.net/browse/OPEN-1800) | Naming conventions (done) | ✅ Done — may cause minor UI impact |

---

## API Fixes (Boss — 2026-03-14 weekend)

Boss made the following API fixes and self-approved the PR:

- Video API URL was incorrect
- `AssetSummary` was returning null OrgId — fixed
- `Positions` renamed to `LatestPositions`
- `Events` renamed to `EventsSince`, `Trips` renamed to `TripsSince`
- `GetSinceAsync` has known perf issues with large datasets — **noted for future sprint** (QBR/analytics impact)
- Future: `HelperManager` to be refactored (story to be created) — config-driven loading instead of action switch

**Action**: Deploy to **INT** (described as DEV) and test with IMEI `352739097418310`.

---

## Stories — Completed / Reference

### QC Automation Phase 1 — Foundation

- Spike: [OPEN-1223](https://powerfleet.atlassian.net/browse/OPEN-1223) — Investigate QC Automation
	- API Endpoint: [OPEN-1293](https://powerfleet.atlassian.net/browse/OPEN-1293)
	- UI (Completed): [OPEN-1493](https://powerfleet.atlassian.net/browse/OPEN-1493) — [[OPEN-1493 UI for Salesforce case Info]] ✅ 2026-02-24
	- Video: [OPEN-1299](https://powerfleet.atlassian.net/browse/OPEN-1299) — check camera channels after install
	- Decommissioning Phase 1: [OPEN-1545](https://powerfleet.atlassian.net/browse/OPEN-1545)
		- Add Decomm Endpoint: [OPEN-1567](https://powerfleet.atlassian.net/browse/OPEN-1567)

### Customer Database

- Epic: [OPEN-1539](https://powerfleet.atlassian.net/browse/OPEN-1539) — Consolidated Customer/Subscriber Database
	- [OPEN-1495](https://powerfleet.atlassian.net/browse/OPEN-1495) — Investigate Customer Database requirements

### Config Analysis Tool

- [OPEN-1494](https://powerfleet.atlassian.net/browse/OPEN-1494) — [[OPEN-1494 Config Analysis Tool]] — Meeting: Investigate Config Analyses Tool
- [OPEN-1624](https://powerfleet.atlassian.net/browse/OPEN-1624) — Split: Config Change Analysis Tool

### Other

- [OPEN-1526](https://powerfleet.atlassian.net/browse/OPEN-1526) — AI to work with Salesforce
- [OPEN-1356](https://powerfleet.atlassian.net/browse/OPEN-1356) — Trigger QC API Endpoint
- [OPEN-1328](https://powerfleet.atlassian.net/browse/OPEN-1328) — Create endpoint in Salesforce
- [OPEN-1715](https://powerfleet.atlassian.net/browse/OPEN-1715) — [[OPEN-1715 Setup UI and API on AWS for AU]] — AWS Setup for AU
- [PFI-3133](https://powerfleet.atlassian.net/browse/PFI-3133) — Operations Enablement Engineering Improvements
	- [OPEN-455](https://powerfleet.atlassian.net/browse/OPEN-455) — CAN Logger App Enhancements
- [OPEN-1631](https://powerfleet.atlassian.net/browse/OPEN-1631) — Develop and Implement tools to increase efficiency (Epic)

---

## Examples & Reference

- [[QBR Report for clients]]
- [[AI python to see data issues]]
- [[Operations Enablement]]
- [[Operations Tools Looking forward 20260316]]
