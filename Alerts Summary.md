---
wiki_ingested: 2026-05-28
created: 2025-04-10T08:43
updated: 2025-04-17T10:24
---

## Four main Alerts

### Alert 1: Assets in config Upload requested state for more than 5 days - Alert 2: Assets in FW upload requested state for more than 3 days

<mark class="hltr-green">SEEMS GREAT</mark>

- Get DATA: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Alerts 1_2 Get DATA.sql
- Get DATA ALL: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Alerts 1_2 Get DATA ALL.sql
- TEST BULK: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2 BULK.sql
- Test Single - More info: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2.sql

[state].[MobileUnit_GetMobileUnitMessageAlerts]

- TEST Ideas For Alert 1:
	- [ ] **Scenario A (Config Alert):** A unit whose _latest_ message of type 254 or 255 is older than 5 days AND has a status NOT IN (10, 12, 13, 25, 28). (Expected output: '10' or '11')
	- [ ] **Scenario D (Old but Good Status):** A unit whose latest relevant message(s) are older than the thresholds BUT have a status IN (10, 12, 13, 25, 28). (Expected output: '00')

- Test Ideas for Alert 2:
	- [ ] **Scenario B (Firmware Alert):** A unit whose _latest_ message of type 103 is older than 3 days AND has a status NOT IN (10, 12, 13, 25, 28). (Expected output: '01' or '11')
	- [ ] **Scenario C (Both Alerts):** A unit meeting conditions for both Scenario A and Scenario B. (Expected output: '11')
	- [ ] **Scenario E (Recent / No Relevant Messages):** A unit whose latest relevant messages are recent OR has no relevant messages at all. (Expected output: '00')
	- [ ] **Scenario D (Old but Good Status):** A unit whose latest relevant message(s) are older than the thresholds BUT have a status IN (10, 12, 13, 25, 28). (Expected output: '00')

- [x] Try these, but change them going forward: ✅ 2025-04-10
	- **Single more explained**: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2.sql
	- **Multiple Compare**: C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2 BULK.sql

- [x] Some questions in OE-623 from Amy regarding Comms log expiring at a different amount of days - have asked Nicole 
	- 3 (spec) 5 (comms) ✅ 2025-04-10
	- **3 DAYS**
	- ![[Alerts Summary FW Outdated 3 days.png]]
	- [[MiX4000 Technical Information V5 1.pdf]]
- https://csojiramixtelematics.atlassian.net/browse/OE-623?focusedCommentId=657100
- AssetId: 1596635336800804864 (FW Expired)

### Alert 3: Preferred FW More than 2 versions old

<mark class="hltr-orange">SOME QUESTIONS</mark>

[state].[MobileUnit_GetMobileUnitFirmwareInfo]
Path: C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetMobileUnitFirmwareInfo.sql

- Select `MobileUnitId`s that represent different firmware scenarios:
	- [ ] up-to-date, 
	- [ ] outdated, 
	- [ ] overridden preferred version, 
	- [ ] different device types like FMBas
	- [ ] /non-FMBas, 
	- [ ] CAN incompatible
	- [ ] /compatible
- I personally don't know if we need to test it so intensely, but it might help
- This one nicely shows the versions, installed and latest
- [ ] CHECK if it should work with the installed or preferred...
- [ ] CHECK if no preferred, should the Alert be 1
	- IF SO, in that section where we test IF it is not nulll...
		- FIRST above this, set it to true, then
		- IF it is not null... default to false...
		- This should fix it
- GET **DATA** to work with:
	- C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Alerts 3 Get DATA to test with.sql
- Test case: 
	- C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 3.sql
- [ ] Double check below with Zonika or Nicole
	- Three questions about Alert 3, FW Preferred Version is more than 2 versions behind:
	  1) Am I correct in assuming the VersionNumber order is correct to determine if it is 2 versions behind.
	  2) Based on the spec I am checking if the Preferred version is outdated, not the installed version.
	  3) Question: IF the preferred FW is blank, should the Alert be raised? Is seems like it should be.

### Alert 4: Missing Parameters

<mark class="hltr-green">SEEMS GREAT</mark>

[state].[MobileUnit_GetMobileUnitMissingParameters]

Have a lot to test already:
```sql
-- ALERT 4: Missing Params

-- Declare a table variable to hold the MobileUnitIds
DECLARE @MobileUnitIds TABLE (
    MobileUnitId BIGINT PRIMARY KEY -- Assuming MobileUnitId is an integer
);

DECLARE @YourResultsTable TABLE (
    MobileUnitId BIGINT, 
    IsMissing BIT
);

-- Declare variables for the loop and the SP output
DECLARE @CurrentMobileUnitId BIGINT;
DECLARE @IsMissingParams BIT; -- Match the data type of the SP output parameter

INSERT INTO @MobileUnitIds (MobileUnitId) VALUES
(1403102293298126848), -- SHOULD
(1450923827225116672),
(1415760817642536960),
(1606749708247756800),
(1522731665984569344),
(1444029372907753472),
(1606679698413109248),
(1626018637366906880), --Shouldnt have
(1596635336800804864),
(1631447698450665472)
--SELECT * FROM @MobileUnitIds

-- Start the loop - continue as long as there are IDs in the table variable
WHILE (SELECT COUNT(*) FROM @MobileUnitIds) > 0
BEGIN
    -- Get the next MobileUnitId to process (simple TOP 1 approach)
    SELECT TOP 1 @CurrentMobileUnitId = MobileUnitId
    FROM @MobileUnitIds
    ORDER BY MobileUnitId; -- Optional: process in a specific order

    EXEC [state].[MobileUnit_GetMobileUnitMissingParameters]
        @MobileUnitId = @CurrentMobileUnitId,
        @IsMissingParameters = @IsMissingParams OUTPUT; -- Capture the output

    IF @IsMissingParams = 1
    BEGIN
        INSERT INTO @YourResultsTable (MobileUnitId, IsMissing) VALUES (@CurrentMobileUnitId, @IsMissingParams);
        PRINT ' -> MobileUnitId ' + CAST(@CurrentMobileUnitId AS VARCHAR(20)) + ' is missing parameters.';
    END
    ELSE
    BEGIN
        INSERT INTO @YourResultsTable (MobileUnitId, IsMissing) VALUES (@CurrentMobileUnitId, @IsMissingParams);
        PRINT ' -> MobileUnitId ' + CAST(@CurrentMobileUnitId AS VARCHAR(20)) + ' has all parameters.';
    END
    -- Remove the processed MobileUnitId from the table variable
    DELETE FROM @MobileUnitIds WHERE MobileUnitId = @CurrentMobileUnitId;
END
SELECT * FROM @YourResultsTable;
```


## Final PR

- [ ] [Pull request 123282: OE-611: Alerts, attempt 1 of.... hopefully 1 - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/123282?path=/DeviceConfiguration.DataProcessing/DeviceConfiguration.DataProcessing.sqlproj)