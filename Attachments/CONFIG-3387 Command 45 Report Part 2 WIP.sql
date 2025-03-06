/*
MiX_Fleet_2013
BasicEnergyServicesPBU_2011
GHOSTesting_2014
DynaMiXTestUnitsV2_2014
*/

-- Get DeviceConfig mobileunits for above orgs IF FM / 4K / 6K
-- Get Asset info from AMU
-- USe AMU to Get all assets and then sites
-- Get all site TZs
-- Get all Messages and states in Asset DB
-- Get all Messages and states in State DB
-- Find all assets where
--		1) There is not acknowledged //Or whatever state(s) we decided
--		2) Where the message string is not correct 



--------------- RUN TO HERE

-- TODO: MR: Double check 1 yr / 6 months back to check messages
-- TODO: MR: Double check which statusses are seen as OK
-- TODO: MR: Double check how we determine command to be sent... ... ...

-- MESSAGE STATUS: TODO: MR: Think we will only show the acknowledged ones? Check with Zonika
IF OBJECT_ID('tempdb..#StatusDescr') IS NOT NULL
    DROP TABLE #StatusDescr;

CREATE TABLE #StatusDescr (
	Id INT,
	Descr NVARCHAR(200)
		);
INSERT INTO #StatusDescr VALUES (0, 'Unknown');
INSERT INTO #StatusDescr VALUES (1, 'New');
INSERT INTO #StatusDescr VALUES (2, 'Pending');
INSERT INTO #StatusDescr VALUES (3, 'Queued');
INSERT INTO #StatusDescr VALUES (4, 'Sent');
INSERT INTO #StatusDescr VALUES (5, 'Postponed');
INSERT INTO #StatusDescr VALUES (6, 'SendFai1ed');
INSERT INTO #StatusDescr VALUES (7, 'Aborted');
INSERT INTO #StatusDescr VALUES (8, 'Deleted');
INSERT INTO #StatusDescr VALUES (9, 'Received');
INSERT INTO #StatusDescr VALUES (10, 'Accepted');
INSERT INTO #StatusDescr VALUES (11, 'Rejected');
INSERT INTO #StatusDescr VALUES (12, 'Completed');
INSERT INTO #StatusDescr VALUES (13, 'Acknowledged');
INSERT INTO #StatusDescr VALUES (14, 'Expired');
INSERT INTO #StatusDescr VALUES (15, 'DeleteRequested');
INSERT INTO #StatusDescr VALUES (16, 'DeleteQueued');
INSERT INTO #StatusDescr VALUES (17, 'ETAChanged');
INSERT INTO #StatusDescr VALUES (18, 'Read');
INSERT INTO #StatusDescr VALUES (19, 'Close');
INSERT INTO #StatusDescr VALUES (20, 'Arrived');
INSERT INTO #StatusDescr VALUES (21, 'KMETAChanged');
INSERT INTO #StatusDescr VALUES (22, 'Created');
INSERT INTO #StatusDescr VALUES (23, 'SentAwaitingResponse');
INSERT INTO #StatusDescr VALUES (25, 'Complete');
INSERT INTO #StatusDescr VALUES (26, 'Failed');
INSERT INTO #StatusDescr VALUES (27, 'Cancelled');
INSERT INTO #StatusDescr VALUES (28, 'Confirmed');

USE DeviceConfiguration;

------------------------------------------------------------------- Get all the Parameters -------------------------

-- ORGS to work with
DECLARE @orgIds TABLE ( 
	Id BIGINT
);
--TODO: MR: This will be a param in the stored proc
/*
INSERT INTO @orgIds VALUES (6047289984099389068);
INSERT INTO @orgIds VALUES (1686880341835301320);
INSERT INTO @orgIds VALUES (-9127061827260636520);
INSERT INTO @orgIds VALUES (-1670888073009243017);
*/
DECLARE @orgIdsCount INT = (SELECT COUNT(*)
FROM @orgIds)
IF (@orgIdsCount = 0)
BEGIN
	--IF no orgs specified, use all
	INSERT INTO @orgIds
	SELECT DISTINCT GroupId
	FROM library.libraries WITH (NOLOCK)
