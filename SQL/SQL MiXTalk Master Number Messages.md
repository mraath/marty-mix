---
created: 2024-02-29T17:02
updated: 2024-02-29T17:02
---
```sql

DECLARE @id BIGINT  = 1005693082251071488; --CHANGE THIS

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

--Properties (MasterNumber, etc)
SELECT * FROM [DeviceConfiguration].[mobileunit].[AssetProperties] 
WHERE AssetId = @id
AND PropertyId = -6213542348403873926; --MasterNumber

--Messages sent for this unit
SELECT --top 50 
  SUBSTRING(ParamsJson, CHARINDEX('CommandType', ParamsJson)+14, 250), 
  mum.CreationDateUtc, MessageStatusDateUtc, s.Descr, s.MessageStatus, MessageId, * -- MessageKey, ParamsJson, CreationDateUtc, ExpiryDateUtc, MessageStatus 
  FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum
  INNER JOIN @status s ON s.MessageStatus = mum.MessageStatus
  WHERE 
  MobileUnitId = @id
  --AND ParamsJson LIKE '%"CommandType":"KeypadNumber1%'
  AND MessageSubType=255
  AND mum.CreationDateUtc > '2020-08-04 13:00' --Change this if needed
  ORDER BY mum.CreationDateUtc DESC
```