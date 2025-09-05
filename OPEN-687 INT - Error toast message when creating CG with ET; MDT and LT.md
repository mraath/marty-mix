---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-05T16:39
---

# OPEN-687

Date: 2025-09-05 Time: 14:02
Parent:: ==xxxx==
Friend:: [[2025-09-05]]
JIRA:OPEN-687
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-687)

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

click: saveConfigurationGroup
disableSaveButton


```c#

```

## Branch

> Branch: Config/MR/Feature/OPEN-687_Disable_Save_on_Click.INT2

- [ ] PR to DEV
- [ ] PR to INT