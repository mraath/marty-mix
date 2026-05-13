---
status: in-progress-dev
priority: 1
created: 2026-03-06T00:00
updated: 2026-03-10T15:29
---

# OPEN-1730 Change the UI for Decomm to accommodate the information needed to start checks

JIRA: [OPEN-1730](https://powerfleet.atlassian.net/browse/OPEN-1730)
Parent: [[OPEN-1264]] — Unity MX Installation QC Automation - Phase 1
Labels: Automation, OpsTools
Assignee: Marthinus Raath
Status: In Progress Dev
Related: [[OPEN-1576 Add UI for Decom Automation manually]]

## Start Here Tomorrow — Priority Checklist

- [x] Implement 2-line layout (see Further Chat Notes)
- [x] Set Decommissioning Date default to `DateTime.UtcNow`
- [x] Set Decommissioning Date field to **ReadOnly**
- [ ] Wait for ETS defect ticket (Patrick) before renaming "Installation Date" → "Decommissioning Date (UTC)"
- [x] Combine implementation with [[OPEN-1576 Add UI for Decom Automation manually]]
- [x] Validate: CaseNumber and UniqueIdentifier reject spaces

## TODO

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

## Description (from Jira)

The following fields need to be visible on the QC UI (Decommissioning):

| Field | Requirement |
|---|---|
| Salesforce Case Number | Mandatory |
| Decommissioning Date | Mandatory, **Read Only** |
| Unique Identifier (IMEI) | Mandatory |
| Registration Number | Mandatory |

**JSON payload sent to API endpoint:**

```json
[
	{
		"CaseNumber": "Case number",
		"InstallationDate": "DateTime",
		"UniqueIdentifier": "IMEI/SerialNumber",
		"RegistrationNumber": "RegistrationNumber"
	}
]
```

**Rules:**
- Decommissioning date is **UTC** — cannot be changed by the user (ReadOnly).
- `CaseNumber` and `UniqueIdentifier` must **not accept spaces**.

## Further Chat Notes

> Items below were discussed in chat but are NOT in the Jira description.

### UI Layout — 2-Line Design (Simplified QC)

```
Line 1: [ Case Number          ] [ Decommissioning Date (UTC) ]
Line 2: [ Unique Identifier    ] [ Reg Number                 ]
```

- Fields on the same line are **side-by-side**.
- Decommissioning Date is read-only; default = `DateTime.UtcNow`.

### Renaming "Installation Date" → "Decommissioning Date (UTC)"

> **WAIT** — do NOT rename until ETS (Patrick) raises the defect ticket. This rename is dependent on that ticket being received first.

### Implementation Dependency

This story must be combined/co-implemented with [[OPEN-1576 Add UI for Decom Automation manually]]. The base form work in OPEN-1730 feeds directly into the manual trigger UI of OPEN-1576.

### AU Note — Registration Numbers

Registration Numbers are often **blank in Australia** because units are installed before the vehicle is registered. Always treat `RegNo` as potentially `null` / blank.

## Branch

> Branch: `Config/MR/Feature/OPEN-1576_OPEN-1730_DecomUI` (shared with OPEN-1576)

## PR Checklist

- [ ] OPEN-1730 Decomm UI Changes → DEV
- [ ] OPEN-1730 Decomm UI Changes → INT
- [ ] OPEN-1730 Decomm UI Changes → UAT
- [ ] OPEN-1730 Decomm UI Changes → PROD
