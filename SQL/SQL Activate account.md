---
created: 2023-10-31T15:17
updated: 2024-09-06T14:33
---

```sql
  update [DynaMiX].[DynaMiX_Authentication].[Accounts]  
  set AccountStatusKey = 1
  IncorrectPasswordCount = 0
  where username = 'marthinus.raath@mixtelematics.com'
```
