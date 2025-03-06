---
status: closed
date: 2023-03-24
comment: 
priority: 8
---

# QA-5713 Icon Wires not languaged

Date: 2023-03-24 Time: 08:47
Parent:: [[lines]]
Friend:: [[2023-03-24]]
JIRA:QA-5713 Icon Wires not languaged
[QA-5713 QA - Various wire icons not languaged on mobile device template - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-5713)

## Currently

- Rudolf looking into deployment pipeline issue
- DONE
- OnDev

## Working from these wires

![[QA-5713 Wire names to language.txt]]

I had a look at the LinesData.xml
From there I built up the following txt file with all lines (some of which were not in the languaging)
(txt File attached)

I then updated the languaging file to include this.
Strings added can be seen here:
[Commit 1c9b0cf7: QA-5713: Added languaging for Wire icons - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Languaging/commit/1c9b0cf745fffb5a495dcc0533f7aa1c62dba00f)

Still to be tested and approved on DEV, INT after the next release.
Busy trying to deploy the languaging.