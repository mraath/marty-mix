---
status: closed
date: 2023-06-23
comment:
priority: 7
---

# QA-5861 Command 45 not sent when site changes

Date: 2023-06-23 Time: 11:14
Parent:: [[Command 45]]
Friend:: [[2023-06-23]]
JIRA:QA-5861 Command 45 not sent when site changes
[QA-5861 Call not created for 'Update asset timezone deviation' Command to display on Info hub when changing site on the Assets details page - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-5861)

## Branch

CHAD fixed something

## OUTSTANDING WORK in this file

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

## PRs

- 

## Related?

- [[SR-15476 Command 45 not sent when moving between sites]]

## Description

- SendTimeZoneDeviation
- mum.IsDeviceEnabled(mobileUnitId, LogicalDevices.REMOTE_COMMAND
- 		public const long REMOTE_COMMAND = -7255325733681205281
- [mobileunit].[MobileUnit_IsDeviceEnabled]
- Remote Command IS enabled for this device. This is usually the reason why it doesn't go through.
- OK - This is a SUB bug of the original bug. Seems (from the original bug) that command 45 IS sent, the Info hub is just not reflecting this
	- [x] Group Drag ✅ 2023-07-26
		- [x] Test DB ✅ 2023-07-26
		- [x] Test Log ✅ 2023-07-26
		- [x] Test Infohub ✅ 2023-07-26
	- [x] Site Drop down change ✅ 2023-07-26
		- [x] Test DB ✅ 2023-07-26
		- [x] Test Log ✅ 2023-07-26
		- [x] Test Infohub ✅ 2023-07-26

```sql
/*
Organisation = QA Live Lightning
orgId=-3050897502994317689
Asset = JCB 722 Dump Truck 31 垃圾车   
Asset ID = 31   
Device type = FM 3607i/3617i   
id=1167982794832834560
*/

DECLARE @OrgName NVARCHAR(100) = 'QA Live Lightning';

-- TODO: REPLACE THIS WITH THE SITE NAME
SELECT o.sconnectdatabase
FROM Fmonlinedb.dbo.organisation o
WHERE o.sOrganisationName LIKE '%' + @OrgName + '%'

--Org TZ Offset
SELECT o.sconnectdatabase, liGMTOffset
FROM Fmonlinedb.dbo.organisation o
WHERE o.sOrganisationName LIKE '%' + @OrgName + '%'

------------------------------
USE QALiveLightning_2019;

--Site timezone
SELECT v.sDesc, s.sName, v.liSiteID, ds.GroupId, g.DisplayTimeZone
FROM dbo.Vehicles v
  INNER JOIN dbo.Sites s ON s.liSiteID = v.liSiteID
  INNER JOIN dynamix.Sites ds ON ds.SiteID = v.liSiteID
  INNER JOIN [DynaMiX].[DynaMiX_Groups].[Groups] g ON g.GroupId = ds.GroupId
WHERE v.iVehicleID = 31                                                                                 -- TODO: REPLACE THIS

-- A temp table with all the LATEST command45 receiced per unit
DECLARE @dateForCommand45ToInclude NVARCHAR(20) = '2021-04-17 00:20';

SELECT top 2 m.liMessageID, msh.liMessageID, msh.dtEntered, m.ucstate, sParams, m.dtStarts, m.sNotes, msh.sNotes, msh.dtTimeStamp, *
FROM dbo.messages m WITH (NOLOCK)
  INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
WHERE
      sParams LIKE '%CommandID=45 ;%'
  AND iVehicleID = 31
ORDER BY m.liMessageID DESC
```




- According to UAT the ORG site move works, but not the ASSET site change. 
	- [x] Ensure from Fleet they use the same end-point for both calls. ✅ 2023-07-26
- [x] Next I would suggest to check the logs and do a test. Maybe that command is never sent (which Chad seems to elude to) ✅ 2023-07-26
- [x] Then check the end-point with this unit, if it works, then double check with Chad how they call it. ✅ 2023-07-26

## Testing Info Hub on UAT

- The **asset** mentioned in the issue: (Asset = JCB 722 Dump Truck 31 垃圾车 | Asset ID = 31 | Device type = FM 3607i/3617i | id=1167982794832834560)
- Before changing the Site it's values were: (Site = Excavators | DisplayTimeZone = South Africa Standard Time (UTC + 2, without DST))
- After changing the Site: (Site = Marty UTC -5 | DisplayTimeZone = Eastern Standard Time (UTC - 6))
- Message received in Asset **DB**: None (This means the Command never successfully made it to the DB) (It had an error OR was never sent)
- **Info Hub**: No new message (There won't be as the message was neveer sent according to DB)
- Log: https://app.logz.io/#/goto/ab338e9375e514dbe559ad809ae60f47?switchToAccountId=157279
	- Message found: Device config SendTimeZoneDeviation/UpdateConfigStatus code not working, while trying to update AssetId: ==1167982794832834560==, the rest of the code will continue
	- I think Fleet team should investigate around this error. Maybe put a break point or just see why this was logged.
 - I then tried more Command 45 options for the Log:  https://app.logz.io/#/goto/fdc14ff3d397f38d50f0095ce6b8c90d?switchToAccountId=157279
	 - Only the previously mentioned one stood out.
- **NEXT**: I will call command 45 on this asset using out client and see what happens.

### Testing the client on UAT

- I ran a utility to make use of our DeviceConfigClient to call the SendTimeZoneDeviation method
- Org Id used: -3050897502994317689
- Asset Id used: 1167982794832834560
- Once I ran this I immediately saw the **message** in the asset **DB**
![[QA-5861 Command 45 not sent when site changes Message received in Asset DB.png | 400]]
- I also immediately saw the message in **Info Hub**
![[QA-5861 Command 45 not sent when site changes Message in Info Hub.png | 400]]

## Test the same using the client directly

- Making use of our existing test app for the client, I made it point to SendTimeZoneDeviation for the mentioned org and unit.
- The logs and DB shows nothing.
- 
- [x] I will next check for any Command 45 specific logs ✅ 2023-07-26
- Command 45 Logs: xxxxxxxxxxxxxx
- Almost all possible Logs for DST: https://app.logz.io/#/goto/14f46493a9b299426cb7e0770a5d45e4?switchToAccountId=1572794
- Simplified: https://app.logz.io/#/goto/62a5351ef3eca4b974d0698346714fbf?switchToAccountId=157279
- Maybe best for UAT: https://app.logz.io/#/goto/05ab73883d113b835d394c70f114172e?switchToAccountId=157279
- Now if we hit swagger directly for this asset, will it send?
- On UAT, I opened a browser, ran swagger directly: 

### ALL txt
```txt
DST Manager
FAILURE: Remote message
send-timezone-deviation
SendTimeZoneDeviation
Sent TimeZone Deviation
Send TimeZone Deviation
SetMobileUnitCanProtocol Exception Response
SendCommandToMobileUnit
SendCommandToMobileUnit
FAILURE: Message was 0
Message Id was 0
Received SendCommandToMobileUnit Request
Unsupported device type
Unsupported command type
Not all required logical devices connected
Command parameters invalid
Command sending failed
No SatComms device attached
Command sent to GPRS Service (CommandId=UpdateAssetTimezoneDeviation
```
### Simplified txt
```txt
Unsupported device type
Unsupported command type
Not all required logical devices connected
Command parameters invalid
Command sending failed
No SatComms device attached
FAILURE: Remote message
FAILURE: Message was 0
Message Id was 0
DST Manager
TimeZone Deviation
UpdateAssetTimezoneDeviation
send-timezone-deviation
SendTimeZoneDeviation




-- Leaving this out
SendCommandToMobileUnit
	Invalid transport specified
SetMobileUnitCanProtocol Exception Response
```

## Investigation

![[QA-5861 Asset Site Time Command 45 not sent.excalidraw | 500]]

## Message to Chad

Hi Chad, I hope you are well.

1) I am looking into QA-5861. Basically Command 45 (Daylight Savings) is not being sent when changing the Site within the Asset Details page.
2) This is a very similar issue to SR-15476 (Dragging asset between sites in Org Groups didn't send DST), you fixed this one.

Are you doing the same call in # 1?

## Chad's reply

So as far as I know, SR-15476 (Closed) was still about the assets details page. 
It was resolved at the time because it fixed the specific issue on the SR and Sizaan found another issue so she logged that QA bug.

The reason the dragging works is because that still uses the old entity  framework and other dynamix calls in dynamix.backend. The asset details page now uses the config api
(new one in Fleet.Services)

![[QA-5861 Command 45 not sent when site changes New Fleet Services Code.png]]

This is what is done in DynaMiX
![[QA-5861 Command 45 not sent when site changes Done in DynaMiX OLD BE Code.png]]

So only FS  all I  do is call the  config api.
There are other  things done in the DynaMiX DeviceIntegrationManager. So I am not sure if all that logic was  moved over to the Config Api call

## More thoughts

For # 2 fix, on June 5, 2023 at 11:02 AM you said "I have added the call required by config. The call was not moved over to Fleet.Services for the new Asset Details Frangular page".
The same call for # 1 will need to be made for command 45 to be triggered.

You mentioned in # 1 that you:
- Use SendTimeZoneDeviation
	- I assume by making use of the DeviceConfigClient.
	- Which did you use for # 2 fix above?
- This hits the end-point (send-timezone-deviation)
- This will go to mucm.SendCommandToMobileUnit
Later you mentioned:
- I have noted that another call is supposed to be made that was not moved over from DynaMiX.Backend to Fleet.Services. (UpdateConfigurationStatus). I have added it as part of this bugfix since it was missing as well. This could be part of the problem. However, please note that I have tested this on Integration and it still does not create the feed message so will still need to be investigated by config.

- [x] Logs for SendCommandToMobileUnit ✅ 2023-07-20

C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitConfigurationManager.cs
Line 294 has UpdateConfigurationStatus
A few lines down SendTimeZoneDeviation

Route: UpdateConfigurationStatus
Calls: mucm.UpdateConfigurationStatus
Route? update-configuration-status (UpdateConfigurationStatus)




