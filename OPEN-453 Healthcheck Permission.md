---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-21T16:37
---

# OPEN-453 Healthcheck Permission

Date: 2025-10-21 Time: 16:09
Parent:: ==xxxx==
Friend:: [[2025-10-21]]
JIRA:OPEN-453 Healthcheck Permission
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-453)

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
Create a permission to ACCESS the health page, under Support Tools, Health Check.



![[OPEN-453 Healthcheck Permission Eg.png]]

## EG Error Log

ACCESS_SUPPORT_TOOLS_ERROR_LOGS


[[Permissions]]

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

> Branch: Config/MR/Feature/OPEN-453 Healthcheck Permission.INT

