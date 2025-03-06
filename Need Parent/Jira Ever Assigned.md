```jira-search
type: TABLE
query: (assignee = currentUser() OR assignee was currentUser()) AND status not in ("closed", "resolved") and updated >= "2022/01/01" ORDER BY updated desc, status asc, priority, key
```