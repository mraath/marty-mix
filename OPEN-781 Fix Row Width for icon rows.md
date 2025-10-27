---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-27T10:06
---

# OPEN-781 Fix Row Width for icon rows

Date: 2025-10-27 Time: 09:41
Parent:: ==xxxx==
Friend:: [[2025-10-27]]
JIRA:OPEN-781 Fix Row Width for icon rows
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-781)


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

Normal row
![[OPEN-781 Fix Row Width for icon rows-1.png]]

Icon row without fix
![[OPEN-781 Fix Row Width for icon rows.png]]

Icon row with potential fix
![[OPEN-781 Fix Row Width for icon rows-2.png]]

Fix:
```css
element.style {
    padding-top: 0px !important;
    padding-bottom: 0px !important;
}
```

