---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-16T12:30
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

## AWS Setup

