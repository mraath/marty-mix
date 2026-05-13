---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-28T14:14
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

- [x] Unable to upload firmware ✅ 2025-05-20
- [x] Reset to group config ✅ 2025-05-20

- Correct eg: Compile and upload configuration
	- compileUploadHeader


## Duplicate

- Was easy

## Code

- Branch: FR UI: Config/MR/Bug/OE-656_GreyBackground
- Removed all "alert" references

- [x] PR FR UI **INT**: [Merge fix to INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/125353) ✅ 2025-05-28
- [x] PR FR UI **DEV**: xxxxxxxxxxxxxxx ✅ 2025-05-20

## DEV TEST

![[OE-656 Grey background Firmware error fixed.png|400]]

![[OE-656 Grey background Reset Config fixed.png|400]]
