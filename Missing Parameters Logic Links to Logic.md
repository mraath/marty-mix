---
wiki_ingested: 2026-05-28
created: 2025-04-08T13:35
updated: 2025-04-08T13:42
---
Herewith the missing parameters logic... with links to the files where the logic is.
As you can see it is quite involved.

You will see round about line 100, the main thing happens... where it sets the status to NoParameters... which is saying the parameters are missing where needed.

+- Lin 100: "eventStatus = EventStatus.NoParameters;"
In this file:
C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\MobileUnitLevel\MobileUnitEventsModule.cs

mobileUnitManager.GetMobileUnitAggregate goed to this file:
C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs

ConfigAdminRepository.GetMobileUnitAggregate goed to this file:
C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminRepository.cs

GetMobileUnitAggregateQuery comes from here:
round about line 2346:
C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminRepository.cs

THEN

mobileUnitManager.GetEffectiveConfig comes from here:
+- line 798: 
C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs

A lot happens in the above file.

It then goes through all the config.AllEvents
If an event is not in the monitored events, then it sets that event as  NoParameters

As you can see it is quite involved, but just take your time, please dont miss any logic, else the SQL will not be accurate.
Rather take longer to architect this and then plan the stored proc and then show the stored proc.
