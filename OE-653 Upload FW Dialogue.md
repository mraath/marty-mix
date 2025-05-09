---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-09T16:49
---

# OE-653 Upload FW Dialogue

Date: 2025-05-09 Time: 16:32
Parent:: [[Languaging]]
Friend:: [[2025-05-09]]
JIRA:OE-653 Upload FW Dialogue
[OE-653 Languaging BUG: config groups tab | Actions | Upload firmware | dialog text - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-653)


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

- CG > Upload FW
- Use [[Languaging Translation Issues]]
- uploadFirmwareTranslatedText
- uploadFirmware
- Are you sure you want to upload firmware to {{configGroupSelectedKeys.length}} configuration group(s)?

