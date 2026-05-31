---
wiki_ingested: 2026-05-28
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-17T11:01
---

# OPEN-235 Error when moving Unallocated to Config Group

Date: 2025-06-06 Time: 10:12
Parent:: [[Configuration Groups]]
Friend:: [[2025-06-06]]
JIRA:OPEN-235 Error when moving Unallocated to Config Group
https://powerfleet.atlassian.net/browse/OPEN-235


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

![[OPEN-235 Error when moving Unallocated to Config Group.png|300]]

## Next Step

- INT: Check Jako's fix and PR...
- Compare when it was removed
- Speak to dev about this

## Jako

Yes, ek dink ek het hierdie na 'n SP verander
Ek dink die ticket is **CONFIG-4604**
Veranderinge is op 
- **Config.API** en 
- **Database** project
![[OPEN-235 Error when moving Unallocated to Config Group-1.png]]
Baie eienaarding. Ek sien nie dat dit na INT gemerge is nie...
![[OPEN-235 Error when moving Unallocated to Config Group-1.png]]
Hy is onder ander ticket nommer in gecheck
![[OPEN-235 Error when moving Unallocated to Config Group-2.png]]
Ek vind nie een van my lyne in INT nie... Dis dalk uit gemerge

