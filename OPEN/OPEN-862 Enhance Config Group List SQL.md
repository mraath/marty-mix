---
wiki_ingested: 2026-05-28
created: 2025-10-30T15:19
updated: 2025-10-30T15:19
---
You are right; for a simple lookup procedure like this one, the best optimization is typically eliminating the **table variable** and performing the selection directly via a **Common Table Expression (CTE)**.

Table variables force the query optimizer to make worst-case cardinality assumptions (often assuming only 1 row), which can lead to inefficient nested loop joins. By switching to a CTE or a direct `SELECT`, the optimizer can use actual statistics and generate a better execution plan, even for simple queries.

Here is the enhanced version of `[template].[Template_GetConfigurationGroupsMultiselect]`.

## ⚡ Enhanced Stored Procedure: `[template].[Template_GetConfigurationGroupsMultiselect]`

_SQL_

```
CREATE PROCEDURE [template].[Template_GetConfigurationGroupsMultiselect]
    @groupId BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    ---------------------------------------------------
    -- STEP 1: General Information CTE (Replaces Table Variable)
    -- Selects all required data directly into a CTE for optimal plan generation.
    ---------------------------------------------------
    WITH GeneralConfigGroupInfo AS (
        SELECT
            tcg.ConfigurationGroupId,
            tcg.ConfigurationGroupKey,
            tcg.Name AS ConfigurationGroupName,
            dmd.Description AS MobileDevice,
            mdt.MobileDeviceTemplateId,
            mdt.Name AS MobileDeviceTemplateName,
            tet.EventTemplateId,
            tet.Name AS EventTemplateName,
            tlt.LocationTemplateId,
            tlt.Name AS LocationTemplateName,
            dd.DeviceKey,
            tcg.MobileDeviceTemplateKey,
            tcg.LibraryKey,
            tcg.IsDefault
        FROM [library].[Libraries] l WITH (NOLOCK)
        INNER JOIN [template].[ConfigurationGroups] tcg WITH (NOLOCK) ON tcg.LibraryKey = l.LibraryKey
        INNER JOIN [template].[MobileDeviceTemplates] mdt WITH (NOLOCK)
            ON tcg.MobileDeviceTemplateKey = mdt.MobileDeviceTemplateKey
            AND tcg.LibraryKey = mdt.LibraryKey
        INNER JOIN [definition].[Devices] dd WITH (NOLOCK) ON mdt.MobileDeviceKey = dd.DeviceKey
        INNER JOIN [definition].[MobileDevices] dmd WITH (NOLOCK) ON dd.DeviceKey = dmd.DeviceKey
        LEFT JOIN [template].[EventTemplates] tet WITH (NOLOCK)
            ON tcg.EventTemplateKey = tet.EventTemplateKey
            AND tcg.LibraryKey = tet.LibraryKey
        LEFT JOIN [template].[LocationTemplates] tlt WITH (NOLOCK)
            ON tcg.LocationTemplateKey = tlt.LocationTemplateKey
            AND tcg.LibraryKey = tlt.LibraryKey
        WHERE l.GroupId = @groupId
    )
    
    ---------------------------------------------------
    -- STEP 2: Final Selection
    ---------------------------------------------------
    SELECT
        NULL AS Alerts,
        NULL AS Flagged,
        g.ConfigurationGroupId,
        g.ConfigurationGroupName,
        NULL AS AssetsCount,
        g.MobileDevice,
        g.MobileDeviceTemplateId,
        g.MobileDeviceTemplateName,
        g.EventTemplateId,
        g.EventTemplateName,
        g.LocationTemplateId,
        g.LocationTemplateName,
        g.IsDefault,
        NULL AS FWVersion,
        NULL AS CanScriptLineId,
        NULL AS CanScript,
        NULL AS Speed,
        NULL AS RPM,
        NULL AS Fuel,
        NULL AS SP,
        NULL AS HOS
    FROM GeneralConfigGroupInfo g;

END
```

The new version achieves the same results while being more efficient:

- **Avoids Table Variable Overhead:** The `@GeneralConfigGroupInfo` table variable is replaced with the `GeneralConfigGroupInfo` **CTE**, allowing the _SQL_ Server optimizer to create a single, efficient execution plan instead of two stages (insert to table variable, then select from table variable).
    
- **Direct Projection:** The data is selected and projected directly to the final result set.
    

This represents the fastest and most efficient structure for a simple lookup query of this nature.

Do you have one final stored procedure you'd like me to review and optimize?


