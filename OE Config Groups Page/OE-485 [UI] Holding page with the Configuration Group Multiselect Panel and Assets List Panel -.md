---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-03-01T15:55
---

# OE-485 [UI] Holding page with the Configuration Group Multiselect Panel and Assets List Panel -

Date: 2024-01-23 Time: 11:00
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-01-23]]
JIRA:OE-485 [UI] Holding page with the Configuration Group Multiselect Panel and Assets List Panel -
[URL TO JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-485)

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

## Image Summary

[ADD IMAGE](<[[Excalidraw/OE-20 Planning.excalidraw.md#^5EPVHjXfv-zqYgk9FVBXG|iFrame]]>)


## Description


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

