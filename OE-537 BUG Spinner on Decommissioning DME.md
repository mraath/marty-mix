---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-05T11:26
---

# OE-537 BUG Spinner on Decommissioning DME

Date: 2025-06-05 Time: 11:26
Parent:: [[Remove Mobile Device]]
Friend:: [[2025-06-05]]
JIRA:OE-537 BUG Spinner on Decommissioning DME
https://powerfleet.atlassian.net/browse/OE-537


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

