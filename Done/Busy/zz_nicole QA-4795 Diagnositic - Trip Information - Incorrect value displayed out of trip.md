# QA-4795 Diagnositic - Trip Information - Incorrect value displayed out of trip

  QA - Diagnositic - Trip Information - Incorrect value displayed out of trip

  ODO:
  				<td>{{controller.group['trip'].odometer.value}} {{ controller.group['trip'].odometer.unit.display | translate}}</td>

  status.Odometer = tripInfo.Odometer
  tripInfo = muProxy.GetDiagnosticsTripInformation

  MiX.DeviceIntegration.Core.DeviceState
    odometerOffset = _odometerState.GetOdometerOffset(mobileUnitId)

    A) Asset out of trip
      _odometerState.GetAssetLastTripEndOdometer(mobileUnitId) + odometerOffset
        1) _redisCache.GetItem(mobileUnitId, Properties.LAST_TRIP_END_ODOMETER)
        2) _deviceStateRepository.GetState(mobileUnitId, Properties.LAST_TRIP_END_ODOMETER)
           1) [state].[MobileUnitState_GetStatesForSingleMobileUnit]
           2) LAST_TRIP_END_ODOMETER = -4403033164446606692
        3) return 0

    B) Asset in trip
      _odometerState.GetUnitRawOdometer(mobileUnitId) + odometerOffset;
        1) _redisCache.GetItem(mobileUnitId, Properties.UNIT_RAW_ODOMETER)
        2) _deviceStateRepository.GetState(mobileUnitId, Properties.UNIT_RAW_ODOMETER)
           1) UNIT_RAW_ODOMETER = -3166755750272960197
           2) state].[MobileUnitState_GetStatesForSingleMobileUnit
        3) return 0