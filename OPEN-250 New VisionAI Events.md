---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-24T14:40
---

# OPEN-250 New VisionAI Events

Date: 2025-06-24 Time: 14:40
Parent:: ==xxxx==
Friend:: [[2025-06-24]]
JIRA:OPEN-250 New VisionAI Events
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-250)

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

> Branch: Config/MR/Feature/OPEN-250 New VisionAI Events.INT

