
Parent:: [[Diagnostic Modal]]
Friend:: [[Property Bag]]

## FE-1350 [TIM] REG Live tracking: GPS status information not available on asset diagnostics

Diagnostics window > Fleet services (asset's status values) > "[dynamix].[AssetStatusValues_Get]"
Asset status GPSReading property > gps values from the status string
!! This however does not always have the correct values to populate the GpsStatusInfo !!


Hey daar. Ek hoop jy doen nog baie goed! 

Ek het gekyk na n issue: FE-1350 (Diagnostics Modal)
GPS data is leeg, last position is nie.
Hul het dit gelog as regression maar dit lyk nie vir my na regression nie.
Dis reeds so op UAT.

My enigste ding wat ek kan doen is om met die Devs involved te praat en te hoor of hul kode in orde lyk.
So ek het probeer om sin te maak van dit als maar dis redelik involved...

In kort... lyk dit of waar ek jou moet vra die volgende is...
xxxxxxxxxxxxxxxx


Diagnotics modal summary


- **FM**

  Request URL: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/2364975042774694384/7071574470134052972/diagnostics/0


  - GPS status information
    FE
      C:\Projects\MiXFleet\UI\Js\FleetAdmin\Templates\asset-diagnostics.html
        gpsStatusInfo
    BE
      GPS_STATUS_INFO
        .... as BE below
          GetAssetDiagnosticInfoDefault
          entity > AssetsManager.GetAssetDiagnosticInfo
            entity.ToCarrier
              carrier.LatestAVLInfo (asd.LastAVL) > TrackingRepository.GetLatestGPSReading (Tim)
            ----------
            last_position > TrackingRepository.GetLatestGPSReading
            ----------
            entity (asd) = AssetsManager.GetAssetDiagnosticInfo
                fleetStatusValues = AssetsClient.GetStatusValuesAsync (fleet client)
                var statusValues = fleetStatusValues.ToEntity
                asd.AssetStatus = AssetStatusBagConverter.Convert(statusValues, orgId) 
                    bag = statusValues.VehicleStatus;
                    statusValues.GPSReading = ConvertGPSReading(bag)
			          X asd.LastAVL = TrackingRepository.GetLatestGPSReading(orgId, assetId, correlationId);
            assetConfigDetails = DeviceIntegrationManager.GetAssetConfigDetails
                ...
            carier > entity.tocarrier(assetConfigDetails)
                carrier.GpsStatusInfo = ConvertGPSReading(asd.AssetStatus.GPSReading
            -------------
            Summary:
            AssetsClient.GetStatusValuesAsync > statusValues
              bag > statusValues.vehicleStatus
                bag converted > asd.AssetStatus.GPSReading
            GPS_data = asd.AssetStatus.GPSReading > bag converted > statusValues.vehicleStatus > AssetsClient.GetStatusValuesAsync
            -------------
            fleetstatusvalues = AssetsClient.GetStatusValuesAsync   <<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>
            fleetStatusValues = AssetsClient.GetStatusValuesAsync
            assetConfigDetails (asd) > DeviceIntegrationManager.GetAssetConfigDetails
              asd.AssetStatus = propertybag(statusValues)
                statusValues = AssetsClient.GetStatusValuesAsync
            carrier.GpsStatusInfo > ConvertGPSReading(asd.AssetStatus.GPSReading
            ASD = AssetStatusDetails entity = AssetsManager.GetAssetDiagnosticInfo(authToken, orgId, assetId, CorrelationId)
            ConvertGPSReading(ASD.AssetStatus (fleetstatusvalues) .GPSReading 
                [ConvertGPSReading(bag)]
                <--> CHECK WHO LAST TOUCHED THIS
    API
    DB

  - Latest position information
    FE
      C:\Projects\MiXFleet\UI\Js\FleetAdmin\Templates\asset-diagnostics.html
        latestAVLInfo
    BE
      LATEST_AVL_INFO
      LATEST_POSITION_INFO
        GetAssetDiagnosticInfo
          Splits into 4k, 6k.... 2k.... other (<focussed on this>)
          GetAssetDiagnosticInfoDefault
            also ASD
                ASD.LastAVL (comes from)
                    TrackingRepository.GetLatestGPSReading
                        tracking repo...
                          <--> CHECK WHO LAST TOUCHED THIS
    API
    DB

- **4k, 6k**
  - GPS status information
    FE
      C:\Projects\MiXFleet\UI\Js\ConfigAdmin\Templates\Diagnostics\DiagnosticsGPS.html
        gps
        getDiagnosticsGPS
    BE
      GPS_STATUS_INFO
        GetDiagnosticsGPS
          muProxy.GetDiagnosticsGPSInformation
    API
      GetDiagnosticsGPSInformation
        MobileUnitStateInSharedCache().GetGpsInformation
        else null !!
        [wynand]                  <-->
    DB
  - Latest position information
    FE
      C:\Projects\MiXFleet\UI\Js\ConfigAdmin\Templates\Diagnostics\DiagnosticsPosition.html
        position
        getDiagnosticsPosition
    BE
      GetDiagnosticsPosition
        List<GPSReading> latestPositions = TrackingManager.GetLatestPositionsForAssetsByAssetIds(authToken, orgId, new List<long> { assetId }, CorrelationId);
          XXXXXX
          [Tim, Christo, Arnold, Chad]           <-->
    API
    DB


## FE-1350 [TIM] REG Live tracking: GPS status information not available on asset diagnostics





Diagnostics window > Fleet services (asset's status values) > "[dynamix].[AssetStatusValues_Get]"

Asset status GPSReading property > gps values from the status string

!! This however does not always have the correct values to populate the GpsStatusInfo !!

  
  

Hey daar. Ek hoop jy doen nog baie goed! 

  

Ek het gekyk na n issue: FE-1350 (Diagnostics Modal)

GPS data is leeg, last position is nie.

Hul het dit gelog as regression maar dit lyk nie vir my na regression nie.

Dis reeds so op UAT.

  

My enigste ding wat ek kan doen is om met die Devs involved te praat en te hoor of hul kode in orde lyk.

So ek het probeer om sin te maak van dit als maar dis redelik involved...

  

In kort... lyk dit of waar ek jou moet vra die volgende is...

xxxxxxxxxxxxxxxx

  
  

Diagnotics modal summary

  
  

- **FM**

  

  Request URL: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/2364975042774694384/7071574470134052972/diagnostics/0

  
  

  - GPS status information

    FE

      C:\Projects\MiXFleet\UI\Js\FleetAdmin\Templates\asset-diagnostics.html

        gpsStatusInfo

    BE

      GPS_STATUS_INFO

  

        .... as BE below

  

          GetAssetDiagnosticInfoDefault

  

          

  
  

          entity > AssetsManager.GetAssetDiagnosticInfo

            entity.ToCarrier

              carrier.LatestAVLInfo (asd.LastAVL) > TrackingRepository.GetLatestGPSReading (Tim)

  

            ----------

  

            last_position > TrackingRepository.GetLatestGPSReading

  

            ----------

Child:: [[Property Bag]]
  

            entity (asd) = AssetsManager.GetAssetDiagnosticInfo

  

                fleetStatusValues = AssetsClient.GetStatusValuesAsync (fleet client)

                var statusValues = fleetStatusValues.ToEntity

                asd.AssetStatus = AssetStatusBagConverter.Convert(statusValues, orgId)

                    bag = statusValues.VehicleStatus;

                    statusValues.GPSReading = ConvertGPSReading(bag)

  

                X asd.LastAVL = TrackingRepository.GetLatestGPSReading(orgId, assetId, correlationId);

  

            assetConfigDetails = DeviceIntegrationManager.GetAssetConfigDetails

                ...

  

            carier > entity.tocarrier(assetConfigDetails)

                carrier.GpsStatusInfo = ConvertGPSReading(asd.AssetStatus.GPSReading

  

            -------------

  

            Summary:

            AssetsClient.GetStatusValuesAsync > statusValues

              bag > statusValues.vehicleStatus

                bag converted > asd.AssetStatus.GPSReading

  

            GPS_data = asd.AssetStatus.GPSReading > bag converted > statusValues.vehicleStatus > AssetsClient.GetStatusValuesAsync

  

            -------------

  
  
  

            fleetstatusvalues = AssetsClient.GetStatusValuesAsync   <<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>

  
  
  

            fleetStatusValues = AssetsClient.GetStatusValuesAsync

  
  

            assetConfigDetails (asd) > DeviceIntegrationManager.GetAssetConfigDetails

  

              asd.AssetStatus = propertybag(statusValues)

                statusValues = AssetsClient.GetStatusValuesAsync

  

            carrier.GpsStatusInfo > ConvertGPSReading(asd.AssetStatus.GPSReading

  
  
  

            ASD = AssetStatusDetails entity = AssetsManager.GetAssetDiagnosticInfo(authToken, orgId, assetId, CorrelationId)

  

            ConvertGPSReading(ASD.AssetStatus (fleetstatusvalues) .GPSReading

  

                [ConvertGPSReading(bag)]

  

                <--> CHECK WHO LAST TOUCHED THIS

  

    API

    DB

  

  - Latest position information

    FE

      C:\Projects\MiXFleet\UI\Js\FleetAdmin\Templates\asset-diagnostics.html

        latestAVLInfo

    BE

      LATEST_AVL_INFO

      LATEST_POSITION_INFO

        GetAssetDiagnosticInfo

          Splits into 4k, 6k.... 2k.... other (<focussed on this>)

  

          GetAssetDiagnosticInfoDefault

  

            also ASD

                ASD.LastAVL (comes from)

                    TrackingRepository.GetLatestGPSReading

                        tracking repo...

  

                          <--> CHECK WHO LAST TOUCHED THIS

  
  

    API

    DB

  

- **4k, 6k**

  

  - GPS status information

    FE

      C:\Projects\MiXFleet\UI\Js\ConfigAdmin\Templates\Diagnostics\DiagnosticsGPS.html

        gps

        getDiagnosticsGPS

    BE

      GPS_STATUS_INFO

        GetDiagnosticsGPS

          muProxy.GetDiagnosticsGPSInformation

    API

      GetDiagnosticsGPSInformation

        MobileUnitStateInSharedCache().GetGpsInformation

        else null !!

  

        [wynand]                  <-->

  

    DB

  

  - Latest position information

    FE

      C:\Projects\MiXFleet\UI\Js\ConfigAdmin\Templates\Diagnostics\DiagnosticsPosition.html

        position

        getDiagnosticsPosition

    BE

      GetDiagnosticsPosition

        List<GPSReading> latestPositions = TrackingManager.GetLatestPositionsForAssetsByAssetIds(authToken, orgId, new List<long> { assetId }, CorrelationId);

          XXXXXX

  

          [Tim, Christo, Arnold, Chad]           <-->

    API

    DB

  