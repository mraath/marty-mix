---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-06T10:42
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

- [ ] Check Jako's fix and PR...
- Compare when it was removed
- Speak to dev about this
- 