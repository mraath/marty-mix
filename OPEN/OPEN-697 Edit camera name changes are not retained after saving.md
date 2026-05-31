---
wiki_ingested: 2026-05-28
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-15T10:08
---

# OPEN-697 Edit camera name changes are not retained after saving

Date: 2025-09-08 Time: 16:15
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-09-08]]
JIRA:OPEN-697 Edit camera name changes are not retained after saving
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-697)


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

CHECK: [library].[LibraryCameraName_Update

- [PR to DEV](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/130433)
- PR to INT will be handled with OPEN-505
