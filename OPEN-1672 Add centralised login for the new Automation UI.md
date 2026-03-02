---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-03-02T10:41
---

# OPEN-1672 Add centralised login for the new Automation UI

Date: 2026-02-24 Time: 11:07
Parent:: ==xxxx==
Friend:: [[2026-02-24]]
JIRA:OPEN-1672 Add centralised login for the new Automation UI
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1672)

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


## CODE

## SP 2

## Branch

> Branch: Config/MR/OPEN-1672_SingularSignup_Automation_UI.INT

## Nuget

MiX.ConfigInternal.Api.Client.2026.6.20260224.2-alpha

## PR

- [ ] OPEN-1672 Add centralised login for the new Automation UI > DEV
- [ ] OPEN-1672 Add centralised login for the new Automation UI > INT
- [ ] OPEN-1672 Add centralised login for the new Automation UI > UAT
- [ ] OPEN-1672 Add centralised login for the new Automation UI > PROD

- [ ] Client: INT: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/139404


## Enhance....

**The simpler approach would be:**

1. Keep the existing 
    Startup.cs, controllers, managers, and service clients **exactly as they were**
2. Only change the **environment detection** in 
    CreateSettings() so it can be influenced by the login selection (e.g., store it and re-initialize when a different environment is selected)
3. Add the login dropdown on the UI side
4. Have the auth flow proxy through to the existing `AuthDataClient` as before

## Notes

- [[Walkthrough - Decommissioning UI & Auth Updates]]
- [[MORE changes for dropdown login environments]]
- [[Walkthrough - Navigation Menu & Decommissioning Placeholder]]
- [[SOP - Implementing Navigation Menu]]

### Technical History & Context (from recent findings)

- **Evolution of Environment Switching:**
    - **Initial Approach:** Global singleton state switch. This was found to be risky in multi-user/parallel request scenarios and led to potential deadlocks or a 500 Internal Server Error when switching.
    - **Refined Approach (Current):** Switched to a **Concurrent Environment Context** model. 
        - [EnvironmentContextManager.cs] manages a `ConcurrentDictionary` of `EnvironmentContext`.
        - Each request (Auth, QC, Decommissioning) passes an `environment` parameter (header `X-Environment` or query param) to retrieve the correct scoped context.
        - Clients and [GlobalSettings] are now scoped per-context, allowing parallel requests to different environments (DEV, INT, AU, etc.) without interference.
- **Bug Fixes:**
    - Fixed compilation errors in `QCManagerTests` due to the [QCManager] constructor now requiring [GlobalSettings] injection.
    - Resolved 500 errors by ensuring `EnvironmentSettingsProvider` doesn't perform blocking global operations during request processing.
- **Relevant Artifacts:**
    - `e418b11d`: Per-Environment Client Instances (Revised Plan & Walkthrough)
    - `b0a4b734`: Multi-Environment Support (Initial Implementation)
    - `a890785e`: Fix Compilation Errors After Multi-Environment Refactor


## Question to Rudolf

Hey daar - ek hoop jy doen nog goed ou!! Voel of ons jare laas gechat het - wel - ons het :-P

SO - ons probeer nou n centralised login doen op AWS - ek dink Jacques het genoem dat julle dit gedoen het....

So ons setup

Op die oomblik het ons n UI deel wat praat moet ons API deel....
... beide le op die config.dev cluster.
Nou het ek ons UI gemaak dat die user kan kies van n dropdown watse environment hy wil gebruik.
Eg. INT, DEV, US, AU...

Als werk mooi tot by ons API.... op die oomblik werk DEV, maar sodra ek probeer INT se config.api toe gaan van ons API (op DEV) dan sien hul nie mekaar nie. Ekt besef dit gaan oor n local setting in die ek dink LB of TG. Ekt toe gegoogle en iets gelees van n bridge wat mens opstel dan kan ek van ons DEV na die INT een chat.

Dis hoe ver ek is - maar dit ignoreer my steeds.

Het jy n goeie vertrekpunt verder? Hoe doen julle die single signin tot multiple orgs?

Hier is van ons info - as jy dit WIL sien en as dit sal help:

DEV UI:

