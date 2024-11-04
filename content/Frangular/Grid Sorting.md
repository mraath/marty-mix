---
created: 2024-11-04T11:41
updated: 2024-11-04T15:22
---
## Grid Sorting

I saw quite a few examples on some of the Fleet Services UI code base. I clipped the simplified example below. From testing it seems to be working fine. 

>[!Note]
>If you find anything that is not working, please let me know, then I can fix this document.

## HTML

```html
<kendo-grid 
	[data]="filteredConfigGroups"
	[sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}"
	[sort]="sortConfigGroups"
	(sortChange)="sortConfigGroupsChange($event)">
```

## Typescript

```ts
import { orderBy, SortDescriptor } from "@progress/kendo-data-query";
sortConfigGroups: SortDescriptor[] = [{ dir: "asc", field: "configurationGroupName" }];

sortConfigGroupsChange(sort: SortDescriptor[]): void {
	this.sortConfigGroups = sort;
	this.loadConfigGroupsGridSortItems();
}

private loadConfigGroupsGridSortItems() {
	this.filteredConfigGroups.data = orderBy(this.filteredConfigGroups.data, this.sortConfigGroups);
}

//Also call loadConfigGroupsGridSortItems() after loading or filtering data!
```
