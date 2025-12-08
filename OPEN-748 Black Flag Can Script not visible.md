---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-08T10:48
---

# OPEN-748 Black Flag Can Script not visible

Date: 2025-12-08 Time: 10:48
Parent:: [[Black Flag|Blackflag]]
Friend:: [[2025-12-08]]
JIRA:OPEN-748 Black Flag Can Script not visible
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-748)


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


## Branch

> Branch: Config/MR/Feature/OPEN-748 Black Flag Can Script not visible.INT

## PR

- [ ] OPEN-748 Black Flag Can Script not visible > DEV
- [ ] OPEN-748 Black Flag Can Script not visible > INT
- [ ] OPEN-748 Black Flag Can Script not visible > UAT
- [ ] OPEN-748 Black Flag Can Script not visible > PROD
