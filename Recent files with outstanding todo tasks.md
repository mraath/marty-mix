---
created: 2025-05-14T10:03
updated: 2025-05-14T10:08
---

```dataview
TABLE WITHOUT ID file.name AS "File", tasks.text AS "Todo Items"
FROM ""
WHERE file.tasks
FLATTEN file.tasks AS tasks
WHERE !tasks.completed
WHERE !contains(file.folder, "Templates") AND !contains(file.folder, "Templater")
GROUP BY file
SORT file.mtime DESC
LIMIT 20
```