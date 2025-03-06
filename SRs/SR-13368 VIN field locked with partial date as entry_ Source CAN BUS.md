Date: 2022-08-02 Time: 11:34
Friend: [[2022-08-02]]
JIRA:SR-13368
[SR-13368 VIN field locked with partial date as entry - "Source: CAN BUS" - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-13368)

# SR-13368 VIN field locked with partial date as entry_ Source CAN BUS

## Image


## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Lang  | UI    | BE    | Client | API   | Common | DB    |
| ----- | ----- | ----- | ------ | ----- | ------ | ----- |
| 22.6  | 22.6  | 22.6  | 22.6   | 22.6  | 22.6   | 22.6  |
| Local | Local | Local | Local  | Local | Local  | Local |

## Branch
Config/MR/Bug/SR-13368 VIN field locked with partial date as entry_ Source CAN BUS.xx.xx.ORI

## Learned

## Description
- partial date was saved as the VIN
- locked (as per workflow)

dynamix.Assets a
	a.VinNumber,
	a.VinNumberMatched,
	a.VinSource,

- Basically just need to move it from "X-decommission" site to "XN-decommission" site

## Code sections

https://us.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/-3348482836877520205/-7413804130028941930

1.  VinNumber: "/2018 10:06:08 PM"
2.  VinNumberMatched: false
3.  VinSource: "CAN_BUS"

ng-disabled="(vinNumberDisabledStatus || !canEdit || asset.isScaniaOem || asset.vinSource == 'CAN_BUS') && !duplicate"

- vinNumberDisabledStatus : vinSource === 'CAN_BUS'
- canEdit : na
- isScaniaOem : na
- ==vinSource== == 'CAN_BUS' : TRUE
- duplicate : na

## Files

## Resources
```sql

--DSV ONLY (Multiple time zone) L3B-UI only
SELECT top 5  *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = -3348482836877520205

--LegacyOrgId
SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = 843

-- Get Asset info
USE ArchRock_2016;
SELECT TOP 10 * FROM DynamiX.Assets
WHERE VinSource = 'CAN_BUS'
AND VinNumber like '%/20%'

/*
USE ArchRock_2016;
UPDATE DynamiX.Assets
SET VinNumber = '',
	VinSource = 'MANUAL'
WHERE AssetId = -7413804130028941930
*/


```
## Notes

