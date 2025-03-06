---
status: busy
date: 2023-08-31
comment: 
priority: 1
created: 2023-08-31T13:19
updated: 2024-10-28T11:35
---

# OE-20 Configuration Groups - Multi-select config groups

Date: 2023-08-31 Time: 13:19
Parent:: [[Configuraton Groups]]
Friend:: [[2023-08-31]]
JIRA:OE-20 Configuration Groups - Multi-select config groups
[OE-20 DI Config: Configuration Groups - Multi-select config groups - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/OE-20)

CHILD:: [[OE-501 SPIKE to create the multi-select config groups]]
[[OE-513 Configuration Groups - Frangularisation and enhancements]]
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

## Description - Training

- [[Frangular - OLD Learning]] has an overview and place to show others

## Image Excalidraw

![[marty-mix/content/Frangular/OE-20 Planning.excalidraw]]

## Actual Story

**Overview**

- We need to allow users to multi-select config groups in order to ==compile== and ==upload configs== and ==firmware== to multiple groups at a time
- This will make the process of uploading configs and FW in bulk more efficient
    

**Solution**

Update the configuration groups panel as per attached PDF and below details:

- add a new section called "Show selected groups" which has a ==checkbox== with the below functionality.
    - When checkbox is selected, display the selected groups that are aligned to what has been added in the **==filter==**. If nothing in the filter, display all selected groups.
    - When this is deselected display all groups (keep selected groups checked)
    - We should also have a info bubble which has a ==tooltip== explaining the functionality of the feature. Tooltip to read:
        - Displays groups that have been selected based on the filter criteria.
- To the right of this are 3 icons with tooltips: **NOTE** - these buttons should be ==greyed== out unless a config group is selected.
	 - ==Compile== - compile all the assets that are in a ==config changed state==
		- if multiple config groups have been selected, bring up the upload configuration modal which includes the count of the selected groups (Upload config groups ==modal==.png)
		- If only 1 config group has been selected, then display the ==standard== upload config modal
	- ==Upload== - upload all assets that are in a ==Ready for upload state==
		- bring up upload config ==modal==
	    - Upload ==firmware== - Upload firmware to all selected assets
	        - bring up upload firmware ==modal== which includes a count of the selected groups (upload firmware.png)
	            - Do a ==version== check and only load the FW to the assets that don't have the version loaded currently

- Below this is the "**==Name==**" bar
- To the left of the Name text is a ==select all== checkbox
    - When this is checked then all config groups for the org should be selected
- To the right of the Name text is the ==column chooser==
- ==Add "Mobile device==" to the column chooser 
	- (Column must be able to be ==sorted== 
	- and ==filtering== can be done against this column)
	- When this is selected display the Mobile device column and populate the mobile device for each config group
- Change the radio buttons next to each config group name to a ==checkbox==
- Users can select a single or multiple config groups
- This should ==load all the assets== in the selected config groups on the assets screen to the right and paged as it currently is.

**Notes:**

- ==Auditing== to be done by calling the Audit Domain to capture details. Story is [https://jira.mixtelematics.com/browse/CONFIG-2690](https://jira.mixtelematics.com/browse/CONFIG-2690)
- A new ==permission== for this is debatable as we already allow users to upload config/FW to the entire org. 
- If one config group fails, it should ==fail silently==/elegantly and continue with the next Config Group.


## Idea for POC

- [[OE-20 NA POC Write a small App]]

## Help Image

![[Frangular EG Dissecting Fleet UI.excalidraw]]

## Breaking up into stories

### Old code

- 9) Domain registrations
	- From what I could see in Fleet code, we will need two public domains for all of this to work
	- A public domain for the Frangular UI
		- eg. configadminui.mixdevelopment.com
	- A public domain for the Frangular API
		- eg. configadminapi.mixdevelopment.com
	- Estimated Story points: 1
![[OE-20 Configuration Groups - Multi-select config groups Domain Registration.png|300]]
- 1) New Permissions
	- This is debatable as we already allow users to upload config/FW to the entire org
	- Estimated Story points: 2
