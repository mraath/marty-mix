---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-02T09:50
---

# ETS-2199 Cannot delete Location

Date: 2025-07-02 Time: 09:40
Parent:: ==xxxx==
Friend:: [[2025-07-02]]
JIRA:ETS-2199 Cannot delete Location
[JIRA](https://powerfleet.atlassian.net/browse/ETS-2199)


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

Org details:  

|   |   |
|---|---|
|Environment|US|
|Org Name|MIXTEL BR - LINDE URUGUAY|
|AssetDB name|MIXTELBR_LINDECOLOMBIA_2014|
|OrgId (Legacy)|428|
|Company ID|2630|
|Org id|-5722240546621579774|
|Library key|114|

Locations  
Baliza Calle Jose Llupes - Location ID 1672836313996447744  
Baliza Calle Santa Lucía - Location ID 1672834094639992832  
  
Hi team,

The customer created the locations below in error and would like to remove them. However, when I try to remove them, I see the error below.

![[Untitled 3.png]]


Can the config team help us to remove the locations like in [SR-16816 UK: Unable to remove location - Jira](https://powerfleet.atlassian.net/browse/SR-16816)

## SR-16816

Paul: ![[Untitled 4.png]]
```sql
SELECT * FROM [DeviceConfiguration].[library].[EventConditions] where value like '-2377262399866316915%'
SELECT * FROM [DeviceConfiguration].[library].[Events] where Eventkey 36121
SELECT * FROM [DeviceConfiguration].[library].[Events] where EventKey - 36121
SELECT * FROM [DeviceConfiguration].[library].[EventTemplates] where EventTemplateKey = 29292
```
