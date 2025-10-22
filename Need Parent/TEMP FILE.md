---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-17T12:13
---

# TEMP FILE

Date: 2025-10-17 Time: 12:13
Parent:: ==xxxx==
Friend:: [[2025-10-17]]
JIRA:TEMP FILE
==URL TO JIRA==


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

OK, the UI is now performing as expected...
Only on my local PC, until I am sure all of this is OK...

### UI Results

Asset List

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Asset List.png]]

Configuration Group

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Configuration Group.png]]

### Code for this:

#### Configuration Groups

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Code Config Groups.png]]

#### Asset List Logic

![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices Asset List Code.png]]

#### Other logic

Some logic I found which I had a question about, but I will leave it as is:
![[MIX3K-89 Missing upgrade firmware button for MiX3000 devices BaseMesa Question.png]]
