---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-16T10:28
---

# OPEN-1371 INT Error 500 on Config Group Alerts

Date: 2026-01-16 Time: 10:27
Parent:: [[timezone]]
Friend:: [[2026-01-16]]
JIRA:OPEN-1371 INT Error 500 on Config Group Alerts
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1371)


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

![[Pasted image 20260116102747.png]]
## Code


## Branch

> Branch: Config/MR/Feature/OPEN-1371 INT Error 500 on Config Group Alerts.INT

## PR

- [ ] OPEN-1371 INT Error 500 on Config Group Alerts > DEV
- [ ] OPEN-1371 INT Error 500 on Config Group Alerts > INT
- [ ] OPEN-1371 INT Error 500 on Config Group Alerts > UAT
- [ ] OPEN-1371 INT Error 500 on Config Group Alerts > PROD
