---
wiki_ingested: 2026-05-28
created: 2025-04-17T08:48
updated: 2025-04-17T08:48
---
The difference in behavior between the stored procedure and function is due to how SQL Server Database Projects handle cross-database references in different object types. Table-valued functions are more strictly checked during build.

Here's how to fix this:

1. First, add the database reference to your project file:

<Project>

  <!-- ...existing code... -->

  <ItemGroup>

    <ProjectReference Include="..\DeviceConfiguration\DeviceConfiguration.sqlproj">

      <Name>DeviceConfiguration</Name>

      <Project>{YOUR-GUID-HERE}</Project>

      <Private>True</Private>

      <DatabaseSqlCmdVariable>DeviceConfiguration</DatabaseSqlCmdVariable>

    </ProjectReference>

  </ItemGroup>

  <PropertyGroup>

    <SqlCommandVariablesFile>Variables.sqlcmd</SqlCommandVariablesFile>

  </PropertyGroup>

2. Create a Variables.sqlcmd file:

:setvar DeviceConfiguration "[$(DatabaseName)]"

3. Modify your function to use the variable:

CREATE FUNCTION [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups]

(

    @configGroupIds [dbo].[SelectionIds] READONLY

)

RETURNS TABLE

AS

RETURN

(

    WITH Constants AS 

    (

        -- ...existing code...

    ),

    PropKeys AS 

    (

        SELECT

            PropIMEIKey = (

                SELECT TOP 1 [PropertyKey]

                FROM $(DeviceConfiguration).[definition].[Properties] dp WITH (NOLOCK)

                CROSS JOIN Constants c

                WHERE dp.PropertyId = c.UNIT_IMEI

            )

    )

    SELECT

        -- ...existing code...

    FROM @configGroupIds cgids

    INNER JOIN $(DeviceConfiguration).[template].[ConfigurationGroups] tcg WITH (NOLOCK)

        ON tcg.ConfigurationGroupId = cgids.id

    INNER JOIN $(DeviceConfiguration).[mobileunit].[MobileUnits] mu WITH (NOLOCK)

        ON mu.ConfigurationGroupKey = tcg.ConfigurationGroupKey

    -- ...rest of joins using $(DeviceConfiguration)...

);

4. Make sure your build process includes the SQLCMD variables by adding to your publish profile:

<Project>

  <PropertyGroup>

    <IncludeCompositeObjects>True</IncludeCompositeObjects>

    <SqlCommandVariablesCheck>True</SqlCommandVariablesCheck>

    <SqlCommandVariables>DatabaseName=DeviceConfiguration</SqlCommandVariables>

  </PropertyGroup>

</Project>

This approach using SQLCMD variables is more reliable for cross-database references in table-valued functions and will resolve the build errors while maintaining the functionality.