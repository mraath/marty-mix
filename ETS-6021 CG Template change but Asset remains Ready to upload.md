---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-03T10:50
---

# ETS-6021 CG Template change but Asset remains Ready to upload

Date: 2025-10-02 Time: 13:49
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-10-02]]
JIRA:ETS-6021 CG Template change but Asset remains Ready to upload
[JIRA](https://powerfleet.atlassian.net/browse/ETS-6021)


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

IDC: UK
Database tested on: Mix Internal - Sales Demo ( I can confirm it has happened on other databased too)
Version: 25.15
**Issue:** Configuration Group (_BETA_) - Does not change config status when a new Event Template is selected and saved on the config group.
**Mange** Configuration Groups (_BETA_)
When you Edit a configuration group & changing the Event Template in **Configuration group (_Beta_)** The configuration status does not change.  
 
When you Editing a configuration group & changing the Event Template in **legacy** **Configuration groups** - Configuration status changes to "**Configuration Changed**"

## INT Test

YEs - I got it to happen on MR ORg Copy.... 

## Code investigation

OLD: https://integration.mixtelematics.com/#/config-admin/configuration-groups/edit?id=7796608306776466722
	BE
		HTML: MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\ConfigGroupsCreateTemplate.html: event="onSave"
		TS: MiX.Fleet.UI\UI\Js\ConfigAdmin\Controllers\ConfigGroupsEditController.ts: SaveEvent > this.onSaveClicked > this.save()
			? this._data.form.save  (comes from module.getConfigGroup)
		BE: GET_CONFIGURATION_GROUP > GetConfigurationGroup > man > 
			
	
NEW: Modal: https://integration.mixtelematics.com/#/config-admin/configuration-groups-multiselect
	FR UI
		HTML: saveConfigurationGroup
		TS: saveConfigurationGroup <<
