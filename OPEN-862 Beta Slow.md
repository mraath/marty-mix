---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-29T10:05
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

[[OPEN-862 Beta Slow AI]]

## Code

Dev Tools Filter: -.js, -.html, -en_, -

| Call                                                          | Lazy | Click | Notes  | UI AU 1499 | TQL 6852 | Lightning 1034 |
| ------------------------------------------------------------- | ---- | ----- | ------ | ---------- | -------- | -------------- |
| module.getHypermedia                                          |      |       |        | 1.6s       |          |                |
| module.getUxDeviceCapabilities                                |      |       |        |            |          |                |
| module.getQueryOptionsAsync                                   |      |       |        | .13s       |          |                |
| module.getConfigurationGroupsMultiselect                      |      |       | CG     | .16s       | .2       | .6             |
| module.getConfigurationGroupsOtherColumns                     | X    |       | Other  | .28s       | .2       | .9             |
| module.getConfigurationGroupsAlerts                           | X    |       | Alerts | 3.3s       | 2.9      | 6.4            |
| module.getConfigChangedFlagForMobileUnits                     | X    |       | Flag   | .17s       | .2       | .7             |
| module.getConfigurationGroupsMultiselectAssetsList            |      |       | Assets | 1s         | 3        | 4              |
| module.getConfigurationGroupsMultiselectAssetLinesList        | X    |       | Lines  | 6.8s-12s   | 12.9     | 3              |
| module.getConfigurationGroupsMultiselectAssetAlertsList       | X    |       | Alerts | 2.5s       | 3        | 7.3            |
| module.getConfigurationGroupsMultiselectAssetsListUnallocated |      | X     |        |            |          |                |
| module.getOverriddenInformationForMobileUnit                  |      | X     |        |            |          |                |
| module.getOrgDisplayTimeZone                                  |      |       |        |            |          |                |
| module.getAssetDisplayTimeZone                                |      |       |        |            |          |                |
| module.getConfigurationGroupTemplate                          |      | X     |        |            |          |                |
| module.getConfigurationGroup                                  |      | X     |        |            |          |                |

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

LibraryKey	(No column name)	     Notes
3524	         7458		         	         Configuration Library of TQL
45		         1459		         	         Configuration Library of BES - PBU - Central
2463		     1034		         	         Configuration Library of LightningTesting2
1242		     1010		         	         Configuration Library of GTS
1132		     1001		         	         Configuration Library of Jeremy's test Organsiation
2475		     1000		         	         Configuration Library of PageLoadTesting


## Stored procs to investigate

