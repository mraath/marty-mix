Date: 2022-05-31 Time: 09:39
Friend: [[Command 45]]
JIRA:SR-12935
[SR-12935 Command 45 - commands not being received by asset - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-12935)

# SR-12935 Command 45 - not received by unit

Parent:: [[Command 45]]

- [x] API > Utility changed > Need to check in for tool ✅ 2023-07-26


## IDEAS

- 'USE'  + QUOTENAME(@sConnectDatabase)
- [[SQL Temp Table need to drop]]
- [dynamix].[Messages_GetDSTCommandsForLastYear]
- [state].[MobileUnitMessages_GetDSTCommandsForLastYear]
- 
 
## Test it locally against INT to find all outstanding assets for DST?

id=936295081791897600&orgId=-8441185520557948197
id=1152691005359259648&orgId=-8441185520557948197

{
  "GroupIds": "-8441185520557948197",
  "MobileUnitIds": "1152691005359259648",
  "TypeIds": ""
}

## Branch
Config/MR/Bug/SR-12935_Command45_report 
(Based off 21.10 INT)

## Help
- [http://api.deviceconfig.uk.dub.production.local](http://api.deviceconfig.uk.dub.production.local/)
- 

## Clock op unit tans

Martin Rademeyer:
Softclock settings tans op asset:
U32 utcEpoch = 1667091600  (Sun, 30 Oct 2022 01:00:00 GMT)
S32 utcOffsetBeforeEpoch = 3600  
S32 utcOffsetAfterEpoch = 0
Asset time: CTIME32 DateTime = 06/06/2022 8:04:53 AM
Dit is UTC soos verwag vir MESA devices.
Source is DTCO

## Example 2

**Example Asset:**   
IDC: UK  
Org: Wincanton  
DB: Wincanton_2017  
Unit Type: MiX 4000  
Asset Id (Legacy): 1965  
Asset Id (64 Bit): 920658990217211904  
IMEI: 358014098841595  
Org Id (Legacy): 5717  
Org Id (64 Bit): 2439978887618476175  
Reg: RE69MXM

Issue: Vehicle was involved in an incident around 11:40am (BST) on 30 May 2022. Client has to download footage for 10:40am as actual footage returned is out by 1 hour.

## Success via swagger

DEBUG 2022-06-02T09:36:55+00:00 [tid:7   ] Received SendDaylightSavingsCommandToMobileUnits Request (groupId=2439978887618476175, mobileUnitIds=920658990217211904, typeIds=)
DEBUG 2022-06-02T09:36:55+00:00 [tid:7   ] DST Manager: [1269011442009157632] Adjuster starting.
DEBUG 2022-06-02T09:36:55+00:00 [tid:7   ] DST Manager: [1269011442009157632] Getting all information. [Org: 2439978887618476175, Asset: 920658990217211904, Type: ]
DEBUG 2022-06-02T09:36:55+00:00 [tid:7   ] DST Manager: [1269011442009157632] Getting organisations
DEBUG 2022-06-02T09:36:55+00:00 [tid:30  ] Requesting MobileUnitMapping for MobileUnitId=1114356000621244416
DEBUG 2022-06-02T09:36:55+00:00 [tid:30  ] Response for MobileUnitMapping, MobileUnitId=1114356000621244416 and UniqueIdentifier=357796101020727
DEBUG 2022-06-02T09:36:55+00:00 [tid:7   ] DST Manager: [1269011442009157632] Getting assets for org: Wincanton
DEBUG 2022-06-02T09:36:55+00:00 [tid:7   ] DST Manager: [1269011442009157632] Getting specified assets for organisation: Wincanton
DEBUG 2022-06-02T09:36:55+00:00 [tid:29  ] GroupId:1468707464514571533, LegacyEventId:32691, ExecTimeMsec:3.1491 : GetLibraryEventByLegacyId
DEBUG 2022-06-02T09:36:55+00:00 [tid:27  ] GroupId:2789946596178804366, LegacyEventId:-32, ExecTimeMsec:2.8456 : GetLibraryEventByLegacyId
DEBUG 2022-06-02T09:36:55+00:00 [tid:32  ] Requesting MobileUnitMapping for MobileUnitId=1171560141569585152
DEBUG 2022-06-02T09:36:55+00:00 [tid:32  ] Response for MobileUnitMapping, MobileUnitId=1171560141569585152 and UniqueIdentifier=357796101056507
DEBUG 2022-06-02T09:36:55+00:00 [tid:7   ] DST Manager: [1269011442009157632] Getting sites for org: Wincanton
DEBUG 2022-06-02T09:36:55+00:00 [tid:7   ] DST Manager: [1269011442009157632] Updating: Wincanton - M&S Sheffield Default Site 10615 [1 asset(s)]
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] Successfully obtained session (Name=Marthinus Raath, AccountId=-3808369611166108857, AuthToken=2d243f0d-aeea-4a26-b460-ffac3101d816)
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] Successfully obtained session (Name=Marthinus Raath, AccountId=-3808369611166108857, AuthToken=2d243f0d-aeea-4a26-b460-ffac3101d816)
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] MobileUnitId=920658990217211904 has DeviceFamily=M4K6K
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] Requesting MobileUnitMapping for MobileUnitId=920658990217211904
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] GetSharedMobileUnitDetailsCache model IS NULL (could not get from cache) trying from DB
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] Executed GetMobileUnitMappingsByMobileUnitId in 0.0009492 seconds
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] GetMobileUnitMappingsByMobileUnitId(DB) - Set in cache (1). MobileUnitId=920658990217211904 (cache updated) 
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] GetMobileUnit(1) - SharedMobileUnitDetailsCache updated with: {"AssetId":920658990217211904,"MobileUnitId":920658990217211904,"UniqueIdentifier":"358014098841595","OrganisationId":2439978887618476175,"LegacyVehicleId":1965,"LegacyOrganisationId":5717,"MobileDeviceType":3}
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] Response for MobileUnitMapping, MobileUnitId=920658990217211904 and UniqueIdentifier=358014098841595
WARN  2022-06-02T09:36:56+00:00 [tid:7   ] Command sent to MiX.Connect (CommandId=UpdateAssetTimezoneDeviation, UnitIdentifier=358014098841595, MobileUnitId=920658990217211904, Transport=GPRS, MessageId=222884352, Parameter1=3600, Parameter2=0, Parameter3=1667091600, Value=)
DEBUG 2022-06-02T09:36:56+00:00 [tid:7   ] DST Manager: [1269011442009157632] Adjustment for assets completed.



