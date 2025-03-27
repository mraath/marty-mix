---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-27T11:04
---

# QA-7242 Cant view Black Flag modal

Date: 2025-03-27 Time: 10:30
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-03-27]]
JIRA:QA-7242 Cant view Black Flag modal
[QA-7242 QA - Configuration groups (Beta): Unable to click on flag to open the "Configuration differences from group" Modal - Jira](https://csojiramixtelematics.atlassian.net/browse/QA-7242)


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

Black flag not clickable

- Version 25.6 beta
- BRANCH: Config/MR/BUG/QA-7242_BlackFlagNotClickable25.6.UAT.ORI

- Look for "Configuration differences from group" in the original HTML
- FE: configDiff
- BE: 

- [ ] Permission: canViewConfigDifference = allPermissions[ConfigConstants.Permissions.ASSET_LEVEL_BLACK_FLAG_REASON
- [ ] 