# SR-10999 AU - Dynamix - Performance degradation

  DB | Local | INT
  Common | Local | INT + nuget | xx build actual PROD
  API | Local | INT | xx PROD + USE actual NUGET for PROD
  Client | Local | INT | xx PROD USE actual NUGET PROD

  Config/MR/BUG/SR-10999_SingleSimplifiedCall.21.15.PROD_ORI

  C:\Projects\Database\sql
  
  public const string GetMobileUnitPropertiesForAssetsList = "groupId/{groupId}/mobile-units/properties_assets_list";

  GetMobileUnitDeviceProperty

  MobileUnitId	              long
  UniqueIdentifier	          nvarchar(50)
  ConfigurationGroupId	      long
  ConfigurationGroupName	    nvarchar(200)
  DriverSetVersion	          nvachar(max)
  DriverSetLoadDate	          
  LastConfig	
  DDMLoadDate	
  DDMVersion	
  UnitIMSI	
  MSISDN	
  UnitIMEI



C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Api.Client.IntegrationTests\MobileUnitLevel\MobileUnitMappingsProxyTests.cs'

DynaMiX.DeviceConfig.Services.Api.Client.IntegrationTests	

C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Api.Client.IntegrationTests\CSC	1	Active

  
  HSSYDIIS44 & HSSYDIIS45

  Assets Page
    GetAssetConfigDetailsList
    GetDeviceStateForMobileUnits
  Drivers Page
  Reports
  Timeline

  TIM:

    c:\projects\dynamix.backend\Logic\DynaMiX.Logic\FleetAdmin\Assets\AssetManager.cs

    1 GetConfigurationGroups

      WHERE LIBRARY ID from orgId...

      configurationGroup.Name
      configurationGroup.Id
    
    2 GetMobileUnitPropertiesForOrgAssets

      [mobileunit].[MobileUnit_GetMobileUnitPropertiesForOrgAssets]
      WHERE organisationId and propertyIds

      mobileUnitProperties

        DDM_LOAD_DATE (NOT USED)
        public const long DRIVER_SET_VERSION = -166780461458096034;
        public const long DRIVER_SET_LOAD_DATE = -9219767447798200635;
        public const long LAST_CONFIG = -8523290938287476583;
        Properties.DDM_LOAD_DATE (not used), [2636610157290733419]
        public const long DDM_VERSION = 2962624355936954378;
        public const long UNIT_IMSI = 3870542574174346252;
        public const long MSISDN = -8253307904787534451;
        public const long UNIT_IMEI = 9188780602356317147;


      Die geel blok se goed moet dalk een call wees waar daai properties aan julle kant maybe gehardcode is sodat die sproc iets soos die kan return

        AssetId     DriverSetVersion    DriverSetLoadDate     LastConfig    DDMLoadDate           DDMVersion    .........
        123456789   2.2                 2021-10-28 08:00:00   1.23456789    2021-10-27 23:59:59   9.87654321    .........

    3 GetMobileUnits

      [mobileunit].[MobileUnit_GetMobileUnits]
      WHERE libraryId

      DALK MERGE MET BOONSTE?

        mu.ID, mu.ConfigurationGroupId, UniqueIdentifier

    4 DeviceStates
      IF PROPERTY VAL IS NULL
      muIMSIs = dsProxy.GetDeviceStatesForMobileUnits(muIds, LogicalDevices.ALL_MOBILE_UNITS, Properties.IMSI)
      [state].[MobileUnitState_GetStatesForMobileUnits]
      public const long IMSI = 6851923534434202573;


    TESTING:
          
      SELECT * FROM [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK)
      WHERE mup.MobileUnitKey IN (
        SELECT MobileUnitKey FROM [mobileunit].[MobileUnits] mu WITH (NOLOCK) 
        WHERE mu.ConfigurationGroupKey IN (
          SELECT ConfigurationGroupKey FROM [template].[ConfigurationGroups] cg WITH (NOLOCK) where cg.[LibraryKey] = 700
        )
      )
      AND PropertyKey IN (
        SELECT PropertyKey FROM [definition].[Properties] dp WITH (NOLOCK)
        WHERE dp.PropertyId IN (
          -8253307904787534451
        )
      )

  JEREMY:

Hi Jeremy - sorry for bothering you
I have the following situation...

I created a stored proc for our DeviceConfiguration database...
From there I need to call records in a table on another databse...
DeviceConfiguration.DataProcessing

It works locally - if I manually run it on INT... the stored proc get created and works, however, when doing n Pull Request the merge gives errors.... recarding that database...

The error is something along these lines....

Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[PropertyId].

So it seem to complain about a cross database call...

I tries this... replacing... also adding variables in the proj... still having issues - so I know I am missing something :)

FROM [$(DeviceConfigurationDataProcessing)].[state].[MobileUnitState] WITH (NOLOCK)

So the error still happens
Any idea as to what I am missing?

I will go into the office and a team lunch at 11:30, just wanted to post this so long so you can put your thinking cap one :-D



  DB FAIL:

  ##[error]DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(69,6): Error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[PropertyId].
     6>D:\b\1\_work\1531\s\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(69,6,69,6): Build error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[PropertyId]. [D:\b\1\_work\1531\s\DeviceConfiguration\DeviceConfiguration.sqlproj]
  ##[error]DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(65,31): Error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[MobileUnitId].
      6>D:\b\1\_work\1531\s\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(65,31,65,31): Build error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[MobileUnitId]. [D:\b\1\_work\1531\s\DeviceConfiguration\DeviceConfiguration.sqlproj]
  ##[error]DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(68,6): Error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[MobileUnitId].
      6>D:\b\1\_work\1531\s\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(68,6,68,6): Build error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[MobileUnitId]. [D:\b\1\_work\1531\s\DeviceConfiguration\DeviceConfiguration.sqlproj]
  ##[error]DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(67,8): Error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[DeviceId].
      6>D:\b\1\_work\1531\s\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(67,8,67,8): Build error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[DeviceId]. [D:\b\1\_work\1531\s\DeviceConfiguration\DeviceConfiguration.sqlproj]
  ##[error]DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(66,7): Error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].
      6>D:\b\1\_work\1531\s\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(66,7,66,7): Build error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState]. [D:\b\1\_work\1531\s\DeviceConfiguration\DeviceConfiguration.sqlproj]
  ##[error]DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(65,47): Error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[Value].
      6>D:\b\1\_work\1531\s\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileUnitPropertiesForAssetsList.sql(65,47,65,47): Build error SQL71562: Procedure: [mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList] has an unresolved reference to object [DeviceConfiguration.DataProcessing].[state].[MobileUnitState].[Value]. [D:\b\1\_work\1531\s\DeviceConfiguration\DeviceConfiguration.sqlproj]
      6>Done Building Project "D:\b\1\_work\1531\s\DeviceConfiguration\DeviceConfiguration.sqlproj" (default targets) -- FAILED.
      9>GenerateSqlTargetFrameworkMoniker:




  Build FAILED.