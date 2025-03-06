---
created: 2024-01-04T14:51
updated: 2024-01-04T16:37
---

```sql
USE GrainCorp_2009; -- REPLACE THIS
--GET LOWEST amount of Logs
SELECT TOP 100 COUNT(liSchedID), liSchedID
FROM [DataScheduleLog] 
GROUP BY liSchedID
HAVING COUNT(liSchedID) >= 10 AND COUNT(liSchedID) <= 15
ORDER BY COUNT(liSchedID) ASC

--MORE info on a Schedule
SELECT top 5 * FROM DataSchedule WHERE liSchedID = 1753;

--GET a lot of info
SELECT top 100 * FROM DataSchedule 
WHERE liSchedID IN
	(SELECT TOP 100 liSchedID
	FROM [DataScheduleLog] 
	GROUP BY liSchedID
	HAVING COUNT(liSchedID) >= 10 AND COUNT(liSchedID) <= 15
	ORDER BY COUNT(liSchedID) ASC)
AND dtWhen >= '2023-10-01'
--ScheduleID:1753
--ObjId:981

--Get the asset info
SELECT TOP 10 * FROM DeviceConfiguration.mobileunit.AssetMobileUnits amu 
where amu.LegacyOrgId = 1183
AND amu.LegacyVehicleId = 981 

----

--Site timezone
SELECT v.sDesc, s.sName, v.liSiteID, ds.GroupId, g.DisplayTimeZone
FROM dbo.Vehicles v
  INNER JOIN dbo.Sites s ON s.liSiteID = v.liSiteID
  INNER JOIN dynamix.Sites ds ON ds.SiteID = v.liSiteID
  INNER JOIN [DynaMiX].[DynaMiX_Groups].[Groups] g ON g.GroupId = ds.GroupId
WHERE v.iVehicleID = 981                                                                                 -- TODO: REPLACE THIS

----



DECLARE @scheduleId INT = 1753; -- REPLACE THIS
DECLARE @lastReceivedLogId INT = NULL;


	DECLARE	@uploadCallMeBack bit
	DECLARE	@coverageCallMeBack bit
	DECLARE @callMeBackSchedIdText nvarchar(max) = null
	DECLARE @callMeBackSchedId int
	DECLARE @objectId int
	DECLARE	@uploadConfig bit
	DECLARE @uploadDDRs bit
	DECLARE @uploadTerminalScript tinyint
	DECLARE @uploadTerminalDDM tinyint
	DECLARE @uploadTerminalDB tinyint
	DECLARE @uploadCanDDM tinyint
	DECLARE @uploadExtendedConfigBIN tinyint
	DECLARE @isUploadSchedule bit
	DECLARE @isCmbUploadSchedule bit
				
	DECLARE @schedIds TABLE (schedId int);
	INSERT INTO @schedIds VALUES (@scheduleId);
	
	SELECT
		@objectId = liObjectID,
		@uploadCallMeBack = bUploadCallMeBack,
		@coverageCallMeBack = bCoverageCallMeBack,
		@uploadConfig = bUploadConfig,
		@uploadDDRs = bUploadDDRs,
		@uploadTerminalScript = ucUploadTerminalScript,
		@uploadTerminalDDM = ucUploadTerminalDDM,
		@uploadTerminalDB = ucUploadTerminalDB,
		@uploadCanDDM = ucUploadCanDDM,
		@uploadExtendedConfigBIN = ucUploadExtendedConfigBIN
	FROM
		DataSchedule
	WHERE
		liSchedID = @scheduleId;

	IF ((@uploadCallMeBack = 1) OR (@coverageCallMeBack = 1))
	BEGIN
		SET @isUploadSchedule = 0;
		IF ((@uploadConfig = 1) OR (@uploadDDRs = 1) OR (@uploadTerminalScript <> 0) OR (@uploadTerminalDDM <> 0) OR (@uploadTerminalDB <> 0) OR (@uploadCanDDM <> 0) OR (@uploadExtendedConfigBIN <> 0))
		BEGIN
			SET @isUploadSchedule = 1;
		END

		SELECT 
			 @callMeBackSchedIdText = sValue
		FROM
			ExtensionProperties 
		WHERE 
			sProperty = 'CallMeBack'
			AND liObjectID = @objectId;

		IF (@callMeBackSchedIdText IS NOT NULL)
		BEGIN
			SET @callMeBackSchedIdText = REPLACE(@callMeBackSchedIdText, 'SchedID=', '');
			SET @callMeBackSchedIdText = REPLACE(@callMeBackSchedIdText, ';', '');
			SET @callMeBackSchedIdText = LTRIM(RTRIM(@callMeBackSchedIdText));
			IF ISNUMERIC(@callMeBackSchedIdText) = 1
			BEGIN
				SET @callMeBackSchedId = CONVERT(int, @callMeBackSchedIdText);

				SELECT
					@objectId = liObjectID,
					@uploadConfig = bUploadConfig,
					@uploadDDRs = bUploadDDRs,
					@uploadTerminalScript = ucUploadTerminalScript,
					@uploadTerminalDDM = ucUploadTerminalDDM,
					@uploadTerminalDB = ucUploadTerminalDB,
					@uploadCanDDM = ucUploadCanDDM,
					@uploadExtendedConfigBIN = ucUploadExtendedConfigBIN
				FROM
					DataSchedule
				WHERE
					liSchedID = @callMeBackSchedId;

				SET @isCmbUploadSchedule = 0;
				IF ((@uploadConfig = 1) OR (@uploadDDRs = 1) OR (@uploadTerminalScript <> 0) OR (@uploadTerminalDDM <> 0) OR (@uploadTerminalDB <> 0) OR (@uploadCanDDM <> 0) OR (@uploadExtendedConfigBIN <> 0))
				BEGIN
					SET @isCmbUploadSchedule = 1;
				END

				IF (@isCmbUploadSchedule = @isUploadSchedule)
				BEGIN
					INSERT INTO @schedIds values (@callMeBackSchedId);
				END
			END
		END
	END

	SELECT 
		[LogId] = DataScheduleLogID,
		[ScheduleId] = liSchedID,
		[TimeStamp] = dtWhen,
		[Message] = sMsg
	FROM
		[DataScheduleLog] dsl
	WHERE 
		liSchedID IN (SELECT schedId FROM @schedIds)
		AND (@lastReceivedLogId IS NULL OR DataScheduleLogID > @lastReceivedLogId)
	ORDER BY 
		dtWhen, DataScheduleLogID

```