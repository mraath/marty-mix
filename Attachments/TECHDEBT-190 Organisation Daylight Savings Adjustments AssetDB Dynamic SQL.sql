CREATE PROCEDURE [state].[OrganisationUpdateDaylightSavings]
  @orgId BIGINT,
  @dstEnabled BIT,
  @dstStart DATETIME,
  @dstEnd DATETIME,
  @dstOffset INT,
  @utcOffset INT
AS
BEGIN
  --USE [DeviceConfiguration.DataProcessing];
  --DROP PROCEDURE [state].[OrganisationUpdateDaylightSavings]
  --Put this in something like: ..\Database\DeviceConfiguration\Schemas\dynamix\Stored Procedures\SetContextInfo.sql
  --[dynamix].[OrganisationUpdateDaylightSavings]

  -- ASSET DB
  DECLARE @SConnectDatabase NVARCHAR(128) = (
    SELECT dboO.sConnectDatabase
    FROM [Fmonlinedb].[DynaMiX].[Organisations] dynO WITH (NOLOCK)
      JOIN [Fmonlinedb].dbo.Organisation dboO WITH (NOLOCK) ON dynO.OrganisationId = dboO.liOrgID
    WHERE dynO.GroupId = @orgId
  )

  -- Update Asset DB Org Options as per legacy stored proc: [dynamix].[OrgOptions_UpdateDST]
  DECLARE @SQL NVARCHAR(MAX);
  SET @SQL = N'USE ' + QUOTENAME(@SConnectDatabase) + N';
    UPDATE
        dbo.OrgOptions
    SET
        bDaylightEnabled =  ' + CAST(@dstEnabled AS NVARCHAR(10)) + ',
        dtDaylightStart = @dstDynamicStart,
        dtDaylightEnd = @dstDynamicEnd,
        liDaylightAdjust =  ' + CAST(@dstOffset AS NVARCHAR(10)) + '
    WHERE
        bDaylightEnabled <>  ' + CAST(@dstEnabled AS NVARCHAR(10)) + '
        OR NULLIF(dtDaylightStart, @dstDynamicStart) IS NOT NULL
        OR NULLIF(@dstDynamicStart, dtDaylightStart) IS NOT NULL
        OR NULLIF(dtDaylightEnd, @dstDynamicEnd) IS NOT NULL
        OR NULLIF(@dstDynamicEnd, dtDaylightEnd) IS NOT NULL
        OR NULLIF(liDaylightAdjust,  ' + CAST(@dstOffset AS NVARCHAR(10)) + ') IS NOT NULL
        OR NULLIF( ' + CAST(@dstOffset AS NVARCHAR(10)) + ', liDaylightAdjust) IS NOT NULL;' -- 

  EXEC sp_executesql @SQL, N'@dstDynamicStart DATETIME, @dstDynamicEnd DATETIME', @dstStart, @dstEnd;

  -- FMOnlineDB
  DECLARE @liOrgID INT = (
    SELECT OrganisationId
      FROM [Fmonlinedb].[DynaMiX].[Organisations] dynO WITH (NOLOCK)
      WHERE dynO.GroupId = @orgId
  )

  UPDATE
    [FMOnlineDB].dbo.Organisation
  SET
    liGMTOffset = @utcOffset
  WHERE
    liOrgID = @liOrgID AND liGMTOffset <> @utcOffset;

  RETURN 0;
END
