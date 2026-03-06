---
status: committed
priority: 1
created: 2026-03-06T00:00
updated: 2026-03-06T15:38
---

# OPEN-1729 Change the UI for QC to accommodate the information needed to start checks

JIRA: [OPEN-1729](https://powerfleet.atlassian.net/browse/OPEN-1729)
Parent: [[OPEN-1264]] — Unity MX Installation QC Automation - Phase 1
Labels: Automation, OpsTools
Assignee: Marthinus Raath
Status: In Progress Dev

## Start Here Tomorrow — Priority Checklist

- [x] Implement 3-line layout (see Further Chat Notes)
- [x] Hide Firmware field
- [x] Hide all Peripheral-related UI elements
- [x] Validate: CaseNumber and UniqueIdentifier reject spaces
- [x] Validate: Odometer sends null when empty (0 is valid)
- [x] Verify Installation Date is treated as UTC

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

The following fields need to be visible on the QC UI:

| Field | Requirement |
|---|---|
| Salesforce Case Number | Mandatory |
| Installation Date | Mandatory |
| Unique Identifier (IMEI) | Mandatory |
| Registration Number | Mandatory |
| Odometer | Optional |

Hide **ALL** peripheral fields on the UI.

**JSON payload sent to API endpoint:**

```json
[
	{
		"SalesforceCaseNumber": "CaseNumber",
		"DataCenter": "DataCenter",
		"ActionDate": "DateTime",
		"UniqueIdentifier": "IMEI",
		"RegistrationNumber": "RegistrationNumber",
		"Odometer": null
	},
	{
		"SalesforceCaseNumber": "CaseNumber",
		"DataCenter": "DataCenter",
		"ActionDate": "DateTime",
		"UniqueIdentifier": "IMEI/SerialNumber",
		"RegistrationNumber": "RegistrationNumber",
		"Odometer": null
	}
]
```

> The JSON contains a collection of devices. This is the structure Salesforce uses and it will be sent through to the API.

**Rules:**
- If Odometer is not entered → send `null`. Any numeric value (including `0`) is valid.
- Installation Date is UTC for now.
- `CaseNumber` and `UniqueIdentifier` must **not accept spaces**.

## Further Chat Notes

> Items below were discussed in chat but are NOT in the Jira description.

### UI Layout — 3-Line Design

```
Line 1: [ Case Number          ] [ Installation Date  ]
Line 2: [ Unique Identifier    ] [ Reg Number         ]
Line 3: [ Odometer (optional)  ]
```

- Fields on the same line are **side-by-side**.
- Odometer sits alone on line 3 and is clearly marked optional.

### Fields to Hide

- **Firmware** field — remove from view entirely.
- **All Peripheral-related UI elements** — peripheral logic is moving to the API (see [[OPEN-1728]]). Hide everything peripheral on the UI for now.

### AU Note — Registration Numbers

Registration Numbers are often **blank in Australia** because units are installed before the vehicle is registered. Always treat `RegNo` as potentially `null` / blank.

## Branch

> Branch: \ on \

## PR Checklist

- [ ] OPEN-1729 QC UI Changes → DEV
- [ ] OPEN-1729 QC UI Changes → INT
- [ ] OPEN-1729 QC UI Changes → UAT
- [ ] OPEN-1729 QC UI Changes → PROD

## Session Notes - 2026-03-06

### Completed this session
- [x] Jira assigned to Marthinus Raath, transitioned to In Progress Dev
- [x] Branch created: Config/MR/Feature/OPEN-1729_QC_UI_Layout on Powerfleet.Automation.UI
- [x] SalesforceCase interface in contracts.ts trimmed to 5 fields (removed GroupId, LegacyOrgId, AssetId, DeviceType, FirmwareVersion, all peripheral booleans)
- [x] QCFormView.tsx rewritten: 3-line layout, peripherals removed, date clear button, space stripping, odometer null fix, InstallationDate mandatory

### Testing in progress - blocked on local API debugger
- UI is running on Powerfleet.Automation.UI feature branch
- .env.local currently pointing to localhost:7116 (local API)
- API repo (Powerfleet.Automation) is on development branch - NO new branch created there (UI-only story)
- Debugger setup done in C:\Projects\.vscode\launch.json using type: coreclr
- Both ms-dotnettools.csdevkit and ms-dotnettools.csharp extensions installed

### Next steps after restart
- [ ] Reload window in Cursor, select Automation API DEV config, hit F5
- [ ] Test the new QC form end-to-end against local API
- [ ] Commit and raise PR once testing passes
