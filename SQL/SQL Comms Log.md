---
created: 2023-10-17T15:28
updated: 2023-10-17T15:30
---
One of our helpful [[sql]] scripts to find info :)
First get the org info using the [[SQL Organisation]] script

```sql
USE TollDataTrial_2012; -- REPLACE THIS

DECLARE @scheduleId INT = 47041; -- REPLACE THIS
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
