---
status: support feedback
date: 2023-06-26
comment: support feedback
priority: 1
---

# SR-15627 Mexico DST update

Date: 2023-06-26 Time: 22:51
Parent:: [[Command 45]]
Friend:: [[2023-06-26]]
JIRA:SR-15627 Mexico DST update
[SR-15627 MiX Vision: DST No Longer Being Applied By The Mexican Government But Server Applies DST on Video Data - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15627)

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

## Branch

- xxxxxxxxxxxxxxxxxxxxxxxxx.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

Local: 🟧 Dev: 🟨 INT: 🟩 UAT: 🟦 PROD: 🟪
🟧🟨🟩🟦🟪

## PRs

- 

## Notes

- Our current code still reads the adjustments from the instance of the DynaMiX server. In order to fix this we need to do Windows Updates for all DYnamiX servers on all environments where Mexico City is used. 
- [ ] The best would be to make use of the globalisation API. Then only one update will fix this time-zone info on all our servers, world-wide.


## Description

- We ensured the windows update was run on all these servers.
- Lutfi tried sending the command, it still doesn't work,
- [x] Check out all the values for org, site and then the message sent ✅ 2023-07-07
	- The org offset (liGMTOffset): -21600
	- AssetId: -6404508311288986358 has a legacy id of 83, which is in Site: 1234 - International ProStar 2014 - LA69269. 
		- The displaytimezone for this site is: Central America Standard Time. Google: UTC-6. (-21600)
		- Last message was: CommandID=45 ;Params=dword:0,dword:0,dword:946688400 ;
		- 946688400 indicates that there is no DST for this timezone.
		- The two dword:0 indicate that there is no difference between the site DST offset and Org DST offset, which is correct if no DST is used.
	- AssetId: 5116275758281508337 has a legacy id of 1182, which is in Site: 768 - Kenworth KW55 2015 - LE44604. 
		- The display timezone for this site is: Central Standard Time (Mexico). Google:  UTC-6. (-21600)
		- Last message was: CommandID=45 ;Params=dword:3600,dword:0,dword:1698541200 ;
		- The last value is 1698541200, which is unix timestamp for: Sun, 29 Oct 2023 01:00:00 GMT
		- This will be the next DST change 
		- dword:3600 shows the DST offset between the site and org, in this case it is correct as DST is observed according to the above value
		- dword:0 shows that after the timestamp there will be no offsett between the Org and site, which is also correct in this case
	- We now need to fnd out why Central America Standard Time has NO DST, while Central Standard Time (Mexico) does.
	- [x] Write a quick tool to check the values for this in the registry ✅ 2023-07-07
		- TimeZoneInfo siteTimeZone = TimeZonesHelper.FindSystemTimeZoneByIdCached(siteTimeZoneName);
			- I see this gets it from cache, this could potentially be an issue, but I will double check
			- To skip cache: TimeZoneInfo.FindSystemTimeZoneById(siteTimeZoneName)
		- bool hasAdjustments = timeZone.GetAdjustmentRules.Count > 0
		- OK - I will write a small up that only gets the timezone asjustments 
		- Locally I can confirm that the timezone for Mexica still does have an adjustment. The code it doing what it should.
		- [x] I will deploy this to US and have a look there to ensure it has adjustments ✅ 2023-07-07
			- This has to be on the DeviceConfig API server
Central America Standard Time
Central Standard Time (Mexico)

![[SR-15627 Mexico DST update Explain from SQL.png | 400]]
## SQL

```sql
-- Command 45

DECLARE @OrgName NVARCHAR(100) = 'MX Linde';

SELECT o.sconnectdatabase
FROM Fmonlinedb.dbo.organisation o
WHERE o.sOrganisationName LIKE '%' + @OrgName + '%'
 
--Org TZ Offset
SELECT o.sconnectdatabase, liGMTOffset
FROM Fmonlinedb.dbo.organisation o
WHERE o.sOrganisationName LIKE '%' + @OrgName + '%'

------------------------------

USE DEMOPraxair_2015;
 
 -- Get legacy Vehicle Ids
 SELECT * FROM DeviceConfiguration.mobileunit.AssetMobileUnits amu
 WHERE amu.MobileUnitKey IN (Select MobileUnitKey from DeviceConfiguration.mobileunit.MobileUnits
	WHERE MobileUnitId IN (5116275758281508337, -6404508311288986358))

-- Legacy Vehicle Id: (83, 1182)

--Site timezone
SELECT v.sDesc, s.sName, v.liSiteID, ds.GroupId, g.DisplayTimeZone, v.iVehicleID
FROM dbo.Vehicles v
  INNER JOIN dbo.Sites s ON s.liSiteID = v.liSiteID
  INNER JOIN dynamix.Sites ds ON ds.SiteID = v.liSiteID
  INNER JOIN [DynaMiX].[DynaMiX_Groups].[Groups] g ON g.GroupId = ds.GroupId
WHERE v.iVehicleID IN (83, 1182)                                                                                 -- TODO: REPLACE THIS

-- A temp table with all the LATEST command45 receiced per unit
DECLARE @dateForCommand45ToInclude NVARCHAR(20) = '2023-07-01 00:20';

SELECT m.iVehicleID, m.liMessageID, msh.liMessageID, msh.dtEntered, m.ucstate, sParams, m.dtStarts, m.sNotes, msh.sNotes, msh.dtTimeStamp, *
--Lastest command45 received
FROM dbo.messages m WITH (NOLOCK)
  INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
WHERE
      sParams LIKE '%CommandID=45 ;%'
  AND iVehicleID IN (83, 1182) 
AND dtEntered > '2023-07-01 06:09'
ORDER BY m.iVehicleID,m.liMessageID DESC

--DEVICECONFIG
SELECT TOP 50
  MessageId, MessageSubType, ParamsJson, *
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum
WHERE ParamsJson LIKE '%"CommandId":45,%'
  AND mum.MobileUnitId IN (5116275758281508337, -6404508311288986358)


```

## Microsoft news

- [Time Zone 'Central Standard Time (Mexico)' dont work properly - Microsoft Q&A](https://learn.microsoft.com/en-us/answers/questions/1195523/time-zone-central-standard-time-(mexico)-dont-work)
- This is a known issue

```c#
public static readonly Lazy<TimeZoneInfo> LazyMexicoTimeZoneInfo = new Lazy<TimeZoneInfo>(
            () =>
            {   
                const string displayName = "(GMT-06:00) México Tiempo del Centro";
                const string standardName = "México Tiempo del Centro (Horario de Siempre)";
                
                var offset = new TimeSpan(-6, 0, 0);
                var result = TimeZoneInfo.CreateCustomTimeZone(standardName, offset, displayName, standardName, null, null);

                return result;
            });
```

## Possibly fixed?

- [Mexico 2023 time zone updates now available - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/daylight-saving-time-time-zone/mexico-2023-time-zone-updates-now-available/ba-p/3749684)


## Powershell to show Timezone

[[Powershell]]
```powershell
Get-TimeZone -ListAvailable | Format-Table Id -Wrap -AutoSize | Out-String -Stream | Select-String -Pattern "Mexico"
```
```powershell
Get-TimeZone -Name "*Central Standard Time (Mexico)*"
```

## Tested on IIS20

![[SR-15627 Mexico DST update Incorrect via Powershell.png | 400]]


