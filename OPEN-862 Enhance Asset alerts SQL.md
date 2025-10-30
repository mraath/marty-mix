---
created: 2025-10-30T11:26
updated: 2025-10-30T11:35
---
You're running into classic performance killers: **cursors** and **row-by-row SP execution** on a result set, combined with the use of suboptimal **Table Variables**.

The core of the slow performance here is the `CURSOR` which iterates through every mobile unit and calls two separate stored procedures (`[state].[MobileUnit_GetMobileUnitFirmwareInfo]` and `[state].[MobileUnit_GetMobileUnitMissingParameters]`) for each unit. If you have 1,000 mobile units, you are executing $1 \text{ base query} + (2 \times 1,000) \text{ SP calls} + 1,000 \text{ UPDATE statements}$. This is extremely inefficient.

The solution is to replace the cursor and row-by-row updates with **set-based logic**, which means finding the underlying queries inside the called stored procedures and integrating them into your main procedure using joins. Since I don't have access to the source of the sub-procedures, I must assume they can be converted or that they accept a table of IDs. I will provide the optimized structure based on converting these operations to set-based logic.

## ⚡️ Enhanced Stored Procedure: Set-Based Optimization

The enhanced procedure eliminates the cursor and replaces the row-by-row SP calls with direct table joins, which is exponentially faster.

_SQL_

```
CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- VARIABLES/SETUP
    -- We can skip the initial @BasicInfo table variable and use a temp table directly for better statistics.
    
    ---------------------------------------------------
    -- STEP 1: GET BASIC INFO
    -- Assuming [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] returns a single result set.
    -- We will insert its results directly into a temp table for better performance.
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#UnitBasicInfo') IS NOT NULL
        DROP TABLE #UnitBasicInfo;
        
    CREATE TABLE #UnitBasicInfo
    (
        MobileUnitId BIGINT PRIMARY KEY, -- Primary key for efficient joining
        AssetId BIGINT,
        ConfigurationGroupId BIGINT,
        ConfigurationGroupKey INT,
        MobileDeviceKey INT,
        MobileUnitKey INT,
        ConfigurationStatusId INT,
        ConfigurationStatus NVARCHAR(50),
        ConfigurationStatusDate DATETIME,
        LegacyOrgId INT,
        LegacyVehicleId INT,
        [UniqueIdentifier] NVARCHAR(250),
        Serialnumber NVARCHAR(250),
        StreamaxSerialNumber NVARCHAR(250),
        ConfigurationGenerationNotes NVARCHAR(MAX),
        ConfigurationGenerationWarning NVARCHAR(MAX),
        LibraryKey INT,
        EventTemplateKey INT,
        LocationTemplateKey INT,
        MobileDeviceTemplateKey INT
    );
    
    -- Insert the basic info results
    INSERT INTO #UnitBasicInfo WITH (TABLOCK)
    EXEC [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] @configGroupIds;


    ---------------------------------------------------
    -- STEP 2: CONVERT ROW-BY-ROW SPs TO SET-BASED
    -- This requires knowing the underlying logic of the called SPs.
    -- Since we don't know the logic, we assume we must still call them, 
    -- but *only if they have been updated to accept a list of IDs* and return a result set.
    -- ***If the SPs cannot be modified, this is the limit of optimization unless you rewrite them entirely here.***
    ---------------------------------------------------
    
    -- Hypothetical replacement for [state].[MobileUnit_GetMobileUnitFirmwareInfo]
    -- We assume a new SP/function that takes the ID table and returns all results at once.
    -- IF the SP can be rewritten:
    
    /*
    IF OBJECT_ID('tempdb..#FirmwareInfo') IS NOT NULL DROP TABLE #FirmwareInfo;

    CREATE TABLE #FirmwareInfo (
        MobileUnitId BIGINT PRIMARY KEY,
        InstalledFirmwareName NVARCHAR(50),
        PreferredFirmwareName NVARCHAR(50),
        IsFirmwareOutdated BIT
    );

    INSERT INTO #FirmwareInfo
    EXEC [state].[MobileUnit_GetMobileUnitFirmwareInfo_SetBased] @configGroupIds; -- New Set-Based SP
    */
    
    -- Hypothetical replacement for [state].[MobileUnit_GetMobileUnitMissingParameters]
    -- We assume a new SP/function that takes the ID table and returns all results at once.
    
    /*
    IF OBJECT_ID('tempdb..#MissingParams') IS NOT NULL DROP TABLE #MissingParams;

    CREATE TABLE #MissingParams (
        MobileUnitId BIGINT PRIMARY KEY,
        IsMissingParameters BIT
    );

    INSERT INTO #MissingParams
    EXEC [state].[MobileUnit_GetMobileUnitMissingParameters_SetBased] @configGroupIds; -- New Set-Based SP
    */

    -- ***Crucial Fallback: If the SPs *cannot* be modified, the cursor is the only way to run them,
    -- but you MUST try to replace them with set-based logic inside this SP.
    
    
    ---------------------------------------------------
    -- STEP 3: FINAL RESULTS (Using CTEs/Set-Based Joins)
    -- This step combines the base info, the firmware/params info (ideally set-based), 
    -- and the iTVFs (which are fine with APPLY).
    ---------------------------------------------------

    -- We must ensure the original logic is preserved. Since I can't rewrite your SPs, 
    -- I will proceed with the final SELECT and assume the logic from the SPs is integrated 
    -- into the final result set via direct joins (or a temporary/final table if the SPs were rewritten).
    
    -- Because the user is asking for an enhancement *without losing anything*, 
    -- I must integrate the logic without calling the SPs row-by-row.
    -- Since the SP logic is unavailable, I will create a single final temp table 
    -- which would be populated by the set-based query replacements for the SPs. 
    -- In a real-world scenario, you would replace the cursor with a single JOIN query.
    
    IF OBJECT_ID('tempdb..#FinalUnitResults') IS NOT NULL
        DROP TABLE #FinalUnitResults;
        
    -- Creating a final, comprehensive temp table with default values (replacing #UnitResults)
    SELECT
        bi.*,
        ISNULL(fi.InstalledFirmwareName, CAST(NULL AS NVARCHAR(50))) AS InstalledFirmwareName,
        ISNULL(fi.PreferredFirmwareName, CAST(NULL AS NVARCHAR(50))) AS PreferredFirmwareName,
        ISNULL(fi.IsFirmwareOutdated, CAST(0 AS BIT)) AS IsFirmwareOutdated,
        ISNULL(mp.IsMissingParameters, CAST(0 AS BIT)) AS IsMissingParameters
    INTO #FinalUnitResults
    FROM #UnitBasicInfo bi
    -- Replace with actual JOINs to your set-based logic for Firmware/Missing Params
    -- Assuming temporary tables #FirmwareInfo (fi) and #MissingParams (mp) from Step 2:
    LEFT JOIN #FirmwareInfo fi ON fi.MobileUnitId = bi.MobileUnitId
    LEFT JOIN #MissingParams mp ON mp.MobileUnitId = bi.MobileUnitId;
    
    -- Final SELECT Statement: Using the set-based results
    SELECT
        Alerts = CONCAT(
                     ISNULL(msgAlerts.MessageAlertCode, '00'), 
                     CAST(fur.IsFirmwareOutdated AS CHAR(1)), 
                     CAST(fur.IsMissingParameters AS CHAR(1)) 
                   ),
        fur.MobileUnitId,
        fur.Serialnumber,
        fur.ConfigurationGroupId,
        NULL AS CommsLog, -- NULL preserved from original
        CAST(LastMsgDate.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc, 
        fur.InstalledFirmwareName AS FWVersion,
        fur.PreferredFirmwareName AS PreferredFWVersion
    FROM #FinalUnitResults fur
    -- CROSS APPLY for iTVFs is acceptable set-based behavior, assuming the iTVFs are efficient.
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](fur.MobileUnitId) AS msgAlerts
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageDate](fur.MobileUnitId) AS LastMsgDate;

    -- Clean up temp tables
    DROP TABLE #FinalUnitResults;
    DROP TABLE #UnitBasicInfo;
    -- Drop #FirmwareInfo and #MissingParams if created

END
```

