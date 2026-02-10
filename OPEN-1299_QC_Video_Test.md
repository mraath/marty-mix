---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-10T11:05
---

# OPEN-1299_QC_Video_Test

Date: 2026-02-10 Time: 10:17
Parent:: ==xxxx==
Friend:: [[2026-02-10]]
JIRA:OPEN-1299_QC_Video_Test
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1299)


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

> Branch: Config/MR/Feature/OPEN-1299_QC_Video_Test.DEV

## PR

- [ ] OPEN-1299_QC_Video_Test > DEV
- [ ] OPEN-1299_QC_Video_Test > INT
- [ ] OPEN-1299_QC_Video_Test > UAT
- [ ] OPEN-1299_QC_Video_Test > PROD
