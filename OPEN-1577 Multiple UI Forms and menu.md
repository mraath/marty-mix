---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-24T06:44
---

# OPEN-1577 Multiple UI Forms and menu

Date: 2026-02-24 Time: 06:44
Parent:: ==xxxx==
Friend:: [[2026-02-24]]
JIRA:OPEN-1577 Multiple UI Forms and menu
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1577)

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

> Branch: Config/MR/Feature/OPEN-1577 Multiple UI Forms and menu.INT

## PR

- [ ] OPEN-1577 Multiple UI Forms and menu > DEV
- [ ] OPEN-1577 Multiple UI Forms and menu > INT
- [ ] OPEN-1577 Multiple UI Forms and menu > UAT
- [ ] OPEN-1577 Multiple UI Forms and menu > PROD
