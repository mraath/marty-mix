---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-08T14:57
---

# OE-651 Multiselect Compile Error

Date: 2025-05-08 Time: 13:48
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-05-08]]
JIRA:OE-651 Multiselect Compile Error
[OE-651 Beta - multiselect - compile error - no indication which asset is causing the issue - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-651)


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

- I believe the behaviour here should be to request the compile for the ones that can and perhaps just notify that some of the assets cannot request compile (need some wording here) perhaps it can be an orange warning toast message I dont think we need to say which ones as the ones that failed would all stay in config changed status
- “it also doesn’t action the compile for the other…” - this is a bug as the original spec said it should not crash on error but continue with the rest

![[OE-651 Multiselect Compile Error Eg.png|650]]

