---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-25T09:27
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
    Startup.cs, controllers, managers, and service clients **exactly as they were**
2. Only change the **environment detection** in 
    CreateSettings() so it can be influenced by the login selection (e.g., store it and re-initialize when a different environment is selected)
3. Add the login dropdown on the UI side
4. Have the auth flow proxy through to the existing `AuthDataClient` as before

## Notes

- [[Walkthrough - Decommissioning UI & Auth Updates]]
- [[MORE changes for dropdown login environments]]
- [[Walkthrough - Navigation Menu & Decommissioning Placeholder]]
- [[SOP - Implementing Navigation Menu]]

### Technical History & Context (from recent findings)

- **Evolution of Environment Switching:**
    - **Initial Approach:** Global singleton state switch. This was found to be risky in multi-user/parallel request scenarios and led to potential deadlocks or a 500 Internal Server Error when switching.
    - **Refined Approach (Current):** Switched to a **Concurrent Environment Context** model. 
        - [EnvironmentContextManager.cs] manages a `ConcurrentDictionary` of `EnvironmentContext`.
        - Each request (Auth, QC, Decommissioning) passes an `environment` parameter (header `X-Environment` or query param) to retrieve the correct scoped context.
        - Clients and [GlobalSettings] are now scoped per-context, allowing parallel requests to different environments (DEV, INT, AU, etc.) without interference.
- **Bug Fixes:**
    - Fixed compilation errors in `QCManagerTests` due to the [QCManager] constructor now requiring [GlobalSettings] injection.
    - Resolved 500 errors by ensuring `EnvironmentSettingsProvider` doesn't perform blocking global operations during request processing.
- **Relevant Artifacts:**
    - `e418b11d`: Per-Environment Client Instances (Revised Plan & Walkthrough)
    - `b0a4b734`: Multi-Environment Support (Initial Implementation)
    - `a890785e`: Fix Compilation Errors After Multi-Environment Refactor