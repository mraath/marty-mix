---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-17T16:24
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

1) Test if site changes - if moved to another site gets logged 
	- https://config.dev.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1704944410111602688&orgId=4036779219063094058
	- 1704944410111602688
	- After Init only 3 rows
	- After unique key - still only 3
	- 
2) and if De & Re commissioned logs

```sql
SELECT * FROM [DynaMiX].[DynaMiX_Audit].[Assets] where assetid in (1704944410111602688)
```