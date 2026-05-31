---
wiki_ingested: 2026-05-28
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-09T09:37
---

# OPEN-1252 Add line C3

Date: 2025-12-04 Time: 15:59
Parent:: [[OPEN-840 Refactor Beta Stored Procs]]
Friend:: [[2025-12-04]]
JIRA:OPEN-1252 Add line C3
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1252)


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

We need to add C3 into this:
[mobileunit].[MobileUnit_GetAllMobileUnitLinesForConfigurationGroups]

## Branch

> Branch: Config/MR/Feature/OPEN-1252_AddlineC3.INT

## PR

- [x] [OPEN-1252 Add line C3 > DEV](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/135614) ✅ 2025-12-04
- [x] [OPEN-1252 Add line C3 > INT](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/135688) ✅ 2025-12-09
