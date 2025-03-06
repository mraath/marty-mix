# UAT-687 Remora and Oyster

Par

  http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/Reports/Reports_GetDiagnosticReportData
  /api/reports/diagnostic-data
  "FirmwareVersion": "string"

	GetDiagnosticReportData

	NOT USED


	isRemora || isOyster

	PBS firmware version
	generalStatusInfo.pbsFirmwareVersion

	BE: ConvertGeneralStatusInfo
	dsp.GetPBSFirmwareVersionForMobileUnit(assetConfigDetails.AssetId)

	API
	GetDeviceStateValueForMobileUnit(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.PBS_FIRMWARE_VERSION)
	PBS_FIRMWARE_VERSION = 5145134252745615892;

	DeviceStateControllerRoutes.GetDeviceStateValueForMobileUnit
	public const string GetDeviceStateValueForMobileUnit = "mobile-unit/{mobileUnitId}/device/{deviceId}/property/{propertyId}/device-state-value";
	[state].[MobileUnitState_GetStatesForMobileUnits] ([state].[MobileUnitState]) ?? EF (MobileUnitProperties)

	Hi @PAUL, I had a look and our diagnostics screen doesn't make use of that end-point.
	For Remora and Oyster we read this value from state.
	It first looks for the value in [state].[MobileUnitState]
	If that is null it makes use of Entity Framework [MobileUnitProperties]
	The id it looks for is: PBS_FIRMWARE_VERSION: 5145134252745615892

