---
wiki_ingested: 2026-05-28
status: committed
priority: 1
created: 2026-03-06T00:00
updated: 2026-03-10T15:04
---

# OPEN-1737 Change UI to allow for multiple IMEIs

JIRA: [OPEN-1737](https://powerfleet.atlassian.net/browse/OPEN-1737)
Parent: [[OPEN-1264]] — Unity MX Installation QC Automation - Phase 1
Labels: Automation, OpsTools
Assignee: Marthinus Raath
Status: Committed
Related: [[OPEN-1729 Change the UI for QC]], [[OPEN-1725]]

## Start Here Tomorrow — Priority Checklist

- [x] Modify IMEI field to accept multiple values (split by `,` or ` `) ✅ 2026-03-10
- [x] Update JSON generation — one record per IMEI ✅ 2026-03-10
- [x] Handle `RegistrationNumber` as blank/null gracefully ✅ 2026-03-10
- [x] Odometer → send `null` if empty ✅ 2026-03-10
- [x] DataCenter derived from Environment combo box ✅ 2026-03-10
- [x] Test with AU data (RegNo likely blank) ✅ 2026-03-10

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



![[OPEN-1602 Pipeline for Powerfleet Automation API#Payload DEV]]


![[OPEN-1602 Pipeline for Powerfleet Automation API#PAYLOAD INT]]


## PR Checklist

- [x] [OPEN-1737 Multiple IMEIs → DEV](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation.UI/pullrequestcreate?sourceRef=Config/MR/OPEN-1737_multiple_IMEIs&targetRef=development&sourceRepositoryId=8a7f617a-e5af-4308-977f-cb0d39024a46&targetRepositoryId=8a7f617a-e5af-4308-977f-cb0d39024a46) ✅ 2026-03-10
	- [x] [API TEMP FIX](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation/pullrequest/140400) ✅ 2026-03-10