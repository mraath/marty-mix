---
status: closed
date: 2022-11-07
comment: 
priority: 8
---

Date: 2022-11-07 Time: 08:39
Parent:: [[Make Available]]
Friend:: [[2022-11-07]]
JIRA:MIX3K-9 MiX3000 Default Config Group
[MIX3K-9 DI Config - Default config group for MiX3000 - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/MIX3K-9)

Related to: [[AC-248 Default Configuration Not just Track & Trace]]


## DEFAULT_TRANSACTION_SCOPE

		public const TransactionScopeOption DEFAULT_TRANSACTION_SCOPE = TransactionScopeOption.Suppress;

## Notes from Meeting one

- Selfinstall can app
- MAke FW avail
- GS Jamming etc
- Update lines
- Connect lines
- Events
	- @Justus: ON your question in that first video... yes... Make available in library, then add to template, yes :-)
	- Above done
- [x] Split transaction
- Justus done
- Put DLL on (INT?)
- Moved code rows - looks good
- [x] Transaction scope SUPPRESS??
- @Both: From your question in the first meeting video, regarding if I removed anything else. No, I only removed that one (13)
- [x] Default templates when fails? Delete?

## 3K second video Meeting

- COPY DLL
	- DSINTIIS01
		- d:\work
		- Temp folder
		- Copy to temp Dynamix.logic
		- BACKUP dlls
		- Then copy to: Bin
- [x] Other solution: Would would you compare in Broken and blank DB? Table entries?
- Config/JA/Makeavailable_work


## Mobile Device Info: MiX3000

JIRA:MIX3K-8

```sql
USE DeviceConfiguration;

/*
--SANITY CHECK

-- Get Library
SELECT * 
FROM library.Events le WITH (NOLOCK)
WHERE le.LibraryKey = -1
AND LegacyEventId = 292 -- EventKey: 35229 (PTO Engaged)

--(Use the EventKey)

SELECT * 
FROM [definition].[DeviceEventDependencies]
WHERE EventKey = 35229

(Use DeviceKeys)

SELECT top 10 * 
FROM definition.Devices d 
WHERE d.DeviceKey IN (9090,9075,9100,10129)

(Use CAN deviceKey)
9075
*/



-- Delete default group creation
SELECT * 
-- DELETE
FROM [definition].[DeviceDependencies] WHERE [DeviceDependencyId] = -3478484293483270551 --Remove M3K default group  

SELECT * 
-- DELETE
FROM [definition].[DeviceDependencies] WHERE [DeviceDependencyId] = -6958420740236099092 --Remove M4K default group

-- Delete PTO event from CAN
SELECT * 
-- DELETE
FROM [definition].[DeviceEventDependencies]
WHERE EventKey = 35229 --PTO 292
AND DeviceKey = 9075 --CAN

```

## MON

- Double check if the dependency doesn't exist on UAT and then PROD
- Next I will move onto the M4K


## Fri

MessageTransport.GsmSms
- Event
	- Param: -376361605312503900 ()


## Error

The transaction associated with the current connection has completed but has not been disposed. The transaction must be disposed before the connection can be used to execute SQL statements.

## DATA CLEANUP

```sql
-- Delete default group creation
DELETE FROM [definition].[DeviceDependencies] WHERE [DeviceDependencyId] = -3478484293483270551 --Remove M3K default group  
DELETE FROM [definition].[DeviceDependencies] WHERE [DeviceDependencyId] = -6958420740236099092 --Remove M4K default group

-- Delete PTO event from CAN
DELETE 
FROM [definition].[DeviceEventDependencies]
WHERE EventKey = 34686 --PTO 292
AND DeviceKey = 12215 --CAN
```

## New stories

4k, 3k, oem, fm
Donny?
	fm, 4000, 2310i
[CONFIG-3589 Automate requirements that are dependencies to make a mobile device available - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-3589)

## Next blank Org: MR 3K Issues 3

- 4K
	- Error: Could not find and add the library event. Legacy Event Id: 13.
	- Made Peripheral: FM PTO Switch available
	- Made Event: FM PTO Engaged available
	- EXCEPTION! The transaction associated with the current connection has completed but has not been disposed. The transaction must be disposed before the connection can be used to execute SQL statements.
-  Made Peripheral: FM PTO Switch available
	- Made Event: FM PTO Engaged available
		- 3K
			- 4K

So the fastest way I got the 4K to be made available on a brand new org.
1) Make Peripheral FM PTO Switch available
2) Make Event FM PTO Engaged available
3) Make 3K available
4) Make 4K available
I know we can also follow this, make available:
1) FM200 Plus
2) FM 3607i
3) MiX 2310i
4) Peripheral FM PTO Switch
5) Event FM PTO Engaged
I prefer the first one, feels simpler.

## Next blank ORG: MR 3K Issues 2

- [x] 3K
	- Error: Could not find and add the library event. Legacy Event Id: 13.
	- Made Peripheral: FM PTO Switch available
	- Made Event: FM PTO Engaged available
- FM200 Plus
	- 3K
- FM200 plus
	- MiX 2310i
		- 3K
- FM200 plus
	- FM 3607i
		- MiX 2310i
			- 3K
			- MiX4K

## Paul Reply - Tried below on: MR 3K Issues

- System.Logical.Sygic.LocationSpeedMonitor
	- System.Logical.Positioning
		- System.Logical.FM.Positioning
			- System.GPS.Receiver
				- ...FMs
					- [x] (INT) FM200 Plus
						- [x] Speed monitoring - Current location
						- 3k - nope - Could not load file or assembly 'System.Memory, Version=4.0.1.1
					- [x] (INT) FM 3607i
						- (INT) 3K - nope - Could not load file or assembly 'System.Memory
						- (Local) 3K - nope - Could not load file or assembly 'System.Memory
							- [x] Bypassed the configgroup Cache
							- EXCEPTION! The transaction associated with the current connection has completed but has not been disposed. The transaction must be disposed before the connection can be used to execute SQL statements. Exception Type: System.InvalidOperationException
							- [x] Made PEripheral FM PTO Switch available
					- BEFORE 3K.... MiX 2310i
						- [x] (local) Bypass ConfigGroup Redis - PAss
						- Now MiX3K
							- Line 140:				throw new ApplicationException("An error occurred in registering the Audit client. Verify that Lightning's config settings API is running.");
							- ...Fuel
							- Issue
								- Communication with the underlying transaction manager has failed.
								- Network access for Distributed Transaction Manager (MSDTC) has been disabled. Please enable DTC for network access in the security configuration for MSDTC using the Component Services Administrative tool.
								- Distributed Transaction Coordinator
								- 

## Paul Email

Hey daar - hoop jy doen goed.

So die MiX3k rabbit hole is toe darem nie direk aan 3K verbind nie.
Mens kan glad nie vir n nuwe org (met niks gecopy) byv n FM 3607i available maak nie.
En dis een van die basiese goed om available te maak :-)

Ekt toe die code gedebug en waar dit DIE **logical** probeer available maak:
Location speed monitoring
Probeer dit DIE **parameter** aangeheg:
Speed monitoring - Current location

En in EF val dit net om.
Ekt dit gehack en toe kom die SQL error op:
The INSERT statement conflicted with the FOREIGN KEY constraint "FK_LibraryDeviceParameters_LibraryParameters". The conflict occurred in database "DeviceConfiguration", table "library.Parameters"

Ekt toe vir DIE parameters gaan search.
Speed monitoring - Current location
Vir orgs waar jy wel die FM 3607i kan available maak is daai Parameter available.
Maar vir die splinter nuwe een - soos my "MR 3K issues" org op INT...
bestaan daai parameter nie in die library.Parameters vir die librarykey nie.

SO... nou wil ek weet of jy kan sien in die scripts of XML hoekom daai so sal wees?
Run daar iewers n cleanup. Die een wat ek en Zonika kon kry is n OU script - so sal nie hy wees nie.
MAAR byv die volgende query return niks nie...

SELECT top 5 * 
FROM library.Devices
WHERE LegacyDeviceId = -500017 --Legacy ID vir Location speed monitoring
AND LibraryKey = 2532 --Library vir MR 3K issues

Zonika het gese dalk moet ek jou vra of jy kan help om dit te vind vir die FM 3607i?

Thanks man


## Next steps

- Issues:
	- FOREIGN KEY constraint "FK_LibraryDeviceParameters_LibraryParameters". The conflict occurred in database "DeviceConfiguration", table "library.Parameters".
	- The INSERT statement conflicted with the FOREIGN KEY constraint "FK_LibraryDeviceParameters_LibraryParameters". The conflict occurred in database "DeviceConfiguration", table "library.Parameters"
		- LibraryKey
		- ParameterKey
		- library.Parameters
		- library.DeviceParameters
	- Windows Application Event Log
		- 

- [x] Create ORG (MR 3K Issues)
- Order
	- FM 3607i
		- The transaction associated with the current connection has completed but has not been disposed. The transaction must be disposed before the connection can be used to execute SQL statements
		- LibraryMobileDeviceManager.MakeLibraryMobileDeviceAvaialble
			- MakeAvailableHelper.MakeLibraryMobileDeviceAvaialble
				- MakeAvailableHelper.MakeDependanciesAvailable
					- MakeAvailableHelper.CopyAndAddLibraryLogicalDevice
						- MakeAvailableHelper.CopyAndAddParameter
							- MakeAvailableHelper.Find_Or_CopyAndAddParameter
								- ConfigAdminRepository.AddLibraryParameter
									- ConfigAdminDbContext.
		 ![[MIX3K-9 MiX3000 error.png]]
		 Location speed monitoring
		Speed monitoring - Current location
		- System.Logical.OnBoard.LocationSpeedMonitor
		- 
		 
	- 2310i / 2000 & 
	- Then rest OK

## Feedback for above to Teams Channel

OK - think I got somewhere.. man... feels like I wasted a LOT of time...
BUT... I THINK we are somewhere... will give feedback to Zonika if you also think this could be it...

I set breakpoints and stepped through the make available of a FM 3607i
IT broke when trying to add the following...
Logical: Location speed monitoring  
Parameter: Speed monitoring - Current location

I then bypassed all the save of the entity framework context.
IT then gave me a Foreign Key constraint on the libraries.Parameters
When trying to insert library.DeviceParameters

