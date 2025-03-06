---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-11-05T10:39
---

# OE-518 Other porting story

Date: 2024-11-04 Time: 09:45
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-11-04]]
JIRA:OE-518 Other porting story
[OE-518 Port all existing logic not catered for in other stories - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-518)

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

As mentioned, this will be used as a bucket to catch everything not covered specifically in stories.
As I see it this story might be passed between developers, based on who is busy implementing missed logic.
This will continually get more things to do until testing and development of other stories are done and BETA has gone live.

- Currently, I am using this to quickly do some languaging, which I should have done as part of each story, however, before we still needed the mechanism of doing languaging, which is now possible. After this, I will set this back to unassigned for the next dev to do something, eg. edit config groups.
- [x] A next thing to look into here would be: Grid Ordering / Sorting ✅ 2024-11-04
	- [[Grid Sorting]]
	- PR: [Pull request 114096: OE-518: Fixed Sorting columns. Removed paging. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/114096)
- [x] Fix Column Chooser ✅ 2024-11-05
	- Doesn't hide when clicking outside of it
	- Sometimes move into weird areas of the page
	- [x] Search for code examples under "Choose columns" ✅ 2024-11-05
	- [[Grid Column Chooser Fix]]
	- Search: popup-column-chooser
	- PR: [Pull request 114154: OE-518: Fixed column chooser hiding behind other panels, etc - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/114154)
- 