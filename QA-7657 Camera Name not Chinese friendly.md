---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-16T09:50
---

# QA-7657 Camera Name not Chinese friendly

Date: 2025-10-16 Time: 09:49
Parent:: ==xxxx==
Friend:: [[2025-10-16]]
JIRA:QA-7657 Camera Name not Chinese friendly
[JIRA](https://powerfleet.atlassian.net/browse/QA-7657)


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

![[QA-7657 Camera Name not Chinese friendly.png]]