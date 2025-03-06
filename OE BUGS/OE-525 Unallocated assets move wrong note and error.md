---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-09-19T19:48
---

# OE-525

Date: 2024-09-19 Time: 08:12
Parent:: [[OE-504 UI Move to Config Group]]
Friend:: [[2024-09-19]]
JIRA:OE-525
[OE-525 BUG - "asset does not match mobile device" message appears for unallocated assets - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/OE-525)

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

- Show **unallocated**
- Selected one asset
- Actions
- Move to config group
- Selected applicable config group: CalAmp Lite
> message indicating that the asset has an **associated mobile device that doesn’t match** the selected config

## Final Findings for Jira

- NA: Check if the API is showing an error
- 

## Jira comments

I have made a few changes.
- Please ensure the original issue is now resolved
- Please ensure it no longer shows the "doesn't match" note
- Please ensure it still shows success

INITIAL IDEA:
I recall seeing something similar while testing, however, this didn't happen with all assets. It was some old data which caused this. I will try to find the reason and comment here XXXXXXXXXXXXXXXXXX
From the console I can see that it actually moved successfully.
It then fails where it tries to adjust the asset counts.
- [x] The note shouldn't show for unallocated assets ✅ 2024-09-19
- [x] Cannot read properties of null (reading 'assetsCount') ✅ 2024-09-19
	- updateConfigGroupsAssetNumbers > assetsCount = u.assetsCount - 1
	- [x] stuck spinner ✅ 2024-09-19



- [Pull request 110894: OE-525: Busy fixing the CG count when moving unallocated assets in - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/110894)
- [Pull request 110925: OE-525: Hiding "do not match" message for unallocated. Remove setting assets... - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/110925)
- [Pull request 110932: OE-525: Needed to exclude more counting logic. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/110932)
- 