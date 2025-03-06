---
status : prod
date : 2022-09-20
priority: 8
comment: ettienne will make changes, OKed by William
---

Date: 2022-09-20 Time: 10:24
Parent:: xxxx
Friend:: [[2022-09-20]]
JIRA:SR-13578
[SR-13578 Multiple Units stuck in Config Upload requested status - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-13578)

# SR-13578 Units Stuck Config Upload

## Image
![[Status Messages.excalidraw]]

## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Lang  | UI    | BE    | Client | API   | Common | DB    |
| ----- | ----- | ----- | ------ | ----- | ------ | ----- |
| 22.6  | 22.6  | 22.6  | 22.6   | 22.6  | 22.6   | 22.6  |
| Local | Local | Local | Local  | Local | Local  | Local |

## Branch
Config/MR/Bug/SR-13578UnitsStuckConfigUpload.22.14.ORI

## Learned

- Ettienne Steenkamp Links
	- [http://api.m2k.uk.dub.production.local/devices/353863118659386/commands.xml?from=20220823&to=20220826](http://api.m2k.uk.dub.production.local/devices/353863118659386/commands.xml?from=20220823&to=20220826) 
	- [http://api.m2k.uk.dub.production.local/devices/353863118659386/commands/1167670393/statushistory.xml](http://api.m2k.uk.dub.production.local/devices/353863118659386/commands/1167670393/statushistory.xml)

## Description
- Units not updating config status form upload requested to config accepted
- MIX4000
- US and the UK IDC
- Egs
	- Avangrid
	- Upload requested
		- It could be that it is the DIS is not updating the config status to configuration accepted
		- But I have no way of confirming 100% that the config was accepted by the unit ,not sure if the is a way of detecting that from the UDP ?
		- Code in datafile?
		- IMEI	357812099639046
		- id=1236574970133852160&orgId=5284249956650970133
		- ... file transfer completed successfully (comms log
		- last time: 2022-08-04 13:10:00 +00:00 Configuration accepted
		- Upload requested
		- **config  was either not accepted**
		- OR **config status is failing to update**
		- WHY **last config upload in asset page is blank** (why nog previous?)
		- **UDP log** check for codes
			- ConfigStatusMessages
		- There are config changes
			- ![[Pasted image 20220921150929.jpg]]
			- either die fragments wat nie werk nie (<mark class="hltr-grey">Paul</mark>) of Firmware wat nie die nuwe config ack nie (firmware)
			- Paul: Fragments OK, might be related to
				- https://jira.mixtelematics.com/browse/SR-13493
				- Asking Shashi
				- 

like 1
## Code sections
```sql
-- PORTIA
use DeviceConfiguration  
go  
select ct.MobileUnitKey, ct.rid, cs.Description, ct.ConfigurationStatus, ct.LoadedConfigurationVersionKey, ct.PendingConfigurationVersionKey, ct.changedate, ct.UserName  
from mobileunit.assetmobileunits amu with (nolock)  
inner join mobileunit.mobileunits mu with (nolock) on mu.mobileunitkey = amu.mobileunitkey  
inner join audit.mobileunit_mobileunits_ct ct with (nolock) on ct.mobileunitkey = amu.mobileunitkey  
inner join definition.configurationstatuses cs with(nolock) on ct.configurationstatus = cs.configurationstatus  
where ct.ChangeDate > '1 may 2018' and  
amu.legacyorgid = 6785 and amu.legacyvehicleid in (2998)  
--and ct.ConfigurationStatus = 11  
--and rid > 286628  
order by mobileunitkey, rid desc
```

## Files

## Resources

## Notes

