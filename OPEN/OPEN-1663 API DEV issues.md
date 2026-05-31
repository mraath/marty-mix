---
wiki_ingested: 2026-05-28
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-23T08:38
---

# OPEN-1663 API DEV issues

Date: 2026-02-23 Time: 08:08
Parent:: ==xxxx==
Friend:: [[2026-02-23]]
JIRA:OPEN-1663 API DEV issues
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1663)


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

- Found in [[OPEN-1602 Pipeline for Powerfleet Automation API]]

## Code

UI: https://powerfleet-automation.dev.mixtelematics.com
API: https://automation-api.dev.mixtelematics.com/swagger/index.html
Config API: 

- `api.deviceconfig.configdev.mix.local` (Local/On-prem DNS)
- `api.deviceconfig.dev.priv`
## Branch

> Branch: Config/MR/Feature/OPEN-1663 API DEV issues.INT

## PR

- [ ] OPEN-1663 API DEV issues > DEV
- [ ] OPEN-1663 API DEV issues > INT
- [ ] OPEN-1663 API DEV issues > UAT
- [ ] OPEN-1663 API DEV issues > PROD
