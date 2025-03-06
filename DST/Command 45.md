---
created: 2022-07-15T16:27
updated: 2024-10-30T09:56
---

Parent:: [[Command]]
Date: 2022-05-31 Time: 10:47
Friend:: [[Config]]
Friend::[[DST]]
# Command 45

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

Here is one of the original [[DaylightSavingsTimeAdjuster]] tool. See below how we enhanced this...

## Quick overview

![[Command 45.excalidraw.png]]

## 18.17 Oman

![[Command 45 18.17 Oman Tool.png]]







## Latest OUTSTANDING

- [x] Tool for DST forcing: DynaMiX.DeviceConfig\DaylightSavingsTimeAdjuster ✅ 2024-06-27
	- DeviceConfigClient.MobileUnitCommands.GetAssetsWithOutdatedDaylightSavingsCommands
	- DeviceConfigClient.MobileUnitCommands.SendCommandsToAssetsWithOutdatedDaylightSavingsCommands
- [ ] Remove this? DynaMiX.DeviceConfig.Utilities.DaylightSavingsService
- [ ] Service for DST take out of BE: DynaMiX.Services.DaylightSavingAdjustment
	- [[DynaMiX.Services.DaylightSavingAdjustment]]
	- [[TECHDEBT-427]]

## Some code to look out for

```c#
//Controller > "/daylight-savings"
//Method > SendDaylightSavingsCommandToMobileUnits
```

## Log on INT

