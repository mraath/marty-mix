---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-27T06:29
---

# QA-7818 Config Groups Link goes to Legacy

Date: 2026-01-22 Time: 08:46
Parent:: ==xxxx==
Friend:: [[2026-01-22]]
JIRA:QA-7818 Config Groups Link goes to Legacy
[JIRA](https://powerfleet.atlassian.net/browse/QA-7818)


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


## Code


## UI

config-admin/configuration-groups/asset/events?assetId=1646589414582132736
<h5 ui-if="url" class="ng-scope"><a ng-click="click()" dmx-translate="" class="ng-binding">Configuration groups</a></h5>
config-admin/configuration-groups



- Asset Description (/asset/events?assetId=1646589414582132736)
	- ~~Event~~ (/asset/events/edit?templateEventId=-5880546474772399188&assetId=1646589414582132736)
		- ~~Mobile device~~ template (SAME as below, but test)
	- ~~Mobile device~~ template (/asset/~~mobile-device~~?assetId=1646589414582132736)
		- Mobile Device type (/asset/~~mobile-device~~/edit?assetId=1694875078396985344)
		- Line Connection (/asset/~~mobile-device~~/edit?assetId=1694875078396985344&lineId=4376715893163448311)

- Can Script (/asset/~~mobile-device~~/edit?assetId=1626018637366906880&lineId=7859185854233145787)

??
~~AssetLocationList~~
~~AssetLocationEdit~~

## Branch

> Branch: Config/MR/Feature/QA-7818_ConfigGroupsLinkGoesToLegacy.26.3

## PR

- [x] QA[-7818 Config Groups Link goes to Legacy > DEV](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/137310?_a=files) ✅ 2026-01-23
- [x] [QA-7818 Config Groups Link goes to Legacy > INT](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/137401) ✅ 2026-01-27
- [ ] [QA-7818 Config Groups Link goes to Legacy > UAT](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/137581?_a=files)
- [ ] QA-7818 Config Groups Link goes to Legacy > PROD
