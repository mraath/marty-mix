---
wiki_ingested: 2026-05-28
created: 2025-10-30T15:46
updated: 2025-10-30T15:46
---

```sql
--------------------------------------------------------------------------------
-- T-SQL STORED PROCEDURE COMPARISON HARNESS (Updated for SP Body Execution)
-- Author: Gemini
-- Purpose: Compare execution time and result sets between an Original and 
--          Optimized stored procedure.
--------------------------------------------------------------------------------

-- 1. ENVIRONMENT SETUP
SET NOCOUNT ON;
-- Enable statistics to track I/O and CPU time
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- Define your input parameter here
DECLARE @TargetGroupId BIGINT = 12345; -- <--- UPDATE WITH A REAL GroupId FOR TESTING

-- ==============================================================================
-- TEMPORARY TABLE DEFINITION (Adjust this schema to match your SP's output)
-- NOTE: This template uses a generalized schema based on both your previous SPs.
-- ==============================================================================

IF OBJECT_ID('tempdb..#OriginalResults') IS NOT NULL DROP TABLE #OriginalResults;
IF OBJECT_ID('tempdb..#OptimizedResults') IS NOT NULL DROP TABLE #OptimizedResults;

-- This schema must match the output columns of your stored procedures
CREATE TABLE #OriginalResults (
    -- Shared columns from both SPs
    ConfigurationGroupId BIGINT NOT NULL,
    Flagged INT NULL,
    AssetsCount INT NULL,
    MobileDevice NVARCHAR(50) NULL,
    FWVersion NVARCHAR(MAX) NULL,
    CanScriptLineId NVARCHAR(MAX) NULL,
    CanScript NVARCHAR(MAX) NULL,
    Speed NVARCHAR(250) NULL,
    RPM NVARCHAR(250) NULL,
    Fuel NVARCHAR(250) NULL,
    SP NVARCHAR(250) NULL,
    HOS NVARCHAR(250) NULL,
    -- Columns from the Multiselect SP (include these only if needed)
    ConfigurationGroupName NVARCHAR(250) NULL,
    MobileDeviceTemplateId BIGINT NULL,
    MobileDeviceTemplateName NVARCHAR(250) NULL,
    EventTemplateId BIGINT NULL,
    EventTemplateName NVARCHAR(250) NULL,
    LocationTemplateId BIGINT NULL,
    LocationTemplateName NVARCHAR(250) NULL,
    IsDefault BIT NULL
);

CREATE TABLE #OptimizedResults (
    -- Shared columns from both SPs
    ConfigurationGroupId BIGINT NOT NULL,
    Flagged INT NULL,
    AssetsCount INT NULL,
    MobileDevice NVARCHAR(50) NULL,
    FWVersion NVARCHAR(MAX) NULL,
    CanScriptLineId NVARCHAR(MAX) NULL,
    CanScript NVARCHAR(MAX) NULL,
    Speed NVARCHAR(250) NULL,
    RPM NVARCHAR(250) NULL,
    Fuel NVARCHAR(250) NULL,
    SP NVARCHAR(250) NULL,
    HOS NVARCHAR(250) NULL,
    -- Columns from the Multiselect SP (include these only if needed)
    ConfigurationGroupName NVARCHAR(250) NULL,
    MobileDeviceTemplateId BIGINT NULL,
    MobileDeviceTemplateName NVARCHAR(250) NULL,
    EventTemplateId BIGINT NULL,
    EventTemplateName NVARCHAR(250) NULL,
    LocationTemplateId BIGINT NULL,
    LocationTemplateName NVARCHAR(250) NULL,
    IsDefault BIT NULL
);

-- ==============================================================================
-- 2. ORIGINAL STORED PROCEDURE BODY TEST
-- 
-- PASTE THE BODY OF YOUR ORIGINAL SP HERE, wrapped in a final BEGIN...END:
-- Note: Replace @groupId with @TargetGroupId if you didn't rename the variable.
-- ==============================================================================

PRINT '------------------------------------------------------------------------';
PRINT 'STARTING ORIGINAL SP EXECUTION (Pasted Body)...';
DECLARE @StartTimeOriginal DATETIME = GETDATE();

INSERT INTO #OriginalResults 
BEGIN 
    -- DECLARE any internal variables from the SP body here (e.g., @PreferedFirmwareVersion)
    -- Use @TargetGroupId from the harness instead of @groupId

    -- ---------------------------------------------
    -- PASTE ORIGINAL SP BODY CODE STARTING HERE
    -- ---------------------------------------------

    -- EXAMPLE (If testing the [Template_GetConfigurationGroupsOtherColumns] SP):
    -- DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;
    -- ... all your DECLARE and TABLE variable code ...
    -- SELECT ... all your final SELECT columns ...

    -- ---------------------------------------------
    -- PASTE ORIGINAL SP BODY CODE ENDING HERE
    -- ---------------------------------------------
END

DECLARE @EndTimeOriginal DATETIME = GETDATE();
PRINT 'ORIGINAL SP EXECUTION COMPLETE.';
PRINT 'TIME TAKEN: ' + CAST(DATEDIFF(ms, @StartTimeOriginal, @EndTimeOriginal) AS VARCHAR(20)) + ' ms';

-- ==============================================================================
-- 3. OPTIMIZED STORED PROCEDURE BODY TEST
-- 
-- PASTE THE BODY OF YOUR OPTIMIZED SP HERE, wrapped in a final BEGIN...END:
-- Note: Replace @groupId with @TargetGroupId if you didn't rename the variable.
-- ==============================================================================

PRINT '------------------------------------------------------------------------';
PRINT 'STARTING OPTIMIZED SP EXECUTION (Pasted Body)...';
DECLARE @StartTimeOptimized DATETIME = GETDATE();

INSERT INTO #OptimizedResults 
BEGIN 
    -- DECLARE any internal variables from the SP body here (e.g., @PreferedFirmwareVersion)
    -- Use @TargetGroupId from the harness instead of @groupId
    
    -- ---------------------------------------------
    -- PASTE OPTIMIZED SP BODY CODE STARTING HERE
    -- ---------------------------------------------

    -- EXAMPLE (If testing the [Template_GetConfigurationGroupsOtherColumns] SP):
    -- DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;
    -- ... all your DECLARE and CTE code ...
    -- SELECT ... all your final SELECT columns ...

    -- ---------------------------------------------
    -- PASTE OPTIMIZED SP BODY CODE ENDING HERE
    -- ---------------------------------------------
END

DECLARE @EndTimeOptimized DATETIME = GETDATE();
PRINT 'OPTIMIZED SP EXECUTION COMPLETE.';
PRINT 'TIME TAKEN: ' + CAST(DATEDIFF(ms, @StartTimeOptimized, @EndTimeOptimized) AS VARCHAR(20)) + ' ms';


-- ==============================================================================
-- 4. COMPARISON LOGIC (Checks for exact row-by-row match)
-- ==============================================================================

PRINT '------------------------------------------------------------------------';
PRINT 'STARTING RESULT COMPARISON...';

-- A. Rows returned by ORIGINAL but NOT in OPTIMIZED (Lost Rows)
SELECT 'LOST (Original Only)' AS DifferenceType, *
FROM #OriginalResults
EXCEPT
SELECT 'LOST (Original Only)' AS DifferenceType, *
FROM #OptimizedResults;

-- B. Rows returned by OPTIMIZED but NOT in ORIGINAL (New/Mismatched Rows)
SELECT 'NEW (Optimized Only)' AS DifferenceType, *
FROM #OptimizedResults
EXCEPT
SELECT 'NEW (Optimized Only)' AS DifferenceType, *
FROM #OriginalResults;

PRINT 'RESULT COMPARISON COMPLETE.';
PRINT '------------------------------------------------------------------------';
PRINT 'If the above two result sets are empty, the results are identical.';
PRINT 'Check the MESSAGE tab for "SQL Server parse and compile time" (CPU) and "Table ... scan count" (IO) for true performance metrics.';

-- Clean up
IF OBJECT_ID('tempdb..#OriginalResults') IS NOT NULL DROP TABLE #OriginalResults;
IF OBJECT_ID('tempdb..#OptimizedResults') IS NOT NULL DROP TABLE #OptimizedResults;

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

```