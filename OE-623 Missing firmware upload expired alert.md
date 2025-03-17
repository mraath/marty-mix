---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-17T15:47
---

# OE-623 Missing firmware upload expired alert

Date: 2025-03-17 Time: 15:46
Parent:: [[OE-513]]
Friend:: [[2025-03-17]]
JIRA:OE-623 Missing firmware upload expired alert
[OE-623 Missing firmware upload expired alert - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-623)


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

