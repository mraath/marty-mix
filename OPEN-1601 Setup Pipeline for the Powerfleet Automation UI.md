---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-16T14:23
---

# OPEN-1601 Setup Pipeline for the Powerfleet Automation UI

Date: 2026-02-16 Time: 07:14
Parent:: ==xxxx==
Friend:: [[2026-02-16]]
JIRA:OPEN-1601 Setup Pipeline for the Powerfleet Automation UI
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1601)

Linked to [[OPEN-1493 UI for Salesforce case Info]]

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


## Code


## Deploy

- DEV: 
	- **[http://52.211.2.39:3000](http://52.211.2.39:3000/)** BACKDOOR
		- http://18.202.56.106:3000/
	- **[https://powerfleet-automation.dev.mixtelematics.com](https://powerfleet-automation.dev.mixtelematics.com/)** MAIN


"https://powerfleet-automation.dev.mixtelematics.com",
"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxAPI",


automation.dev.mixtelematics.com
automation-api.dev.mixtelematics.com


"https://mixconfigfrangularui.mixdevelopment.com",
"https://mixconfigfrangularapi.mixdevelopment.com",



## Branch

> Branch: Config/MR/Feature/OPEN-1601 Setup Pipeline for the Powerfleet Automation UI.INT

## PR

- [ ] OPEN-1601 Setup Pipeline for the Powerfleet Automation UI > DEV
- [ ] OPEN-1601 Setup Pipeline for the Powerfleet Automation UI > INT
- [ ] OPEN-1601 Setup Pipeline for the Powerfleet Automation UI > UAT
- [ ] OPEN-1601 Setup Pipeline for the Powerfleet Automation UI > PROD


## AWS Vrae

Ek besig met die AWS goed.

Die UI dev het seker 4 of 6 ure geneem, maar die AWS deel neem nou al 2 dae ![Smiley with tongue out](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/tongueout/default/20_f.png)

Is daar n vinniger manier om dit te doen.

Ek neem aan mens moet iets opstel vir die UI en die API vir elke env (Dev, INT, Prod x X)

So is daar n script wat dit vir mens kan doen?

**Automation UI.**

Ekt klaar die moving parts vir die DEV environment opgestel.

Dit run, maar wys nie na die regte urls nie WANT dis nog op IP... die DNS moet nog opgestel word.

So is ek reg dat iemand (dalk van Fleer die DNS moet activate? watse info gee ek hulle?)

So vir die UI kort nog net die DNS (DINK ek)

**Automation API**

Ekt nou net bietjie begin doen

Die antwoord gaan seker dieselfde lyk vir die API.

Op die oomblik is die volgende die name.... dit voel bietjie lomp - kan ek dit verbeter (moet ook PROD in ag neem)

OOK - ek piggy back soveel moontlik op goed wat reeds bestaan (eg. DEV-config container, DEV_Config_ExtermalALB loadbalancer)

(Als goed wat ek Vrydag beter van geleer het ![Smiley with tongue out](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/tongueout/default/20_f.png))

Name op die oomblik:

Automation **UI**: automation.dev.mixtelematics.com

Automation **API**: automation-api.dev.mixtelematics.com

Ok - dink julle het nou genoeg van my gehoor....

Ek dink nie hierdie maak die "uitrol" n baie lang proses - so ek sal eers net DEV doen

## AWS Setup

