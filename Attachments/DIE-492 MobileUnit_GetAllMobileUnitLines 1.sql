DECLARE @mobileUnitId     BIGINT = 1230279699646066688;
USE Deviceconfiguration;


-- AllLines ----------------------------------------------------------------------

DECLARE @AllLinesByMobileUnitId TABLE  
    (
  [GroupId]                BIGINT,
  [MobileUnitId]           BIGINT,
  [ConfigurationGroupId]   BIGINT,
  [ConfigurationGroupName] NVARCHAR(200),
  [WireName]               NVARCHAR(200),
  [SortOrder]              INT,
  [WireIconPath]           NVARCHAR(200),
  [Connection]             NVARCHAR(200),
  [IsOverridden]           BIT,
  [EquivalentLineName]     NVARCHAR(200),
  [Tacho]                  BIT
    );

INSERT INTO @AllLinesByMobileUnitId
SELECT
  [GroupId] = ll.GroupId,
  [MobileUnitId] = mu.MobileUnitId,
  [ConfigurationGroupId] = tcg.ConfigurationGroupId,
  [ConfigurationGroupName] = tcg.Name,
  [WireName] = dl.[Name],
  [SortOrder] = dl.[SortOrder],
  [WireIconPath] = dl.[IdentifyingImageName],
  [Connection] = '',
  [IsOverridden] = 0,
  [EquivalentLineName] = dl_e.[Name],
  [Tacho] = 0
FROM [mobileunit].[MobileUnits] mu WITH (NOLOCK)
  INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dmd.DeviceKey = mu.MobileDeviceKey
  INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.[ConfigurationGroupKey] = mu.[ConfigurationGroupKey]
  INNER JOIN [library].[Libraries] ll WITH (NOLOCK) ON ll.[LibraryKey] = tcg.[LibraryKey]
  LEFT JOIN [definition].[MobileDeviceLines] dmdl WITH (NOLOCK) ON dmdl.[MobileDeviceKey]   = mu.[MobileDeviceKey]
  LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = dmdl.[LineKey]
  LEFT JOIN [definition].[Lines] dl_e WITH (NOLOCK) ON dl_e.[LineKey] = dmdl.[EquivalentLineKey]
WHERE mu.MobileUnitId = @mobileUnitId


-- Effective Lines ----------------------------------------------------------------------

DECLARE @EffectiveByMobileUnitId TABLE  
    (
  [GroupId]      BIGINT,
  [MobileUnitId] BIGINT,
  [WireName]     NVARCHAR(200),
  [SortOrder]    INT,
  [WireIconPath] NVARCHAR(200),
  [Connection]   NVARCHAR(200),
  [IsOverridden] BIT,
  [Tacho]        BIT);

INSERT INTO @EffectiveByMobileUnitId
SELECT
  [GroupId] = ll.GroupId,
  [MobileUnitId] = mu.MobileUnitId,
  [WireName] = dl.[Name],
  [SortOrder] = CASE WHEN dl.DateUpdated IS NOT NULL THEN dl.[SortOrder] ELSE 0 END,
  [WireIconPath] = dl.[IdentifyingImageName],
  [Connection] = lpd.[Description],
  [IsOverridden] = pd.[IsOverridden],
  [Tacho] = pd.[Tacho]

--General Mobileunit info
FROM [mobileunit].[MobileUnits] mu WITH (NOLOCK)
  INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dmd.DeviceKey = mu.MobileDeviceKey
  INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.[ConfigurationGroupKey] = mu.[ConfigurationGroupKey]
  INNER JOIN [library].[Libraries] ll WITH (NOLOCK) ON ll.[LibraryKey] = tcg.[LibraryKey]
  INNER JOIN [template].[Devices] td WITH (NOLOCK) ON td.[MobileDeviceTemplateKey] = tcg.[MobileDeviceTemplateKey]
  INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON dd.[DeviceKey] = td.[DeviceKey]
 


