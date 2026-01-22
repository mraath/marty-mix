---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-22T08:47
---

# QA-7818 Config Groups Link goes to Legacy

Date: 2026-01-22 Time: 08:46
Parent:: ==xxxx==
Friend:: [[2026-01-22]]
JIRA:QA-7818 Config Groups Link goes to Legacy
[JIRA](https://powerfleet.atlassian.net/browse/QA-7818)


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

> Branch: Config/MR/Feature/QA-7818 Config Groups Link goes to Legacy.INT

## PR

- [ ] QA-7818 Config Groups Link goes to Legacy > DEV
- [ ] QA-7818 Config Groups Link goes to Legacy > INT
- [ ] QA-7818 Config Groups Link goes to Legacy > UAT
- [ ] QA-7818 Config Groups Link goes to Legacy > PROD
