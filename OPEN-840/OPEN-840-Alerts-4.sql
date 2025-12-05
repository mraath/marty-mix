CREATE PROCEDURE [state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized_4ALerts]
    @configGroupIds [dbo].[SelectionIds] READONLY
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #BasicInfo (MobileUnitId BIGINT PRIMARY KEY, AssetId BIGINT, ConfigurationGroupId BIGINT, ConfigurationGroupKey INT, MobileDeviceKey INT, MobileUnitKey INT, ConfigurationStatusId INT, ConfigurationStatus NVARCHAR(50), ConfigurationStatusDate DATETIME, LegacyOrgId INT, LegacyVehicleId INT, [UniqueIdentifier] NVARCHAR(250), Serialnumber NVARCHAR(250), StreamaxSerialNumber NVARCHAR(250), ConfigurationGenerationNotes NVARCHAR(MAX), ConfigurationGenerationWarning NVARCHAR(MAX), LibraryKey INT, EventTemplateKey INT, LocationTemplateKey INT, MobileDeviceTemplateKey INT);
    INSERT INTO #BasicInfo EXEC [state].[MobileUnit_GetMobileUnitBasicInfoForConfigGroups] @configGroupIds;

    SELECT
        Alerts = CONCAT(ISNULL(msgAlerts.MessageAlertCode, '00'), CAST(ISNULL(fw.IsFirmwareOutdated, 0) AS CHAR(1)), '0'),
        bi.MobileUnitId, bi.Serialnumber, bi.ConfigurationGroupId, NULL as CommsLog,
        CAST(lastMsg.LastMessageStatusDateUtc AS DATETIME) AS MessageStatusDateUtc,
        fw.InstalledFirmwareName AS FWVersion, fw.PreferredFirmwareName AS PreferredFWVersion
    FROM #BasicInfo bi
    CROSS APPLY [state].[MobileUnit_GetUnitFirmwareInfoTVF](bi.MobileUnitId, bi.MobileUnitKey, bi.MobileDeviceKey, bi.LibraryKey, bi.MobileDeviceTemplateKey) AS fw
    CROSS APPLY [state].[MobileUnit_GetMobileUnitMessageAlerts](bi.MobileUnitId) AS msgAlerts
    OUTER APPLY [state].[MobileUnit_GetMobileUnitLastMessageDate](bi.MobileUnitId) AS lastMsg;

    DROP TABLE #BasicInfo;
END;