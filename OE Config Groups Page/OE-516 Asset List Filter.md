---
created: 2023-03-27T07:35
updated: 2024-07-09T14:25
status: busy
comment: 
priority: 1
---

# OE-516 Asset List Filter

Date: 2024-07-05 Time: 09:14
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-07-05]]
JIRA:OE-516 Asset List Filter
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-516)

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

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Description

Please see the parent story to know how this fits into the bigger picture.

- [x] Header: Assets ✅ 2024-07-05
- [x] To the right of this is an asset count ✅ 2024-07-05
- [x] As the user selects config groups on the left panel it should load the assets in order on the Assets screen ✅ 2024-07-05
- [x] Do the All, Visible, Filtered rows ✅ 2024-07-08
### Filter by Config status

- [x] When this is selected display the list of available configuration statuses ✅ 2024-07-05
- [x] The user can select more than one ✅ 2024-07-05
- [x] Once selected filter the assets based on the selected filter ✅ 2024-07-08

### Filter by FW version

- [x] When this is selected display the list of available FW versions ✅ 2024-07-05
- [x] The user can select more than one ✅ 2024-07-05
- [x] Once selected filter the assets based on the selected filter ✅ 2024-07-08
- [x] Below this is a free text filter box ✅ 2024-07-05

### Free text filter

- [x] Users should be able to enter 255 characters ✅ 2024-07-09
- [x] Search on all cells ✅ 2024-07-09
- [x] Below this is the list of assets ✅ 2024-07-08

### Functionality

- [x] At the end of the header row is an export button which allows a user to export the config details ✅ 2024-07-09
- [x] If a group is deselected, its assets will be removed ✅ 2024-07-09



---
![[OE Swagger Test]]
