---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-08T09:59
---

# CONFIG-4709 CAN script not showing

Date: 2025-11-27 Time: 13:39
Parent:: [[OPEN-862 Beta Slow]]
Friend:: [[2025-11-27]]
JIRA:CONFIG-4709 CAN script not showing
[JIRA](https://powerfleet.atlassian.net/browse/CONFIG-4709)

AKA::OPEN-1209

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

## Investigation

OK - the data is there....
Populating the row is considering it....
So I think it is HTML parts (new type maybe breaking other)

> Config/MR/Bug/CONFIG-4709CANScriptNotShowing.INT
> Config/MR/Bug/CONFIG-4709CANScriptNotShowing.INT3 <<<<<<

- [x] [Config-4709 > DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135177) ✅ 2025-11-28
- [x] [Config-4709 > INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135705) ✅ 2025-12-05

## NEXT ISSUE

Config Group Panel not showing C3
- PROCEDURE [template].[Template_GetConfigurationGroupsOtherColumns]

- [ ] Config-1252 > DEV
- [ ] [Config-1252 > INT](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/135796?_a=files)
