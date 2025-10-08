---
created: 2025-10-08T07:28
updated: 2025-10-08T08:09
---

## Introduction

We sometimes need a method to persist user selections between sessions. The mechanism we use is the **selection criteria**. Examples would be persisting selected columns, column widths, etc. 
I will explain the basics of doing this in this article.

## Example: persisting column width

Column widths is not the most simple example, however, this is the last one I worked on and I should be able to remember what I did :-)

This example can therefore be simplified to your needs, but here it goes.

### Need

When the user changes column widths for the Config Groups Panel within the Configuration Groups (BETA) page.  This needs to be persisted between sessions and page changes.

### Mechanism

We make use of the Selection Criteria. 
The selection criteria will need a **key** to persist these values, it will also need a **class** which will specify eg. column names and widths.

### HTML

![[Persisting Values via the Selection Criteria Column Resize Example.png]]

### TS file

Whenever the width changes save that to Selection Criteria by using the Settings you specified.

In this instance there is a method on the Selection Criteria service. You will need to see if this is something you can re-use or (highly unlikely) you will need to write a new method.

For persisting you will need: 
- a method to **get** your values and 
- a method to **update** the values


#### Updating the vaues

```ts
columnResize(columnResizeEvent: ColumnResizeArgs[]) {
	this.gridSelectionCriteriaService.changeColumnWidth(SelectionCriteriaKeys.configGroupsColumnSettings, this.configGroupsColumnSettings, columnResizeEvent);
}
```

Above you can see the two 
#### Getting the values

