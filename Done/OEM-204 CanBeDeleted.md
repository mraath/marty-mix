# OEM-204 CanBeDeleted

  Common | Local | INT | NUGET | (dev)
  API | local | INT | 
  Client | local | INT | NUGET | Test app | (dev)

  Languaging | xx

  DEV: FORD: OEM: 1130967614899113984
  DEV: 4K: -8350495493145261616
  NULL: 1111111111111111111

  MiX.DeviceIntegration.Common.2021.8.6.1.nuspec
  OEM: "The asset is enrolled to an OEM data service, and needs first to be decommissioned before it can be deleted." 

  asset/{assetId}/can-asset-be-deleted
  //eg. GetAssetProperties

  public const long UNIQUE_IDENTIFIER_PROPERTY_ID_VIN = -4602155280089995484;
  IMobileDevice resolvedMobileDevice = mobileUnitManager.GetResolvedMobileDevice(assetId);
  bool isUniqueIdentifierVIN = resolvedMobileDevice.UniqueIdentifierPropertyId == ConfigConstants.Properties.UNIQUE_IDENTIFIER_PROPERTY_ID_VIN;


  Config/MR/Feature/OEM-204_CanBeDeleted.21.12.INT_ORI

  ![](LTE-248_MiX6k%20LTE%20Wrong%20Modal.png)

  https://integration.mixtelematics.com/#/asset/diagnostics?id=992216852975796224&orgId=-8441185520557948197&device=MiX6000%2BLTE&modal=true

