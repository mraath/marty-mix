---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-24T16:32
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

> Branch: Config/MR/OPEN-1672_SingularSignup_Automation_UI.INT

## Nuget

MiX.ConfigInternal.Api.Client.2026.6.20260224.2-alpha

## PR

- [ ] OPEN-1672 Add centralised login for the new Automation UI > DEV
- [ ] OPEN-1672 Add centralised login for the new Automation UI > INT
- [ ] OPEN-1672 Add centralised login for the new Automation UI > UAT
- [ ] OPEN-1672 Add centralised login for the new Automation UI > PROD

- [ ] Client: INT: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/139404


## Enhance....

**The simpler approach would be:**

1. Keep the existing 
    
    ![](vscode-file://vscode-app/c:/Users/MarthinusR/AppData/Local/Programs/Antigravity/resources/app/extensions/theme-symbols/src/icons/files/csharp.svg)
    
    Startup.cs, controllers, managers, and service clients **exactly as they were**
2. Only change the **environment detection** in 
    
    ![](vscode-file://vscode-app/c:/Users/MarthinusR/AppData/Local/Programs/Antigravity/resources/app/extensions/theme-symbols/src/icons/files/csharp.svg)
    
    CreateSettings() so it can be influenced by the login selection (e.g., store it and re-initialize when a different environment is selected)
3. Add the login dropdown on the UI side
4. Have the auth flow proxy through to the existing `AuthDataClient` as before

## Notes

- [[Walkthrough - Decommissioning UI & Auth Updates]]