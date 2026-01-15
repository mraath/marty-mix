---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-15T12:37
---

# OPEN-1362 INT Config groups page Error 500

Date: 2026-01-15 Time: 12:33
Parent:: ==xxxx==
Friend:: [[2026-01-15]]
JIRA:error
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1362)


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

> Branch: Config/MR/Feature/OPEN-1362_ConfiggroupsPageError500.INT

## PR

- [ ] OPEN-1362 > DEV
- [ ] OPEN-1362 > INT
- [ ] OPEN-1362 > UAT
- [ ] OPEN-1362 > PROD
