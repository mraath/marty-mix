---
created: 2024-09-19T08:17
updated: 2024-10-02T13:12
---
## Last Notes

```dataview 
TABLE
FROM -"DailyNotes"
WHERE file.mtime >= date(today) - dur(100 day)
AND !contains(file.path, "DailyNotes/") 
AND !contains(file.path, "WeeklyNotes/")
AND !contains(file.path, "MonthlyNotes/")
AND !contains(file.path, "Some Day/")
AND !contains(file.path, "Templater/")
AND !contains(file.path, "Templates/")
SORT file.mtime DESC
LIMIT 30
```

## Outstanding (PREV worked on)

```dataview
TASK 
FROM "" 
WHERE !completed 
AND file.mtime >= date(today) - dur(10 day) 
FLATTEN file.path AS Path 
SORT dateformat(file.mtime, "yyyy-MM-dd") desc
GROUP BY Path
```

