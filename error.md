---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-15T12:33
---

# error

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

> Branch: Config/MR/Feature/error.INT

## PR

- [ ] error > DEV
- [ ] error > INT
- [ ] error > UAT
- [ ] error > PROD
