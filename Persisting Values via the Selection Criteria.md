---
created: 2025-10-08T07:28
updated: 2025-10-08T08:33
---

## Introduction

We sometimes need a method to persist user selections between sessions. The mechanism we use is the **selection criteria**. Examples would be persisting selected columns, column widths, etc. 
I will explain the basics of doing this in this article.

## Example: persisting column width

Column widths is not the most simple example, however, this is the last one I worked on and I should be able to remember what I did :-)

This example can therefore be simplified to your needs, but here it goes.

### Need

When the user changes column widths for the Config Groups Panel within the Configuration Groups (BETA) page.  This needs to be persisted between sessions and page changes.

### Mechanism

We make use of the Selection Criteria. 
The selection criteria will need:
- a **key** to persist these values against, 
- it will also need a **settings class** which will specify eg. column names and widths.
- **data** you want to change

### HTML

In the below HTML, the (columnResize) event will be used. This will call the ts file's method: columnResize

```html
<!-- CONFIGURATION GROUPS GRID -->
    <div class="row flex-grow-1 position-relative mr-overflow">
      <kendo-grid [data]="filteredConfigGroups" [skip]="skip"  [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="true" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortConfigGroups" (sortChange)="sortConfigGroupsChange($event)" class="grid-full-height" (selectionChange)="onConfigGroupSelectionChange($event)" (columnReorder)="columnReordered($event)" kendoGridSelectBy="configurationGroupId" [(selectedKeys)]="configGroupSelectedKeys" (columnResize)="columnResize($event)">
```
### TS file

Whenever the width changes save that to Selection Criteria by using the Settings you specified.

In this instance there is a method on the Selection Criteria service. You will need to see if this is something you can re-use or (highly unlikely) you will need to write a new method.

For persisting you will need: 
- a method to **get** your values and 
- a method to **update** the values


#### Updating the values

```ts
columnResize(columnResizeEvent: ColumnResizeArgs[]) {
	this.gridSelectionCriteriaService.changeColumnWidth(SelectionCriteriaKeys.configGroupsColumnSettings, this.configGroupsColumnSettings, columnResizeEvent);
}
```

Above you can see the two things I mentioned before, which the Selection Criteria needs to persist data.

##### The Key

In this case: SelectionCriteriaKeys.configGroupsColumnSettings
Path: src\app\shared\selection-criteria-keys.ts

```ts
export class SelectionCriteriaKeys {
	//... the relative snippet
	static configGroupsColumnSettings = "configGroupsColumn";
	
}
```

This key is used within the Selection Criteria to know what you are busy persisting.

##### The Settings class

In this case: this.configGroupsColumnSettings

```ts
//Code snippets
import { ConfigGroupsColumnSettings } from '../shared/components/controls/grid-columns/config-groups-column-settings';

private configGroupsColumnSettings: ColumnSettingsDataItem[];
```

Path: src\app\shared\components\controls\input-models\column-settings-data-item.ts

```ts
export class ColumnSettingsDataItem {
	columnName: string;
	minimumWidth: number;
	currentWidth: number;
	index: number;
}
```

##### The data to be changed

In this case it comes from: columnResizeEvent
This event has all the information needed to change the info.
It has the fieldname to be used against the Settings class to know what field to update.
It has the new column width, which will become the new value for the above field.

#### Getting the values

Data is read from the Selection Criteria, making use of the **key** 

```ts
// Snippets
// ngOnInit...
this.configGroupsColumnSettings = this.gridSelectionCriteriaService.getDefaultColumnSettings(SelectionCriteriaKeys.configGroupsColumnSettings);

// Getting all the grid + column values
private fetchGroupsSelectionCriteriaGrid() {
    //console.log("Fetching config groups selection criteria");
    this.loadSpinnerConfigGroups = true;
    this.gridSelectionCriteriaService.getColumnSettings(SelectionCriteriaKeys.configGroupsColumnSettings, SelectionCriteriaKeys.configGroupsSelectedColumns)
      .pipe(takeWhile(() => this.alive))
      .subscribe((gridColumnData: GridColumnDataModel) => {
        if (gridColumnData && gridColumnData.columnSettings && gridColumnData.columnSettings.length > 0)
          this.configGroupsColumnSettings = gridColumnData.columnSettings;

		// Im just leaving the below in for 
        if (gridColumnData && gridColumnData.allowedHiddenColumns && gridColumnData.allowedHiddenColumns.length > 0)
          this.configGroupsHiddenColumnSettings = gridColumnData.allowedHiddenColumns;

        this.configGroupsHiddenColumns = gridColumnData.hiddenColumns;
        this.setupConfigGroupsGrid();

      }, () => this.setupConfigGroupsGrid());
  }
```

### Other selection criteria method

Other methods might help you figure out your needs even more.
Here is one relate to the above, to persist column ordering...

- gridSelectionCriteriaService.changeColumnOrdering