![[LOG Command 45#Log]]


## Triggers (There are a few)

### 1) Moving to another site

[[Command 45 Moving Site]]


## Command 45 App / Tool workflow

![[Command 45 App Workflow.png]]

## Lightning Kafka

![[SR-8111-Kafka-Event-Command 45.png]]


## Services

INT: DSINTAPP02


## Description

### When an issue comes in
- Check the **messages** table (sql below)
- Try it on **swagger** (link below)
	- Check the log for "DST Manager" to see if it went through
	- Check the messages table again
- Try the **UI tool** (below) and check the messages again
	- Check the log for "DST Manager" to see if it went through
	- Check the messages table again
- Check the Org timezone offset and Site timezoneoffset (sql below)
- Use online tool for sitetimezone to see the value (online tool below)
- **Calculation**: Param1: before deviation: SiteOffset - OrgOffset in seconds
- Param2: after deviation: SiteOffset - OrgOffset in seconds
- Param3: deviation date in unix time (use online tool to convert - below)
- I also added a quick check sql to just show the amount of messages sent after a specified date (sql below)
- [ ] Is the below for 4k and 6k only (I don't see anything for FM)

## IMPORTANT note

![[Command 45 Adding Org Offset.png| 500]]

- If the third param is: 946688400 it means there is no DST in windows
## Online Tools
- [Online Conversion - Unix time conversion](https://www.onlineconversion.com/unix_time.htm)
- [Greenwich Mean Time – GMT Time Zone (timeanddate.com)](https://www.timeanddate.com/time/zones/gmt)

## UI Tool

- On the Jumpbox (c:\projects\DaylightSavingsTime.22.2)
- ![[Command 45 App On Server (Jumpbox).png]]
- [[CONFIG-3387 App or Report for Command 45|SRE-105 Command 45 App or Tool]]

## Service

- [[TECHDEBT-190 Move the DST Service to the DeviceConfig Repo]]

## Swagger

- [Swagger UI (domain.local)](http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/MobileUnitCommands/MobileUnitCommands_SendDaylightSavingsCommandToMobileUnits)

## Log
- Look for DST Manager (this is the UI tool logging - debug only though...)
- Logz.io
- "DST Manager" - how to show in logs...?

## Windows registry

- If we use Globalisation API: We don't need to do a thing
- If we use DynaMiX Services API OR DynaMIX API, then we need to run windows updates on the DynaMiX servers
	- Our current code still reads the adjustments from the instance of the DynaMiX server. In order to fix this we need to do Windows Updates for all DYnamiX servers on all environments where Mexico City is used.
	- [x] The best would be to make use of the globalisation API. Then only one update will fix this time-zone info on all our servers, world-wide. ✅ 2023-07-26

## See Commands Sent

![[QA-5849 GetStatus Command not populating table#SQL Used]]

## Dario SQL

```sql
DECLARE @commandID nvarchar(20) = 45
DECLARE @LIORGID VARCHAR(100) = '4185'

 

---------
--1 = PositionRequest
--2 = IncreaseSMSLimit
--3 = RequestCallback
--4 = TrackingRequest
--7 = ClearMessageBuffer
--10 = SetRelay
--11 = IncreaseSatCommsLimit
--12 = TrackingRequestSatComms
--13 = PositionRequestSatComms
--14 = thenIncreaseSatCommsLimitPermanently
--15 = RequestSatHeartBeatEvent
--35 = thenRemoteDriverDisarm
--45 = UpdateAssetTimezoneDeviation
--37 = GetLegacyDriverId
--46 = SetAcronym
--47 = ChangeAssetId
--101 = GetStatus
--102 = SendConfiguration
--103 = SendFirmware
--104 = SendOdometer
--254 = SendConfig
--255 = SendSettings

 

---------

 

DECLARE @Database sysname
DECLARE @OrgID int
DECLARE @SQL nvarchar(max)
DECLARE @Params nvarchar(110)

 

SET NOCOUNT ON;
SET @Params = N'@OrgID int, @Database sysname'

 

DROP TABLE IF EXISTS #FINAL;
DROP TABLE IF EXISTS #FINAL2;
-- Create temp table to store result rows from each db
CREATE TABLE #FINAL(
ORGID [smallint],
[Unit Type] [nvarchar](100),
[vehicleid] [int],
[assetid] [bigint],
[Command] [nvarchar](255),
PARAMETER [nvarchar](255),
Starts [datetime],
Expires [datetime],
Status [nvarchar](255)
);

 

-- Decide which databases to query

 


-- Decide which databases to query
DECLARE tCursor CURSOR fast_forward
FOR

 

SELECT liOrgID, sConnectDatabase 
FROM FMOnlineDB.dbo.Organisation o WITH (NOLOCK)
WHERE liOrgID > 0 
--  AND bActive = 1 
  AND liOrgID IN (SELECT value FROM STRING_SPLIT(@LIORGID, ','))

 

ORDER BY
liOrgID
FOR READ ONLY;
OPEN tCursor;

 

-- Get first db record
FETCH next from tCursor into @OrgID, @Database;
-- build SQL command
WHILE @@FETCH_STATUS = 0
BEGIN

 


SET @SQL = N'RAISERROR(''Processing database %s '', -1, -1, @Database) WITH NOWAIT
USE [' + @Database + '];' + nchar(13) +
N'

 


DECLARE @PARAMID nvarchar(10) = 45;

 

insert into #FINAL
SELECT
o.liorgid as [OrgID],
dm.description as ''Unit Type'',
v.iVehicleID as ''Vehicle ID'',
a.AssetId,
Command=
CASE
When sParams like ''%CommandID=1 %'' then ''PositionRequest ''
When sparams like ''%Commandid=2 %'' then ''IncreaseSMSLimit ''
When sparams like ''%Commandid=3 %'' then ''RequestCallback ''
When sparams like ''%Commandid=4 %'' then ''TrackingRequest ''
When sparams like ''%Commandid=7 %'' then ''ClearMessageBuffer ''
When sparams like ''%Commandid=10 %'' then ''SetRelay ''
When sparams like ''%Commandid=11 %'' then ''IncreaseSatCommsLimit ''
When sparams like ''%Commandid=12 %'' then ''TrackingRequestSatComms ''
When sparams like ''%Commandid=13 %'' then ''PositionRequestSatComms ''
When sparams like ''%Commandid=14 %''then ''IncreaseSatCommsLimitPermanently ''
When sparams like ''%Commandid=15 %'' then ''RequestSatHeartBeatEvent ''
When sparams like ''%Commandid=35 %''then ''RemoteDriverDisarm ''
When sparams like ''%Commandid=45 %'' then ''UpdateAssetTimezoneDeviation ''
When sparams like ''%Commandid=37 %'' then ''GetLegacyDriverId ''
When sparams like ''%Commandid=46 %'' then ''SetAcronym ''
When sparams like ''%Commandid=47 %'' then ''ChangeAssetId ''
When sparams like ''%Commandid=101 %'' then ''GetStatus ''
When sparams like ''%Commandid=102 %'' then ''SendConfiguration ''
When sparams like ''%Commandid=103 %'' then ''SendFirmware ''
When sparams like ''%Commandid=104 %'' then ''SendOdometer''
When sparams like ''%Commandid=254 %'' then ''SendConfig ''
When sparams like ''%Commandid=255 %'' then ''SendSettings ''
END
,m.sparams
,m.dtStarts
,m.dtExpires
,snotes as ''status''
FROM Vehicles v with (nolock)
INNER JOIN dynamix.Assets a WITH (NOLOCK) ON a.VehicleId = v.iVehicleId
LEFT JOIN DeviceConfiguration.mobileunit.MobileUnits mu WITH (NOLOCK) ON mu.MobileUnitId = a.AssetId
left join dbo.messages m  with (nolock) on m.ivehicleid = v.ivehicleid
left join  [DeviceConfiguration].[definition].[MobileDevices] dm with (nolock) on  mu.mobiledevicekey = dm.devicekey
left join  [DeviceConfiguration].mobileunit.assetmobileunits amu with (nolock) on amu.assetid = mu.mobileunitid
left join [FMOnlineDB].[dbo].[organisation] o WITH (NOLOCK) ON o.liOrgID = amu.legacyorgid

 


where dm.description is not null
and m.sparams like ''CommandID=%''

 

group by
a.AssetId, 
o.liorgid,
dm.description,
v.iVehicleID,
m.sparams,
m.dtStarts,
m.dtExpires,
m.snotes

 

order by 1,4,8
'

 


-- execute it
EXEC sp_executesql @SQL, @Params, @OrgID, @Database

 

-- do the next org
FETCH NEXT FROM tCursor INTO @OrgID, @Database;

 

END

 

CLOSE tCursor;
DEALLOCATE tCursor;
--SELECT*FROM #FINAL R
-- Display the results
Select * into #final2 from
(
SELECT*
FROM #FINAL R

 

union

 

SELECT -- TOP (1000) 
legacyorgid as [ORGID]
,dm.description as 'Unit Type'
,legacyvehicleid vehicleid
,mu.[MobileUnitId] as assetid

 

      
     , CASE
    When messagesubtype=1 then 'PositionRequest '
When messagesubtype=2 then 'IncreaseSMSLimit '
When messagesubtype=3 then 'RequestCallback '
When messagesubtype=4 then 'TrackingRequest '
When messagesubtype=7 then 'ClearMessageBuffer '
When messagesubtype=10 then 'SetRelay '
When messagesubtype=11 then 'IncreaseSatCommsLimit '
When messagesubtype=12 then 'TrackingRequestSatComms '
When messagesubtype=13 then 'PositionRequestSatComms '
When messagesubtype=14 then 'IncreaseSatCommsLimitPermanently '
When messagesubtype=15 then 'RequestSatHeartBeatEvent '
When messagesubtype=35 then 'RemoteDriverDisarm '
When messagesubtype=45 then 'UpdateAssetTimezoneDeviation '
When messagesubtype=37 then 'GetLegacyDriverId '
When messagesubtype=46 then 'SetAcronym '
When messagesubtype=47 then 'ChangeAssetId '
When messagesubtype=101 then 'GetStatus '
When messagesubtype=102 then 'SendConfiguration '
When messagesubtype=103 then 'SendFirmware '
When MessageSubType=104 then 'SendOdometer'
When messagesubtype=254 then 'SendConfig '
When messagesubtype=255 then 'SendSettings '
else 'Unknown'
    END as 'Command'
          ,[ParamsJson] as 'PARAMETER'
      ,[CreationDateUtc] as 'Starts'
      ,[ExpiryDateUtc] as 'Expires'

 


      ,
            Case 
                When MessageStatus ='0'
                    Then 'UNKNOWN'

                When MessageStatus ='1'
                    Then 'NEW'

                When MessageStatus ='2'
                    Then 'Pending'

                When MessageStatus ='3'
                    Then 'Queued'

                When MessageStatus ='4'
                    Then 'Sent'

                When MessageStatus ='5'
                    Then 'Postponed'

                When MessageStatus ='6'
                    Then 'SendFailed'

                When MessageStatus ='7'
                    Then 'Aborted'

                When MessageStatus ='8'
                    Then 'Deleted'
                    When MessageStatus ='9'
                    Then 'Received'

                When MessageStatus ='10'
                    Then 'Accepted'

 

                When MessageStatus ='11'
                    Then 'Rejected'

                When MessageStatus ='12'
                    Then 'Completed'

 

                When MessageStatus ='13'
                    Then 'Acknowledged'

                When MessageStatus ='14'
                    Then 'Expired'

 

                When MessageStatus ='15'
                    Then 'DeleteRequested'

                When MessageStatus ='16'
                    Then 'DeleteQueued'

 

                When MessageStatus ='17'
                    Then 'ETAChanged'

                When MessageStatus ='18'
                    Then 'READ'

 

                When MessageStatus ='19'
                    Then 'CLOSE'

                When MessageStatus ='20'
                    Then 'ARRIVED'

 

                When MessageStatus ='21'
                    Then 'KMETACHANGED'

 

                When MessageStatus ='22'
                    Then 'CREATED'

 

                When MessageStatus ='23'
                    Then 'SendAwaitingResponse'

 

                When MessageStatus ='24'
                    Then 'Acknowleged'

                When MessageStatus ='25'
                    Then 'Complete'

                When MessageStatus ='26'
                    Then 'Failed'

 

                When MessageStatus ='27'
                    Then 'Cancelled'

 

                    END as 'Status'

  FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum with (nolock)
  Left Join DeviceConfiguration.mobileunit.assetmobileunits amu with (nolock)on mum.MobileUnitId=amu.assetid
  Left Join fmonlinedb.dbo.Organisation o with (nolock) on o.liorgid=amu.LegacyOrgId
  LEFT JOIN DeviceConfiguration.mobileunit.MobileUnits mu WITH (NOLOCK) ON mu.MobileUnitId = amu.AssetId
  left join  [DeviceConfiguration].[definition].[MobileDevices] dm with (nolock) on  mu.mobiledevicekey = dm.devicekey
  WHERE legacyorgid IN (SELECT value FROM STRING_SPLIT(@LIORGID, ','))
  --where mum.MessageStatusDateUtc >'2023-04-01' 

  --and MessageSubType=10

  --mobileunitid =1311437026813661184 and MessageStatusDateUtc > '2023-02-23 00:00' and MessageKey=2861408090


 




 

  ) spc
  WHERE PARAMETER LIKE '%CommandID=' + @commandID + ' ;'+ '%' OR PARAMETER LIKE '%CommandId":' + @commandID +','+ + '%'

 


  Select * from #final2

 

  --where starts > '20230601'
  --where vehicleid = 2
  ORDER BY 7 desc
```

## SQL


```sql
-- Command 45 SR-8111 ---------------------
DECLARE @OrgName NVARCHAR(100) = 'DynaMiX Test Units 2017';

-- TODO: REPLACE THIS WITH THE SITE NAME
SELECT o.sconnectdatabase
FROM Fmonlinedb.dbo.organisation o
WHERE o.sOrganisationName LIKE '%' + @OrgName + '%'

--Org TZ Offset
SELECT o.sconnectdatabase, liGMTOffset
FROM Fmonlinedb.dbo.organisation o
WHERE o.sOrganisationName LIKE '%' + @OrgName + '%'

------------------------------
USE DynaMiXTestUnits_2016 --AlMalihiTransportingandContracting_2019                                      -- TODO: REPLACE THIS WITH THE CORRECT DB NAME received above

--Site timezone
SELECT v.sDesc, s.sName, v.liSiteID, ds.GroupId, g.DisplayTimeZone
FROM dbo.Vehicles v
  INNER JOIN dbo.Sites s ON s.liSiteID = v.liSiteID
  INNER JOIN dynamix.Sites ds ON ds.SiteID = v.liSiteID
  INNER JOIN [DynaMiX].[DynaMiX_Groups].[Groups] g ON g.GroupId = ds.GroupId
WHERE v.iVehicleID = 53                                                                                 -- TODO: REPLACE THIS

-- A temp table with all the LATEST command 45 receiced per unit
DECLARE @dateForCommand45ToInclude NVARCHAR(20) = '2021-04-17 00:20';

SELECT m.liMessageID, msh.liMessageID, msh.dtEntered, m.ucstate, sParams, m.dtStarts, m.sNotes, msh.sNotes, msh.dtTimeStamp, *
FROM dbo.messages m WITH (NOLOCK)
  INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
WHERE
      sParams LIKE '%CommandID=45 ;%'
  AND iVehicleID = 93
ORDER BY m.liMessageID DESC

--DEVICECONFIG

SELECT TOP 50

  MessageId, MessageSubType, ParamsJson, *

FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum

WHERE ParamsJson LIKE '%"CommandId":45,%'

  AND mum.MobileUnitId = 1113579701291151360


------------------------
-- GET QUICK LAST 500 for both

-- FM
SELECT top 500 m.liMessageID, msh.liMessageID, msh.dtEntered, m.ucstate, sParams, m.dtStarts, m.sNotes, msh.sNotes, msh.dtTimeStamp, *
FROM dbo.messages m WITH (NOLOCK)
  INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
WHERE
      sParams LIKE '%CommandID=45 ;%'
ORDER BY msh.dtEntered DESC


-- MESA
SELECT TOP 500
  MessageId, MessageSubType, ParamsJson, *
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum  WITH (NOLOCK)
WHERE ParamsJson LIKE '%"CommandId":45,%'
Order by CreationDateUtc DESC


--------------------------
-- Get COUNT for BOTH for specific date

DECLARE @afterdate NVARCHAR(50) = '2022-06-01'

-- FM
SELECT top 500 m.liMessageID, iVehicleId, msh.sNotes, msh.dtEntered, sParams, m.dtStarts, msh.dtTimeStamp
FROM dbo.messages m WITH (NOLOCK)
  INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
WHERE
      sParams LIKE '%CommandID=45 ;%'
	AND msh.dtEntered > @afterdate
ORDER BY m.liMessageId, msh.dtEntered DESC


-- MESA
SELECT count(*) 
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum  WITH (NOLOCK)
WHERE ParamsJson LIKE '%"CommandId":45,%'
AND CreationDateUtc > @afterdate

  -- Ensure the AssetId and MobileUnitId is the same
  /*
  SELECT * FROM DeviceConfiguration.[mobileunit].[AssetMobileUnits] amu
  WHERE amu.AssetId = 920658990217211904
  SELECT * FROM DeviceConfiguration.[mobileunit].[MobileUnits] mu
  WHERE mu.MobileUnitKey = 262131
  */
  
	-- LAST 50 for specific unit
	/*
	SELECT TOP 50
	
	  mum.CreationDateUtc, mumh.MessageStatusDateUtc, s.Descr, mum.MessageId, mum.MessageSubType, mum.ParamsJson, *
	
	FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum WITH (NOLOCK)
	LEFT JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessageStateHistory] mumh WITH (NOLOCK) ON mumh.MessageId = mum.MessageId
	LEFT JOIN @status s ON s.MessageStatus = mumh.MessageStatus
	WHERE ParamsJson LIKE '%"CommandId":45,%'
	  AND mum.MobileUnitId = 920658990217211904
	ORDER BY mum.CreationDateUtc DESC, mumh.MessageStateHistoryKey DESC
	*/

	-- LAST 50 Acknowledged command 45 s
	/*
	SELECT TOP 50
	
	  mum.CreationDateUtc, mumh.MessageStatusDateUtc, s.Descr, mum.MessageId, mum.MessageSubType, mum.ParamsJson, *
	
	FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum WITH (NOLOCK)
	LEFT JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessageStateHistory] mumh WITH (NOLOCK) ON mumh.MessageId = mum.MessageId
	LEFT JOIN @status s ON s.MessageStatus = mumh.MessageStatus
	WHERE ParamsJson LIKE '%"CommandId":45,%'
	  --AND mum.MobileUnitId = 920658990217211904
		AND s.Descr = 'Acknowledged'
	ORDER BY mum.CreationDateUtc DESC, mumh.MessageStatusDateUtc DESC
	*/

	-- Getting the status descr
	/*
	DECLARE @status TABLE (
	  MessageStatus INT,
	  Descr         NVARCHAR(200)
	    );
	
	INSERT INTO @status VALUES   (0, 'Unknown');
	INSERT INTO @status VALUES   (1, 'New');
	INSERT INTO @status VALUES   (2, 'Pending');
	INSERT INTO @status VALUES   (3, 'Queued');
	INSERT INTO @status VALUES   (4, 'Sent');
	INSERT INTO @status VALUES   (5, 'Postponed');
	INSERT INTO @status VALUES   (6, 'SendFai1ed');
	INSERT INTO @status VALUES   (7, 'Aborted');
	INSERT INTO @status VALUES   (8, 'Deleted');
	INSERT INTO @status VALUES   (9, 'Received');
	INSERT INTO @status VALUES   (10, 'Accepted');
	INSERT INTO @status VALUES   (11, 'Rejected');
	INSERT INTO @status VALUES   (12, 'Completed');
	INSERT INTO @status VALUES   (13, 'Acknowledged');
	INSERT INTO @status VALUES   (14, 'Expired');
	INSERT INTO @status VALUES   (15, 'DeleteRequested');
	INSERT INTO @status VALUES   (16, 'DeleteQueued');
	INSERT INTO @status VALUES   (17, 'ETAChanged');
	INSERT INTO @status VALUES   (18, 'Read');
	INSERT INTO @status VALUES   (19, 'Close');
	INSERT INTO @status VALUES   (20, 'Arrived');
	INSERT INTO @status VALUES   (21, 'KMETAChanged');
	INSERT INTO @status VALUES   (22, 'Created');
	INSERT INTO @status VALUES   (23, 'SentAwaitingResponse');
	INSERT INTO @status VALUES   (25, 'Complete');
	INSERT INTO @status VALUES   (26, 'Failed');
	INSERT INTO @status VALUES   (27, 'Cancelled');
	INSERT INTO @status VALUES   (28, 'Confirmed');
	*/
```

## Resources
-  [[SR-8111]] (huge)
- ? [[zz_martin SR-10305 [21.7 WIP] MiX4000  MVR Units Losing Timezone Settings]] (maybe part of above)
- SQL
	- C:\Projects\_MiXTelematicsFiles\SQL_MostUsed (1).sql
- [[SR-12935 Command 45 - not received by unit]] (latest)
- [[SR-12041 Send Command 45]] Send Command 45 via FM Time Asjuster (moved the sending app to own place and placed on server)

## Command 45 templates...

```c#
//Get the command for FM
var fmCommand = $"CommandID=45;Params=dword:{param1},dword:{param2},dword:{param3};";
//Get the command for Mesa
var mesaCommand = $"\"CommandId\":45,\"Param1\":{param1},\"Param2\":{param2},\"Param3\":{param3},";
```


## When Sending the Command 45 to Mesa with a blank IMEI

![[Command 45 Blank IMEI issue.png | 500]]

The above code never shows that the IMEI was blank, the command is never sent, but the user thinks it was successful.
- [ ] Should we not notify the user somehow.
- Zonika knows about this

## FM status changes

![[Command 45 FM Status Changes.png | 500]]

- [ ] Why are we changing this 3 times, if it will always stay Pending?



