---
created: 2023-11-22T09:08
updated: 2023-11-22T10:20
---
## Branch

BRANCH: Config/MR/POC/OE-20_Frangular.INT.ORI
- FE
- Seed

## Prep

- [x] Start NEW branch for FE ✅ 2023-09-05

## Frangular UI

- [x] Add Router ✅ 2023-09-06
- [x] Add basic page ✅ 2023-09-06

## UI

- [x] Replace current ConfigGroup Page with a blank iFrame ✅ 2023-09-06
- eg. https://integration.mixtelematics.com/#/operations/data-centre-administration/asset-search
- [x] Call the Frangular UI URL ✅ 2023-09-06

## First POC view

![[OE-20 Configuration Groups - Multi-select config groups First POC.png | 400]]


## Make a call to our API

- TODO: MR: COULDN'T Call basic info from our API
	- Maybe: http://localhost/DynaMiX.DeviceConfig.Services.API/api/asset-mobile-units/all
```c#
//Returns something like this
[
  {
    "LegacyOrganisationId": 245,
    "LegacyVehicleId": 4605,
    "MobileUnitType": 6710364014173584000,
    "OrganisationId": -7858474141122475000,
    "MobileUnitId": -321562216662056500,
    "AssetId": -321562216662056500,
    "MobileDeviceType": "FM",
    "UniqueIdentifier": null
  }, 
  { .... }
]
	```
- TODO: MR: COULDN'T Pull it into the Frangular UI

## Frangular API

- [x] Future ... micro services ✅ 2023-11-22
- [x] Running in Containers? Docker ✅ 2023-11-22
- [x] Lightweight ✅ 2023-11-22
- [x] Can use VS Code ✅ 2023-11-22
- [x] UI can view that page directly ✅ 2023-11-22
- [x] For now call current API ✅ 2023-11-22



