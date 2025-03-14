---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-14T08:46
---

# OE-638 Reset Black Flag

Date: 2025-03-14 Time: 08:39
Parent:: [[OE-513]]
Friend:: [[2025-03-14]]
JIRA:OE-638 Reset Black Flag
[OE-638 Reset config group is not successfully resetting the asset to the config group - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-638)


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

- **OLD** UI: 
- NEW UI: https://mixconfigfrangularapi.mixdevelopment.com/api/groupId/-7094567047859310012/mobile-units/reset/1