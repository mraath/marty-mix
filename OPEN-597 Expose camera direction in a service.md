---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-08-18T16:54
---

# OPEN-597 Expose camera direction in a service

Date: 2025-08-18 Time: 16:49
Parent:: ==xxxx==
Friend:: [[2025-08-18]]
JIRA:OPEN-597 Expose camera direction in a service
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-597)

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

The purpose of this story is to expose the camera direction data in a service/API as developed in https://powerfleet.atlassian.net/browse/OPEN-505 
The Data Science team will use the camera direction to apply blurring to specific channels

- [ ] Add camera name
- [ ] Edit camera name

## Branch

> Branch: Config/MR/Feature/OPEN-597 Expose camera direction in a service.INT

