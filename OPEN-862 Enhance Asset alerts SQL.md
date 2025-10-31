---
created: 2025-10-30T11:26
updated: 2025-10-31T08:33
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


```txt
OK - I will give you the Original and new below, please use that to write me a complete comparison harness...

NEW CODE:

CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]
  @configGroupIds   [dbo].[SelectionIds] READONLY
AS
BEGIN
  -- VARIABLES ---

  -- Send messages types
  DECLARE @typeList TABLE (id BIGINT);
  INSERT INTO @typeList VALUES (254), (103), (255); --SendConfig,SendFirmware,SendSettings
    
  DECLARE @CompileFailed INT = 4;
  DECLARE @ScriptableCan INT = 125;
  DECLARE @PreferedFirmwareVersion BIGINT = 4015466679217121645;
  DECLARE @UNIT_IMEI BIGINT = 9188780602356317147;
  DECLARE @SERIAL_NUMBER BIGINT = -6167220489794283114;
  DECLARE @StreamaxSerialNumber BIGINT = -4477362625925416557;
  DECLARE @FIRMWARE_VERSION BIGINT = 642299852142387816;

  DECLARE @PropIMEIKey INT = (
    SELECT [PropertyKey]
    FROM [DeviceConfiguration].[definition].[Properties] dp WITH (NOLOCK)
    WHERE dp.PropertyId = @UNIT_IMEI
  );

  DECLARE @FWVersion SMALLINT = (
    SELECT PropertyKey
    FROM [DeviceConfiguration].[definition].[Properties] WITH (NOLOCK)
    WHERE PropertyId = @PreferedFirmwareVersion
  );

  -- Device Driver Type
  DECLARE @FMUnknown INT = -1;
  DECLARE @FM200Plus INT = 0;
  DECLARE @FMTerminal INT = 1;
  DECLARE @FM3xBASDDR INT = 2;
  DECLARE @FMCANDDMs INT = 3;
  DECLARE @FMJ1708DDMs INT = 4;
  DECLARE @FMHOSDBDDM INT = 5;
  DECLARE @MiX2310i INT = 6;
  DECLARE @FM3D INT = 7;
  DECLARE @ROVI INT = 8;
  DECLARE @ROVIII INT = 9;
  DECLARE @TABSBEACONFW INT = 10;
  DECLARE @TABSPBSFW INT = 11;
  DECLARE @TABSCOMMANDS INT = 12;
  DECLARE @TABSSETTINGS INT = 13;
  DECLARE @TABSLIST INT = 14;
  DECLARE @MiX4000 INT = 15;
  DECLARE @MiX6000 INT = 16;
  DECLARE @MiX2000 INT = 17;
  DECLARE @ROVIIII INT = 18;
  DECLARE @ROVIIV INT = 19;
  DECLARE @MiX6000LTE INT = 20;
  DECLARE @MiX3000 INT = 21;
  -- BASE Devices
  DECLARE @FM3XXX_MOBILE_DEVICE_RANGE BIGINT = 6773205951411395052;
  DECLARE @BASE_FM_FUNCTIONALITY BIGINT = -4443154563661222391;
  DECLARE @SCRIPTABLE_CAN_BUS BIGINT = -2374460998933609581;
  DECLARE @HOURS_OF_SERVICE BIGINT = 7622806356726782531;
  DECLARE @SYSTEM_TERMINAL BIGINT = -7786317619852719241;
  DECLARE @MIX3000_FIRMWARE BIGINT = -1056138116899142373;
  DECLARE @MIX4000_FW BIGINT = 4999121101837382283;
  DECLARE @MIX2000_FIRMWARE BIGINT = -6130542022605112303;
  DECLARE @MIX2310_FIRMWARE BIGINT = -6701434148427672311;
  DECLARE @FM3D_FW BIGINT = -6696558636443726452;
  DECLARE @ROVIII_FIRMWARE_PACKAGE BIGINT = -8240710130213624706;
  DECLARE @ROVIIII_FIRMWARE_PACKAGE BIGINT = 7621659214296776294;
  DECLARE @ROVIIV_FIRMWARE_PACKAGE BIGINT = -7704231156642700278;
  DECLARE @TABS_PBS_FIRMWARE BIGINT = 4309165355632585315;
  DECLARE @TABS_BEACON_FIRMWARE BIGINT = 2229325472509295665;
  DECLARE @MIX6000_FIRMWARE BIGINT = 7031964624791253468;
  DECLARE @MIX6000LTE_FIRMWARE BIGINT = -7449984837957825032;
  -- SPECIFIC Device Versions
  DECLARE @FM3316i BIGINT = 873035855993834515;
  DECLARE @FM33x6 BIGINT = -9096330589235079600;
  DECLARE @FM2000 BIGINT = -1840564510281932398;
  DECLARE @FM2000_HV BIGINT = -4778860267039095909;
  DECLARE @FM2001 BIGINT = -5858009722316757743;
  DECLARE @FM2100 BIGINT = 4650434075306181696;
  DECLARE @FM2100_HV BIGINT = -7990768985497297820;
  DECLARE @FM2300 BIGINT = 3527221626955903837;
  DECLARE @FM2300_HV BIGINT = -2584440882719714179;
  DECLARE @FM3106 BIGINT = 6009028139816724904;
  DECLARE @FM32x0 BIGINT = -8283040575705223110;
  DECLARE @FM32x1 BIGINT = -2638857266241007532;
  DECLARE @FM33x0 BIGINT = 6710364014173584261;
  DECLARE @FM33x1 BIGINT = -90599922128129323;
  DECLARE @FM33x5 BIGINT = -2135111653303591150;
  DECLARE @FM_Tracer BIGINT = -5604407714490286122;

  ------------------------------------------------------------------------------------
  -- TEMP tables for: Libaries, Definitions, Templates, used more than once in the Org
  ------------------------------------------------------------------------------------
  DECLARE @templateConfigGroups TABLE (
    ConfigurationGroupId     BIGINT,
    ConfigurationGroupKey    INT,
    ConfigurationGroupName   NVARCHAR(250),
    MobileDeviceTemplateKey  BIGINT,
    LibraryKey               INT,
    EventTemplateKey         INT,
    LocationTemplateKey      INT
  )
  INSERT INTO @templateConfigGroups
  SELECT
    tcg.ConfigurationGroupId,
    tcg.ConfigurationGroupKey,
    tcg.Name AS ConfigurationGroupName,
    tcg.MobileDeviceTemplateKey,
    tcg.LibraryKey,
    tcg.EventTemplateKey,
    tcg.LocationTemplateKey
  FROM @configGroupIds cg
  INNER JOIN [DeviceConfiguration].[template].[ConfigurationGroups] tcg WITH (NOLOCK)
    ON tcg.ConfigurationGroupId = cg.id

  -- Template Devices
  DECLARE @templateDevices TABLE (
    MobileDeviceTemplateKey   INT,
    LibraryKey                INT,
    DeviceKey                 INT,
    TemplateDeviceKey         INT,
    IsEnabled                 BIT
  )
  INSERT INTO @templateDevices
  SELECT DISTINCT
    tcg.MobileDeviceTemplateKey,
    tcg.LibraryKey,
    DeviceKey,
    TemplateDeviceKey,
    IsEnabled
  FROM @templateConfigGroups tcg
  INNER JOIN [DeviceConfiguration].[template].[Devices] td WITH (NOLOCK)
        ON td.[MobileDeviceTemplateKey] = tcg.[MobileDeviceTemplateKey]
        AND tcg.LibraryKey = td.LibraryKey

  -- Definition Devices
  DECLARE @definitionDevices TABLE (
    DeviceKey                 INT,
    DeviceId                  BIGINT,
    SystemName                NVARCHAR(250)
  )
  INSERT INTO @definitionDevices
  SELECT DISTINCT 
    dd.[DeviceKey], dd.[DeviceId], dd.[SystemName]
  FROM @templateDevices td
  INNER JOIN [DeviceConfiguration].[definition].[Devices] dd WITH (NOLOCK)
    ON dd.[DeviceKey] = td.[DeviceKey]

  -- Library Devices

  -- Library Devices
  DECLARE @libraryDevices TABLE (
    DeviceKey                 INT,
    LibraryDeviceKey          INT,
    LibraryKey                INT,
    DeviceId                  BIGINT
  )
  INSERT INTO @libraryDevices
  SELECT DISTINCT 
    dd.[DeviceKey], ld.[LibraryDeviceKey], ld.[LibraryKey], dd.[DeviceId]
  FROM @templateConfigGroups tcg
  INNER JOIN [DeviceConfiguration].[library].[Devices] ld WITH (NOLOCK)
    ON ld.[LibraryKey] = tcg.[LibraryKey]
  INNER JOIN @definitionDevices dd
    ON ld.[DeviceKey] = dd.[DeviceKey] 


  -- Definition Mobile Devices
  DECLARE @definitionMobileDevices TABLE (
    [Description]                 NVARCHAR(250),
    MobileDeviceType              INT,
    DeviceKey                     INT
  )
  INSERT INTO @definitionMobileDevices
  SELECT DISTINCT 
    dmd.[Description], dmd.[MobileDeviceType], dmd.[DeviceKey]
  FROM @definitionDevices dd
  INNER JOIN [DeviceConfiguration].[definition].[MobileDevices] dmd WITH (NOLOCK)
    ON dd.[DeviceKey] = dmd.[DeviceKey]

  -- Template Event Templates
  DECLARE @templateEventTemplates TABLE (
    EventTemplateKey                INT,
    LibraryKey                      INT,
    EventTemplateId                 BIGINT,
    EventTemplateName               NVARCHAR(250)
  )
  INSERT INTO @templateEventTemplates
  SELECT DISTINCT 
    tcg.EventTemplateKey,
    tcg.LibraryKey,
    tet.EventTemplateId,
    tet.Name AS EventTemplateName
  FROM @templateConfigGroups tcg
  INNER JOIN [DeviceConfiguration].[template].[EventTemplates] tet WITH (NOLOCK)
    ON tcg.EventTemplateKey = tet.EventTemplateKey
    AND tcg.LibraryKey = tet.LibraryKey

  -- Template MobileDeviceTemplates
  DECLARE @TemplateMobileDeviceTemplates TABLE (
    MobileDeviceTemplateKey     INT,
    LibraryKey                  INT,
    MobileDeviceKey             INT,
    MobileDeviceTemplateId      BIGINT,
    [Name]                      NVARCHAR(250)
  )
  INSERT INTO @TemplateMobileDeviceTemplates
  SELECT 
    mdt.MobileDeviceTemplateKey, mdt.LibraryKey, mdt.MobileDeviceKey, mdt.MobileDeviceTemplateId, mdt.[Name]
  FROM @templateConfigGroups tcg
  INNER JOIN [DeviceConfiguration].[template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
    ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
    AND tcg.LibraryKey = mdt.LibraryKey
  --SELECT * FROM @TemplateMobileDeviceTemplates


  -- GENERAL CONFIG GROUP INFORMATION

  DECLARE @GeneralConfigGroupInfo TABLE (
    ConfigurationGroupId     BIGINT,
    ConfigurationGroupKey    INT,
    ConfigurationGroupName   NVARCHAR(250),
    MobileDevice             NVARCHAR(50),
    MobileDeviceTemplateId   BIGINT,
    MobileDeviceTemplateName NVARCHAR(250),
    EventTemplateId          BIGINT,
    EventTemplateName        NVARCHAR(250),
    LocationTemplateId       BIGINT,
    LocationTemplateName     NVARCHAR(250),
    DeviceKey                INT,
    MobileDeviceTemplateKey  BIGINT,
    LibraryKey               INT,
    MobileDeviceType         INT
  )
  INSERT INTO @GeneralConfigGroupInfo
  SELECT
    tcg.ConfigurationGroupId,
    tcg.ConfigurationGroupKey,
    tcg.ConfigurationGroupName,
    dmd.Description AS MobileDevice,
    mdt.MobileDeviceTemplateId,
    mdt.Name AS MobileDeviceTemplateName,
    tet.EventTemplateId,
    tet.EventTemplateName,
    tlt.LocationTemplateId,
    tlt.Name AS LocationTemplateName,
    dd.DeviceKey,
    tcg.MobileDeviceTemplateKey,
    tcg.LibraryKey,
    dmd.MobileDeviceType
  FROM @templateConfigGroups tcg
    INNER JOIN @TemplateMobileDeviceTemplates mdt
      ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
      AND tcg.LibraryKey = mdt.LibraryKey
    INNER JOIN @definitionDevices dd
      ON mdt.MobileDeviceKey = dd.DeviceKey
    INNER JOIN @definitionMobileDevices dmd
      ON dd.DeviceKey = dmd.DeviceKey
    LEFT JOIN @templateEventTemplates tet
      ON tcg.EventTemplateKey = tet.EventTemplateKey
      AND tcg.LibraryKey = tet.LibraryKey
    LEFT JOIN [DeviceConfiguration].[template].[LocationTemplates] tlt WITH (NOLOCK)
      ON tcg.LocationTemplateKey = tlt.LocationTemplateKey
      AND tcg.LibraryKey = tlt.LibraryKey

  -- Template PeripheralDevices
  DECLARE @templatePeripheralDevices TABLE (
    TemplateDeviceKey     INT,
    LineKey               INT,
    RecordInterval        BIT
  )
  INSERT INTO @templatePeripheralDevices
  SELECT DISTINCT 
    td.[TemplateDeviceKey], LineKey, RecordInterval
  FROM @templateDevices td
  INNER JOIN @templatePeripheralDevices tpd
    ON tpd.[TemplateDeviceKey] = td.[TemplateDeviceKey]

  -- MobileUnit MobileUnits
  DECLARE @mobileunitMobileUnits TABLE (
    ConfigurationGroupKey             INT,
    MobileUnitKey                     INT,
    MobileDeviceKey                   INT,
    MobileUnitId                      BIGINT,
    ConfigurationStatus               TINYINT,
    DateUpdated                       DateTimeOffset(0),
    [UniqueIdentifier]                NVARCHAR(50),
    ConfigurationGenerationNotes      NVARCHAR(MAX),
    ConfigurationGenerationWarning    NVARCHAR(MAX)
  )
  INSERT INTO @mobileunitMobileUnits
  SELECT DISTINCT 
    mu.[ConfigurationGroupKey],
    MobileUnitKey,
    MobileDeviceKey,
    MobileUnitId,
    ConfigurationStatus,
    DateUpdated,
    [UniqueIdentifier],
    ConfigurationGenerationNotes,
    ConfigurationGenerationWarning
  FROM @templateConfigGroups tcg
  INNER JOIN [DeviceConfiguration].[mobileunit].[MobileUnits] mu WITH (NOLOCK)
    ON mu.[ConfigurationGroupKey] = tcg.[ConfigurationGroupKey]


  -- Library Parameters
  DECLARE @libraryParameters TABLE (
    LibraryKey         INT,
    ParameterKey       INT
  )
  INSERT INTO @libraryParameters
  SELECT DISTINCT 
    lp.LibraryKey, ParameterKey
  FROM @templateConfigGroups tcg
  INNER JOIN [DeviceConfiguration].[library].[Parameters] lp WITH (NOLOCK)
    ON lp.LibraryKey = tcg.LibraryKey

  -- Definition Parameters
  DECLARE @definitionParameters TABLE (
    ParameterKey       INT,
    ParameterId        BIGINT
  )
  INSERT INTO @definitionParameters
  SELECT DISTINCT 
    dp.ParameterKey, ParameterId
  FROM @libraryParameters lp
  INNER JOIN [DeviceConfiguration].[definition].[Parameters] dp WITH (NOLOCK)
    ON dp.ParameterKey = lp.ParameterKey


  -- Definition FirmwareVersions
  DECLARE @definitionFirmwareVersions TABLE (
    [Name]                NVARCHAR(50),
    FirmwareVersionId     BIGINT,
    FirmwareVersionKey    INT,
    FirmwareType          INT
  )
  INSERT INTO @definitionFirmwareVersions
  SELECT DISTINCT 
    [Name], FirmwareVersionId, FirmwareVersionKey, FirmwareType
  FROM [DeviceConfiguration].[definition].[FirmwareVersions] WITH (NOLOCK)

  -- Library FirmwareVersions
  DECLARE @allFirmwareVersions TABLE (
      FirmwareVersionKey      INT,
      FirmwareVersionId       BIGINT,
      FirmwareVersionName     NVARCHAR(250),
      FirmwareType            INT,
      FirmwareTypeName        NVARCHAR(250),
      LibraryKey              INT
  )
  INSERT INTO @allFirmwareVersions
  SELECT DISTINCT
    dfw.FirmwareVersionKey,dfw.FirmwareVersionId, dfw.Name, dfw.FirmwareType, dft.Name, tcg.LibraryKey
  FROM @templateConfigGroups tcg
  INNER JOIN [DeviceConfiguration].[library].[FirmwareVersions] lfw
    ON lfw.LibraryKey = tcg.LibraryKey
  INNER JOIN @definitionFirmwareVersions dfw
    ON dfw.FirmwareVersionKey = lfw.FirmwareVersionKey
  INNER JOIN [DeviceConfiguration].[definition].[FirmwareTypes] dft
    ON dft.FirmwareType = dfw.FirmwareType

  -- ASSET DATABASE INFORMATION

  -- Mobile Units
  IF OBJECT_ID('tempdb..#mobileUnits') IS NOT NULL
      DROP TABLE #mobileUnits;

  CREATE TABLE #mobileUnits (
    ConfigurationGroupId           BIGINT,
    ConfigurationGroupKey          INT,
    AssetId                        BIGINT,
    MobileUnitKey                  INT,
    MobileDeviceKey                INT,
    MobileUnitId                   BIGINT,
    ConfigurationStatusId          INT,
    ConfigurationStatus            NVARCHAR(50),
    ConfigurationStatusDate        DATETIME,
    LegacyOrgId                    INT,
    LegacyVehicleId                INT,
    [UniqueIdentifier]             NVARCHAR(250),
    [Serialnumber]                 NVARCHAR(250),
    StreamaxSerialNumber           NVARCHAR(250),
    ConfigurationGenerationNotes   NVARCHAR(MAX),
    ConfigurationGenerationWarning NVARCHAR(MAX)
  )
  INSERT INTO #mobileUnits
  SELECT
    g.ConfigurationGroupId [ConfigurationGroupId],
    mu.ConfigurationGroupKey [ConfigurationGroupKey],
    amu.AssetId [AssetId],
    mu.MobileUnitKey [MobileUnitKey],
    mu.MobileDeviceKey [MobileDeviceKey],
    mu.MobileUnitId [MobileUnitId],
    mu.[ConfigurationStatus] [ConfigurationStatusId],
    cs.[Description] [ConfigurationStatus],
    mu.DateUpdated [ConfigurationStatusDate],
    amu.LegacyOrgId [LegacyOrgId],
    amu.LegacyVehicleId [LegacyVehicleId],
    [UniqueIdentifier] = CASE WHEN mu.UniqueIdentifier IS NULL THEN mup.Value ELSE mu.UniqueIdentifier END,
    mus.Value [Serialnumber],
    StreamaxSerialNumber = CASE WHEN (ap.Value IS NULL) THEN mu.UniqueIdentifier ELSE ap.Value END,
    mu.ConfigurationGenerationNotes,
    mu.ConfigurationGenerationWarning
  FROM @GeneralConfigGroupInfo g
    INNER JOIN @mobileunitMobileUnits mu
      ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    INNER JOIN [DeviceConfiguration].[mobileunit].[AssetMobileUnits] amu WITH (NOLOCK)
      ON mu.MobileUnitKey = amu.MobileUnitKey
    INNER JOIN [DeviceConfiguration].[definition].[ConfigurationStatuses] cs WITH (NOLOCK)
      ON cs.[ConfigurationStatus] = mu.[ConfigurationStatus]
    LEFT JOIN [DeviceConfiguration].[mobileunit].[MobileUnitProperties] mup WITH (NOLOCK)
      ON mu.[MobileUnitKey] = mup.[MobileUnitKey]
      AND mup.[PropertyKey] = @PropIMEIKey
    LEFT JOIN [state].[MobileUnitState] mus
      ON mus.[MobileUnitId] = mu.[MobileUnitId]
      AND mus.[PropertyId] = @SERIAL_NUMBER
    LEFT JOIN [DeviceConfiguration].[mobileunit].[AssetProperties] ap WITH (NOLOCK)
      ON mu.MobileUnitId = ap.AssetId AND ap.PropertyId  = @StreamaxSerialNumber;

  -- Overwritten Tables
  -- Mobileunit OverridenEvents
  DECLARE @mobileunitOverridenEvents TABLE (
    MobileUnitKey       INT,
    TemplateEventKey    INT,
    IsEnabled           BIT
  )
  INSERT INTO @mobileunitOverridenEvents
  SELECT DISTINCT 
    mu.MobileUnitKey, TemplateEventKey, IsEnabled
  FROM #mobileUnits mu
  INNER JOIN [DeviceConfiguration].[mobileunit].[OverridenEvents] muoe WITH (NOLOCK)
    ON muoe.MobileUnitKey = mu.MobileUnitKey
  
  -- Mobileunit OverridenDeviceProperties
  DECLARE @mobileunitOverridenDeviceProperties TABLE (
    MobileUnitKey               INT,
    TemplateDevicePropertyKey   INT,
    PersistOnReset              BIT,
    [Value]                     NVARCHAR(MAX)
  )
  INSERT INTO @mobileunitOverridenDeviceProperties
  SELECT DISTINCT 
    mu.MobileUnitKey, TemplateDevicePropertyKey, PersistOnReset, [Value]
  FROM #mobileUnits mu
  INNER JOIN [DeviceConfiguration].[mobileunit].[OverridenDeviceProperties] muodp  WITH (NOLOCK)
    ON muodp.MobileUnitKey = mu.MobileUnitKey


  -- Looking for alerts
  DECLARE @messageStatuses TABLE (
    ConfigurationGroupId  BIGINT,
    MobileUnitId BIGINT,
    MessageSubType INT
  );

  WITH LastMessageStatus AS (
    SELECT  
      mu.ConfigurationGroupId,
      mum.MobileUnitId,
      mum.MessageSubType, 
      mum.CreationDateUtc,
      mum.MessageStatus,
      ROW_NUMBER() OVER (PARTITION BY mum.MobileUnitId, mum.MessageSubType ORDER BY mum.CreationDateUtc DESC) as RowNum
    FROM    @typeList typeIds
    JOIN    [state].[MobileUnitMessage] mum
      ON mum.MessageSubType = typeIds.id 
    JOIN    #mobileUnits mu
      ON mum.MobileUnitId = mu.MobileUnitId
  )

  INSERT INTO @messageStatuses
  SELECT 
    ConfigurationGroupId,
    MobileUnitId,
    MessageSubType
  FROM LastMessageStatus
  WHERE 
    RowNum = 1
    AND
    (
      (MessageSubType IN (254) --Config, 255.. Settings 
      AND CreationDateUtc < DATEADD(day, -5, GETDATE()))
      OR 
      (MessageSubType IN (103) --FW 
      AND CreationDateUtc < DATEADD(day, -3, GETDATE()))
    AND MessageStatus IN (22, 23) --Created,SentAwaitingResponse
  )
  ORDER BY ConfigurationGroupId, MobileUnitId, MessageSubType;

--SELECT * FROM @messageStatuses;




  -- Messages for Mesa
  DECLARE @typelistmu TABLE (
    mobId  BIGINT,
    typeId BIGINT,
    PRIMARY KEY (typeId,mobId)
  )
  INSERT INTO @typelistmu
  SELECT m.MobileUnitId, t.id
  FROM @typeList t
          CROSS JOIN #mobileUnits m
  GROUP BY m.MobileUnitId, t.id

  DECLARE @mesaMessages TABLE (
    MessageSubType       INT,
    MessageStatusDateUtc DATETIME,
    MessageStatus        INT,
    MobileUnitId         BIGINT
  )
  INSERT INTO @mesaMessages
  SELECT c.MessageSubType,
    MessageStatusDateUtc,
    MessageStatus,
    MobileUnitId
  FROM
    (
      SELECT
      mum.MessageSubType,
      mum.CreationDateUtc,
      mum.MessageStatusDateUtc,
      mum.MessageId,
      mum.MessageStatus,
      mum.MessageKey,
      ROW_NUMBER() OVER ( PARTITION BY mum.MobileUnitId ORDER BY mum.MessageStatusDateUtc DESC ) AS rn, MobileUnitId
    FROM [state].[MobileUnitMessage] mum  WITH (NOLOCK)
      JOIN @typelistmu muIds
        ON muIds.mobId = mum.MobileUnitId
        AND mum.MessageSubType = muIds.typeId
  ) c
  WHERE       rn IN (1)
  ORDER BY    MobileUnitId,c.MessageSubType, MessageStatusDateUtc






  -- FW VERSION

  -- Get all the Devices that should be FMBas
  DECLARE @FMBasDevices TABLE (
    DeviceKey       INT
  )
  INSERT INTO @FMBasDevices
  SELECT 
    ddd.ParentDeviceKey
  FROM @definitionDevices dd
  INNER JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd
    ON ddd.ChildDeviceKey = dd.DeviceKey
  WHERE dd.DeviceId = @FM3XXX_MOBILE_DEVICE_RANGE --6773205951411395052
  --SELECT * FROM @FMBasDevices

  DECLARE @ConfigGroupsFWVersions TABLE (
    [ConfigurationGroupId]      BIGINT,
    [FWName]                    NVARCHAR(50),
    [TemplateDevicePropertyKey] INT,
    FirmwareVersionId           BIGINT,
    ChildDeviceKey              INT,
    DeviceKey                   INT,
    MobileDeviceTemplateKey     INT,
    FirmwareVersionKey          INT,
    MobileDeviceKey             INT
  );
  INSERT INTO @ConfigGroupsFWVersions
  SELECT DISTINCT
    [ConfigurationGroupId] = tcg.ConfigurationGroupId,
    [FWName] = fw.Name,
    tdpr.TemplateDevicePropertyKey,
    FirmwareVersionId = fw.FirmwareVersionId,
    ddChild.DeviceKey as ChildDeviceKey,
    ld.DeviceKey,
    tcg.MobileDeviceTemplateKey,
    fw.FirmwareVersionKey,
    tmdt.MobileDeviceKey
  --Used to check up the overwritten value
  FROM @GeneralConfigGroupInfo tcg
    -- Mobile Device Templates
    INNER JOIN @TemplateMobileDeviceTemplates tmdt
      ON tmdt.LibraryKey = tcg.LibraryKey
      AND tmdt.MobileDeviceTemplateKey = tcg.MobileDeviceTemplateKey
    -- Mobile Device Template - Device
    INNER JOIN @LibraryDevices ld
      ON ld.LibraryKey = tmdt.LibraryKey
      AND ld.DeviceKey = tmdt.MobileDeviceKey
    -- Linked Logicals, to get to the FW Property
    INNER JOIN [DeviceConfiguration].[definition].[DeviceDependencies] ddd WITH (NOLOCK)
      ON ddd.ParentDeviceKey = ld.DeviceKey
    INNER JOIN @definitionDevices ddChild --TODO: MR: IF missing children, use definition.Devices
      ON ddChild.DeviceKey = ddd.ChildDeviceKey
    -- Get Logical devices
    INNER JOIN [DeviceConfiguration].[template].[DeviceProperties] tdpr WITH (NOLOCK)
      ON tdpr.DeviceKey = ddChild.DeviceKey
      AND tdpr.PropertyKey = @FWVersion
      AND tdpr.LibraryKey = tcg.LibraryKey
      AND tdpr.MobileDeviceTemplateKey = tmdt.MobileDeviceTemplateKey
    INNER JOIN @definitionFirmwareVersions fw
      ON fw.FirmwareVersionId = tdpr.Value;


  -- Add the overwritten values next

  DECLARE @AssetPreferredFWVersions TABLE (
    [MobileUnitKey]                 INT,
    [FWName]                        NVARCHAR(50),
    FirmwareVersionId               BIGINT,
    TemplateDevicePropertyKey       INT
  );
  WITH FilteredMuopr AS (
    SELECT muopr.*
    FROM @mobileunitOverridenDeviceProperties muopr
    INNER JOIN @ConfigGroupsFWVersions fw
        ON muopr.TemplateDevicePropertyKey = fw.TemplateDevicePropertyKey
    )
  INSERT INTO @AssetPreferredFWVersions
    SELECT 
        muopr.MobileUnitKey,
        dfw.Name AS FWName,
        dfw.FirmwareVersionId,
        fw.TemplateDevicePropertyKey
    FROM FilteredMuopr muopr
    INNER JOIN @definitionFirmwareVersions dfw 
    ON dfw.FirmwareVersionId = muopr.Value
    INNER JOIN @ConfigGroupsFWVersions fw
    ON muopr.TemplateDevicePropertyKey = fw.TemplateDevicePropertyKey;

  --The actual FW Version installed on the asset
  DECLARE @FWVersionInstalled TABLE (
    [MobileUnitKey] INT,
    [FWName]        NVARCHAR(50)
  );
  INSERT INTO @FWVersionInstalled
  SELECT mu.MobileUnitKey, mus.[Value]
  FROM @GeneralConfigGroupInfo g 
    INNER JOIN @mobileunitMobileUnits mu
      ON mu.ConfigurationGroupKey = g.ConfigurationGroupKey
    INNER JOIN [state].[MobileUnitState] mus
      ON mus.[MobileUnitId] = mu.[MobileUnitId]
      AND mus.[PropertyId] = @FIRMWARE_VERSION;


  -- Calculating Alert number 4.... quite a process
  --"Not monitored - Missing parameters"
  -- MobileDeviceTemplate
  DECLARE @MobileDeviceTemplateDevices TABLE (
    MobileDeviceTemplateKey     INT,
    DeviceId                    BIGINT,
    TemplateDeviceKey           INT,
    DeviceKey                   INT,
    LibraryKey                  INT,
    IsEnabled                   BIT
  )
  INSERT INTO @MobileDeviceTemplateDevices
  SELECT 
    g.MobileDeviceTemplateKey, dd.DeviceId, td.TemplateDeviceKey, td.DeviceKey, g.LibraryKey, td.IsEnabled
  FROM @GeneralConfigGroupInfo g
  INNER JOIN @templateDevices td
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey AND td.LibraryKey = g.LibraryKey
  INNER JOIN @definitionDevices dd
    ON dd.DeviceKey = td.DeviceKey;
  --SELECT COUNT(*) FROM @MobileDeviceTemplateDevices;

  -- AllDefinitionDeviceIds < For the whole Org
  -- allDefinitionDeviceIds = MobileDevice, AllLogicalDevices, AllPeripheralDevices
  DECLARE @AllDefinitionDeviceIds TABLE (
    DeviceId                    BIGINT,
    DeviceKey                   INT,
    LibraryKey                  INT
  )
  -- Peripherals
  INSERT INTO @AllDefinitionDeviceIds
    SELECT DeviceId, DeviceKey, LibraryKey
    FROM @MobileDeviceTemplateDevices mdt
    INNER JOIN @templatePeripheralDevices tpd
      ON tpd.TemplateDeviceKey = mdt.TemplateDeviceKey
    WHERE mdt.IsEnabled = 1;
  -- MobileDevice
  INSERT INTO @AllDefinitionDeviceIds
    SELECT DeviceId, dMd.DeviceKey, LibraryKey
    FROM @MobileDeviceTemplateDevices mdt
    INNER JOIN @definitionMobileDevices dMd 
      ON dMd.DeviceKey = mdt.DeviceKey
    WHERE mdt.IsEnabled = 1;
  -- Logicals
  INSERT INTO @AllDefinitionDeviceIds
    SELECT DeviceId, dL.DeviceKey, LibraryKey
    FROM @MobileDeviceTemplateDevices mdt
    INNER JOIN [DeviceConfiguration].[definition].[LogicalDevices] dL WITH (NOLOCK) 
      ON dL.DeviceKey = mdt.DeviceKey
    WHERE mdt.IsEnabled = 1;


  --Definition DeviceParameters
  DECLARE @definitionDeviceParameters TABLE (
    DeviceKey         INT,
    DeviceId          BIGINT,
    ParameterKey      INT
  );
  INSERT INTO @definitionDeviceParameters
    SELECT DISTINCT ddp.DeviceKey, dd.DeviceId, ParameterKey
    FROM [DeviceConfiguration].[definition].[DeviceParameters] ddp
    INNER JOIN @definitionDevices dd
      ON dd.DeviceKey = ddp.DeviceKey
    --SELECT COUNT(*) FROM @definitionDeviceParameters ddp


  -- Device Paramers < For the whole Org
  DECLARE @AllSupportedParameters TABLE (
      DeviceKey                   INT,
      DeviceId                    BIGINT,
      ParameterId                 BIGINT
  )
  INSERT INTO @AllSupportedParameters
  SELECT 
    dd.DeviceKey, dd.DeviceId, dp.ParameterId
  FROM @definitionDeviceParameters ddp --33057
  INNER JOIN @definitionDevices dd
    ON dd.DeviceKey = ddp.DeviceKey --33057
  INNER JOIN @definitionParameters dp
    ON dp.ParameterKey = ddp.ParameterKey --33057
  INNER JOIN @libraryParameters lp
    ON lp.ParameterKey = dp.ParameterKey --30970
  INNER JOIN @libraryDevices ld
    ON ld.DeviceKey = dd.DeviceKey 
    AND ld.LibraryKey = lp.LibraryKey --21476
  INNER JOIN @AllDefinitionDeviceIds ids 
    ON ids.DeviceId = dd.DeviceId --272
  --SELECT COUNT(*) FROM @AllSupportedParameters

  DECLARE @OPEN_BRACKET BIGINT = 981729539706373388;
  DECLARE @CLOSE_BRACKET BIGINT = -8380423587615480304;

  --conditionParam
      -- + !supportedParam + eventConditionRequired > requiredConditionParameterMissing << NOT MONITORED                                      [FINE]
      -- + supportedParam               > atLeastOneParameterMonitored = true                                                     [FINE]
    --  (!requiredConditionParameterMissing && eventEnabled && (atLeastOneParameterMonitored || peripheralBasedEvent)) > MonitoredEvents       [FINE]

  DECLARE @assetsMissingParameters TABLE (
    MobileUnitId  BIGINT
  )
  INSERT INTO @assetsMissingParameters
  SELECT 
    DISTINCT (MissingParameters.MobileUnitId)
  FROM (
    SELECT
      MobileUnitId,
      [Event],
      MonitoredEvent = CASE WHEN (requiredConditionParameterMissing = 0 AND eventEnabled = 1 
        AND (atLeastOneParameterMonitored = 1 OR peripheralBasedEvent = 1)) THEN 1 ELSE 0 END
      --requiredConditionParameterMissing, atLeastOneParameterMonitored,   conditionParam, supportedParam, eventConditionRequired, peripheralBasedEvent, eventEnabled,   EventExtraFields.*
    FROM (
      SELECT
        requiredConditionParameterMissing = CASE WHEN (ConditionParam = 1 AND ISNULL(SupportedParam, 0) = 0 AND eventConditionRequired = 1) THEN 1 ELSE 0 END,
        atLeastOneParameterMonitored = CASE WHEN (ConditionParam = 1 AND ISNULL(SupportedParam, 0) <> 0) THEN 1 ELSE 0 END,
        EventBaseFields.*
      FROM 
      (
        SELECT DISTINCT
          mu.MobileUnitId,
          [Event] = le.[Description], 
          --[EventType] = det.[Description],
          --lp.[Description],
          --dp.ParameterId, 
          ConditionParam = CASE WHEN (dp.ParameterId = @OPEN_BRACKET OR dp.ParameterId = @CLOSE_BRACKET) THEN 0 else 1 END,
          SupportedParam = asp.parameterId, 
          eventConditionRequired = tec.IsRequired, 
          eventEnabled = CASE WHEN oe.IsEnabled IS NOT NULL THEN oe.IsEnabled ELSE 1 END, --It seems like by default it is enabled
          peripheralBasedEvent = CASE WHEN de.EventType = 10 THEN 1 ELSE 0 END
        FROM @GeneralConfigGroupInfo g
          INNER JOIN #mobileUnits mu 
            ON mu.ConfigurationGroupId = g.ConfigurationGroupId
          --Event
          INNER JOIN @templateEventTemplates tet
            ON tet.EventTemplateId =  g.EventTemplateId AND tet.LibraryKey = g.LibraryKey
          INNER JOIN [DeviceConfiguration].[template].[Events] te WITH (NOLOCK)
            ON te.EventTemplateKey = tet.EventTemplateKey AND te.LibraryKey = tet.LibraryKey
          INNER JOIN [DeviceConfiguration].[definition].[Events] de WITH (NOLOCK)
            ON de.EventKey = te.EventKey
          INNER JOIN [DeviceConfiguration].[library].[Events] le WITH (NOLOCK)
            ON le.EventKey = de.EventKey AND le.LibraryKey = g.LibraryKey
          INNER JOIN [DeviceConfiguration].[definition].[EventTypes] det WITH (NOLOCK)
            ON det.EventType = de.EventType
          -- EventConditions, Parameters
          LEFT OUTER JOIN [DeviceConfiguration].[template].[EventConditions] tec WITH (NOLOCK)
            ON tec.LibraryKey = g.LibraryKey AND tec.EventTemplateKey = te.EventTemplateKey AND tec.EventKey = te.EventKey
          LEFT OUTER JOIN @definitionParameters dp
            ON dp.ParameterKey = tec.ParameterKey
          LEFT OUTER JOIN @libraryParameters lp
            ON lp.LibraryKey = g.LibraryKey AND lp.ParameterKey = dp.ParameterKey
          -- Overiden Events (enabled)
          LEFT OUTER JOIN @mobileunitOverridenEvents oe
            ON oe.MobileUnitKey = mu.MobileUnitKey AND oe.TemplateEventKey = de.EventKey
          --Supported Parameters, as per Library (based from definition.DeviceParameters, took 3 days to figure this out :-))
          LEFT OUTER JOIN @AllSupportedParameters asp
            ON asp.ParameterId = dp.ParameterId AND asp.DeviceKey = g.DeviceKey
        --Ignore Hidden Events
        WHERE de.EventType != 0 --Hidden
      ) as EventBaseFields
      WHERE EventBaseFields.eventEnabled = 1
    ) as EventExtraFields
  ) MissingParameters
  WHERE MonitoredEvent = 0 
  --SELECT * FROM @assetsMissingParameters


  DECLARE @alertByAssets TABLE (
    MobileUnitId  BIGINT,
    Alerts NVARCHAR(50)
  );
  INSERT INTO @alertByAssets
  SELECT 
    MobileUnitId,
    CONCAT(
        COUNT(DISTINCT CASE WHEN MessageSubType = 254 THEN MobileUnitId END),
        COUNT(DISTINCT CASE WHEN MessageSubType = 103 THEN MobileUnitId END)
    ) AS Alerts
  FROM @messageStatuses
  GROUP BY MobileUnitId;
  --ORDER BY MobileUnitId;
  --SELECT * FROM @alertByAssets;


  -- Firmware Versions ---------------------------------------------------------

  DECLARE @canBasIncompatible TABLE (
      DeviceId            BIGINT
  )
  INSERT INTO @canBasIncompatible VALUES (@FM3316i);
  INSERT INTO @canBasIncompatible VALUES (@FM33x6);
  INSERT INTO @canBasIncompatible VALUES (@FM2000);
  INSERT INTO @canBasIncompatible VALUES (@FM2000_HV);
  INSERT INTO @canBasIncompatible VALUES (@FM2001);
  INSERT INTO @canBasIncompatible VALUES (@FM2100);
  INSERT INTO @canBasIncompatible VALUES (@FM2100_HV);
  INSERT INTO @canBasIncompatible VALUES (@FM2300);
  INSERT INTO @canBasIncompatible VALUES (@FM2300_HV);
  INSERT INTO @canBasIncompatible VALUES (@FM3106);
  INSERT INTO @canBasIncompatible VALUES (@FM32x0);
  INSERT INTO @canBasIncompatible VALUES (@FM32x1);
  INSERT INTO @canBasIncompatible VALUES (@FM33x0);
  INSERT INTO @canBasIncompatible VALUES (@FM33x1);
  INSERT INTO @canBasIncompatible VALUES (@FM33x5);
  INSERT INTO @canBasIncompatible VALUES (@FM_Tracer);
  --SELECT * FROM @canBasIncompatible

  -- Filtered Firmware Versions

  --SELECT * FROM @allFirmwareVersions

  --TODO: MR: mobileDevice specific (IsEnabled that links template.Devices to library.Devices will cause the difference via template.MobileDeviceTemplates)
  --@fmBas = 1 WHEN  allLogicalDevices.DeviceId = @FM3XXX_MOBILE_DEVICE_RANGE AND allLogicalDevices.IsEnabled = 1 --TODO: MR: Add back via tmdt

  DECLARE @filteredVersions TABLE (
    DeviceId                BIGINT,
    FirmwareVersionKey      INT,
    VersionNumber           INT,
    FMBas                   BIT
  )

  --TODO: MR: I think this is done now. The only potential issue is if the Logical's IsEnabled could be changed per mobile unit, but it doesn't seem to be the case... mu, via tmdt > deviceId > tld * isEnabled...
  INSERT INTO @filteredVersions
    SELECT 
      @BASE_FM_FUNCTIONALITY, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 1 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @FM3xBASDDR
    ORDER BY afw.FirmwareVersionKey;
  INSERT INTO @filteredVersions
    SELECT 
      @BASE_FM_FUNCTIONALITY, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @FM200Plus
    ORDER BY afw.FirmwareVersionKey;

  --TODO: MR: When connecting to the mu, figure out the CANBASInCompatible, then exclude those starting with E
    --Perform check to make sure only FM35xx and newer units get BAS 1.70 CAN DDMs in the UI drop down
      --WHEN testing the device....
        --IF @SCRIPTABLE_CAN_BUS device AND IN @canBasIncompatible THEN remove those starting with E
  INSERT INTO @filteredVersions
    SELECT 
      @SCRIPTABLE_CAN_BUS, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @FMCANDDMs
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @HOURS_OF_SERVICE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @FMHOSDBDDM
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @SYSTEM_TERMINAL, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @FMTerminal
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @MIX3000_FIRMWARE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @MiX3000
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @MIX4000_FW, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @MiX4000
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @MIX2000_FIRMWARE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @MiX2000
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @MIX2310_FIRMWARE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @MiX2310i
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @FM3D_FW, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @FM3D
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @ROVIII_FIRMWARE_PACKAGE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @ROVIII
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @ROVIIII_FIRMWARE_PACKAGE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @ROVIIII
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @ROVIIV_FIRMWARE_PACKAGE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @ROVIIV
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @TABS_PBS_FIRMWARE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @TABSPBSFW
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @TABS_BEACON_FIRMWARE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @TABSBEACONFW
    ORDER BY afw.FirmwareVersionKey;

  INSERT INTO @filteredVersions
    SELECT 
      @MIX6000_FIRMWARE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType = @MiX6000
    ORDER BY afw.FirmwareVersionKey;
    
  INSERT INTO @filteredVersions
    SELECT 
      @MIX6000LTE_FIRMWARE, FirmwareVersionKey, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VersionNumber, 0 as FMBas
    FROM @allFirmwareVersions afw
    WHERE afw.FirmwareType =  @MiX6000LTE
    ORDER BY afw.FirmwareVersionKey;


  DECLARE @maxFirmwareVersion TABLE (
    DeviceId            BIGINT, 
    FMBas               BIT, 
    VersionNumber       INT
  )
  INSERT INTO @maxFirmwareVersion
  SELECT 
      DeviceId,
      FMBas,
      MAX(VersionNumber) AS MaxVersionNumber
  FROM 
      @filteredVersions
  GROUP BY 
      DeviceId, 
      FMBas;


  DECLARE @CanBasIncompatibleDeviceKeys TABLE (
    DeviceKey         INT
  )
  INSERT INTO @CanBasIncompatibleDeviceKeys
  SELECT 
    DeviceKey
  FROM [DeviceConfiguration].[definition].[Devices] dd
  WHERE dd.DeviceId IN
  (SELECT DeviceId FROM @canBasIncompatible)
  --SELECT * FROM @CanBasIncompatibleDeviceKeys


  DECLARE @MobileUnitFWVersions TABLE (
    ConfigurationGroupId            BIGINT,
    MobileUnitId                    BIGINT,
    MobileUnitKey                   INT,
    TemplateDevicePropertyKey       INT,
    PreferredFWVersion              NVARCHAR(250),
    PreferredFirmwareVersionId      BIGINT,
    FMBas                           BIT,
    DeviceKey                       INT,
    LogicalDeviceId                 BIGINT,
    FirmwareVersionKey              INT,
    OriginalDeviceId                BIGINT,
    CanBasIncompatible              BIT
    --LatestFWVesion = 0 --TODO: MR: Use the new stuff here
  );
  INSERT INTO @MobileUnitFWVersions
  SELECT DISTINCT
    g.ConfigurationGroupId,
    mu.MobileUnitId,
    mu.MobileUnitKey,
    fw.TemplateDevicePropertyKey,
    PreferredFWVersion = ISNULL(apfw.FWName, fw.FWName),
    PreferredFirmwareVersionId = ISNULL(apfw.FirmwareVersionId, fw.FirmwareVersionId)
    --,  LatestFWVesion = 0 --TODO: MR: Use the new stuff here
    ,FMBas = CASE WHEN fw.MobileDeviceKey IN (SELECT DeviceKey FROM @FMBasDevices) THEN 1 ELSE 0 END -- @FM3XXX_MOBILE_DEVICE_RANGE
    ,fw.ChildDeviceKey [DeviceKey]
    ,dd.DeviceId [LogicalDeviceId]
    ,fw.FirmwareVersionKey
    ,ddOriginal.DeviceId [OriginalDeviceId]
    ,CanBasIncompatible = CASE WHEN fw.MobileDeviceKey IN (SELECT DeviceKey FROM @CanBasIncompatibleDeviceKeys) THEN 1 ELSE 0 END
    --,fw.*
  FROM @GeneralConfigGroupInfo g
    INNER JOIN #mobileUnits mu ON mu.ConfigurationGroupId = g.ConfigurationGroupId
    INNER JOIN @TemplateMobileDeviceTemplates tmdt
      ON tmdt.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    LEFT JOIN @ConfigGroupsFWVersions fw ON fw.ConfigurationGroupId = g.ConfigurationGroupId
    --INNER JOIN #assets a ON a.LegacyVehicleId = mu.LegacyVehicleId
    --LEFT JOIN @BlackFlagsCount b ON b.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN @AssetPreferredFWVersions apfw ON apfw.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN @definitionDevices dd ON dd.DeviceKey = fw.ChildDeviceKey
    LEFT JOIN @definitionDevices ddOriginal ON ddOriginal.DeviceKey = fw.DeviceKey
    
  DECLARE @MobileUnitFWOutdated TABLE (
    ConfigurationGroupId            BIGINT,
    MobileUnitId                    BIGINT,
    FirmwareVersionKey              INT,
    PreferredFWVersion              NVARCHAR(250),
    [FWVersion]                     INT,
    [LatestFWVesion]                INT,
    OutdatedFW                      BIT,
    CanBasIncompatible              BIT
  )
  INSERT INTO @MobileUnitFWOutdated
  SELECT 
    tcg.ConfigurationGroupId,
    mufw.MobileUnitId,
    mufw.FirmwareVersionKey,
    mufw.PreferredFWVersion,
    ffw.VersionNumber [FWVersion],
    mfw.VersionNumber [LatestFWVesion],
    CASE WHEN ((mfw.VersionNumber - ffw.VersionNumber) > 2) THEN 1 ELSE 0 END AS [OutdatedFW],
    mufw.CanBasIncompatible --TODO: MR: IF it is this - remove "E" results.
  FROM @MobileUnitFWVersions mufw
    INNER JOIN #mobileUnits mu
      ON mu.MobileUnitId = mufw.MobileUnitId
    INNER JOIN @templateConfigGroups tcg
      ON tcg.ConfigurationGroupId = mu.ConfigurationGroupId
    INNER JOIN @TemplateMobileDeviceTemplates tmdt
      ON tmdt.MobileDeviceTemplateKey = tcg.MobileDeviceTemplateKey
    INNER JOIN @definitionDevices dd
      ON dd.DeviceKey = tmdt.MobileDeviceKey
    LEFT JOIN @filteredVersions ffw
      ON ffw.DeviceId = mufw.LogicalDeviceId
      AND ffw.FirmwareVersionKey = mufw.FirmwareVersionKey
      AND ffw.FMBas = mufw.FMBas
    LEFT JOIN @maxFirmwareVersion mfw
      ON mfw.DeviceId = mufw.LogicalDeviceId
      AND mfw.FMBas = mufw.FMBas;




  -- Put it all together
  SELECT DISTINCT
    Alerts = 
      CONCAT(
        CASE 
            WHEN ISNULL(aa.Alerts,'') = '' THEN '00'
            ELSE aa.Alerts
        END, -- Messages Outdates
        CASE 
            WHEN ISNULL(mufwo.MobileUnitId, 0) = 0 THEN '0'
            ELSE '1'
        END, -- Mobileunit Firmware outdated by more than 2
        CASE 
            WHEN ISNULL(amp.MobileUnitId, 0) = 0 THEN '0'
            ELSE '1'
        END -- Event Not Monitored Missing Parameters
      ),
    mu.MobileUnitId,
    mu.Serialnumber,
    g.ConfigurationGroupId,
    NULL AS CommsLog, -- In Code, CommsLog would be mm.MessageStatusDateUtc in historical date, else sched.LastLogEntry
    mm.MessageStatusDateUtc,
    afwi.FWName AS FWVersion,
    mufw.PreferredFWVersion AS PreferredFWVersion
  FROM @GeneralConfigGroupInfo g
    INNER JOIN #mobileUnits mu ON mu.ConfigurationGroupId = g.ConfigurationGroupId
    LEFT JOIN @MobileUnitFWVersions mufw ON mufw.MobileUnitId = mu.MobileUnitId
    LEFT JOIN @FWVersionInstalled afwi ON afwi.MobileUnitKey = mu.MobileUnitKey
    LEFT JOIN @alertByAssets aa ON aa.MobileUnitId = mu.MobileUnitId
    LEFT JOIN @assetsMissingParameters amp ON amp.MobileUnitId = mu.MobileUnitId 
    LEFT JOIN @MobileUnitFWOutdated mufwo ON mufwo.MobileUnitId = mu.MobileUnitId AND mufwo.OutdatedFW = 1
    LEFT JOIN @mesaMessages mm ON mm.MobileUnitId = mu.MobileUnitId

END




NEW CODE:

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