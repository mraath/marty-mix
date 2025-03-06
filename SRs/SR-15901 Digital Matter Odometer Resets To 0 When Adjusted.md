---
status: closed
date: 2023-10-03
comment: 
priority: 1
created: 2023-10-03T14:08
updated: 2024-10-02T13:17
---

# SR-15901

Date: 2023-10-03 Time: 14:08
Parent:: [[DME]]
Child:: [[Odometer]]
Friend:: [[2023-10-03 1]]
JIRA:SR-15901
[SR-15901 Digital Matter: Odometer Resets To 0 When Adjusted - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15901)

## Shorter Summary

Yubbies, etc must now be set as DME
Also happens on M4K and M2K
Check flow of code
- [ ] Debug in Jako's code section to see what happens for DME

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

### Oyster units with issues

[[AU]]  
BMR Logistics  
OrgId=-8400939365829350376  
   
[[Oyster]]  
IMEI: 356726109918136  
Vehicle ID: 53  
AssetId=1392855913680777216  
First Adjusted Odometer: 428 808  
Current Odometer: 17 557  
   
IMEI: 359215100810101  
Vehicle ID: 52  
AssetId=1392855320593387520  
First Adjusted Odometer 437 375  
Current Odometer: 10 726

Reported Issue: 2 x Oyster updated the odometer and **after few hours it resets** to the **total KLMS** its done since installed.
you can see in my image taken i took screenshot with them updated and it took them

### What he thinks might happen

The odometer was adjusted prior to the unit being used (09/6/2023) as seen from the Asset page screenshot, however **after a few trip** the dealer noticed that the odometer has **jumped back**. I get the feeling that even though the odometer was **adjusted and showed** on the [[Asset details]] page the **trips started recorded from 0km instead** of the adjusted. Looking at the [[detailed trip report]] the trips all **started with a 0km** value.

### More

The odo was adjusted a second time on 12-07-2023 and reset again to 0 (2nd screen shot)
I have checked and both units are running the **latest FW**.
Only **added UDP from installation**. Let me know you require any additional dates.
Can you please investigate why the Odo keeps resetting to 0 and suggest a possible fix.

![[SR-15901 Digital Matter Odometer Resets To 0 When Adjusted Image 1.png]]

![[SR-15901 Digital Matter Odometer Resets To 0 When Adjusted.png]]

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Notes from SR meeting

- Version of Teltonika devices? Related? Think not? Check code.

- [x] Process of Odo set [[Command]] sent to [[Comms]] for Device? Not sent, just Odo saved in State and Vehicle tables ✅ 2023-10-12
	- [x] Fire forget? (save with awaits) ✅ 2023-10-12
	- [x] Exception on Comms? na ✅ 2023-10-12
	- [ ] Does Fleet or someone just Reset (Still need to find out next)
