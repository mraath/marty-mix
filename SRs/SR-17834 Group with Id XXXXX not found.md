---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-04-02T14:37
---

# SR-17834 Group with Id XXXXX not found

Date: 2024-04-02 Time: 09:31
Parent:: ==xxxx==
Friend:: [[2024-04-02]]
JIRA:SR-17834 Group with Id XXXXX not found
[SR-17834 Unexpected Error. Error: EXCEPTION! Group with Id XXXXX not found - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-17834)


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

- Group with Id XXXXX not found
## Investigation

I first had a look at the log.
[Logz.io](https://app.logz.io/#/goto/f8352becfd63f38ef936484d7c5977d4?switchToAccountId=157279)

I then looked at the database and found that the group Id the error refers to is NOT a group id.
It is actually an asset Id.

![[SR-17834 Group with Id XXXXX not found Group Id is an Asset Id.png|600]]

I then had a look again at the Log and saw that the group Id and asset Id, passed to the end-point is actually both the asset Id.

![[SR-17834 Group with Id XXXXX not found Asset vs config.png|600]]

## Suggestion

Find in the logz which code called this and why the asset id was being used in place of the org id.

## Further investigation

- The mentioned url is called the following in the backend: GET_MOBILE_UNIT_EVENT
- IT gets called from. UI Module: getAssetEvent
- Which gets called from: getEvent in "C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Controllers\AssetEventEditController.ts"
- Click on Asset name in Config groups, then edit the event, whala
![[SR-17834 Group with Id XXXXX not found Succeeds when tested.png|600]]

## SQL

```sql
------------------------------------------
-- Organisation info based on long assetId
------------------------------------------
DECLARE @id as BIGINT = 1394911101344714752;

SELECT * FROM DeviceConfiguration.mobileunit.AssetMobileUnits WHERE AssetId = @id
DECLARE @lorgID INT = (SELECT LegacyOrgId FROM DeviceConfiguration.mobileunit.AssetMobileUnits WHERE AssetId = @id)
--LegacyOrgId
SELECT liGMTOffset, * FROM FMOnlineDB.dbo.Organisation dboOrg WHERE dboOrg.liOrgID = @lorgID
-----------------------------------------
--Get Organisation based on long group id
-----------------------------------------
DECLARE @GroupId BIGINT = 1394911101344714752;
SELECT * FROM FMOnlineDB.dynamix.Organisations WHERE GroupId = @GroupId
SET @lorgID = (SELECT OrganisationId FROM FMOnlineDB.dynamix.Organisations WHERE GroupId = @GroupId)

SELECT liGMTOffset, * FROM FMOnlineDB.dbo.Organisation dboOrg WHERE dboOrg.liOrgID = @lorgID
```

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
