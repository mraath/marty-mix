---
wiki_ingested: 2026-05-28
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-18T08:20
---

# OE-636 Column Selector not Alphabetical

Date: 2025-03-13 Time: 15:43
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
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

It as because of the Upper Case in the word.
I have forced the sorting to ignore case.

[Pull request 121281: OE-636: Column Chooser sorting fixed - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/121281)
