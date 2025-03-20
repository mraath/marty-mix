---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-20T10:55
---

# OE-611 Alert not adjusting when removing missing parameters

Date: 2025-02-25 Time: 09:57
Parent:: [[OE-515 Alerts Column Assets Panel]]
Friend:: [[2025-02-25]]
JIRA:OE-611 Alert not adjusting when removing missing parameters
[OE-611 Alert not updating as expected when an event with missing parameters is removed from the event template - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-611)


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

### This one should have NO missing parameters

Config Groups Beta values

![[OE-611 Alert not adjusting when removing missing parameters.png]]

- CG values: [MiX Telematics - Configuration groups](https://integration.mixtelematics.com/#/config-admin/configuration-groups/edit?id=-2440320943995442748)
- -2440320943995442748

- Asset Id: [MiX Telematics - Configuration groups](https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=1631447698450665472)
- 1631447698450665472

Asset Template

![[OE-611 Alert not adjusting when removing missing parameters Not missing.png]]


Looking at the original Template

![[OE-611 Alert not adjusting when removing missing parameters Original Template.png]]

### This one SHOULD have missing parameters

![[OE-611 Alert not adjusting when removing missing parameters Overview.png]]

CG: 3744429100126254243
AssetId: -3958977241595557833


![[OE-611 Alert not adjusting when removing missing parameters yes.png]]

**FE**:

URL: https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=-3958977241595557833
AssetEventListTemplate.html
module.getAssetEvents

**BE**

MobileUnitEventsModule.ModuleRoutes.GET_EVENTS
GetEventTemplate
	mobileUnitManager.GetEffectiveConfig(mobileUnit, mobileDeviceTemplate, eventTemplate)
		resolvedMobileDevie = GetResolvedMobileDevice(mobileUnit, tempalteAggregate
		GetEffectiveConfig(mobileUnit, eventTemplateAggregate, resolvedMobileDevie)


## Files

- C:\Projects\_MiXTelematicsFiles\SQL\OE-611 Missing Params Test.sql

## Findings

- Looking at the inner SELECT in @assetsMissingParameters, I can see none of the event have supported Params
- Look at the supportive params next (@AllSupportedParameters)........ xxxxxxxxxxxxxxx

## RETEST

- OK - so this reverts some changes for OE-614
- We need to retest OE-614
