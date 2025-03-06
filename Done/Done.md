---
created: 2022-07-15T16:27
updated: 2025-03-06T12:00
---
# DONE

## LTE-248 MiX6000LTE Diagnostics modal not the same as the MiX6000/4000

  FE | Local | xxx
  
  INT
  MiX 6000 LTE

  Config/MR/Feature/LTE-248_MiX6000LTEDiagnostics.21.12.INT_ORI
  
## QA-4687 Unable to recommission assets

 https://uat.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/-5288458383792327239/-4022087827946895875?_exp=400
 
## TEL-17 [21.9 Waiting Paul] Extra thresholds (2)

  COMMON | Local | DEV | INT 
    ! Common NUGET | DEV | INT
  API | Local | INT
  BE | Local | INT
  FE | Local | INT

  Config/MR/Feature/TEL-17_NewThresholds.21.9.INT_ORI

  !LANG
  Excessive idling

  Excessive idle

  - ERROR

    at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(String callerMemberName, String callerFilePath, Int32 callerLineNumber) in D:\b\1\_work\537\s\MiX.Core\Retries\ElasticRetryStrategy.cs:line 110
      at MiX.Core.Retries.RetryStrategy.d__33.MoveNext() in D:\b\1\_work\537\s\MiX.Core\Retries\RetryStrategy.cs:line 362
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at MiX.Core.Retries.RetryStrategy.d__29`1.MoveNext() in D:\b\1\_work\537\s\MiX.Core\Retries\RetryStrategy.cs:line 295
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at MiX.Core.Clients.HttpRetries.d__11`1.MoveNext()
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at MiX.Core.Clients.HttpRetries.d__10`1.MoveNext()
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitRepository.d__8.MoveNext() in D:\b\4\_work\162\s\MiX.DeviceConfig.Api.Client\Repositories\MobileUnitRepository.cs:line 124
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
      at DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.TeltonikaMobileUnitManager.ChangeThresholds(String authToken, Int64 orgId, Int64 assetId, Nullable`1 overSpeedingKph, Nullable`1 overRevvingRpm, Nullable`1 harshBrakingKphps, Nullable`1 harshAccellerationKphps, Nullable`1 highEngineTemperatureCelcius, Nullable`1 harshCorneringMg, Nullable`1 excessiveIdlingSec) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\TeltonikaMobileUnitManager.cs:line 97
      at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.DeviceIntegrationManager.ChangeThresholds(String authToken, Int64 orgId, Int64 assetId, Nullable`1 overSpeedingKph, Nullable`1 overRevvingRpm, Nullable`1 harshBrakingKphps, Nullable`1 harshAccellerationKphps, Nullable`1 highEngineTemperatureCelcius, Nullable`1 harshCorneringMg, Nullable`1 excessiveIdlingSec, Boolean isTeltonika) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs:line 418
      at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.ChangeTrackAndTraceThresholds(String authToken, Int64 orgId, Int64 assetId, ThresholdsFormCarrier formCarrier) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 382
      at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_7(Object args) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 165
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.b__2(Object args) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.b__1() in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 281
      at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 190
      at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 120

  - ons moet net die mg na m/s2 conversion doen in die command sender soos wat ons vir die ander thresholds gedoen het
    > 10 m/s2 * 1000/9,80665 = 1020 mg
    > 5.9 * 1000 / 9.8 = 602.04081632653061224489795918367
    > 600mg is 5.9 m/s2
    > 600mrad = 5,8 m/s2 (die conversion van mg na m/s2: 9,80665/1000) (OLD?)
  - IGNORE:
    - excessive idle event thresholds aanvaar net waardes tussen 0 en 255 sekondes, nie 3600 soos gespec is nie. Rudi sal moet inweeg hier. Ons sal hiervoor ook rangecheck moet insit in die command sender om >255 te stel na 255
      > waardes tussen 0 en 255 sekondes
      > Default? 255?  

  - MR TEL 2

    http://config.dev.mixtelematics.com/#/fleet-admin/asset/details?id=1137162152733458432&orgId=3906835417853769299
    http://config.dev.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1137162152733458432&orgId=3906835417853769299

    http://localhost/mixfleet/#/fleet-admin/asset/details?id=1137162152733458432&orgId=3906835417853769299
    http://localhost/mixfleet/#/fleet-admin/asset/commissioning?id=1137162152733458432&orgId=3906835417853769299

  - LATEST

    - Excessive idle
      <event id="-7995443436338294858" type="11" legacyId="354" description="Excessive idle">
          <conditions>
              <condition id="-5651391176591936562" sequence="10" parameterId="-8998265156756701001" operator="&gt;" value="300" flags="1" />
          </conditions>
      </event>
      event id="-7995443436338294858"
      parameterId="-8998265156756701001"

      Events.HARSH_CORNERING


      So param: 
        TRACK_TRACE_CORNERING_THRESHOLD = 8019524306600152882;
      En Event: 
        id="4291175374538259638"  legacyId="29622" description="* Harsh Cornering"


    -HARSH CORNERING
      -4398378188999478703 vir [THREE_AXIS_HARSH_CORNERING]
      Param -8505014648878721343 en dit sal 0.25 wees. [THREE_AXIS_CORNERING_G_FORCE]

      <event id="-4398378188999478703" type="4" returnActionType="1" returnParameterId="-8505014648878721343" legacyId="189" description="3-Axis – Harsh Cornering">


  - current asset info




    config.AllEvents.Select(x => "Id " + x.Id + " DEId " + x.DefinitionEventId + " LEId " + x.LegacyEventId)

    config.AllSupportedParameters.Select(x => " ID: " + x.Id + " DDID: " + x.DefinitionDeviceId + " DPID: " + x.DefinitionParameterId + " LID: " + x.LibraryId)

    config.MonitoredEvents.Select(x => " ID: " + x.Id + " DEID: " + x.DefinitionEventId + " LEID: " + x.LegacyEventId)





    config.AllEvents.Select(x => "Id " + x.Id + " DEId " + x.DefinitionEventId + " LEId " + x.LegacyEventId)
    {System.Linq.Enumerable.WhereSelectListIterator<DynaMiX.Entities.ConfigAdmin.ResolvedConfig.Event.IEvent, string>}
        [0]: "Id -274151184200741267 DEId -7995443436338294858 LEId 354"
        [1]: "Id 4736823933901801094 DEId 4291175374538259638 LEId 29622"
    config.AllSupportedParameters.Select(x => " ID: " + x.Id + " DDID: " + x.DefinitionDeviceId + " DPID: " + x.DefinitionParameterId + " LID: " + x.LibraryId)
    {System.Linq.Enumerable.WhereSelectListIterator<DynaMiX.Entities.ConfigAdmin.IParameter, string>}
        [0]: " ID: 3592006106719189318 DDID: 8390531593309277252 DPID: -8998265156756701001 LID: 3906835417853769299"
        [1]: " ID: 7138142868836081371 DDID: 7481358147036515658 DPID: -4138506370119513461 LID: 3906835417853769299"
        [2]: " ID: 1326294628105601570 DDID: 8390531593309277252 DPID: -8773503912069575223 LID: 3906835417853769299"
        [3]: " ID: 6047817306470239368 DDID: 8390531593309277252 DPID: 7168821117511843328 LID: 3906835417853769299"
        [4]: " ID: -972428832333251557 DDID: 8390531593309277252 DPID: -3361659057359657382 LID: 3906835417853769299"
        [5]: " ID: 531887508846648812 DDID: 7481358147036515658 DPID: 7168821117511843328 LID: 3906835417853769299"
        [6]: " ID: 6236281344060302437 DDID: 8390531593309277252 DPID: 8019524306600152882 LID: 3906835417853769299"
        [7]: " ID: -1900619481510569603 DDID: 8390531593309277252 DPID: -997280659822459764 LID: 3906835417853769299"
    config.MonitoredEvents.Select(x => " ID: " + x.Id + " DEID: " + x.DefinitionEventId + " LEID: " + x.LegacyEventId)
    {System.Linq.Enumerable.WhereSelectListIterator<DynaMiX.Entities.ConfigAdmin.ResolvedConfig.Event.IEvent, string>}
        [0]: " ID: -274151184200741267 DEID: -7995443436338294858 LEID: 354"
        [1]: " ID: 4736823933901801094 DEID: 4291175374538259638 LEID: 29622"










  - Idle Param Id? 7168821117511843328?

    config.AllSupportedParameters.Select(x => " ID: " + x.Id + " DDID: " + x.DefinitionDeviceId + " DPID: " + x.DefinitionParameterId + " LID: " + x.LibraryId)
      [0]: " ID: -972428832333251557 DDID: 8390531593309277252 DPID: -3361659057359657382 LID: 2364975042774694384"
      [1]: " ID: -1900619481510569603 DDID: 8390531593309277252 DPID: -997280659822459764 LID: 2364975042774694384"
      [2]: " ID: 1326294628105601570 DDID: 8390531593309277252 DPID: -8773503912069575223 LID: 2364975042774694384"
      [3]: " ID: 6047817306470239368 DDID: 8390531593309277252 DPID: 7168821117511843328 LID: 2364975042774694384"
    
    config.MonitoredEvents.Select(x => " ID: " + x.Id + " DEID: " + x.DefinitionEventId + " LEID: " + x.LegacyEventId)
      [0]: " ID: -8803598759932557573 DEID: 6454149451280645233 LEID: 7"
      [1]: " ID: -1590047872585682637 DEID: -3890646499157906515 LEID: 1"
      [2]: " ID: 2344067455281778352 DEID: 4750800303282680186 LEID: 3"
      [3]: " ID: 8058629496156949672 DEID: -7372181092478897411 LEID: 2"

    config.AllEvents.Select(x => "Id " + x.Id + " DEId " + x.DefinitionEventId + " LEId " + x.LegacyEventId)
      [0]: "Id -8803598759932557573 DEId 6454149451280645233 LEId 7"
      [1]: "Id -4423067404001530476 DEId 4650840888823746694 LEId 5"
      [2]: "Id -1590047872585682637 DEId -3890646499157906515 LEId 1"
      [3]: "Id 2344067455281778352 DEId 4750800303282680186 LEId 3"
      [4]: "Id 3173325867028510066 DEId 4291175374538259638 LEId 29622"
      [5]: "Id 8058629496156949672 DEId -7372181092478897411 LEId 2"


  ABOVE SHOWS ITS NOT LINKED YET
    https://mixtelematics.visualstudio.com/Common/_git/Database/pullrequest/55670?_a=files&path=%2FDeviceConfiguration%2FScripts%2FDeploymentScripts%2FData%2FDevicesData.xml


  public const long ROAD_SPEED = -8773503912069575223;
  public const long ENGINE_RPM = 7168821117511843328;
  public const long ACCELERATION = -997280659822459764;
  public const long DECELERATION = -3361659057359657382;
  public const long FM_HIGH_ENGINE_TEMPERATURE = -8456574128637028132;
  public const long TRACK_TRACE_CORNERING_THRESHOLD = 8019524306600152882;
  public const long TIME_IN_MODE = -8998265156756701001;
  
  - https://mixtelematics.visualstudio.com/Common/_git/Database/pullrequest/55670?_a=files&path=%2FDeviceConfiguration%2FScripts%2FDeploymentScripts%2FData%2FDevicesData.xml

    <requiredEvents>
			<event id="-6249713384440061567" eventId="-3890646499157906515" info="Over speeding" />
			<event id="6884631588258599125" eventId="-7372181092478897411" info="Over Revving" />
			<event id="-1081783270343471977" eventId="4291175374538259638" info="* Harsh Cornering" />
			<event id="-7188565753438282738" eventId="4650840888823746694" info="Idle - excessive" />
			<event id="5981394396224030428" eventId="5981394396224030428" info="Jamming Detect" />
			<event id="368238088758698029" eventId="368238088758698029" info="Asset Towed" />
			<event id="1814841846951175422" eventId="1814841846951175422" info="Power Disconnect/Reconnect" />
			<event id="6194584995452978134" eventId="6194584995452978134" info="Impact Detect" />
		</requiredEvents>

    <requiredEvents>
			<event id="-2694640010250830764" eventId="-3890646499157906515" info="Over speeding" />
			<event id="7307476077620357734" eventId="-7372181092478897411" info="Over Revving" />
			<event id="6662025770420236541" eventId="4291175374538259638" info="* Harsh Cornering" />
			<event id="-4353502989143169539" eventId="4650840888823746694" info="Idle - excessive" />
			<event id="3022043530963886425" eventId="5981394396224030428" info="Jamming Detect" />
			<event id="3570717231243821094" eventId="368238088758698029" info="Asset Towed" />
			<event id="4974053671764442047" eventId="1814841846951175422" info="Power Disconnect/Reconnect" />
			<event id="1512990204655998215" eventId="6194584995452978134" info="Impact Detect" />
		</requiredEvents>

  - https://mixtelematics.visualstudio.com/Common/_git/Database/pullrequest/55781?_a=files&path=%2FDeviceConfiguration%2FScripts%2FDeploymentScripts%2FData%2FDevicesData.xml

    <parameters>
			<parameter id="3670773234267248691" parameterId="-8773503912069575223" calibrationType="29" info="Road speed" />
			<parameter id="6769260640122658007" parameterId="7168821117511843328" calibrationType="31" info="Engine RPM" />
			<parameter id="-8700669443677272724" parameterId="-997280659822459764" calibrationType="29" info="Acceleration" />
			<parameter id="-4319472248940811562" parameterId="-3361659057359657382" calibrationType="29" info="Deceleration" />
			<parameter id="4732840675737418308" parameterId="8019524306600152882" calibrationType="9" info="TrackTrace.Cornering" />
			<parameter id="8172834872148046068" parameterId="-8998265156756701001" calibrationType="13" info="Time in mode" />
		</parameters

    <parameters>
			<parameter id="1326294628105601570" parameterId="-8773503912069575223" calibrationType="29" info="Road speed" />
			<parameter id="6047817306470239368" parameterId="7168821117511843328" calibrationType="31" info="Engine RPM" />
			<parameter id="-1900619481510569603" parameterId="-997280659822459764" calibrationType="29" info="Acceleration" />
			<parameter id="-972428832333251557" parameterId="-3361659057359657382" calibrationType="29" info="Deceleration" />
			<parameter id="6236281344060302437" parameterId="8019524306600152882" calibrationType="9" info="TrackTrace.Cornering" />
			<parameter id="3592006106719189318" parameterId="-8998265156756701001" calibrationType="13" info="Time in mode" />
		</parameters>



  - Regression

    Ensure PaOBC HarshCornering still persists and is default 600

  - Notes
    SETUP: Might need to be added to the template

    - Excessive idle
        Excessive Idling
        Parameter: 11205
        Units of measure: seconds
        Min: 0
        Max: 3600
        Default: 300
        <event id="-4499384450369902462" eventId="4650840888823746694" info="Idle - excessive" />
        <event id="4650840888823746694" type="1" mnemonic="EXIDL" legacyId="5" description="Idle - excessive">

      - Harsh Cornering
        HarshConering
        Parameter: 11006
        Units of measure: rad/s
        Min: 0.5
        Max: 10
        DEFAULT: 5.9
        <event id="-591119167398504893" eventId="4291175374538259638" info="* Harsh Cornering" />
        <event id="4291175374538259638"  type="1" legacyId="29622" description="* Harsh Cornering" >


    API (can it persist the new ones? Does it consider it?)
      MobileUnitManager.cs (line 2820)
        Add two new ones here
        Also ensure it can be sent to the unit
        (TECHDEBT-41)
        Test against Marvin's unit

    FE (double check - think nothing needs to be done)

    BE (think I need to add these two spesifically. Also where MAX and MIN values are specified)
      /Logic/DynaMiX.Logic/ConfigAdmin/MobileUnitLevel/TeltonikaMobileUnitManager.cs

    UpdateMobileUnit: Proc: Also needs these two new ones

### SR-9719 [INT TEST] MiXTalk config changed...



2526



21.4

BE | Local | PR INT
FE | Local | PR INT

Config/MR/Bug/SR-9719_ConfigStatusShouldNotSet.21.4.PROD.ORI

SR-9719
FE: https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/54058
BE: https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/54066
  BE INT BRANCH: Config/MR/Bug/SR-9719_ConfigStatusShouldNotSet.21.7.INT.NA

ConfigChanged

-------

ng-model:

form.deviceTypeName
form.deviceTypeIdentifierTitle
form.deviceTypeIdentifierValue
form.deviceTypeIdentifierValueUI <--REMOVED THIS ONE -->
form.simCardPinCode
form.gprsEnabled
form.gprsApnPointName
form.gprsApnUsername
form.gprsApnPassword
form.gsmEnabled
form.gsmMsisdnNumber
form.smsEnabled
form.smsMobileDeviceNumber
form.smsMessageCentreNumber
form.satelliteCapable
form.satalliteDeviceId
form.iridiumSatelliteCapable
form.iridiumImei
form.iridiumContract


-- Not to have an effect
form.OrgIsMiXTalkEnabled
form.miXTalkIMEI
form.MiXTalkSIMNumber
form.miXTalkCarrierID
form.OrgIsStreamaxEnabled
form.streamaxSerialNumber
form.streamaxDeviceTypeID

--Saved by other means
assetChangeSatelliteModemTemplate.note
assetChangeSatelliteModemTemplate.newImeiNumber
changeMobileDeviceTemplate.deviceTypeId
changeMobileDeviceTemplate.configGroupId
changeMobileDeviceTemplate.mobileNumber
removeMobileDeviceTemplate.moveToDecommissionedSite
removeMobileDeviceTemplate.siteId
removeMobileDeviceTemplate.makeAssetInactive
removeMobileDeviceTemplate.notes
assetRemoveSatelliteModemTemplate.note
setOdoTemplate.odometer.value
setEngineHoursTemplate.engineHours
changeThresholdsTemplate.overSpeeding.value
changeThresholdsTemplate.overRevving.value
changeThresholdsTemplate.harshBraking.value
changeThresholdsTemplate.harshAcceleration.value
changeThresholdsTemplate.highEngineTemperature.value
changeThresholdsTemplate.harshCornering.value

-- Strongly doubt - check BE
assetUploadConfigTemplate.whenToUpload
assetDownloadConfigTemplate.plugSize
assetDownloadConfigTemplate.eventRatio

-------

I spoke to Zonika about this. I will add a flag on the carrier, which will be set to true in the UI if any fields other than the MiXTalk and StreamMax fields have changed. The flag will be checked before the "Config Changed" gets set.

https://integration.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1042140005620469760&orgId=2364975042774694384

WHAT SHOULD THIS BE SET TO?



### CONFIG-2567

Sorted by Jacques' fix... will influence and be tested by SR-8111

## SR-8295 [UAE Passed] IMSI not shown FROM UAT-524


!! DynaMiX.DeviceConfig.Services.API.Client !! Update this !!

API         | Local | 18.17
  GetDeviceStatesForMobileUnits (nuwe method)
Client      | Local | 18.17
  Uses the older client DynaMiX.DeviceConfig.Services.API.Client
BE          | Local | Next update PROXY from release above!
  Consume latest client (old proxy version)
  2 smalls changes in code


Config/Bug/MR/SR-8295_IMSI_onAssetPage.18.17.ALG.ORI
DynaMiX.Backend DS (Legacy)
18.17_2021.04.07.1


Attempting to gather dependency information for package 'DynaMiX.DeviceConfig.Services.API.Client.18.17.2' with respect to project 'MiXFleet\API\DynaMiX.API', targeting '.NETFramework,Version=v4.6.2'
One or more unresolved package dependency constraints detected in the existing packages.config file. All dependency constraints must be resolved to add or update packages. If these packages are being updated this message may be ignored, if not the following error(s) may be blocking the current package operation: 'DynaMiX.CanPlan.Services.API.Client 17.13.2 constraint: DynaMiX.DeviceConfig.API.Client.Core (>= 17.13.0)'

Attempting to gather dependency information for package 'DynaMiX.DeviceConfig.Services.API.Client.18.17.2' with respect to project 'Components\UnitConfiguration\MiX.UnitConfiguration.Generation', targeting '.NETFramework,Version=v4.6.2'
One or more unresolved package dependency constraints detected in the existing packages.config file. All dependency constraints must be resolved to add or update packages. If these packages are being updated this message may be ignored, if not the following error(s) may be blocking the current package operation: 'DynaMiX.CanPlan.Services.API.Client 17.13.2 constraint: DynaMiX.DeviceConfig.API.Client.Core (>= 17.13.0)'



ALG is still DynaMiX 18.17.3

JAcques:
so ja die ou client is updateable - ek het 'n script geskry wat dit nuget (wat jy steeds locally build as release version) na Azure Artifacts push


** ISSUE **

Severity	Code	Description	Project	File	Line	Suppression State
Error		Your project does not reference ".NETFramework,Version=v4.5.2" framework. Add a reference to ".NETFramework,Version=v4.5.2" in the "TargetFrameworks" property of your project file and then re-run NuGet restore.	Tabs.Mobile.Api.Client.Tests			
Error		Your project does not reference ".NETPortable,Version=v4.5,Profile=Profile259" framework. Add a reference to ".NETPortable,Version=v4.5,Profile=Profile259" in the "TargetFrameworks" property of your project file and then re-run NuGet restore.	Tabs.Mobile.Api.Client			


FROM UAT-524
FM unit
The Diagnostics window reads it from state.
The Asset list page reads it from mobileunit properties.
read the IMSI from the device config services API
Both the **backend** and **Deviceconfig.api** had to be changed.

OK - so dit lyk na n baie eenvoudige fix.

Die enigste potentiele ding wat ons sal moet check is die client.
So dit gebruik nog die ou client en ek weet deesdae doen ons nie meer nie, maar ek assume hulle sal nog die ou client he :-D

Die dele wat verander het...

API
  GetDeviceStatesForMobileUnits (nuwe method)
Client
  Uses the older client DynaMiX.DeviceConfig.Services.API.Client
BE
  Consume latest client (old proxy version)
  2 smalls changes in code

Config/Bug/MR/SR-8295_IMSI_onAssetPage.18.17.ALG.ORI

Ek dink dis baie doenbaar - maar mens sal net moet seker maak as mens daai ou branches pull dat als WEL daar is wat ons DINK daar is.

Net n nota vir toetsers as ons dit doen:
Testers please ensure that the asset list page now shows the IMSI. PS (if the IMSI is not available in the diagnostics, it will also not be available in the asset list page)




## OEM-166 EventId list for AssetId

  DB | Local

  Config/MR/Feature/OEM-166_EventIdsPerAssetId.21.8.INT.ORI

  BASED ON
  C:\Projects\Database\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\MobileUnit_GetEventConditionThresholds.sql



## OEM-165 EventId list for DeviceType

  DB | Local | DEV

  Config/MR/Feature/OEM-165_EventIdsPerMobileDeviceType.21.7.INT.ORI


  MobileDeviceType
  [mobileunit].[GetDefaultEventIdsByMobileDeviceType]

  [definition].[MobileDevices]
  [definition].[MobileDeviceTypes]
  
  [definition].[MobileDevices]
   dmd WITH (NOLOCK) on dmd.DeviceKey = mu.MobileDeviceKey


## TECHDEBT-41: Remove most EF

  REPOS:
    API | INT
    DB | INT

    Config/MR/Feature/TECHDEBT-41_OverwrittenConditionThresholds.21.7.INT.ORI

  Test?
    
    Test to see if Teltonika is registered:
    http://dsintapp06:9003/devices/867060033914892

    Teltonika API
    http://dsintapp06:9003/reference/api

    Org 1MT
    http://localhost/MiXFleet/#/fleet-admin/asset/commissioning?id=1094010937441591296&orgId=-5904178910191067669

    LOCAL curl to test:
    see "C:\Projects\swagger.http"



## TEL-3

  - REPOS:
    BE | Local | INT
    FE | Local (NA)
    Config/MR/Feature/TEL-3_OverwrittenConditionThresholds.21.7.INT.ORI

  (event) HARSH_ACCELERATION = 6454149451280645233
  (param) ACCELERATION = -997280659822459764
  
  (event) HARSH_BRAKING = 4750800303282680186
  (param) DECELERATION = -3361659057359657382

- ERROR
  	"StackTrace": "   at System.Uri.CreateThis(String uri, Boolean dontEscape, UriKind uriKind)\r\n   at System.Uri..ctor(String uriString)\r\n   at RestSharp.RestClient..ctor(String baseUrl)\r\n   at MiX.Connect.Teltonika.Web.Api.Client.CommsClient..ctor(String serverBaseUrl)\r\n   at DynaMiX.Services.API.Client.MiXConnect.MiXConnectTeltonikaProxy..ctor() in D:\\b\\2\\_work\\246\\s\\DynaMiX.Services.API.Client\\MiX.Connect\\MiXConnectTeltonikaProxy.cs:line 33\r\n   at DynaMiX.DeviceConfig.Logic.Initializer.<>c.<Initialize>b__0_29() in D:\\b\\2\\_work\\246\\s\\DynaMiX.DeviceConfig.Logic\\Initializer.cs:line 71\r\n   at MiX.DeviceIntegration.Core.Runtime.IOC.DependencyRegistry.CreateInstance[T](String name)\r\n   at MiX.DeviceIntegration.Core.Runtime.IOC.DependencyRegistry.GetInstance[T](Boolean singleton, String name)\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.AddOrUpdateMobileUnit(String authToken, MobileUnitConfiguration newMobileUnitConfig, Boolean uploadConfig) in D:\\b\\2\\_work\\246\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitManager.cs:line 2713\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.UpdateMobileUnitEventThresholds(String authToken, Int64 mobileUnitId, Dictionary`2 eventValues) in D:\\b\\2\\_work\\246\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitManager.cs:line 2499\r\n   at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitController.<>c__DisplayClass61_0.<UpdateMobileUnitEventThresholds>b__0() in D:\\b\\2\\_work\\246\\s\\DynaMiX.DeviceConfig.Services.API\\Controllers\\MobileUnitLevel\\MobileUnitController.cs:line 1300\r\n   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in D:\\b\\2\\_work\\246\\s\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 46",

- ERROR 2
    "StackTrace": "   at System.Data.Entity.Core.EntityClient.EntityConnection.Open()\r\n   at System.Data.Entity.Core.Objects.ObjectContext.EnsureConnection(Boolean shouldMonitorTransactions)\r\n   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)\r\n   at System.Data.Entity.Core.Objects.ObjectQuery`1.<>c__DisplayClass41_0.<GetResults>b__0()\r\n   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)\r\n   at System.Data.Entity.Core.Objects.ObjectQuery`1.GetResults(Nullable`1 forMergeOption)\r\n   at System.Data.Entity.Core.Objects.ObjectQuery`1.<System.Collections.Generic.IEnumerable<T>.GetEnumerator>b__31_0()\r\n   at System.Data.Entity.Internal.LazyEnumerator`1.MoveNext()\r\n   at System.Linq.Enumerable.FirstOrDefault[TSource](IEnumerable`1 source)\r\n   at DynaMiX.DeviceConfig.DataAccess.DeviceConfigRepository.GetMobileUnitAggregate(Int64 mobileUnitId) in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.DataAccess\\Repository\\MobileUnitLevel\\MobileUnit.cs:line 1570\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitConfigurationManager.GetMobileUnitConfiguration(String authToken, Int64 mobileUnitId) in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitConfigurationManager.cs:line 330\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.AddOrUpdateMobileUnit(String authToken, MobileUnitConfiguration newMobileUnitConfig, Boolean uploadConfig) in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitManager.cs:line 2701\r\n   at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.UpdateMobileUnitEventThresholds(String authToken, Int64 mobileUnitId, Dictionary`2 eventValues) in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitManager.cs:line 2492\r\n   at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitController.<>c__DisplayClass61_0.<UpdateMobileUnitEventThresholds>b__0() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Services.API\\Controllers\\MobileUnitLevel\\MobileUnitController.cs:line 1299\r\n   at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 46",


- CHANGES TO BE MADE
 
	- CancelPendingCommand (default is false, so not an issue)
	- mctProxy.SendCommand(muc, commands)

- ONLY NEED
  - mobileUnitConfig.DefaultEvents 		(xxxxx)
  - mobileUnitConfig.OverriddenEvents	(xxxx)
  - mobileUnitConfig.MobileUnitId 		(already have it)
    - mu.libraryId (getAllLibraryEvents)

- TSQL
  - CREATE TYPE [dbo].[ConditionThresholds] AS TABLE
    (
      DefinitionEventId   BIGINT          NOT NULL,
      Value               NVARCHAR(50)  NOT NULL
    )
    GO

  (eg. to use: [dbo].[IntSelectionIds])

- 

  

- SOME IDEAS
  
	List<TemplateEvent> defaultEvents = eventTemplate.TemplateEvents.Where(te => te.EventType != EventType.Hidden && te.EventType != EventType.SoftDeleted).OrderBy(e => e.Description).ToList();

	condition in defaultEvent.Conditions

	var overriddenEvent = overriddenEventConditionThresholds.Where(oe => oe.TemplateEventConditionId == condition.Id).FirstOrDefault();

	var configuredEvent = libraryEvents.Where(le => le.ReturnParameter != null && le.ReturnParameter.ParameterId == condition.DefinitionParameterId).FirstOrDefault();
  

  
- OTHER
> assetid, value, eventTemplate, evn, mu
	= templatEvent
	= condition.Id

> assetId, Dict(condition.Id, value), templateEvent, mu
	= 


TemplateCondition = templateEventFromDb.Conditions from dict.key
OverwrittenCondition = mu.OverridenEventConditionThresholds

If Value changed
(TemplateCondition.Value != Dict[0].Value)

	If OverwrittenCondition doesnt exist 
		add mu.OverwrittenConditions
		(new OverwrittenCondition(assetId, TemplateCondition.ID, Dict[0].Value))
	Else 
		set OverwrittenCondition Value to Dict[0].Value

If OverwrittenCondition exists, but not diff from UI, delete


id=1123313570331557888
orgId=2364975042774694384

curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{"6454149451280645233" : "13","-3890646499157906515" : "123","4750800303282680186" : "18","-7372181092478897411" : "4503"}' 'http://api.deviceconfig.int.development.domain.local/api/mobile-units/1123313570331557888/update-event-thresholds?authToken=96cf0066-e3ce-4b2f-84aa-f25eda55638d'

JSON for SWAGGER:
{"6454149451280645233" : "13","-3890646499157906515" : "123","4750800303282680186" : "18","-7372181092478897411" : "4503"}

Overwrittens found
mobileUnitConfig.OverriddenEvents.Select(o => o.DefinitionEventId + ": " + o.Value + ": " + o.Description)
    [0]: "6454149451280645233: 13: Harsh acceleration | Acceleration"
    [1]: "-3890646499157906515: 123: Over speeding | Road speed"
    [2]: "4750800303282680186: 18: Harsh braking | Deceleration"
    [3]: "-7372181092478897411: 4503: Over revving | Engine RPM"

parameterId

eventValues
Count = 4
    [0]: {[-997280659822459764, 13]}
    [1]: {[-8773503912069575223, 123]}
    [2]: {[-3361659057359657382, 18]}
    [3]: {[7168821117511843328, 4503]}

ACCELERATION = -997280659822459764
ROAD SPEED = -8773503912069575223
DECELERATION = -3361659057359657382
ENGINE RPM = 7168821117511843328

config.AllEvents.Select(e => new { e.Description, e.DefinitionEventId, e.Id })
    [0]: {{ Description = Harsh acceleration, DefinitionEventId = 6454149451280645233, Id = -8803598759932557573 }}
    [1]: {{ Description = Over speeding, DefinitionEventId = -3890646499157906515, Id = -1590047872585682637 }}
    [2]: {{ Description = Harsh braking, DefinitionEventId = 4750800303282680186, Id = 2344067455281778352 }}
    [3]: {{ Description = Over revving, DefinitionEventId = -7372181092478897411, Id = 8058629496156949672 }}

