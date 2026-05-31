---
wiki_ingested: 2026-05-28
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-09T13:06
---

# OE-654 Not Languaged firmware upload request successful

Date: 2025-05-09 Time: 11:39
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-05-09]]
JIRA:OE-654 Not Languaged firmware upload request successful
[OE-654 Languaging BUG: firmware upload request successful - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-654)


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

- Firmware upload request successful
	- IT is in new FR UI POT
	- NOT IN: older one
- popAlert... languaged?
- 