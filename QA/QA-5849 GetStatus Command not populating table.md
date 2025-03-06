---
status: closed
date: 2023-06-19
comment: 
priority: 8
---

# QA-5849 GetStatus Command not populating table

Date: 2023-06-19 Time: 10:24
Parent:: [[Command]]
Friend:: [[2023-06-19]]
JIRA:QA-5849 GetStatus Command not populating table
[QA-5849 QA - 3000 - Diagnostic Page - GetStatus Command - not appearing on "DeviceConfiguration.DataProcessing" table when opening diagnostic page - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-5849)

## Branch

- xxxxxxxxxxxxxxxxxxxxxxxxx.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## PRs

- 

## Description

Database name: MiX3000
orgId=7263018081657095762
id=1387200051102040064
IMEI: 862096048024496

The getstatus command populates the diagnostic page for the asset.

Replication steps: Navigate to the asset on the assets page, on the the drop down select Diagnostics,

Run the attached query make sure to fill in the mobileunitid that you will use.

## Notes

- /diagnostics/MiX3000/config/0
	- /diagnostics/{device}/config/
		- BE: GetDiagnosticsConfig
		- public static readonly RouteDefinition GetDiagnosticsConfig = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/assets/organisations/{orgId}/{assetId}/diagnostics/{device}/config/{statusPendingRequestId}", Constants.HTTPVerbs.GET);
			- DeviceConfigClient.MobileUnits.GetDiagnosticsConfigDetails
			- Client: mobile-units/{mobileUnitId}/diagnostics-config-details
				- API: GetDiagnosticsConfigDetails
				- deviceConfigRepo.GetMobileUnitConfigGroupStatus
					- EF: mu.ConfigurationStatus
- /diagnostics/MiX3000/asset/0
	- /diagnostics/{device}/asset/

## Boodskap aan Zonika

Re  QA-5849. Ek dink ek mis wat jy sien :-)
So die FE roep GetDiagnosticsConfig op die BE. (assets/organisations/{orgId}/{assetId}/diagnostics/{device}/config/{statusPendingRequestId)
Die BE roep dan GetDiagnosticsConfigDetails op die client.
Die client roep dan die end-point op die API. (mobile-units/{mobileUnitId}/diagnostics-config-details)
Dit roep dan die repo method GetMobileUnitConfigGroupStatus.
Wat EF gebruik om mu.ConfigurationStatus te return.

Ek't gedink miskien roep 3K iets anders as 4K.
Maar as ek daai deel van die Diagnostics refresh roep 3K en 4K dieselfde end-point... in die Networks tab (/diagnostics/{device}/config/)
MAAR ek mag iets mis? :-)

## Devices to test

- 4K
	- https://integration.mixtelematics.com/#/asset/diagnostics/MiX4000?id=1405657160572604416&orgId=-7950239061577934052&device=MiX4000&modal=true
	- https://config.dev.mixtelematics.com/#/asset/diagnostics/MiX4000?id=1355302833787355136&orgId=3222089765699420885&device=MiX4000&modal=true
		- https://config.dev.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/3222089765699420885/1355302833787355136/diagnostics/MiX4000/config/0
		- 
- 3K
	- https://integration.mixtelematics.com/#/asset/diagnostics/MiX3000?id=1405594814812758016&orgId=-7950239061577934052&device=MiX3000&modal=true
	- https://config.dev.mixtelematics.com/#/asset/diagnostics/MiX3000?id=1171605900751024128&orgId=3222089765699420885&device=MiX3000&modal=true
		- https://config.dev.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/3222089765699420885/1171605900751024128/diagnostics/MiX3000/config/0



## SQL Used

```sql
-- Messages in DP
USE  [DeviceConfiguration.DataProcessing]
SELECT CreationDateUtc, MessageId, MessageSubType, 
CASE WHEN MessageSubType = 1 Then 'PositionRequest'
WHEN MessageSubType = 45 Then 'UpdateAssetTimezoneDeviation' 
WHEN MessagesubType = 101 Then 'GetStatus'
WHEN MessagesubType = 102 Then 'SendConfiguration'
WHEN MessagesubType = 103 Then 'SendFirmware'
WHEN MessageSubType = 104 Then 'SetOdometerOffset'
WHEN MessageSubType = 105 Then 'SetEngineHoursOffset'
WHEN MessageSubType = 109 Then 'SendRebootRequest'
WHEN MessageSubType = 254 Then 'SendConfig'
WHEN MessageSubType = 255 Then 'SendSettings'
END AS [MessageSubType], MessageStatus,
CASE WHEN MessageStatus = 2 Then 'Pending' 
WHEN MessageStatus = 11 Then 'Rejected' 
WHEN MessageStatus = 13 Then 'Acknowledged' 
WHEN MessageStatus = 22 Then 'Created' 
WHEN MessageStatus = 23 Then 'Sent Awaiting Response' 
WHEN MessageStatus = 25 Then 'MiX.Connect Message Complete' 
WHEN MessageStatus = 26 Then 'MiX.Connect Message Failed' 
WHEN MessageStatus = 27 Then 'MiX.Connect Message Cancelled' 
END as [Message Status], MessageType,ExpiryDateUtc, MessageStatusDateUtc, Value, ParamsJson
FROM state.MobileUnitMessage (NOLOCK)
WHERE  MobileUnitId IN (4Kid, 3Kid) 
--AND MessageSubType IN (104,105)
ORDER BY CreationDateUtc DESC

--Messages in Teltonika
USE [MiX.Connect.Teltonika]
SELECT top 5 * 
FROM dbo.Commands
WHERE IMEI = 867060033914892
```