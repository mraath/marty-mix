---
status: busy
date: 2023-09-14
comment: 
priority: 1
created: 2023-09-14T09:54
updated: 2023-11-13T11:25
---

# QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset

Date: 2023-09-14 Time: 09:54
Parent:: [[OEM]]
Friend:: [[2023-09-14]]
JIRA:QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset
[QA-6032 QA - Manage - Config Admin: Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-6032)

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

## Branch

- Config/MR/Feature/Template Jira Issue_INT_ORI

## Description

Testing on UAT 23.14  
Org: Jacques' Org  
Org id: -3651824075929424032  
Asset id: 1438592889007034368

Steps to replicate:  
_**CREATING A NEW ASSET ON THE ASSET's PAGE: (NON-OEM Assets/ Config Group)**_  
Create a new asset  
Assign the VIN Number and save the asset  
Ensure no default configuration group is selected for this asset.  
Navigate to Configuration group and move the asset into an OEM Config group.  
Navigate back to the asset's page and edit the asset.

**BUG:** The text box is not locked and the VIN Number was removed from the field.1438592889007034368

## Reproducing on UAT

![[QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset Reproduced on UAT.png | 500]]

## Reproducing on INT

- Exact same thing on INT
- What if I fill SAVE as before, then select the Asset Details Configuration Group (Not dragging)
	- [x] Not the same... ✅ 2023-09-14
![[QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset Change Config Group in Asset Details.png | 500]]

### When dragging, this modal shows

![[QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset Warning dragging message.png | 200]]

## Reproducing on PROD

- IF it is aleady on prod I can lower the priority
- Not yet on prod, as the device is not yet available

```sql
SELECT * FROM DeviceConfiguration.definition.MobileDevices
WHERE Description LIKE '%hino%'
SELECT * FROM DeviceConfiguration.definition.Devices
WHERE SystemName LIKE '%hino%'
```

## Next I will check the difference in Logic between the Asset Details change and Dragging an asset into a Config Group

- Changing the Asset Details
	- MR Test VIN 4
	- SAVE
		- Post: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/728991141410751360/asset/%7BassetId%7D/add
			- [vinSource: null]
		- GET:         "vinSource": "MANUAL",
	- Change Config Group
		- GET: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/728991141410751360/configGroup/5396298819185955314/requiredproperties
			- VIN > True
		- GET: https://fleetadminapi.mixdevelopment.com/api/asset-details/configGroup/5396298819185955314/streamaxstate
		- GET: https://fleetadminapi.mixdevelopment.com/api/asset-details/configGroup/5396298819185955314/enabledforhours
	- SAVE
		- GET: https://fleetadminapi.mixdevelopment.com/api/asset-details/asset/1438887194018246656/assetjourneystate
		- POST: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/728991141410751360/asset/%7BassetId%7D/update
			- [Vinsource? "MANUAL"]
- Dragging the Asset into a Configuration Group
	- MR Test VIN 3
	- SAVE
	- Post: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/728991141410751360/asset/%7BassetId%7D/add
	- DRAG
	- POST: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/728991141410751360/config_groups/5396298819185955314/assets 
		- [AssetIds: 1438879483901526016]
	- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs
		- MOVE_ASSETS_TO_CONFIGURATION_GROUP
	- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs
		- UpdateAssetsConfigurationGroup

## New day, new tests on INT

### MR VIN OEM

#### ADD ASSET (VIN, NO Config Group)

