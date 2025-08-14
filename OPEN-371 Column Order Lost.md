---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-08-14T10:23
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
- [x] Should save columns selected ✅ 2025-08-12
- Should more easily select columns


## Branch

Config/MR/Bug/OPEN-371ColumnOrderLost.INT
- [x] [PR to DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/128833) ✅ 2025-08-14
	- [x] [PR to DEV 2](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/128984) ✅ 2025-08-14
- [ ] PR to INT

## Flow Diagram

![[OPEN-371 Column Order Lost.excalidraw.png]]
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
		- SelectionCriteriaKeys.assetSearchSelectedColumns
	- columnVisibilityChanged
		- 
	- assetsColumnVisibilityChanged
		- gridSelectionCriteriaService.changeHiddenColumns
		- configAssetsHiddenColumns
		- SelectionCriteriaKeys.assetsSelectedColumns

### Ordered Cols

- html: kendo-grid class="grid" #eventsGrid [data]="gridView" [resizable]="false" [sortable]="false" [reorderable]="true" (columnReorder)="columnReordered($event)">
- ts
	- columnReordered
		- this.columns
		- this.hiddenColumns
		- this.gridSelectionCriteriaService.changeColumnOrdering
			- SelectionCriteriaKeys.assetSearchColumnSettings
			- this.columnSettings
			- this.columns
	- columnReordered
		- cccc
	- assetsColumnReordered
		- this.assetsColumns
		- configAssetsHiddenColumns
		- this.gridSelectionCriteriaService.changeColumnOrdering
			- SelectionCriteriaKeys.assetsColumnSettings
			- this.assetsColumnSettings
			- this.assetsColumns

## TEST

### CG

![[Pasted image 20250721163425.png]]
![[Pasted image 20250721163403.png]]
![[Pasted image 20250721163237.png]]

### Asset

![[OPEN-371 Column Order Lost-2.png]]
![[OPEN-371 Column Order Lost-3.png]]
![[OPEN-371 Column Order Lost-4.png]]

## Timothy

Ek dink daar is niks fout met selection criteria nie. Ek het wel 1 keer gesien 'n ==error== wat gebeur het voor selection criteria laai wat maak dat dit lyk asof dit nie laai nie.

Jy kan sien in die network tab as die requests om die criteria te fetch/==update==. Ek het 'n column gekies, wat deselected was. Jy kan sien in die image hier onder die 3 columns wat nou deselected is, is deel van die network request om te persist.

![[OPEN-371 Column Order Lost-5.png]]

Daarna het ek net die get request ge-==replay== om response te sien en te verseker dit match teenoor wat ek sopas persist het (jy kan page ook reload maar dis meer effort ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/30_f.png?v=v83)). Hier kan jy sien die response van die volgende request het al die columns in wat ek net voor dit gaan persist het

![[OPEN-371 Column Order Lost 2.png]]
