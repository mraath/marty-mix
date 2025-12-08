---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-08T16:57
---

# OPEN-930 Add Config File Downloads

Date: 2025-12-08 Time: 16:54
Parent:: ==xxxx==
Friend:: [[2025-12-08]]
JIRA:OPEN-930 Add Config File Downloads
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-930)

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

- [ ] Download config file
	- 
- [ ] Download pending config file
	- 

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-930_AddConfigFileDownloads.INT

## PR

- [ ] OPEN-930 Add Config File Downloads > DEV
- [ ] OPEN-930 Add Config File Downloads > INT

