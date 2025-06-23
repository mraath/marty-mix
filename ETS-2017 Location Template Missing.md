---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-23T16:45
---

# ETS-142

Date: 2025-06-23 Time: 15:25
Parent:: ETS-142
Friend:: [[2025-06-23]]
JIRA:ETS-142
DEFECT: https://powerfleet.atlassian.net/browse/ETS-2017
Comes from: https://powerfleet.atlassian.net/browse/ETS-142

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

Platform UntityAIOT.com
ENV: UK
DATABASE: Schlumberger - OPG - OMAN
Module : Configuration Groups (BETA)

Location Template field not available when trying to edit Configuration group even though a location Template is associated to the config Group.

![[Attachments/Untitled.png]]

Normal Config Groups Module:

![[ETS-2017 Location Template Missing.png]]

**Example Config Group:** FM36x7i - LV - VSS & RPM - SB NC - PS>6V - VTS>6V - No SAT - 12V - ArmDelay 20s_3axis_PDO

## Replicate on INT

- Easy - look for Location Template value in CG Panel and edit
- showLocationTemplate is surely false
- [ ] HOW to get it to show as true...