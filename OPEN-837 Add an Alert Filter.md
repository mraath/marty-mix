---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-14T11:02
---

# OPEN-837 Add an Alert Filter

Date: 2025-10-07 Time: 11:21
Parent:: ==xxxx==
Friend:: [[2025-10-07]]
JIRA:OPEN-837 Add an Alert Filter
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-837)

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

[[Adding a Filter]]

## Code

ddFilterAlerts
selectedAlerts

alertsChanged
alertsClosed
alertsChanged
onAlertsChange

filter.alerts

## Language these

- [x] Filter by alert ✅ 2025-10-09

## CSS

- [ ] Styling to fit dropdown and selected text better

## Branch

> Branch: Config/MR/Feature/OPEN-837AddAnAlertFilter.INT

## PRs

- [x] [PR to DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/132292) ✅ 2025-10-14
- [ ] PR to INT
