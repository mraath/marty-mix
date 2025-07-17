---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-17T09:15
---

# OPEN-403 Multiselect Columns

Date: 2025-07-17 Time: 09:14
Parent:: ==xxxx==
Friend:: [[2025-07-17]]
JIRA:OPEN-403 Multiselect Columns
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-403)


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

