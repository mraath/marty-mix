---
status: closed
date: 2023-04-13
comment: 
priority: 8
created: 2023-04-13T06:13
updated: 2023-11-17T17:30
---

# Make Available

Date: 2023-04-13 Time: 06:13
Parent:: [[Device]]
Friend:: [[2023-04-13]]
JIRA:Make Available
==URL TO JIRA==

## Important setting if local debugging

- Transaction scope SUPPRESS??

## Make Available Steps

[[Make Available Steps to get parameters]]

## Make available Training video

[[Make Available Training Video]]
## Broken Make Availables

- While the individual devices are being fixed to work out of the box
- This used to work for 3K, so try for other devices (Try first)
	- Make Peripheral FM PTO Switch available  
	- Make Event FM PTO Engaged available  
	- Make device (3K) available
- This used to work for 4K, so try on others (Try second)
	- FM200 Plus 
	- FM 3607i  
	- MiX 2310i  
	- Peripheral FM PTO Switch  
	- Event FM PTO Engaged
	- Make device (4k) available

## SQL: Handy

- file:///C:/Projects/_MiXTelematicsFiles/SQL/MAke%20Unavailable%2020230428.sql
- 

## Main files used in order:

- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs
- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryMobileDeviceManager.cs
- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs
- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\MobileDeviceTemplateManager.cs
- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\MiX3000Model.cs
- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\MobileDeviceHelper.cs

Some other files:
- C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminRepository.cs
- C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminDbContext.cs
- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileDeviceManager.cs
- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryEventManager.cs
- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs

## Testing Steps for commenting

Test XXXXXX on Empty Org XXXXX
	- I ensured the Org was Empty.
	- There were NO Mobile Devices enabled.
	- I made XXXXX available.
	- The log shows: XXXXXXXXXXXXXXXXXXXXXXX
	- The Make Available modal kept spinning though. 
	- Zonika suggested this might be because it’s the first device per org. Might not be a blocker.
	- If I refresh the page it does show it as Made Available:
	- XXXXXXXXXXXXXXXXXX IMG
	- The default Event and Mobile device Templates are also present. The default config group is also present.

## Description

- 