---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-16T07:14
---

# OPEN-1601 Setup Pipeline for the Powerfleet Automation UI

Date: 2026-02-16 Time: 07:14
Parent:: ==xxxx==
Friend:: [[2026-02-16]]
JIRA:OPEN-1601 Setup Pipeline for the Powerfleet Automation UI
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1601)


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


## Code


## Branch

> Branch: Config/MR/Feature/OPEN-1601 Setup Pipeline for the Powerfleet Automation UI.INT

## PR

- [ ] OPEN-1601 Setup Pipeline for the Powerfleet Automation UI > DEV
- [ ] OPEN-1601 Setup Pipeline for the Powerfleet Automation UI > INT
- [ ] OPEN-1601 Setup Pipeline for the Powerfleet Automation UI > UAT
- [ ] OPEN-1601 Setup Pipeline for the Powerfleet Automation UI > PROD
