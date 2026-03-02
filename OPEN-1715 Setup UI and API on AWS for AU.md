---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-03-02T12:31
---

# OPEN-1715 Setup UI and API on AWS for AU

Date: 2026-03-02 Time: 12:24
Parent:: ==xxxx==
Friend:: [[2026-03-02]]
JIRA:OPEN-1715 Setup UI and API on AWS for AU
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1715)

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

## Description

Please set up the AWS environments for both the Automation UI and API.
Once done we can deploy to these environment to start testing on AU.

## CODE

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1715 Setup UI and API on AWS for AU.INT

## PR

- [ ] OPEN-1715 Setup UI and API on AWS for AU > DEV
- [ ] OPEN-1715 Setup UI and API on AWS for AU > INT
- [ ] OPEN-1715 Setup UI and API on AWS for AU > UAT
- [ ] OPEN-1715 Setup UI and API on AWS for AU > PROD
