---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-11T09:24
---

# OPEN-249 IMEI in use message missing

Date: 2025-06-11 Time: 09:23
Parent:: ==xxxx==
Friend:: [[2025-06-11]]
JIRA:OPEN-249 IMEI in use message missing
==URL TO JIRA==


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

