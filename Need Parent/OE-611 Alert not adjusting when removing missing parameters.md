---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-04-07T11:41
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
			eventTemplate = ConfigAdminRepository.GetEventTemplateWithChildrenById(configGroup.EventTemplateId)
			GetEffectiveConfig(mobielUnitAggregate, eventTemplate, resolvedMobileDevice)

[[Parameter]]

![[SQL Schemas#Parameters]]

## Files

- C:\Projects\_MiXTelematicsFiles\SQL\OE-611 Missing Params Test.sql

## Findings

- Looking at the inner SELECT in @assetsMissingParameters, I can see none of the event have supported Params
- Look at the supportive params next (@AllSupportedParameters)........ xxxxxxxxxxxxxxx

## RETEST

- OK - so this reverts some changes for OE-614
- We need to retest OE-614

## Reworking all of this

[[Alerts with AI]]

## Comparing the refactored work

> C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare.sql

### Fixing up: First Alerts

[[ AI Alerts Feedback 1]]
- [ ] We'll remember to add the correct status filtering back later once you provide the list.

[[AI FW Versions]]

## Broke it up in sections to test rather

### Base Info

- New Function: C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Functions\udfGetMobileUnitBasicInfoForConfigGroups.sql
- Test: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare BASICS.sql

### Alerts 1 and 2

- First train what it should be looking at...
- Then test the two results
- Story:
	- Assets in config Upload requested state for more than 5 days
	- Assets in FW upload requested state for more than 3 days
	- [[SQL Message Statuses]]
- Function: C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Functions\udfGetMobileUnitMessageAlerts.sql
- Test cases:
	- **Scenario A (Config Alert):** A unit whose _latest_ message of type 254 or 255 is older than 5 days AND has a status NOT IN (10, 12, 13, 25, 28). (Expected output: '10' or '11')
	- **Scenario B (Firmware Alert):** A unit whose _latest_ message of type 103 is older than 3 days AND has a status NOT IN (10, 12, 13, 25, 28). (Expected output: '01' or '11')
	- **Scenario C (Both Alerts):** A unit meeting conditions for both Scenario A and Scenario B. (Expected output: '11')
	- **Scenario D (Old but Good Status):** A unit whose latest relevant message(s) are older than the thresholds BUT have a status IN (10, 12, 13, 25, 28). (Expected output: '00')
	- **Scenario E (Recent / No Relevant Messages):** A unit whose latest relevant messages are recent OR has no relevant messages at all. (Expected output: '00')
- TEST 1: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2.sql
- Test Many: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2 BULK.sql

### Alert 3

- uspGetMobileUnitFirmwareInfo

Since this is a stored procedure with output parameters, testing involves:

1. **Choosing Test Cases:** Select `MobileUnitId`s that represent different firmware scenarios (e.g., up-to-date, outdated, overridden preferred version, different device types like FMBas/non-FMBas, CAN incompatible/compatible).
	- [ ] up-to-date, 
	- [ ] outdated, 
	- [ ] overridden preferred version, 
	- [ ] different device types like FMBas
	- [ ] /non-FMBas, 
	- [ ] CAN incompatible
	- [ ] /compatible
2. **Gathering Inputs:** For each test `MobileUnitId`, you need to find its corresponding `MobileUnitKey`, `MobileDeviceKey`, `LibraryKey`, and `MobileDeviceTemplateKey`. You can get these from the `udfGetMobileUnitBasicInfoForConfigGroups` function or by querying the base tables directly.
3. **Manually Calculating Expected Output:** This is the most involved part. For a given test case, you would need to manually trace the logic within `uspGetMobileUnitFirmwareInfo`:
    - [ ] Find the installed firmware name (`state.MobileUnitState`).
    - [ ] Find the preferred firmware name (checking template properties and overrides).
    - [ ] Determine the device's FMBas/CAN status based on the template's `MobileDeviceKey`.
    - [ ] Identify the relevant set of available firmware versions based on type and library, applying filters.
    - [ ] Order the available versions by name, assign sequence numbers.
    - [ ] Compare the installed version's sequence number to the latest available sequence number to determine the expected `IsFirmwareOutdated` flag (0 or 1).
4. **Executing the Stored Procedure:** Run the SP with the inputs gathered in step 2.
5. **Comparing Results:** Compare the values returned in the SP's output parameters (`@InstalledFirmwareName`, `@PreferredFirmwareName`, `@IsFirmwareOutdated`) with the expected values calculated in step 3.

- Toets: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 3.sql
- [ ] Look at results for assets and double check version number order with Zonika or Nicole