I tried A LOT of SQL stuff to find the error...
Then looked in code for the above mentioned Parameter....
Then used that against my org... and found this...

![image](data:image/jpeg;base64,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yDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUcyDlZ5DRXr3/CE+Hv+gf/AORpP/iqP+EJ8Pf9A/8A8jSf/FUc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CKipfss3/TP/AL6P+FH2Wb/pn/30f8KAIqKl+yzf9M/++j/hR9lm/wCmf/fR/wAKAIqKl+yzf9M/++j/AIUfZZv+mf8A30f8KAIqKl+yzf8ATP8A76P+FH2Wb/pn/wB9H/CgCKipfss3/TP/AL6P+FH2Wb/pn/30f8KAIqKl+yzf9M/++j/hR9lm/wCmf/fR/wAKAIqKl+yzf9M/++j/AIUfZZv+mf8A30f8KAIqKl+yzf8ATP8A76P+FH2Wb/pn/wB9H/CgCKipfss3/TP/AL6P+FH2Wb/pn/30f8KAIqKl+yzf9M/++j/hR9lm/wCmf/fR/wAKAIqKl+yzf9M/++j/AIUfZZv+mf8A30f8KAIqKl+yzf8ATP8A76P+FH2Wb/pn/wB9H/CgCKipfss3/TP/AL6P+FH2Wb/pn/30f8KAIqKl+yzf9M/++j/hR9lm/wCmf/fR/wAKAIqKl+yzf9M/++j/AIUfZZv+mf8A30f8KAIqKl+yzf8ATP8A76P+FH2Wb/pn/wB9H/CgCKipfss3/TP/AL6P+FH2Wb/pn/30f8KAIqKl+yzf9M/++j/hR9lm/wCmf/fR/wAKAIqKl+yzf9M/++j/AIUfZZv+mf8A30f8KAIqKl+yzf8ATP8A76P+FH2Wb/pn/wB9H/CgD58r6Rr5ur6Rq5ExCiiioKCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAPm6vpGvm6vpGrkTEKKKKgoKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKRWDKGU5BGRS1Hb/APHtF/uD+VAElFFFAEUlxDE22SVFPXBNN+223/PeP/vqsjWP+P0f7g/rWfVKJLkdP9ttv+e8f/fVH222/wCe8f8A31XMUU+UXMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttv+e8f/fVH222/57x/99VzFFHKHMdP9ttf+fiP0+8Kd9qg/wCeqfnXMxnEinOO3XH9R/nsehtUuUOY8Pr6Rr5ur6RpyHEKKKKgoKKKKAKs+pWFrJ5dxe20MmM7ZJVU4+hNWEdJY1kjZXRhlWU5BHqKxd10viG/+zW0E37qHd5sxTH3umFOane/lsr6VbsgQm285FGMKV++oOBnqDWan1f9bmanrqatFc4+o3iGztbi4mhkkgM8skNt5jcnhQApAxnqR2py3+ozw2EayNDJLcvC8jwbS6BWIYKw4JAB+v5Ue0V7f1vYXtYnQ0Vzt7Jdiz1ize8kfyIBIku1QxDA5U4GO3oDzWzYRPFZxrJcSTkgHc4UEcdPlAqoyu2ilO7tYkFzA23bNGd7FVww+YjOQPcYP5U9JI5VLRurgEglTnkdRXPWMjImmqNuHvrgHKg95Dxnp+FMtRfQ6ZfXkN5sEM8zrD5alWAYkhjjPPPQio9p1fa/5f5kqo+x01FYwnu73VDDFcm3g+zxzfKilsknjkH/ACKrajqrQSyTW+oSyeXKqmFbbdF1AKl9vB/4EKpzS3/roN1Ulc6KislHvLrWLyEXbRW8BjICIpJyuSMkHj9eagTULp7a3tfMxfG5MEr7R0XlmxjHK4/OhTX9ethuaRu0UUVZYUUUUAFFFFABRRRQAUUUUAFR2/8Ax7Rf7g/lUlR2/wDx7Rf7g/lQBJRRRQBg6x/x+j/cH9az60NY/wCP0f7g/rWfWi2M3ucZNqOrpaatqa6sqR2V1JGltJAm11U8LnAOTnHWugutYNpDDIdPvpzJH5jC3i3BPqSRz7Vn6V4ctlvL+7v9Pha4e8kkidwG+QnKn2/nUOsaXqF5rMhe1ku7KSJVhAvDCkLdywByfwzR0X9dBdX/AF1NOfxFYwW1lcATSx3ufJ8qPcWOM4x1yen1pbjWzbwRSnS9SfehcokIJjA/vc4z7Amsyy0e+ht/DiPCM2TP5/zj5cqQO/PPpSaxpeoXmsyF7WS7spIlWEC8MKQt3LAHJ/DNN76AvM05/EVlDbWU6rPMl7nyRFHuLHGcY657VU/4S+12TYsNSMluf38YgG6Ierc4x9CelQWWj30Nv4cR4RmyZ/P+cfLlSB3559Knj0y8W48RsYflvAPIO4fP+7x68c+tD0vYF0uXrrXbW3itXjSe6e6XfDFbpudlxnODjA5HWqV/4nSHR4720t5pWadYGjaPDRtuAYMMjB7D3xWddeHrl7XR5nsjdNa2ggmtluPKbOByGBA4IPerEmizf8I40Vlpn2Wf7Ulx9me58wuVYH75JAJA9aHa/wDXf/IRpza9FBFb7rK9NxOCVtVjBlAHUkZwB+PekfxJYR6bFft5wiebyCvl/Oj85DL1yMds1l6vpV1qN1Z6nJpjSssTRS2YuvLdecgh1IB+me9POjS/2VYxWumm1K6hHcSwtceYQoPLFieeMcChf194zoLO6N5biY289vkkbJ1Ct9cZNLd3cNjbtcXDFYl+8wQtj8ganpCAylWAIIwQe9AGZaeItLvrhbe2uTJK3RRE/wDhxWpVHT9IstLaVrSEIZWyx6/gPar1ABRRRSAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAfGcSKc47dcf1H+ex6G1VWM4kU5x264/qP89j0NqgDw+vpGvm6vpGlIuIUUUVBQUUUUAUJdL33sl1Fe3Nu8iqriPZg4zj7yn1pbzSob+K3S4klYwsG3ZAL+objGD3xir1FTyonkRUurBLqWOYSywTxghZYiAcHqDkEEfUUg09S1s0k80r27l1ZyMsSCOcD0PbFXKKfKhuKbuVH06CWS7d95+1RiORc8YGen51Ja25tYBEZ5ZtvRpcZA9OAKnooSSd0HKr3KMelQRfZ9ryfuJXmXJHJbdnPHT5jUH9gwbZYxc3QgmcvLCHG1yTk54yB24IrVopckRckexXSzjjvXulLb3jWMr2ABJH86pPoMDxyQ/aboW7uZPJDgKrZzxxnr2JIrVoocUwcIvRleO1jgubi5UuWm2lh1A2jAxWfYW4uNaudT8mWKMoI4xKhQsf4m2nkdFH4VsUUcqun2BxTsFFFFUUFFFFABRRRQAUUUUAFFFFABUdv/wAe0X+4P5VJUdv/AMe0X+4P5UASUUUUAYOsf8fo/wBwf1rPro57CG6lLyFsgY4NRf2Pbesn/fVUpEOLuYNFb39j23rJ/wB9Uf2Pbesn/fVPmQcrMGit7+x7b1k/76o/se29ZP8AvqjmQcrMGit7+x7b1k/76o/se29ZP++qOZByswaK3v7HtvWT/vqj+x7b1k/76o5kHKzBore/se29ZP8Avqj+x7b1k/76o5kHKzBore/se29ZP++qP7HtvWT/AL6o5kHKzBore/se29ZP++qP7HtvWT/vqjmQcrMGit7+x7b1k/76o/se29ZP++qOZByswaK3v7HtvWT/AL6o/se29ZP++qOZByswaK3v7HtvWT/vqj+x7b1k/wC+qOZByswaK3v7HtvWT/vqj+x7b1k/76o5kHKzBore/se29ZP++qP7HtvWT/vqjmQcrMGit7+x7b1k/wC+qP7HtvWT/vqjmQcr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L+gH51oT28FygS4hjlUHcFkUMAfXmpaq3vOQKCTXkFFFFUWFFFFABRRRQAVHb/8AHtF/uD+VSVHb/wDHtF/uD+VAElFFFACDq31paQdW+tLQAUUUUAFFFFABRRRQAUUVFLcRQFRI4Ut0zQNJvREtFFFAgooooAKKa7rGhdzhR1JpI5UmQPGwZT3FA7O1x9FFFAgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA+bq+ka+bq+kauRMQoooqCgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAqO3/49ov8AcH8qkqO3/wCPaL/cH8qAJKKKKAEHVvrS0g6t9aWgAooooAKKKKACsHyFutXljckAseRW9WD5Jn1eWMOUJZvmFRPodWGduZ3toO2vYalHFFIzKxGR7GpNa/1sH0P9Kinik0y5jlDiTdn7w5qTWDue3PqCf5VHRo3WtSEt9NzSuLuK1UGViM9AByagi1W2lcJ86knALDilvriCB498Xmy/wLjpWbqMksgjMtsIeuOeTVyk0YUqMZpXW/n+hsXN3HahTJn5jgYFQvqtqkm3cze6jIqtrPMEB9z/ACp91bQppJKxqCACDjnPFDbu7BCnT5YuXUnv3V9MkdTlSoII+oqHTpkh0zzJDhVY1EhJ8Ptntn/0Ks8M3lwLLuEG4njvzz+NS5a3NYUk4OHZnRW9wlzF5iBtuccjFS02MIsaiMAJj5celOrVHDK19AooooEFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAfN1fSNfN1fSNXImIUUUVBQUUUUAFFYjajcxeJzbvJmzKom3A+V2BIOev8OPxp0+oXH/CR21rE+LYEpKNoO5thbr1GML+dQpr8bEe0Rs0Vmy61DE8uILiSGFtss6ICiHv3ycd8A1FJqksWtSW6RTXMZt0kRIVXjk5OSR7d6OeIOcUa9FZp1KOcWMkMkiLNMUK+WM5AOVbPTBHb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UUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB83V9I183V9I1ciYhRRRUFBRRRQAUVnz6r5V3LbR2V1O0SqzmIJgA5x1YE9D0FWrW5ivLaO4gbdG4yCRikpJ7CUk3YmooqNpdtwkXlyHepO8D5Vxjgn15pjJKKKggu47ia4iQMGgcI2RwSQDx+dFwuT0UUUAFFFQS3ccN1b27Bi85YKQOBgZOaG7A3YnoqCe6SCe3hcMWncopA4BAJ5/KozqCK0KvDMhmmMKhlA5GeevQ4pXQuZFuiiimMKKKKACiiigAooooAKKKKACo7f8A49ov9wfyqSo7f/j2i/3B/KgCSiiigBB1b60tIOrfWloAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA+bq+ka+bq+kauRMQoooqCgooooAw9l4/iDUBazww/uotxkiLn+Lp8w/rVa+tDayaZp6xx3FuRIWW4l2LJJ15wpz1Jxj+VdGI41kaQIodgAzAcnHTJps0ENxGY54kljPVXUMD+BrJ09DN07pnNy2k0Wnw28xRI21FAiQylvLQ/wAO7APr+daBt4bXXbGK3iSKMQTEKgwOq1opZ2sUSxR20KRo29UWMABvUD1qQxo0gkKKZFBCsRyAevNNQsv67WEqf6fnc5KJLX/hGYryIqdQjk2xyA/OH34Cj2x2q+mn2t3e6xJcwrKVkAXfyF/djkeh96v6ZpMNnbQGa3t2uowR5yoCep6HGe9XxFGpcrGgMhy5C/e7c+tQqV46ihT2cvL9f8zl2aa7XRo5oormOS037LiUoryYXr8p3HGeD7mpZLWZNPs7a4ZAp1AKiwyltiHPy7sA8cj6V0D2dtLbrbyW8LwqABGyAqMdOOlCWltHGkaW8SxxtuRVQAKfUDsar2fvXf8AWqYlSdtX0/S3/BMa+jsvtK6fFplrKIYjKRM4jjQE9uDk8dccetVtLkaVPD7M245nAO7PADAc9+BXRTWdrcujz20MrJ91nQMV+melKtvApQrDGDGSUwo+Unrj0zRyO9/63G6b5r/10/yKOpf8hLSf+u7f+i2rFkWB7azS5IELapKGycA8vwfY11bRo7IzorMhypIyVPTj0qM2lsybGt4iuS20oMZPU/jk/nTlC7v/AF0/yHKnzXOeu44bb+2LezCpbCzDOifdSQ7ug6AkYq1cRWdlY28As1nkvGVW3vt8xgM5du/f1+la0dnaxQNBFbQpC2d0axgKc9cjpTpraC4h8maGOWP+46Aj8jS9m0v67t/8APZnKMdml67AiRQJG0e2OCTeiE4zg4H5YrWvLO30o2t9bxrGsMmJ2HVkbglj3IODk+laYs7URNELaERsAGURjBA6Aj2qvqltc3tubSLylhmG2V3Y7lXvtGME49SKTg0rrcSp2TuM0VS9tJeuPnu5DLz2Xoo/75A/OtKmoixoqIMKowAOwp1apWVkaRVlqFFFFMoKKKKACo7f/j2i/wBwfyqSo7f/AI9ov9wfyoAkooooAQdW+tLSDq31paACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAPm6vpGvm6vpGrkTEKKKKgoKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKjt/wDj2i/3B/KpKjt/+PaL/cH8qAJKKKKAEHVvrS0g6t9aWgAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigD5ur6Rr5ur6Rq5ExCiiioKCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACo7f/j2i/wBwfyqSo7f/AI9ov9wfyoAkooooAQdW+tLSDq31paACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAPm6vpGiirkTEKKKKgoKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKjt/wDj2i/3B/KiigCSiiigBB1b60tFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAH/2Q==)