- Many paths...
- [x] Best to first check with PO ✅ 2023-10-03
	- Do all support it?
	- ![[Oyster#SR Gotcha]]
		- They are correctly set as DME

## Chat met Heinrich


Nou goeie chat met Peter gehad. 
Daar is blykbaar 2 odo fields, maar hoe die waardes dar uitkom weet ons nie.
Odo waarde kom saam met elke pakkie in, en Config apply net die [[offset]].
Hierdie lyk nie na 'n ofset issue nie want die waarde gaan terug na 0 toe in die [[diagnostics modal]].
Probleem hier is dat die odo in die Asset list is nie gelyk aan die waarde in die diagnostics modal nie.
En net om dit beter te maak - dit gebeur op die [[MiX2000]] en [[MiX4000]] ook ![😬](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/1f62c_grimacingface/default/30_f.png?v=v7)
Ek het my findings op daai ticket van jou as 'n comment gesit

## Helpful Comments From Jira

### Shashi Behari 

12 September 2023 at 15:27
It seems like the odo on these is now correct, so it is difficult to diagnose
I have added the following properties to the [[MobileUnitStateHistory table]] in order to gather more information when this occurs
### Lutfi

Since 22.15 all DME devices should no longer be configured as Remora\Oyster\Yabby\etc, but instead should be DIgital Matter Mobile Devices in the UI
- [x] Check if these are set up as DME ✅ 2023-10-11
- [x] Check in code if command is handled by DME or eg. Romora, Oyster, Yabby ✅ 2023-10-11

Save works, but odo ==reset again next trip==
### Sashi

See [[MobileUnitStateHistory table]] for Odometer

### Heinrich

I found the same behaviour for a [[MiX2310i]] and a [[MiX4000]] on INT

## Progress

- [[2023-10-05]]
	- [x] Why can't I see a DME sender? ✅ 2023-10-11 NOT needed for DME
		- [x] Debug this path ✅ 2023-10-12
	- Can use this to log check the command sent
		- Something like:
		- CommandId=muc.CommandId 
		- UnitIdentifier=muc.UnitIdentifier
	
	- From what I can see looking at the Logz and History State table, the 4K Heinrich mentioned, the odo was never set
	- I will now check the 2k he mentioned. This was also not set.
	- [x] Then I will check the Original ORG units ✅ 2023-10-12
		- AU
		- BMR Logistics
		- AssetId=1392855913680777216
		- AssetId=1392855320593387520
	- LOGS
		- All for these Ids: Only later: https://app.logz.io/#/goto/a19d606e70cc34457ad26a2e90c3b9dc?switchToAccountId=157279 but nothing with sending commands
		- 
	- DB Audit
		- 1392855320593387520: Deleted
		- 1392855913680777216: All audits AFTER: 2023-09-12 21:45:55.027
			- [x] One of 3 are blank (-2956425554789101238) ✅ 2023-10-12
		- 1396103557047508992: Set after: 2023-09-12 20:44:59.907
		- 

- [[2023-10-06]]
	- Timeout in retries: 
	- https://app.logz.io/#/goto/d2724758033a8bc6973b13ec08019ac9?switchToAccountId=157279
		- [[2023-10-06 Log Odometer SR-15901]]
- [[2023-10-09]] Berno
	- [MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1307418444008112128&orgId=8071296543227367712)
	- IS TrackAndTrace
	- Is DME

- [[2023-10-10]] Trying MiX4k of Heinrich and jira issue units
	- IMEI: 357865090007316 (MiX4K)
		- [MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=850791724917612544&orgId=-988065034237472380)
		- Asset list Odo: 2 584
		- Setting to 2588
		- Have NOT done a trip, but up to this point it is OK
		- **IS SET IN DB**
		- https://app.logz.io/#/goto/d6e1ef763c66ecd5babe34c9c8ed4abd?switchToAccountId=157279
		- [ ] Do a trip and then have a look
	- IMEI: 354869050656362 (MiX2K)
		- [MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=6632102729933727148&orgId=718936554657957186)
		- Asset List Odo: 44 238
		- Setting to: 44240
		- Asset list still old data
		- ==NOT SET IN DB==
		- https://app.logz.io/#/goto/1cf5f4de738019ea5525b1c56e8fa510?switchToAccountId=157279
		- [ ] See if updated
		- [ ] Do trip and check
	- ==Original assets==
		- IMEI: 356726109918136
			- CG: DME
			- AssetId: 1396103557047508992
			- [MiX Telematics - Assets](https://au.mixtelematics.com/#/fleet-admin/asset/details?id=1392855913680777216&orgId=480821774307286959)
			- Current Value: 3633,831
			- AssetType: ==Trailer==
			- ![[SR-15901 Digital Matter Odometer Resets To 0 When Adjusted 1st eg.png]]
		- IMEI: 359215100810101
			- ==Not found==
- [[2023-10-11]] 
	- IMEI: 350916069178534
		- CG: DME
		- AssetId: 1392855913680777216
		- [MiX Telematics - Assets](https://au.mixtelematics.com/#/fleet-admin/asset/details?id=1396103557047508992&orgId=1540721865749602915)
		- Current Value: 21806,27
		- ![[SR-15901 Digital Matter Odometer Resets To 0 When Adjusted 3rd Vehicle.png]]

[[Code SetOdometer]]

## SQL Used

- [[SQL Is Device Enabled for MobileUnit]]
- [[SQL to get Organisation information from MobileUnit]]
- [[SQL to get Vehicle information from Mobileunit and Organisation]]
- [[SQL Audit Odometer]]
- 

## Resources

- [[Command 45.excalidraw]]
- [[PaOBC Decommissioning failed]]

## Check out Code paths

- [[Odometer Code]]
## Testing




## Closing Words

Relates to
- https://csojiramixtelematics.atlassian.net/browse/SR-15130
- https://csojiramixtelematics.atlassian.net/browse/CONFIG-4012
- Closed by above fixes from [[DP]]