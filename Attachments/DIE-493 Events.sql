DECLARE @mobileunitId BIGINT = 1086046864838615040;

-- BASIC CONFIGURATION -----------------------------------------
  DECLARE @configuration TABLE (
    MobileUnitId            BIGINT,
	MobileUnitKey			INT,
    EventTemplate           NVARCHAR(250),
	EventTemplateKey		INT
   );

  INSERT INTO @configuration
  SELECT
    mu.MobileUnitId,
	mu.MobileUnitKey,
    et.Name EventTemplate,
	et.EventTemplateKey EventTemplateKey
  FROM mobileunit.MobileUnits mu WITH (NOLOCK)
    INNER JOIN template.ConfigurationGroups cg WITH (NOLOCK)
		ON cg.ConfigurationGroupKey = mu.ConfigurationGroupKey
    LEFT JOIN template.EventTemplates et WITH (NOLOCK)
		ON et.EventTemplateKey = cg.EventTemplateKey
  WHERE mu.MobileUnitId = @mobileunitId;

  --SELECT * FROM @configuration
  DECLARE @EventTemplateKey INT = (SELECT EventTemplateKey FROM @configuration);
  DECLARE @MobileUnitKey INT = (SELECT MobileUnitKey FROM @configuration);

-- TEMPLATE EVENTS -----------------------------------------
  DECLARE @templateEvent TABLE (
	TemplateEventKey		INT,
	EventTemplateKey		INT,
	LibraryKey				INT,
	EventKey				INT,
	EventDescription		NVARCHAR(100),
	EventType				NVARCHAR(20),
	IsEnabled				INT
  )

  INSERT INTO @templateEvent
  Select 
	te.TemplateEventKey,
	te.EventTemplateKey,
	te.LibraryKey,
	te.EventKey,
	le.[Description], 
	det.[Description],
	IsEnabled = CASE WHEN moe.[TemplateEventKey] IS NOT NULL THEN moe.[IsEnabled] ELSE 1 END
  FROM [template].[Events] te WITH (NOLOCK)
  INNER JOIN [library].[Events] le WITH (NOLOCK)
	ON te.LibraryKey = le.LibraryKey AND te.EventKey = le.EventKey
  INNER JOIN [definition].[Events] de WITH (NOLOCK)
	ON de.EventKey = le.EventKey
  INNER JOIN [definition].[EventTypes] det WITH (NOLOCK)
	ON det.EventType = de.EventType

  --also overridden
  LEFT JOIN [mobileunit].[OverridenEvents] moe WITH (NOLOCK)
	ON moe.[MobileUnitKey] = @MobileUnitKey
	AND te.[TemplateEventKey] = moe.[TemplateEventKey]


  WHERE te.EventTemplateKey = @EventTemplateKey
  ORDER BY le.[Description]

  --SELECT * FROM @templateEvent
  

-- EVENT CONDITIONS -----------------------------------------
  
  DECLARE @EventConditions TABLE (
	EventKey			INT,
	[Sequence]			INT,
	[Description]		NVARCHAR(100),
	Operator			NVARCHAR(5),
	[Value]				NVARCHAR(10),
	[DisplayUnits]		NVARCHAR(10),
	JoinOperator		NVARCHAR(10)
  )

  INSERT INTO @EventConditions --replace CASE with Coalesce 
  Select 
	tec.EventKey,
	tec.[Sequence],
	lp.[Description],
	CASE WHEN tec.Operator = '' THEN 'is' ELSE tec.Operator END as Operator,
	CASE WHEN tec.[Value] = -1 THEN 'true' ELSE FORMAT(tec.[Value], '#0') END as [Value],
	CASE WHEN lp.[DisplayUnits] IS NULL THEN '' ELSE lp.[DisplayUnits] END as [DisplayUnits],
	CASE WHEN tec.JoinOperator IS NULL THEN '' ELSE tec.JoinOperator END as JoinOperator
  FROM [template].[Events] te WITH (NOLOCK)

  INNER JOIN [template].[EventConditions] tec WITH (NOLOCK)
	ON tec.EventTemplateKey = te.EventTemplateKey 
		AND tec.LibraryKey = te.LibraryKey
		AND tec.EventKey = te.EventKey
  INNER JOIN [library].[Parameters] lp WITH (NOLOCK)
	ON lp.ParameterKey = tec.ParameterKey
		AND lp.LibraryKey = tec.LibraryKey
  WHERE te.EventTemplateKey = @EventTemplateKey
  ORDER By tec.EventKey, tec.[Sequence]

  --SELECT * FROM @eventConditions

  DECLARE @eventConcatenatedConditions TABLE (
	EventKey			INT,
	Condition			NVARCHAR(500)
  )
  INSERT INTO @eventConcatenatedConditions
  SELECT 
	  EventKey,
	  CONCAT(
		[Description],
		' ',
		[Operator],
		' ',
		[Value],
		' ',
		DisplayUnits,
		' ',
		replace(replace(JoinOperator, '&&', 'and'), '||', 'or')
	) as Condition
  FROM @EventConditions

  --SELECT * FROM @eventConcatenatedConditions

  -- Seems like there is no overridden info for these conditions, only condition thresholds


