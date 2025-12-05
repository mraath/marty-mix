USE [DeviceConfiguration];
GO

-- =================================================================
-- Final Corrected Script
-- =================================================================
-- This script contains the fix within the AggregatedLines CTE.
-- The l2.LineId is now explicitly CAST to NVARCHAR(MAX) to avoid
-- the data type conversion error.

PRINT 'Running the final, fully corrected script...';

DECLARE @configGroupIds [dbo].[SelectionIds];
INSERT INTO @configGroupIds (id)
VALUES
    (-2803813420773469362), (2557659825063191210), (-6039078778185809084), (3189959622678903378), (1989001888637459309), (-9078750292130215188), (-3274353763833670263), (1232298188016006398), (4631052128945276764), (-3251388662902899727), (-1806774282659967806), (5918913735931167160), (8799631723342597089), (-8162147584136025918), (-1307004388228739243), (-6257508969252238550), (8312559892687542597), (-1323496424401963304), (-2524931806030160341), (3681922843152348030), (3209265185920104888), (5621177276048465690), (-8126655682067440340), (-6836621200088256507), (3780592447908270856), (1223784011986591945), (-3366261590319731458), (-7392764503748298046), (-7629839428314466340), (7187708927592996236), (-1635591222982510535), (-6151357456724753887), (-5912082017677079777), (-5390337933230695538), (-4067179943998429825), (1364631742777966163), (-7653538731568077332), (-7668187040444806181), (4208572072426061348), (3362884251134407151), (-3893536691584770708), (-6084966262084607888), (3774723236452900354), (-2723417818245426945), (-3836116117686479120), (-7382401016514304197), (7518319533563758380), (3813205176926613669), (5916945531324722255), (-5159253166163790691), (-2147059355369176559), (60036256406525452), (767833652034630589), (-6328313109361883502), (1287625066743264402), (2505696365882641504), (1240957115574012888), (-2374899645906010889), (3739189965094689367), (8235264728202292851), (-1136609960426082090), (4505193432618700901), (6775426529790173259), (-3798194295803321659), (-8871627763454545305), (-2110415703208626075), (-5801394207784667707), (4309917650092943416), (6143152948325390557), (2237002883694620525), (-6366678994605550120), (881148683257612107), (-7944209854350725335), (3559248872843565414), (3168786260864673578), (7598006177779832207), (-1923500799342536831), (-1733893171984566420), (-8642220154752102213), (5009320484667002586), (-8507561780508819492), (7115023718153513169), (8724893352726780856), (-383605210349505097), (-2310911944299775966);




  --This is a 1:1 translation of the original stored procedure into a CTE-based format.
  --Each CTE corresponds to a temporary table in the original version to ensure identical logic.

  DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
  DECLARE @STREAMAX_STANDALONE_DEVICE_KEY INT = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE DeviceId = -1064000195705392069);

  WITH GeneralConfigGroupInfo AS (
    -- Mirrors the original's @GeneralConfigGroupInfo table
    SELECT
      tcg.ConfigurationGroupId,
      dd.DeviceKey,
      tcg.MobileDeviceTemplateKey,
      tcg.LibraryKey,
      tcg.ConfigurationGroupKey,
      dmd.Description AS MobileDevice
    FROM @configGroupIds cg
      INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.ConfigurationGroupId = cg.id
      INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK) ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey AND tcg.LibraryKey = mdt.LibraryKey
      INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
      INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
  ),
  MobileUnits AS (
    -- Mirrors the original's #mobileUnits table
    SELECT
      g.ConfigurationGroupId,
      mu.MobileUnitId,
      mu.MobileUnitKey,
      mu.MobileDeviceKey,
      (CASE WHEN mu.MobileDeviceKey = @STREAMAX_STANDALONE_DEVICE_KEY THEN mu.UniqueIdentifier ELSE ap.Value END) AS StreamaxSerialNumber
    FROM GeneralConfigGroupInfo g
    INNER JOIN [mobileunit].[MobileUnits] mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    LEFT JOIN [mobileunit].[AssetProperties] ap WITH (NOLOCK) ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId = @StreamaxSerialNumber
  ),
  AllConfigGroupLines AS (
    -- Mirrors the original's @AllConfigGroupLines table
    SELECT
      g.ConfigurationGroupId,
      dl.[Name] AS WireName,
      lpd.[Description] AS Connection,
      dl.LineId
    FROM GeneralConfigGroupInfo g
    LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey] = g.[DeviceKey]
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
    LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
    INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey] AND g.LibraryKey = td.LibraryKey
    INNER JOIN [definition].[Devices] tdd WITH (NOLOCK) ON tdd.[DeviceKey] = td.[DeviceKey]
    CROSS APPLY ( 
      SELECT [LineKey] = tpd.[LineKey]
      FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
      WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey] AND tpd.[LineKey]=dmdl.[LineKey]
    ) pd
    LEFT JOIN [definition].[Lines] pdl WITH (NOLOCK) ON pdl.[LineKey] = pd.[LineKey]
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) ON dmdlpd.[MobileDeviceKey] = g.DeviceKey AND dmdlpd.[LineKey] = pd.[LineKey] AND dmdlpd.[PeripheralDeviceKey] = tdd.[DeviceKey]
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN [library].[PeripheralDevices] lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey
  ),
  EffectiveLines AS (
    -- Mirrors the original's @EffectiveByMobileUnitId table
    SELECT
      mu.MobileUnitId,
      dl.[Name] AS WireName,
      lpd.[Description] AS Connection,
      pd.[IsOverridden],
      dl.LineId
    FROM MobileUnits mu
    INNER JOIN GeneralConfigGroupInfo g ON g.ConfigurationGroupId = mu.ConfigurationGroupId
    INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.[MobileDeviceTemplateKey] = g.[MobileDeviceTemplateKey]
    INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON dd.[DeviceKey] = td.[DeviceKey]
    CROSS APPLY ( 
      SELECT
        [LineKey] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN opd.[LineKey] ELSE tpd.[LineKey] END,
        [IsOverridden] = CAST(CASE WHEN opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL THEN 1 ELSE 0 END AS BIT)
      FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
      LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) ON opd.[MobileUnitKey] = mu.[MobileUnitKey] AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
      WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
        AND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)
        OR (opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))
    ) pd
    LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = pd.[LineKey]
    LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) ON dmdlpd.[MobileDeviceKey] = mu.[MobileDeviceKey] AND dmdlpd.[LineKey] = pd.[LineKey] AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]
    LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = g.LibraryKey
    LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey
  ),
  MobileUnitLines AS (
    -- Mirrors the original's @MobileUnitLines table
    SELECT
      mu.MobileUnitId,
      cgl.ConfigurationGroupId,
      cgl.LineId,
      cgl.WireName,
      eff.IsOverridden,
      [Connection] = CASE WHEN eff.IsOverridden = 1 THEN eff.Connection ELSE cgl.Connection END
    FROM MobileUnits mu
    INNER JOIN AllConfigGroupLines cgl ON cgl.ConfigurationGroupId = mu.ConfigurationGroupId
    LEFT JOIN EffectiveLines eff ON eff.MobileUnitId = mu.MobileUnitId AND eff.LineId = cgl.LineId
  )
  -- Final SELECT, exactly matching the original's structure
  SELECT
    mu.MobileUnitId,
    CanScriptLineId = STUFF((
      SELECT ', ' + CAST(l.[LineId] AS NVARCHAR(MAX))
      FROM MobileUnitLines l
      WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.MobileUnitId = mu.MobileUnitId
      AND (l.WireName = 'C1' OR l.WireName = 'C2')
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    CanScript = STUFF((
      SELECT ', ' + l.[Connection]
      FROM MobileUnitLines l
      WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.MobileUnitId = mu.MobileUnitId
      AND (l.WireName = 'C1' OR l.WireName = 'C2')
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''),
    Speed = CASE
      WHEN g.MobileDevice LIKE 'MiX2%' THEN 'GPS velocity as speed'
      WHEN g.MobileDevice LIKE 'FM%' THEN (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName LIKE ('F%')
          AND l.Connection LIKE '%SPEED%'
      )
      ELSE (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName = 'Speed'
      )
    END,
    RPM =   CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName LIKE ('F%')
          AND l.Connection LIKE '%RPM%'
      )
      ELSE (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName = 'RPM'
      )
    END,
    Fuel =  CASE
      WHEN g.MobileDevice LIKE 'FM%' THEN (
          SELECT [Connection]
          FROM MobileUnitLines l
          WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
          AND l.MobileUnitId = mu.MobileUnitId
          AND l.WireName LIKE ('F%')
          AND l.Connection LIKE '%Fuel%'
      )
      ELSE (
        SELECT [Connection]
        FROM MobileUnitLines l
        WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
        AND l.MobileUnitId = mu.MobileUnitId
        AND l.WireName = 'Fuel'
      )
    END,
    SP =    (
      SELECT [Connection]
      FROM MobileUnitLines l
      WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.MobileUnitId = mu.MobileUnitId
      AND l.WireName = 'SP'
    ),
    MiXVisionSerialnumber = mu.StreamaxSerialNumber,
    HOS =   (
      SELECT [Connection]
      FROM MobileUnitLines l
      WHERE l.ConfigurationGroupId = g.ConfigurationGroupId
      AND l.MobileUnitId = mu.MobileUnitId
      AND l.WireName = 'HOS'
    )
  FROM GeneralConfigGroupInfo g
    INNER JOIN MobileUnits mu 
      ON mu.ConfigurationGroupId = g.ConfigurationGroupId;
