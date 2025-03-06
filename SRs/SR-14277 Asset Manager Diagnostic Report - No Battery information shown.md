---
status: closed
date: 2023-02-03
comment: WK
priority: 8
---

Date: 2023-02-03 Time: 11:37
Parent:: [[Diagnostic Modal]]
Friend:: [[2023-02-03]]
JIRA:SR-14277
[SR-14277 Asset Manager Diagnostic Report - No Battery information shown - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14277)

Friend:: [[zz_zonika UAT-687 Remora and Oyster]]
Parent:: [[Diagnostic Modal]]
Child:: [[Battery]]

# SR-14277 Asset Manager Diagnostic Report - No Battery information shown

## Next Steps

- Made me think of:  [UAT-687 Asset Manager Diagnostic Report - Firmware version missing for Remora and Oyster - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/UAT-687)
- [x] Will quickly check the above issue for tips on how to investigate this

Friend:: ![[UAT-687 FW Version not on Asset MAnager Diagnostics Report.excalidraw]]
- [x] Closed: Swagger end-point and then also 
```json
[
  {
    "MobileUnitId": 1298337334911697000,
    "AssetId": 1298337334911697000,
    "MobileDeviceType": "DME",
    "BatteryChargePercentage": null,
    "LoadedVoltage": null,
    "BatteryVoltage": null,
    "BatteryLevel": null,
    "Temperature": null,
    "FirmwareVersion": null,
    "UniqueIdentifier": "355703094342276",
    "SignalStrength": null,
    "MobileDevice": "Remora"
  }
]
```

- [x] check the DB.

- The code I used to find that the DeviceId in state is different from mobileunit
[SQL to test both end point values](file:///C:\Projects\_MiXTelematicsFiles\SQL\SR-14277%20Asset%20Manager%20Diagnostic%20Report%20vs%20Diagnostics%20Modal.sql)
- Next I got all those with only 1 state row for a mobile unit - al these fail
[SQL to find 1 to 1 relationships that fail](file:///C:\Projects\_MiXTelematicsFiles\SQL\MR_SR_14277_ReportVsDiagnosticsModal_Part2.sql)

OK - let's see if it is:
- [x] DATA or
This seems to be the problem
- [x] Org Settings - ==I didnt even check this==

## Testing


## Story Description

Diagnostic Screen for the mentioned Remora unit, 
you will see that the Battery Information is displayed 
but it is not generating on the report (Asset Manager Diagnostic Report):
(Remora, Oyster, Tabs, and AT1340 Units)

- William Kemlo: "we aren’t getting the info back from the API"
- API endpoint api/reports/diagnostic-data?authToken={AuthToken}
- Example assetIDs [1298318527100329984,1300270749536063488]
- [x] Closed: Use the below asset Id for test above and see what we get

## Scratchpad

```Javascript
const re = new RegExp('[0-9][0-9][hH][0-9][0-9]:');
const notfound = re.test("thi is a test 09h00 sd asdas das das da d");
console.log("??? : " + notfound);
const found = re.test("thi is a test 09h00: kjsdhfjks jh kjh ksdfkj hkj ");
console.log("??? : " + found);
```

- The End point info
```c#
...\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Routes\Reports\ReportControllerRoutes.cs
	ReportControllerRoutes > GetDiagnosticReportData = "reports/diagnostic-data"

```

Child:: ![[SR14277 Asset Manager Diagnostic Report Not showing Battery Information.excalidraw]]

**IDC:** AU  
**Organization:** Global Express  
**orgId**=4089036243479131134
Asset: 44332 - 23/04/2019  
id=1298337334911696896

![[SR-14277 Diagnostic Data Not in Report via Config API.png]]


## JSON

```JSON

[
  {
    "MobileUnitId": 949246176133296100,
    "AssetId": 949246176133296100,
    "MobileDeviceType": "DME",
    "BatteryChargePercentage": "92",
    "LoadedVoltage": "740",
    "BatteryVoltage": "687",
    "BatteryLevel": "0",
    "Temperature": "20",
    "FirmwareVersion": null,
    "UniqueIdentifier": "352753096880081",
    "SignalStrength": "319",
    "MobileDevice": "Remora"
  },
  {
    "MobileUnitId": 1101573344783712300,
    "AssetId": 1101573344783712300,
    "MobileDeviceType": "DME",
    "BatteryChargePercentage": "95",
    "LoadedVoltage": "7243",
    "BatteryVoltage": "7278",
    "BatteryLevel": "1",
    "Temperature": "11",
    "FirmwareVersion": null,
    "UniqueIdentifier": "358014099151424",
    "SignalStrength": "77",
    "MobileDevice": "Remora"
  },
  {
    "MobileUnitId": 1298337334911697000,
    "AssetId": 1298337334911697000,
    "MobileDeviceType": "DME",
    "BatteryChargePercentage": null,
    "LoadedVoltage": null,
    "BatteryVoltage": null,
    "BatteryLevel": null,
    "Temperature": null,
    "FirmwareVersion": null,
    "UniqueIdentifier": "355703094342276",
    "SignalStrength": null,
    "MobileDevice": "Remora"
  },
  {
    "MobileUnitId": 1298318527100330000,
    "AssetId": 1298318527100330000,
    "MobileDeviceType": "Unknown",
    "BatteryChargePercentage": null,
    "LoadedVoltage": null,
    "BatteryVoltage": null,
    "BatteryLevel": null,
    "Temperature": null,
    "FirmwareVersion": null,
    "UniqueIdentifier": "359739075396366",
    "SignalStrength": null,
    "MobileDevice": "AT 1340 (Wired Trailer Track and Trace)"
  },
  {
    "MobileUnitId": 1300270749536063500,
    "AssetId": 1300270749536063500,
    "MobileDeviceType": "DME",
    "BatteryChargePercentage": null,
    "LoadedVoltage": null,
    "BatteryVoltage": null,
    "BatteryLevel": null,
    "Temperature": null,
    "FirmwareVersion": null,
    "UniqueIdentifier": "359215103068970",
    "SignalStrength": null,
    "MobileDevice": "Remora"
  }
]

```

## Image

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.17 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-14277.xx.xx.ORI
