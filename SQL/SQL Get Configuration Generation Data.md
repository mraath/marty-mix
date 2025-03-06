---
created: 2023-11-15T11:13
updated: 2023-11-15T11:16
---

```sql
-- Based on PROCEDURE [mobileunit].[MobileUnit_GetGenerationData]
-- Use this to get the PSKKey value for an asset to see if the leading 0 has been removed
USE Deviceconfiguration;

DECLARE @mobileUnitId BIGINT = 1159262212995481600;         -- REPLACE with what you want to test

DECLARE @libraryKey INT;
DECLARE @mobileUnitKey INT;
DECLARE @mobileDeviceTemplateKey INT;
DECLARE @mobileDeviceKey INT;
DECLARE @eventTemplateKey INT;
DECLARE @locationTemplateKey INT;
DECLARE @isMesaBased BIT;

DECLARE @connectedDevices TABLE
(
  [DeviceKey]           INT         NOT NULL PRIMARY KEY,
  [DeviceId]            BIGINT      NOT NULL,
  [DeviceType]          TINYINT     NOT NULL,
  [IsEnabled]           BIT         NOT NULL,
  [LineKey]             VARCHAR(5)  NULL,
  [RecordInterval]      BIT         NOT NULL,
  [PowerDeviceKey]      INT         NULL
);

DECLARE @connectedParameters TABLE
(
  [ParameterKey]            INT PRIMARY KEY,
  [LibraryParameterKey]     INT,
  [ParameterId]             BIGINT,
  [SystemName]              NVARCHAR(255),
  [Description]             NVARCHAR(255),
  [DisplayUnits]            NVARCHAR(15),
  [IsFuelCounter]           BIT,
  [LegacyParameterId]       SMALLINT,
  [ConnectedDeviceKey]      INT,
  [ValueFormatType]         TINYINT,
  [CalibrationType]         TINYINT,
  [HasVariableCalibration]  BIT,
  [DeviceType]              TINYINT,
  [ConditionDefinition]     NVARCHAR(MAX),
  [ActionDefinition]        NVARCHAR(MAX),
  [ActionReturnSize]        TINYINT
);

DECLARE @connectedEvents TABLE
(
  [EventKey]            INT PRIMARY KEY,
  [EventId]             BIGINT
);
DECLARE @eventConditions TABLE
(
  [EventKey]        INT,
  [ParameterId]     BIGINT,
  [Operator]        NVARCHAR(2),
  [Value]           DECIMAL(28, 6),
  [JoinOperator]    NVARCHAR(2)
);

SELECT
  @libraryKey              = tcg.[LibraryKey],
  @mobileUnitKey           = mmu.[MobileUnitKey],
  @mobileDeviceKey         = mmu.[MobileDeviceKey],
  @mobileDeviceTemplateKey = tcg.[MobileDeviceTemplateKey],
  @eventTemplateKey        = tcg.[EventTemplateKey],
  @locationTemplateKey     = tcg.[LocationTemplateKey]
FROM
  [mobileunit].[MobileUnits] mmu
    INNER JOIN
  [template].[ConfigurationGroups] tcg ON mmu.[ConfigurationGroupKey] = tcg.[ConfigurationGroupKey]
WHERE [MobileUnitId] = @mobileUnitId;

WITH data ([DeviceKey], [IsEnabled], [LineKey], [RecordInterval], [PowerDeviceKey]) AS
(
  SELECT
    ld.[DeviceKey],
    CASE WHEN md.[MobileUnitKey] IS NULL THEN td.[IsEnabled] ELSE md.[IsEnabled] END,
    CASE WHEN mpd.[MobileUnitKey] IS NULL THEN tpd.[LineKey] ELSE mpd.[LineKey] END,
    ISNULL(CASE WHEN mpd.[MobileUnitKey] IS NULL THEN tpd.[RecordInterval] ELSE mpd.[RecordInterval] END, 0),
    CASE WHEN mpd.[MobileUnitKey] IS NULL THEN tpd.[PowerDeviceKey] ELSE mpd.[PowerDeviceKey] END
  FROM
    [library].[Devices] ld
      INNER JOIN
    [template].[Devices] td ON @mobileDeviceTemplateKey = td.[MobileDeviceTemplateKey]
                           AND ld.[LibraryKey]          = td.[LibraryKey]
                           AND ld.[DeviceKey]           = td.[DeviceKey]
      LEFT JOIN
    [template].[PeripheralDevices] tpd ON td.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
      LEFT JOIN
    [mobileunit].[OverridenDevices] md ON @mobileUnitKey = md.[MobileUnitKey] AND td.[TemplateDeviceKey] = md.[TemplateDeviceKey]
      LEFT JOIN
    [mobileunit].[OverridenPeripheralDevices] mpd ON @mobileUnitKey = mpd.[MobileUnitKey] AND tpd.[TemplateDeviceKey] = mpd.[TemplateDeviceKey]
)
INSERT INTO @connectedDevices
  SELECT
    data.[DeviceKey],
    dd.[DeviceId],
    dd.[DeviceType],
    data.[IsEnabled],
    data.[LineKey],
    data.[RecordInterval],
    data.[PowerDeviceKey]
  FROM
    data
      INNER JOIN
    [definition].[Devices] dd ON data.[DeviceKey] = dd.[DeviceKey]
  WHERE
    [IsEnabled] = 1;

SET @isMesaBased = CASE WHEN EXISTS (SELECT * FROM @connectedDevices WHERE [DeviceId] = 2661058860026395155) --MobileDevice.Logical.Base.MESA 
    THEN 1
    ELSE 0
END;

WITH linkedParameters ([ParameterKey], [DeviceKey], [DeviceType], [CalibrationType], [row]) AS
(
  SELECT
    dp.[ParameterKey],
    dp.[DeviceKey],
    cd.[DeviceType],
    dp.[CalibrationType],
    ROW_NUMBER() OVER(PARTITION BY dp.[ParameterKey] ORDER BY cd.[DeviceType] DESC, cd.[DeviceKey])
  FROM
    @connectedDevices cd
      INNER JOIN
    [definition].[DeviceParameters] dp ON cd.[DeviceKey] = dp.[DeviceKey]
)
, uniqueParameters ([ParameterKey], [DeviceKey], [DeviceType], [CalibrationType]) AS
(
  SELECT [ParameterKey], [DeviceKey], [DeviceType], [CalibrationType]
  FROM   linkedParameters
  WHERE  [row] = 1
)
INSERT INTO @connectedParameters
  SELECT
    up.[ParameterKey],
    lp.[LibraryParameterKey],
    dp.[ParameterId],
    dp.[SystemName],
    lp.[Description],
    lp.[DisplayUnits],
    lp.[IsFuelCounter],
    lp.[LegacyParameterId],
    up.[DeviceKey],
    dp.[ValueFormatType],
    up.[CalibrationType],
    dct.[HasVariableCalibration],
    up.[DeviceType],
    dp.[ConditionDefinition],
    dp.[ActionDefinition],
    dp.[ActionReturnSize]
  FROM
    uniqueParameters up
      INNER JOIN
    [definition].[CalibrationTypes] dct ON up.[CalibrationType] = dct.[CalibrationType]
      INNER JOIN
    [definition].[Parameters] dp ON up.[ParameterKey] = dp.[ParameterKey]
      LEFT JOIN
    [library].[Parameters] lp ON @libraryKey = lp.[LibraryKey]
                             AND up.[ParameterKey] = lp.[ParameterKey];

-- update the  parameters connected to I1->I8, F3->F4
DECLARE @definition NVARCHAR(MAX);
UPDATE trg
SET
  @definition           = CASE
                            WHEN cd.[DeviceType] = 8 THEN l.[AlternativeDefinition]
                                -- special case for HI-res speed. Need to figure out how to do this properly!
                            WHEN cd.DeviceId = -8946953342866214293 THEN '<Input>PrecisionSpeed</Input>'
                                -- special case for Fuel Difference. Need to figure out how to do this properly!
                            WHEN trg.ParameterId = -6574647361581776949 THEN trg.[ConditionDefinition]
                                -- for MESA we prefer to use the parameter definition
                            WHEN @isMesaBased = 1 THEN ISNULL(trg.[ConditionDefinition], l.[Definition] )
                            ELSE ISNULL(l.[Definition], trg.[ConditionDefinition])
                          END,
  [ConditionDefinition] = @definition,
  [ActionDefinition]    = CASE
                                -- for MESA we prefer to use the parameter definition
                            WHEN @isMesaBased = 1 AND @definition LIKE '<DDCall%' THEN '<Input>LastDDriverReturn</Input>' + @definition
                            WHEN trg.[ValueFormatType] > 1 THEN @definition
                                -- special case for Fuel Difference. Need to figure out how to do this properly!
                            WHEN trg.ParameterId = -6574647361581776949 THEN trg.[ActionDefinition]
                            ELSE NULL
                          END,
  [ActionReturnSize]    = CASE
                            WHEN trg.[ValueFormatType] = 1 THEN NULL
                            WHEN cd.[DeviceType] = 8 THEN l.[AlternativeReturnSize]
                            WHEN cd.DeviceId = -8946953342866214293 THEN 2
                                -- special case for Fuel Difference. Need to figure out how to do this properly!
                            WHEN trg.ParameterId = -6574647361581776949 THEN trg.[ActionReturnSize]
                            ELSE ISNULL(l.[ReturnSize], trg.[ActionReturnSize])
                          END
FROM
  @connectedParameters trg
    INNER JOIN
  @connectedDevices cd ON trg.[ConnectedDeviceKey] = cd.[DeviceKey]
    INNER JOIN
  [definition].[Lines] l ON cd.[LineKey] = l.[LineKey]
WHERE
  trg.LegacyParameterId < 10000;

-- update the parameter Condition and Action definition for MESA units so that they do not use the softclock variable
IF @isMesaBased = 1
BEGIN
	UPDATE @connectedParameters SET 
		[ConditionDefinition] = '<Input>CurrentTime</Input>',
		[ActionDefinition] = '<Input>CurrentTime</Input>'
	WHERE [ParameterId] = -2267422830731559915;
	UPDATE @connectedParameters SET 
		[ConditionDefinition] = '<Input>CurrentDateTime</Input>',
		[ActionDefinition] = '<Input>CurrentDateTime</Input>'
	WHERE [ParameterId] = 3334860652514618754;
	UPDATE @connectedParameters SET
		[ActionReturnSize] = 4
	WHERE [ParameterId] = 1772016337543624622;
END

 -- start with all events in the template that have no return Parameter, and those where the Parameter is connected
INSERT INTO @connectedEvents
  SELECT
    de.[EventKey],
    de.[EventId]
  FROM
    [definition].[Events] de
      INNER JOIN
    [template].[Events] te ON de.[EventKey] = te.[EventKey]
      LEFT JOIN
    [mobileunit].[OverridenEvents] me ON @mobileUnitKey = me.[MobileUnitKey] AND te.[TemplateEventKey] = me.[TemplateEventKey]
      LEFT JOIN
    @connectedParameters cp ON de.[ReturnParameterKey] = cp.[ParameterKey]
  WHERE
    te.EventTemplateKey = @eventTemplateKey
    AND (me.[OverridenEventId] IS NULL OR me.[IsEnabled] = 1)
    AND (de.ReturnParameterKey IS NULL OR cp.ParameterKey IS NOT NULL);

DELETE
  @connectedEvents
FROM
  @connectedEvents ce
WHERE
  EXISTS (SELECT 1 FROM
            [template].[EventConditions] tec
              LEFT JOIN
            @connectedParameters cp ON tec.[ParameterKey] = cp.[ParameterKey]
          WHERE
            tec.EventTemplateKey = @eventTemplateKey
            AND tec.[EventKey] = ce.[EventKey]
            AND tec.[IsRequired] = 1
            AND cp.ParameterKey IS NULL);

INSERT INTO @eventConditions
  SELECT
    ce.[EventKey],
    cp.[ParameterId],
    tec.[Operator],
    [Value] = CASE WHEN mec.[MobileUnitKey] IS NULL THEN tec.[Value] ELSE mec.[Value] END,
    tec.[JoinOperator]
  FROM
    @connectedEvents ce
      INNER JOIN
    [template].[EventConditions] tec ON @eventTemplateKey = tec.[EventTemplateKey] AND ce.[EventKey] = tec.[EventKey]
      INNER JOIN
    @connectedParameters cp ON tec.[ParameterKey] = cp.[ParameterKey]
      LEFT JOIN
    [mobileunit].[OverridenEventConditionThresholds] mec ON mec.[MobileUnitKey] = @mobileUnitKey AND tec.[TemplateEventConditionKey] = mec.[TemplateEventConditionKey];

  -- remove events with no condition!
DELETE
  @connectedEvents
FROM
  @connectedEvents ce
    LEFT JOIN
  @eventConditions ec ON ce.EventKey = ec.EventKey
WHERE
  ec.EventKey IS NULL;

--================================

-- And finaly return all the required recordsets:

SELECT
  dd.[DeviceId],
  dd.[DeviceType],
  dd.[SystemName],
  [Description] = COALESCE(lpd.[Description], dld.[DisplayLabel], dd.[SystemName]),
  cd.[IsEnabled],
  [Line] = ISNULL(l_r.[Name], l.[Name]),
  [RedirectedFromLine] = CASE WHEN l_r.[Name] IS NOT NULL THEN l.[Name] ELSE NULL END,
  cd.[RecordInterval],
  [PowerDeviceId] = pdd.[DeviceId]
FROM
  @connectedDevices cd
    INNER JOIN
  [library].[Devices] ld ON @libraryKey = ld.[LibraryKey] AND cd.[DeviceKey] = ld.[DeviceKey]
    INNER JOIN
  [definition].[Devices] dd ON cd.[DeviceKey] = dd.[DeviceKey]
    LEFT JOIN
  [library].[PeripheralDevices] lpd ON ld.[LibraryDeviceKey] = lpd.[LibraryDeviceKey]
    LEFT JOIN
  [definition].[LogicalDevices] dld ON dd.[DeviceKey] = dld.[DeviceKey]
    LEFT JOIN
  [definition].[Lines] l ON cd.[LineKey] = l.[LineKey]
    LEFT JOIN
  [definition].[Devices] pdd ON cd.[PowerDeviceKey] = pdd.[DeviceKey]
    LEFT JOIN
  [definition].[MobileDeviceLinePeripheralDevices] mdlpd ON @mobileDeviceKey = mdlpd.[MobileDeviceKey]
                                                        AND cd.[LineKey] = mdlpd.[LineKey]
                                                        AND cd.[DeviceKey] = mdlpd.[PeripheralDeviceKey]
    LEFT JOIN
  [definition].[Lines] l_r ON mdlpd.[RedirectedLineKey] = l_r.[LineKey];

WITH data ([DeviceId], [PropertyKey], [Value]) AS
(
  SELECT
    cp.[DeviceId],
    tdp.[PropertyKey],
    [Value] = CASE WHEN mdp.[MobileUnitKey] IS NULL THEN tdp.[Value] ELSE mdp.[Value] END
  FROM
    @connectedDevices cp
      INNER JOIN
    [template].[DeviceProperties] tdp ON @mobileDeviceTemplateKey = tdp.[MobileDeviceTemplateKey]
                                     AND cp.[DeviceKey] = tdp.[DeviceKey]
      LEFT JOIN
    [mobileunit].[OverridenDeviceProperties] mdp ON mdp.[MobileUnitKey] = @mobileUnitKey AND tdp.[TemplateDevicePropertyKey] = mdp.[TemplateDevicePropertyKey]
UNION ALL
  SELECT
    dd.[DeviceId],
    mup.[PropertyKey],
    mup.[Value]
  FROM
    [mobileunit].[MobileUnitProperties] mup
      INNER JOIN
    [definition].[Devices] dd ON mup.[DeviceKey] = dd.[DeviceKey]
  WHERE
    mup.[MobileUnitKey] = @mobileUnitKey
)
SELECT
  data.[DeviceId],
  dp.[PropertyId],
  dp.[PropertyName],
  dp.[ValueFormatType],
  data.[Value]
FROM
  data
    INNER JOIN
  [definition].[Properties] dp ON data.[PropertyKey] = dp.[PropertyKey];

SELECT
  cp.[ParameterId],
  cp.[Description],
  cp.[DisplayUnits],
  cp.[SystemName],
  cp.[ValueFormatType],
  cp.[IsFuelCounter],
  cp.[LegacyParameterId],
  cp.[ConditionDefinition],
  cp.[ActionDefinition],
  cp.[ActionReturnSize],
  cp.[CalibrationType],
  cp.[DeviceType],
  [Calibration1] = CASE WHEN cp.[HasVariableCalibration] = 1 THEN
                      CASE WHEN mdp.[MobileUnitKey] IS NOT NULL THEN
                          mdp.[Calibration1]
                        ELSE
                          tdp.[Calibration1]
                        END
                    ELSE
                      NULL
                    END,
  [Value1]      = CASE WHEN cp.[HasVariableCalibration] = 1 THEN
                      CASE WHEN mdp.[MobileUnitKey] IS NOT NULL THEN
                          mdp.[Value1]
                        ELSE
                          tdp.[Value1]
                        END
                    ELSE
                      NULL
                    END,
  [Calibration2] = CASE WHEN cp.[HasVariableCalibration] = 1 THEN
                      CASE WHEN mdp.[MobileUnitKey] IS NOT NULL THEN
                          mdp.[Calibration2]
                        ELSE
                          tdp.[Calibration2]
                        END
                    ELSE
                      NULL
                    END,
  [Value2]       = CASE WHEN cp.[HasVariableCalibration] = 1 THEN
                      CASE WHEN mdp.[MobileUnitKey] IS NOT NULL THEN
                          mdp.[Value2]
                        ELSE
                          tdp.[Value2]
                        END
                    ELSE
                      NULL
                    END
FROM
  @connectedParameters cp
    LEFT JOIN
  [template].[DeviceParameters] tdp ON @mobileDeviceTemplateKey = tdp.[MobileDeviceTemplateKey]
                                   AND cp.[ParameterKey] = tdp.[ParameterKey]
                                   AND cp.[ConnectedDeviceKey] = tdp.[DeviceKey]
    LEFT JOIN
  [mobileunit].[OverridenDeviceParameters] mdp ON @mobileUnitKey = mdp.[MobileUnitKey]
                                              AND tdp.[TemplateDeviceParameterKey] = mdp.[TemplateDeviceParameterKey]

SELECT
  de.[EventId],
  le.[LegacyEventId],
  le.[Description],
  de.[Mnemonic],
  de.[ReturnActionType],
  [ReturnParameterId] = cp.[ParameterId]
FROM
  @connectedEvents ce
    INNER JOIN
  [library].[Events] le ON @libraryKey = le.[LibraryKey]
                       AND ce.[EventKey] = le.[EventKey]
    INNER JOIN
  [definition].[Events] de ON ce.[EventKey] = de.[EventKey]
    LEFT JOIN
  @connectedParameters cp ON de.[ReturnParameterKey] = cp.[ParameterKey];

SELECT
  ce.[EventId],
  tec.[Sequence],
  cp.[ParameterId],
  tec.[Operator],
  [Value] = CASE WHEN mec.[MobileUnitKey] IS NULL THEN tec.[Value] ELSE mec.[Value] END,
  tec.[JoinOperator]
FROM
  @connectedEvents ce
    INNER JOIN
  [template].[EventConditions] tec ON @eventTemplateKey = tec.[EventTemplateKey] AND ce.[EventKey] = tec.[EventKey]
    LEFT JOIN
  [mobileunit].[OverridenEventConditionThresholds] mec ON @mobileUnitKey = mec.[MobileUnitKey] AND tec.[TemplateEventConditionKey] = mec.[TemplateEventConditionKey]
    INNER JOIN
  @connectedParameters cp ON tec.[ParameterKey] = cp.[ParameterKey];

WITH data ([EventId], [EventActionType], [IsEnabled], [Delay], [ActionSettings]) AS
(
  SELECT
    ce.[EventId],
    tea.[EventActionType],
    CASE WHEN mea.[MobileUnitKey] IS NULL THEN tea.[IsEnabled] ELSE mea.[IsEnabled] END,
    CASE WHEN mea.[MobileUnitKey] IS NULL THEN tea.[Delay] ELSE mea.[Delay] END,
    CASE WHEN mea.[MobileUnitKey] IS NULL THEN tea.[ActionSettings] ELSE mea.[ActionSettings] END
  FROM
    @connectedEvents ce
      INNER JOIN
    [template].[EventActions] tea ON @eventTemplateKey = tea.[EventTemplateKey] AND ce.[EventKey] = tea.[EventKey]
      LEFT JOIN
    [mobileunit].[OverridenEventActions] mea ON @mobileUnitKey = mea.[MobileUnitKey] AND tea.[TemplateEventActionKey] = mea.[TemplateEventActionKey]
)
SELECT
  [EventId],
  [EventActionType],
  [Delay],
  [ActionSettings]
FROM
  data
WHERE
  [IsEnabled] = 1;

--get location details
SELECT
  ll.[DmxLocationId],
  tl.[TemplateLocationId],
  tl.[SpeedLimit],
  tl.[WarningDelay],
  tl.[RecordingDelay],
  tl.[SpeedBuffer],
  tl.[EnableActiveMessageDelay],
  tl.[ActiveMessageDelay],
  tl.[EnableActiveMessageExcessiveSpeedLimit],
  tl.[ActiveMessageExcessiveSpeedLimit],
  tl.[ActiveMessagePriority]
FROM
  [template].[Locations] tl
    INNER JOIN
  [library].Locations ll ON tl.LibraryLocationKey = ll.LibraryLocationKey
WHERE
  tl.LocationTemplateKey = @locationTemplateKey;

SELECT 
  dp.SystemName
FROM
  [template].[DeviceParameters] tdp
    JOIN
  [template].[MobileDeviceTemplates] mdt on tdp.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
    JOIN
  [library].[DeviceParameters] ldp on tdp.ParameterKey = ldp.ParameterKey and tdp.LibraryKey = ldp.LibraryKey and tdp.DeviceKey = ldp.DeviceKey
    JOIN
  [definition].[Parameters] dp on ldp.ParameterKey = dp.ParameterKey
    JOIN
  [definition].[Devices] dd on tdp.DeviceKey = dd.DeviceKey
    LEFT OUTER JOIN
  [mobileunit].[OverridenCanParameters] ocp on tdp.TemplateDeviceParameterKey = ocp.TemplateDeviceParameterKey
WHERE
  dd.DeviceId = -6553357677453916166 and mdt.MobileDeviceTemplateKey = @mobileDeviceTemplateKey and (ocp.IsEnabled is null or ocp.IsEnabled = 1)


```