END

-- ASSETS to work with
DECLARE @assetIds TABLE (
	Id BIGINT
);
--TODO: MR: This will be a param in the stored proc
/*
INSERT INTO @assetIds VALUES (-9221740202469002059);
INSERT INTO @assetIds VALUES (-9137721436630085531);
INSERT INTO @assetIds VALUES (-9134296001387990051); --Org not above: -7939468676834550650
INSERT INTO @assetIds VALUES (-9127360644455873785); --Org not above: -8188616783454335581
INSERT INTO @assetIds VALUES (1299040641669939200);
INSERT INTO @assetIds VALUES (1312621635882711284);
INSERT INTO @assetIds VALUES (1347654536621985792);
INSERT INTO @assetIds VALUES (1349931086743943498);
*/
DECLARE @assetIdsCount INT = (SELECT COUNT(*)
FROM @assetIds)
IF (@assetIdsCount = 0)
BEGIN
	--IF no assets specified, use all
	INSERT INTO @assetIds
	SELECT DISTINCT AssetId
	FROM mobileunit.AssetMobileUnits WITH (NOLOCK)
END

-- UNIT TYPES to work with
DECLARE @types NVARCHAR(50) = ''; -- = 'FM,MiX4k';
--TODO: MR: This comes from UI
DECLARE @typeIds TABLE (
	Id INT
);
IF CHARINDEX('FM', @types) > 0
BEGIN
	INSERT INTO @typeIds VALUES (1); --FM
END
IF CHARINDEX('MiX4k', @types) > 0
BEGIN
	INSERT INTO @typeIds VALUES (3); --MESA
END
DECLARE @typeIdsCount INT = (SELECT COUNT(*)
FROM @typeIds)
IF (@typeIdsCount = 0)
BEGIN
	--IF no types specified, use all
	INSERT INTO @typeIds VALUES (1); --FM
	INSERT INTO @typeIds VALUES (3); --MESA
END



------------------------------------------------------------------- Get all Assets and set Blank Messages  -------------------------

-- BOTH FM AND MESA -----------------------------------------------------------
USE DeviceConfiguration;

-- Get all FM, MESA (4K, 6K) mobile units, for these orgs, assets, types...

IF OBJECT_ID('tempdb..#mobileUnits') IS NOT NULL
    DROP TABLE #mobileUnits;

CREATE TABLE #mobileUnits (
	GroupId BIGINT,
	AssetId BIGINT,
	MobileUnitId BIGINT,
	[Description] NVARCHAR(250),
	LegacyOrgId INT,
	LegacyVehicleId INT,
	MobileUnitKey INT,
	MobileDeviceType INT,
	liGMTOffset INT,
	DisplayTimeZone NVARCHAR(500),
	[Message] NVARCHAR(500)
);

-- All Mobile units for specified orgids, assetids, unit types
INSERT INTO #mobileUnits
SELECT 
	ll.GroupId,
	amu.AssetId, 
	mu.MobileUnitId, 
	dmdt.[Description], 
	LegacyOrgId, 
	LegacyVehicleId, 
	mu.MobileUnitKey, 
	dmdt.MobileDeviceType, 
	0 as liGMTOffset, --This could give issues if the GMTOffset for this was not found, however, this shouldn't be the case
	'' as DisplayTimeZone,
	'' as [Message] --By default all devices will return an issue with the blank Message until we retrieve the latest from the DB
FROM mobileunit.MobileUnits mu WITH (NOLOCK)
	JOIN definition.MobileDevices dmd WITH (NOLOCK) on dmd.DeviceKey = mu.MobileDeviceKey
	JOIN definition.MobileDeviceTypes dmdt WITH (NOLOCK) on dmdt.MobileDeviceType = dmd.MobileDeviceType
	JOIN mobileunit.AssetMobileUnits amu WITH (NOLOCK) on amu.MobileUnitKey = mu.MobileUnitKey
	JOIN template.ConfigurationGroups tcg WITH (NOLOCK) ON tcg.ConfigurationGroupKey = mu.ConfigurationGroupKey
	JOIN library.libraries ll WITH (NOLOCK) on ll.LibraryKey = tcg.LibraryKey
	JOIN @orgIds orgIds ON orgIds.id = ll.GroupId
	JOIN @assetIds assetIds ON assetIds.id = amu.AssetId
	JOIN @typeIds typeIds ON typeIds.id = dmdt.MobileDeviceType

