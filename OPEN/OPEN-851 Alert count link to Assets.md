---
wiki_ingested: 2026-05-28
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-10T16:42
---

# OPEN-851 Alert count link to Assets

Date: 2025-12-01 Time: 08:55
Parent:: ==xxxx==
Friend:: [[2025-12-01]]
JIRA:OPEN-851 Alert count link to Assets
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-851)

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

- When clicked, this link should:
    - Automatically select the relevant Config Group.
    - Apply a filter to show only assets flagged with the selected alert.

![[Pasted image 20251201085851.png|600]]


## SP 2



## Branch

> Branch: Config/MR/Feature/OPEN-851_Alert_count_link_to_Assets.INT

## PR

- [x] [OPEN-851 Alert count link to Assets > DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135409) ✅ 2025-12-02
	- [x] [Alphabetic list](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135415) ✅ 2025-12-02
- [x] [OPEN-851 Alert count link to Assets > INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135942) ✅ 2025-12-10
