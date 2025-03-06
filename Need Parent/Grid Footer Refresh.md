---
created: 2025-01-13T12:00
updated: 2025-01-13T12:01
---
## Configuration Groups

```html
<!-- Grid Footer -->
<ng-template kendoPagerTemplate let-totalPages="totalPages" let-currentPage="currentPage">
  <span class="ml-2">
  </span>
</ng-template>
```

## Assets Panel

```html
<ng-template kendoPagerTemplate let-totalPages="totalPages" let-currentPage="currentPage">
  <span class="ml-2">
	<strong>{{'Last refresh'|dmxTranslate}}:</strong>
	<span class="muted ml-1 mr-1">{{refreshText}}</span>
	<a (click)="onRefreshClicked()" [ngClass]="{'disabled': !canRefresh }">
	  <i class="fa fa-refresh mr-1"></i>
	  <span>{{'Refresh'|dmxTranslate}}</span>
	</a>
  </span>
</ng-template>
<kendo-grid-messages noRecords="{{'No records available.'|dmxTranslate}}">
</kendo-grid-messages>
```
