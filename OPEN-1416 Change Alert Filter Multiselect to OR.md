---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-03T09:27
---

# OPEN-1416 Change Alert Filter Multiselect to OR

Date: 2026-01-21 Time: 12:09
Parent:: ==xxxx==
Friend:: [[2026-01-21]]
JIRA:OPEN-1416 Change Alert Filter Multiselect to OR
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1416)

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


## CODE

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1416_ChangeAlertFilterMultiselecttoOR.INT

## PR

- [x] [OPEN-1416 Change Alert Filter Multiselect to OR > DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/137215) ✅ 2026-02-03
- [ ] [OPEN-1416 Change Alert Filter Multiselect to OR > INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/138052?_a=files)
