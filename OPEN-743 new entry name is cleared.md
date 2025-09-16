---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-16T15:39
---

# OPEN-743 new entry name is cleared

Date: 2025-09-16 Time: 11:49
Parent:: ==xxxx==
Friend:: [[2025-09-16]]
JIRA:OPEN-743 new entry name is cleared
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-743)


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

- PR in OPEN-505