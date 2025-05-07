---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-07T12:38
---

# OE-611 Alert not adjusting when removing missing parameters

Date: 2025-02-25 Time: 09:57
Parent:: [[OE-515 Alerts Column Assets Panel]]
Friend:: [[2025-02-25]]
JIRA:OE-611 Alert not adjusting when removing missing parameters
[OE-611 Alert not updating as expected when an event with missing parameters is removed from the event template - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-611)


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

### This one should have NO missing parameters

Config Groups Beta values

![[OE-611 Alert not adjusting when removing missing parameters.png]]

- CG values: [MiX Telematics - Configuration groups](https://integration.mixtelematics.com/#/config-admin/configuration-groups/edit?id=-2440320943995442748)
- -2440320943995442748

- Asset Id: [MiX Telematics - Configuration groups](https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=1631447698450665472)
- 1631447698450665472

Asset Template

![[OE-611 Alert not adjusting when removing missing parameters Not missing.png]]


Looking at the original Template

![[OE-611 Alert not adjusting when removing missing parameters Original Template.png]]

### This one SHOULD have missing parameters

![[OE-611 Alert not adjusting when removing missing parameters Overview.png]]

CG: 3744429100126254243
AssetId: -3958977241595557833


![[OE-611 Alert not adjusting when removing missing parameters yes.png]]

**FE**:

URL: https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=-3958977241595557833
AssetEventListTemplate.html
module.getAssetEvents

**BE**

MobileUnitEventsModule.ModuleRoutes.GET_EVENTS
GetEventTemplate
	mobileUnitManager.GetEffectiveConfig(mobileUnit, mobileDeviceTemplate, eventTemplate)
		resolvedMobileDevie = GetResolvedMobileDevice(mobileUnit, tempalteAggregate
		GetEffectiveConfig(mobileUnit, eventTemplateAggregate, resolvedMobileDevie)
			eventTemplate = ConfigAdminRepository.GetEventTemplateWithChildrenById(configGroup.EventTemplateId)
			GetEffectiveConfig(mobielUnitAggregate, eventTemplate, resolvedMobileDevice)

[[Parameter]]

![[SQL Schemas#Parameters]]

## Files

- C:\Projects\_MiXTelematicsFiles\SQL\OE-611 Missing Params Test.sql

## Findings

- Looking at the inner SELECT in @assetsMissingParameters, I can see none of the event have supported Params
- Look at the supportive params next (@AllSupportedParameters)........ xxxxxxxxxxxxxxx

## RETEST

- OK - so this reverts some changes for OE-614
- We need to retest OE-614

## Reworking all of this

[[Alerts with AI]]

## Comparing the refactored work

> C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare.sql

### Fixing up: First Alerts

[[ AI Alerts Feedback 1]]
- [ ] We'll remember to add the correct status filtering back later once you provide the list.

[[AI FW Versions]]

## Broke it up in sections to test rather

### Base Info

- New Function: C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Functions\udfGetMobileUnitBasicInfoForConfigGroups.sql
- ==Test==: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare BASICS.sql

### Alerts 1 and 2

- First train what it should be looking at...
- Then test the two results
- Story:
	- Assets in config Upload requested state for more than 5 days
	- Assets in FW upload requested state for more than 3 days
	- [[SQL Message Statuses]]
- Function: C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Functions\udfGetMobileUnitMessageAlerts.sql
- Test cases:
	- **Scenario A (Config Alert):** A unit whose _latest_ message of type 254 or 255 is older than 5 days AND has a status NOT IN (10, 12, 13, 25, 28). (Expected output: '10' or '11')
	- **Scenario B (Firmware Alert):** A unit whose _latest_ message of type 103 is older than 3 days AND has a status NOT IN (10, 12, 13, 25, 28). (Expected output: '01' or '11')
	- **Scenario C (Both Alerts):** A unit meeting conditions for both Scenario A and Scenario B. (Expected output: '11')
	- **Scenario D (Old but Good Status):** A unit whose latest relevant message(s) are older than the thresholds BUT have a status IN (10, 12, 13, 25, 28). (Expected output: '00')
	- **Scenario E (Recent / No Relevant Messages):** A unit whose latest relevant messages are recent OR has no relevant messages at all. (Expected output: '00')
- ==TEST 1==: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2.sql
- ==Test Many==: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2 BULK.sql
	- AssetId: 1596635336800804864 (FW Expired)

### Alert 3

- uspGetMobileUnitFirmwareInfo

Since this is a stored procedure with output parameters, testing involves:

1. **Choosing Test Cases:** Select `MobileUnitId`s that represent different firmware scenarios (e.g., up-to-date, outdated, overridden preferred version, different device types like FMBas/non-FMBas, CAN incompatible/compatible).
	- [x] up-to-date, ✅ 2025-04-10
	- [x] outdated, ✅ 2025-04-10
	- [x] overridden preferred version, ✅ 2025-04-10
	- [x] different device types like FMBas ✅ 2025-04-10
	- [x] /non-FMBas, ✅ 2025-04-10
	- [x] CAN incompatible ✅ 2025-04-10
	- [x] /compatible ✅ 2025-04-10
2. **Gathering Inputs:** For each test `MobileUnitId`, you need to find its corresponding `MobileUnitKey`, `MobileDeviceKey`, `LibraryKey`, and `MobileDeviceTemplateKey`. You can get these from the `udfGetMobileUnitBasicInfoForConfigGroups` function or by querying the base tables directly.
3. **Manually Calculating Expected Output:** This is the most involved part. For a given test case, you would need to manually trace the logic within `uspGetMobileUnitFirmwareInfo`:
    - [ ] Find the installed firmware name (`state.MobileUnitState`).
    - [ ] Find the preferred firmware name (checking template properties and overrides).
    - [ ] Determine the device's FMBas/CAN status based on the template's `MobileDeviceKey`.
    - [ ] Identify the relevant set of available firmware versions based on type and library, applying filters.
    - [ ] Order the available versions by name, assign sequence numbers.
    - [ ] Compare the installed version's sequence number to the latest available sequence number to determine the expected `IsFirmwareOutdated` flag (0 or 1).
4. **Executing the Stored Procedure:** Run the SP with the inputs gathered in step 2.
5. **Comparing Results:** Compare the values returned in the SP's output parameters (`@InstalledFirmwareName`, `@PreferredFirmwareName`, `@IsFirmwareOutdated`) with the expected values calculated in step 3.

- ==Toets==: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 3.sql
- [ ] Look at results for assets and double check version number order with Zonika or Nicole

- [ ] Test to be resolved: 1519091697465741312
	- It shows an installed version which isnt even in the list shown in the test stored proc
	- one of them will be wrong
- [ ] business logic question: If a unit reports having a firmware version installed that is _not recognized_ or _not available_ within its current library/configuration context, should it be flagged as outdated?
- [ ] Should we test against PREFERRED or INSTALLED being outdated
- [ ] ARE WE?

### Alert 4

- udfIsMobileUnitMissingParameters
- ==Toets==: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 4 Missing Params.sql

**Alert Digit 4 (Missing Parameters)**, calculated by `[state].[udfIsMobileUnitMissingParameters]`.

We need to verify if this function correctly identifies situations where an enabled event requires a parameter that is not supported by the mobile unit's configured devices.

**Testing Approach:**

1. **Choose Test Cases:** Select `MobileUnitId`s representing:
    - A unit where all required event parameters _are_ supported (Expected output: `IsMissingParameters = 0`).
    - A unit where at least one _required_ parameter for an _enabled_ event is _not_ supported by the configured devices (Expected output: `IsMissingParameters = 1`).
    - Consider edge cases like peripheral-based events (EventType = 10) or events with overrides.
2. **Gather Inputs:** For each test `MobileUnitId`, find its `MobileUnitKey`, `MobileDeviceKey`, `LibraryKey`, and `EventTemplateKey` (using `udfGetMobileUnitBasicInfoForConfigGroups` is easiest).
3. **Manually Verify Expected Output:** This involves replicating the function's logic:
    - Identify all enabled devices for the unit's template (`TemplateDevices` CTE).
    - Identify all parameters supported by those devices in the library context (`AllSupportedParameters` CTE).
    - Identify all enabled events for the unit's template/overrides.
    - For each enabled event, check its required condition parameters (`template.EventConditions` where `IsRequired = 1`).
    - Determine if any required parameter is _not_ in the `AllSupportedParameters` list. Also check if at least one parameter _is_ supported and if it's a peripheral event.
    - Apply the final logic: flag '1' if `RequiredConditionParameterMissing = 1 AND AtLeastOneParameterMonitored = 0 AND IsPeripheralBasedEvent = 0` for any event.
4. **Execute the Function:** Call `udfIsMobileUnitMissingParameters` with the inputs.
5. **Compare:** Compare the function's output (`IsMissingParameters`) with your manually determined expected value.

To help with Step 3 (Manual Verification), here's a query that breaks down the logic for a specific test case:

Putting this alert into words.

  --conditionParam
      -- + !supportedParam + eventConditionRequired > requiredConditionParameterMissing << NOT MONITORED                                      [FINE]
      -- + supportedParam               > atLeastOneParameterMonitored = true                                                     [FINE]
    --  (!requiredConditionParameterMissing && eventEnabled && (atLeastOneParameterMonitored || peripheralBasedEvent)) > MonitoredEvents       [FINE]
- If there is no supported Parameter, but the eventcondition requires it, the the required condition parameter is missing and the "not monitored" should happen.
- If there is a supported parameter, and at least one parameter is monitored, then is is OK
- if there is not requiredConditionParameterMissing && eventEnabled && (atLeastOneParameterMonitored OR peripheralBasedEvent)) then it is monitored
- TESTED: Bench units and AMy Bench Units
	- NEed more info....
- NA: MiX Vision > Event types seems to be missing from sql call
- Should have missing parameter: 
	- 1403102293298126848
	- 1450923827225116672
	- 1415760817642536960
	- 1450923827225116672
	- ?? 1606749708247756800
		- End of trip state of charge Not monitored - Missing parameters
		- Start of trip state of charge Not monitored - Missing parameters
	- ?? 1522731665984569344
	- 1444029372907753472
	- 1606679698413109248
- Shouldnt have: 
	- 1626018637366906880
	- 1596635336800804864
	- 1626018637366906880
	- 1631447698450665472

[[Missing Parameters Logic]]
[[Missing Parameters Logic Links to Logic]]
[[MissingParametersLogicFlow]]

- Ran out of credits... think Cline > gemini
- Moved over to Roo
	- Roo has these questions:
		- NA: Does disabling a peripheral via `OverridenPeripheralDevice` prevent its parameters from being included in `config.AllSupportedParameters`?
		- NA: Is an event excluded from `config.MonitoredEvents` if _any_ required parameter is missing, or only if _all_ parameters are effectively unsupported (matching the SQL's `AtLeastOneParameterMonitored = 0`)?
		- NA: Is the exclusion of `EventType = 10` in the SQL correct for the "Missing Parameters" alert's definition?
	- Gave it the links to logic... came up with a good assessment and gameplan...
		- [x] Are we sure about the eventType 10 being excluded when looking at the code? You mentioned: "1. **Set Final Flag:** If _any_ enabled event (excluding `EventType = 10` as previously decided) was found in step 4 to have a missing required parameter, set `@IsMissingParameters = 1`. Otherwise, set it to `0`." ✅ 2025-04-08
		- [[uspGetMobileUnitMissingParameters_Analysis]]
		- [[Roo Code Code Analysis]]
		- [[Roo Code Why my Original Stored Proc didnt work]]

#### Answers to Roo

- Does disabling a peripheral via `OverridenPeripheralDevice` prevent its parameters from being included in `config.AllSupportedParameters`? I am actually not sure. Let's keep it as is for now.
- Is an event excluded from `config.MonitoredEvents` if _any_ required parameter is missing, or only if _all_ parameters are effectively unsupported (matching the SQL's `AtLeastOneParameterMonitored = 0`)? It should be if ANY paramaters are missing, if I understand the code correctly.
- Is the exclusion of `EventType = 10` in the SQL correct for the "Missing Parameters" alert's definition? I think this is OK, we can change this at a later stage. 

## MORE TESTING

- [[Amy Alerts Test Cases]]
- Alert 1, 2: xxxxxxxxxxxxx
- Alert 3
- Alert 4: Missing parameters
	- Should have ==missing== parameter: 
		- 1403102293298126848
		- 1450923827225116672
		- 1415760817642536960
		- 1606749708247756800
		- 1522731665984569344
		- 1444029372907753472
		- 1606679698413109248
	- Shouldnt have: 
		- 1626018637366906880
		- 1596635336800804864
		- 1626018637366906880
		- 1631447698450665472
	- https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=1606749708247756800

## Moving parts

- Putting it all together
	- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Refactored.sql
	- [x] Basic Info: [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] ✅ 2025-04-09
		- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Functions\ MobileUnit_GetMobileUnitBasicInfoForConfigGroups.sql
	- [x] Last Message: [state].[MobileUnit_GetMobileUnitLastMessageDate] ✅ 2025-04-09
		- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Functions\ MobileUnit_GetMobileUnitLastMessageDate.sql
	- [x] Alert 1 & 2: [state].[MobileUnit_GetMobileUnitMessageAlerts] ✅ 2025-04-09
		- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Functions\ MobileUnit_GetMobileUnitMessageAlerts.sql
	- [x] Alert 3: [state].[MobileUnit_GetMobileUnitFirmwareInfo] ✅ 2025-04-09
		- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetMobileUnitFirmwareInfo.sql
	- [x] Alert 4: [state].[MobileUnit_GetMobileUnitMissingParameters] ✅ 2025-04-09
		- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetMobileUnitMissingParameters.sql

- [x] Rename all the above ✅ 2025-04-09
- [ ] ENSURE deployment to eg. DEV works, seeing above files might not be in .proj file
- [ ] PR To follow: 

[[OE-611 Script to remove all stored procs and functions]]

### No longer needed (DELETED)

- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Functions\udfIsMobileUnitMissingParameters.sql
- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\uspIsMobileUnitMissingParameters.sql

## Testing moving parts

- ALL: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare.sql
- Basic Info: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare BASICS.sql
- Alert 1,2: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2.sql
- Alert 3: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 3.sql
- Alert 4: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 4 Missing Params.sql

## Busy changing over 

- [x] Fix this error: ✅ 2025-04-09
	- I get the following error, I think the way it returns this date is different from the original...
	- **ERROR**: CorrelationId:1646553197155127296|/api/configuration-groups-multiselect/groupId/-5401647754082838271/alerts|04/09/2025 05:13:04|Error:MiX.Core.Clients.HttpRetries+HttpInvalidRequestException: Response status code does not indicate success: 500 ({"ExceptionMessage":"Error parsing column 5 (MessageStatusDateUtc=03/20/2025 12:12:23 \u002B00:00 - Object
	- How can I fix the above error... the new code looks like this file, but seems to fail on : MessageStatusDateUtc
	- C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql
	- The OLD code use to look like this: (The last few lines should explain it)
	- C:\Projects\_MiXTelematicsFiles\SQL\OE-611 OLD FULL MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql

## All of a sudden this no longer works... investigating

- [state].[MobileUnit_GetMobileUnitMissingParameters]
- -8798513244981487643
- 