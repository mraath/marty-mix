---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-10T16:57
---

# OE-631 Column selector styling

Date: 2025-03-10 Time: 15:33
Parent:: [[OE-513]]
Friend:: [[2025-03-10]]
JIRA:OE-631 Column selector styling
[OE-631 UI: Column Selector Icon Misaligned - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-631)


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

Padding / margin missing

![[OE-631 Column selector styling Padding or Margin.png]]

PR: [Pull request 121009: OE-631: Spacing or styling for the column choosers - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/121009)
