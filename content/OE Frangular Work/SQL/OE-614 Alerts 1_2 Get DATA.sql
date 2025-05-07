USE [DeviceConfiguration.Dataprocessing];

-- Define thresholds and statuses
DECLARE @ConfigAgeThresholdDays INT = 5;
DECLARE @FwAgeThresholdDays INT = 3;

-- Declare variable for input ConfigurationGroupIds
DECLARE @TargetConfigGroupIds dbo.SelectionIds;

-- *** USER INPUT REQUIRED HERE ***
-- Populate with specific ConfigurationGroupIds
INSERT INTO @TargetConfigGroupIds (id) 
VALUES(3744429100126254243), (-2440320943995442748), (-8601070457854353823),(-3751550636977100219),(-188994457358791832),(-3539031602115732476),(-6732880824993784265),(61756661440635962),(5347252666355409446),(-4682479239161263365),(-1508296197039288250),(-8958682396246293176),(-8864395233107620198),(-1325082746264596693),(-4003628735172700822),(-9076606996180062319),(-4717128997316087817),(7972458021988004916),(8815476176116823518),(4919764585535166399),(-7838770298250680961),(-2748008063263561295),(-6935626891522280445),(1490244259299731130),(-4258849611457539337),(159897983233803411),(-6284968178773227668),
(6807629221267997621),(-5322542706332715080),(-5478527828933866162),(-5579545911740947113),(-6151267166848528093),(7417790447252270150),(-3132820852874418386),(-4225283288011955553),(1325911266354511004),(-6300261974712159873),(-2221726257111617269),(6956525315613478272)



-- Declare variable to hold the MobileUnitIds for the target groups
DECLARE @TargetMobileUnitIds TABLE (MobileUnitId BIGINT PRIMARY KEY);

-- Populate the target MobileUnitIds using the TVF
INSERT INTO @TargetMobileUnitIds (MobileUnitId)
SELECT DISTINCT bi.MobileUnitId
FROM [state].[udfGetMobileUnitBasicInfoForConfigGroups](@TargetConfigGroupIds) bi;

-- Now proceed with the message alert logic, filtered by @TargetMobileUnitIds

