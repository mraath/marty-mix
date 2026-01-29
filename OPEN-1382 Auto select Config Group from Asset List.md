---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-29T11:40
---

# OPEN-1382 Auto select Config Group from Asset List

Date: 2026-01-26 Time: 08:28
Parent:: ==xxxx==
Friend:: [[2026-01-26]]
JIRA:OPEN-1382 Auto select Config Group from Asset List
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1382)

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

When directing to the Config groups pane from links in the 
- [ ] Asset List or 
- [ ] Asset details

## CODE

OLD UI
FR UI

### Assets List

C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Controllers\assetList.ts
openConfigGroup


### Mobile Device Settings

Asset configuration changed. Click here to go to configuration groups to compile and upload now.

C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Controllers\assetCommissioning.ts
setPath('/config-admin/configuration-groups-multiselect

eg.: 
this.location.setPath(MiXFleet.ConfigAdmin.Routes.AssetMobileDevicePeripheralEdit, { assetId: this.location.getQueryParameter("assetId"), lineId: line.id });



## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1382 Auto select Config Group from Asset List.INT

## PR

- [ ] OPEN-1382 Auto select Config Group from Asset List > DEV
- [ ] OPEN-1382 Auto select Config Group from Asset List > INT
- [ ] OPEN-1382 Auto select Config Group from Asset List > UAT
- [ ] OPEN-1382 Auto select Config Group from Asset List > PROD
