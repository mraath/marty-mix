---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-23T16:53
---

# OPEN-1493 UI for Salesforce case Info

Date: 2026-02-04 Time: 11:05
Parent:: [[Operations Tools]]
Friend:: [[2026-02-04]]
JIRA:OPEN-1493 UI for Salesforce case Info
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1493)


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

- [x] **Environment:** Where will this UI live? (e.g., Internal web portal, standalone desktop app, or nested in Salesforce via Canvas/Iframe?) ✅ 2026-02-05
- [x] **Authentication Flow:** You mentioned authenticating against your own DB/API. We should decide if we want a SSO (Single Sign-On) experience with Salesforce or a separate login. ✅ 2026-02-05
- [x] **API Contract:** Once you have the local repo, let's define the JSON structure the API expects and what it returns. ✅ 2026-02-05
- [x] local repository: **Form fields** field requirements ✅ 2026-02-05
- [x] **API details** needed ✅ 2026-02-05

### Question 3 - AG (field info etc)

 As this will be a tool which might become part of a bigger project (which most likely will be angular or c#), please write the next.js app in such a way that logic can be easily extracted and moved over if needed.
- **UI fields**: The form that needs to be filled in in the ui has these fields: C:\Projects\Powerfleet.Automation\Powerfleet.Automation.Logic\Entities\SalesforceCase.cs. Not all of these are needed. I might need to change it going forward but for now only up to **CanConnected** is mandatory.
- **Environment**: You had a good question, for now I will test it locally as a standalone next.js app, going forward we will most likely host this in AWS.
- **Authentication**: I will need to authenticate against an api end-point on our server. This authentication will need to happen before the user gets access to capturing this form. A good example of such a potential auth form is: https://integration.mixtelematics.com/#/login. For now we wont need the Language selector. so only the username and password.
- **API Contract**: See what I mentioned about the fields, this class will then be sent to this api end-point:  C:\Projects\Powerfleet.Automation\Powerfleet.Automation.Api\Controllers\QC\QcController.cs, the controller is:  `public async Task<IActionResult> PerformQC([FromQuery] string authToken, [FromBody] SalesforceCase caseDetail)`
- **API Result**: Currently this class gets returned: C:\Projects\Powerfleet.Automation\Powerfleet.Automation.Common\RequestResult.cs, which we will need to make nicer and convert to the correct JSON. The `List<TestArea> TestAreas` shows what was tested while `List<string> Messages` gives more information eg. results or reasons for failure. We can correct the JSON format later. Please take note.

### Answers

- Ran into an error
- [x] **API Base URL:** TBD (Please provide the local/dev API endpoint for the  `QcController` ). ✅ 2026-02-05
- [x] **Auth Endpoint:** TBD (Please provide the authentication endpoint URL). ✅ 2026-02-05

### Another help regarding fields

Before I said the fields only need to go up to a certain point, I was wrong, it must go up to only up to **CanConnected** is mandatory.
Here is an example of the json we will get in future once salesforce integrates with this endpoint directly and we no longer need the UI manual form:
```json
{  
  "CaseNumber": "XYZ",  
  "GroupId": 1234567890123456,    
  "LegacyOrgId": 1234,  
  "UniqueIdentifier": "3453453453453",  
  "AssetId": 1234567890123456,  
  "DeviceType":"MIX4000",  
  "InstallationDateCompleted": "2024-01-21T05:52:09Z",  
  "FirmwareVersion": "4.6.1",  
  "Odometer": 987654,  
  "DriveMateConnected": false,  
  "IridiumConnected": false,  
  "RoviConnected": false,  
  "DtcoConnected": false,  
  "VideoConnected": false,  
  "CanConnected": false  
}
```

```json
{  
  "CaseNumber": "XYZ",  
  "GroupId": 4036779219063094058,    
  "LegacyOrgId": 1234,  
  "UniqueIdentifier": "359315071771793",  
  "AssetId": 1660021429525905408,  
  "DeviceType":"MIX4000",  
  "InstallationDateCompleted": "2024-01-21T05:52:09Z",  
  "FirmwareVersion": "4.6.1",  
  "Odometer": 987654,  
  "DriveMateConnected": false,  
  "IridiumConnected": false,  
  "RoviConnected": false,  
  "DtcoConnected": false,  
  "VideoConnected": false,  
  "CanConnected": false  
}
```

```txt
{938e1822-bfee-4da9-bddc-78846fdc18a0
  "CaseNumber": "1234",
  "GroupId": 4036779219063094058,
  "LegacyOrgId": 0,
  "UniqueIdentifier": "359315071771793",
  "AssetId": 1660021429525905408,
  "DeviceType": "MIX4000",
  "InstallationDateCompleted": "2026-02-18T03:06:12.529Z",
  "FirmwareVersion": "MIX4000",
  "Odometer": 0,
  "DriveMateConnected": true,
  "IridiumConnected": true,
  "RoviConnected": true,
  "DtcoConnected": true,
  "VideoConnected": true,
  "CanConnected": true,
  "DateToPending": "2026-02-18T03:06:12.529Z",
  "RequestResults": {
    "Status": "Unknown",
    "TestAreas": [
      {
        "AreaName": "string",
        "Result": "string"
      }
    ],
    "Messages": [
      "string"
    ]
  },
  "IsConfigTested": true,
  "IsTripInfoTested": true,
  "IsCommsTested": true,
  "IsDriveMateTested": true,
  "IsIridiumTested": true,
  "IsRoviTested": true,
  "IsDtcoTested": true,
  "IsVideoTested": true,
  "IsCanTested": true,
  "CurrentCaseStatus": "Unknown"
}
```


> OK - I just want to know. The whole idea with the different appsettings json files is so the environment on which it is deployed uses the correct "overwrites". Does the Automation API have the logic built in to do this? OR does it do it while BUILDING the environment on a pull request? I just want to make sure all the mechanisms are there so it will work going forward.


- Essientially the story we are working on is the UI story (manual input) for this future one: [[OPEN-1356] Trigger QC API Endpoint - Jira](https://powerfleet.atlassian.net/browse/OPEN-1356 "https://powerfleet.atlassian.net/browse/open-1356")
    

## Questions to team

### Questions vir William

Hey - so paar vinnige vrae:
- API: Run dit al iewers (Eg. dev / int) waar ek dit kan roep of run ek dit net locally: **NEE**
- UI: Waar gaan dit leef? Op een van AWS servers? OF iewers op n SalesForce server? Het ons al n plek om dit te sit? **Nee**, ons moet besluit. Sal beter wees op **AWS** dink ek?
- UI Fields: Jy het gese dis die SalesforceCase class tot en met die Odometer field? Sorry my note le by die huis :-D Tot by **CanConnected**
- AUTH: Roep ons die huidige Config.API auth end-point? Seker? **JA**
- JSON: Het ons al n idee hoe dit moet lyk aan die einde of gaan ons dit vir nou eers kyk hoe dit lyk en dan verder gesels? 
	- [x] William sal **voorbeeld** stuur ✅ 2026-02-06
```json
{  
  "CaseNumber": "XYZ",  
  "GroupId": 1234567890123456,    
  "LegacyOrgId": 1234,  
  "UniqueIdentifier": "3453453453453",  
  "AssetId": 1234567890123456,  
  "DeviceType":"MIX4000",  
  "InstallationDateCompleted": "2025-01-21T05:52:09Z",  
  "FirmwareVersion": "4.6.1",  
  "Odometer": 987654,  
  "DriveMateConnected": false,  
  "IridiumConnected": false,  
  "RoviConnected": false,  
  "DtcoConnected": false,  
  "VideoConnected": false,  
  "CanConnected": false  
}
```
- Kyk hierdie storie: [[OPEN-1356] Trigger QC API Endpoint - Jira](https://powerfleet.atlassian.net/browse/OPEN-1356 "https://powerfleet.atlassian.net/browse/open-1356")
## Steps

- I asked AI if next.js and BLAST would be a good fit.... YES
- I will use firecrawl.dev > playground to get all the brand design
- Got a local repo for OperationsTools
- [x] Should we use the Salesforce or Powerfleet **styling**? ✅ 2026-02-10
	- Extract: Use CSS Peeper on your company’s main portal to get the HEX codes.
	- Mockup: Use html.to.design to pull a Salesforce layout into Figma so your form looks native to the environment.
	- Implement: In your Next.js app, put these colors into your tailwind.config.ts so you can use them as standard classes (e.g., bg-brand-blue).
- 

## DB

```sql
USE Deviceconfiguration;
SELECT TOP 10 * FROM mobileunit.Mobileunits
WHERE UniqueIdentifier = '866561069628406';
SELECT * FROM mobileunit.AssetMobileUnits WHERE MobileUnitKey = 153855;

USE FMONlineDB;
SELECT TOP 10 * FROM dbo.Organisation WHERE liOrgID = 10000;
SELECT TOP 10 * FROM [dynamix].[Organisations] WHERE OrganisationId = 10000;

/*
USE DynaMiX;
SELECT TOP 10 * FROM dbo.Organisation WHERE liOrgID = 10000;
*/
```

## Test Data

**Salesforce Case Details**
Case number: XYZ
Group ID: -5401647754082838271
Legacy Org ID: 10000
Unique identifier: 866561069628406
Asset ID: 1646589414582132736
Device type: MIX4000
Installation date: 2024/02/06
Firmware version: 5.10.12
Odometer: 123456


## Unit Tests

To run these unit tests manually, you can use the 

```
dotnet test
```

 command in your terminal. Here are the most useful ways to run them:

### 1. Run all tests in the project

From any terminal, run:

```powershell
dotnet test "c:\Projects\Powerfleet.Automation\Powerfleet.Automation.Api.UnitTests\Powerfleet.Automation.Logic.UnitTests.csproj"
```

### 2. Run with detailed output

If you want to see exactly which test cases passed without scrolling through noise, add the console logger:

```powershell
dotnet test "c:\Projects\Powerfleet.Automation\Powerfleet.Automation.Api.UnitTests\Powerfleet.Automation.Logic.UnitTests.csproj" --logger:"console;verbosity=normal"
```

### 3. Run only specific tests (Filtering)

If you only want to run the 

QCManager tests (and ignore any others that might be added later):

```powershell
dotnet test "c:\Projects\Powerfleet.Automation\Powerfleet.Automation.Api.UnitTests\Powerfleet.Automation.Logic.UnitTests.csproj" --filter "QCManager"
```

### Tips for IDEs:

- **Visual Studio**: You can open the **Test Explorer** (Test > Test Explorer) and they will show up there for one-click running and debugging.
- **VS Code**: If you have the "C# Dev Kit" extension installed, you can use the **Testing** icon in the left-hand sidebar to run or debug individual tests visually.

## ALL Tests - not all implemented

**CURRENT TESTS (22 tests)**

- Do we have a mobiledevice for the asset installed?  
- Is the unit's raw date >= install date?  
- Is the firmware version on the unit = what the installer confirmed?  
- Is the config upload date >= Install date?  
- Is the unit's config status = Accepted after install date?  
- Are there trips after install date?  
- Does the unit have a valid odometer reading?  
- Is the odometer value >= the expected value?  
- Are there positions for the unit after install date?  
- Does the latest position have a valid GPS fix?  
- Does the latest position have a valid timestamp?  
- Does the latest position have a valid Hdop?  
- Does the latest position have a odometer and is it what is expected?  
- If a video peripheral is installed, is it available on a "line"?  
- If a video peripheral is installed, does it have cameras configured?  
- If DriveMate is enabled, is it available on a "line"?  
- If DriveMate is enabled, are there DriveMate Change Mode events after the install date?  
- If Iridium is installed, is it available on a "line"?  
- If Iridium is installed, does it have an active airtime contract?  
- If Iridium is installed, does it have heartbeat events after install date?  
- If ROVI is installed, is it available on a "line"?  
- If DTCO is installed, is it available on a "line"?

## Code


## REPO

> NEW: https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation.UI

## Branch

> Branch: Config/MR/Feature/OPEN-1493_UI_for_Salesforce_case_Info.INT

## PR

- [x] OPEN-1493 UI for Salesforce case Info > DEV ✅ 2026-02-20
	- [x] API: https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation/pullrequest/138538 ✅ 2026-02-20
	- [x] UI: xxxxxxxxx ✅ 2026-02-20
- [ ] OPEN-1493 UI for Salesforce case Info > INT
- [ ] OPEN-1493 UI for Salesforce case Info > UAT
- [ ] OPEN-1493 UI for Salesforce case Info > PROD

## Deploy

- DEV: 
	- **[http://52.211.2.39:3000](http://52.211.2.39:3000/)** BACKDOOR
	- **[https://powerfleet-automation.dev.mixtelematics.com](https://powerfleet-automation.dev.mixtelematics.com/)** MAIN


The security group was: - [sg-0514f9a34b60d28af](https://eu-west-1.console.aws.amazon.com/vpc/home?region=eu-west-1#SecurityGroup:groupId=sg-0514f9a34b60d28af)

I couldnt figure out the target group:
https://eu-west-1.console.aws.amazon.com/ec2/home?region=eu-west-1#TargetGroups:v=3;$case=tags:false%5C,client:false;$regex=tags:false%5C,client:false

I coulnt find the load balances:
https://eu-west-1.console.aws.amazon.com/ec2/home?region=eu-west-1#LoadBalancers:search=:dev;v=3;$case=tags:false%5C,client:false;$regex=tags:false%5C,client:false

## Debug API

![[Pasted image 20260219153527.png]]

![[Pasted image 20260219153626.png]]


The first image shows what the client looks like at the moment it tries to fins the asset. The second shows where it doesnt find it, thus ending up with the rttot that it cant find it. Does the info look correct? How do I debug this further? Seems like the dev endpoint is not working? not sure


## Verbeteringe

- DEV
	- 1 instance
	- Drop down
		- AU (kan dit inlog op ander API)
		- etc
- Auth > config.api > authentication service
	- dalk users sonder login
- FC Plus