---
created: 2023-10-12T15:41
updated: 2024-03-05T12:26
---
JIRA:CONFIG-3508

## Description

As per [https://csojiramixtelematics.atlassian.net/browse/QM-802#icft=QM-802](https://csojiramixtelematics.atlassian.net/browse/QM-802#icft=QM-802) the use of [[DynaMiX.Services.API]] needs to stop.  Currently the [[GPRS]] Server is still calling the /[[largefiletransfer]]/lft/ controller.  Corresponding endpoints are needed on an alternative API. Move it to [[DynaMiX.DeviceConfig]]

## Visual overview


## Code Search

file:///C:/Projects/SearchResults/_Large_Transfer_.code-search

## Mappings

- Excel: https://mixtelematics-my.sharepoint.com/:x:/p/marthinus_raath/EQIxuipwPR9Huj74M0059GABI0yiZBDdnkjmbYpAwHMz-w?e=XAwF3K
- 

## Swagger

- [Swagger UI (mix.local)](http://api.deviceconfig.configdev.mix.local/swagger/ui/index#/)
- 

## Tests

- [x] JIRA:CONFIG-3899 ✅ 2023-11-13
- [x] JIRA:CONFIG-3902 ✅ 2023-11-13
- [x] JIRA:CONFIG-3903 ✅ 2023-11-13
- [ ] JIRA:CONFIG-3919
	- Connected to INT DB:
	- ![[Config-3508 Testing Large file transfer for Pallavi RequestPart.png|400]]
	- 
- [x] JIRA:CONFIG-3923 ✅ 2023-11-13
- [x] JIRA:CONFIG-3924 ✅ 2023-11-13
- [x] JIRA:CONFIG-3940 ✅ 2023-11-13
- [x] JIRA:CONFIG-3953 ✅ 2023-11-13
- [x] JIRA:CONFIG-3959 ✅ 2023-11-13
- [x] JIRA:CONFIG-3960 ✅ 2023-11-13
- [ ] JIRA:CONFIG-3966
- [x] JIRA:CONFIG-3967 ✅ 2023-11-13

## Chat to Pallavi

Off Dynamix.api
To Config.api

BE:
LArgeTransferModule
	Endpoints
		Client
		Config API
		Unit Tests
		
LargeTransferManager


Testing:
DB, what data
Simple testing
Not checked correct work or not

- Transfer (save) - diff tables
- Download - diff tables

Comms calls this function
C++ class

NEed to change call from Fleet
Not using exactly from ours
Timothy

Config.Api
LArgeFile
(DEV BRANCH)
LargeFileTransferController
Has all end-points
> Man > Repo (2x, Transfer, Download)

Entity: Core


## Second Pallavi Chat

Hi there. Let me know if you don't have access to the repository, then I'll give you access.

I see the GPRS service mostly uses the LargeFileTransferClient in this file:
[LargeFileMessageDirector.cpp - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Comms/_git/FMSSComms?path=/Comms/GPRSService/LargeFileMessageDirector.cpp "https://dev.azure.com/mixtelematics/comms/_git/fmsscomms?path=/comms/gprsservice/largefilemessagedirector.cpp")

And the client code is in this project:
[LargeFileTransferClient - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Comms/_git/FMSSComms?path=/Comms/LargeFileTransferClient "https://dev.azure.com/mixtelematics/comms/_git/fmsscomms?path=/comms/largefiletransferclient")

This is from martin lottering . You need to ask him for access to this file.

Asked [[Martin Lottering]],
He said ask: [[Paul Putter]], anders [[Farhaad Bux]] vra.

## Comms team needs

Paul Putter: 

Config Team to provide this endpoint:

This is hardcoded so it would be great if we could keep it the same:
_baseUrl = "http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/"

The above is used like this:
public bool NotifyState(int fileTransferId, LargeFileTransferStatus status)
{ RestCalls rest = new RestCalls(_baseUrl + "notify/"); return rest.NotifyState(fileTransferId, status); }

## These are the different calls used:

```txt
_baseUrl = "http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/"
The above is used like this:
public bool NotifyState(int fileTransferId, LargeFileTransferStatus status)

These are the different calls used:
RestCalls rest = new RestCalls(_baseUrl + "notify/");
RestCalls rest = new RestCalls(_baseUrl + "pending/");
RestCalls rest = new RestCalls(_baseUrl + "getinprogress/");
RestCalls rest = new RestCalls(_baseUrl + "newfileavailable/");
RestCalls rest = new RestCalls(_baseUrl + "getnextfilepart/");
RestCalls rest = new RestCalls(_baseUrl + "getstatus/");
RestCalls rest = new RestCalls(_baseUrl + "storefilepart/");
RestCalls rest = new RestCalls(_baseUrl + "getpendingdownloads/");
```


Jira link: https://csojiramixtelematics.atlassian.net/browse/FC-796?focusedCommentId=79255

BE: file:///C:/Projects/DynaMiX.Backend/Services/Api/DynaMiX.Services.Api.LargeFileTransfer.Client/LargeFileTransfer.cs




## Going forward

Write a test app to test new against old
OLD: ? DynaMiX.Services.Api.LargeFileTransfer.Client
Test Uri: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/

### Error

Required attribute 'MiX4000LatestFirmwareVersion' not found.

Line 39:     <dynamix.config_admin ConfigAdminConnectionString="Data Source=DSINTSQL01;Initial Catalog=DeviceConfiguration;Integrated Security=SSPI;Persist Security Info=False;Application Name=ConfigAdmin;MultipleActiveResultSets=True" PlugDataRootFolder="D:\PlugData\" LegacyCompilersPath="D:\Legacy\" PulsUsername="xt21E3O2Vvr+qgJ7UsJP8w==" PulsPassword="yz4+gXUk5JKwcnRjZWGECgVUpz4qAyPYqbgH9FueGE0=" PulsUrl="https://puls.calamp.com/service" DmiPath="D:\Dmi2\" PlugToolVersionFile="D:\inetpub\Static\MiX.Plugs.ManagementUtility\version" StandalonePlugToolVersionFile="D:\inetpub\Static\MiX.Plugs.ManagementUtility\standalone_version" MiX2000CommsApiUrl="http://api.m2k.int.development.domain.local/" DDDServiceApiUrl="http://ghos.int.development.domain.local/MiX.DDD.Web.Api/" ConfigServicesApiServerUrl="http://api.deviceconfig.int.development.domain.local" DMTCommsServerUrl="http://api.dmt.int.development.domain.local/" DynamicCanServerUrl="https://dynamic-can-api.integration.mixtelematics.com/" CanDynaMixApiUsername="rootuser@mixtel.com" CanDynaMixApiPassword="dynamix_is_awesome" CanDynaMixApiUrl="http://mfm.int.development.domain.local/DynaMiX.Services.API/" DaylightSavingsCommandDelay="50" RunDaylightSavingsCommand="true" RunToday="false" RunAtTimeLocal="00:00:01" />


### Requests

- GetPendingFileTransfers
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/pending
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/file-transfer-types/{type}/pending-file-transfers
	- Old Client: GetPendingFileTransfers
		- rest.GetPendingFileTransfers
		- Count: 36
	- New Client: RequestPendingList
		- Count: 36
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)
- RequestTransfersInProgress
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/getinprogress
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/file-transfer-types/{type}/transfers-in-progress
	- Old Client: GetTransfersInProgress
		- Findings: Count 5
	- New Client: RequestTransfersInProgress
		- Findings: Count 5
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)
- RequestStatus
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/getstatus
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/transfer-ids/{fileTransferId}/request-status
	- Old Client: GetFileTransferStatus
		- Findings: 5170: CompletedSuccess
		- Findings: 2418: CancelledPending
	- New Client: RequestStatus
		- Findings: 5170: CompletedSuccess
		- Findings: 2418: CancelledPending
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)
- RequestPendingDownloads
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/getpendingdownloads
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/file-transfer-types/{type}/pending-file-transfers
	- Old Client: GetPendingDownloads
		- Findings: Count 16 (Some VehicleIds: 37,15501,801,700,806)
	- New Client: RequestPendingDownloads
		- Findings: Count 16 (Some VehicleIds: 37,15501,801,700,806)
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)
- NotifyState
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/notify
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/transfer-ids/{fileTransferId}/status/{status}/notify-state
	- Old Client: NotifyState
		- Get a value, set to something else, test, set back to original, test
		- Findings: 2418: CancelledPending > Notified > CancelledPending
	- New Client: NotifyState
		- Get a value, set to something else, test, set back to original, test
		- Findings: 2418: CancelledPending > Notified > CancelledPending
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)
- GetNextFilePartToDownload
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/getnextfilepart
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/transfer-ids/{fileTransferId}/max-part-size/{maxPartSize}/next-file-part-to-download
	- Old Client: GetNextFilePartToDownload
		- Findings: Offset: 0, Partsize: 256, Status: InProgress
	- New Client: GetNextFilePartToDownload
		- Findings: Offset: 0, Partsize: 256, Status: InProgress
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (I am not 100% sure if I tested it to the full, however, overall this works fine)
- NewFileAvailable
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/newfileavailable
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/new-file-available
	- Old Client: NewFileAvailable
		- Findings: Could add the new file and add content
	- New Client: NewFileAvailable
		- Findings: Could add the new file and add content
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)
- StoreFilePart
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/storefilepart
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/store-file-part
	- Old Client: StoreFilePart
		- Findings: Could add the new file and add content
	- New Client: StoreFilePart
		- Findings: Could add the new file and add content
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)
- [x] RequestPart ✅ 2024-03-05
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft: NA
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/transfer-ids/{fileTransferId}/offset/{offset}/block-size/{blockSize}/pad-byte/{padByte}/request-part
	- Old Client: RequestPart
		- Findings: The byte value is the same, but the old client uses a memory pointer.
	- New Client: RequestPart
		- Findings: The byte value is the same. Doesn't use a memory pointer.
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **NOT SURE** (Should this return memory pointers as per the old code?)
- UpdateProgress
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft: NA
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/transfer-ids/{fileTransferId}/offset/{offset}/update-progress
	- Old Client: UpdateProgress
		- Findings: Successfully set the offset to 777 then 888
	- New Client: UpdateProgress
		- Findings: Successfully set the offset to 777 then 888
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)
- [x] GetTransferStatuses ✅ 2024-03-05
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft: NA
		- NEW CLIENT: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/org-ids/{orgId}/org-timezone-info/{orgTimeZoneInfo}/transfer-statuses
		- **NEW API**: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/transfer-statuses
	- Old Client: NA
		- Findings: NA
	- New Client: GetTransferStatuses
		- Findings: FAILED - Couldn't reach the API as the URIs between the Client and the API are inconsistent
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **FAIL** (Failed, because of inconsistent URI between Client and API, couldn't compare with a non-existing older client)
- CancelFile
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft: NA
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/large-file-transfer/transfer-ids/{fileTransferId}/cancel-file
	- Old Client: NA
		- Findings: NA
	- New Client: CancelFile
		- Findings: Successfully set the status from 0 to 4 (CancelledPending)
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **PASS** (Overall this works fine)

### TEMPLATE

- XXXX
	- Uri: NOT as per Comms request
		- OLD: http://localhost/DynaMiX.Services.Api/largefiletransfers/lft/XXXX
		- NEW: http://localhost/DynaMiX.DeviceConfig.Services.API/api/XXXX
	- Old Client: XXXX
		- Findings: xxxx
	- New Client: XXXX
		- Findings: xxxx
	- INFORMATION: I have notified Pallavi regarding the difference in URIs
	- **XXXX** (Overall this works fine)

## Final Questions:

- [x] Should the URIs be the same for old and new? ✅ 2024-03-04
- [x] Should the new RequestPart make use of memory pointers as the old one does? ✅ 2024-03-04
- [x] GetTransferStatuses: Client URI and API are not the same ✅ 2024-03-05

Some final thoughts on testing Large File Transfers:
- Should the URIs be as per Comms request? As it is not.
- Some of the method signatures are different in the new client from the old client, will comms be OK with this?
- Should RequestPart make use of memory pointers as per the old way? (Or is the byte array OK)
- GetTransferStatuses failed as the Client and API URI are not the same.

## Testing info

### NewFileAvailable and StoreFilePart

- ![[CODE Large File Transfer NewFileAvailable and StoreFilePart]]
- ![[SQL Large File Transfer NewFileAvailable and StoreFilePart]]

### UpdateProgress

- ![[SQL Large File Transfer UpdateProgress]]
- ![[CODE Large File Transfer UpdateProgress]]

### Cancel

- ![[SQL Large File Transfer Cancel]]


## TEST

- Actual FW upgrades on ROVIs
- 