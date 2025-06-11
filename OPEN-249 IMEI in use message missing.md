---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-11T09:45
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

no “This IMEI is already in use“ message appears for DME, instead an error popup is displayed

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

## Marty

Ok. There is quite a bit happening in this bug.  
  
1) The spinner. I can confirm what Jako said. About 11 months ago a new failure state was added in code to be returned. This is not handled by the UI. We need to add in the logic and decide what should be displayed.  
2) When the user refreshes the page, yes, there will be an error as this page can usually only be seen when the mobile unit is connected to a config group. In this instance it assumes there is a config group (as the user is on the page) but the config group is will be null, as it started the decommissioning. This all makes perfect sense.  
3) The new IMEI issue, where it doesn’t show that it is already in use. I would say, yes, please log a new bug for this. It could be related to the decommissioning which didn’t complete, but I think it should be separated out.  
  
@Amy Rodger, would you please log the new IMEI issue as a separate bug.  
I will look at the spinner UI handling.