---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-26T09:24
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


VisionAI 360
	- Module: Safeguard
		- Events
			- Assign risk Classification

on-Road IoT
	- New **Events**
		- No video
		- default type
		- no configurable
		- visible on Trip timeline

**Requirements**

1. Create the following VisionAI 360 events in On-road IoT:  
    - [x] MiX Vision: Safeguard extremely high risk ✅ 2025-06-25
    - [x] MiX Vision: Safeguard high risk ✅ 2025-06-25
    - [x] MiX Vision: Safeguard medium risk ✅ 2025-06-25
    - [x] MiX Vision: Safeguard low risk ✅ 2025-06-25
2. [x] The events should display as **default** event type. ✅ 2025-06-25
3. [x] The events must **not record video** as users will navigate to the VisionAI 360 module to view videos. ✅ 2025-06-25
4. [x] The events must **not be configurable** as configuration is done on the VisionAI 360 platform. ✅ 2025-06-25

**Acceptance criteria**

1. The risk events display as default events in the library. The events are not configurable.
2. The events are **visible on Trip timeline**.

**Testing notes:** 
- [ ] In order to test, **enable Safeguard** for an asset and trigger risk events from the platform.
Config team do dev and testing to do Verification on this ticket.
End to end will be with the AI Vision team.

**Branch**: Config/MR/Feature/OPEN-250_SafegaurdEvents


## Testing

Spoke to Zonika. The "extra things" like "linking" is not something we will do. We just need these events as defaults in the library.
It must be possible to make them available. After this there is an API call on which the available events will be listed for another team to be used.

Zonika will ask Stephan if there are any Safeguard assets on INT to test with.
 

## SP 2

- [x] [PR DEV](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/126568?_a=files) ✅ 2025-06-25
- [ ] [PR INT](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/126567?_a=files)

## Branch

> Branch: Config/MR/Feature/OPEN-250 New VisionAI Events.INT

