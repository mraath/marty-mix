---
created: 2025-10-07T07:59
updated: 2025-10-07T07:59
---
## OE-513 All SQL involved

Config Groups Panel
- (init) [template].[Template_GetConfigurationGroupsMultiselect]
- (lazy) [template].[Template_GetConfigurationGroupsOtherColumns]

Assets List Panel
- (init unallocated) [mobileunit].[MobileUnit_GetUnallocatedAssets]
- (init normal) [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]
- (lazy) [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups]
- (lazy) [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