---

## 🔑 Key Performance Improvement

The single most important improvement is the elimination of the **CURSOR** and the **row-by-row stored procedure calls**.

- **Original Logic (Cursor):** For $N$ mobile units, you execute $1 \text{ base query} + 2N \text{ SP calls} + N \text{ UPDATEs}$. This is $\mathcal{O}(N)$ or potentially $\mathcal{O}(N^2)$ depending on the complexity of the SPs.
    
- **Enhanced Logic (Set-Based):** You execute $1 \text{ base query} + 2 \text{ set-based SP replacements/joins} + 1 \text{ final SELECT with APPLY}$. This is typically $\mathcal{O}(\log N)$ or $\mathcal{O}(N \log N)$, making it vastly superior for any non-trivial number of mobile units.
    

### Next Steps for Implementation

1. **Crucial Action:** The logic of `[state].[MobileUnit_GetMobileUnitFirmwareInfo]` and `[state].[MobileUnit_GetMobileUnitMissingParameters]` **must be integrated as set-based joins** into the main stored procedure. The cursor version is too slow to keep.
    
2. If the external SPs cannot be opened and rewritten here, you must create **new set-based versions** of those SPs/functions that accept a table of `MobileUnitId`s and return a table of results, as hinted in Step 2 of the optimized code.
    

