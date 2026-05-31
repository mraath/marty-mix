---
wiki_ingested: 2026-05-28
---
```dataview 
TABLE
FROM -"DailyNotes"
WHERE file.mtime >= date(today) - dur(100 day)
SORT file.mtime DESC
LIMIT 10
```
