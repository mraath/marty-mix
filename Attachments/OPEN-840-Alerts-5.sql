CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized_5ALerts]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #BasicInfo (MobileUnitId BIGINT PRIMARY KEY, AssetId BIGINT, ConfigurationGroupId BIGINT, ConfigurationGroupKey INT, MobileDeviceKey INT, MobileUnitKey INT, ConfigurationStatusId INT, ConfigurationStatus NVARCHAR(50), ConfigurationStatusDate DATETIME, LegacyOrgId INT, LegacyVehicleId INT, [UniqueIdentifier] NVARCHAR(250), Serialnumber NVARCHAR(250), StreamaxSerialNumber NVARCHAR(250), ConfigurationGenerationNotes NVARCHAR(MAX), ConfigurationGenerationWarning NVARCHAR(MAX), LibraryKey INT, EventTemplateKey INT, LocationTemplateKey INT, MobileDeviceTemplateKey INT);
    INSERT INTO #BasicInfo EXEC [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] @configGroupIds;

    SELECT
        Alerts = CONCAT(
                    ISNULL(msgAlerts.MessageAlertCode, '00'),           -- Alert 1 & 2
                    CAST(ISNULL(fw.IsFirmwareOutdated, 0) AS CHAR(1)),  -- Alert 3
                    '0',                                                -- Alert 4 (Missing Parameters - Disabled)
					(CASE WHEN (fw.InstalledFirmwareAlpha < fw.PreferredFirmwareAlpha) AND
								(fw.InstalledFirmwareAlpha <> '') AND 
								(fw.PreferredFirmwareAlpha) <> '' THEN '1' ELSE '0' END) -- Alert 5
                 ),
        bi.MobileUnitId, bi.Serialnumber, bi.ConfigurationGroupId, NULL as CommsLog,
        CAST(lastMsg.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc,
        fw.InstalledFirmwareName AS FWVersion, fw.PreferredFirmwareName AS PreferredFWVersion
    FROM #BasicInfo bi
    CROSS APPLY [state].[MobileUnit_GetUnitFirmwareInfoTVF_WithAlert5](bi.MobileUnitId, bi.MobileUnitKey, bi.MobileDeviceKey, bi.LibraryKey, bi.MobileDeviceTemplateKey) AS fw
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](bi.MobileUnitId) AS msgAlerts
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageDate](bi.MobileUnitId) AS lastMsg;

    DROP TABLE #BasicInfo;
END;