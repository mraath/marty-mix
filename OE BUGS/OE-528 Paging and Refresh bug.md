---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-07T12:46
---

# OE-528 Paging and Refresh bug

Date: 2024-10-03 Time: 10:12
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-10-03]]
JIRA:OE-528 Paging and Refresh bug
[OE-528 Refresh tab not refreshing after click - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/OE-528)


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

We have spoken to Nicole. The implementation will be like this (and handled in this bug):
- [x] Only have a Refresh on the Asset side, ✅ 2024-10-04
- [x] no paging anywhere. ✅ 2024-10-03

Also remember:
- [x] Languaging ✅ 2024-10-07

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Languages

- [x] "Last refresh" ✅ 2024-10-07
- [x] "Refresh" ✅ 2024-10-07
- [x] "a few seconds ago" ✅ 2024-10-07
- [x] "less than 30 seconds ago" ✅ 2024-10-07
- [x] "less than a minute ago" ✅ 2024-10-07
- [x] "{{minutes}} minute ago" ✅ 2024-10-07
- [x] "{{minutes}} minutes ago" ✅ 2024-10-07
- [x] "{{hours}} hour ago" ✅ 2024-10-07
- [x] "{{hours}} hours ago" ✅ 2024-10-07
- NA: Not gonna wait for a day to test: "more than a day ago"

## PR

- [Pull request 111767: OE-528: Added the Refresh logic and removed paging - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/111767)
- 