---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-04T11:06
---

# OPEN-1493 UI for Salesforce case Info

Date: 2026-02-04 Time: 11:05
Parent:: ==xxxx==
Friend:: [[2026-02-04]]
JIRA:OPEN-1493 UI for Salesforce case Info
==URL TO JIRA==


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


## AI

### First question

I've been asked to start working on a new team. It's called the Operations Tools Team. We will be doing very rapid application development. We still need to consider standards, but the main aim is to quickly complete and come with solutions for customer issues. Basically, we will get a task from our CEO, and then we must come up with a quick solution. I wanted to know if my below prompt will be adequate for this. What I would like to do, for instance, we currently have a quality control epic. From that epic, we got a phase one for quality control. And out of that phase one, we have a UI form I need to design in which we will get information from a user. This information is related to Salesforce. I will then push this information into our API. The API will do certain tests on our user data and then return a JSON object This JSON object we will later feed back into Salesforce Would a Next.js web app be a good fit for this? We do need to authenticate a user, so we need some form of login, which will authenticate against our own database. We could use the same API to do this, or maybe we could use a different one. Is there something that if we use Next.js, is the Next.js app a good fit? Or should I rather just go for vanilla JS and API calls and CSS? What would be the best fit? Also, is there something that we could reproduce? Could we, because obviously now I'm going to work on this UI form, but in future I will work on something else. So could I then still use the below prompt? And also, once I use this prompt, can I still enhance the app? Let me know.

(Pasted the BLAST prompt her)

### Second question



## Code


## Branch

> Branch: Config/MR/Feature/OPEN-1493 UI for Salesforce case Info.INT

## PR

- [ ] OPEN-1493 UI for Salesforce case Info > DEV
- [ ] OPEN-1493 UI for Salesforce case Info > INT
- [ ] OPEN-1493 UI for Salesforce case Info > UAT
- [ ] OPEN-1493 UI for Salesforce case Info > PROD