![[OE-20 Configuration Groups - Multi-select config groups Permissions.png|300]]
- 2) Top navigation menu item
	- We will need to add a new item within the existing menu
	- This item will be directing to a new page in the old code
	- This page will be created as part of # 3
	- That page will basically be a page holding an iFrame which will point to the new Frangular UI Route
	- Estimated Story points: 1
![[OE-20 Configuration Groups - Multi-select config groups Menu Item.png|450]]
- 3) New iFrame holding page in the old front-end code
	- The page will basically be a page holding an iFrame which will point to the new Frangular UI Route
	- In essence this will call the Frangular UI page to be displayed here.
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups iFrame b.png|450]]
- 3.2) Replacing the old Configuration Group Page and menu item
	- Once we are happy with the new page, we need to replace two parts of the old code
	- Replace the old menu item with the new menu item url
	- Replace the old page with the new page
	- Estimated Story points: 2
- 7) Auditing (Handled as part of Config-2690)
	- [x] It needs a lot more information. ✅ 2024-10-28
	- Estimated Story points: Will need a lot more information
![[OE-20 Configuration Groups - Multi-select config groups Audting.png|300]]
- TOTAL Estimated Story points: 9 + Auditing?

### Frangular UI

- 8) Frangular UI Seed app
	- Make use of the Fleet Seed app
	- Clone this and decide on the main parts we will need to use
	- Strip this down to the bare essentials for us to get going
	- Ensure we are not taking shortcuts which can cost us in the long run
	- Run this idea past someone in Fleet, eg. Chad
	- Estimated Story points: 5
![[OE-20 Configuration Groups - Multi-select config groups Frangular UI.png|450]]
- 4) Holding page with the Configuration Group Multiselect Panel and Assets List Panel
	- This will form the initial structure of the story
	- The holding page will hold both the Configuration Group Multiselect Panel and the Assets List Panel
	- Until these two panels are done, it could just be two DIVs, later to be replaced by the actual panels
	- This will include a route, controller, html, etc.
	- Estimated Story points: 2