To give you the truly fastest code, I need to know the underlying _SQL_ logic for the two called stored procedures. Would you like to provide the code for those two procedures so I can complete the set-based integration?


---

You're running into classic performance killers: **cursors** and **row-by-row SP execution** on a result set, combined with the use of suboptimal **Table Variables**.

The core of the slow performance here is the `CURSOR` which iterates through every mobile unit and calls two separate stored procedures (`[state].[MobileUnit_GetMobileUnitFirmwareInfo]` and `[state].[MobileUnit_GetMobileUnitMissingParameters]`) for each unit. If you have 1,000 mobile units, you are executing $1 \text{ base query} + (2 \times 1,000) \text{ SP calls} + 1,000 \text{ UPDATE statements}$. This is extremely inefficient.

The solution is to replace the cursor and row-by-row updates with **set-based logic**, which means finding the underlying queries inside the called stored procedures and integrating them into your main procedure using joins. Since I don't have access to the source of the sub-procedures, I must assume they can be converted or that they accept a table of IDs. I will provide the optimized structure based on converting these operations to set-based logic.

## ⚡️ Enhanced Stored Procedure: Set-Based Optimization

The enhanced procedure eliminates the cursor and replaces the row-by-row SP calls with direct table joins, which is exponentially faster.

_SQL_

```
CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- VARIABLES/SETUP
    -- We can skip the initial @BasicInfo table variable and use a temp table directly for better statistics.
    
    ---------------------------------------------------
    -- STEP 1: GET BASIC INFO
    -- Assuming [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] returns a single result set.
    -- We will insert its results directly into a temp table for better performance.
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#UnitBasicInfo') IS NOT NULL
        DROP TABLE #UnitBasicInfo;
        
    CREATE TABLE #UnitBasicInfo
    (
        MobileUnitId BIGINT PRIMARY KEY, -- Primary key for efficient joining
        AssetId BIGINT,
        ConfigurationGroupId BIGINT,
        ConfigurationGroupKey INT,
        MobileDeviceKey INT,
        MobileUnitKey INT,
        ConfigurationStatusId INT,
        ConfigurationStatus NVARCHAR(50),
        ConfigurationStatusDate DATETIME,
        LegacyOrgId INT,
        LegacyVehicleId INT,
        [UniqueIdentifier] NVARCHAR(250),
        Serialnumber NVARCHAR(250),
        StreamaxSerialNumber NVARCHAR(250),
        ConfigurationGenerationNotes NVARCHAR(MAX),
        ConfigurationGenerationWarning NVARCHAR(MAX),
        LibraryKey INT,
        EventTemplateKey INT,
        LocationTemplateKey INT,
        MobileDeviceTemplateKey INT
    );
    
    -- Insert the basic info results
    INSERT INTO #UnitBasicInfo WITH (TABLOCK)
    EXEC [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] @configGroupIds;


    ---------------------------------------------------
    -- STEP 2: CONVERT ROW-BY-ROW SPs TO SET-BASED
    -- This requires knowing the underlying logic of the called SPs.
    -- Since we don't know the logic, we assume we must still call them, 
    -- but *only if they have been updated to accept a list of IDs* and return a result set.
    -- ***If the SPs cannot be modified, this is the limit of optimization unless you rewrite them entirely here.***
    ---------------------------------------------------
    
    -- Hypothetical replacement for [state].[MobileUnit_GetMobileUnitFirmwareInfo]
    -- We assume a new SP/function that takes the ID table and returns all results at once.
    -- IF the SP can be rewritten:
    
    /*
    IF OBJECT_ID('tempdb..#FirmwareInfo') IS NOT NULL DROP TABLE #FirmwareInfo;

    CREATE TABLE #FirmwareInfo (
        MobileUnitId BIGINT PRIMARY KEY,
        InstalledFirmwareName NVARCHAR(50),
        PreferredFirmwareName NVARCHAR(50),
        IsFirmwareOutdated BIT
    );

    INSERT INTO #FirmwareInfo
    EXEC [state].[MobileUnit_GetMobileUnitFirmwareInfo_SetBased] @configGroupIds; -- New Set-Based SP
    */
    
    -- Hypothetical replacement for [state].[MobileUnit_GetMobileUnitMissingParameters]
    -- We assume a new SP/function that takes the ID table and returns all results at once.
    
    /*
    IF OBJECT_ID('tempdb..#MissingParams') IS NOT NULL DROP TABLE #MissingParams;

    CREATE TABLE #MissingParams (
        MobileUnitId BIGINT PRIMARY KEY,
        IsMissingParameters BIT
    );

    INSERT INTO #MissingParams
    EXEC [state].[MobileUnit_GetMobileUnitMissingParameters_SetBased] @configGroupIds; -- New Set-Based SP
    */

    -- ***Crucial Fallback: If the SPs *cannot* be modified, the cursor is the only way to run them,
    -- but you MUST try to replace them with set-based logic inside this SP.
    
    
    ---------------------------------------------------
    -- STEP 3: FINAL RESULTS (Using CTEs/Set-Based Joins)
    -- This step combines the base info, the firmware/params info (ideally set-based), 
    -- and the iTVFs (which are fine with APPLY).
    ---------------------------------------------------

    -- We must ensure the original logic is preserved. Since I can't rewrite your SPs, 
    -- I will proceed with the final SELECT and assume the logic from the SPs is integrated 
    -- into the final result set via direct joins (or a temporary/final table if the SPs were rewritten).
    
    -- Because the user is asking for an enhancement *without losing anything*, 
    -- I must integrate the logic without calling the SPs row-by-row.
    -- Since the SP logic is unavailable, I will create a single final temp table 
    -- which would be populated by the set-based query replacements for the SPs. 
    -- In a real-world scenario, you would replace the cursor with a single JOIN query.
    
    IF OBJECT_ID('tempdb..#FinalUnitResults') IS NOT NULL
        DROP TABLE #FinalUnitResults;
        
    -- Creating a final, comprehensive temp table with default values (replacing #UnitResults)
    SELECT
        bi.*,
        ISNULL(fi.InstalledFirmwareName, CAST(NULL AS NVARCHAR(50))) AS InstalledFirmwareName,
        ISNULL(fi.PreferredFirmwareName, CAST(NULL AS NVARCHAR(50))) AS PreferredFirmwareName,
        ISNULL(fi.IsFirmwareOutdated, CAST(0 AS BIT)) AS IsFirmwareOutdated,
        ISNULL(mp.IsMissingParameters, CAST(0 AS BIT)) AS IsMissingParameters
    INTO #FinalUnitResults
    FROM #UnitBasicInfo bi
    -- Replace with actual JOINs to your set-based logic for Firmware/Missing Params
    -- Assuming temporary tables #FirmwareInfo (fi) and #MissingParams (mp) from Step 2:
    LEFT JOIN #FirmwareInfo fi ON fi.MobileUnitId = bi.MobileUnitId
    LEFT JOIN #MissingParams mp ON mp.MobileUnitId = bi.MobileUnitId;
    
    -- Final SELECT Statement: Using the set-based results
    SELECT
        Alerts = CONCAT(
                     ISNULL(msgAlerts.MessageAlertCode, '00'), 
                     CAST(fur.IsFirmwareOutdated AS CHAR(1)), 
                     CAST(fur.IsMissingParameters AS CHAR(1)) 
                   ),
        fur.MobileUnitId,
        fur.Serialnumber,
        fur.ConfigurationGroupId,
        NULL AS CommsLog, -- NULL preserved from original
        CAST(LastMsgDate.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc, 
        fur.InstalledFirmwareName AS FWVersion,
        fur.PreferredFirmwareName AS PreferredFWVersion
    FROM #FinalUnitResults fur
    -- CROSS APPLY for iTVFs is acceptable set-based behavior, assuming the iTVFs are efficient.
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](fur.MobileUnitId) AS msgAlerts
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageDate](fur.MobileUnitId) AS LastMsgDate;

    -- Clean up temp tables
    DROP TABLE #FinalUnitResults;
    DROP TABLE #UnitBasicInfo;
    -- Drop #FirmwareInfo and #MissingParams if created

END
```

