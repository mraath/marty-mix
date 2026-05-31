---
wiki_ingested: 2026-05-28
created: 2025-10-08T09:17
updated: 2025-10-08T10:55
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

Other settings for the drop down....

[textField]="'text'"  > shows which part of ddFilterFirmwareVersion will be displayed (this can be translated)
[valueField]="'value'" > shows the value used
[clearButton]="true" > should there be a clear button on the selection
[autoClose]="false" > shouldn't autoclose (I think on selection)
[filterable]="true" > allow the used to filter the dropdown values by what they type in
[tagMapper]="tagMapper"  > not sure yet
[placeholder]="'Filter by firmware version'|dmxTranslate" > A message to call the user to action
class="filter"> the css class used