config.AllSupportedParameters.Select(p => new { p.Id, p.DefinitionDeviceId, p.DefinitionParameterId, p.LibraryId })
    [0]: {{ Id = -972428832333251557, DefinitionDeviceId = 8390531593309277252, DefinitionParameterId = -3361659057359657382, LibraryId = 2364975042774694384 }}
    [1]: {{ Id = -1900619481510569603, DefinitionDeviceId = 8390531593309277252, DefinitionParameterId = -997280659822459764, LibraryId = 2364975042774694384 }}
    [2]: {{ Id = 1326294628105601570, DefinitionDeviceId = 8390531593309277252, DefinitionParameterId = -8773503912069575223, LibraryId = 2364975042774694384 }}
    [3]: {{ Id = 6047817306470239368, DefinitionDeviceId = 8390531593309277252, DefinitionParameterId = 7168821117511843328, LibraryId = 2364975042774694384 }}

config.MonitoredEvents.Select(m => new { m.Description, m.Id, m.DefinitionEventId, m.LegacyEventId, m.ReturnLibraryParameterId })
    [0]: {{ Description = Harsh acceleration, Id = -8803598759932557573, DefinitionEventId = 6454149451280645233, LegacyEventId = 7, ReturnLibraryParameterId = -504779365600253129 }}
    [1]: {{ Description = Over speeding, Id = -1590047872585682637, DefinitionEventId = -3890646499157906515, LegacyEventId = 1, ReturnLibraryParameterId = -1722750960743175851 }}
    [2]: {{ Description = Harsh braking, Id = 2344067455281778352, DefinitionEventId = 4750800303282680186, LegacyEventId = 3, ReturnLibraryParameterId = 2889589996754472471 }}
    [3]: {{ Description = Over revving, Id = 8058629496156949672, DefinitionEventId = -7372181092478897411, LegacyEventId = 2, ReturnLibraryParameterId = 4116620002433302925 }}


config.MonitoredEvents[X].Conditions[Y].Value
eventValues
Count = 4
    [0]: {[-997280659822459764, 13]}
    [1]: {[-8773503912069575223, 123]}
    [2]: {[-3361659057359657382, 18]}
    [3]: {[7168821117511843328, 4503]}


      "EventTypeId": 6454149451280645233,
      "EventName": "Harsh Acceleration",

      "EventTypeId": 4750800303282680186,
      "EventName": "Harsh Braking",

      "EventTypeId": 4291175374538259638,
      "EventName": "Harsh Cornering",

      "EventTypeId": -3890646499157906515,
      "EventName": "Over speeding",

      "EventTypeId": -2864371101042705250,
      "EventName": "Road Speed Overspeeding",

### STM-378 Change StreamaxId UI deel




  

FE | Local | DEV | INT | DONE
BE (net carrier deel) | local | DEV | INT | DONE
LANGUAGE | DONE
  Change Streamax device
  Current serial number
  New serial number
  Value is invalid

ORI: Config/MR/Feature/STM-378_UI_ChangeStreamaxDeviceID.21.6.INT_ORI
MERGED: Config/DJMPZ/STM/STM-242_21.6

MERGE: FE: Config/MR/Feature/STM-378_UI_ChangeStreamaxDeviceID.STM-242_21.6_NA | DONE


!! For 21.6 FE, need to copy changes:
  
  STM-378: Removed duplicate button.| DONE
  https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/53996

  STM-378: Fixed button layout | DONE
  https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/54003


TOETS:
DEV: http://localhost/mixfleet/#/fleet-admin/asset/commissioning?id=1116443404660883456&orgId=3906835417853769299


### STM-375 Decommission all assets if disconnected from SP line

BE | Local | INT | DONE

ORI: Config/MR/STM-249_DecommissionSTMIfNoSPConnection.21.6.INT.ORI
MERGED: Config/DJMPZ/STM/STM-242_21.6

PR: DEV: https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/53808
PR: INT: https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/53807

Base of INT 21.6

Update Mobile device template

Changing a mobile device template will automatically update the configuration settings for all the assets using this template. All these assets will then show a "Configuration changed" status and will require the configuration to be compiled and uploaded for the changes to be effective on the mobile device.

Would you like to continue?

----

POST /config-admin/organisations/2364975042774694384/mobile-device-templates/-5093418988682952066/line-settings/4376715893163448311

C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\MobileDeviceTemplateCrudModule.cs
Line 69

----
var confgGroups = ConfigAdminRepository
				.GetConfigurationGroupsByMobileDeviceTemplateIds(new List<long>(new[] { fromUi.Id }));

List<MobileUnit> mobileUnits = ConfigAdminRepository.GetMobileUnitAggregatesByConfigurationGroupId(configurationGroup.Id);




### VM-242 SP Line


  DB: INT:  https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/53390
  
  --------------
  
    MiX.DeviceIntegration.Common | Local | Nuget DEV | Ignore Before | PR INT
    DB | Local | DEV
    API | Nuget DEV | DEV
  --------------
  DB | Local | DEV
  MiX.DeviceIntegration.Common | Local | Nuget DEV | 
  MiX.DeviceConfig | Nuget DEV | 
  MiX.Integrate | 
  DynaMiX.DeviceConfig.Services.API.Client
  API | Nuget DEV | DEV
  


MiX.DeviceIntegration.Common.2021.3.19.1.nuspec

MobileUnit_GetMobileUnitLine

C:\Projects\MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\MobileUnitLevel\MobileUnitLine.cs

  COMMON: Config/MR/Feature/STM-242_GetLines_AddedDeviceID.21.15.INT.ORI
  DB : Config/MR/Feature/STM-242_GetLines_AddedDeviceID.21.15.DEV.ORI
  API : Config/MR/Feature/STM-242_GetLines_AddedDeviceID.21.15.INT.ORI


?? DynaMiX.DeviceConfig.Common ?? NOPE

public long DeviceId { get; set; }

TODO TODAY:

- STM
  Part of this the GetLines stored proc changed. It will be tested while doing this, however, a quick smoke test to see if the following still works will be great: 
  - FusionData report (I don't think this is actually used, so ignore it)
  - DiagnosticData showing lines
  - 
- MixTalk
  Ek dink vir die werk wat ek gedoen het is die bg toets MEER as voldoende... so ek dink dis great.
  MAar - ek dink jou concern wat jy gehad het is steeds valid - ek dink as deel van ons voorstel om n storie te maak wat die user blok om te stuur na die eg 3e keer in 5 mins, moet ons ook die volgende insit:

    Matt vra wat hy doen... as 1e een pass - stuur hy dan ook die volgende twee
    Ons moet besluit oor die status wat ons vertoon - op die oomblik wys ons die laaste attempt se status

  MAar ek dink dit moet deel wees v n nuwe enhancement vir user experience! 


SEARCH FOR:
  GetMobileUnitLinesByGroupIdsAndMobileUnitIds (from MiX.DeviceConfig)
  MobileUnitConfigurationGroupDetail





  [mobileunit].[MobileUnit_GetAllMobileUnitLines]


  Lines Data

	<line id="4376715893163448311" name="SP" sort="800000" image="icon-consolidation" desc="Standalone peripheral" />

  Devices Data

  <new id="5555510227986128751" type="96" />




### VM-252 [DEV] Change MiX Talk commands implementation to work for all device types

API | Jacques | INT
MiX API Client | INT              (only test outstanding)
BE | local | DEV | Need INT and nugets




LATEST BE:
Config/MR/Feature/VM-252_MiXTalk.21.5.INT_na



BE: Config/MR/Feature/VM-252_MiXTalk.21.4.INT.ORI
API: Config/MR/Feature/VM-252_MiXTalk_20.4.DEV_ORI

var sendSettings = (int)MiX.DeviceIntegration.Common.Enums.CommandIdType.SendConfigurationToStandAloneDevice;


Jacques PRs:
https://mixtelematics.visualstudio.com/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/52154?_a=files
https://mixtelematics.visualstudio.com/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/52155?_a=files

TEST

cascade
SendTalkConnectMessageStatus


1	MTN
2	Vodacom
4	Telkom SA Ltd

1	+278393010212867	+27831000002
2	+278200702232668	+27829119
4	+278116000101052311	+2781191


Config/MR/Feature/VM-252_MiXTalk.21.4.INT.ORI
R

Regression:
- Ensure you can send the Master Number (no need to check whole loop, just ensure it ends up in the Messages table)
- Same for keypads
- Same for auto answer
- Same for cascade






### OBC-577 [PR 20.16] Error when compiling all assets for default config group for mobile phone

BE: Local

Config/MR/Bug/OBC-577_20.16.UAT.ORI


So my thinking behind this... The actual compile went through OK. It was during upload that I would all the time get a timeout due to not being able to connect to the database. So obviously something before this point is causing this, as other units work well.

I then decided to change how I compile and upload for mobile phone. I still go through this method:
CompileAndUploadConfigurationGroup > RequestConfigurationGroupCompileAndScheduleUpload
However, I then test if the template is for PaOBC. If this is the case I follow a similar path as for an individual PaOBC, when setting Thresholds (OBC-577).
We changed the individual PaOBC to rather make use of the API call:
DeviceConfigClient.MobileUnits.RequestMobileUnitConfigurationCompile(...

I have tested the above.
It is MUCH faster.
When I change eg. from Config Group > Asset > override template...
If I then Compile and upload group, this new value is sent correctly.

----

So for an individual asset it would do this:
AssetCommissioningModule.CompileAndUploadAssetConfiguration > configurationGroupManager.RequestAssetConfigurationCompileAndScheduleUpload > API
mucProxy.UpdateMobileUnitConfiguration

RequestCompile
IMobileUnitManager mobileUnitManager = DependencyResolver.GetInstance<IMobileUnitManager>(_context);
			MobileUnit mobileUnit = mobileUnitManager.GetMobileUnitAggregate(authToken, organisationId, assetId);
			mobileUnit.ConfigurationStatus = ConfigurationStatus.CompileRequested;
			ConfigAdminRepository.SaveEFContext();

RequestUpload
RequestUploadOldWay
TrackAndTraceMobileUnitManager.UploadMobilePhone



Kibana Test:
http://logging.mixdevelopment.com/app/kibana#/discover?_g=(filters:!(),refreshInterval:(pause:!f,value:5000),time:(from:'2020-11-27T07:32:00.000Z',to:now))&_a=(columns:!(_source),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:b0a88d70-0210-11ea-986d-37754e7c9f8f,key:Text,negate:!f,params:!('Can%20not%20request%20a%20compile%20when%20the%20configuration%20status%20is'),type:phrases,value:'Can%20not%20request%20a%20compile%20when%20the%20configuration%20status%20is'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(Text:'Can%20not%20request%20a%20compile%20when%20the%20configuration%20status%20is'))))))),index:b0a88d70-0210-11ea-986d-37754e7c9f8f,interval:auto,query:(language:lucene,query:'Can%20not%20request%20a%20compile%20when%20the%20configuration%20status%20is%20NotCommissioned'),sort:!(!('@timestamp',desc)))

Can not request a compile when the configuration status


GetMobileUnits

mdt.DefinitionDeviceId <-- rather use this one>
mdt.DsiMobileDeviceType

var result = DeviceConfigClient.MobileUnits.RequestMobileUnitConfigurationCompile(authToken, orgId, assetId, true).ConfigureAwait(false).GetAwaiter().GetResult();

bool isPhone = mobileUnitManager.IsTheDeviceAvailableForAsset(assetId, LogicalDevices.PHONE_COMMUNICATIONS);

PHONE_COMMUNICATIONS = -5806870339229589495
  PHONE = -7688187356053930045

![](Phone_PhoneComms.png)

ADD:

M4K na FM dan moet dit nie Unique identifier soek nie. Anders om het waar dit eintlik moet gebeur dan het dit nie gevra vir Unique identifier nie m.a.w FM na M4K

html
changeMobileDevice

ts
changeMobileDevice


BE: Check what is on the carrier:

changeMobilePhoneTemplate
  xxxxxxxxx

changeMobileDeviceTemplate
  xxxxxxxxxx


DST:
ZS/SCAN/SCAN-52_mergeDEV




### QA-2324 Battery voltage value returned displays 77 on Notification &lt;&gt; Info hub

<https://jira.mixtelematics.com/browse/QA-2324>

 

 

Thursday, 08 August 2019

10:59

 

<img src="./OneNoteExported/General/media/image129.png" style="width:9.32292in;height:4.76042in" alt="SCLCueryI [S use LIATNewTestOrgposONIocON 2ß16; [S select top Iøøø where Vehicleld and EventlD from tbEventData between &#39;2a19-a5-28&#39; and &#39;2a19-a5-29&#39; Sta rtD a te [S select top Iøøø where Vehicleld and EventlD from tbActivemessages and EventDate between &#39;2a19-a5-28&#39; Massages and 2a19-a5-29 100 % Evant Key Vehicle&#39; D Driverl D Original Driverl D Evant ID Evant Date Event Type Start Sequence Vehicle&#39; D 4096 Start Data 07000 Start Odometer NULL Valua StartGPSID NULL End Sequence NULL End Data NULL [shed MassageID 7069444 Phony 250 Recei vad Dat a 20W0528053820000 Evant ID 20W0528053806000 GPSID 21480346 11575062745098 Odometer 96884 79688 Speed 0 00000 " />

use UATNewTestOrgposONIocON\_2016

 

select top 1000 \* from tbEventData

where Vehicleld = 406

and EventlD = -996

And StartDate between '2019-05-28' and '2019-05-29'

 

select top 1000 \* from tbActiveMessages

where Vehicleld = 406

and EventlD = -996

and EventDate between '2019-05-28' and '2019-05-29'

 

 

 

SELECT DISTINCT o.iCompanyID, le.LegacyEventId

FROM library.Events le

INNER JOIN definition.Events de ON de.EventKey = le.EventKey

INNER JOIN definition.DeviceParameters ddp ON ddp.ParameterKey = de.ReturnParameterKey

INNER JOIN definition.CalibrationTypes ct ON ct.CalibrationType = ddp.CalibrationType

INNER JOIN library.Libraries ll ON ll.LibraryKey = le.LibraryKey

INNER JOIN \[FMONLINEDB\].dynamix.Organisations do ON do.GroupId = ll.GroupId

INNER JOIN \[FMONLINEDB\].dbo.Organisation o ON o.liOrgID = do.OrganisationId

WHERE ct.HasVariableCalibration = 0

AND o.iCompanyID is not null

AND le.LegacyEventId is not null

-- AND le.LegacyEventId = -996

 

SELECT top 10 \* FROM library.Events WHERE Description like '%battery low%'

Select top 10 \* FROM definition.Events where EventKey = 12598

SELECT top 10 \* FROM definition.DeviceParameters where ParameterKey = 414

SELECT top 10 \* FROM definition.CalibrationTypes where CalibrationType = 12

 

 

HSUATATS01

 

SQL08LST\\FOXTROT

 

 

<img src="./OneNoteExported/General/media/image130.png" style="width:5in;height:4.71875in" alt="e. Ven JOIN definition. Events de de. Eventkey = 12. Eventkey JOIN definition.DeviceParameters ddp ddp.ParameterKey = de.ReturnParameterKey JOIN definition-calibrationType5 ct Ol&#39; ct.CaIibrationType = ddp.CaIibrationType JOIN library.Librarie5 Il ON Il, LibraryKey = le. LibraryKey INNER JOIN do do. Groupld 11.6roupId INNER JOLN . dbo.organisaticn o Ou c. liorg:o • do.organisationld *ERE = o. iCompanyID is not null LegacyEuentId is act null e. egacy Stored proc wat dit toets SELECT top le Select top SELECT top le top lø • FRO&#39; library. Events WHERE Descripti ike • *attery • FRW definition. Events where EventKey • FRC*I definition.DeuicePara•eters where Par terKey • 414 Jou spesifieke event • FRIN definition.CaIibrationTypes &quot;here Calibr Resdts Messages Ljbt&amp;y Id J 8588088205955644885 Event 84&#39; i 12598 79 Event d EventTyve -996 Mnemcric Retu+dicn NULL 1 173 124 62 140 t 71 760 onType = 12 Rede dat dit nie calibrate nie... Desaiption Reum9aamAerKey Notes Oateupdat± NULL Type 5756887570117719* 3 &quot;1 4027984049149422642 -37365750367218301 ss .33798227593%323850 -3151681075060447174 -2028762414241557442 600112639433303619 7343474385221948983 -368548541231865739 12 Updated 201545-131 201505-131 201505-131 201505-131 201505-131 201545-131 Cd&amp;ationType &quot; Hage9egs o Nou moet ek uitvind hoekom hy so opgestel is :-) Thanks baie " />

 

 

<img src="./OneNoteExported/General/media/image131.png" style="width:7.6875in;height:0.65625in" alt="x CmdGetEventCaIibra...tRequiredList.sqI LoadCaIibrationTypes.sqI Mobile Unit_GetDiagnosticData.sqI Mobile Unit_GetAvai... TransportTypes .sql «calibraticnType calibraticnType= calibraticnT descri este s&quot; " />

 

 

 

<https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend?path=%2FEntities%2FDynaMiX.Entities%2FConfigAdmin%2FParameterCalibration&version=GBIntegration>

 

 

Ross: As it stands now the event value is wrong in lightning Resource Data as well

 

Data Processor or Generic notification service sends email?

 

Hendrik: Received by GPS from FM: Val:77

> For DB calibration is done
>
> basList.setItem("BatVoltage", nBatVoltage \* (((5.0 \* 11500) / 1.5) / 255));
>
> But when calculating the battery voltage for the notifications, no calibration is done.
>
> This is a bug in GPRS and has to be fixed??
>
>  
>
> I can see that the sproc call \[cmdGetEventCalibrationNotRequiredList\] to the DeviceConfiguration DB returns the CompanyID and Event ID of the event in questions which tells the DP not to calibrate the value before putting it on the Q. However currently DP does not call this same sproc to check if it should calibrate when writing to the DB. Can someone in the Config team please have a look if what this sproc is returning is actually valid as it seems to be more strict than the standard parameter calibration that is used when calling the sproc sqryVehicleParamDownloadConfig.
>
>  

**<u>INSPECT</u>**  
cmdGetEventCalibrationNotRequiredList





## SR-10440



  - CALL
    PUT https://alg.mixtelematics.com:443/DynaMiX.API/config-admin/5142497371717118183/config_groups/asset/5451889313265527547/upload

    {"WhenToUpload":0,"WhenToUploadDateTime":{"IsoDateTimeString":"2021-05-21T07:27:47","TimeZoneName":"W. Central Africa Standard Time","TimeZoneShortCode":"WAT"}}

  - HSATSIIS07 EXCEPTION:
    HSATSIIS07 EXCEPTION:
    Sequence contains no matching element
      at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.HandleErrorCodes(Uri uri, String requestUrl, JsonResponse response) in C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 60
      at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.DoPost(String url, Object body, RequestParameter[] parameters) in C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 148
      at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitCommandsProxy.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3)
      at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitCommandsProxy.UpdateMobileUnitConfiguration(String authToken, Int64 groupId, Int64 mobileUnitId)
      at DynaMiX.Logic.ConfigAdmin.TemplateLevel.ConfigurationGroupManager.RequestUpload(String authToken, Int64 orgId, MobileUnit mobileUnit, ZonedDateTime scheduleDateTime, Nullable`1 siteId) in D:\b\1\_work\173\s\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs:line 598
      at DynaMiX.Logic.ConfigAdmin.TemplateLevel.ConfigurationGroupManager.ScheduleAssetConfigurationUpload(String authToken, Int64 orgId, Int64 assetId, ZonedDateTime scheduleDateTime) in D:\b\1\_work\173\s\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs:line 534
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupActionsModule.UploadAssetConfiguration(String authToken, Int64 orgId, Int64 assetId, UploadTemplate uploadTemplate) in D:\b\1\_work\173\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupActionsModule.cs:line 135
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupActionsModule.<.ctor>b__1_4(Object args) in D:\b\1\_work\173\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupActionsModule.cs:line 57
      at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass37_0.<RegisterRoute>b__2(Object args) in D:\b\1\_work\173\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 488
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass14_1.<HandleVoid>b__1() in D:\b\1\_work\173\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 249
      at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\b\1\_work\173\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 165
      at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\b\1\_work\173\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 109
      
    Sequence contains no matching element
      at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.HandleErrorCodes(Uri uri, String requestUrl, JsonResponse response) in C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 60
      at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.DoPost(String url, Object body, RequestParameter[] parameters) in C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 148
      at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitCommandsProxy.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3)
      at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitCommandsProxy.UpdateMobileUnitConfiguration(String authToken, Int64 groupId, Int64 mobileUnitId)
      at DynaMiX.Logic.ConfigAdmin.TemplateLevel.ConfigurationGroupManager.RequestUpload(String authToken, Int64 orgId, MobileUnit mobileUnit, ZonedDateTime scheduleDateTime, Nullable`1 siteId) in D:\b\1\_work\173\s\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs:line 598
      at DynaMiX.Logic.ConfigAdmin.TemplateLevel.ConfigurationGroupManager.ScheduleAssetConfigurationUpload(String authToken, Int64 orgId, Int64 assetId, ZonedDateTime scheduleDateTime) in D:\b\1\_work\173\s\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs:line 534
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupActionsModule.UploadAssetConfiguration(String authToken, Int64 orgId, Int64 assetId, UploadTemplate uploadTemplate) in D:\b\1\_work\173\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupActionsModule.cs:line 135
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupActionsModule.<.ctor>b__1_4(Object args) in D:\b\1\_work\173\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupActionsModule.cs:line 57
      at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass37_0.<RegisterRoute>b__2(Object args) in D:\b\1\_work\173\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 488
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass14_1.<HandleVoid>b__1() in D:\b\1\_work\173\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 249
      at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\b\1\_work\173\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 165
      at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\b\1\_work\173\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 109


  - \\hsatsiis11\l$\WebServices\DynaMiX.DeviceConfig.Services.API
    DEBUG 2021-05-21T06:27:50+00:00 [tid:7   ] MobileUnitId=5451889313265527547 has DeviceFamily=M4K6K
    DEBUG 2021-05-21T06:27:50+00:00 [tid:7   ] MobileUnitId=5451889313265527547 is supported for Command=SendConfiguration
    DEBUG 2021-05-21T06:27:50+00:00 [tid:7   ] User agent: [browser] [HSATSIIS07] [POST] groupIds/{groupId}/command/{commandId}/mobile-units-list/aresupported time: 00:00:00.0130000 
    DEBUG 2021-05-21T06:27:50+00:00 [tid:12  ] Received SendCommandToMobileUnit Request (groupId=5142497371717118183, mobileUnitId=5451889313265527547, commandId=SendConfiguration, preferredTransport=, param1=, param2=, param3=)
    DEBUG 2021-05-21T06:27:50+00:00 [tid:12  ] MobileUnitId=5451889313265527547 has DeviceFamily=M4K6K
    ERROR 2021-05-21T06:27:50+00:00 [tid:12  ] System.InvalidOperationException: Sequence contains no matching element
      at System.Linq.Enumerable.Single[TSource](IEnumerable`1 source, Func`2 predicate)
      at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.CommandSenders.MiX4k6kCommandSender.PackageCommand(IMobileUnitManager mum, MobileUnitCommand muc) in D:\b\1\_work\2091\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\CommandSenders\MiX4k6kCommandSender.cs:line 136
      at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitCommandsManager.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3) in D:\b\1\_work\2091\s\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitCommandsManager.cs:line 73
      at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitCommandsController.<>c__DisplayClass0_0.<SendCommandToMobileUnit>b__0() in D:\b\1\_work\2091\s\DynaMiX.DeviceConfig.Services.API\Controllers\MobileUnitLevel\MobileUnitCommandsController.cs:line 48
      at DynaMiX.DeviceConfig.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in D:\b\1\_work\2091\s\DynaMiX.DeviceConfig.API.Core\Controllers\ControllerBase.cs:line 46

    -- 102

    - GetPendingOrLoadedConfigurationVersionForMobileUnit
    - GetConfigurationFilesForMobileUnit


### SR-8111 [Test] Timebased events

  PART2:
    API | Local | PR INT?
    Client | Local | INT & NUGET

    Config/MR/Bug/SR-8111_Part2_SentTimeZoneDeviation_NeedsToLogError.21.7.INT.ORI


    NUGET:
    MiX.DeviceConfig.Api.Client.2021.7.20210416.1.nupkg

	TESTS:
		SentTimeZoneDeviation

		Swagger > Works
		Client > Works
		Client App > Works

		FMAP > Clients (works) > Never actually sends command


  - UAT TEST UNIT BERNO
    Environment: UAT
    ORG ID: 5658 (orgId=-7418635377791898363)
    Branch: QA Team
    Database: QA Live Vehicles [UATNewTestOrgposONlocON_2016]
    Unit Type: FM 3607i/3617i
    IMEI# 351628093252909
    Asset ID: 152 (id = 875461538184634368 )
    Asset Description: Berno FM3617i Bench Test 03 Iridium/SAT BAS 1.80 E-19.03.13.13

    \\hsuatapp07\l$\Services\DynaMiX.DeviceConfig.Services.Fm.ActiveMessageProcessor


  TEST
    https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1113579701291151360&orgId=2364975042774694384
    MR FM Bench Unit
    95

    LegacyOrgId	748
    LegacyVehicleId 93

    - DAT FILE LIVES HERE ON INT:
      \\dsintapp07\d$\APCBackup\ORG748\93
      (OLD) \\dsintapp08\d$\APCBackup\ORG748\93

    - LOG files:
      \\DSINTAPP09\l$\Services\DynaMiX.DeviceConfig.Services.Fm.ActiveMessageProcessor

      "Received NEW_CONFIG_CONFIRMED event from mobile unit (MobileUnitId = "
      "). Sent TimeZone Deviation."

    - Events to look for in the dat files:

      Sent TimeZone Deviation

      29400 New Config Received (active only, not on dat file?) << we added logic to 29400 >>
      29450 - New Config Confirmed (still has comms)

      -32700 NEW Config
      -32698 Config RESET (new config or reset)

      15501 Before deviation
      15502 AFTER deviation
      15503 Tyd in dag / 3600
      15504 
      15505 (UNIT GOT [[Command 45]])  


		GprsAndSatamaticsMessageSender: Command sent to GPRS Service

    Logz
    https://app.logz.io/#/dashboard/kibana/discover?switchToAccountId=157279&_a=(columns:!(AppName,message),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:!('1113579701291151360'),type:phrases,value:'1113579701291151360'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(message:'1113579701291151360'))))))),index:'logzioCustomerIndex*',interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:'2021-04-13T09:00:00.000Z',to:'2021-04-13T09:10:00.000Z'))&accountIds=157752&accountIds=157986&accountIds=158898&accountIds=157279&accountIds=158426&accountIds=158424&accountIds=157736

    


    



- BE | Local | DEV | INT 21.5 | ?Prod / Done
- MiX.DeviceIntegration.Common | INT 21.5
- MiX.DeviceConfig | Local | INT 21.5 | ?Prod / Done
- API | Local | DEV | INT
  PROD Nuget change needed if retro fitted
  Config/MR/Bug/SR-8111_21.5.INT_na

OLDER
Config/MR/Bug/SR-8111_Command45_EndPoint.20.13.PROD_ORI
Config/MR/Bug/SR-8111_FmTimeAdjusterFix_20.11.PROD

My Bench Unit

FM 3607i Electronic Unit
PART NUMBER
440FT0655

SERIAL NUMBER
0655TE072403

IMEI NUMBER
351628098452728

TE 25/2019






BUTTON

      Dmx config username: config@mixtel.com
      Dmx config password: c0nf1gsvc!


      Cursor.Current = Cursors.WaitCursor;

			FmActiveMsgProcessor fmActiveMsgProcessor = new FmActiveMsgProcessor();
			fmActiveMsgProcessor.RegisterDependencies();

			//Happy path test
			var evntPass = new Event("deviceType", "748.93", new DateTime(), FmEvents.FmNewConfig.ToString(), 1000000d);
			evntPass.SetProperty("0", "TestValue");
			evntPass.SetProperty("1", "[SYSDB] [N_VIN] [1FT7W2A69CEA92034]");
			evntPass.SetProperty("2", "Happy path test");
			fmActiveMsgProcessor.msmqReader_MessageReceived(null, evntPass);
			MessageBox.Show(string.Format("'Happy path test' completed... Next test starting now."));


			Cursor.Current = Cursors.Default;


string authToken = _authenticationProxy.Authenticate("mraath@gmail.com",
							"Liselle7").AuthToken;

"Received NEW_CONFIG_CONFIRMED event from mobile unit (MobileUnitId = "
"). Sent TimeZone Deviation."
"Received NEW_CONFIG event from mobile unit (MobileUnitId ="

FM Unit must be set up for softclock
- events
- something else

LOGIC ADDED For 29400 !!!!

29400 New Config Received (active only, not on dat file?)
-32700 NEW Config
-32698 Config RESET (new config or reset)

29450 - New Config Confirmed (still has comms)

15501 Before deviation
15502 AFTER deviation
15503 Tyd in dag / 3600
15504 
15505 (UNIT GOT COMMAND45)  





 60 <-- DOnny Asset Id FM >

Requesting MobileUnitMapping for legacy 
Requesting MobileUnitMapping for MobileUnitId

4412900873233944263 (Do not edit) (Regression Testing Units)
http://config.dev.mixtelematics.com/#/fleet-admin/asset/details?id=4412900873233944263&orgId=2330833568360483679

1035376388697247744 (Mike) (Bench Units 2020)
http://config.dev.mixtelematics.com/#/fleet-admin/asset/details?id=1035376388697247744&orgId=3222089765699420885



DEBUG 2021-02-03T06:51:36+00:00 [tid:59  ] Not proccessing event with ID -71
DEBUG 2021-02-03T06:52:04+00:00 [tid:60  ] Event message received: 29400 for Vehicle Id 700
DEBUG 2021-02-03T06:52:05+00:00 [tid:60  ] DynaMiX.DeviceConfig.DataAccess.EF.Mappings.MobileUnitLevel.MobileUnitMap()
DEBUG 2021-02-03T06:52:07+00:00 [tid:60  ] Requesting MobileUnitMapping for legacy 1077 + 700
DEBUG 2021-02-03T06:52:08+00:00 [tid:60  ] Could not retrieve MobileUnitMapping for legacy 1077 + 700
WARN  2021-02-03T06:52:08+00:00 [tid:60  ] Active message received from asset that is no longer registered in dynamix,orgiID=1077 vid=700
DEBUG 2021-02-03T06:52:28+00:00 [tid:35  ] Not proccessing event with ID -71




Severity	Code	Description	Project	File	Line	Suppression State
Error	CS0104	'ServiceToMonitor' is an ambiguous reference between 'DynaMiX.DeviceConfig.Services.Monitoring.Settings.ServiceToMonitor' and 'MiX.DeviceIntegration.Common.Entities.Monitoring.ServiceToMonitor'	DynaMiX.DeviceConfig.Services.Monitoring	C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Monitoring\Email.cs	137	Active


using ServiceToMonitor = DynaMiX.DeviceConfig.Services.Monitoring.Settings.ServiceToMonitor;





.top_panel_sec {
    visibility: hidden;
}


.head_sec {
    visibility: hidden;
}

.gamepg-pnl>.container>.row>.sm-2-columns {
    visibility: hidden;
}

.instant-nav-menu, .instant-nav-menu * {
    visibility: hidden;
}

.after_reach_code {
    visibility: collapse;
}

div.rchcor {
    visibility: collapse;
}

.instru-blk {
    visibility: hidden;
}

.foot-sec {
    visibility: hidden;
}

#main {
    height: 100%;
    width: 100%;
    float: left;
    position: absolute;
    z-index: 1;
}




NEXT:
Call that new xxxxxxx endpoint
![](SR-8111_WhereToCallNewEndPoint.png)

Files for above EndPoint
![](SR-8111_EndPointAdded.png)


id=972632921446207488
&orgId=2364975042774694384

id=1055885292297347072
&orgId=2364975042774694384


public const string SendTimeZoneDeviation = 
  "group-id/{orgId}/mobile-units/{mobileUnitId}/configuration/send-timezone-deviation";

ConfigurationChanged
UploadSuccess
ConfigurationAccepted


void UpdateConfigurationStatus(string authToken, short legacyOrgId, short legacyVehicleId, ConfigurationStatus configurationStatus);