------------------------------------------------------------------- Get all Latest Messages for MESA  -------------------------
-- TODO: MR: Ensure there are no other messages in queue which could overwrite this one

-- MESA --------------------
-- Find all messages for these mobileunits which are MESA devices
USE [DeviceConfiguration.DataProcessing];

-- All Messages
DECLARE @messages TABLE (
	MobileUnitId BIGINT,
	MessageStatus INT,
	Descr NVARCHAR(50),
	ParamsJson NVARCHAR(MAX),
	CreationDateUtc DATETIME
);
INSERT INTO @messages
SELECT DISTINCT
	msg.MobileUnitId,
	msgh.MessageStatus,
	s.Descr,
	ParamsJson,
	msg.CreationDateUtc
FROM [state].[MobileUnitMessage] msg WITH (NOLOCK)
	JOIN [state].[MobileUnitMessageStateHistory] msgh WITH (NOLOCK) ON msgh.MessageKey = msg.MessageKey
	JOIN #StatusDescr s ON s.Id = msgh.MessageStatus
	JOIN #mobileUnits mu ON mu.MobileUnitId = msg.MobileUnitId
WHERE REPLACE(ParamsJson, ' ', '') LIKE '%"CommandId":45,%'
	AND s.Id IN (9, 10, 25, 28) --(9)'Received', (10)'Accepted', (25)'Complete', (28)'Confirmed' --TODO: MR: Confirm
	AND CreationDateUtc >= DATEADD(YEAR, -1, GETDATE()) --Last year
	AND mu.MobileDeviceType IN (3); --MESA
--MESA only
--AND (ExpiryDateUtc >= @now
--OR (ExpiryDateUtc < @now AND msgh.MessageStatus in (13, 25)))

-- Select Only last message for each mobile unit
DECLARE @lastmessages TABLE (
	MobileUnitId BIGINT,
	MessageStatus INT,
	Descr NVARCHAR(50),
	ParamsJson NVARCHAR(MAX),
	CreationDateUtc DATETIME,
	rn INT
);
INSERT INTO @lastmessages
SELECT *
FROM (
  SELECT MobileUnitId, MessageStatus, Descr, ParamsJson, CreationDateUtc, ROW_NUMBER() OVER (PARTITION BY MobileUnitId ORDER BY CreationDateUtc DESC) AS rn
	FROM @messages
) t
WHERE rn = 1;

-- TODO: MR: No longer needed.... just link... NEW table to link last message with mobileunit
-- MARK those without message - I think just add params





------------------------------------------------------------------- Get all Latest Messages for FM  -------------------------
-- TODO: MR: Ensure there are no other messages in queue which could overwrite this one

-- FM --------------------

-- @orgIds holds all the orgids, but these are for mesa and fm
-- it MIGHT be that once we got only valid mobile units,
-- that we have fewer orgids to work with...
-- So I will now just get orgIds for units which have valid mobile units

DECLARE @validAssetDBOrgIds TABLE (
	Id BIGINT
);
INSERT INTO @validAssetDBOrgIds
SELECT DISTINCT GroupId
FROM #mobileUnits
-- WHERE MobileDeviceType = 1; --FM only, NO, we also need SITE info for MESA

-- Get all Org TZ offsets

-- FM ORG Information
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
	JOIN [Fmonlinedb].[DynaMiX].[Organisations] dynO WITH (NOLOCK) ON dynO.OrganisationId = dboO.liOrgID
	JOIN @validAssetDBOrgIds orgIds ON orgIds.Id = dynO.GroupId
WHERE bActive = 1

-- Get all assets > messenges: WIP 

