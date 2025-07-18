---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-18T16:53
---

# OPEN-371 Column Order Lost

Date: 2025-07-14 Time: 09:01
Parent:: ==xxxx==
Friend:: [[2025-07-14]]
JIRA:OPEN-371
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-371)


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

Column selection and column order settings reset when reloading

- [ ] Should keep column order
- [ ] Should save columns selected
- Should more easily select columns

## NEXT

Check if these are hit
- updateColumnSettings
- updateHiddenColumns
They do

## Testing order logging

Load: alerts|registration|legacyVehicleId|sitename|assetDescription|flagged|assetId|fleetNumber|lastposition|imei|serialnumber|mobileDevice|configCompileStatus|configurationStatus|configurationStatusDate|commsLog|configurationGroupName|mobileDeviceTemplateName|eventTemplateName|locationTemplateName|fwVersion|preferredFWVersion|canScript|speed|rpm|fuel|sp|miXVisionSerialnumber|hos
changeColumnOrdering: alerts|registration|sitename|legacyVehicleId|assetDescription|flagged|assetId|fleetNumber|lastposition|imei|serialnumber|mobileDevice|configCompileStatus|configurationStatus|configurationStatusDate|commsLog|configurationGroupName|mobileDeviceTemplateName|eventTemplateName|locationTemplateName|fwVersion|preferredFWVersion|canScript|speed|rpm|fuel|sp|miXVisionSerialnumber|hos
Reordered: alerts|registration|sitename|legacyVehicleId|assetDescription|flagged|assetId|fleetNumber|lastposition|imei|serialnumber|mobileDevice|configCompileStatus|configurationStatus|configurationStatusDate|commsLog|configurationGroupName|mobileDeviceTemplateName|eventTemplateName|locationTemplateName|fwVersion|preferredFWVersion|canScript|speed|rpm|fuel|sp|miXVisionSerialnumber|hos
changeColumnOrdering: alerts|registration|sitename|legacyVehicleId|assetId|assetDescription|flagged|fleetNumber|lastposition|imei|serialnumber|mobileDevice|configCompileStatus|configurationStatus|configurationStatusDate|commsLog|configurationGroupName|mobileDeviceTemplateName|eventTemplateName|locationTemplateName|fwVersion|preferredFWVersion|canScript|speed|rpm|fuel|sp|miXVisionSerialnumber|hos
Reordered: alerts|registration|sitename|legacyVehicleId|assetId|assetDescription|flagged|fleetNumber|lastposition|imei|serialnumber|mobileDevice|configCompileStatus|configurationStatus|configurationStatusDate|commsLog|configurationGroupName|mobileDeviceTemplateName|eventTemplateName|locationTemplateName|fwVersion|preferredFWVersion|canScript|speed|rpm|fuel|sp|miXVisionSerialnumber|hos



--------------- IMEI
123456789033322

![[OPEN-371 Column Order Lost.png]]

![[OPEN-371 Column Order Lost-1.png]]


## Test BETA

- First try **vars**
- Then try **SelectionCriteria** Logic for grid

### Selected Cols

- html: (click)="columnVisibilityChanged(item)"
- ts
	- columnVisibilityChanged
		- gridSelectionCriteriaService.changeHiddenColumns
		- hiddenColumns
	- columnVisibilityChanged
		- 
	- assetsColumnVisibilityChanged
		- gridSelectionCriteriaService.changeHiddenColumns
		- configAssetsHiddenColumns

### Ordered Cols

- html: kendo-grid class="grid" #eventsGrid [data]="gridView" [resizable]="false" [sortable]="false" [reorderable]="true" (columnReorder)="columnReordered($event)">
- ts
	- columnReordered
		- hiddenColumns
		- 
	- columnReordered
		- cccc
	- assetsColumnReordered
		- configAssetsHiddenColumns
		- 

xxxxxxxxxxxxxxxxxxx