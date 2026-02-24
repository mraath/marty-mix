---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-24T12:01
---

# OPEN-1672 Add centralised login for the new Automation UI

Date: 2026-02-24 Time: 11:07
Parent:: ==xxxx==
Friend:: [[2026-02-24]]
JIRA:OPEN-1672 Add centralised login for the new Automation UI
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1672)

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

> Branch: OPEN-1672_SingularSignup_Automation_UI.INT

## Nuget

MiX.ConfigInternal.Api.Client.2026.6.20260224.2-alpha

## PR

- [ ] OPEN-1672 Add centralised login for the new Automation UI > DEV
- [ ] OPEN-1672 Add centralised login for the new Automation UI > INT
- [ ] OPEN-1672 Add centralised login for the new Automation UI > UAT
- [ ] OPEN-1672 Add centralised login for the new Automation UI > PROD

- [ ] Client: INT: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/139404
- 