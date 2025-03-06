---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-03-20T16:37
---

# OE-481 iFrame

Date: 2024-01-10 Time: 10:25
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-01-10]]
JIRA:OE-481 iFrame
[URL TO JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-481)

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

![[OE-481 iFrame Summary.png|400]]

## Description

- The page will basically be a page holding an iFrame which will point to the new Frangular UI Route
- In essence, this will call the Frangular UI page to be displayed here.

## Branches

- Config/MR/Feature/OE-501-Frangular-B.24.3.INT
- ALWAYS merge INT back in before merging to DEV, then INT...

