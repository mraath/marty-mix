# CONFIG-2686 Black flag blocking unit commissioning (IMEI)

  

  - 21.9

    BE | Local | DEV | PR INT
    API | Local | DEV | PR INT
    DB | Local | DEV | PR INT
    
    Config/MR/Bug/CONFIG-2686_BlackFlag_ConfigChangedStatus.21.9.PROD.ORI

    PR INT:
    DB: https://mixtelematics.visualstudio.com/Common/_git/Database/pullrequest/59570
    API: https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/59571
    BE: https://mixtelematics.visualstudio.com/Common/_git/DynaMiX.Backend/pullrequest/59594  

    TrackAndTraceMobileUnitManager.cs	Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel
    MobileUnitManager.cs	Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel
    MobileDeviceTemplateManager.cs	Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel
    DeviceIntegrationManager.cs	Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel
    ConfigurationGroupManager.cs	Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel
    AssetKeypadManager.cs	Logic\DynaMiX.Logic\FleetAdmin


    ConfigurationStatus

    ConfigurationStatus.ConfigChanged
    ConfigurationStatus.ConfigurationChanged

    CONFIG-2686: Added in logic to only set to config changed when it should


  - BELOW is OLD

    - Remove compile and upload
      Mobile Device Settings
      Config group asset list

    BE | Local
    FE | Local

    Config/MR/Bug/CONFIG-2686_DisableUploadCompile.21.8.PROD_ORI

  

  AutoCommission
  canAutoCommission
  
  if (mobileUnit != null && mobileUnit.ConfigurationStatus != ConfigurationStatus.NotCommissioned)
  
  if (mobileUnit == null && newConfigurationStatus == ConfigurationStatus.ConfigChanged) return;
  if (newConfigurationStatus == ConfigurationStatus.ConfigChanged && previousConfigurationStatus == ConfigurationStatus.NotCommissioned) return;



  - ATTEMPT TO REMOVE THE ISSUE

    I found about 62 places in 23 files where it directly sets the mobileunit to the following state:
    ConfigurationStatus.ConfigurationChanged

    I then just removed the test occurrances and those which seemed irrelevant. Herewith the files still in questions.

    - EASY
    
      - DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetAccessControlModule.cs:
        164: DeviceIntegrationManager.SetConfigurationStatus(authToken, assetId, ConfigEnums.ConfigurationStatus.ConfigurationChanged, ...

      - DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetDetailsModule.cs:
        456: deviceIntegrationManager.SetConfigurationStatus(authToken, assetId, MiX.DeviceIntegration.Common.Enums.ConfigurationStatus.ConfigurationChanged, ...

      - DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Drivers\DriverAccessControlModule.cs:
        146: DeviceIntegrationManager.SetConfigurationStatus(authToken, item.AssetId, ConfigurationStatus.ConfigurationChanged, ...
        156: DeviceIntegrationManager.SetConfigurationStatus(authToken, item.AssetId, ConfigurationStatus.ConfigurationChanged, ...

      - DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleet.Mobile.Api\Modules\AssetsAndDriversModule.cs:
        215: DeviceIntegrationManager.SetConfigurationStatus(authToken, mobileUnit.AssetId, ConfigurationStatus.ConfigurationChanged, ...
      
      - DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:
        1586: _deviceConfigRepo.SetConfigurationStatusForMobileUnit(session, mobileUnitId, ConfigurationStatus.ConfigurationChanged);
        1631: _deviceConfigRepo.SetConfigurationStatusForMobileUnit(session, mobileUnitId, ConfigurationStatus.ConfigurationChanged);

      - DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:
        165: mobileUnitManager.UpdateConfigurationStatus(authToken, assetId, ConfigurationStatus.ConfigurationChanged);

      - DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs:
        376: UpdateConfigurationStatus(authToken, mobileUnit.Id, ConfigEnums.ConfigurationStatus.ConfigurationChanged);


    - TRICKY (???? canAutoCommission)

      (MU null) if (status == ConfigurationStatus.ConfigChanged) return;
      (else) if (newConfigurationStatus == ConfigurationStatus.ConfigChanged && previousConfigurationStatus == ConfigurationStatus.NotCommissioned) return;

      (CAN LOOK AT PREVIOUS aka if mu exists && prev status is not "notcommissioned" then change) 
      (???? When will above note make sense?)

      - DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:
        2808: ConfigurationStatus configStatus = ConfigurationStatus.ConfigurationChanged;
        2866: newMobileUnitConfig.ConfigurationStatus = (byte)ConfigurationStatus.ConfigurationChanged;
        2877: newMobileUnitConfig.ConfigurationStatus = (byte)ConfigurationStatus.ConfigurationChanged;
        3568: mobileUnit.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;

      - DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:
        421: ConfigurationStatus = canAutoCommission ? ConfigurationStatus.ConfigurationChanged : ConfigurationStatus.NotCommissioned,
        464: mu.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;

      - DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs:
        395: mobileUnit.ConfigurationStatus = ConfigEnums.ConfigurationStatus.ConfigurationChanged;
        943: mu.ConfigurationStatus = ConfigEnums.ConfigurationStatus.ConfigurationChanged;
        1691: mobileUnit.ConfigurationStatus = ConfigEnums.ConfigurationStatus.ConfigurationChanged;
        400: mobileUnit.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;
        564: mobileUnit.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;
        196: mu.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;
        982: mobileUnit.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;

      - DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetKeypadManager.cs:
        179: mobileUnit.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;
        213: mobileUnit.ConfigurationStatus = ConfigurationStatus.ConfigurationChanged;


    - NOT SURE AT ALL
    
      - DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\TemplateLevel\MobileDeviceTemplates.cs:
        426: Context.Entry(property).Property(p => p.ConfigurationStatus).CurrentValue = (byte)ConfigurationStatus.ConfigurationChanged;

      - DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminSqlRepository.cs:
        1039: @configurationStatus = ConfigurationStatus.ConfigurationChanged //MobileUnit_MarkConfigChangedByLocationTemplate
        1057: @configurationStatus = ConfigurationStatus.ConfigurationChanged //MobileUnit_MarkConfigChangedByEventTemplate

      - DynaMiX.Backend\Services\Configuration Generation\MiX.UnitConfiguration.GenerationService\UnitConfigurationService.cs:
        252: if (statusWhileGenerating == ConfigurationStatus.ConfigurationChanged)


  