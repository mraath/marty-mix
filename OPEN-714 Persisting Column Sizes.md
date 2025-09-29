---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-29T11:37
---

# OPEN-714 Persisting Column Sizes

Date: 2025-09-23 Time: 11:24
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-09-23]]
JIRA:OPEN-714 Persisting Column Sizes
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-714)

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


## SP 2

### FE
- [ ] Task 1
      PR: xxxxxxxxxx

### BE
- [ ] Task 1
      PR: xxxxxxxxxx

### DB
- [ ] Task 1
      PR: xxxxxxxxxx


## Notes

https://selectioncriteria.intss.mixdevelopment.com/api/selectioncriteria/query?datacentre=DEV
	dictionaries
		configGroupsColumnWidths
			  0: {key: "sp", value: "200"}
		configGroupsColumnOrder
			0: {key: "sp", value: "14"}

https://selectioncriteria.intss.mixdevelopment.com/api/selectioncriteria/query?datacentre=DEV
	configAssetsColumnWidths
		0: {key: "sp", value: "200"}
	configAssetsColumnOrder
		0: {key: "sp", value: "27"}

https://selectioncriteria.intss.mixdevelopment.com/api/selectioncriteria/update?datacentre=DEV
	Payload: configAssetsColumnWidths, configAssetsColumnOrder

Upbove is the update.... so width is on the payload - so SHOULD save it.... so just add the persisting part....
CALLING update on column width change

- [ ] Add an OnColumnWidthChanged (something like that)

## Adding Column Resize Event

```
<kendo-grid (columnResize)="columnResize($event)">

import { ColumnResizeArgs } from "@progress/kendo-angular-grid";

columnResize(columnResizeEvent: ColumnResizeArgs[]) {
	this.gridSelectionCriteriaService.changeColumnWidth(SelectionCriteriaKeys.configGroupsColumnSettings, this.configGroupsColumnSettings, columnResizeEvent);
}
```

## Local Test

![[OPEN-714 Persisting Column Sizes Result1.png]]
![[OPEN-714 Persisting Column Sizes Widths.png]]


## Testing

Local CG
	https://selectioncriteria.intss.mixdevelopment.com/api/selectioncriteria/update?datacentre=DEV
	It is persisting, now just to read it....

## Reading the column width

### According to Shawn

@Richard Hobson They are using some logic to set column widths, i.e. `[width]="getColumWidth(col?.field, ‘assets') || 150"`  
  
We will need to understand what they’re currently doing and how the width get’s calculated as to see what happens when columns are added/hidden. The 150px looks like a fallback but I’m not sure what has been done in terms of dynamic widths. Will need to setup a call with a developer.

```
<kendo-grid-column *ngFor="let col of assetsColumns;" [field]="col?.field" title="{{col?.title|dmxTranslate}}"
                       [hidden]="col?.hidden" [width]="getColumWidth(col?.field, 'assets') || 150">
                       
<kendo-grid-column *ngFor="let col of configGroupsColumns;" [field]="col?.field" title="{{col?.title|dmxTranslate}}"
                           [hidden]="col?.hidden" [width]="getColumWidth(col?.field, 'configGroups') || 150">
```


configGroupsColumnSettings

## NEXT I see some blank cols....

configGroupsColumns
assetsColumns

## Possible width fix

scrollable="none"
NO
## Branch

> Branch: Config/MR/Feature/OPEN-714 Persisting Column Sizes.INT

