---- Get Config Groups to test against

USE DeviceConfiguration;

DECLARE @OrgId BIGINT = -4493495256567590976;

SELECT * FROM library.Libraries ll
WHERE ll.GroupId = @OrgId

SELECT * FROM [template].[ConfigurationGroups] tcg WITH (NOLOCK) 
WHERE tcg.LibraryKey = 1202

---- Get Org Info

DECLARE @GroupId BIGINT = -4493495256567590976;
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId

DECLARE @lorgID INT = (SELECT OrganisationId
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId)

SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID

----- Get Data Schedule Log

/*
DECLARE @selectionIds TABLE
(
	Id BIGINT
) --AssetIds
INSERT INTO @selectionIds VALUES (1328778456133091328);
*/

IF OBJECT_ID('tempdb..#schedule') IS NOT NULL
    DROP TABLE #schedule;

CREATE TABLE #schedule
(
    [ScheduleId] INT,
	[AssetId] BIGINT,
	[LastRun] DATETIME,
	--[NextRun] DATETIME,
	--[DateProcessed] DATETIME,
	--[Retries] INT,
	--[MaxRetries] INT,
    --[LastEditedBy] NVARCHAR(50),
    [LastLogEntry] NVARCHAR(500)
)

USE EttienneBenchUnitsDONOTEDIT_2020;

;WITH ScheduleLogIds as 
(
	SELECT 
		MAX(DataScheduleLogID) DataScheduleLogID, 
		a.VehicleId, 
		a.AssetId
	FROM dbo.DataScheduleLog dsl 
	JOIN dbo.DataSchedule ds on ds.liSchedId = dsl.liSchedId 
	JOIN dynamix.Assets a on a.VehicleId = ds.liObjectID		
	--JOIN @selectionIds ids on ids.id = a.AssetId
	WHERE CAST((CAST(bUploadConfig as tinyint) + CAST(bUploadDDRs as tinyint) + 
            bUploadDDRs +  ucUploadTerminalScript + ucUploadTerminalDDM + 
            ucUploadTerminalDB + ucUploadCanDDM + ucUploadExtendedConfigBIN) as bit) = 1
	GROUP by
		a.VehicleId , a.AssetId
)


INSERT INTO #schedule
SELECT 
	[ScheduleId] = ads.UploadScheduleId,
	[AssetId] = logIds.AssetId,
	[LastRun] = ds.dtLastRun,
	--[NextRun] = ds.dtNextRun,
	--[DateProcessed] = ds.dtProcessed,
	--[Retries] = ds.ucRetries,
	--[MaxRetries] = ds.ucMaxRetries,
    --[LastEditedBy] = ds.LastEditedBy,
    [LastLogEntry] = [dynamix].[GetLatestScheduleLogMsgByScheduleId] (ds.[liSchedID], null)
FROM ScheduleLogIds logIds 
JOIN dynamix.AssetDataSchedules ads ON ads.AssetId = logIds.AssetId
JOIN dbo.DataSchedule ds on ds.liObjectId = logIds.VehicleId and ds.liSchedID = ads.UploadScheduleId

SELECT * FROM #schedule


----- MESA Messages

-- Send messages types
DECLARE @typeList TABLE
(
	Id BIGINT
) --types to get messages sent for
INSERT INTO @typeList VALUES (254); -- SendConfig
INSERT INTO @typeList VALUES (103); -- SendFirmware
INSERT INTO @typeList VALUES (255); -- SendSettings

DECLARE @mobileUnitIds TABLE
(
	Id BIGINT
) --mobile unit ids to include
INSERT INTO @mobileUnitIds Select mu.MobileUnitId FROM [DeviceConfiguration].mobileunit.MobileUnits mu;

	CREATE TABLE #t
	(
		mobId  BIGINT NOT NULL,
		typeId BIGINT NOT NULL,
		PRIMARY KEY (typeId,mobId)
	)

	INSERT INTO #t
	SELECT m.id, t.id
	FROM @typeList t
			CROSS JOIN @mobileUnitIds m
	GROUP BY m.id, t.id

	SELECT c.MessageSubType,
		MessageStatusDateUtc,
		MessageStatus,
		MobileUnitId
	FROM (
			SELECT mum.MessageSubType,
			mum.CreationDateUtc,
			mum.MessageStatusDateUtc,
			mum.MessageId,
			mum.MessageStatus,
			mum.MessageKey,
			ROW_NUMBER() OVER ( PARTITION BY mum.MobileUnitId ORDER BY mum.MessageStatusDateUtc DESC ) AS rn, MobileUnitId
		FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum  WITH (NOLOCK)
			JOIN #t muIds
			ON muIds.mobId = mum.MobileUnitId
				AND mum.MessageSubType = muIds.typeId
		) c
	WHERE       rn IN (1)
	ORDER BY    MobileUnitId,c.MessageSubType, MessageStatusDateUtc

	DROP TABLE #t
