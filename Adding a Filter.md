---
created: 2025-10-08T09:17
updated: 2025-10-08T09:22
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

[data]="ddFilterFirmwareVersion" 
[(ngModel)]="selectedFWVersions" 
(closed)="fwVersionsClosed()" 
(valueChange)="fwVersionsChanged()" 
[textField]="'text'" 
[valueField]="'value'" 
[clearButton]="true" 
[autoClose]="false" 
[filterable]="true" 
[tagMapper]="tagMapper" 
[placeholder]="'Filter by firmware version'|dmxTranslate" 
(filterChange)="onFWVersionsChange($event)" 
class="filter">
