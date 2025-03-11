---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-11T17:28
---

# OE-632 Kebab menu not visible

Date: 2025-03-11 Time: 07:23
Parent:: [[OE-513]]
Friend:: [[2025-03-11]]
JIRA:OE-632 Kebab menu not visible
[OE-632 Kebab menu not visible upon loading - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-632)


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

![[OE-632 Kebab menu not visible Kebab menu missing.png]]

- Checking up with Shawn
- Shawn
It's not a bug. The Kendo grids in the version we used didn't have the ability to lock a column to the right.. only to the left. In a later version they introduced sticky columns which achieves that functionality but it has limitations with other grid functions.