---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-09T16:31
---

# OE-652 Not Languaged config status filter dropdown

Date: 2025-05-09 Time: 13:39
Parent:: [[Languaging]]
Friend:: [[2025-05-09]]
JIRA:OE-652 Not Languaged config status filter dropdown
[OE-652 Languaging BUG: config status filter dropdown - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-652)


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

Check these:
Configuration accepted
Configuration changed
Not commissioned

- It is in FR UI Pot
- FR UI DD didnt have lang service

- BRANCH: 
- PR INT: [Pull request 124383: OE-652: Added languaging to the dropdown values - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/124383)
- Should be done