---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-08-15T14:57
---

# ETS-2976 Config Beta page - compile status not displayed

Date: 2025-08-15 Time: 14:05
Parent:: 
Friend:: [[2025-08-15]]
JIRA:ETS-2976 Config Beta page - compile status not displayed
[JIRA](https://powerfleet.atlassian.net/browse/ETS-2976)


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

## Findings

As far as I can tell this is an FM 3607i/3617i. The config compile status 