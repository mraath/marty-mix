---
created: 2024-02-20T17:27
updated: 2024-04-17T16:59
---
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]

[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-487)


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

## Columns Needed

- [x] Select all checkbox - When this is checked then all config groups visible should be selected ✅ 2024-04-11
- [x] Alerts icon - display error count - see below for details ✅ 2024-04-05
- [x] Flagged assets icon - Number of assets flagged within the config group ✅ 2024-04-05
	- [x] Need flagged icon for ✅ 2024-04-09
- [x] Name - Configuration group name ✅ 2024-04-05
- [x] Asset count - Number of assets assigned to config group ✅ 2024-04-05
- [x] Mobile device - Mobile device associated with config group ✅ 2024-04-05
- [x] Mobile device template - Mobile device template linked to config group ✅ 2024-04-09
	- [x] green hyperlink that opens the template ✅ 2024-04-10
	- [x] xxxxxxxxxxxx ✅ 2024-04-10
- [x] Event template - Event template linked to config group ✅ 2024-04-09
	- [x] green hyperlink that opens the template ✅ 2024-04-10
	- [x] xxxxxxxxx ✅ 2024-04-10
- [x] Location template - Location template linked to config group ✅ 2024-04-09
	- [x] green hyperlink that opens the template ✅ 2024-04-10
	- [x] xxxxxxxxxxx ✅ 2024-04-10
- [x] FW version - Preferred FW version configured on the Mobile device connected to the Mobile device template ✅ 2024-04-09
	- [x] Multiline? ✅ 2024-04-09
- [x] CAN script - CAN script connected to Mobile device template (if 2 connected then display names below each other) ✅ 2024-04-09
	- [x] Multiline? ✅ 2024-04-09
	- [x] a green hyperlink that opens CAN script on the Template level ✅ 2024-04-11
	- [x] xxxxxxxxxx ✅ 2024-04-11
- [x] Speed - Speed source connected to Mobile device template such as Speed sender, J1708 CAN Speed, GPS velocity as speed ✅ 2024-04-09
	- [x] Multiline? ✅ 2024-04-09
- [x] RPM - RPM source connected to Mobile device template such as RPM signal or J1708 CAN RPM ✅ 2024-04-09
	- [x] Multiline? ✅ 2024-04-09
- [x] Fuel - Fuel source connected to Mobile device template such as EDM fuel flow meter or J1708 CAN Fuel ✅ 2024-04-09
	- [x] Multiline? ✅ 2024-04-09
- [x] SP - shows whether Streamax is connected or not. Configured on Mobile device template ✅ 2024-04-09
	- [x] Multiline? ✅ 2024-04-09
- [x] HOS - Shows whether DTCO or BYOD/ELD is in use. Configured on the Mobile device template (HOS Line) ✅ 2024-04-09
	- [x] Multiline? ✅ 2024-04-09
- [x] Users can select all, multi-select or select a single config group at a time ✅ 2024-04-11

## Help to links

![[OE-487 UI Config list Links.png]]

- Event Template: https://integration.mixtelematics.com/#/config-admin/templates/events/edit?id=-2641877325531634950&duplicate=0
- Mobile Device Template: https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/edit?id=-2010776559895876483
- Location Template: https://integration.mixtelematics.com/#/config-admin/templates/locations/edit?id=3759325715323973692&duplicate=0

CAN:
- [x] SQL Need lineId ✅ 2024-04-11
	/config-admin/templates/mobile-devices/peripherals?templateId=108968281281278625&lineId=401558247868188484
	/config-admin/templates/mobile-devices/peripherals?templateId=-6978672355520422992&lineId=-2043420209342905840
	/config-admin/templates/mobile-devices/peripherals?templateId=-6978672355520422992&lineId=401558247868188484
	/config-admin/templates/mobile-devices/peripherals?templateId=-6978672355520423000&lineId=-2043420209342905900
	/config-admin/templates/mobile-devices/peripherals?templateId=-6978672355520422992&lineId=-2043420209342905840
	/config-admin/templates/mobile-devices/edit?id=-6978672355520422992
	/config-admin/templates/mobile-devices/edit?id=-2010776559895876483
	/config-admin/templates/mobile-devices/peripherals?templateId=-6978672355520422992&lineId=-

	/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=-2043420209342905840
	/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=%20401558247868188484
	/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=401558247868188484
	/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=-
	/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=401558247868188484
	/config-admin/templates/mobile-devices/peripherals?templateId=-2010776559895876483&lineId=-2043420209342905840

## Enums

editEventTemplate,
  editMobileDeviceTemplate,
  editLocationTemplate
<div><a *ngIf='canScript; else readColumn' (click)='editCANScriptClicked(-6978672355520422992, -2043420209342905840)'>Script.CAN.J1939.FMS.TF.ISUZU.FTR_FTM.100.ACK_ENBL.REV.1.8.0.12</a></div>
## LATER?

- [x] When a group is selected then enable the Actions dropdown list at the top of the page ✅ 2024-04-11

## CSS

- [x] Grid goes out of view at bottom ✅ 2024-04-11

## Further Information

- [x] Only Configuration Groups that meet the filter's criteria will be displayed - Handled in [[OE-486 UI Configuration Group FILTER]] ✅ 2024-04-11
    - The filters will more work like a search, so previously selected config groups will not be deselected
- Selecting a config group will add all the assets in the selected config groups on the assets screen to the right and paged as it currently is. This will be a new call (Handled as # C in the Frangular API)
    - [x] Discuss if we should “lazy load” any columns. (Maybe wait till say 3 seconds after the last selection, else we will keep hitting the API for each click.) ✅ 2024-04-11


## Column Chooser

- 

## Cross CORS for Selection Criteria issues

- https://dev.azure.com/MiXTelematics/Fleet/_git/Fleet.Services.SelectionCriteria?path=/Fleet.Services.SelectionCriteria.Web.Api/appsettings.INT.json

## LATER

- [ ] Update breadcrumb change > Frangular
- [ ] Cut of multiline DIV if too long for column - might not be needed
- [ ] CG Panel cuts off on top - minimal
- [x] To the right of these columns is the column chooser - might not be needed ✅ 2024-04-17
- [x] figure out the linked columns ✅ 2024-04-17

- [ ] SelectionCriteria: subdomains add on INT
- [ ] Add functionality to the Grid footer
- [ ] Save Selected Columns

## Test

- -1983255592473789111
- TEMP add [template].[Template_GetConfigurationGroupsMultiselect] to INT
- UserId: 2779462498498119425

## Image

![[OE-487 UI Config list Config groups list.png]]

## Multilines

- [x] Struggling with innerHTML for multilines... still to resolve ✅ 2024-04-11

## Link to pages

- Asset Description: https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=1129866710152437760
- Mobile Device Template: https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/edit?id=-2269285829139232202
- Comms log? Modal: https://integration.mixtelematics.com/#/config-admin/comms-log?id=1174121359466622976&orgId=-7094567047859310012&device=MiX4000&modal=true
- Event Template: https://integration.mixtelematics.com/#/config-admin/templates/events/edit?id=3734458975993561092


## Work in progress Columns and Cells

- 2024/04/17
![[OE-487 UI Config list WIP columns dynamic.png|300]]
- Column headers working
![[OE-487 UI Config list Columns working.png|650]]
- All cells also working now - next columns selector
![[OE-487 UI Config list All working but columns selector.png|650]]


## Columns selector


- Columns selector working
![[OE-487 UI Config list Columns Selector working.png|600]]

## Actions

Placeholder actions have been added.
![[OE-487 UI Config list Placeholder actions.png|400]]

