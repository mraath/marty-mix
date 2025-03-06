---
aliases:
  - odo
created: 2023-10-03T15:27
updated: 2025-03-06T12:00
---
## Intro

The [[DIS]] Team is also very involved here

## Set

[[Config]] team sets odo values for [[DME]] when the UI is involved

## More Info

ok asset db odo is what is calculated by DP (DIS/Downloader) at trip end, but that has little to do with the odo update commands and their updates.
In the DB also, the state tables are slightly ahead of the values in the asset Db.
this looks like expected behaviour:

- Diagnostics odo is near real-time odo calculation
- Assets page odo (from asset db) is last trip odo

On MiX2000/MESA odo commands are applied out of trip by FW, so trip processing will finish by DP and still reflect unadjusted odo and only update correctly after the end of the next trip (as the warning in MFM states). The same applies to E/H

## Read

The [[DIS]] will:
- read Odometer from the [[Device State]] [[Tables]] to 
- add the Trip Distance and then 
- save it back
but we do not adjust the odo from whatever is set in the UI
- [[DIS Teltonika Odometer]]

## Display

- [[Assets List]]
	- Source: POST .../DynaMiX.API/fleet-admin/assets/groups/-5401647754082838271
		- GET_ASSET_LIST_PAGE
		- GetAssetListPage
		- Items[x].Odometer
		- [dynamix].[Assets_GetExtendedSummaries]
		- [dbo].[Vehicles].fLastOdo, 
		- ISNULL([dbo].[Trailers].[fSetOdometer], 0) + ISNULL([dbo].[Trailers].[fDistance], 0)

- [[Diagnostic Modal]] Old and new
	- Source: 2K: Properties.UNIT_RAW_ODOMETER = -3166755750272960197
		- DB: Stored Proc:[state].[MobileUnitState_GetStatesForSingleMobileUnit]
		- [state].[MobileUnitState]
	- Source: DME: 
		- From vehicle table
- [[Mobile Device Settings]]
	- Source DME:
		- GET: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/8071296543227367712/1307418444008112128
		- SetOdoTemplate.Odometer
			- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs
			- trackAndTraceMobileUnitManager.GetLastOdometer
			- AM.GetLastOdo
			- AssetsClient.GetLastOdoAsync
			- [dynamix].[Assets_Get]
			- dbo.Vehicles.fLastOdo OR dbo.Trailers.fSetOdometer

## Set

- UI: Set odometer
	- PUT: 1. "DynaMiX.API/fleet-admin/assets/commissioning/-5401647754082838271/1435774616539906048/odometer"
	- Search: RegEx: "assets\/commissioning\/.*\/.*\/odometer"
	- SET_ODOMETER
	- SetOdometer
		- trackAndTraceMobileUnitManager.SetOdometer
			- AssetsManager.UpdateAssetLastOdo
			- dsi > MSMQ
		- mesaMobileUnitManager.SetOdometer
			- if update Asset DB > AssetsManager.UpdateAssetLastOdo
		- DeviceConfigClient.MobileUnits.SetMobileUnitOdometerMeters
			- SetMobileUnitOdometerMeters
			- SetMobileUnitOdometerMetersOrOffset
				- Use offset? SendOdometerOffsetCommandToMobileUnit
					- CommandIdType.SetOdometerOffset (104) (SetOdometerOffset)
					- 
				- else SetMobileUnitOdometerMeters
				- [[MobileUnitCommandSender]]
				- 
## Audit

- See full [[SQL Audit Odometer]]
(See DIS [[MobileUnitStateHistory table]] for Odometer)

## Log

- Check the [[Log Odometer Setting]]
- 