As sanity check I had a look at the org that does work

![image](data:image/jpeg;base64,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Pyt8p6VjFvmuelVpxdLlXTY6CiiitzywooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA8A8Pf8AIzaV/wBfkP8A6GK9/rwDw9/yM2lf9fkP/oYr3+qkTEKKKKkoKKKjimjm3+W2djFG46EdaAJKKKKACimPKkW3ewXewVc9z6UquHLYDfKcHKkflnrQA6iiigAoqoNRhNl9q2ybPKMuNvYe/TPtmrQOQD60k7iuhaKKKYwooooAKKKKACiiigAqOP8A1k3+/wD+yipKjj/1k3+//wCyigCSkb7jfSlpG+430oAWiiigAooooAKKKKAMjWuZLcfX+la9ZGr83NuP89a16lbs3qfw4fMKKKKowCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDwDw9/yM2lf9fkP/oYr3+vAPD3/IzaV/1+Q/8AoYr3+qkTEKKKKkoKybS48p7q2MdwszzyFG+zyFOeh3Yxj8a1qKlxu7id+hzdvbOBbLaW0kF8sbC5laIrubYRyx4f5sEYJqRRBFpRW300+eQiXHmWjEnnknjMmOTwTmugoqeT+v6/EhU7f1/Wpyq2ObYGayDwR3quEW0ZRsKAErGckDPUfpVt7dv3pkt5GtPtu+SIRE708sAfL1IBxxjtW/RQqaX9en+QvZK39ef+ZgR2Qm8tBbOtkbzckTRlQqeWc5U9FLdiB196vaXAbc3sQiMcK3B8pduFClV+77Zz0960aKagl/Xp/kUoJO/9df8AM5z7NcfYkXyJd39mypjac7iVwPr7UNboY7j7DZzQj7HIko8pk3ucbeo+ZuvIz1610dFL2a/r5/5i9mr3/rp/kYOoWscSw2sdhCYmUuXe0afL8DkKRgn+8T2p1jYedLbG9t2fZZRjEq5AfJz1/iH5jNblIRuUg55GODij2avcPZq9zF02KRr7yZQSmnAxRk9y3Q/gmB+NbdRW9tFaxlIlIBJYksWJPqSeSfrUtXFWVioxsgoooplBRRRQAVHH/rJv9/8A9lFSVHH/AKyb/f8A/ZRQBJSN9xvpS0jfcb6UALRRRQAUUUUAFFIzBVLHgAZNc6bu5837RvfYX4G44+lTKVjalRdS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igAooooAKKKKACiiigAooooAKKKKACiiigDwDw9/yM2lf9fkP/oYr3+vAPD3/IzaV/1+Q/8AoYr3+qkTEKjZXEm9NpyMEE4/z1qSipKI903/ADzj/wC+z/hRum/55x/99n/CpKKAI903/POP/vs/4Ubpv+ecf/fZ/wAKkooAj3Tf884/++z/AIUbpv8AnnH/AN9n/CpKKAI903/POP8A77P+FG6b/nnH/wB9n/CpKKAI903/ADzj/wC+z/hRum/55x/99n/CpKKAI903/POP/vs/4Ubpv+ecf/fZ/wAKkooAj3Tf884/++z/AIUbpv8AnnH/AN9n/CpKKAI903/POP8A77P+FG6b/nnH/wB9n/CpKKAI903/ADzj/wC+z/hRum/55x/99n/CpKKAI903/POP/vs/4UsbltwZQCpwcHPYH+tPqOP/AFk3+/8A+yigCSkb7jfSlpG+430oAWiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAPAPD3/IzaV/1+Q/+hivf68A8Pf8jNpX/X5D/wChivf6qRMQoooqSgqn/atp55hLyBhJ5ZYxOE3em7G3P41crItdOaWS4a4lnEX2pnEBChDg5B6bjzz1xUtvmSX9bEybS9016a7hAMhuSBwpPX6VztrZzjVFeZglws7sXFk5Z1JOAZc7cYxx2wKmhsPK0myK2zCczQtKdnz4Dg898D9KmM27aE87102ub1RQTrcIzoCArshz6qSD/KufiiikkPlWkv20XzETiM4CCQ5+fpjGRtz+FTNp4SJblLYi6+37vMCfOEMvPPXbt/CiM27f12/zE5vWy2N+iubtbOcaorzMEuFndi4snLOpJwDLnbjGOO2BThai20a2X7CjvMQJ2lt2mK4BI3IPmbngelJVHa9h8710NyS4SK4hhYNumJCkdBgZ5pGu40uHhKvuRBIdq54JI7c9qx9OgnQ2IeFlWOabgRlAqkHHGTtHoM1NqkEskt4Uidt1sijapOTvPFVzPf8Ara4cz5WzTguEnaZUDAwyeW2e5wDx+dTVzVxbAzahiylN7JPm2m8knHyryHxhRkHPIz71Za2MS6ndfYhNOZiI96E/IVUHHfHXgdcUlN2+Qc7u15/5/wCRuUVzEFnK0V5GsBSCSS3KCG2aBT8/zEKSSDgcnirN9ai1uVtbSJY4b9fJZYwAFI5Jx/ulvyFHO+wlUbV7G9RSKoRQqgBQMADtS1oahRRRQAVHH/rJv9//ANlFSVHH/rJv9/8A9lFAElI33G+lLSN9xvpQAtFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAeAeHv8AkZtK/wCvyH/0MV7/AF4B4e/5GbSv+vyH/wBDFe/1UiYhRRRUlBRRRQAUUUUAMiiSFSsa4BYsee5OT+pp9FFABRRRQAUUUUAFFFFABUP2WL7V9pKsZcbQSxIUewzgfhU1FABRRRQAUUUUAFRx/wCsm/3/AP2UVJUcf+sm/wB//wBlFAElI33G+lLSN9xvpQAtFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAeAeHv+Rm0r/r8h/8AQxXv9FFVImIUUUVJQUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAVHH/rJv9/8A9lFFFAElI33G+lFFAC0UUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB//2Q==)

I then tripple checked against Yanga's org

![image](data:image/jpeg;base64,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AKdFXPskP91v++z/AI0fZIf7rf8AfZ/xoAp0Vc+yQ/3W/wC+z/jR9kh/ut/32f8AGgCnRVz7JD/db/vs/wCNH2SH+63/AH2f8aAKdFXPskP91v8Avs/40fZIf7rf99n/ABoAp0Vc+yQ/3W/77P8AjR9kh/ut/wB9n/GgDxnwD/yO2n/9tP8A0W1e214l4B/5HbT/APtp/wCi2r22qluTHYKKKKkoKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKRWDDIOeSPyoAWiikZgqlmICjkk0ALRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUH222/57x/99Ufbbb/nvH/31QBPRUBvbUDJuIwB1O4U77VB/wA9U/OgDxfwD/yO2n/9tP8A0W1e214l4B/5HbT/APtp/wCi2r22qluTHYKKKKkoKKKo2+prPH5xtpobcgnzpWQL/wChZ/SldXsJtIvUVG88MRIklRCFLkMwGFHU/SmC+tGg89bqAwkkCQSDbx70XQXRPRVKXVrCGGKZruHypX2I4kBUn65qWe6EJt8KHE0gQEHpkE59+lHMg5kWKKz21e3jnjWZ44Y3jZ/MklUAEMBjrjv69qtSXlrEqtJcworDKlnAyPah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kcd3FtR0aKMwlxkjn5srjj1zUsti48OPZQrIz+SVVZWXd9CRx+XFalFNQSuPkV2+5j3VpcG4aVLfzQLxJgu4DKiMDIyeufWmixnnnE8ltsV7xZjExUlQExk4OM5x0z2raopKCX9en+QOCf8AXr/mYd/b6lc3MiBZfKEqMmwxCMqCpO7Pz7uvTA6VYGn7rXUkkURmeVnV8+w2t+BFalRzQRXEZjniSVDyVdQw/I0cm4civf8Arr/mUdG8yW0N7OAJro7yB2GMKB7YGfxrSo6DAoq0rIqKsrBUcH+rP++3/oRqSo4P9Wf99v8A0I0DJKRun4ilpG6fiKAFooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAIp4EuITG+dp9O1UxpbhdgvJBH/AHf8mtGik0maRqyirJkNtbR2sWyMH1JPU0txD58Dxbtu4YzipaKLaWJ5nzc3UgtLf7LAIt27BznGKnoop7CbcndhRRRQIKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDxLwD/wAjtp//AG0/9FtXtteJeAf+R20//tp/6LavbaqW5MdgpjSojbSST6AE/wAqfUcf+sm/3x/6CKkoPPT0k/79t/hR56ekn/ftv8KkooAj89PST/v23+FHnp6Sf9+2/wAKkooAj89PST/v23+FHnp6Sf8Aftv8KkooAj89PST/AL9t/hR56ekn/ftv8KkooAj89PST/v23+FHnp6Sf9+2/wqSigCPz09JP+/bf4UeenpJ/37b/AAqSigCPz09JP+/bf4UeenpJ/wB+2/wqSigCPz09JP8Av23+FHnp6Sf9+2/wqSigCPz09JP+/bf4UeenpJ/37b/CpKKAI/PT0k/79t/hRDny+QRlmPI9SakooAKRun4ilpG6fiKAFooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAPEvAP/I7af/20/wDRbV7bXiXgH/kdtP8A+2n/AKLavbaqW5MdgqOP/WTf7/8A7KKkqOP/AFk3+/8A+yipKJKybXXo7mW3V7K7gjuWKQTS7CrsATj5WJHCk8gVrVh6Roi2VjFK8bm+RWKiad5EjY5+6CxVev8ADjikBoxapp85mEN/ayGAZmCTKfL/AN7B46d6bJrGlwxNJLqVmkayeWzNOoAf+6Tnr7Vzi6brN28kt1Hclzp08BSZoABI2zATy+dpwfvEnjt307+DUoksrexSeO2WIo/2QQ70YYC/63I24znAJ6UwNO41OwtI1e5vbaBGAKtLKqgg9MZNLBqFlc3ElvBeW8s0Yy8ccqsyj3AORWPpOk3Nstj9ogXdDpv2djlThsjI4+npio7XRrtNL0e38sQSQWDwSMpH7t2RR268jt6UPRN/11/r5gtzWk1vTEtrq4+32zx2oJnKSq2z2ODwfal/tnSxaxXLajaLDMcRyNMoVj6A55Nc5b6FeyWFxBKL8Trp0lpEZ2t/J+YAYXywGxkDG4Dip72x1G5uIbxYdRhVrX7NJbwG1LrySc+ZldpGOhzwMj0H/X4h0/ryOjkvbSKZIZLqFJXIVEaQBmJ6ADvUFzqS2128Lx5VLczl94Xo2Mc4H4k1V0nTDY30shjfZ9kt4EklKlzs3ZBx35HtUetafdXcl0YIt4ksWhX5gMuWBxyaf2rf1sK75blqPW7P+0LiynnggmjmEUaSTANLlFbIB/3sd+lWnv7OOcQPdwLMc4jaQBuBk8deAQfpWDfWN87a5bR6cZBqTAR3AdAqDylXLZIbggkYBP0q39ivbYa5PaxJ9quHVoGbB3gRIoz+Ibg/ypdCupoQanp91C01vfW00SsEZ45lZQx6AkHryKfb39ndqzW13BMqjJMcgYAZIzx7g/ka5kaRqN0b97mK5lS4W1VVu2g3kJKxYER4XGD7k/pV3xDbym6tRbNte9BspQDg+WfmLD3UBsf71DEb8ciTRLLE6vG4DKynIYHoQadSIixoqIoVVGAB2FLQAUUUUAFFFFABSN0/EUtI3T8RQAtFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB4l4B/5HbT/+2n/otq9trxLwD/yO2n/9tP8A0W1e21UtyY7BUcf+sm/3/wD2UVJUZRg5ZHA3dQVyKkokoqPE3/PSP/vg/wCNGJv+ekf/AHwf8aAJKKjxN/z0j/74P+NGJv8AnpH/AN8H/GgCSio8Tf8APSP/AL4P+NGJv+ekf/fB/wAaAJKKjxN/z0j/AO+D/jRib/npH/3wf8aAJKKjxN/z0j/74P8AjRib/npH/wB8H/GgCSio8Tf89I/++D/jRib/AJ6R/wDfB/xoAkqL7Lb/AGr7V5EX2grsMuwb9vpnrj2pcTf89I/++D/jRib/AJ6R/wDfB/xoAkoqPE3/AD0j/wC+D/jRib/npH/3wf8AGgCSio8Tf89I/wDvg/40Ym/56R/98H/GgCSio8Tf89I/++D/AI0sTF0y2MgkHHscUAPpG6fiKWkbp+IoAWiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA8S8A/wDI7af/ANtP/RbV7bXiXgH/AJHbT/8Atp/6LavbaqW5MdgoooqSgoorPt9WSd4c21xFHMSscj7drEZ44YkdD1ApNpOwm0tzQoqBL21kaRUuYWaLmQLICU+vpSLe27yKkcschLFDsdTtIGcHnOfpRdBdFiioI721nkMcNzDJIBuKJICQPXAqKx1K2vo49k0XnMgdoRICy59R1oug5kXKKgS9tZGkVLmFmi5kCyAlPr6U19RsY0Lve26qG2FjKoAb069aOZBdFmiq4uw18tuoBVofNDhuDyB/WmC+X7RNEyY8uRYwdw5LAHvj16cmi6C6LdFUrLVLe8wnmxJPuYeT5gLYViM469s1Kb+zXfm7gGwbnzIPlGcZPpzRzK1wUk1csUVAL21MAnFzCYWziTzBtOOvPTsaVbq3eHzluImizjeHBX86LoLomooopjCiiigAqOD/AFZ/32/9CNSVHB/qz/vt/wChGgCSkbp+IpaRun4igBaKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDxLwD/yO2n/9tP8A0W1e214l4B/5HbT/APtp/wCi2r22qluTHYKKKKkoKytO0lYLSMyLILkK2C0rOEJzyoJIHXtWrRUuKbuxWV7nN2+lXS23lSi7aSK2eJCzQ+UxIxxtAbng8/jWm9o4fTfLjAS3J3gEfKPLIH6mtGikoJJkRppf1/XYwNNinnttKAs/KS3XeZSy4YFSMKAc85ycgVMmnTrb6TGsexoAwkII+TMZH48ntWwiLGioihVUYCgYAFLRyK1mEaaRzdvpV0tt5Uou2kitniQs0PlMSMcbQG54PP41euYr2OO1htUkWFY9reR5e5W4x9/jb16ZNa1FHs1YFTSVl/X9WMnTLK4t3tTMmPLtPKY7gcNuBxxRNZ3DXcjrHlTdRSA5H3VABNa1FPlWnl/ncfIrW/raxhQWd15UFq1mY/LuzOZty7cby3Y5yQcdPxqVLa8tdJWOCIrKbh3kEewvtLscjd8ucY61sUUlBJW/rp/kHs1+hh2mnXOUNxGzf6cZyZChbb5eATtwM59P/r0+W3ZteFuuPs8m26kHoy8D8ztP/ATWzUccEMTO0cSI0h3OVUAsfU+tHJawvZq1iSiiirNAooooAKjg/wBWf99v/QjUlRwf6s/77f8AoRoAkpG6fiKWkbp+IoAWiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA8S8A/8jtp//bT/ANFtXtteJeAf+R20/wD7af8Aotq9tqpbkx2CiiipKCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACo4P9Wf99v/AEI1JUcH+rP++3/oRoAkpG6fiKWkbp+IoAWiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA8S8A/8AI7af/wBtP/RbV7bXiXgH/kdtP/7af+i2r22qluTHYKKKKkoKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKjg/1Z/32/wDQjUlRwf6s/wC+3/oRoAkpG6fiKWkbp+IoAWiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA8S8A/wDI7af/ANtP/RbV7bRRVS3JjsFFFFSUFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFRwf6s/77f8AoRoooAkpG6fiKKKAFooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/9k=)

NEXT I will try to figure what is supposed to add parameters into the new org
I THINK if I add the logical: Location speed monitoring

Let's see...
When should Logicals be made available... I can't find a way to make this available.
I even looked at events and peripherals ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/30_f.png?v=v81) Thought they might trigger something.

I think THIS should be made availble for the above mentioned param to work:
device id="-2231271351705479521" type="130" systemName="System.Logical.LocationSpeedMonitor"

## Have available

- Make switch available
- ![[MIX3K-9 FM PTO Switch.png]]
- Then the Event FM Pto Engaged
- ![[MIX3K-9 FM PTO Engaged.png]]
- Missing parameters is usually: device that should still be made available or peripheral

## Potential issues

- Diff is FM PTO violation not available
- Justus tried making: FM3607 available

- (FM3607i) When making the required events available, SQL client complaints about: The transaction associated with the current connection has completed but has not been disposed.
- The error Yanga showed was the exact same thing.
- (M2310i) Also gets to MakeAvailableHelper.MakeRequiredEventsAvailalble (As above), but the issue is regarding "All required parameters for this event have not been satisfied"
- The only difference with an old org and this new org  Event library> FM PTO Violation is available

## 07

Paul peripherals

```sql
--PERIPHERALS ??
SELECT distinct dmd.[DeviceKey]
      ,dmd.[Description]
      ,dl.Name
      ,dl.[Description]
      ,dd.SystemName
      ,lpd.[Description]
  FROM [DeviceConfiguration].[definition].[MobileDevices] dmd
  JOIN [DeviceConfiguration].[definition].[MobileDeviceLines] dmdl on dmdl.MobileDeviceKey = dmd.DeviceKey
  JOIN [DeviceConfiguration].[definition].[Lines] dl on dl.LineKey = dmdl.LineKey
  JOIN [DeviceConfiguration].[definition].[NewDeviceLines] dndl on dndl.LineKey = dmdl.LineKey and dndl.MobileDeviceKey = dmdl.MobileDeviceKey
  JOIN [DeviceConfiguration].[definition].[Devices] dd on dd.DeviceType = dndl.DeviceType
  JOIN [DeviceConfiguration].[definition].[MobileDeviceLinePeripheralDevices] mdlpd on mdlpd.LineKey = dmdl.LineKey and mdlpd.MobileDeviceKey = dmdl.MobileDeviceKey
  JOIN [DeviceConfiguration].[library].[Devices] ld on ld.devicekey = dd.DeviceKey
  JOIN [DeviceConfiguration].[library].[PeripheralDevices] lpd on lpd.LibraryDeviceKey = ld.LibraryDeviceKey
  where dmd.Description in ('MiX3000', 'MiX4000') and ld.LibraryKey = -1
  order by dmd.[Description]
      ,dl.[Name]
      ,dl.[Description]
```

libraryMobileDevice.AvailableLines > 0

```sql
--LINES
SELECT dmd.[DeviceKey]
      ,dmd.[Description]
      ,dl.Name
      ,dl.[Description]
  FROM [DeviceConfiguration].[definition].[MobileDevices] dmd
  JOIN [DeviceConfiguration].[definition].[MobileDeviceLines] dmdl on dmdl.MobileDeviceKey = dmd.DeviceKey
  JOIN [DeviceConfiguration].[definition].[Lines] dl on dl.LineKey = dmdl.LineKey
  where dmd.Description in ('MiX3000', 'MiX4000')
  order by dmd.[Description]
      ,dl.[Name]
      ,dl.[Description]
```

## 20230306 Current Notes

On the following date stamp Yanga confirmed that it was working:
February 15, 2023 at 12:51 PM
I will now compare that code base to what is currently on DEV to find the change.

I used git graph to get the reference number at the time it was tested.
I then used Gitlens: Compare with Reference
	Paste the reference
	Select the branch, DEV, you want to compare against


Herewith what I could see.
- DB: DevicesData: ELD, SLC, M2K (small) Doesn't seem relevant to the issue.
- BE: ONly the template part - think only white space... why empty??

## Message to Zonika and Justus

Hi, I am just letting both of you know about the issue I found regarding the MiX3K.
The reason is, it is not just the MiX3K :-D

Yesterday I could finally get to debug from my machine to DEV.
I could see that there are no peripherals on the MiX3K device template while being created.
I then made the one, which I previously successfully made available, unavailable.
When I tried to make it available, it now gives the same issue on DEV than it had on INT.

I tried a few queries to get to the bottom of this, seeing it worked well on DEV.
I thought it could be:
1) Data that has been removed, so I've been investigating DevicesData.xml
2) Logic that has been merged out, don't think I've found anything yet, but it could still be.

