DECLARE @mobileunitId BIGINT = 1230279699646066688;
USE DeviceConfiguration;

--Get MobileUnit Information needed
DECLARE @configuration TABLE (
  MobileUnitKey				INT,
  ConfigurationGroup		NVARCHAR(250),
  MobileDeviceTemplateKey   INT,
  MobileDeviceKey			INT
 );

INSERT INTO @configuration
SELECT
  mu.MobileUnitKey,
  cg.Name ConfigurationGroup,
  mdt.MobileDeviceTemplateKey,
  mdt.MobileDeviceKey
FROM mobileunit.MobileUnits mu WITH (NOLOCK)
INNER JOIN template.ConfigurationGroups cg WITH (NOLOCK)
	ON cg.ConfigurationGroupKey = mu.ConfigurationGroupKey
LEFT JOIN template.MobileDeviceTemplates mdt WITH (NOLOCK)
	ON mdt.MobileDeviceTemplateKey = cg.MobileDeviceTemplateKey
WHERE mu.MobileUnitId = @mobileunitId;

SELECT * FROM @configuration;
DECLARE @MobileUnitKey INT = (SELECT MobileUnitKey FROM @configuration);
DECLARE @MobileDeviceTemplateKey INT = (SELECT MobileDeviceTemplateKey FROM @configuration);

-- Mobile Devices -----------------------------------

SELECT * 
FROM @configuration c
INNER JOIN [definition].[MobileDevices] dmd
	ON dmd.DeviceKey = c.MobileDeviceKey


-- Devices
--- DeviceParameters
--- DeviceProperties
--- OverriddenDevices
--- PeripheralDevices

--- Devices
---- DeviceTypes

-- MobileDevices
--- MobileDeviceTypes
--- Properties

SELECT 
	td.DeviceKey,
	dld.DisplayLabel Device,
	IsEnabled = CASE WHEN muod.MobileUnitKey IS NOT NULL THEN muod.IsEnabled ELSE td.IsEnabled END, 
	dp.DisplayLabel Property, 
	[Value] = CONCAT(
		CASE WHEN muodp.MobileUnitKey IS NOT NULL THEN muodp.[Value] ELSE tdp.[Value] END,
		' ', dp.DisplayUnits
	),
	dvft.[Description] ValueFormat,
	'XXXXXXXXX', dp.ValueFormatType, 
	dp.*,
	tdp.*

	/*
	dd.DeviceType, dd.SystemName,
	ddt.[Description], ddt.*,
	dmd.DeviceKey, dmd.[Description], 
	dpd.DeviceKey, dpd.*,
	dld.DeviceKey, dld.DisplayLabel, 
	dld.* , muod.*
	*/

FROM template.Devices td WITH (NOLOCK)
LEFT JOIN [mobileunit].OverridenDevices muod WITH (NOLOCK) 
	ON muod.TemplateDeviceKey = td.TemplateDeviceKey 
	AND muod.MobileUnitKey = @MobileUnitKey



INNER JOIN [definition].LogicalDevices dld WITH (NOLOCK)
	ON dld.DeviceKey = td.DeviceKey


LEFT JOIN template.DeviceProperties tdp WITH (NOLOCK)
	ON tdp.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
	AND tdp.DeviceKey = td.DeviceKey
LEFT JOIN mobileunit.OverridenDeviceProperties muodp WITH (NOLOCK)
	ON muodp.TemplateDevicePropertyKey = tdp.TemplateDevicePropertyKey
	AND muodp.MobileUnitKey = @MobileUnitKey

INNER JOIN [definition].Properties dp WITH (NOLOCK)
	ON dp.PropertyKey = tdp.PropertyKey

INNER JOIN [definition].ValueFormatTypes dvft WITH (NOLOCK)
	ON dvft.ValueFormatType = dp.ValueFormatType
--

/*

LEFT JOIN [definition].MobileDevices dmd WITH (NOLOCK) 	ON td.DeviceKey = dmd.DeviceKey
LEFT JOIN [definition].LogicalDevices dld WITH (NOLOCK)	ON dld.DeviceKey = td.DeviceKey
LEFT JOIN [definition].PeripheralDevices dpd WITH (NOLOCK)	ON dpd.DeviceKey = td.DeviceKey
INNER JOIN [definition].Devices dd WITH (NOLOCK) ON dd.DeviceKey = td.DeviceKey
INNER JOIN [definition].DeviceTypes ddt WITH (NOLOCK) ON ddt.DeviceType = dd.DeviceType
*/

WHERE td.MobileDeviceTemplateKey = @MobileDeviceTemplateKey
--	AND td.IsEnabled = 1

ORDER BY dld.UiSortOrder, dld.DeviceKey, dp.UiSortOrder


SELECT dd.DeviceKey, dld.DisplayLabel, *
FROM [definition].DeviceDependencies ddd WITH (NOLOCK)
INNER JOIN [definition].Devices dd WITH (NOLOCK) ON dd.DeviceKey = ddd.ChildDeviceKey
LEFT JOIN [definition].LogicalDevices dld WITH (NOLOCK)	ON dld.DeviceKey = dd.DeviceKey
WHERE ParentDeviceKey = 323
ORDER BY dld.UiSortOrder

