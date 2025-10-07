---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-07T08:00
---

# OPEN-836 Alert Hide missing Parameters

Date: 2025-10-07 Time: 07:55
Parent:: ==xxxx==
Friend:: [[2025-10-07]]
JIRA:OPEN-836 Alert Hide missing Parameters
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-836)

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


The alert “Event not monitored – missing parameters” need to be disabled
- [ ] CG panel
- [ ] Assets Panel

## Code

- [[OE-513 All SQL involved]]

## Branch

> Branch: Config/MR/Feature/OPEN-836AlertHideMissingParameters.INT

- [ ] PR DEV
- [ ] PR INT