##### POST: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/728991141410751360/asset/%7BassetId%7D/add
Payload
```json
  
{"assetId":"0","assetTypeId":"4","description":"MR VIN OEM","registrationNumber":"MRVO1","mobileNumber":null,"siteId":"-1754837226472884968","fuelType":null,"targetFuelConsumption":null,"targetFuelConsumptionUnits":"mpg (US)","targetHourlyFuelConsumption":null,"targetHourlyFuelConsumptionUnits":"gal (US)/h","fuelTankCapacity":null,"fleetNumber":null,"make":"AC","model":null,"year":null,"vinNumber":"11111222223333313","vinSource":null,"engineNumber":null,"fmVehicleId":null,"additionalMobileDevice":null,"notes":null,"icon":"boat-right","iconColour":"blue","colour":null,"assetImage":null,"assetImageUrl":null,"status":null,"createdBy":null,"createdDate":null,"country":null,"miXAccountNumber":null,"isNewAsset":true,"additionalDetailFields":[],"canProtocol":null,"requiredProperties":{},"volumeUnits":"gal (US)","wltp":null,"batteryCapacity":null,"usableBatteryCapacity":null,"distanceUnit":"mi"}
```
##### GET: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/728991141410751360/asset/1439294447656128512/duplicate/false/get
Response
```json
{
    "canEdit": true,
    "assetDetails": {
        "assetId": "1439294447656128512",
        "assetTypeId": "4",
        "eld": false,
        "description": "MR VIN OEM",
        "isConnectedTrailer": false,
        "registrationNumber": "MRVO1",
        "mobileNumber": null,
        "siteId": "-1754837226472884968",
        "fuelType": null,
        "targetFuelConsumption": null,
        "targetFuelConsumptionUnits": "mpg (US)",
        "targetHourlyFuelConsumption": null,
        "targetHourlyFuelConsumptionUnits": "gal (US)/h",
        "fuelTankCapacity": null,
        "fleetNumber": null,
        "make": "AC",
        "model": null,
        "year": null,
        "vinNumber": "11111222223333313",
        "vinSource": "MANUAL",
        "isNotCanVin": false,
        "vinNumberMatched": false,
        "engineNumber": null,
        "fmVehicleId": 7,
        "additionalMobileDevice": null,
        "notes": null,
        "icon": "boat-right",
        "iconColour": "blue",
        "colour": null,
        "assetImage": "asset-boat.jpg",
        "isDefaultImage": false,
        "assetImageUrl": null,
        "status": null,
        "createdBy": "Marthinus Raath",
        "configurationGroupId": "",
        "createdDate": null,
        "country": null,
        "miXAccountNumber": null,
        "isNewAsset": false,
        "isMobilePhone": false,
        "additionalDetailFields": [],
        "isStreamaxCommissioned": false,
        "decommissionStreamaxDevice": false,
        "canProtocol": "",
        "isScaniaOem": false,
        "isOnJourney": false,
        "requiredProperties": {
            "vin": false,
            "canProtocol": false,
            "fuelType": false
        },
        "volumeUnits": "gal (US)",
        "wltp": null,
        "batteryCapacity": null,
        "usableBatteryCapacity": null,
        "distanceUnit": "mi",
        "hyperMedia": null
    },
    "isNewAsset": false,
    "configGroups": [
        {
            "value": "5396298819185955314",
            "text": "Default configuration group for Hino OEM"
        }
    ],...
}
```

#### Move to OEM Config Group
##### POST https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/728991141410751360/config_groups/5396298819185955314/assets
```json
{"AssetIds":["1439294447656128512"]}
```
Response:
```json
{
    "IncompatibleAssets": [],
    "AssetIds": [
        1439294447656128512
    ],
    "IncompatibleVinAssets": [],
    "IncompatibleVinAssetsDescriptions": []
}
```
#### Result
![[QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset Asset Details.png|300]]
![[QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset Mobile Device Settings.png|300]]


### MR VIN OEM (UAT)

