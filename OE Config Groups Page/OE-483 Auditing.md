---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-10T11:40
---

# OE-483 Auditing

Date: 2025-03-03 Time: 11:32
Parent:: ==xxxx==
Friend:: [[2025-03-03]]
JIRA:OE-483 Auditing
[OE-483 BE Auditing (Handled as part of Config-2690) - #7 - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-483)

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

## Description

Compare the Auditing between the OLD and BETA system

## Image

![[OE-483 Auditing Compare between OLD and BETA.png|600]]



## Outstanding Logic - discuss with Nicole

We never implemented the: 
- [ ] download config file
- [ ] download pending config file
This should be simple, but we should mention this to Nicole.

## FR UI

[[OE-483 Auditing_Research]]
