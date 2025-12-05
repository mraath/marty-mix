--I KEEP GETTING THIS ERROR: Msg 8114, Level 16, State 5, Procedure MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_Optimized, Line 10. Error converting data type varchar to bigint.
--HEre are my tests.... how do I fix this? Should I replace my DECLARE @MyConfigGroupIds AS [dbo].[SelectionIds]; with a table instead


USE [DeviceConfiguration];

-- 1) Create stored procs
--DROP PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups_Optimized];

/*
CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups_Optimized]
  @configGroupIds   [dbo].[SelectionIds] READONLY
AS
BEGIN
  SET NOCOUNT ON;

  CREATE TABLE #assets (
    AssetDescription NVARCHAR(500),
    Registration     NVARCHAR(50),
    Sitename         NVARCHAR(500),
    FleetNumber      NVARCHAR(50),
    LegacyVehicleId  INT
  );

  CREATE TABLE #schedule (
    [ScheduleId]   INT,
    [AssetId]      BIGINT,
    [LastRun]      DATETIME,
    [LastLogEntry] NVARCHAR(500)
  );

  CREATE TABLE #LegacyVehicleIds (LegacyVehicleId INT PRIMARY KEY, AssetId BIGINT);

  WITH MobileUnitsForGroups AS (
    SELECT amu.LegacyVehicleId, amu.AssetId
    FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.id
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
    INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON mu.MobileUnitKey = amu.MobileUnitKey
  )
  INSERT INTO #LegacyVehicleIds (LegacyVehicleId, AssetId)
  SELECT LegacyVehicleId, AssetId FROM MobileUnitsForGroups;

  DECLARE @sConnectDatabase NVARCHAR(250);
  DECLARE @legacyOrgId INT;

  SELECT TOP 1 @legacyOrgId = amu.LegacyOrgId
  FROM @configGroupIds cg
  INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.id
  INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey
  INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON mu.MobileUnitKey = amu.MobileUnitKey;

  SELECT @sConnectDatabase = sConnectDatabase
  FROM [FMOnlineDB].[dbo].[Organisation] fmo WITH (NOLOCK) --TODO: MR: $(Controller) 
  WHERE fmo.liOrgID = @legacyOrgId;

  DECLARE @SQL NVARCHAR(MAX);
  SET @SQL = N'USE ' + QUOTENAME(@sConnectDatabase) + N';
    INSERT INTO #assets
    SELECT DISTINCT
      v.sDesc as AssetDescription,
      v.sRegNo as Registration,
      s.sName as [Sitename],
      a.FleetNumber,
      l.LegacyVehicleId
    FROM #LegacyVehicleIds l
    INNER JOIN dbo.Vehicles v WITH (NOLOCK) ON v.iVehicleID = l.LegacyVehicleId
    INNER JOIN [dynamix].Assets a WITH (NOLOCK) ON v.iVehicleID  = a.VehicleId
    INNER JOIN dbo.Sites s WITH (NOLOCK) ON s.liSiteID = v.liSiteID;

    WITH ScheduleLogIds AS (
      SELECT
        MAX(DataScheduleLogID) DataScheduleLogID,
        a.VehicleId,
        a.AssetId
      FROM dbo.DataScheduleLog dsl WITH (NOLOCK)
      JOIN dbo.DataSchedule ds WITH (NOLOCK) ON ds.liSchedId = dsl.liSchedId
      JOIN dynamix.Assets a WITH (NOLOCK) ON a.VehicleId = ds.liObjectID
      JOIN #LegacyVehicleIds l ON l.AssetId = a.AssetId
      WHERE CAST((CAST(bUploadConfig as tinyint) + CAST(bUploadDDRs as tinyint) +
              bUploadDDRs +  ucUploadTerminalScript + ucUploadTerminalDDM +
              ucUploadTerminalDB + ucUploadCanDDM + ucUploadExtendedConfigBIN) as bit) = 1
      GROUP by a.VehicleId, a.AssetId
    )
    INSERT INTO #schedule
    SELECT
      ads.UploadScheduleId,
      logIds.AssetId,
      ds.dtLastRun,
      [dynamix].[GetLatestScheduleLogMsgByScheduleId](ds.[liSchedID], null)
    FROM ScheduleLogIds logIds WITH (NOLOCK)
    JOIN dynamix.AssetDataSchedules ads WITH (NOLOCK) ON ads.AssetId = logIds.AssetId
    JOIN dbo.DataSchedule ds WITH (NOLOCK) ON ds.liObjectId = logIds.VehicleId AND ds.liSchedID = ads.UploadScheduleId;';

  EXEC sp_executesql @SQL;

  WITH GeneralConfigGroupInfo AS (
    SELECT
      tcg.ConfigurationGroupId,
      tcg.ConfigurationGroupKey,
      tcg.Name AS ConfigurationGroupName,
      dmd.Description AS MobileDevice,
      mdt.MobileDeviceTemplateId,
      mdt.Name AS MobileDeviceTemplateName,
      tet.EventTemplateId,
      tet.Name AS EventTemplateName,
      tlt.LocationTemplateId,
      tlt.Name AS LocationTemplateName,
      dd.DeviceKey,
      tcg.MobileDeviceTemplateKey,
      tcg.LibraryKey,
      dmd.MobileDeviceType
    FROM @configGroupIds cg
      INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.id
      INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey AND tcg.LibraryKey = mdt.LibraryKey
      INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
      INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
      LEFT JOIN [template].[EventTemplates] tet WITH (NOLOCK) ON tcg.EventTemplateKey = tet.EventTemplateKey AND tcg.LibraryKey = tet.LibraryKey
      LEFT JOIN [template].[LocationTemplates] tlt WITH (NOLOCK) ON tcg.LocationTemplateKey = tlt.LocationTemplateKey AND tcg.LibraryKey = tlt.LibraryKey
  ),
  MobileUnits AS (
    SELECT
      g.ConfigurationGroupId,
      mu.ConfigurationGroupKey,
      amu.AssetId,
      mu.MobileUnitKey,
      mu.MobileDeviceKey,
      mu.MobileUnitId,
      mu.[ConfigurationStatus] AS ConfigurationStatusId,
      cs.[Description] AS ConfigurationStatus,
      mu.DateUpdated AS ConfigurationStatusDate,
      amu.LegacyOrgId,
      amu.LegacyVehicleId,
      ISNULL(mu.UniqueIdentifier, mup.Value) AS [UniqueIdentifier],
      (CASE WHEN mu.MobileDeviceKey = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE DeviceId = -1064000195705392069) THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber,
      mu.ConfigurationGenerationNotes,
      mu.ConfigurationGenerationWarning
    FROM GeneralConfigGroupInfo g
      INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
      INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON mu.MobileUnitKey = amu.MobileUnitKey
      INNER JOIN [definition].[ConfigurationStatuses] cs WITH (NOLOCK) ON cs.[ConfigurationStatus] = mu.[ConfigurationStatus]
      LEFT JOIN [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK) ON mu.[MobileUnitKey] = mup.[MobileUnitKey] AND mup.[PropertyKey] = (SELECT [PropertyKey] FROM [definition].[Properties] dp WITH (NOLOCK) WHERE dp.PropertyId = 9188780602356317147)
      LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId  = -4477362625925416557
  ),
  BlackFlags AS (
    SELECT DISTINCT mu.MobileUnitKey, 1 AS BlackFlagged
    FROM MobileUnits mu
    WHERE EXISTS (SELECT 1 FROM [mobileunit].[OverridenEvents] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenEventActions] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenEventConditionThresholds] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenDevices] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenDeviceParameters] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenCanParameters] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenDeviceProperties] o WHERE o.MobileUnitKey = mu.MobileUnitKey AND o.PersistOnReset = 0)
       OR EXISTS (SELECT 1 FROM [mobileunit].[OverridenPeripheralDevices] o WHERE o.MobileUnitKey = mu.MobileUnitKey)
  )
  SELECT
    NULL AS Alerts,
    bf.BlackFlagged AS Flagged,
    mu.AssetId,
    mu.LegacyVehicleId,
    a.AssetDescription,
    a.Registration,
    a.Sitename,
    a.FleetNumber,
    NULL AS Lastposition,
    mu.UniqueIdentifier AS IMEI,
    NULL AS Serialnumber,
    g.MobileDevice,
    CASE
      WHEN mu.ConfigurationStatusId IN (4, 14, 0) THEN
        ISNULL(mu.ConfigurationGenerationWarning, mu.ConfigurationGenerationNotes)
      ELSE ''
    END AS ConfigCompileStatus,
    mu.ConfigurationStatus,
    CONVERT(NVARCHAR(23), mu.ConfigurationStatusDate, 121) AS ConfigurationStatusDate,
    NULL AS CommsLog,
    NULL AS MessageStatusDateUtc,
    sched.LastLogEntry,
    sched.ScheduleId,
    g.ConfigurationGroupId,
    g.ConfigurationGroupName,
    g.MobileDeviceTemplateId,
    g.MobileDeviceTemplateName,
    g.EventTemplateId,
    g.EventTemplateName,
    g.LocationTemplateId,
    g.LocationTemplateName,
    g.MobileDeviceType,
    NULL AS FWVersion,
    NULL AS PreferredFWVersion,
    NULL AS CanScriptLineId,
    NULL AS CanScript,
    NULL AS Speed,
    NULL AS RPM,
    NULL AS Fuel,
    NULL AS SP,
    mu.StreamaxSerialNumber AS MiXVisionSerialnumber,
    NULL AS HOS
  FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu ON mu.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN #assets a ON a.LegacyVehicleId = mu.LegacyVehicleId
    LEFT JOIN BlackFlags bf ON bf.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN #schedule sched ON sched.AssetId = mu.AssetId;

  DROP TABLE #assets;
  DROP TABLE #schedule;
  DROP TABLE #LegacyVehicleIds;

END
*/



