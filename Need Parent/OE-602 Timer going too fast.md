---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-03T08:29
---

# OE-602 Timer going too fast

Date: 2025-03-03 Time: 07:46
Parent:: [[OE-513]]
Friend:: [[2025-03-03]]
JIRA:OE-602 Timer going too fast
[OE-602 BUG - "Last refresh" interval indicator is cycling too quickly - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-602)


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

- Timer going too quickly
- Jako says it is potentially: private refreshTimer()

## Findings

Mine is like 30s ahead.
