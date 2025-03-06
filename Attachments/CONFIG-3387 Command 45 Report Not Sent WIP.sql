------------------------------------------------------------------------------------------------------------------------------
/*
FM: 
dbo.messages
dbo.messagestatehistory

MESA:
[state].[MobileUnitMessage]
[state].[MobileUnitMessageStateHistory]
*/
------------------------------------------------------------------------------------------------------------------------------

-- MESSAGE STATUS: TODO: MR: Think we will only show the acknowledged ones? Check with Zonika
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

-- FM --------------------

--ASSET DB
-- Get all Org TZ offsets
DECLARE @groupIds TABLE (
	Id BIGINT
);
INSERT INTO @groupIds VALUES (6047289984099389068);
INSERT INTO @groupIds VALUES (1686880341835301320);
INSERT INTO @groupIds VALUES (-9127061827260636520);
INSERT INTO @groupIds VALUES (-1670888073009243017);

DECLARE @orgCount INT = (SELECT COUNT(*) FROM @groupIds)

-- ORG Information
DECLARE @organisations TABLE (
	GroupId BIGINT, 
	liOrgID INT, 
	sOrganisationName NVARCHAR(250), 
	sConnectDatabase NVARCHAR(250), 
	liGMTOffset INT
);

INSERT INTO @organisations
SELECT GroupId, liOrgID, sOrganisationName, sConnectDatabase, liGMTOffset
FROM Fmonlinedb.dbo.organisation dboO WITH (NOLOCK)
INNER JOIN [Fmonlinedb].[DynaMiX].[Organisations] dynO WITH (NOLOCK) ON dynO.OrganisationId = dboO.liOrgID
LEFT JOIN @groupIds groupIds ON groupIds.id = dynO.GroupId
WHERE (@orgCount > 0 AND groupIds.id IS NOT NULL) OR (@orgCount = 0)
	AND bActive = 1

-- PER ORG ---------------------------------------------------------------------

-- Get DeviceConfig mobileunits for above orgs IF FM / 4K / 6K
-- Get Asset info from AMU
-- USe AMU to Get all assets and then sites
-- Get all site TZs
-- Get all Messages and states in Asset DB
-- Get all Messages and states in State DB
-- Find all assets where
--		1) NO messages... flagged and asset taken out of list to process to speed up
--		2) There is not acknowledged //Or whatever state(s) we decided
--		3) Where the message string is not correct 

--SELECT * FROM @organisations


-- TODO: MR: This will become dynamic

DECLARE @SQL NVARCHAR(MAX)

CREATE TABLE #Results
(
    iVehicleID INT,
    liSiteID INT
)

DECLARE @dbName NVARCHAR(50)
DECLARE dbCursor CURSOR FOR
SELECT sConnectDatabase FROM @organisations

OPEN dbCursor
FETCH NEXT FROM dbCursor INTO @dbName

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @SQL = N'USE ' + QUOTENAME(@dbName) + N';
				SELECT top 10 iVehicleID, liSiteID FROM [dbo].[Vehicles];'
	--SET @SQL = 'SELECT ''' + @DbName + ''' AS DbName, ''' + @TableName + ''' AS TableName, Column1, Column2 FROM ' + QUOTENAME(@DbName) + '..' + QUOTENAME(@TableName)
    INSERT INTO #Results
    EXEC sp_executesql @SQL
	---

    FETCH NEXT FROM dbCursor INTO @dbName
END

CLOSE dbCursor
DEALLOCATE dbCursor

SELECT * FROM #Results


------


/*
-- LAST YEAR

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

--DEVICECONFIG

SELECT TOP 50
	MessageId, MessageSubType, ParamsJson, *
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum
WHERE ParamsJson LIKE '%"CommandId":45,%'
	AND mum.MobileUnitId = 1113579701291151360

------------------------
-- GET QUICK LAST 500 for both

-- FM
SELECT top 500
	m.liMessageID, msh.liMessageID, msh.dtEntered, m.ucstate, sParams, m.dtStarts, m.sNotes, msh.sNotes, msh.dtTimeStamp, *
FROM dbo.messages m WITH (NOLOCK)
	INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
WHERE
      sParams LIKE '%CommandID=45 ;%'
ORDER BY msh.dtEntered DESC

-- LAST YEAR

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


-- MESA
SELECT TOP 500
	MessageId, MessageSubType, ParamsJson, *
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum  WITH (NOLOCK)
WHERE ParamsJson LIKE '%"CommandId":45,%'
Order by CreationDateUtc DESC


--------------------------
-- Get COUNT for BOTH for specific date

DECLARE @afterdate NVARCHAR(50) = '2022-06-01'

-- FM
SELECT top 500
	m.liMessageID, iVehicleId, msh.sNotes, msh.dtEntered, sParams, m.dtStarts, msh.dtTimeStamp
FROM dbo.messages m WITH (NOLOCK)
	INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
WHERE
      sParams LIKE '%CommandID=45 ;%'
	AND msh.dtEntered > @afterdate
ORDER BY m.liMessageId, msh.dtEntered DESC


-- MESA
SELECT count(*)
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum  WITH (NOLOCK)
WHERE ParamsJson LIKE '%"CommandId":45,%'
	AND CreationDateUtc > @afterdate

	*/

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
