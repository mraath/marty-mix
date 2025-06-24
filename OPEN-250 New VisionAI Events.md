---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-24T14:44
---

# OPEN-250 New VisionAI Events

Date: 2025-06-24 Time: 14:40
Parent:: ==xxxx==
Friend:: [[2025-06-24]]
JIRA:OPEN-250 New VisionAI Events
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-250)

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

## Description

**Overview**

The Safeguard module in VisionAI 360 identifies risky driving behaviour and assigns a risk classification to these events. Currently these events are exposed within the VisionAI 360 platform only, however going forward we want to expose these on-Road IoT as well. For now, no video will be requested for these events.

**Requirements**

1. Create the following VisionAI 360 events in On-road IoT:  
    MiX Vision: Safeguard extremely high risk  
    MiX Vision: Safeguard high risk  
    MiX Vision: Safeguard medium risk  
    MiX Vision: Safeguard low risk   
2. The events should display as default event type.
3. The events must not record video as users will navigate to the VisionAI 360 module to view videos.
4. The events must not be configurable as configuration is done on the VisionAI 360 platform.

**Acceptance criteria**

1. The risk events display as default events in the library. The events are not configurable.
2. The events are visible on Trip timeline.

**Testing notes:** In order to test, enable Safeguard for an asset and trigger risk events from the platform.

Config team do dev and testing to do Verification on this ticket.

End to end will be with the AI Vision team.

## SP 2

### FE
- [ ] Task 1
      PR: xxxxxxxxxx

### BE
- [ ] Task 1
      PR: xxxxxxxxxx

### DB
- [ ] Task 1
      PR: xxxxxxxxxx

## Branch

> Branch: Config/MR/Feature/OPEN-250 New VisionAI Events.INT

