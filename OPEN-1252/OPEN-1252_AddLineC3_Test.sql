--I KEEP GETTING THIS ERROR: Msg 8114, Level 16, State 5, Procedure MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_Optimized, Line 10. Error converting data type varchar to bigint.
--HEre are my tests.... how do I fix this? Should I replace my DECLARE @MyConfigGroupIds AS [dbo].[SelectionIds]; with a table instead


USE [DeviceConfiguration];

-- 1) Create stored procs
--DROP PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_C3];
--DROP PROCEDURE [template].[Template_GetConfigurationGroupsOtherColumns_C3];

/*
--CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_C3]
CREATE PROCEDURE [template].[Template_GetConfigurationGroupsOtherColumns_C3]
  @groupId BIGINT
AS
BEGIN

  SET NOCOUNT ON;

  --VARIABLES
  DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;

  DECLARE @FWVersion SMALLINT = 
        (SELECT PropertyKey
  FROM [definition].[Properties] WITH (NOLOCK)
  WHERE PropertyId = @PreferedFirmwareVersion);

  WITH GeneralConfigGroupInfo AS (
    SELECT
      tcg.ConfigurationGroupId,
      tcg.ConfigurationGroupKey,
      tcg.MobileDeviceTemplateKey,
      tcg.LibraryKey,
      dd.DeviceKey,
      dmd.Description AS MobileDevice
    FROM [library].[Libraries] l WITH (NOLOCK)
      INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.LibraryKey = l.LibraryKey
      INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
      ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
        AND tcg.LibraryKey = mdt.LibraryKey
      INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
      INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
    WHERE l.GroupId = @groupId
  ), MobileUnits AS (
    SELECT
      g.ConfigurationGroupId,
      mu.ConfigurationGroupKey,
      (mu.MobileUnitKey) AS MobileUnitKey
    FROM GeneralConfigGroupInfo g
      INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
      INNER JOIN [mobileunit].[AssetMobileUnits] amu WITH (NOLOCK) ON amu.MobileUnitKey = mu.MobileUnitKey
  ), AssetsCount AS (
    SELECT
      ConfigurationGroupId,
      Count(MobileUnitKey) AS AssetsCount
    FROM MobileUnits
    GROUP BY ConfigurationGroupId
  ), BlackFlagsCount AS (
    SELECT
      ConfigurationGroupId,
      COUNT(MobileUnitKey) AS BlackFlagsCount
    FROM
      (
        SELECT DISTINCT
          mu.ConfigurationGroupId AS ConfigurationGroupId,
          mu.MobileUnitKey AS MobileUnitKey
        FROM MobileUnits mu
          --Overwritten Events
          LEFT JOIN [mobileunit].[OverridenEvents] events WITH (NOLOCK) ON events.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenEventActions] eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenEventConditionThresholds] thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = mu.MobileUnitKey
          --Overwritten Device Info
          LEFT JOIN [mobileunit].[OverridenDevices] devices WITH (NOLOCK) ON devices.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenDeviceParameters] params WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenCanParameters] paramsCan WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
          LEFT JOIN [mobileunit].[OverridenDeviceProperties] properties WITH (NOLOCK) ON properties.MobileUnitKey = mu.MobileUnitKey
            AND properties.PersistOnReset = 0
          LEFT JOIN [mobileunit].[OverridenPeripheralDevices] peripherals WITH (NOLOCK) ON peripherals.MobileUnitKey = mu.MobileUnitKey
        WHERE
          (
            events.MobileUnitKey IS NOT NULL
            OR eventActions.MobileUnitKey IS NOT NULL
            OR thresholds.MobileUnitKey IS NOT NULL
            OR devices.MobileUnitKey IS NOT NULL
            OR params.MobileUnitKey IS NOT NULL
            OR paramsCan.MobileUnitKey IS NOT NULL
            OR properties.MobileUnitKey IS NOT NULL
            OR peripherals.MobileUnitKey IS NOT NULL
          )
      ) AS uniqueRows
    GROUP BY ConfigurationGroupId
  ), AllConfigGroupLines AS (
    SELECT
      [ConfigurationGroupId] = g.ConfigurationGroupId,
      [WireName] = dl.[Name],
      [Connection] = lpd.[Description],
      [LineId] = CAST(dl.LineId AS NVARCHAR(50))
    FROM GeneralConfigGroupInfo g
      LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey] = g.DeviceKey
      LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
      LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
      --Template Devices
      INNER JOIN [template].[Devices] td WITH (NOLOCK)
      ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
        AND g.LibraryKey = td.LibraryKey
      INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
      -- Peripheral devices
      CROSS APPLY
      (
        SELECT
          [LineKey] = tpd.[LineKey]
        FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
        WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
          AND tpd.[LineKey] = dmdl.[LineKey]
      ) pd
      LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]
      -- Lines
      LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK)
      ON dmdlpd.[MobileDeviceKey] = g.DeviceKey --mu.[MobileDeviceKey]
        AND dmdlpd.[LineKey] = pd.[LineKey]
        AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
      -- Get connected device
      LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey
        AND ld.LibraryKey = g.LibraryKey
      LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey
  ), AggregatedCanLines AS (
    SELECT
      l.ConfigurationGroupId,
      CanScriptLineId = STUFF((
        SELECT
          ', ' + l2.[LineId]
        FROM AllConfigGroupLines l2
        WHERE
          l2.ConfigurationGroupId = l.ConfigurationGroupId
          AND l2.WireName IN ('C1', 'C2', 'C3')
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
      CanScript = STUFF((
        SELECT
          ', ' + l2.[Connection]
        FROM AllConfigGroupLines l2
        WHERE
          l2.ConfigurationGroupId = l.ConfigurationGroupId
          AND l2.WireName IN ('C1', 'C2', 'C3')
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '')
    FROM AllConfigGroupLines l
    WHERE
      l.WireName IN ('C1', 'C2', 'C3')
    GROUP BY l.ConfigurationGroupId
  ), FWVersions AS (
    SELECT DISTINCT
      g.ConfigurationGroupId,
      fw.Name AS FWName
    FROM GeneralConfigGroupInfo g
      -- Find optional logical device dependencies for the main mobile device
      INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
      ON dep.ParentDeviceKey = g.DeviceKey
        AND dep.DependencyType = 1
      -- Join template.Devices on the child device from dependencies
      INNER JOIN [template].[Devices] td WITH (NOLOCK)
      ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
        AND td.LibraryKey = g.LibraryKey
        AND td.DeviceKey = dep.ChildDeviceKey
      -- Get firmware properties from the dependency device
      INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
      ON tdpr.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
        AND tdpr.DeviceKey = td.DeviceKey
        AND tdpr.PropertyKey = @FWVersion
      -- Get the firmware version details
      INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) ON fw.FirmwareVersionId = tdpr.Value
    WHERE tdpr.Value IS NOT NULL
  ), AggregatedFW AS (
    SELECT
      ConfigurationGroupId,
      STUFF((
        SELECT
          ', ' + FWName
        FROM FWVersions fw
        WHERE
          fw.ConfigurationGroupId = f.ConfigurationGroupId
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS FWVersion
    FROM FWVersions f
    GROUP BY ConfigurationGroupId
  ), PivotedLines AS (
    SELECT
      ConfigurationGroupId,
      MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%SPEED%' THEN Connection END) AS Speed_FM,
      MAX(CASE WHEN WireName = 'Speed' THEN Connection END) AS Speed_Other,
      MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%RPM%' THEN Connection END) AS RPM_FM,
      MAX(CASE WHEN WireName = 'RPM' THEN Connection END) AS RPM_Other,
      MAX(CASE WHEN WireName LIKE 'F%' AND Connection LIKE '%Fuel%' THEN Connection END) AS Fuel_FM,
      MAX(CASE WHEN WireName = 'Fuel' THEN Connection END) AS Fuel_Other,
      MAX(CASE WHEN WireName = 'SP' THEN Connection END) AS SP,
      MAX(CASE WHEN WireName = 'HOS' THEN Connection END) AS HOS
    FROM AllConfigGroupLines l
    GROUP BY ConfigurationGroupId
  )
  SELECT
    Flagged = b.BlackFlagsCount,
    g.ConfigurationGroupId,
    a.AssetsCount,
    fw.FWVersion,
    acl.CanScriptLineId,
    acl.CanScript,
    Speed = CASE
              WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed' --Business rule on OE-20, this is always the value for MiX2000
              WHEN g.MobileDevice LIKE 'FM%' THEN pl.Speed_FM
              ELSE pl.Speed_Other
            END,
    RPM =   CASE
              WHEN g.MobileDevice LIKE 'FM%' THEN pl.RPM_FM
              ELSE pl.RPM_Other
            END,
    Fuel =  CASE
              WHEN g.MobileDevice LIKE 'FM%' THEN pl.Fuel_FM
              ELSE pl.Fuel_Other
            END,
    pl.SP,
    pl.HOS
  FROM GeneralConfigGroupInfo g
    LEFT JOIN AssetsCount a ON a.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN BlackFlagsCount b ON b.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN PivotedLines pl ON pl.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN AggregatedFW fw ON fw.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN AggregatedCanLines acl ON acl.ConfigurationGroupId = g.ConfigurationGroupId;

END
*/



