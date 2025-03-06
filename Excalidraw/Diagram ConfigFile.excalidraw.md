---

excalidraw-plugin: parsed

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Text Elements
[[template. LocationTemplates]] ^zlop62Yw

[[template. Locations]] ^uymSghEl

[[mobileunit. AssetMobileUnit]] ^bMb55Tde

[[mobileunit. MobileUnits]] ^OgNd3w1X

[[template. ConfigurationGroups] ^JmFh0qvU

[[template. EventTemplates] ^8OdUYgvH

[[template. MobileDeviceTemplates] ^pMvAoLaA

[[library. Libraries] ^RK3SRvaH

MobileUnitKey ^aGixBvHz

ConfigurationGroupKey ^NnddiwEO

EventTemplateKey ^LrJT7NHX

MobileDeviceTemplateKey ^N10k6ocS

LibraryKey ^vysoFHLP

LocationTemplateKey ^cCXwu2Nd

[[library. Locations] ^NPokJW4i

LibraryLocationKey ^56dA1Twx

LibraryKey ^f9NiGa0u

LibraryKey ^koX1Xlem

LocationTemplateKey ^qjIESy6h

[[FMOnlineDB.
dbo.Organisation]] ^kTIe6hih

liOrgID = legacyOrgId ^OjP8OjIT

[[dbo.Vehicles]] ^FE08ZXxd

iVehicleID = legacyVehicleId ^69MvgBQD

[[dbo.Sites]] ^ZZSSOoEJ

liSiteID ^Jf7KpvL4

[[dynamix.MapLocations]] ^pnC2L6M2

DmxLocationId ^SPJDxUHE

[[dbo.MapLocations]] ^A5szKn9k

MapLocationKey = liLocationId ^AXQT2V8z

OVERWRITTEN???? ^ZxUV0wJp

mobileunit.OverridenCanParameters
mobileunit.OverridenDeviceParameters
mobileunit.OverridenDeviceProperties
mobileunit.OverridenDevices

mobileunit.OverridenEventActions
mobileunit.OverridenEventConditionThresholds
mobileunit.OverridenEvents

mobileunit.OverridenPeripheralDevices ^Pe5t9f7O

sConnectDatabase ^M2EVBIVs

[[definition MobileDevices]] ^7Bmd2WCH

dmd.DeviceKey 
= mu.MobileDeviceKey ^iTVxt7qP

[[definition MobileDeviceLines]] ^IiUT69dQ

dmdl.[MobileDeviceKey] 
= mu.[MobileDeviceKey] ^RYpHXZ5H

[[definition Lines]] ^xDTIf93X

LineKey ^66bs1Drx

Equivalent Line ^T2qEqXuA

dl_e.[LineKey] 
= dmdl.[EquivalentLineKey] ^Zj0dJTxh

[[template Devices]] ^xIqOoEa7

td.[MobileDeviceTemplateKey] 
= tcg.[MobileDeviceTemplateKey] ^6ehkitDm

[[definition Devices]] ^pvR3jO29

dd.[DeviceKey] 
= td.[DeviceKey] ^XmfFcGe8

Cross Alied as pd ^peer7DSw

[[template PeripheralDevices]] ^ykqO2DUV

[[mobileunit OverridenPeripheralDevices]] ^GxPk47Tx

opd.[MobileUnitKey]
= mu.[MobileUnitKey]
AND opd.[TemplateDeviceKey] 
= tpd.[TemplateDeviceKey] ^WcPa0AmG

tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]
		AND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)
		OR(opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL)) ^6Sb5vgEY

[[definition MobileDeviceLinePeripheralDevices]] ^qymM8l2u

dmdlpd.[MobileDeviceKey]     = mu.[MobileDeviceKey]
    AND dmdlpd.[LineKey]             = pd.[LineKey]
    AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey] ^7t7dmJb3

[[library Devices]] ^OEdCKbMe

ld.DeviceKey 
= dmdlpd.PeripheralDeviceKey 
AND ld.LibraryKey 
= tcg.LibraryKey ^AwpmGzkH

[[library PeripheralDevices]] ^CoQfs1TE

LibraryDeviceKey ^H1RN2idh

template Events ^LNduEHdy

template EventActions ^KfsunbyR

template EventConditions ^Q6HqqYLe

template OverriddenEventActions ^UJPNlAei

template OverridenEventConditionThresholds ^5CHZ6Ks4

template OverridenEvents ^rq4mWE1L

[dynamix].[Assets] ^IXcPR2pR

v.iVehicleID = a.VehicleId ^DeNPOnFK

AssetId ^sPV6pDqU

AssetId ^gTpV14Rw

%%
# Drawing
```json
{
	"type": "excalidraw",
	"version": 2,
	"source": "https://excalidraw.com",
	"elements": [
		{
			"type": "rectangle",
			"version": 2580,
			"versionNonce": 1458686071,
			"isDeleted": false,
			"id": "gkgn7fxStHWfUMpNMITxF",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -366.4292929292932,
			"y": 992.5133477633481,
			"strokeColor": "#495057",
			"backgroundColor": "#fab005",
			"width": 222,
			"height": 60,
			"seed": 259016579,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"type": "text",
					"id": "zlop62Yw"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "aPl62MpcBBq6zEBX4epuv",
					"type": "arrow"
				},
				{
					"id": "OEB9YdDDmPwKoT85PNNKV",
					"type": "arrow"
				},
				{
					"id": "ndb9jmeMHhFODVbBT2--3",
					"type": "arrow"
				},
				{
					"id": "M1CuErnnYYMSoOsFqHz6w",
					"type": "arrow"
				}
			],
			"updated": 1648805102721,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2437,
			"versionNonce": 579792211,
			"isDeleted": false,
			"id": "zlop62Yw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -361.4292929292932,
			"y": 997.5133477633481,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 212,
			"height": 50,
			"seed": 49658765,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653344,
			"link": "[[template. LocationTemplates]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[template. \nLocationTemplates]]",
			"rawText": "[[template. LocationTemplates]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "gkgn7fxStHWfUMpNMITxF",
			"originalText": "📍[[template. LocationTemplates]]"
		},
		{
			"type": "rectangle",
			"version": 3273,
			"versionNonce": 883925399,
			"isDeleted": false,
			"id": "_roIBbIyE-ldrDLpjxlYg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 45.89357864357828,
			"y": 1233.8870876802166,
			"strokeColor": "#495057",
			"backgroundColor": "#fab005",
			"width": 147,
			"height": 60,
			"seed": 1130930659,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "uymSghEl",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "uDuxy_i7It6wdvtX4BKxX",
					"type": "arrow"
				},
				{
					"id": "ndb9jmeMHhFODVbBT2--3",
					"type": "arrow"
				}
			],
			"updated": 1648805102721,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 3097,
			"versionNonce": 1142916445,
			"isDeleted": false,
			"id": "uymSghEl",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 50.89357864357828,
			"y": 1238.8870876802166,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 137,
			"height": 50,
			"seed": 2119508429,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653345,
			"link": "[[template. Locations]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[template. \nLocations]]",
			"rawText": "[[template. Locations]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "_roIBbIyE-ldrDLpjxlYg",
			"originalText": "📍[[template. Locations]]"
		},
		{
			"type": "arrow",
			"version": 6545,
			"versionNonce": 1478741299,
			"isDeleted": false,
			"id": "-039YMcZgFW_iCTrvfql3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -166.53536146127,
			"y": 1060.332422297888,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 211.8183957859472,
			"height": 226.8898944256057,
			"seed": 1568429997,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743418,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "gkgn7fxStHWfUMpNMITxF",
				"gap": 7.819074534539766,
				"focus": -0.385498327585516
			},
			"endBinding": {
				"elementId": "cCXwu2Nd",
				"gap": 4.3282804219502395,
				"focus": -0.16773271355068103
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					211.8183957859472,
					226.8898944256057
				]
			]
		},
		{
			"type": "rectangle",
			"version": 1821,
			"versionNonce": 605672505,
			"isDeleted": false,
			"id": "wH8MYjkqrsPgHRGP0SUWO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1055.7916666666667,
			"y": -124.27398862742416,
			"strokeColor": "#000000",
			"backgroundColor": "#228be6",
			"width": 218,
			"height": 60,
			"seed": 197576643,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "bMb55Tde",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				}
			],
			"updated": 1648805102721,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1648,
			"versionNonce": 817228339,
			"isDeleted": false,
			"id": "bMb55Tde",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1050.7916666666667,
			"y": -119.27398862742416,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 208,
			"height": 50,
			"seed": 247253485,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653346,
			"link": "[[mobileunit. AssetMobileUnit]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[mobileunit. \nAssetMobileUnit]]",
			"rawText": "[[mobileunit. AssetMobileUnit]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "wH8MYjkqrsPgHRGP0SUWO",
			"originalText": "📍[[mobileunit. AssetMobileUnit]]"
		},
		{
			"type": "rectangle",
			"version": 1896,
			"versionNonce": 371516697,
			"isDeleted": false,
			"id": "c-ipdrk3ll_LkqLdNokSf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1057.1210317460318,
			"y": -289.5993854528208,
			"strokeColor": "#000000",
			"backgroundColor": "#228be6",
			"width": 218,
			"height": 85,
			"seed": 887925795,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "OgNd3w1X",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "OMoH6-mlpD3KAJhISiHVy",
					"type": "arrow"
				},
				{
					"id": "pZzlPq59uuq7pb2w3PyYm",
					"type": "arrow"
				},
				{
					"id": "lL5dGlpr5l16DIwWibA4y",
					"type": "arrow"
				},
				{
					"id": "BBdDuQwA0LoywTHoJWgC8",
					"type": "arrow"
				}
			],
			"updated": 1648805102721,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1674,
			"versionNonce": 1511359677,
			"isDeleted": false,
			"id": "OgNd3w1X",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1052.1210317460318,
			"y": -272.0993854528208,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 208,
			"height": 50,
			"seed": 1587403661,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653348,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[mobileunit. \nMobileUnits]]",
			"rawText": "[[mobileunit. MobileUnits]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "c-ipdrk3ll_LkqLdNokSf",
			"originalText": "📍[[mobileunit. MobileUnits]]"
		},
		{
			"type": "arrow",
			"version": 1230,
			"versionNonce": 957549299,
			"isDeleted": false,
			"id": "IygDIeT8xKqDHHckqYgCx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1035.6625377471532,
			"y": -129.52398862742416,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 1.6995117278122507,
			"height": 74.0753968253967,
			"seed": 1298998448,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743422,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "wH8MYjkqrsPgHRGP0SUWO",
				"gap": 5.25,
				"focus": -0.8175860141113205
			},
			"endBinding": {
				"elementId": "c-ipdrk3ll_LkqLdNokSf",
				"gap": 1,
				"focus": 0.7714836470826306
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					1.6995117278122507,
					-74.0753968253967
				]
			]
		},
		{
			"type": "rectangle",
			"version": 2419,
			"versionNonce": 1836759993,
			"isDeleted": false,
			"id": "EstmDgrwCyko18b99ljJw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -703.5347222222223,
			"y": 340.0701230766108,
			"strokeColor": "#000000",
			"backgroundColor": "#12b886",
			"width": 257,
			"height": 60,
			"seed": 172214147,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "JmFh0qvU",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "ndb9jmeMHhFODVbBT2--3",
					"type": "arrow"
				},
				{
					"id": "uXCtM6p1HNnu-NV9H0zyw",
					"type": "arrow"
				},
				{
					"id": "M1CuErnnYYMSoOsFqHz6w",
					"type": "arrow"
				},
				{
					"id": "D9mSnFZ9I4VuMB1hNVVtG",
					"type": "arrow"
				},
				{
					"id": "GZ999IthLFLg11fWiPklA",
					"type": "arrow"
				},
				{
					"id": "_ijht77lDWJoVyeg5fvMK",
					"type": "arrow"
				}
			],
			"updated": 1648805137180,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2165,
			"versionNonce": 1574987603,
			"isDeleted": false,
			"id": "JmFh0qvU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -698.5347222222223,
			"y": 345.0701230766108,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 39888429,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653352,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "[[template. \nConfigurationGroups]",
			"rawText": "[[template. ConfigurationGroups]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "EstmDgrwCyko18b99ljJw",
			"originalText": "[[template. ConfigurationGroups]"
		},
		{
			"type": "arrow",
			"version": 2440,
			"versionNonce": 1592709907,
			"isDeleted": false,
			"id": "2yKCqrcXYLudX12JLy1qz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -838.1210317460318,
			"y": -227.00766895581944,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 145.60414516872027,
			"height": 554.4111253657636,
			"seed": 575983117,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743423,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "c-ipdrk3ll_LkqLdNokSf",
				"gap": 1,
				"focus": -0.8715200815929308
			},
			"endBinding": {
				"elementId": "EstmDgrwCyko18b99ljJw",
				"gap": 12.666666666666629,
				"focus": -0.7792753775637494
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					145.60414516872027,
					554.4111253657636
				]
			]
		},
		{
			"type": "rectangle",
			"version": 2414,
			"versionNonce": 820342713,
			"isDeleted": false,
			"id": "dXMIB8d6xp5UDdJx6lJiH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -358.2500901875902,
			"y": 672.3941897939982,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1331135501,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "8OdUYgvH",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				}
			],
			"updated": 1648805102722,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2183,
			"versionNonce": 353824403,
			"isDeleted": false,
			"id": "8OdUYgvH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -353.2500901875902,
			"y": 677.3941897939982,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 383536963,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653353,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "[[template. \nEventTemplates]",
			"rawText": "[[template. EventTemplates]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "dXMIB8d6xp5UDdJx6lJiH",
			"originalText": "[[template. EventTemplates]"
		},
		{
			"type": "arrow",
			"version": 2130,
			"versionNonce": 873998547,
			"isDeleted": false,
			"id": "5K8Vy6tKTmWryWyL8sFQp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -445.3995816860645,
			"y": 406.99452536089416,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 277.45559804232283,
			"height": 264.399664433104,
			"seed": 2042346381,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743427,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "EstmDgrwCyko18b99ljJw",
				"gap": 7.0168291294157825,
				"focus": -0.5681125189077724
			},
			"endBinding": {
				"elementId": "dXMIB8d6xp5UDdJx6lJiH",
				"gap": 1,
				"focus": 0.5896740521801382
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					277.45559804232283,
					264.399664433104
				]
			]
		},
		{
			"type": "rectangle",
			"version": 2429,
			"versionNonce": 299409783,
			"isDeleted": false,
			"id": "XzQEYW6yvoiN2YerKTWGg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -359.6256313131314,
			"y": 791.0625019073486,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1420955171,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "pMvAoLaA",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "uXCtM6p1HNnu-NV9H0zyw",
					"type": "arrow"
				},
				{
					"id": "ZkzBCvDmS7rdzPRMPTQKh",
					"type": "arrow"
				}
			],
			"updated": 1648805102722,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2191,
			"versionNonce": 220173533,
			"isDeleted": false,
			"id": "pMvAoLaA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -354.6256313131314,
			"y": 796.0625019073486,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 299342221,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653354,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "[[template. \nMobileDeviceTemplates]",
			"rawText": "[[template. MobileDeviceTemplates]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "XzQEYW6yvoiN2YerKTWGg",
			"originalText": "[[template. MobileDeviceTemplates]"
		},
		{
			"type": "rectangle",
			"version": 3393,
			"versionNonce": 223885335,
			"isDeleted": false,
			"id": "-BM1VMHjF0LTD5PHndzIx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 420.810876623376,
			"y": 981.3720257168725,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 111,
			"height": 60,
			"seed": 2082028899,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "RK3SRvaH",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "ZkzBCvDmS7rdzPRMPTQKh",
					"type": "arrow"
				},
				{
					"id": "OEB9YdDDmPwKoT85PNNKV",
					"type": "arrow"
				},
				{
					"id": "s1qXG_CtnmZQLLiqQWob0",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "D9mSnFZ9I4VuMB1hNVVtG",
					"type": "arrow"
				}
			],
			"updated": 1649055183650,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 3108,
			"versionNonce": 1281597939,
			"isDeleted": false,
			"id": "RK3SRvaH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 425.810876623376,
			"y": 986.3720257168725,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 101,
			"height": 50,
			"seed": 1529740877,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653356,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "[[library. \nLibraries]",
			"rawText": "[[library. Libraries]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "-BM1VMHjF0LTD5PHndzIx",
			"originalText": "[[library. Libraries]"
		},
		{
			"type": "arrow",
			"version": 3660,
			"versionNonce": 471388925,
			"isDeleted": false,
			"id": "ZkzBCvDmS7rdzPRMPTQKh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 419.810876623376,
			"y": 1000.7116648825914,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 513.8015873015868,
			"height": 151.81673014724777,
			"seed": 1108177133,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743429,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "-BM1VMHjF0LTD5PHndzIx",
				"gap": 1,
				"focus": -0.13004828200292712
			},
			"endBinding": {
				"elementId": "XzQEYW6yvoiN2YerKTWGg",
				"gap": 8.634920634920604,
				"focus": -0.1866712735809754
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-513.8015873015868,
					-151.81673014724777
				]
			]
		},
		{
			"type": "text",
			"version": 313,
			"versionNonce": 1397181241,
			"isDeleted": false,
			"id": "aGixBvHz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1029.7089646464647,
			"y": -148.0208282470703,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 130,
			"height": 25,
			"seed": 1110903693,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				}
			],
			"updated": 1648805102723,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "MobileUnitKey",
			"rawText": "MobileUnitKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "MobileUnitKey"
		},
		{
			"type": "text",
			"version": 325,
			"versionNonce": 1611718871,
			"isDeleted": false,
			"id": "NnddiwEO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -956.7922979797979,
			"y": -204.43748537699378,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 217,
			"height": 25,
			"seed": 1025487971,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102723,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "ConfigurationGroupKey",
			"rawText": "ConfigurationGroupKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "ConfigurationGroupKey"
		},
		{
			"type": "text",
			"version": 719,
			"versionNonce": 244022297,
			"isDeleted": false,
			"id": "LrJT7NHX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -379.8756313131314,
			"y": 640.9791812896729,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 179,
			"height": 25,
			"seed": 389199469,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102723,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "EventTemplateKey",
			"rawText": "EventTemplateKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "EventTemplateKey"
		},
		{
			"type": "text",
			"version": 924,
			"versionNonce": 252489207,
			"isDeleted": false,
			"id": "N10k6ocS",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -397.9705537518041,
			"y": 766.9910733359201,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 243,
			"height": 25,
			"seed": 1871650509,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102723,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "MobileDeviceTemplateKey",
			"rawText": "MobileDeviceTemplateKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "MobileDeviceTemplateKey"
		},
		{
			"type": "text",
			"version": 1686,
			"versionNonce": 253708727,
			"isDeleted": false,
			"id": "vysoFHLP",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 328.3350018037513,
			"y": 945.776800337292,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 100,
			"height": 25,
			"seed": 1158463907,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "ZkzBCvDmS7rdzPRMPTQKh",
					"type": "arrow"
				}
			],
			"updated": 1649055183653,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "LibraryKey",
			"rawText": "LibraryKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "LibraryKey"
		},
		{
			"type": "text",
			"version": 1822,
			"versionNonce": 1129436951,
			"isDeleted": false,
			"id": "cCXwu2Nd",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -23.18880772005832,
			"y": 1291.5505971454438,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 207,
			"height": 25,
			"seed": 2075394317,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "uDuxy_i7It6wdvtX4BKxX",
					"type": "arrow"
				}
			],
			"updated": 1648805102723,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "LocationTemplateKey",
			"rawText": "LocationTemplateKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "LocationTemplateKey"
		},
		{
			"type": "arrow",
			"version": 4825,
			"versionNonce": 1189047133,
			"isDeleted": false,
			"id": "OEB9YdDDmPwKoT85PNNKV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -139.67929292929318,
			"y": 998.8568496220382,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 552.9901695526689,
			"height": 30.377005087367024,
			"seed": 1964035021,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743429,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "gkgn7fxStHWfUMpNMITxF",
				"gap": 4.75,
				"focus": -0.8314959035005519
			},
			"endBinding": {
				"elementId": "-BM1VMHjF0LTD5PHndzIx",
				"gap": 7.500000000000227,
				"focus": -0.6451853037819267
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					552.9901695526689,
					30.377005087367024
				]
			]
		},
		{
			"type": "rectangle",
			"version": 3930,
			"versionNonce": 1129634871,
			"isDeleted": false,
			"id": "STojLunIr35WVyXVEhhMT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 172.58500180375154,
			"y": 1075.0029780978248,
			"strokeColor": "#495057",
			"backgroundColor": "#fab005",
			"width": 114,
			"height": 85,
			"seed": 1965398381,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "NPokJW4i",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "ZkzBCvDmS7rdzPRMPTQKh",
					"type": "arrow"
				},
				{
					"id": "OEB9YdDDmPwKoT85PNNKV",
					"type": "arrow"
				},
				{
					"id": "uDuxy_i7It6wdvtX4BKxX",
					"type": "arrow"
				},
				{
					"id": "aPl62MpcBBq6zEBX4epuv",
					"type": "arrow"
				},
				{
					"id": "s1qXG_CtnmZQLLiqQWob0",
					"type": "arrow"
				}
			],
			"updated": 1648805102723,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 3634,
			"versionNonce": 694389533,
			"isDeleted": false,
			"id": "NPokJW4i",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 177.58500180375154,
			"y": 1092.5029780978248,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 104,
			"height": 50,
			"seed": 212647907,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653356,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "[[library. \nLocations]",
			"rawText": "[[library. Locations]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "STojLunIr35WVyXVEhhMT",
			"originalText": "[[library. Locations]"
		},
		{
			"type": "arrow",
			"version": 5548,
			"versionNonce": 318389591,
			"isDeleted": false,
			"id": "uDuxy_i7It6wdvtX4BKxX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 197.6331829470518,
			"y": 1281.235540919339,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 6.8050087586639165,
			"height": 119.38833302202391,
			"seed": 2115266413,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1648805102723,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "cCXwu2Nd",
				"focus": 1.1235055700263128,
				"gap": 14.821990667110128
			},
			"endBinding": {
				"elementId": "56dA1Twx",
				"focus": -1.1155786379285115,
				"gap": 12.055570854345149
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					6.8050087586639165,
					-119.38833302202391
				]
			]
		},
		{
			"type": "text",
			"version": 2499,
			"versionNonce": 1590962073,
			"isDeleted": false,
			"id": "56dA1Twx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 10.382620851370575,
			"y": 1162.3839368366062,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 183,
			"height": 25,
			"seed": 1172548227,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "uDuxy_i7It6wdvtX4BKxX",
					"type": "arrow"
				}
			],
			"updated": 1648805102723,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "LibraryLocationKey",
			"rawText": "LibraryLocationKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "LibraryLocationKey"
		},
		{
			"type": "text",
			"version": 2271,
			"versionNonce": 1167489655,
			"isDeleted": false,
			"id": "f9NiGa0u",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 68.22801677489178,
			"y": 1081.935155758438,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 100,
			"height": 25,
			"seed": 1385568173,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "uDuxy_i7It6wdvtX4BKxX",
					"type": "arrow"
				},
				{
					"id": "aPl62MpcBBq6zEBX4epuv",
					"type": "arrow"
				}
			],
			"updated": 1648805102723,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "LibraryKey",
			"rawText": "LibraryKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "LibraryKey"
		},
		{
			"type": "arrow",
			"version": 5116,
			"versionNonce": 1194962643,
			"isDeleted": false,
			"id": "aPl62MpcBBq6zEBX4epuv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -139.02967235295503,
			"y": 1032.5946609936937,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 278.699046819041,
			"height": 42.090682016013034,
			"seed": 1646564291,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743418,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "gkgn7fxStHWfUMpNMITxF",
				"gap": 5.3996205763381795,
				"focus": -0.16033768732826917
			},
			"endBinding": {
				"elementId": "f9NiGa0u",
				"gap": 7.249812748731472,
				"focus": 1.1464608636107254
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					278.699046819041,
					42.090682016013034
				]
			]
		},
		{
			"type": "arrow",
			"version": 2695,
			"versionNonce": 54943741,
			"isDeleted": false,
			"id": "ndb9jmeMHhFODVbBT2--3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -678.2646158705818,
			"y": 404.45899071356257,
			"strokeColor": "#3333",
			"backgroundColor": "transparent",
			"width": 313.42542812917867,
			"height": 658.4901115847858,
			"seed": 2086993891,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743424,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "EstmDgrwCyko18b99ljJw",
				"gap": 4.3888676369517725,
				"focus": 0.7997590171772315
			},
			"endBinding": {
				"elementId": "koX1Xlem",
				"focus": -0.8331555197150087,
				"gap": 5.70243860340247
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-4.991494338653752,
					632.3214285714284
				],
				[
					308.4339337905249,
					658.4901115847858
				]
			]
		},
		{
			"type": "arrow",
			"version": 4749,
			"versionNonce": 1365044349,
			"isDeleted": false,
			"id": "s1qXG_CtnmZQLLiqQWob0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 293.10107704369534,
			"y": 1159.3964288363431,
			"strokeColor": "#495057",
			"backgroundColor": "transparent",
			"width": 127.0855106023273,
			"height": 114.84335342059649,
			"seed": 1050714211,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743430,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "STojLunIr35WVyXVEhhMT",
				"gap": 6.516075239943802,
				"focus": 1.0561842112594095
			},
			"endBinding": {
				"elementId": "-BM1VMHjF0LTD5PHndzIx",
				"gap": 3.241730080366551,
				"focus": 0.2187894802267108
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					127.0855106023273,
					-114.84335342059649
				]
			]
		},
		{
			"type": "arrow",
			"version": 2631,
			"versionNonce": 557198995,
			"isDeleted": false,
			"id": "tvan7cB59_KVHfR4SpDRQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -91.94658639971146,
			"y": 690.559970154362,
			"strokeColor": "#c925",
			"backgroundColor": "transparent",
			"width": 594.4467654521852,
			"height": 277.2680713571626,
			"seed": 497864301,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743429,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "dXMIB8d6xp5UDdJx6lJiH",
				"gap": 9.303503787878753,
				"focus": -0.6929363724726053
			},
			"endBinding": {
				"elementId": "-BM1VMHjF0LTD5PHndzIx",
				"gap": 13.543984205347897,
				"focus": 0.748313259993927
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					453.33333333333314,
					83.24426183335316
				],
				[
					594.4467654521852,
					277.2680713571626
				]
			]
		},
		{
			"type": "arrow",
			"version": 1422,
			"versionNonce": 167738941,
			"isDeleted": false,
			"id": "uXCtM6p1HNnu-NV9H0zyw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -462.7040791211182,
			"y": 405.7296874705502,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 100.98372349668216,
			"height": 378.85823841908075,
			"seed": 2064102989,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743428,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "EstmDgrwCyko18b99ljJw",
				"gap": 5.659564393939377,
				"focus": -0.7533213727385595
			},
			"endBinding": {
				"elementId": "XzQEYW6yvoiN2YerKTWGg",
				"gap": 6.804998497397037,
				"focus": -0.88553613080748
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					100.98372349668216,
					378.85823841908075
				]
			]
		},
		{
			"type": "text",
			"version": 1405,
			"versionNonce": 303126999,
			"isDeleted": false,
			"id": "koX1Xlem",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -471.3672213203463,
			"y": 1032.246663694946,
			"strokeColor": "#3333",
			"backgroundColor": "transparent",
			"width": 100,
			"height": 25,
			"seed": 119099843,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "ZkzBCvDmS7rdzPRMPTQKh",
					"type": "arrow"
				},
				{
					"id": "ndb9jmeMHhFODVbBT2--3",
					"type": "arrow"
				}
			],
			"updated": 1648805102724,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "LibraryKey",
			"rawText": "LibraryKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "LibraryKey"
		},
		{
			"type": "arrow",
			"version": 1973,
			"versionNonce": 1626515443,
			"isDeleted": false,
			"id": "M1CuErnnYYMSoOsFqHz6w",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -556.289384682233,
			"y": 401.0701230766108,
			"strokeColor": "#000000",
			"backgroundColor": "#12b886",
			"width": 188.1796891853898,
			"height": 593.1524457558619,
			"seed": 872404120,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743424,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "EstmDgrwCyko18b99ljJw",
				"gap": 1,
				"focus": -0.14683858324160062
			},
			"endBinding": {
				"elementId": "qjIESy6h",
				"focus": -0.8607828282836,
				"gap": 13.598833817462378
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-2.6580810464832894,
					572.7678976526854
				],
				[
					185.52160813890652,
					593.1524457558619
				]
			]
		},
		{
			"type": "text",
			"version": 1986,
			"versionNonce": 2090206967,
			"isDeleted": false,
			"id": "qjIESy6h",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -526.709370490621,
			"y": 955.6237350150103,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 207,
			"height": 25,
			"seed": 1728133016,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "M1CuErnnYYMSoOsFqHz6w",
					"type": "arrow"
				}
			],
			"updated": 1648805102724,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "LocationTemplateKey",
			"rawText": "LocationTemplateKey",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "LocationTemplateKey"
		},
		{
			"type": "rectangle",
			"version": 2038,
			"versionNonce": 1156270073,
			"isDeleted": false,
			"id": "xGX6-EEbGTVKpzpa7SxT-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1398.4074946130852,
			"y": -124.40797529179315,
			"strokeColor": "#000000",
			"backgroundColor": "#868e96",
			"width": 218,
			"height": 60,
			"seed": 1757573016,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "kTIe6hih",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				},
				{
					"id": "JkH2B6gPJvUxYcXwq94Rf",
					"type": "arrow"
				},
				{
					"id": "09COOPCe6YK0m-MHbCtBt",
					"type": "arrow"
				}
			],
			"updated": 1648805102724,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1862,
			"versionNonce": 867181629,
			"isDeleted": false,
			"id": "kTIe6hih",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1393.4074946130852,
			"y": -119.40797529179315,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 208,
			"height": 50,
			"seed": 1318057448,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653358,
			"link": "[[FMOnlineDB.\ndbo.Organisation]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[FMOnlineDB.\ndbo.Organisation]]",
			"rawText": "[[FMOnlineDB.\ndbo.Organisation]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "xGX6-EEbGTVKpzpa7SxT-",
			"originalText": "📍[[FMOnlineDB.\ndbo.Organisation]]"
		},
		{
			"type": "arrow",
			"version": 738,
			"versionNonce": 1063539933,
			"isDeleted": false,
			"id": "RTy3CyMidk3B2_AxxwHAo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1060.9865643159224,
			"y": -104.77373983878101,
			"strokeColor": "#000000",
			"backgroundColor": "#868e96",
			"width": 114.33333333333303,
			"height": 1.8927723553718465,
			"seed": 2121591272,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743431,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "wH8MYjkqrsPgHRGP0SUWO",
				"gap": 5.1948976492556085,
				"focus": 0.3895750496141859
			},
			"endBinding": {
				"elementId": "xGX6-EEbGTVKpzpa7SxT-",
				"gap": 5.08759696382981,
				"focus": -0.20702391661994327
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-114.33333333333303,
					1.8927723553718465
				]
			]
		},
		{
			"type": "text",
			"version": 1965,
			"versionNonce": 521925943,
			"isDeleted": false,
			"id": "OjP8OjIT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1363.4310087603665,
			"y": -60.07994970924403,
			"strokeColor": "#087f5b",
			"backgroundColor": "transparent",
			"width": 217,
			"height": 25,
			"seed": 1186981352,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				}
			],
			"updated": 1648805102724,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "liOrgID = legacyOrgId",
			"rawText": "liOrgID = legacyOrgId",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "liOrgID = legacyOrgId"
		},
		{
			"type": "rectangle",
			"version": 2198,
			"versionNonce": 1486586323,
			"isDeleted": false,
			"id": "3CpO0ZR-xGl-Pba2Jes44",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1756.110514751756,
			"y": -121.08932921862356,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 185,
			"height": 60,
			"seed": 2056432360,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "FE08ZXxd",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				},
				{
					"id": "JkH2B6gPJvUxYcXwq94Rf",
					"type": "arrow"
				},
				{
					"id": "Pk_i9sSd5y4f3nI8kdQy0",
					"type": "arrow"
				},
				{
					"id": "Yc7YS6IECmvXEuApCw6V7",
					"type": "arrow"
				}
			],
			"updated": 1654760677742,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2028,
			"versionNonce": 167633235,
			"isDeleted": false,
			"id": "FE08ZXxd",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1751.110514751756,
			"y": -103.58932921862356,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 175,
			"height": 25,
			"seed": 762304408,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653359,
			"link": "[[dbo.Vehicles]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[dbo.Vehicles]]",
			"rawText": "[[dbo.Vehicles]]",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "3CpO0ZR-xGl-Pba2Jes44",
			"originalText": "📍[[dbo.Vehicles]]"
		},
		{
			"type": "text",
			"version": 2191,
			"versionNonce": 315118227,
			"isDeleted": false,
			"id": "69MvgBQD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1767.1313644285472,
			"y": -57.462345091639406,
			"strokeColor": "#087f5b",
			"backgroundColor": "transparent",
			"width": 269,
			"height": 25,
			"seed": 175493016,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				}
			],
			"updated": 1654760699637,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "iVehicleID = legacyVehicleId",
			"rawText": "iVehicleID = legacyVehicleId",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "iVehicleID = legacyVehicleId"
		},
		{
			"type": "arrow",
			"version": 668,
			"versionNonce": 512209587,
			"isDeleted": false,
			"id": "JkH2B6gPJvUxYcXwq94Rf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1405.356472653656,
			"y": -79.90686400545125,
			"strokeColor": "#000000",
			"backgroundColor": "#fa5252",
			"width": 160.3571428571429,
			"height": 2.30115235564422,
			"seed": 260294376,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743433,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "xGX6-EEbGTVKpzpa7SxT-",
				"gap": 6.948978040570864,
				"focus": -0.40670241742860613
			},
			"endBinding": {
				"elementId": "3CpO0ZR-xGl-Pba2Jes44",
				"gap": 5.396899240957055,
				"focus": 0.47525358489066105
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-160.3571428571429,
					2.30115235564422
				]
			]
		},
		{
			"type": "rectangle",
			"version": 2297,
			"versionNonce": 868932314,
			"isDeleted": false,
			"id": "UQKZQXnFIwSKPGznWVhtn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1737.9679445151273,
			"y": -282.11851127288725,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 161,
			"height": 60,
			"seed": 1124574440,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "ZZSSOoEJ",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				},
				{
					"id": "JkH2B6gPJvUxYcXwq94Rf",
					"type": "arrow"
				},
				{
					"id": "Pk_i9sSd5y4f3nI8kdQy0",
					"type": "arrow"
				}
			],
			"updated": 1650480347211,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2132,
			"versionNonce": 320970173,
			"isDeleted": false,
			"id": "ZZSSOoEJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1732.9679445151273,
			"y": -264.61851127288725,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 151,
			"height": 25,
			"seed": 241139096,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653360,
			"link": "[[dbo.Sites]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[dbo.Sites]]",
			"rawText": "[[dbo.Sites]]",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "UQKZQXnFIwSKPGznWVhtn",
			"originalText": "📍[[dbo.Sites]]"
		},
		{
			"type": "arrow",
			"version": 845,
			"versionNonce": 2130717587,
			"isDeleted": false,
			"id": "Pk_i9sSd5y4f3nI8kdQy0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1681.5104484793956,
			"y": -132.48171484492218,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 0.1311153550891504,
			"height": 84.4217522908919,
			"seed": 1267092456,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743434,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "3CpO0ZR-xGl-Pba2Jes44",
				"gap": 11.39238562629859,
				"focus": -0.19411001130006064
			},
			"endBinding": {
				"elementId": "UQKZQXnFIwSKPGznWVhtn",
				"gap": 5.215044137073164,
				"focus": 0.29618504360398223
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					0.1311153550891504,
					-84.4217522908919
				]
			]
		},
		{
			"type": "text",
			"version": 2250,
			"versionNonce": 1093149111,
			"isDeleted": false,
			"id": "Jf7KpvL4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1795.310981186135,
			"y": -211.60015172944605,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 76,
			"height": 25,
			"seed": 71244696,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				}
			],
			"updated": 1648805102724,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "liSiteID",
			"rawText": "liSiteID",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "liSiteID"
		},
		{
			"type": "rectangle",
			"version": 2466,
			"versionNonce": 1395956678,
			"isDeleted": false,
			"id": "7zAw7HJHNIBYFfZZbIlpJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1841.5811647453052,
			"y": 111.12641221276232,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 282,
			"height": 60,
			"seed": 1007842968,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "pnC2L6M2",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				},
				{
					"id": "JkH2B6gPJvUxYcXwq94Rf",
					"type": "arrow"
				},
				{
					"id": "Pk_i9sSd5y4f3nI8kdQy0",
					"type": "arrow"
				},
				{
					"id": "09COOPCe6YK0m-MHbCtBt",
					"type": "arrow"
				},
				{
					"id": "5gSVmN45RCi-kpwT2Lg0m",
					"type": "arrow"
				}
			],
			"updated": 1650480331150,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2304,
			"versionNonce": 1675170429,
			"isDeleted": false,
			"id": "pnC2L6M2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1836.5811647453052,
			"y": 128.62641221276232,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 272,
			"height": 25,
			"seed": 493346536,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653361,
			"link": "[[dynamix.MapLocations]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[dynamix.MapLocations]]",
			"rawText": "[[dynamix.MapLocations]]",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "7zAw7HJHNIBYFfZZbIlpJ",
			"originalText": "📍[[dynamix.MapLocations]]"
		},
		{
			"type": "arrow",
			"version": 484,
			"versionNonce": 286804765,
			"isDeleted": false,
			"id": "09COOPCe6YK0m-MHbCtBt",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1404.1733162204748,
			"y": -80.01128893012763,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 154.40784852483057,
			"height": 199.55948512204898,
			"seed": 1208984984,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743435,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "xGX6-EEbGTVKpzpa7SxT-",
				"gap": 5.765821607389626,
				"focus": 0.9462024706009136
			},
			"endBinding": {
				"elementId": "7zAw7HJHNIBYFfZZbIlpJ",
				"gap": 1,
				"focus": 0.49942074481306703
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-38.098324715305125,
					140.1535868744215
				],
				[
					-154.40784852483057,
					199.55948512204898
				]
			]
		},
		{
			"type": "text",
			"version": 2371,
			"versionNonce": 947281911,
			"isDeleted": false,
			"id": "SPJDxUHE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1650.3986250627647,
			"y": 88.11848842048428,
			"strokeColor": "#087f5b",
			"backgroundColor": "transparent",
			"width": 145,
			"height": 25,
			"seed": 938885528,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				}
			],
			"updated": 1648805102724,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "DmxLocationId",
			"rawText": "DmxLocationId",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "DmxLocationId"
		},
		{
			"type": "rectangle",
			"version": 2495,
			"versionNonce": 978989210,
			"isDeleted": false,
			"id": "ST86X_i3kNZyKJ7xlzKah",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1838.8271964913363,
			"y": 256.53119954884,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 250,
			"height": 60,
			"seed": 289264872,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "A5szKn9k",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				},
				{
					"id": "JkH2B6gPJvUxYcXwq94Rf",
					"type": "arrow"
				},
				{
					"id": "Pk_i9sSd5y4f3nI8kdQy0",
					"type": "arrow"
				},
				{
					"id": "09COOPCe6YK0m-MHbCtBt",
					"type": "arrow"
				},
				{
					"id": "5gSVmN45RCi-kpwT2Lg0m",
					"type": "arrow"
				}
			],
			"updated": 1650480353386,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2336,
			"versionNonce": 1315417459,
			"isDeleted": false,
			"id": "A5szKn9k",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1833.8271964913363,
			"y": 274.03119954884,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 240,
			"height": 25,
			"seed": 165957016,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653362,
			"link": "[[dbo.MapLocations]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[dbo.MapLocations]]",
			"rawText": "[[dbo.MapLocations]]",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ST86X_i3kNZyKJ7xlzKah",
			"originalText": "📍[[dbo.MapLocations]]"
		},
		{
			"type": "arrow",
			"version": 963,
			"versionNonce": 1967908829,
			"isDeleted": false,
			"id": "5gSVmN45RCi-kpwT2Lg0m",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1787.6449866771577,
			"y": 175.69782806853374,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 1.4334091572045509,
			"height": 75.83333333333337,
			"seed": 25853928,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743436,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "7zAw7HJHNIBYFfZZbIlpJ",
				"gap": 4.57141585577142,
				"focus": 0.6103845612514589
			},
			"endBinding": {
				"elementId": "ST86X_i3kNZyKJ7xlzKah",
				"gap": 5.000038146972884,
				"focus": -0.604559601298064
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-1.4334091572045509,
					75.83333333333337
				]
			]
		},
		{
			"type": "text",
			"version": 2391,
			"versionNonce": 1601834551,
			"isDeleted": false,
			"id": "AXQT2V8z",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1734.5892723979048,
			"y": 231.61052648123217,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 301,
			"height": 25,
			"seed": 1700044008,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "MapLocationKey = liLocationId",
			"rawText": "MapLocationKey = liLocationId",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "MapLocationKey = liLocationId"
		},
		{
			"type": "rectangle",
			"version": 2508,
			"versionNonce": 1129174170,
			"isDeleted": false,
			"id": "rJRhhZT-8e2yxdi2yDB55",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1334.8136505858333,
			"y": 19.348135183518707,
			"strokeColor": "#000000",
			"backgroundColor": "#fa5252",
			"width": 218,
			"height": 85,
			"seed": 1225515416,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "ZxUV0wJp",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				}
			],
			"updated": 1650480364127,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2287,
			"versionNonce": 1083890182,
			"isDeleted": false,
			"id": "ZxUV0wJp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1329.8136505858333,
			"y": 49.34813518351871,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 208,
			"height": 25,
			"seed": 122594280,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1650480364127,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "OVERWRITTEN????",
			"rawText": "OVERWRITTEN????",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "rJRhhZT-8e2yxdi2yDB55",
			"originalText": "OVERWRITTEN????"
		},
		{
			"type": "text",
			"version": 695,
			"versionNonce": 1318859098,
			"isDeleted": false,
			"id": "Pe5t9f7O",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1309.4383076024474,
			"y": 113.25338362408934,
			"strokeColor": "#000000",
			"backgroundColor": "#fa5252",
			"width": 431,
			"height": 250,
			"seed": 484797672,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1650480364127,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "mobileunit.OverridenCanParameters\nmobileunit.OverridenDeviceParameters\nmobileunit.OverridenDeviceProperties\nmobileunit.OverridenDevices\n\nmobileunit.OverridenEventActions\nmobileunit.OverridenEventConditionThresholds\nmobileunit.OverridenEvents\n\nmobileunit.OverridenPeripheralDevices",
			"rawText": "mobileunit.OverridenCanParameters\nmobileunit.OverridenDeviceParameters\nmobileunit.OverridenDeviceProperties\nmobileunit.OverridenDevices\n\nmobileunit.OverridenEventActions\nmobileunit.OverridenEventConditionThresholds\nmobileunit.OverridenEvents\n\nmobileunit.OverridenPeripheralDevices",
			"baseline": 243,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "mobileunit.OverridenCanParameters\nmobileunit.OverridenDeviceParameters\nmobileunit.OverridenDeviceProperties\nmobileunit.OverridenDevices\n\nmobileunit.OverridenEventActions\nmobileunit.OverridenEventConditionThresholds\nmobileunit.OverridenEvents\n\nmobileunit.OverridenPeripheralDevices"
		},
		{
			"type": "ellipse",
			"version": 128,
			"versionNonce": 2073504887,
			"isDeleted": false,
			"id": "Cbz7x7sI2B30CkRFs6P1D",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1404.0375139516518,
			"y": -168.5850098285514,
			"strokeColor": "#000000",
			"backgroundColor": "#fa5252",
			"width": 219,
			"height": 39,
			"seed": 1053982104,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"type": "text",
					"id": "M2EVBIVs"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 101,
			"versionNonce": 236534393,
			"isDeleted": false,
			"id": "M2EVBIVs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1399.0375139516518,
			"y": -161.5850098285514,
			"strokeColor": "#000000",
			"backgroundColor": "#fa5252",
			"width": 209,
			"height": 25,
			"seed": 388220824,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "sConnectDatabase",
			"rawText": "sConnectDatabase",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Cbz7x7sI2B30CkRFs6P1D",
			"originalText": "sConnectDatabase"
		},
		{
			"type": "rectangle",
			"version": 2398,
			"versionNonce": 1728611735,
			"isDeleted": false,
			"id": "LoaWLfIO7B36PfQ9PF28_",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -573.3906885548282,
			"y": -1125.145871930757,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1703258617,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "7Bmd2WCH",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2180,
			"versionNonce": 1867142973,
			"isDeleted": false,
			"id": "7Bmd2WCH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -568.3906885548282,
			"y": -1120.145871930757,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 1585237527,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653364,
			"link": "[[definition MobileDevices]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[definition \nMobileDevices]]",
			"rawText": "[[definition MobileDevices]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "LoaWLfIO7B36PfQ9PF28_",
			"originalText": "📍[[definition MobileDevices]]"
		},
		{
			"type": "arrow",
			"version": 563,
			"versionNonce": 1257976979,
			"isDeleted": false,
			"id": "OMoH6-mlpD3KAJhISiHVy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -951.6861695542373,
			"y": -294.4166850117041,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 371.84531374867174,
			"height": 821.21080368321,
			"seed": 2012994841,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743422,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "c-ipdrk3ll_LkqLdNokSf",
				"gap": 4.817299558883292,
				"focus": -0.19486651634433816
			},
			"endBinding": {
				"elementId": "iTVxt7qP",
				"gap": 15.833333333333258,
				"focus": 0.8022260675853979
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					371.84531374867174,
					-821.21080368321
				]
			]
		},
		{
			"type": "text",
			"version": 368,
			"versionNonce": 1743106105,
			"isDeleted": false,
			"id": "iTVxt7qP",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -573.2240218881611,
			"y": -1170.011923106942,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 164,
			"height": 40,
			"seed": 583517847,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "OMoH6-mlpD3KAJhISiHVy",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "dmd.DeviceKey \n= mu.MobileDeviceKey",
			"rawText": "dmd.DeviceKey \n= mu.MobileDeviceKey",
			"baseline": 34,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "dmd.DeviceKey \n= mu.MobileDeviceKey"
		},
		{
			"type": "arrow",
			"version": 1319,
			"versionNonce": 1467480093,
			"isDeleted": false,
			"id": "D9mSnFZ9I4VuMB1hNVVtG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -440.60497426911394,
			"y": 356.09676742530786,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 1780,
			"height": 624.1368553082286,
			"seed": 338645369,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743429,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "EstmDgrwCyko18b99ljJw",
				"gap": 5.929747953108404,
				"focus": -0.5308420861126383
			},
			"endBinding": {
				"elementId": "-BM1VMHjF0LTD5PHndzIx",
				"gap": 1.1384029833359364,
				"focus": -0.5262385326823661
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					1780,
					52.47018864156206
				],
				[
					911.0441134067864,
					624.1368553082286
				]
			]
		},
		{
			"type": "rectangle",
			"version": 2429,
			"versionNonce": 739590425,
			"isDeleted": false,
			"id": "Vd1tua7IVJIG-AN9zARbX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -569.5357665670937,
			"y": -1036.1949486950348,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 819708439,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "IiUT69dQ",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "pZzlPq59uuq7pb2w3PyYm",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2227,
			"versionNonce": 1926831699,
			"isDeleted": false,
			"id": "IiUT69dQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -564.5357665670937,
			"y": -1031.1949486950348,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 759844569,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653366,
			"link": "[[definition MobileDeviceLines]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[definition \nMobileDeviceLines]]",
			"rawText": "[[definition MobileDeviceLines]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Vd1tua7IVJIG-AN9zARbX",
			"originalText": "📍[[definition MobileDeviceLines]]"
		},
		{
			"type": "arrow",
			"version": 468,
			"versionNonce": 916251709,
			"isDeleted": false,
			"id": "pZzlPq59uuq7pb2w3PyYm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -956.9048287606622,
			"y": -297.26637726646345,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 384.2023955269019,
			"height": 709.2654346102964,
			"seed": 487288473,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743439,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "c-ipdrk3ll_LkqLdNokSf",
				"gap": 7.666991813642653,
				"focus": -0.2723699410822261
			},
			"endBinding": {
				"elementId": "Vd1tua7IVJIG-AN9zARbX",
				"gap": 3.1666666666666288,
				"focus": 0.9108703914861266
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					384.2023955269019,
					-709.2654346102964
				]
			]
		},
		{
			"type": "text",
			"version": 274,
			"versionNonce": 1838776855,
			"isDeleted": false,
			"id": "RYpHXZ5H",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -586.0357665670938,
			"y": -968.6949486950348,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 182,
			"height": 40,
			"seed": 1504645175,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "dmdl.[MobileDeviceKey] \n= mu.[MobileDeviceKey]",
			"rawText": "dmdl.[MobileDeviceKey] \n= mu.[MobileDeviceKey]",
			"baseline": 34,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "dmdl.[MobileDeviceKey] \n= mu.[MobileDeviceKey]"
		},
		{
			"type": "rectangle",
			"version": 2460,
			"versionNonce": 1950912217,
			"isDeleted": false,
			"id": "BzHx9EkywIfob2J5Fo7vc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 187.1309000995734,
			"y": -1050.3616153617013,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 278453081,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "xDTIf93X",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				},
				{
					"id": "TDGyMcY-Ki9OAHeQgYdBE",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2245,
			"versionNonce": 1854793107,
			"isDeleted": false,
			"id": "xDTIf93X",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 192.1309000995734,
			"y": -1032.8616153617013,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 25,
			"seed": 108520119,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653367,
			"link": "[[definition Lines]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[definition Lines]]",
			"rawText": "[[definition Lines]]",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "BzHx9EkywIfob2J5Fo7vc",
			"originalText": "📍[[definition Lines]]"
		},
		{
			"type": "arrow",
			"version": 667,
			"versionNonce": 555006205,
			"isDeleted": false,
			"id": "s7GepDh6lwdFsYQGdacqF",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -305.48021101153813,
			"y": -1017.028282028368,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 489.44444444444457,
			"height": 6.666666666666629,
			"seed": 1940252503,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743440,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "Vd1tua7IVJIG-AN9zARbX",
				"gap": 7.055555555555543,
				"focus": -0.28305090805090605
			},
			"endBinding": {
				"elementId": "BzHx9EkywIfob2J5Fo7vc",
				"gap": 3.16666666666697,
				"focus": 0.1614709948043292
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					489.44444444444457,
					-6.666666666666629
				]
			]
		},
		{
			"type": "text",
			"version": 184,
			"versionNonce": 160639063,
			"isDeleted": false,
			"id": "66bs1Drx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 193.96423343290644,
			"y": -1076.1949486950348,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 56,
			"height": 20,
			"seed": 1057868279,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "LineKey",
			"rawText": "LineKey",
			"baseline": 14,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "LineKey"
		},
		{
			"type": "rectangle",
			"version": 2496,
			"versionNonce": 1792240793,
			"isDeleted": false,
			"id": "pHBz722yyCchognYe4lma",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 188.79756676623947,
			"y": -985.3616153617013,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1932617273,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "T2qEqXuA",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2282,
			"versionNonce": 1876559223,
			"isDeleted": false,
			"id": "T2qEqXuA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 193.79756676623947,
			"y": -967.8616153617013,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 25,
			"seed": 531232215,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102725,
			"link": "[[definition Lines]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Equivalent Line",
			"rawText": "Equivalent Line",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "pHBz722yyCchognYe4lma",
			"originalText": "Equivalent Line"
		},
		{
			"type": "line",
			"version": 175,
			"versionNonce": 382497145,
			"isDeleted": false,
			"id": "YC9SUordtUJt456-N08w_",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 385.63090009957295,
			"y": -953.6949486950348,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 0,
			"height": 0,
			"seed": 1123270745,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0
				]
			]
		},
		{
			"type": "text",
			"version": 220,
			"versionNonce": 1602764439,
			"isDeleted": false,
			"id": "Zj0dJTxh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 188.96423343290598,
			"y": -918.6949486950348,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 208,
			"height": 40,
			"seed": 804747223,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "dl_e.[LineKey] \n= dmdl.[EquivalentLineKey]",
			"rawText": "dl_e.[LineKey] \n= dmdl.[EquivalentLineKey]",
			"baseline": 34,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "dl_e.[LineKey] \n= dmdl.[EquivalentLineKey]"
		},
		{
			"type": "rectangle",
			"version": 2986,
			"versionNonce": 1796332121,
			"isDeleted": false,
			"id": "vnTXyKloMG64Q6sx_Drg7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -331.89687767820476,
			"y": -721.6116153617013,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1559653049,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "xIqOoEa7",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				},
				{
					"id": "arWclQklpvAPVAMil10sD",
					"type": "arrow"
				},
				{
					"id": "GZ999IthLFLg11fWiPklA",
					"type": "arrow"
				},
				{
					"id": "xEdRddZXu-SA8Y1nCgCJ2",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2780,
			"versionNonce": 899467891,
			"isDeleted": false,
			"id": "xIqOoEa7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -326.89687767820476,
			"y": -704.1116153617013,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 25,
			"seed": 1678080343,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653369,
			"link": "[[template Devices]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[template Devices]]",
			"rawText": "[[template Devices]]",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "vnTXyKloMG64Q6sx_Drg7",
			"originalText": "📍[[template Devices]]"
		},
		{
			"type": "text",
			"version": 679,
			"versionNonce": 1752639289,
			"isDeleted": false,
			"id": "6ehkitDm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -335.0635443448715,
			"y": -759.9449486950347,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 258,
			"height": 40,
			"seed": 116711799,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "td.[MobileDeviceTemplateKey] \n= tcg.[MobileDeviceTemplateKey]",
			"rawText": "td.[MobileDeviceTemplateKey] \n= tcg.[MobileDeviceTemplateKey]",
			"baseline": 34,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "td.[MobileDeviceTemplateKey] \n= tcg.[MobileDeviceTemplateKey]"
		},
		{
			"type": "rectangle",
			"version": 3085,
			"versionNonce": 1532806359,
			"isDeleted": false,
			"id": "wve9RZQYA0fVDg-Fhjbdf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 24.769788988461983,
			"y": -724.9449486950349,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1950324761,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "pvR3jO29",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				},
				{
					"id": "arWclQklpvAPVAMil10sD",
					"type": "arrow"
				},
				{
					"id": "Ycnv5bM-H0olzY2I9C6zp",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2875,
			"versionNonce": 1798113715,
			"isDeleted": false,
			"id": "pvR3jO29",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 29.769788988461983,
			"y": -707.4449486950349,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 25,
			"seed": 590893559,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653370,
			"link": "[[definition Devices]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[definition Devices]]",
			"rawText": "[[definition Devices]]",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "wve9RZQYA0fVDg-Fhjbdf",
			"originalText": "📍[[definition Devices]]"
		},
		{
			"type": "text",
			"version": 627,
			"versionNonce": 2134643191,
			"isDeleted": false,
			"id": "XmfFcGe8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 29.936455655128043,
			"y": -758.2782820283679,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 133,
			"height": 40,
			"seed": 1931638809,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "dd.[DeviceKey] \n= td.[DeviceKey]",
			"rawText": "dd.[DeviceKey] \n= td.[DeviceKey]",
			"baseline": 34,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "dd.[DeviceKey] \n= td.[DeviceKey]"
		},
		{
			"type": "arrow",
			"version": 1918,
			"versionNonce": 2117456509,
			"isDeleted": false,
			"id": "arWclQklpvAPVAMil10sD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -66.73021101153824,
			"y": -691.6116153617013,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 88.33333333333326,
			"height": 0,
			"seed": 1118983191,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743444,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "vnTXyKloMG64Q6sx_Drg7",
				"gap": 8.166666666666515,
				"focus": 0
			},
			"endBinding": {
				"elementId": "wve9RZQYA0fVDg-Fhjbdf",
				"gap": 3.16666666666697,
				"focus": -0.11111111111111997
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					88.33333333333326,
					0
				]
			]
		},
		{
			"type": "arrow",
			"version": 914,
			"versionNonce": 1504599485,
			"isDeleted": false,
			"id": "GZ999IthLFLg11fWiPklA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -461.98814751947504,
			"y": 336.48362273353655,
			"strokeColor": "#e67700",
			"backgroundColor": "#fa5252",
			"width": 144.4891580331078,
			"height": 987.4285714285709,
			"seed": 1294554935,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743443,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "EstmDgrwCyko18b99ljJw",
				"gap": 3.586500343074249,
				"focus": 0.8522178107594829
			},
			"endBinding": {
				"elementId": "vnTXyKloMG64Q6sx_Drg7",
				"gap": 10.66666666666697,
				"focus": 0.5344975407247006
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					52.142857142857395,
					-872.1428571428572
				],
				[
					144.4891580331078,
					-987.4285714285709
				]
			]
		},
		{
			"type": "rectangle",
			"version": 941,
			"versionNonce": 1931044313,
			"isDeleted": false,
			"id": "JpyDdo9UkhH-Rqz_d5D67",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 27.714233432906212,
			"y": -630.6393931394792,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 810.2777777777778,
			"height": 420.277777777778,
			"seed": 1418600247,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "TDGyMcY-Ki9OAHeQgYdBE",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 617,
			"versionNonce": 1912291383,
			"isDeleted": false,
			"id": "peer7DSw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 382.15867787735056,
			"y": -612.3616153617015,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 246,
			"height": 35,
			"seed": 1841852567,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102725,
			"link": null,
			"locked": false,
			"fontSize": 28,
			"fontFamily": 1,
			"text": "Cross Alied as pd",
			"rawText": "Cross Alied as pd",
			"baseline": 25,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Cross Alied as pd"
		},
		{
			"type": "rectangle",
			"version": 2965,
			"versionNonce": 780223161,
			"isDeleted": false,
			"id": "4rjYGl8UIhUCz5tqJukSZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 40.325344544017184,
			"y": -488.6949486950348,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 2021184089,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "ykqO2DUV",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				},
				{
					"id": "arWclQklpvAPVAMil10sD",
					"type": "arrow"
				},
				{
					"id": "GZ999IthLFLg11fWiPklA",
					"type": "arrow"
				},
				{
					"id": "LdJW69NjYvdXu7frikJKX",
					"type": "arrow"
				},
				{
					"id": "xEdRddZXu-SA8Y1nCgCJ2",
					"type": "arrow"
				}
			],
			"updated": 1648805102725,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2764,
			"versionNonce": 1741685693,
			"isDeleted": false,
			"id": "ykqO2DUV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 45.325344544017184,
			"y": -483.6949486950348,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 100064183,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653373,
			"link": "[[template PeripheralDevices]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[template \nPeripheralDevices]]",
			"rawText": "[[template PeripheralDevices]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "4rjYGl8UIhUCz5tqJukSZ",
			"originalText": "📍[[template PeripheralDevices]]"
		},
		{
			"type": "rectangle",
			"version": 3198,
			"versionNonce": 1855619993,
			"isDeleted": false,
			"id": "PUP5T6WkJSLYmd-hYpZ_P",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 169.82534454401718,
			"y": -316.3338375839237,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 290,
			"height": 85,
			"seed": 485125049,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "GxPk47Tx",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				},
				{
					"id": "arWclQklpvAPVAMil10sD",
					"type": "arrow"
				},
				{
					"id": "GZ999IthLFLg11fWiPklA",
					"type": "arrow"
				},
				{
					"id": "LdJW69NjYvdXu7frikJKX",
					"type": "arrow"
				},
				{
					"id": "lL5dGlpr5l16DIwWibA4y",
					"type": "arrow"
				}
			],
			"updated": 1648805102726,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 3001,
			"versionNonce": 1060215251,
			"isDeleted": false,
			"id": "GxPk47Tx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 174.82534454401718,
			"y": -298.8338375839237,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 280,
			"height": 50,
			"seed": 1309542487,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653374,
			"link": "[[mobileunit OverridenPeripheralDevices]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[mobileunit \nOverridenPeripheralDevices]]",
			"rawText": "[[mobileunit OverridenPeripheralDevices]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "PUP5T6WkJSLYmd-hYpZ_P",
			"originalText": "📍[[mobileunit OverridenPeripheralDevices]]"
		},
		{
			"type": "text",
			"version": 623,
			"versionNonce": 1603840121,
			"isDeleted": false,
			"id": "WcPa0AmG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 173.26978898846187,
			"y": -397.4449486950348,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 244,
			"height": 80,
			"seed": 1866426199,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102726,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "opd.[MobileUnitKey]\n= mu.[MobileUnitKey]\nAND opd.[TemplateDeviceKey] \n= tpd.[TemplateDeviceKey]",
			"rawText": "opd.[MobileUnitKey]\n= mu.[MobileUnitKey]\nAND opd.[TemplateDeviceKey] \n= tpd.[TemplateDeviceKey]",
			"baseline": 74,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "opd.[MobileUnitKey]\n= mu.[MobileUnitKey]\nAND opd.[TemplateDeviceKey] \n= tpd.[TemplateDeviceKey]"
		},
		{
			"type": "arrow",
			"version": 1927,
			"versionNonce": 485649587,
			"isDeleted": false,
			"id": "LdJW69NjYvdXu7frikJKX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 69.84252670851028,
			"y": -425.77828202836815,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 94.197754504271,
			"height": 131.99036860785338,
			"seed": 933149463,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743446,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "4rjYGl8UIhUCz5tqJukSZ",
				"gap": 2.9166666666666288,
				"focus": 0.8169860957935264
			},
			"endBinding": {
				"elementId": "PUP5T6WkJSLYmd-hYpZ_P",
				"gap": 5.785063331235904,
				"focus": -0.7787806028451161
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					94.197754504271,
					131.99036860785338
				]
			]
		},
		{
			"type": "arrow",
			"version": 1453,
			"versionNonce": 1208507987,
			"isDeleted": false,
			"id": "lL5dGlpr5l16DIwWibA4y",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -831.4722745036019,
			"y": -272.46399354564426,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 1000.297619047619,
			"height": 8.213357641017296,
			"seed": 1246317945,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743446,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "c-ipdrk3ll_LkqLdNokSf",
				"gap": 7.648757242430065,
				"focus": -0.6065769626723078
			},
			"endBinding": {
				"elementId": "PUP5T6WkJSLYmd-hYpZ_P",
				"gap": 1,
				"focus": -0.24678075891309886
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					1000.297619047619,
					8.213357641017296
				]
			]
		},
		{
			"type": "arrow",
			"version": 1895,
			"versionNonce": 513197843,
			"isDeleted": false,
			"id": "xEdRddZXu-SA8Y1nCgCJ2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -237.01387927618038,
			"y": -656.1949486950348,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 365.2831654336025,
			"height": 165.83333333333331,
			"seed": 1987195639,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743445,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "vnTXyKloMG64Q6sx_Drg7",
				"gap": 5.416666666666515,
				"focus": 0.5736917882361124
			},
			"endBinding": {
				"elementId": "4rjYGl8UIhUCz5tqJukSZ",
				"gap": 1.6666666666666856,
				"focus": 0.15004779166441287
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					365.2831654336025,
					165.83333333333331
				]
			]
		},
		{
			"type": "text",
			"version": 577,
			"versionNonce": 920755769,
			"isDeleted": false,
			"id": "6Sb5vgEY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 194.48804295671584,
			"y": -562.6393931394792,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 630,
			"height": 51,
			"seed": 1515843161,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805102726,
			"link": null,
			"locked": false,
			"fontSize": 13.925925925925926,
			"fontFamily": 1,
			"text": "tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]\n\t\tAND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)\n\t\tOR(opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))",
			"rawText": "tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]\r\n\t\tAND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)\r\n\t\tOR(opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))",
			"baseline": 46,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]\n\t\tAND ((opd.[MobileUnitKey] IS NOT NULL AND opd.[LineKey] IS NOT NULL)\n\t\tOR(opd.[MobileUnitKey] IS NULL AND tpd.[LineKey] IS NOT NULL))"
		},
		{
			"type": "arrow",
			"version": 1042,
			"versionNonce": 846012755,
			"isDeleted": false,
			"id": "TDGyMcY-Ki9OAHeQgYdBE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 815.4776841700896,
			"y": -638.6949486950347,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 360.6801174038501,
			"height": 386.2500000000001,
			"seed": 66560471,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743441,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "JpyDdo9UkhH-Rqz_d5D67",
				"focus": 0.9484630652648774,
				"gap": 8.055555555555458
			},
			"endBinding": {
				"elementId": "BzHx9EkywIfob2J5Fo7vc",
				"gap": 10.66666666666606,
				"focus": -0.5009051910740302
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-29.43011740385009,
					-340.0000000000001
				],
				[
					-360.6801174038501,
					-386.2500000000001
				]
			]
		},
		{
			"type": "rectangle",
			"version": 2563,
			"versionNonce": 373088185,
			"isDeleted": false,
			"id": "2G3woOPfGpTLol1X_CJL5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -575.6594849877256,
			"y": -1309.4846312347172,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 359,
			"height": 85,
			"seed": 1182953527,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "qymM8l2u",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "pZzlPq59uuq7pb2w3PyYm",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				},
				{
					"id": "BBdDuQwA0LoywTHoJWgC8",
					"type": "arrow"
				},
				{
					"id": "Ycnv5bM-H0olzY2I9C6zp",
					"type": "arrow"
				},
				{
					"id": "IGFp5NGXl4CSlvDhxCrT0",
					"type": "arrow"
				}
			],
			"updated": 1648805122090,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2359,
			"versionNonce": 1455754653,
			"isDeleted": false,
			"id": "qymM8l2u",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -570.6594849877256,
			"y": -1291.9846312347172,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 349,
			"height": 50,
			"seed": 759501497,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653375,
			"link": "[[definition MobileDeviceLinePeripheralDevices]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[definition \nMobileDeviceLinePeripheralDevices]]",
			"rawText": "[[definition MobileDeviceLinePeripheralDevices]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "2G3woOPfGpTLol1X_CJL5",
			"originalText": "📍[[definition MobileDeviceLinePeripheralDevices]]"
		},
		{
			"type": "arrow",
			"version": 147,
			"versionNonce": 716119027,
			"isDeleted": false,
			"id": "BBdDuQwA0LoywTHoJWgC8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -952.1118659401075,
			"y": -293.37177894939833,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 365.7142857142858,
			"height": 1009.9999999999998,
			"seed": 1844102519,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743447,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "c-ipdrk3ll_LkqLdNokSf",
				"gap": 3.772393496577479,
				"focus": -0.16678135281188095
			},
			"endBinding": {
				"elementId": "2G3woOPfGpTLol1X_CJL5",
				"gap": 10.738095238096093,
				"focus": 1.0437411731068884
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					365.7142857142858,
					-1009.9999999999998
				]
			]
		},
		{
			"type": "arrow",
			"version": 245,
			"versionNonce": 147256343,
			"isDeleted": false,
			"id": "4vVkgbrSA62JW5RDoZMT3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 834.0071816789405,
			"y": -643.8003503779701,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 1426,
			"height": 824,
			"seed": 1917364535,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1648805102726,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "7t7dmJb3",
				"focus": -0.7929748627156005,
				"gap": 11.271611223531636
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-10,
					-774
				],
				[
					-1394,
					-824
				],
				[
					-1426,
					-656
				]
			]
		},
		{
			"type": "arrow",
			"version": 606,
			"versionNonce": 1884754109,
			"isDeleted": false,
			"id": "Ycnv5bM-H0olzY2I9C6zp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 184.15713485030597,
			"y": -730.933072712613,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 820.1388888888889,
			"height": 719.7222222222222,
			"seed": 1234145687,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743447,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "wve9RZQYA0fVDg-Fhjbdf",
				"gap": 5.988124017578116,
				"focus": 0.3393211957512732
			},
			"endBinding": {
				"elementId": "2G3woOPfGpTLol1X_CJL5",
				"gap": 14.766713495301701,
				"focus": -0.9335723377376054
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-327.3611111111111,
					-664.4444444444446
				],
				[
					-820.1388888888889,
					-719.7222222222222
				],
				[
					-774.5797499140756,
					-578.8768550178279
				]
			]
		},
		{
			"type": "text",
			"version": 82,
			"versionNonce": 907958583,
			"isDeleted": false,
			"id": "7t7dmJb3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -624.7317540385825,
			"y": -1371.0719616015017,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 436,
			"height": 60,
			"seed": 1250522777,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "4vVkgbrSA62JW5RDoZMT3",
					"type": "arrow"
				}
			],
			"updated": 1648805102726,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "dmdlpd.[MobileDeviceKey]     = mu.[MobileDeviceKey]\n    AND dmdlpd.[LineKey]             = pd.[LineKey]\n    AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]",
			"rawText": "dmdlpd.[MobileDeviceKey]     = mu.[MobileDeviceKey]\r\n    AND dmdlpd.[LineKey]             = pd.[LineKey]\r\n    AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]",
			"baseline": 54,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "dmdlpd.[MobileDeviceKey]     = mu.[MobileDeviceKey]\n    AND dmdlpd.[LineKey]             = pd.[LineKey]\n    AND dmdlpd.[PeripheralDeviceKey] = dd.[DeviceKey]"
		},
		{
			"type": "rectangle",
			"version": 2685,
			"versionNonce": 1203788441,
			"isDeleted": false,
			"id": "6puvNKAuwq-Fk67KlazFb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -713.4103254671535,
			"y": -686.3695806491208,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1940460887,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "OEdCKbMe",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "pZzlPq59uuq7pb2w3PyYm",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				},
				{
					"id": "IGFp5NGXl4CSlvDhxCrT0",
					"type": "arrow"
				},
				{
					"id": "_ijht77lDWJoVyeg5fvMK",
					"type": "arrow"
				},
				{
					"id": "H2FkJ4_7PquGXf_DeKX0m",
					"type": "arrow"
				}
			],
			"updated": 1648805344936,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2500,
			"versionNonce": 28841459,
			"isDeleted": false,
			"id": "OEdCKbMe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -708.4103254671535,
			"y": -668.8695806491208,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 25,
			"seed": 1193201561,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653377,
			"link": "[[library Devices]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[library Devices]]",
			"rawText": "[[library Devices]]",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "6puvNKAuwq-Fk67KlazFb",
			"originalText": "📍[[library Devices]]"
		},
		{
			"type": "arrow",
			"version": 243,
			"versionNonce": 2081419549,
			"isDeleted": false,
			"id": "IGFp5NGXl4CSlvDhxCrT0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -270.2079445147742,
			"y": -1212.7981520776912,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 277.63013902577654,
			"height": 520.0000000000002,
			"seed": 2138955641,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743449,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "2G3woOPfGpTLol1X_CJL5",
				"gap": 11.686479157026042,
				"focus": -0.7057118905159465
			},
			"endBinding": {
				"elementId": "6puvNKAuwq-Fk67KlazFb",
				"gap": 6.428571428570081,
				"focus": 0.2456032609539377
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-10,
					334.28571428571445
				],
				[
					-258.57142857142867,
					368.57142857142867
				],
				[
					-277.63013902577654,
					520.0000000000002
				]
			]
		},
		{
			"type": "arrow",
			"version": 231,
			"versionNonce": 1921893757,
			"isDeleted": false,
			"id": "_ijht77lDWJoVyeg5fvMK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -568.8787741650261,
			"y": 331.4875622080233,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 20.175983098047368,
			"height": 948.5714285714287,
			"seed": 1019669143,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743449,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "EstmDgrwCyko18b99ljJw",
				"gap": 8.582560868587507,
				"focus": 0.04131470491600946
			},
			"endBinding": {
				"elementId": "6puvNKAuwq-Fk67KlazFb",
				"gap": 9.285714285715471,
				"focus": -0.28684901899552945
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					20.175983098047368,
					-948.5714285714287
				]
			]
		},
		{
			"type": "text",
			"version": 118,
			"versionNonce": 1212993975,
			"isDeleted": false,
			"id": "AwpmGzkH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -728.8865159433444,
			"y": -608.5481520776923,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 232,
			"height": 80,
			"seed": 1520388697,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805270389,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "ld.DeviceKey \n= dmdlpd.PeripheralDeviceKey \nAND ld.LibraryKey \n= tcg.LibraryKey",
			"rawText": "ld.DeviceKey \n= dmdlpd.PeripheralDeviceKey \nAND ld.LibraryKey \n= tcg.LibraryKey",
			"baseline": 74,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "ld.DeviceKey \n= dmdlpd.PeripheralDeviceKey \nAND ld.LibraryKey \n= tcg.LibraryKey"
		},
		{
			"type": "rectangle",
			"version": 2689,
			"versionNonce": 1676386169,
			"isDeleted": false,
			"id": "GUXG977_aF8ChJbRlSDJ9",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -829.4817540385828,
			"y": -479.8814854110258,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 83360281,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "CoQfs1TE",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				},
				{
					"id": "pZzlPq59uuq7pb2w3PyYm",
					"type": "arrow"
				},
				{
					"id": "s7GepDh6lwdFsYQGdacqF",
					"type": "arrow"
				},
				{
					"id": "IGFp5NGXl4CSlvDhxCrT0",
					"type": "arrow"
				},
				{
					"id": "_ijht77lDWJoVyeg5fvMK",
					"type": "arrow"
				},
				{
					"id": "H2FkJ4_7PquGXf_DeKX0m",
					"type": "arrow"
				}
			],
			"updated": 1648805344936,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2508,
			"versionNonce": 1892081555,
			"isDeleted": false,
			"id": "CoQfs1TE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -824.4817540385828,
			"y": -474.8814854110258,
			"strokeColor": "#999",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 1647251447,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653378,
			"link": "[[library PeripheralDevices]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "📍[[library \nPeripheralDevices]]",
			"rawText": "[[library PeripheralDevices]]",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "GUXG977_aF8ChJbRlSDJ9",
			"originalText": "📍[[library PeripheralDevices]]"
		},
		{
			"type": "arrow",
			"version": 105,
			"versionNonce": 387059165,
			"isDeleted": false,
			"id": "H2FkJ4_7PquGXf_DeKX0m",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -719.6181176749461,
			"y": -638.284082813623,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 68.18181818181824,
			"height": 155.4545454545455,
			"seed": 1836864407,
			"groupIds": [],
			"strokeSharpness": "round",
			"boundElements": [],
			"updated": 1654760743450,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "6puvNKAuwq-Fk67KlazFb",
				"gap": 6.207792207792636,
				"focus": 0.8349570517921773
			},
			"endBinding": {
				"elementId": "GUXG977_aF8ChJbRlSDJ9",
				"gap": 2.9480519480516705,
				"focus": -0.6756278740714516
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-68.18181818181824,
					107.27272727272725
				],
				[
					-68.18181818181824,
					155.4545454545455
				]
			]
		},
		{
			"type": "text",
			"version": 31,
			"versionNonce": 1001702201,
			"isDeleted": false,
			"id": "H1RN2idh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -779.9211479779763,
			"y": -502.13256766210793,
			"strokeColor": "#e67700",
			"backgroundColor": "#ced4da",
			"width": 130,
			"height": 20,
			"seed": 1779103447,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1648805365376,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "LibraryDeviceKey",
			"rawText": "LibraryDeviceKey",
			"baseline": 14,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "LibraryDeviceKey"
		},
		{
			"type": "rectangle",
			"version": 2467,
			"versionNonce": 2077721943,
			"isDeleted": false,
			"id": "zd72_eDrEm5mT5Xu93mv6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -38.648420705248725,
			"y": 667.8169272873871,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 424149529,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "LNduEHdy",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				}
			],
			"updated": 1649073550257,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2251,
			"versionNonce": 1934581657,
			"isDeleted": false,
			"id": "LNduEHdy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -33.648420705248725,
			"y": 685.3169272873871,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 25,
			"seed": 12814327,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1649073550257,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "template Events",
			"rawText": "template Events",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "zd72_eDrEm5mT5Xu93mv6",
			"originalText": "template Events"
		},
		{
			"type": "rectangle",
			"version": 2479,
			"versionNonce": 1361279673,
			"isDeleted": false,
			"id": "T3eh2L8XdGiNnUaluDqIx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 260.24046818364013,
			"y": 576.7058161762757,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1569912279,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "KfsunbyR",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				}
			],
			"updated": 1649073555788,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2268,
			"versionNonce": 85099991,
			"isDeleted": false,
			"id": "KfsunbyR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 265.24046818364013,
			"y": 594.2058161762757,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 25,
			"seed": 832648985,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1649073560196,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "template EventActions",
			"rawText": "template EventActions",
			"baseline": 18,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "T3eh2L8XdGiNnUaluDqIx",
			"originalText": "template EventActions"
		},
		{
			"type": "rectangle",
			"version": 2454,
			"versionNonce": 1737351961,
			"isDeleted": false,
			"id": "Um-XAG4kEPjbOqLHQx1uK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 255.24046818364013,
			"y": 663.3724828429425,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 1318171383,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "Q6HqqYLe",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				}
			],
			"updated": 1649073629439,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2253,
			"versionNonce": 189191965,
			"isDeleted": false,
			"id": "Q6HqqYLe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 260.24046818364013,
			"y": 668.3724828429425,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 1657822201,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653380,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "template \nEventConditions",
			"rawText": "template EventConditions",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Um-XAG4kEPjbOqLHQx1uK",
			"originalText": "template EventConditions"
		},
		{
			"type": "rectangle",
			"version": 2502,
			"versionNonce": 1782345367,
			"isDeleted": false,
			"id": "hjfz5odJsLwZ7SDp9pvPv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 549.9230078661794,
			"y": 571.5470860175456,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 2073486169,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "UJPNlAei",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				}
			],
			"updated": 1649073630897,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2307,
			"versionNonce": 1384871219,
			"isDeleted": false,
			"id": "UJPNlAei",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 554.9230078661794,
			"y": 576.5470860175456,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 1480481463,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653380,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "template \nOverriddenEventActions",
			"rawText": "template OverriddenEventActions",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "hjfz5odJsLwZ7SDp9pvPv",
			"originalText": "template OverriddenEventActions"
		},
		{
			"type": "rectangle",
			"version": 2464,
			"versionNonce": 424403287,
			"isDeleted": false,
			"id": "oFZsqlYlGak3Z8AQ1Fdll",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 554.2087221518937,
			"y": 660.1185145889742,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 85,
			"seed": 1896085305,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "5CHZ6Ks4",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				}
			],
			"updated": 1649073763585,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2264,
			"versionNonce": 100133757,
			"isDeleted": false,
			"id": "5CHZ6Ks4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 559.2087221518937,
			"y": 665.1185145889742,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 75,
			"seed": 180679895,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653381,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "template \nOverridenEventConditionT\nhresholds",
			"rawText": "template OverridenEventConditionThresholds",
			"baseline": 68,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "oFZsqlYlGak3Z8AQ1Fdll",
			"originalText": "template OverridenEventConditionThresholds"
		},
		{
			"type": "rectangle",
			"version": 2493,
			"versionNonce": 1784904983,
			"isDeleted": false,
			"id": "lkKCsG6NOTZfmqpNmTCYf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 258.4944364376081,
			"y": 795.8328003032599,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 60,
			"seed": 2123226681,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "rq4mWE1L",
					"type": "text"
				},
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "IygDIeT8xKqDHHckqYgCx",
					"type": "arrow"
				},
				{
					"id": "2yKCqrcXYLudX12JLy1qz",
					"type": "arrow"
				},
				{
					"id": "5K8Vy6tKTmWryWyL8sFQp",
					"type": "arrow"
				},
				{
					"id": "tvan7cB59_KVHfR4SpDRQ",
					"type": "arrow"
				}
			],
			"updated": 1649073812736,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2283,
			"versionNonce": 1718376147,
			"isDeleted": false,
			"id": "rq4mWE1L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 263.4944364376081,
			"y": 800.8328003032599,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 247,
			"height": 50,
			"seed": 1618017751,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760653382,
			"link": "[[mobileunit. MobileUnits]]",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "template \nOverridenEvents",
			"rawText": "template OverridenEvents",
			"baseline": 43,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "lkKCsG6NOTZfmqpNmTCYf",
			"originalText": "template OverridenEvents"
		},
		{
			"type": "rectangle",
			"version": 166,
			"versionNonce": 692548893,
			"isDeleted": false,
			"id": "2ITFhXRLFEuDvLumRf8Jz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2015.8668410840453,
			"y": -116.07196160150204,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 161.1111111111111,
			"height": 58.888888888888914,
			"seed": 773833501,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "Yc7YS6IECmvXEuApCw6V7",
					"type": "arrow"
				}
			],
			"updated": 1654760688735,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 158,
			"versionNonce": 729045203,
			"isDeleted": false,
			"id": "IXcPR2pR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2009.2001744173779,
			"y": -94.96085049039101,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"width": 149,
			"height": 20,
			"seed": 462234493,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [],
			"updated": 1654760688735,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "[dynamix].[Assets]",
			"rawText": "[dynamix].[Assets]",
			"baseline": 14,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "[dynamix].[Assets]"
		},
		{
			"type": "text",
			"version": 2393,
			"versionNonce": 332748179,
			"isDeleted": false,
			"id": "DeNPOnFK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2021.4779521951561,
			"y": -143.01640604594655,
			"strokeColor": "#087f5b",
			"backgroundColor": "transparent",
			"width": 245,
			"height": 25,
			"seed": 693718301,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"boundElements": [
				{
					"id": "-039YMcZgFW_iCTrvfql3",
					"type": "arrow"
				},
				{
					"id": "RTy3CyMidk3B2_AxxwHAo",
					"type": "arrow"
				}
			],
			"updated": 1654760695648,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "v.iVehicleID = a.VehicleId",
			"rawText": "v.iVehicleID = a.VehicleId",
			"baseline": 18,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "v.iVehicleID = a.VehicleId"
		},
		{
			"id": "Yc7YS6IECmvXEuApCw6V7",
			"type": "arrow",
			"x": -1842.5335077507118,
			"y": -79.43856916056109,
			"width": 80,
			"height": 2.7298864799392106,
			"angle": 0,
			"strokeColor": "#000000",
			"backgroundColor": "#ced4da",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"strokeSharpness": "round",
			"seed": 1895441181,
			"version": 266,
			"versionNonce": 1344987635,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1654760743433,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					80,
					-2.7298864799392106
				]
			],
			"lastCommittedPoint": null,
			"startBinding": {
				"elementId": "2ITFhXRLFEuDvLumRf8Jz",
				"gap": 12.222222222222513,
				"focus": 0.32075471698113045
			},
			"endBinding": {
				"elementId": "3CpO0ZR-xGl-Pba2Jes44",
				"gap": 6.422992998955806,
				"focus": -0.16724558723738406
			},
			"startArrowhead": null,
			"endArrowhead": "arrow"
		},
		{
			"id": "sPV6pDqU",
			"type": "text",
			"x": -2016.9779521951561,
			"y": -52.738628268168725,
			"width": 65,
			"height": 20,
			"angle": 0,
			"strokeColor": "#c92a2a",
			"backgroundColor": "#ced4da",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"seed": 600541309,
			"version": 17,
			"versionNonce": 138672797,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1654760753684,
			"link": null,
			"locked": false,
			"text": "AssetId",
			"rawText": "AssetId",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "left",
			"verticalAlign": "top",
			"baseline": 14,
			"containerId": null,
			"originalText": "AssetId"
		},
		{
			"id": "gTpV14Rw",
			"type": "text",
			"x": -904.755729972934,
			"y": -58.29418382372427,
			"width": 65,
			"height": 20,
			"angle": 0,
			"strokeColor": "#c92a2a",
			"backgroundColor": "#ced4da",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"strokeSharpness": "sharp",
			"seed": 92889523,
			"version": 23,
			"versionNonce": 168053171,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1654760753684,
			"link": null,
			"locked": false,
			"text": "AssetId",
			"rawText": "AssetId",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "left",
			"verticalAlign": "top",
			"baseline": 14,
			"containerId": null,
			"originalText": "AssetId"
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#c92a2a",
		"currentItemBackgroundColor": "#ced4da",
		"currentItemFillStyle": "hachure",
		"currentItemStrokeWidth": 1,
		"currentItemStrokeStyle": "solid",
		"currentItemRoughness": 1,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 16,
		"currentItemTextAlign": "left",
		"currentItemStrokeSharpness": "sharp",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"currentItemLinearStrokeSharpness": "round",
		"gridSize": null,
		"colorPalette": {}
	},
	"files": {}
}
```
%%