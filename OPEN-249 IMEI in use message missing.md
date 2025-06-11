---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-11T11:29
---

# OPEN-249 IMEI in use message missing

Date: 2025-06-11 Time: 09:23
Parent:: [[IMEI]]
Friend:: [[2025-06-11]]
JIRA:OPEN-249 IMEI in use message missing
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-249)


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

no “This IMEI is already in use“ message appears for **DME**, instead an error popup is displayed

## Amy

This morning I **decommissioned** my Oyster 2G from Brandon’s org 
	(since I have the hardware here with me on my bench)… 
	obviously the decommissioning took place as per this bug… 
	but the thing is that the **IMEI** was _not_ decommissioned… 
	when I checked it in Data centre administration | Asset search, the IMEI still appeared on his org 
	(FYI I had the decommissioning spinner loading for a good couple of minutes before refreshing and the IMEI remained commissioned to that asset).

However I took a chance and **tried commissioning** the IMEI on my device 
	and what was interesting was that it ==didn’t give me== the usual 
	“This IMEI is already in use“ 
	message… BUT it did give me an **error** when trying to save the changes… 
	I am guessing that this is DME specific, but still it should probably give the warning text like the other devices rather than an error?

```txt
Specified argument was out of the range of valid values. (Parameter 'Unique Identifier already used on MobileUnit: {"AssetId":1451687716841263104,"MobileUnitId":1451687716841263104,"UniqueIdentifier":"358014098040867","OrganisationId":-9139758428361458025,"LegacyVehicleId":25,"LegacyOrganisationId":9596,"MobileDeviceType":4,"MobileUnitType":5646852502041998355}')
```

## Looking into the code

- I think the DME is not using the same validation as other types
- [ ] Check validation in Code
- Once we know FIX

```html
<input type="text" ng-hide="assetConfigSummary.isTDI || assetConfigSummary.isStreamaxStandAlone" 
	ng-disabled="!changeMobileDeviceTemplate.identifierTitle || !form.hasDeviceTypeIdentifier || form.hasBeenCommissioned || assetConfigSummary.isTDI || assetConfigSummary.isScaniaOem || assetConfigSummary.isAEMP || assetConfigSummary.isGeotab" 
	ng-model="form.deviceTypeIdentifierValue" name="deviceTypeIdentifierValue" dmx-validate="deviceTypeIdentifierValue" 
	class="span12 ng-dirty ng-invalid ng-invalid-dmx-required ng-valid-fleet-mobile-unit-unique-identifier-async show-validity" 
	dmx-required="" 
	fleet:mobile-unit-unique-identifier-async-params="{ assetId: assetId }" 
	fleet:mobile-unit-unique-identifier-async="" 
	fleet:mobile-unit-unique-identifier-async-message="'Unique identifier already in use'" 
	fleet-mobile-unit-unique-identifier-async="" 
	fleet-mobile-unit-unique-identifier-async-message="'Unique identifier already in use'">
```

==dmx-validate="deviceTypeIdentifierValue" ==

```html
<input type="text" ng-hide="assetConfigSummary.isTDI || assetConfigSummary.isStreamaxStandAlone"
	 ng-disabled="!changeMobileDeviceTemplate.identifierTitle || !form.hasDeviceTypeIdentifier || form.hasBeenCommissioned || assetConfigSummary.isTDI || assetConfigSummary.isScaniaOem || assetConfigSummary.isAEMP || assetConfigSummary.isGeotab"
	 ng-model="form.deviceTypeIdentifierValue" name="deviceTypeIdentifierValue" dmx-validate="deviceTypeIdentifierValue" 
	 class="span12"
	 dmx-required 
	 fleet:mobile-unit-unique-identifier-async-params="{ assetId: assetId }"
	 fleet:mobile-unit-unique-identifier-async 
	 fleet:mobile-unit-unique-identifier-async-message="'Unique identifier already in use'" />
```

COMPARE TO?

```html
<input type="text"
	 ng-model="form.miXTalkIMEI" name="mixTalkIMEINumber" 
	 dmx-validate="mixTalkIMEINumber" class="span12"
	 fleet:mobile-unit-unique-identifier-async-params="{ assetId: assetId, source: 'MiXTalk' }"
	 fleet:mobile-unit-unique-identifier-async fleet:mobile-unit-unique-identifier-async-message="'IMEI already in use'" />
```
