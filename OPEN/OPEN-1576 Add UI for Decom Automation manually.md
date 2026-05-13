---
status: in-progress-dev
priority: 1
created: 2026-03-06T00:00
updated: 2026-03-10T15:30
---

# OPEN-1576 Add UI for Support to Supply Salesforce Case Info and Start Decom Automation Manually

JIRA: [OPEN-1576](https://powerfleet.atlassian.net/browse/OPEN-1576)
Parent: [[OPEN-1545]] — Decommissioning Automation - Phase 1
Labels: Automation, OpsTools
Assignee: Marthinus Raath
Status: In Progress Dev
Related: [[OPEN-1730 Change the UI for Decomm]]

## Start Here Tomorrow — Priority Checklist

- [x] Base form UI to be built in tandem with [[OPEN-1730 Change the UI for Decomm]]
- [x] Create overloaded API endpoint that returns resultset as JSON (for support to paste into Salesforce case)
- [x] Reference [[OPEN-1493 UI for Salesforce case Info]] as implementation example
- [x] See [[OPEN-1730 Change the UI for Decomm]] for form field/layout changes

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

We are currently waiting for Salesforce to implement their side of the integration. Because the timeline is uncertain, support agents need a **manual mechanism** to:

1. Fill in the required Salesforce case data points via a UI.
2. Trigger the Decom Automation manually.
3. Receive the result as JSON to paste back into the Salesforce case.

**Implementation references:**
- Use [[OPEN-1493 UI for Salesforce case Info]] as the example pattern.
- See [[OPEN-1730 Change the UI for Decomm]] for the form field changes to this form.

## Further Chat Notes

> Items below were discussed in chat but are NOT fully detailed in the Jira description.

### Integration with OPEN-1730

This story shares the same UI form as [[OPEN-1730 Change the UI for Decomm]]. The Decomm form built for OPEN-1730 **is** the form used here to trigger the automation manually. Implement both in the same sprint/branch where possible.

### Overloaded Endpoint

An overloaded (or separate) version of the Decom endpoint must:
- Accept the same JSON payload structure.
- Return the resultset in **JSON format** (not fire-and-forget) so the agent can copy/paste it into Salesforce.

## Branch

> Branch: `Config/MR/Feature/OPEN-1576_OPEN-1730_DecomUI` (shared with OPEN-1730)

## PR Checklist

- [ ] OPEN-1576 Decom Manual UI → DEV
- [ ] OPEN-1576 Decom Manual UI → INT
- [ ] OPEN-1576 Decom Manual UI → UAT
- [ ] OPEN-1576 Decom Manual UI → PROD
