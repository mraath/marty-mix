---
status: closed
date: 2023-07-18
comment: 
priority: 8
---

# SR-15741 Incorrect VIN

Date: 2023-07-18 Time: 16:28
Parent:: ==xxxx==
Friend:: [[2023-07-18]]
JIRA:SR-15741 Incorrect VIN
[SR-15741 Unable to edit asset due to error - VIN field locked with partial date as entry - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15741)

## Outstanding in this file

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

## Details

Server: US  
Org: MIXTEL BR - DELLA VOLPE  
orgId=-554738622497589290

## SQL

```sql
DECLARE @GroupId BIGINT = -554738622497589290;

DECLARE @lorgID INT = (SELECT OrganisationId
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = @GroupId)

SELECT sConnectDatabase, liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID



-- ASSET DB to use
USE MIXTELBR_DELLAVOLPE_2014;

-- These 30 have issues
SELECT * FROM DynamiX.Assets
WHERE VinSource = 'CAN_BUS' AND 
VinNumber like '%/%'

-- Clean their VinNumbers
UPDATE DynamiX.Assets
SET VinNumber = ''
WHERE VinSource = 'CAN_BUS' AND 
VinNumber like '%/%'

-- Should now have 0 with this issue
SELECT * FROM DynamiX.Assets
WHERE VinSource = 'CAN_BUS' AND 
VinNumber like '%/%'
```

## BEFORE Cleanup

![[SR-15741 Incorrect VIN Before Cleanup.png]]

- Asked Martin du Plessis to run this
## After Cleanup

Nothing

## Branch

- xxxxxxxxxxxxxxxxxxxxxxxxx.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

- [ ] Local: 🟧 
- [ ] Dev: 🟨 
- [ ] INT: 🟩 
- [ ] UAT: 🟦 
- [ ] PROD: 🟪

## PRs

- 

## Description

- 