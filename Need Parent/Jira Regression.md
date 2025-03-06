```jira-search
type: TABLE
query: assignee = EMPTY AND Team in ("Team Config 1", "Team DI Config", "Team Config") AND issuetype in (Bug) AND status not in (Resolved, Closed, "Support Feedback Required") AND (summary ~ REG: OR summary ~ INT: OR summary ~ DEV:) ORDER BY createdDate DESC
```
