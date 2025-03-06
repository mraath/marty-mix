---
status: busy
date: 2023-10-17
comment: 
priority: 1
created: 2023-10-17T10:17
updated: 2024-01-08T15:44
---

# SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units

Date: 2023-10-17 Time: 10:17
Parent:: ==xxxx==
Friend:: [[2023-10-17]]
JIRA:SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units
[SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-16598)

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

**AU**
**ORG:** Toll Group
**Vehicleid:** 2093

When users try to upload to FMs we see the schedulers time stamps flopping around within the same schedule:
![[SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units Time Flops in Diagnostic MOdal.png|400]]

I can see in the DB that the timestamps are consistent so this seems to be related to how the UI applies the offset between storage time and display time:

**NB Time seems to deviate by 1 Hour**
![[SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units Compared to Correct Data in Database.png|400]]


## Quick Comms Log tests

- Test one seems maybe out by 1 hour
![[SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units Time out by one hour.png|400]]

- Test two, a few minutes later, seems fine
![[SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units Time seems fine.png|400]]

- It almost seems like the eg. in the issue has mixed times, some correct some not?
- I think the offset async call in the first eg. didn't yet have the correct offset, thus didnt apply it before returning it.
- I think the second eg. the async call went through, as no code was changed, yet it looks fine.
- Herewith the value from the database
![[SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units Value from DB.png|400]]


## Code Flow

- From the UI: it does a GET: https://au.mixtelematics.com/DynaMiX.API/scheduler/scheduler/upload/log/4089036243479131134/897728377717052470/47041
- Route:/scheduler/upload/log/{orgId}/{assetId}/{id}           aka. (scheduleId)
- This hits the following file on the BE: file:///C:/Projects/DynaMiX.Backend/API/DynaMiX.API/NancyModules/Scheduler/UploadScheduleListModule.cs
- Method: GetUploadSchedulerLog
- The following three Managers are called within the method
	- AssetsManager.GetAssetSummary
	- DataScheduleManager.GetLogForSchedule
		- This hits the following StoredProc to Get the Logs
		- [dynamix].[DataScheduleLog_GetLatestByScheduleId]
	- GroupManager.GetGroupDisplayTimeZoneInfo
		- GroupManager.GetGroupDisplayTimeZoneInfo(authToken, asset.SiteId)
		- I think this one doesn't return the offset in time, maybe await it?

sDesc	                                                    sName	                liSiteID	 GroupId	                        DisplayTimeZone
Compressor Champion D75A CHURCH	Portland - Assets	307	      6825083025083237231	AUS Eastern Standard Time

[DynaMiX_Groups].[Groups_Get]
- FindSystemTimeZoneByIdCached('AUS Eastern Standard Time')
- [ ] TRY GET api for above
- [x] TRY read DB log values desc, see if date ever changes to make sure ✅ 2024-01-05
	- Flops: 1422: Data stays the same
	- Doesn't: 1753: Data stays the same

AU:  MiX Telematics > AU-DIRECT > AU-Intellifleet-Australia > Graincorp

INT: Try set a new site to AUS ST
	See Comms log
		Ettience Bench Units (Do not edit)
		test FM asset with out clearing unit
	Set the same thing on an Asset
		Doesnt flop around
- [ ] Is it the AU environment for getting TimeZoneInfo?

Trying to debug this directly on PROD
Will need to be quick
- [ ] debug directly on PROD - ensure you CLOSE ALL OUT
- http://localhost/DynaMiX.API/scheduler/scheduler/upload/log/-7419581221023686787/4517386298112896017/1422




/scheduler/upload/log/{orgId}/{assetId}/{id}
https://integration.mixtelematics.com/DynaMiX.API/scheduler/scheduler/upload/log/ORGID/ASSETID/SCHEDULEID
https://integration.mixtelematics.com/DynaMiX.API/scheduler/scheduler/upload/log/ORGID/1398262471460622336/SCHEDULEID

AU:
Doesnt: https://au.mixtelematics.com/DynaMiX.API/scheduler/scheduler/upload/log/-7419581221023686787/1398262471460622336/2608
Flops: https://au.mixtelematics.com/DynaMiX.API/scheduler/scheduler/upload/log/-7419581221023686787/4517386298112896017/1422

[[SQL to test SR-16598 Scheduler Timestamps flopping]]

