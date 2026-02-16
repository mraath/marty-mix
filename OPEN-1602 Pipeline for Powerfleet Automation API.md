---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-16T15:30
---

# OPEN-1602 Pipeline for Powerfleet Automation API

Date: 2026-02-16 Time: 15:30
Parent:: ==xxxx==
Friend:: [[2026-02-16]]
JIRA:OPEN-1602 Pipeline for Powerfleet Automation API
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1602)

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

> Branch: Config/MR/Feature/OPEN-1602 Pipeline for Powerfleet Automation API.INT

## PR

- [ ] OPEN-1602 Pipeline for Powerfleet Automation API > DEV
- [ ] OPEN-1602 Pipeline for Powerfleet Automation API > INT
- [ ] OPEN-1602 Pipeline for Powerfleet Automation API > UAT
- [ ] OPEN-1602 Pipeline for Powerfleet Automation API > PROD
