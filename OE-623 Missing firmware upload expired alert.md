---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-19T10:30
---

# OE-623 Missing firmware upload expired alert

Date: 2025-03-17 Time: 15:46
Parent:: [[OE-515 Alerts Column Assets Panel]]
Friend:: [[2025-03-17]]
JIRA:OE-623 Missing firmware upload expired alert
[OE-623 Missing firmware upload expired alert - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-623)


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

Org: Amy Bench Units
Rodger MiX3000
CG: -5579545911740947113
AssetId: 1522731665984569344

The FW Update message date is: 2025-03-17 12:42:23.397
This will not currently show up in the Alerts, as it is about 1 day old.
It seems like it was a message sent by the system (config@mixtel.com), not Amy.

## Files

- C:\Projects\_MiXTelematicsFiles\SQL\OE-623 Amy Units Test.sql

## Testing

```sql
SELECT * FROM [state].[MobileUnitMessage] mum
    INNER JOIN [state].[MobileUnitMessageStateHistory] msh
      ON mum.MessageKey = msh.MessageKey
WHERE mum.MessageSubType in (103)
AND CreationDateUtc > '2025-03-10'
AND mum.MobileUnitId = 1522731665984569344
ORDER BY CreationDateUtc DESC
```

![[OE-623 Missing firmware upload expired alert Proof Working.png]]


- [x] PR Zonika (Same): [Pull request 121410: OE-614: Added the DeviceKey to link on. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/121410?_a=files) ✅ 2025-03-19
