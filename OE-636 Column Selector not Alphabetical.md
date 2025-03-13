---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-13T16:00
---

# OE-636 Column Selector not Alphabetical

Date: 2025-03-13 Time: 15:43
Parent:: [[OE-513]]
Friend:: [[2025-03-13]]
JIRA:OE-636 Column Selector not Alphabetical
[[OE-636] Column selection list: alphabetical order revision - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-636)


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

## Shorter Description

![[OE-636 Column Selector not Alphabetical CG.png]]
![[OE-636 Column Selector not Alphabetical Assets1.png]]
![[OE-636 Column Selector not Alphabetical Assets2.png]]

## Findings

- onToggleGridConfigGroupColumns
	- configGroupsColumnsOrdered
- onToggleGridConfigAssetsColumns
	- configAssetsColumnsOrdered

