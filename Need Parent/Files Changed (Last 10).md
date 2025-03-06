```dataview 
TABLE
FROM -"DailyNotes"
WHERE file.mtime >= date(today) - dur(100 day)
SORT file.mtime DESC
LIMIT 10
```
