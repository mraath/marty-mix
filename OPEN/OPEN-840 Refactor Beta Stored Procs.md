---
wiki_ingested: 2026-05-28
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-11-25T07:30
---

# OPEN-840 Refactor Beta Stored Procs

Date: 2025-11-07 Time: 15:33
Parent:: ==xxxx==
Friend:: [[2025-11-07]]
JIRA:OPEN-840 Refactor Beta Stored Procs
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-840)


## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Shorter Description

### Objective

Refactor the key Store Procedures (SPs) used in the Config module to address performance bottlenecks, reduce page load times, and improve scalability, as outlined in the findings and recommendations from OPEN-862.

### Scope of Work

#### 1. Targeted Store Procedures

Focus on the following SPs, in priority order

- **Alerts**: `MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups` (shared between assets and config groups)
- **Asset Lines**: `MobileUnit_GetAllMobileUnitLinesForConfigurationGroups`
- **Assets List**: `MobileUnit_GetAllMobileUnitsForConfigurationGroups`

#### 2. Refactoring Guidelines

Apply the following enhancements to each targeted SP:

- **Replace Table Variables**: Avoid table variables in favor of temporary tables or CTEs, especially for larger datasets, to improve execution plans and join performance.
- **Eliminate Correlated Subqueries**: Refactor scalar subqueries (especially those involving CAN logic) using `OUTER APPLY`, conditional aggregation, or PIVOT to enable set-based processing.
- **Remove Cursors**: Replace cursor-based logic with set-based joins or CTEs to avoid row-by-row processing and excessive SP calls.
- **Optimize String Aggregation and Multi-Join Queries**: Refactor string aggregation and complex joins over table variables for better efficiency.
- **Review Calculated Columns**: Move calculations (e.g., firmware version checks) out of subqueries where possible.

### Implementation Steps

1. [x] Refactor the **Alerts** stored procedure as a priority, applying all relevant enhancements. ✅ 2025-11-20
2. [x] Proceed to refactor the **Asset Lines** stored procedure. ✅ 2025-11-20
3. [ ] Refactor the **Assets List** stored procedure.
4. [ ] Review and adjust lazy loading logic in the front end as needed


> STASHED: OPEN-840_WIP_Optmized

## Notes

### Alerts

==CHANGE==: [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]

- Original: C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql
- Optimized:
	- [[OPEN-840-Alerts-5-FW.sql]]
	- [[OPEN-840-Alerts-5.sql]]


- OLDER VERSIONS
	- [[OPEN-840-Alerts-4.sql]]
	- [[OPEN-840-Alerts-FW.sql]]
- Helpful comparison testers
	- [[GeminiAlertTestTransaction_20251105.sql]]


### Lines

==CHANGE:== [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups]

- Original: C:\Projects\Database\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetAllMobileUnitLinesForConfigurationGroups.sql
- Optimized: C:\Projects\Database\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetAllMobileUnitLinesForConfigurationGroups_Optimized_Claude.sql

### Lists - not worth it

- Original: C:\Projects\Database\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetAllMobileUnitsForConfigurationGroups.sql
- Optimized: C:\Projects\Database\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetAllMobileUnitsForConfigurationGroups_Optimized.sql
- Wasn't yet significant - MAYBE retry later

### Lazy Loading - will test

- Later

## TESTS

- DEV - nope
- INT - Both returned SAME result
- PROD
	- Alert
		- OLD: 41s
		- NEW: 6s
		- SAME RESULTS
	- Lines
		- OLD: 16s
		- NEW: 5s
		- SAME RESULTS

## BRANCH

> Config/MR/OPEN-840_Optimise_Alerts_Lines.INT

- Dynamix.Deviceconfig
	- [x] Update DEV ✅ 2025-11-20
	- [x] [PR INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/134629) ✅ 2025-11-21
- Database
	- [x] Updated DEV ✅ 2025-11-20
	- [x] [PR INT](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/134630) ✅ 2025-11-21



[[OPEN-862 Beta Slow]]