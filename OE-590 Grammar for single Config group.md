---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-06T12:59
---

# OE-590 Grammar for single Config group

Date: 2025-05-06 Time: 12:57
Parent:: [[OE-562 Language count]]
Friend:: [[2025-05-06]]
JIRA:OE-590 Grammar for single Config group
[OE-590 Grammar: Compile and upload configuration dialog - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-590)


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

