---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-30T15:19
---

# OPEN-862 Beta Slow

Date: 2025-10-28 Time: 06:51
Parent:: ==xxxx==
Friend:: [[2025-10-28]]
JIRA:OPEN-862 Beta Slow
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-862)


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

There are noticeable loading delays on the Config Groups Page (_Beta_). The service that retrieves the CAN scripts from each vehicle in the chosen organisation might be the main source of the bottleneck. Before implementing further optimizations or architectural changes, it is essential to confirm the root cause of the slowness.

This Spike aims to:
- Profile and analyze the page load process to identify where the most time is spent.   
- Determine if the **CAN Scripts** fetching is the main contributor to the slow load times, or if other factors are involved.
- Document findings

## Investigation

Init questions: [[OPEN-862 Beta Slow AI]]
Enhance Assets Lines: [[OPEN-862 Enhance Asset lines SQL]]
Enhance Assets Alerts: [[OPEN-862 Enhance Asset alerts SQL]]
Enhance Assets List: [[OPEN-862 Enhance Asset List SQL]]
Enhance Config Group Other: [[OPEN-862 Enhance Config Group Other SQL]]
Enhance Config Group List: [[OPEN-862 Enhance Config Group List SQL]]
## Code

Dev Tools Filter: -.js, -.html, -en_, -

| Call                                                          | Stored Proc                                             | Potential Enhancement | Lazy | Click | Notes  | UI AU 1499 | TQL 6852 | Lightning 1034 | Rio Tinto | Rio 2 |
| ------------------------------------------------------------- | ------------------------------------------------------- | --------------------- | ---- | ----- | ------ | ---------- | -------- | -------------- | --------- | ----- |
| module.getHypermedia                                          |                                                         |                       |      |       |        | 1.6s       |          |                |           |       |
| module.getUxDeviceCapabilities                                |                                                         |                       |      |       |        |            |          |                |           |       |
| module.getQueryOptionsAsync                                   |                                                         |                       |      |       |        | .13s       |          |                |           |       |
| module.getConfigurationGroupsMultiselect                      | Template_GetConfigurationGroupsMultiselect              | 5                     |      |       | CG     | .16s       | .2       | .6             | .2        | .7    |
| module.getConfigurationGroupsOtherColumns                     | Template_GetConfigurationGroupsOtherColumns             | 4                     | X    |       | Other  | .28s       | .2       | .9             | .8        | 1     |
| module.getConfigurationGroupsAlerts                           | MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups | 1                     | X    |       | Alerts | 3.3s       | 2.9      | 6.4            | 36        | 2min  |
| module.getConfigChangedFlagForMobileUnits                     |                                                         |                       | X    |       | Flag   | .17s       | .2       | .7             | .3        | .4    |
| module.getConfigurationGroupsMultiselectAssetsList            | MobileUnit_GetAllMobileUnitsForConfigurationGroups      | 3                     |      |       | Assets | 1s         | 3        | 4              | 4.6       | 4     |
| module.**getConfigurationGroupsMultiselectAssetLinesList**    | MobileUnit_GetAllMobileUnitLinesForConfigurationGroups  | 2                     | X    |       | Lines  | 6.8s-12s   | 12.9     | 3              | pending   | 16    |
| module.**getConfigurationGroupsMultiselectAssetAlertsList**   | MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups | 1                     | X    |       | Alerts | 2.5s       | 3        | 7.3            | pending   | 36    |
| module.getConfigurationGroupsMultiselectAssetsListUnallocated |                                                         |                       |      | X     |        |            |          |                |           |       |
| module.getOverriddenInformationForMobileUnit                  |                                                         |                       |      | X     |        |            |          |                |           |       |
| module.getOrgDisplayTimeZone                                  |                                                         |                       |      |       |        |            |          |                |           |       |
| module.getAssetDisplayTimeZone                                |                                                         |                       |      |       |        |            |          |                |           |       |
| module.getConfigurationGroupTemplate                          |                                                         |                       |      | X     |        |            |          |                |           |       |
| module.getConfigurationGroup                                  |                                                         |                       |      | X     |        |            |          |                |           |       |



## Thoughts

- [ ] On AU seems like the asset lists returns quickly, however, it seems to wait for a lazy loading call before displaying, this could be an issue
	- [ ] Maybe for both CG and Assets check lazy load after init has been populated in grid.... boolean?
- [ ] Could load assets a few cgs at a time
- [ ] DB - to check load time of asset-lines..... test in AU DB. Check time. NULL can and dont work out logic. Check time again.
- [ ] DB - do similar things for other lines, etc...

## SQL to find big orgs

```sql
USE DeviceConfiguration;

SELECT ll.LibraryKey, count(mu.MobileUnitKey), ll.Notes
FROM mobileunit.Mobileunits mu
INNER JOIN template.ConfigurationGroups tcg ON tcg.ConfigurationGroupKey = mu.ConfigurationGroupKey
INNER JOIN library.Libraries ll ON ll.LibraryKey = tcg.LibraryKey
GROUP BY ll.LibraryKey, ll.Notes
ORDER BY count(mu.MobileUnitKey) DESC
```


### INT

LibraryKey	(No column name)	     Notes
3524	         7458		         	         Configuration Library of TQL
45		         1459		         	         Configuration Library of BES - PBU - Central
2463		     1034		         	         Configuration Library of LightningTesting2
1242		     1010		         	         Configuration Library of GTS
1132		     1001		         	         Configuration Library of Jeremy's test Organsiation
2475		     1000		         	         Configuration Library of PageLoadTesting

### AUS

LibraryKey	(No column name)	Notes
340	    6976	                            Configuration Library of Rio Tinto - Australia migrated with script 20150723.01
422	    5063	                            Configuration Library of GRAINCORP migrated with script 20151203.01
307	    3503	                            Configuration Library of RIO TINTO - AUSTRALIA migrated with script 20150723.01
1452	2385	                            Configuration Library of Service Stream
828	    1937	                            Configuration Library of Demo - Veolia ANZ
599	    1876	                            Configuration Library of Landmark
152	    1512	                            Configuration Library of Borg Manufacturing migrated with script 20150325.01
893	    1499	                            Configuration Library of Water Corporation Test
1219	1415	                            Configuration Library of Landpower New Zealand
833	    1410	                            Configuration Library of Mader
795	    1121	                            Configuration Library of Fleet Integrations - AU Projects
123	    1071	                            Configuration Library of TOLL GLOBAL LOGISTICS migrated with script 20150219.01
866	    1002	                            Configuration Library of CBH

## Stored procs to investigate

![[OE-513 All SQL involved]]


- Template_GetConfigurationGroupsMultiselect|Template_GetConfigurationGroupsOtherColumns|MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups|MobileUnit_GetUnallocatedAssets|MobileUnit_GetAllMobileUnitsForConfigurationGroups|MobileUnit_GetAllMobileUnitLinesForConfigurationGroups|MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups|MobileUnit_GetMobileUnitMissingParameters|MobileUnit_GetMobileUnitBasicInfoForConfigGroups|MobileUnit_GetMobileUnitFirmwareInfo|MobileUnit_GetMobileUnitMessageAlerts|MobileUnit_GetMobileUnitLastMessageDate
