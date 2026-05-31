---
wiki_ingested: 2026-05-28
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-03T15:36
---

# QA-7444

Date: 2025-07-02 Time: 16:43
Parent:: ==xxxx==
Friend:: [[2025-07-02]]
JIRA:QA-7444
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

Testing on UAT 25.11  
ORG: QA Salesforce1  
Org id: -3239007612472481813  
Asset id: 1516947122304966656  
Asset description: Jacques' Daihatsu Terios (New MiX2000 with U-Blox GSM Modem) (FW ver. 4.10.19)

**Description:**

The odometer field for unit type MiX2310i does not lock after being updated via the UI, as expected.

**Steps to Replicate:**

Navigate to MONITOR - FLEET ADMIN - Assets.  
Select a unit of type MiX2310i and edit the asset  
Navigate to Mobile device settings  
Change the odometer value.  
Save

**BUG:**  
The odometer field remains editable after saving the update, instead of locking.

## Code

$dynamicScope?.setOdoTemplate?.canSetOdoOffsetAgain == MiXFleet.ConfigAdmin.FailReasonType.Success (0)
DeviceConfigApi.DeviceConfigClient.MobileUnits.CanSetOdo2
It hits the "can-set-odo-or-enginehours2" end-point, I will see if that changed
It will only be disabled if it was not successfully set.

SetOdometerOffset = 104

Config-API
	CanSetOdoOrEngineHours2
	await in controller - should be fine
	very similar, has CANiQ_MM check which is new
	lets check the swagger against each other
	OLD SWAGGER: Success
	NEW SWAGGER: Success as per the log....

OLD API
	CanSetOdoOrEngineHours2

Client
	CanSetOdo2


id=1677303065536602112&orgId=-1983255592473789111


- From this log I can see that the logic does allow the setodo to happen again, so the UI is behaving correctly
	- [Axiom Allowing SetOdo](https://app.axiom.co/powerfleet-cpve/query?qid=ZRJJgvHX1X4-sytac8)
- 