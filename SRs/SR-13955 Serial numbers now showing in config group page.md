---
status: closed
date: 2022-10-26
comment: nicole > architect
priority: 8
---

Date: 2022-10-26 Time: 15:45
Parent:: xxxx
Friend:: [[2022-10-26]]
JIRA:SR-13955 

# SR-13955 Serial numbers now showing in config group page

## Image


## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.13 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-13955 Serial numbers now showing in config group page.xx.xx.ORI

## Learned

## Notes

- Might be related to [[SR-11470 Serial number not showing in Device Configuration page even though it is in the mobileunitstate table]]

## Description

- not show or update the  ==serial number== information on the ==configuration==  group page
- MiX4000
- IDC: UK
- DB: TCO Contractor
- Group ID : 2366487117609703219

 

Reg No        A ID 64 bit asset ID 	            IMEI	                         IMSI 	                    Device 	FW 	    FW ver upload date
102 AB 06	645	1319728216483000320	359159973736631	401015724187864	MiX4000	4.12.6	2022/10/21 1:25:56 PM (UZT)
028 YM 06	541	1317888133915373568	354679099474275	401015724187769	MiX4000	4.12.6	2022/10/16 11:22:51 AM (UZT)
077 ECA 06	418	1311680630410756096	359159973723258	401015724187813	MiX4000	4.12.6	2022/09/29 8:26:23 AM (UZT)
 
```sql
use deviceconfiguration
select * from
[DeviceConfiguration.DataProcessing].[state].[MobileUnitState] mus2 with (nolock)
Where mobileunitid =1319728216483000320
```

## Where does it get the Serial number from NOW

- In Config groups page
- Assets
- AssetsList
- Request URL: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/config_groups/0/assetlist
- GET_CONFIG_GROUP_ASSETS
- ..\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs
- method: GetConfigGroupAssetList
- Justus did some work about 10 months ago
- FOR MESA:
	- it first tries: MobileUnitState
	- if it doesnt get it then it uses the mobileunitproperties
- OTHERS
	- mobileunitproperties

## Code sections

## Files

## Resources

## Notes

