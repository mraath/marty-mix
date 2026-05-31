---
wiki_ingested: 2026-05-28
created: 2025-12-03T13:24
updated: 2025-12-05T11:16
---

## Intro

Ashley needed to language the "items selected"

![[Pasted image 20251203132906.png|700]]

## Code

### HTML

In the HTML, ensure that this kendo-multiselect has the [tagMapper]="tagMapper"
(It should, but just double check) 

### TS

In the ts file change the tagMapper function

```ts
tagMapper = (tags: any[]): any[] => {
    if (tags.length > 1) {
      return [{
        text: `${tags.length} ${this.itemsSelected}`,
        value: tags
      }];
    }
    return tags;
};

//You also need to declare the itemsSelected and get the languaged value of it....

//Declare it at the top of the TS file
itemsSelected: string = 'items selected'; //Ask PO if it should be 'item(s) selected' to handle the singular, then also add in the correct POT file

//Assign it, I do it where config groups get called.... seeing this only happens once per page and by then the languaging works
getConfigGroups() {
	//...
    this.itemsSelected = this.languageService.translate('items selected');
```

### POT

Just add the string in the correct POT file.... 
First speak to the PO re: if it should be 'item(s) selected' or singular

'item selected';
'items selected';

## Test

Just test it for all the multiselect elements