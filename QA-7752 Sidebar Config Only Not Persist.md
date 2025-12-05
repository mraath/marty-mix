---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-05T08:19
---

# QA-7752 Sidebar Config Only Not Persist

Date: 2025-12-03 Time: 16:32
Parent:: ==xxxx==
Friend:: [[2025-12-03]]
JIRA:QA-7752 Sidebar Config Only Not Persist
==URL TO JIRA==


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

key: "sidebarSize"

{
  "values": [
    "49.448182220253614%"
  ],
  "hasLatest": false,
  "key": "sidebarSize",
  "index": null,
  "lastChangedUtcDate": "20251128005255"
}


## Pallavi Findinding + Branch + PR (WIP)

- [x] onCollapsedChange event is not getting called when we extent from Configuration Group side. ✅ 2025-12-05
Event is only getting called when extent from Asset side Finding: 
There are 2 kendo-splitter-pane but only one have binding to this event 1 pane

<kendo-splitter-pane [scrollable]="false" class="d-flex" min="15%" [(size)]="sidebarSize" [collapsible]="sidebarCollapsible" [collapsed]="sidebarCollapsed" (collapsedChange)="onCollapsedChange($event)" (sizeChange)="onSidebarResize($event)">

2 pane

<kendo-splitter-pane [scrollable]="false" [collapsible]="true" class="d-flex" min="15%"> 

This issue is related to sidebarCollapsed variable [https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/1355…](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135587 "https://dev.azure.com/mixtelematics/deviceintegration/_git/mix.config.frangular.ui/pullrequest/135587")

Did some progess but code is not 100% working yet

---

Left: 
	sidebarSize
	[collapsed]="sidebarCollapsed"
	(collapsedChange)="onCollapsedChange($event)" 
	(sizeChange)="onSidebarResize($event)
Right: 
	NONE
	[collapsed]="sidebarCollapsedAsset"
	(collapsedChange)="onCollapsedAssetChange($event)"

this.sidebarSize
this.sidebarCollapsedAsset


---
sidebarSize = '50%';
sidebarCollapsed = false;
sidebarCollapsedAsset = false;
sidebarCollapsible = true;

SelectionCriteriaKeys.sidebarCollapsedSetting > this.sidebarCollapsed = val === 'true'

onCollapsedChange > updateMyVal(SelectionCriteriaKeys.sidebarCollapsedSetting(collapsed)
onCollapsedAssetChange > updateMyVal(SelectionCriteriaKeys.sidebarCollapsedAssetSetting (collapsed)
onSidebarResize > sidebarSize = newSize > updateMyVal(SelectionCriteriaKeys.sidebarSizeSetting (newSize)

load
	getMyVal(SelectionCriteriaKeys.sidebarSizeSetting > this.sidebarSize = val
	getMyVal(SelectionCriteriaKeys.sidebarCollapsedAssetSetting > sidebarCollapsedAsset = val === 'true'
	???

---

## Branch

> Branch: Config/PJ/QA-7752(1)_R25.22

## PR

- [x] [QA-7752 Sidebar Config Only Not Persist > INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135598) ✅ 2025-12-05
- [x] QA-7752 Sidebar Config Only Not Persist > UAT ✅ 2025-12-05
