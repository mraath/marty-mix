---
status: parked
date: 2023-04-11
comment:
priority: 3
---

# SR-15056 Audit Report user info needed

Date: 2023-04-11 Time: 09:24
Parent:: ==xxxx==
Friend:: [[2023-04-11]]
JIRA:SR-15056 Audit Report user info needed
[SR-15056 Configuration Audit Report assistance - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15056)

## SQL Zeshan

```sql
Select top 20 * from DeviceConfiguration.[reports].vwAudit_mobileunit_MobileUnitProperties_CT where (mobileunitkey = 408600 and propertykey = 370) or value = '300534063100980' order by ChangeDate
```

## Jira message

The logic that gets called here, reaches a method in the Backend, where the current user session is used in specific scenarios.
If the mobile unit was:
- MiXTalk
- Streamax
- If it is a track and trace device, to call the AssetsRepository.UpdateTrackAndTraceUnitIdentifiersAsync
- Has an iridium modem, it calls RemoveSatelliteModem. In here it seems to:
	- Call deviceIntegrationManager to DisconnectIridiumModem. I couldn't find anything here which helped.
	- Call the IridiumManager to RemoveIridiumContractFromAsset. I will ask **Fleet** about this.

It also uses it to:
- Call our client to DeleteAssetMobileUnitStates. In this code, however, it disregards the user in the API.
- Call the AssetsManager to UpdateAsset. I will ask **Fleet** about this.
- Call the AssetsRepository to AddAssetStateAsync. I will ask **Fleet** about this.







LOOK INTO:
- DeviceConfigClient.MobileUnits.UpdateMobileUnitConfigurationGroupCache
- ...

## Fleet message

Hey daar. Ek hoop jy doen goed.
Wanneer jy tyd het. Ek kyk na SR-15056.
Basies het hul n Iridium IMEI verander deur die device to remove.
MAAR nou wil hul sien WIE dit gedoen het :-)
Die Audit Report wys net "Config User". So ekt nou in die kode gaan kyk.
Daars n paar plekke wat die AuthToken wel gebruik mag word.
Die kode wat ek kon volg het ek. Maar kon nie iets kry nie...
Ekt nou wel die ander kode gevolg en van hul mag jul Fleet span DALK info kan kry
Jy kan my laaste comment lees op die issue - in kort... ek DINK hier iewers mag ons iets kry.
So net wanneer jy n Normal SR wil hanteer :-D

In ..\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs
IT goes to RemoveMobileDevice and eventually DeleteAssetMobileUnit.
From here it goes into many potential places, but I think these MIGHT have something:
- IridiumManager to RemoveIridiumContractFromAsset
- AssetsManager to UpdateAsset
- AssetsRepository to AddAssetStateAsync


## Notes

REMOVE_MOBILE_DEVICE
RemoveMobileDevice (AssetCommissioning)
assetCommissioningManager.DeleteAssetMobileUnit
	calledFromDeviceConfigAPI will be false - so will get the current session (with user info)
	IsAssetTrackAndTraceDevice > will use current user to UpdateTrackAndTraceUnitIdentifiersAsync
	assetState.CreatedBy = currentSession.FullName
	if (assetState)
		AssetsRepository.AddAssetStateAsync
		

Maybe
	DeviceConfigClient.MobileUnits.DeleteAssetMobileUnitStates
		delete-asset-mobile-unit-states
		DeleteAssetMobileUnitStates
			Gets CurrentUserSession - NOT USED
			

## Description

- ![[Decommissioning MiX4000.excalidraw]]