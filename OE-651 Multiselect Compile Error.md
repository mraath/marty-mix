---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-08T13:48
---

# OE-651 Multiselect Compile Error

Date: 2025-05-08 Time: 13:48
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-05-08]]
JIRA:OE-651 Multiselect Compile Error
[OE-651 Beta - multiselect - compile error - no indication which asset is causing the issue - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-651)


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

