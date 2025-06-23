---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-23T15:34
---

# ETS-142

Date: 2025-06-23 Time: 15:25
Parent:: ETS-142
Friend:: [[2025-06-23]]
JIRA:ETS-142
DEFECT: https://powerfleet.atlassian.net/browse/ETS-2017
Comes from: https://powerfleet.atlassian.net/browse/ETS-142

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

