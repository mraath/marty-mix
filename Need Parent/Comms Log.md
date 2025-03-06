---
created: 2024-11-20T12:05
updated: 2024-11-21T15:35
---
## Overview

![[Comms Log.excalidraw]]

## Comms Log Order: Config Upload

![[SR-14483 Comms log order not great#Next Steps]]

## Type Ids

**SendFirmware** = 103
SendConfiguration = 102
SendConfigurationToStandAloneDevice = 108
**SendConfig** = 254
**SendSettings** = 255

## ?MESA

http://localhost/MiXFleet.UI/#/config-admin/comms-log?id=1086005172591616000&orgId=-7094567047859310012&device=MiX4000&modal=true

```
IN UI it will change under these circumstances

case "MiX3000":
case "MiX4000":
case "MiX6000":
case "MiX6000 LTE":
case "MiX2310i":
case "MiX2000":
	url = '/config-admin/comms-log';
```

FE
	getCommsLogFirmware ==Firmware==
	getCommsLogConfig ==Config==

BE
	ModuleRoutes.GetCommsLogFirmware
		CommsLogModule.GetCommsLogFirmware
			List<long typeIds = new List<long { (long)CommandIdType.SendFirmware };
			var statuses = DeviceConfigClient.MobileUnits.GetLastMessageStatusesForTypes(authToken, orgId, assetId, typeIds).ConfigureAwait(false).GetAwaiter().GetResult();
			(It then gets converted to a carrier)
	ModuleRoutes.GetCommsLogConfig
		CommsLogModule.GetCommsLogConfig
			List<long typeIds = new List<long { (long)CommandIdType.SendConfig, (long)CommandIdType.SendSettings };
			var statuses = DeviceConfigClient.MobileUnits.GetLastMessageStatusesForTypes(authToken, orgId, assetId, typeIds).ConfigureAwait(false).GetAwaiter().GetResult();
			(It then gets converted to a carrier)
Client
	==DeviceConfigClient.MobileUnits.GetLastMessageStatusesForTypes==
API
	Route > Controller > Man > Command > DB
DB
	?? [state].[MobileUnitMessage_GetLastMessageStatusesForTypes]

### SQL Test

```sql
-- TEST OE-515 check commands to see which to alert on

USE [DeviceConfiguration.DataProcessing];

-- TEST DATA NEEDED
-- AssetId: 1086005172591616000

-- STATUS VALUES

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

-- Procedure to retrieve the last messages' statuses for the specified type of messages for a specific mobile unit
DECLARE     @mobileUnitId     BIGINT = 8472800361954900260; --1086004667345240064; --1450923827225116672; -- 1086005172591616000;
DECLARE     @idList           [dbo].[SelectionIds];
INSERT INTO @idList VALUES (254); --config
INSERT INTO @idList VALUES (255); --setting
INSERT INTO @idList VALUES (103); --FW


-- OLD way to get messages grouped
/*
SELECT  c.MessageSubType, 
        msh.MessageStatusDateUtc, 
        msh.MessageStatus,
        c.Value,
        s.Descr
FROM    (
        SELECT  mum.MessageSubType, 
                mum.CreationDateUtc, 
                mum.MessageStatusDateUtc, 
                -- mum.MessageId, 
                mum.MessageKey,
                mum.Value,
                ROW_NUMBER() OVER ( PARTITION BY mum.MessageSubType ORDER BY mum.CreationDateUtc DESC ) AS rn
        FROM    @idList ids
        JOIN    [state].[MobileUnitMessage] mum
                ON mum.MessageSubType = ids.id 
        WHERE   mum.MobileUnitId = @mobileUnitId
    ) c
INNER JOIN  [state].[MobileUnitMessageStateHistory] msh
            ON c.MessageKey=msh.MessageKey
INNER JOIN  @status s
            ON s.MessageStatus = msh.MessageStatus
--WHERE       rn in (1)
WHERE       rn = 1
Order by    c.MessageSubType, msh.MessageStatusDateUtc
*/


---- NOW only show alert or not
/*
SELECT CASE 
    WHEN MAX(c.CreationDateUtc) < DATEADD(day, -5, GETDATE()) 
         AND MAX(msh.MessageStatus) IN (22, 23) 
    THEN 'Alert'
    ELSE 'No Alert'
END AS AlertStatus
FROM    (
        SELECT  mum.MessageSubType, 
                mum.CreationDateUtc, 
                mum.MessageKey,
                mum.Value,
                mum.MobileUnitId,
                ROW_NUMBER() OVER ( PARTITION BY mum.MessageSubType ORDER BY mum.CreationDateUtc DESC ) AS rn
        FROM    @idList ids
        JOIN    [state].[MobileUnitMessage] mum
                ON mum.MessageSubType = ids.id 
        WHERE   mum.MobileUnitId = @mobileUnitId
    ) c
INNER JOIN  [state].[MobileUnitMessageStateHistory] msh
            ON c.MessageKey = msh.MessageKey
*/




-- NOW only insert ALERT into a tmp table

DECLARE @configGroups TABLE (
    MobileUnitId BIGINT
    -- Add any other necessary columns
);

-- Insert your mobile unit IDs into @configGroups
-- MESAs
INSERT INTO @configGroups (MobileUnitId) VALUES (1086005172591616000);
INSERT INTO @configGroups (MobileUnitId) VALUES (1450923827225116672);
INSERT INTO @configGroups (MobileUnitId) VALUES (1086004667345240064);
-- FMs?
-- TODO: MR: ADD a few




WITH LastMessageStatus AS (
    SELECT  
        mum.MobileUnitId,
        mum.MessageSubType, 
        MAX(mum.CreationDateUtc) AS CreationDateUtc,
        MAX(msh.MessageStatus) AS MessageStatus
    FROM    @idList ids
    JOIN    [state].[MobileUnitMessage] mum
            ON mum.MessageSubType = ids.id 
    JOIN    @configGroups cg
            ON mum.MobileUnitId = cg.MobileUnitId
    INNER JOIN  [state].[MobileUnitMessageStateHistory] msh
            ON mum.MessageKey = msh.MessageKey
    GROUP BY mum.MobileUnitId, mum.MessageSubType
)

SELECT 
    MobileUnitId,
    MessageSubType
    /*,
    CASE 
        WHEN CreationDateUtc < DATEADD(day, -5, GETDATE()) 
             AND MessageStatus IN (22, 23) 
        THEN 'Alert'
        ELSE 'No Alert'
    END AS AlertStatus*/
FROM LastMessageStatus
WHERE CreationDateUtc < DATEADD(day, -5, GETDATE()) 
             AND MessageStatus IN (22, 23)


```

## ? FM

http://localhost/MiXFleet.UI/#/scheduler/view-log?type=upload&id=108&orgId=-7094567047859310012&assetId=8472800361954900260&modal=true

FE
	"Comms Log"
	this.configModules.getConfigUploadLog(this.params)
		BE
			ModuleRoutes.GET_UPLOAD_SCHEDULER_LOG
			UploadScheduleListModule.GetUploadSchedulerLog
			logs = DataScheduleManager.GetLogForSchedule(authToken, orgId, scheduleId, lastReceivedLogId, asset.SiteId);
				AssetDB: [dynamix].[DataScheduleLog_GetLatestByScheduleId]
	this.module.getUploadLog(this.params)
		BE
			ModuleRoutes.GET_UPLOAD_SCHEDULER_LOG (same as one above...)

## SQL Testing FM Config and FM upload

```sql

```