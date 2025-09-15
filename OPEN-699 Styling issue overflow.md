---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-15T08:26
---

# OPEN-699 Styling issue overflow

Date: 2025-09-15 Time: 08:25
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-09-15]]
JIRA:OPEN-699 Styling issue overflow
JIRA


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

![[OPEN-699 Styling issue overflow 1.png|400]]