---
status: support feedback
date: 2023-01-04
comment: WK
priority: 6
---

Date: 2023-01-04 Time: 03:47
Parent:: [[Odometer]]
Friend:: [[2023-01-04]]
JIRA:SR-14297 FM ODO sent through scheduler not being applied

# SR-14297 FM ODO sent through scheduler not being applied

## Testing

## Next Steps

- [x] 

- [x] Do we change it when writing it?
	- [x] Look for:
		- DmXLogger.Log($"SaveUploadScheduler: {user.GetFullName()}, Odo values: {carrier.ActionsOdometer.Value} {carrier.ActionsOdometer.Unit}. JSON: {json}", LogLevel.Warning);
	- Unit conversions
- [x] Where do we read it from? Do we convert anything?
	- asset.Odometer < AssetsManager.GetAsset <  AssetsClient.GetAsync < MiX.Fleet.Services.Api.Client < ???
	- Only unit conversions

FLEET:
[08:39] Timothy Butler
Hi Marty, sorry nie message gesien nie. Ja, ek dink ons lees net odo met die sproc
[dynamix].[Assets_Get]
Die normal update asset stuur ons nie die laaste odo saam nie, maar lyk asof daar wel 'n update Odo method is wat die sproc roep
[dynamix].[Assets_Update_LastOdo]
deur die client method
AssetsClient.UpdateLastOdoAsync
Die sproc word ook geroep as 'n mobile device settings geupdate word deur die client method
AssetsClient.UpdateMobileDeviceSettingsAsync
Conversions word altyd gedoen net voor die UI toe gaan. Dit is om te verhoed dat ons dalk multiple times dit probeer convert van metric na die user se settings

Jeremy would know more about the max odo distance stuff.

## Story Description

==FM==

Environment : ENT
Org Name: Intercape Mainliner (R)
AssetDB name (which is different from the Org name):  IntercapeMainliner2_2015
Company id: -32755
OrgId (Legacy):  404
64 bit org id: -5858119684662776138
Library key: 28

ODO set commend

Comms message:
Transfer complete
Unit not accepted

DAT files:
1 847 618 km
1 148 059 mi

FROM DAT:
169 896,4

Current odometer is 179 342 Kilometres

TOO Large for unit
Odo Rollover settings is set to true
OdoUnwrapEnabled
odo values from the unit will be adjusted by 1 677 721.5

event id (32563 - SetOdo)
1 698 964

process handled outside of the Downloader. 
Config > creates schedule > FmComms > unit > FW > apply value
(?? how do we handle values greater than what the physical unit can handle??)

(The odo might also go to fLastOdo field in the Vehicles table)
(Something might then be sent to Lightning)
What does FW do with a value too big

## Image

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.17 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-14297 FM ODO sent through scheduler not being applied.xx.xx.ORI
