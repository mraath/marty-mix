---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-28T07:32
---

# OPEN-862 Beta Slow

Date: 2025-10-28 Time: 06:51
Parent:: ==xxxx==
Friend:: [[2025-10-28]]
JIRA:OPEN-862 Beta Slow
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-862)


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

There are noticeable loading delays on the Config Groups Page (_Beta_). The service that retrieves the CAN scripts from each vehicle in the chosen organisation might be the main source of the bottleneck. Before implementing further optimizations or architectural changes, it is essential to confirm the root cause of the slowness.

This Spike aims to:
- Profile and analyze the page load process to identify where the most time is spent.   
- Determine if the **CAN Scripts** fetching is the main contributor to the slow load times, or if other factors are involved.
- Document findings

[[OPEN-862 Beta Slow AI]]