public const string UpdateConfigurationStatusFromLegacyIds =
    "legacy-org/{legacyOrgId}/legacy-vehicle/{legacyVehicleId}/configuration/update-configuration-status/{configurationStatus}";




This will ensure the timezone offset for softclock is resent to the unit 45 minutes after a successful config load.



-- MobileUnitConfiguration

public const string UpdateConfigurationStatusFromLegacyIds = "legacy-org/{legacyOrgId}/legacy-vehicle/{legacyVehicleId}/configuration/update-configuration-status/{configurationStatus}";

SR-8111: Going forward.

[Unit]

[Comms]

[client]
(changemobileunitstatus: legacyOrg, legacyVehicle)

[API]
(changemobileunitstatus)
<if FM & accepted>
(sendCommand45)
(getParams)
(sendCommand)

(SendMobileUnitCommand) exists!

--

deviceIntegrationManager.UpdateAssetTimezoneDeviation

--

Basic idea for handling the config accepted event to send Command 45.

![](SR-8111-Kafka-Event-Command%2045.png)

I will write a service that will check the Lightning Events Kafka queue.  
(This is the same thing Fleet does for their tracking service)
Their service is way more involved. I will just check for this:

EventTypeID = 8762220870379150868  (Config accepted)

When I get this from the queue I will make use of the Daylight Saving Adjuster to send command45 to the unit.
I will also log this to some logging system.

Questions:  
1) Is the event-type id I have correct?
2) Should I be writing a service to be hosted in a docker?
3) If so, is there an eg of this somewhere or should I use what fleet did as an example?
4) Is there a specific logging method I should use? Should I use Logstash or something else?

I did a quick poc, I can get the correct events. I now just need to send the command (and make this cleaner).
I do want to ask the above questions though, as I think this is a good learning curve and something we can make use of going forward.


--

OK - so jy gaan maar moet gracious wees met my. Ekt AMPER opgegee gister maar vandag maak dinge weer meer sin - dink ek :-D
My vraag is - ek wil net confirm dat jul beide Lightning EN non-lightning events in ag neem.

Van ons gesprek lyk dit of jul doen. In RedisTrackingService... sien ek jul kry ook n event Manager, wat lyk of dit ons goed in ag neem.
Ek sien ook jul luister na n stream vir lightning.

So ek sal nou meet duidelikheid kry oor hoe jul die twee bymekaar bring... maar uit bg. lyk dit wel dat jul beide consider?

--

Ja, daar is config transforms en als in. Dis die hele solution 
Jy gee om oor Fleet.Services.Tracking.Redis -> Fleet.Services.Tracking.Redis -> Program.cs en RedisTrackingService.cs

Program register die client as ek reg onthou en in die RedisTrackingService.cs subscribe ons net na die verskeie topics. In die ActiveEvents stream sal jy net wil early exit indien die eventTypeId nie jou id is nie

InternalAntenna = 0,
ExternalAntenna = 1

OK - so I had to have a look in our kode...
ExternalAntenna is true IF...

OverridenDevices
OverridenPeripheralDevices

mobileDeviceTemplateId
MobileDeviceTemplates.AllPeripheralDevices
MobileDeviceTemplates.AllLogicalDevices

public const long MIX6000LTE_GPS = -6684027584598198712;
public const long MIX2XXX_MOBILE_DEVICE_RANGE = 3628142212283117612;
public const long M6K_ONBOARD_GPS = 3876246157642342761; // System.Peripheral.MiX6000.OnBoardDevice.Gps
public const long EXTERNAL_GPS_ANTENNA_CONNECTED = 4939765917928749801;

for M6K:
  if
    buildContext.IsDeviceEnabled(LogicalDevices.MIX6000LTE_GPS)
  OR
    DevicePropertyValue(PeripheralDevices.M6K_ONBOARD_GPS, 
      DeviceProperties.EXTERNAL_GPS_ANTENNA_CONNECTED) = 1

for MIX2XXX:
  IF
    DevicePropertyValue(LogicalDevices.MIX2XXX_MOBILE_DEVICE_RANGE, 
      DynaMiX.Common.ConfigAdmin.Constants.Properties.EXTERNAL_GPS_ANTENNA_CONNECTED, 0) = 1

Hey Jacques. 

Die einde tot die lang opstel is net om te hoor of jy saamstem...
So n simple yes / no sal doen :-D

Gister het ek baie tyd spandeer om Phathuxolo te help met data wat hy wil he vir n report.
Basies wil hy weet of n unit external gps amtenna connected het. 
Ekt met Paul gecheck. Daars twee dele tot dit.

i) Die een deel check die property se value in [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] en as dit 1 is, is dit external gps.
Ekt dit reeds vir hom deur gegee.

ii) Die ander deel is om te check vir die...
IsDeviceEnabled(LogicalDevices.MIX6000LTE_GPS)
Maar vir daai check moet mens daai hele monster van die unit aggregate.
Ons moet die mobile unit, template, overwritten dinge, als bymekaar kry.
So dis baie werk :-D
Ekt bietjie begin - maar ek wil nie nog n dag waste nie.

Ekt vir hom gese ek dink eks nou op n plek waar ons n jira story nodig het om daai vir hom te gee.
Ekt ook gese die SQL wat ek hom gegee het het reeds baie info vir hom om mee te werk.

IS jy OK met dit dat ek vir hom vra om te reel vir n story om die 2e deel te doen?

deviceSettings.Add(
					new DeviceSetting(UdpParameterId.AntennaSelect,
							(AntennaSelectMode)
									buildContext.DevicePropertyValue(LogicalDevices.MIX2XXX_MOBILE_DEVICE_RANGE, DynaMiX.Common.ConfigAdmin.Constants.Properties.EXTERNAL_GPS_ANTENNA_CONNECTED, 0)));

if (buildContext.IsDeviceEnabled(LogicalDevices.MIX6000LTE_GPS))
				gpsAntennaSelect = 1;
			else
				gpsAntennaSelect = buildContext.DevicePropertyValue<byte>(PeripheralDevices.M6K_ONBOARD_GPS, DeviceProperties.EXTERNAL_GPS_ANTENNA_CONNECTED);

			deviceSettings.Add(new DeviceSetting(UdpParameterId.AntennaSelect, (AntennaSelectMode)gpsAntennaSelect));

--

Ons fetch lightning so

OrganisationManager.IsFeatureEnabled(orgId, OrgFeature.LightningTripsEvents, true);

Dan is dit hoe ons daai boolean gebruik

![](ActiveEventLightningAndNot.png)

Eks nie seker of julle omgee oor of Processing aan is of nie. Andersins gaan jy dalk tri state kort waar die OrgFeature dan ook net kyk vir DataProcessing.

--

ActiveEventManager.cs

Fleet Services API aanvaar reeds die org 3B enabled is
DynaMiX Backend doen die lookup

Sal beter wees aangesien die Daylight Savings service ook in die backend is, so al die manager (logic layer) calls behoort daar te wees om te sien of die org 3B enabled is of nie en dan 
- die DB call as die org nie is nie, 
- of Fleet Services API call as dit org wel 3B enabled is
Check daar die ActiveEventManager.cs
Maar ek sien dit soek alreeds 'n parameter of lightning enabled is of nie, so jy sal in een van die modules moet kyk wat die ActiveEventManager roep om te kyk watter call om te gebruik (vir 3B aan of af)

TIM >

--

As I can see in the issue this happens with FM units. Paul has also confirmed that mesa units work fine. I will now add in logic to send a command45 when config is uploaded to a unit.

Question. Can it ever happen that if we do the above, that the unit will FIRST receive the command45 and only then the config upload? If this is the case we will need to take this one step further.

If the above is true, then the softclock will be overwritten again. We will then need something (potentially in the DST service) to check when uploads have been accepted. Once that happens we need to send a new command45. We will need to check both lightning events and sql events. This will be a bit of a job.

Please let me know if the above will be necessary?

eventId="8762220870379150868" eventName="Configuration accepted"
<event id="8762220870379150868" type="4" returnActionType="3" returnParameterId="-4539270798360273587" legacyId="29400" description="Configuration accepted" />
Client.GetRangeForGroups(

MiX.Integrate
  GetRangeForGroups?


Hey Rudolf. Hoop dinge gaan goed.
Dalk kan jy my se met wie om te chat.

So ons het n SR waaraan ek werk.
In kort moet ek as n Active Event opgetel is, iets doen.
Die active event is vir Config Accepted.
Ek gaan dit sommer saam die Daylight Savings service hanteer.

Sekere orgs is mos Lightning, ander nie.
As ek MiX.Integrate se method GetRangeForGroups roep, sal dit van beide lightning en ou DB die events kry?
Sal dit ook active events bevat?

  MiX.Integrate\MiX.Integrate.Fleet.Logic\ActiveEvents\ActiveEventsManager.cs:
  153  
  154: 		public async Task<IList<ActiveEvent>> GetRangeForGroups(List<long> groupIds, string entityType, DateTime from, DateTime to, List<long> eventTypeIds = null)
  155  		{
  156  			var securityAccounts = new SecurityAccounts(SessionHelper.CurrentAccountId);
  157: 			var fleetEvents = await ActiveEventsRepo.GetRangeForGroupsAsync(groupIds, entityType, from, to, eventTypeIds, null, securityAccounts).ConfigureAwait(false);
  158  			if (fleetEvents == null || fleetEvents.Count == 0)

- Going forward

Enhance the Daylight savings service to Resend command45 when:  
- config accepted status changes  
- 15503's value is not correct (this could be more tricky)  

Also send when upload config

To get new config stuffs
- Lightning
- AssetDB



https://uk.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/-526653425951115306%20/981983764404281344/null

https://uk.mixtelematics.com/#/fleet-admin/asset/details?id=981983764404281344&orgId=-526653425951115306
id=981983764404281344  
orgId=-526653425951115306  
siteID? -2694619846386919722  
https://uk.mixtelematics.com  
marthinus.raath@mixtelematics.com  
Liselle7  


```sql
Select de.eventid from deviceconfiguration.library.events le
inner join deviceconfiguration.definition.events de on le.eventkey=de.eventkey 
Where librarykey=-1 and le.LegacyEventId=15505
```

```mysql
SELECT *
FROM Events
WHERE EventID = 8762220870379150868 LIMIT 100
```

----

Here is the stored proc
C:\Projects\_MiXTelematicsFiles\SR-8111 Softclock issue Finding Events outside the times after the command45 was received.sql

15501 Before deviation
15502 AFTER deviation
15503 Tyd in dag / 3600
15504 
15505 (UNIT GOT COMMAND45)  

-32700 NEW Config
-32698 Config RESET

- Findings 20200909

After investigating a lot of vehicles, events, dat and config files over different organisations, we found an edge case. Under this edge case the unit will not persist the softclock offset, which will result in the unit's event times not being calculated correctly.

The firmware, together with the config team, has put in place logic to persist the softclock offset in case a new config was loaded or config was reset on the vehicle. This was tested in the past by Paul and Dario. This logic will to the best of its ability persist the offset, however, in certain edge cases, it still looses the offset.

When looking into the amount of time spent on this issue to find this edge case, it is clearly seen that this doesn't happen all the time, and was not easy to pin down.

Now that we have seen this happen, we know by default to look out for these same symptoms in case this happens again.

So the findings in short are as follows:
When a command45 was sent, this command goes into a message table. From there it goes via comms to the vehicle. When the vehicle receives this command45, it will make an entry in the dat file. The event id is 15505, this shows that command45 was received, it is also easy to then see what value this unit received as the offset, etc. Another important event id is 15503, this event will show the time on the unit (this applies the offset). If you take the value in this event (the value is in seconds), you can work out the offset in time on the unit.

What we saw for the vehicle we found this edge case on was this. It received 15505, setting the offset to the right value (as per the messages table). When it reported the 15503 value, this offset was also correct, meaning the unit already applies the offset. In this case there were no incorrect timed events for this unit after this offset was correctly applied.

We later found new incorrect timed events. When we traced the dat file, we found that 15503 was no longer applying the correct offset, which meant the unit's time was incorrect, which would explain why the timed event triggered incorrectly.

This needed an explanation. We then traced the dat file further back and found that the first time 15503 was reporting the incorrect unit time was after these events occurred. Event -32700 (New Config) and Event -32698 (Config Reset). As soon as those happened, the 15503 event started reporting the incorrect time.

Herewith an example of where 15503 no longer reports the correct unit time.

![](15503_Offset_missing_command45.png)

In the above image, you can see the event -32698 triggered. After this you can see event 15503 reporting the unit time in seconds as 47202. If you work this to hours it is just over 13 hours, which is the same as the org time. This means there is no longer any offset applied on the unit.

The above points back to the edge case.

Our temporary suggestion / workaround:
For now we will give the FMTimeAdjuster tool to the RSO. They will then be able to resend the Command45 after this type of edge case is found. This will then resend 15505 and thus it will fix 15503. This will in turn unsure timed events will not report out of bounds.

Going forward:
We will need to enhance the logic to fix this, without the need for someone to manually send the command45. We suggest an enhancement which will resend the command45 automatically after a new config and after a config reset.
I would also suggest somewhere in the future we enhance the Daylight savings time, to look for units which never received the 15505 and then resend this command45.






- Tests 2020-08-18

From my latest tests... using SQL, it seems like everything is in order.
I will run my logic past Russell soon.

On **Al Malihi Transporting and Contracting** site all the events look fine.

On **Desert Man General Transport** site all the events look fine.

The only problem I could potentially find was this unit, which could have incorrect events set up on its config, as you can see the last command45 to that unit was middle 2019. This means the config could also be out.

| sdescription        | vehicleid | StartdateAST            | Command45Received       |
| ------------------- | --------- | ----------------------- |
| Test 2(8PM to 5 AM) | 40        | 2020-08-17 07:59:41.000 | 2019-07-21 10:23:38.000 |

I will ask @Russel to pull this unit's config to see the config on that unit.

- 20200901 (Outstanding - why the older command45 was not considered)

**Current status:**  
We compared the client's report to our sql results.
We are happy with the following finding:
There has been no incorrectly triggered events, after our manual command45 was received on the vehicles.
This is good news, showing that once the vehicle has received command45, the time for the events were correct.

**Process followed:**  
We had a look at the two event in the client's report.
To simplify my explanation I will only show the result for (Test 1)
The result shows events triggered outside of the time set up for the event.
This image comes from the client's report.

![](EventFromClientReport.png)

We then duplicated this using sql.
In order to understand why the events were triggered incorrectly we had a look at command45.
I added two columns for command45.
The first one shows command45 sent manually by myself and Russell.
It will be noticed that no incorrect events were triggered after this command45 was sent manually.

In the image below we have duplicated these incorrect events.
For the first record, it is clearly seen that there was no command45 received for this vehicle.
(Indicated in red)
We are therefore happy with the result.

For the next record, the incorrect date and time is the 2nd of Aug.
This is the last time this event triggered incorrectly for this unit.
(Indicated in green)
Our manual command45 was only received on the 11th of Aug.
(Indicated in blue)
After this manual command45, no incorrect events were triggered.

We do however have a question about the part indicated in purple.
(This will be commented on next)

![](Command45OldAndNewAndIssue.png)

**Outstanding investigation:**  

In the above image you can see that before our manual command45 was received for this unit,
the last last auto command45 received for this unit was the end of February.
(Indicated in purple)

Our question is why this command45 received, was not considered when triggering the event.

Currrently we think it could be:
- That these units' softclocks were reset in some way.
  - Maybe when receiving new config this will happen? We will ask Paul
  - Maybe the firmware or mechanism considering soft clock, ignores older settings?

We will investigate this further.

- Client

Runs event report - that picks this up

- Branch

Config/MR/Bug/SR-8111_FmTimeAdjusterFix_20.11.PROD

- Information

RW- TIme Based Events triggering incorrectly even after Command 45 was sent to units - MiX Telematics JIRA

Clipped from: <https://jira.mixtelematics.com/browse/SR-8111>

Client Complaint is that the timebased event is triggering outside of the configured bounds.

I have have used the Time adjustment tool to send **Command 45** to the units and still the units are triggering outside of bounds.

I have provided Dat files for one of the vehicles that have received the Command 45 and is still triggering incorrectly

This is logged as HIGH as there are 2 Dbs affected and teh Dealer wants to use this Events on all the databases

Event Name : TEST 2
![](SR-8111%20Conditions.png)

Sample Vehicle: **Vehicleid 181**

Sample Event Evaluated:
![](2020-08-07-11-06-31.png)

I have also noted that the assetdatatimezone is AST and on the UI it shows GST.
AST = UTC+4
GST=UTC +3     ??


<table><thead><tr class="header"><th>General status information </th><th> </th></tr></thead><tbody><tr class="odd"><td>Vehicleid </td><td>181</td></tr><tr class="even"><td>Mobileunitid</td><td>981983764404281344</td></tr><tr class="odd"><td>Raw unit date &amp; time (unadjusted)</td><td>20.7.2020. 14:29:18 UTC</td></tr><tr class="even"><td>Asset site time</td><td>20.7.2020. 18:29:18 (GST)</td></tr><tr class="odd"><td>Vehicle mode</td><td>Out of trip : 0-00:08:34</td></tr><tr class="even"><td>Driver</td><td>Unknown</td></tr><tr class="odd"><td>Speed</td><td>0 km/h</td></tr><tr class="even"><td>RPM</td><td>0</td></tr><tr class="odd"><td>Odometer</td><td>10497.1 km</td></tr><tr class="even"><td>GSM quality status</td><td>69%</td></tr><tr class="odd"><td>Current subtrip distance</td><td>0 km</td></tr><tr class="even"><td>GPRS context (restricted)</td><td>+CGDCONT=1,"IP","m2m"</td></tr><tr class="odd"><td>MSISDN</td><td>-</td></tr><tr class="even"><td>IMSI</td><td>4.24024E+14</td></tr><tr class="odd"><td>IMEI</td><td>3.51628E+14</td></tr><tr class="even"><td>CAN script device name</td><td> </td></tr><tr class="odd"><td>Mobile device driver version</td><td>15.2.25.11</td></tr><tr class="even"><td>Mobile device driver update date</td><td>23.12.2019. 11:34:24 (GST)</td></tr><tr class="odd"><td>CAN PIC driver version</td><td>15.5.2.23</td></tr><tr class="even"><td>CAN PIC driver update date</td><td>29.11.2012. 13:50:56 (GST)</td></tr></tbody></table>

- The dat file - not showing the command45  
![](2020-08-07-11-10-18.png)

- Error found > AuthToken
![](2020-08-05-14-40-20.png)  
Figured out that we needed to add extra code in for the https...  
This wasnt the case before  

- Testing  
https://uk.mixtelematics.com/#/fleet-admin/asset/details?id=981983764404281344&orgId=-526653425951115306
id=981983764404281344  
orgId=-526653425951115306  
siteID? -2694619846386919722  
https://uk.mixtelematics.com  
marthinus.raath@mixtelematics.com  
Liselle7  

1) Test if the command45 reaches this unit (FM 3607i) (Mercedes Truck 60759-2)
   - [x] Check the messages table (FM << / Mesa)
   - [  Check the dat? file for that code paul mentioned? 15502 15503
2) Ensure that this condition is on the unit
   - [x] Check the config file
3) Somehow test if this triggers wrong still
   - [  Ask Russell to check if the trigger is still wrong (set this up, check table)
4) Check if this the case: Asset Site Time, Org Time
   - [  Is the asset in the correct TZ
   - [  Is the org in the right timezone
5) Ensure the message I saw for the command45 is the correct offset
   - [  Look at the calculations and org settings

- SQL: Check messages in FM table for command45

Asset DB strored proc  
[dynamix].[Messages_GetDSTCommandsForLastYear]  

```sql
  --Get all messages for this asset sent in last year
  USE AlMalihiTransportingandContracting_2019;
  DECLARE @now datetime = '7 August 2020'
  SELECT DISTINCT
    [AssetId],
    [dtStarts] as [DtStarts],
    [sParams] as [SParams]
  FROM [dbo].[Messages] m WITH (NOLOCK)
    INNER JOIN [dynamix].[Assets] a WITH (NOLOCK) ON m.iVehicleID = a.VehicleId
  WHERE 
    AssetId = 981983764404281344
    AND REPLACE(sParams, ' ', '') LIKE 'CommandID=45;%'
    AND dtStarts >= DATEADD(YEAR, -1, @now)
    AND (dtExpires >= @now
      OR (dtExpires < @now AND ucState = 9))

  --Get Org Timezone Offset
  Select liGMTOffset, * from FMOnlineDB.dbo.Organisation
  WHERE sConnectDatabase = 'AlMalihiTransportingandContracting_2019'

  --Get Site TZ Offset
  SELECT top 5
    g.[GroupId],
    g.[Description],
    g.[Name],
    [Type]          = gt.[GroupTypeId],
    g.[DisplayTimeZone]
  FROM
    [DynaMiX].[DynaMiX_Groups].[Groups] g
      INNER JOIN
    [DynaMiX].[DynaMiX].[GroupTypes] gt ON g.[GroupTypeKey] = gt.[GroupTypeKey]
  WHERE     g.[GroupId] = -2694619846386919722 --SiteGroupId
```

- Tool used

![](2020-08-07-11-53-25.png)
![](2020-08-07-11-54-42.png)

The resource cannot be found.

Requested URL: /DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/-526653425951115306 /981983764404281344/null

https://uk.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/-526653425951115306%20/981983764404281344/null

![](2020-08-07-12-06-15.png)

CommandID=45 ;Params=dword:14400,dword:14400,dword:946688400 ;
Date effective: GMT: Saturday, January 1, 2000 1:00:00 AM

deviceIntegrationManager.SetCommandParameters(authToken, orgId, firstSiteGroupId, out secondsBefore, out secondsAfter, out ctime)

double orgSecondsOffset = orgSummary.GMTOffset
siteSecondsOffset = GetSecondsOffset(authToken, siteDateTime, siteTimeZone)
siteTimeZone = destinationGroup.DisplayTimeZone
DynaMiX_Groups].[Groups_Get
  site id sent in

NO Deviation found...    
    Both = siteSecondsOffset - orgSecondsOffset    
    Time 10 years back (this is what I see in the message - done when no deviation was found)    
ELSE    
    secondsBefore = secondsOffsetBeforeDeviation - orgSecondsOffset;    
	  secondsAfter = secondsOffsetAfterDeviation - orgSecondsOffset;     


- Org TZ
liGMTOffset (org offset) = 0
- Site TZ
site Display timezone = Arabian Standard Time ()
Current time in Arabia Standard Time ‎(UTC+3)

The message sents 14400
14400/60/60 = 4 hours
Above we see online it is 3 hours

> ... daylight saving time is not observed. Between 1982 and 2007, Iraq observed Arabia Daylight Time (UTC+04:00) but the government abolished DST in March 2008...
https://en.wikipedia.org/wiki/UTC%2B03:00#Arabia_Standard_Time

MAYBE the microsoft offsets we read is not up to date?

- Findings: So far

If we look at the database, we can see the following:
1) The org timezone offset is 0
2) The site timezone offset is 10800 (3*60*60)
3) The message offset is 14400 (4*60*60)

![](OffsetsFoundInUKDb.png)

It seems like the offset being set is **1 hour more** than it should be.

I looked on this wiki page and found the following:
> ... daylight saving time is not observed. Between 1982 and 2007, Iraq observed Arabia Daylight Time (UTC+04:00) but the government abolished DST in March 2008...
https://en.wikipedia.org/wiki/UTC%2B03:00#Arabia_Standard_Time

It could therefore be that that the microsoft source is incorrect, but before I just to conclusions I will write a small app that runs a test for AST TimeZone and see what the value returned is. If it is indeed UTC + 4 we have found our problem. If not, I will continue my search.

- TestApp

- [x] Write a test app to use Arabian Standard Time to work out the offset in windows

I have concluded in the test that the value returned for "Arabian Standard Time" is inconsistent with the value I see on other sites.

![](2020-08-07-15-42-49.png)

I will now speak to a few people to find out how we can fix this.

- Asset info

https://uk.mixtelematics.com/#/fleet-admin/asset/details?id=966073143833665536&orgId=4941797257640699807

Org: MiX Telematics / ME-DIRECT / ... / ME-FMSI UAE-UAE / Desert Man General Transport  
orgId: 4941797257640699807  
DB: DesertManGeneralTransport_2017  
Name: Ashok Leyland 51293-1  
AssetId: 119  
SiteId: -6168205532488898875  






## QA-4517 PaOBC Disable save on no Threshold changes

  FE | Local | INT | PR UAT

  Config/MR/Bug/QA-4517_DisableThresholdSave.21.7.UAT.ORI



  changeThresholdsTemplate.overSpeeding.value
  changeThresholdsTemplate.overRevving.value
  changeThresholdsTemplate.harshBraking.value
  changeThresholdsTemplate.harshAcceleration.value
  changeThresholdsTemplate.highEngineTemperature.value
  changeThresholdsTemplate.harshCornering.value
  
## QA-4521 PaOBC Removing asset and removing device for NO phone number supplied


  - Fixes:
    - Scenatio 1: when trying to remove the asset it shouldn't try to decommission the PaOBC if no number exists
    - 

  BE | Local | PR UAT

  BE: Config/MR/Bug/QA-4521_ShouldntDecommisison.21.7.UAT.ORI

  Config/MR/Bug/QA-4521_RemovePaOBC.21.7.UAT.ORI
### SR-9341 [Feedback] AU PaOBC Harsh Cornering issue

BE | Local | 

Config/MR/Bug/SR-9341_PaOBCErrorHarshCornering.21.4.INT_ORI

LibraryKey (743)
ParameterKey (702)
EventKey (144)
TemplateEventKey (415618) 
EventTemplateKey (10264)


AU
OrgID: -4272895230518739167
EventTemplateId: 7380602479991216794

INSERT INTO library.EventConditions (LibraryEventConditionId, LibraryKey, EventKey, Sequence, ParameterKey, Operator, Value, EditFlags, IsRequired, JoinOperator)
SELECT LibraryEventConditionId, @toLibraryKey, EventKey, Sequence, ParameterKey, Operator, Value, EditFlags, IsRequired, JoinOperator

INSERT INTO library.EventConditions (LibraryEventConditionId, LibraryKey, EventKey, Sequence, ParameterKey, Operator, Value, EditFlags, IsRequired, JoinOperator)
SELECT LibraryEventConditionId, @toLibraryKey, EventKey, Sequence, ParameterKey, Operator, Value, EditFlags, IsRequired, JoinOperator


[11:16 AM] Arnold Visser
Replace mix-au-sydrds-2.syd.production.local met 
mix-au-sydrds-2.cusdor.ng.0001.apse2.cache.amazonaws.com


Track trace cornering threshold
<parameter id="8019524306600152882"  systemName="TrackTrace.Cornering" description="Track trace cornering threshold" valueFormat="16" units="mg"/>


<event id="4291175374538259638"  type="1" legacyId="29622" description="* Harsh Cornering" >
  <conditions>
    <condition id="5647940314164842809" sequence="1" parameterId="8019524306600152882" operator="&gt;" value="600" flags="1" />
  </conditions>
</event>

public static readonly RouteDefinition UPDATE_EVENT_TEMPLATE_EVENT = new RouteDefinition(APISettings.Current.ApiBaseUrl, APISettings.Current.ConfigAdminBaseUrl, "/{orgId}/event_template_events/{id}", Core.Http.Constants.HTTPVerbs.PUT);



id=4064548945216537184&templateId=7358092118433527419

https://au.mixtelematics.com/DynaMiX.API/config-admin/-4272895230518739167/event_template_events/7380602479991216794
Request Method: PUT
PUT http://au.mixtelematics.com:80/DynaMiX.API/config-admin/-4272895230518739167/event_template_events/7380602479991216794


ERROR:
1087799396081532928

INT
templateEvent.EventId: -1483934163101502963
MyMiX 2019 - 3
MyMiX20193_2019


SELECT --TODO: MR: Operator? Sequence? JoinOperator
[ValueName] = lp.Description,
[PeripheralDevice] = null,
[LogicalDevice] = null,
[TemplateValue] = t.Value,
[AssetValue] = o.Value
FROM
 [dynamix].OverridenEventConditionThresholds o 
 INNER JOIN [dynamix].TemplateEventConditions t ON o.TemplateEventConditionId = t.TemplateEventConditionId
 INNER JOIN [dynamix].[LibraryParameters] lp ON lp.LibraryParameterId = t.DefinitionParameterId
WHERE o.MobileUnitId = @mobileUnit;

SELECT 
	[DefinitionParameterId] = tec.DefinitionParameterId,
	[ConfigType] = 'Event - condition threshold',
	[ConfigObjectSetting] = lp.[Description],
	[ConfigObject] = '', 
	[TemplateValue] = tec.Value,
	[AssetValue] = oe.Value,
	[UserName] = oe.UserName, 
	[DateTime] = oe.DateUpdated
	--,[oe]='',oe.*
	--,[tec]='',tec.*
	--,[lp]='',lp.*
FROM
 [dynamix].OverridenEventConditionThresholds oe 
 INNER JOIN [dynamix].TemplateEventConditions tec ON oe.TemplateEventConditionId = tec.TemplateEventConditionId
 INNER JOIN [dynamix].[LibraryParameters] lp ON lp.LibraryParameterId = tec.DefinitionParameterId
WHERE oe.MobileUnitId = @mobileUnit;


AU
templateEvent.EventId: 7380602479991216794

var condSeqNumsDb = ConfigAdminRepository.GetTemplateEventConditionSequencenums(templateEvent.Id).OrderBy(x => x).ToList();
  return Context.TemplateEventConditions.Where(x => x.TemplateEventId == eventTemplateId).Select(x => x.Sequence).ToList();
var minSeqNum = condSeqNumsDb.Min(); <-- Problem here>
var maxSeqNum = condSeqNumsDb.Max(); <-- Problem here>