![[OE-20 Configuration Groups - Multi-select config groups Holding Page.png|450]]
- 4.4) The Configuration Group Multiselect Panel will be handled in this story
	- (The Assets List Panel will be handled in number 5)
	- Tip: Have some variables in place in the controller for (eg. Lists: all config groups, display groups, selected groups)
	- Add the filter textbox, which will be used to filter the Configuration Groups displayed.
		- Add the All radio button and 
		- Unallocated radio button
			- [x] How do these influence the Show selected groups checkbox and Configuration groups selected ✅ 2024-10-28
			- Usually they were used to display the Assets in the Assets List page (Handled in # 5)
			- [x] How will this then also influence the Three actions buttons in 4.1 - 4.3 ✅ 2024-10-28
			- I would think only the FW (4.3) could be influenced as only in that one the user selects the assets
			- All the rest are based on the config status of the unit
			- Thinking again, I don't even think 4.3 should be influenced by this selection, it might also confuse the user
	- Add a section called "Show selected groups" which has a checkbox with the below functionality.
		- When checkbox is selected, display the selected groups that are aligned to what has been added in the filter. 
		- If nothing in the filter, display all selected groups.
			- [x] This makes me think the filter will never remove selected groups? ✅ 2024-10-28
			- [x] Am I correct in saying the selected group will always remain selected even when filtered out? ✅ 2024-10-28
			- [x] Will it ever remove selected assets? ✅ 2024-10-28
		- When this is deselected display all groups (keep selected groups checked)
		- We should also have a info bubble which has a tooltip explaining the functionality of the feature. 
			- Tooltip to read: Displays groups that have been selected based on the filter criteria.
		- To the right of this are 3 icons with tooltips: 
		- **NOTE** - these buttons should be greyed out unless a config group is selected.
		- This page will only contain the buttons, the functionality will be handled in (4.1 - 4.3)
			- Compile (Function handled as 4.1)
			- Upload (Function handled as 4.2)
			- Upload FW (Function handled as 4.3)
	- Get all Configuration Groups for this org. This call will be handled as # B in the Frangular API section.
		- Place all these in a list.
		- From the filtered actions, place them in the display list.
		- Those selected, place them in the selected list.
		- Populate the Configuration Groups from the display list,
			- [x] If you change the filter, which would cause a selected configuration group to no longer be displayed, should it be deselected. ✅ 2024-10-28
			- I think not, rather just show a number of selected Configuration Groups which would show the user there are more selected than what they can see.
	- Estimated Story points: 5
![[OE-20 Configuration Groups - Multi-select config groups Show Selected Groups.png|450]]
- 4.5) The configuration groups list
	- Below "Show Selected Groups" is the "Name" bar
	- To the left of the Name text is a select all checkbox
		- When this is checked then all config groups for the org should be selected
			- [x] I assume only those that meets the filter's criteria, those displayed currently ✅ 2024-10-28
	- To the right of the Name text is the column chooser
		- Add "Mobile device" to the column chooser 
			- When this is selected display the Mobile device column and populate the mobile device for each config group
			- (Column must be able to be sorted 
			- and filtering can be done against this column)
				- [x] I'm not sure how this filtering is supposed to work? ✅ 2024-10-28
	- Each config group name has a checkbox
		- Users can select a single or multiple config groups
		- This should load all the assets in the selected config groups on the assets screen to the right and paged as it currently is.
			- This will be a new call (Handled as # C in the Frangular API)
			- [x] On click, should it load the assets in the Assets List Page? Or rather wait and load 3 seconds after the last select? Else we will hit the API each time a group is selected and this can be a painful exercise. ✅ 2024-10-28
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups Config Groups List.png|450]]
- 4.1) Compile Config
	- Compile all the assets that are in a Config Changed State
	- If multiple config groups have been selected, bring up the upload configuration modal which includes the count of the selected groups (Upload config groups modal.png in original OE-20 story)
	- If only 1 config group has been selected, then display the standard upload config modal
	- The actual compile logic will be in the new Frangular API as # 6.1
	- Estimated Story points: 2
![[OE-20 Configuration Groups - Multi-select config groups Compile.png|450]]
- 4.2) Upload Config
	- Upload all assets that are in a Ready for Upload State
	- Bring up upload config modal
	- The actual upload logic will be in the new Frangular API as # 6.2
	- Estimated Story points: 2
![[OE-20 Configuration Groups - Multi-select config groups Upload Config.png|450]]
- 4.3) Upload firmware
	- Upload firmware to all selected assets
		- [x] Are these assets selected from the Assets List Page ✅ 2024-10-28
		- [x] If this is the case and these are over multiple groups do you automatically deselect the assets if eg. the Filter changes ✅ 2024-10-28
		- [x] If this happens people might miss assets, should we just indicate the amount of assets selected ✅ 2024-10-28
	- Get the FW versions for all Selected Assets from Frangular API as # D
	- Bring up upload firmware modal which includes a count of the selected groups (upload firmware.png)
		- Do a version check and only load the FW to the assets that don't have the version loaded currently
			- [x] What does "The Version" refer to? Is it the latest version? ✅ 2024-10-28
			- [x] Or is this the version selected in the mobile device "Preferred firmware version"? ✅ 2024-10-28
	- The actual upload firmware logic will be in the new Frangular API as # 6.3
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups Upload FW.png|450]]
- 5) Assets List Panel
	- From the existing story it is clear that we need an Assets List Panel.
	- This panel will display the assets from the configuration Groups selected
	- From what I understand this could be from multiple selected configuration groups
		- [x] Should all selected assets be deselected if the group is deselected? ✅ 2024-10-28
		- I guess this would make sense.
		- [x] If the filter influences the groups being displayed, should it then also change the assets seen and selected ✅ 2024-10-28
		- I would guess the assets displayed will only change on the config groups selected changed, not by the filter. If the answer to my filter question is that groups should automatically be deselected, then yes, I would guess the assets will also not display and be deselected.
	- Getting the assets will be handled as # C in the Fangular API
	- Estimated Story points: We need to flesh this out still. 5?
