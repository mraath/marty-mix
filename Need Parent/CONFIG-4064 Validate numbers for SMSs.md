---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2023-11-28T16:01
---

# CONFIG-4064 Validate numbers for SMSs

Date: 2023-11-28 Time: 08:06
Parent:: [[validation]]
Friend:: [[2023-11-28]]
JIRA:CONFIG-4064 Validate numbers for SMSs
[CONFIG-4064 Validate numbers for SMSs - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-4064)

## Lesson

- [ ] What was the MAIN cause or thing learned from this?

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

## Image learned from this issue

ADD IMAGE

## Move what you learned into the bigger picture

ADD IMAGE

## Shorter Summary

- Version 23.16

![[CONFIG-4064 Validate numbers for SMSs Fix needed.png]]

None of these were found as value types in XML.
I will apply validation from HTML side.
First I will find a similar validation and just apply that.
? negative driver ID (NO - I will continue to investigate)

- Asset Name: C09-MAN 26.4806X4B (0960 20074 13750) (CF259157x)
- Org Name: Xinergistix (R)
- DB Name: HOCompassXinergistix1_2016
- Vehicle Id: 907
- liOrgId: 523
- AssetId: 893980046368452608
- MobileUnitKey: 273402
- Unit Type: FM3617i
- [MiX Telematics - Assets](http://localhost/MiXFleet.UI/#/fleet-admin/asset/commissioning?id=1466041918665613312&orgId=-1983255592473789111)

## Mobile Phone Validation

```html
<input type="text" ng-show="assetConfigSummary.isMobilePhone"
	ng-disabled="!assetConfigSummary.isMobilePhone  || oldForm.deviceTypeIdentifierValue"
	ng-model="form.deviceTypeIdentifierValue" name="deviceTypeIdentifierValueMobileNumber" dmx-validate="deviceTypeIdentifierValueMobileNumber" class="span12"
	dmx-phonecountrycode dmx-phonecountrycode-message="'Invalid country code'"
	dmx-phonenumber dmx-phonenumber-message="'The value must be a valid phone number, e.g. +27 12 345 6789'"
	dmx-required fleet:mobile-number-unique-async-params="{ assetId: assetId }"
	fleet:mobile-number-unique-async fleet:mobile-number-unique-async-message="'Unique identifier already in use'" />

<input type="text" ng-model="form.gsmMsisdnNumber"        name="gsmMsisdnNumber"        dmx-validate="gsmMsisdnNumber"        class="span12" dmx-required ng-disabled="!form.gsmEnabled||!form.canEditGsmDetails||!form.communicationCapable" />
<input type="text" ng-model="form.smsMobileDeviceNumber"  name="smsMobileDeviceNumber"  dmx-validate="smsMobileDeviceNumber"  class="span12" dmx-required ng-disabled="!form.smsEnabled||!form.canEditSmsDetails||!form.communicationCapable" />
<input type="text" ng-model="form.smsMessageCentreNumber" name="smsMessageCentreNumber" dmx-validate="smsMessageCentreNumber" class="span12" dmx-required ng-disabled="!form.smsEnabled||!form.canEditSmsDetails||!form.communicationCapable" />

<!-- What to add 
	dmx-phonecountrycode dmx-phonecountrycode-message="'Invalid country code'"
	dmx-phonenumber dmx-phonenumber-message="'The value must be a valid phone number, e.g. +27 12 345 6789'"
	-->
```

## SQL Used

```sql
USE HOCompassXinergistix1_2016;

SELECT TOP 10 * FROM dbo.Vehicles
WHERE sDesc like 'C09-MAN 26.4806X4B%'
-- Vehicle Id: 907

USE FMOnlineDB;

SELECT TOP 10 * FROM dbo.Organisation
WHERE sOrganisationName like '%Xinergistix%'
-- liOrgId: 523

USE DeviceConfiguration;

SELECT TOP 10 * FROM mobileunit.AssetMobileUnits
Where LegacyVehicleId = 907
AND LegacyOrgId = 523

SELECT * FROM mobileunit.MobileUnits
WHERE MobileUnitKey = 273402
-- CG Key: 21619

SELECT TOP 10 * FROM template.ConfigurationGroups
WHERE ConfigurationGroupKey = 21619
--Name: TT MAN TGS-2019 up-FM3617i-MTN-CAN-(P/D/B/PTO)-SC-VK-OS-81-COMP ID-UNC

```
## Description


## Notes

- [ ] Message Farhaad 
Hi Farhaad, Marthinus here.
I am looking into CONFIG-4064
I found other places where the phone numbers allow for spaces.
Is this the same for this issue?
So will the following validation be in order?
"The value must be a valid phone number, e.g. +27 12 345 6789"

## Ideas

- [ ] Duplicate in Prod
- [ ] Duplicate on INT
- [ ] Check DB, Logs

## SR Meeting Notes


## Useful Comments from Jira


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing



## Follow the code path

### Log


### Data


### Code


## Final Findings for Jira

- 