-- 2) TEST original, new, copy to excel, compare

-- Declare the table variable that the stored procedure expects
DECLARE @MyConfigGroupIds AS [dbo].[SelectionIds]; --TABLE (id BIGINT); --

INSERT INTO @MyConfigGroupIds (id) 
VALUES 
    (-2803813420773469362), (2557659825063191210), (-6039078778185809084), (3189959622678903378), (1989001888637459309), (-9078750292130215188), (-3274353763833670263), (1232298188016006398), (4631052128945276764), (-3251388662902899727), (-1806774282659967806), (5918913735931167160), (8799631723342597089), (-8162147584136025918), (-1307004388228739243), (-6257508969252238550), (8312559892687542597), (-1323496424401963304), (-2524931806030160341), (3681922843152348030), (3209265185920104888), (5621177276048465690), (-8126655682067440340), (-6836621200088256507), (3780592447908270856), (1223784011986591945), (-3366261590319731458), (-7392764503748298046), (-7629839428314466340), (7187708927592996236), (-1635591222982510535), (-6151357456724753887), (-5912082017677079777), (-5390337933230695538), (-4067179943998429825), (1364631742777966163), (-7653538731568077332), (-7668187040444806181), (4208572072426061348), (3362884251134407151), (-3893536691584770708), (-6084966262084607888), (3774723236452900354), (-2723417818245426945), (-3836116117686479120), (-7382401016514304197), (7518319533563758380), (3813205176926613669), (5916945531324722255), (-5159253166163790691), (-2147059355369176559), (60036256406525452), (767833652034630589), (-6328313109361883502), (1287625066743264402), (2505696365882641504), (1240957115574012888), (-2374899645906010889), (3739189965094689367), (8235264728202292851), (-1136609960426082090), (4505193432618700901), (6775426529790173259), (-3798194295803321659), (-8871627763454545305), (-2110415703208626075), (-5801394207784667707), (4309917650092943416), (6143152948325390557), (2237002883694620525), (-6366678994605550120), (881148683257612107), (-7944209854350725335), (3559248872843565414), (3168786260864673578), (7598006177779832207), (-1923500799342536831), (-1733893171984566420), (-8642220154752102213), (5009320484667002586), (-8507561780508819492), (7115023718153513169), (8724893352726780856), (-383605210349505097), (-2310911944299775966), (1735562267874004226), (-2320806248371712183), (-5340634987676521615), (4263282101255212968); -- LESS, but Alerts:


