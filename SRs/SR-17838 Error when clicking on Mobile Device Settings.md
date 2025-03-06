---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-04-02T14:38
---

# SR-17838 Error when clicking on Mobile Device Settings

Date: 2024-04-02 Time: 08:36
Parent:: ==xxxx==
Friend:: [[2024-04-02]]
JIRA:SR-17838 Error when clicking on Mobile Device Settings
[SR-17838 Unexpected Error. Object reference not set to an instance of an object. - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-17838)


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

- Unexpected Error. Object reference not set to an instance of an object.

## Investigation

When looking at the log I found that there is an error before this one.
It mentioned a duplicate key constraint.
[Logz.io](https://app.logz.io/#/goto/d21347d9366712fb98d2e7546789799e?switchToAccountId=157279)

![[SR-17838 Error when clicking on Mobile Device Settings Log issue.png|400]]

I then had a look at the database and can confirm that there is OLD data found for the AssetMobileunits table.
For each of the mentioned units, the NEW mobileunitId is not found, however, when looking for the legacy asset id and legacy org id, the rows are present.
This will explain the duplicate key issue.

### For Asset 1511417423075274752

![[SR-17838 Error when clicking on Mobile Device Settings Eg1.png|600]]


### For Asset 1511417428141105152

![[SR-17838 Error when clicking on Mobile Device Settings Eg 2.png|600]]

### For Asset 1511417434513842176

![[SR-17838 Error when clicking on Mobile Device Settings eg 3.png|600]]


## Suggestion

- Remove the legacy records in the AssetMobileUnits table

## SQL

```sql
USE DeviceConfiguration;
DECLARE @muid BIGINT = 1511417434513842176;
DECLARE @legacyId INT = 1254;
DECLARE @legacyOrgId INT = 7274;
SELECT * FROM mobileunit.MobileUnits WHERE MobileUnitId = @muid --Finds mobile unit
SELECT * FROM mobileunit.AssetMobileunits WHERE AssetId = @muid OR (LegacyVehicleId = @legacyId AND LegacyOrgID = @legacyOrgId) --DOESN'T FIND 
--Audit Tables
SELECT * FROM audit.mobileunit_MobileUnits_CT WHERE MobileUnitId = @muid OR MobileUnitKey  = 448698
SELECT * FROM audit.mobileunit_AssetMobileunits_CT WHERE AssetId = @muid OR (LegacyVehicleId = @legacyId AND LegacyOrgID = @legacyOrgId)
/*
SELECT * FROM template.ConfigurationGroups WHERE ConfigurationGroupKey = 67277 --Finds Config Group
SELECT * FROM library.Libraries WHERE LibraryKey = 4336 --Finds Library
(1252) 1511417423075274752 has mu, not amu
1511417428141105152 has nothing
1511417434513842176 has nothing
*/
```
## Maybe check the logs?


## Screenshot of the issue


## Lesson

- [ ] What was the MAIN cause or thing learned from this?


## Image learned from this issue

ADD IMAGE

## Move what you learned into the bigger picture

ADD IMAGE

## Shorter Summary



## Description


## Ideas

- [ ] Duplicate in Prod
- [ ] Duplicate on INT
- [ ] Check DB, Logs

## SR Meeting Notes


## Useful Comments from Jira


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing



## Follow the code path

### Log


### Data


### Code


## Final Findings for Jira

- 
