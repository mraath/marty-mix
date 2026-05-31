---
wiki_ingested: 2026-05-28
created: 2025-09-24T08:21
updated: 2025-09-24T08:21
---
## Notes

HTML
<kendo-grid [data]="gridData" [rowClass]="rowClassFn">
<kendo-grid-column *ngFor="let col of gridConfigGroupColumns"
                     [field]="col.field"
                     [title]="col.name"
                     [width]="col.width"
                     [hidden]="!col.visible"
                     [sortable]="true"
                     [resizable]="true"
[class]="col.field === 'firmwareVersion' ? 'firmware-col' : ''">
</kendo-grid-column>
</kendo-grid>

 
TS
import { RowClassArgs } from '@progress/kendo-angular-grid';
 
public rowClassFn = (args: RowClassArgs) => {
  const v = parseFloat(args.dataItem?.firmwareVersion);
  return { 'old-fw': !isNaN(v) && v < 2.0 };
};

 
CSS
.k-grid tr.old-fw td.firmware-col {
  background:$error-subtle!important
}


## Example PR

https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/131224?_a=files