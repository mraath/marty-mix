---
created: 2023-08-31T07:41
updated: 2024-06-27T08:54
---

Parent:: [[Command 45]]

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

## Background

- Set ==clock== on the Mobile Unit
	- Org TZ
	- Site TZ
	- Asset TZ
- When moving to a site, new config
- <mark class="hltr-red">ERROR</mark>: Sometimes the command doesn't go through
	- MANY SRs
	- Many hours
	- Can check SQL
- <mark class="hltr-green">FIX</mark>:
	- Nightly DST **service**
	- Added a **tool** to force send it to the mobile unit


## The original server

- Code snippet
```file
C:\Projects\DynaMiX.Backend\Services\Daylight Saving Adjustment\DynaMiX.Services.DaylightSavingAdjustment\DaylightSavingAdjuster.cs
```
- Diagram 
![[Command 45.excalidraw]]


## DST Tool enhancement (Mobile Units)

- Looks on the Jumpbox
![[CONFIG-3387 App or Report for Command 45 UI Tool Change.png | 600]]
- Old Tool
![[Command 45 App Workflow.png]]

- Enhancement Idea
	- ![[Config-3387 App Command 45 redesign.excalidraw]]
	- 
		- ![[CONFIG-3387 App or Report for Command 45 Missing Messages Report Design.png]]

 
 - Enhancement
	 - Getting outdated DST commands ==SProc==
```file
C:\Projects\_MiXTelematicsFiles\SQL\SRE-105_WIP.sql
```
- Swagger and Stored proc
	- Sending the commands
	- Screenshot
		- DB Stored Proc is on DEV
		- ![[CONFIG-3387 App or Report for Command 45 Stored Proc exists.png | 400]]
		- Swagger end-points are on DEV
		- ![[CONFIG-3387 App or Report for Command 45 Swagger End points.png | 400]]
	- Tool Look and feel
	- ![[CONFIG-3387 App or Report for Command 45 Tool working on DEV.png | 400]]


## DST Service move to our API

- Reuse Tool enhancement for ==Mobile Units==
- ==Organisation== settings porting
- Move to API
	- ![[TECHDEBT-190 Move DST to API]]
```file
C:\Projects\_MiXTelematicsFiles\SQL\TECHDEBT-190 Get Organisation Info.sql
C:\Projects\_MiXTelematicsFiles\SQL\TECHDEBT-190 Organisation Daylight Savings Adjustments AssetDB Dynamic SQL.sql
```
- Swagger Test
- Log showing results
	- Log: https://app.logz.io/#/goto/0677d7733267f1d4a9048d9f5fb2f4c5?switchToAccountId=157279
	- Total time: 23:48:11 to 23:48:14 > 3 seconds (121 Orgs, 64 Assets)
	- This is amazing. There were some errors sending some commands, which are normal, however, the speed at which this happened is a huge advance.
	- File: ![[Discover 2023-08-28T23_48_11.798Z - 2023-08-28T23_48_14.681Z.csv]]
- Final questions
	- Globalisation API (Future Story)
	- How to kick this off with ==Azure==?
	- OK to set timeout to ==120s== for SProc?
	- OK to run all assets as currently?
	- Merge final to INT
	- Test final swagger
	- Test final tool

