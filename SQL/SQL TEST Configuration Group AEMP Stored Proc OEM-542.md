
```sql
-- TESTING AEMP Stored Proc
--BlockManalCommisioning must be used

-- Finding the correct Logical device
--SAFEST to work with LONG in definition.Devices
--SELECT top 10 * from definition.LogicalDevices Order by devicekey DESC
--27208	BlockManualCommissioning Logical
--SELECT * FROM definition.Devices WHERE DeviceKey = 27208
--27208	2302774839761424318	130	MobileDevice.Logical.BlockManualCommissioning
--SELECT * FROM definition.Devices WHERE DeviceId IN (5367522731798878433, 2302774839761424318)
--2302774839761424318	MobileDevice.Logical.BlockManualCommissioning



DECLARE @orgId BIGINT = -1983255592473789111; --INT: MR AEMP
DECLARE @assetId BIGINT;-- = 1441016203391774720; --Null should return all but AEMP 

--TODO: MR: Add to SProc
DECLARE @BlockManualCommissioning AS BIGINT = 2302774839761424318;
DECLARE @BlockedDevices TABLE (	DeviceKey INT );
INSERT INTO @BlockedDevices
SELECT ParentDeviceKey 
    FROM definition.DeviceDependencies 
    WHERE ChildDeviceKey in (
        SELECT DeviceKey 
            FROM definition.Devices 
            WHERE DeviceId = @BlockManualCommissioning
    )




--SELECT * FROM @BlockedDevices




USE DeviceConfiguration;

  /* If we cannot resolve the Mobile Device, we will return all Configuration Groups for the Org */
	DECLARE @MobileDeviceKey BIGINT = (	SELECT MU.[MobileDeviceKey] FROM mobileunit.AssetMobileUnits AMU WITH (NOLOCK)
											INNER JOIN mobileunit.MobileUnits MU ON MU.[MobileUnitKey] = AMU.[MobileUnitKey]
										WHERE AMU.[AssetId] = @assetId)

	DECLARE @LibraryKey BIGINT = (SELECT L.[LibraryKey] FROM library.[Libraries] L  WITH (NOLOCK) WHERE L.[GroupId] = @orgId)

  /* Outer JOIN so that we catch ConfigurationGroups without units as well */
	SELECT CG.[ConfigurationGroupId] AS [ConfigurationGroupId], 
				CG.[Name] AS [ConfigurationGroupName], 
				COUNT(MU.[ConfigurationGroupKey]) AS [MobileUnitCount]
		FROM [template].[ConfigurationGroups] CG  WITH (NOLOCK)
			INNER JOIN template.MobileDeviceTemplates MT  WITH (NOLOCK) ON MT.[MobileDeviceTemplateKey] = CG.[MobileDeviceTemplateKey]
			LEFT OUTER JOIN  mobileunit.MobileUnits MU  WITH (NOLOCK) ON MU.[ConfigurationGroupKey] = CG.[ConfigurationGroupKey]
		WHERE 
            (@MobileDeviceKey = MT.[MobileDeviceKey]
                OR (@MobileDeviceKey IS NULL AND MT.[MobileDeviceKey] NOT IN (SELECT * FROM @BlockedDevices))) --TODO: MR: Change the where clause
            AND CG.[LibraryKey] = @LibraryKey
	GROUP BY CG.[ConfigurationGroupId], CG.[Name]
	ORDER BY CG.[Name]
```