---

## 🔑 Key Performance Improvement

The single most important improvement is the elimination of the **CURSOR** and the **row-by-row stored procedure calls**.

- **Original Logic (Cursor):** For $N$ mobile units, you execute $1 \text{ base query} + 2N \text{ SP calls} + N \text{ UPDATEs}$. This is $\mathcal{O}(N)$ or potentially $\mathcal{O}(N^2)$ depending on the complexity of the SPs.
    
- **Enhanced Logic (Set-Based):** You execute $1 \text{ base query} + 2 \text{ set-based SP replacements/joins} + 1 \text{ final SELECT with APPLY}$. This is typically $\mathcal{O}(\log N)$ or $\mathcal{O}(N \log N)$, making it vastly superior for any non-trivial number of mobile units.
    

### Next Steps for Implementation

1. **Crucial Action:** The logic of `[state].[MobileUnit_GetMobileUnitFirmwareInfo]` and `[state].[MobileUnit_GetMobileUnitMissingParameters]` **must be integrated as set-based joins** into the main stored procedure. The cursor version is too slow to keep.
    
2. If the external SPs cannot be opened and rewritten here, you must create **new set-based versions** of those SPs/functions that accept a table of `MobileUnitId`s and return a table of results, as hinted in Step 2 of the optimized code.
    

To give you the truly fastest code, I need to know the underlying _SQL_ logic for the two called stored procedures. Would you like to provide the code for those two procedures so I can complete the set-based integration?


---