Context.TemplateEventConditions.Where(x => x.TemplateEventId == eventTemplateId




### CONFIG-2592

https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Config%2FMR%2FBug%2FCONFIG-2592_PaOBCErrorHarshCornering.21.4.INT_ORI&targetRef=Integration&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0

### OBC-683 [PR with 588] Remove old duplicate decommissioning code

- AssetCommissioningManager
  RemoveMobilePhone
  
- AssetManager
  ChangeMobilePhone

## CONFIG-2694 [INT 21.7] REG: Change mobile device on Mesa units


FE | Local | 

MiX4000 
leaves the details the same > 'Change' button > a Swap unit function is essentially performed.
	 "Configuration changed' status and 
	 the Unique identifier should be greyed out.

INT, after the 'Change' button is clicked, the Configuration status incorrectly changes to "Not commissioned" and the Unique identifier field is editable (which it shouldn't be).

? regression from https://jira.mixtelematics.com/browse/SR-9719


Config/MR/Bug/CONFIG-2694_REG_ConfigChanged.21.7.INT.ORI


## VM-251 Commissioning status does not transition to "Failed" state after 30 minutes

358887099578088
+27670573336
asset id 1086451917092028416

Test on VM-54 sql
Test on mysql
SELECT Created, Updated, AssetId, CommandText, TimeToLive, AllowedRetries
FROM Command
WHERE AssetId = 1086451917092028416
ORDER BY Updated DESC


I can confirm that the status Donovan is seeing, is what it is in the database.

xxxxxxxxxxxxx

I can also confirm that our new code and "TimeToLive" has been deployed and we are sending these values on to the Comms team.

XXXXXXXXXXXXX

From our side we can't do more.

@Matt , in the above mentioned case I guess we should have received a "failed" status after 5 minutes (this is what the TimeToLive was set to).
Could you please investigate why we didn't receive this? It could be an issue further down the line though.




### OBC-588 Config: Decommission asset on the device on decommission or deletion

- MiX.DeviceIntegration | Local | INT
- MiX.DeviceConfig | Local | INT
- API | Local | INT
  
- FE | Config/MR/Feature/OBC-588_DecommissionPaOBC.21.4.INT.ORI
- BE | Local | BRANCH INT 21.5
  MiX.DeviceConfig.Api.Client
  MiX.DeviceIntegration.Common


+27760117376


BE - latest branch
Config/MR/Feature/OBC-588_DecommissionPaOBC.21.5.INT

List<long> failedAssetIds = new List<long>();
int iVal = 0;
var failedNum1 = DeviceConfigApi.DeviceConfigClient.MobileUnitCommands.SendCommandToMobileUnits(authToken, orgId, sendSettings, assetIds, (int)MessageTransport.SMSGateway, (uint)ParamPropertyType.VOICE_NUMBER1).ConfigureAwait(false).GetAwaiter().GetResult();
failedAssetIds.AddRange(failedNum1.Where(f => !string.IsNullOrEmpty(f.Value) && !int.TryParse(f.Value, out iVal)).Select(p => p.Key));

var failedNum1 = DeviceConfigApi.DeviceConfigClient.MobileUnitCommands.SendCommandToMobileUnits(authToken, orgId, sendSettings, new List<long> { assetId }, (int)MessageTransport.SMSGateway, (uint)propertyType).ConfigureAwait(false).GetAwaiter().GetResult();
var iVal = 0;
int ifailed = failedNum1.Where(f => !string.IsNullOrEmpty(f.Value) && !int.TryParse(f.Value, out iVal)).Count();
result = ifailed == 0;



Config/MR/Feature/OBC-588_DecommissionPaOBC.21.2.ORI

?? DeviceConfigClient.MobileUnits.SendCommandToMobileUnits 

- Outstanding

  - I have created the following tech-debt story to double handle other places in code where the decommissioning logic is called
  https://jira.mixtelematics.com/browse/OBC-683

  - I have created the following tech-debt story to remove the old way of determining if a unit is a PaOBC
  https://jira.mixtelematics.com/browse/OBC-682


- NEXT STEP: Investigate below two bugs - see stack trace why both errors occured - decide business logic - modal in UI? Stephan?

  1063516442322903040

  WARN  2021-02-16T07:06:07+00:00 [tid:20  ] Authenticated with DynaMiX method (Username: Marthinus Raath)
  WARN  2021-02-16T07:06:07+00:00 [tid:20  ] Authenticated with DynaMiX method (Username: Marthinus Raath)
  DEBUG 2021-02-16T07:06:07+00:00 [tid:20  ] MobileUnitId=1063516442322903040 has DeviceFamily=PHONE
  DEBUG 2021-02-16T07:06:07+00:00 [tid:20  ] Requesting MobileUnitMapping for MobileUnitId=1063516442322903040
  DEBUG 2021-02-16T07:06:07+00:00 [tid:20  ] Executed GetMobileUnitMappingsByMobileUnitId in 0.0045167 seconds
  DEBUG 2021-02-16T07:06:14+00:00 [tid:16  ] User agent: unknown [unknown] [POST] device/{deviceId}/property/{propertyId}/device-states time: 00:00:00.2520000 
  DEBUG 2021-02-16T07:06:16+00:00 [tid:14  ] STATE Updating of 10 second state interval triggered
  ERROR 2021-02-16T07:06:20+00:00 [tid:20  ] PaOBC Proxy error in the Send Decommissioning Request method. Asset id: 1063516442322903040. Exception: Response status code does not indicate success: 500 ().. Inner Exception: 
  ERROR 2021-02-16T07:06:21+00:00 [tid:20  ] PaOBC error when trying to Send Commissioning request. Unique identifier: [+27741433223]. Mobile unit id: 1063516442322903040.


  MessageStateType.Complete : MessageStateType.Failed
- TODO:

  Method SendDecommissioningRequest (returns bool - true if success)

  var failedNum1 = DeviceConfigApi.DeviceConfigClient.MobileUnits.SendCommandToMobileUnits(authToken, orgId, new List<long>() { assetId }, (int)CommandIdType.SendDecommissioningRequest, 0).ConfigureAwait(false).GetAwaiter().GetResult();


  var commConfig = CommissioningApiClient.Instance.GetCommissioningStatus(assetId).ConfigureAwait(false).GetAwaiter().GetResult();
  if (commConfig != null)
  {
    if (commConfig?.State == CommissioningState.Finalised)
    {
- Random

  1) Will do - I will update the story
  2) Perfect
  3) It is on shared BE code, so I will just do the work and notify Rudolf and Nadine
  4) I will send an eg. soonest possible
  5) Perfect

  LANG:
  Decommissioning failed
  Unable to complete the action because we are unable to reach the mobile device. Please try again or contact your administrator.

  Add in the IF this succeeds - THEN continue
  A few BE places:
  - remove mobile device or 
  - change mobile device, 
  - when config is notified that an asset using a mobile phone config group has been deleted in MiX Fleet Manager, 

  API: Issues: DynaMiX.DeviceConfig.Services.Monitoring.Settings.ServiceToMonitor

  1) Will do - I will update the story
  2) Perfect
  3) It is on shared BE code, so I will just do the work and notify Rudolf and Nadine
  4) I will send an eg. soonest possible
  5) Perfect

  groupId: 2364975042774694384
  MobileId: 1063516442322903040
- Error message: Notify Rudolf and Nadine

    I'm finally working on OBC-588 again.
    I was just asked to notify you of the following.
    When a user tries to delete an asset (PaOBC) from the assets list page, it should decommission the PaOBC.
    If this actions fails, then it shouldn't continue with deleting the asset. The user should be notified. The user can then try again.
    I saw that Fleet already handles error messages on this page. I am sending an error message the same way.
    It is displaying correctly. I just had to notify you of this.

    The information on the error message:
    Heading: "Decommissioning failed"
    Description: "Unable to complete the action because we are unable to reach the mobile device. Please try again or contact your administrator."

    This will be checked in with completion of OBC-588
- When performing a:
  - change mobile device, 
  - remove mobile device or 
  - when config is notified that an asset using a mobile phone config group has been deleted in MiX Fleet Manager, 

  DI Config to call the 
    CommissioningClient.DecommissionByAssetId(long asssetId) method 
  in the 
    MyMiX.PaOBC.Commissioning.Management.Client 
  will provide the phone with a push notification to tell it to revert to its pre-conditioned state.

  !! If the call to the Phone as OBC API fails then we must fail action (change mobile device, remove mobile device, delete asset) and log the error.

  Add a new command type to record this 'decomissioning request'


### QA-4336 MiXTalk Status incorrect

- FIX
  DECLARE @commandType NVARCHAR(25) = '';

  DECLARE @messages TABLE (
    MobileUnitId BIGINT, 
    CreationDateUtc DATETIMEOFFSET(7), 
    ExpiryDateUtc DATETIMEOFFSET(7), 
    MessageStatusDateUtc DATETIMEOFFSET(7), 
    MessageStatus TINYINT, 
    ParamsJson NVARCHAR(200)
  )

  --Added this for MiXTalk Backwards compatibility
  DECLARE @messageSubTypes TABLE (messageSubType INT);
  INSERT INTO @messageSubTypes VALUES (@messageSubType);
  IF (@messageSubType = 108) 
  BEGIN
      INSERT INTO @messageSubTypes VALUES (255); --Backwards compatible value for MiXTalk statuses
  END

  INSERT INTO @messages
    SELECT MobileUnitId, CreationDateUtc, ExpiryDateUtc, MessageStatusDateUtc, MessageStatus, ParamsJson
    FROM [state].[MobileUnitMessage] mum
    WHERE mum.MobileUnitId = 1042140005620469760 AND
      MessageSubType IN (SELECT [messageSubType] FROM @messageSubTypes)
      AND ((@commandType = 'null') OR (ParamsJson like '%"CommandType":"' + @commandType + '"%'))
      AND MessageStatus <> 11 --Exclude Rejected

API - DB
Config/MR/Bug/QA-4336_MiXTalkBackwardCompatibleSubType.21.5.UAT.ORI

MessageSubType
255 > 108

COULD HAVE UsED:
INNER JOIN @groupExtIds gids ON gids.id = CASE WHEN @grouprows > 1 THEN ll.GroupId ELSE gids.id END


Investigate:
- MiX.DeviceConfig > Nothing to change
- DynaMiX.Backend
  IsMiXTalkMasterNumberSet > DeviceConfigApi.DeviceConfigClient.MobileUnits.GetLatestMessageStatusForSpecificCommand
  GetTalkConnectMessageStatus > DeviceConfigApi.DeviceConfigClient.MobileUnits.GetLatestMessageStatusForSpecificCommand

Route: mobile-units-list/getlatestmessagestatus/messageSubType

DB: [state].[MobileUnitMessage_GetLatestMessageStatusForSpecificCommand]

Controller: GetLatestMessageStatusForSpecificCommand
ROUTE: GetLatestMessageStatusForSpecificCommand = "groupIds/{groupId}/mobile-units-list/getlatestmessagestatus/messageSubType/{messageSubType}/commandType/{commandType}";

### SR-9719 MiXTalk HUGE issue - will split out

muc.CommandType = configurationType
Consume new ones from Jacques

1086451917092028416

VM-252:
MiX.DeviceIntegration.Core | INT
MiX.DeviceConfig | JvW INT
DynaMiX.DeviceConfig | JvW INT



### CONFIG-2607

Other code had to be done

### SR-9391 [Feedback] Library Event Missing From UI

Navigate to https://au.mixtelematics.com/#/config-admin/events
Select Org: Chevron - Wheatstone DS
Search for Event name: Over Speeding - LNG Test 20 - Sharon Re Reporting Review

Request URL: https://au.mixtelematics.com/DynaMiX.API/config-admin/1704831732352957390/libraries/events
Request Method: GET

Request URL: https://au.mixtelematics.com/DynaMiX.API/config-admin/1704831732352957390/libraries/events
Request Method: GET

Event: Over Speeding - LNG Test 20 - Sharon Re Reporting Review
LibraryEventKey: 185501
LibraryEventID: -4746846307596164803
LegacyEventId: -238
Librarykey:423
EventKey: 19936
Lightning EventID: 906181885122256896

START HERE:

..\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryEventsModule.cs
And then go to this method:
GetEventList

GET_EVENT_LIST
GetEventList(string authenticationToken, long orgId)

OK - I got this from a local - DeviceConfiguration - Stackify Prefix

GET /config-admin/{id}/libraries/events

i) orgEventList

1) GET API.LibraryLevel.LibraryEvents.GetAllLibraryEventSummaries *this part passes*

GET /api/groupIds/2364975042774694384/event-summaries
SELECT Libraries, Events, Events (279)

SELECT [Extent1].[LibraryKey] AS [LibraryKey],[Extent2].[LibraryEventId] AS [LibraryEventId],[Extent3].[EventId] AS [EventId],[Extent1].[LibraryId] AS [LibraryId],[Extent2].[LegacyEventId] AS [LegacyEventId],[Extent2].[Description] AS [Description],[Extent3].[EventType] AS [EventType]
FROM [library].[Libraries] AS [Extent1]
INNER JOIN [library].[Events] AS [Extent2]
ON [Extent1].[LibraryKey] = [Extent2].[LibraryKey]
INNER JOIN [definition].[Events] AS [Extent3]
ON [Extent2].[EventKey] = [Extent3].[EventKey]
WHERE [Extent1].[GroupId] = 2364975042774694384


ii) dataCenterEventList

2) GET API.LibraryLevel.LibraryEvents.GetAllLibraryEventSummaries 

GET /api/groupIds/1/event-summaries
SELECT Libraries, Events, Events, Records (401)

SELECT [Extent1].[LibraryKey] AS [LibraryKey],[Extent2].[LibraryEventId] AS [LibraryEventId],[Extent3].[EventId] AS [EventId],[Extent1].[LibraryId] AS [LibraryId],[Extent2].[LegacyEventId] AS [LegacyEventId],[Extent2].[Description] AS [Description],[Extent3].[EventType] AS [EventType]
FROM [library].[Libraries] AS [Extent1]
INNER JOIN [library].[Events] AS [Extent2]
ON [Extent1].[LibraryKey] = [Extent2].[LibraryKey]
INNER JOIN [definition].[Events] AS [Extent3]
ON [Extent2].[EventKey] = [Extent3].[EventKey]
WHERE [Extent1].[GroupId] = 1                         <<--DataCenterGroupId, currently code returns 1 -->>


iii) dataCenterEventsThatCanNotBeMadeAvailable

3) GET API.LibraryLevel.LibraryEvents.GetEventIdsThatCanNotBeMadeAvailable 

GET /api/groupIds/1/2364975042774694384/eventIds

Settings_GetByName (1)

EXEC settings.Settings_getbyname
@settingName = 'LightFleetMode', @serviceName = 'MiX.DeviceIntegration.Core'

Events_GetEventIdsThatCannotBeMadeAvailable (455)

EXEC [library].[Events_geteventidsthatcannotbemadeavailable]
@sourceGroupId = 1, @targetGroupId = 2364975042774694384

-----------------

[library].[Events_GetEventIdsThatCannotBeMadeAvailable]", new { sourceGroupId, targetGroupId }

### CONFIG-2446 Iridium positions stopped working

xxxxx






### SR-9485 [Support Feedback] Black flag cant remove

US
Impersonate
https://us.mixtelematics.com/#/user-admin/user/personal-details?id=1257481205651451456&orgId=1

Asset in Config group
https://us.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=911559926065410048

HITS THIS
Request URL: https://us.mixtelematics.com/DynaMiX.API/config-admin/organisations/8821743720720757086/assets/911559926065410048/reset-events-to-config-group
Request Method: POST

ASSET:
https://us.mixtelematics.com/#/fleet-admin/asset/details?id=911559926065410048&orgId=8821743720720757086

It sends this in as the orgID: 8821743720720757086

            public static readonly RouteDefinition RESET_EVENTS_TO_CONFIG_GROUP = new RouteDefinition(API_BASE_URL, BASE_PATH, "/organisations/{orgId}/assets/{assetId}/reset-events-to-config-group", Core.Http.Constants.HTTPVerbs.POST);



