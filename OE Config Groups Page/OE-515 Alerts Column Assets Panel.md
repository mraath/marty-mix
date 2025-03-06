---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-01-31T11:04
---
# OE-515 Alerts Column logic

Date: 2024-04-11 Time: 15:33
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-04-11]]
JIRA:OE-515 Alerts Column logic
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-515)

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

## Description

### Configuration Groups

Alerts icon - display error count - see below for details

Alerts logic:
We’ll start with 4 alert states and add more in future
- Assets in config Upload requested state for more than 5 days
	- Maybe look into how [[Comms Log]] get its data
- Assets in FW upload requested state for more than 3 days
- Preferred FW version that is older than 2 releases back
	- [x] How will we figure this out? Jacques? ✅ 2024-12-23
- Assets that have events with a status of  “Events not monitored - missing parameters”

## Events

CG > Asset Descr >
http://localhost/MiXFleet.UI/#/config-admin/configuration-groups/asset/events?assetId=1401709835162300416
1401709835162300416

![[OE-515 Alerts Column logic Event Not monitored.png]]
### Code flow

?? AssetEventListController

AssetEventListController
	onSelectionCriteriaChanged
		this.module.getAssetEvents

MiXFleet.ConfigAdmin
	getAssetEvents

ModuleRoutes.GET_EVENTS

FROM: C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\MobileUnitLevel\MobileUnitEventsModule.cs

==GetEventTemplate==

```c#
IEffectiveConfig config = mobileUnitManager.GetEffectiveConfig(mobileUnit, mobileDeviceTemplate, eventTemplate);

bool canEditMobileUnitEvents = AuthorisationManager.Authorise(authToken, ConfigConstants.Permissions.CAN_UPDATE_TEMPLATE_EVENTS, orgId);

var carrier = new MobileUnitEventsPageCarrier();
carrier.AssetName = asset.Description;
carrier.EventTemplateName = eventTemplate.Name;
foreach (IEvent evnt in config.AllEvents)
{
	MobileUnitEventItemCarrier item = ConvertToCarrier(evnt);

	EventStatus eventStatus = evnt.IsEnabled ? EventStatus.Monitored : EventStatus.NotMonitored;

	if (evnt.IsEnabled)
	{
		if (!config.MonitoredEvents.Contains(evnt))
		{
			eventStatus = EventStatus.NoParameters;
			item.Description.Disabled = true;
		}


// FROM HERE
if (!requiredConditionParameterMissing && objEvent.IsEnabled && (atLeastOneParameterMonitored || peripheralBasedEvent))
	config.MonitoredEvents.Add(objEvent);

// requiredConditionParameterMissing
foreach (TemplateEventCondition templateEventCondition in templateEvent.Conditions.OrderBy(x => x.Sequence))
{
	IParameter supportedParameter = config.AllSupportedParameters.FirstOrDefault(x => x.DefinitionParameterId == templateEventCondition.DefinitionParameterId);
	if (supportedParameter == null // the device does not report this parameter
				&& templateEventCondition.DefinitionParameterId != ConfigConstants.Parameters.OPEN_BRACKET
				&& templateEventCondition.DefinitionParameterId != ConfigConstants.Parameters.CLOSE_BRACKET)
	{
			if (templateEventCondition.IsRequired)
			{
				// the parameter is required
				requiredConditionParameterMissing = true;
```

## Current Status

![[OE-515 Alerts Column logic Current Status Matching monitored.png]]


### Further info

- [x] The alerts column should display the number of alerts for the **config group** (so max 4 at the moment) ✅ 2025-01-30
- [x] The alert count should be a clickable link ✅ 2025-01-30
- [x] Green header Alerts ✅ 2025-01-30
		Below this display each alert and the asset count associated to the alert
			Alert                                                                         Asset count
			Configuration upload request expired                              5
			FW upload request expired                                               5
			Preferred FW version not supported                                5
			Event not monitored - missing parameters                      1
		In the bottom right corner is a green Close button

### Assets List

- Alerts icon - display alert count for each asset
- [x] Should the clickable icon then only show the list of alerts, I think so ✅ 2025-01-30

## Code

