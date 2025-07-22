---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-22T14:54
---

# OPEN-437 Default Config Group not editable

Date: 2025-07-22 Time: 14:54
Parent:: ==xxxx==
Friend:: [[2025-07-22]]
JIRA:OPEN-437 Default Config Group not editable
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
- [ ] Task 1
      PR: xxxxxxxxxx

### DB
- [ ] Task 1
      PR: xxxxxxxxxx

## Branch

> Branch: Config/MR/Feature/OPEN-437 Default Config Group not editable.INT