This morning I had a fantastic idea :-) I thought, let's test the MiX4K, seeing they share most of the code.
The MiX4K also can't be made available anymore on INT.
It fails in the same place... 
MobileDeviceHelper.UpdateLineDetails
With this error
Sequence contains no matching element

Reason, we are trying to update peripheral information, but the template has no peripherals.

Both the INT MiX4K and DEV MiX3K used to work.
So something changed...
Either data or logic.

So back to you... I will continue this investigation, however, I know, Justus, you were also heavily involved in the MiX4K.
So just in case we start running out of time, I might need to pull you in to help find what is now missing :-o
Maybe a fresh set of eyes could be good :-)
But let's chat again next week.

I just wanted to ensure both of you know about this.
Cheers
Marthinus






## It currently breaks here, for both DEV and INT

- On INT a 4K can also NOT be made available
	- Sequence contains no matching element
	- In MobileDeviceHelper.UpdateLineDetails
- [x] Debugging a 4K on DEV shows that the peripherals are also empty???
- [x] 

- It might actually break AFTER This - when I run the below I actually do get a value - so I think it is the line below this one.
- [x] What changed.... as this used to work perfectly on DEV when tested before.

```sql
SELECT TOP (1) [Extent1].[LibraryMobileDeviceLineId] AS [LibraryMobileDeviceLineId],[Extent1].[DefinitionEquivalentLineId] AS [DefinitionEquivalentLineId],[Extent1].[CanRecordInterval] AS [CanRecordInterval],[Extent1].[IsRequiredToBeConnected] AS [IsRequiredToBeConnected],[Extent1].[DefinitionLineId] AS [DefinitionLineId],[Extent1].[LibraryMobileDeviceId] AS [LibraryMobileDeviceId],[Extent1].[Name] AS [Name],[Extent1].[EquivalentLineName] AS [EquivalentLineName],[Extent1].[RedirectedLineName] AS [RedirectedLineName],[Extent1].[RedirectedLineCanRecordInterval] AS [RedirectedLineCanRecordInterval],[Extent1].[RedirectedLineId] AS [RedirectedLineId]
FROM   [dynamix].[LibraryMobileDeviceLines] AS [Extent1]
WHERE  ( [Extent1].[DefinitionLineId] = 401558247868188484/* @p__linq__0 */ )
       AND ( [Extent1].[LibraryMobileDeviceId] = 3671331967614438961/* @p__linq__1 */ )
```