## Error via app

DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] Received SendDaylightSavingsCommandToMobileUnits Request (groupId=2439978887618476175, mobileUnitIds=920658990217211904, typeIds=MiX4k)
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] Adjuster starting.
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] Getting all information. [Org: 2439978887618476175, Asset: 920658990217211904, Type: MiX4k]
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] Getting organisations
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] Getting assets for org: Wincanton
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] Getting specified assets for organisation: Wincanton
DEBUG 2022-06-02T08:42:27+00:00 [tid:11  ] GroupId:1382948275595209101, LegacyEventId:6, ExecTimeMsec:2.5371 : GetLibraryEventByLegacyId
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] Getting types for org: Wincanton
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] Getting sites for org: Wincanton
WARN  2022-06-02T08:42:27+00:00 [tid:33  ] Failed to obtain session! (AuthToken=)
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ]  FAILURE: Remote message for asset 920658990217211904 not sent. MiX.DeviceIntegration.Common.Exceptions.UnAuthenticatedException: Exception of type 'MiX.DeviceIntegration.Common.Exceptions.UnAuthenticatedException' was thrown.
   at DynaMiX.Services.API.Client.AuthenticationProxy.GetSession(String authToken) in D:\b\1\_work\2665\s\DynaMiX.Services.API.Client\AuthenticationProxy.cs:line 111
   at DynaMiX.Services.API.Client.AuthenticationProxy.ValidateToken(String authToken) in D:\b\1\_work\2665\s\DynaMiX.Services.API.Client\AuthenticationProxy.cs:line 119
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.AuthenticateUser(String authToken, CommandIdType commandType, Int64 groupId) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitCommandsManager.cs:line 246
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitCommandsManager.cs:line 72
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.DaylightSavingsManager.SendCommandToUpdateAssetTimezoneDeviation(String authToken, Int64 orgId, Double secondsBefore, Double secondsAfter, Double ctime, List`1 assetIds, String currentUser, Int64 correlationId, DSTOptionalFields dstOptionalFields) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DaylightSavingsManager.cs:line 279
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] FAILURE: System.InvalidOperationException: Unable to send update timezone message for all the assets.FAILURE: Remote message for asset 920658990217211904 not sent. MiX.DeviceIntegration.Common.Exceptions.UnAuthenticatedException: Exception of type 'MiX.DeviceIntegration.Common.Exceptions.UnAuthenticatedException' was thrown.
   at DynaMiX.Services.API.Client.AuthenticationProxy.GetSession(String authToken) in D:\b\1\_work\2665\s\DynaMiX.Services.API.Client\AuthenticationProxy.cs:line 111
   at DynaMiX.Services.API.Client.AuthenticationProxy.ValidateToken(String authToken) in D:\b\1\_work\2665\s\DynaMiX.Services.API.Client\AuthenticationProxy.cs:line 119
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.AuthenticateUser(String authToken, CommandIdType commandType, Int64 groupId) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitCommandsManager.cs:line 246
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitCommandsManager.cs:line 72
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.DaylightSavingsManager.SendCommandToUpdateAssetTimezoneDeviation(String authToken, Int64 orgId, Double secondsBefore, Double secondsAfter, Double ctime, List`1 assetIds, String currentUser, Int64 correlationId, DSTOptionalFields dstOptionalFields) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DaylightSavingsManager.cs:line 279
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.DaylightSavingsManager.SendCommandToUpdateAssetTimezoneDeviation(String authToken, Int64 orgId, Double secondsBefore, Double secondsAfter, Double ctime, List`1 assetIds, String currentUser, Int64 correlationId, DSTOptionalFields dstOptionalFields) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DaylightSavingsManager.cs:line 307
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.DaylightSavingsManager.UpdateAssetTimezoneDeviation(String authToken, Int64 orgId, List`1 assetIds, Int64 correlationId, String siteTimeZoneName, DSTOptionalFields dstOptionalFields) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DaylightSavingsManager.cs:line 238
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.DaylightSavingsManager.AdjustAssetDayLightSavings(String authToken, String orgIdFromUI, String assetIdFromUI, String typeIdFromUI) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DaylightSavingsManager.cs:line 179
DEBUG 2022-06-02T08:42:27+00:00 [tid:33  ] DST Manager: [1268997734633226240] System.Exception: Errors found while sending commands
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.DaylightSavingsManager.AdjustAssetDayLightSavings(String authToken, String orgIdFromUI, String assetIdFromUI, String typeIdFromUI) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DaylightSavingsManager.cs:line 226
   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.DaylightSavingsManager.SendDaylightSavingsCommandToMobileUnits(String _authToken, String groupIds, String mobileUnitIds, String typeIds) in D:\b\1\_work\2665\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DaylightSavingsManager.cs:line 70