DECLARE @SQL NVARCHAR(MAX)

-- Get all Sites for Assets that has units attached
IF OBJECT_ID('tempdb..#Sites') IS NOT NULL
    DROP TABLE #Sites;

CREATE TABLE #Sites
(
	MobileUnitId BIGINT, 
	liOrgID INT,
	liSiteID INT, 
	sName NVARCHAR(500), 
	DisplayTimeZone NVARCHAR(500)
)

-- Store only the latest message for each asset
IF OBJECT_ID('tempdb..#lastmessagesFM') IS NOT NULL
    DROP TABLE #lastmessagesFM;

CREATE TABLE #lastmessagesFM 
(
	MobileUnitId BIGINT,
	MessageStatus INT,
	Descr NVARCHAR(50),
	ParamsJson NVARCHAR(MAX),
	CreationDateUtc DATETIME,
	rn INT
);


DECLARE @dbName NVARCHAR(500)
DECLARE @orgid INT
DECLARE dbCursor CURSOR FOR
SELECT sConnectDatabase, liOrgID
FROM @organisations

OPEN dbCursor
FETCH NEXT FROM dbCursor INTO @dbName, @orgid

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @SQL = N'USE ' + QUOTENAME(@dbName) + N';

		--Get all Site information needed for ALL assets
		INSERT INTO #Sites
			SELECT 
			mu.MobileUnitId, 
			mu.LegacyOrgId as liOrgID,
			s.liSiteID, 
			s.sName, 
			g.DisplayTimeZone
			FROM #mobileUnits mu
			INNER JOIN dbo.Vehicles v WITH (NOLOCK) ON v.iVehicleID = mu.LegacyVehicleId
			INNER JOIN dbo.Sites s WITH (NOLOCK) ON s.liSiteID = v.liSiteID
			INNER JOIN dynamix.Sites ds WITH (NOLOCK) ON ds.SiteID = v.liSiteID
			INNER JOIN [DynaMiX].[DynaMiX_Groups].[Groups] g WITH (NOLOCK) ON g.GroupId = ds.GroupId
			WHERE mu.LegacyOrgId = ' + CAST(@orgid AS NVARCHAR(250)) + N';

		--Get all Messages For FMs
		DECLARE @messagesFM TABLE (
			MobileUnitId BIGINT,
			MessageStatus INT,
			Descr NVARCHAR(50),
			ParamsJson NVARCHAR(MAX),
			CreationDateUtc DATETIME
		);
		INSERT INTO @messagesFM
		SELECT DISTINCT
			mu.MobileUnitId,
			m.ucState as MessageStatus,
			s.Descr,
			m.sParams as ParamsJson,
			m.dtStarts as CreationDateUtc
		FROM #mobileUnits mu
			JOIN [dbo].[Messages] m WITH (NOLOCK) ON m.iVehicleID = mu.LegacyVehicleId
			--INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
			JOIN #StatusDescr s ON s.Id = m.ucState
		WHERE mu.MobileDeviceType IN (1) --FM
			AND REPLACE(sParams, '' '', '''') LIKE ''CommandID=45;%''
			AND s.Id IN (9, 10, 25, 28) --(9) Received, (10) Accepted, (25) Complete, (28) Confirmed --TODO: MR: Confirm
			AND dtStarts >= DATEADD(YEAR, -1, GETDATE());

		--Get only last Message for each Asset with a Mobile Unit - FM
		INSERT INTO #lastmessagesFM
		SELECT *
		FROM (
		SELECT MobileUnitId, MessageStatus, Descr, ParamsJson, CreationDateUtc, ROW_NUMBER() OVER (PARTITION BY MobileUnitId ORDER BY CreationDateUtc DESC) AS rn
			FROM @messagesFM
		) t
		WHERE rn = 1;

		'

	EXEC sp_executesql @SQL
	---

	FETCH NEXT FROM dbCursor INTO @dbName, @orgid
END

CLOSE dbCursor
DEALLOCATE dbCursor


--------------------- Only the last messages combined (FM and MESA)

DECLARE @combinedLastMessages TABLE
(
	MobileUnitId BIGINT,
	ParamsJson NVARCHAR(MAX),
	DisplayTimeZone NVARCHAR(500),
	liGMTOffset INT
)


--SELECT * FROM @organisations
--SELECT * FROM #mobileUnits WHERE LegacyOrgId = 178
--SELECT top 50 * FROM #Sites
--SELECT * FROM #lastmessagesFM

-- Get Each MobileUnit with it's appropriate last message, if any
-- AND site TimeZone, to test if this paramsJson is actually the correct last one
--TODO: MR: Still busy figuring out how to get the last DST date and offset before and after
-- BELOW is still a huge WIP.... if I add in WHERE to for NULL it will be all those with NO message
-- THEN I can run the calc against those who DO have values... if ParamsJson is WRONG... needs new Message
-- Can return BOTH these for re-sending from the app
INSERT INTO @combinedLastMessages
SELECT 
	mu.MobileUnitId,
	CASE 
		WHEN mu.MobileDeviceType = '3' THEN lastM.ParamsJson --MESA
		WHEN mu.MobileDeviceType = '1' THEN lastF.ParamsJson --FROM
		ELSE NULL
	END as ParamsJson,
	s.DisplayTimeZone,
	o.liGMTOffset
FROM #mobileUnits mu
LEFT JOIN #Sites s on s.MobileUnitId = mu.MobileUnitId
LEFT JOIN @organisations o ON o.liOrgID = s.liOrgID
LEFT JOIN @lastmessages lastM on lastM.MobileUnitId = mu.MobileUnitId
LEFT JOIN #lastmessagesFM lastF on lastF.MobileUnitId = mu.MobileUnitId
--WHERE messageSent IS NULL

-- NOW add all the potential messages, offsets, timezone info to the MobileUnits
UPDATE mu
SET
	mu.[Message] = m.ParamsJson,
	mu.DisplayTimeZone = m.DisplayTimeZone,
	mu.liGMTOffset = m.liGMTOffset
FROM #mobileUnits mu
JOIN @combinedLastMessages m ON mu.MobileUnitId = m.MobileUnitId


SELECT * 
FROM #mobileUnits

------------------------------------------------------------------- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  -------------------------


--These dont have ANY messages sent, setting the NoMessage BIT
/*
UPDATE #mobileUnits
SET NoMessage = 1
WHERE MobileUnitId IN
(
	SELECT MobileUnitId FROM @combinedLastMessages clm
	WHERE clm.ParamsJson IS NULL
)
*/


-- LAST BIT: Get all the actual sParams you were expecting for eacg siteID
-- Compare with the one sent
-- IF not the same set WrongMessage = 1

-- Get all Sites which need to be calculated
/*
SELECT DISTINCT s.* 
FROM #Sites s
JOIN #mobileUnits mu on mu.MobileUnitId = s.MobileUnitId
Where mu.NoMessage = 0
*/

-- FM: CommandID=45 ;Params=dword:0,dword:3600,dword:1678586400 ;
-- MESA: {"CommandId":45,"Param1":7200,"Param2":7200,"Param3":946688400,"ConfigVersion":null,"FirmwareVersion":null,"CommandType":null,"Value":null,"ParamDictionary":null}

--SELECT * FROM @combinedLastMessages
--SELECT * FROM #mobileUnits


----------------------------------- THIS WILL HAVE TO HAPPEN IN CODE!!!!!


--TODO: MR: The rest need the calculation to see if the message sent was correct...
-- TODO: MR: Setting the WrongMessage BIT
-- YIKES!!



-- ALL Messages Asset
-- LAST Messages for Asset
-- 3) Site Info for Assets
-- Combine all this into an AssetDBTable with what is needed


--------------- RUN TO HERE

/*

-- TODO: MR: Get a way to convert DisplayTimeZone to actual seconds offset
-- DO CALC to figure out what message should have been for this unit
-- SEEING it is trying to find those NOT sent - should it look BACK? for PREVIOUS offset? Think so?
-- So NOT forward.... ??


*/