#### ADD
Post: https://fleetadminapi.uat.mixtelematics.com/api/asset-details/group/-3651824075929424032/asset/%7BassetId%7D/add
```json
{"assetId":"0","assetTypeId":"4","eld":true,"description":"MR VIN OEM","registrationNumber":"MRVO1","mobileNumber":null,"siteId":"-2884964356484889788","fuelType":null,"targetFuelConsumption":null,"targetFuelConsumptionUnits":"gal (US)/100mi","targetHourlyFuelConsumption":null,"targetHourlyFuelConsumptionUnits":"gal (US)/h","fuelTankCapacity":null,"fleetNumber":"121","make":"AC","model":null,"year":null,"vinNumber":"11111222221212121","vinSource":null,"engineNumber":null,"fmVehicleId":null,"additionalMobileDevice":null,"notes":null,"icon":"boat-right","iconColour":"blue","colour":null,"assetImage":null,"assetImageUrl":null,"status":null,"createdBy":null,"createdDate":null,"country":null,"miXAccountNumber":null,"isNewAsset":true,"additionalDetailFields":[],"canProtocol":null,"requiredProperties":{},"volumeUnits":"gal (US)","wltp":null,"batteryCapacity":null,"usableBatteryCapacity":null,"distanceUnit":"mi"}
```
Response
{"id":"1439303319228698624","value":true,"resultMessage":null}
GET: https://fleetadminapi.uat.mixtelematics.com/api/asset-details/group/-3651824075929424032/asset/1439303319228698624/duplicate/false/get
```json
{
    "canEdit": true,
    "assetDetails": {
        "assetId": "1439303319228698624",
        "assetTypeId": "4",
        "eld": true,
        "description": "MR VIN OEM",
        "isConnectedTrailer": false,
        "registrationNumber": "MRVO1",
        "mobileNumber": null,
        "siteId": "-2884964356484889788",
        "fuelType": null,
        "targetFuelConsumption": null,
        "targetFuelConsumptionUnits": "gal (US)/100mi",
        "targetHourlyFuelConsumption": null,
        "targetHourlyFuelConsumptionUnits": "gal (US)/h",
        "fuelTankCapacity": null,
        "fleetNumber": "121",
        "make": "AC",
        "model": null,
        "year": null,
        "vinNumber": "11111222221212121",
        "vinSource": "MANUAL",
        "isNotCanVin": false,
        "vinNumberMatched": false,
        "engineNumber": null,
        "fmVehicleId": 25,
        "additionalMobileDevice": null,
        "notes": null,
        "icon": "boat-right",
        "iconColour": "blue",
        "colour": null,
        "assetImage": "asset-boat.jpg",
        "isDefaultImage": false,
        "assetImageUrl": null,
        "status": null,
        "createdBy": "Marthinus RaathLimited",
        "configurationGroupId": "",
        "createdDate": null,
        "country": null,
        "miXAccountNumber": null,
        "isNewAsset": false,
        "isMobilePhone": false,
        "additionalDetailFields": [],
        "isStreamaxCommissioned": false,
        "decommissionStreamaxDevice": false,
        "canProtocol": "",
        "isScaniaOem": false,
        "isOnJourney": false,
        "requiredProperties": {
            "vin": false,
            "canProtocol": false,
            "fuelType": false
        },
        "volumeUnits": "gal (US)",
        "wltp": null,
        "batteryCapacity": null,
        "usableBatteryCapacity": null,
        "distanceUnit": "mi",
        "hyperMedia": null
    },...
}
```
#### DRAG
POst: https://uat.mixtelematics.com/DynaMiX.API/config-admin/organisations/-3651824075929424032/config_groups/-2853100246670594941/assets
{"AssetIds":["1439303319228698624"]}
Result:
```json
{
    "IncompatibleAssets": [],
    "AssetIds": [
        1439303319228698624
    ],
    "IncompatibleVinAssets": [],
    "IncompatibleVinAssetsDescriptions": []
}
```
- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs
- MOVE_ASSETS_TO_CONFIGURATION_GROUP
	- UpdateAssetsConfigurationGroup
	- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs
	- AssetCommissioningManager.UpdateAssetConfigGroup
		- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs
		- 




#### Result
![[QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset UAT Result after Drag.png|500]]

## Another occurance from JAcques

Test VIN LOCK 6
AssetId: 1439606668347408384  
Vin Number: 77484775856465775

## Message to Fleet team

Hi there. I am investigating QA-6032.
On INT it works (most of the time). On UAT it sometimes works.
Bacially you will fill in an Asset's details (incl. VIN, excl. Config group)
When you then drag it into a Config Group the VIN number gets added as a unique identifier (which is correct)
However, sometimes it then removed the VIN from the Asset (which seems to be wrong)

I had a look at our code. It seems OK. I saw it also calls some Fleet code.
I just want to pick your brain on this, as I think the VIN being in two places was handled by Fleet.
Could you have a quick look if what we see makes any sense from your point of view.
Below I followed the exact same steps. The one in green succeeded, the one in red removed the VIN number.
(Thanks)

![[QA-6032 Moving a Non-OEM asset into an OEM Config group removes the VIN Number from the asset Eg of success and fail.png|500]]

## Possible references for VIN and OEM

![[Change Config.excalidraw]]
![[Message Status.excalidraw]]
![[MiX.excalidraw]]

[[SR-13706 Showing date time for VIN]]
[[OEM-204 CanBeDeleted]]
[[SR-13274 VIN not cleared after decommissioning]]
[[SR-13368 VIN field locked with partial date as entry_ Source CAN BUS]]

