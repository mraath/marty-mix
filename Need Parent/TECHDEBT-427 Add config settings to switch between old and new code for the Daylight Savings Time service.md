---
status: busy
date: 2023-09-22
comment: 
priority: 1
created: 2023-09-22T09:00
updated: 2024-06-27T08:57
dg-publish: true
dg-home: 
---

# TECHDEBT-427 Add config settings to switch between old and new code for the Daylight Savings Time service

Date: 2023-09-22 Time: 09:00
Parent:: [[Command 45]]
Friend:: [[2023-09-22]]
JIRA:TECHDEBT-427 Add config settings to switch between old and new code for the Daylight Savings Time service
Jira: [TECHDEBT-427 Add config settings to switch between old and new code for the Daylight Savings Time service - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/TECHDEBT-427)

Friend::[[TECHDEBT-190 Move the DST Service to the DeviceConfig Repo]]]


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

This has been replaced by the <mark class="hltr-pink">housekeeping tool</mark>.
We just need to remove the service from the BE.

## DEPENDS ON TECHDEBT-190:

![[TECHDEBT-190 Move the DST Service to the DeviceConfig Repo#TODO]]

## Concept

![[TECHDEBT-427 DST Setting for new Logic]]



### 2023-10-24

Async work is still not on INT:
![[TECHDEBT-427 Add config settings to switch between old and new code for the Daylight Savings Time service Async work on on INT.png]]



## Description

While working on: [[TECHDEBT-190 Move the DST Service to the DeviceConfig Repo]]
JIRA: [![](https://csojiramixtelematics.atlassian.net/rest/api/2/universal_avatar/view/type/issuetype/avatar/10311)TECHDEBT-190: Move the DST Service calls to the DeviceConfig RepoCLOSED](https://csojiramixtelematics.atlassian.net/browse/TECHDEBT-190)

We saw that the [[Async work]] for INT is still to be rolled out. 
We will add a [[Config Setting]] which will indicate weather or not the [[DynaMiX.Services.DaylightSavingAdjustment]] should make use of the old or new DST logic.

## Depending on TECHDEBT-190

[[TECHDEBT-190 Move the DST Service to the DeviceConfig Repo]]
## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Code investigation

### Code

- Code: C:\Projects\DynaMiX.Backend\Services\Daylight Saving Adjustment\DynaMiX.Services.DaylightSavingAdjustment\DaylightSavingAdjustmentService.cs
	- [x] Add the switch at the TODO: MR: ✅ 2023-11-01
### Client

- Use this client call with the switch:
	- Method to hit: [[AdjustDaylightSavingsForOrganisationsAndMobileUnitsMethod]]
	- [x] Create the method on the [[MiX.ConfigInternal.Api.Client]] ✅ 2023-11-01
	- 

## Testing
- [x] [[Run or test windows Service as Console app]] ✅ 2023-11-01


