---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-29T16:45
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

### REPO Mixleet UI



#### Assets List

C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Controllers\assetList.ts
openConfigGroup


#### Mobile Device Settings

Asset configuration changed. Click here to go to configuration groups to compile and upload now.

C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Controllers\assetCommissioning.ts
setPath('/config-admin/configuration-groups-multiselect

eg.: 
this.location.setPath('config-admin/configuration-groups-multiselect', { groupId: asset.groupid }); //something like this

## Frangular UI

asset

## AI question

I am currently working on this story:  
C:\Projects\marty-mix\OPEN-1382 Auto select Config Group from Asset List.md  
  
It links to this jira issue:  
[https://powerfleet.atlassian.net/browse/OPEN-1382](https://powerfleet.atlassian.net/browse/OPEN-1382)  
  
Basically the FLEET.UI will get extra params in the Setpath....  
The parameter will be a configgroupId (still need to find out the exact field name)  

The Frangular UI will have to handle this new parameter, basically if it is present, we need to autoselect the config group mentioned,
We currently also do this when a user clicks on the number of assets in the alerts modal in the Frangular UI

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1382_AutoselectConfigGroupfromAssetList.INT

## PR

- [ ] OPEN-1382 Auto select Config Group from Asset List > DEV
- [ ] OPEN-1382 Auto select Config Group from Asset List > INT
- [ ] OPEN-1382 Auto select Config Group from Asset List > UAT
- [ ] OPEN-1382 Auto select Config Group from Asset List > PROD