## Testers

Branch to point current int to dev: Config/MR/MR_Point_To_Dev
defaultTemplateResult.MobileDeviceDefaultTemplateId -222206921271976143


Org? 3Js Test Org 9
![[MIX3K-9 MiX3000 OB1 GPS Module not available.png]]

### Issue on INT

```log
EXCEPTION! <?xml version="1.0" encoding="utf-16"?> <ApiRequestInfo xmlns:xsd="[http://www.w3.org/2001/XMLSchema"](http://www.w3.org/2001/XMLSchema%22 "http://www.w3.org/2001/xmlschema%22") xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance">](http://www.w3.org/2001/XMLSchema-instance%22> "http://www.w3.org/2001/xmlschema-instance%22%3e") <RequestId>1365476049096933376</RequestId> <AuthToken>18028024-39f2-4762-921a-66e221f6407a</AuthToken> <AccountId>6636789966604390213</AccountId> <RequestJson>{"Rows":[{"Id":"7197747763929409291","Description":{"Title":"AT 1330 (Wireless Trailer Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"2441784980668833294","Description":{"Title":"AT 1340 (Wired Trailer Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-276206128280422867","Description":{"Title":"AT SAT EMS TAM (Satellite Trailer Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"2144530432827431759","Description":{"Title":"bioWatch Integrated device","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"5646852502041998355","Description":{"Title":"Digital Matter","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"6365161075736078749","Description":{"Title":"FM 1000 (FM100)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-1840564510281932398","Description":{"Title":"FM 2000 (FM200 Plus)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-4778860267039095909","Description":{"Title":"FM 2000HV (FM200 Plus HV)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-5858009722316757743","Description":{"Title":"FM 2001 (FM200 CAN)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"4650434075306181696","Description":{"Title":"FM 2100 (FM200 Locator)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-7990768985497297820","Description":{"Title":"FM 2100HV (FM200 Locator HV)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"3527221626955903837","Description":{"Title":"FM 2300 (FM200 Communicator)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-2584440882719714179","Description":{"Title":"FM 2300HV (FM200 Communicator HV)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"6009028139816724904","Description":{"Title":"FM 3106","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-8283040575705223110","Description":{"Title":"FM 3200/3210 (FM300 ComLink-GSM)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-2638857266241007532","Description":{"Title":"FM 3201/3211 (FM300 CAN ComLink)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"6710364014173584261","Description":{"Title":"FM 3300/3310 (FM300 Communicator)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-90599922128129323","Description":{"Title":"FM 3301/3311 (FM300 CAN Communicator)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-2135111653303591150","Description":{"Title":"FM 3305/3315 (J1708)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-9096330589235079600","Description":{"Title":"FM 3306/3316","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"873035855993834515","Description":{"Title":"FM 3316i (Tracer)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-1815797007298898523","Description":{"Title":"FM 3507i/3517i","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-3755124825869787037","Description":{"Title":"FM 3516i (Tracer)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"5885262600288608221","Description":{"Title":"FM 3607i/3617i","Disabled":false},"Availability":"Available","Actions":["Edit","MakeUnavailable"]},{"Id":"-3090910092652161951","Description":{"Title":"FM 3616i (Tracer)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"2805417112665854608","Description":{"Title":"FM 3707i/3717i","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-1322568839943127374","Description":{"Title":"FM 3716i (Tracer)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-5694385571636989860","Description":{"Title":"FM 3807i/3817i","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-5604407714490286122","Description":{"Title":"FM Tracer","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"7691569724904501690","Description":{"Title":"FM200","Disabled":false},"Availability":"Available","Actions":["Edit","MakeUnavailable"]},{"Id":"-3492265442579611717","Description":{"Title":"Ford OEM","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"697324896487352644","Description":{"Title":"G52S Solar Tracker","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"6255387638305918612","Description":{"Title":"Hino OEM","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"2674807441444838784","Description":{"Title":"Integrated device","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-7586695067651916356","Description":{"Title":"Lommy Container Asset Tracker","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-280588544043133793","Description":{"Title":"MiX Tabs Beacon","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-4791134254654685492","Description":{"Title":"MiX2000","Disabled":false},"Availability":"Available","Actions":["Edit","MakeUnavailable"]},{"Id":"295341957383281927","Description":{"Title":"MiX2310i","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-5678077773610990815","Description":{"Title":"MiX3000","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"6183256567829462590","Description":{"Title":"MiX4000","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-7681409220681262334","Description":{"Title":"MiX6000","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"7771696109990054209","Description":{"Title":"MiX6000 LTE","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-7688187356053930045","Description":{"Title":"Mobile Phone","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-4029035978948561278","Description":{"Title":"Navistar OEM","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"1421721680027030859","Description":{"Title":"Oyster","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-7102029466465232301","Description":{"Title":"Phone TDI","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-2638134262001887069","Description":{"Title":"PT MOB (Mobile Phone Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-8531853140595275914","Description":{"Title":"PT SAT SPOT (Satellite Personnel Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"797324896487352744","Description":{"Title":"Remora","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"3399630737658112808","Description":{"Title":"Scania OEM","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"2227837975127546318","Description":{"Title":"Stellantis OEM","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-1064000195705392069","Description":{"Title":"Streamax Standalone","Disabled":false},"Availability":"Available","Actions":["Edit","MakeUnavailable"]},{"Id":"4006004756113529772","Description":{"Title":"Teltonika","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-2238903845732144759","Description":{"Title":"Track and Trace","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"5256236074733439636","Description":{"Title":"VT 1300/1310 (Vehicle Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"532730660579366356","Description":{"Title":"VT 1305 (OBDII Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"5320300317076768302","Description":{"Title":"VT 1330 (Motorcycle Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"2438460409495893683","Description":{"Title":"VT DUO GT 900 (GSM/Satellite Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-8352356955919268735","Description":{"Title":"VT SAT EMS 202 (Satellite Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-9165723886842271533","Description":{"Title":"VT SAT GT 340 (Satellite Track and Trace)","Disabled":true},"Availability":"","Actions":["MakeAvailable"]},{"Id":"-7892022077469569738","Description":{"Title":"Yabby","Disabled":true},"Availability":"","Actions":["MakeAvailable"]}]}</RequestJson> <RequestUrl>POST [http://integration.mixtelematics.com:80/DynaMiX.API/config-admin/1674691381001506210/modile_device_types/-5678077773610990815</RequestUrl>](http://integration.mixtelematics.com:80/DynaMiX.API/config-admin/1674691381001506210/modile_device_types/-5678077773610990815</RequestUrl> "http://integration.mixtelematics.com/dynamix.api/config-admin/1674691381001506210/modile_device_types/-5678077773610990815%3c/requesturl%3e") </ApiRequestInfo> Exception Type: System.Exception EXCEPTION! Sequence contains no matching element Exception Type: System.InvalidOperationException Stack trace at System.Linq.Enumerable.Single[TSource](IEnumerable`1 source, Func`2 predicate) at DynaMiX.Logic.ConfigAdmin.LibraryLevel.DefaultTemplateOverrides.MobileDeviceHelper.UpdateLineDetails(IMobileDeviceManager mobileDeviceManager, String authToken, Int64 orgId, LibraryMobileDeviceLine libraryLine, PeripheralDevice overridePeripheralDevice, IMobileDevice mobileDevice, Boolean doTacho, Nullable`1 assetId) in D:\b\3\_work\304\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\MobileDeviceHelper.cs:line 120 at DynaMiX.Logic.ConfigAdmin.LibraryLevel.DefaultTemplateOverrides.MiX3000Model.UpdateLines(IDefaultTemplateResult defaultTemplateResult) in D:\b\3\_work\304\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\MiX3000Model.cs:line 296 at DynaMiX.Logic.ConfigAdmin.LibraryLevel.DefaultTemplateOverrides.MiX3000Model.Update(IDefaultTemplateResult defaultTemplateResult) in D:\b\3\_work\304\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\MiX3000Model.cs:line 287 at DynaMiX.Logic.ConfigAdmin.LibraryLevel.LibraryMobileDeviceManager.MakeLibraryMobileDeviceAvaialble(String authToken, Int64 orgId, Int64 mobileDeviceId, Int64 correlationId) in D:\b\3\_work\304\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryMobileDeviceManager.cs:line 323 at DynaMiX.Api.NancyModules.ConfigAdmin.LibraryLevel.LibraryMobileDevicesModule.MakeAvailableForLibrary(String authToken, Int64 orgId, Int64 mobileDeviceId) in D:\b\3\_work\304\s\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs:line 124 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__1(Object args) in D:\b\3\_work\304\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in D:\b\3\_work\304\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 282 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\b\3\_work\304\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 191 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\b\3\_work\304\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 121
```

## CODE

Zonika had to merge this in to ensure the logical is hidden on integration to safeguard incorrect deployment of this logic.
[Pull request 77851: MiX3K-77 - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/77851?_a=files)

- [x] Core Int
- [x] BE INT: (pull in INT nuget next... (> 2.2.1) (MiX.DeviceIntegration.Common), 
- [x] BE INT: then get all MIX3K-9: USE commits since 1 Feb?)

![[MIX3K-9 Last DEV Merge.png | 300]]

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| BE     | COMMON |
| ------ | ------ |
| DEV    | DEV    |
| !! INT | !! INT | 

## Branch
Config/MR/Bug/MIX3K-9MiX3000DefaultConfigGroup.23.01.ORI


## Testing

- INT
	- orgId=-8386191436408769566

## Logz

```log
[OpenSearch Dashboards - Logz.io](https://app.logz.io/#/dashboard/osd/discover/?switchToAccountId=157279&_a=(columns:!(message),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:AppName,negate:!f,params:(query:DynaMiX.Api),type:phrase),query:(match_phrase:(AppName:DynaMiX.Api))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:Env,negate:!f,params:(query:DEV),type:phrase),query:(match_phrase:(Env:DEV))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:!('MiX3K%20%3E%20Default'),type:phrases,value:'MiX3K%20%3E%20Default'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(message:'MiX3K%20%3E%20Default'))))))),index:'logzioCustomerIndex*',interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&accountIds=true)
```

## Firmware Version

```sql
USE DeviceConfiguration;

SELECT
  *
FROM definition.FirmwareVersions dfv
  LEFT JOIN library.FirmwareVersions lfv ON lfv.FirmwareVersionKey = dfv.FirmwareVersionKey
  --LEFT JOIN library.Libraries ll ON ll.LibraryKey = ll.LibraryKey
  LEFT JOIN [definition].[FirmwareTypes] dft on dft.firmwaretype = dfv.firmwaretype
--
WHERE dft.[Name] = 'MIX3000'
--AND ll.LibraryKey = -1
--AND ll.GroupId = -5785682803802374635

--Select Distinct firmwaretype from definition.FirmwareVersions
```

[14:01] Paul Roux
Hi daar, ek is nie seker wie dit laai en mergetool loop - moes nogals extensive cahnges maak om mergetool te laat werk met M3K. Check bietjie met Jacques wie die tool gebruik om firmware available te maak.

[14:59] Jacques Van Wyk
jis, daar is 'n tool gebruik word om FW te laai na MiX.Connect op die environment, waarma dit met 'n merge tool na MFM gemerge word - [How is firmware uploaded and made available in DynaMiX? - Device Integration Team - MiX Telematics Confluence](https://confluence.mixtelematics.com/pages/viewpage.action?pageId=79200552 "https://confluence.mixtelematics.com/pages/viewpage.action?pageid=79200552")

Martin Rademeyer > Johan Grobbelaar > Donovan se span > Granville

## How does FW upload to Environment (eg Dev)

[15:52] Granville Volkwyn
we use a tool, upgrade monitor to load on respective server

How to view this:
api.connect.devices.comms.dev.int.priv/firmware/mix3000/versions
![[Pasted image 20230130162044.png]]

After this a ==merge tool== is used, currently being investigated by Zonika.
- [x] TODO: MR: This then also writes this into the DB?

## How do the FW versions get into the template

![[MIX_FE#Mobile Device Templates Features and Settings Image]]




![[Config_Tempates_MobileDevices_FW.excalidraw]]

## Views

![[MiX3K Default Templates.excalidraw]]

![[Make Device Available.excalidraw]]

## First Succeeded Defaults

![[MiX3K-9 MiX3000 First Default success]]


## Currently failing here

- Goes through all the way to UPDATE the model
- Then into MobileDeviceHelper.UpdateDeviceDetails
	- UpdateLogicalDevice << Fails here

"EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>\r\n<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\r\n <RequestId>1352334867854884864</RequestId>\r\n <AuthToken>9a504506-ebb0-4c85-a8a9-5c5c062a5924</AuthToken>\r\n <AccountId>2904277068424365252</AccountId>\r\n <RequestJson>{\"Rows\":[{\"Id\":\"7197747763929409291\",\"Description\":{\"Title\":\"AT 1330 (Wireless Trailer Track and Trace)\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"2441784980668833294\",\"Description\":{\"Title\":\"AT 1340 (Wired Trailer Track and Trace)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-276206128280422867\",\"Description\":{\"Title\":\"AT SAT EMS TAM (Satellite Trailer Track and Trace)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"2144530432827431759\",\"Description\":{\"Title\":\"bioWatch Integrated device\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"5646852502041998355\",\"Description\":{\"Title\":\"Digital Matter\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"6365161075736078749\",\"Description\":{\"Title\":\"FM 1000 (FM100)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-1840564510281932398\",\"Description\":{\"Title\":\"FM 2000 (FM200 Plus)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-4778860267039095909\",\"Description\":{\"Title\":\"FM 2000HV (FM200 Plus HV)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-5858009722316757743\",\"Description\":{\"Title\":\"FM 2001 (FM200 CAN)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"4650434075306181696\",\"Description\":{\"Title\":\"FM 2100 (FM200 Locator)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-7990768985497297820\",\"Description\":{\"Title\":\"FM 2100HV (FM200 Locator HV)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"3527221626955903837\",\"Description\":{\"Title\":\"FM 2300 (FM200 Communicator)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-2584440882719714179\",\"Description\":{\"Title\":\"FM 2300HV (FM200 Communicator HV)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"6009028139816724904\",\"Description\":{\"Title\":\"FM 3106\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-8283040575705223110\",\"Description\":{\"Title\":\"FM 3200/3210 (FM300 ComLink-GSM)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-2638857266241007532\",\"Description\":{\"Title\":\"FM 3201/3211 (FM300 CAN ComLink)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"6710364014173584261\",\"Description\":{\"Title\":\"FM 3300/3310 (FM300 Communicator)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-90599922128129323\",\"Description\":{\"Title\":\"FM 3301/3311 (FM300 CAN Communicator)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-2135111653303591150\",\"Description\":{\"Title\":\"FM 3305/3315 (J1708)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-9096330589235079600\",\"Description\":{\"Title\":\"FM 3306/3316\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"873035855993834515\",\"Description\":{\"Title\":\"FM 3316i (Tracer)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-1815797007298898523\",\"Description\":{\"Title\":\"FM 3507i/3517i\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-3755124825869787037\",\"Description\":{\"Title\":\"FM 3516i (Tracer)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"5885262600288608221\",\"Description\":{\"Title\":\"FM 3607i/3617i\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-3090910092652161951\",\"Description\":{\"Title\":\"FM 3616i (Tracer)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"2805417112665854608\",\"Description\":{\"Title\":\"FM 3707i/3717i\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-1322568839943127374\",\"Description\":{\"Title\":\"FM 3716i (Tracer)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-5694385571636989860\",\"Description\":{\"Title\":\"FM 3807i/3817i\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-5604407714490286122\",\"Description\":{\"Title\":\"FM Tracer\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"7691569724904501690\",\"Description\":{\"Title\":\"FM200\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-3492265442579611717\",\"Description\":{\"Title\":\"Ford OEM\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"697324896487352644\",\"Description\":{\"Title\":\"G52S Solar Tracker\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"6808165154651063642\",\"Description\":{\"Title\":\"GoSafe G79B OBDII Asset Tracker\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"6255387638305918612\",\"Description\":{\"Title\":\"Hino OEM\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"2674807441444838784\",\"Description\":{\"Title\":\"Integrated device\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-7586695067651916356\",\"Description\":{\"Title\":\"Lommy Container Asset Tracker\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"6952149829812879284\",\"Description\":{\"Title\":\"Lommy Eye Asset Tracker\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-280588544043133793\",\"Description\":{\"Title\":\"MiX Tabs Beacon\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-4791134254654685492\",\"Description\":{\"Title\":\"MiX2000\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"295341957383281927\",\"Description\":{\"Title\":\"MiX2310i\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-5678077773610990815\",\"Description\":{\"Title\":\"MiX3000\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"6183256567829462590\",\"Description\":{\"Title\":\"MiX4000\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-7681409220681262334\",\"Description\":{\"Title\":\"MiX6000\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"7771696109990054209\",\"Description\":{\"Title\":\"MiX6000 LTE\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-7688187356053930045\",\"Description\":{\"Title\":\"Mobile Phone\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-4029035978948561278\",\"Description\":{\"Title\":\"Navistar OEM\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"1421721680027030859\",\"Description\":{\"Title\":\"Oyster\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-7102029466465232301\",\"Description\":{\"Title\":\"Phone TDI\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-2638134262001887069\",\"Description\":{\"Title\":\"PT MOB (Mobile Phone Track and Trace)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-8531853140595275914\",\"Description\":{\"Title\":\"PT SAT SPOT (Satellite Personnel Track and Trace)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"797324896487352744\",\"Description\":{\"Title\":\"Remora\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"3399630737658112808\",\"Description\":{\"Title\":\"Scania OEM\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"2227837975127546318\",\"Description\":{\"Title\":\"Stellantis OEM\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-1064000195705392069\",\"Description\":{\"Title\":\"Streamax Standalone\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"4006004756113529772\",\"Description\":{\"Title\":\"Teltonika\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"-2238903845732144759\",\"Description\":{\"Title\":\"Track and Trace\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"5256236074733439636\",\"Description\":{\"Title\":\"VT 1300/1310 (Vehicle Track and Trace)\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"532730660579366356\",\"Description\":{\"Title\":\"VT 1305 (OBDII Track and Trace)\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]},{\"Id\":\"5320300317076768302\",\"Description\":{\"Title\":\"VT 1330 (Motorcycle Track and Trace)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"2438460409495893683\",\"Description\":{\"Title\":\"VT DUO GT 900 (GSM/Satellite Track and Trace)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-8352356955919268735\",\"Description\":{\"Title\":\"VT SAT EMS 202 (Satellite Track and Trace)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-9165723886842271533\",\"Description\":{\"Title\":\"VT SAT GT 340 (Satellite Track and Trace)\",\"Disabled\":true},\"Availability\":\"\",\"Actions\":[\"MakeAvailable\"]},{\"Id\":\"-7892022077469569738\",\"Description\":{\"Title\":\"Yabby\",\"Disabled\":false},\"Availability\":\"Available\",\"Actions\":[\"Edit\",\"MakeUnavailable\"]}]}</RequestJson>\r\n <RequestUrl>POST http://config.dev.mixtelematics.com:80/DynaMiX.API/config-admin/-5785682803802374635/modile_device_types/-5678077773610990815</RequestUrl>\r\n</ApiRequestInfo>\r\n\tException Type: System.Exception\r\nEXCEPTION! Sequence contains no matching element\r\n\tException Type: System.InvalidOperationException\r\n\tStack trace at System.Linq.Enumerable.Single[TSource](IEnumerable`1 source, Func`2 predicate)\r\n at DynaMiX.Logic.ConfigAdmin.LibraryLevel.DefaultTemplateOverrides.MobileDeviceHelper.UpdateLogicalDevice(IMobileDevice mobileDevice, List`1 logicalDevices) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\LibraryLevel\\DefaultTemplateOverrides\\MobileDeviceHelper.cs:line 34\r\n at DynaMiX.Logic.ConfigAdmin.LibraryLevel.DefaultTemplateOverrides.MobileDeviceHelper.UpdateDeviceDetails(String authToken, Int64 orgId, IMobileDeviceManager mobileDeviceManager, IMobileDevice mobileDevice, List`1 logicalDevices, Nullable`1 assetId) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\LibraryLevel\\DefaultTemplateOverrides\\MobileDeviceHelper.cs:line 22\r\n at DynaMiX.Logic.ConfigAdmin.LibraryLevel.DefaultTemplateOverrides.MiX3000Model.UpdateMobileDeviceTemplate(IDefaultTemplateResult defaultTemplateResult) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\LibraryLevel\\DefaultTemplateOverrides\\MiX3000Model.cs:line 332\r\n at DynaMiX.Logic.ConfigAdmin.LibraryLevel.DefaultTemplateOverrides.MiX3000Model.Update(IDefaultTemplateResult defaultTemplateResult) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\LibraryLevel\\DefaultTemplateOverrides\\MiX3000Model.cs:line 293\r\n at DynaMiX.Logic.ConfigAdmin.LibraryLevel.LibraryMobileDeviceManager.MakeLibraryMobileDeviceAvaialble(String authToken, Int64 orgId, Int64 mobileDeviceId, Int64 correlationId) in C:\\Projects\\DynaMiX.Backend\\Logic\\DynaMiX.Logic\\ConfigAdmin\\LibraryLevel\\LibraryMobileDeviceManager.cs:line 321\r\n at DynaMiX.Api.NancyModules.ConfigAdmin.LibraryLevel.LibraryMobileDevicesModule.MakeAvailableForLibrary(String authToken, Int64 orgId, Int64 mobileDeviceId)\r\n at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__1(Object args) in D:\\b\\1\\_work\\501\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 530\r\n at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in D:\\b\\1\\_work\\501\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 282\r\n at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\\b\\1\\_work\\501\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 191\r\n at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\\b\\1\\_work\\501\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 121\r\n",

