---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-24T15:05
---

# OPEN-1577 Multiple UI Forms and menu

Date: 2026-02-24 Time: 06:44
Parent:: ==xxxx==
Friend:: [[2026-02-24]]
JIRA:OPEN-1577 Multiple UI Forms and menu
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1577)

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

![[Pasted image 20260224071406.png]]

## CODE

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1577 Multiple UI Forms and menu.INT

## PR

- [x] OPEN-1577 Multiple UI Forms and menu > DEV ✅ 2026-02-24
- [ ] INT?
- 
## Notes

- [[SOP - Implementing Navigation Menu]]
- [[Project Map - Navigation and Decommissioning]]
- [[Walkthrough - Navigation Menu & Decommissioning Placeholder]]