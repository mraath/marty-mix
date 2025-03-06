---
status: busy
date:
  "{ date }": 
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2023-10-26T10:01
---

# FWQ-1400 FWQ - 3-Axis -Accelerometer events not applicable to MiX 6000 Lte devices

Date: 2023-10-24 Time: 15:45
Parent:: [[Events]]
Friends::[[MiX6000LTE]]
Friend:: [[2023-10-24]]
JIRA:FWQ-1400 FWQ - 3-Axis -Accelerometer events not applicable to MiX 6000 Lte devices
[FWQ-1400 FWQ - 3-Axis -Accelerometer events not applicable to MiX 6000 Lte devices - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/FWQ-1400)

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

![[FWQ-1400 3-Axis Not in event templates.excalidraw]]


## Shorter Summary

- Events NOT in config
- Events SHOULD be in Template? Ask Craig Roos
- Busy checking the events, etc
- dalk default templates of so iets kan wees wat dit in die templates laat wys

## Description

3-Axis -Accelerometer events not applicable to [[MiX6000LTE]] devices on template level

```xml
<device id="-3519111760369312923" type="130" systemName="System.Logical.ThreeAxisAccelerometer" legacyId="-200037">
```

![[FWQ-1400 FWQ - 3-Axis -Accelerometer events not applicable to MiX 6000 Lte devices Logic 3axes to 6KLte.png|600]]


Only impact events triggering
DB DTCO Testing
Asset 867698043691842
asset ID 1440885069441753088
org Id=5385940956949618384
INT


## Follow the code path

### Data:

- There is no default template for MiX6000LTE
- [[SQL Get Default Event Template]]
- There are a lot of older Template Event Templates containing the 3-Axis Events
- [[SQL Get Template Event Templates with specific Events]]
- The reason these events are not selectable in the Event Templates is because they are of Default Event Type, which is excluded explicitly in code
- I will double check this business logic with the PO
### Code:

- Seeing it used to exist, let's see why it is not shown as selectable events when setting up Event Templates
	- FE: URL: GET
		- https://integration.mixtelematics.com/DynaMiX.API/config-admin/-8481193750264341014/event_templates/2667866017543810990
		- Eg. Result: {data: Events[0]: Description, EventId, EventType}
	- BE: GET_EVENT_TEMPLATE > GetEventTemplate > Events: GetAllLibraryEventsForEventTemplates
	-     ConfigAdminRepository.GetAllLibraryEvents(orgId, includeHiddenEvents: false, includeDefaultEvents: false, includeServerSide: false, includeHosViolationEvents: false) 
	-       (0, 4, 7, 8) -- All the axis events are of Default Event Type
	-       Get all library Events for current librarykey
	-       The youngest part of the code is 2 yrs, 8 months
	-  WHY 3-Axis not included anymore... (must have been in the pass)


## Findings

- There is no default template for MiX6000LTE (Which is correct)
- There are a lot of older Event Templates containing the 3-Axis Events
- The reason these events are **not selectable** in the Event Templates is because they are of Default Event Type, which is **excluded explicitly** in code
- I will double check this business logic with the PO