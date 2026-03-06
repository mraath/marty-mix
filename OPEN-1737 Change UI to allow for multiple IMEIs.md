---
status: committed
priority: 1
created: 2026-03-06T00:00
updated: 2026-03-06T11:45
---

# OPEN-1737 Change UI to allow for multiple IMEIs

JIRA: [OPEN-1737](https://powerfleet.atlassian.net/browse/OPEN-1737)
Parent: [[OPEN-1264]] — Unity MX Installation QC Automation - Phase 1
Labels: Automation, OpsTools
Assignee: Marthinus Raath
Status: Committed
Related: [[OPEN-1729 Change the UI for QC]], [[OPEN-1725]]

## Start Here Tomorrow — Priority Checklist

- [ ] Modify IMEI field to accept multiple values (split by `,` or ` `)
- [ ] Update JSON generation — one record per IMEI
- [ ] Handle `RegistrationNumber` as blank/null gracefully
- [ ] Odometer → send `null` if empty
- [ ] DataCenter derived from Environment combo box
- [ ] Test with AU data (RegNo likely blank)

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

Currently the UI can handle only **1 IMEI**. Change it so the user can enter **multiple IMEIs**.

When the user triggers the check, the JSON sent to the API must include each IMEI as a **separate record**:

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

> This allows checks to be done as a single submission.

## Further Chat Notes

> Items below were discussed in chat but are NOT in the Jira description.

### Input Splitting Logic

The IMEI field must split on **both**:
- Comma `,`
- Space ` `

So a user can paste: `123456789012345, 987654321098765` or `123456789012345 987654321098765` and both work.

### JSON Field Mapping

| JSON Field | Source |
|---|---|
| `SalesforceCaseNumber` | Case Number input |
| `DataCenter` | **Derived from the Environment combo box** (not a manual input) |
| `ActionDate` | DateTime (UTC) |
| `UniqueIdentifier` | Each split IMEI/SerialNumber |
| `RegistrationNumber` | Reg Number input — **handle blank / not available** |
| `Odometer` | Odometer input — **send `null` if empty** |

### AU Note — Registration Numbers

> **Important**: Registration Numbers are often blank in Australia because units are installed **before the vehicle is registered**. The UI must handle `RegNo` as `null` / blank without error.

### Related Backend

- [[OPEN-1725]] — Backend endpoint update to receive the new array parameter structure.

## Branch

> Branch: (to be created)

## PR Checklist

- [ ] OPEN-1737 Multiple IMEIs → DEV
- [ ] OPEN-1737 Multiple IMEIs → INT
- [ ] OPEN-1737 Multiple IMEIs → UAT
- [ ] OPEN-1737 Multiple IMEIs → PROD
