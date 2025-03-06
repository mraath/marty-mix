---
status: testing
date: 2023-07-21
comment: 
priority: 7
created: 2023-07-21T16:58
updated: 2025-03-06T12:00
---

# Tel-84 Command sent twice

Date: 2023-07-21 Time: 16:58
Parent:: [[Command]]
Friend:: [[2023-07-21]]
JIRA:TEL-84 Command sent twice
[TEL-84 Multiple commands seems to be sending when sending "request current position" command - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/TEL-84)

## Outstanding in this file

- [ ] Local: 🟧 
- [ ] Dev: 🟨 
- [ ] INT: 🟩 
- [ ] UAT: 🟦 
- [ ] PROD: 🟪

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

## Branch

- Tel-84 Command sent twice.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...
- **Common**: XXX Branch Name
	- [ ] Local files committed
		- [ ] Local Nuget: xxxName
	- [ ] PR DEV: xxxURL
		- [ ] Nuget DEV: xxxName
	- [ ] PR INT: xxxURL
		- [ ] Nuget INT: xxxName
- **Client**: XXX Branch Name
	- [ ] Local files committed
		- [ ] Local Nuget: xxxName
	- [ ] PR DEV: xxxURL
		- [ ] Nuget DEV: xxxName
	- [ ] PR INT: xxxURL
		- [ ] Nuget INT: xxxName
- **API**: XXX Branch Name
	- [ ] Local files committed
	- [ ] PR DEV: xxxURL
	- [ ] PR INT: xxxURL

## Testing notes

- What to test
- Passed or failed with images

## Description

- request current position
- RequestCurrentPosition
	- In: C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\Tracking\LiveTrackingModule.cs
- var result = DeviceConfigClient.MobileUnitCommands.SendCommandToMobileUnit(authToken, organisationId, mobileUnitId, (int)commandId, transportMethodId, null, null, null).ConfigureAwait(false).GetAwaiter().GetResult();
- **SendCommandToMobileUnit**
- Org: MT Test Org
- Asset: 2 New Teltonika FM3001
- AssetID: 1413244958288154624
- IMEI: 867060033914892
- Live Tracking (Legacy)
- orgId: -7950239061577934052

## Further Investigation
- BE: LiveTracking: Jako Malan - May 2023 (Client)
	- How is this client set up? Also for elastic - maybe irrelevant
- BE: CommandManager: Thiren - May 2023 (Client)
	- Same question
- Client: MobileUnitCommandsRepository: Thiren - July (_httpNoRetriesButWithElasticStrategy)

## Running Tests

- Client App (get all info from BE and push it in)
- DB Test: [C:\Projects\_MiXTelematicsFiles\SQL\Command Teltonika TEL-84.sql](file:///C:/Projects/_MiXTelematicsFiles/SQL/Command%20Teltonika%20TEL-84.sql)
- Log: https://app.logz.io/#/goto/a3e11df8633511e5ab19144095d02a70?switchToAccountId=157279


## Message to Marvin

Hey Marvin
I will still do another test, but I can confirm that thing is CRAZY! :-)
It sent 578 messages at the time of me writing this :-)
Think something is MESSED UP in that retry strategy

I will do one more test, but I will write my findings in that issue,
re-open the issue, and assign to Jako or Thiren as they worked on that code last, so should know more :-)

- [x] Add this to the Jira item ✅ 2023-08-02

After talking to Marvin I had a quick look at that **database**.
At the time of writing it already added 578 entries to the database.

```sql
SELECT top 1000 * 
FROM dbo.Commands
WHERE IMEI = 867060033914892
AND DateTimeLastSent > '2023-08-01'
ORDER BY DateTimeLastSent DESC

-- Rows: 578
-- First sent: 2023-08-01 09:27:20.087
-- Last (for now): 2023-08-02 01:20:01.390
```

The **log** also shows a LOT of activities: https://app.logz.io/#/goto/a3e11df8633511e5ab19144095d02a70?switchToAccountId=157279

I THINK it has to do with the **retry strategy** as previously mentioned.
It could also be that comms has its own retry strategy, because I see 3 entries every 5 mins.
I had a look at the devs who last worked on this and will ask them to investigate further.


# "C:\Projects\_MiXTelematicsFiles\SQL\SRE-105 TEST Messages Sent.sql"
## Observation

- The method (SendCommandToMobileUnit) in the client used to follow the default HttpRetries strategy as previously expected.
- In order to fix the multiple sending of the IMEI, we introduced this: _httpNoRetriesButWithElasticStrategy
- The duplicate sending of commands to mobile units was also noted while testing Command 45.
	- The two best ways forward I could think of:
		- We could introduce something like: _httpNoRetriesButWithElasticStrategy
		- We could also first check if the command has been sent before resending it.
	- I see httpNoRetriesButWithElasticStrategy was introduced for this command two weeks ago, by Thiren.
		- From what I can see it is already on INT, if INT is using the latest client.
		- I will do a few tests
		- Last 15 Mins: https://app.logz.io/#/goto/cdcd828ee45391bae352e6a2c70753e8?switchToAccountId=157279
		- I only got 1 hit, so it seems OK
		- ![[Tel-84 Command sent twice 1 Hit for command sent.png | 400]]
		- 
		- 
		- DB: 
			- ![[QA-5849 GetStatus Command not populating table#SQL Used]]
  

## Drawing

![[Tel-84 Send Command multiple times.excalidraw]]