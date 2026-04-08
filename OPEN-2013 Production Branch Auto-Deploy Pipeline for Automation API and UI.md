---
status: In Progress Dev
priority: 1
created: 2026-04-08T00:00
updated: 2026-04-08T14:39
---

# OPEN-2013 Production Branch Auto-Deploy Pipeline for Automation API and UI

JIRA: [OPEN-2013](https://powerfleet.atlassian.net/browse/OPEN-2013)
Parent: [[OPEN-1624]] — Config change analysis tool
Labels: None
Assignee: Marthinus Raath
Status: In Progress Dev

## Start Here Tomorrow — Priority Checklist

- [ ] Set up the production branches as specified in the Jira description.
- [ ] Configure auto-deploy pipelines.

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

Production Branch & Auto-Deploy Pipeline for Automation API and UI

## Further Chat Notes

> Add any context from chat/boss instructions that is NOT in the Jira description.

## Branch

> Branch: Config/MR/Feature/OPEN-2013_ProdBranchAutoDeploy

## PR Checklist

- [ ] OPEN-2013 → DEV
- [ ] OPEN-2013 → INT
- [ ] OPEN-2013 → UAT
- [ ] OPEN-2013 → PROD