![[OE-20 Configuration Groups - Multi-select config groups Assets List Panel.png|450]]
- TOTAL Estimated Story points: 22 + Assets List Panel?

### Frangular API

- 6) Frangular API Seed app
	- The reason for doing this is to keep with the Fleet pattern.
	- I also found while testing the Proof Of Concept that the existing API could not be called from my local machine due to a cross domain issue.
	- Make use of the Fleet API Seed app
	- Clone this and decide on the main parts we will need to use
	- Strip this down to the bare essentials for us to get going
	- Ensure we are not taking shortcuts which can cost us in the long run
	- Run this idea past someone in Fleet, eg. Chad
	- Estimated Story points: 5
![[OE-20 Configuration Groups - Multi-select config groups Angular API Seed.png|250]]
- 6.1) A new API / Client call to Compile Config
	- This call is to fail silently, continue with next group if one fails.
	- [x] Will there be an error modal, in which case we will need to return eg. the group numbers that failed OR the asset ids OR amount of assets within each config group? Maybe the group Id is sufficient? ✅ 2024-10-28
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups Compile API.png|250]]
- 6.2) A new API / Client call to Upload Config
	- This call is to fail silently, continue with next group if one fails.
	- [x] Will there be an error modal, in which case we will need to return eg. the group numbers that failed OR the asset ids OR amount of assets within each config group? Maybe the group Id is sufficient? ✅ 2024-10-28
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups Upload Config-1.png|250]]
- 6.3) A new API / Client call to Upload FW
	- This call is to fail silently, continue with next group if one fails.
	- [x] Will there be an error modal, in which case we will need to return eg. the group numbers that failed OR the asset ids OR amount of assets within each config group? Maybe the group Id is sufficient? ✅ 2024-10-28
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups Upload FW-1.png|250]]
- B) A new API / Client call to load all Configuration groups and columns needed
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups Load Config Groups.png|250]]
- C) A new API / Client call to Load assets for all selected config groups
	- In the UI where this triggers please note we should possibly only call this eg. 3 seconds after the last select was made, else the API will be hammered potentially.
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups Load Assets.png|250]]
- D) A new API / Client call to get the FW versions
	- Part of Uploading FW from the UI is to only upload FW for assets which don't have the latest FW.
	- For this we will need to get all the latest FW versions for the selected assets.
	- Potentially this could be done as part of the FW Upload logic, to first do this test, then don't expose an end point, just do it in that logic.
	- Estimated Story points: 3
![[OE-20 Configuration Groups - Multi-select config groups Get FW Version.png|250]]
- 10) Micro services
	- In future we could run the API in Micro services.
	- I don't know if we want to do this already
	- Maybe we should speak to Chad about how difficult it would be to do this later
	- Estimated Story points: No idea, we first need to decide and flesh this out better.
![[OE-20 Configuration Groups - Multi-select config groups Microservices.png|250]]
- 11) Containers
	- In future we could run the Micro services in containers (Docker?)
	- I don't know if we want to do this already
	- Maybe we should speak to Chad about how difficult it would be to do this later
	- Estimated Story points: No idea, we first need to decide and flesh this out better.
![[OE-20 Configuration Groups - Multi-select config groups Containers.png|250]]

Estimated Story points: 23 + Micro services? + Containers?

### Audit (Check Config-2690)

- Auditing has to be done by calling the Audit Domain in order to capture details. 
- The story is [https://jira.mixtelematics.com/browse/CONFIG-2690](https://jira.mixtelematics.com/browse/CONFIG-2690)
- [x] Needs a lot more fleshing out ✅ 2024-10-28

## Final Comments

- [x] Dissect the [[Frangular EG Dissecting Fleet UI.excalidraw]] ✅ 2023-11-22
- Before making final calls.

## Video WIP POC

[OE-20 Progress Video](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/ET-GFuZnRZxGoaGLVQhJGA8Bt5bfJppXy-76jWRi8MgVzw?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=KWMKsA)

