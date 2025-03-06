---
created: 2024-02-29T17:05
updated: 2024-02-29T17:05
---
```sql

DECLARE @legacyOrgId INT  = 748; --CHANGE THIS

DECLARE @status TABLE (
  MessageStatus        INT,
  Descr                NVARCHAR(200)
);
INSERT INTO @status VALUES (0, 'Unknown');
INSERT INTO @status VALUES (1, 'New');
INSERT INTO @status VALUES (2, 'Pending');
INSERT INTO @status VALUES (3, 'Queued');
INSERT INTO @status VALUES (4, 'Sent');
INSERT INTO @status VALUES (5, 'Postponed');
INSERT INTO @status VALUES (6, 'SendFai1ed');
INSERT INTO @status VALUES (7, 'Aborted');
INSERT INTO @status VALUES (8, 'Deleted');
INSERT INTO @status VALUES (9, 'Received');
INSERT INTO @status VALUES (10, 'Accepted');
INSERT INTO @status VALUES (11, 'Rejected');
INSERT INTO @status VALUES (12, 'Completed');
INSERT INTO @status VALUES (13, 'Acknowledged');
INSERT INTO @status VALUES (14, 'Expired');
INSERT INTO @status VALUES (15, 'DeleteRequested');
INSERT INTO @status VALUES (16, 'DeleteQueued');
INSERT INTO @status VALUES (17, 'ETAChanged');
INSERT INTO @status VALUES (18, 'Read');
INSERT INTO @status VALUES (19, 'Close');
INSERT INTO @status VALUES (20, 'Arrived');
INSERT INTO @status VALUES (21, 'KMETAChanged');
INSERT INTO @status VALUES (22, 'Created');
INSERT INTO @status VALUES (23, 'SentAwaitingResponse');
INSERT INTO @status VALUES (25, 'Complete');
INSERT INTO @status VALUES (26, 'Failed');
INSERT INTO @status VALUES (27, 'Cancelled');
INSERT INTO @status VALUES (28, 'Confirmed');

DECLARE @amu TABLE (
  AssetId         BIGINT,
 	LegacyVehicleId INT
);

INSERT INTO @amu (AssetId, LegacyVehicleId) 
SELECT AssetId, LegacyVehicleId 
FROM [DeviceConfiguration].[mobileunit].[AssetMobileUnits] with (nolock)
WHERE LegacyOrgId = @legacyOrgId;

DECLARE @property TABLE (
  AssetId        BIGINT,
  MiXTalkNumber  NVARCHAR(200)
);

INSERT INTO @property (AssetId, MiXTalkNumber) 
SELECT AssetId, [Value] as MiXTalkNumber 
FROM [DeviceConfiguration].[mobileunit].[AssetProperties] with (nolock)
WHERE AssetId IN (Select AssetId FROM @amu)
AND PropertyId = -6213542348403873926; --MasterNumber

--Messages sent for this unit
SELECT a.AssetId, a.LegacyVehicleId,
  mum.CreationDateUtc, MessageStatusDateUtc, 
  s.Descr, 
  REPLACE(SUBSTRING(ParamsJson, CHARINDEX('CommandType', ParamsJson)+14, 13),'"', '') as MessageDescr, 
  s.MessageStatus, MessageId
  FROM @amu a
  INNER JOIN @property p on p.AssetId = a.AssetId
  LEFT OUTER JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum  with (nolock) ON mum.MobileUnitId = p.AssetId
  INNER JOIN @status s ON s.MessageStatus = mum.MessageStatus
  WHERE 
  MessageSubType = 108
  --AND ParamsJson LIKE '%"CommandType":"KeypadNumber1%'
  --AND mum.CreationDateUtc > '2020-08-04 13:00' --Change this if needed
  ORDER BY a.AssetId, mum.CreationDateUtc DESC


```