DEBUG 2022-06-02T08:42:28+00:00 [tid:32  ] Successfully obtained session (Name=Lightning User, AccountId=40000000010008, AuthToken=06945bb5-ff02-4116-8efe-75fc2c6e4744)



## Description

-- mine
id=1014349704057729024
orgId=-8441185520557948197

-- Theirs
53
4807194728063746720
id=4807194728063746720
orgId=2439978887618476175


Dublin
Affected Region:
United Kingdom
Organisation:Wincanton
Organisation 3B Status:3B DP

Good Day Team

We've received a few tickets whereby footage time is out by the daylight savings hours. Initially, sending a command 45 would resolve this, however, at the moment, this is not working.

The command 45 commands sent via the tool as well as by physically moving the asset between various config groups in order to force a time sync, is not yielding any results. No current messages on streams to indicate any outgoing messages. Ran a script to check from the backend for Command 45 messages, however, the last message is dated 10 May 2022. Restarted the Dynamix Daylight Saving Adjustment service on HSDUBAPP05, which did not help. Russell assisted with this issue and his results are attached in the excel document. 

https://jira.mixtelematics.com/secure/attachment/212760/212760_Command+45+Issue.xlsx

Could you please investigate further to ascertain whether there is an issue with the Daylight Savings Time Adjuster. 

Daylight Savings Time Adjuster

- [x] **Ver 22.2** ✅ 2023-05-25
- [x] Last message 10 May 2022 ✅ 2023-05-25
- [x] Info hub no command to mobile for command 45 (should it?) ✅ 2023-05-25

## Code sections

## Files

## Resources

## Notes