--Peripheral Devices
	CROSS APPLY ( SELECT
		[LineKey] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN opd.[LineKey] ELSE tpd.[LineKey] END,
		[IsOverridden] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN
										CASE WHEN opd.[LineKey] IS NOT NULL THEN 'true' 
										ELSE 'false' END
									 ELSE 'false' END,
		[Tacho] = CASE WHEN opd.[MobileUnitKey] IS NOT NULL THEN opd.[RecordInterval] ELSE tpd.[RecordInterval] END
    
	  FROM [template].[PeripheralDevices] tpd WITH (NOLOCK)
		LEFT JOIN [mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK) ON opd.[MobileUnitKey]     = mu.[MobileUnitKey]
		  AND opd.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]
	  WHERE tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
		AND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)
		OR(opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))) pd



  LEFT JOIN [definition].[Lines] dl WITH (NOLOCK) ON dl.[LineKey] = pd.[LineKey]

  --Lines
  LEFT JOIN [definition].[MobileDeviceLinePeripheralDevices] dmdlpd WITH (NOLOCK) ON dmdlpd.[MobileDeviceKey]     = mu.[MobileDeviceKey]
    AND dmdlpd.[LineKey]             = pd.[LineKey]
    AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]

  --Get the connected device
  LEFT JOIN [library].[Devices] ld WITH (NOLOCK) ON ld.DeviceKey = dmdlpd.PeripheralDeviceKey AND ld.LibraryKey = tcg.LibraryKey
  LEFT JOIN library.PeripheralDevices lpd WITH (NOLOCK) ON lpd.LibraryDeviceKey = ld.LibraryDeviceKey

WHERE mu.MobileUnitId = @mobileUnitId


-- Mashup of the two tables ----------------------------------------------------------------------


--definition.MobileDeviceLines.CanRecordInterval
--ALSO check CREATE PROCEDURE [mobileunit].[MobileUnit_CanLineDoTacho] 
--REDIRECTED lines...!
--CREATE PROCEDURE [dbo].[cmdVehicles_GetTachoLines]

-- CASE WHEN md.[MobileUnitKey] IS NOT NULL THEN opd.[RecordInterval] ELSE tpd.[RecordInterval] END

-- [mobileunit].[OverridenDevices] md
-- [mobileunit].[OverridenPeripheralDevices] opd ON mu.[MobileUnitKey] = opd.[MobileUnitKey] AND td.[TemplateDeviceKey] = opd.[TemplateDeviceKey]
-- [template].[PeripheralDevices] tpd ON td.[TemplateDeviceKey] = tpd.[TemplateDeviceKey]

SELECT
  --a.[GroupId],
  --a.[MobileUnitId],
  --a.[ConfigurationGroupId],
  --a.[ConfigurationGroupName],
  [Line] = CASE WHEN eff.Connection IS NOT NULL 
			THEN 
				CASE WHEN a.[EquivalentLineName] IS NOT NULL 
				THEN eff.[WireName] + ' (' +  a.[EquivalentLineName] + ')'
				ELSE eff.[WireName] 
				END
			ELSE 
				CASE WHEN a.[EquivalentLineName] IS NOT NULL 
				THEN a.[WireName] + ' (' + a.[EquivalentLineName] + ')'
				ELSE a.[WireName] 
				END
			END,
  --[EquivalentLine] = CASE WHEN a.[EquivalentLineName] IS NOT NULL THEN a.[EquivalentLineName] ELSE '' END,
  [Tacho] = CASE WHEN eff.[Tacho] IS NOT NULL THEN 
				CASE WHEN eff.[Tacho] = 1 THEN 'X' ELSE '' END
			ELSE '' END,
  --SortOrder = CASE WHEN eff.[Connection] IS NOT NULL THEN eff.[SortOrder] ELSE a.[SortOrder] END,
  --WireIconPath = CASE WHEN eff.[Connection] IS NOT NULL THEN eff.[WireIconPath] ELSE a.[WireIconPath] END,
  [ConnectedDevice] = CASE WHEN eff.[Connection] IS NOT NULL THEN eff.[Connection] ELSE '**  Not connected **' END
--IsOverridden = eff.[IsOverridden],
  

FROM @AllLinesByMobileUnitId a
  LEFT JOIN @EffectiveByMobileUnitId eff ON eff.[MobileUnitId] = a.[MobileUnitId]
    AND eff.[WireName] = a.[WireName]
ORDER BY a.SortOrder

-- TODO: MR: Also need the Config / Setting ?? ----------------------------------------------------------------------

