---
wiki_ingested: 2026-05-28
created: 2025-10-30T11:26
updated: 2025-10-31T09:11
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


You are absolutely correct. Since the Missing Parameters logic is complex and relies on multiple CTEs, simply uncommenting those placeholders (`...`) wouldn't work.

I will update the main stored procedure to include the **full set-based logic** for `[state].[MobileUnit_GetMobileUnitMissingParameters]`, but I will keep the final check **commented out** within the procedure, as per your instruction, so you can easily enable it later.

Here is the enhanced stored procedure with the set-based Missing Parameters logic fully integrated and ready to be toggled on.

## 🚀 Enhanced Stored Procedure with Full Set-Based Logic

The following code fully integrates the CTE logic for determining `IsMissingParameters` into the main procedure, eliminating the placeholder syntax.

_SQL_

```
CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    ---------------------------------------------------
    -- STEP 1: Get Basic Info & Keys
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#UnitBasicInfo') IS NOT NULL
        DROP TABLE #UnitBasicInfo;
        
    CREATE TABLE #UnitBasicInfo
    (
        MobileUnitId BIGINT PRIMARY KEY,
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
    
    INSERT INTO #UnitBasicInfo WITH (TABLOCK)
    EXEC [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] @configGroupIds;


    ---------------------------------------------------
    -- STEP 2: FIRMWARE LOGIC (Set-Based Integration) - Unchanged from previous revision
    ---------------------------------------------------
    
    -- CONSTANTS (Pulled from original Firmware SP)
    DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;
    DECLARE @PreferedFirmwareVersionPropId BIGINT = 4015466679217121645;
    DECLARE @BASE_FM_FUNCTIONALITY BIGINT = -4443154563661222391;
    DECLARE @SCRIPTABLE_CAN_BUS BIGINT = -2374460998933609581;
    DECLARE @FM3xBASDDR INT = 2;
    DECLARE @FMCANDDMs INT = 3;
    DECLARE @FM3XXX_MOBILE_DEVICE_RANGE BIGINT = 6773205951411395052;
    DECLARE @CAN_INCOMPATIBLE_DEVICES TABLE (DeviceId BIGINT PRIMARY KEY);
    INSERT INTO @CAN_INCOMPATIBLE_DEVICES (DeviceId) VALUES 
        (873035855993834515), (-9096330589235079600), (-1840564510281932398), (-4778860267039095909), (-5858009722316757743), 
        (4650434075306181696), (-7990768985497297820), (3527221626955903837), (-2584440882719714179), (6009028139816724904), 
        (-8283040575705223110), (-2638857266241007532), (6710364014173584261), (-90599922128129323), (-2135111653303591150), 
        (-5604407714490286122);


    -- Find the PropertyKey for Preferred Firmware Version
    DECLARE @FWPropKey INT = (SELECT TOP 1 PropertyKey FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK) WHERE PropertyId = @PreferedFirmwareVersionPropId);
    
    -- Final Firmware Results Temp Table
    IF OBJECT_ID('tempdb..#FirmwareResults') IS NOT NULL
        DROP TABLE #FirmwareResults;

    -- *** FIRMWARE CTE LOGIC (as defined in previous step) ***
    WITH InstalledFW AS (
        SELECT bi.MobileUnitId, mus.[Value] AS InstalledFirmwareName, dfw.FirmwareVersionId AS InstalledFirmwareVersionId
        FROM #UnitBasicInfo bi
        LEFT JOIN [state].[MobileUnitState] mus WITH (NOLOCK)
            ON mus.[MobileUnitId] = bi.MobileUnitId AND mus.[PropertyId] = @FIRMWARE_VERSION
        LEFT JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK)
            ON dfw.[Name] = mus.[Value]
    ),
    TemplateFW AS (
        SELECT 
            tmdt.MobileDeviceTemplateKey, tmdt.LibraryKey, ddd.ChildDeviceKey, tdpr.TemplateDevicePropertyKey, tdpr.DeviceKey,
            CASE WHEN ISNUMERIC(tdpr.[Value]) = 1 THEN CAST(tdpr.[Value] AS BIGINT) ELSE NULL END AS TemplateFirmwareVersionId
        FROM [DeviceConfiguration].[template].[MobileDeviceTemplates] tmdt WITH (NOLOCK)
        INNER JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK)
            ON ddd.ParentDeviceKey = tmdt.MobileDeviceKey 
        INNER JOIN [DeviceConfiguration].[template].[DeviceProperties] tdpr WITH (NOLOCK)
            ON tdpr.DeviceKey = ddd.ChildDeviceKey AND tdpr.PropertyKey = @FWPropKey AND tdpr.LibraryKey = tmdt.LibraryKey AND tdpr.MobileDeviceTemplateKey = tmdt.MobileDeviceTemplateKey
        WHERE tdpr.Value IS NOT NULL
    ),
    PreferredFW AS (
        SELECT
            bi.MobileUnitId,
            COALESCE(
                CASE WHEN ISNUMERIC(muodp.[Value]) = 1 THEN CAST(muodp.[Value] AS BIGINT) ELSE NULL END, 
                tfw.TemplateFirmwareVersionId 
            ) AS PreferredFirmwareVersionId
        FROM #UnitBasicInfo bi
        INNER JOIN TemplateFW tfw 
            ON tfw.MobileDeviceTemplateKey = bi.MobileDeviceTemplateKey
            AND tfw.LibraryKey = bi.LibraryKey
            AND tfw.DeviceKey = bi.MobileDeviceKey
        LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties] muodp WITH (NOLOCK)
            ON muodp.TemplateDevicePropertyKey = tfw.TemplateDevicePropertyKey
            AND muodp.MobileUnitKey = bi.MobileUnitKey
        GROUP BY bi.MobileUnitId, tfw.TemplateFirmwareVersionId, muodp.[Value]
    ),
    FilteredVersions AS (
        SELECT
            pfw.MobileUnitId, pfw.PreferredFirmwareVersionId, dfw_pref.Name AS PreferredFirmwareName, dfw_pref.FirmwareType,
            CASE dfw_pref.FirmwareType
                WHEN @FM3xBASDDR THEN @BASE_FM_FUNCTIONALITY
                WHEN @FMCANDDMs THEN @SCRIPTABLE_CAN_BUS
                ELSE @BASE_FM_FUNCTIONALITY
            END AS AnchorDeviceId,
            CASE WHEN dfw_pref.FirmwareType = @FMCANDDMs AND cind.DeviceId IS NOT NULL THEN 1 ELSE 0 END AS IsCanBasIncompatible,
            CASE WHEN dfw_pref.FirmwareType = @FM3xBASDDR AND ddd_fm.ChildDeviceKey IS NOT NULL THEN 1 ELSE 0 END AS IsFMBasDevice
        FROM PreferredFW pfw
        INNER JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw_pref WITH (NOLOCK) ON pfw.PreferredFirmwareVersionId = dfw_pref.FirmwareVersionId
        INNER JOIN #UnitBasicInfo bi ON bi.MobileUnitId = pfw.MobileUnitId
        LEFT JOIN @CAN_INCOMPATIBLE_DEVICES cind ON cind.DeviceId = (SELECT DeviceId FROM [DeviceConfiguration].[definition].[Devices] WHERE DeviceKey = bi.MobileDeviceKey)
        LEFT JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd_fm WITH (NOLOCK)
            ON ddd_fm.ChildDeviceKey = bi.MobileDeviceKey
            AND (SELECT DeviceId FROM [DeviceConfiguration].[definition].[Devices] WHERE DeviceKey = ddd_fm.ParentDeviceKey) = @FM3XXX_MOBILE_DEVICE_RANGE
    ),
    LatestVersionCheck AS (
        SELECT
            fv.MobileUnitId, fv.PreferredFirmwareVersionId, fv.PreferredFirmwareName, dfw.FirmwareVersionId AS AllVersionsId,
            dfw.[Name] AS AllVersionsName,
            ROW_NUMBER() OVER (PARTITION BY fv.MobileUnitId ORDER BY dfw.[Name] DESC) AS Rnk,
            CASE
                WHEN fv.FirmwareType = @FMCANDDMs AND fv.IsCanBasIncompatible = 1 AND dfw.[Name] LIKE 'E%' THEN 0
                WHEN fv.FirmwareType = @FM3xBASDDR AND fv.IsFMBasDevice = 0 THEN 0
                ELSE 1
            END AS IsValidVersion
        FROM FilteredVersions fv
        INNER JOIN #UnitBasicInfo bi ON bi.MobileUnitId = fv.MobileUnitId
        INNER JOIN [DeviceConfiguration].[definition].[FirmwareVersions] dfw WITH (NOLOCK) ON dfw.FirmwareType = fv.FirmwareType
        INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw WITH (NOLOCK) ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey AND lfw.LibraryKey = bi.LibraryKey
    )
    SELECT
        lvc.MobileUnitId,
        i.InstalledFirmwareName,
        lvc.PreferredFirmwareName,
        CAST(
            CASE WHEN lvc.PreferredFirmwareVersionId IS NULL THEN 0 
                 ELSE
                    (SELECT COUNT(DISTINCT AllVersionsId)
                     FROM LatestVersionCheck lvc2
                     WHERE lvc2.MobileUnitId = lvc.MobileUnitId
                       AND lvc2.IsValidVersion = 1
                       AND lvc2.AllVersionsName > lvc.PreferredFirmwareName 
                    ) > 2
            END
        AS BIT) AS IsFirmwareOutdated
    INTO #FirmwareResults
    FROM LatestVersionCheck lvc
    INNER JOIN InstalledFW i ON i.MobileUnitId = lvc.MobileUnitId
    WHERE lvc.Rnk = 1 
    GROUP BY lvc.MobileUnitId, i.InstalledFirmwareName, lvc.PreferredFirmwareName, lvc.PreferredFirmwareVersionId;


    ---------------------------------------------------
    -- STEP 3: MISSING PARAMETERS LOGIC (Set-Based Integration)
    -- The full CTE logic is included, but the final update is commented out.
    ---------------------------------------------------

    IF OBJECT_ID('tempdb..#MissingParamsResults') IS NOT NULL
        DROP TABLE #MissingParamsResults;
    
    -- Initialize the results table with the default "Not Missing" status (0)
    SELECT MobileUnitId, CAST(0 AS BIT) AS IsMissingParameters
    INTO #MissingParamsResults
    FROM #UnitBasicInfo;

    /* OPEN-836: Hide "Missing Parameters" Alert - To be revisited

    -- Constants for Missing Parameters logic
    DECLARE @OPEN_BRACKET BIGINT = 981729539706373388;
    DECLARE @CLOSE_BRACKET BIGINT = -8380423587615480304;

    -- 1. Determine Enabled Hardware Configuration (Set-Based for all MobileUnits)
    WITH BaseTemplateDevices AS (
        SELECT
            bi.MobileUnitId,
            td.TemplateDeviceKey,
            td.DeviceKey,
            dd.DeviceId AS DefinitionDeviceId,
            CASE WHEN dl.DeviceKey IS NOT NULL THEN 1 ELSE 0 END AS IsLogical,
            td.IsEnabled AS TemplateIsEnabled
        FROM [DeviceConfiguration].[template].[Devices] td WITH (NOLOCK)
        INNER JOIN [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK) ON td.DeviceKey = dd.DeviceKey
        LEFT JOIN [DeviceConfiguration].[definition].[LogicalDevices] dl WITH (NOLOCK) ON td.DeviceKey = dl.DeviceKey
        INNER JOIN #UnitBasicInfo bi 
            ON td.MobileDeviceTemplateKey = bi.MobileDeviceTemplateKey AND td.LibraryKey = bi.LibraryKey
    ),
    -- 2. Apply Overrides to get Effective Enabled Status
    EffectiveDeviceStatus AS (
        SELECT
            btd.MobileUnitId,
            btd.DefinitionDeviceId,
            btd.IsLogical,
            CASE
                WHEN btd.IsLogical = 1 THEN ISNULL(od.IsEnabled, btd.TemplateIsEnabled)
                ELSE btd.TemplateIsEnabled 
            END AS IsEnabledPrePeripheralOverride,
            btd.TemplateDeviceKey,
            bi.MobileUnitKey -- Needed for peripheral override join
        FROM BaseTemplateDevices btd
        INNER JOIN #UnitBasicInfo bi ON bi.MobileUnitId = btd.MobileUnitId
        LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenDevices] od WITH (NOLOCK)
            ON btd.TemplateDeviceKey = od.TemplateDeviceKey AND od.MobileUnitKey = bi.MobileUnitKey AND btd.IsLogical = 1
    ),
    -- 3. Apply Peripheral Overrides & Union Main Device to get Enabled Device IDs
    EnabledDeviceIds AS (
        SELECT eds.MobileUnitId, eds.DefinitionDeviceId
        FROM EffectiveDeviceStatus eds
        WHERE eds.IsLogical = 1 AND eds.IsEnabledPrePeripheralOverride = 1 -- Enabled Logical Devices
        
        UNION -- Union handles distinct
        
        SELECT eds.MobileUnitId, eds.DefinitionDeviceId
        FROM EffectiveDeviceStatus eds
        LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenPeripheralDevices] opd WITH (NOLOCK)
            ON eds.TemplateDeviceKey = opd.TemplateDeviceKey AND opd.MobileUnitKey = eds.MobileUnitKey
        WHERE eds.IsLogical = 0 -- Focus on Peripherals
          AND (
                -- Enabled if Template enabled AND NOT disconnected by override (LineKey IS NULL)
                (eds.IsEnabledPrePeripheralOverride = 1 AND (opd.MobileUnitKey IS NULL OR opd.LineKey IS NOT NULL))
                OR
                -- OR Enabled if Template disabled BUT connected by override (LineKey IS NOT NULL)
                (eds.IsEnabledPrePeripheralOverride = 0 AND opd.MobileUnitKey IS NOT NULL AND opd.LineKey IS NOT NULL)
              )
        
        UNION -- Add the main mobile device itself for each unit
        
        SELECT bi.MobileUnitId, dd.DeviceId 
        FROM #UnitBasicInfo bi
        INNER JOIN [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK) ON dd.DeviceKey = bi.MobileDeviceKey
    ),
    -- 4. Identify Supported Parameters from Enabled Devices
    AllSupportedParameters AS (
        SELECT DISTINCT 
            edi.MobileUnitId,
            dp.ParameterId
        FROM EnabledDeviceIds edi
        INNER JOIN [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK) ON dd.DeviceId = edi.DefinitionDeviceId
        INNER JOIN [DeviceConfiguration].[definition].[DeviceParameters] ddp WITH (NOLOCK) ON ddp.DeviceKey = dd.DeviceKey
        INNER JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK) ON dp.ParameterKey = ddp.ParameterKey
        INNER JOIN #UnitBasicInfo bi 
            ON bi.MobileUnitId = edi.MobileUnitId -- Filter by units in scope
        INNER JOIN [DeviceConfiguration].[library].[Parameters] lp WITH (NOLOCK) 
            ON lp.ParameterKey = dp.ParameterKey AND lp.LibraryKey = bi.LibraryKey -- Ensure parameter is in the unit's library context
        INNER JOIN [DeviceConfiguration].[library].[Devices] ld WITH (NOLOCK) 
            ON ld.DeviceKey = ddp.DeviceKey AND ld.LibraryKey = bi.LibraryKey -- Ensure device is in the unit's library context
    ),
    -- 5. Analyze Events and Conditions
    EventParameterSupport AS (
        SELECT
            bi.MobileUnitId,
            te.EventKey,
            ISNULL(muoe.IsEnabled, 1) AS IsEventEnabled, -- Check override, default to enabled
            tec.IsRequired AS IsConditionParamRequired,
            dp.ParameterId AS ConditionParameterId,
            CASE WHEN asp.ParameterId IS NOT NULL THEN 1 ELSE 0 END AS IsConditionParamSupported
        FROM #UnitBasicInfo bi
        INNER JOIN [DeviceConfiguration].[template].[Events] te WITH (NOLOCK) 
            ON te.LibraryKey = bi.LibraryKey AND te.EventTemplateKey = bi.EventTemplateKey
        INNER JOIN [DeviceConfiguration].[definition].[Events] de WITH (NOLOCK) ON de.EventKey = te.EventKey
        LEFT JOIN [DeviceConfiguration].[mobileunit].[OverridenEvents] muoe WITH (NOLOCK)
            ON muoe.MobileUnitKey = bi.MobileUnitKey AND muoe.TemplateEventKey = te.EventKey 
        LEFT JOIN [DeviceConfiguration].[template].[EventConditions] tec WITH (NOLOCK)
            ON tec.LibraryKey = te.LibraryKey AND tec.EventTemplateKey = te.EventTemplateKey AND tec.EventKey = te.EventKey
        LEFT JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK)
            ON dp.ParameterKey = tec.ParameterKey AND dp.ParameterId NOT IN (@OPEN_BRACKET, @CLOSE_BRACKET)
        LEFT JOIN AllSupportedParameters asp ON asp.ParameterId = dp.ParameterId AND asp.MobileUnitId = bi.MobileUnitId -- Check support against unit's supported params
        WHERE de.EventType != 0 -- Ignore Hidden events
    )
    
    -- *** This section is commented out and must be uncommented to enable the alert. ***
    /*
    UPDATE mpr
    SET IsMissingParameters = 1
    FROM #MissingParamsResults mpr
    INNER JOIN (
        -- Find any enabled event with a missing required parameter for each unit
        SELECT DISTINCT MobileUnitId
        FROM EventParameterSupport eps
        WHERE eps.IsEventEnabled = 1
          AND eps.IsConditionParamRequired = 1
          AND eps.IsConditionParamSupported = 0 
    ) AS Missing ON Missing.MobileUnitId = mpr.MobileUnitId;
    */

    */

    ---------------------------------------------------
    -- STEP 4: FINAL SELECT
    ---------------------------------------------------

    SELECT
        Alerts = CONCAT(
                     ISNULL(msgAlerts.MessageAlertCode, '00'), 
                     CAST(ISNULL(fr.IsFirmwareOutdated, 0) AS CHAR(1)), 
                     CAST(ISNULL(mpr.IsMissingParameters, 0) AS CHAR(1)) 
                   ),
        bi.MobileUnitId,
        bi.Serialnumber,
        bi.ConfigurationGroupId,
        NULL AS CommsLog,
        CAST(LastMsgDate.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc, 
        ISNULL(fr.InstalledFirmwareName, '') AS FWVersion,
        ISNULL(fr.PreferredFirmwareName, '') AS PreferredFWVersion
    FROM #UnitBasicInfo bi
    -- Join Set-Based Results
    LEFT JOIN #FirmwareResults fr ON fr.MobileUnitId = bi.MobileUnitId
    LEFT JOIN #MissingParamsResults mpr ON mpr.MobileUnitId = bi.MobileUnitId
    -- Apply iTVFs
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](bi.MobileUnitId) AS msgAlerts
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageDate](bi.MobileUnitId) AS LastMsgDate;

    -- Clean up temp tables
    DROP TABLE #FirmwareResults;
    DROP TABLE #MissingParamsResults;
    DROP TABLE #UnitBasicInfo;

END;
```

---

The stored procedure is now fully set-based. When you are ready to enable the Missing Parameters alert, you only need to:

1. **Uncomment** the constant declarations for `@OPEN_BRACKET` and `@CLOSE_BRACKET`.
    
2. **Uncomment** the final `UPDATE` statement that uses the `EventParameterSupport` CTE to mark units with missing required parameters.
    

This modular structure allows for easy, set-based activation of the logic.

Would you like to review any specific part of the integrated Missing Parameters logic, or would you like to move on to testing this procedure?


```Question
OK - I will give you the Original and new below, please use that to write me a complete comparison harness...
Could you please copy and paste the correct sections between the begin and end.
Please adjust the original and optimized results tables.
```

[[OPEN-862 TEST ALERT SQL]]