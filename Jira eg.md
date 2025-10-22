---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-17T12:14
---

# Jira eg

Date: 2025-10-17 Time: 12:14
Parent:: ==xxxx==
Friend:: [[2025-10-17]]
JIRA:Jira eg
==URL TO JIRA==

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


## SP 2

### FE
- [ ] Task 1
      PR: xxxxxxxxxx

### BE
- [x] Task 1 ✅ 2025-10-17
      PR: xxxxxxxxxx

### DB
- [ ] Task 1
      PR: xxxxxxxxxx

## Branch

> Branch: Config/MR/Feature/Jira eg.INT

