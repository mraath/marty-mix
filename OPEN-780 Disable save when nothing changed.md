---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-23T14:12
---

# OPEN-780 Disable save when nothing changed

Date: 2025-09-23 Time: 14:11
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-09-23]]
JIRA:OPEN-780 Disable save when nothing changed
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-780)


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

