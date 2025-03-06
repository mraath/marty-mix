---
alias: SRE-105 Command 45 App or Tool
status: closed
date: 2022-09-27
priority: 1
comment: new feature
created: 2022-09-27T16:03
updated: 2024-10-02T13:17
---

Date: 2022-09-27 Time: 10:03
Parent:: [[Command 45]]
Friend:: [[2022-09-27 1]]
Parent:: [[SR-12935 Command 45 - not received by unit]]
JIRA:CONFIG-3387
[SRE-105 App or Report for Command 45 - commands not being received by asset - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SRE-105)

## CONFIG-3387 App or Report for Command 45

Config/MR/Feature/CONFIG-3387_DST_Incorrect.23.9.INT.ORI
CONFIG-3387
- [x] Local: 🟧 ✅ 2023-07-17
- [x] Dev: 🟨 ✅ 2023-07-19
- [x] INT: 🟩 ✅ 2023-07-21

## OUTSTANDING WORK in this file

```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Data from SQL

```txt
C:\Projects\_MiXTelematicsFiles\SQL\SRE-105 TEST Messages Sent.sql
```

## Branches

- **Common**: Config/MR/Feature/CONFIG-3387_DST_Incorrect.23.10.INT.ORI 🟧🟨🟩
	- Nuget Created: local
	- MiX.DeviceIntegration.Common.2023.7.10.2-_alpha_ (local)
	- MiX.DeviceIntegration.Common.2023.7.17.1-_beta_ (dev)
	- [x] PR INT: [Pull request 87502: CONFIG-3387: DST classes needed for the tool. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/87502) ✅ 2023-07-20
	- [x] Nuget INT: MiX.DeviceIntegration.Common.2023.7.20.1.nuspec ✅ 2023-07-20
- **Client**: Config/MR/Feature/CONFIG-3387_DST_Incorrect.23.9.INT.ORI 🟧🟨🟩
	- Need Nugets: common
	- Nuget created: Local
	- MiX.ConfigInternal.Api.Client.2023.11.20230710.1-_alpha_ (local)
	- MiX.ConfigInternal.Api.Client.2023.12.20230717.1-_beta_ (dev)
	- [x] PR INT: [Pull request 87507: CONFIG-3387: Move DST logic to INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/87507) ✅ 2023-07-20
	- [x] Nuget INT: MiX.ConfigInternal.Api.Client.2023.12.20230720.1.nupkg ✅ 2023-07-20
- **API**: Config/MR/Feature/CONFIG-3387_DST_Incorrect.23.9.INT.ORI 🟧🟨🟩
	- Need Nugets: common, Client 
	- [x] PR INT: [Pull request 87508: CONFIG-3387: DST to API and Tool on INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/87508) ✅ 2023-07-21
- **Tool**: (Part of API solution, Utilities) 🟧🟨🟩
	- Need Nugets: common, Client

## Deployments

Swagger end-points are on DEV
![[CONFIG-3387 App or Report for Command 45 Swagger End points.png | 400]]
DB Stored Proc is on DEV
![[CONFIG-3387 App or Report for Command 45 Stored Proc exists.png | 400]]

## Dev Test

- orgId=3222089765699420885
- Swagger: Worked
- Tool
- 1359673542383321088			MESA
- 1408203159022665728			FM
Working nicely:
![[CONFIG-3387 App or Report for Command 45 Tool working on DEV.png | 400]]

## Test Cases:
- [x] Write some test cases ✅ 2023-07-20
	- Please note this is an internal tool only, the spec below was decided on by our team and could be enhanced going forward.  
	- Columns should be sortable
	- Grayed-out rows should not be selectable
	- The toggle button should invert the selection. (Grayed out will never be selected)
	- The selection indicator should be displayed (Selected 0 of 201)
	- Send Daylight saving command button should initiate sending the selected assets one by one
	- The label to show success, fail, and left should then be shown (Success: 2, Failed: 0, Left: 0)
	- If all were successful, the message box should indicate this (Successfully sent the messages)
	- Successful messages (Green), can't be selected again
	- Failed messages (Red), can be sent again.
	- Successful sending should result in Green
	- Failed sending should result in Red and be shown in a pop-up screen, eg (OrgId: 6683530587170817171, AssetId: 1243268927570206720, Exception: System.EntryPointNotFoundException: A call to "POST /devices/456525845695215/comm...)
	- Mesas should show up if the Org contains them and they need command 45
	- Mesas should be able to send
	- FMs should show up if the Org contains them and they need command 45
	- FMs should be able to send
	- Units without Remote Connected should not be selectable and state it in Status (No Remote Device)
	- Mesas without a unique identifier should display this in the Status (No Id)
	- Incorrect messages (has a message, but with wrong params), should indicate this in Status (Command Incorrect)
	- Empty messages should indicate this in Status (Empty Command)
	- Take note of the total of potential messages to send (eg. 201). Take note of all successful messages (eg. 5). The next time you display the exact same query of assets, it should not include the 5 successful ones (eg. 196). Please note, if the DST daily service ran, it could mess up these figures. The best then is used eg. one org, take note of the assets that were sent via this tool. Then ensure the next time they are no longer there.
	- Assets won't be displayed in this list if their last message sent was in this state:
		- Message was sent anytime in the past, with the correct params for non DST site
		- Message was sent with the correct params, it is not yet successful on the device, but it has not yet expired (3 days) so it will still be handled
		- Message was sent in the past 6 months with the correct params.
- [x] Test these ✅ 2023-07-20

## Deployment on INT

### Swagger end-points are there
![[CONFIG-3387 App or Report for Command 45 INT Swagger End points.png | 400]]
- Quick outdated swagger test for orgId=-7094567047859310012 worked just fine.

### DB Stored Proc is there
![[CONFIG-3387 App or Report for Command 45 INT SProc.png | 400]]

Next I will test all the things I tested on DEV.

	ORG: -8441185520557948197,-7950239061577934052,-5872178668069482261,1835521538525709176,-7950239061577934052, -5070807911028103534

### Test Cases

I ensured that the basic app is working. I install it on DSINTAPP09. It usually runs on the DC's Jumpbox.
![[CONFIG-3387 App or Report for Command 45 INT Tool working.png | 400]]

- Please note this is an internal tool only, the spec below was decided on by our team and could be enhanced going forward.  
	- [x] Columns should be sortable ✅ 2023-07-21
	- [x] Grayed-out rows should not be selectable ✅ 2023-07-21
	- [x] The toggle button should invert the selection. (Grayed out will never be selected) ✅ 2023-07-21
	- [x] The selection indicator should be displayed (Selected 0 of 201) ✅ 2023-07-21
	- [x] Send Daylight saving command button should initiate sending the selected assets one by one ✅ 2023-07-21
	- [x] The label to show success, fail, and left should then be shown (Success: 2, Failed: 0, Left: 0) ✅ 2023-07-21
	- [x] If all were successful, the message box should indicate this (Successfully sent the messages) ✅ 2023-07-21
	- [x] Successful messages (Green), can't be selected again ✅ 2023-07-21
	- [x] Failed messages (Red), can be sent again. ✅ 2023-07-21
	- [x] Successful sending should result in Green ✅ 2023-07-21
	- [x] Failed sending should result in Red and be shown in a pop-up screen, eg (OrgId: 6683530587170817171, AssetId: 1243268927570206720, Exception: System.EntryPointNotFoundException: A call to "POST /devices/456525845695215/comm...) ✅ 2023-07-21
	- [x] Mesas should show up if the Org contains them and they need command 45 ✅ 2023-07-21
	- [x] Mesas should be able to send ✅ 2023-07-21
	- [x] FMs should show up if the Org contains them and they need command 45 ✅ 2023-07-21
	- [x] FMs should be able to send ✅ 2023-07-21
	- [x] Units without Remote Connected should not be selectable and state it in Status (No Remote Device) ✅ 2023-07-21
	- [x] Mesas without a unique identifier should display this in the Status (No Id) ✅ 2023-07-21
	- [x] Incorrect messages (has a message, but with wrong params), should indicate this in Status (Command Incorrect) ✅ 2023-07-21
	- [x] Empty messages should indicate this in Status (Empty Command) ✅ 2023-07-21
	- [x] Take note of the total of potential messages to send (eg. 201). Take note of all successful messages (eg. 5). The next time you display the exact same query of assets, it should not include the 5 successful ones (eg. 196). Please note, if the DST daily service ran, it could mess up these figures. The best then is used eg. one org, take note of the assets that were sent via this tool. Then ensure the next time they are no longer there. ✅ 2023-07-21



## NEXT

- [x] Add count of rows ✅ 2023-06-07
- [x] Add selected count of rows ✅ 2023-06-07
- [x] Make those without Remote not selectable (disable?) ✅ 2023-07-14
- [x] Put logic behind the Send COmmands... (Maybe new end-point to not send one by one, yes, will be better also for nightly runs) ✅ 2023-06-09
- [x] Remote inactive orgs (no need to return these) ✅ 2023-06-06
- [x] REMOTECOMMAND ✅ 2023-06-05
- [x] Use MobileUnitId rather than AssetId ✅ 2023-06-12
- [x] Update SQL to remove those not expired ✅ 2023-07-04
- [x] Remove successful ones from list ✅ 2023-06-12
- [x] Die default commands se param1 en 2 moet org offset bykry anders wrord dit n fake incorrect command ✅ 2023-07-13
- [x] Change FM to be not expired and ucstate 2 ✅ 2023-07-04
- [x] Change MESA to be not expired and MessageStatus 22 ✅ 2023-07-04
- DIDNT: Also test FM with other offsets ✅ 2023-07-17
- DIDNT: Also test Mesa with other offsets ✅ 2023-07-17

## Next steps

- Replace FMOnlineDB with VAR

- [x] SQL: Get all Assets, Messages and set messages as blank ✅ 2023-06-07
- [x] SQL: Get all messages ✅ 2023-06-07
	- [x] FM ✅ 2023-06-07
	- [x] MESA ✅ 2023-06-07
- [x] SQL: Add all messages to Assets, Messages ✅ 2023-06-07
- [x] Code: For all Assets with messages, find what it should have been ✅ 2023-06-07
- [x] Code: Return all Incorrect messages ✅ 2023-06-07
	- [x] Add Blank messages ✅ 2023-06-07
	- [x] Add Incorrrect messages ✅ 2023-06-07
- [x] UI Tool: Incorporate all this ✅ 2023-07-13
	- [x] Call client to get result ✅ 2023-06-07
	- [x] Show grid ✅ 2023-06-07
	- [x] Make selectable ✅ 2023-06-07
	- [x] Send all ✅ 2023-07-13
- [x] Client: To instantiate in top as per video ✅ 2023-07-17
- [x] Client: Add new service name to DST ✅ 2023-07-17
- [x] API: Async Controller (End-point) eg. GetMObileUnitMappingsByAssetIds ✅ 2023-07-10
	- [x] Even DB conn.async... have look at this eg... ✅ 2023-07-10
	- [x] TEST: Don't use var ✅ 2023-07-10

- The TSQL statements to get all the current orgs, sites, assets, and command 45 messages sent.  
- The code part is to find the Windows registry timezone offsets in order to compare and then return the ones not sent correctly.
- [x] Fix up the last few SQL things ✅ 2023-07-17


## Concept

![[CONFIG-3387 App or Report for Command 45 Missing Messages Report Design.png]]

## Tool Redesign

![[Config-3387 App Command 45 redesign.excalidraw]]

## Call Command 45 from UI Tool

- mobileUnitCommandsManager.SendCommandToMobileUnit(authToken, orgId, assetId, (int)CommandIdType.UpdateAssetTimezoneDeviation, null, param1, param2, param3);
- I think add a new end-point, send ALL info from frontend > end-point > Manager.... send command... fewer API calls!!

## UI tool changes (Idea)

![[CONFIG-3387 App or Report for Command 45 UI Tool Change.png | 600]]
## Notes

- GetLatestDaylightSavingsCommands
- [state].[MobileUnitMessages_GetLatestDaylightSavingsCommands]
- GetAssetIdsForOutdatedDaylightSavingsCommands = "outdated-daylight-savings"
- @orgIdsUI       dbo.SelectionIds READONLY,
- @assetIdsUI     dbo.SelectionIds READONLY,
- @typeIdsUI      dbo.SelectionIds READONLY

- [x] Move to common: LatestDaylightSavingsCommand ✅ 2023-06-07
```txt
GroupId BIGINT,
AssetId BIGINT,
MobileUnitId BIGINT,
sOrganisationName NVARCHAR(250),
vDesc NVARCHAR(500),
MobileDeviceTypeDescription NVARCHAR(250),
LegacyOrgId INT,
LegacyVehicleId INT,
MobileUnitKey INT,
MobileDeviceType INT,
liGMTOffset INT,
DisplayTimeZone NVARCHAR(500),
[Message] NVARCHAR(500)
```

```C#
public long GroupId { get; set; }
public long AssetId { get; set; }
public string OrganisationName { get; set; }
public string AssetDesciption { get; set; }
public string MobileDeviceTypeDescription { get; set; }
public bool IsRemoteCommandConnected { get; set; }
public uint Param1 { get; set; }
public uint Param2 { get; set; }
public uint Param3 { get; set; }
public string Status { get; set; }

