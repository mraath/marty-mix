```sql
@libraryId BIGINT,
	@deviceId BIGINT
AS
BEGIN
  SET NOCOUNT OFF;

  DECLARE @LibraryKey INT = (SELECT LibraryKey FROM [library].[Libraries] WITH (NOLOCK) WHERE [LibraryId] = @libraryId);
  DECLARE @DeviceKey INT = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE [DeviceId] = @deviceId);

  DECLARE @ConfigGroups TABLE (ConfigGroupKey INT NOT NULL PRIMARY KEY CLUSTERED, MobileDeviceTemplateKey INT NOT NULL);
  DECLARE @MuKeys TABLE (MUId BIGINT NOT NULL, MUKey INT NOT NULL PRIMARY KEY CLUSTERED, [MobileDeviceTemplateKey] INT NOT NULL)

  INSERT @ConfigGroups
    SELECT [ConfigurationGroupKey], [MobileDeviceTemplateKey]
      FROM [template].[ConfigurationGroups] cg WITH (NOLOCK)
      WHERE [LibraryKey] = @LibraryKey;

  INSERT @MuKeys
    SELECT [MobileUnitId], [MobileUnitKey], [MobileDeviceTemplateKey]
    FROM  [mobileunit].[MobileUnits] mu  WITH (NOLOCK) 
      JOIN @ConfigGroups cg ON mu.[ConfigurationGroupKey] = cg.[ConfigGroupKey]

  SELECT
    [AssetId] = mu.[MUId]
  FROM
    @MuKeys mu
  INNER JOIN
    [template].[Devices] td WITH (NOLOCK) ON mu.[MobileDeviceTemplateKey] = td.[MobileDeviceTemplateKey] AND td.[DeviceKey] = @DeviceKey
  LEFT JOIN
    [mobileunit].[OverridenDevices] md ON mu.[MUKey] = md.[MobileUnitKey] AND td.[TemplateDeviceKey] = md.[TemplateDeviceKey]
  WHERE 
      (md.[TemplateDeviceKey] IS NOT NULL AND md.[IsEnabled] = 1 OR (md.[TemplateDeviceKey] IS NULL AND td.[IsEnabled] = 1));
```
