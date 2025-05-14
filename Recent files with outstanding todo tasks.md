---
created: 2025-05-14T10:03
updated: 2025-05-14T10:03
---

```dataview
TABLE file.name AS "File", T.text AS "Todo Item"
FROM ""
FLATTEN file.tasks AS T
WHERE T.completed = false
SORT file.mtime DESC
LIMIT 20
```