//Extra in UI
public bool Selected { get; set; }

## Sending commands to outdated DSTs

- SendCommandsToAssetsWithOutdatedDaylightSavingsCommands = "send-command-to-outdated-daylight-savings";
- 5373602768183155046

## More fields needed on UI

- isUnitConnectedToRemoteCommand? <<<<<<<<<<<<<<<<<< ???? GET it from the SQL... yes
	- mobileUnitManager.GetAllAssetsThatHaveDeviceEnabled(orgId, LogicalDevices.REMOTE_COMMAND
- authToken   y
- orgId,    y
- assetId,    y
- (int)CommandIdType.UpdateAssetTimezoneDeviation,    y
- null -- preferred transport   y
- param1   +
- param2   +
- param3   +
- ..... Delay
## SQL to TEST if message went through

```sql
DECLARE @GroupId BIGINT = 5373602768183155046;

DECLARE @lorgID INT = (SELECT OrganisationId
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId)

SELECT sConnectDatabase, liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID

------------------------------
USE BenchUnits_2015;                                -- TODO: REPLACE THIS WITH THE CORRECT DB NAME received above

DECLARE @dateForCommand45ToInclude NVARCHAR(20) = '2023-06-09 00:30';

-- FM
SELECT top 500 dtStarts, v.sDesc, m.liMessageID, msh.liMessageID, msh.dtEntered, m.ucstate, sParams, m.dtStarts, m.sNotes, msh.sNotes, msh.dtTimeStamp, *
FROM dbo.messages m WITH (NOLOCK)
 INNER JOIN dbo.messagestatehistory msh WITH (NOLOCK) ON m.limessageid=msh.limessageid
 INNER JOIN dbo.vehicles v ON v.iVehicleId = m.iVehicleID
WHERE
   sParams LIKE '%CommandID=45 ;%'
AND msh.dtEntered > @dateForCommand45ToInclude


-- MESA
SELECT TOP 500
 CreationDateUtc, MessageId, MessageSubType, ParamsJson, *
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum WITH (NOLOCK)
WHERE ParamsJson LIKE '%"CommandId":45,%'
AND CreationDateUTC > @dateForCommand45ToInclude
```

## INT Testing

ORG: 7375043360480842650
IDS: 7686090027250417405,7696456543948684779,-3555951485071343414,943551135287394304
IDS2: -184461320058585413,953353641859710976 (Nope, after sending it says command incorrect! TEST it there in code)
IDS3: -184461320058585413,953353641859710976

## INT Testing 2
- Org: -9139758428361458025
- IDS: 1405656429450891264,1412959846039158784
## INT Test 3
- Org: -7094567047859310012
- IDS: 
## DEV Test 2

- 4318545541975424657
- 4693332000851043070
- 4939831081821351618
- 7773376884753414768

ORG: 5373602768183155046
IDS: 4318545541975424657,4693332000851043070,4939831081821351618,7773376884753414768

## Int Testing

-2863222214918159932
-9127061827260636520
2941218413219747865
3808396317524043816
3780630951757900231
-559071081520146128
-751899861423399517


-2863222214918159932,-9127061827260636520,2941218413219747865,3808396317524043816,3780630951757900231,-559071081520146128,-751899861423399517

## Try these manually

| org                 | asset               | mobile              | org name    | asset name                         | 
| ------------------- | ------------------- | ------------------- | ----------- | ---------------------------------- |
| 5373602768183155046 | 324671489999230131  | 324671489999230131  | Bench Units | TIMEZONE TEST-6000    XXXXXXX             |
| 5373602768183155046 | 862043805943975936  | 862043805943975936  | Bench Units | william bench 4000 359315077632213 |
| 5373602768183155046 | 1199171724857906167 | 1199171724857906167 | Bench Units | Load Test MiX 4000 01              |
| 5373602768183155046 | 1143624731378679808 | 1143624731378679808 | Bench Units | MR 4k BF                           |
| 5373602768183155046 | 1142222246309756928 | 1142222246309756928 | Bench Units | MR STM Peripheral                  |
| 5373602768183155046 | 1141433303604477952 | 1141433303604477952 | Bench Units | Jacques DCan test  XXXXXX                 |
| 5373602768183155046 | 1138592109460557824 | 1138592109460557824 | Bench Units | Test112                            |
| 5373602768183155046 | 1072610807551692800 | 1072610807551692800 | Bench Units | MIX6000 - Ernest                   |
| 5373602768183155046 | 1045467545029345280 | 1045467545029345280 | Bench Units | Marvin MX6K                        |
| 5373602768183155046 | 1035263761638375424 | 1035263761638375424 | Bench Units | MR MiXTalk 1                       |
| 5373602768183155046 | 1034952168919048192 | 1034952168919048192 | Bench Units | MR 4K IMEI                         |
|                     |                     |                     |             |                                    |

## Error to check

OrgId: 5373602768183155046, AssetId: 1142222246309756928, Exception: System.TypeLoadException: Method 'SetItemForUniqueIdentifier' in type 'MiX.Device...
5373602768183155046 
1069016704784003072 
Bench Units
.WilliamlftaTest568

5373602768183155046 
1142222246309756928 
Bench Units
MR STM Peripheral

## Many errors to investigate

|                     |                      |
| ------------------- | -------------------- |
| 5373602768183155046 | -2865718939562969721 |
| ------------------- | -------------------- |
|||

## Error

```
## ERROR

```txt
  "StackTrace": "   at Dapper.SqlMapper.ThrowDataException(Exception ex, Int32 index, IDataReader reader, Object value) in /_/Dapper/SqlMapper.cs:line 3706\r\n   at Deserialize6628b142-e020-4e18-be29-03aeddc089c3(IDataReader )\r\n   at Dapper.SqlMapper.<QueryAsync>d__33`1.MoveNext() in /_/Dapper/SqlMapper.Async.cs:line 438\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()\r\n   at DynaMiX.DeviceConfig.DataAccess.DeviceConfigRepository.<GetLatestDaylightSavingsCommands>d__37.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.DataAccess\\Repository\\MobileUnitLevel\\Command.cs:line 249\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.DaylightSavingsManager.<GetAssetIdsForOutdatedDaylightSavingsCommands>d__12.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\DaylightSavingsManager.cs:line 107\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()\r\n   at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitCommandsController.<>c__DisplayClass4_0.<<GetAssetIdsForOutdatedDaylightSavingsCommands>b__0>d.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Services.API\\Controllers\\MobileUnitLevel\\MobileUnitCommandsController.cs:line 157\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()\r\n   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.<HandledResponseAsync>d__3`1.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 105",

```

## Result from DB

| GroupId             | AssetId             | MobileUnitId        | MobileDeviceTypeDescription | LegacyOrgId | LegacyVehicleId | MobileUnitKey | MobileDeviceType | liGMTOffset | DisplayTimeZone            | Message |
| ------------------- | ------------------- | ------------------- | --------------------------- | ----------- | --------------- | ------------- | ---------------- | ----------- | -------------------------- | ------- |
| 5373602768183155046 | 1001730213518663680 | 1001730213518663680 | MESA                        | 5           | 178             | 53290         | 3                | 7200        | South Africa Standard Time | NULL    |


## Swagger 

[Swagger UI](http://localhost/DynaMiX.DeviceConfig.Services.API/swagger/ui/index#!/MobileUnitCommands/MobileUnitCommands_GetAssetIdsForOutdatedDaylightSavingsCommands)

## Read Description

- Unit Info if needed eg.
	- IDC: XXXX
	- Database: XXXX
	- Group ID: XXXX
	- Asset description: XXXX
	- Asset ID: XXXX
	- Last config loaded: XXXX
	- Mobile device: XXXX
- Description of issue from Jira
	- XXXX

## Similar SQL statements

```txt
-- FM
C:\Projects\Database\FMAsset\Schemas\dynamix\Stored Procedures\JobsAndMessaging\Messages\Messages_SucceededAndQueuedForDSTCommand.sql
C:\Projects\Database\FMAsset\Schemas\dynamix\Stored Procedures\JobsAndMessaging\Messages\Messages_GetDSTCommandsForLastYear.sql

-- MESA
C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnitMessages_SucceededAndQueuedForDSTCommand.sql
C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnitMessages_GetDSTCommandsForLastYear.sql
```

Mesa
	msgh.MessageStatus in (13, 25)))
FM
	9

## See it happen

- Duplicate this on the environment mentioned using MFM

## SQL

(SQL FILE)[C:\Projects\_MiXTelematicsFiles\SQL\CONFIG-3387 Command 45 Report Not Sent WIP.sql]
![[CONFIG-3387 Command 45 Report Not Sent WIP.sql]]
![[CONFIG-3387 Command 45 Report Part 2 WIP.sql]]
## Analyse SQL file

ALSO LOOK INTO:
[dynamix].[Messages_GetDSTCommandsForLastYear]

```sql
SELECT DISTINCT 
    [AssetId],
    [dtStarts] as [DtStarts],
    [sParams] as [SParams]
  FROM [dbo].[Messages] m WITH (NOLOCK)
    INNER JOIN [dynamix].[Assets] a WITH (NOLOCK) ON m.iVehicleID = a.VehicleId
  WHERE REPLACE(sParams, ' ', '') LIKE 'CommandID=45;%'
    AND dtStarts >= DATEADD(YEAR, -1, @now)
    AND (dtExpires >= @now
      OR (dtExpires < @now AND ucState = 9))
```

[state].[MobileUnitMessages_GetDSTCommandsForLastYear]

```sql
SELECT DISTINCT   
    msg.MobileUnitId MobileUnitId, 
    [CreationDateUtc] CreationDateUtc, 
    ParamsJson
  FROM [state].[MobileUnitMessage] msg
    INNER JOIN [state].[MobileUnitMessageStateHistory] msgh ON msgh.MessageKey = msg.MessageKey
  WHERE REPLACE(ParamsJson, ' ', '') LIKE '%"CommandId":45,%'
    AND CreationDateUtc >= DATEADD(YEAR, -1, @now)
    AND (ExpiryDateUtc >= @now
      OR (ExpiryDateUtc < @now AND msgh.MessageStatus in (13, 25)))
```

## Any Development done?

? ==Replace with Template Development note==

## T-SQL to get the offset before and after the last Daylight Savings Time change

To get the timezone offset in seconds for a given timezone name in T-SQL, you can use the AT TIME ZONE function along with the DATEDIFF function.

First, you need to determine the last daylight savings date for the given timezone. This can be done using the SWITCHOFFSET function to convert a known date to the given timezone and then using the DATEADD function to determine the last Sunday in October, which is typically when daylight savings ends in most parts of the world.

Here is an example query that gets the last daylight savings date for Eastern Standard Time:

```sql
DECLARE @timezone VARCHAR(50) = 'Eastern Standard Time';

SELECT DATEADD(WEEK, DATEDIFF(WEEK, '19000107', SWITCHOFFSET(CONVERT(datetimeoffset, '20220101', 0), @timezone)), 0) AS LastDSTDate;
```

This will output the last Sunday in October 2022, which is the last daylight savings date for Eastern Standard Time.

To get the offset in seconds before and after this date, you can use the DATEDIFF function to calculate the difference between a given date and the last daylight savings date, and then convert the result to seconds.

Here is an example query that gets the offset in seconds before and after the last daylight savings date for Eastern Standard Time:

```sql
DECLARE @timezone VARCHAR(50) = 'Eastern Standard Time';
DECLARE @lastDSTDate DATETIMEOFFSET = DATEADD(WEEK, DATEDIFF(WEEK, '19000107', SWITCHOFFSET(CONVERT(datetimeoffset, '20220101', 0), @timezone)), 0);

SELECT 
    DATEDIFF(SECOND, SWITCHOFFSET(CONVERT(datetimeoffset, '20211031 01:00:00', 0), @timezone), @lastDSTDate) AS OffsetBeforeDST,
    DATEDIFF(SECOND, @lastDSTDate, SWITCHOFFSET(CONVERT(datetimeoffset, '20221031 01:00:00', 0), @timezone)) AS OffsetAfterDST;
```

This will output the offset in seconds before and after the last daylight savings date in Eastern Standard Time for 2022.