## Canvas

![[MIX3K-9 MiX3000 Default Config Group.canvas]]

## Next Steps

- Add TODO in each section
- Comment out adding events to see what comes back, maybe connected lines are OK
- Then start adding above back
- Issue:
	- The underlying provider failed on Open
	- MSSQL

## Test things

- orgId=-8386191436408769566
- 
- 
LogicalDevices.Select(l => l.Id)
{System.Linq.Enumerable.WhereSelectListIterator<DynaMiX.Logic.ConfigAdmin.LibraryLevel.DefaultTemplateOverrides.LogicalDevice, long>}
    [0]: 2661058860026395155
    [1]: 4999121101837382283
    [2]: 9156217035291766525
    [3]: -5215845406465777006
    [4]: 1618831221688219249
    [5]: 295760960565509331
md.AllLogicalDevices.Select(al => al.Id)
{System.Linq.Enumerable.WhereSelectListIterator<DynaMiX.Entities.ConfigAdmin.ResolvedConfig.MobileDevice.ILogicalDevice, long>}
    [0]: -5991987314035575920
    [1]: -3566764828759052896
    [2]: 245949043241004492
    [3]: 7645187414593512429
    [4]: 8229662367751201484
    [5]: -7120044127992149675
    [6]: -8783179421342699278
    [7]: 8121416456359775759
    [8]: 7107045948579795262
    [9]: -8709978633653011982
    [10]: 4716645204465568025
    [11]: 5068191268329964832
    [12]: 5628658113909693511
    [13]: -2243780433957331639
    [14]: 2575691700371665727
    [15]: 4573130331941967482
    [16]: 3807873984308136537
    [17]: 4275336323133878561
    [18]: -8562127990928065994
    [19]: -6925164128939969281
    [20]: -6665688648233671807
    [21]: -688634501335128018
    [22]: 1348834277464933408
    [23]: -1670549615287393638
    [24]: -6971527142410953980
    [25]: 3363602118421337150
    [26]: 1691033636513247479
    [27]: 1798023239388552707
    [28]: -4209401609173198932
    [29]: -5336098631222420570
    [30]: -8729414642406316566
    [31]: -1933089640650207976
    [32]: -700229962652845388
    [33]: -8577745165041540777
    [34]: -2201485418311237662
    [35]: -5872302477552389647
    [36]: 3242621342930497014
    [37]: -5526863240252243819
    [38]: 8106176744145799978
    [39]: 4707702282391108928
    [40]: 5390451388808945705
    [41]: 3086809412204198364
    [42]: -8639252705276813775
    [43]: -5997874582404414102
    [44]: -5986643088847829727
    [45]: 8260098526561045507
    [46]: -1875243592491830802
    [47]: 6256751136942193751
    [48]: -1597388312975191365
    [49]: 8203707827334536064
    [50]: -5289330123446651522
    [51]: -7395519303285603530
    [52]: 1560918500220966693
    [53]: 3790876496522796295
    [54]: 8342175507732708376
    [55]: 3577382431742791736
    [56]: -3783820521066872052
    [57]: 6210840319104125317
    [58]: 2169682505801523107
    [59]: 5117422937346019523
    [60]: 1447466761284180307


