---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-04T16:15
---

# OPEN-689 Camera Direction field needed in operational stored procs

Date: 2025-09-04 Time: 14:59
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-09-04]]
JIRA:OPEN-689 Camera Direction field needed in operational stored procs
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-689)

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


I have identified the following files to be handled.
- [dynamix].[CopyLibraryForNewDatabase]
- [dynamix].[InitializeLibraryForNewBlankDatabase]
- [library].[CopyCameraNamesAndChannels]
- C:\\Projects\\Database\\DeviceConfiguration\\Scripts\\DeploymentScripts\\MergeCameraData.sql

## Branch

Handled as part of OPEN-597

- [x] [PR to DEV with Operational things](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/130127) ✅ 2025-09-04
- [ ] PR to INT

## Testing notes


