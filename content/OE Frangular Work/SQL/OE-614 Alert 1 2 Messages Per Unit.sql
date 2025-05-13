USE [DeviceConfiguration.Dataprocessing];

-- Status
DECLARE @status TABLE (   MessageStatus INT,   Descr         NVARCHAR(200)     );
INSERT INTO @status VALUES
  (0, 'Unknown'),   (1, 'New'),   (2, 'Pending'),   (3, 'Queued'),   (4, 'Sent'),   (5, 'Postponed'),   (6, 'SendFai1ed'),   (7, 'Aborted'),
  (8, 'Deleted'),   (9, 'Received'),   (10, 'Accepted'),   (11, 'Rejected'),   (12, 'Completed'),   (13, 'Acknowledged'),   (14, 'Expired'),
  (15, 'DeleteRequested'),   (16, 'DeleteQueued'),   (17, 'ETAChanged'),   (18, 'Read'),   (19, 'Close'),   (20, 'Arrived'),   (21, 'KMETAChanged'),
  (22, 'Created'),   (23, 'SentAwaitingResponse'),   (25, 'Complete'),   (26, 'Failed'),   (27, 'Cancelled'),   (28, 'Confirmed');

-- Actual query

SELECT
    mum.MessageKey, mum.CreationDateUtc, mum.MessageSubType, s.Descr, mum.UserName,
    *
    FROM [state].[MobileUnitMessage] mum
    INNER JOIN [state].[MobileUnitMessageStateHistory] msh ON mum.MessageKey = msh.MessageKey
    LEFT OUTER JOIN @status s ON s.MessageStatus = msh.MessageStatus
WHERE mum.MessageSubType in (103, 254, 255)
AND CreationDateUtc > DATEADD(DAY, -6, GETDATE())
AND mum.MobileUnitId = 1522731665984569344
ORDER BY mum.MessageKey Desc, msh.MessageStateHistoryKey DESC, mum.CreationDateUtc DESC

/*
AMY BENCH UNITS

FW Upload expired:
1596635336800804864 (003 MiX4000)               > SQL, Firmware package loaded from database (2025/05/09), Configuration file loaded from database (2025/05/09)
1631447698450665472 (002 MiX4000)               > Firmware package loaded from database (2025/03/28), Configuration file loaded from database (2025/05/12)
1646589414582132736 (001 MiX4000 + STM 2.0)     > Firmware package loaded from database (2025/04/09), Configuration file loaded from database (2025/05/12)

ALERT 1

na

ALERT 2

1656766446900490240 (alert_2 check...)          > Config Alert 1: Configuration file loaded from database (2025/05/07)

*/