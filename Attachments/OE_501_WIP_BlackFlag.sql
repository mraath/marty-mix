USE DeviceConfiguration;
DECLARE @groupId BIGINT = 1686880341835301320;

DECLARE @BlackFlagsCount TABLE
(
    ConfigurationGroupId BIGINT, 
    BlackFlagsCount INT
)
INSERT INTO @BlackFlagsCount
SELECT ConfigurationGroupId, COUNT(MobileUnitKey)
FROM
(
    SELECT DISTINCT tcg.ConfigurationGroupId as ConfigurationGroupId, mu.MobileUnitKey as MobileUnitKey
    --COALESCE(events.MobileUnitKey, eventActions.MobileUnitKey, thresholds.MobileUnitKey, devices.MobileUnitKey, params.MobileUnitKey, paramsCan.MobileUnitKey, properties.MobileUnitKey, peripherals.MobileUnitKey) as MobileUnitKey
    FROM library.Libraries l
    INNER JOIN template.ConfigurationGroups tcg WITH (NOLOCK) ON tcg.LibraryKey = l.LibraryKey
    INNER JOIN mobileunit.MobileUnits mu WITH (NOLOCK) ON tcg.ConfigurationGroupKey = mu.ConfigurationGroupKey
    --Overwritten Events
    LEFT JOIN mobileunit.OverridenEvents events WITH (NOLOCK) ON events.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenEventActions eventActions WITH (NOLOCK) ON eventActions.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenEventConditionThresholds thresholds WITH (NOLOCK) ON thresholds.MobileUnitKey = mu.MobileUnitKey
    --Overwritten Device Info
    LEFT JOIN mobileunit.OverridenDevices devices WITH (NOLOCK) ON devices.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenDeviceParameters params WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenCanParameters paramsCan WITH (NOLOCK) ON params.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN mobileunit.OverridenDeviceProperties properties WITH (NOLOCK) ON properties.MobileUnitKey = mu.MobileUnitKey and properties.PersistOnReset = 0
    LEFT JOIN mobileunit.OverridenPeripheralDevices peripherals WITH (NOLOCK) ON peripherals.MobileUnitKey = mu.MobileUnitKey
    WHERE l.GroupId = @groupId
    AND (
        events.MobileUnitKey IS NOT NULL
        OR eventActions.MobileUnitKey IS NOT NULL
        OR thresholds.MobileUnitKey IS NOT NULL
        OR devices.MobileUnitKey IS NOT NULL
        OR params.MobileUnitKey IS NOT NULL
        OR paramsCan.MobileUnitKey IS NOT NULL
        OR properties.MobileUnitKey IS NOT NULL
        OR peripherals.MobileUnitKey IS NOT NULL
    )
) AS uniqueRows
GROUP BY ConfigurationGroupId

SELECT * FROM @BlackFlagsCount