-- excluded > DependencyType = 3


-- Logical Device Id: 898881372534391990
-- Property Id: -4645894425392195380

/*

SELECT * 
FROM [definition].Devices
WHERE DeviceKey in (323, 136,143,146,147,165)

SELECT * 
FROM [definition].LogicalDevices
WHERE DeviceKey in (323, 136,143,146,147,165)

SELECT dld.DisplayLabel, *
FROM [definition].DeviceDependencies ddd WITH (NOLOCK)
INNER JOIN [definition].Devices dd WITH (NOLOCK) ON dd.DeviceKey = ddd.ChildDeviceKey
LEFT JOIN [definition].LogicalDevices dld WITH (NOLOCK)	ON dld.DeviceKey = dd.DeviceKey
WHERE ParentDeviceKey = 323
ORDER BY dld.UiSort


*/
--SELECT * FROM definition.Devices WHERE DeviceKey = 323



------------- THIS WORKS!!!!!!!

DECLARE @mobileunitId BIGINT = 1230279699646066688;
USE DeviceConfiguration;

--Get MobileUnit Information needed
DECLARE @configuration TABLE (
  MobileUnitKey				INT,
  ConfigurationGroup		NVARCHAR(250),
  MobileDeviceTemplateKey   INT,
  MobileDeviceKey			INT,
  DeviceId					BIGINT,
  LibraryKey				INT
 );

INSERT INTO @configuration
SELECT
  mu.MobileUnitKey,
  cg.Name ConfigurationGroup,
  mdt.MobileDeviceTemplateKey,
  mdt.MobileDeviceKey,
  dd.DeviceId DeviceId,
  cg.LibraryKey
FROM mobileunit.MobileUnits mu WITH (NOLOCK)
INNER JOIN template.ConfigurationGroups cg WITH (NOLOCK)
	ON cg.ConfigurationGroupKey = mu.ConfigurationGroupKey
LEFT JOIN template.MobileDeviceTemplates mdt WITH (NOLOCK)
	ON mdt.MobileDeviceTemplateKey = cg.MobileDeviceTemplateKey
INNER JOIN [definition].[Devices] dd
	ON dd.DeviceKey = mdt.MobileDeviceKey
WHERE mu.MobileUnitId = @mobileunitId;

--SELECT * FROM @configuration;

Select 
	dd.DeviceKey,
	dld.DisplayLabel Device,
	IsEnabled = CASE WHEN muod.MobileUnitKey IS NOT NULL THEN muod.IsEnabled ELSE td.IsEnabled END,
	dp.DisplayLabel Property, 
	[Value] = CONCAT(
		CASE WHEN muodp.MobileUnitKey IS NOT NULL THEN muodp.[Value] ELSE tdp.[Value] END,
		' ', dp.DisplayUnits
	),
	dvft.[Description] ValueFormat

--Basic
From @configuration c
INNER JOIN [dynamix].[LinkedDevicesForProperties] dldfp WITH (NOLOCK)
	ON c.DeviceId = dldfp.DefinitionParentDeviceId
INNER JOIN [definition].Devices dd WITH (NOLOCK) 
	ON dd.DeviceId = dldfp.DefinitionLogicalDeviceId
LEFT JOIN [definition].LogicalDevices dld WITH (NOLOCK)
	ON dld.DeviceKey = dd.DeviceKey

--Devices
LEFT JOIN template.Devices td WITH (NOLOCK)
	ON td.MobileDeviceTemplateKey = c.MobileDeviceTemplateKey
	AND td.LibraryKey = c.LibraryKey
	AND td.DeviceKey = dd.DeviceKey
LEFT JOIN [mobileunit].OverridenDevices muod WITH (NOLOCK) 
	ON muod.TemplateDeviceKey = td.TemplateDeviceKey 
	AND muod.MobileUnitKey = c.MobileUnitKey
--Properties
LEFT JOIN template.DeviceProperties tdp WITH (NOLOCK)
	ON tdp.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
	AND tdp.DeviceKey = td.DeviceKey
LEFT JOIN mobileunit.OverridenDeviceProperties muodp WITH (NOLOCK)
	ON muodp.TemplateDevicePropertyKey = tdp.TemplateDevicePropertyKey
	AND muodp.MobileUnitKey = c.MobileUnitKey

LEFT JOIN [definition].Properties dp WITH (NOLOCK)
	ON dp.PropertyKey = tdp.PropertyKey

LEFT JOIN [definition].ValueFormatTypes dvft WITH (NOLOCK)
	ON dvft.ValueFormatType = dp.ValueFormatType

ORDER BY dld.UiSortOrder, dld.DeviceKey, dp.UiSortOrder

/*
SELECT top 10 * FROM  template.Devices
SELECT top 10 * FROM  template.ConfigurationGroups
*/