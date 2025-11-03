---
created: 2025-11-03T10:20
updated: 2025-11-03T13:13
---
## Initial findings

While looking into the spike, I did quite a few tests. I did a few tests on integration, a few locally, and then also on production. In the table below you can see some of my findings.

|Network Calls|Stored Proc|Potential Enhancement|Lazy|Click|Notes|UI AU 1499|TQL 6852|Lightning 1034|Rio Tinto|Rio 2|
|---|---|---|---|---|---|---|---|---|---|---|
|module.getHypermedia||||||1.6s|||||
|module.getUxDeviceCapabilities|||||||||||
|module.getQueryOptionsAsync||||||.13s|||||
|module.getConfigurationGroupsMultiselect|Template_GetConfigurationGroupsMultiselect|5|||CG|.16s|.2|.6|.2|.7|
|module.getConfigurationGroupsOtherColumns|Template_GetConfigurationGroupsOtherColumns|4|X||Other|.28s|.2|.9|.8|1|
|module.getConfigurationGroupsAlerts|MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups|1|X||Alerts|3.3s|2.9|6.4|36|2min|
|module.getConfigChangedFlagForMobileUnits|||X||Flag|.17s|.2|.7|.3|.4|
|module.getConfigurationGroupsMultiselectAssetsList|MobileUnit_GetAllMobileUnitsForConfigurationGroups|3|||Assets|1s|3|4|4.6|4|
|module.**getConfigurationGroupsMultiselectAssetLinesList**|MobileUnit_GetAllMobileUnitLinesForConfigurationGroups|2|X||Lines|6.8s-12s|12.9|3|pending|16|
|module.**getConfigurationGroupsMultiselectAssetAlertsList**|[state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]|1|X||Alerts|2.5s|3|7.3|pending|36|
|module.getConfigurationGroupsMultiselectAssetsListUnallocated||||X|||||||
|module.getOverriddenInformationForMobileUnit||||X|||||||
|module.getOrgDisplayTimeZone|||||||||||
|module.getAssetDisplayTimeZone|||||||||||
|module.getConfigurationGroupTemplate||||X|||||||
|module.getConfigurationGroup||||X|||||||

In the table above, we can clearly see that the main point of concern is the alerts for both assets and config groups as the stored proc between these two are shared. 
Then after that, asset lines is also a potential issue. Asset Lines also contains the CAN logic, which currently I can't really see is the main reason for all of this happening.
The next stored proc to look at is the one returning all the assets within the config groups.

When looking into the table above, we can see that Rio Tinto, within that column, that the alerts and the asset lines sometimes would time out. It would remain pending. This confirms my above statements. The configgroupsAlerts was also quite high, but it shares the stored proc as previously mentioned. So if we fix up the assets alerts, this will also be resolved.

In addition to the above three stored procs, we could enhance reading the other columns for config groups. I would not prioritize this though because as we can see in the result, it usually gets done within a second.
Lastly, we could also look into getting the config groups. However, this also usually takes less than a second. So I would also not prioritize this.


## More findings

From the above table we can also see that the three stored procs mentioned above are lazy loaded. However, sometimes it seemed to still have an influence on the initial data being loaded. This could be another thing we could change to ensure that lazy loading happens only after the initial data has populated the grid.
We can do this for both the ConfigGroupsGrid and the AssetListsGrid.

Once we have enhanced the stored procs and we have also ensured that the lazy loading happens at the correct time, we could look into loading only a few config groups assets at a time. However, for now, I think we should just focus on the above-mentioned enhancements.

## Database Changes

Personally I think making stored proc changes would have the most significant effect on these slow pages. After this I would look into the lazy loading in the front end to ensure it loads after the initial grid data has been been populated.

### Performance issues

1) Table variables
	- Has poor execution plans for joins as sql assumes very few rows
	- Results in slow nested loops joins and complex queries
	- USE: Temporary Tables or CTEs (for smaller datasets)
2) Correlated Subqueries
	- Multiple scalar subqueries for different lines: Incl. CAN
	- Row-by-row execution and bottleneck
	- USE: Outer apply / conditional aggregation / PIVOT
3) Cursors
	- Iterates over each unit, two SPs per unit
	- eg. 1000 units > 1 base query + 2000 SP calls + 1000 updates.... this is very slow
	- USE: Joins / CTE's instead of integrated logic
4) Other
	- String aggregation
	- Multi-join queries over table variables
	- FW version outdated calculated inside a subquery per mobile unit

Summary: Switch from Table Variables + Cursors + correlated subqueries to temporary tables / CTEs + set-based joins. This will reduce runtime significantly.

## POC

As a proof of concept, I took the alerts, stored proc, I added some enhancements. It seemed to load much faster. I just need to ensure that it still returns the same data. However, from my initial proof of concept, it seemed to have worked. However, we just need to make sure about this.

## Steps

I would suggest to start with the three mentioned stored props. Fix the performance issues mentioned above. Start with alerts, then asset lines, then the assets list. Last, Ensure, Lazy, Loading, Correct, Time,
