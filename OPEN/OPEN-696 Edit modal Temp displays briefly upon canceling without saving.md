---
wiki_ingested: 2026-05-28
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-10T10:14
---

# OPEN-696 Edit modal Temp displays briefly upon canceling without saving

Date: 2025-09-10 Time: 09:08
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-09-10]]
JIRA:OPEN-696 Edit modal Temp displays briefly upon canceling without saving
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-696)


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

- Fixed in OPEN-505: https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/130482