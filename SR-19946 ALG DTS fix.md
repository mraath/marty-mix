---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-19T10:20
---

# SR-19946 ALG DTS fix

Date: 2025-03-19 Time: 08:46
Parent:: [[DST]]
Friend:: [[2025-03-19]]
JIRA:SR-19946 ALG DTS fix
[SR-19946 Time Adjustment tool in OMAN - Jira](https://csojiramixtelematics.atlassian.net/browse/SR-19946)

Similar to:: [[SAAS-10447 DST Tool in OMAN 18.17]]

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

We got it sorted in OMAN
- [[OMAN DST Command 45 Setup]]
Now we just need to figure this out for ALG

## Finding the server

- ~~HSATSIIS06~~
- ~~HSATSIIS07~~
- ~~HSATSIIS11~~
- ~~HSATSIIS12~~
- Searched Jira:
	- HSATSDMXIIS01
	- HSATSDMXIIS02
	- HSATSMCIIS04
	- HSATSAPC04
	- HSATSAPP09
- Aaaarrrggghhhh - check [[Production Servers]] for **ATS**
	- HSATSDCSIIS01
	- **HSATSDMXIIS01**,02
- Copying the FMTimeAdjuster api > zip > teams online > above ALG server
- Copied the FMTimeAdjuster app > zip > teams online > ALG Jumpbox
- Busy activating the API on the IIS

## Setting up in ALG

### Setting up the API

- I copied the FMTimeAdjuster API from OMN IIS to ALG HSATSDMXIIS01
- ON HSATSDMXIIS01, the API is running: http://localhost/DynaMiX.DeviceConfig.FMTimeAdjuster.Api

![[SR-19946 ALG DTS fix API Running.png]]
- **Please note**: It could be that the config file still has some OMN settings. I had a quick look, but we will need to ensure this is in order when we test.

### Setting up the APP

- I copied the old 18.17 app from OMN Jumpbox to ALG Jumpbox.
- It seems to be running there

![[SR-19946 ALG DTS fix App Running.png]]
- **Please note**: We just need to test this. I don't have logins for this server currently. I will speak to Russell re testing this.