- Could use the following as a starting point: [state].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]

## FW

https://integration.mixtelematics.com/DynaMiX.API/config-admin/-7094567047859310012/libraries/firmware
```json
"Rows": [
        {
            "Id": "1076577027900068745",
            "Description": "0.0.0",
            "Availability": "Available",
            "Actions": [
                "CascadeTemplates"
            ],
            "Type": "MiX2310i"
        },
```

BE: 
	GET_FIRMWARE_LIBRARY
	GetFirmwareLibrary

> MiX.DeviceIntegration.Common.FirmwareType

```c#

public enum FirmwareType : short
{
	[Description("Unknown type.")]
	FMUnknown = -1,
	[Description("FM")]
	FM200Plus,
	[Description("FM Terminal")]
	FMTerminal,
	[Description("FM")]
	FM3xBASDDR,
	[Description("CAN")]
	FMCANDDMs,
	[Description("CAN")]
	FMJ1708DDMs,
	[Description("HOS")]
	FMHOSDBDDM,
	[Description("MiX2310i")]
	MiX2310i,
	[Description("FM3D")]
	FM3D,
	[Description("ROVI")]
	ROVI,
	[Description("ROVI II")]
	ROVIII,
	[Description("Beacon")]
	TABSBEACONFW,
	[Description("PBS")]
	TABSPBSFW,
	[Description("Magix Commands")]
	TABSCOMMANDS,
	[Description("Magix Settings")]
	TABSSETTINGS,
	[Description("Magix List")]
	TABSLIST,
	[Description("MiX4000")]
	MiX4000,
	[Description("MiX6000")]
	MiX6000,
	[Description("MiX2000")]
	MiX2000,
	[Description("ROVI III")]
	ROVIIII,
	[Description("ROVI IV")]
	ROVIIV,
	[Description("MiX6000LTE")]
	MiX6000LTE,
	[Description("MiX3000")]
	MiX3000
}
```

```c#
Data
	LogicalDeviceData
		4999121101837382283
		PropertyData
			AllowedValues
```

C:\Projects\DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\AllLevels\ConfigAdminConverters.cs
filteredVersions

## Firmware More

https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/mobile-device-template-settings/-

==Details== 
UI: http://localhost/MiXFleet.UI/#/config-admin/templates/mobile-devices/peripherals?templateId=-7392917270995469090
	- Gets returned as part of Data > LogicalDeviceData > PropertyData
API: http://localhost/DynaMiX.API/config-admin/organisations/-7094567047859310012/mobile-device-template-settings/-7392917270995469090
GET_DEVICE_DETAILS
GetDeviceDetails
xxxxx


[[SQL Query Execution Plan]]


![[SQL Schemas]]


## Steps

- Split up the Assets Pane part into 3 to lazy load
	- Config/MR/OE-515 Splitting out Alerts Columns
		- state.MobileUnit_GetAllMobileUnitsForConfigurationGroups
		- state.MobileUnit_GetAllMobileUnitLinesForConfigurationGroups
		- state.MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups
	- PR: [Pull request 116860: OE-515: Split out the column fetching for speed - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/116860?path=/DeviceConfiguration.DataProcessing/Schemas/state/Stored%20Procedures/MobileUnit_GetAllMobileUnitsForConfigurationGroups.sql)
