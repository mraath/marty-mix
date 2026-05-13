---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-28T07:11
---

# OPEN-836 Alert Hide missing Parameters

Date: 2025-10-07 Time: 07:55
Parent:: ==xxxx==
Friend:: [[2025-10-07]]
JIRA:OPEN-836 Alert Hide missing Parameters
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-836)

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


The alert “Event not monitored – missing parameters” need to be disabled
- [x] CG panel ✅ 2025-10-15
- [x] Assets Panel ✅ 2025-10-15

## Code

- [[OE-513 All SQL involved]]

BOTH CG and Assets calls: [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
	This in affect calls the Stored Proc, in which it calls [state].[MobileUnit_GetMobileUnitMissingParameters]
	So, in this last mentioned stored proc we can just comment out the logic and return nothing.

commented out:
MobileUnit_GetMobileUnitMissingParameters

## Get some testing data

## Branch

> Branch: Config/MR/Feature/OPEN-836AlertHideMissingParameters.INT

- PR DEV
- [x] [PR INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/131955) ✅ 2025-10-28
