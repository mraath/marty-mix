---
status: closed
date: 2023-01-17
comment: 
priority: 8
---

Date: 2023-01-17 Time: 08:19
Parent:: xxxx
Friend:: [[2023-01-17]]
JIRA:QA-5583 Speeding not available for selection
[QA-5583 UAE: Server-side tiered speed events enabled on Organisation, but Speeding - Tiered is not available for selection on Events - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-5583)

# QA-5583 Speeding not available for selection

## Testing

## Next Steps

- [x] Comment on the issue

I had a look at this issue and can confirm that that event was not present. The only one present was this one: Speeding - On-board tiered
![[Pasted image 20230117101743.png]]

Next I searched for the mentioned event and found the following comment. 3 Years ago there was some renaming done, but for languaging, older names were not renamed:
![[Pasted image 20230117101903.png]]

I searched for the mentioned Event Id on our Integration branch and found that it is being used by many libraries:
![[Pasted image 20230117101944.png]]

When I do that exact same search on UAE it is only used by the root library:
![[Pasted image 20230117102051.png]]

This indicated to me that this event was not "copied" into the organisation in question (or any other organisations for that matter)
If Paul can just confirm this and maybe he has some indication as to what could have caused this.



## Story Description

## SQL Used

```sql
USE DeviceConfiguration;
SELECT top 10 * FROM definition.Events
WHERE EventId = -5725594963738269514;

SELECT top 10 * FROM library.Events
WHERE EventKey = 31789;

SELECT top 10 * FROM template.Events
WHERE EventKey = 31789;
--WHERE Description like '%tiered%';

SELECT top 10 * FROM library.Libraries
WHERE LibraryKey IN (-1,700,510,1128,890,940)

SELECT *vFROM FMOnlineDB.dynamix.Organisations
WHERE GroupId IN (1,2364975042774694384,-8441185520557948197,-5478533298789189557,-5070807911028103534,-7912776881831891863)

SELECT liGMTOffset, * FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID IN (-1,748,1967,4159,4188,9389)
```

## Image

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.17 |     |
| Local |     |

## Branch
Config/MR/Bug/QA-5583 Speeding not available for selection.xx.xx.ORI