-- 2) TEST original, new, copy to excel, compare

-- Declare the table variable that the stored procedure expects
DECLARE @MyConfigGroupIds AS [dbo].[SelectionIds]; --TABLE (id BIGINT); --

INSERT INTO @MyConfigGroupIds (id) 
VALUES 
    (-2803813420773469362), (2557659825063191210), (-6039078778185809084), (3189959622678903378), (1989001888637459309), (-9078750292130215188), (-3274353763833670263), (1232298188016006398), (4631052128945276764), (-3251388662902899727), (-1806774282659967806), (5918913735931167160), (8799631723342597089), (-8162147584136025918), (-1307004388228739243), (-6257508969252238550), (8312559892687542597), (-1323496424401963304), (-2524931806030160341), (3681922843152348030), (3209265185920104888), (5621177276048465690), (-8126655682067440340), (-6836621200088256507), (3780592447908270856), (1223784011986591945), (-3366261590319731458), (-7392764503748298046), (-7629839428314466340), (7187708927592996236), (-1635591222982510535), (-6151357456724753887), (-5912082017677079777), (-5390337933230695538), (-4067179943998429825), (1364631742777966163), (-7653538731568077332), (-7668187040444806181), (4208572072426061348), (3362884251134407151), (-3893536691584770708), (-6084966262084607888), (3774723236452900354), (-2723417818245426945), (-3836116117686479120), (-7382401016514304197), (7518319533563758380), (3813205176926613669), (5916945531324722255), (-5159253166163790691), (-2147059355369176559), (60036256406525452), (767833652034630589), (-6328313109361883502), (1287625066743264402), (2505696365882641504), (1240957115574012888), (-2374899645906010889), (3739189965094689367), (8235264728202292851), (-1136609960426082090), (4505193432618700901), (6775426529790173259), (-3798194295803321659), (-8871627763454545305), (-2110415703208626075), (-5801394207784667707), (4309917650092943416), (6143152948325390557), (2237002883694620525), (-6366678994605550120), (881148683257612107), (-7944209854350725335), (3559248872843565414), (3168786260864673578), (7598006177779832207), (-1923500799342536831), (-1733893171984566420), (-8642220154752102213), (5009320484667002586), (-8507561780508819492), (7115023718153513169), (8724893352726780856), (-383605210349505097), (-2310911944299775966), (1735562267874004226), (-2320806248371712183), (-5340634987676521615), (4263282101255212968); -- LESS, but Alerts:


