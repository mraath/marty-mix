--I KEEP GETTING THIS ERROR: Msg 8114, Level 16, State 5, Procedure MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_Optimized, Line 10. Error converting data type varchar to bigint.
--HEre are my tests.... how do I fix this? Should I replace my DECLARE @MyConfigGroupIds AS [dbo].[SelectionIds]; with a table instead


USE [DeviceConfiguration];

-- 1) Create stored procs
--DROP PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_C3];

/*
CREATE PROCEDURE [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_C3]
  @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
  DECLARE @STREAMAX_STANDALONE_DEVICE_KEY INT = (
    SELECT [DeviceKey] 
    FROM [definition].[Devices] WITH (NOLOCK) 
    WHERE DeviceId = -1064000195705392069
  );

  -- Step 1: General Config Group Info with proper indexing
  CREATE TABLE #GeneralConfigGroupInfo (
    ConfigurationGroupId     BIGINT,
    DeviceKey                INT,
    MobileDeviceTemplateKey  BIGINT,
    LibraryKey               INT,
    ConfigurationGroupKey    INT,
    MobileDevice             NVARCHAR(50),
    INDEX IX_ConfigGroupId CLUSTERED (ConfigurationGroupId),
    INDEX IX_DeviceKey NONCLUSTERED (DeviceKey),
    INDEX IX_ConfigGroupKey NONCLUSTERED (ConfigurationGroupKey)
  );

  INSERT INTO #GeneralConfigGroupInfo
  SELECT
    tcg.ConfigurationGroupId,
    dd.DeviceKey,
    tcg.MobileDeviceTemplateKey,
    tcg.LibraryKey,
    tcg.ConfigurationGroupKey,
    dmd.Description
  FROM @configGroupIds cg
    INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) 
      ON tcg.ConfigurationGroupId = cg.id
    INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) 
      ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey 
      AND tcg.LibraryKey = mdt.LibraryKey
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) 
      ON mdt.MobileDeviceKey = dd.DeviceKey
    INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) 
      ON dd.DeviceKey = dmd.DeviceKey;

  -- Step 2: Mobile Units with proper indexing
  CREATE TABLE #MobileUnits (
    ConfigurationGroupId     BIGINT,
    MobileUnitId             BIGINT,
    MobileUnitKey            INT,
    MobileDeviceKey          INT,
    StreamaxSerialNumber     NVARCHAR(250),
    INDEX IX_MobileUnitId CLUSTERED (MobileUnitId),
    INDEX IX_ConfigGroupId NONCLUSTERED (ConfigurationGroupId),
    INDEX IX_MobileUnitKey NONCLUSTERED (MobileUnitKey)
  );

  INSERT INTO #MobileUnits
  SELECT
    g.ConfigurationGroupId,
    mu.MobileUnitId,
    mu.MobileUnitKey,
    mu.MobileDeviceKey,
    CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY 
         THEN mu.UniqueIdentifier 
         ELSE ap.Value 
    END
  FROM #GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) 
      ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) 
      ON mu.MobileUnitId = ap.AssetId 
      AND ap.PropertyId = @StreamaxSerialNumber;

  -- Step 3: All Config Group Lines
  CREATE TABLE #AllConfigGroupLines (
    ConfigurationGroupId BIGINT,
    WireName             NVARCHAR(200),
    Connection           NVARCHAR(200),
    LineId               NVARCHAR(50),
    INDEX IX_ConfigGroupId CLUSTERED (ConfigurationGroupId, LineId)
  );

  INSERT INTO #AllConfigGroupLines
  SELECT
    g.ConfigurationGroupId,
    dl.[Name],
    lpd.[Description],
    dl.LineId
  FROM #GeneralConfigGroupInfo g
    LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) 
      ON dmdl.[MobileDeviceKey] = g.DeviceKey
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) 
      ON dl.[LineKey] = dmdl.[LineKey]
    INNER JOIN [template].[Devices] td WITH (NOLOCK) 
      ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
      AND g.LibraryKey = td.LibraryKey
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) 
      ON tdd.[DeviceKey] = td.[DeviceKey]
    CROSS APPLY ( 
      SELECT [LineKey] = tpd.[LineKey]
      FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
      WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND tpd.[LineKey] = dmdl.[LineKey]
    ) pd
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) 
      ON dmdlpd.[MobileDeviceKey] = g.DeviceKey
      AND dmdlpd.[LineKey] = pd.[LineKey]
      AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) 
      ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey 
      AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) 
      ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey;

  -- Step 4: Effective Lines
  CREATE TABLE #EffectiveLines (
    MobileUnitId   BIGINT,
    WireName       NVARCHAR(200),
    Connection     NVARCHAR(200),
    IsOverridden   BIT,
    LineId         NVARCHAR(50),
    INDEX IX_MobileUnitId CLUSTERED (MobileUnitId, LineId)
  );

  INSERT INTO #EffectiveLines
  SELECT
    mu.MobileUnitId,
    dl.[Name],
    lpd.[Description],
    CAST(CASE WHEN opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL 
              THEN 1 ELSE 0 END AS BIT),
    dl.LineId
  FROM #MobileUnits mu
    INNER JOIN #GeneralConfigGroupInfo g 
      ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    INNER JOIN [template].[Devices] td WITH (NOLOCK) 
      ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) 
      ON dd.[DeviceKey] = td.[DeviceKey]
    CROSS APPLY ( 
      SELECT
        [LineKey] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL 
                         THEN opd.[LineKey] 
                         ELSE tpd.[LineKey] END
      FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
        LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) 
          ON opd.[MobileUnitKey] = mu.[MobileUnitKey]
          AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
      WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)
             OR (opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))
    ) pd
    LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK)
      ON opd.[MobileUnitKey] = mu.[MobileUnitKey]
      AND opd.[LineKey] = pd.[LineKey]
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) 
      ON dl.[LineKey] = pd.[LineKey]
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) 
      ON dmdlpd.[MobileDeviceKey] = mu.[MobileDeviceKey]
      AND dmdlpd.[LineKey] = pd.[LineKey]
      AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) 
      ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey
      AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) 
      ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey;

  -- Step 5: Mobile Unit Lines (matching original ORDER BY)
  CREATE TABLE #MobileUnitLines (
    MobileUnitId         BIGINT,
    ConfigurationGroupId BIGINT,
    LineId               NVARCHAR(50),
    WireName             NVARCHAR(200),
    IsOverridden         BIT,
    Connection           NVARCHAR(200),
    INDEX IX_Main CLUSTERED (ConfigurationGroupId DESC, WireName DESC, MobileUnitId)
  );

  INSERT INTO #MobileUnitLines
  SELECT
    mu.MobileUnitId,
    cgl.ConfigurationGroupId,
    cgl.LineId,
    cgl.WireName,
    ISNULL(eff.IsOverridden, 0),
    CASE WHEN ISNULL(eff.IsOverridden, 0) = 1 
         THEN eff.Connection 
         ELSE cgl.Connection END
  FROM #MobileUnits mu
    INNER JOIN #AllConfigGroupLines cgl 
      ON cgl.ConfigurationGroupId = mu.ConfigurationGroupId
    LEFT JOIN #EffectiveLines eff 
      ON eff.MobileUnitId = mu.MobileUnitId
      AND eff.LineId = cgl.LineId
  ORDER BY cgl.ConfigurationGroupId DESC, cgl.WireName DESC;

  -- Step 6: Pre-aggregate specific wire values to avoid correlated subqueries
  CREATE TABLE #AggregatedLines (
    MobileUnitId          BIGINT,
    ConfigurationGroupId  BIGINT,
    CanScriptLineId       NVARCHAR(MAX),
    CanScript             NVARCHAR(MAX),
    SpeedConnection       NVARCHAR(200),
    RPMConnection         NVARCHAR(200),
    FuelConnection        NVARCHAR(200),
    SPConnection          NVARCHAR(200),
    HOSConnection         NVARCHAR(200),
    FreqSpeedConnection   NVARCHAR(200),
    FreqRPMConnection     NVARCHAR(200),
    FreqFuelConnection    NVARCHAR(200),
    INDEX IX_Main CLUSTERED (MobileUnitId, ConfigurationGroupId)
  );

  INSERT INTO #AggregatedLines
  SELECT
    l.MobileUnitId,
    l.ConfigurationGroupId,
    -- CanScriptLineId (order by WireName DESC to match original)
    STUFF((
      SELECT ', ' + l2.LineId
      FROM #MobileUnitLines l2
      WHERE l2.MobileUnitId = l.MobileUnitId
        AND l2.ConfigurationGroupId = l.ConfigurationGroupId
        AND l2.WireName IN ('C1', 'C2', 'C3')
      ORDER BY l2.WireName DESC
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    -- CanScript (order by WireName DESC to match original)
    STUFF((
      SELECT ', ' + l2.Connection
      FROM #MobileUnitLines l2
      WHERE l2.MobileUnitId = l.MobileUnitId
        AND l2.ConfigurationGroupId = l.ConfigurationGroupId
        AND l2.WireName IN ('C1', 'C2', 'C3')
      ORDER BY l2.WireName DESC
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    -- Speed
    MAX(CASE WHEN l.WireName = 'Speed' THEN l.Connection END),
    -- RPM
    MAX(CASE WHEN l.WireName = 'RPM' THEN l.Connection END),
    -- Fuel
    MAX(CASE WHEN l.WireName = 'Fuel' THEN l.Connection END),
    -- SP
    MAX(CASE WHEN l.WireName = 'SP' THEN l.Connection END),
    -- HOS
    MAX(CASE WHEN l.WireName = 'HOS' THEN l.Connection END),
    -- Frequency lines for Speed
    MAX(CASE WHEN l.WireName LIKE 'F%' AND l.Connection LIKE '%SPEED%' 
             THEN l.Connection END),
    -- Frequency lines for RPM
    MAX(CASE WHEN l.WireName LIKE 'F%' AND l.Connection LIKE '%RPM%' 
             THEN l.Connection END),
    -- Frequency lines for Fuel
    MAX(CASE WHEN l.WireName LIKE 'F%' AND l.Connection LIKE '%Fuel%' 
             THEN l.Connection END)
  FROM #MobileUnitLines l
  GROUP BY l.MobileUnitId, l.ConfigurationGroupId;

  -- Final SELECT with pre-aggregated data
  SELECT
    mu.MobileUnitId,
    agg.CanScriptLineId,
    agg.CanScript,
    Speed = CASE
      WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
      WHEN g.MobileDevice LIKE 'FM%' THEN agg.FreqSpeedConnection
      ELSE agg.SpeedConnection
    END,
    RPM = CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN agg.FreqRPMConnection
      ELSE agg.RPMConnection
    END,
    Fuel = CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN agg.FreqFuelConnection
      ELSE agg.FuelConnection
    END,
    SP = agg.SPConnection,
    MiXVisionSerialnumber = mu.StreamaxSerialNumber,
    HOS = agg.HOSConnection
  FROM #GeneralConfigGroupInfo g
    INNER JOIN #MobileUnits mu 
      ON mu.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN #AggregatedLines agg
      ON agg.MobileUnitId = mu.MobileUnitId
      AND agg.ConfigurationGroupId = g.ConfigurationGroupId;

  -- Cleanup
  DROP TABLE IF EXISTS #GeneralConfigGroupInfo;
  DROP TABLE IF EXISTS #MobileUnits;
  DROP TABLE IF EXISTS #AllConfigGroupLines;
  DROP TABLE IF EXISTS #EffectiveLines;
  DROP TABLE IF EXISTS #MobileUnitLines;
  DROP TABLE IF EXISTS #AggregatedLines;

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
--7s 127
--EXEC [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups] @configGroupIds = @MyConfigGroupIds;
-- 6s 127
EXEC [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_C3] @configGroupIds = @MyConfigGroupIds;

/*

Invalid column name 'LegacyVehicleId'. Invalid object name 'GeneralConfigGoupInfo'.

*/