## TEST on AU DEV PC:

Doesnt: http://localhost/DynaMiX.API/scheduler/scheduler/upload/log/-7419581221023686787/1398262471460622336/2608
Flops test - didnt: http://localhost/DynaMiX.API/scheduler/scheduler/upload/log/-7419581221023686787/4517386298112896017/1422

```c#
//AssetSummary asset = AssetsManager.GetAssetSummary(authToken, assetId);

//Hardcode
//6825083025083237231
//Compressor Champion D75A CHURCH
AssetSummary asset = new AssetSummary()
{
	SiteId = 6825083025083237231,
	Description = "Compressor Champion D75A CHURCH"
};
```

```c#
<customErrors mode="Off"/>
```

## Message Timothy / fleet

Ek wou weet of ek dalk jou brein kan pick? Ons werk aan SR-16598. 
Basies is DIE wat gebeur. Ons comms log kry 1) Logs... en dan 2) Apply dit die timezone offsets. Die data 1) is altyd diselfde, maar 2) die timezone offsets is soms een uur vroeer.
Sover ek kan sien gebeur dit NET op AU. NET vir die TimeZone AEDT. En ook net wanneer dit in DST is.
Dalk kort daai server n patch of nuwe info of iets?
VERDER as ek n asset op INT stel om dieselfde AEDT te gebruik gebeur dit nie.
As ek op die DEV box op AU gaan gebeur dit ook nie vir localhost nie, as ek dan daai DEV boks point na die gewone AU end-point gebeur dit.
So die tyd sal eg.14:00 wees, dan refresh ek dit, dan is dit 13:00, dan refresh ek weer n paar keer, dan is dit weer 14:00.... ens
Dit flip net met 1 uur vir AEDT op AU. So eg. heeltyd tussen 13:00 en 14:00. In die issue noem hul dit "the time is flopping"
Die data bly dieselfde
MAAR die MAG DALK wees waar mens die timezone info lees dat dit in cache mal gaan?
Nie seker nie
Het jy n idee?
Dis hoe die code lyk....
![[SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units Where time flops.png]]

So by die rooi kry dit daai ander waarde - maar nie in DEV op AU nie - net AU live.
So AL wat anders is is die moontlikheid hoe dit daai assetSiteTimeZoneInfo kry....
Want die Logs (data) bly dieselfde asook die kode.
So net die moontlikke Timezone mag dalk rondspring op AU.

Is daar n manier op daai GetGroupDisplayTimeZoneInfo via eg. Swagger direk op AU te roep om te toets?
Ek is nou al DAE op die ding 😛

[3:06 PM] Timothy Butler
mmm, die Timezone van die manager behoort ons global timezone goed te consume en nie local enes nie. Daar is nie rerig 'n manier om dit te toets nie, tensy jy dalk daai global ene se swagger consume. Sal kyk of ek kan vind of dit een het
[3:07 PM] Timothy Butler
Daar is ook 'n kaans dat dit wel point na die local timezone cache van die machine, maar dis nie veronderstel om die geval te wees nie. Ons het jare terug toe Christo nog hier was daai verander


Marty:
Lyk of dit eers die global probeer, en dan indien dit nie kry nie - dan soek dit op n ander plek
![[SR-16598 RW - Scheduler Timestamps flopping around on Uploads for FM units Globalisation Alternative.png]]

[3:28 PM] Marthinus Raath
As ek na bg kyk dink ek ek kan dalk n klein console app skryf en die bg in te pull en te roep met daai timezoneid
Ek dink dis dalk n opsie? wat dink jy? Dan run ek daai console app gou op die iis server op AU en kyk

JAKO: dalk load-balancing betrokke met WEB service

## Ideas

- [x] Duplicate in Prod ✅ 2023-10-17
	- [MiX Telematics - Assets](https://au.mixtelematics.com/#/fleet-admin/asset/details?id=897728377717052470&orgId=4089036243479131134)
	- 
- Duplicate on INT (handed over to Jako)
- Check DB, Logs (handed over to Jako)
- I THINK it is ordered by message then date time (handed over to Jako)

## Helpful SQL

[[SQL Organisation]]
[[SQL Comms Log]]

## SR Meeting Notes

- Handed over to Jako

## Useful Comments from Jira


## Check out Code paths



## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing

