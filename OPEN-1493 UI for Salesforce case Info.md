---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-04T11:33
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

### Answer 1

🛠 Is Next.js a Good Fit?

**Yes, Next.js is an excellent fit for this use case.**

While Vanilla JS (HTML/CSS/JS) is "lighter," it becomes a maintenance nightmare once you add authentication and complex state management. Here is why Next.js wins for your team:

- **Speed of Setup:** You can spin up a UI with **Tailwind CSS** and **shadcn/ui** components in minutes.
    
- **Built-in API Routes:** Since you need to talk to a Salesforce API and your own DB, you can use Next.js `Route Handlers` as a proxy. This hides your API keys from the frontend (security) and handles the JSON transformation easily.
    
- **Authentication:** Using **NextAuth.js (Auth.js)** allows you to connect to your own database or an existing provider with very little boilerplate.
    
- **Standardization:** As your team grows, having a Next.js structure ensures everyone knows where the routes, components, and logic live. Vanilla JS often becomes "spaghetti code" in rapid development.
    

---

🚀 Evaluating the "B.L.A.S.T. Master System Prompt"

Your prompt is **highly sophisticated** and perfect for an Operations Tools role. Here’s why it works for your new team:

**1. Does it fit the CEO's "Quick Solution" mandate?**

Yes, but with a caveat. Your prompt forces a **Blueprint phase**. While this might feel like it slows you down by 5 minutes, it prevents "re-work" (doing the task twice because you misunderstood the JSON schema). In a rapid environment, **clear data schemas (Phase 2)** are the only things that prevent total system collapse.

**2. Can you use this for future tasks?**

Absolutely. Because the prompt is **modular**, you can use it for:

- Building a new UI form (like your current Quality Control task).
    
- Writing a one-off data migration script.
    
- Automating a Salesforce-to-Slack notification.
    
    The "Global Operating Rules" ensure that no matter the task, the AI will ask for the "North Star" and "Source of Truth" first.
    

**3. Can you enhance the app later?**

Yes. Phase 5 (**Trigger**) and the **Instruction Preservation Rule** are designed for this. You can tell the AI: _"We have the basic form working. Now, using the existing Blueprint, add a validation step that checks for duplicate Salesforce IDs before submitting."_

---

📊 Summary Table: Tech Choice

| **Feature**           | **Vanilla JS**   | **Next.js**            | **Winner**  |
| --------------------- | ---------------- | ---------------------- | ----------- |
| **Development Speed** | High (initially) | Very High (components) | **Next.js** |
| **Security (Auth)**   | Manual/Difficult | Built-in (NextAuth)    | **Next.js** |
| **API Handling**      | Client-side only | Server-side (Secure)   | **Next.js** |
| **Reproducibility**   | Low              | High (Templates)       | **Next.js** |

### Second question

## Steps

- I asked AI if next.js and BLAST would be a good fit.... YES
- I will use firecrawl.dev > playground to get all the brand design
- 

## Code


## Branch

> Branch: Config/MR/Feature/OPEN-1493 UI for Salesforce case Info.INT

## PR

- [ ] OPEN-1493 UI for Salesforce case Info > DEV
- [ ] OPEN-1493 UI for Salesforce case Info > INT
- [ ] OPEN-1493 UI for Salesforce case Info > UAT
- [ ] OPEN-1493 UI for Salesforce case Info > PROD
