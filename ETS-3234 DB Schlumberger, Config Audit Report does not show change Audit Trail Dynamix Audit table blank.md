---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-18T09:20
---

# ETS-3234 DB Schlumberger, Config Audit Report does not show change Audit Trail Dynamix Audit table blank

Date: 2025-09-15 Time: 11:18
Parent:: ==xxxx==
Friend:: [[2025-09-15]]
JIRA:ETS-3234 DB Schlumberger, Config Audit Report does not show change Audit Trail Dynamix Audit table blank
[JIRA](https://powerfleet.atlassian.net/browse/ETS-3234)


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

## Shorter Description

DB: Schlumberger-KZU

Issue: Config Audit Report does not show change Audit Trail - Dynamix Audit table blank

Examples:

Asset ID: 1686122227738537984

Asset ID: 3929166784807882648

On Road IoT Audit Report does not contain required information

Audit records in [DynaMiX].[DynaMiX_Audit].[Assets] returns no results

Script used :  
SELECT TOP (1000) [AssetsAuditKey]  
      ,[Operation]  
      ,[UpdateMask]  
      ,[CreatedDateTime]  
      ,[UserName]  
      ,[Entity]  
      ,[AssetId]  
      ,[VehicleId]  
      ,[OrganisationId]  
      ,[NewValues]  
  FROM [DynaMiX].[DynaMiX_Audit].[Assets] where assetid in (1686122227738537984,  
3929166784807882648)

From Resource data it was determined that one asset had been moved to another site and the other had been De & Re commissioned.

![[ETS-3234 DB Schlumberger, Config Audit Report does not show change Audit Trail Dynamix Audit table blank Asset Rows.png]]

Please can you investigate why there is no information in the Audit records/Audit report?

## date ranges

2037 - Changes made 27/07/2025  
6003 - Changes made 06/08/2025

470143	9148237898469913400	1686122227738537984	492848	925	2037
470865	2528765721212179261	3929166784807882648	493571	925	6003


## TESTS

1) [x] Test if site changes - if moved to another site gets logged ✅ 2025-09-17
	- https://config.dev.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1704944410111602688&orgId=4036779219063094058
	- 1704944410111602688
	- After Init only 3 rows
	- After unique key - still only 3
	- Default Site > MR Site - 5 !!! Check mask....  750780416, 1241507888
	- MR Site > Default Site - 7 !!! Check mask.... 750780416, 1241507888
	- Remove mobile device - 11
	- Move to CG - 14
2) [x] and if De & Re commissioned logs ✅ 2025-09-17
	- Remove mobile device - 11
	- Move to CG - 14

- [ ] I will first check if I can test this on the same database.  
	- Schlumberger-KZU
	- https://uk.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1704950877146279936&orgId=-9141529759028177209
	- 1704950877146279936
- [ ] After this I will try to find where these rows went.
- [ ] Mobile Device Type mabe?

```sql
SELECT * FROM [DynaMiX].[DynaMiX_Audit].[Assets] where assetid in (1704944410111602688)
```

## More info from files added

1686122227738537984

Configuration Group: BTS - KAZ - Tengiz OFS / TCO - FM 36x7, CAN: J1939.250KBPS.ACK_ENBL.v1.24.0.4_MG, No RPM, I3 HL >6+Mix Vision AI
Mobile Device: FM 3607i/3617i
FM device Id: 5532222609168997
IMEI Number: 355544065478586

3929166784807882648

Configuration Group: BTS KAZ - Tengiz OFS/TCO FM 35x7i F1 VSS, F2 RPM, I1 DSB >6, I2 PSB >6, I3 HL >6, LV
FM device Id: 1631200312137626
IMEI Number: 356496043536341

### Now adding on DEV for FM 3607

https://config.dev.mixtelematics.com/#/fleet-admin/asset/details?id=1705200145348530176&orgId=4036779219063094058&mobileNumber=
1705200145348530176
Init: 3
Site > MR: 5
Site > Default: 7
Remove: 11
Move CG: 14