- The above was NOT OK, I moved it to the DB project, lets see how that goes
	- Config/MR/OE-515 Splitting out Alerts Columns
		- [mobileunit].[MobileUnit_GetUnallocatedAssets]
		- [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]
		- [mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups]
		- [mobileunit].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
			- MOVED TO STATE DB
			- [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
	- [x] PR to add to Database Proj: ✅ 2025-01-30
	- PR to remove from OLD API, once all else is in place:
		- [-] [Pull request 117014: OE-515: Moving these Stored Procs to the Database Project. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/117014)
		- [x] [Pull request 117043: OE-515: Moved alerts part to DP DB - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/117043) ✅ 2025-01-28
	- [x] Lines from new SP ✅ 2025-01-30
	- [x] Alerts from new SP ✅ 2025-01-30
		- [x] Serialnumber, FWVersion, PreferredFWVersion from new SP ✅ 2025-01-30
	- [x] NULL AS CommsLog, -- In Code, CommsLog would be mm.MessageStatusDateUtc in historical date, else sched.LastLogEntry ✅ 2025-01-30
	- [x] mm.MessageStatusDateUtc, ✅ 2025-01-30
- IN ORDER to make use of the sp_executesql
	- Add a reference to  master in your project
		- C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\Extensions\Microsoft\SQLDB\Extensions\SqlServer\130\SqlSchemas\master.dacpac
		- [SQL Server database project gives warning 'Unresolved reference to object sp_executesql' - Stack Overflow](https://stackoverflow.com/questions/64436910/sql-server-database-project-gives-warning-unresolved-reference-to-object-sp-exe)
		- ![[OE-515 Alerts Column logic Master Reference to resolve sp_executesql.png]]
		- Added a reference to Master in order to fix this
		- ![[OE-515 Alerts Column logic Reference to master added.png]]

## Steps going forward

- Common:
	- Config/MR/OE-515 Splitting out Alerts Columns
	- Classes
		- BASE: ConfigurationGroupMultiselectAssetsList
		- [x] ConfigurationGroupMultiselectAssetLinesList ✅ 2025-01-14
			- [Pull request 117114: OE-515: Added a class to receive the asset lines from the stored proc - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/117114)
			- MiX.DeviceIntegration.Common.2025.3.20250114.1
		- [x] ConfigurationGroupMultiselectAssetAlertsList ✅ 2025-01-15
			- PR: [Pull request 117131: OE-515: Changes needed for Alerts - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/117131)
			- MiX.DeviceIntegration.Common.2025.3.20250115.1
	- Carriers
	- Fixing up multiline canscript
		- [x] PR: [Pull request 117219: OE-515: Fix CanScriptLineId for multiple values - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/117219) ✅ 2025-01-16
		- MiX.DeviceIntegration.Common.2025.1.16.1 (LATEST IS **27th** currently)
- Config.API
	- Calling Stored Procs into these classes
	- Config/MR/OE-515 Splitting out Alerts Columns
		- [[New Config API]]
		- [[OE Swagger Test]]
		- [x] Unallocated ✅ 2025-01-14
		- [x] Base ✅ 2025-01-14
		- [x] Lines ✅ 2025-01-15
			- configuration-groups-multiselect/groupId/{groupId}/asset-lines-list
			- PR: [Pull request 117128: OE-515: Upgraded common Nuget. Added ConfigurationGroupMultiselectAssetLinesList - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/117128?_a=files)
		- [x] Alerts ✅ 2025-01-15
			- configuration-groups-multiselect/groupId/{groupId}/asset-alerts-list
			- PR: [Pull request 117150: OE-515: Adding in Alerts end point - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/117150)
		- [x] Upgraded Common: [Pull request 117228: OE-515: Upgraded Common Nuget - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/117228) ✅ 2025-01-16
			- [x] NEED: MiX.DeviceIntegration.Common.2025.3.20250116.2 (**27th**) ✅ 2025-01-28
			- [x] PR: [Pull request 117876: OE-515: Upgraded nuget common - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/117876) ✅ 2025-01-28
		- [x] Add Back: black flags ✅ 2025-01-28
- ==DeviceConfig.API==
	- [x] PR: Outstanding: [Pull request 117043: OE-515: Moved alerts part to DP DB - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/117043?path=/DeviceConfiguration.DataProcessing/Schemas/state/Stored%20Procedures/MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql) ✅ 2025-01-28
- Client
	- Calling API
	- Config/MR/OE-515 Splitting out Alerts Columns
	- [x] Lines ✅ 2025-01-15
		- [x] [Pull request 117163: OE-515: Added methods to call Lines and Alerts end points - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/117163) ✅ 2025-01-15
		- MiX.ConfigInternal.Api.Client.2025.3.20250115.1
	- [x] Alerts ✅ 2025-01-15
		- As above
	- [x] Upgraded Common: [Pull request 117229: OE-515: Upgraded Common - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/117229) ✅ 2025-01-16
	- MiX.ConfigInternal.Api.Client.2025.3.20250116.1
	- [x] Need: MiX.DeviceIntegration.Common.2025.3.20250116.2 (**27th**) ✅ 2025-01-28
	- [x] PR: [Pull request 117880: OE-515: Upgraded nuget common - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/117880) ✅ 2025-01-28
	- **MiX.ConfigInternal.Api.Client.2025.4.20250128.1**
	- [x] Add back black flags ✅ 2025-01-28
- FR API
	- Calling Client
	- Config/MR/OE-515 Splitting out Alerts Columns
	- [x] Lines ✅ 2025-01-16
	- [x] Alerts ✅ 2025-01-16
	- [x] Need Common: MiX.DeviceIntegration.Common.2025.3.20250116.2 (**27th**) ✅ 2025-01-28
	- [x] Need Client: MiX.ConfigInternal.Api.Client.2025.4.20250128.1 ✅ 2025-01-28
		- [x] PR: [Pull request 117883: OE-515: Adding lazy loading end-points for lines and alerts - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/117883) ✅ 2025-01-28
	- [x] Add back black flags ✅ 2025-01-28
- FR UI
	- Call FR API
	- Config/MR/OE-515 Splitting out Alerts Columns
	- [-] Need: MiX.DeviceIntegration.Common.2025.3.20250116.2
	- [x] Lines ✅ 2025-01-28
	- [x] Alerts ✅ 2025-01-28
		- [x] If it has CommsLog, replace this new value in the UI ✅ 2025-01-28
	- https://www.telerik.com/kendo-angular-ui/components/indicators/skeleton
	- [x] PR: [Pull request 117896: OE-515: Lazy loading Lines and Alert columns - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/117896) ✅ 2025-01-28
	- [x] Add back black flags ✅ 2025-01-28
	- [x] Add loading indicators ✅ 2025-01-30
		- configAssetColumnLazy
		- eg. configAssetColumnIcon
		- 3: lines: hos, miXVisionSerialnumber, sp, fuel, rpm, speed 
		- 3: alerts: fwVersion, preferredFWVersion, alerts, serialnumber
		- 5: alerts: commsLog (messageStatusDateUtc)
		- **ADDED**: @progress/kendo-angular-indicators
		- [ ] ? canScript (canScriptLineId)
	- [x] PR: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/118020 ✅ 2025-01-30

```c#
ng add @progress/kendo-angular-indicators
//OR
npm install --save @progress/kendo-angular-indicators
```

## Bugs Note

As mentioned before. We moved these columns out to lazy load.  
This helps this panel load faster.  
(I am still busy implementing the loading indicators, which are not part of this story)  
  
_Please note_ the Firmware filter lazy loads.  
So at first, it won’t show immediately, until it lazy loads. 
So give it time 🙂


## Columns split for lazy loading overview

- Unallocated: MobileUnit_GetUnallocatedAssets
- [x] Base, Black Flags: MobileUnit_GetAllMobileUnitsForConfigurationGroups ✅ 2025-01-28
- [x] Lines, MiXVisionSerialnumber: MobileUnit_GetAllMobileUnitLinesForConfigurationGroups ✅ 2025-01-28
- [x] Alerts, FW, Serialnumber, CommsLog: MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups ✅ 2025-01-28


## Kendo Skeleton Indicators

SOURCE: [Angular Indicators Skeleton Overview - Kendo UI for Angular](https://www.telerik.com/kendo-angular-ui/components/indicators/skeleton)

```html
<kendo-skeleton
  shape="circle"
  animation="pulse"
  [width]="20"
  [height]="20"
></kendo-skeleton>

<kendo-skeleton
	shape="text"
	animation="pulse"
	width="100%"
></kendo-skeleton>

<kendo-skeleton
	shape="rectangle"
	animation="pulse"
	width="100%"
	height="143.86px"
></kendo-skeleton>
```

## Languaging

- [x] Alerts ✅ 2025-01-30
- [x] Configuration upload request expired ✅ 2025-01-30
- [x] FW upload request expired ✅ 2025-01-30
- [x] Preferred FW version not supported ✅ 2025-01-30
- [x] Event not monitored - missing parameters ✅ 2025-01-30