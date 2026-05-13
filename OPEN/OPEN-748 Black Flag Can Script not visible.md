---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-10T16:07
---

# OPEN-748 Black Flag Can Script not visible

Date: 2025-12-08 Time: 10:48
Parent:: [[Black Flag|Blackflag]]
Friend:: [[2025-12-08]]
JIRA:OPEN-748 Black Flag Can Script not visible
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-748)


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

On flagged vehicles, where the script has been changed away from the template, the script name is truncated in the new info screen, so you aren't able to see what has been changed. There is no way of expanding the columns to see the information either.

![[Pasted image 20251208120107.png|300]]

This is the old config page display:

![[Pasted image 20251208120118.png|300]]


## Code

getOverriddenInformationForMobileUnit
blackFlagModalShow


## Branch

> Branch: Config/MR/Feature/OPEN-748_BlackFlagCanScriptNotVisible.INT

## PR

- [x] [OPEN-748 Black Flag Can Script not visible > DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135804?_a=files) ✅ 2025-12-08
- [x] [OPEN-748 Black Flag Can Script not visible > INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135941) ✅ 2025-12-10
