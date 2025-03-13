---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-13T11:54
---

# OE-635 Dropdown filtering messed up

Date: 2025-03-13 Time: 11:13
Parent:: [[OE-513]]
Friend:: [[2025-03-13]]
JIRA:OE-635 Dropdown filtering messed up
[OE-635]Dropdown filtering does not correctly apply text input criteria - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-635)


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


- Filter by mobile device
	- 