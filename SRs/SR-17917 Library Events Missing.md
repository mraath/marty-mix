---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-04-16T15:53
---

# SR-17917 Library Events Missing

Date: 2024-04-16 Time: 08:57
Parent:: [[Events]]
Friend:: [[2024-04-16]]
JIRA:SR-17917 Library Events Missing
[JIRA](https://csojiramixtelematics.atlassian.net/browse/SR-17917)


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

EventKey	EventId
3120	    -886123622139984997
3118	    2456605873203796503
3121	    6707552231300886991

## Findings

The provided ids were definition event ids.  
From there I got the EventKeys.  

I found the above event keys for this org as:
3118 SP2000-Driving at Night Outside Camp 30 KM (PDO) Last Update: 2024-01-08 04:47:01 +00:00	Atif Iqbal
3120 SP2000-OverSpeeding at Night Time                           Last Update: 2024-04-05 11:04:21 +00:00	Ashraf Hijazi
3121 SP2000-OverSpeeding LSR-Night Time                        Last Update: 2024-04-05 11:03:51 +00:00	Ashraf Hijazi

When I then have a look at the audit tables, I only saw 3 updates...
Nothing older than 2024-04-05
3120 SP2000-OverSpeeding at Night Time(19:00PM-5:00AM)	 2024-04-05 11:03:14 +00:00	Ashraf Hijazi
3120 SP2000-OverSpeeding at Night Time	                             2024-04-05 11:04:21 +00:00	Ashraf Hijazi
3121 SP2000-OverSpeeding LSR-Night Time	                             2024-04-05 11:03:51 +00:00	Ashraf Hijazi

I found other events where the name started with “SP2000”, however it had different EventKeys.

Next, I will look at MFM and see what I can see, once my user is enabled.
Lastly we could ask Martin to look at the datawarehouse to see if there are any older audits logged.

## SOC

Could someone please enable my account on: https://om.mixtelematics.com/


## Events in the system present

![[SR-17917 Library Events Missing Event present.png|600]]

## SQL

[[SQL SR-17917 Library Events deleted]]

