---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-28T11:43
dg-publish: true
dg-home: 
---

# OE-501 SPIKE to create the multi-select config groups

Date: 2024-01-09 Time: 09:42
Parent:: [[OE-20 Configuration Groups - Multi-select config groups]]
Friend:: [[2024-01-09]]
JIRA:OE-501 SPIKE to create the multi-select config groups
[URL TO JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-501)

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

## Progress Video OE-20

- [Progress Video OE-20](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/ET-GFuZnRZxGoaGLVQhJGA8Bt5bfJppXy-76jWRi8MgVzw?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=KWMKsA)

## Planning

![[marty-mix/content/Frangular/OE-20 Planning.excalidraw]]

- I will do what is in **green**
- Others can start with **blue**
- We can ignore **black** for now


## Seed apps egs

Eg. For the operations module that we have in DynaMiX.
- [Fleet.Services.Operations.API - Repos (visualstudio.com)](https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.API "https://mixtelematics.visualstudio.com/fleet/_git/fleet.services.operations.api")
- [Fleet.Services.Operations.UI - Repos (visualstudio.com)](https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.UI "https://mixtelematics.visualstudio.com/fleet/_git/fleet.services.operations.ui")


## Flowchart

![[OE-20 Frangular Seed App POC layout]]

## Branch

- Config/MR/Feature/OE-501-Frangular-B.24.3.INT

## Repo Naming

- MiX.Config.Frangular.API
- MiX.Config.Frangular.UI

## Subtasks OLD

| Issue key | Link |
| ---- | ---- |
| JIRA:OE-478 |  |
| JIRA:OE-479 |  |
| JIRA:OE-482 |  |
| JIRA:OE-483 |  |
| JIRA:OE-485 | [[OE-485 UI Holding page]] |
| JIRA:OE-486 | [[OE-486 UI Configuration Group FILTER]] |
| JIRA:OE-487 |  |
| JIRA:OE-488 |  |
| JIRA:OE-489 |  |
| JIRA:OE-490 |  |
| JIRA:OE-491 |  |
| JIRA:OE-493 |  |
| JIRA:OE-494 |  |
| JIRA:OE-495 |  |
| JIRA:OE-496 | [[OE-496 API Config Groups and columns]] |
| JIRA:OE-497 |  |
| JIRA:OE-498 |  |
| JIRA:OE-499 |  |
| JIRA:OE-500 |  |
| JIRA:OE-480 | [[OE-480 Navigation Item]] |
| JIRA:OE-481 | [[OE-481 iFrame]] |
| JIRA:OE-484 | [[OE-484 SEED Frangular UI]] |
| JIRA:OE-492 | [[OE-492 SEED Frangular API]] |
|  |  |
## Feedback to Nicole

- OE-480: Just need Nicole's OK with the wording. Then I can language it and close it.
- OE-481: iFrame done. I will keep it open, as it MIGHT need more work as discovered by other stories.
- OE-484: UI SEED app done. Need Nicole's approvals to put into Progress and close. Not testing needed.
- OE-492: API SEED app done. Need Nicole's approvals to put into Progress and close. Not testing needed.
- OE-478: Jako is busy with this.
- OE-479: Jako is busy with this.
- OE-485: The actual Frangular holding page. I will pick this story up next. We just need to discuss the design. I also need Nicole's approvals.
- OE-486: Can be picked up after OE-485. 
- OE-487: Can be picked up after OE-485. Will rely on OE-496 & OE-497 to complete, but not to start.
- OE-491: Can be picked up with OE-487. Will rely on OE-487 & OE-497 to complete, but not to start.
- OE-488 will rely on OE-493 to complete, but can start without it.
- OE-489 will rely on OE-494 to complete, but can start without it.
- OE-490 will rely on OE-498 & OE-495 to complete, but can start without it.
- BE stories can be picked up individually. Consider the relying UI stories.

## Mine

OE-484, OE-492, OE-485, OE-486


## Discovered

- (already sent to Nicole)
- Porting existing CG logic
	- Dragging assets in CGs

## To be done before we go live

- [x] Nicole: Discovered: Add Config group, Edit Config Group... other existing logic that needs to be ported ✅ 2024-10-28
- [x] FE: Add languaging for new menu item ✅ 2024-10-28
- [x] BE: config.js ✅ 2024-10-28
	- var angularNextConfigUrl = "http://localhost:5001";
	- var operationsApiUrl = "http://localhost:5013"; //TODO: MR: Replace
- [x] Transforms for production ✅ 2024-10-28
	- [x] UI ✅ 2024-10-28
	- [x] API: ConfigApiUrl ✅ 2024-10-28
- [x] Build Pipelines ✅ 2024-10-28
	- [x] UI ✅ 2024-10-28
	- [x] API- Setup Development environment ✅ 2024-10-28
	- For FLEET Development settings point to INT
		- Our auth also didnt work until I saw this
		- I now point it all to INT - this needs to be resolved

## Shawn CSS

"the HTML is on the branch **ui-config-groups** on the Seed app repo:"  
[https://MiXTelematics@dev.azure.com/MiXTelematics/DynaMiX/_git/Seed](https://MiXTelematics@dev.azure.com/MiXTelematics/DynaMiX/_git/Seed "https://mixtelematics@dev.azure.com/mixtelematics/dynamix/_git/seed")

## Pulled in Shawn's work

![[OE-501 SPIKE to create the multi-select config groups Shawns work.png|900]]

## New Look

![[OE-501 SPIKE to create the multi-select config groups NEW NEW look.png|900]]
## Team

For those who want to start playing around with this.
If the FIRST person could let me know, then I could help with the UI (once you tried my pdf) 
Then we can fix up the pdf
API: [https://csojiramixtelematics.atlassian.net/browse/OE-492?focusedCommentId=443131](https://csojiramixtelematics.atlassian.net/browse/OE-492?focusedCommentId=443131 "https://csojiramixtelematics.atlassian.net/browse/oe-492?focusedcommentid=443131")
UI: [https://csojiramixtelematics.atlassian.net/browse/OE-484?focusedCommentId=443143](https://csojiramixtelematics.atlassian.net/browse/OE-484?focusedCommentId=443143 "https://csojiramixtelematics.atlassian.net/browse/oe-484?focusedcommentid=443143")

OE-496: Load all Configuration groups and columns
OE-493: Compile Config
OE-494: Upload Config
OE-498: Get latest FW for assets
OE-495: Upload FW
OE-497: Load assets for all selected config groups

## More node_Modules (or not)

- @Progress (this is for Kendo)

## Fix iFrame

- [x] angularNextConfigUrl (config.js) ✅ 2024-10-28
- [x] Controller: Point to Frangular url ✅ 2024-10-28
- [x] Fix Actions not needed ✅ 2024-10-28
- [x] Remove interface not needed or fix up ✅ 2024-10-28
- [x] Fix: moduleName ✅ 2024-10-28
- [x] iframeUrl: To point to correct Fangular url ✅ 2024-10-28
- [x] BE Transforms for this ✅ 2024-10-28
- [x] sendMessage ✅ 2024-10-28
- [x] receiveMessage ✅ 2024-10-28
- [x] clean code: Remove unneeded, add what needs to still happen ✅ 2024-10-28

