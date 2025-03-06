---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-02-27T06:45
---

# CONFIG-3988 Configure alerts for new Config Compiler instances

Date: 2023-10-19 Time: 16:36
Parent:: [[Alerts and Alarms]]
Friend:: [[2023-10-19]]
JIRA:CONFIG-3988 Configure alerts for new Config Compiler instances
[CONFIG-3988 Configure alerts for new Config Compiler instances - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-3988)

## Shorter Summary


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

For [[Configuration Compiler]], [[MiX.UnitConfiguration.Generation]] [[Services]] instances are set up.

Under JIRA:SR-16189: , new compiler instances have been added to all non-DS IDCs. These are T-instances as they are optimal for our use case. But in case we have long periods of high CPU usage, we also want to be sure that we are not limited on rate:

- [x] Read original story ✅ 2023-10-20
- [x] Ensure these instances are set to “Unlimited” ✅ 2023-10-20
	- [[How to check an AWS instance has unlimited credit usage]]
- [x] Configure alarms when unlimited credit usage will incur charges ✅ 2023-10-23

## Ensured Service Instances are Set as Unlimited

- Most Servers are under account: 365528985733 (operationsmixtelematics)
	- Otherwise the account is specified below.
- HSUAEAPP21 - **YES**  
	- ![[CONFIG-3988 Configure alerts for new Config Compiler instances Unlimited HSUAEAPP21.png|400]]
- HSVIRAPP43 - **YES**  
	- ![[CONFIG-3988 Configure alerts for new Config Compiler instances HSVIRAPP43 Unlimited.png | 400]]
- HSSYDAPP35 - **YES**  
	- ![[CONFIG-3988 Configure alerts for new Config Compiler instances HSSYDAPP35 Unlimited.png|400]]
- HSCPTAPP36 (i-05d6d6809ef0639d5) - **YES**
	- Account: 668736068906 (mix-cpt-operations)
	- ![[CONFIG-3988 Configure alerts for new Config Compiler instances HSCPTAPP36 Unlimited.png|400]]
- HSENTAPP38 (i-00a9a661735841243) - **YES**  
	- Account: 522301445307 (mixenterprise)
	- ![[CONFIG-3988 Configure alerts for new Config Compiler instances HSENTAPP38 Unlimited.png|400]]
- HSDUBAPP55 - **YES**
	- ![[CONFIG-3988 Configure alerts for new Config Compiler instances HSDUBAPP55 Unlimited.png|400]]

## Set alarms when charges will incur

- For each of our Accounts (3 in this case), I did the following:
	- I went into Metrics > All Metrics
	- Next I searched for: CPUSurplusCreditsCharged
	- Next, select EC2 > Per-Instance Metrics
	- Select the instance name
	- Create Alarm
	- I set up the alarms like this:
		- ![[CONFIG-3988 Configure alerts for new Config Compiler instances Metric Value.png|150]]
		- ![[CONFIG-3988 Configure alerts for new Config Compiler instances Condition.png|150]]
		- They all go to the Config SNS topic

## Summary of Alarms and their names

- HSUAEAPP21 - Done
	- AlarmCPUSurplusCreditsChargedHSUAEAPP21
	- [CloudWatch | me-central-1 (amazon.com)](https://me-central-1.console.aws.amazon.com/cloudwatch/home?region=me-central-1#alarmsV2:alarm/AlarmCPUSurplusCreditsChargedHSUAEAPP21)
- HSVIRAPP43 - Done
	- AlarmCPUSurplusCreditsChargedHSVIRAPP43
	- [CloudWatch | us-east-1 (amazon.com)](https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#alarmsV2:alarm/AlarmCPUSurplusCreditsChargedHSVIRAPP43)
- HSSYDAPP35 - Done
	- AlarmCPUSurplusCreditsCharged HSSYDAPP35
	- [CloudWatch | ap-southeast-2 (amazon.com)](https://ap-southeast-2.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-2#alarmsV2:alarm/AlarmCPUSurplusCreditsCharged+HSSYDAPP35)
- HSCPTAPP36 (i-05d6d6809ef0639d5) - Done
	- AlarmCPUSurplusCreditsChargedHSCPTAPP36
	- [CloudWatch | eu-west-1 (amazon.com)](https://eu-west-1.console.aws.amazon.com/cloudwatch/home?region=eu-west-1#alarmsV2:alarm/AlarmCPUSurplusCreditsChargedHSCPTAPP36)
- HSENTAPP38 (i-00a9a661735841243) - Done
	- AlarmCPUSurplusCreditsChargedHSENTAPP38
	- [CloudWatch | eu-west-1 (amazon.com)](https://eu-west-1.console.aws.amazon.com/cloudwatch/home?region=eu-west-1#alarmsV2:alarm/AlarmCPUSurplusCreditsChargedHSENTAPP38)
- HSDUBAPP55 - Done
	- AlarmCPUSurplusCreditsChargedHSDUBAPP55
	- [CloudWatch | eu-west-1 (amazon.com)](https://eu-west-1.console.aws.amazon.com/cloudwatch/home?region=eu-west-1#alarmsV2:alarm/AlarmCPUSurplusCreditsChargedHSDUBAPP55)

## Expectation from Jira Ticket

- **Configure alarms** when unlimited credit usage will incur **charges** - here is a potential metric that can be monitored:
    - [https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#dashboards/dashboard/Config](https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#dashboards/dashboard/Config "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#dashboards/dashboard/Config")
    - [[CPUSurplusCreditsCharged Metric]]
	- 
    - These alarms should only go to the team, not to SOC.
	    - **SNS**: Opsgenie-DI-Config
	    - **Metric**: CPUSurplusCreditsCharged
	- Alarm Actions
	    - [ ] Should the Alarm action eg. to stop?

Alarm **Name**: AlarmCPUSurplusCreditsCharged XXXX
Alarm **Description**: Send and alarm to Opsgenie-DI-Config when the surplus credit goes above 0 for xxxx
## Finding CPUSurplusCreditsCharged

- Metrics
- Ireland
- Search CPUSurplusCreditsCharged
- EC2 > Per-Instance Metrics
- Search for Instance
- Select
- ![[CONFIG-3988 Configure alerts for new Config Compiler instances Search Metrics.png]]
- Setup
	- See above

## TEMP

i-010b4e0edcccab435 (HSDUBAPP55)
i-06b2c100f2b0df49b (HSUAEAPP21)
i-0de6547c6f93432a3 (HSVIRAPP43)
i-06390ba359935f0b5 (HSSYDAPP35)
i-05d6d6809ef0639d5 (HSCPTAPP36)
i-00a9a661735841243 (HSENTAPP38)

## Change Credit Specification


![[CONFIG-3988 Configure alerts for new Config Compiler instances.png|400]]

## Server List

https://confluence.mixtelematics.com/display/CT/Production

## Server Requirements (SAAS-8321)

- t3a.large (2vCPU,8 GiB Memory)
- MSMQ (including directory service integration)
- .NET 4.7
- Once instance each for US, AU, UK, ENT, UAE and ZA
- Zabbix on all servers for normal service, drive space and memory usage monitoring

## New Hosts created (CR-1918)

- HSUAEAPP21 - Done  
- HSVIRAPP43 - Done  
- HSSYDAPP35 - Done  
- HSCPTAPP36 (i-05d6d6809ef0639d5) - Done  
- HSENTAPP38 (i-00a9a661735841243) - Done  
- HSDUBAPP55 - Done

## Service Status

![[CONFIG-3988 Configure alerts for new Config Compiler instances Service Status.png|700]]




