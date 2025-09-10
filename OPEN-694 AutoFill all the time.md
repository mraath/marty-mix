---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-10T11:07
---

# OPEN-694 AutoFill all the time

Date: 2025-09-10 Time: 10:25
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-09-10]]
JIRA:OPEN-694 AutoFill all the time
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-694)


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

- Part of parent: https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/130483