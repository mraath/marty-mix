---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-08T15:02
---

# OPEN-837 Add an Alert Filter

Date: 2025-10-07 Time: 11:21
Parent:: ==xxxx==
Friend:: [[2025-10-07]]
JIRA:OPEN-837 Add an Alert Filter
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-837)

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

## Description

[[Adding a Filter]]

## Code

ddFilterAlerts



## Branch

> Branch: Config/MR/Feature/OPEN-837 Add an Alert Filter.INT

