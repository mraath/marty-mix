---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-15T11:20
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

