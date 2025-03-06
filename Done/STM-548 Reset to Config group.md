# STM-548 Reset to Config group


  API | Local | xx
  
  Config/MR/Feature/STM-548_ResetToConfigGroup.21.16.INT.ORI
  

"Reset to group config"

  resetConfigurationModalButtons

  modalButtonResetClicked

  resetAsset(this._currentRow)

  resetConfigTemplate["resetDevices"]({ assetId: row.assetId }).then
  resetConfigTemplate["reset"]({ assetId: row.assetId }).then

  RESET_DEVICE_TO_CONFIG_GROUP ????????
    mobileUnitProxy.ResetAssetMobileUnit   type:1
  RESET_TO_CONFIG_GROUP
    mobileUnitProxy.ResetAssetMobileUnit   type:2edgee