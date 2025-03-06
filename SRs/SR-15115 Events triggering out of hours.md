---
status: closed
date: 2023-04-18
comment: 
priority: 8
---

# SR-15115 Events triggering out of hours

Date: 2023-04-18 Time: 09:04
Parent:: [[Command 45]]
Friend:: [[2023-04-18]]
JIRA:SR-15115 Events triggering out of hours
[SR-15115 Events triggering out of hours - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15115)


## Description

- Environment ZA
- Org Name TotalEnergies-MS/AFR-South Africa-HV-D
- AssetDB name TotalSouthAfrica_2016
- OrgId (Legacy) 3943
- Company id: -32212
- Org id 5116439464470248035
- Asset Id: 1290745962778677248

## SQL


![[SQL Command 45 Organisation Offset#Organisation Information]]

![[SQL Command 45 Asset Offset#Asset Information and Site Offset]]

![[SQL Command 45 Asset Auditing]]

![[SQL Command 45 Messages Sent#Messages Sent FM and Mesa]]


## First findings

In short, I can see 3 command 45s for this unit.  
- [x] TODO: PAUL: What initiated each of these commands?
  
![[SR-15115 Events triggering out of hours Command Cancelled.png]]

You will see the first two have the same values Riaan was expecting. 
For some reason, the second one was cancelled and another was completed (3rd one with the incorrect value).
- [x] TODO: PAUL: Look for **Message Ids** to try and work out the order of events.... maybe more can be seen?
- [x] TODO: PAUL: Why was the 2nd one cancelled? Ask Paul if Config compile could be the reason.
- [x] TODO: PAUL: How did the 3rd one get incorrect values? Tried looking at **Audits**. Maybe revisit this.
- [x] TODO: PAUL: Ask Paul what he thinks might have cause the change... config reset? Show images.
- [x] TODO: PAUL: Double check Audit Tables again

I have had a look at the **audit tables**. 
I can’t find anything indicating why the timezone would have changed between the 2nd and 3rd command seen. 
No site or org changes that would explain this.

The only other thing I could think of is the device was decommissioned just before the 2nd and 3rd command was sent. 
Maybe some data was not yet correct, but this is the best guess.

![[SR-15115 Events triggering out of hours.png]]

I will investigate further asap.

## Second Findings

- GMTOffset: 7200
- Is DisplayTimeZone the correct one? Check code: "South Africa Standard Time"
- Online: Above is 7200
- fixedPastDateTime? 946688400 YES DateTime(2000, 01, 01, 01, 00, 00) 
- SO no deviation
- At the END when SENDING it adds the OrgOffset to the param 1 and 2

### PROBLEMS

- secondsBefore = siteSecondsOffset - orgSecondsOffset; //param1: Offset before deviation - Offset Org [should be 0, but was 7200]
- secondsAfter = siteSecondsOffset - orgSecondsOffset; //param2: Offset after deviation - Offset Org [should be 0, but was 7200]
- ctime = ConvertToCTime(fixedPastDateTime [This was correct... 2000/01/01 ...]
- [x] Why are the parameters used incorrect... from my above findings they should be 0... from the DB... except if the OrgOffset gets UTC somehow... ✅ 2023-05-25
	- The above wasn't incorrect, in the API it then again adds the Org offset...

## Next Step

- First duplicate this incorrect 7200
	- INT
	- Org: Shehaam's Test Units
	- DB: DynaMiXTestUnitsV2_2014
	- MiX4000
	- Asset: (with site of "South Africa Standard Time"):  
		- MiX 4K 3D CRAIG
			- id=3772523737395817690&orgId=6047289984099389068
			- MiX4k
			- /daylight-savings
			- swagger: http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/MobileUnitCommands/MobileUnitCommands_SendDaylightSavingsCommandToMobileUnits
```txt
{
"GroupIds": "6047289984099389068",
"MobileUnitIds": "3772523737395817690",
"TypeIds": ""
}
```

- Test locally
	- Swagger
		- [Swagger UI](http://localhost/DynaMiX.DeviceConfig.Services.API/swagger/ui/index#!/MobileUnitCommands/MobileUnitCommands_SendDaylightSavingsCommandToMobileUnits)

- DB TEST
```sql
SELECT TOP 50
  MessageId, MessageSubType, ParamsJson, *
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum  WITH (NOLOCK)
WHERE ParamsJson LIKE '%"CommandId":45,%'
AND mum.MobileUnitId = 3772523737395817690
Order by CreationDateUtc DESC
```

- Then create a test and swagger end-point
- [x] Then ensure the values we get from FLEET is the same as we get from SQL
	- Might be a different value... like 0
- [x] Write a TEST (temp) to get values for that org and site and calculate the params
	- deviceIntegrationManager.SetCommandParameters(authToken, orgId, firstSiteGroupId, out secondsBefore, out secondsAfter, out ctime);
	- var commandParams = deviceIntegrationManager.GetCommandString(authToken, secondsBefore, secondsAfter, ctime);
