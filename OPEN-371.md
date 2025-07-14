---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-14T09:08
---

# OPEN-371

Date: 2025-07-14 Time: 09:01
Parent:: ==xxxx==
Friend:: [[2025-07-14]]
JIRA:OPEN-371
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-371)


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

Column selection and column order settings reset when reloading