<<<<<<
Asset level - Change mobile device
public const long ASSET_LEVEL_CHANGE_MOBILE_DEVICE = 520000005
FOR THE GROUPID
-- CHECK AUTH VALUE
later... _deviceConfigRepo.ResetAssetMobileUnit(mobileUnitId, resetType
>>>>>>


public const string ResetAssetMobileUnit = "groupId/{groupId}/mobile-units/{mobileUnitId}/reset/{resetType}";

----- issue

Vehicle ID: 20667
US
MIXTEL BR - NSO - Auto Viação Urubupungá
orgId=2703331115169289586
Error: 1086692979160793088

-----

ASSET_LEVEL_CHANGE_MOBILE_DEVICE = 520000005





Text:EXCEPTION! <?xml version="1.0" encoding="utf-16"?> <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <RequestId>1086692979160793088</RequestId> <AuthToken>1a7a81b1-aea9-41f2-aaee-43a3b735bc78</AuthToken> <AccountId>8379251753199858021</AccountId> <RequestJson>

{"WhatToReset":0}
</RequestJson> <RequestUrl>POST http://us.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/8821743720720757086/assets/911559926065410048/reset-events-to-config-group</RequestUrl> </ApiRequestInfo> Exception Type: System.Exception EXCEPTION! Exception of type 'DynaMiX.DeviceConfig.Common.Exceptions.UnAuthorisedException' was thrown. Exception Type: DynaMiX.DeviceConfig.Common.Exceptions.UnAuthorisedException Stack trace at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.HandleErrorCodes(Uri uri, String requestUrl, JsonResponse response) in F:_Sources\DynaMiX\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 75 at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.DoDelete(String url, RequestParameter[] parameters) in F:_Sources\DynaMiX\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 204 at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitProxy.ResetAssetMobileUnit(Int64 mobileUnitId, ResetType resettype, Int64 groupId, String authToken) at DynaMiX.Api.NancyModules.ConfigAdmin.MobileUnitLevel.MobileUnitMobileDeviceModule.ResetAssetMobileUnit(String authToken, Int64 orgId, Int64 assetId, ResetType resetType) in D:\b\1_work\535\s\API\DynaMiX.API\NancyModules\ConfigAdmin\MobileUnitLevel\MobileUnitMobileDeviceModule.cs:line 191 at DynaMiX.Api.NancyModules.ConfigAdmin.MobileUnitLevel.MobileUnitMobileDeviceModule.<.ctor>b__1_7(Object args) in D:\b\1_work\535\s\API\DynaMiX.API\NancyModules\ConfigAdmin\MobileUnitLevel\MobileUnitMobileDeviceModule.cs:line 75 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c_DisplayClass49_0.<RegisterRoute>b1(Object args) in D:\b\1_work\535\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 528 at DynaMiX.Core.Http.Nancy.ModuleBase.<>cDisplayClass26_1.<HandleVoid>b_1() in D:\b\1_work\535\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 281 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\b\1_work\535\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 190 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\b\1_work\535\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 120 AppName:DynaMiX.Api CorrelationId:1086692979160793088 Machine:HSVIRIIS16 Level:Error Member: host:10.77.19.215 @version:1 @timestamp:Jan 15 2021 @ 07:08:26.517 _id:3pLfBHcBsNo6V88mwAVu _type:_doc _index:us-application-logs-000802 _score: -




## STM-275 Peripherals design

------------------------

Jeremy, Jacques and I had a meeting discussing the database and UI solution mostly.

Here are my shorthand notes to this meeting.

Database:

We decided to go with something very similar to my DB Diagram above.

- We will be making use of the existing [definition.DeviceEventDependencies] table.
- Another table will be introduced, very much like the library.DeviceParameters and library.DeviceProperties.
This new table will be called [library.DeviceEvents]

This table will have all the needed keys and then a boolean field to indicate true (monitored) / false (not monitored)
Have a look at the other two similar tables to see how the link and connect to events and devices.
Also to see the typical fields needed.

High-level of how things will happen:

(Please make use of the existing logic for eg. properties and parameters, to ensure we are handling the events in a similar way)

- Peripheral & DeviceEvents:
DeviceEventDependencies will be used to link to the peripheral device
Whe the user makes a peripheral device (for standalone) available - the new events will be put into the library
The [definition.DeviceEventDependencies] will then also be made available
The events will be added to the table [library.DeviceEvents] (by default the monitoring will be set to true)

If the above events are detected in the table, it will then be shown in the Peripherals' event grid

- When creating a new device Template:
[template.DeviceEvents] to be populated (as per library)
The user will be able to Edit the template (read and write) - this should not dirty the config

- EventsTemplate is to exclude these events.

- Asset Level:
These events' monitoring values can be overwritten. (as per eg. DeviceParameters)
It should then show a black-flag
For this we need to create a table [mobileunit.OverriddenDeviceEvents] (to record and show black flags)

- API:
Read from this table to give the list of assets to comms team

- Compiler:
Needs to ignore these events.

- Migration:
We will not have Migration code for now. A script with enough information to show which assets were commissioned with this peripheral will be created. They can then manually de-commission the old and re-commission as new.

- Notes:
We need to see how deployments will be affected?

- Testers:
The Device Make available for other Devices / Events should not be affected

This can now be fleshed out into a few more stories.

------------------

I have read through this storie as well as related stories.



Please view my diagram that shows which parts are covered by which stories here:

xxxxxxx

https://1drv.ms/u/s!AkrBWbGn6pLcjrsGKrjuvKYScb8WSQ?e=d4vy0z

Questions I have:
(Indicated with red dots on the diagram)
- The need is for the Events Templates to not show these new MiXVision events. I couldn't find a story for this.
- Editing events names in the Events Library, is this included in STM-274 (it wasn't clear)
- For STM-269 we need to edit the event values (monitored / stop monitoring). I couldn't see that this story would include this. If not, we need to add a story for this. If it is supposed to include it, we might need to bump up the story points estimated.
- STM-269 also mentions that we should only make the line available if the peripheral was made available for the org. Is this in place? Should we not maybe check if ANY Standalone peripheral type has been made available as any of them can be connected to this new line, not just Streamax.
- Adding of the new Standalone Peripheral Line wasn't linked directly to a story. I did see that Paul mentioned that he has done this. Should we maybe create this spesific story and mark as completed by Paul?

Assumptions:

- No event templates are supposed to be used.
- Adding these later will be handled then (it will take some effort)
- The newly added events don't have event actions, conditions or any such linked tables as for other events.
- 

Investigation:

I had a look at our existing database. This was a huge undertaking as there as a lot of related tables and dependencies. Once I understood this better, I made a simpler DB Diagram. (Indicated on the diagram is two places I want to discuss with Jeremy)

xxxxxxxxxxxxx

From what I can see there are two potential places we could link the Peripherals with Events (This is to impolement the remainder of this spike... investigating how to do the Events Page for the Peripheral, and as I mentioned before, it will also be needed for editing the events' monitored status for the Mobile Device Template)

Jeremy, Jacques and myself will have a meeting to discuss the best way forward and once done I will add it as an additional comment here.






Implementation:

https://dbdiagram.io/d/601bfe8280d742080a392ec7

Section | How it works | What has been done | Going forward



## FE-930 [INT] Change Mobile Device save shouldnt be enabled

FE: Local

Config/MR/Bug/FE-930_DontAllowSaveMobileDevice_20.16.UAT.ORI

## VM-237 [PR INT] Change MiX Talk command timeout

DeviceIntegration Core: Local
API: Local

Config/MR/Feature/VM-237_MiXTalkCommandTimeout.21.2.ORI

(API) Config/MR/Feature/VM-237_MiXTalkCommandTimeout.20.16.ORI_na
(Core) Config/MR/Feature/VM-237_MiXTalkCommandTimeout.20.15.ORI_na

[LogExecutionTimeAttribute]

Settings
![](CodeSnippets%20Timezones.md)

Sending MiXTalk command:
http://localhost/DynaMiX.DeviceConfig.Services.API/api/groupIds/2364975042774694384/mobile-units/1066048771332816896/command/255?authToken=f269c36c-6ddb-4d25-a6b1-0f2595aa94b3&preferredTransport=5&param1=0

TalkConnectApiUrl

TalkConnectTimeToLive
TalkConnectNumberOfRetries

//int timeToLive = 30;
//int numberOfRetries = 2;


DynaMiX,Api,NancyModules,FleetAdmin,Assets,AssetCommissioningModule
DynaMiX,Logic,ConfigAdmin,MobileUnitLevel,MobileUnitManager
DynaMiX,Data,ConfigAdmin,ConfigAdminRepository
DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule
DynaMiX.Logic.ConfigAdmin.MobileUnitLevel.MobileUnitManager
DynaMiX.Data.ConfigAdmin.ConfigAdminRepository
DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.DeviceIntegrationManager
DynaMiX.Logic.FleetAdmin.AssetCommissioningManager

GetAssetCommissioning(
GetResolvedMobileDevice(System,Data,Entity,DynamicProxies,MobileUnit
GetResolvedMobileDevice(DynaMiX.Entities.ConfigAdmin.MobileUnitLevel.MobileUnit
GetMobileUnitAggregate(
GetResolvedMobileDevice(System.Data.Entity.DynamicProxies.MobileUnit
RefreshMobileUnitMappingCache(
UpdateAssetCommissionInformation(
UpdateAssetCommissioning(
UpdateMobileDevice(
ChangeAssetMobileUnit(
UpdateAssetConfigGroup(
DeleteAssetMobileUnit(
GetResolvedMobileDevice(

## SR-9207 [SUB] Adding Logs with SW
  
  See SR-7604
  
  Stopwatch sw = new Stopwatch();
  sw.Start();
  .............
  sw.Stop();
  Logger.Log($"SW: DynaMiX.API: AssetCommissioningManager: UpdateAssetCommissionInformation in {sw.Elapsed.TotalMilliseconds}", LoggingLevel.Debug);

## SR-9291 [PR INT] Dynamix both ZA and ENT Mobile device setting for IMEI to commission assets is grayed-out

FE: Local
BE: Local

Config/MR/Bug/SR-9291_ReEnableImeiAndButtons.20.16.PROD.ORI


[10:58 AM] Jacques Van Wyk
    

UK:
HSDUBIIS09
HSDUBIIS10
HSDUBIIS12
HSDUBIIS45

ENT:
HSENTIIS19
HSENTIIS20

ZA:
HSCPTIIS13
HSCPTIIS14
HSCPTIIS15
HSCPTIIS16




1) fixed by populating from BE
   
selectedDevice.identifierTitle
Backend....
changeMobileDeviceTemplate.identifierTitle = selectedDevice.identifierTitle

public string IdentifierTitle { get; set; }


2) commissioned (CHECK IN DB)

form.HasBeenCommissioned = mobileUnit.ConfigurationStatus != ConfigurationStatus.NotCommissioned;
Been like this for 9 months since Matthew changed it or moved it

    "Not commissioned", 0
		"Configuration changed", 1
		"Compile requested", 2
		"Compiling", 3
		"Compile failed", 4
		"Ready for upload", 5
		"Upload requested", 6
		"Uploading configuration", 7
		"Upload success", 8
		"Upload failed", 9
		"Plug generated", 10
		"Configuration accepted", 11
		"Configuration rejected", 12
		"Outdated configuration version", 13
		"Configuration warning", 14
		"Not yet commissioned", 15
		"Commissioned", 16
		"Pending", 1


Thoughts IMEI field:
1) Remove changeMobileDeviceTemplate.identifierTitle from TOP html part...
2) WHY think commissioned
3) changeMobileDeviceTemplate.identifierTitle change?

Buttons
4) Buttons....?

Removed new code...


Logic to disable input of IMEI:
1) assetConfigSummary.isMobilePhone                                   FALSE
2) OR doesn't have changeMobileDeviceTemplate.identifierTitle         NULL    <-- causes disable
3) OR doesn't have form.hasDeviceTypeIdentifier                       FALSE    
4) OR form.hasBeenCommissioned                                        TRUE    <-- causes disable
5) OR assetConfigSummary.isTDI                                        FALSE

Logic to disable "Change mobile device" and "Remove mobile device":
1) !form.canEditDetails                                               FALSE
2) (is not changeMobileDeviceTemplate.isFM                            TRUE    <--|
    AND doesn't have a value for oldForm.deviceTypeIdentifierValue)   TRUE    <--| Together cause disable




<input type="text" ng-hide="assetConfigSummary.isTDI || assetConfigSummary.isMobilePhone" ng-disabled="assetConfigSummary.isMobilePhone || !changeMobileDeviceTemplate.identifierTitle || !form.hasDeviceTypeIdentifier || form.hasBeenCommissioned || assetConfigSummary.isTDI" ng-model="form.deviceTypeIdentifierValue" name="deviceTypeIdentifierValue" dmx-validate="deviceTypeIdentifierValue" class="span12 ng-pristine ng-valid-dmx-required ng-valid ng-valid-fleet-mobile-unit-unique-identifier-async" dmx-required="" fleet:mobile-unit-unique-identifier-async-params="{ assetId: assetId }" fleet:mobile-unit-unique-identifier-async="" fleet:mobile-unit-unique-identifier-async-message="'Unique identifier already in use'" disabled="disabled" fleet-mobile-unit-unique-identifier-async="" fleet-mobile-unit-unique-identifier-async-message="'Unique identifier already in use'">

<button class="btn ml-3 mb-5" ng-show="form.canEditMobileDevice" ng-disabled="!form.canEditDetails || (!changeMobileDeviceTemplate.isFM &amp;&amp; !oldForm.deviceTypeIdentifierValue)" ng-click="changeMobileDevice()" dmx-translate="" disabled="disabled" style="">Change mobile device</button>

<button class="btn ml-3 mb-5" ng-show="form.canRemoveMobileDevice" ng-disabled="!form.canEditDetails || (!changeMobileDeviceTemplate.isFM &amp;&amp; !oldForm.deviceTypeIdentifierValue)" ng-click="removeMobileDevice()" dmx-translate="" disabled="disabled" style="">Remove mobile device</button>


- AssetConfigSummary: {Id: null, PendingConfigurationVersionId: "-6917641161398609813",…}
  CanChangeThresholds: false
  CanDownloadConfig: false
  CanSendDefaults: false
  CanSetEngineHours: true
  CanSetOdo: true
  ConfigStatusCanCompile: true
  ConfigStatusCanUpload: false
  ConfigurationStatus: "Configuration changed"
  CurrentConfigurationGeneratedBy: null
  CurrentConfigurationGeneratedDateTime: null
  CurrentConfigurationVersion: null
  CurrentConfigurationVersionId: null
  EngineHours: null
  Id: null
  IsBeacon: false
  IsEngineHoursSelected: true
  IsGoSafeTracker: false
  IsLommyEye: false
  IsMix2K: false
  **IsMobilePhone: false**
  IsPhoneTdi: false
  IsPhoneTrackTrace: false
  IsSatTrackTrace: false
  **IsTDI: false**
  IsTeltonika: false
  IsTrackAndTrace: false
  IsVT1310: false
  PendingConfigurationGeneratedBy: "Configuration Generation Service"
  PendingConfigurationGeneratedDateTime: {DateTime: "2020-07-22T19:54:55", IsoDateTimeString: "2020-07-22T19:54:55",…}
  PendingConfigurationVersion: "1595458493"
  PendingConfigurationVersionId: "-6917641161398609813"

- ChangeMobileDeviceTemplate: {ConfigGroupId: "-2564832300304079379", MobileNumber: null, IsMobilePhone: false, IsFM: false,…}
  ConfigGroupId: "-2564832300304079379"
  ConfigGroups: [{ConfigGroupId: "-6129643676183543140",…},…]
  Devices: [,…]
  HyperMedia: {Links: [{ModifyData: false, ExcludeBodyFromResponse: false, Rel: "save",…}],…}
  **IsFM: false**
  IsMobilePhone: false
  MobileNumber: null
  ??identifierTitle

- Form: {,…}
  AssetName: "IMPLANTAÇÃO MIX 4000|Script.CAN.J1939.DM_TT_FEF1_FE6C_FE6E_FEF2_FEE9.0250KBPS_02.2019.v1.12.0.0_DC"
  CanCompileConfig: true
  CanDeactivateIridiumAccount: false
  CanEditApnName: true
  **CanEditDetails: true**
  CanEditGsmDetails: true
  CanEditIridiumSatelliteDetails: true
  CanEditMobileDevice: true
  CanEditSatelliteDetails: true
  CanEditSimPin: true
  CanEditSmsDetails: true
  CanRemoveMobileDevice: true
  CanUploadConfig: true
  CanViewCommsLog: true
  CommissioningStatus: null
  CommunicationCapable: false
  CompileCapable: true
  DeviceIsStreamaxEnabled: true
  DeviceTypeIdentifierTitle: "Unique identifier"
  **DeviceTypeIdentifierValue: null**
  DeviceTypeName: "MiX4000"
  GprsApnPassword: null
  GprsApnPointName: null
  GprsApnUsername: null
  GprsCapable: false
  GprsEnabled: false
  GsmCapable: false
  GsmEnabled: false
  GsmMsisdnNumber: null
  **HasBeenCommissioned: true**
  **HasDeviceTypeIdentifier: true**
  HasIridiumImei: false
  HasUploadSchedule: true
  HyperMedia: {Links: [{ModifyData: false, ExcludeBodyFromResponse: false, Rel: "save",…},…],…}
  IridiumContract: ""
  IridiumError: null
  IridiumImei: ""
  IridiumSatelliteCapable: false
  IsMesaBased: false
  MiXTalkCarrierID: 0
  MiXTalkCarriers: null
  MiXTalkIMEI: null
  MiXTalkSIMNumber: null
  MobileDeviceId: "6183256567829462590"
  OrgIsMiXTalkEnabled: false
  OrgIsStreamaxEnabled: false
  SatalliteDeviceId: ""
  SatelliteCapable: false
  ShowOBCResendCommissioningSMS: false
  SimCardPinCode: ""
  SmsCapable: false
  SmsEnabled: false
  SmsMessageCentreNumber: null
  SmsMobileDeviceNumber: null
  StreamaxDeviceTypeID: null
  StreamaxDeviceTypes: null
  StreamaxSerialNumber: null
  Tabs: null
  UploadScheduleId: 3220


## CONFIG-2486 Date issues Comms Log



--------------

The main problem:
Incorrect time displaying on upload and download scheduler log

The Front-end (the popup module seen in the image) has html and ts
  - Herewith the ts file for this
  - C:\Projects\MiXFleet\UI\Js\Scheduler\Controllers\ViewLog.ts
  - I checked to see where it reads the data from
  - It does a GET to
  - Request URL: http://localhost/DynaMiX.API/scheduler/scheduler/upload/log/2364975042774694384/1010383751398969344/69?lastLogId=8502
  - The above calls the following in the back

The Back-end to get the data
  - C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\Scheduler\UploadScheduleListModule.cs
  - This... public static readonly RouteDefinition GET_UPLOAD_SCHEDULER_LOG = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/scheduler/upload/log/{orgId}/{assetId}/{id}", DynaMiX.Core.Http.Constants.HTTPVerbs.GET);
  - This calls the following method... GetUploadSchedulerLog
  - This calls: DataScheduleManager.GetLogForSchedule
  - This calls: Repository.GetLogForSchedule
  - This calls the stored proc: [dynamix].[DataScheduleLog_GetLatestByScheduleId]
  - I would then search around this how the date time gets converted
    - Maybe first check what times come back
    - then check how it gets converted
      - I see this happens in GetUploadSchedulerLog...
      - See assetSiteTimeZoneInfo and the ToCarrier(...)




## MX46-990 Comms log

Comms log for MiX2000/4000/6000

SP2:  

- FE: Add Set Odo section
- FE: Refresh logic for Set Odo section
- BE: Call the records for Set Odo section
- BE: Logic to see if an asset is configured for Engine hours
- FE: Add Engine hours section
- FE: Refresh logic for Engine hours section
- BE: Call the record for Engine hours section
- The part about "if this command fails is should display..." needs to be clarified

SProc:  

Need to show this value from the json params:  

![](CommsLogJsonParams.png)

I see the utility used to serialise it - also has a method to deserialise it
DeserializeCommandParameters

![](CommsLogJsonParamsDeserialise.png)

[state].[MobileUnitMessage_GetLastMessageStatusesForTypes]

public CommandIdType MessageSubType { get; set; }
public DateTimeOffset MessageStatusDateUtc { get; set; }
public MessageStateType MessageStatus { get; set; }

To Maribolle:  

OK - so returning the value seems like a lot of work... 
Sorry for not being able to write it all out - need to get on with other work now :-D  
Here is an attempt - please ask questions...
Basically you will need to ... 

1) CHANGE THE SQL:

In this file... You should return the extra field...

..\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnitMessage_GetLastMessageStatusesForTypes.sql

![](CommsLogReturnExtraField.png)

2) ADD THE FIELD: 

You will also need to then change where you call this stored proc, to include this field  

![](CommsLogJsonParamsField.png)

3) CHANGE THE METHOD:  

You then need to change the method in the following file...  

..\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\MobileUnitLevel\Command.cs  

To something like this...  

![](CommsLogNewReturnType.png)



In this same file I see the following things:  
- splitOn: ParamsJsonHolder.Splitter,
- GetFunctionToDeserializeParams(),
This seems related, but I wasn't sure how to work with this - seems like the SQL will need to return something else...
So I rather went with my idea :-D



This is where we get the comms log:  

![](CommsLogWhereToGetIt.png)

Some things Maribolle had to do:  

The **Back-End** It makes a call like this:  

../DynaMiX.API/config-admin/assets/5882517267388112686/organisations/2364975042774694384/commslog/config?device=MiX6000

We will need to add two new ones (one for each section)

They are found here:
..\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\CommsLog\CommsLogModule.cs

The **Client**  

It calls something like this on the old API:  
muProxy.GetLastMessageStatusesForConfigurationUpload

This client is being replaced, so will will need to make use of this client...  
MiX.DevicConfig.Api.Client
In the old client it is found here:  
GetLastMessageStatusesForConfigurationUpload C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API.Client\Proxies\MobileUnitLevel\MobileUnitCommandsProxy.cs

If you follow this logic you will come to a place where you specify which commands you need to retrieve...

List<long> typeIds = new List<long> { (long)CommandIdType.SendConfig, (long)CommandIdType.SendSettings }; 

As far as I can tell your two methods will need to call the following individually:
SetOdometerOffset = 104,
SetEngineHoursOffset = 105,

And this seems to be all of it...

So I think you could start on the BackEnd and Client part...

I will quickly ask Jacques about the Front End.


You will see that the Comms log for MiX2000/4000/6000 looks different than for eg. FM.  
I had a story a few years ago to make it look "newer" and work better. So it should be easy to add your work to this.  
I think you will just need to add the extra info they need to see from the Back-End. Let me have a look.  

Currently it looks like this.  

![](CommsLog.png.md)

From the Spec it seems like you have to add two more sections.  
Odometer and Engine Hours.  

From what I can see you will need to do a bit of Front-End work as well. So I am not sure that they can have you do this?  
I will ask Jacques.  

The Back-End 
It makes a call like this:  
../DynaMiX.API/config-admin/assets/5882517267388112686/organisations/2364975042774694384/commslog/config?device=MiX6000  
We will need to add two new ones (one for each section)  
They are found here:  
..\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\CommsLog\CommsLogModule.cs  

The Client  
It calls something like this on the old API:  
muProxy.GetLastMessageStatusesForConfigurationUpload  
This client is being replaced, so will will need to make use of this client...  
MiX.DevicConfig.Api.Client  
In the old client it is found here:  
GetLastMessageStatusesForConfigurationUpload
C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API.Client\Proxies\MobileUnitLevel\MobileUnitCommandsProxy.cs  

If you follow this logic you will come to a place where you specify which commands you need to retrieve...  
```c#
List<long> typeIds = new List<long> { (long)CommandIdType.SendConfig, (long)CommandIdType.SendSettings };
```

As far as I can tell your two methods will need to call the following individually:  
SetOdometerOffset = 104,  
SetEngineHoursOffset = 105,  

And this seems to be all of it...  

So I think you could start on the BackEnd and Client part...  

I will quickly ask Jacques about the Front End.  



## SR-8730 MiX Talk on Prod

SR
orgid: 5121
USE CrusadeLogisticsPTYLTDR2020CrusadeLogisticsPTYLTDR_2020;
Assetids:
(4833,4864,4865,4862,4863,4844,4841,4846,4847,4848,4849,4850,4851,4852,4853,4854,4855,4856)

## CONFIG-2531 DEV Dynamics is not accessible, site can't be reached



DSSTBCFGIIS01

authentication errors regarding CredSSP
IT restored access to DSSTBCFGHV02 - Network point stopped working
IP ranges for the VMs have been updated to cater for the VLAN change (move from Config to other building prompted this change)
access to all the VMs (incl. DSSTBCFGIIS01) that is hosting the Config Dev MiX Fleet Manager. Network connectivity restored and it's possible to RD.
External routing has been modified for the FM GPRS service so that FM unit sim cards traffic can get to DSSTBCFGGPRS01

MiX Fleet Manager UI isn't loading for some reason


 Chrome menu > Settings > Show advanced settings… > Change proxy settings… > LAN Settings and deselect "Use a proxy server for your LAN"



## QA-4199 Scheduler - Downloads: Object reference error

BE | PR UAT | PR INT

Config/MR/Bug/QA-4199_AddedExtraCheckingForNullAsset.21.2.UAT

sdfsdfsdfError no: 1089246804579155968

Request URL: https://uat.mixtelematics.com/DynaMiX.API/scheduler/scheduler/download/groups/-5288458383792327239
Request Method: GET

Kibana:
"Text": "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>\r\n<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\r\n  <RequestId>1089246804579155968</RequestId>\r\n  <AuthToken>2436ed2c-d228-44e4-b458-d79d6f864289</AuthToken>\r\n  <AccountId>7261693113146365683</AccountId>\r\n  <RequestJson />\r\n  <RequestUrl>GET https://uat.mixtelematics.com:443/DynaMiX.API/scheduler/scheduler/download/groups/-5288458383792327239</RequestUrl>\r\n</ApiRequestInfo>\r\n\tException Type: System.Exception\r\nEXCEPTION! 
**Object reference not set to an instance of an object.**
\r\n\tException Type: System.NullReferenceException\r\n\tStack trace    at 
**DynaMiX.Api.Carriers.Scheduler.Converter.ToListCarriers(List`1** schedules, String authToken, Int64 orgId, Boolean canEdit, ISession currentSession) 
in 
**D:\\b\\2\\_work\\375\\s\\API\\DynaMiX.API\\Carriers\\Scheduler\\Converter.cs:line 388\r\n**   at 
**DynaMiX.Api.NancyModules.Scheduler.DownloadScheduleListModule.GetDownloadSchedulerListPage(String** authToken, Int64 orgId) in D:\\b\\2\\_work\\375\\s\\API\\DynaMiX.API\\NancyModules\\Scheduler\\DownloadScheduleListModule.cs:line 98\r\n   
at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)\r\n   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__0(Object args) in D:\\b\\2\\_work\\375\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 497\r\n   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)\r\n   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\\b\\2\\_work\\375\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 287\r\n   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\\b\\2\\_work\\375\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 214\r\n   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\\b\\2\\_work\\375\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 148\r\n",

On UAT Jumpbox
http://api.fleet.uat.priv/swagger/index.html
/api/assets/organisation/{organisationId}/summary/assetids

SQL

USE BasicEnergyServicesPBU_2011;

--Vehicles
DECLARE @AllVehicles AS TABLE 
(AssetId BIGINT PRIMARY KEY)

INSERT INTO @AllVehicles
SELECT AssetId
FROM dynamix.Assets a WITH (NoLock)
  LEFT JOIN dbo.vehicles v WITH (NoLock)
  ON v.iVehicleID = a.VehicleId 


--Schedules
DECLARE @AllSchedules AS TABLE 
([ScheduleId] BIGINT, [Name] NVARCHAR(200), [AssetId] BIGINT)

INSERT INTO @AllSchedules
  SELECT
    [ScheduleId] = ds.liSchedID,
    --[ParentScheduleId] = CASE WHEN ds.liSchedID = ds.liExpandedID THEN NULL ELSE ds.liExpandedID END,
    [Name] = ds.sDesc,
    --[ScheduleTargetDescription] = COALESCE(v.sDesc, dbos.sName, vr.sName),
    --[ScheduleTargetType] = ds.ucObjectType,
    --[TripsEventsDownload] = CASE WHEN ds.bTransfer = 0 THEN 0 WHEN ds.bFullDownload = 1 THEN 2 ELSE 1 END,
    [AssetId] = a.AssetId
    --[SiteId] = dmxs.GroupId,
    --[CustomGroupId] = cg.CustomGroupId,
    --[Frequency] = ds.ucType,
    --[LastEditedBy] = ds.LastEditedBy,
    --[LastRun] = ds.dtLastRun,
    --[NextRun] = ds.dtNextRun,
    --[DateProcessed] = ds.dtProcessed,
    --[Retries] = ds.ucRetries,
    --[MaxRetries] = ds.ucMaxRetries,
    --[LastLogEntry] = [dynamix].[GetLatestScheduleLogMsgByScheduleId] (ds.liSchedID, null)
  FROM
    dbo.DataSchedule ds  with (NoLock)
  LEFT JOIN
    dynamix.Assets a  with (NoLock)
    ON ds.ucObjectType = 0 AND a.VehicleId = ds.liObjectID
  LEFT JOIN
    dbo.Vehicles v  with (NoLock)
    ON a.VehicleId = v.iVehicleID
  LEFT JOIN
    dynamix.Sites dmxs  with (NoLock)
    ON ds.ucObjectType = 1 AND dmxs.SiteId = ds.liObjectID
  LEFT JOIN
    dbo.Sites dbos  with (NoLock)
    ON dmxs.SiteId = dbos.liSiteID
  LEFT JOIN
    dynamix.CustomGroups cg  with (NoLock)
    ON ds.ucObjectType = 2 AND cg.VehicleReportingId = ds.liObjectID
  LEFT JOIN
    dbo.VehicleReporting vr  with (NoLock)
    ON cg.VehicleReportingId = vr.liGroupID
  WHERE
    ds.liSchedID NOT IN (SELECT ScheduleId FROM dynamix.DataScheduleLogRecurring) AND
    ds.liSchedID NOT IN (SELECT UploadScheduleId FROM dynamix.AssetDataSchedules WHERE UploadScheduleId IS NOT NULL) AND
    ds.liSchedID NOT IN (SELECT DownloadNowScheduleId FROM dynamix.AssetDataSchedules WHERE DownloadNowScheduleId IS NOT NULL) AND
    ds.bDeleted = 0


Select * FROM @AllSchedules s
LEFT OUTER JOIN @AllVehicles v
ON v.AssetId = s.AssetId
--WHERE v.AssetId IS NULL

/*
DELETE FROM dbo.DataSchedule
Where liSchedID IN (143,157,158,159,163,185,193,211,321,323)
*/


## QA-4211 Doesnt timeout

Check setting

![](VM-MiXTalk-Timeout%20Setting.png)

Ask Matt

## OBC-579 [PR 20.16] Problems with Changing Mobile device

FE: Local > INT > PR 20.16
BE: Local > INT > PR 20.16
API: Local > INT > PR 20.16

Config/MR/Bug/OBC-579_20.16.UAT.ORI

OBC-579: Merge Change Mobile Phone Logic into INT for testing

OBC-579, OBC-571, QA-4062: Merge closed issues to UAT


FE:
https://dev.azure.com/MiXTelematics/Common/_releaseProgress?_a=release-pipeline-progress&releaseId=22837

BE:
https://dev.azure.com/MiXTelematics/Common/_releaseProgress?_a=release-pipeline-progress&releaseId=22839

BE (weet nie of die of die bg een eerder moet gebeur nie - ek dink DIE een):
https://dev.azure.com/MiXTelematics/Common/_releaseProgress?_a=release-pipeline-progress&releaseId=22840

DeviceConfig API:
https://dev.azure.com/MiXTelematics/DeviceIntegration/_releaseProgress?_a=release-pipeline-progress&releaseId=14973


## OBC-571 [PR 20.16] Getting an error when changing device type from Mix2310i back to Mobile device

GetMobileDeviceType
SetMobileDeviceType

MiX.DeviceIntegration.Common.Interfaces.ICache


[mobileunit].[MobileUnit_GetDefinitionMobileDeviceType] ??

DeviceIntegrationManager.RefreshMobileUnitMappingCache
RemoveItem 
SetItem 



FE
$dynamicScope.changeMobileDeviceTemplate.isFM = selectedDevice

- TDI related devices - ensure they work! To and from.

    [0]: "6710364014173584261"  : "FM 3300/3310 (FM300 Communicator)"   MobileDevices.FM33x0
    [1]: "-1815797007298898523" : "FM 3507i/3517i"                      MobileDevices.FM35x7i
    [2]: "5885262600288608221"  : "FM 3607i/3617i"                      MobileDevices.FM36x7i
    [3]: "2805417112665854608"  : "FM 3707i/3717i"                      MobileDevices.FM37x7i


## QA-4062 [PR 20.16] BE: QA - Phone as OBC - Error when changing mobile device from mobile phone to FM or MiX 4000

ddd

## OBC-513 Asset not transitioning to "Upload requested"

BE: Local  

Config/MR/Feature/OBC-513_Upload_Workflow.20.16.INT_ORI

Compile
> Compile requested...
> Request upload > Upload Requested



## SR-8872 Make location unavailable - Lightning?

ENT
ORG ID: 404
orgId=-5858119684662776138
Intercape Mainliner
Location id=-5845976541497744560
IC Mountain Pass - Grahamstown (80km/h)

Event / SSE


location is removed from all events

SELECT top 1 * from [IntercapeMainliner2_2015].Dynamix.maplocations d WHERE d.FmLocationId = -5845976541497744560;
SELECT top 1 * FROM [DeviceConfiguration].library.Locations L WHERE L.DmxLocationId = -5845976541497744560;
UPDATE [DeviceConfiguration].library.Locations SET Deleted = 1 WHERE DmxLocationId = -5845976541497744560;


## SR-7821 Time from on unit

Gave comment from Michael as to how to set it

## OBC-560 (PR UAT) Compile button is enabled when the device is not yet commissioned

BE: Local - INT - TEST

Config/MR/Bug/OBC-560_20.16.UAT.ORI
Config/MR/Bug/OBC-560_INT_na

## OBC-576 (PR UAT) Changing the Mobile number to the same number sends the sms to the device twice

FE: Local - INT - TEST

Config/MR/Bug/OBC-576_20.16.UAT.ORI
Config/MR/Bug/OBC-576_21.01.INT_na

$dynamicScope.form
$dynamicScope.oldForm
$dynamicScope.changeMobileDeviceTemplate
configGroupId
deviceTypeId
$dynamicScope.oldChangeMobileDeviceTemplate



## OBC-568 (PR UAT) Duplicate SMS received when changing mobile device

FE: Local - Wait Deploy INT

Config/MR/Bug/OBC-568_20.16.UAT.ORI

Hi Matthew. I am working on OBC-568.
The SMS is sent twice. I saw on the UI that the save happens twice.
When looking at the history I saw you added something 21st Oct which would cause this.
Before I take it out (which would fix the double SMS being sent) I first wanted to hear why this was added.
I dont want to remove something you added in there for a good reason.
I might be missing something here.

Testing Kibana:

http://logging.mixdevelopment.com/app/kibana#/discover?_g=(filters:!(),refreshInterval:(pause:!f,value:5000),time:(from:now-10m,to:now))&_a=(columns:!(_source),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:b0a88d70-0210-11ea-986d-37754e7c9f8f,key:Text,negate:!f,params:(query:'1040738323704737792'),type:phrase,value:'1040738323704737792'),query:(match:(Text:(query:'1040738323704737792',type:phrase)))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:b0a88d70-0210-11ea-986d-37754e7c9f8f,key:Text,negate:!f,params:(query:'sending%20SMS%20to%20PhoneNumber'),type:phrase,value:'sending%20SMS%20to%20PhoneNumber'),query:(match:(Text:(query:'sending%20SMS%20to%20PhoneNumber',type:phrase))))),index:b0a88d70-0210-11ea-986d-37754e7c9f8f,interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))


## OBC-566 Initial save shows incorrect config status - Configuration Accepted

BE: local

Config/MR/Bug/OBC-566_20.16.UAT.ORI

Currently on save: Configuration Accepted
whilst the commissioning is still happening: Not Commissioned
[Description("Not commissioned")]
		NotCommissioned = 0,

Maybe in SAVE - last step check... PaOBC, set to above?

As per the comments on the issue and Lauren's feedback we will do nothing, and close the issue....

## OBC-564 Mobile number does not update to changed number once saved

| Repo | Description |
| ---- | ----------- |
| FE   | PR INT      |

Config/MR/Bug/OBC-564_DisplayCorrectPhoneNumber_20.16.INT.ORI

C:\Projects\MiXFleet\UI\Js\FleetAdmin\Controllers\assetCommissioning.ts
673 $dynamicScope.modalScope.$parent.form.deviceTypeIdentifierValue = $dynamicScope.changeMobilePhoneTemplate.mobileNumber;

UpdateAssetCommissioning calls it a second time... why?


## OBC-532 Allow user to edit mobile number until asset is commissioned

| Repo | Environment |
| ---- | ----------- |
| BE   | local       |

Config/MR/Feature/OBC-532_AllowChangingMobileNumber_20.16.INT.ORI



## OBC-292 Display configuration status

| Repo | Environment |
| ---- | ----------- |
| BE   | local       |
| FE   | local       |

Config/MR/Feature/OBC-292_DisplayConfigStatus_20.16.INT.ORI


[x] form.compileCapable
[x] assetConfigSummary.configurationStatus

[x] show="form.canCompileConfig 
disabled="!assetConfigSummary.configStatusCanCompile
compileMobileDevice() -- check where this goes!

[x] show="form.canUploadConfig" 
ng-disabled="!assetConfigSummary.configStatusCanUpload" 
ng-click="uploadConfiguration() -- check where this goes!

[x] show="form.canViewCommsLog && form.hasUploadSchedule" 


compileAndUploadModal

----

Introduction

As part of the Phone as OBC project, they repurposed the Configuration status section on the mobile device settings tab to display Commissioning status. This needs to be reverted to display the assets configuration status.

Implementation

- [x] On the mobile device settings tab, we need to display the "Configuration status" for assets making use of the mobile phone device type 
- [x] This is the standard configuration status dialog that is available for all assets.
- [x] There must be no button for Comms log
- [x] The Compile and upload buttons must be available but only clickable depending on the assets current configuration status.
  - [x] Configuration changed - Compile button must be available, upload greyed out
  - [x] Compile requested, Compiling, Upload requested, Upload in progress, Configuration accepted - Both buttons should be greyed out.
- [x] The current "Commissioning status" box that was implemented must not be available.

Testing

Verify that the Commissioning status fields have been changed to Configuration details and display config status
Also ensure that the correct buttons are displayed i.e Compile when the asset is in Config changed

[11:48 AM] Jacques Van Wyk

https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/40087?_a=overview

https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/40091?_a=overview

![](OBC-292_ConfigStatus.png)


## OBC-513 Upload button shouldnt be available

| Repo | Description |
| ---- | ----------- |
| BE   | Local       |

Config/MR/Feature/OBC-513_Upload_Workflow.20.16.INT_ORI

Compile
> Compile requested...
> Request upload > Upload Requested


## SR-8547 Sat Id validation issue

![](SatIDValidation.png)

DynaMiX.Logic.ConfigAdmin.Validation.MobileUnitSatalliteDeviceIdUniqueAsyncAttribute

## QA-3933 Last refresh time on MiX Talk incorrect

| Repo | Description |
| ---- | ----------- |
| FE   | INT         |

Config/MR/Bug/QA-3933_RefreshTimer.20.13.UAT

tooltipValue
text



15:37 (0)

## VM-234 Incorrect assets displayed in Cascading list for MiXTalk

| Repo   | Updated |
| ------ | ------- |
| BE     | local   |
| API DB | local   |

Config/MR/Bug/VM-234_Fix_AssetsShown_NotJustMesa.20.13.INT

### Breathe well 
I have had a look and this had NO impact on MiXTalk as such.
It ONLY has an impact on the assets being displayed in the cascading module.

### Reason
- There was an incorrect assumption made a year ago that only Mesa units will be cascaded. To fix this I will just remove that logic.
- The check to ensure a unit has been commission needs an update to ensure it hasn't been decommissioned since then. This is just a change to the SQL logic.

I am busy working on both. Hopefully will be done in the next few hours.

## CONFIG-2200 DEV: Tacho graph(timeline) doesn't load on DEV

It is not possible to open a Tacho graph from the timeline on DEV.  

When clicking on this icon, it opens the login screen:  

![](2020-08-25-15-32-03.png)

Where to click:  
http://localhost/MiXFleet/#/timeline/trips/asset?assetId=4412900873233944263

Popup:  
http://config.dev.mixtelematics.com/#/timeline/tacho/asset?siteId=-32335940303648351&id=4412900873233944263&tab=true

http://config.dev.mixtelematics.com/#/timeline/trips/asset?assetId=4412900873233944263

http://config.dev.mixtelematics.com/#/timeline/tacho/asset?siteId=-32335940303648351&id=4412900873233944263&tab=true

![](UrlRewrite.png)

Hey Jacques.

So vir CONFIG-2200 se fix het Arnold n SSL code change in die BE gemaak in die NancyCookieHandler.cs file.
Basies het hy net DIE verander in lyn 12:
RequireSSL = false

Potentiele probleme:
1) So dit KAN gebeur dat INT dit DALK overwrite met n merge - ons moet dit maar net onthou
2) Dalk moet ons n certificate kry vir Development environment om https te wees. (Arnold dink daar gaan n paar goed dalk fout gaan agv dit. (ek dink dit sal fine wees - ons moet maar kyk))
3) Ons moet net nooit DEV > INT > PROD toe vat nie... oor daai SSL code :-D
4) Arnold se UI deployments mag dalk die framework overwrite dan gaan dit dalk weer uit bom (ek moes die framework met n ander file overwrite)  

DynaMiX/Core/DynaMiX.Core.Http/Nancy/CustomNancyCookie.cs en remove die lyn  
![](SLLFix2.png)


## CONFIG-2301 Config-Dev: unable to add IMEI's to new Assets

| Repo | Updated |
| ---- | ------- |
| FE   | DEV     |

111115555511111

## [SR-8111](https://jira.mixtelematics.com/browse/SR-8111) Timebased events

| Repo | Updated |
| ---- | ------- |
| API  | DEV     |
| BE   | Local   |

Config/MR/Bug/SR-8111_Command45_EndPoint.20.13.PROD_ORI
Config/MR/Bug/SR-8111_FmTimeAdjusterFix_20.11.PROD

-- MobileUnitConfiguration

public const string UpdateConfigurationStatusFromLegacyIds = "legacy-org/{legacyOrgId}/legacy-vehicle/{legacyVehicleId}/configuration/update-configuration-status/{configurationStatus}";

SR-8111: Going forward.

[Unit]

[Comms]

[client]
(changemobileunitstatus: legacyOrg, legacyVehicle)

[API]
(changemobileunitstatus)
<if FM & accepted>
(sendCommand45)
(getParams)
(sendCommand)

(SendMobileUnitCommand) exists!

--

deviceIntegrationManager.UpdateAssetTimezoneDeviation

--

Basic idea for handling the config accepted event to send Command 45.

![](SR-8111-Kafka-Event-Command%2045.png)

I will write a service that will check the Lightning Events Kafka queue.  
(This is the same thing Fleet does for their tracking service)
Their service is way more involved. I will just check for this:

EventTypeID = 8762220870379150868  (Config accepted)

When I get this from the queue I will make use of the Daylight Saving Adjuster to send command45 to the unit.
I will also log this to some logging system.

Questions:  
1) Is the event-type id I have correct?
2) Should I be writing a service to be hosted in a docker?
3) If so, is there an eg of this somewhere or should I use what fleet did as an example?
4) Is there a specific logging method I should use? Should I use Logstash or something else?

I did a quick poc, I can get the correct events. I now just need to send the command (and make this cleaner).
I do want to ask the above questions though, as I think this is a good learning curve and something we can make use of going forward.


--

OK - so jy gaan maar moet gracious wees met my. Ekt AMPER opgegee gister maar vandag maak dinge weer meer sin - dink ek :-D
My vraag is - ek wil net confirm dat jul beide Lightning EN non-lightning events in ag neem.

Van ons gesprek lyk dit of jul doen. In RedisTrackingService... sien ek jul kry ook n event Manager, wat lyk of dit ons goed in ag neem.
Ek sien ook jul luister na n stream vir lightning.

So ek sal nou meet duidelikheid kry oor hoe jul die twee bymekaar bring... maar uit bg. lyk dit wel dat jul beide consider?

--

Ja, daar is config transforms en als in. Dis die hele solution 
Jy gee om oor Fleet.Services.Tracking.Redis -> Fleet.Services.Tracking.Redis -> Program.cs en RedisTrackingService.cs

Program register die client as ek reg onthou en in die RedisTrackingService.cs subscribe ons net na die verskeie topics. In die ActiveEvents stream sal jy net wil early exit indien die eventTypeId nie jou id is nie

InternalAntenna = 0,
ExternalAntenna = 1

OK - so I had to have a look in our kode...
ExternalAntenna is true IF...

OverridenDevices
OverridenPeripheralDevices

mobileDeviceTemplateId
MobileDeviceTemplates.AllPeripheralDevices
MobileDeviceTemplates.AllLogicalDevices

public const long MIX6000LTE_GPS = -6684027584598198712;
public const long MIX2XXX_MOBILE_DEVICE_RANGE = 3628142212283117612;
public const long M6K_ONBOARD_GPS = 3876246157642342761; // System.Peripheral.MiX6000.OnBoardDevice.Gps
public const long EXTERNAL_GPS_ANTENNA_CONNECTED = 4939765917928749801;

for M6K:
  if
    buildContext.IsDeviceEnabled(LogicalDevices.MIX6000LTE_GPS)
  OR
    DevicePropertyValue(PeripheralDevices.M6K_ONBOARD_GPS, 
      DeviceProperties.EXTERNAL_GPS_ANTENNA_CONNECTED) = 1

for MIX2XXX:
  IF
    DevicePropertyValue(LogicalDevices.MIX2XXX_MOBILE_DEVICE_RANGE, 
      DynaMiX.Common.ConfigAdmin.Constants.Properties.EXTERNAL_GPS_ANTENNA_CONNECTED, 0) = 1

Hey Jacques. 

Die einde tot die lang opstel is net om te hoor of jy saamstem...
So n simple yes / no sal doen :-D

Gister het ek baie tyd spandeer om Phathuxolo te help met data wat hy wil he vir n report.
Basies wil hy weet of n unit external gps amtenna connected het. 
Ekt met Paul gecheck. Daars twee dele tot dit.

i) Die een deel check die property se value in [DeviceConfiguration.DataProcessing].[state].[MobileUnitState] en as dit 1 is, is dit external gps.
Ekt dit reeds vir hom deur gegee.

ii) Die ander deel is om te check vir die...
IsDeviceEnabled(LogicalDevices.MIX6000LTE_GPS)
Maar vir daai check moet mens daai hele monster van die unit aggregate.
Ons moet die mobile unit, template, overwritten dinge, als bymekaar kry.
So dis baie werk :-D
Ekt bietjie begin - maar ek wil nie nog n dag waste nie.

Ekt vir hom gese ek dink eks nou op n plek waar ons n jira story nodig het om daai vir hom te gee.
Ekt ook gese die SQL wat ek hom gegee het het reeds baie info vir hom om mee te werk.

IS jy OK met dit dat ek vir hom vra om te reel vir n story om die 2e deel te doen?

deviceSettings.Add(
					new DeviceSetting(UdpParameterId.AntennaSelect,
							(AntennaSelectMode)
									buildContext.DevicePropertyValue(LogicalDevices.MIX2XXX_MOBILE_DEVICE_RANGE, DynaMiX.Common.ConfigAdmin.Constants.Properties.EXTERNAL_GPS_ANTENNA_CONNECTED, 0)));

if (buildContext.IsDeviceEnabled(LogicalDevices.MIX6000LTE_GPS))
				gpsAntennaSelect = 1;
			else
				gpsAntennaSelect = buildContext.DevicePropertyValue<byte>(PeripheralDevices.M6K_ONBOARD_GPS, DeviceProperties.EXTERNAL_GPS_ANTENNA_CONNECTED);

			deviceSettings.Add(new DeviceSetting(UdpParameterId.AntennaSelect, (AntennaSelectMode)gpsAntennaSelect));

--

Ons fetch lightning so

OrganisationManager.IsFeatureEnabled(orgId, OrgFeature.LightningTripsEvents, true);

Dan is dit hoe ons daai boolean gebruik

![](ActiveEventLightningAndNot.png)

Eks nie seker of julle omgee oor of Processing aan is of nie. Andersins gaan jy dalk tri state kort waar die OrgFeature dan ook net kyk vir DataProcessing.

--

ActiveEventManager.cs

Fleet Services API aanvaar reeds die org 3B enabled is
DynaMiX Backend doen die lookup

Sal beter wees aangesien die Daylight Savings service ook in die backend is, so al die manager (logic layer) calls behoort daar te wees om te sien of die org 3B enabled is of nie en dan 
- die DB call as die org nie is nie, 
- of Fleet Services API call as dit org wel 3B enabled is
Check daar die ActiveEventManager.cs
Maar ek sien dit soek alreeds 'n parameter of lightning enabled is of nie, so jy sal in een van die modules moet kyk wat die ActiveEventManager roep om te kyk watter call om te gebruik (vir 3B aan of af)

TIM >

--

As I can see in the issue this happens with FM units. Paul has also confirmed that mesa units work fine. I will now add in logic to send a command45 when config is uploaded to a unit.

Question. Can it ever happen that if we do the above, that the unit will FIRST receive the command45 and only then the config upload? If this is the case we will need to take this one step further.

If the above is true, then the softclock will be overwritten again. We will then need something (potentially in the DST service) to check when uploads have been accepted. Once that happens we need to send a new command45. We will need to check both lightning events and sql events. This will be a bit of a job.

Please let me know if the above will be necessary?

eventId="8762220870379150868" eventName="Configuration accepted"
<event id="8762220870379150868" type="4" returnActionType="3" returnParameterId="-4539270798360273587" legacyId="29400" description="Configuration accepted" />
Client.GetRangeForGroups(

MiX.Integrate
  GetRangeForGroups?


Hey Rudolf. Hoop dinge gaan goed.
Dalk kan jy my se met wie om te chat.

So ons het n SR waaraan ek werk.
In kort moet ek as n Active Event opgetel is, iets doen.
Die active event is vir Config Accepted.
Ek gaan dit sommer saam die Daylight Savings service hanteer.

Sekere orgs is mos Lightning, ander nie.
As ek MiX.Integrate se method GetRangeForGroups roep, sal dit van beide lightning en ou DB die events kry?
Sal dit ook active events bevat?

  MiX.Integrate\MiX.Integrate.Fleet.Logic\ActiveEvents\ActiveEventsManager.cs:
  153  
  154: 		public async Task<IList<ActiveEvent>> GetRangeForGroups(List<long> groupIds, string entityType, DateTime from, DateTime to, List<long> eventTypeIds = null)
  155  		{
  156  			var securityAccounts = new SecurityAccounts(SessionHelper.CurrentAccountId);
  157: 			var fleetEvents = await ActiveEventsRepo.GetRangeForGroupsAsync(groupIds, entityType, from, to, eventTypeIds, null, securityAccounts).ConfigureAwait(false);
  158  			if (fleetEvents == null || fleetEvents.Count == 0)

### Going forward

Enhance the Daylight savings service to Resend command45 when:  
- config accepted status changes  
- 15503's value is not correct (this could be more tricky)  

Also send when upload config

To get new config stuffs
- Lightning
- AssetDB



https://uk.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/-526653425951115306%20/981983764404281344/null

https://uk.mixtelematics.com/#/fleet-admin/asset/details?id=981983764404281344&orgId=-526653425951115306
id=981983764404281344  
orgId=-526653425951115306  
siteID? -2694619846386919722  
https://uk.mixtelematics.com  
marthinus.raath@mixtelematics.com  
Liselle7  


```sql
Select de.eventid from deviceconfiguration.library.events le
inner join deviceconfiguration.definition.events de on le.eventkey=de.eventkey 
Where librarykey=-1 and le.LegacyEventId=15505
```

```mysql
SELECT *
FROM Events
WHERE EventID = 8762220870379150868 LIMIT 100
```

----

Here is the stored proc
C:\Projects\_MiXTelematicsFiles\SR-8111 Softclock issue Finding Events outside the times after the command45 was received.sql

15501 Before deviation
15502 AFTER deviation
15503 Tyd in dag / 3600
15504 
15505 (UNIT GOT COMMAND45)  

-32700 NEW Config
-32698 Config RESET

### Findings 20200909

After investigating a lot of vehicles, events, dat and config files over different organisations, we found an edge case. Under this edge case the unit will not persist the softclock offset, which will result in the unit's event times not being calculated correctly.

The firmware, together with the config team, has put in place logic to persist the softclock offset in case a new config was loaded or config was reset on the vehicle. This was tested in the past by Paul and Dario. This logic will to the best of its ability persist the offset, however, in certain edge cases, it still looses the offset.

When looking into the amount of time spent on this issue to find this edge case, it is clearly seen that this doesn't happen all the time, and was not easy to pin down.

Now that we have seen this happen, we know by default to look out for these same symptoms in case this happens again.

So the findings in short are as follows:
When a command45 was sent, this command goes into a message table. From there it goes via comms to the vehicle. When the vehicle receives this command45, it will make an entry in the dat file. The event id is 15505, this shows that command45 was received, it is also easy to then see what value this unit received as the offset, etc. Another important event id is 15503, this event will show the time on the unit (this applies the offset). If you take the value in this event (the value is in seconds), you can work out the offset in time on the unit.

What we saw for the vehicle we found this edge case on was this. It received 15505, setting the offset to the right value (as per the messages table). When it reported the 15503 value, this offset was also correct, meaning the unit already applies the offset. In this case there were no incorrect timed events for this unit after this offset was correctly applied.

We later found new incorrect timed events. When we traced the dat file, we found that 15503 was no longer applying the correct offset, which meant the unit's time was incorrect, which would explain why the timed event triggered incorrectly.

This needed an explanation. We then traced the dat file further back and found that the first time 15503 was reporting the incorrect unit time was after these events occurred. Event -32700 (New Config) and Event -32698 (Config Reset). As soon as those happened, the 15503 event started reporting the incorrect time.

Herewith an example of where 15503 no longer reports the correct unit time.

![](15503_Offset_missing_command45.png)

In the above image, you can see the event -32698 triggered. After this you can see event 15503 reporting the unit time in seconds as 47202. If you work this to hours it is just over 13 hours, which is the same as the org time. This means there is no longer any offset applied on the unit.

The above points back to the edge case.

Our temporary suggestion / workaround:
For now we will give the FMTimeAdjuster tool to the RSO. They will then be able to resend the Command45 after this type of edge case is found. This will then resend 15505 and thus it will fix 15503. This will in turn unsure timed events will not report out of bounds.

Going forward:
We will need to enhance the logic to fix this, without the need for someone to manually send the command45. We suggest an enhancement which will resend the command45 automatically after a new config and after a config reset.
I would also suggest somewhere in the future we enhance the Daylight savings time, to look for units which never received the 15505 and then resend this command45.






### Tests 2020-08-18

From my latest tests... using SQL, it seems like everything is in order.
I will run my logic past Russell soon.

On **Al Malihi Transporting and Contracting** site all the events look fine.

On **Desert Man General Transport** site all the events look fine.

The only problem I could potentially find was this unit, which could have incorrect events set up on its config, as you can see the last command45 to that unit was middle 2019. This means the config could also be out.

| sdescription        | vehicleid | StartdateAST            | Command45Received       |
| ------------------- | --------- | ----------------------- |
| Test 2(8PM to 5 AM) | 40        | 2020-08-17 07:59:41.000 | 2019-07-21 10:23:38.000 |

I will ask @Russel to pull this unit's config to see the config on that unit.

### 20200901 (Outstanding - why the older command45 was not considered)

**Current status:**  
We compared the client's report to our sql results.
We are happy with the following finding:
There has been no incorrectly triggered events, after our manual command45 was received on the vehicles.
This is good news, showing that once the vehicle has received command45, the time for the events were correct.

**Process followed:**  
We had a look at the two event in the client's report.
To simplify my explanation I will only show the result for (Test 1)
The result shows events triggered outside of the time set up for the event.
This image comes from the client's report.

![](EventFromClientReport.png)

We then duplicated this using sql.
In order to understand why the events were triggered incorrectly we had a look at command45.
I added two columns for command45.
The first one shows command45 sent manually by myself and Russell.
It will be noticed that no incorrect events were triggered after this command45 was sent manually.

In the image below we have duplicated these incorrect events.
For the first record, it is clearly seen that there was no command45 received for this vehicle.
(Indicated in red)
We are therefore happy with the result.

For the next record, the incorrect date and time is the 2nd of Aug.
This is the last time this event triggered incorrectly for this unit.
(Indicated in green)
Our manual command45 was only received on the 11th of Aug.
(Indicated in blue)
After this manual command45, no incorrect events were triggered.

We do however have a question about the part indicated in purple.
(This will be commented on next)

![](Command45OldAndNewAndIssue.png)

**Outstanding investigation:**  

In the above image you can see that before our manual command45 was received for this unit,
the last last auto command45 received for this unit was the end of February.
(Indicated in purple)

Our question is why this command45 received, was not considered when triggering the event.

Currrently we think it could be:
- That these units' softclocks were reset in some way.
  - Maybe when receiving new config this will happen? We will ask Paul
  - Maybe the firmware or mechanism considering soft clock, ignores older settings?

We will investigate this further.

### Client

Runs event report - that picks this up

### Branch

Config/MR/Bug/SR-8111_FmTimeAdjusterFix_20.11.PROD

### Information

RW- TIme Based Events triggering incorrectly even after Command 45 was sent to units - MiX Telematics JIRA

Clipped from: <https://jira.mixtelematics.com/browse/SR-8111>

Client Complaint is that the timebased event is triggering outside of the configured bounds.

I have have used the Time adjustment tool to send **Command 45** to the units and still the units are triggering outside of bounds.

I have provided Dat files for one of the vehicles that have received the Command 45 and is still triggering incorrectly

This is logged as HIGH as there are 2 Dbs affected and teh Dealer wants to use this Events on all the databases

Event Name : TEST 2
![](SR-8111%20Conditions.png)

Sample Vehicle: **Vehicleid 181**

Sample Event Evaluated:
![](2020-08-07-11-06-31.png)

I have also noted that the assetdatatimezone is AST and on the UI it shows GST.
AST = UTC+4
GST=UTC +3     ??


<table><thead><tr class="header"><th>General status information </th><th> </th></tr></thead><tbody><tr class="odd"><td>Vehicleid </td><td>181</td></tr><tr class="even"><td>Mobileunitid</td><td>981983764404281344</td></tr><tr class="odd"><td>Raw unit date &amp; time (unadjusted)</td><td>20.7.2020. 14:29:18 UTC</td></tr><tr class="even"><td>Asset site time</td><td>20.7.2020. 18:29:18 (GST)</td></tr><tr class="odd"><td>Vehicle mode</td><td>Out of trip : 0-00:08:34</td></tr><tr class="even"><td>Driver</td><td>Unknown</td></tr><tr class="odd"><td>Speed</td><td>0 km/h</td></tr><tr class="even"><td>RPM</td><td>0</td></tr><tr class="odd"><td>Odometer</td><td>10497.1 km</td></tr><tr class="even"><td>GSM quality status</td><td>69%</td></tr><tr class="odd"><td>Current subtrip distance</td><td>0 km</td></tr><tr class="even"><td>GPRS context (restricted)</td><td>+CGDCONT=1,"IP","m2m"</td></tr><tr class="odd"><td>MSISDN</td><td>-</td></tr><tr class="even"><td>IMSI</td><td>4.24024E+14</td></tr><tr class="odd"><td>IMEI</td><td>3.51628E+14</td></tr><tr class="even"><td>CAN script device name</td><td> </td></tr><tr class="odd"><td>Mobile device driver version</td><td>15.2.25.11</td></tr><tr class="even"><td>Mobile device driver update date</td><td>23.12.2019. 11:34:24 (GST)</td></tr><tr class="odd"><td>CAN PIC driver version</td><td>15.5.2.23</td></tr><tr class="even"><td>CAN PIC driver update date</td><td>29.11.2012. 13:50:56 (GST)</td></tr></tbody></table>

### The dat file - not showing the command45  
![](2020-08-07-11-10-18.png)

### Error found > AuthToken
![](2020-08-05-14-40-20.png)  
Figured out that we needed to add extra code in for the https...  
This wasnt the case before  

### Testing  
https://uk.mixtelematics.com/#/fleet-admin/asset/details?id=981983764404281344&orgId=-526653425951115306
id=981983764404281344  
orgId=-526653425951115306  
siteID? -2694619846386919722  
https://uk.mixtelematics.com  
marthinus.raath@mixtelematics.com  
Liselle7  

1) Test if the command45 reaches this unit (FM 3607i) (Mercedes Truck 60759-2)
   - [x] Check the messages table (FM << / Mesa)
   - Check the dat? file for that code paul mentioned? 15502 15503
2) Ensure that this condition is on the unit
   - [x] Check the config file
3) Somehow test if this triggers wrong still
   - Ask Russell to check if the trigger is still wrong (set this up, check table)
4) Check if this the case: Asset Site Time, Org Time
   - Is the asset in the correct TZ
   - Is the org in the right timezone
5) Ensure the message I saw for the command45 is the correct offset
   - Look at the calculations and org settings

### SQL: Check messages in FM table for command45

Asset DB strored proc  
[dynamix].[Messages_GetDSTCommandsForLastYear]  

```sql
  --Get all messages for this asset sent in last year
  USE AlMalihiTransportingandContracting_2019;
  DECLARE @now datetime = '7 August 2020'
  SELECT DISTINCT
    [AssetId],
    [dtStarts] as [DtStarts],
    [sParams] as [SParams]
  FROM [dbo].[Messages] m WITH (NOLOCK)
    INNER JOIN [dynamix].[Assets] a WITH (NOLOCK) ON m.iVehicleID = a.VehicleId
  WHERE 
    AssetId = 981983764404281344
    AND REPLACE(sParams, ' ', '') LIKE 'CommandID=45;%'
    AND dtStarts >= DATEADD(YEAR, -1, @now)
    AND (dtExpires >= @now
      OR (dtExpires < @now AND ucState = 9))

  --Get Org Timezone Offset
  Select liGMTOffset, * from FMOnlineDB.dbo.Organisation
  WHERE sConnectDatabase = 'AlMalihiTransportingandContracting_2019'

  --Get Site TZ Offset
  SELECT top 5
    g.[GroupId],
    g.[Description],
    g.[Name],
    [Type]          = gt.[GroupTypeId],
    g.[DisplayTimeZone]
  FROM
    [DynaMiX].[DynaMiX_Groups].[Groups] g
      INNER JOIN
    [DynaMiX].[DynaMiX].[GroupTypes] gt ON g.[GroupTypeKey] = gt.[GroupTypeKey]
  WHERE     g.[GroupId] = -2694619846386919722 --SiteGroupId
```

### Tool used

![](2020-08-07-11-53-25.png)
![](2020-08-07-11-54-42.png)

The resource cannot be found.

Requested URL: /DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/-526653425951115306 /981983764404281344/null

https://uk.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/-526653425951115306%20/981983764404281344/null

![](2020-08-07-12-06-15.png)

CommandID=45 ;Params=dword:14400,dword:14400,dword:946688400 ;
Date effective: GMT: Saturday, January 1, 2000 1:00:00 AM

deviceIntegrationManager.SetCommandParameters(authToken, orgId, firstSiteGroupId, out secondsBefore, out secondsAfter, out ctime)

double orgSecondsOffset = orgSummary.GMTOffset
siteSecondsOffset = GetSecondsOffset(authToken, siteDateTime, siteTimeZone)
siteTimeZone = destinationGroup.DisplayTimeZone
DynaMiX_Groups].[Groups_Get
  site id sent in

NO Deviation found...    
    Both = siteSecondsOffset - orgSecondsOffset    
    Time 10 years back (this is what I see in the message - done when no deviation was found)    
ELSE    
    secondsBefore = secondsOffsetBeforeDeviation - orgSecondsOffset;    
	  secondsAfter = secondsOffsetAfterDeviation - orgSecondsOffset;     


#### Org TZ
liGMTOffset (org offset) = 0
#### Site TZ
site Display timezone = Arabian Standard Time ()
Current time in Arabia Standard Time ‎(UTC+3)

The message sents 14400
14400/60/60 = 4 hours
Above we see online it is 3 hours

> ... daylight saving time is not observed. Between 1982 and 2007, Iraq observed Arabia Daylight Time (UTC+04:00) but the government abolished DST in March 2008...
https://en.wikipedia.org/wiki/UTC%2B03:00#Arabia_Standard_Time

MAYBE the microsoft offsets we read is not up to date?

#### Findings: So far

If we look at the database, we can see the following:
1) The org timezone offset is 0
2) The site timezone offset is 10800 (3*60*60)
3) The message offset is 14400 (4*60*60)

![](OffsetsFoundInUKDb.png)

It seems like the offset being set is **1 hour more** than it should be.

I looked on this wiki page and found the following:
> ... daylight saving time is not observed. Between 1982 and 2007, Iraq observed Arabia Daylight Time (UTC+04:00) but the government abolished DST in March 2008...
https://en.wikipedia.org/wiki/UTC%2B03:00#Arabia_Standard_Time

It could therefore be that that the microsoft source is incorrect, but before I just to conclusions I will write a small app that runs a test for AST TimeZone and see what the value returned is. If it is indeed UTC + 4 we have found our problem. If not, I will continue my search.

#### TestApp

- [x] Write a test app to use Arabian Standard Time to work out the offset in windows

I have concluded in the test that the value returned for "Arabian Standard Time" is inconsistent with the value I see on other sites.

![](2020-08-07-15-42-49.png)

I will now speak to a few people to find out how we can fix this.

#### Asset info

https://uk.mixtelematics.com/#/fleet-admin/asset/details?id=966073143833665536&orgId=4941797257640699807

Org: MiX Telematics / ME-DIRECT / ... / ME-FMSI UAE-UAE / Desert Man General Transport  
orgId: 4941797257640699807  
DB: DesertManGeneralTransport_2017  
Name: Ashok Leyland 51293-1  
AssetId: 119  
SiteId: -6168205532488898875  

## QA-3925 QA - MiX Talk - IMEI already in use when entering number that hasn't been used

C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs
Still needed Track&Trace
But Mobile & MiXTalk is handled below

USE DeviceConfiguration;
--UATNewTestOrgposONlocON_2016
DECLARE @id nvarchar(200) = 358887099566745;
Select * FROM mobileunit.MobileUnits WITH (NOLOCK) WHERE UniqueIdentifier = @id;
SELECT * FROM mobileunit.AssetProperties WHERE PropertyId = 1471065106778105997 AND Value like @id;
Select * from mobileunit.AssetMobileUnits WHERE AssetId = 7457499350949496471


358887099566745
LdP MiX Talk 20.13 (MiX Talk 20.13)
MiX Telematics / QA Team / QA Live Vehicles
DB: UATNewTestOrgposONlocON_2016


https://uat.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1038246138735173632&orgId=-5288458383792327239


#### TZ

Org: 0
Site: Arabian Standard Time (4 = 14400)

#### Event Template

name: 3.0.0.0 ADCO_HV_80_HB-10_HA-8_VSS/Can_Rpm/Can_No PSB_No 4WD_DSB  
4PM-1AM: Test 1  
8pm-5am: Test 2  

#### Config file

- Asset: 119

65486: 4PM-1AM: Test 1: 558943196208183670  
65485: 8pm-5am: Test 2  


```xml
<!-- Test 2(8PM to 5 AM) -->
<Conditions>
<EventId>65485</EventId>
<!-- In trip (drive) -->
<Op>!</Op>
<Input>TripStatus</Input>
<Op>&amp;&amp;</Op>
<!-- ( -->
<Op>(</Op>
<!-- Current time -->
<Input>StorageLongs</Input>
<InputExt>Calculated_Time</InputExt>
<Op>&gt;</Op>
<Const>72000</Const>
<Op>||</Op>
<!-- Current time -->
<Input>StorageLongs</Input>
<InputExt>Calculated_Time</InputExt>
<Op>&lt;=</Op>
<Const>17940</Const>
<!-- ) -->
<Op>)</Op>
</Conditions>
<Actions>
<Action Type="RecordNotification" Delay="0" React="True" StartTime="true" EndTime="true" StartOdo="true" EndOdo="true" />
<Action Type="SetBit" Delay="0" React="Pos">STORE_POSITION</Action>
<Action Type="SetBit" Delay="0" React="Neg">STORE_POSITION</Action>
</Actions>


<!-- Test 1(4PM to 1AM) -->
<Conditions>
<EventId>65486</EventId>
<!-- In trip (drive) -->
<Op>!</Op>
<Input>TripStatus</Input>
<Op>&amp;&amp;</Op>
<!-- ( -->
<Op>(</Op>
<!-- Current time -->
<Input>StorageLongs</Input>
<InputExt>Calculated_Time</InputExt>
<Op>&gt;</Op>
<Const>57600</Const>
<Op>||</Op>
<!-- Current time -->
<Input>StorageLongs</Input>
<InputExt>Calculated_Time</InputExt>
<Op>&lt;=</Op>
<Const>3540</Const>
<!-- ) -->
<Op>)</Op>
</Conditions>
<Actions>
<Action Type="RecordNotification" Delay="0" React="True" StartTime="true" EndTime="true" StartOdo="true" EndOdo="true" />
<Action Type="SetBit" Delay="0" React="Pos">STORE_POSITION</Action>
<Action Type="SetBit" Delay="0" React="Neg">STORE_POSITION</Action>

```
----------------
```text
Event description : Test 1(4PM to 1AM)
Event ID : 558943196208183670
Event legacy ID : -50
Condition
In trip (drive) -1 And
(
Current time > 3:59:59 PM Or
Current time <= 12:58:59 AM
)
Action
Record event : Delay=0
Type=Detailed
Start odometer
End odometer
Start position
End position

Event description : Exceeding 2 hours driv
```
---------------

#### Message table received

| AssetId            | DtStarts                | SParams                                                      |
| ------------------ | ----------------------- | ------------------------------------------------------------ |
| 966073143833665536 | 2020-08-11 07:28:48.877 | CommandID=45;Params=dword:14400,dword:14400,dword:946688400; |

#### Dat file

sdfsdfsdf

#### Triggered

sfdsdfsdf

![](2020-08-14-16-08-32.png)

![](2020-08-14-16-08-48.png)


#### Question

- If we send the before and after offset to 14400, will it still be set as 14400?
- 




## QA-2324 Battery voltage value returned displays 77 on Notification &lt;&gt; Info hub


<https://jira.mixtelematics.com/browse/QA-2324>

 

 

Thursday, 08 August 2019

10:59

 

<img src="./OneNoteExported/General/media/image129.png" style="width:9.32292in;height:4.76042in" alt="SCLCueryI [S use LIATNewTestOrgposONIocON 2ß16; [S select top Iøøø where Vehicleld and EventlD from tbEventData between &#39;2a19-a5-28&#39; and &#39;2a19-a5-29&#39; Sta rtD a te [S select top Iøøø where Vehicleld and EventlD from tbActivemessages and EventDate between &#39;2a19-a5-28&#39; Massages and 2a19-a5-29 100 % Evant Key Vehicle&#39; D Driverl D Original Driverl D Evant ID Evant Date Event Type Start Sequence Vehicle&#39; D 4096 Start Data 07000 Start Odometer NULL Valua StartGPSID NULL End Sequence NULL End Data NULL [shed MassageID 7069444 Phony 250 Recei vad Dat a 20W0528053820000 Evant ID 20W0528053806000 GPSID 21480346 11575062745098 Odometer 96884 79688 Speed 0 00000 " />

use UATNewTestOrgposONIocON\_2016

 

select top 1000 \* from tbEventData

where Vehicleld = 406

and EventlD = -996

And StartDate between '2019-05-28' and '2019-05-29'

 

select top 1000 \* from tbActiveMessages

where Vehicleld = 406

and EventlD = -996

and EventDate between '2019-05-28' and '2019-05-29'

 

 

 

SELECT DISTINCT o.iCompanyID, le.LegacyEventId

FROM library.Events le

INNER JOIN definition.Events de ON de.EventKey = le.EventKey

INNER JOIN definition.DeviceParameters ddp ON ddp.ParameterKey = de.ReturnParameterKey

INNER JOIN definition.CalibrationTypes ct ON ct.CalibrationType = ddp.CalibrationType

INNER JOIN library.Libraries ll ON ll.LibraryKey = le.LibraryKey

INNER JOIN \[FMONLINEDB\].dynamix.Organisations do ON do.GroupId = ll.GroupId

INNER JOIN \[FMONLINEDB\].dbo.Organisation o ON o.liOrgID = do.OrganisationId

WHERE ct.HasVariableCalibration = 0

AND o.iCompanyID is not null

AND le.LegacyEventId is not null

-- AND le.LegacyEventId = -996

 

SELECT top 10 \* FROM library.Events WHERE Description like '%battery low%'

Select top 10 \* FROM definition.Events where EventKey = 12598

SELECT top 10 \* FROM definition.DeviceParameters where ParameterKey = 414

SELECT top 10 \* FROM definition.CalibrationTypes where CalibrationType = 12

 

 

HSUATATS01

 

SQL08LST\\FOXTROT

 

 

<img src="./OneNoteExported/General/media/image130.png" style="width:5in;height:4.71875in" alt="e. Ven JOIN definition. Events de de. Eventkey = 12. Eventkey JOIN definition.DeviceParameters ddp ddp.ParameterKey = de.ReturnParameterKey JOIN definition-calibrationType5 ct Ol&#39; ct.CaIibrationType = ddp.CaIibrationType JOIN library.Librarie5 Il ON Il, LibraryKey = le. LibraryKey INNER JOIN do do. Groupld 11.6roupId INNER JOLN . dbo.organisaticn o Ou c. liorg:o • do.organisationld *ERE = o. iCompanyID is not null LegacyEuentId is act null e. egacy Stored proc wat dit toets SELECT top le Select top SELECT top le top lø • FRO&#39; library. Events WHERE Descripti ike • *attery • FRW definition. Events where EventKey • FRC*I definition.DeuicePara•eters where Par terKey • 414 Jou spesifieke event • FRIN definition.CaIibrationTypes &quot;here Calibr Resdts Messages Ljbt&amp;y Id J 8588088205955644885 Event 84&#39; i 12598 79 Event d EventTyve -996 Mnemcric Retu+dicn NULL 1 173 124 62 140 t 71 760 onType = 12 Rede dat dit nie calibrate nie... Desaiption Reum9aamAerKey Notes Oateupdat± NULL Type 5756887570117719* 3 &quot;1 4027984049149422642 -37365750367218301 ss .33798227593%323850 -3151681075060447174 -2028762414241557442 600112639433303619 7343474385221948983 -368548541231865739 12 Updated 201545-131 201505-131 201505-131 201505-131 201505-131 201545-131 Cd&amp;ationType &quot; Hage9egs o Nou moet ek uitvind hoekom hy so opgestel is :-) Thanks baie " />

 

 

<img src="./OneNoteExported/General/media/image131.png" style="width:7.6875in;height:0.65625in" alt="x CmdGetEventCaIibra...tRequiredList.sqI LoadCaIibrationTypes.sqI Mobile Unit_GetDiagnosticData.sqI Mobile Unit_GetAvai... TransportTypes .sql «calibraticnType calibraticnType= calibraticnT descri este s&quot; " />

 

 

 

<https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend?path=%2FEntities%2FDynaMiX.Entities%2FConfigAdmin%2FParameterCalibration&version=GBIntegration>

 

 

Ross: As it stands now the event value is wrong in lightning Resource Data as well

 

Data Processor or Generic notification service sends email?

 

Hendrik: Received by GPS from FM: Val:77

> For DB calibration is done
>
> basList.setItem("BatVoltage", nBatVoltage \* (((5.0 \* 11500) / 1.5) / 255));
>
> But when calculating the battery voltage for the notifications, no calibration is done.
>
> This is a bug in GPRS and has to be fixed??
>
>  
>
> I can see that the sproc call \[cmdGetEventCalibrationNotRequiredList\] to the DeviceConfiguration DB returns the CompanyID and Event ID of the event in questions which tells the DP not to calibrate the value before putting it on the Q. However currently DP does not call this same sproc to check if it should calibrate when writing to the DB. Can someone in the Config team please have a look if what this sproc is returning is actually valid as it seems to be more strict than the standard parameter calibration that is used when calling the sproc sqryVehicleParamDownloadConfig.
>
>  

**<u>INSPECT</u>**  
cmdGetEventCalibrationNotRequiredList


## OBC-504 Fix compile

| Repo | Environment |
| ---- | ----------- |
| BE   | INT         |

Config/MR/Feature/OBC-504_Fixed_Compile.20.15.INT_ORI

OBC-296 addressed compilation and saving of PaOBC configs from DynaMiX. Regression seems to have occurred since as the config compiled for the PaOBC is being compiled and stored under a Calamp device type.

Step 1: Compile obc > CG page
Step 2: MiX2k? Save mobile device settings

1053033809762357248

canAutoCommission

RequestMobileUnitConfigurationCompile

Twee pics:

![](RequestCompile.png)
![](Compile.png)

check inkom vir paobc en dan moet hy dieselfde code path volg as M2K en DMT



## OBC-68 Mobile device settings tab: Configure Event Thresholds

| Repo | Environment |
| ---- | ----------- |
| BE   | Local       |
| FE   | Local       |
| Lang | Master      |

Config/MR/Feature/OBC-68_PaOBC_Threshold.20.15.INT_ORI


1) Rather call:

public async Task<ConfigurationStatus> RequestMobileUnitConfigurationCompile(string authToken, long groupId, long mobileUnitId, bool autoUpload, long? correlationId = null)

2) MObile number - save - not commissioned


### ---- My Kibana for MY vehicle... can see order well

Myne
http://localhost/mixfleet/#/fleet-admin/asset/commissioning?id=1040738323704737792&orgId=2364975042774694384

http://logging.mixdevelopment.com/app/kibana#/discover?_g=(filters:!(),refreshInterval:(pause:!f,value:15000),time:(from:'2020-10-30T06:50:00.000Z',to:now))&_a=(columns:!(Text),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:b0a88d70-0210-11ea-986d-37754e7c9f8f,key:Text,negate:!f,params:!('1040738323704737792','Pending%20and%20loaded%20configurations%20version%20are%20NULL','No%20configuration%20files%20found%20for%20ConfigurationVersionId'),type:phrases,value:'1040738323704737792,%20Pending%20and%20loaded%20configurations%20version%20are%20NULL,%20No%20configuration%20files%20found%20for%20ConfigurationVersionId'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(Text:'1040738323704737792')),(match_phrase:(Text:'Pending%20and%20loaded%20configurations%20version%20are%20NULL')),(match_phrase:(Text:'No%20configuration%20files%20found%20for%20ConfigurationVersionId'))))))),index:b0a88d70-0210-11ea-986d-37754e7c9f8f,interval:auto,query:(language:kuery,query:''),sort:!(!('@timestamp',desc)))


### ---- OUT OF SYNC

https://mixfds.mixtelematics.com/adfs/ls/idpinitiatedsignon.aspx
https://eu-west-1.console.aws.amazon.com/iot/home?region=eu-west-1#/thing/1057448383665246208/namedShadow/Classic%20Shadow

http://logging.mixdevelopment.com/app/kibana#/discover?_g=(filters:!())&_a=(columns:!(Text),filters:!((%27$state%27:(store:appState),meta:(alias:!n,disabled:!f,index:b0a88d70-0210-11ea-986d-37754e7c9f8f,key:OtherData.assetId,negate:!f,params:(query:%271057448383665246208%27),type:phrase,value:%271057448383665246208%27),query:(match:(OtherData.assetId:(query:%271057448383665246208%27,type:phrase))))),index:b0a88d70-0210-11ea-986d-37754e7c9f8f,interval:auto,query:(language:kuery,query:%27AppName:%20MyMiX.*%27),sort:!(!(%27@timestamp%27,desc)))



Stephan's IPhone
https://integration.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1057448383665246208&orgId=4686848533662217157




canChangeThresholds
changeThresholdsTemplate

Parameter: TRACK_TRACE_CORNERING_THRESHOLD = 8019524306600152882
Event: HARSH_CORNERING = 4291175374538259638

<parameter id="8019524306600152882"  systemName="TrackTrace.Cornering" description="Track trace cornering threshold" valueFormat="16" units="mg"/>
"MinValue": 0,
"MaxValue": 4294967295,

<event id="4291175374538259638"  type="1" legacyId="29622" description="* Harsh Cornering" >
  <conditions>
    <condition id="5647940314164842809" sequence="1" parameterId="8019524306600152882" operator="&gt;" value="600" flags="1" />
  </conditions>
</event>

configGroup.EventTemplateId = 4202915719371899668
eventTemplateAggregate.TemplateEvents.Select(e => e.Description).ToList()
Count = 4
    [0]: "Over speeding"
    [1]: "Harsh braking"
    [2]: "Harsh acceleration"
    [3]: "Mobile phone use"

- Add it in building up carrier
- Add it where changing thresholds
- Language:
  Harsh cornering
  eg. Harsh acceleration

ALSO SEE: LFDI-137

Introduction:

This story is about allowing a user to be able to configure event thresholds on the mobile device settings tab.

Solution:

Display a "Change event thresholds" button onto the mobile device settings tab. 
When a user clicks on the event thresholds button, the following modal must be displayed:
Heading: Event thresholds
Body: The following items must be displayed with a heading and a free text field underneath it, where a user is able to enter in a value. All current validation must be applied and all thresholds must display the current configured values.  

- [x] Over speeding (units of measure, eg: km/h)*  
- [x] Harsh braking (units of measure, eg: km/h/s)*  
- [x] Harsh acceleration (units of measure, eg: km/h/s)*  
- [x] Harsh cornering (units of measure mg)  

Cancel: Clicking this will cancel the modal and the update
Save: Clicking save will save the updated event thresholds and must trigger a compile AND upload immediately for the selected asset and set the status to Upload requested.
Technical

On Save the ConfigAPI client should be called with RequestMobileUnitConfigurationCompile and AutoUpload= true
Testing

Verify that the asset is flagged on the Config groups page and the updated thresholds displayed
Verify that the status changes to Upload requested



## QA-3996_ChangePaOBC_ClientInstantiation

Config/MR/Bug/QA-3996_ChangePaOBC_ClientInstantiationChange.20.15.UAT_ORI

string apiUrl = SettingsProviderFactory.GetProvider(Constants.ServiceName).GetString(Constants.SettingNames.PaOBCApiUrl);
try
{
  CommissioningApiClient.RegisterRepository(apiUrl);
  _paOBCCommissioningApiClient = CommissioningApiClient.Instance;
}
catch (Exception ex)
{
  Logger.Log($"{ErrorMessages.ConfigAdmin.COMMS_CLIENT_CREATION_FAILED}: PaOBCApiUrl={apiUrl}", LogLevel.Error);
  throw new ArgumentOutOfRangeException(ErrorMessages.ConfigAdmin.COMMS_CLIENT_CREATION_FAILED);
}

private ICommissioningApiClient _paOBCCommissioningApiClient;

private bool SendCommissioningRequest(CommissioningRequestCarrier obcCommand)
{
  try
  {
    return _paOBCCommissioningApiClient.SendCommissioningRequest(obcCommand.CommissioningGuid, obcCommand.DataCentreId, obcCommand.OrganisationId, obcCommand.OrganisationName, obcCommand.LanguageCode, obcCommand.AssetId, obcCommand.PhoneNumber).ConfigureAwait(false).GetAwaiter().GetResult();
  }



## OBC-289 event thresholds

| Repo   | Environment |
| ------ | ----------- |
| API    | INT         |
| Common | INT         |




PaOBCDataCentre
PaOBCCommissioningApiUrl
PaOBCConfigUploadApiUrl

-- nugets
-- new filename
-- Test x2
-- Merge to int
-- notify Stephan

-- NEW
PaOBCDataCentre
PaOBCApiUrl

PaOBCCommissioningApiUrl
PaOBCConfigUploadApiUrl

C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.ConfigUI\SettingsReflector.cs

[DatabaseSettingKey(DataCentre, DatabaseSettingKeyAttribute.SettingType.String)]
public const string DataCentre = "DataCentre";

[DatabaseSettingKey(AwsApiUrl, DatabaseSettingKeyAttribute.SettingType.String)]
public const string AwsApiUrl = "AwsApiUrl";

--Only in class not in XML/JSON
DataUsageApiUrl
HorizontalPositionsAccuracyOutOfTripMeters
HorizontalPositionsAccuracyInTripMeters
VerticalPositionsAccuracyOutOfTripMeters
VerticalPositionsAccuracyInTripMeters
PositionIntervalOutOfTripSeconds
EnableAvlOutOfTrip
HeadingDeviationDegreesMinSpeedKph
PositionDistanceInTripInMeters
PositionIntervalInTripSeconds
OrganisationId
MessageGuid
Topics

--In both
DataUsageIntervalSeconds
PositionHeadingDeviationDegrees
TripEndTimeoutSeconds
LogLevel
AssetId
EventTypeConfigurations
  
    --Only in EventTypeConfiguration Class
    EventTypeConfigurations.EventName
    EventTypeConfigurations.EventHandlingMode

    --In Both
    EventTypeConfigurations.EventTypeId
		EventTypeConfigurations.SygicEventTypeId
		EventTypeConfigurations.Threshold
		EventTypeConfigurations.RecordingDelaySeconds
		EventTypeConfigurations.RecordingInactiveSeconds
		EventTypeConfigurations.DisplayNotificationAtStart
		EventTypeConfigurations.DisplayNotificationAtEnd
		EventTypeConfigurations.SaveNotification
		EventTypeConfigurations.SaveDetails


--Only in JSON
OrganistionId
PositionIntervalInTripInSeconds
PositionIntervalOutOfTripInSeconds
  


Config/MR/Feature/OBC-289_OBC_UploadSendToOBCApi.20.15.INT_ORI

Update event thresholds: Config API - Send request to PaOBC API to update device shadow **  

DynaMiX.Backend\MiX.UnitConfiguration\Utilities\SaveConfigurationFiles\Program.cs

OBC-311

Getting byte array from DB to xml

    var stringFromSQL = "your sting from SQL";

    List<byte> byteList = new List<byte>();
    for (int i = 1; i < stringFromSQL.Length / 2; i++)
    {
        string hexNumber = stringFromSQL.Substring(i * 2, 2);
        byteList.Add((byte)Convert.ToInt32(hexNumber, 16));
    }
    byte[] original = byteList.ToArray();

    UTF8Encoding utf8 = new UTF8Encoding();
    var xml = utf8.GetString(original);

### Fields

https://integration.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1040738323704737792&orgId=2364975042774694384


TEST USING THIS:
  1012050582994825216

Go to MyMiX 2019 - 3 and look for Stephan's iPhone
https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1012050582994825216&orgId=4686848533662217157

asset id = 1012050582994825216
orgId = 4686848533662217157

SendConfiguration = 102


2017

https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1040738323704737792&orgId=2364975042774694384



public Guid MessageGuid { get; set; }
public long AssetId { get; set; }
public long OrganisationId { get; set; }
public ushort TripEndTimeoutSeconds { get; set; } = Default.TripEndTimeoutSeconds;
public ushort PositionIntervalInTripSeconds { get; set; } = Default.PositionIntervalInTripSeconds;
public ushort PositionDistanceInTripInMeters { get; set; } = Default.PositionDistanceInTripInMeters;
public ushort PositionHeadingDeviationDegrees { get; set; } = Default.PositionHeadingDeviationDegrees;
public byte HeadingDeviationDegreesMinSpeedKph { get; set; } = Default.HeadingDeviationDegreesMinSpeedKph;
public bool EnableAvlOutOfTrip { get; set; } = Default.PositionOutOfTripEnabled;
public ushort PositionIntervalOutOfTripSeconds { get; set; } = Default.PositionIntervalOutOfTripSeconds;
public Dictionary<long, EventTypeConfiguration> EventTypeConfigurations { get; set; }

"DefaultEventTypeConfiguration": [
  {
      "EventTypeId": 6454149451280645233,
      "EventName": "Harsh Acceleration",
      "Threshold": 8,
      "RecordingDelaySeconds": 0,
      "RecordingInactiveSeconds": 3600,
      "DisplayNotificationAtStart": true,
      "DisplayNotificationAtEnd": false,
      "SaveNotification": true,
      "SaveDetails": true,
      "EventHandlingMode": 1
  },
  {
      "EventTypeId": 4750800303282680186,
      "EventName": "Harsh Braking",
      "Threshold": 12,
      "RecordingDelaySeconds": 0,
      "RecordingInactiveSeconds": 3600,
      "DisplayNotificationAtStart": true,
      "DisplayNotificationAtEnd": false,
      "SaveNotification": true,
      "SaveDetails": true,
      "EventHandlingMode": 1
  },
  {
      "EventTypeId": 4291175374538259638,
      "EventName": "Harsh Cornering",
      "Threshold": 18,
      "RecordingDelaySeconds": 0,
      "RecordingInactiveSeconds": 3600,
      "DisplayNotificationAtStart": true,
      "DisplayNotificationAtEnd": false,
      "SaveNotification": true,
      "SaveDetails": true,
      "EventHandlingMode": 1
  },
  {
      "EventTypeId": -1392049663143411429,
      "EventName": "Mobile phone use",
      "Threshold": 0,
      "RecordingDelaySeconds": 0,
      "RecordingInactiveSeconds": 3600,
      "DisplayNotificationAtStart": true,
      "DisplayNotificationAtEnd": false,
      "SaveNotification": true,
      "SaveDetails": true,
      "EventHandlingMode": 1
  },
  {
      "EventTypeId": -3890646499157906515,
      "EventName": "Over speeding",
      "Threshold": 80,
      "RecordingDelaySeconds": 0,
      "RecordingInactiveSeconds": 3600,
      "DisplayNotificationAtStart": true,
      "DisplayNotificationAtEnd": false,
      "SaveNotification": true,
      "SaveDetails": true,
      "EventHandlingMode": 0
  },
  {
      "EventTypeId": -2864371101042705250,
      "EventName": "Road Speed Overspeeding",
      "Threshold": 0,
      "RecordingDelaySeconds": 0,
      "RecordingInactiveSeconds": 3600,
      "DisplayNotificationAtStart": true,
      "DisplayNotificationAtEnd": false,
      "SaveNotification": true,
      "SaveDetails": true,
      "EventHandlingMode": 0
  }
]

### Spec

Screen info vir jacques
Monitor 2
Dell
1020-000340

So ek sien vir MiX2k stuur dit 2 commands na comms.
1) XmlSettings (sting)
2) ConfigBin (byte[])

Dit moet nou somehow map na dit wat Stephan will he
1) DeviceSettings 
2) EventTypeConfigurations

Sal Paul die beste ou wees om my te help om al die dinge reg te map?
Ek vra solank vir hom.


OBC-360 was MyMiX.PaOBC.Commissioning.Management.Client

SendConfiguration = 102,

Single Asset Upload:
configurationGroupManager.ScheduleAssetConfigurationUpload
Single Asset Compile and Upload:
configurationGroupManager.RequestAssetConfigurationCompileAndScheduleUpload

C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\ConfigurationGroupManager.cs
  RequestUpload

UploadConfigurationGroup
  RequestUpload
UploadAssetConfiguration
  RequestUpload

CompileAndUploadConfigurationGroup
  ScheduleConfigurationGroupUpload

CompileAndUploadAssetConfiguration  
  RequestUpload

Mobile device settings: Compile, upload 
Config groups: Asset: Compile, Upload, Compile & Upload
Config groups: Group: Compile, Upload, Compile & Upload


![](UploadPaOBCIdea.png)

Introduction  

When compiling of config for a mobile phone device is requested, the PaOBC API needs to be called with the relevant data and this should set the configuration status to "configuration changed".   

Solution  

Once the user (or via external trigger) has opted to compile and upload, Device config must call the API using the client provided by the MyMiX team (OBC-206) to **send the request** to update the PaOBC asset config.  

The configuration status should be set to **"Upload requested"** once the the compile is requested and then set to upload in progress when the request has been sent.  

Testing  

Swagger test to be done  

Notes  

Add data access layer for Phone as OBC API  
Client name: MyMiX.PaOBC.Local.Device.Management.Client - https://dev.azure.com/MiXTelematics/Common/_packaging?_a=package&feed=Common&package=MyMiX.PaOBC.Local.Device.Management.Client&version=2020.6.25.6&protocolType=NuGet  
PaOBC api url to be added to Config API settings (INT: http://localdevicemanagementapi.mymix.int.development.domain.local/index.html)   
Lucid Chart: https://app.lucidchart.com/documents/edit/bec9d843-14a4-4903-9c7d-b92e709cd8db/0_0#?folder_id=home&browser=icon  

Latest Client:  
https://dev.azure.com/MiXTelematics/Common/_packaging?_a=package&feed=Common&package=MyMiX.PaOBC.Local.Device.Management.Client  

MyMiX.PaOBC.Local.Device.Management.Client
NEEDS:
MyMiX.PaOBC.Device


Paul?
SETTINGS_FILENAME = "mix2310i_config.xml";
SendConfiguration -> Logical device... REMOTE_COMMAND = -7255325733681205281

CommandIdType.SendSettings = 255
SendConfiguration = 102

OBC-311  
https://app.lucidchart.com/invitations/accept/11aec572-0e68-4e6e-a8d6-2071b034246c
http://api.deviceconfig.configdev.mix.local/swagger/ui/index#!/MobileUnitCommands/MobileUnitCommands_UpdateMobileUnitMessageStatus_0



## OBC Merging

| Jira        | Descr                                                       | Points | Status      | Repo                              | Environment    |
| ----------- | ----------------------------------------------------------- | ------ | ----------- | --------------------------------- | -------------- |
| OBC-401     | Change the uniqueproperty "PhoneNumber" for Mobile Phone    | 1      | Closed      | DB                                | DEV & Merged   |
| OBC-403     | Mobile phone validation and uniqueness check                | 3      | Closed      | FE, BE                            | DEV & Merged   |
| OBC-404     | Mobile phone number saving - fix error                      | 3      | Closed      | FE?, BE                           | DEV & Merged   |
| **OBC-406** | Resend mobile phone commissioning SMS - UpdateMessageStatus | 5      | Testing     | API, Client                       | DEV            |
| OBC-405     | Send mobile phone commissioning SMS                         | 3      | Code Review | BE                                | Local & Merged |
| OBC-407     | Resend mobile phone commissioning SMS - UI                  | 5      | 60%         | Lang, FE, BE, API, API DB, Common | local & Merged |
| **OBC-402** | Mobile phone refactoring of Matthew's work                  | 5/8    | 80%         | FE, BE                            | Local & Merged |

Combining ALL stories into one for INT:  
Config/MR/Feature/OBC-401-407_AllMerged.INT.20.14.ORI  

Merge steps:  
- ------ DONE ------
- Lang
- DB
- Common (nuget built)
- Client (no Common Nuget, nuget built)
- API DB
- API (pulled in Common Nuget)
- ------ BUSY ------
- BE (pulled in Client Nuget)
- FE (finalise)
- ------ TODO ------

- [x] MiX.DeviceConfig.Api.Client > build nuget for int > consume > merge
- [x] STM-123 might be needed to be deployed WITH this (yes on int)
      DeviceConfigClient.MobileUnits.DecommissionMiXTalk(authToken, assetId); should be used instead of muProxy.DeleteAssetProperties(authToken, assetId);
- [x] Language: Resend commissioning SMS



**Testing notes: potential issues**
- MiXTalk: Decommissioning, does it still work?  


DONE: Check why 100 is not an acceptable value...
!! MiX.DeviceIntegration.Common.Enums needs changing

getlatestmessagestatus/messageSubType

http://localhost/MiXFleet/#/fleet-admin/asset/commissioning?id=1040738323704737792&orgId=2364975042774694384  



## OBC-406 Change status

End-point tested:  
http://api.deviceconfig.configdev.mix.local/swagger/ui/index#!/MobileUnitCommands/MobileUnitCommands_UpdateMobileUnitMessageStatus_0

https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/46866?_a=files

https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/46852?_a=files

https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/46860?_a=files


a02cc470-bfOb44df-a6dc-342863a2e18b
group: 5373602768183155046
mobile: 852251315327344640
guid: 7177088d-1653-4267-948a-ad40cbd41310
28 V

/*
--MessageId   (No COLUMN name)
--1673623702	ull,"Value":"7177088d-1653-4267-948a-ad40cbd41310"}
--7777778

UPDATE [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage]
SET MessageStatus = 100
WHERE MessageId = 281069699;

UPDATE [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage]
SET MessageId = 1673623702
WHERE MessageId = 2849261160;
*/

DECLARE @id BIGINT  = 852251315327344640;

SELECT * FROM [DeviceConfiguration].[mobileunit].[MobileUnits] WHERE MobileUnitId = @id; 

SELECT top 50 MessageId, MessageStateId, CreationDateUtc, MobileUnitId, MessageStatus, ParamsJson, SUBSTRING(ParamsJson, CHARINDEX('CommandType', ParamsJson)+14, 250)
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum
WHERE ParamsJson LIKE '%"CommandType":null%'
AND mum.mobileunitid = @id
ORDER BY MessageKey DESC




## OBC-405 Send SMS

| Repo | Descr |
| ---- | ----- |
| BE   | Local |

Config/MR/Feature/OBC-405_OBC-404_FROM_403_PhoneAllowSaving_20.12.INT

+27741433001

Use what was done in https://jira.mixtelematics.com/browse/OBC-360  

1917772704

Eg.  
```c#
CommissioningState state = CommissioningState.Unknown;
var response = await DeviceConfigClient.MobileUnits.SendCommissioningRequest(authToken, groupId, mobileUnitId, state).ConfigureAwait(false);
Console.WriteLine($"SendCommissioningRequest Response: {JsonConvert.SerializeObject(response)}");
```

MiX.DeviceConfig.Api.Client.20.14.20200915.1-beta  

C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs

if (carrier.DeviceTypeName == "Mobile Phone")
{
    //Send PaOBC SMS as Pending
    var response = DeviceConfigApi.DeviceConfigClient.MobileUnits.SendCommissioningRequest(authToken, orgId, assetId, CommissioningState.PendingSqsQueue).ConfigureAwait(false).GetAwaiter().GetResult();
}



## OBC-407 Resend SMS

The idea of how the UI should look. The refresh button should not be visible.  
![](ResendSMSOBC.png)

The status issue at hand with my recommendation.  
![](Message_vs_OBC_SMS_status.png)





## STM-123 Method for Decommissioning of Streamax Device

| Repo   | Updated   |
| ------ | --------- |
| BE     | DEV       |
| Client | DEV Nuget |
| API    | DEV       |

>> TEST MiXTalk Decommission and Recommission (Local then DEV)

MiX.DeviceConfig.Api.Client.20.13.20200824.2-beta

Config/MR/Feature/STM-123_DecommissioningAndDeleting.20.13.INT

### Testing

- [x] Ensure that MiXTalk can still decommission (without deleting Streamax values)
- [x] Ensure MiXTalk can still commission (after being decommissioned)
- [x] Add DecommissionMiXTalk in the client > API > pass in properties to method DeleteAssetProperties
- [x] Add DecommissionStreamax in the client > API > pass in properties to method DeleteAssetProperties
- [x] DeleteAssetProperties
- [x] If you add Line CP > FM Keypad - remove MiXTalk properties
- [x] If removing both fields - remove MiXTalk properties
- [x] If deleting an asset - remove MiXTalk properties

### AssetProperties

MiXTalkIMEI = 1471065106778105997;
MiXTalkSIMNumber = -6213542348403873926;
MiXTalkAutoAnswer = -8821833229598988185;
MiXTalkMasterNumber = -169345474250556771;
MiXTalkCarrierID = -6024391627074329223;
VOICE_NUMBER1 = -1215837488863828637;
VOICE_NUMBER2 = 4693572524015961998;
VOICE_NUMBER3 = -5636914472051820521;
VOICE_NUMBER4 = -2920914978524392577;

### Routes

NEW:

public const string DecommissionMiXTalk = "asset/{assetId}/properties/decommission-mixtalk";
public const string DecommissionStreamax = "asset/{assetId}/properties/decommission-streamax";

REMOVED:
DeleteAssetProperties = "asset/{assetId}/properties/delete"

```c#
muProxy.DeleteAssetProperties(authToken, assetId);
  
//This is an EF delete operation,
//  Currently it will remove all properties for this asset
//  !! This is an issue which we will need to change now
//  It is an EF thing, so adding in an overwrite wont be difficult
//  We can add in a method to accept list of property ids to remove
//    We will then add in two calling methods
//    1) DecommissionMiXTalk
//    2) DecommissionStreamax
//  (these will then pass in the property ids to DeleteAssetProperties)
//We just need to think about this - keep MiXTalk testing in consideration
```
### New stuff





## CONFIG-2301 Cant save IMEI

I am unable to add IMEI's to new assets created on Config-Dev. The save button does not become highlighted once an IMEI is entered. It does validate the length and if the IMEI is already in use, but won't save a IMEI.



## OBC-360 (New endpoint - still needs loads of other things)


### Testing

http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/MobileUnitCommands/MobileUnitCommands_SendCommandToMobileUnit

![](TestOBC360.png)

SQL

USE [DeviceConfiguration.DataProcessing];
SELECT MessageId, MessageSubType, ParamsJson, *
FROM [state].[MobileUnitMessage]
WHERE MessageId = -86781830

OBC

MR Phone test

id=1010254937276825600

orgId=-8441185520557948197

 

Marty Test

-4813711035018012046

 

 

 

### Jacques vrae:

 -   RE: OBC-360

-   I had a look at the client's method, am I right in saying we are only trying to set the CommissioningState?

-   Validation: Assume just one command

-   Required: By default REMOTE\_COMMAND

-   Params: Just first needed for CommissioningState

-   Transport type: All accepted

-   Package Command: Nothing added

-   PaOBC Command: Just SendCommissioningRequest for now

    -   Guid… Need to figure out how to new one up with good value

    -   I assume we are only trying to set the state?


### Stephan vrae:

 

-   Wanneer ek die carrier opbou soek dit

    -   Language Code: Kan ek dit blank los?

    -   Organisation name: Kan ek dit ook blank los?

    -   DataCenterId: Ek neem aan dis in ons geval "INT" soos per jou screenshot hier bo

-   Op die oomblik kry ek DIE error as ek die client probeer gebruik…

    -   "Unable to get IAM security credentials from EC2 Instance Metadata Service."

    -   Dit lyk vir my of dit een of ander credentials ook benodig?

    -   Stack trace:

> at Amazon.Runtime.DefaultInstanceProfileAWSCredentials.FetchCredentials()
>
> at Amazon.Runtime.DefaultInstanceProfileAWSCredentials.GetCredentials()
>
> at Amazon.Runtime.DefaultInstanceProfileAWSCredentials.GetCredentialsAsync()
>
> at Amazon.Runtime.Internal.CredentialsRetriever.&lt;InvokeAsync&gt;d\_\_7\`1.MoveNext()
>
> at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
>
> at Amazon.Runtime.Internal.RetryHandler.&lt;InvokeAsync&gt;d\_\_10\`1.MoveNext()
>
> at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
>
> at Amazon.Runtime.Internal.RetryHandler.&lt;InvokeAsync&gt;d\_\_10\`1.MoveNext()
>
> at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
>
> at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
>
> at Amazon.Runtime.Internal.CallbackHandler.&lt;InvokeAsync&gt;d\_\_9\`1.MoveNext()
>
> at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
>
> at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
>
> at Amazon.Runtime.Internal.CallbackHandler.&lt;InvokeAsync&gt;d\_\_9\`1.MoveNext()
>
> at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
>
> at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
>
> at Amazon.Runtime.Internal.ErrorCallbackHandler.&lt;InvokeAsync&gt;d\_\_5\`1.MoveNext()
>
> at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
>
> at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
>
> at Amazon.Runtime.Internal.MetricsHandler.&lt;InvokeAsync&gt;d\_\_1\`1.MoveNext()
>
> at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
>
> at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
>
> at MyMiX.PaOBC.Commissioning.Management.Client.CommissioningClient.&lt;SendCommissioningRequest&gt;d\_\_14.MoveNext()
>
> at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
>
> at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
>
> at System.Runtime.CompilerServices.ConfiguredTaskAwaitable\`1.ConfiguredTaskAwaiter.GetResult()
>
> at DynaMiX.Services.API.Client.PaOBCConnect.PaOBCProxy.SendCommissioningRequest(CommissioningRequestCarrier obcCommand) in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.Services.API.Client\\PaOBC.Connect\\PaOBCProxy.cs:line 76
>
>  

-   Hier is n EG app van hoe ek dit probeer gebruik

-   Xxxxxxxxxxxxxxxx

>  
>
>  

 

 

 
### Setup
 

![](2020-09-09-09-21-50.png)

 

AWSRegionz "eu-west-1"

SQSQueu " <https://sqs.eu-west-1.amazonaws.com/601704920959/INT-MyMiXCommissioningSQS>"

ApiUrIz "<http://commissioningapi.mymixint.development.domain.local>"

Data Centerld ="INT"

LocaIApiurI "<http://localdevicemanagementapi.mymix.int.development.domain.local/>"

 

 

 

When an new asset has been created and a configuration group for a mobile phone device type has been added to it, the mobile device configuration tab will be displayed.

After entering the phone number of the mobile phone and when saving that information, the **MyMiX.PaOBC.Commissioning.Management.Client** client should be user to send a commissioning request message using the **SendCommissioningRequest** method.

Points 7 to 10 in [OBC-336](https://jira.mixtelematics.com/browse/OBC-336) should be looked at together with this story to get a full understanding of how that tab needs to work when dealing with a mobile phone device type

Solution: Config API

-   Add new CommandIdType.SendCommissioningRequest

-   Add PaOBC CommandSender implementation (similar to MiX2kCommandSender) that initially only supports sending SendCommissioningRequest messages

-   Add PaOBC MessageSender implementation (similar to MiXConnectMessageSender)

-   Add 3rdParty client class and implementation for **SendCommissioningRequest** in **MyMiX.PaOBC.Commissioning.Management.Client**

-   When generating the command request in the 3rd party client class, *generate* a 32-bit signed correlationId to be used as the MessageId when this command is stored in state.MobileUnitMessage

-   Add MiX.DeviceConfig client overload for SendCommandToMobileUnit called "SendCommissioningRequest" that enables calling this implementation from DynaMiX BE

 

<https://dev.azure.com/MiXTelematics/Mobile/_git/MyMiX.PhoneAsOBC?path=%2FMyMiX.PaOBC.Commissioning.Management.Client.Tests%2FCommissioningClientTest.cs>

 

 ![](2020-09-09-09-23-36.png)

 



### AWS Security token

Specified argument was out of the range of valid values. (Parameter 'The security token included in the request is invalid.')'

- AWS credentials

1) Delete all AWS related environment variables
2) Set-ExecutionPolicy Unrestricted
3) Run nou die StoreAWSCredentialsFromSAM…. In PowerShell
4) Select 601704920959
5) Get-S3Bucket
6) restart IIS and possibly VS

Powershell

Upgrade

<!-- -->

-   Set-ExecutionPolicy RemoteSigned

<!-- -->

-   Install-Module nuget

<!-- -->

-   Install-Module -Name AWSPowerShell

1)  Run nou die StoreAWSCredentialsFromSAM…. In PowerShell

> (had to change and uncommet to this:
>
> Import-Module -Name AWSPowershell)

3)  Select

![](301704920959.png.md)

PS C:\Users\marthinusr> Get-S3Bucket
Get-S3Bucket: The provided token has expired.


4) after you have done the PS script you will most likely need to restart IIS and possibly VS since they cache the environment variables for as long as the process using it is running
5) Diff script?

-   Go to

> <https://mixfds.mixtelematics.com/adfs/ls/idpinitiatedsignon.aspx>

-   Sign in with email (MiX)

-   Then try open AWS - should give the list of options

 

-   Another test in Powershell run

<!-- -->

-   Get-S3Bucket

-   Should see list

-   The standalone test app then worked

 

-   For IIS test had to restart IIS

-   Still didn’t work

-   Restart PC - went further but hanged

 

 

 

 

EG: Multiple vals

DeviceConfigDb: Integrated Security=SSPI;Persist Security Info=False;Database=DeviceConfiguration;Server=DSINTSQL01

 

 
![](2020-09-09-09-25-40.png)
>
>  
>
> MetricsSettingNames
>
> coreSettings.GetString(MiX.DeviceIntegration.Core.CoreConstants.SettingNames.data247Url
>
>  
>
>  
>
> Nuget downground PR  
> <https://mixtelematics.visualstudio.com/Common/_git/DynaMiX.Backend/pullrequest/43716?_a=files>
>
>  
>
>  
>
>  
>
> AWSSDK.Core 3.3.106.13
>
> AWSSDK.S3.3.3.110.59
>
> AWSSDK.SQS.3.3.102.100
>
>  
>
> AWSSDK.SimpleNotificationService.3.3.101.157
>
> AWSSDK.Lambda.3.3.109.15
>
>  
>
> AWSSDK.CloudWatch ? 3.3.106.13



## OBC-402 Mobile phone refactoring of Matthew's work

### DEV

| Repo | Updated |
| ---- | ------- |
| FE   | local   |
| BE   | local   |

Config/MR/Feature/OBC-402_FROM_403_PhoneValidationAndUnique_20.12.INT  

- [x] Change Mobile Phone
- [x] Remove Mobile Phone
- [x] Commissioning status logic
- [x] Program flow
- [x] Send Commissioning Request  

### Personal Test

MiX Telematics / CSO-RSA / DynaMiX Test Units 2017 L3B+Proc
MR Phone 1
https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1037136024575840256&orgId=2364975042774694384


### Current look

![](MobileNumber.png)

![](ChangeMobileDevice.png)

![](RemoveMobileDevice.png)


For testing set the following to TRUE  
dynamix.mymixpaobc featureEnabled

orgId	5373602768183155046	long
assetId	1039664492274368512	long
+		org	{GroupName:Bench Units,Id:5373602768183155046}	DynaMiX.Entities.Groups.Group
status	null	MyMiX.PaOBC.Commissioning.Api.Shared.CommissioningStateCarrier
phoneNumber	"+27741433223"	string
authToken	"83348395-9b7a-43b6-a1e3-7b82d02b911b"	string
request	false	bool

var request = AssetsGateway.SendCommissioningRequest(authToken, org.GroupId, assetId, phoneNumber, MyMiXPaOBCSettings.Current.DataCenterId);

### More things to consider doing

- [x] BE: When isMobilePhone; assetConfigSummary.canDownloadConfig, 
- [x] assetConfigSummary.canSetOdo, 
- [x] assetConfigSummary.canSetEngineHours, 
- [x] assetConfigSummary.canChangeThresholds all become false
- [x] FE: Remove !assetConfigSummary.isMobilePhone && 
- [x] BE: Same for; form.canCompileConfig, 
- [x] form.canUploadConfig, 
- [x] form.canViewCommsLog
- [x] FE: Then also remove !assetConfigSummary.isMobilePhone && 

- [x] FE: changeMobileDeviceForm
- [x] FE: removeMobileDeviceForm
- FE: TS: changeMobileDevice (ensure it still works)
- FE: TS: removeMobileDevice (ensure it still works)
- FE: Modal validation
- FE: TS: Invalid logic
- FE: html: hasBeenCommissioned logic - should we keep it in?
  
- [x] BE: configSummaryCarrier.ConfigurationStatus logic
- [x] BE: AssetCommissioningModule (ACM): Compare deleted CHANGE_MOBILE_PHONE if the logic can fit into existing CHANGE_MOBILE_DEVICE
- [x] BE: ACM: Compare deleted REMOVE_MOBILE_PHONE if the logic can fit into existing REMOVE_MOBILE_DEVICE
- [x] BE: ACM: Compare deleted "Get asset config summary" with current
- [x] BE: ACM: Check deleted "SendCommissioningRequest" - how to reintroduce
  
- BE: device.DsiMobileDeviceType == "Phone (add back?)


<input type="text" ng-show="assetConfigSummary.isTDI"
        ng-disabled="!changeMobileDeviceTemplate.identifierTitle || !form.hasDeviceTypeIdentifier || form.hasBeenCommissioned || !assetConfigSummary.isTDI"
        ng-model="form.deviceTypeIdentifierValue" name="deviceTypeIdentifierValue" dmx-validate="deviceTypeIdentifierValueTDI" class="span12"
        dmx-required fleet:mobile-unit-unique-identifier-async-params="{ assetId: assetId }"
        fleet:mobile-unit-unique-identifier-async fleet:mobile-unit-unique-identifier-async-message="'Unique identifier already in use'" />
<input type="text" ng-hide="assetConfigSummary.isTDI || assetConfigSummary.isMobilePhone"
        ng-disabled="assetConfigSummary.isMobilePhone || !changeMobileDeviceTemplate.identifierTitle || !form.hasDeviceTypeIdentifier || form.hasBeenCommissioned || assetConfigSummary.isTDI"
        ng-model="form.deviceTypeIdentifierValue" name="deviceTypeIdentifierValue" dmx-validate="deviceTypeIdentifierValue" class="span12"
        dmx-required fleet:mobile-unit-unique-identifier-async-params="{ assetId: assetId }"
        fleet:mobile-unit-unique-identifier-async fleet:mobile-unit-unique-identifier-async-message="'Unique identifier already in use'" />
<input type="text" ng-show="assetConfigSummary.isMobilePhone"
        ng-disabled="!assetConfigSummary.isMobilePhone"
        ng-model="form.deviceTypeIdentifierValue" name="deviceTypeIdentifierValueMobileNumber" dmx-validate="deviceTypeIdentifierValueMobileNumber" class="span12"
        dmx-phonecountrycode dmx-phonecountrycode-message="'Invalid country code'"
        dmx-phonenumber dmx-phonenumber-message="'The value must be a valid phone number, e.g. +27 12 345 6789'"
        dmx-required fleet:mobile-number-unique-async-params="{ assetId: assetId }"
        fleet:mobile-number-unique-async fleet:mobile-number-unique-async-message="'Unique identifier already in use'" />

<span ng-show="assetConfigSummary.isMobilePhone" class="help-block" dmx-translate>Include country code, e.g. +27 12 345 6789</span>

<!--Numeric validation message-->
<span ng:show="isNumericValidationMessageVisible() && !assetConfigSummary.isMobilePhone" class="validity-message ng-scope ng-binding" style="">
  <span dmx-translate>{{numericValidationMessage}}</span>
</span>

http://config.dev.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1025167004693676032&orgId=3906835417853769299
http://localhost/MiXFleet/#/fleet-admin/asset/commissioning?id=1025167004693676032&orgId=3906835417853769299

### Introduction

A lot of code changes have been made to both the Back End  and Front End, which causes some issues in the UI. It is as a result of work Matthew had to do. The code changes were made from March 2020.

All of this will need to be considered and potentially refactored.

### Implementation

We will need to ensure the following:

i) All the logic Matthew has made must still be there and work correctly. Some of which are:

- Change Mobile Phone
- Remove Mobile Phone
- Commissioning status logic
- Program flow
- Send Commissioning Request  

 I would suggest speaking to Matthew first and then potentially allocation some story points to this.

 ii) The logic should be consistent with how we use it for other units. Currently it is a bit confusing and not easy to maintain.



## OBC-403 Mobile phone validation and uniqueness check

https://jira.mixtelematics.com/browse/OBC-403

| Repo | Updated |
| ---- | ------- |
| FE   | DEV     |
| BE   | DEV     |
| lang | master  |

### Branch

Config/MR/Feature/OBC-403_PhoneValidationAndUnique_20.12.INT

### DEV

- [x] Valid number (and country code)
- [x] Unique in data centre
- [x] Languaging: "Mobile number already in use"
(where SIM number already in use)

### Introduction

We need to commission the device type mobile phone using its mobile number. This number must be validated that it is a valid number (including **country code)** and it is **unique in the data centre.**

### Implementation

Currently when you type in the Mobile Phone number in the IMEI field, there are 2 validation issues that needs to be resolved.

It checks that is should be 15 characters. This is not correct as it should ensure it is a phone number. Similar validations already exist, but needs to be applied here.
Ensuring the value is unique. Currently it checks this against IMEI numbers. We need to add new validation logic here. I have done something similar before and it is a bit tricky.

### Notes  

Standard Mobile phone number validation should be used
Refer to MiX Talk validation schema for mobile phone number validation

UnitUniqueIdentifierAsyncParams
SimCardUniqueNumberAsync                    <- Good one to look into

### Testing

http://config.dev.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1025167004693676032&orgId=3906835417853769299


**Testers**
This has been deployed on Dev. 
This is part of many other stories.
We will only deploy this on Int once all the necessary parts involved have been tested on Dev.

Seeing that the "Saving" part is now yet implemented, I manuall added a Mobile number in the database. In order to test the unique value part of this story, you can try the following information.

Org: MiX Telematics / Config Team / Dev Test Units
Mobile number: +27741433223

Seeing that the above Mobile number is already saved, if you try to enter that (or even the same number with spaces), it should give a unique validation error.

### How the validator works

MobileNumberUniqueAsyncAttribute
MobileNumberUniqueAsyncConverter
"fleet-mobile-number-unique-async"
MobileNumberTypeIdentifierValue

![](Validator.png.md)

Also needed the Attribute Directive added in the UI and then use it in the HTML


MobileUnitUniqueIdentifierAsyncAttribute
mobile-unit-unique-identifier-async
MobileUnitUniqueIdentifierAsync

![](ValidationWorking.png.md)

- A) Normal validation to indicate that the field is _required_ is working.
- B) _Phone Number_ validation (Valid phone number and Valid country code) is working.
- C) _Unique_ validation, to ensure it is not already captured as a unique identifier is working.
- D) The one _**issue**_ I have is that (as for any phone number) a user can capture it with spaces, which will then make it unique. I will change this to ensure it strips out spaces when checking for a unique value. (It will still save it as it was typed in)

FE:  
https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/45930?_a=files  
BE:  
https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/45929?_a=files  



## OBC-401 Change the uniqueproperty "PhoneNumber" for Mobile Phone

https://jira.mixtelematics.com/browse/OBC-401

| Repo | Updated |
| ---- | ------- |
| DB   | Dev     |
| Lang | Master  |

### Branch

Config/MR/Feature/OBC-401_ChangeUniqueProperty_20.12.INT

### Introduction

We need to commission a mobile phone using its mobile number as its unique identifier in a similar way to the IMEI on a Mesa unit.

Implementation

Change the uniqueproperty from "UnitIdentifier" to "PhoneNumber" (property id=-8253307904787534451) for MobileDevice.Phone (device id=-7688187356053930045)
It should render the label for the field as "Mobile number" rather than MSISDN (We need to check the knock-on effect of changing this in the XML. Potentially this could be used in other places)

### Notes

Testing is 'Does label' change
Regional validation is done elsewhere

<mobile description="Mobile Phone" handler="8" sort="250" tracer="1" legacy="157" dsiType="Phone" uniqueProperty="PhoneNumber" mobileDeviceType="7" />

In order to render the label to "Mobile number" rather than "MSISDN" I need to change the value in ...
I see this is in turn used by:
- Asset Maintenance Module
- Asset Commissioning Module (where we are needing this)



### Languaging

FROM: "MSISDN" to "Mobile number"










## OBC-404 Cant save

| Repo | Descr |
| ---- | ----- |
| FE   | DEV   |
| BE   | DEV   |

Config/MR/Feature/OBC-402_FROM_403_PhoneAllowSaving_20.12.INT

//DeviceTypeIdentifierTitle: "Mobile number"
//DeviceTypeIdentifierValue: "+27741433221"
//DeviceTypeName: "Mobile Phone"
//var phoneNumberClean = Regex.Replace(phoneNumber, "[^.0-9+]", "");

#/fleet-admin/asset/commissioning?id=1025167004693676032&orgId=3906835417853769299

It currently break at this line, we will need to find out why this is different for Mobile Phone, as it doesn’t happen with others eg. 2310i  propertyValueDictionary.Add(ConfigAdminConstants.Properties.MSISDN, carrier.GsmMsisdnNumber)

If I bypass this it actually persists and then put it into the assets list IMEI number.

![](2020-09-10-13-25-25.png)

PS - with the above - I don’t know what I don’t know. If I just skip the above line if it is already in there, will this break something? Will this cause something to NOT persist? Why can answer this? I THINK it is OK though.


var imeiValid = ($dynamicScope.assetConfigSummary?.isMobilePhone) ? !$dynamicScope.assetCommissioningForm.deviceTypeIdentifierValueMobileNumber.$invalid : !$dynamicScope.assetCommissioningForm.deviceTypeIdentifierValue.$invalid;  



## OBC-374 SPIKE: Config: Investigate using phone number as UniqueIdentifier (1 Day)** - MiX Telematics JIRA

Clipped from: https://jira.mixtelematics.com/browse/OBC-374

DB	DEV	"PhoneNumber"
BE	Local	
FE	Local	

Config/MR/Spike/OBC-374_PhoneNumber.20.12.ORI



Stories from this spike

OBC-401 Change the uniqueproperty "PhoneNumber" for Mobile Phone	1
OBC-402 Mobile phone refactoring of Matthew's work	?
OBC-403 Mobile phone validation and uniqueness check	3
OBC-404 Mobile phone number saving results in an error which needs to be resolved	3
OBC-405 Send mobile phone commissioning SMS	3
OBC-406 Resend mobile phone commissioning SMS - Kafka side	5
OBC-407 Resend mobile phone commissioning SMS - UI	5

When an new asset has been created and a configuration group for a mobile phone device type has been added to it, the mobile device configuration tab will be displayed. On the Mobile Device Settings tabs, the device's phone number should be its unique identifier, with normal phone number validation.
This is theoretically catered for and implemented in the DeviceConfiguration database and DynaMiX backend, but not currently exercised.

Investigate the following:

	• Changing the uniqueproperty from "UnitIdentifier" to "PhoneNumber" (property id=-8253307904787534451) for MobileDevice.Phone (device id=-7688187356053930045)

Did a simple change in the DeviceData.xml file


	• Confirm rendering and 

Before:

![](2020-09-10-13-22-50.png)

After:

![](2020-09-10-13-23-16.png)

	• storing of phone number as unique identifier on Mobile Device Settings tab

Currently it doesn't allow the user to type in anything. For example on the MiX4k you can type in things. We will need to check this on the BE code…

![](2020-09-10-13-23-51.png.md)

Lots of things have been added to our code by Matthew which might be causing this…

![](2020-09-10-13-24-17.png)

All of this will need to be considered and potentially refactored to ensure all the logic still exists. I also need to get the logic to be the same way it was before all these changes, in order to ensure it works the same for all devices.

This is on both the BE and the FE

![](2020-09-10-13-24-39.png)

I will do a quick and dirty revert to check if the user can add in the phone number and if it persists. This is on the FE and the BE.

Lots of change, remove and has been commissioned logic for Mobile Phone was found.
This will need to be refactored to ensure it still works. I would suggest the story points the original story took.

I also found "SendCommissioningRequest" logic. This might need to be refactored. We might need to allocate a portion of the original story points for this.

We might need to add in new validation - ensuring it is unique as it seems to be validate against IMEI.New Phone Number Validation needs to get added.

Request URL: http://localhost/DynaMiX.API/validate
Request Method: PUT

{validator: "DynaMiX.Logic.ConfigAdmin.Validation.MobileUnitUniqueIdentifierAsyncAttribute",…}
parameters: {assetId: "1025200008107368448"}
sequence: 10
validator: "DynaMiX.Logic.ConfigAdmin.Validation.MobileUnitUniqueIdentifierAsyncAttribute"
value: "+27 12 345 6789"

It also validated for 15 characters, this needs to change to a phone number.

It currently break at this line, we will need to find out why this is different for Mobile Phone, as it doesn’t happen with others eg. 2310ipropertyValueDictionary.Add(ConfigAdminConstants.Properties.MSISDN, carrier.GsmMsisdnNumber)

If I bypass this it actually persists and then put it into the assets list IMEI number.

![](2020-09-10-13-25-25.png)

PS - with the above - I don’t know what I don’t know. If I just skip the above line if it is already in there, will this break something? Will this cause something to NOT persist? Why can answer this? I THINK it is OK though.


	• Clicking save on this tab must send the commissioning SMS and 
	• set the status to unverified/pending and 

This should be handled by calling the new end-point added for OBC-360. Just add logic to call this. Should be FE and BE work only.

	• the mobile number field must remain greyed out.

This seems to be existing logic from what I could gather.

	• While the asset is unverified, we should have a "Resend commissioning SMS" below the mobile number. 
	• Clicking this must send a new commissioning SMS.

We might need logic to check some Kafka Queue and then update the Messages status.

We need new logic to check the status and display the button.
This will be FE, BE, Client, API and DB work.
This also needs to call the same logic we need to add above.


	• Once the asset is commissioned, the "Change mobile device" and "Remove mobile device" options should be available

We just need to check this, however, this is usually how it works from the BE once the unit is set as being commissioned. We just need to ensure the unit is set as commissioned correctly.

	• The mobile number should be populated in the IMEI column in the assets list page.

If the saving error is overcome, then it actually seems to show up in this column.







## VM-83 MiXTalk final stretch

https://jira.mixtelematics.com/browse/VM-83

### Information

| Repo       | Updated |
| ---------- | ------- |
| FE         | INT     |
| BE         | INT     |
| API        | INT     |
| DB         | INT     |
| Core       | INT     |
| API Client | INT     |


| Descr      | Spent | Expected |
| :--------- | ----: | -------: |
| Groceries  | 12700 |    10000 |
| Eating out |   350 |        0 |
| Medical    |  1390 |        0 |
| Personal   |  3000 |     1900 |


* Config/MR/Feature/VM-83_CarrierDropdown.20.9.ORI

![](2020-08-04-16-19-07.png)

![MessageStatus](MessageStatusMiXTalk.png)

### UAT

Dit is UAT environment
Org:QA Live vehicles
asset:974002248650174464

Donny's M4K

IMEI: 358887096219165
NO: +279603003126245
MTN

### Status

0, 'Unknown'
1, 'New'
2, 'Pending'
3, 'Queued'
4, 'Sent'
5, 'Postponed'
6, 'SendFai1ed'
7, 'Aborted'
8, 'Deleted'
9, 'Received'
10, 'Accepted'
11, 'Rejected'
12, 'Completed'
13, 'Acknowledged'
14, 'Expired'
15, 'DeleteRequested'
16, 'DeleteQueued'
17, 'ETAChanged'
18, 'Read'
19, 'Close'
20, 'Arrived'
21, 'KMETAChanged'
22, 'Created'
23, 'SentAwaitingResponse'
25, 'Complete'
26, 'Failed'
27, 'Cancelled'
28, 'Confirmed'


### Details
  
* Add a network provider (carrier) dropdown list to the Mobile device settings page when MiX Talk is in use
* This list of possible carriers (e.g. Vodacom, MTN, etc.) should be read from the DeviceConfiguration DB and be associated with a carrier specific master number (that can be updated via db script only)
* This is a required field so the user should not be able to commission a MiX Talk without selecting an option
* This associated master number should be used to any send config changes to the SMS gateway

### TESTING
  
* Selection of carrier must be compulsory
* When this carrier is changed the commissioning process should be re-initiated
* End-to-end testing to be done under VM-219

![](MiXTalkProviderDropdown.png)

"Network provider"

--------------

MiXTalkCarrierID  
MiXTalkCarriers

--------------

public const string GetMiXTalkCarriers = "mixtalkmastercarriers";

[mobileunit].[GetMiXTalkCarrierInfo]

MiXTalkIMEI
MiXTalkCarrierID >> AssetProperties.MiXTalkCarrierID


[mobileunit].[GetMiXTalkCarriers]
form.MiXTalkCarriers

"MiX.Datawarehouse.Client" version="2020.1.21.5"

![](2020-08-05-15-40-50.png.md)

Donny has been doing a lot of tests.
In his last test he could commission a MiXTalk for Telkom and even phone my number from the unit.
The problem is that not all info is being updated. All statusses are also not being updated.

I will try to explain his finding here.
The idea is to get a game plan out of this.
My suggestion is to decide how to test each step if it succeded.
In thus doing we should get the culprit.

OK - so 30 foot view, Donny did the following.
Step i - set the Master Number.
Step ii - set the keypad number (my phone number)
He then tested this and could phone me.

If we have a look at the image below...

In pink we have Step i.
(Setting the Master Number, SMSC and Open Line)
From the UI (looking at the status) seems like the Master Number was set correctly (The status is Commissioned).
If we however have a look at the Tool's screenshot, we will see that the following happened:
- The Master Number on the device was set correctly (A)
- The SMSC Number was NOT set (B)
- The Open Line was NOT set (C)

Looking at my quick flow diagram at the bottom of the image...
For A (Master Number):
- Step 1, 2, 3, 4, 5 happened (setting it first to pending)
- Step 6, 7 happened (sending via MR Messenger to the unit)
- It then SET the actual number (A)
- Step 8, 9, 10 happened (Sending a reply via Mr Messenger)
- Step 11, 12, 13 happened (Updating the status unto the Kafka Q and into the status table, updating the UI)
For B (SMSC Number):
- Dont know where it failed, but we know it did (SMSC wasnt updated) (B)
- The flow would have started from 2
For C (Open Line):
- Dont know where it failed, but we know it did (Open Line wasnt updated) (C)
- The flow would have started from 2


In purple we have Step ii.
(Setting the Keypad Number)
From the UI (looking at the status) it seems like the Keypad Number was NOT sett correctly (Status Pending)
If we however look at the Tool, we see the following:
- The Button #1 (Keypad Number 1) WAS set correctly (E) 
(It is the same as per the UI (D))

Looking at my quick flow diagram at the bottom of the image...
For E (Keypad Number)
- Step 1 > 5 worked (Pending State)
- Step 2 > 7 worked (Setting the correct value for Button #1) (E)
- Then somewhere it broke... as the status was never updated... this could have been any step 8 - 13

We need to check the LOG for each step to see which steps are reached and which not.
Once we can see this, we need to do this a few times.
We can then start eliminating the problem steps(s)

![](MiXTalkWorkFlow.png.md)







## STM-28 Storing Streamax

### GetMiXTalkCarrierInfo

### class AssetProperties

public const long MiXTalkIMEI = 1471065106778105997;  
public const long MiXTalkSIMNumber = -6213542348403873926;  
public const long MiXTalkAutoAnswer = -8821833229598988185;  
public const long MiXTalkMasterNumber = -169345474250556771;  
public const long VOICE_NUMBER1 = -1215837488863828637;  
public const long VOICE_NUMBER2 = 4693572524015961998;  
public const long VOICE_NUMBER3 = -5636914472051820521;  
public const long VOICE_NUMBER4 = -2920914978524392577;  

### Check out insert and update - should be fine

All will be fine...  
```c#
//List of properties to change
var assetProperties = new List<DynaiX.DeviceConfig.Common.Entities.MobileUnitLevel.PropertyValue>();  

//Adding properties to insert or update and setting the values
assetProperties.Add(new DynaMiX.DeviceConfig.Common.Entities.MobileUnitLevel.PropertyValue { 
  PropertyId = AssetProperties.MiXTalkIMEI, 
  Value = carrier.MiXTalkIMEI });  

assetProperties.Add(new DynaMiX.DeviceConfig.Common.Entities.MobileUnitLevel.PropertyValue { 
  PropertyId = AssetProperties.MiXTalkSIMNumber, 
  Value = carrier.MiXTalkSIMNumber });  

//Insert or update properties  
muProxy.SetAssetProperties(authToken, assetId, assetProperties);  
```

### Getting the data

```c#  
IMobileUnitProxy muProxy = new MobileUnitProxy(
  DynaMiX.Common.ConfigAdmin.ConfigAdminSettings.Current.ConfigServicesApiServerUrl);  
var assetProperties = muProxy.GetAssetProperties(authToken, mobileUnit.AssetId);  

//This will however return all of it for now
//Then you just pick those you need  

//In future, we could also add an overwrite to pass in only the propertyids we do need. 
//I would suggest we do this on a later time.  
```

### Delete MiXTalk (Remove MiX Talk)

```c#
muProxy.DeleteAssetProperties(authToken, assetId);
  
//This is an EF delete operation,
//  Currently it will remove all properties for this asset
//  !! This is an issue which we will need to change now
//  It is an EF thing, so adding in an overwrite wont be difficult
//  We can add in a method to accept list of property ids to remove
//    We will then add in two calling methods
//    1) DeleteAssetPropertiesForMiXTalk
//    2) DeleteAssetPropertiesForStreamax
//  (these will then pass in the property ids to this overwrite)
//We just need to think about this - keep MiXTalk testing in consideration
```
![](AssetProperties.png.md)



## OBC-567 Validation needs to change

| Repo | Description |
| ---- | ----------- |
| BE   | INT         |

Config/MR/Bug/OBC-567_ThresholdValidation_20.16.INT.ORI



## UAT-1283 Error when commissioning mobile phone

This was due to environment settings!



## OBC-549 Theshold info old

| Repo | Description |
| ---- | ----------- |
| BE   | UAT         |
| API  | UAT         |

Use the below kibana to see the assetId's actions

http://logging.mixdevelopment.com/app/kibana#/discover?_g=(filters:!(),refreshInterval:(pause:!f,value:5000),time:(from:'2020-11-03T12:23:00.000Z',to:now))&_a=(columns:!(Text),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:b0a88d70-0210-11ea-986d-37754e7c9f8f,key:Text,negate:!f,params:!('1040738323704737792','Pending%20and%20loaded%20configurations%20version%20are%20NULL','No%20configuration%20files%20found%20for%20ConfigurationVersionId'),type:phrases,value:'1040738323704737792,%20Pending%20and%20loaded%20configurations%20version%20are%20NULL,%20No%20configuration%20files%20found%20for%20ConfigurationVersionId'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(Text:'1040738323704737792')),(match_phrase:(Text:'Pending%20and%20loaded%20configurations%20version%20are%20NULL')),(match_phrase:(Text:'No%20configuration%20files%20found%20for%20ConfigurationVersionId'))))))),index:b0a88d70-0210-11ea-986d-37754e7c9f8f,interval:auto,query:(language:kuery,query:''),sort:!(!('@timestamp',desc)))



## OBC-548 Change Threshold shouldnt be available

| Repo | Description |
| ---- | ----------- |
| BE   | Local       |

Config/MR/Bug/OBC-548_ThresholdShouldNotDisplay.20.16.INT.ORI





## OBC-527 Compile all on mobile phone to incorrect status

| Repo | Description |
| ---- | ----------- |
| BE   | BOTH INT    |

Config/MR/Bug/OBC-527_CompileAllMobilePhone.20.16.INT.ORI

Config/MR/Bug/OBC-513_UploadOnlyWhenConfigReady.20.16.INT.ORI

ASSET:

Request URL: https://integration.mixtelematics.com/DynaMiX.API/config-admin/2364975042774694384/config_groups/asset/1047184796625399808/compile_and_upload

COMPILE_AND_UPLOAD_ASSET_CONFIG > CompileAndUploadAssetConfiguration

GROUP:

Request URL: http://localhost/DynaMiX.API/config-admin/2364975042774694384/config_groups/-445479206320168060/compile_and_upload

COMPILE_AND_UPLOAD_CONFIG_GROUP > CompileAndUploadConfigurationGroup




## SR-8547 Sat Id validation issue

![](SatIDValidation.png)

DynaMiX.Logic.ConfigAdmin.Validation.MobileUnitSatalliteDeviceIdUniqueAsyncAttribute



## QA-3933 Last refresh time on MiX Talk incorrect

| Repo | Description |
| ---- | ----------- |
| FE   | INT         |

Config/MR/Bug/QA-3933_RefreshTimer.20.13.UAT

tooltipValue
text



15:37 (0)



## VM-234 Incorrect assets displayed in Cascading list for MiXTalk

| Repo   | Updated |
| ------ | ------- |
| BE     | local   |
| API DB | local   |

Config/MR/Bug/VM-234_Fix_AssetsShown_NotJustMesa.20.13.INT

### Breathe well 
I have had a look and this had NO impact on MiXTalk as such.
It ONLY has an impact on the assets being displayed in the cascading module.

### Reason
- There was an incorrect assumption made a year ago that only Mesa units will be cascaded. To fix this I will just remove that logic.
- The check to ensure a unit has been commission needs an update to ensure it hasn't been decommissioned since then. This is just a change to the SQL logic.

I am busy working on both. Hopefully will be done in the next few hours.



## QA-3925 QA - MiX Talk - IMEI already in use when entering number that hasn't been used

C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs
Still needed Track&Trace
But Mobile & MiXTalk is handled below

USE DeviceConfiguration;
--UATNewTestOrgposONlocON_2016
DECLARE @id nvarchar(200) = 358887099566745;
Select * FROM mobileunit.MobileUnits WITH (NOLOCK) WHERE UniqueIdentifier = @id;
SELECT * FROM mobileunit.AssetProperties WHERE PropertyId = 1471065106778105997 AND Value like @id;
Select * from mobileunit.AssetMobileUnits WHERE AssetId = 7457499350949496471


358887099566745
LdP MiX Talk 20.13 (MiX Talk 20.13)
MiX Telematics / QA Team / QA Live Vehicles
DB: UATNewTestOrgposONlocON_2016


https://uat.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1038246138735173632&orgId=-5288458383792327239


#### TZ

Org: 0
Site: Arabian Standard Time (4 = 14400)

#### Event Template

name: 3.0.0.0 ADCO_HV_80_HB-10_HA-8_VSS/Can_Rpm/Can_No PSB_No 4WD_DSB  
4PM-1AM: Test 1  
8pm-5am: Test 2  

#### Config file

- Asset: 119

65486: 4PM-1AM: Test 1: 558943196208183670  
65485: 8pm-5am: Test 2  


```xml
<!-- Test 2(8PM to 5 AM) -->
<Conditions>
<EventId>65485</EventId>
<!-- In trip (drive) -->
<Op>!</Op>
<Input>TripStatus</Input>
<Op>&amp;&amp;</Op>
<!-- ( -->
<Op>(</Op>
<!-- Current time -->
<Input>StorageLongs</Input>
<InputExt>Calculated_Time</InputExt>
<Op>&gt;</Op>
<Const>72000</Const>
<Op>||</Op>
<!-- Current time -->
<Input>StorageLongs</Input>
<InputExt>Calculated_Time</InputExt>
<Op>&lt;=</Op>
<Const>17940</Const>
<!-- ) -->
<Op>)</Op>
</Conditions>
<Actions>
<Action Type="RecordNotification" Delay="0" React="True" StartTime="true" EndTime="true" StartOdo="true" EndOdo="true" />
<Action Type="SetBit" Delay="0" React="Pos">STORE_POSITION</Action>
<Action Type="SetBit" Delay="0" React="Neg">STORE_POSITION</Action>
</Actions>


<!-- Test 1(4PM to 1AM) -->
<Conditions>
<EventId>65486</EventId>
<!-- In trip (drive) -->
<Op>!</Op>
<Input>TripStatus</Input>
<Op>&amp;&amp;</Op>
<!-- ( -->
<Op>(</Op>
<!-- Current time -->
<Input>StorageLongs</Input>
<InputExt>Calculated_Time</InputExt>
<Op>&gt;</Op>
<Const>57600</Const>
<Op>||</Op>
<!-- Current time -->
<Input>StorageLongs</Input>
<InputExt>Calculated_Time</InputExt>
<Op>&lt;=</Op>
<Const>3540</Const>
<!-- ) -->
<Op>)</Op>
</Conditions>
<Actions>
<Action Type="RecordNotification" Delay="0" React="True" StartTime="true" EndTime="true" StartOdo="true" EndOdo="true" />
<Action Type="SetBit" Delay="0" React="Pos">STORE_POSITION</Action>
<Action Type="SetBit" Delay="0" React="Neg">STORE_POSITION</Action>

```
----------------
```text
Event description : Test 1(4PM to 1AM)
Event ID : 558943196208183670
Event legacy ID : -50
Condition
In trip (drive) -1 And
(
Current time > 3:59:59 PM Or
Current time <= 12:58:59 AM
)
Action
Record event : Delay=0
Type=Detailed
Start odometer
End odometer
Start position
End position

Event description : Exceeding 2 hours driv
```
---------------

#### Message table received

| AssetId            | DtStarts                | SParams                                                      |
| ------------------ | ----------------------- | ------------------------------------------------------------ |
| 966073143833665536 | 2020-08-11 07:28:48.877 | CommandID=45;Params=dword:14400,dword:14400,dword:946688400; |

#### Dat file

sdfsdfsdf

#### Triggered

sfdsdfsdf

![](2020-08-14-16-08-32.png)

![](2020-08-14-16-08-48.png)


#### Question

- If we send the before and after offset to 14400, will it still be set as 14400?
- 




## CONFIG-2301 Config-Dev: unable to add IMEI's to new Assets

| Repo | Updated |
| ---- | ------- |
| FE   | DEV     |

111115555511111


## CONFIG-2200 DEV: Tacho graph(timeline) doesn't load on DEV

It is not possible to open a Tacho graph from the timeline on DEV.  

When clicking on this icon, it opens the login screen:  

![](2020-08-25-15-32-03.png)

Where to click:  
http://localhost/MiXFleet/#/timeline/trips/asset?assetId=4412900873233944263

Popup:  
http://config.dev.mixtelematics.com/#/timeline/tacho/asset?siteId=-32335940303648351&id=4412900873233944263&tab=true

http://config.dev.mixtelematics.com/#/timeline/trips/asset?assetId=4412900873233944263

http://config.dev.mixtelematics.com/#/timeline/tacho/asset?siteId=-32335940303648351&id=4412900873233944263&tab=true

![](UrlRewrite.png)

Hey Jacques.

So vir CONFIG-2200 se fix het Arnold n SSL code change in die BE gemaak in die NancyCookieHandler.cs file.
Basies het hy net DIE verander in lyn 12:
RequireSSL = false

Potentiele probleme:
1) So dit KAN gebeur dat INT dit DALK overwrite met n merge - ons moet dit maar net onthou
2) Dalk moet ons n certificate kry vir Development environment om https te wees. (Arnold dink daar gaan n paar goed dalk fout gaan agv dit. (ek dink dit sal fine wees - ons moet maar kyk))
3) Ons moet net nooit DEV > INT > PROD toe vat nie... oor daai SSL code :-D
4) Arnold se UI deployments mag dalk die framework overwrite dan gaan dit dalk weer uit bom (ek moes die framework met n ander file overwrite)  

DynaMiX/Core/DynaMiX.Core.Http/Nancy/CustomNancyCookie.cs en remove die lyn  
![](SLLFix2.png)



## Dewald Lookup

So myne lyk bietjie anders as joune maar die idee is baie dieselfde:

Flow tussen repos...  
FE > BE > API > DB  

### DB

SProc: "[mobileunit].[GetMiXTalkCarriers]"  
..\Database\DeviceConfiguration\Schemas\mobileunit\Stored   Procedures\MobileUnit_GetMiXTalkCarriers.sql  

### API

Method: GetMiXTalkCarriers  
..\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\MobileUnitLevel\MobileUnit.cs  

Volg dan die logika ook terug...  
Dit gaan mos  
Controller > Manager > Repo > DB call  

### Client

Method: GetMiXTalkCarriers  
..\MiX.DeviceConfig\MiX.DeviceConfig.Api.Client\Repositories\MobileUnitRepository.cs  

### BE

Hier sal jy sien roep ek die lys via die client...  
Dan stoor ek dit as n list in die carrier wat na die frontend to gaan  

Method: PopulateCarrier  

```c#
  var carrierList = DeviceConfigApi.DeviceConfigClient.MobileUnits.GetMiXTalkCarriers(authToken, CorrelationId).ConfigureAwait(false).GetAwaiter().GetResult();
  form.MiXTalkCarriers = carrierList.Select(c => new MiXTalkCarrierCarrier() {
    Carrier = c.Carrier,
    CarrierID = c.CarrierID
  }).ToList();
```

..\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs  

### FE

Die front-end het ook twee dele...  

Die html (wat die user sien)  
Die ts (javascript) wat dinge dynamic maak...  

#### TS file

Soms sal mens n method in die TS file he wat die data vir die dropdown genereer.  
In die geval is dit nie nodig nie want die BE het dit mooi reeds hier gesit...  
Jy sal in die HTML sien die volgende word gebruik.  

form.miXTalkCarriers  

#### Html file

Soek vir Network provider  

..\MiXFleet\UI\Js\FleetAdmin\Templates\asset-commissioning.html  

```html
<div class="span6">
  <label dmx-translate>Network provider</label>
  <select class="span12" ng-options="carrier.carrierID as carrier.carrier for carrier in form.miXTalkCarriers" ng-model="form.miXTalkCarrierID" dmx-validate="carrierId" name="carrierId">
    <option style="display: none" value="">{{ 'Select a network provider' | translate }}</option>
  </select>
  <!--Manual validation message-->
  <span ng:show="manualMiXTalkAllValidationMessage" class="validity-message ng-scope ng-binding" style="">
    <span dmx-translate>{{manualMiXTalkAllValidationMessage}}</span>
  </span>
</div>
```
