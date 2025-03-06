---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-02-25T10:00
---

# OE-611 Alert not adjusting when removing missing parameters

Date: 2025-02-25 Time: 09:57
Parent:: [[OE-515 Alerts Column Assets Panel]]
Friend:: [[2025-02-25]]
JIRA:OE-611 Alert not adjusting when removing missing parameters
[OE-611 Alert not updating as expected when an event with missing parameters is removed from the event template - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-611)


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


## Duplicate Issue


## Maybe check the logs?


## Screenshot of the issue


## Lesson

- [ ] What was the MAIN cause or thing learned from this?


## Image learned from this issue

ADD IMAGE

## Move what you learned into the bigger picture

ADD IMAGE

## Shorter Summary



## Description


## Ideas

- [ ] Duplicate in Prod
- [ ] Duplicate on INT
- [ ] Check DB, Logs

## SR Meeting Notes


## Useful Comments from Jira


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing



## Follow the code path

### Log


### Data


### Code


## Final Findings for Jira

- 
