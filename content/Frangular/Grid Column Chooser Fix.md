---
created: 2024-11-05T09:59
updated: 2024-11-05T10:11
---
## Grid Column Chooser issue

I had a problem where the column chooser will move out of the grid if the scroller got activated. This would cause very unappealing UI experiences. The below logic hides the popup when the column selector moves out of focus or if you click somewhere else.

## HTML

```html
<div class="text-right">
	<button 
		#configGroupsColumnChooserButton <!--Removed what's not needed for eg--> 
	>
	</button>
	<kendo-popup 
		*ngIf="showColumnChooser" 
		[anchor]="configGroupsColumnChooserButton" 
		[anchorAlign]="anchorAlign" 
		[popupAlign]="popupAlign">
		<div>
			<!--Removed what's not needed for eg-->
		</div>
	</kendo-popup>
</div>
```

## Typescript

```typescript
@ViewChild("configGroupsColumnChooserButton") public configGroupsColumnChooserButton: ElementRef;

anchorAlign: Align = { horizontal: "right", vertical: "bottom" };
popupAlign: Align = { horizontal: "right", vertical: "top" };

@HostListener("document:click", ["$event.target"])
public documentClick(targetElement: HTMLElement): void {
	if (!targetElement) {
		return;
	}

	const clickedOnConfigGroupsColumnChooser = this.configGroupsColumnChooserButton?.nativeElement?.contains(targetElement);
	if (this.showGridConfigGroupColumns && !clickedOnConfigGroupsColumnChooser) {
		this.showGridConfigGroupColumns = false;
		return;
	}
}
```

