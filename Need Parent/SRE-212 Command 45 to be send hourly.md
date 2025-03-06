---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-05-03T14:28
---

# SRE-212 Command45 to be send hourly

Date: 2024-03-25 Time: 15:42
Parent:: [[Command 45]]
Friend:: [[2024-03-25]]
JIRA:SRE-212 Command45 to be send hourly
[JIRA](https://csojiramixtelematics.atlassian.net/browse/SRE-212)

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

## Summary

- Project: DynaMiX.DeviceConfig.Utilities.DaylightSavingsTimeAdjusterCommandline
- Branch: Config/MR/Feature/SRE-212_Command45Hourly24.7.ORI
## Description

IDC: SYD

Org: Chevron - Barrow Island

- [x] OrgID: -2028909786913159060 ✅ 2024-04-05
- [x] Unit type: Only MiX4000 ✅ 2024-04-05

Current total asset count: 652

- [x] We need to automatically run the command 45 sending utility for the next 4 weeks for Chevron Barrow Island ✅ 2024-04-05

The command should be sent every hour to all MiX4000s in the org

- [x] It can be switched off after 4 weeks ✅ 2024-04-05

## Data to use on INT

I ran this with no Ids...
[state].[MobileUnitMessages_GetLatestDaylightSavingsCommands]
Then copied all results to excel
Then filtered for those without commands, with imei
Then tested the ASSETID against swagger
Then used it

[[SRE-212 Test Data Command 45]]


-7950239061577934052 (1)
-2318086964065689932 (0)
-8437676598591279767 (0)

## Automatically send

- Get AuthToken
- Hourly
	- Get Outdated DST Commands
	- Select all and send
		- Send Daylight Savings Command(s)
	- Show errors

- INT ORG TEST: -1983255592473789111
	dstCommand.GroupIds = "-7950239061577934052"
	
AssetIds:
1407712035682283520
1336405323247910912
1425236008474427392
1433132660917985280
1433133363820531712
1433133124002701312
1407712035682283520,1336405323247910912,1425236008474427392,1433132660917985280,1433133363820531712,1433133124002701312

ORG TO TEST AGAINST: -1983255592473789111
## SQL

- [[SQL Command 45 Clean Mesa Messages per AssetId]]

## TESTING 20240327

![[SRE-212 Command45 to be send hourly.png|700]]
![[SRE-212 Command45 to be send hourly Actual Sending.png|700]]


## PRS

- Initial: [INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/100324)
- Hourly Authentication: [Auth INT](https://mixtelematics.visualstudio.com/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/100600)

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Leonardo Issue

![[SRE-212 Command45 to be send hourly Check this Asset.png]]

- [MiX Telematics - Assets](https://au.mixtelematics.com/#/fleet-admin/asset/commissioning?id=-5738957575013785595&orgId=-2028909786913159060)
- https://au.mixtelematics.com/#/fleet-admin/asset/commissioning?id=-5738957575013785595&orgId=-2028909786913159060
- IMEI: 863427060328359
- 4K
- AssetId: -5738957575013785595
- 