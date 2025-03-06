
---
status: closed
date: 2023-05-09
comment: 
priority: 8
---

# CONFIG-3703 Make Available Hino OEM

Date: 2023-05-09 Time: 12:21
Parent:: [[Make Available]]
Friend:: [[2023-05-09]]
JIRA:CONFIG-3703 Make Available Hino OEM
[CONFIG-3703 Make Available: Hino OEM - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-3703)

## Message to Paul and Zonika

I've added in the new parameters in order for Hino to be made available without issues.
The one issue I had on deployment was the existing parameter that was in the Hino.
It had a blank Id. I gave it one, but then the deploy would complain about duplicate key constraint.
Only when I deleted this from the DEV DB, did it go through.

![[CONFIG-3703 Make Available Hino OEM Blank Id replaced.png]]

My question now is, will this cause issues on INT, UAT and PROD?
Paul mentioned to see what are on those DBs already.... herewith my results...
(Should I move the Id back to what it was... blank... this feels wrong though and I think Paul mentioned this will cause issues :-))

Findings (They all have the blank one, so I see problems with deployment):
- INT
	- ![[CONFIG-3703 Make Available Hino OEM INT blank.png]]
- UAT
	- ![[CONFIG-3703 Make Available Hino OEM UAT Blank.png]]
- PROD (VIR, won't do all of them)
	- ![[CONFIG-3703 Make Available Hino OEM PROD Blank.png]]



## SQL Used to look for blank Parameter Id

```sql
-- Find out if the DB has the blank Hino Params Id
DECLARE @systemName NVARCHAR(50) = 'MobileDevice.Hino'; --<-- Specify the Device you want to work with

USE DeviceConfiguration;
DECLARE @libId INT = -1; --Default Library

-- DEVICE
DECLARE @deviceKey INT = (SELECT DeviceKey FROM definition.Devices WHERE SYSTEMNAME = @systemName)

-- PARAMS
SELECT ddp.DeviceParameterId, dd.SystemName, dp.ParameterId, dp.SystemName, dp.ActionDefinition, dp.ActionDefinition
FROM definition.DeviceParameters ddp
JOIN definition.Devices dd ON dd.DeviceKey = ddp.DeviceKey
JOIN definition.Parameters dp on dp.ParameterKey = ddp.ParameterKey
WHERE ddp.DeviceKey = @deviceKey

```

## Make available error

- ParameterId:-3731545217573397882  **Error no: 1393173109247610880**

## Error 20230511

- _EXCEPTION_! Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded.
- 

## Description


## SQL Results

-8773503912069575223
-8722384628719264678
-8505014648878721343
-8456574128637028132
-8380423587615480304
-4138506370119513461
-3361659057359657382
-3161730702566266071
-997280659822459764
981729539706373388
6004312178450985728
7168821117511843328
-3690537839026879670
-7959039106706272406
-8883477110877699683
2638979532023225991
-2155824911768570108

## Changes

```xml
			<parameter id="9001488664387336997" parameterId="7168821117511843328" calibrationType="31" info="Engine RPM" />
			<parameter id="4254040777519601705" parameterId="-8773503912069575223" calibrationType="29" info="Road speed" />
			<parameter id="2403394230821147841" parameterId="-8722384628719264678" calibrationType="8" info="In trip (drive)" />
			<parameter id="7965449409990603396" parameterId="-8505014648878721343" calibrationType="29" info="SYSTEM.3AXIS.CORNERING.GFORCE.HIGH" />
			<parameter id="3895986973428816624" parameterId="-8456574128637028132" calibrationType="9" info="CAN.CTVAL" />
			<parameter id="-5973318210331085087" parameterId="-8380423587615480304" info=")" />
			<parameter id="-1276264987808886317" parameterId="-4138506370119513461" calibrationType="8" info="System.IgnitionOn" />
			<parameter id="-606684203301957280" parameterId="-3361659057359657382" calibrationType="29" info="Deceleration" />
			<parameter id="-1984103442201057217" parameterId="-3161730702566266071" calibrationType="9" info="Fuel level" />
			<parameter id="2843971452103599250" parameterId="-997280659822459764" calibrationType="29" info="Acceleration" />
			<parameter id="-8050961434493349318" parameterId="981729539706373388" info="(" />
			<parameter id="-2509914753701397284" parameterId="6004312178450985728" calibrationType="1" default="1" calibration1="7065" value1="9" info="System.PTOEngaged" />
			<parameter id="4430999726476492721" parameterId="-3690537839026879670" calibrationType="9" info="FMS Active Diagnostic Trouble Codes" />
			<parameter id="5103057724911202491" parameterId="-7959039106706272406" calibrationType="9" info="FMS Engine Coolant Temperature" />
			<parameter id="-2504166421345253661" parameterId="-8883477110877699683" calibrationType="9" info="TT: Block 0 Status 11" />
			<parameter id="-7064559512861153458" parameterId="2638979532023225991" calibrationType="9" info="FMS Engine fault" />
			<parameter id="6368517674266908283" parameterId="-2155824911768570108" calibrationType="9" info="In Sub-trip" />
```

## PR

- DEV: [Pull request 83498: Make Available Hino OEM needs some parameters - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/83498)
- Config/MR/CONFIG-3703-Hino
- Config/MR/CONFIG-3703-Hino_INT_NA
- INT: [Pull request 84190: CONFIG-3703: Merge Hino OEM into INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/84190)

## ERROR

- [DS_OLTP_Database - DS_OLTP_Database 2023.05.09-4 - Pipelines (azure.com)](https://dev.azure.com/MiXTelematics/Common/_releaseProgress?_a=release-environment-deployment-group-logs&releaseId=38531&environmentId=239493&deploymentGroupPhaseId=52911)
- 2023-05-09T07:01:31.8288724Z Microsoft.SqlServer.Management.Common.ExecutionFailureException: An exception occurred while executing a Transact-SQL statement or batch. ---> System.Data.SqlClient.SqlException: Cannot insert duplicate key row in object 'definition.DeviceParameters' with unique index 'IX_DeviceKey_ParameterKey'. The duplicate key value is (10129, 398).
- [x] Ask Paul.... Above error happened after I gave this param an id... will this ripple as an error into all existing Hino param definitions out there. Should I revert it to what it was without the id?
- 2023-05-09T07:20:11.0235365Z Microsoft.SqlServer.Management.Common.ExecutionFailureException: An exception occurred while executing a Transact-SQL statement or batch. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column 'EventKey', table 'DeviceConfiguration.library.Events'; column does not allow nulls. UPDATE fails.