-- EVENT ACTIONS -----------------------------------------------

  DECLARE @RecordingTypes TABLE (
	 RecordType		INT,
	 [Description]	NVARCHAR(50)
  )
  INSERT INTO @RecordingTypes VALUES (1, 'Detailed');
  INSERT INTO @RecordingTypes VALUES (2, 'Summarised');
  INSERT INTO @RecordingTypes VALUES (3, 'Notification');

  DECLARE @tmpEventActions TABLE (
	EventKey			INT,
	IsEnabled			BIT,
	[Delay]				INT,
	ActionSettings		XML
  )
  INSERT INTO @tmpEventActions
  Select 
  te.EventKey, 
  IsEnabled				= CASE WHEN moea.[TemplateEventActionKey] IS NOT NULL THEN moea.[IsEnabled] ELSE tea.[IsEnabled] END,
  [Delay]				= CASE WHEN moea.[TemplateEventActionKey] IS NOT NULL THEN moea.[Delay] ELSE tea.[Delay] END,
  [ActionSettings]		= CASE WHEN moea.[TemplateEventActionKey] IS NOT NULL THEN moea.[ActionSettings] ELSE tea.[ActionSettings] END
  FROM @templateEvent te
  INNER JOIN template.EventActions tea WITH (NOLOCK)
	ON te.EventTemplateKey = tea.EventTemplateKey
	AND te.LibraryKey = tea.LibraryKey
	AND te.EventKey = tea.EventKey
  --also overridden
  LEFT JOIN [mobileunit].[OverridenEventActions] moea WITH (NOLOCK)
	ON moea.[MobileUnitKey] = @MobileUnitKey
	AND tea.[TemplateEventActionKey] = moea.[TemplateEventActionKey]
  WHERE tea.EventActionType = 1 --Record
  
  --SELECT * FROM @tmpEventActions

  DECLARE @TemplateEventActions TABLE (
	EventKey			INT,
	[Description]		NVARCHAR(50),
	[Delay]				NVARCHAR(50),
	video				BIT,
	startOdometer		BIT,
	endOdometer			BIT,
	startPosition		BIT,
	endPosition			BIT
  )
  INSERT INTO @TemplateEventActions
  SELECT
	ea.[EventKey],
	rtd.[Description],
	CASE WHEN ea.[IsEnabled] = 1 
		THEN CONVERT(varchar, DATEADD(ms, ea.[Delay] * 1000, 0), 108)
		ELSE 'Disabled' END										[Delay],
	a.s.value('@video[1]' , 'BIT')								video,
	a.s.value('@startOdometer[1]' , 'BIT')						startOdometer,
	a.s.value('@endOdometer[1]' , 'BIT')						endOdometer,
	a.s.value('@startPosition[1]' , 'BIT')						startPosition,
	a.s.value('@endPosition[1]' , 'BIT')						endPosition
  FROM @tmpEventActions ea
  CROSS APPLY
	ea.[ActionSettings].nodes('/settings') a(s)
  CROSS APPLY ( SELECT rt.[Description] 
	FROM @RecordingTypes rt 
	WHERE rt.RecordType = a.s.value('@recordType[1]' , 'INT')
	) rtd

  --SELECT * FROM @TemplateEventActions


-- This will be the final concatenated value being sent through

Select 
	te.IsEnabled,
	te.EventDescription + ': (' +
	(SELECT '' + Condition AS 'data()'
         FROM @eventConcatenatedConditions 
		 WHERE EventKey = te.EventKey
		 FOR XML PATH(N''),TYPE).value('.','varchar(max)'
	) + ') '			[Description],
	tea.[Description]	EventType,
	tea.[Delay],
	tea.video,
	tea.startOdometer,
	tea.endOdometer,
	tea.startPosition,
	tea.endPosition,
	''					Summary
FROM @templateEvent te
LEFT JOIN @TemplateEventActions tea
	ON tea.EventKey = te.EventKey
