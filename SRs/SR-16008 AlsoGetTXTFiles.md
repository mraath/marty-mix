---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2023-12-05T16:09
---

# SR-16008 AlsoGetTXTFiles

Date: 2023-12-05 Time: 16:09
Parent:: ==xxxx==
Friend:: [[2023-12-05]]
JIRA:SR-16008 AlsoGetTXTFiles
==URL TO JIRA==

## Lesson

- [ ] What was the MAIN cause or thing learned from this?

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

## Branch

Config/MR/Bug/SR-16008_AlsoGetTXTFiles.23.16.ORI

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