## AC Cleanup Script

![[AC Cleanup Script]]

## IT currently creates

- Default event template for MiX3000
	- Blank
- Default mobile device template for MiX3000
	- Device
		- ![[Pasted image 20221118112539.png]]
	- Connected lines
		- ![[Pasted image 20221118112253.png]]
- Default configuration group for MiX3000

## Chat with Peter Futter

- I put the list of default connections on the ticket as well as the events that should be added to the default event template.
- From the peripheral perspective yes it will be a very similar to the 4000 but with a few differences. but no differences between what was done for the device and what needs to gone in the mobile device template

## XML

- Device (as per MiX4000)
	- Base mobile device feature set: ~~Remove or~~ hide **Ignition wired** (it will be a virtual connection, e.g. data traffic on CAN)
	-   Location speed monitoring  **-** available but checkbox **unticked**
	-   Require Company ID on driver plug  **- Not supported, can be removed**
	-   Engine hours **-** available but checkbox **unticked**
	-   Magix **-** available but checkbox **unticked**
	-   GSM jamming detection **-** available but checkbox **unticked**
	-   [not originally speced] Private mode plug **- Not supported, please remove**
- Lines
	-   C1 - As per MiX 4000 - Yellow and Green twisted pair
	-   C2 - As per MiX 4000 - Yellow/black and Green/black twisted pair
	    -   If C2 is connected with a script, set C3 to "Not Connected". Setting to be sent to unit (story tbc)
	-   C3 - New - Yellow/Red and Green/Red twisted pair
	    -   Icon (see below) <i class="icon-wire-c3"></i>
	    -   If C3 is connected with a script, set C2 to "Not Connected". Setting to be sent to unit (story tbc)
	-   Speed - Same icons as MiX 4000
	-   RPM - Same icons as MiX 4000
	-   Fuel - Same icons as MiX 4000
	-   I1 - Same as MiX 4000 - White/Violet
	-   I2 - Same as MiX 4000 - White/Red
	-   O1/S1 - Red
	    -   If O1 is connected, set S1 to "Not Connected"
	-   S1/O1 - Same icons as MiX 4000
	    -   If S1 is connected, set O1 to "Not Connected"
	-   OB1 = GPS Icon: <i class="icon-gps"></i>
	-   OB2 = GSM Icon: <i class="icon-mbs"></i>
	-   OB3 = 3D Icon: <i class="icon-tachometer"></i>
	-   OB4 = BT Icon: <i class="icon-bluetooth"></i> - [~~BDI-12~~](https://jira.mixtelematics.com/browse/BDI-12 "DI Config: Create new OB4 line for MiX4000") / [~~BDI-11~~](https://jira.mixtelematics.com/browse/BDI-11 "DI Config: New Bluetooth Peripheral")
	-   SP1
	- [x] Only 1 C line can be used. If one is used, the others must be disconnected.
	- [x] Default template uses C1 and C3???

### Device
(As 4k)
- [x] Base mobile device feature set: ~~Remove or~~ 
- [x] hide **Ignition wired** (it will be a virtual connection, e.g. data traffic on CAN)
- [x]  Location speed monitoring  **-** available but checkbox **unticked**
- [x]  Require Company ID on driver plug  **- Not supported, can be removed**
- [x]  Engine hours **-** available but checkbox **unticked**
- [x]  Magix **-** available but checkbox **unticked**
- [x]  GSM jamming detection **-** available but checkbox **unticked**
- [x]  [not originally speced] Private mode plug **- Not supported, please remove**

### Differences between 4000 and 3000

![[Pasted image 20221118145142.png]]

### Connected lines
- [x] C1 - Dynamic CAN peripheral
- [x] Speed - J1708/CAN - Speed
- [x] RPM - J1708/CAN - RPM
- [x] Fuel - J1708/CAN - Fuel
- [x] GPS - GPS module
- [x] GSM - GSM module

### 4k Connected Lines

![[Pasted image 20221118135105.png]]

### Event Template
(Same events as the MiX4000 Default event template (standard offering))
- [x] Battery disconnected, System
- [x] Diagnostic trouble code, System
- [x] Driver door open, System
- [x] Driver seatbelt not engaged, System
- [x] Driver side rear door open, System
- [x] End of trip fuel tank level percentage, System
- [x] End of trip state of charge, System
- [x] Engine coolant temperature high, System
- [x] Engine light (MIL) on, System
- [x] Engine Oil level low, System
- [x] Engine Oil Pressure low, System
- [x] FM PTO engaged, System
- [x] Harsh acceleration, System
- [x] Harsh braking, System
- [x] Idle, System
- [x] Idle - excessive, System
- [x] Over revving, System
- [x] Over speeding, System
- [x] Passenger door open, System
- [x] Passenger seatbelt not engaged, System
- [x] Passenger side rear door open, System
- [x] Possible impact, System
- [x] Possible impact when parked, System
- [x] Possible Rollover, System
- [x] Start of trip fuel tank level percentage, System
- [x] Start of trip state of charge, System

### 4k Events

![[Pasted image 20221118134246.png]]

# MIX3K-9 MiX3000 Default Config Group

## Image

![[MiX3K Default Templates.excalidraw]]

## Previous Stories

- AC-248
- 

## Background Image

![[AC-163 SPIKE CAN Config Group#Image]]

## Background Description


![[AC-163 SPIKE CAN Config Group#From Story]]


## Description of what is needed here

-   Settings (XML):  
	- Ensure we have the correct Peripherals info JIRA:MIX3K-62
		- Eg. AC-254
	- Ensure we have the correct Mobile Device Settings JIRA:MIX3K-63
		- Eg. AC-255
	- Ensure we have the correct Events info (only the connected ones need to be considered) JIRA:MIX3K-64
		- Eg. AC-256
	- Description for above:
		- These libraries will need to be set up in order to get the device and event templates' info.  
		- Mostly like the MiX4000 
		- More specific info on the story
		- Some of this might already be there 
-   BE Logic:
    -   **BE: Not just Track & Trace.**  JIRA:MIX3K-65
	    - Eg. AC-248
	    - Change code to also include MiX3k
	    - A good place to get started is here:  
	    - ..DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs  
	    - The MakeAvailableForLibrary method
    -   **BE: Connect Lines.** JIRA:MIX3K-66
	    - Eg. AC-249
	    - Auto connect parts might need enhancements due to eg. more than one CAN script being available.
	    - Specify the defaults to use, based on device type. (Currently, it seems to use the first available option.)
	    - Moving average speed filter duration - 3 seconds might be different from Mobile Device template settings.
    -   **BE: Additional Events.** JIRA:MIX3K-67
	    - Eg. AC-265
	    - Add additional events through code.
	    - Basically we will add them as we will do for connecting lines to specific peripherals.
    -   **BE: Missing Create Templates Code.** JIRA:MIX3K-68
	    - Eg. AC-250
	    - There might be code required in the creation of the mobile device template.   
	    - It might need little work for the event template.   
	    - The config group template should most likely work as-is.
	    - CreateMobileDeviceTemplate
	    - AddMobileDeviceAvailableLines
	    - AutoConnect
	    - ValidateAndFixConnections
	    - 
    -   **BE: Missing Get Device Template Info.** JIRA:MIX3K-69
	    - Eg. AC-251
	    - It might be that we will need to cater for logic here, to incorporate any new properties or fields not previously considered.
    -   **BE: Missing Get Event Template Info.** JIRA:MIX3K-70
	    - Eg. AC-252
	    - Ensure all actions, conditions and parameters are pulled in, otherwise handle this with code.
	- BE: Retrofit App JIRA:MIX3K-71
		- We wrote a retro-fit app to cater for organisations that already has MiX4000 templates enabled.
		- We need to enhance this to also include the logic for a MiX3000.
	- BE: Make unavailable JIRA:MIX3K-72
	- BE: Logic for cameras JIRA:MIX3K-73

-   Database Scripts:  
	- To be done last
	- Used for Organisation that already has MiX3000 made available.  
	- These default templates will need to be retro-fitted.  
	- Most likely done as DB Scripts, which can be run as post-deployment scripts.  
	- This will duplicate the creating of templates code
		- **Script: Get Device Template Info.** [Story]
			- Eg. AC-260
			- Lot's of tables make part of the device.
			- See above mentioned story.
		- **Script: Get Event Template Info.** [Story]
			- Eg. AC-261
			- A few tables form part. 
			- See above mentioned story.
		- **Script: Connect Lines.** [Story]
			- Eg. AC-262
			- Auto connect lines via stored procs
		- **Script: Create Mobile Device Template.** [Story]
			- Eg. AC-257
			- It will make use if the device info and connect lines to create the mobile device template via stored procs
		- **Script: Create Event Template.** [Story]
			- Eg. AC-258
			- This will be done, after getting all the event info, to create the event template using stored procs.
		- **Script: Create Config Group.** [Story]  
			- Eg. AC-259
			- Once we created the mobile device template and events template, we can use those ids to create the config group by making use of stored procs.
		- **Script: Post Deployment Scripts.** [Story]
			- Eg. AC-263
			- This will basically put all the previous scripts generated into a Post Deployment Script.

-   Testing:
    -   **Regression Test Make Available.** JIRA:MIX3K-74

