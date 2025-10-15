---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-15T16:23
---

# QA-7654 Edit Camera Name Case

Date: 2025-10-15 Time: 16:22
Parent:: ==xxxx==
Friend:: [[2025-10-15]]
JIRA:QA-7654 Edit Camera Name Case
[JIRA](https://powerfleet.atlassian.net/browse/QA-7654)


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

**Steps used to replicate the issue:**

1. In On-Road IoT, Navigate to MANAGE → CONFIG ADMIN → Libraries → Peripheral library
2. Search for the Streamax camera peripheral
3. Under the Features and settings dialog, select the Camera name heading
4. Click on the 3 dots Actions button next to any Camera name and select the Edit option…An Edit camera name modal displays on-screen
5. Inspect the modal descriptions

**BUG**: The modal description heading as well as the ‘Edit camera name’ free text heading is not sentenced capitalized as seen on the screen shot below…