---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-26T15:16
---

# OPEN-997 New Column Reordering

Date: 2026-01-26 Time: 15:15
Parent:: ==xxxx==
Friend:: [[2026-01-26]]
JIRA:OPEN-997 New Column Reordering
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-997)

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


## CODE

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-997 New Column Reordering.INT

## PR

- [ ] OPEN-997 New Column Reordering > DEV
- [ ] OPEN-997 New Column Reordering > INT
- [ ] OPEN-997 New Column Reordering > UAT
- [ ] OPEN-997 New Column Reordering > PROD