WITH MessageTypes AS (
    SELECT id = 254 UNION ALL SELECT id = 103 UNION ALL SELECT id = 255
),
KnownGoodStatuses AS (
    SELECT StatusId = 10 UNION ALL SELECT StatusId = 12 UNION ALL SELECT StatusId = 13 UNION ALL
    SELECT StatusId = 25 UNION ALL SELECT StatusId = 28
),
-- Find the latest message of each relevant type for the TARGET MobileUnitIds
LatestMessages AS (
    SELECT
        mum.MobileUnitId,
        mum.MessageSubType,
        mum.CreationDateUtc,
        mum.MessageStatus,
        ROW_NUMBER() OVER (PARTITION BY mum.MobileUnitId, mum.MessageSubType ORDER BY mum.CreationDateUtc DESC) as rn
    FROM [state].[MobileUnitMessage] mum WITH (NOLOCK)
    INNER JOIN MessageTypes mt ON mum.MessageSubType = mt.id
    INNER JOIN @TargetMobileUnitIds tmu ON mum.MobileUnitId = tmu.MobileUnitId -- *** Filter by target units ***
),
-- Evaluate alert conditions for each latest message
AlertConditions AS (
    SELECT
        lm.MobileUnitId,
        lm.MessageSubType,
        lm.CreationDateUtc,
        lm.MessageStatus,
        DATEDIFF(day, lm.CreationDateUtc, GETUTCDATE()) AS MessageAgeDays,
        CASE WHEN kgs.StatusId IS NULL THEN 1 ELSE 0 END AS StatusIsNotGood,
        -- Config/Setting Alert Condition (per message)
        CASE
            WHEN lm.MessageSubType IN (254, 255)
             AND lm.CreationDateUtc < DATEADD(day, -@ConfigAgeThresholdDays, GETUTCDATE())
             AND kgs.StatusId IS NULL -- Status is NOT good
            THEN 1 ELSE 0
        END AS IsConfigTypeAlert,
        -- Firmware Alert Condition (per message)
        CASE
            WHEN lm.MessageSubType = 103
             AND lm.CreationDateUtc < DATEADD(day, -@FwAgeThresholdDays, GETUTCDATE())
             AND kgs.StatusId IS NULL -- Status is NOT good
            THEN 1 ELSE 0
        END AS IsFwTypeAlert
    FROM LatestMessages lm
    LEFT JOIN KnownGoodStatuses kgs ON lm.MessageStatus = kgs.StatusId
    WHERE lm.rn = 1 -- Only the latest message of each type
),
-- Aggregate the alert flags per MobileUnitId
AggregatedAlerts AS (
    SELECT
        MobileUnitId,
        MAX(IsConfigTypeAlert) AS FinalConfigAlertFlag, -- MAX acts as OR for 254/255
        MAX(IsFwTypeAlert) AS FinalFwAlertFlag -- MAX picks the 1 if 103 condition met
    FROM AlertConditions
    GROUP BY MobileUnitId
),
-- Get details for reporting (latest dates/status for each category)
LatestDetails AS (
    SELECT
        MobileUnitId,
        MAX(CASE WHEN MessageSubType IN (254, 255) THEN CreationDateUtc ELSE NULL END) AS LatestConfigMsgDate,
        MAX(CASE WHEN MessageSubType IN (254, 255) THEN MessageStatus ELSE NULL END) AS LatestConfigMsgStatus, -- Note: Status might be from 254 or 255 if both exist
        MAX(CASE WHEN MessageSubType = 103 THEN CreationDateUtc ELSE NULL END) AS LatestFwMsgDate,
        MAX(CASE WHEN MessageSubType = 103 THEN MessageStatus ELSE NULL END) AS LatestFwMsgStatus
    FROM AlertConditions -- Use AlertConditions as it already filtered for rn=1
    GROUP BY MobileUnitId
)
-- Final Output: Combine aggregated flags with details
SELECT
    aa.MobileUnitId,
    CONCAT(CAST(aa.FinalConfigAlertFlag AS CHAR(1)), CAST(aa.FinalFwAlertFlag AS CHAR(1))) AS ExpectedAlertCode,
    -- Add scenario description for clarity
    CASE
        WHEN aa.FinalConfigAlertFlag = 1 AND aa.FinalFwAlertFlag = 1 THEN 'C: Both Alerts'
        WHEN aa.FinalConfigAlertFlag = 1 AND aa.FinalFwAlertFlag = 0 THEN 'A: Config Alert Only'
        WHEN aa.FinalConfigAlertFlag = 0 AND aa.FinalFwAlertFlag = 1 THEN 'B: Firmware Alert Only'
        WHEN aa.FinalConfigAlertFlag = 0 AND aa.FinalFwAlertFlag = 0 THEN
            CASE
                WHEN EXISTS (
                    SELECT 1 FROM AlertConditions ac
                    WHERE ac.MobileUnitId = aa.MobileUnitId
                      AND ac.StatusIsNotGood = 0 -- Status WAS good
                      AND ( (ac.MessageSubType IN (254, 255) AND ac.MessageAgeDays >= @ConfigAgeThresholdDays) OR
                            (ac.MessageSubType = 103 AND ac.MessageAgeDays >= @FwAgeThresholdDays) )
                ) THEN 'D: Old Message(s) with Good Status'
                ELSE 'E: Recent Messages or No Relevant Messages'
            END
        ELSE 'Unknown'
    END AS ScenarioDescription,
    -- Optional: Join back to get ConfigurationGroupId if needed
    -- cgm.ConfigurationGroupId, -- Need to get this mapping if required
    ld.LatestConfigMsgDate,
    ld.LatestConfigMsgStatus,
    ld.LatestFwMsgDate,
    ld.LatestFwMsgStatus,
    aa.FinalConfigAlertFlag,
    aa.FinalFwAlertFlag
FROM AggregatedAlerts aa
LEFT JOIN LatestDetails ld ON aa.MobileUnitId = ld.MobileUnitId
-- Optional: Join to get ConfigurationGroupId if needed
-- LEFT JOIN (SELECT DISTINCT MobileUnitId, ConfigurationGroupId FROM [state].[udfGetMobileUnitBasicInfoForConfigGroups](@TargetConfigGroupIds)) cgm ON aa.MobileUnitId = cgm.MobileUnitId
ORDER BY ScenarioDescription, aa.MobileUnitId;