| Component           | Details                                        |
| ------------------- | ---------------------------------------------- |
| **ECS Cluster**     | `DEV-Config`                                   |
| **ECS Service**     | `dev-powerfleet-automation-ui` (1/1 running ✅) |
| **Task Definition** | `dev-powerfleet-automation-ui:1`               |
| **Load Balancer**   | `DEV-Config-ExternalALB` (internet-facing ALB) |
| **Target Group**    | `dev-powerfleet-automation-ui` (HTTP:3000)     |
| **Security Group**  | `sg-0514f9a34b60d28af`                         |
| **Public URLs**     | `automation.dev.mixtelematics.com`             |

DEV API:
 
| Component           | Details                                        |
| ------------------- | ---------------------------------------------- |
| **ECS Cluster**     | `DEV-Config`                                   |
| **ECS Service**     | `dev-powerfleet-automation-ui` (1/1 running ✅) |
| **Task Definition** | `dev-powerfleet-automation-ui:1`               |
| **Load Balancer**   | `DEV-Config-ExternalALB` (internet-facing ALB) |
| **Target Group**    | `dev-powerfleet-automation-ui` (HTTP:3000)     |
| **Security Group**  | `sg-0514f9a34b60d28af`                         |
| **Public URLs**     | `automation.dev.mixtelematics.com`             |

## Rudolf reply

Jis! Baie lanklaas gesels ja! ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/30_f.png?v=v83) Gaan nog ok hier... net swamped met alles wat die company gedoen wil he maar nou ja ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/30_f.png?v=v83)

So laat ek net reg verstaan, jy het 'n UI en jy wil die public API wat die UI mee gesels kan switch? Public API nie internal nie?

Ons het nie heeltemal so 'n setup nie. Ons het 'n internal API wat loop op die MiX Shared Services AWS account. Daardie API kan dan Internal <-> internal chat met die authentication API's in die different regions... m.a.w. wat ook in ander AWS accounts is. Vir dit om te kan werk moet cross account policies opgestel word. Ek was nie betrokke met daardie nie, maar die SaaS team sal kan help.

	As julle net die UI wil switch om met 'n ander public API te gesels..... dan weet ek nie hoekom daar 'n issue is nie. Al wat ek kan dink is dat die browser dit blok a.g.v. CORS omdat jul public URLs nie almal op dieselfde domain as die UI is nie. Dit sal explain hoekom Dev <-> Dev werk maar nie Dev -> enigiets anders nie

## Currently adding an AU instance of UI and API

```
OK - we have a successfull DEV environment.  
It has two parts:  
1) UI: https://automation.dev.mixtelematics.com  
2) API: https://automation-api.dev.mixtelematics.com  
  
We now need to do the same setup (both) for the following environment: AU  
  
You have two files that will help:  
1) C:\Projects\marty-mix\Automation Infrastructure Setup Guide.md  
2) C:\Projects\marty-mix\AWS Troubleshooting and Python Learnings.md  
  
I have already signed in with SAML.  
AWS CLI doesnt work so use the python workaround

IF at anytime you struggle on AWS Settings, you can use the AWS Skill to get more related information.
```


## Config API INT

| Component           | Details                                                                            |
| ------------------- | ---------------------------------------------------------------------------------- |
| **ECS Cluster**     | `INT-Config`                                                                       |
| **ECS Service**     | `int-config-api` (2/2 running ✅)                                                   |
| **Task Definition** | `int-config-api:7`                                                                 |
| **Load Balancer**   | `INT-DI-API-ALB` (internal application)                                            |
| **Target Group**    | `int-config-api-TG` (HTTP:80)                                                      |
| **Security Group**  | `sg-09d9e1223188d85ff`                                                             |
| **Public URLs**     | `ecs-api.config.int.priv`, `configapi.int.priv`, `api.config.devicestate.int.priv` |

## Config API AU (manual)

