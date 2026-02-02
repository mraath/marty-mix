---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-02T08:12
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

## AI question

I am currently working on this story:  
C:\Projects\marty-mix\OPEN-1382 Auto select Config Group from Asset List.md  
  
It links to this jira issue:  
[https://powerfleet.atlassian.net/browse/OPEN-1382](https://powerfleet.atlassian.net/browse/OPEN-1382)  
  
Basically the FLEET.UI will get extra params in the Setpath....  
The parameter will be a configgroupId (still need to find out the exact field name)  

The Frangular UI will have to handle this new parameter, basically if it is present, we need to autoselect the config group mentioned,
We currently also do this when a user clicks on the number of assets in the alerts modal in the Frangular UI

### REPO Mixleet UI

This is the repo where we need to change it, in three places
#### Assets List

C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Controllers\assetList.ts
method openConfigGroup

#### Mobile Device Settings

Close to wording like:
Asset configuration changed. Click here to go to configuration groups to compile and upload now.

C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Controllers\assetCommissioning.ts
setPath('/config-admin/configuration-groups-multiselect

change to eg.: 
this.location.setPath('config-admin/configuration-groups-multiselect', { groupId: asset.groupid }); //something like this


#### ConfigGroupsMultiselectController

C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Controllers\ConfigGroupsMultiselectController.ts
this.location.getQueryParameter("templateEventId");

### Frangular UI

I will still add where but it will be in the configurationgroups.... 
file: C:\Projects\MiX.Config.Frangular.UI\src\app\config-groups\config-groups.component.ts

This is how we set it from the Grid:
```c#
this.selectedConfigGroupForAlerts = dataItem; //NEED to figure this one out (IConfigurationGroupsMultiselectCarrier)
//Maybe do this once we have loaded the config groups, then get the dataItem by using the id sent in
this.selectedConfigGroupForAlerts.configurationGroupId
```
Maybe something like this:
  ```c#
  filterByAlert(alertMessage: configAlertMessage) {
    this.configAssetAlertsModalClose();

    if (this.selectedConfigGroupForAlerts) {
      this.configGroupSelectedKeys = [this.selectedConfigGroupForAlerts.configurationGroupId];
      this.selectedAlerts = [];
      this.pendingAlertFilter = alertMessage.alert;
      this.loadConfigAssets();
    }
  }
  ```



## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1382_AutoselectConfigGroupfromAssetList.INT
> UI DEV: Config/MR/Feature/OPEN-1382_AutoselectConfigGroupfromAssetList.DEV

## PR

- [ ] OPEN-1382 UI: Auto select Config Group from Asset List > DEV
- [ ] OPEN-1382 **FR UI**: Auto select Config Group from Asset List > DEV
- [ ] OPEN-1382 UI: Auto select Config Group from Asset List > INT
- [ ] OPEN-1382 **FR UI**: Auto select Config Group from Asset List > INT
