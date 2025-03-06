---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2023-11-20T20:27
---

# FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases

Date: 2023-11-14 Time: 19:42
Parent:: ==xxxx==
Friend:: [[2023-11-14]]
JIRA:FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases
[FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/FWQ-1403)


## Lesson

- TryParse in code ripped out leading zeros

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

## RoadMap

![[FWQ-1403 Leading 0 being dropped.excalidraw]]

## Image learned from this issue

ADD IMAGE

## Move what you learned into the bigger picture

ADD IMAGE

## Shorter Summary



## Investigation

```txt
<property id="3707347343900294912" name="PSKKey" displayLabel="PSK Key" description="Key to be used when authenticating. This is only used when WPA Pre-Shared Key is the selected wireless encryption mode." format="18" uisortorder="2900400" requiredProperty="WEPKeyMode" />

```

![[FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases Save and response Correct.png]]

- Using the stored procedure Paul mentioned, it still has the leading 0.
![[FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases Stored Proc leading zero.png]]

- I had a look at the template and overwritten tables. There was nothing in the overwritten tables, but the template still has the leading 0
![[FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases Template still has leading 0.png]]

- I will now **compile** and test,  
	- Couldn't compile yet, getting an error: https://app.logz.io/#/goto/0f8159568df6da0bacdb60df6070fb52?switchToAccountId=157279
	- But it still hasn't remove the 0
	- I will, however, get it to compile successfully before going to the upload testing part
	- [x] Jako: No speed source configured. Please remove video events that require a speed source before compiling. ✅ 2023-11-16
	- It doesnt show the WIFI part in the pending config file downloaded
- then **upload** and test
- [x] x ✅ 2023-11-20
- While I can't compile, I will override the value on Asset level and see what happens
	- Even after I override the value on asset level the DB still shows the leading zeros
	- ![[FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases Overridden Values still persist 0.png]]

- This is where I could match up the code to what they saw as an issue
![[FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases Code mapped.png]]

- I asked Paul if he could see anything, he found this
- ![[FWQ-1403 MiX6000 LTE Mobile Device Template drops leading 0 in numerical passphrases Where the 0 gets removed in a tryparse.png]]
- Description: Parsing values loaded from the database into the **BuildContext** attempts to parse them as a double. This causes numeric values to lose leading 0s. An exclusion was added for the MESA WiFi logical.

# Activity feed
## Original Story Unit

- [MiX Telematics - Configuration groups](https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/mobile-device/edit?assetId=1367869758365401088&lineId=1680383223371695241)
- assetId=1367869758365401088
- ineId=1680383223371695241
- https://app.logz.io/#/goto/0da5660012ef603922572ea0046e1daa?switchToAccountId=157279
- The DB is still OK even after compiling. Upload is requested

## The unit I am testing on INT

- [MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1159262212995481600&orgId=-8441185520557948197)
- id=1159262212995481600
- unique = 132456978132111
- orgId=-8441185520557948197
- DynamiX Test Units 2018
- GET: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-8441185520557948197/mobile-device-templates/-2503245438874984546/line-settings/1680383223371695241
- Stored Proc mentions by Paul
[[SQL Get Configuration Generation Data]]
- Overwritten tables mentioned by Paul
[[SQL Get Template and Overwritten values]]
## Ideas

- [x] Duplicate on INT ✅ 2023-11-15
- [x] Check DB, Logs ✅ 2023-11-15

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
