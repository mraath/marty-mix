---
created: 2025-04-17T07:59
updated: 2025-04-17T08:49
---
## Errors

```txt
"D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj" (default target) (11) ->
(SqlBuild target) -> 
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetMobileUnitFirmwareInfo.sql(142,35,142,35): Build error SQL46010: Incorrect syntax near 'AS'. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(18,22,18,22): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] has an unresolved reference to object [DeviceConfiguration].[definition].[Properties]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(17,30,17,30): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] has an unresolved reference to object [DeviceConfiguration].[definition].[Properties].[PropertyKey]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(20,23,20,23): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] contains an unresolved reference to an object. Either the object does not exist or the reference is ambiguous because it could refer to any of the following objects: [DeviceConfiguration].[definition].[Properties].[dp]::[PropertyId] or [DeviceConfiguration].[definition].[Properties].[PropertyId]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(45,16,45,16): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] has an unresolved reference to object [DeviceConfiguration].[template].[ConfigurationGroups]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(47,16,47,16): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] has an unresolved reference to object [DeviceConfiguration].[mobileunit].[MobileUnits]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(49,16,49,16): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] has an unresolved reference to object [DeviceConfiguration].[mobileunit].[AssetMobileUnits]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(51,16,51,16): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] has an unresolved reference to object [DeviceConfiguration].[definition].[ConfigurationStatuses]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(55,15,55,15): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] has an unresolved reference to object [DeviceConfiguration].[mobileunit].[MobileUnitProperties]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]
  D:\a\1\s\DeviceConfiguration.DataProcessing\Schemas\state\Functions\MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql(61,15,61,15): Build error SQL71561: Function: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] has an unresolved reference to object [DeviceConfiguration].[mobileunit].[AssetProperties]. [D:\a\1\s\DeviceConfiguration.DataProcessing\DeviceConfiguration.DataProcessing.sqlproj]

    274 Warning(s)
    10 Error(s)
```

## AS BIGINT

Was due to SQL not being 2012 when TRY_CAST was introduced

## DeviceConfiguration not found

[[Creating a Database Name SQL Command Variable]]
For now I will just convert the function to a stored proc - will be LITTLE bit slower