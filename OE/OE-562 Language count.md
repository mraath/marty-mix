---
wiki_ingested: 2026-05-28
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-06T13:06
---

# OE-562 Language count

Date: 2025-04-22 Time: 09:28
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-04-22]]
JIRA:OE-562 Language count
[[OE-562] UI: Configuration groups (beta) - Wording/grammar changes - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-562)

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

Issue string:

{{incompatibleAssets}} asset(s) have associated mobile devices that do not match the mobile device in the selected configuration group. Proceeding with this move will remove the mobile devices, and they will be decommissioned.

- Followed [[Languaging Translation Issues]]

Testing this locally:
Eng:
xxxxxxxxxxxxx

Pig Latin:
cccccccccccccccccccccccc

