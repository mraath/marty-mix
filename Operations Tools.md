---
created: 2025-05-05T11:56
updated: 2026-03-10T15:13
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
- [ ] **OPEN-1730** — Decomm UI: 2-line layout, ReadOnly UTC date (default = Now), combine with OPEN-1576
- [x] **OPEN-1737** — Multiple IMEI input: split on comma/space, build JSON array per IMEI ✅ 2026-03-10
- [ ] **OPEN-1576** — Manual Decom trigger UI: overloaded endpoint returning JSON result

## Links

| Resource | URL |
|---|---|
| Sprint Board | [Sprint Board](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/7014/backlog) |
| Kanban | [Kanban](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/6981) |
| Repo Overview | [Azure DevOps](https://dev.azure.com/MiXTelematics/OperationsTools) |
| Repo Dev Branch | [development](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation?path=%2F&version=GBdevelopment&_a=contents) |

---

## Stories — Active Sprint (QC Automation Phase 1)

> Epic: [OPEN-1264](https://powerfleet.atlassian.net/browse/OPEN-1264) — Unity MX Installation QC Automation - Phase 1

### Assigned to Me — UI Work

| Ticket                                                         | Summary                                                                                       | Status          | Note                       |
| -------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------- | -------------------------- |
| [OPEN-1729](https://powerfleet.atlassian.net/browse/OPEN-1729) | [[OPEN-1729 Change the UI for QC\|QC UI — 3-line layout, hide peripherals/firmware]]          | Committed       | DONE                       |
| [OPEN-1730](https://powerfleet.atlassian.net/browse/OPEN-1730) | [[OPEN-1730 Change the UI for Decomm\|Decomm UI — 2-line layout, ReadOnly UTC date]]          | Committed       | Combine with OPEN-1576     |
| [OPEN-1737](https://powerfleet.atlassian.net/browse/OPEN-1737) | [[OPEN-1737 Change UI to allow for multiple IMEIs\|Multiple IMEI input — split & JSON array]] | Committed       | DONE                       |
| [OPEN-1576](https://powerfleet.atlassian.net/browse/OPEN-1576) | [[OPEN-1576 Add UI for Decom Automation manually\|Manual Decom trigger UI]]                   | In Progress Dev | Shared form with OPEN-1730 |

### Background / Dependencies (Backend — Not My Primary)

| Ticket | Summary | Notes |
|---|---|---|
| [OPEN-1725](https://powerfleet.atlassian.net/browse/OPEN-1725) | Update starting Endpoint to receive new parameters | API side of OPEN-1737 |
| [OPEN-1726](https://powerfleet.atlassian.net/browse/OPEN-1726) | Retrieve device & asset info using new parameters | Backend logic |
| [OPEN-1727](https://powerfleet.atlassian.net/browse/OPEN-1727) | Create static class for shared logic layer | Shared logic container |
| [OPEN-1728](https://powerfleet.atlassian.net/browse/OPEN-1728) | Change how peripherals are checked | API refactor; UI hides peripherals for now |
| [OPEN-1741](https://powerfleet.atlassian.net/browse/OPEN-1741) | Support descriptions instead of IDs | Comparison/mapping logic |
| [OPEN-1742](https://powerfleet.atlassian.net/browse/OPEN-1742) | Add dashboard summary | High-level summary view |
| [OPEN-1743](https://powerfleet.atlassian.net/browse/OPEN-1743) | Ignore certain differences in comparisons | Filter/whitelist for comparison noise |

---

## Stories — Earlier Work (Completed / Reference)

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
