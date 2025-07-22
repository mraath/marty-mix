---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-22T09:40
---

# ETS-2241 Event Video Intermittent

Date: 2025-07-22 Time: 09:40
Parent:: ==xxxx==
Friend:: [[2025-07-22]]
JIRA:ETS-2241 Event Video Intermittent
[JIRA](https://powerfleet.atlassian.net/browse/ETS-2241)


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

