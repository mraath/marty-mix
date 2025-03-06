---
created: 2023-10-19T07:57
updated: 2023-10-19T08:11
---
JIRA:SR-16639

## Description

Example [[Event]]: TCO - Vehicle Driven Without Headlights

![[SR-16639 Camera selection settings not cascading to templates Event.png|600]]

Select Cameras and Save
![[SR-16639 Camera selection settings not cascading to templates Select Event Cameras.png|600]]
  

Select ‘[[Cascade to templates]]’ from drop down menu
![[SR-16639 Camera selection settings not cascading to templates Cascade Event to Templates.png|600]]
  

Select Templates and Save
![[SR-16639 Camera selection settings not cascading to templates Choose Templates.png|600]]

Cascading shows successful

![[SR-16639 Camera selection settings not cascading to templates Success.png|600]]

Select any [[event template]]

![[SR-16639 Camera selection settings not cascading to templates Select a Template.png|600]]
  

Go to Event: TCO - Vehicle Driven Without Headlights. Camera selection is not ticked

![[SR-16639 Camera selection settings not cascading to templates Camera not selected.png|600]]


## Fix

- BE: Changed libraryEvent.EventId to libraryEvent.Id
- [Pull request 92862: SR-16639 Fix for Cascading issue. Merged 23.14 into INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/92862?_a=files)
- DB: 
	- Added: With DefaultLibraryCameraNameKey a
	- Changed ,@DefaultLibraryCameraNameKey to ,a.LibraryCameraNameKey (main fix)
- [Pull request 92864: SR-16639 Update SP to allow for multiple default cameras to be set. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/92864?_a=files&path=/DeviceConfiguration/Schemas/template/Stored%20Procedures/Template_AddTemplateDefaultEventCamera.sql)
