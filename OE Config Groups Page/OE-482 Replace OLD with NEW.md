---
created: 2023-03-27T07:35
updated: 2024-08-09T11:16
status: busy
comment: 
priority: 1
---

# OE-482 Replace OLD with NEW

Date: 2024-08-07 Time: 12:17
Parent:: OE-513
Friend:: [[2024-08-07]]
JIRA:OE-482 Replace OLD with NEW
[Jira](https://csojiramixtelematics.atlassian.net/browse/OE-482)

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

ADD IMAGE

## Description

How to do it: [[Frangular Show and Hide Menu items]]

## Code

Added common as: ConfigGroups

### NEXT

- [x] Ensure all is in FR UI ✅ 2024-08-07
- [x] Ensure all is in FR API ✅ 2024-08-07
- [x] Ensure all is in Internal Client ✅ 2024-08-07
- [x] Ensure all is in API ✅ 2024-08-09

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

