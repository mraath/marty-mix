---
created: 2025-10-08T09:17
updated: 2025-10-08T10:52
---
## Introduction

Often our grids have a lot of data. Adding a filter is an easy way to quickly show the information the user is interested in.
I will walk through a filter example here.... I will make use of the Firmware Version filter on the Assets Panel in the Configuration Groups (BETA) page.

## HTML

```html
<!-- Filter -->
<div class="row">
  
  
  <div class="col p-0 border-left">
    <!-- TODO: MR: Should tagMapper be unique? -->
    <kendo-multiselect [data]="ddFilterFirmwareVersion" [(ngModel)]="selectedFWVersions" (closed)="fwVersionsClosed()" (valueChange)="fwVersionsChanged()" [textField]="'text'" [valueField]="'value'" [clearButton]="true" [autoClose]="false" [filterable]="true" [tagMapper]="tagMapper" [placeholder]="'Filter by firmware version'|dmxTranslate" (filterChange)="onFWVersionsChange($event)" class="filter">
    </kendo-multiselect>
  </div>
```


## TS

### Fields and methods

ddFilterFirmwareVersion > Stores the drop down list (data)

```ts
ddFilterFirmwareVersion: Array<{ text: string; value: string }> = [];

//Whenever the data changes (comes in from the backend) I update the dropdown (if needed)... We call this method
UpdateFilters
```

onFWVersionsChange($event) > Called when filter Changes

```ts
//This method will set the Filters
//It will also then filter the dropdown based on what the user entered
```


selectedFWVersions > Keeps the currently selected fw version (ngModel)

```ts
selectedFWVersions: any[] = [];

```

fwVersionsChanged > when the value changes (valueChange)

```ts
fwVersionsChanged() {
    if (this.selectedFWVersions.length === 0) {
      this.FilterAssets();
      this.loadAssetsGridSortItems();
    }
}

//Inside FilterAssets
if (this.selectedFWVersions.length > 0) {
  var selected = this.selectedFWVersions.select(x => x.value); //Strip out value only
  data = data.filter(x => selected.includes(x.fwVersion));
}
```

on clearPage > when clearing all elements on the page

```ts
this.ddFilterFirmwareVersion.clear();
this.selectedFWVersions.clear();
```

fwVersionsClosed > when the dropdown closes (closed)

```ts
fwVersionsClosed() {
	this.FilterAssets();
	this.loadAssetsGridSortItems();
}
```


[textField]="'text'" 
[valueField]="'value'" 
[clearButton]="true" 
[autoClose]="false" 
[filterable]="true" 
[tagMapper]="tagMapper" 
[placeholder]="'Filter by firmware version'|dmxTranslate" 

class="filter">
