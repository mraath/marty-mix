---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-02-26T14:37
---

# OE-614 Alerts not matched between CG and Assets

Date: 2025-02-25 Time: 09:57
Parent:: [[OE-515 Alerts Column Assets Panel]]
Friend:: [[2025-02-25]]
JIRA:OE-614 Alerts not matched between CG and Assets
[OE-614 The alerts shown on the assets page do not match the alerts shown on the left side - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-614)


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

config groups selected shown on the config side (left side) does not correspond on the asset side the count is not aligned 
it looks like if you have a missing parameter and you remove it. it does not update the alert as expected
The assets shown on the asset page do not match the alert shown on the left side.
E.g The FM3607i config group has 2 alerts on the left and 2 on the right
The MiX2310i has no alerts on the left but 1 on the right
The MiX4000 has 1 alert on the left and 1 on the right

![[OE-614 Alerts not matched between CG and Assets CG Side.png]]
![[OE-614 Alerts not matched between CG and Assets EG 2.png]]
![[OE-614 Alerts not matched between CG and Assets EG 3.png]]

## Findings

- I have found the same results
- [ ] I will compare the two swagger calls
	- OrgId: 2307906436721054420
	- CG: 
		- https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/2307906436721054420/alerts
{
    "configurationGroupIds": "-8601070457854353823,-3751550636977100219,-188994457358791832,-3539031602115732476,-6732880824993784265,61756661440635962,5347252666355409446,-4682479239161263365,-1508296197039288250,-8958682396246293176,-8864395233107620198,-1325082746264596693,-4003628735172700822,-9076606996180062319,-4717128997316087817,7972458021988004916,8815476176116823518,4919764585535166399,-7838770298250680961,3744429100126254243,-2748008063263561295,-6935626891522280445,1490244259299731130,-4258849611457539337,159897983233803411,-6284968178773227668"
}
- 
	- Assets: 
		- https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/2307906436721054420/asset-alerts-list
{
    "configurationGroupIds": "3744429100126254243"
}



## SQL Testing.... 

When stripping out the central part to see if parameters are supported...
For SINGLE asset.... it picjs up that the supported thingi is not there....
.... Check the stored proc
- Check with single
- Check with all
Here is a screenshot

![[OE-614 Alerts not matched between CG and Assets Issue found.png]]

## Stored Proc

> C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Alert issue assets for more than one cgId.sql
