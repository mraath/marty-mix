---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-20T10:18
---

# OE-656 Grey background

Date: 2025-05-19 Time: 15:15
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-05-19]]
JIRA:OE-656 Grey background
[OE-656 Error dialog and reset dialog appear in front of grey screen - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-656)


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

- [ ] Unable to upload firmware
- [ ] Reset to group config

- Correct eg: Compile and upload configuration
	- compileUploadHeader


## Duplicate

- Was easy

## Code

- Branch: FR UI: Config/MR/Bug/OE-656_GreyBackground
- Removed all "alert" references

- [ ] PR FR UI **INT**: xxxxxxxxxxxxxxx
- [ ] PR FR UI **DEV**: xxxxxxxxxxxxxxx

