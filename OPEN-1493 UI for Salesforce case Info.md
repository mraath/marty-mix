---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-04T15:50
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

Currently, we are waiting for Salesforce devs to implement [OPEN-1356: Trigger QC API EndpointReady for Grooming](https://powerfleet.atlassian.net/browse/OPEN-1356) and [OPEN-1295: Call Salesforce Endpoint from QC AutomationReady for Sprint](https://powerfleet.atlassian.net/browse/OPEN-1295). We are not sure how long that will take, therefore we need to supply the support agents with a mechanism to supply the needed Salsforce case info and return the result for them. To do this, we need to:

1. Create a UI that will enable them to fill in the needed data points (see [OPEN-1356: Trigger QC API EndpointReady for Grooming](https://powerfleet.atlassian.net/browse/OPEN-1356)).
    
2. Supply an overloaded version of the Endpoint that returns the resultset in json format for them to add to the Salesforce case.

## AI

### First question - gemini

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

### Second question - Antigravity (flash)

I've been asked to start working on a new team. It's called the Operations Tools Team. We will be doing very rapid application development. We still need to consider standards, but the main aim is to quickly complete and come with solutions for customer issues. Basically, we will get a task from our CEO, and then we must come up with a quick solution. I wanted to know if my below prompt will be adequate for this. What I would like to do, for instance, we currently have a quality control epic. From that epic, we got a phase one for quality control. And out of that phase one, we have a UI form I need to design in which we will get information from a user. This information is related to Salesforce. I will then push this information into our API. The API will do certain tests on our user data and then return a JSON object This JSON object we will later feed back into Salesforce. We do need to authenticate a user, so we need some form of login, which will authenticate against our own database / api. We could use the same API to do this, or maybe we could use a different one. Please consider this while planning. 

I will be focussing on the following story: [https://powerfleet.atlassian.net/browse/OPEN-1493](https://powerfleet.atlassian.net/browse/OPEN-1493) I am still busy getting the repo locally, so I can send you the fields needed on the form, for our planning, however, while I am waiting to get this, could you look at the above story.... then also look into the links below.... to see related things I should consider, also maybe build a short diagram as to how these stories link.... I know there was an epic / spice (OPEN-1123) from which they generated the phase 1 (OPEN-1264) of which this story I am working on (OPEN-1493) is one of the tasks. Some more links: - Spike QC Automation: [https://powerfleet.atlassian.net/browse/OPEN-1223](https://powerfleet.atlassian.net/browse/OPEN-1223) Investigate QC Automation - Epic na API: [https://powerfleet.atlassian.net/browse/OPEN-1264](https://powerfleet.atlassian.net/browse/OPEN-1264) Unity MX Installation QC Automation - Phase 1 - [https://powerfleet.atlassian.net/browse/OPEN-1495](https://powerfleet.atlassian.net/browse/OPEN-1495) Investigate Customer Database requirements (not related to OPEN-1493) - [https://powerfleet.atlassian.net/browse/OPEN-1493](https://powerfleet.atlassian.net/browse/OPEN-1493) Add UI for support to supply Salesforce case info and start QC Automation manually - [https://powerfleet.atlassian.net/browse/OPEN-1494](https://powerfleet.atlassian.net/browse/OPEN-1494) Meeting: Investigate Config analyses tool to see where changes happened (future story)  
  
  
Once we know more I would like to plan this using the planning and brainstorming skill, after this I will give you very specific BLAST prompt to help me in the design. Please also use the design skill and the resources folder in order to know the branding. Please do keep track of where we are in this process. Maybe make use of gemini.md or a blueprint.md or whatever will work for you. Please let me know which file to refer back to for status on this.

### Answer 2

- [ ] **Environment:** Where will this UI live? (e.g., Internal web portal, standalone desktop app, or nested in Salesforce via Canvas/Iframe?)
- [ ] **Authentication Flow:** You mentioned authenticating against your own DB/API. We should decide if we want a SSO (Single Sign-On) experience with Salesforce or a separate login.
- [ ] **API Contract:** Once you have the local repo, let's define the JSON structure the API expects and what it returns.
- [ ] local repository: **Form fields** field requirements
- [ ] **API details** needed
- [ ] 

### Question 3 - AG (field info etc)

 As this will be a tool which might become part of a bigger project (which most likely will be angular or c#), please write the next.js app in such a way that logic can be easily extracted and moved over if needed.
- **UI fields**: The form that needs to be filled in in the ui has these fields: C:\Projects\Powerfleet.Automation\Powerfleet.Automation.Logic\Entities\SalesforceCase.cs. Not all of these are needed. I might need to change it going forward but for now only up to **Odometer** is mandatory.
- **Environment**: You had a good question, for now I will test it locally as a standalone next.js app, going forward we will most likely host this in AWS.
- **Authentication**: I will need to authenticate against an api end-point on our server. This authentication will need to happen before the user gets access to capturing this form. A good example of such a potential auth form is: https://integration.mixtelematics.com/#/login. For now we wont need the Language selector. so only the username and password.
- **API Contract**: See what I mentioned about the fields, this class will then be sent to this api end-point:  C:\Projects\Powerfleet.Automation\Powerfleet.Automation.Api\Controllers\QC\QcController.cs, the controller is:  `public async Task<IActionResult> PerformQC([FromQuery] string authToken, [FromBody] SalesforceCase caseDetail)`
- **API Result**: Currently this class gets returned: C:\Projects\Powerfleet.Automation\Powerfleet.Automation.Common\RequestResult.cs, which we will need to make nicer and convert to the correct JSON. The `List<TestArea> TestAreas` shows what was tested while `List<string> Messages` gives more information eg. results or reasons for failure. We can correct the JSON format later. Please take note.


## Questions to team

### Questions vir William

Hey - so paar vinnige vrae:
- API: Run dit al iewers (Eg. dev / int) waar ek dit kan roep of run ek dit net locally
- UI: Waar gaan dit leef? Op een van AWS servers? OF iewers op n SalesForce server? Het ons al n plek om dit te sit?
- UI Fields: Jy het gese dis die SalesforceCase class tot en met die Odometer field? Sorry my note le by die huis :-D
- AUTH: Roep ons die huidige Config.API auth end-point? Seker?
- JSON: Het ons al n idee hoe dit moet lyk aan die einde of gaan ons dit vir nou eers kyk hoe dit lyk en dan verder gesels?
- 

## Steps

- I asked AI if next.js and BLAST would be a good fit.... YES
- I will use firecrawl.dev > playground to get all the brand design
- Got a local repo for OperationsTools
- [ ] Should we use the Salesforce or Powerfleet **styling**?
	- Extract: Use CSS Peeper on your company’s main portal to get the HEX codes.
	- Mockup: Use html.to.design to pull a Salesforce layout into Figma so your form looks native to the environment.
	- Implement: In your Next.js app, put these colors into your tailwind.config.ts so you can use them as standard classes (e.g., bg-brand-blue).
- 

## Code


## Branch

> Branch: Config/MR/Feature/OPEN-1493 UI for Salesforce case Info.INT

## PR

- [ ] OPEN-1493 UI for Salesforce case Info > DEV
- [ ] OPEN-1493 UI for Salesforce case Info > INT
- [ ] OPEN-1493 UI for Salesforce case Info > UAT
- [ ] OPEN-1493 UI for Salesforce case Info > PROD
