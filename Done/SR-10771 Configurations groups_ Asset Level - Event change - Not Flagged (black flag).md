# SR-10771 Configurations groups: Asset Level - Event change - Not Flagged (black flag?)

    Stefan Smeda
    [reports].[sprReportConfigurationAuditSummary]
    op die asset db
    
    EXEC [$(DeviceConfiguration)].[reports].[MobileUnit_ConfigurationAuditSummary] @assets;
    EXEC [$(DeviceConfiguration)].[reports].[MobileUnit_ConfigurationAuditDetails] @assets, @dateFrom, @dateTo;
    dis actually in deviceconfig db

  - Details

    USE [DynaMiXTestUnits2018_2017]
    GO

    DECLARE	@return_value int

    EXEC	@return_value = [reports].[sprReportConfigurationAuditDetails]
        @organisationId = 0,
        @assetHostIds = N'355',
        @dateFrom = '2021-01-01',
        @dateTo = '2021-07-20'

    SELECT	'Return Value' = @return_value

    GO

  - Summary

    USE [DynaMiXTestUnits2018_2017]
    GO

    DECLARE	@return_value int

    EXEC	@return_value = [reports].[sprReportConfigurationAuditSummary]
        @organisationId = 0,
        @assetHostIds = N'355'

    SELECT	'Return Value' = @return_value

    GO

  - Other
  
  NEE: assetdb... [reports].[sprReportConfigurationAuditSummary]
  
  assetId = 973644418085838848

  I will now have a look at the database to check if the above mentioned changes are indeed in the overwritten tables,
  If so I will then check the new EF logic to see why it doesn't go through to the UI, although it seems to be there.

  4435128435617356968 
  -5215845406465777006 (System.Logical.MiX6000.Buzzer)



  LibraryEventKey	LibraryEventId	    LibraryKey	EventKey	LegacyEventId	Description	                              DateUpdated	              UserName
  188118	        1390673568505012449	828	        20395	    -183	        Door Open Park Brake Disengaged - Switch	2020-05-18 01:23:14 +00:00	Ensiyeh Kashtkaran

  mobileunit.OverriddenDeviceEvents
  - ConfigurationGroupDifference
    OverridenDeviceParameter
    OverridenDevicePropert
    OverridenDevice
    OverridenPeripheralDevice
    
    OverridenEventActions 
    OverridenEventConditionThresholds 
    OverridenEvents
    OverridenParameters

  Html element
	configDifferenceModal

  Directive to search for in code
	fleetConfigDifferenceModal

  isConfigurationDifferentToConfigGroup
  areConfigurationEventsDifferentToConfigGroup
  isConfigurationDeviceDifferentToConfigGroup

  pageData.configDiff({ assetId: row.assetId }).then((data)
  this.diffRows = data["groupDifferences"];

  mobileUnitManager.GetConfigurationGroupDifferences
    muProxy.GetOverriddenInformationForMobileUnit
      mum.GetOverriddenInformationForMobileUnit
        OverriddenDevices
        OverriddenPeripheralDevices
        OverriddenDeviceProperties
        OverriddenDeviceParameters
        OverriddenEvents
        OverriddenEventConditionThresholds
        OverriddenEventActions
        OverriddenCanParameters

    2 Years ago, changed from 6 years ago

  Will check DB now





## TEMP

  - Wyanand
    generalStatusInfoRemora.batteryLevel
    carrier.BatteryLevel = remoraProperties.BatteryLevel;
    mobiledevices.Remora = 797324896487352744
    [mobileunit].[MobileUnit_GetAllAssetsThatHaveMobileDevice]",
						libraryId,
						mobileDeviceId
    DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.GetDMEDiagnosticData(assetId)


      var batteryGood = _deviceStateManager.GetStateValue(mobileUnitId, deviceId, Properties.G52SOLAR_BATTERY_GOOD);
        [state].[MobileUnitState_GetStatesForMobileUnits]
        ??
        _deviceConfigRepo.GetMobileUnitProperty
          EF
      G52SOLAR_BATTERY_GOOD = -8013576258321919123

			if (!string.IsNullOrEmpty(batteryGood))
				result.BatteryGood = batteryGood == "1";


      result.BatteryLevel = (bool)data.BatteryGood ? DiagnosticInfo.BATTERY_GOOD : DiagnosticInfo.BATTERY_LOW;
      result.BatteryLevel = DiagnosticInfo.NOT_AVAILABLE

  - JUSTUS
    C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryEventManager.cs
    method MakeAvailable
      calls MakeAvailableHelper.MakeLibraryEventAvailable


    C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryMobileDeviceManager.cs
    method MakeLibraryMobileDeviceAvaialble
      // auto-create default template
      CreateDefaultTemplate

