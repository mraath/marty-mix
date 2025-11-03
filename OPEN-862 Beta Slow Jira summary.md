---
created: 2025-11-03T10:20
updated: 2025-11-03T12:45
---
## Introduction

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

In addition to the above three stored procs, we could enhance reading the other columns for config groups. getMobi1eunitAliensForонаionXBQJyi5 , getMobi1eunitWitldZ1,,gif, Mobi1eunitะ3, getMobi1eunitGl, getMobi1eunitFentimeZ3, x celular1ulan, x extendeddial, getMobi1euninVa9, x',,x411, x2le southern, x3 softwarecastx, getMobi1eunitRedequezZa, x411 serverные axiom Booft, $220$209, $220$209, $220$209, $940$209, $ tener$ハальным til0, $880$280, $6.99$, $9.99$, $9.99$", $9.99$, $6.99$, $ulanB泰 DimStorm, $9.99$ $4.9$$126, $2