-- LOTS, but NO ALERTS: VALUES (-4706039627829598783),(199325999668202366), (-8457480704780512749),(2677576181771254477),(2823596733503101975),(1538687544172856721), (-4229490949371290982), (-2384730484822060182),(7440653181116775134),(8283011099424745956),(6270824666272621435), (-8949632091574047260), (-8207503568458137854), (-1215659196319016695),(6152593781035096689),(2974831301785092008),(3962657782447665558), (-3546122059729481997),(5567431191665092749), (-5883907305683060856),(461085753557650606),(3502599370431462499), (-7369294648932782097), (-8787908773382047661),(7287834424358043214),(3977693385065534239),(3545130468931642729),(75472660843825717), (-6236293196728745404), (-2473474416939851345), (-4815071576473298740), (-2317285672350580067),(3504428657675998019),(4462868102626601662),(3052323964734261303),(2610836696632034535),(3273233624147396660), (-8388558004121944370),(5295170289666896775),(7909417651692360436), (-7590346313175141016),(6277877287032876699), (-576980630916973063);


-- Execute the old
--EXEC [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups] @configGroupIds = @MyConfigGroupIds;

-- Execute the new, optimized stored procedure
EXEC [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups_Optimized] @configGroupIds = @MyConfigGroupIds;

/*

Invalid column name 'LegacyVehicleId'. Invalid object name 'GeneralConfigGoupInfo'.

*/