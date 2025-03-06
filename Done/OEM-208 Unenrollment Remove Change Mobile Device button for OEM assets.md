# OEM-208 Unenrollment: Remove Change Mobile Device button for OEM assets

  NAVISTAR, SCANIA, FORD
  If uniqueidentifier is of type "VIN", hide the "Change Mobile Device" button

  BE | Local | DEV | xxx
  Config/MR/Feature/OEM-208_RemoveChangeMobileDeviceButtonForVIN.21.12.INT_ORI

## SPIKE

CHANGE_MOBILE_DEVICE (all, but something small, like config group)
  oldSiteId (AssetGateway)
  decommissionSTM (fine)
  assetCommissioningManager.ChangeAssetMobileUnit
    DeleteAssetMobileUnit (a lot happening)
      Fleet... UpdateTrackAndTraceUnitIdentifiersAsync
      DecommissionMiXTalk
      RemoveSatelliteModem
      Fleet... UpdateConfigurationGroupAsync
      DeleteMobileUnit
      ..configSecurityAccounts
      Fleet... AddAssetStateAsync
      Fleet... UpdateActiveStateAsync
      SetSiteId
      UpdateAsset
      QueueAssetsForSalesforce

    UpdateAssetConfigGroup
      ...Security
      ...Ligtning3B
      Fleet... swapunits
      Fleet... AddAssetStateAsync
      Fleet... UpdateConfigurationGroupAsync
      Add / update mu
      Set ConfigGroup
      Fleet... UpdateConfigurationGroupAsync
    
    QueueAssetsForSalesforce
    Fleet... UpdateActiveStateAsync
    DecommissionSTM
  UpdateVinAsync
  UpdateAssetCommissionInformation ... new number
  SendOBCCommissioning
  TimeZoneDeviation
  InvalidateMobileUnitMapping
      
UPDATE_COMMISSIONING_DETAILS (if not mobile phone)
  MiXTalk stuff
  STM Peripheral stuff, decommission, commission
  
  Updates propertyValueDictionary (eg. sattelite, iridium, msisdn, pwd, sms, ...mobileDeviceUniqueIdentifierPropertyId)
  Update other info (unique id, gsm modem, satematics, iridium, UpdateConfigurationStatus, mobile Device (!!!Connections, transportype, !!!DoUpdateMobileDevice, 2K - track&trace, Beacon))

  SendOBCCommissioning
  STM Standalone - Commission
  
