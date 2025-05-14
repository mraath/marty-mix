---
created: 2025-05-14T10:03
updated: 2025-05-14T11:49
---

```dataview
TABLE WITHOUT ID file.name AS "File", map(filter(file.tasks, (t) => !t.completed), (t) => t.link + " - " + t.text) AS "Todo Items"
FROM ""
WHERE file.tasks
WHERE contains(file.tasks.completed, false)
WHERE !contains(file.folder, "Templates") AND !contains(file.folder, "Templater")
SORT file.mtime DESC
LIMIT 20
```
