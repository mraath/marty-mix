```jira-search
type: TABLE
query: assignee = EMPTY AND status in (Parked, Open, "In Progress", "Pending Release UAT", "Pending Release Prod", "Pending Release Approval", "Pending Release") AND Team = "Team Config" AND issuetype in (Bug, "Bug (Sub Task)", "Service Request", "Service Request (Sub Task)", "Advanced Service Request") AND priority != "To be set" ORDER BY status ASC, priority DESC, issuetype, Key ASC
```
