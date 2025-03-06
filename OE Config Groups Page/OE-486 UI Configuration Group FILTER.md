---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-07-05T09:07
---

# OE-486

Date: 2024-01-25 Time: 15:23
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-01-25]]
JIRA:OE-486
[URL TO JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-486)

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

## Image Summary

![[OE-486 UI Configuration Group FILTER.png]]

## Description

![[OE-501 SPIKE to create the multi-select config groups NEW NEW look.png]]

### CONFIGURATION GROUPS

- [x] Header in bold: Configuration groups ✅ 2024-07-02
- [x] To the right of this is a count of all the configuration groups in the org ✅ 2024-07-02
- [x] To the right of this is an actions dropdown which only becomes available once the user has selected a configuration group (The actions buttons' functionality will be handled in another story, this is just to implement the button) ✅ 2024-07-02

### Filter by Mobile device

- [x] When this is selected display the list of available mobile devices ✅ 2024-07-05
- [x] The user can select more than one ✅ 2024-07-05
- [x] Once selected filter the configuration groups based on the selected filter ✅ 2024-07-05

- [x] Below this is a free text filter box ✅ 2024-07-05
- [x] Fix Selected rows, CG + Assets (as add, remove, hide, show rows) ✅ 2024-07-05

### Free text filter

- Users should be able to enter 255 characters  (NA)
- [x] Search on all cells ✅ 2024-07-05
Below this is the list of configuration groups (Implemented in another story)

### Further Information

- Tip: Have some variables in place in the controller for (eg. Lists: all config groups, display groups, selected groups)
	- All list will contain all Config groups 
    - Display list will contain those shown due to the filters
    - Selected list will contain those Config Groups the user actually clicked on (done in another story)
- FYI, how the selection of Config Groups will work (handled in another story)
    - If no filters have been set, display all config groups.
    - Config groups selected in the list below will ALWAYS stay selected until you manually deselect them.
    

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

- [x]  ✅ 2024-02-05
