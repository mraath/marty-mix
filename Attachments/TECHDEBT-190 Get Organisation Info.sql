CREATE PROCEDURE [dynamix].[OrganisationGetAssetDataTimeZones]
AS
BEGIN
    --USE DeviceConfiguration;
    --DROP PROCEDURE [dynamix].[OrganisationGetAssetDataTimeZones]

    SELECT
        [Key] = dynO.[GroupId],
        [Value] = dynO.[AssetDataTimeZone]
    FROM [FMOnlineDB].[dbo].[Organisation] org
        INNER JOIN [FMOnlineDB].[dynamix].[Organisations] dynO ON org.[liOrgID] = dynO.[OrganisationId]
    WHERE org.[liOrgID] != -1
        AND dynO.[DatabaseState] = 0 -- Active
END
