---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-11T07:23
---

# OE-632 Kebab menu not visible

Date: 2025-03-11 Time: 07:23
Parent:: [[OE-513]]
Friend:: [[2025-03-11]]
JIRA:OE-632 Kebab menu not visible
[OE-632 Kebab menu not visible upon loading - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-632)


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
