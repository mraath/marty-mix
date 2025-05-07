-- USED TO TEST THE STORED PROCS

USE [DeviceConfiguration.Dataprocessing];

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

-- **** USER INFO NEEDED ******

INSERT INTO @MobileUnitIds (MobileUnitId) VALUES
(-8798513244981487643),--NEW
(1403102293298126848), -- Should have ==missing== parameter: 
(1450923827225116672),
(1415760817642536960),
(1606749708247756800),
(1522731665984569344),
(1444029372907753472),
(1606679698413109248),
(1626018637366906880), -- Shouldnt have: 
(1596635336800804864),
(1631447698450665472)

/*
(-8798513244981487643),--NEW
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
*/
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



