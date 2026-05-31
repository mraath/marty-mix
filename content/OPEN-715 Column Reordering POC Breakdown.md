---
wiki_ingested: 2026-05-28
created: 2026-03-09T00:00
updated: 2026-03-09T16:33
---

# OPEN-715 Column Reordering POC Breakdown

Date: 2026-03-09
Parent:: [[OPEN-997 New Column Reordering]]
JIRA:: [OPEN-715](https://powerfleet.atlassian.net/browse/OPEN-715) | [OPEN-997](https://powerfleet.atlassian.net/browse/OPEN-997)
Friend:: [[2026-03-09]]

**Branch:** `Config/MR/Feature/OPEN-997_NewColumnReordering.INT`
**Repo:** `MiX.Config.Frangular.UI`
**Files changed:** `package.json`, `app.module.ts`, `configgroups.component.html`, `configgroups.component.ts`

---

## ASCII Wireframe — What Changed in the UI

**Before (integration — no reordering):**
```
┌─────────────────────────────────┐
│  [☑] Column Chooser Button      │
└─────────────────────────────────┘
         │
         ▼
┌──────────────────────────────────────┐
│  COLUMN CHOOSER POPUP                │
│  ┌────────────────────────────────┐  │
│  │ [✓]  Vehicle Name             │  │
│  │ [✓]  Registration             │  │
│  │ [ ]  Driver                   │  │
│  │ [✓]  Speed                    │  │
│  └────────────────────────────────┘  │
│  (No way to reorder — just show/hide)│
└──────────────────────────────────────┘

GRID: [reorderable]="true"  ← user can drag columns on the grid directly
```

**After (POC branch — with drag-drop reordering):**
```
┌─────────────────────────────────┐
│  [☑] Column Chooser Button      │
└─────────────────────────────────┘
         │
         ▼
┌──────────────────────────────────────┐
│  COLUMN CHOOSER POPUP                │
│  ┌────────────────────────────────┐  │
│  │ [✓]  Vehicle Name        ☰   │  │◄── drag handle (cdkDragHandle)
│  │ [✓]  Registration        ☰   │  │
│  │ [ ]  Driver              ☰   │  │
│  │ [✓]  Speed               ☰   │  │
│  └────────────────────────────────┘  │
│  (Drag rows up/down to reorder)      │
└──────────────────────────────────────┘
            │
            ▼
   Drag fires dropConfigGroups()
   or dropAssets() handler
            │
            ▼
   reorderManual() called
            │
      ┌─────┴───────┐
      ▼             ▼
changeColumnOrdering()  reorderGridColumnsOnStartup()
(persists to         (physically moves the columns
 selection criteria)  in the Kendo grid)

GRID: [reorderable]="false" ← forced to use popup only
```

---

## Plain English — What Changed and Why

**The problem:** Users had no way to change the order of columns except by dragging them directly in the grid. The column chooser popup only let you show/hide columns, not reorder them.

**What the POC added:** Three capabilities, all wired together:

1. **Drag handles in the popup** — A ☰ hamburger icon appeared next to each column in the column chooser popup. You could grab it and drag the row up or down within the popup list.

2. **Live grid reordering** — When you dropped the row in a new position, the grid's actual columns moved to match. This was done by constructing a fake `ColumnReorderEvent` and passing it to the existing persistence service.

3. **Persistence** — The new order was saved to the selection criteria (the existing backend mechanism the app already used for remembering column visibility and sort). So when you refreshed or came back later, the order was restored.

**The grid was also locked** (`[reorderable]="false"`) so users could only reorder through the popup — keeping the two sources of truth in sync.

**The key trick** was that the drag-drop index in the popup is offset by 1 from the grid column index (because the grid has a hidden first column for checkboxes), so the code always added 1 when translating popup positions to grid positions.

---

## The Moving Parts

| Part | What it does |
|---|---|
| `@angular/cdk` + `DragDropModule` | Provides the drag-drop capability |
| `cdkDropList` on the popup wrapper | Makes the popup a drag-drop container |
| `cdkDrag` on each row | Makes each column row draggable |
| `cdkDragHandle` on the ☰ icon | Restricts dragging to only the handle |
| `trackByField()` | Prevents Angular from losing checkbox state when rows move |
| `dropConfigGroups()` / `dropAssets()` | Catches the drop event, gets old/new indexes |
| `reorderManual()` | Translates popup indexes → grid indexes, builds fake event, calls persist |
| `changeColumnOrdering()` (existing service) | Saves new order to selection criteria |
| `reorderGridColumnsOnStartup()` (existing service) | Applies persisted order to the Kendo grid |
| `setupConfigGroupsGrid()` / `setupConfigAssetsGrid()` | Rebuilds the popup list to reflect new order |

---

## The Code — Section by Section

### 1. New dependency added

```json
// package.json
// Angular CDK (Component Dev Kit) — provides drag-drop primitives
"@angular/cdk": "^12.2.13",
```

---

### 2. DragDropModule wired into Angular

```typescript
// app.module.ts
// Import the CDK drag-drop module so it's available in templates
import { DragDropModule } from '@angular/cdk/drag-drop';

@NgModule({
  imports: [
    // ...existing imports...
    DragDropModule   // ← added to NgModule
  ]
})
```

---

### 3. HTML — Config Groups popup (column chooser gets drag-drop)

```html
<!-- configgroups.component.html -->

<!--
  The popup wrapper div becomes a drop ZONE.
  (cdkDropListDropped) fires when the user releases a dragged item.
  "column-chooser-list" is a CSS class for styling.
-->
<div cdkDropList (cdkDropListDropped)="dropConfigGroups($event)" class="column-chooser-list">

  <!--
    Each row is now a draggable item (cdkDrag).
    trackBy: trackByField prevents Angular from losing checkbox state on re-render.
  -->
  <div class="wrap d-flex align-items-center"
       *ngFor="let item of configGroupsColumnsOrdered; let i = index; trackBy: trackByField"
       role="menuitem"
       cdkDrag>

    <input type="checkbox" id="{{item?.field}}" class="k-checkbox"
           [checked]="!item?.hidden"
           [disabled]="item?.locked"
           (click)="columnVisibilityChanged(item)" />

    <label class="k-checkbox-label flex-grow-1 mb-0"
           for="{{item?.field}}"
           (click)="$event.stopPropagation()">{{item?.title|dmxTranslate}}</label>

    <!--
      The grab handle (☰ hamburger). cdkDragHandle restricts dragging to this icon only.
      Locked columns get a 'disabled' CSS class so they appear greyed out.
    -->
    <div class="ml-2">
      <span class="column-chooser-drag-handle hand-cursor"
            cdkDragHandle
            [class.disabled]="item?.locked"
            style="font-size: 18px; color: #888;">☰</span>
    </div>

  </div>
</div>
```

---

### 4. HTML — Config Assets popup (same pattern, Assets grid)

```html
<!-- configgroups.component.html — the assets panel column chooser -->

<!-- Same drag-drop structure for the assets grid column chooser -->
<div cdkDropList (cdkDropListDropped)="dropAssets($event)"
     class="column-chooser-list popup-column-chooser-scroll"
     style="white-space: nowrap;">

  <div class="wrap d-flex align-items-center"
       *ngFor="let item of configAssetsColumnsOrdered; let i = index; trackBy: trackByField"
       role="menuitem"
       cdkDrag>

    <input type="checkbox" id="{{item?.field}}" class="k-checkbox"
           [checked]="!item?.hidden"
           [disabled]="item?.locked"
           (click)="assetsColumnVisibilityChanged(item)" />

    <label class="k-checkbox-label flex-grow-1 mb-0"
           for="{{item?.field}}"
           (click)="$event.stopPropagation()">
      {{item?.title|dmxTranslate}}
    </label>

    <div class="ml-2 mr-2">
      <span class="column-chooser-drag-handle hand-cursor"
            cdkDragHandle
            [class.disabled]="item?.locked"
            style="font-size: 18px; color: #888;">☰</span>
    </div>

  </div>
</div>
```

---

### 5. HTML — Grids locked to popup-only reordering

```html
<!-- Config Groups grid: reorderable="false" — user can no longer drag columns directly on the grid -->
<kendo-grid #configGroupsGrid
            [reorderable]="false"
            ...>

<!-- Assets grid: same — forces all reordering through the popup -->
<kendo-grid #assetsGrid
            [reorderable]="false"
            ...>
```

---

### 6. TypeScript — Imports and ViewChild

```typescript
// configgroups.component.ts

// CDK drag-drop types needed for the drop handler
import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';

// Need a reference to the config groups grid so we can programmatically reorder its columns
@ViewChild("configGroupsGrid", { static: false }) configGroupsGrid: GridComponent;
// (assetsGrid ViewChild already existed)
```

---

### 7. TypeScript — Drop handler for Config Groups

```typescript
// Fires when the user drops a dragged row in the popup.
// event.previousIndex = where it came from, event.currentIndex = where it landed.
dropConfigGroups(event: CdkDragDrop<any[]>): void {
  if (event.previousIndex === event.currentIndex) return; // nothing moved

  // Build the new order for the popup list
  const newOrder = [...this.configGroupsColumnsOrdered];
  moveItemInArray(newOrder, event.previousIndex, event.currentIndex);

  // Persist + move the actual grid columns
  this.reorderManual(
    this.configGroupsColumnsOrdered,
    event.previousIndex,
    event.currentIndex,
    'configGroups'
  );

  // Update the popup list reference
  this.configGroupsColumnsOrdered = newOrder;
}
```

---

### 8. TypeScript — Drop handler for Assets

```typescript
// Same pattern as dropConfigGroups, but for the assets grid
dropAssets(event: CdkDragDrop<any[]>): void {
  if (event.previousIndex === event.currentIndex) return;

  const newOrder = [...this.configAssetsColumnsOrdered];
  moveItemInArray(newOrder, event.previousIndex, event.currentIndex);

  this.reorderManual(
    this.configAssetsColumnsOrdered,
    event.previousIndex,
    event.currentIndex,
    'assets'
  );

  this.configAssetsColumnsOrdered = newOrder;
}
```

---

### 9. TypeScript — trackByField (keeps checkboxes stable)

```typescript
// Without trackBy, Angular destroys and recreates each DOM row when the array changes.
// This would cause checkboxes to lose their state mid-drag.
// By tracking by field name, Angular reuses the existing DOM elements.
trackByField(index: number, item: any): string {
  return item.field;
}
```

---

### 10. TypeScript — The core reorderManual logic

```typescript
// Called by both the drag-drop handlers AND the up/down chevron buttons (earlier POC version).
// popupOldIndex / popupNewIndex = positions in the popup list (0-based)
// Grid columns are offset by +1 because index 0 in the grid is the hidden checkbox column.
private reorderManual(columns: IColumn[], popupOldIndex: number, popupNewIndex: number, gridType: string) {
  const item = columns[popupOldIndex];
  if (item.locked) return; // locked columns can't be moved

  // Translate popup index → grid column index (offset by 1 for the checkbox column)
  const gridOldIndex = popupOldIndex + 1;
  const gridNewIndex = popupNewIndex + 1;

  // Good way to debug indexes:
  // console.log(`Moving ${item.field} from ${gridOldIndex} to ${gridNewIndex}`);

  // Build a fake ColumnReorderEvent — the existing persistence service expects this format
  const event = new ColumnReorderEvent({
    column: { field: item.field } as any,
    newIndex: gridNewIndex,
    oldIndex: gridOldIndex
  });

  if (gridType === 'configGroups') {
    // 1. Persist the new order to selection criteria
    this.gridSelectionCriteriaService.changeColumnOrdering(
      SelectionCriteriaKeys.configGroupsColumnSettings,
      this.configGroupsColumnSettings,
      event, 1, this.configGroupsColumns.length
    );
    // 2. Physically reorder the Kendo grid columns to match
    this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(
      this.configGroupsGrid, this.configGroupsColumnSettings
    );
  } else {
    this.gridSelectionCriteriaService.changeColumnOrdering(
      SelectionCriteriaKeys.assetsColumnSettings,
      this.assetsColumnSettings,
      event, 1, this.assetsColumns.length
    );
    this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(
      this.assetsGrid, this.assetsColumnSettings
    );
  }

  // Rebuild the popup list so it reflects the new order
  if (gridType === 'configGroups') {
    this.setupConfigGroupsGrid();
  } else {
    this.setupConfigAssetsGrid();
  }
}
```

---

### 11. TypeScript — Reapply saved order on load

```typescript
// After fetching column settings from the backend on page load,
// apply the previously persisted column order to the Kendo grid.
// Without this, the grid always starts in default order even if the user had reordered it.

// Config Groups:
this.configGroupsHiddenColumns = gridColumnData.hiddenColumns;
this.setupConfigGroupsGrid();
if (this.configGroupsGrid) {
  this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(
    this.configGroupsGrid, this.configGroupsColumnSettings
  );
}

// Assets:
this.configAssetsHiddenColumns = gridColumnData.hiddenColumns;
this.setupConfigAssetsGrid();
if (this.assetsGrid) {
  this.gridSelectionCriteriaService.reorderGridColumnsOnStartup(
    this.assetsGrid, this.assetsColumnSettings
  );
}
```

---

### 12. TypeScript — setupConfigGroupsGrid / setupConfigAssetsGrid

```typescript
// When rebuilding the popup list, filter out undefined entries
// and maintain the grid's actual current column order (don't sort alphabetically).
private setupConfigGroupsGrid() {
  this.configGroupsColumnsOrdered = [];
  this.configGroupsColumnsOrdered.push(...this.configGroupsColumns);

  // Remove any undefined slots (can appear when columns are dynamically added/removed)
  this.configGroupsColumnsOrdered = this.configGroupsColumnsOrdered.filter(c => c !== undefined);

  // NOTE: Shawn's recommendation was to NOT sort alphabetically here,
  // so that the popup reflects the actual current grid column order.
  // The old alphabetical sort was commented out.
}
```

---

## Summary of All Changed Files

```
package.json                         ← added @angular/cdk
app.module.ts                        ← imported DragDropModule
configgroups.component.html          ← added cdkDropList/cdkDrag/cdkDragHandle to both
                                        column chooser popups; set reorderable=false on grids
configgroups.component.ts            ← added CdkDragDrop import, ViewChild for configGroupsGrid,
                                        dropConfigGroups(), dropAssets(), trackByField(),
                                        moveColumnUp/Down(), reorderManual(),
                                        reorderGridColumnsOnStartup() calls on load,
                                        filter(undefined) in setupGrid methods
```