-- LOTS, but NO ALERTS: VALUES (-4706039627829598783),(199325999668202366), (-8457480704780512749),(2677576181771254477),(2823596733503101975),(1538687544172856721), (-4229490949371290982), (-2384730484822060182),(7440653181116775134),(8283011099424745956),(6270824666272621435), (-8949632091574047260), (-8207503568458137854), (-1215659196319016695),(6152593781035096689),(2974831301785092008),(3962657782447665558), (-3546122059729481997),(5567431191665092749), (-5883907305683060856),(461085753557650606),(3502599370431462499), (-7369294648932782097), (-8787908773382047661),(7287834424358043214),(3977693385065534239),(3545130468931642729),(75472660843825717), (-6236293196728745404), (-2473474416939851345), (-4815071576473298740), (-2317285672350580067),(3504428657675998019),(4462868102626601662),(3052323964734261303),(2610836696632034535),(3273233624147396660), (-8388558004121944370),(5295170289666896775),(7909417651692360436), (-7590346313175141016),(6277877287032876699), (-576980630916973063);


-- ASSET PANEL
-- Execute the old
--7s 127
--EXEC [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups] @configGroupIds = @MyConfigGroupIds;
-- 6s 127
--EXEC [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_C3] @configGroupIds = @MyConfigGroupIds;


-- CONFIG GROUP PANEL
DECLARE @groupId BIGINT = -5401647754082838271;
--EXEC [template].[Template_GetConfigurationGroupsOtherColumns] @groupId = @groupId;
EXEC [template].[Template_GetConfigurationGroupsOtherColumns_C3] @groupId = @groupId;

/*

Invalid column name 'LegacyVehicleId'. Invalid object name 'GeneralConfigGoupInfo'.

*/