| Component           | Details                                                                                                        |
| ------------------- | -------------------------------------------------------------------------------------------------------------- |
| Account             | operationsmixtelematics (365528985733)<br>MiX-DevOpsAdmin                                                      |
| Region              | Sydney<br>ap-southeast-2                                                                                       |
| **ECS Cluster**     | AU-Config                                                                                                      |
| **ECS Service**     | au-config-api                                                                                                  |
| **Task Definition** | au-config-api:1                                                                                                |
| **Load Balancer**   | AU-Config-InternalALB                                                                                          |
| **Target Group**    | au-config-api-TG (HTTP:80)                                                                                     |
| **Security Group**  | sg-09d97cfc127d25b95                                                                                           |
| **Public URLs**     | ecs-api.config.au.priv, integrate.api.deviceconfig.syd.production.local, api.deviceconfig.syd.production.local |

## Asking AI (steps and auto)

You helped me to setup my Automation API and Automation UI, you then added these help documents:
C:\Projects\marty-mix\Automation Infrastructure Setup Guide.md
C:\Projects\marty-mix\AWS Troubleshooting and Python Learnings.md

Could you give me a step by step way to do this manually on AWS for AU?

First, here are my resulting setup for the two mentioned above:

UI

| Component           | Details                                        |
| ------------------- | ---------------------------------------------- |
| **ECS Cluster**     | `DEV-Config`                                   |
| **ECS Service**     | `dev-powerfleet-automation-ui` (1/1 running ✅) |
| **Task Definition** | `dev-powerfleet-automation-ui:1`               |
| **Load Balancer**   | `DEV-Config-ExternalALB` (internet-facing ALB) |
| **Target Group**    | `dev-powerfleet-automation-ui` (HTTP:3000)     |
| **Security Group**  | `sg-0514f9a34b60d28af`                         |
| **Public URLs**     | `automation.dev.mixtelematics.com`             |

API

| Component           | Details                                        |
| ------------------- | ---------------------------------------------- |
| **ECS Cluster**     | `DEV-Config`                                   |
| **ECS Service**     | `dev-powerfleet-automation-ui` (1/1 running ✅) |
| **Task Definition** | `dev-powerfleet-automation-ui:1`               |
| **Load Balancer**   | `DEV-Config-ExternalALB` (internet-facing ALB) |
| **Target Group**    | `dev-powerfleet-automation-ui` (HTTP:3000)     |
| **Security Group**  | `sg-0514f9a34b60d28af`                         |
| **Public URLs**     | `automation.dev.mixtelematics.com`             |

The above to make use of the config.api on dev to get values....




So I need you to help me setup the above, but for the AU environment.... which will make use of the AU config.api as setup below:

| Component           | Details                                                                                                        |
| ------------------- | -------------------------------------------------------------------------------------------------------------- |
| Account             | operationsmixtelematics (365528985733)<br>MiX-DevOpsAdmin                                                      |
| Region              | Sydney<br>ap-southeast-2                                                                                       |
| **ECS Cluster**     | AU-Config                                                                                                      |
| **ECS Service**     | au-config-api                                                                                                  |
| **Task Definition** | au-config-api:1                                                                                                |
| **Load Balancer**   | AU-Config-InternalALB                                                                                          |
| **Target Group**    | au-config-api-TG (HTTP:80)                                                                                     |
| **Security Group**  | sg-09d97cfc127d25b95                                                                                           |
| **Public URLs**     | ecs-api.config.au.priv, integrate.api.deviceconfig.syd.production.local, api.deviceconfig.syd.production.local |




Please do this for me, if you cant, please give me the step by step how you did the first two mentioned, then I can duplicate it for the AU two,

YEs - I think BEFORE you try to automate it, first just document the step by step you did for the first two, then I can duplicate it as a second phase if you cant automate it.

## xcvxcvxcvxcvxcvxcv

| Component           | UI                              | API                                 |
| ------------------- | ------------------------------- | ----------------------------------- |
| **ECS Cluster**     | AU-Config                       |                                     |
| **ECS Service**     | au-powerfleet-automation-ui     | au-powerfleet-automation-api        |
| **Task Definition** | au-powerfleet-automation-ui     | au-powerfleet-automation-api        |
| **Target Group**    | au-powerfleet-automation-ui     | au-powerfleet-automation-api        |
| **Public URLs**     | automation.au.mixtelematics.com | automation-api.au.mixtelematics.com |
