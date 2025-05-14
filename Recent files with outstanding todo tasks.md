---
created: 2025-05-14T10:03
updated: 2025-05-14T10:28
---

```dataview
TABLE WITHOUT ID file.name AS "File", filter(file.tasks, (t) => !t.completed).link AS "Todo Items"
FROM ""
WHERE file.tasks
WHERE contains(file.tasks.completed, false)
WHERE !contains(file.folder, "Templates") AND !contains(file.folder, "Templater")
SORT file.mtime DESC
LIMIT 20
```
