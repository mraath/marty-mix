---
created: 2023-03-27T07:35
updated: 2025-02-07T08:44
status: busy
comment: 
priority: 1
---

# OE-605 Alerts Column logic Config Group

Date: 2025-01-30 Time: 11:51
Parent:: [[OE-513]]
Friend:: [[2025-01-30]]
JIRA:OE-605 Alerts Column logic Config Group
[[OE-605] [UI] [API] Alerts Column Configuration Groups - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-605)

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

## Branch

> Config/MR/Feature/OE-605-Alerts-Column-logic-Config-Group.INT

## Description

Please see the parent item to view where this fits in.  
_PLEASE NOTE_ This only handles the Config Groups list.  
  
We’ll start with 4 alert states and add more in future

- Assets in config Upload requested state for more than 5 days
- Assets in FW upload requested state for more than 3 days
- Preferred FW version that is older than 2 releases back. **Jacques van Wyk will have more info?**
- Assets that have events with a status of “Events not monitored - missing parameters”  
    
The alerts column should display the number of alerts for the config group (so max 4 at the moment)  
The alert count should be a clickable link

Green header Alerts  
(_PLEASE NOTE_ the new styling across the system is no longer with a green header, please just double check with the PO, but I think this is OK.)  
Below this display each alert and the asset count associated to the alert

|Alert|Asset count|
|---|---|
|Configuration upload request expired|5|
|FW upload request expired|5|
|Preferred FW version not supported|5|
|Event not monitored - missing parameters|1|

In the bottom right corner is a green Close button  
(ALL the other Modal in this type of scenario show an OK. I have left it as an OK. Please confirm with the PO if this is OK)

## This needs to happen for both panels

- This is needed for the config groups grid.
- It is also needed for individual assets' rows in the assets grid. (This will be a new story)
## Idea

- [ ] On Assets could have these as columns for easy selecting and then eg. sending FW again

## NEXT: Config Group Section

- NOT NEEDED
	- Lines: ~~miXVisionSerialnumber~~
	- Alerts: ~~preferredFWVersion~~, ~~serialnumber~~, ~~commsLog~~ (messageStatusDateUtc)
- MAYBE NEEDED
	- 3: lines: hos, sp, fuel, rpm, speed 
	- 3: alerts: fwVersion, 
		- alerts << Call other one, strip out what is needed...

Route: GetConfigurationGroupsOtherColumns = "configuration-groups-multiselect/groupId/{groupId}/other-columns";


- DB
	- STILL: [template].[Template_GetConfigurationGroupsMultiselect]
		- ~~Remove from DeviceConfig.api~~
	- [x] Strip out into Lazy Loading Sections ✅ 2025-02-03
		- [x] Base: [template].[Template_GetConfigurationGroupsMultiselect] ✅ 2025-02-03
		- Removed: Alerts.... will come from code
		- Removed: Flagged, FWVersion, Lines
		- [x] FW, Lines, etc: [template].[Template_GetConfigurationGroupsOtherColumns] ✅ 2025-02-03
		- [x] PR: [Pull request 118207: OE-605: Lazy loading columns - Repos](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/118207) ✅ 2025-02-03
		- [x] [Pull request 118225: OE-605: Simplify other columns return class - Repos](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/118225?_a=files) ✅ 2025-02-03
	- NA: Move to different projects
	- Stored Proc to get CG Alert Values.... reuse above? Then filter to get totals
- Common
	- [x] Add new classes for the lazy loading ✅ 2025-02-03
		- ConfigurationGroupOtherMultiselect
		- ConfigurationGroupOtherMultiselectCarrier
		- ConfigurationGroupAlertMultiselectCarrier
		- ConfigurationGroupAlertMultiselect
		- [x] PR: [Pull request 118231: OE-605: Added a few classes needed for lazy loading the config groups panel - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/118231) ✅ 2025-02-03
		- **MiX.DeviceIntegration.Common.2025.4.20250203.2**
