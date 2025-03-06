```dataview
TABLE
status as "Status", 
priority as "Priority",
date as "Created",
comment as "Comment"
FROM -"Templates"
WHERE (
status = "busy" 
OR status = "open"
OR status = "parked" 
OR status = "dev test"
OR status = "test"
OR status = "uat testing"
OR status = "testing"
OR status = "feedback"
OR status = "support feedback"
OR status = "pending"
OR status = "pending release"
OR status = "uat"
)
SORT priority, status ASC, file.name
```
