---
created: 2025-11-26T09:28
updated: 2025-11-26T09:48
---

20251126

Yesterday we looked into this stored proc: C:\Projects\Database\DeviceConfiguration\Schemas\template\Stored Procedures\Template_GetConfigurationGroupsOtherColumns.sql. The version you see here is already optimized. ALL my orginal issues have been resolved. It only shows the correct FW Version and it is faster and mostly data is correct. Whan I can see is the CAN lines are not correct. It should return BOTH C1 and C2 if they exist. This will result in CanScriptLineId and CanScript having multiple (comma seperated) values. The current version is no longer doing this, so I think it will be a simple fix of just allowed BOTH, not selecting just one. PLEASE ensure it stays optimized and fast. Herewith the OLD version where BOTH correctly showed: C:\Projects\marty-mix\ETS-6874\OLD_OTHERS.md

---

