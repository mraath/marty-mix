---
aliases:
  - Marty Team Issues
created: 2023-10-03T10:03
updated: 2023-12-11T07:56
---
```jira-search
type: TABLE
query: assignee = EMPTY AND status in (Parked, Open, "In Progress", "Pending Release UAT", "Pending Release Prod", "Pending Release Approval", "Pending Release") AND Team = "Team Config" AND issuetype in (Bug, "Bug (Sub Task)", "Service Request", "Service Request (Sub Task)", "Advanced Service Request") AND priority != "To be set" ORDER BY status ASC, priority DESC, issuetype DESC, Key ASC
columns: -TYPE, -PRIORITY, KEY, STATUS,  SUMMARY, UPDATED, , -REPORTER
```

## Jira

- [Marty Team Issues](https://csojiramixtelematics.atlassian.net/issues/?filter=12814)
- [Marty Unassigned SR and REG](https://csojiramixtelematics.atlassian.net/issues/?filter=12852)
