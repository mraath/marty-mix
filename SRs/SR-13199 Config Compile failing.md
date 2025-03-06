Date: 2022-07-12 Time: 11:23
Friend: 
JIRA:SR-13199
[SR-13199 MiX 4000 - Configuration Compiler failed - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-13199)

# SR-13199

## Image


## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Lang  | UI    | BE    | Client | API   | Common | DB    |
| ----- | ----- | ----- | ------ | ----- | ------ | ----- |
| 22.6  | 22.6  | 22.6  | 22.6   | 22.6  | 22.6   | 22.6  |
| Local | Local | Local | Local  | Local | Local  | Local |

## Branch
Config/MR/Bug/SR-13199.xx.xx.ORI

## Learned

MiXConnectMessageSender Line 87
```c#
if (pendingTimezoneUpdate != null)
{
	pendingTimezoneUpdate.UserName = username;
	SendTimeZoneUpdateCommand(commsProxy, pendingTimezoneUpdate); 
	//TODO: MR: Think the above lineis the error - add a line above that to force groupId
}
```


[state].[MobileUnitMessage_GetMessageDetails]
Doesnt return a groupId, I will replace this with muc.

## Description

AsserID: 986728078122885120
Unique Identifier: 359159974771959

2022-07-04 09:58:49 Thread[14] Generation failed for (986728078122885120) - VW Caddy 2020 (KA870JI)
2022-07-04 09:59:50 EXCEPTION! **GMTOffset not found for this group id: 0**, UnitIdentifier:359159974343866, commandId: UpdateAssetTimezoneDeviation
	Exception Type: DynaMiX.DeviceConfig.Common.Exceptions.ServerSideException
	Stack trace    at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.HandleErrorCodes(Uri uri, String requestUrl, JsonResponse response) in F:\_Sources\DynaMiX\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 60
   at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.DoPost(String url, Object body, RequestParameter[] parameters) in F:\_Sources\DynaMiX\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 148
   at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitCommandsProxy.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3)
   at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitCommandsProxy.UpdateMobileUnitConfiguration(String authToken, Int64 groupId, Int64 mobileUnitId)
   at MiX.UnitConfiguration.GenerationService.UnitConfigurationService.UpdateMobileUnitConfigurationViaDis(IBuildContext context, Int32 threadId, Int32 retryCount) in D:\b\1\_work\2938\s\Services\Configuration Generation\MiX.UnitConfiguration.GenerationService\UnitConfigurationService.cs:line 337
   at MiX.UnitConfiguration.GenerationService.UnitConfigurationService.DoWork(Object workItem) in D:\b\1\_work\2938\s\Services\Configuration Generation\MiX.UnitConfiguration.GenerationService\UnitConfigurationService.cs:line 267


## Test case

GMTOffset not found for this group id: 0 >>

GMTOffset not found for this group id: 0, UnitIdentifier:359588160340718, commandId: UpdateAssetTimezoneDeviation
	throw new System.Exception($"{ErrorMessages.ConfigAdmin.GMTOFFSET_NOT_FOUND}: {muc.GroupId}, UnitIdentifier:{muc?.UnitIdentifier}, commandId: {muc?.CommandId}");
	MobileUnitId=1256277082074050560 and UniqueIdentifier=354762110248694

## Steps

- Next look for the following in the **API LOG**: 
  Received SendCommandToMobileUnit Request (groupId={0}, mobileUnitId={1}, commandId={2}, preferredTransport={3}, param1={4}, param2={5}, param3={6}
- 

## Notes

![[DST Moving Parts]]

### Code stuffs

C:\Projects\DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\MiX.Connect\MiXConnectMiX4k6kProxy.cs
Line 67
	              throw new System.Exception($"{ErrorMessages.ConfigAdmin.GMTOFFSET_NOT_FOUND}: {muc.GroupId}, UnitIdentifier:{muc?.UnitIdentifier}, commandId: {muc?.CommandId}");

### In SR-5350 we had a very similar issue.

- My comment:
	After looking at the backend, I saw that this value will only be 0 if it was sent as 0 from the front-end.  
	I then ran the above-mentioned test again, and it succeeded.  
	![Image of Group Upload](https://jira.mixtelematics.com/secure/attachment/118281/screenshot-1.png)
	
	From investigating the Network traffic I can confirm that it sent out the actual OrgId and this call succeeded.  
	![Image of Upload sending the correct org id](https://jira.mixtelematics.com/secure/thumbnail/118282/_thumb_118282.png)
	
	This might have been due to something in cache.  
	I would suggest to just try this again and let me know if the problem persists.  
	Hi [Dario Gandolfi](https://jira.mixtelematics.com/secure/ViewProfile.jspa?name=dariog), please close this if you are happy with your tests and these findings.

- Dario:
	Client confirmed this is still happening.
	Error: **996792066688917504**
	
	Also note that RSO states that:-
	_**This error happens while uploading for Assets that never communicated.**_   
	_**So the same happens if one vehicle in a Config group never communicated, then if we try to upload at the config group level we get the error message. Maybe this helps pin it down.**_