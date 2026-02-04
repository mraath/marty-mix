---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-04T10:39
---

# OPEN-997 New Column Reordering

Date: 2026-01-26 Time: 15:15
Parent:: https://powerfleet.atlassian.net/browse/OPEN-715
Friend:: [[2026-01-26]]
JIRA:OPEN-997 New Column Reordering
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-997)



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

- Please provide all links investigated for these findings, including JIRA items (main and parent) and relevant repositories.

### Investigated Links
- **JIRA Story**: [OPEN-997](https://powerfleet.atlassian.net/browse/OPEN-997)
- **Parent JIRA**: [OPEN-715](https://powerfleet.atlassian.net/browse/OPEN-715)
- **Previous Work**: [OPEN-714](https://powerfleet.atlassian.net/browse/OPEN-714), [OPEN-371](https://powerfleet.atlassian.net/browse/OPEN-371)
- **MiX Seed Repo**: [MiX Seed](https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed)
- **Seed App Demo**: [http://10.224.2.56/fleet/seedapp/#/layout](http://10.224.2.56/fleet/seedapp/#/layout)
- **Frangular UI Repo**: [MiX.Config.Frangular.UI](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI)

## AI Questions:

### One

OK - I found the correct links....
In this link:
https://powerfleet.atlassian.net/browse/OPEN-715?focusedCommentId=1355185
Shawn mentioned this seed app where he did it:
MiX Seed: https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed


We would add something like that into this part of our logic:
C:\Projects\MiX.Config.Frangular.UI\src\app\configgroups\configgroups.component.html
And its relevant .ts file, where it mentions this:
          <kendo-popup #popup class="popup-column-chooser" *ngIf="showGridConfigGroupColumns" [anchor]="configGroupsColumnChooserButton" (anchorViewportLeave)="showGridConfigGroupColumns = false" [animate]="false" [anchorAlign]="anchorAlign" [popupAlign]="popupAlign">

### Two

Did you see this part he mentioned:
@Richard Hobson I’ve done an example on the ui-config-groups branch on the MiX Seed app repo, showing column reordering via the column chooser popup. I would recommend setting [reorderable]="false" on the grid, so that the user is forced to use the column choose to reorder columns. They would still need to persist the column order state.

MiX Seed: https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed

### Three

Okay this is great, now looking at the seed app and the changes Sean showed there, could you try and duplicate that in our config groups page for a config group popup modal. Under this section
kendo-popup #popup class="popup-column-chooser" *ngIf="showGridConfigGroupColumns


## DIFF 1

[[dev.azure.com-Pull requests - Repos-fpscreenshot.pdf]]

### Code

```c#
configgroups.component.html
-7+14
/src/app/configgroups/configgroups.component.html
            </button>
          </div>
          <kendo-popup #popup class="popup-column-chooser" *ngIf="showGridConfigGroupColumns" [anchor]="configGroupsColumnChooserButton" (anchorViewportLeave)="showGridConfigGroupColumns = false" [animate]="false" [anchorAlign]="anchorAlign" [popupAlign]="popupAlign">
            <div class="wrap" *ngFor="let item of configGroupsColumnsOrdered; let i = index" role="menuitem">
            <div class="wrap d-flex align-items-center" *ngFor="let item of configGroupsColumnsOrdered; let i = index" role="menuitem">
              <input type="checkbox" id="{{item?.field}}" class="k-checkbox"
                     [checked]="!item?.hidden"
                     [disabled]="item?.locked"
                     (click)="columnVisibilityChanged(item)" />
              <label class="k-checkbox-label"
              <label class="k-checkbox-label flex-grow-1 mb-0"
                     for="{{item?.field}}"
                     (click)="$event.stopPropagation()">{{item?.title|dmxTranslate}}</label>
              <div class="ml-2">
                <i class="icon-chevron-up hand-cursor mr-1" (click)="moveColumnUp(i, 'configGroups')" [class.disabled]="i === 1 || item?.locked"></i>
                <i class="icon-chevron-down hand-cursor" (click)="moveColumnDown(i, 'configGroups')" [class.disabled]="i === configGroupsColumnsOrdered.length - 2 || item?.locked"></i>
              </div>
            </div>
          </kendo-popup>
        </div>
      </div>
    </div>
    <!-- CONFIGURATION GROUPS GRID -->
    <div class="row flex-grow-1 position-relative mr-overflow">
      <kendo-grid [data]="filteredConfigGroups" [skip]="skip"  [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="true" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortConfigGroups" (sortChange)="sortConfigGroupsChange($event)" class="grid-full-height" (selectionChange)="onConfigGroupSelectionChange($event)" (columnReorder)="columnReordered($event)" kendoGridSelectBy="configurationGroupId" [(selectedKeys)]="configGroupSelectedKeys" (columnResize)="columnResize($event)">
      <kendo-grid #configGroupsGrid [data]="filteredConfigGroups" [skip]="skip"  [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="false" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortConfigGroups" (sortChange)="sortConfigGroupsChange($event)" class="grid-full-height" (selectionChange)="onConfigGroupSelectionChange($event)" (columnReorder)="columnReordered($event)" kendoGridSelectBy="configurationGroupId" [(selectedKeys)]="configGroupSelectedKeys" (columnResize)="columnResize($event)">
        <!--Config Groups Text Filter-->
        <ng-template kendoGridToolbarTemplate>
                   [popupAlign]="popupAlign"
                   style="width: auto;">
        <div class="popup-column-chooser-scroll" style="white-space: nowrap;">
          <div class="wrap"
          <div class="wrap d-flex align-items-center"
               *ngFor="let item of configAssetsColumnsOrdered; let i = index"
               role="menuitem">
            <input type="checkbox"
                   [checked]="!item?.hidden"
                   [disabled]="item?.locked"
                   (click)="assetsColumnVisibilityChanged(item)" />
            <label class="k-checkbox-label"
            <label class="k-checkbox-label flex-grow-1 mb-0"
                   for="{{item?.field}}"
                   (click)="$event.stopPropagation()">
              {{item?.title|dmxTranslate}}
            </label>
            <div class="ml-2 mr-2">
              <i class="icon-chevron-up hand-cursor mr-1" (click)="moveColumnUp(i, 'assets')" [class.disabled]="i === 1 || item?.locked"></i>
              <i class="icon-chevron-down hand-cursor" (click)="moveColumnDown(i, 'assets')" [class.disabled]="i === configAssetsColumnsOrdered.length - 2 || item?.locked"></i>
            </div>
          </div>
        </div>
      </kendo-popup>
<!-- ASSETS PANEL GRID -->
<div class="row flex-grow-1 position-relative">
  <kendo-grid #assetsGrid [data]="filteredAssets" [skip]="skip" [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="true" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortAssets" (sortChange)="sortAssetsChange($event)" class="grid-full-height" (selectionChange)="onAssetSelectionChange($event)" (columnReorder)="assetsColumnReordered($event)" kendoGridSelectBy="assetId" [(selectedKeys)]="assetSelectedKeys" (excelExport)="onExcelExportAssets($event)" [pageable]="true" [singlepage]="true" (columnResize)="assetColumnResize($event)" [rowClass]="fwOldVersionHighlightRowClassFn">
  <kendo-grid #assetsGrid [data]="filteredAssets" [skip]="skip" [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="false" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortAssets" (sortChange)="sortAssetsChange($event)" class="grid-full-height" (selectionChange)="onAssetSelectionChange($event)" (columnReorder)="assetsColumnReordered($event)" kendoGridSelectBy="assetId" [(selectedKeys)]="assetSelectedKeys" (excelExport)="onExcelExportAssets($event)" [pageable]="true" [singlepage]="true" (columnResize)="assetColumnResize($event)" [rowClass]="fwOldVersionHighlightRowClassFn">
    <!--Assets Text Filter-->
    <ng-template kendoGridToolbarTemplate>

configgroups.component.ts
-5+67
/src/app/configgroups/configgroups.component.ts
//, AfterViewInit
{
  @ViewChild("assetsGrid", { static: false }) assetsGrid: GridComponent;
  @ViewChild("configGroupsGrid", { static: false }) configGroupsGrid: GridComponent;
  @ViewChild("configGroupsColumnChooserButton") public configGroupsColumnChooserButton: ElementRef;
  @ViewChild("assetsColumnChooserButton") public assetsColumnChooserButton: ElementRef;
  @ViewChild('assetsDropdown') assetsDropdown: any;
  assetsMoveErrorMessage: string;
  columns: IColumn[] = [];
  organisationId: string;
  configGroupId: string;
  configGroupIds: string[] = [];
  iFrameMessage: string;
  sidebarSize = '50%';
      this.gridSelectionCriteriaService.getSelectedConfigGroups(SelectionCriteriaKeys.selectedConfigGroups + this.organisationId)
        .pipe(takeWhile(() => this.alive))
        .subscribe((data: string) => {
          if(data)
          {
          // Check query params first
          if (this.configGroupId) {
            this.configGroupSelectedKeys = [this.configGroupId];
            this.loadConfigAssets();
          } else if (data) {
            // If selected group ids value doesn't match a pattern - empty the selection
            const regex = /^-?\d+(,-?\d+)*$/;
            this.configGroupSelectedKeys = regex.test(data) ? data.split(',') : [];
    //console.log("FR UI: onMessageReceived: " + JSON.stringify(msg, null, 2));
    //This is where the authToken gets sent in from the OLD UI
    this.organisationId = msg.data.message.data.organisationId;
    this.configGroupId = msg.data.message.data.configGroupId;
    //console.log("Org in Frangular: " + this.organisationId);
    this.xAuth = msg.data.xAuth;
    this.sessionService.setAuthToken(msg.data.xAuth).pipe(takeWhile(() => this.alive))
    //Save to selection criteria
    column = new ColumnReorderEvent({ column: column.column, newIndex: column.newIndex, oldIndex: column.oldIndex });
    this.gridSelectionCriteriaService.changeColumnOrdering(SelectionCriteriaKeys.assetsColumnSettings, this.assetsColumnSettings, column, 0, this.assetsColumns.length);
    this.gridSelectionCriteriaService.changeColumnOrdering(SelectionCriteriaKeys.assetsColumnSettings, this.assetsColumnSettings, column, 1, this.assetsColumns.length);
  }
  moveColumnUp(index: number, gridType: string) {
    if (index === 0) return;
    const columns = gridType === 'configGroups' ? this.configGroupsColumnsOrdered : this.configAssetsColumnsOrdered;
    this.reorderManual(columns, index, index - 1, gridType);
  }
  moveColumnDown(index: number, gridType: string) {
    const columns = gridType === 'configGroups' ? this.configGroupsColumnsOrdered : this.configAssetsColumnsOrdered;
    if (index === columns.length - 1) return;
    this.reorderManual(columns, index, index + 1, gridType);
  }
  private reorderManual(columns: IColumn[], popupOldIndex: number, popupNewIndex: number, gridType: string) {
    const item = columns[popupOldIndex];
    if (item.locked) return;
    const gridOldIndex = popupOldIndex + 1;
    const gridNewIndex = popupNewIndex + 1;
    const event = new ColumnReorderEvent({
      column: { field: item.field } as any,
      newIndex: gridNewIndex,
      oldIndex: gridOldIndex
    });
    if (gridType === 'configGroups') {
      this.gridSelectionCriteriaService.changeColumnOrdering(SelectionCriteriaKeys.configGroupsColumnSettings, this.configGroupsColumnSettings, event, 1, this.configGroupsColumns.length);
      this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(this.configGroupsGrid, this.configGroupsColumnSettings);
    } else {
      this.gridSelectionCriteriaService.changeColumnOrdering(SelectionCriteriaKeys.assetsColumnSettings, this.assetsColumnSettings, event, 1, this.assetsColumns.length);
      this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(this.assetsGrid, this.assetsColumnSettings);
    }
    if (gridType === 'configGroups') {
      this.setupConfigGroupsGrid();
    } else {
      this.setupConfigAssetsGrid();
    }
  }
  assetColumnResize(columnResizeEvent: ColumnResizeArgs[]) {
        this.configGroupsHiddenColumns = gridColumnData.hiddenColumns;
        this.setupConfigGroupsGrid();
        if (this.configGroupsGrid) {
          this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(this.configGroupsGrid, this.configGroupsColumnSettings);
        }
      }, () => this.setupConfigGroupsGrid());
  }
        this.configAssetsHiddenColumns = gridColumnData.hiddenColumns;
        this.setupConfigAssetsGrid();
        if (this.assetsGrid) {
          this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(this.assetsGrid, this.assetsColumnSettings);
        }
        this.loadSpinnerAssets = false;
      }, () => this.setupConfigAssetsGrid());
    //console.log("configGroupColumn done");
    this.configGroupsColumnsOrdered = [];
    this.configGroupsColumnsOrdered.push(...this.configGroupsColumns);
    // Filter out undefined and maintain grid order
    this.configGroupsColumnsOrdered = this.configGroupsColumnsOrdered.filter(c => c !== undefined);
    /* Shawn recommendation: maintain grid order in chooser
    this.configGroupsColumnsOrdered.sort((columnA, columnB) => {
      const titleA = columnA.title.toLowerCase();
      const titleB = columnB.title.toLowerCase();
      }
      return 0;
    });
    */
  }
  private setupConfigAssetsGrid() {
    //console.log("configAssetsColumn done");
    this.configAssetsColumnsOrdered = [];
    this.configAssetsColumnsOrdered.push(...this.assetsColumns);
    // Filter out undefined and maintain grid order
    this.configAssetsColumnsOrdered = this.configAssetsColumnsOrdered.filter(c => c !== undefined);
    /* Shawn recommendation: maintain grid order in chooser
    this.configAssetsColumnsOrdered.sort((columnA, columnB) => {
      const titleA = columnA.title.toLowerCase();
      const titleB = columnB.title.toLowerCase();
      }
      return 0;
    });
    */
  }

```

## CODE

As per the parent story, Open-715, I looked into Shawn's example on our **ui-config-groups** branch.
This can be found in the MiX Seed repo: `https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed`. 

I got those changes into our pop-up column selectors for as a proof of concept with up and down arrows. 
This worked well and it also persisted the column order in the selection criteria. 
After this I tried the drag drop as an enhancement and eventually I got it working.
Before the drag drop was working I had some issues. I lost certain columns, furthermore certain indexes wouldn't persist. Sometimes the column orders on the grid would not match the column selector's order. 

As my branch is currently, it seems to be working fine. 
However, I would suggest that a **developer** takes **one (maybe two) days** just to double check, especially the indexing. I added a console log (currently commented out) which can be used for debugging to ensure the indexing is working. Also test that if you go to another page and return that it actually persists for both the config grid and the assets grid column orders. 
I would then also suggest that a **tester** will take **one (maybe two) days** just to test this properly as we know that column ordering has been an issue in the past. However, it shouldn't take more than a day.

As most of the work has been done and it will mostly be double checking things, I would suggest no more than 3 days (mostly for testing and a little bit of Dev sanity checking)

Herewith the branch I worked on (this is before the FR UI Refactoring)
Config/MR/Feature/OPEN-997_NewColumnReordering.INT

Herewith a video showing this in action:
[Watch the video here](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/IQD3ubDg4VIvQ7SmnJSwIW_fAY0UuuWxv9Ao8gP-ckjUQp0?e=ZCuokX)



## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-997_NewColumnReordering.INT

## DIFF

```diff
diff --git a/package.json b/package.json
index d10d4cd..260c4bb 100644
--- a/package.json
+++ b/package.json
@@ -24,7 +24,6 @@
   "private": true,
   "dependencies": {
     "@angular/animations": "12.2.16",
-    "@angular/cdk": "^12.2.13",
     "@angular/common": "12.2.16",
     "@angular/compiler": "12.2.16",
     "@angular/core": "12.2.16",
diff --git a/src/app/app.module.ts b/src/app/app.module.ts
index dc6b29d..5c06611 100644
--- a/src/app/app.module.ts
+++ b/src/app/app.module.ts
@@ -69,7 +69,6 @@ import { LogicalDeviceComponent } from "./components/common/logical-device/featu
 import { HealthCheckComponent } from "./health-check/health-check.component";
 import { StatusIconComponent } from "./components/common/staus-icon/status-icon.component";
 import { DaysInStatusCellComponent } from "./health-check/days-in-status/days-in-status-cell.component";
-import { DragDropModule } from '@angular/cdk/drag-drop';
 
 @NgModule({
   declarations: [
@@ -118,8 +117,7 @@ import { DragDropModule } from '@angular/cdk/drag-drop';
     RadioButtonModule, LabelModule,
     //CANLibraryModule
     CalibrationModule,
-    NumericTextBoxModule,
-    DragDropModule
+    NumericTextBoxModule
   ],
   providers: [
     SpinnerService,
diff --git a/src/app/configgroups/configgroups.component.html b/src/app/configgroups/configgroups.component.html
index 5105731..a2934c4 100644
--- a/src/app/configgroups/configgroups.component.html
+++ b/src/app/configgroups/configgroups.component.html
@@ -60,30 +60,23 @@
             </button>
           </div>
           <kendo-popup #popup class="popup-column-chooser" *ngIf="showGridConfigGroupColumns" [anchor]="configGroupsColumnChooserButton" (anchorViewportLeave)="showGridConfigGroupColumns = false" [animate]="false" [anchorAlign]="anchorAlign" [popupAlign]="popupAlign">
-            <div cdkDropList (cdkDropListDropped)="dropConfigGroups($event)" class="column-chooser-list">
-              <div class="wrap d-flex align-items-center" *ngFor="let item of configGroupsColumnsOrdered; let i = index; trackBy: trackByField" role="menuitem" cdkDrag>
-                <input type="checkbox" id="{{item?.field}}" class="k-checkbox"
-                      [checked]="!item?.hidden"
-                      [disabled]="item?.locked"
-                      (click)="columnVisibilityChanged(item)" />
-                <label class="k-checkbox-label flex-grow-1 mb-0"
-                      for="{{item?.field}}"
-                      (click)="$event.stopPropagation()">{{item?.title|dmxTranslate}}</label>
-                
-                <div class="ml-2">
-                  <span class="column-chooser-drag-handle hand-cursor" cdkDragHandle 
-                        [class.disabled]="item?.locked" 
-                        style="font-size: 18px; color: #888;">☰</span>
-                </div>
-              </div>
+            <div class="wrap" *ngFor="let item of configGroupsColumnsOrdered; let i = index" role="menuitem">
+              <input type="checkbox" id="{{item?.field}}" class="k-checkbox"
+                     [checked]="!item?.hidden"
+                     [disabled]="item?.locked"
+                     (click)="columnVisibilityChanged(item)" />
+              <label class="k-checkbox-label"
+                     for="{{item?.field}}"
+                     (click)="$event.stopPropagation()">{{item?.title|dmxTranslate}}</label>
             </div>
           </kendo-popup>
         </div>
       </div>
     </div>
 
+    <!-- CONFIGURATION GROUPS GRID -->
     <div class="row flex-grow-1 position-relative mr-overflow">
-      <kendo-grid #configGroupsGrid [data]="filteredConfigGroups" [skip]="skip"  [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="false" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortConfigGroups" (sortChange)="sortConfigGroupsChange($event)" class="grid-full-height" (selectionChange)="onConfigGroupSelectionChange($event)" (columnReorder)="columnReordered($event)" kendoGridSelectBy="configurationGroupId" [(selectedKeys)]="configGroupSelectedKeys" (columnResize)="columnResize($event)">
+      <kendo-grid [data]="filteredConfigGroups" [skip]="skip"  [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="true" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortConfigGroups" (sortChange)="sortConfigGroupsChange($event)" class="grid-full-height" (selectionChange)="onConfigGroupSelectionChange($event)" (columnReorder)="columnReordered($event)" kendoGridSelectBy="configurationGroupId" [(selectedKeys)]="configGroupSelectedKeys" (columnResize)="columnResize($event)">
 
         <!--Config Groups Text Filter-->
         <ng-template kendoGridToolbarTemplate>
@@ -276,22 +269,28 @@
                 style="background-color: transparent; border: none;">
         </button>
       </div>
-      <kendo-popup #popup class="popup-column-chooser" *ngIf="showGridConfigAssetsColumns" [anchor]="assetsColumnChooserButton" (anchorViewportLeave)="showGridConfigAssetsColumns = false" [animate]="false" [anchorAlign]="anchorAlign" [popupAlign]="popupAlign">
-        <div cdkDropList (cdkDropListDropped)="dropAssets($event)" class="column-chooser-list popup-column-chooser-scroll" style="white-space: nowrap;">
-          <div class="wrap d-flex align-items-center" *ngFor="let item of configAssetsColumnsOrdered; let i = index; trackBy: trackByField" role="menuitem" cdkDrag>
-            <input type="checkbox" id="{{item?.field}}" class="k-checkbox"
-                  [checked]="!item?.hidden"
-                  [disabled]="item?.locked"
-                  (click)="assetsColumnVisibilityChanged(item)" />
-            <label class="k-checkbox-label flex-grow-1 mb-0"
-                  for="{{item?.field}}"
-                  (click)="$event.stopPropagation()">{{item?.title|dmxTranslate}}</label>
-            
-            <div class="ml-2 mr-2">
-              <span class="column-chooser-drag-handle hand-cursor" cdkDragHandle 
-                    [class.disabled]="item?.locked" 
-                    style="font-size: 18px; color: #888;">☰</span>
-            </div>
+      <kendo-popup #popup class="popup-column-chooser"
+                   *ngIf="showGridConfigAssetsColumns"
+                   [anchor]="assetsColumnChooserButton"
+                   (anchorViewportLeave)="showGridConfigAssetsColumns = false"
+                   [anchorAlign]="anchorAlign"
+                   [popupAlign]="popupAlign"
+                   style="width: auto;">
+        <div class="popup-column-chooser-scroll" style="white-space: nowrap;">
+          <div class="wrap"
+               *ngFor="let item of configAssetsColumnsOrdered; let i = index"
+               role="menuitem">
+            <input type="checkbox"
+                   id="{{item?.field}}"
+                   class="k-checkbox"
+                   [checked]="!item?.hidden"
+                   [disabled]="item?.locked"
+                   (click)="assetsColumnVisibilityChanged(item)" />
+            <label class="k-checkbox-label"
+                   for="{{item?.field}}"
+                   (click)="$event.stopPropagation()">
+              {{item?.title|dmxTranslate}}
+            </label>
           </div>
         </div>
       </kendo-popup>
@@ -301,7 +300,7 @@
 
 <!-- ASSETS PANEL GRID -->
 <div class="row flex-grow-1 position-relative">
-  <kendo-grid #assetsGrid [data]="filteredAssets" [skip]="skip" [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="false" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortAssets" (sortChange)="sortAssetsChange($event)" class="grid-full-height" (selectionChange)="onAssetSelectionChange($event)" (columnReorder)="assetsColumnReordered($event)" kendoGridSelectBy="assetId" [(selectedKeys)]="assetSelectedKeys" (excelExport)="onExcelExportAssets($event)" [pageable]="true" [singlepage]="true" (columnResize)="assetColumnResize($event)" [rowClass]="fwOldVersionHighlightRowClassFn">
+  <kendo-grid #assetsGrid [data]="filteredAssets" [skip]="skip" [selectable]="{enabled: true, checkboxOnly: true}" [resizable]="true" [reorderable]="true" [sortable]="{mode: 'single',initialDirection: 'asc',allowUnsort: false}" [sort]="sortAssets" (sortChange)="sortAssetsChange($event)" class="grid-full-height" (selectionChange)="onAssetSelectionChange($event)" (columnReorder)="assetsColumnReordered($event)" kendoGridSelectBy="assetId" [(selectedKeys)]="assetSelectedKeys" (excelExport)="onExcelExportAssets($event)" [pageable]="true" [singlepage]="true" (columnResize)="assetColumnResize($event)" [rowClass]="fwOldVersionHighlightRowClassFn">
 
     <!--Assets Text Filter-->
     <ng-template kendoGridToolbarTemplate>
diff --git a/src/app/configgroups/configgroups.component.ts b/src/app/configgroups/configgroups.component.ts
index 71312f8..fdb4221 100644
--- a/src/app/configgroups/configgroups.component.ts
+++ b/src/app/configgroups/configgroups.component.ts
@@ -65,7 +65,6 @@ import { ISimpleFileTransferBase64 } from '../shared/hypermedia/simple-file-tran
 import { DownloadService } from '../shared/download.service';
 import { IColumn } from './models/grid/column.interface';
 import { ILink } from './models/grid/link.interface';
-import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
 
 export enum Modal {
   mesa
@@ -202,7 +201,6 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
 //, AfterViewInit
 {
   @ViewChild("assetsGrid", { static: false }) assetsGrid: GridComponent;
-  @ViewChild("configGroupsGrid", { static: false }) configGroupsGrid: GridComponent;
   @ViewChild("configGroupsColumnChooserButton") public configGroupsColumnChooserButton: ElementRef;
   @ViewChild("assetsColumnChooserButton") public assetsColumnChooserButton: ElementRef;
   @ViewChild('assetsDropdown') assetsDropdown: any;
@@ -223,7 +221,6 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
   assetsMoveErrorMessage: string;
   columns: IColumn[] = [];
   organisationId: string;
-  configGroupId: string;
   configGroupIds: string[] = [];
   iFrameMessage: string;
   sidebarSize = '50%';
@@ -929,11 +926,8 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
       this.gridSelectionCriteriaService.getSelectedConfigGroups(SelectionCriteriaKeys.selectedConfigGroups + this.organisationId)
         .pipe(takeWhile(() => this.alive))
         .subscribe((data: string) => {
-          // Check query params first
-          if (this.configGroupId) {
-            this.configGroupSelectedKeys = [this.configGroupId];
-            this.loadConfigAssets();
-          } else if (data) {
+          if(data)
+          {
             // If selected group ids value doesn't match a pattern - empty the selection
             const regex = /^-?\d+(,-?\d+)*$/;
             this.configGroupSelectedKeys = regex.test(data) ? data.split(',') : [];
@@ -2232,7 +2226,6 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
     //console.log("FR UI: onMessageReceived: " + JSON.stringify(msg, null, 2));
     //This is where the authToken gets sent in from the OLD UI
     this.organisationId = msg.data.message.data.organisationId;
-    this.configGroupId = msg.data.message.data.configGroupId;
     //console.log("Org in Frangular: " + this.organisationId);
     this.xAuth = msg.data.xAuth;
     this.sessionService.setAuthToken(msg.data.xAuth).pipe(takeWhile(() => this.alive))
@@ -3670,92 +3663,7 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
 
     //Save to selection criteria
     column = new ColumnReorderEvent({ column: column.column, newIndex: column.newIndex, oldIndex: column.oldIndex });
-    this.gridSelectionCriteriaService.changeColumnOrdering(SelectionCriteriaKeys.assetsColumnSettings, this.assetsColumnSettings, column, 1, this.assetsColumns.length);
-  }
-
-  dropConfigGroups(event: CdkDragDrop<any[]>): void {
-    if (event.previousIndex === event.currentIndex) return;
-
-    // Create the new order
-    const newOrder = [...this.configGroupsColumnsOrdered];
-    moveItemInArray(newOrder, event.previousIndex, event.currentIndex);
-
-    // Persist the change
-    this.reorderManual(
-      this.configGroupsColumnsOrdered,
-      event.previousIndex,
-      event.currentIndex,
-      'configGroups'
-    );
-
-    // Update the UI reference
-    this.configGroupsColumnsOrdered = newOrder;
-  }
-
-  dropAssets(event: CdkDragDrop<any[]>): void {
-    if (event.previousIndex === event.currentIndex) return;
-
-    // Create the new order
-    const newOrder = [...this.configAssetsColumnsOrdered];
-    moveItemInArray(newOrder, event.previousIndex, event.currentIndex);
-
-    // Persist the change
-    this.reorderManual(
-      this.configAssetsColumnsOrdered,
-      event.previousIndex,
-      event.currentIndex,
-      'assets'
-    );
-
-    // Update the UI reference
-    this.configAssetsColumnsOrdered = newOrder;
-  }
-
-  // Keeps track of each field to not loose eg. checked
-  trackByField(index: number, item: any): string {
-    return item.field;
-  }
-  
-  moveColumnUp(index: number, gridType: string) {
-    if (index === 0) return;
-    const columns = gridType === 'configGroups' ? this.configGroupsColumnsOrdered : this.configAssetsColumnsOrdered;
-    this.reorderManual(columns, index, index - 1, gridType);
-  }
-
-  moveColumnDown(index: number, gridType: string) {
-    const columns = gridType === 'configGroups' ? this.configGroupsColumnsOrdered : this.configAssetsColumnsOrdered;
-    if (index === columns.length - 1) return;
-    this.reorderManual(columns, index, index + 1, gridType);
-  }
-
-  private reorderManual(columns: IColumn[], popupOldIndex: number, popupNewIndex: number, gridType: string) {
-    const item = columns[popupOldIndex];
-
-    const gridOldIndex = popupOldIndex + 1;
-    const gridNewIndex = popupNewIndex + 1;
-
-    //Good way to debug indexes
-    //console.log(`Moving ${item.field} from ${gridOldIndex} to ${gridNewIndex}`);
-
-    const event = new ColumnReorderEvent({
-      column: { field: item.field } as any,
-      newIndex: gridNewIndex,
-      oldIndex: gridOldIndex
-    });
-
-    if (gridType === 'configGroups') {
-      this.gridSelectionCriteriaService.changeColumnOrdering(SelectionCriteriaKeys.configGroupsColumnSettings, this.configGroupsColumnSettings, event, 1, this.configGroupsColumns.length);
-      this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(this.configGroupsGrid, this.configGroupsColumnSettings);
-    } else {
-      this.gridSelectionCriteriaService.changeColumnOrdering(SelectionCriteriaKeys.assetsColumnSettings, this.assetsColumnSettings, event, 1, this.assetsColumns.length);
-      this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(this.assetsGrid, this.assetsColumnSettings);
-    }
-
-    if (gridType === 'configGroups') {
-      this.setupConfigGroupsGrid();
-    } else {
-      this.setupConfigAssetsGrid();
-    }
+    this.gridSelectionCriteriaService.changeColumnOrdering(SelectionCriteriaKeys.assetsColumnSettings, this.assetsColumnSettings, column, 0, this.assetsColumns.length);
   }
 
   assetColumnResize(columnResizeEvent: ColumnResizeArgs[]) {
@@ -3799,9 +3707,7 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
 
         this.configGroupsHiddenColumns = gridColumnData.hiddenColumns;
         this.setupConfigGroupsGrid();
-        if (this.configGroupsGrid) {
-          this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(this.configGroupsGrid, this.configGroupsColumnSettings);
-        }
+
       }, () => this.setupConfigGroupsGrid());
   }
 
@@ -3819,9 +3725,7 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
 
         this.configAssetsHiddenColumns = gridColumnData.hiddenColumns;
         this.setupConfigAssetsGrid();
-        if (this.assetsGrid) {
-          this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(this.assetsGrid, this.assetsColumnSettings);
-        }
+
         this.loadSpinnerAssets = false;
 
       }, () => this.setupConfigAssetsGrid());
@@ -3866,11 +3770,6 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
     //console.log("configGroupColumn done");
     this.configGroupsColumnsOrdered = [];
     this.configGroupsColumnsOrdered.push(...this.configGroupsColumns);
-
-    // Filter out undefined and maintain grid order
-    this.configGroupsColumnsOrdered = this.configGroupsColumnsOrdered.filter(c => c !== undefined);
-
-    /* Shawn recommendation: maintain grid order in chooser
     this.configGroupsColumnsOrdered.sort((columnA, columnB) => {
       const titleA = columnA.title.toLowerCase();
       const titleB = columnB.title.toLowerCase();
@@ -3881,7 +3780,6 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
       }
       return 0;
     });
-    */
   }
 
   private setupConfigAssetsGrid() {
@@ -3933,11 +3831,6 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
     //console.log("configAssetsColumn done");
     this.configAssetsColumnsOrdered = [];
     this.configAssetsColumnsOrdered.push(...this.assetsColumns);
-
-    // Filter out undefined and maintain grid order
-    this.configAssetsColumnsOrdered = this.configAssetsColumnsOrdered.filter(c => c !== undefined);
-
-    /* Shawn recommendation: maintain grid order in chooser
     this.configAssetsColumnsOrdered.sort((columnA, columnB) => {
       const titleA = columnA.title.toLowerCase();
       const titleB = columnB.title.toLowerCase();
@@ -3948,7 +3841,6 @@ export class ConfiggroupsComponent implements OnInit, OnDestroy
       }
       return 0;
     });
-    */
   }
 
 

```

## PR

- [x] COmmented on story ✅ 2026-02-04