- API
	- Controller to get other columns
	- Stored Proc to get CG Alert Values.... reuse above asset panel's? Then filter to get totals
		- public const string GetConfigurationGroupsOtherColumns = "configuration-groups-multiselect/groupId/{groupId}/other-columns";
		- public const string GetConfigurationGroupsAlerts = "configuration-groups-multiselect/groupId/{groupId}/alerts";
	- GetConfigurationGroupsAlerts
	- [x] PR: [Pull request 118251: OE-605: Added endpoints for config groups - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/118251) ✅ 2025-02-04
- Client
	- Method to get other columns
		- GetConfigurationGroupsOtherColumns
	- Method to get CG Alerts
		- GetConfigurationGroupsAlerts
	- [x] PR: [Pull request 118284: OE-605: Added methods to get Other Lazy Load columns and Alerts for Config Gr... - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/118284) ✅ 2025-02-04
	- **MiX.ConfigInternal.Api.Client.2025.4.20250204.2**
- FR API
	- Controller to use client to get other columns
	- Controller to use client to get alerts
		- GetConfigurationGroupsOtherColumnsListCarrier
		- GetConfigurationGroupsAlertsListCarrier
	- [x] PR: [Pull request 118318: OE-605: Nuget Upgraded. Added controllers to get other columns and alerts to... - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/118318) ✅ 2025-02-04
	- Missed these methods in the Hypermedia for CG
		- [Pull request 118358: OE-605: Missed these methods in the GetHypermedia for Config Groups - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/118358)
- FR UI
	- Call FR API to get other columns
	- Call FR API to get alerts
		- getConfigurationGroupsOtherColumns
		- getConfigurationGroupsAlerts
	- Columns: 3, 2, 
		- [x] PR: [Pull request 118364: OE-605: Lazy loading others columns and alerts. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/118364) ✅ 2025-02-05
	- NEXT display the alerts modal
		- 
		- [x] PR: [Pull request 118426: OE-605: Added Alert Modal - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/118426) ✅ 2025-02-06

## FORGOT

- [ ] One of the alerts were NOT done on asset level (Asset DB....) Go look!!

### Investigation Notes

- This one is partly outstanding - MAYBE
	- Configuration upload request expired
		- The Deviceconfiguration and DP part has been done (Mesa, etc)
			- It was easy to look at the last message status and types and then determine if it has expired according to the rules
		- The Asset DB part has not been done (as I am not sure about the following):
			- I am not sure WHAT to look at which will tell me it is not yet completed.
			- It just seems like a list of messages that came in, no way to determine except if we look for strings within that list...
![[OE-605 Alerts Column logic Config Group Example of Comms for Asset DB.png]]

- All of these have been done as they all come from the Deviceconfiguration and DP DBs.
	- FW upload request expired
	- Preferred FW version not supported
		- This MIGHT have CanbusIncompatible missing logic where 'E' FW needs to be removed, however while testing I didn't find issues.
	- Event not monitored - missing parameters

## Temp note

Columns that will not show for the time being:
- lines: hos, sp, fuel, rpm, speed, fwVersion
- alerts

## Lazy Loading notes

- lazyLoadingCGOther: boolean = false;
- lazyLoadingCGAlerts: boolean = false;
- lazyLoadingCGOtherUnits: string = '';
- lazyLoadingCGAlertsUnits: string = '';

## Code

```html
<div>
  <div *ngIf="
  (col?.lazy === 'alerts' && lazyLoadingAlerts && unitIsLazyLoading(dataItem.configurationGroupId, lazyLoadingAlertsUnits)) ||
  (col?.lazy === 'lines' && lazyLoadingLines && unitIsLazyLoading(dataItem.configurationGroupId, lazyLoadingLinesUnits))">
	<kendo-skeleton
	  shape="text"
	  animation="pulse"
	  width="100%"
></kendo-skeleton>
  </div>
</div>


<!-- <kendo-grid
	[kendoGridBinding]="configAlertData"
	[height]="270">
	<kendo-grid-column field="alert" title="{{'Alert'|dmxTranslate}}" [width]="150">
	</kendo-grid-column>
	<kendo-grid-column field="count" title="{{'Asset count'|dmxTranslate}}" [width]="50">
	</kendo-grid-column>
  </kendo-grid> -->
```

## Languaging

- [x] All these ✅ 2025-02-06
- Alert
- Asset count
