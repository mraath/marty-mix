5849 results - 791 files

_MiXTelematicsFiles\Microsoft Teams Chat Files\LogicalDevices.cs:
  103  		public const long ELVIST = -7357202562364966061;
  104: 		public const long SSC_DTCO_ODOMETER = 4934038548513523645;
  105  		public const long STATE_LINE_CROSSING = -4508727509657924314;

  133  		public const long WIRELESS_TRAILER = 7698308803231676529;
  134: 		public const long ESTIMATED_ODOMETER = 1819976686812319282;
  135  

Database\Controller_Base\Schemas\dbo\Functions\DownloadProcess\PreprocessStream.cs:
   21  			EndTime = 0x040,
   22: 			StartOdo = 0x080,
   23: 			EndOdo = 0x100,
   24  			ValuePresent = 0x200,

   81  
   82: 		internal void SaveIni(short driverId, int odometer, int distance, DateTime start, DateTime? depart, DateTime end, byte maxSpeed, short maxRevs, byte maxBrake, int speedTime, int speedOccurs, int revsTime, int revsOccurs, int brakeTime, int brakeOccurs, int greenbandTime, int greenbandOccurs, int excessiveIdleTime, int excessiveIdleOccurs, int idleTime, int idleOccurs)
   83  		{

   89  			_writer.Write(driverId);
   90: 			_writer.Write(odometer);
   91  			_writer.Write(distance);

  145  
  146: 		internal void SaveEventRecord(short eventId, short flags, byte actionId, byte actionIdx, byte? dmiInputId, int? dParamB, int? startSequence, DateTime? startDate, int? startOdometer, int? endSequence, DateTime? endDate, int? endOdometer, int? totalTime, int? totalOccurs, int? value)
  147  		{ // 55 bytes

  152  			_writer.Write((byte)2); //record type
  153: 			ProcessBase(eventId, flags, actionId, actionIdx, dmiInputId, dParamB, startSequence, startDate, startOdometer, endSequence, endDate, endOdometer, totalTime, totalOccurs);
  154  			_writer.Write(value ?? 0);

  168  
  169: 		internal void SaveTerminalRecord(short eventId, short flags, byte actionId, byte actionIdx, int endSequence, DateTime endDate, int? endOdometer, string menuId, string menuItemCode, byte valueType, byte[] value)
  170  		{

  188  			_writer.Write(endDate.Ticks);
  189: 			_writer.Write(endOdometer ?? 0);
  190  			_writer.Write(menuId);

  214  
  215: 		internal void SaveGpsRecord(short eventId, short flags, byte actionId, byte actionIdx, int endSequence, DateTime endDate, int? endOdometer, int longitude, int latitude, short altitude, byte heading, byte satellites, byte hdop, int age, int distance, byte velocity)
  216  		{// 77 bytes

  221  			_writer.Write((byte)4); //record type
  222: 			ProcessBase(eventId, flags, actionId, actionIdx, null, null, null, null, null, endSequence, endDate, endOdometer, null, null);
  223  			_writer.Write((short)0x01FF);

  307  
  308: 		private void ProcessBase(short eventId, short flags, byte actionId, byte actionIdx, byte? dmiInputId, int? dParamB, int? startSequence, DateTime? startDate, int? startOdometer, int? endSequence, DateTime? endDate, int? endOdometer, int? totalTime, int? totalOccurs)
  309  		{ // version + 51 bytes

  318  			_writer.Write(startDate.HasValue ? startDate.Value.Ticks : (long)0);
  319: 			_writer.Write(startOdometer ?? 0);
  320  			_writer.Write(endSequence ?? 0);
  321  			_writer.Write(endDate.HasValue ? endDate.Value.Ticks : (long)0);
  322: 			_writer.Write(endOdometer ?? 0);
  323  			_writer.Write(totalTime ?? 0);

Database\Controller_Base\Schemas\dbo\Functions\TachoDecode\DataLine.cs:
  160  
  161:   private class DoOdometer : DataLine
  162    {
  163:     public DoOdometer(TachoDecoder Parent, TachoInterval Interval, int InitialValue) : base(Parent, Interval, InitialValue) { }
  164  

Database\Controller_Base\Schemas\dbo\Functions\TachoDecode\TachoDecoder.cs:
   13      F3 = 0x0080,
   14:     Odo = 0x0040,
   15      I1 = 0x0020,

  178  
  179:     if ((_fieldMask & TachoMask.Odo) == TachoMask.Odo)
  180      {
  181        ushort valuePart1 = BitConverter.ToUInt16(_block, 11);
  182:       _doLines[3] = new DoOdometer(this, interval, valuePart1 + (_block[13] * 65536));
  183      }

DynaMiX.Backend\API\DynaMiX.API\APISettings.cs:
   11  
   12: 		//todo jm: find a better way to do this.
   13  		[ConfigurationProperty("APIHost", IsRequired = true)]

  282  
  283: 		[ConfigurationProperty("DTCODownloadManagerBaseUrl", DefaultValue = "/dtco_download_manager")]
  284: 		public string DTCODownloadManagerBaseUrl
  285  		{
  286: 			get { return (string)base["DTCODownloadManagerBaseUrl"]; }
  287  		}

DynaMiX.Backend\API\DynaMiX.API\Carriers\BaseApp\Contacts\Converter.cs:
  48  		{
  49: 			//TODO HM: Verify that I have done this correctly (call it a code review if needs be) - PV
  50  			var carrier = new ContactSummaryCarrier();

DynaMiX.Backend\API\DynaMiX.API\Carriers\Common\ImportExport\FuelImportCarrier.cs:
  22  
  23: 		[Display(Name = DynaMiX.Common.Constants.ColumnHeadings.FuelImportTemplate.ODOMETER_UNIT)]
  24  		[Required]
  25: 		public string OdometerUnit { get; set; }
  26  
  27: 		[Display(Name = DynaMiX.Common.Constants.ColumnHeadings.FuelImportTemplate.ODOMETER)]
  28  		[Required]
  29: 		public double Odometer { get; set; }
  30  

DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\AllLevels\ConfigAdminConverters.cs:
  1267  					DateTimeOffset dateValue = DateTimeOffset.Parse(carrierValue);
  1268: 					return (((Convert.ToDouble(dateValue.Hour) * 3600)
  1269: 									 + (Convert.ToDouble(dateValue.Minute) * 60)
  1270: 									 + Convert.ToDouble(dateValue.Second)) / 86400).ToString();
  1271  				}

  1375  						Converter.ConvertToSystem(
  1376: 							sourceValue.ToDouble(),
  1377  							string.IsNullOrEmpty(fromUnit) ? Unit.KilometresPerHour : fromUnit,

  1386  					Converter.ConvertToSystem(
  1387: 						sourceValue.ToDouble(),
  1388  						string.IsNullOrEmpty(fromUnit) ? Unit.Kilometres : fromUnit,

  1396  					Converter.ConvertToSystem(
  1397: 						sourceValue.ToDouble(),
  1398  						string.IsNullOrEmpty(fromUnit) ? Unit.Metres : fromUnit,

  1406  					Converter.ConvertToSystem(
  1407: 						sourceValue.ToDouble(),
  1408  						string.IsNullOrEmpty(fromUnit) ? Unit.Litres : fromUnit,

  1420  					Converter.ConvertToSystem(
  1421: 						sourceValue.ToDouble(),
  1422  						string.IsNullOrEmpty(fromUnit) ? Unit.DegreesCelcius : fromUnit,

  1432  						{
  1433: 							double uk = Math.Round(MetricTonneToLongTon(sourceValue.ToDouble()), ConfigAdminSettings.Current.Precision);
  1434  							return new Tuple<string, string>(uk + "", "t");

  1437  						{
  1438: 							double us = MetricTonneToShortTon(sourceValue.ToDouble());
  1439  							return new Tuple<string, string>(us + "", "t (US)");

  1441  
  1442: 						return new Tuple<string, string>(sourceValue.ToDouble() + "", "t"); // the user is using metric
  1443  					}

  1447  						{
  1448: 							double uk = Math.Round(KgToLbs(sourceValue.ToDouble()), ConfigAdminSettings.Current.Precision);
  1449  							return new Tuple<string, string>(uk + "", "lbs");

  1451  
  1452: 						return new Tuple<string, string>(sourceValue.ToDouble() + "", "kg"); // the user is using metric
  1453  					}

  1455  					Converter.ConvertToSystem(
  1456: 						sourceValue.ToDouble(),
  1457  						string.IsNullOrEmpty(fromUnit) ? Unit.KilometresPerHourPerSecond : fromUnit,

  1465  					Converter.ConvertToSystem(
  1466: 						sourceValue.ToDouble(),
  1467  						string.IsNullOrEmpty(fromUnit) ? Unit.KilometresPerLitre : fromUnit,

  1772  				IsEnabled = entity.IsEnabled,
  1773: 				StartOdometer = entity.IsEnabled && entity.StartOdometer,
  1774: 				EndOdometer = entity.IsEnabled && entity.EndOdometer,
  1775  				StartPosition = entity.IsEnabled && entity.StartPosition,

  1896  				{
  1897: 					entity.StartOdometer = carrier.StartOdometer;
  1898  					entity.StartPosition = carrier.StartPosition;

  1903  				{
  1904: 					entity.EndOdometer = carrier.EndOdometer;
  1905  					entity.EndPosition = carrier.EndPosition;

  1912  				entity.Delay = 0;
  1913: 				entity.StartOdometer = false;
  1914: 				entity.EndOdometer = false;
  1915  				entity.StartPosition = false;

DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\AllLevels\Devices\DeviceDetailsPageCarriers.cs:
  78  	{
  79: 		//TODO ES incorrect naming; this includes ALL parent devices
  80  		public ParentLogicalDevice(string parentDeviceId, bool autoEnable, bool autoConnect)

DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\AllLevels\Events\EventRecordingActionCarrier.cs:
  38  		/// <summary>
  39: 		/// Gets or sets whether to record the start odometer reading when triggered.
  40  		/// </summary>
  41: 		public bool StartOdometer
  42  		{

  47  		/// <summary>
  48: 		/// Gets or sets whether to record the end odometer reading when triggered.
  49  		/// </summary>
  50: 		public bool EndOdometer
  51  		{

DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\AssetMaintenance\AssetMaintenanceCarrier.cs:
  143  
  144: 	public class AssetMaintenanceOdometerFormCarrier : CarrierBase
  145  	{
  146: 		public AssetMaintenanceOdometerFormCarrier()
  147  		{
  148  			HyperMedia = new HyperMediaCarrier();
  149: 			Odometer = new DistanceCarrier();
  150  		}

  153  		[PositiveFloat(ErrorMessage = ErrorMessages.GeneralValidation.POSITIVE_FLOAT)]
  154: 		public DistanceCarrier Odometer { get; set; }
  155  	}

  202  		public string OrganisationName { get; set; }
  203: 		public Dictionary<string, string> CurrentOdomenterDisplay { get; set; }
  204  		public bool EngineHoursEnabled { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\LibraryLevel\Locations\Converters\LibraryLocationImportConverter.cs:
  36  				{
  37: 					// JVW TODO: Do this properly (store underlying enum value in xls-file and rather use this on import)
  38  					locationImport.location.ActiveMessagePriority = byte.Parse(((int)((ConfigEnums.MessagePriority)Enum.Parse(typeof(ConfigEnums.MessagePriority), RemoveIllegalCharsForEnumParse(importItem.MessagePriority)))).ToString());

DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\PlugManagement\AssetCarrier.cs:
  17  		{
  18: 			OdometerUnit = Unit.Kilometres;
  19  		}

  28  		[Integer(ErrorMessage = ErrorMessages.GeneralValidation.NUMERIC)]
  29: 		public float? Odometer { get; set; }
  30  
  31: 		public string OdometerUnit { get; set; }
  32  

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DownloadTaskCrudCarrier.cs:
  5  
  6: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  7  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOArchiveSettingsCarrier.cs:
  4  
  5: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  6  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOAuthenticationServiceCarrier.cs:
  2  
  3: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  4  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOAuthenticationServicesListCarrier.cs:
  2  
  3: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  4  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOCompanyCardCarrier.cs:
  5  
  6: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  7  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOCompanyCardsListCarrier.cs:
  4  
  5: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  6  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOCompanyCardStatusCarrier.cs:
  2  
  3: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  4  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCODownloadDataCarrier.cs:
   4  
   5: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
   6  {
   7: 	public class DTCODownloadDataCarrier : CarrierBase
   8  	{

  12  
  13: 		public DTCODownloadDataCarrier()
  14  		{

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOFileCarrier.cs:
  4  
  5: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  6  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOFilesListCarrier.cs:
  4  
  5: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  6  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOGroupTreeCarrier.cs:
  7  
  8: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  9  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCORemoteTaskCarrier.cs:
   4  
   5: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
   6  {

  16  		public ZonedDateTimeCarrier LastActionDate { get; set; }
  17: 		public DTCODownloadDataCarrier DownloadData { get; set; }
  18  		public string DownloadType { get; set; }

  26  			Actions = new List<string>();
  27: 			DownloadData = new DTCODownloadDataCarrier();
  28  		}

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCORemoteTaskListCarrier.cs:
  4  
  5: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  6  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCORemoteTaskStatusCarrier.cs:
  2  
  3: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  4  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOSettingsScheduleFrequencyCarrier.cs:
   6  
   7: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
   8  {

  13  		public List<string> Actions { get; set; }
  14: 		public DTCODownloadDataCarrier DTCODownloadData { get; set; }
  15  

  18  			Actions = new List<string>();
  19: 			DTCODownloadData = new DTCODownloadDataCarrier();
  20  		}

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\DTCOStatusDiagnosticsCarrier.cs:
  7  
  8: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  9  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\LandingPageCarrier.cs:
  2  
  3: namespace DynaMiX.Api.Carriers.DTCODownloadManagement
  4  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\CompanyCardCrud\CardExistsCarrier.cs:
  2  
  3: namespace DynaMiX.Api.Carriers.DTCODownloadManagement.CompanyCardCrud
  4  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\CompanyCardCrud\CardPrefixCarrier.cs:
  2  
  3: namespace DynaMiX.Api.Carriers.DTCODownloadManagement.CompanyCardCrud
  4  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\DTCODownloadManagement\CompanyCardCrud\CompanyCardCrudCarier.cs:
  7  
  8: namespace DynaMiX.Api.Carriers.DTCODownloadManagement.CompanyCardCrud
  9  {

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\AssetSummaryCarrier.cs:
  26  
  27: 		public string Odometer { get; set; }
  28  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\AssetCrud\AssetCrudConverter.cs:
  53  				Unit = entity.TargetFuelConsumptionUnits,
  54: 				Value = targetFuelConsumption != 0 ? Convert.ToDouble(targetFuelConsumption) : (double?)null,
  55  				AvailableUnits = new List<UnitCarrier>

  68  				Unit = entity.TargetHourlyFuelConsumptionUnits,
  69: 				Value = targetHourlyFuelConsumption != 0 ? Convert.ToDouble(targetHourlyFuelConsumption) : (double?)null,
  70  				AvailableUnits = new List<UnitCarrier>

  83  				Unit = entity.VolumeUnits,
  84: 				Value = fuelTankCapacity != 0 ? Convert.ToDouble(fuelTankCapacity) : (double?)null,
  85  				AvailableUnits = new List<UnitCarrier>

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\AssetList\AssetListConverter.cs:
  81  
  82: 			UnitsConverter.ConvertDistanceStandardToProfile(assetDetails.Asset, profile, a => a.Odometer, a => a.OdometerUnits);
  83: 			carrier.Odometer = assetDetails.Asset.Odometer;
  84  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\AssetList\AssetListItem.cs:
  40  
  41: 		public float? Odometer { get; set; }
  42  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\Commissioning\AssetCommissioningCarrier.cs:
   36  		public AssetRemoveMobileDeviceFormCarrier RemoveMobileDeviceTemplate { get; set; }
   37: 		public AssetOdometerFormCarrier SetOdoTemplate { get; set; }
   38  		public AssetEngineHoursFormCarrier SetEngineHoursTemplate { get; set; }

  243  
  244: 	public class AssetOdometerFormCarrier : CarrierBase
  245  	{
  246: 		public AssetOdometerFormCarrier()
  247  		{
  248  			HyperMedia = new HyperMediaCarrier();
  249: 			Odometer = new DistanceCarrier();
  250: 			PersistedOdometer = new DistanceCarrier();
  251  		}

  254  		[PositiveFloat(ErrorMessage = ErrorMessages.GeneralValidation.POSITIVE_FLOAT)]
  255: 		public DistanceCarrier Odometer { get; set; }
  256: 		public DistanceCarrier PersistedOdometer { get; set; }
  257: 		public MiX.DeviceIntegration.Common.Enums.FailReason CanSetOdoOffsetAgain { get; set; }
  258  		public bool UsesOnboardOffsets { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\Commissioning\AssetConfigSummaryCarrier.cs:
  17  		public ZonedDateTimeCarrier CurrentConfigurationGeneratedDateTime { get; set; }
  18: 		public bool CanSetOdo { get; set; }
  19  		public bool CanChangeThresholds { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\CostData\AssetCostDataFormCarrier.cs:
  19      [Required(ErrorMessage = ErrorMessages.GeneralValidation.REQUIRED)]
  20: 		public DistanceCarrier Odometer { get; set; }
  21  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\CostData\AssetCostDataTransactionFormCarrier.cs:
  19  
  20:     public DistanceCarrier Odometer { get; set; }
  21  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\CostData\AssetOtherCostTransactionListItemCarrier.cs:
   9  		public ZonedDateTimeCarrier TransactionDate { get; set; }
  10: 		public decimal Odometer { get; set; }
  11  		public decimal TransactionAmount { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\CostData\Converter.cs:
   29  				item.TransactionDate = transaction.TransactionDate.ToDateOnlyCarrier();
   30: 				item.Odometer = UnitsConverter.ConvertDistanceStandardToUnit(transaction.Odometer, distanceUnit);
   31  				item.TransactionAmount = transaction.Cost;

  102  			entity.CategoryId = carrier.CategoryId.ToLong();
  103: 			UnitsConverter.ConvertDistanceToStandard(carrier.Odometer, d => d.Value, d => d.Unit);
  104: 			entity.Odometer = carrier.Odometer.Value.HasValue ? Convert.ToDecimal(carrier.Odometer.Value.Value) : 0;
  105  			entity.Memo = carrier.Memo;

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\Diagnostics\AssetDiagnosticInfoCarrier.cs:
    2  using DynaMiX.Api.Carriers.Common;
    3: using DynaMiX.Api.Carriers.DTCODownloadManagement;
    4  using DynaMiX.Core.Gateway.Carriers;

  118  
  119: 		public string Odometer { get; set; }
  120  

  153  		public string Speed { get; set; }
  154: 		public string Odometer { get; set; }
  155  		public string Imei { get; set; }

  171  		public string Speed { get; set; }
  172: 		public string Odometer { get; set; }
  173  		public string Imei { get; set; }

  193  		public string Speed { get; set; }
  194: 		public string Odometer { get; set; }
  195  		public string Imei { get; set; }

  213  		public string Speed { get; set; }
  214: 		public string Odometer { get; set; }
  215  		public string Imei { get; set; }

  233  		public string Speed { get; set; }
  234: 		public string Odometer { get; set; }
  235  		public string Imei { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\Diagnostics\Converter.cs:
  191  
  192: 			if (asd.AssetStatus.VehicleLastOdo.HasValue) // rather using AssetStatusDetails.AssetStatus.VehicleLastOdo fetched by AssetsManager (rather than GetStatatus Odo)
  193  			{
  194: 				var odometerValue = MiX.Core.Conversion.Converter.ConvertValue(Convert.ToInt64(asd.AssetStatus.VehicleLastOdo.Value), MiX.Core.Conversion.Unit.Kilometres, distanceUnit);
  195: 				diagnosticInfo.Odometer = new DistanceCarrier()
  196  				{
  197  					Unit = distanceUnit,
  198: 					Value = odometerValue
  199  				};

  277  			UnitsConverter.ConvertSpeedStandardToProfile(status, profile, s => s.Speed, s => s.SpeedUnits);
  278: 			UnitsConverter.ConvertDistanceStandardToProfile(status, profile, s => s.Odometer, s => s.OdometerUnits);
  279  			UnitsConverter.ConvertDistanceStandardToProfile(status, profile, s => s.SubTripDistance, s => s.SubTripDistanceUnits);

  307  			carrier.Rpm = status.RPM.HasValue ? status.RPM.Value.ToString() : languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, InformationMessages.Misc.NOT_AVAILABLE).Value;
  308: 			carrier.Odometer = status.Odometer.HasValue ? ((double) status.Odometer.Value).ToString("#.#") + " " + languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, status.OdometerUnits).Value : languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, InformationMessages.Misc.NOT_AVAILABLE).Value;
  309  			carrier.GsmQualityStatus = !string.IsNullOrEmpty(status.SignalQuality) ? status.SignalQuality : languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, InformationMessages.Misc.NOT_AVAILABLE).Value;

  390  			var distanceUnit = UnitsConverter.GetDistanceUnit(profile);
  391: 			carrier.Odometer = status.VehicleLastOdo.HasValue
  392: 				? "≈" + UnitsConverter.ConvertDistanceStandardToUnit(status.VehicleLastOdo.Value, distanceUnit).ToString("#.#") + " " + distanceUnit
  393  				: languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, InformationMessages.Misc.NOT_AVAILABLE).Value;

  458  			var distanceUnit = UnitsConverter.GetDistanceUnit(profile);
  459: 			carrier.Odometer = status.VehicleLastOdo.HasValue
  460: 				? "≈" + UnitsConverter.ConvertDistanceStandardToUnit(status.VehicleLastOdo.Value, distanceUnit).ToString("#.#") + " " + distanceUnit
  461  				: languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, InformationMessages.Misc.NOT_AVAILABLE).Value;

  524  			var distanceUnit = UnitsConverter.GetDistanceUnit(profile);
  525: 			carrier.Odometer = status.VehicleLastOdo.HasValue
  526: 				? "≈" + UnitsConverter.ConvertDistanceStandardToUnit(status.VehicleLastOdo.Value, distanceUnit).ToString("#.#") + " " + distanceUnit
  527  				: languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, InformationMessages.Misc.NOT_AVAILABLE).Value;

  590  			var distanceUnit = UnitsConverter.GetDistanceUnit(profile);
  591: 			carrier.Odometer = status.VehicleLastOdo.HasValue
  592: 				? "≈" + UnitsConverter.ConvertDistanceStandardToUnit(status.VehicleLastOdo.Value, distanceUnit).ToString("#.#") + " " + distanceUnit
  593  				: languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, InformationMessages.Misc.NOT_AVAILABLE).Value;

  657  			var distanceUnit = UnitsConverter.GetDistanceUnit(profile);
  658: 			carrier.Odometer = status.VehicleLastOdo.HasValue
  659: 				? "≈" + UnitsConverter.ConvertDistanceStandardToUnit(status.VehicleLastOdo.Value, distanceUnit).ToString("#.#") + " " + distanceUnit
  660  				: languagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, profile.LanguageCode, InformationMessages.Misc.NOT_AVAILABLE).Value;

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\Diagnostics\DiagnosticsPositionCarrier.cs:
  15  		public ZonedDateTimeCarrier LastAVLDate { get; set; }
  16: 		public string Longitude { get; set; } //TODO: MR: Change to DirectionCarrier
  17: 		public string Latitude { get; set; } //TODO: MR: Change to DirectionCarrier
  18  		public string Velocity { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\Diagnostics\DiagnosticsTripCarrier.cs:
  19  		public string Speed { get; set; }
  20: 		public DistanceCarrier Odometer { get; set; } //TODO: MR: Will have to fix this type
  21: 		public double? EngineHours { get; set; } //TODO: MR: Will have to fix this type
  22  		public string CurrentSubtripDistance { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\Diagnostics\Mix4KDiagnosticsInfoCarrier.cs:
   9  		public string VehicleMode { get; set; }
  10: 		public DistanceCarrier Odometer { get; set; }
  11  		public long? Imsi { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\Diagnostics\MiX2310iStatusInfoCarrier.cs:
  24  		public string InternalBatteryState { get; set; }
  25: 		public DistanceCarrier Odometer { get; set; }
  26  		public string PlatformVersion { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\FuelUsage\AssetFuelUsageCarrier.cs:
  16  		{
  17: 			Odometer = new DistanceCarrier();
  18  			Volume = new VolumeCarrier();

  27  		[PositiveFloat(ErrorMessage = ErrorMessages.GeneralValidation.POSITIVE_FLOAT)]
  28: 		[Range(0, 9999999.99, ErrorMessage = ErrorMessages.Assets.ASSET_FUEL_DATA_ODOMETER_RANGE)]
  29: 		public DistanceCarrier Odometer { get; set; }
  30  

  47  
  48: 		public Dictionary<string, string> LastOdometerValues { get; set; }
  49: 		public Dictionary<string, string> NextOdometerValues { get; set; }
  50  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\FuelUsage\AssetFuelUsageListCarrier.cs:
  14  
  15: 		public string OdometerUnit { get; set; }
  16  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\FuelUsage\AssetFuelUsageListItem.cs:
  15  
  16: 		public double Odometer { get; set; }
  17  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\FuelUsage\FuelUsageConverter.cs:
   16  	{
   17: 		public static AssetFuelUsageListItem ToAssetFuelUsageListItem(this AssetFuelUsage assetFuelUsage, bool canEdit, bool canDelete, string odoUnit, string volumeUnit, string orgBaseCurrency, List<HistoricalTimeZone> historicalTimeZonesForEntities, TimeZoneInfo sourceDataTimezone)
   18  		{

   32  			carrier.Volume = Math.Round(Converter.ConvertValue(assetFuelUsage.Litres, Unit.Litres, volumeUnit), 2);
   33: 			carrier.Odometer = Math.Round(Converter.ConvertValue(assetFuelUsage.Odometer, Unit.Kilometres, odoUnit), 2);
   34  

   62  
   63: 		public static void PopulateFuelUsageData(this AssetFuelUsageCarrier carrier, AssetFuelUsage assetFuelUsage, UnitCarrier baseCurrencyUnit, string odoUnit, string volumeUnit)
   64  		{

   82  
   83: 			double odo = Math.Round(Converter.ConvertValue(assetFuelUsage.Odometer, Unit.Kilometres, odoUnit), 2);
   84: 			carrier.Odometer.Value = odo;
   85: 			carrier.Odometer.Unit = odoUnit;
   86  

   89  
   90: 			carrier.BaseCurrencyAmount.Value = Convert.ToDouble(baseAmount);
   91  			carrier.BaseCurrencyAmount.Unit = assetFuelUsage.BaseCurrency != null ? assetFuelUsage.BaseCurrency : baseCurrencyUnit.Value;

   93  
   94: 			carrier.TransactionAmount.Value = Convert.ToDouble(transAmount);
   95  			carrier.TransactionAmount.Unit = transactionCurrencyUnit.Value;

  107  
  108: 		public static Dictionary<string, string> GetOdometerForAllAvailableUnits(List<UnitCarrier> units, double odometer)
  109  		{

  112  			{
  113: 				values.Add(unit.Value, Math.Round(Converter.ConvertValue(odometer, Unit.Kilometres, unit.Value), 2).ToString());
  114  			}

  143  
  144: 		public static void PopulateDefaultFuelUsageData(this AssetFuelUsageCarrier carrier, AssetFuelUsage lastFuelUsage, UnitCarrier baseCurrencyUnit, string odoUnit, string volumeUnit)
  145  		{

  149  			carrier.Volume.DisplayValue = volumeUnit;
  150: 			carrier.Odometer.Value = 1;
  151: 			carrier.Odometer.Unit = odoUnit;
  152  			if (lastFuelUsage != null)
  153  			{
  154: 				var odo = Math.Round(Converter.ConvertValue(lastFuelUsage.Odometer, Unit.Kilometres, odoUnit), 2);
  155: 				carrier.Odometer.Value = odo;
  156  			}

  180  			var fuelUsage = new AssetFuelUsage();
  181: 			if (carrier.Odometer.Value.HasValue)
  182: 				fuelUsage.Odometer = Converter.ConvertValue(Convert.ToDouble(carrier.Odometer.Value), carrier.Odometer.Unit, Unit.Kilometres);
  183: 			fuelUsage.Litres = Converter.ConvertValue(Convert.ToDouble(carrier.Volume.Value), carrier.Volume.Unit, Unit.Litres);
  184  
  185  			if (carrier.EngineHours.HasValue)
  186: 				fuelUsage.EngineSeconds = Convert.ToDouble(carrier.EngineHours.Value * 3600);
  187  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\MeterReadings\AssetMeterReadingsCarrier.cs:
  19  		public UploadSchedulerCarrier UploadAllForm { get; set; }
  20: 		public Dictionary<string, string> CurrentOdomenterDisplay { get; set; }
  21  		public bool EngineHoursEnabled { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\MeterReadings\OdometerConversionsCarrier.cs:
   8  {
   9: 	public class OdometerConversionsCarrier : CarrierBase
  10  	{
  11: 		public Dictionary<string, string> CurrentOdomenterDisplay { get; set; }
  12  	}

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\ServiceHistory\AssetServiceHistoryCarrier.cs:
  15      {
  16:       Odometer = new DistanceCarrier();
  17        TransactionAmount = new MoneyCarrier();
  18        BaseCurrencyAmount = new MoneyCarrier();
  19:       LastOdometerValues = new Dictionary<string, string>();
  20:       NextOdometerValues = new Dictionary<string, string>();
  21: 			OdometerIntervalValues = new Dictionary<string, string>();
  22  

  36  
  37: 		/* Odometer */
  38  		[Range(1, 10000000, ErrorMessage = ErrorMessages.Assets.VALUE_BETWEEN_1_AND_10000000)]
  39  		[PositiveFloat(ErrorMessage = ErrorMessages.GeneralValidation.POSITIVE_FLOAT)]
  40:     public DistanceCarrier Odometer { get; set; }
  41  

  44      [PositiveFloat(ErrorMessage = ErrorMessages.GeneralValidation.POSITIVE_FLOAT)]
  45:     public DistanceCarrier NextOdometer { get; set; }
  46  
  47:     public DistanceCarrier LastOdometer { get; set; }
  48  
  49:     public Dictionary<string, string> LastOdometerValues { get; set; }
  50:     public Dictionary<string, string> NextOdometerValues { get; set; }
  51: 		public Dictionary<string, string> OdometerIntervalValues { get; set; }
  52  
  53: 		public int OdometerInterval { get; set; }
  54  
  55:     public bool OdometerRemindersEnabled { get; set; }
  56  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\ServiceHistory\AssetServiceHistoryListCarrier.cs:
  14  
  15: 		public string OdometerUnit { get; set; }
  16  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\ServiceHistory\AssetServiceHistoryListItem.cs:
  19  
  20: 		public double Odometer { get; set; }
  21  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\ServiceHistory\ServiceHistoryConverter.cs:
  13  	{
  14: 		public static AssetServiceHistoryListItem ToAssetServiceHistoryListItem(this AssetServiceHistory serviceHistory, bool canEdit, bool canDelete, string odoUnit, string orgBaseCurrency)
  15  		{

  26  			carrier.ServiceDate = serviceHistory.ServiceDate.ToIsoString();
  27: 			carrier.Odometer = Math.Round(Converter.ConvertValue(serviceHistory.Odometer, Unit.Kilometres, odoUnit), 2);
  28  			carrier.Reference = serviceHistory.Reference;

  59  
  60: 			if (carrier.Odometer.Value.HasValue)
  61: 				serviceHistory.Odometer = Converter.ConvertValue(carrier.Odometer.Value.Value, carrier.Odometer.Unit, Unit.Kilometres);
  62  

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\TrailerId\AssetTrailerIdCarrier.cs:
  21  		public ChangeTrailerIdFormCarrier ChangeTrailerIdForm { get; set; }
  22: 		public ChangeOdometerFormCarrier ChangeOdometerForm { get; set; }
  23  		public string TrailerId { get; set; }
  24: 		public DistanceCarrier Odometer { get; set; }
  25: 		public ZonedDateTimeCarrier OdometerDate { get; set; }
  26  		public bool CanUpdate { get; set; }

  46  
  47: 	public class ChangeOdometerFormCarrier : CarrierBase
  48  	{
  49: 		public ChangeOdometerFormCarrier()
  50  		{

  55  		[PositiveFloat(ErrorMessage = ErrorMessages.GeneralValidation.POSITIVE_FLOAT)]
  56: 		public DistanceCarrier NewOdometer { get; set; }
  57: 		public ZonedDateTimeCarrier NewOdometerDate { get; set; }
  58  	}

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Assets\TrailerId\Converter.cs:
  26  
  27: 		public static AssetTrailerDetails ToEntity(this ChangeOdometerFormCarrier carrier)
  28  		{
  29: 			UnitsConverter.ConvertDistanceToStandard(carrier.NewOdometer, a => a.Value, a => a.Unit);
  30  			return new AssetTrailerDetails
  31  			{
  32: 				Odometer = carrier.NewOdometer.Value.Value,
  33: 				OdometerDate = carrier.NewOdometerDate.IsoDateTimeString.ParseIsoDateToDateTimeoffset().DateTime
  34  			};

  36  
  37: 		public static AssetTrailerIDPageCarrier ToCarrier(this AssetTrailerDetails entity, string odoUnit, double odo)
  38  		{

  41  				TrailerId = entity.HexTrailerId,
  42: 				Odometer = new DistanceCarrier { Value = odo, Unit = odoUnit },
  43: 				OdometerDate = entity.OdometerDate.ToZonedDateTimeCarrier()
  44  			};

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Drivers\DriverSummaryCarrier.cs:
  4  {
  5: 	//TODO HML This needs to be merged with DriverSummaryListItem
  6  	[Serializable]

DynaMiX.Backend\API\DynaMiX.API\Carriers\FleetAdmin\Drivers\HoursOfService\HosDriverSummaryCarrier.cs:
  4  {
  5: 	//TODO HML This needs to be merged with DriverSummaryListItem
  6  	[Serializable]

DynaMiX.Backend\API\DynaMiX.API\Carriers\HoursOfService\Converter.cs:
  329  					Distance = workStateData.Distance,
  330: 					StartOdo = workStateData.StartOdometer,
  331  					Location = new HosLocationCarrier(),

DynaMiX.Backend\API\DynaMiX.API\Carriers\InfoHub\EventStreamItemCarrier.cs:
  41  		public AltitudeCarrier Altitude { get; set; }
  42: 		public DistanceCarrier Odometer { get; set; }
  43  		public List<EventStreamItemActionCarrier> Actions { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\InfoHub\InfoHubConverter.cs:
  1004  					AssetId = evnt.AssetId.ToString(),
  1005: 					Odometer = new DistanceCarrier { Value = Convert.ToDouble(evnt.Odometer), Unit = UnitsConverter.StandardUnits.Distance },
  1006: 					Speed = new SpeedCarrier { Value = Convert.ToDouble(evnt.Speed), Unit = UnitsConverter.StandardUnits.Speed },
  1007  					LocationName = evnt.Address,

  1013  				UnitsConverter.ConvertSpeedStandardToProfile(evntItem.Speed, userProfile, x => x.Value, x => x.Unit);
  1014: 				UnitsConverter.ConvertDistanceStandardToProfile(evntItem.Odometer, userProfile, x => x.Value, x => x.Unit);
  1015  

  1199  				To = job.ExpiryDate.HasValue ? new ZonedDateTime(job.ExpiryDate.Value, sourceDataTimezone).ToHistoricalTimeZone(asset.AssetId, historicalTimeZonesForEntities, sourceDataTimezone).ToCarrier() : null,
  1200: 				Eta = null, //todo jm
  1201  				Status = job.MessageStatus.GetDescription(),

  1437  				HeadingDirection = eventDetail.Heading.HasValue ? eventDetail.HeadingCardinal : null,
  1438: 				Speed = new SpeedCarrier { Value = Convert.ToDouble(eventDetail.Speed), Unit = UnitsConverter.StandardUnits.Speed },
  1439: 				SpeedLimit = new SpeedCarrier { Value = Convert.ToDouble(eventDetail.SpeedLimit), Unit = UnitsConverter.StandardUnits.Speed },
  1440: 				Odometer = new DistanceCarrier { Value = Convert.ToDouble(eventDetail.Odometer), Unit = UnitsConverter.StandardUnits.Distance },
  1441  				Altitude = eventDetail.Altitude.HasValue ? new AltitudeCarrier { Value = eventDetail.Altitude.Value, Unit = UnitsConverter.StandardUnits.Altitude } : null,

  1454  			UnitsConverter.ConvertSpeedStandardToProfile(carrier.SpeedLimit, userProfile, x => x.Value, x => x.Unit);
  1455: 			UnitsConverter.ConvertDistanceStandardToProfile(carrier.Odometer, userProfile, x => x.Value, x => x.Unit);
  1456  			if (carrier.Altitude != null)

  1543  			carrier.HeadingDirection = eventDetail.Heading.HasValue ? eventDetail.HeadingCardinal : null;
  1544: 			carrier.Speed = new SpeedCarrier { Value = Convert.ToDouble(eventDetail.Speed), Unit = UnitsConverter.StandardUnits.Speed };
  1545: 			carrier.Odometer = new DistanceCarrier { Value = Convert.ToDouble(eventDetail.Odometer), Unit = UnitsConverter.StandardUnits.Distance };
  1546  			carrier.Altitude = eventDetail.Altitude.HasValue ? new AltitudeCarrier { Value = eventDetail.Altitude.Value, Unit = UnitsConverter.StandardUnits.Altitude } : null;

  1556  			UnitsConverter.ConvertSpeedStandardToProfile(carrier.Speed, userProfile, x => x.Value, x => x.Unit);
  1557: 			UnitsConverter.ConvertDistanceStandardToProfile(carrier.Odometer, userProfile, x => x.Value, x => x.Unit);
  1558  			if (carrier.Altitude != null)

DynaMiX.Backend\API\DynaMiX.API\Carriers\InfoHub\TrackingMessageStreamItemCarrier.cs:
  26  		public AltitudeCarrier Altitude { get; set; }
  27: 		public DistanceCarrier Odometer { get; set; }
  28  		public MapProviderCarrier MapProvider { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\JobsAndMessaging\DefaultOptions\Converter.cs:
  227  				AddMessageTemplate = new MessageOptionCarrier(),
  228: 				CanAdd = true  //TODO JM: If organisation is making use of terminals, only a maximum of 5 rows allowed. Check number of rows and set bool.
  229  			};

  278  				AddReplyTemplate = new ReplyOptionCarrier(),
  279: 				CanAdd = true //todo check limit on number of allowed replies
  280  			};

DynaMiX.Backend\API\DynaMiX.API\Carriers\JourneyManagement\JourneyDriverRiskAssessmentDetailsCarrier.cs:
  19  
  20: 		public string DriverRiskAssessments { get; set; } //TODO: MR: List<JourneyDriverRiskAssessmentCarrier> - Replace this with carrier in future
  21  

DynaMiX.Backend\API\DynaMiX.API\Carriers\JourneyManagement\JourneyManagementConverter.cs:
   321  
   322: 				//TODO GDS: Add Logic To Check Whether The Cargo Item may Be Edited
   323  				AllowCargoItemEdit = true

   413  
   414: 			//TODO GDS: Add Logic To Check Whether The Assets may Be Edited
   415  			if (entity.JourneyAssetDrivers.Where(x => x.DriverName == DynaMiX.Common.Constants.InformationMessages.JourneyManagement.JOURNEY_SITE_RESTRICTED).Count() == 0)

   655  
   656: 			//TODO GDS: Add Logic To Check Whether The Asset Passengers may Be Edited
   657  			carrier.AllowAssetPassengerEdit = true;

   719  
   720: 			//TODO GDS: Add Logic To Check Whether The Cargo Assets may Be Edited
   721  			carrier.AllowAssetCargoEdit = true;

   965  		{
   966: 			//todo Zonika complete
   967  

  1601  			{
  1602: 				start = new MiX.Spatial.Point() { Latitude = Convert.ToDouble(startArray[0]), Longitude = Convert.ToDouble(startArray[1]) };
  1603  			}

  1605  			{
  1606: 				end = new MiX.Spatial.Point() { Latitude = Convert.ToDouble(EndArray[0]), Longitude = Convert.ToDouble(EndArray[1]) };
  1607  			}

  1719  				{
  1720: 					result.Waypoints.Add(new MiX.Spatial.Point() { Latitude = Convert.ToDouble(temp[0]), Longitude = Convert.ToDouble(temp[1]) });
  1721  				}

  1734  			{
  1735: 				start = new Coordinate() { Latitude = Convert.ToDouble(startArray[0]), Longitude = Convert.ToDouble(startArray[1]) };
  1736  			}

  1738  			{
  1739: 				end = new Coordinate() { Latitude = Convert.ToDouble(EndArray[0]), Longitude = Convert.ToDouble(EndArray[1]) };
  1740  			}

  1768  				{
  1769: 					result.Waypoints.Add(new MiX.Spatial.Point() { Latitude = Convert.ToDouble(temp[0]), Longitude = Convert.ToDouble(temp[1]) });
  1770  				}

DynaMiX.Backend\API\DynaMiX.API\Carriers\JourneyManagement\JourneyPreDeparturePageCarrier.cs:
  19  		public string JourneyRisk { get; set; }
  20: 		public string DriverRiskAssessments { get; set; } //TODO: MR: Add a carrier for this in future
  21  		public List<DriverAssessedDetailCarrier> Drivers { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\JourneyManagement\JourneyProgressStatusUpdateDisplayListCarrier.cs:
  7  {
  8: 	//todo zonika remove
  9  	public class JourneyProgressStatusUpdateDisplayListCarrier

DynaMiX.Backend\API\DynaMiX.API\Carriers\JourneyManagement\JourneyWizardRiskAssessmentStepCarrier.cs:
  27  		public List<DriverAssessedDetailCarrier> Drivers { get; set; } 
  28: 		public string RiskAssessment { get; set; } //TODO: MR: Change this JSON object to an actual carrier - there is a story for this
  29  		public string ReasonForChange { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\Mobitech\Converters\Workers\Converter.cs:
  112  				if (w.CurrentLatitude.HasValue)
  113: 					latLngCurrent.Latitude = Convert.ToDouble(w.CurrentLatitude.Value);
  114  				if (w.CurrentLongitude.HasValue)
  115: 					latLngCurrent.Longitude = Convert.ToDouble(w.CurrentLongitude.Value);
  116  
  117  				if (w.CurrentTaskLatitude.HasValue)
  118: 					latLngTask.Latitude = Convert.ToDouble(w.CurrentTaskLatitude.Value);
  119  				if (w.CurrentTaskLongitude.HasValue)
  120: 					latLngTask.Longitude = Convert.ToDouble(w.CurrentTaskLongitude.Value);
  121  

DynaMiX.Backend\API\DynaMiX.API\Carriers\Operations\DatabaseAdmin\Converter.cs:
   55  			carrier.ParentGroupName = entity.DealerName;
   56: 			carrier.DtcoDownloadManagement = entity.HasFeature(OrgFeature.DtcoDownloadManagement);
   57  			carrier.TimeEntryEnabled = entity.HasFeature(OrgFeature.TimeEntryExtension);

  121  
  122: 			if (carrier.DtcoDownloadManagement && !org.HasFeature(OrgFeature.DtcoDownloadManagement))
  123: 				org.AddFeature(OrgFeature.DtcoDownloadManagement);
  124  
  125: 			if (!carrier.DtcoDownloadManagement && org.HasFeature(OrgFeature.DtcoDownloadManagement))
  126: 				org.RemoveFeature(OrgFeature.DtcoDownloadManagement);
  127  

DynaMiX.Backend\API\DynaMiX.API\Carriers\Operations\DatabaseAdmin\DatabaseAdminMeasurementSettingsPageCarrier.cs:
   9  	{
  10: 		//TODO JM: Add languages to RegionalSettingsCarrier (or make new one)
  11  		public MeasurementSettingsDataCarrier Data { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\Operations\DatabaseAdmin\DatabaseAdminOrgDetailsCarrier.cs:
  38  		public string ParentGroupName { get; set; }
  39: 		public bool DtcoDownloadManagement { get; set; }
  40  		public bool TimeEntryEnabled { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\Operations\DataCentreAdmin\ApiAccounts\Converter.cs:
  28  			entity.FMUser.MeasurementType = (MeasurementType)int.Parse(carrier.MeasurementUnitId);
  29: 			entity.FMUser.FuelCaptureDistanceMeasurementType = (MeasurementType)int.Parse(carrier.OdoUnitId);
  30  			entity.FMUser.FuelCaptureVolumeMeasurementType = (MeasurementType)int.Parse(carrier.VolumeUnitId);

  64  			form.MeasurementUnitId = ((int) entity.FMUser.MeasurementType).ToString();
  65: 			form.OdoUnitId = ((int) entity.FMUser.FuelCaptureDistanceMeasurementType).ToString();
  66  			form.VolumeUnitId = ((int) entity.FMUser.FuelCaptureVolumeMeasurementType).ToString();

DynaMiX.Backend\API\DynaMiX.API\Carriers\Operations\DataCentreAdmin\ApiAccounts\DataCentreApiAccountsPageCarrier.cs:
   29  		public List<DropDownListItemCarrier> ConsumptionUnits { get; set; }
   30: 		public List<DropDownListItemCarrier> OdoUnits { get; set; }
   31  		public List<DropDownListItemCarrier> VolumeUnits { get; set; }

  115  		[ValidatorAlias("FuelCaptureDistanceMeasurementType")]
  116: 		public string OdoUnitId { get; set; }
  117  

DynaMiX.Backend\API\DynaMiX.API\Carriers\Operations\OrgSettings\Converter.cs:
  182  
  183: 			//TODO: Uncomment once nested validation works
  184  			//trackingOptionsCarrier.PositionFilter = entity.PositionFilter.ToCarrier();

DynaMiX.Backend\API\DynaMiX.API\Carriers\Operations\OrgSettings\TrackingOptionsCarrier.cs:
  77  
  78: 		//TODO: Add nested validation to allow this
  79  		//public PositionFilterCarrier PositionFilter { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\RoviConfig\Converters.cs:
   25  {
   26: 	// TODO: This should be split out to ConvertersV1 and ConvertersV2 as it will become more difficult to manage as the number of devices grow.
   27  	// Split into ConvertersV1, ConvertersV2, ConvertersV3 and ConvertersV4

  294  				result.DeviceType = "MiX Rovi I";
  295: 				//FLEET-5182 TODO: THIS IS A MAJOR HACK!!!!!!! NEEDS TO CHANGE WHEN ROVI SYSTEM IS RE-ADDRESSED.
  296  				result.MicronetDeviceId = string.Empty;

DynaMiX.Backend\API\DynaMiX.API\Carriers\RoviConfig\ConvertersV2.cs:
  23  
  24: 			form.Rovis = PeripheralDevices.MIX_ROVI2.ToString(); // TODO: This should go where settings are copied.
  25  			form.SupportsDataInputs = component.SupportsDataInputs;

DynaMiX.Backend\API\DynaMiX.API\Carriers\RoviConfig\ConvertersV3.cs:
  22  
  23: 			form.Rovis = PeripheralDevices.MIX_ROVI3.ToString(); // TODO: This should go where settings are copied.
  24  			form.SupportsDataInputs = component.SupportsDataInputs;

DynaMiX.Backend\API\DynaMiX.API\Carriers\Scheduler\Converter.cs:
  307  				entity.DisarmDriverId = carrier.ActionsDriverId.ToLong();
  308: 			if (carrier.ActionsOdometer != null && carrier.ActionsOdometer.Value.HasValue)
  309  			{
  310: 				UnitsConverter.ConvertDistanceToStandard(carrier.ActionsOdometer, t => t.Value, t => t.Unit);
  311: 				entity.SetOdoKmValue = Convert.ToInt32(Math.Round(carrier.ActionsOdometer.Value.Value));
  312  			}

  533  			carrier.DownloadTripsAndEventsType = schedule.TripsEventsDownload.GetDescription();
  534: 			carrier.DownloadTachoType = schedule.TachoDownloadType.GetDescription();
  535: 			if (schedule.TachoDownloadType == TachoDownloadType.Windowed && schedule.TachoStart != null && schedule.TachoEnd != null)
  536  			{

  666  			entity.TripsEventsDownload = carrier.DownloadTripsAndEventsType.ParseEnum<TripsEventsDownloadTypes>();
  667: 			entity.TachoDownloadType = carrier.DownloadTachoType.ParseEnum<TachoDownloadType>();
  668: 			if (entity.TachoDownloadType == TachoDownloadType.Windowed)
  669  			{

  879  					break;
  880: 				case MiX.DeviceIntegration.Common.Enums.CommandIdType.SetOdometerOffset:
  881: 					messageType = "Odometer command";
  882  					break;

  929  				case MiX.DeviceIntegration.Common.Enums.CommandIdType.SetEngineHoursOffset:
  930: 				case MiX.DeviceIntegration.Common.Enums.CommandIdType.SetOdometerOffset:
  931  					switch (l.MessageStatus)

DynaMiX.Backend\API\DynaMiX.API\Carriers\Scheduler\UploadSchedulerActionsTabCarrier.cs:
  15  		public List<DriverListItem> Drivers { get; set; }
  16: 		public Dictionary<string, string> CurrentOdomenterDisplay { get; set; }
  17  		public string CurrentEngineHoursDisplay { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\Scheduler\UploadSchedulerCarrier.cs:
  55  		[Range(1, Int32.MaxValue, ErrorMessage = ErrorMessages.GeneralValidation.RANGE_0TO2147483647)]
  56: 		public DistanceCarrier ActionsOdometer { get; set; }
  57  

DynaMiX.Backend\API\DynaMiX.API\Carriers\TimeLine\Entries\Events\DetailedEventEntryCarrier.cs:
  17  		public List<ClipChannelStatus> VideoChannelRequests { get; set; }
  18: 		public DistanceCarrier StartOdometer { get; set; }
  19: 		public DistanceCarrier EndOdometer { get; set; }
  20  		public int StartGpsId { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\TimeLine\Entries\Events\IEventEntry.cs:
  21  
  22: 		DistanceCarrier StartOdometer { get; set; }
  23: 		DistanceCarrier EndOdometer { get; set; }
  24  

DynaMiX.Backend\API\DynaMiX.API\Carriers\TimeLine\Entries\Events\NotificationEventTimelineEntryCarrier.cs:
  17  		public List<ClipChannelStatus> VideoChannelRequests { get; set; }
  18: 		public DistanceCarrier StartOdometer { get; set; }
  19: 		public DistanceCarrier EndOdometer { get; set; }
  20  		public int StartGpsId { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\TimeLine\Entries\Events\SummaryEventEntryCarrier.cs:
  17  		public List<ClipChannelStatus> VideoChannelRequests { get; set; }
  18: 		public DistanceCarrier StartOdometer { get; set; }
  19: 		public DistanceCarrier EndOdometer { get; set; }
  20  		public int StartGpsId { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\TimeLine\Entries\HOS\HosStatusDataCarrier.cs:
  16  		public double Duration { get; set; }
  17: 		public string StartOdo { get; set; }
  18  		public decimal? EngineHours { get; set; }

  63  		public decimal EngineHours { get; set; }
  64: 		public decimal StartOdo { get; set; }
  65  		public decimal Distance { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\TimeLine\Entries\HOS\HosStatusOdoRangeCarrier.cs:
   9  {
  10: 	public class HosStatusOdoRangeCarrier : CarrierBase
  11  	{

  16  
  17: 		public HosStatusOdoRangeCarrier()
  18  		{

DynaMiX.Backend\API\DynaMiX.API\Carriers\TimeLine\Entries\Trips\SubTripEntryCarrier.cs:
  11  
  12: 		public DistanceCarrier Odometer { get; set; }
  13  		

DynaMiX.Backend\API\DynaMiX.API\Carriers\Tracking\Converter.cs:
   263  				var key = DynaMiX.Common.Constants.OtherTypesPositionData.G52_SOLAR_BATTERY_VOLTAGE;
   264: 				double solarBatteryVoltage = Math.Round(Convert.ToDouble(otherData[key], CultureInfo.InvariantCulture) / 1000, 2);
   265  				otherData[key] = string.Concat(solarBatteryVoltage.ToString(), " V");

   272  		{
   273: 			double batteryVoltage = Convert.ToDouble(batteryLevel, CultureInfo.InvariantCulture) / 1000;
   274  			double batteryVoltageRounded = Math.Round(batteryVoltage, 2);
   275  
   276: 			if (batteryVoltageRounded >= Convert.ToDouble("3.85", CultureInfo.InvariantCulture))
   277  			{

   279  			}
   280: 			if (batteryVoltageRounded >= Convert.ToDouble("3.7", CultureInfo.InvariantCulture) && batteryVoltageRounded < Convert.ToDouble("3.85", CultureInfo.InvariantCulture))
   281  			{

   283  			}
   284: 			if (batteryVoltageRounded >= Convert.ToDouble("3.5", CultureInfo.InvariantCulture) && batteryVoltageRounded < Convert.ToDouble("3.7", CultureInfo.InvariantCulture))
   285  			{

   287  			}
   288: 			if (batteryVoltageRounded < Convert.ToDouble("3.5", CultureInfo.InvariantCulture))
   289  			{

   394  
   395: 				item.SpeedLimit = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(Convert.ToDouble(activeEvent.SpeedLimit ?? 0), userProfile);
   396  				list.Add(item);

   428  					{
   429: 						double speed = Convert.ToDouble(activeEvent.Speed);
   430  						item.Value = TimelineConverter.GetEventDisplay(authToken, userProfile, speed, libraryEvent, orgId, out unit, correlationId, getTrailerDescription, false);

   608  			{
   609: 				var dRadius = Convert.ToDouble(carrier.Radius);
   610  				var circle = new CircleShape(carrier.LatLngs.First().ToCoordinate(), Math.Round(dRadius));

   757  				item.AssetIconColour = asset.IconColour ?? AssetIcons.DefaultAssetIconColour;
   758: 				item.TotalDistance = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(Convert.ToDouble(asset.TotalDistance), userProfile);
   759  				item.HasTrips = asset.TripCount > 0;

   839  			carrier.EndTime = correctedEnd.ToCarrier();
   840: 			carrier.Distance = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(Convert.ToDouble(tripSummary.Distance), userProfile);
   841: 			carrier.MaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(Convert.ToDouble(tripSummary.MaxSpeed), userProfile);
   842  			carrier.FmDriverId = tripSummary.FmDriverId.ToString();

  1007  			carrier.EndTime = tripSummary.TripEnd.ToCarrier();
  1008: 			carrier.Distance = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(Convert.ToDouble(tripSummary.Distance), userProfile);
  1009: 			carrier.MaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(Convert.ToDouble(tripSummary.MaxSpeed), userProfile);
  1010  			carrier.Track = new AssetTrackCarrier();

  1013  
  1014: 			//carrier.Track.Events = events.Select(e => e.ToCarrier(authToken, orgId, userProfile)).ToList(); //TODO JM
  1015  

  1046  				EndTime = subTrip.End.ToCarrier(),
  1047: 				Distance = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(Convert.ToDouble(subTrip.Distance), userProfile),
  1048: 				MaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(Convert.ToDouble(subTrip.MaxSpeed), userProfile),
  1049  				Events = new List<EventListItemCarrier>()

  1119  			double distance = 0;
  1120: 			if (eventData.StartOdometer.HasValue && eventData.EndOdometer.HasValue)
  1121: 				distance = Convert.ToDouble(eventData.EndOdometer.Value - eventData.StartOdometer.Value);
  1122  			carrier.Distance = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(distance, userProfile);

  1226  			{
  1227: 				carrier.SpeedLimit = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(Convert.ToDouble(eventData.SpeedLimit), userProfile);
  1228  			}

  1315  			CultureInfo cultureInfo = CultureInfo.GetCultureInfo(selectedLocale.Id);
  1316: 			return (value % 1 == 0) ? Convert.ToDouble(value).ToString("N0", cultureInfo) : Convert.ToDouble(value).ToString("N2", cultureInfo);
  1317  		}

  1321  			CultureInfo cultureInfo = CultureInfo.GetCultureInfo(selectedLocale.Id);
  1322: 			return (value % 1 == 0) ? Convert.ToDouble(value).ToString("N0", cultureInfo) : Convert.ToDouble(value).ToString("N2", cultureInfo);
  1323  		}

  1327  			CultureInfo cultureInfo = CultureInfo.GetCultureInfo(selectedLocale.Id);
  1328: 			return (value % 1 == 0) ? Convert.ToDouble(value).ToString("N0", cultureInfo) : Convert.ToDouble(value).ToString("N2", cultureInfo);
  1329  		}

  1569  
  1570: 			// TODO: Not sure what you would want to do with polygon holes.
  1571  			//       I assume that the intention is not to support holes and

  1589  
  1590: 				// TODO: Not sure what you would want to do with polygon holes.
  1591  				//       I assume that the intention is not to support holes and

  1820  			{
  1821: 				var dRadius = Convert.ToDouble(carrier.PointRadius);
  1822  				var circle = new CircleShape(carrier.LatLngs.First().ToCoordinate(), Math.Round(dRadius));

DynaMiX.Backend\API\DynaMiX.API\Converters\DTCOConverter.cs:
    4  using DynaMiX.Api.Carriers.Common;
    5: using DynaMiX.Api.Carriers.DTCODownloadManagement;
    6  using DynaMiX.Core.Extensions.Enum;

    8  using DynaMiX.Core.TimeZones;
    9: using DynaMiX.Entities.DTCODownloadManagement;
   10  

   32  				{
   33: 					cfg.CreateMap<DTCODownloadData, DTCODownloadDataCarrier>();
   34: 					cfg.CreateMap<DTCODownloadDataCarrier, DTCODownloadData>();
   35  					cfg.CreateMap<AssetData, AssetDataCarrier>();

   63  				OrgId = entity.OrgId,
   64: 				DTCODownloadData = entity.DTCODownloadData.ToCarrier()
   65  			};

   73  				OrgId = carrier.OrgId,
   74: 				DTCODownloadData = carrier.DTCODownloadData.ToEntity()
   75  			};

  158  				DownloadType = entity.DownloadType,
  159: 				DownloadData = entity.DTCODownloadData.ToCarrier()
  160  			};

  181  				DownloadType = carrier.DownloadType,
  182: 				DTCODownloadData = carrier.DownloadData.ToEntity()
  183  			};

  196  
  197: 		public static DTCODownloadDataCarrier ToCarrier(this DTCODownloadData entity)
  198  		{
  199: 			return _mapper.Map<DTCODownloadDataCarrier>(entity);
  200  		}
  201  
  202: 		public static DTCODownloadData ToEntity(this DTCODownloadDataCarrier carrier)
  203  		{
  204: 			return _mapper.Map<DTCODownloadData>(carrier);
  205  		}

DynaMiX.Backend\API\DynaMiX.API\Converters\FleetAdminConverter.cs:
  28  				LastTrip = entity.LastTrip.ToCarrier(),
  29: 				Odometer = !entity.Odometer.HasValue ? "" : entity.Odometer.Value.ToString(),
  30  				CurrentState = entity.Status,

DynaMiX.Backend\API\DynaMiX.API\Converters\TimelineConverter.cs:
   189  				TripDistanceUnits = subTrip.TripDistanceUnits,
   190: 				Odometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(decimal.ToDouble(subTrip.Odometer), userProfile)
   191  			};

   193  			// Over speeding.
   194: 			subTripEntry.MaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(decimal.ToDouble(subTrip.MaxSpeed), userProfile);
   195  			subTripEntry.SpeedTime = (subTripEntry.MaxSpeed != null) ? subTrip.SpeedTime : 0;

   198  			// Acceleration
   199: 			subTripEntry.MaxAccel = subTrip.MaxAccel != null ? UnitsOfMeasureCarrierConverter.GetAccelerationCarrier(decimal.ToDouble(subTrip.MaxAccel.GetValueOrDefault()), userProfile) : null;
   200  			subTripEntry.AccelTime = (subTrip.MaxAccel != null) ? subTrip.AccelTime.GetValueOrDefault() : 0;

   203  			// Braking (Deceleration)
   204: 			subTripEntry.MaxBrake = subTrip.MaxBrake != null ? UnitsOfMeasureCarrierConverter.GetAccelerationCarrier(decimal.ToDouble(subTrip.MaxBrake.GetValueOrDefault()), userProfile) : null;
   205  			subTripEntry.BrakeTime = (subTrip.MaxBrake != null) ? subTrip.BrakeTime : 0;

   217  			//Fuel 
   218: 			subTripEntry.FuelConsumption = subTrip.FuelConsumption != null ? UnitsOfMeasureCarrierConverter.GetConsumptionCarrier(decimal.ToDouble(subTrip.FuelConsumption.GetValueOrDefault()), userProfile) : null;
   219  			if (subTripEntry.FuelConsumption != null)
   220  				subTripEntry.FuelConsumption.Unit = UnitsConverter.SetFuelConsumptionUnit(userProfile, (subTrip.FuelConsumption.GetValueOrDefault()));
   221: 			subTripEntry.FuelUsage = subTrip.Litres != null ? UnitsOfMeasureCarrierConverter.GetVolumeCarrier(decimal.ToDouble(subTrip.Litres.GetValueOrDefault()), userProfile) : null;
   222  

  1245  						LocationName = @event.LocationName,
  1246: 						SpeedLimit = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(Convert.ToDouble(@event.SpeedLimit), userProfile)
  1247  					};

  1260  						LocationName = (@event.LocationName != null) ? @event.LocationName : null,
  1261: 						SpeedLimit = (@event.SpeedLimit != null && @event.SpeedLimit > 0) ? UnitsOfMeasureCarrierConverter.GetSpeedCarrier(Convert.ToDouble(@event.SpeedLimit), userProfile) : null
  1262  					};

  1285  
  1286: 			eventEntry.StartOdometer = @event.StartOdometer.HasValue && (int)@event.StartOdometer.Value != 0 ? UnitsOfMeasureCarrierConverter.GetDistanceCarrier(@event.StartOdometer.GetValueOrDefault(), userProfile) : null;
  1287: 			eventEntry.EndOdometer = @event.EndOdometer.HasValue && (int)@event.EndOdometer.Value != 0 ? UnitsOfMeasureCarrierConverter.GetDistanceCarrier(@event.EndOdometer.GetValueOrDefault(), userProfile) : null;
  1288  			eventEntry.TotalOccurs = @event.TotalOccurs;

  1524  				WorkState = (byte)hosWorkStateData.WorkState,
  1525: 				StartOdo = hosWorkStateData.StartOdometer.ToString(CultureInfo.InvariantCulture),
  1526  				IsAssumed = hosWorkStateData.IsAssumed,

  1633  
  1634: 			if (carrier.StartOdo.IsNotNullOrEmpty())
  1635  			{
  1636: 				workStateEntry.StartOdometer = Convert.ToDecimal(carrier.StartOdo);
  1637: 				workStateEntry.StartOdometerUnits = carrier.DistanceUnits;
  1638: 				UnitsConverter.ConvertDistanceToStandard(workStateEntry, w => w.StartOdometer, w => w.StartOdometerUnits);
  1639: 				workStateEntry.StartOdometer = Decimal.Round(workStateEntry.StartOdometer, 1);
  1640  			}

DynaMiX.Backend\API\DynaMiX.API\Converters\TimelineTextSummary.cs:
   401  							{"distance", trip.TripDistance.ToString("N2", CultureInfo.GetCultureInfo(selectedLocale.Id))},
   402: 							{"odo", trip.Odometer.ToString("N2", CultureInfo.GetCultureInfo(selectedLocale.Id))},
   403  							{"unit",LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, _userProfile.LanguageCode,trip.TripDistanceUnits).Value},

   843  								{"tripDistance", subTrip.TripDistance.ToString("N2", CultureInfo.GetCultureInfo(selectedLocale.Id))},
   844: 								{"odo", subTrip.Odometer.ToString("N2", CultureInfo.GetCultureInfo(selectedLocale.Id))},
   845  								{"tripDistanceUnits",LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, _userProfile.LanguageCode, subTrip.TripDistanceUnits).Value},

  1161  
  1162: 			if (eventData.StartOdometer.HasValue && (int)eventData.StartOdometer.Value != 0)
  1163  			{

  1166  					Translate(
  1167: 						InformationMessages.Timeline.RES_TIMELINE_EVENT_ODO,
  1168  						new Dictionary<string, string>
  1169  						{
  1170: 							{ "odoValue", eventData.StartOdometer.Value.ToString("N2", CultureInfo.GetCultureInfo(selectedLocale.Id)) },
  1171: 							{ "odoUnit",LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, _userProfile.LanguageCode, eventData.OdometerUnits ).Value}
  1172  						}

  1189  			// Fuel consumption has to be calculated before we convert units the the userprofile configured
  1190: 			var eventDistance = eventData.EndOdometer.GetValueOrDefault(0) - eventData.StartOdometer.GetValueOrDefault(0);
  1191  			var eventFuelConsumed = eventData.Litres.GetValueOrDefault(0);

  1252  
  1253: 						if (eventData.StartOdometer.HasValue && eventData.EndOdometer.HasValue)
  1254  						{

  1353  
  1354: 			if (eventData.EndOdometer.HasValue && (int)eventData.EndOdometer.Value != 0)
  1355  			{

  1358  					Translate(
  1359: 						InformationMessages.Timeline.RES_TIMELINE_EVENT_ODO,
  1360  						new Dictionary<string, string>
  1361  						{
  1362: 							{ "odoValue", eventData.EndOdometer.Value.ToString("N2", CultureInfo.GetCultureInfo(selectedLocale.Id)) },
  1363: 							{ "odoUnit",LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, _userProfile.LanguageCode, eventData.OdometerUnits).Value }
  1364  						}

  1624  		{
  1625: 			UnitsConverter.ConvertProperties(tds, userProfile, t => t.Odometer, t => t.OdometerUnits);
  1626  			UnitsConverter.ConvertProperties(tds, userProfile, t => t.TripDistance, t => t.TripDistanceUnits);

  1640  		{
  1641: 			string originalUnits = eventData.OdometerUnits;
  1642: 			UnitsConverter.ConvertProperties(eventData, userProfile, e => e.StartOdometer, e => e.OdometerUnits);
  1643  
  1644: 			if (eventData.EndOdometer > 0)
  1645  			{
  1646: 				eventData.OdometerUnits = originalUnits;
  1647: 				UnitsConverter.ConvertProperties(eventData, userProfile, e => e.EndOdometer, e => e.OdometerUnits);
  1648  			}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\AssetMaintenance\AssetMaintenanceModule.cs:
  149  
  150: 				if (assetId == 0L) //TODO: MR: double check this gets returned for incorrect regNo
  151  					return new GatewayResult<AssetMaintenanceAssetCrudCarrier>(GatewayResultStatus.NoData, carrier);

  188  				carrier.UploadAllForm = CreateUploadSchedulerForm(selectedId, assetId, asset);
  189: 				carrier.UploadAllForm.ActionsOdometer = new DistanceCarrier
  190  				{

  193  				};
  194: 				if (asset.Odometer.HasValue)
  195  				{
  196: 					carrier.CurrentOdomenterDisplay = new Dictionary<string, string>();
  197: 					foreach (UnitCarrier unit in carrier.UploadAllForm.ActionsOdometer.AvailableUnits)
  198  					{
  199: 						carrier.CurrentOdomenterDisplay.Add(unit.Value, Math.Round(MiX.Core.Conversion.Converter.ConvertValue(asset.Odometer.Value, Unit.Kilometres, unit.Value), 2).ToString());
  200  					}

  345  
  346: 			AssetMaintenanceOdometerFormCarrier setOdoTemplate = new AssetMaintenanceOdometerFormCarrier();
  347  			IEffectiveConfig config = new ObjEffectiveConfig();

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\CommsLog\CommsLogModule.cs:
   35  			public static readonly RouteDefinition GetCommsLogEH = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/assets/{assetId}/organisations/{orgId}/commslog/enginehours", Constants.HTTPVerbs.GET);
   36: 			public static readonly RouteDefinition GetCommsLogOdometer = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/assets/{assetId}/organisations/{orgId}/commslog/odometer", Constants.HTTPVerbs.GET);
   37  

   46  			RegisterRoute(ModuleRoutes.GetCommsLogEH, args => GetCommsLogEH(AuthToken, (long)args["orgId"], (long)args["assetId"], (string)args["device"]));
   47: 			RegisterRoute(ModuleRoutes.GetCommsLogOdometer, args => GetCommsLogOdometer(AuthToken, (long)args["orgId"], (long)args["assetId"], (string)args["device"]));
   48  

  166  
  167: 		private GatewayResult<ScheduleLogResultCarrier> GetCommsLogOdometer(string authToken, long orgId, long assetId, string device)
  168  		{

  172  
  173: 			List<long> typeIds = new List<long> { (long)CommandIdType.SetOdometerOffset };
  174  			var statuses = DeviceConfigClient.MobileUnits.GetLastMessageStatusesForTypes(authToken, orgId, assetId, typeIds).ConfigureAwait(false).GetAwaiter().GetResult();

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibrariesModule.cs:
  59  		{
  60: 			//TODO JM: Fix this edge case
  61  			RegisterRoute(ModuleRoutes.GET_LIBRARIES_PAGE, args => GroupTrees.GetGroupTreeGatewayResult(AuthToken, GetTabsGroupTreeSelector(), CorrelationId));

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\MobileUnitLevel\MobileUnitMobileDeviceModule.cs:
  392  					DeviceConfigClient.MobileUnits.DecommissionMiXTalk(authToken, assetId).ConfigureAwait(false).GetAwaiter().GetResult();
  393: 					//TODO: MR: Send SMS here to also remove numbers and auto-answer
  394  				}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\PlugManagement\PlugManagementModule.cs:
   350  
   351: 			//TODO: MR: Use enums for these statusses in BE & in PMU system
   352  			carrier.ConfigurationStatus = mobileUnit.ConfigurationStatus.GetEnumEntryForValue().Description;
   353: 			//TODO: MR: Get the version from both overwritten and template...
   354  			var allFirmwareVersions = LibraryFirmwareManager.GetLibraryFirmwareVersions(authToken, organisationId);

   472  			{
   473: 				//TODO RDT: return 200 Success, with empty carrier if asset exists but has not config
   474  				return new GatewayResult<AssetDeviceDriversCarrier>(GatewayResultStatus.Success, carrier);

   494  			tachoArray[4] = (num & 0x0080) == 0x0080 ? "1" : "0"; // F3
   495: 			tachoArray[5] = "1";                                  // Odo
   496  			tachoArray[6] = (num & 0x0020) == 0x0020 ? "1" : "0"; // I1

   541  
   542: 		//TODO: MR: IS this still needed - it is currently accessible in MiXFleet from plugController.ts (if not remove this)
   543  		public GatewayResult<DriverAssetsCarrier> GetAssetBlackListByDriverId(string authToken, long organisationId, short fmLegacyDriverId)

   727  
   728: 				UnitsConverter.ConvertDistanceStandardToProfile(newAssetList[i], CurrentUser.Profile, a => a.Odometer, a => a.OdometerUnits);
   729: 				if (newAssetList[i].Odometer.HasValue)
   730: 					assetCarrier.Odometer = newAssetList[i].Odometer;
   731: 				assetCarrier.OdometerUnit = newAssetList[i].OdometerUnits;
   732  

   792  			OrganisationDetail organisationDetail = OrganisationManager.GetOrganisationDetailByLegacyCompanyId(authToken, signedCompanyId);
   793: 			//TODO RDT: RETURN 404
   794  			if (organisationDetail == null)

   842  			var org = OrganisationGroupManager.GetOrganisationGroupForEntity(orgId, EntityTypes.GROUP);
   843: 			//TODO RDT: RETURN 404
   844  			if (assetList.Count == 0)

   877  			}
   878: 			//TODO RDT: RETURN 404
   879  			if (driverList.Count == 0)

   942  			driverList = LegacyIdConverter.ConvertDriverIdsLegacyToFleet(legacyDriverList, org.GroupId);
   943: 			//TODO RDT: RETURN 404
   944  			if (driverList.Count == 0)

   974  			carrier.FmPassengerId = passengerId;
   975: 			//TODO RDT: RETURN 404
   976  			if (passengerList.Count == 0)

  1059  			carrier.HyperMedia.Links.Add(ModuleRoutes.GET_HOS_DRIVERS.ToLinkCarrier("getHosDrivers"));
  1060: 			carrier.HyperMedia.Links.Add(ModuleRoutes.GET_DRIVER_ASSET_BLACKLIST.ToLinkCarrier("getIllegalAssetsForDriver")); //TODO: MR: If not needed remove!
  1061  			carrier.HyperMedia.Links.Add(ModuleRoutes.GET_PASSENGERS.ToLinkCarrier("getPassengers"));

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:
  1039  						Video						= e.Video ? "x" : "",
  1040: 						StartOdometer		= e.StartOdometer ? "x" : "",
  1041: 						EndOdometer			= e.EndOdometer ? "x" : "",
  1042  						StartPosition		= e.StartPosition ? "x" : "",

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ImportExport\AssetConfigFileXlsxEventClassMap.cs:
  15  		public string Video { get; set; }
  16: 		[XLColumn(Header = "Start Odometer", Order = 6, Ignore = false)]
  17: 		public string StartOdometer { get; set; }
  18: 		[XLColumn(Header = "End Odometer", Order = 7, Ignore = false)]
  19: 		public string EndOdometer { get; set; }
  20  		[XLColumn(Header = "Start Position", Order = 8, Ignore = false)]

DynaMiX.Backend\API\DynaMiX.API\NancyModules\DTCODownloadManagement\DTCOArchiveSettingsModule.cs:
    1: using DynaMiX.Api.Carriers.DTCODownloadManagement;
    2  using DynaMiX.Api.Converters;

   10  using DynaMiX.Core.Runtime;
   11: using DynaMiX.Logic.DTCODownloadManagement;
   12  using System.Collections.Generic;
   13: using Permissions = DynaMiX.Common.DTCODownloadManagement.Permissions;
   14  using DynaMiX.Api.Carriers.Common.Tree;

   17  
   18: namespace DynaMiX.Api.NancyModules.DTCODownloadManagement
   19  {

   22  
   23: 		private IDTCODownloadManagementManager _dtcoDownloadManagementManager;
   24  
   25: 		public IDTCODownloadManagementManager DTCODownloadManagementManager
   26  		{
   27: 			get { return _dtcoDownloadManagementManager ?? (_dtcoDownloadManagementManager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>()); }
   28: 			set { _dtcoDownloadManagementManager = value; }
   29  		}
   30: 		private IDTCODownloadManagementManager _dddManager;
   31  
   32: 		public IDTCODownloadManagementManager DddManager
   33  		{
   34: 			get { return _dddManager ?? (_dddManager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>()); }
   35  			set { _dddManager = value; }

   37  
   38: 		public static readonly string BasePath = APISettings.Current.DTCODownloadManagerBaseUrl;
   39  		public static readonly string ApiBaseUrl = APISettings.Current.ApiBaseUrl;

   87  		{
   88: 			var archiveSettings = DTCODownloadManagementManager.GetDtcoArchiveSettings(authToken, orgId);
   89  

  101  			var entity = carrier.ToEntity();
  102: 			var result = DTCODownloadManagementManager.UpdateDtcoArchiveSettings(authToken, entity);
  103  			carrier = result.ToCarrier();

DynaMiX.Backend\API\DynaMiX.API\NancyModules\DTCODownloadManagement\DTCOCompanyCardListFilters.cs:
  2  
  3: namespace DynaMiX.Api.NancyModules.DTCODownloadManagement
  4  {

DynaMiX.Backend\API\DynaMiX.API\NancyModules\DTCODownloadManagement\DTCODownloadManagementModule.cs:
    6  using DynaMiX.Api.Carriers.Common.Tree;
    7: using DynaMiX.Api.Carriers.DTCODownloadManagement;
    8  using DynaMiX.Api.Converters;
    9: using DynaMiX.Api.NancyModules.DTCODownloadManagement.CompanyCards;
   10  using DynaMiX.Api.Utilities;

   20  using DynaMiX.Core.Runtime.Resolver;
   21: using DynaMiX.Logic.DTCODownloadManagement;
   22  using Nancy;

   24  using ServiceStack.Text;
   25: using Permissions = DynaMiX.Common.DTCODownloadManagement.Permissions;
   26  using DynaMiX.Entities.Groups;
   27  
   28: namespace DynaMiX.Api.NancyModules.DTCODownloadManagement
   29  {
   30: 	public class DTCODownloadManagementModule : MiXFleetModuleBase
   31  	{
   32: 		protected static readonly string BasePath = APISettings.Current.DTCODownloadManagerBaseUrl;
   33  		protected static readonly string ApiBaseUrl = APISettings.Current.ApiBaseUrl;
   34  
   35: 		private IDTCODownloadManagementManager _dddManager;
   36  
   37: 		public IDTCODownloadManagementManager DddManager
   38  		{
   39: 			get { return _dddManager ?? (_dddManager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>()); }
   40  			set { _dddManager = value; }

   64  
   65: 		public DTCODownloadManagementModule()
   66  			: base(BasePath)

  106  			SimpleMessage carrier = new SimpleMessage();
  107: 			carrier.Message = OrganisationManager.IsFeatureEnabled(orgId, Entities.Operations.OrgFeature.DtcoDownloadManagement).ToString();
  108  

  223  
  224: 			//if (canCreate) carrier.HyperMedia.Links.Add(DTCODownloadTaskDetailsModule.ModuleRoutes.GET_DOWNLOAD_TASK_DETAILS_TEMPLATE.ToLinkCarrier("getDownloadTaskDetailsTemplate"));
  225  			//if (canUpdate) carrier.HyperMedia.Links.Add(ModuleRoutes.PUT_REMOTE_TASK_MANAGEMENT.ToLinkCarrier("updateRemoteTaskManagement"));

  313  				var response = new TextResponse();
  314: 				IDTCODownloadManagementManager manager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>(context);
  315  

  329  				var response = new TextResponse();
  330: 				IDTCODownloadManagementManager manager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>(context);
  331  

DynaMiX.Backend\API\DynaMiX.API\NancyModules\DTCODownloadManagement\DTCODownloadTaskDetailsModule.cs:
    4  using DynaMiX.Api.Carriers.Common;
    5: using DynaMiX.Api.Carriers.DTCODownloadManagement;
    6  using DynaMiX.Api.Carriers.JobsAndMessaging.MessageBox;

    8  using DynaMiX.Api.NancyModules.FleetAdmin;
    9: using DynaMiX.Common.DTCODownloadManagement;
   10  using DynaMiX.Core.Extensions.String;

   15  using DynaMiX.Core.TimeZones;
   16: using DynaMiX.Entities.DTCODownloadManagement;
   17  using DynaMiX.Entities.FleetAdmin.Assets;
   18: using DynaMiX.Logic.DTCODownloadManagement;
   19  using DynaMiX.Logic.FleetAdmin;

   21  
   22: namespace DynaMiX.Api.NancyModules.DTCODownloadManagement
   23  {
   24: 	public class DTCODownloadTaskDetailsModule : MiXFleetModuleBase
   25  	{
   26: 		internal IDTCODownloadManagementManager _dtcoDownloadManagementManager;
   27  		internal IAssetManager _assetManager;

   29  		[ExcludeFromCodeCoverage]
   30: 		public IDTCODownloadManagementManager DTCODownloadManagementManager
   31  		{
   32: 			get { return _dtcoDownloadManagementManager ?? (_dtcoDownloadManagementManager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>()); }
   33: 			set { _dtcoDownloadManagementManager = value; }
   34  		}
   35: 		protected static readonly string BasePath = APISettings.Current.DTCODownloadManagerBaseUrl;
   36  		protected static readonly string ApiBaseUrl = APISettings.Current.ApiBaseUrl;

   45  
   46: 		public DTCODownloadTaskDetailsModule()
   47  			: base(BasePath)
   48  		{
   49: 			RegisterRoute(DTCODownloadTaskDetailsModule.ModuleRoutes.GET_DOWNLOAD_TASK_DETAILS_TEMPLATE, args => GetDownloadTaskDetailsTemplate(AuthToken, (long) args["orgId"]));
   50: 			RegisterRoute(DTCODownloadTaskDetailsModule.ModuleRoutes.GET_DOWNLOAD_TASK_DETAILS, args => GetDownloadTaskDetails(AuthToken, (long)args["orgId"], (long)args["downloadTaskId"]));
   51: 			RegisterRoute(DTCODownloadTaskDetailsModule.ModuleRoutes.POST_DOWNLOAD_TASK_DETAILS, args => PostDownloadTaskDetails(AuthToken, (long)args["orgId"], Model<DTCORemoteTaskCarrier>()));
   52: 			RegisterRoute(DTCODownloadTaskDetailsModule.ModuleRoutes.PUT_DOWNLOAD_TASK_DETAILS, args => PutDownloadTaskDetails(AuthToken, (long)args["orgId"], (long)args["downloadTaskId"], Model<DTCORemoteTaskCarrier>()));
   53  		}

   71  			var carrier = new DownloadTaskCrudCarrier();
   72: 			var downloadTask = DTCODownloadManagementManager.GetDownloadTask(authToken, orgId, downloadTaskId);
   73  			var canEdit = AuthorisationManager.Authorise(authToken, Permissions.CAN_UPDATE_REMOTE_TASK_MANAGEMENT);

  106  						
  107: 			var result = DTCODownloadManagementManager.AddDownloadTask(authToken, entity);
  108  			var canEdit = AuthorisationManager.Authorise(authToken, Permissions.CAN_UPDATE_REMOTE_TASK_MANAGEMENT);

  119  
  120: 			var result = DTCODownloadManagementManager.UpdateDownloadTask(authToken, orgId, entity);
  121  			var canEdit = AuthorisationManager.Authorise(authToken, Permissions.CAN_UPDATE_REMOTE_TASK_MANAGEMENT);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\DTCODownloadManagement\DTCORemoteTaskListFilters.cs:
  2  
  3: namespace DynaMiX.Api.NancyModules.DTCODownloadManagement
  4  {

DynaMiX.Backend\API\DynaMiX.API\NancyModules\DTCODownloadManagement\DTCOCompanyCards\DTCOCompanyCardDetailsModule.cs:
    5  using DynaMiX.Api.Carriers.Common;
    6: using DynaMiX.Api.Carriers.DTCODownloadManagement;
    7  using DynaMiX.Api.NancyModules.FleetAdmin;

   13  using DynaMiX.Core.Http.Shared;
   14: using DynaMiX.Api.Carriers.DTCODownloadManagement.CompanyCardCrud;
   15  using DynaMiX.Core.Http;

   17  using DynaMiX.Core.TimeZones;
   18: using DynaMiX.Entities.DTCODownloadManagement;
   19: using DynaMiX.Logic.DTCODownloadManagement;
   20  using DynaMiX.Api.Utilities.SelectionCriteria;
   21: using Permissions = DynaMiX.Common.DTCODownloadManagement.Permissions;
   22: using DynaMiX.Common.DTCODownloadManagement;
   23  using DynaMiX.Common.Groups.Constants;

   25  
   26: namespace DynaMiX.Api.NancyModules.DTCODownloadManagement.CompanyCards
   27  {

   29  	{
   30: 		internal IDTCODownloadManagementManager _dtcoDownloadManagementManager;
   31  
   32  		[ExcludeFromCodeCoverage]
   33: 		public IDTCODownloadManagementManager DTCODownloadManagementManager
   34  		{
   35: 			get { return _dtcoDownloadManagementManager ?? (_dtcoDownloadManagementManager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>()); }
   36: 			set { _dtcoDownloadManagementManager = value; }
   37  		}
   38  
   39: 		protected static readonly string BasePath = APISettings.Current.DTCODownloadManagerBaseUrl;
   40  		protected static readonly string ApiBaseUrl = APISettings.Current.ApiBaseUrl;

   64  		{
   65: 			RequiredPermissionId = Common.DTCODownloadManagement.Permissions.CAN_UPDATE_COMPANY_CARDS,
   66  			VisibleGroupTypes = GroupTypes.GROUP_TYPES_IN_ORGANISATION_GROUP_TREE,

  109  		{
  110: 			var companyCards = DTCODownloadManagementManager.GetCompanyCards(authToken, new long[] { groupId }, base.CurrentUserProfile);
  111  			bool cardExists = companyCards.Any(c => 

  119  		{
  120: 			var card = DTCODownloadManagementManager.GetCompanyCards(authToken, new long[] { groupId }, base.CurrentUserProfile).FirstOrDefault();
  121  			var prefix = card == null ? "" : card.CardNumber.Substring(0, 13);

  144  			{
  145: 				if (DTCODownloadManagementManager.AddCompanyCard(authToken, companyCard))
  146  				{

  174  		{
  175: 			var companyCard = DTCODownloadManagementManager.GetCompanyCard(cardSerial);
  176  			bool deletedCompanyCard = false;

  179  			{
  180: 				deletedCompanyCard = DTCODownloadManagementManager.DeleteCompanyCard(authToken, companyCard);
  181  				return new GatewayResult<DTCOCompanyCardCarrier>(deletedCompanyCard ? GatewayResultStatus.Success : GatewayResultStatus.GeneralFailure, new DTCOCompanyCardCarrier());

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\DiagnosticsModule.cs:
     2  using DynaMiX.Api.Carriers.ConfigAdmin.AllLevels;
     3: using DynaMiX.Api.Carriers.DTCODownloadManagement;
     4  using DynaMiX.Api.Carriers.FleetAdmin.Assets.Diagnostics;

    28  using DynaMiX.Logic.DataWarehouse;
    29: using DynaMiX.Logic.DTCODownloadManagement;
    30  using DynaMiX.Logic.FleetAdmin;

    64  
    65: 		private IDTCODownloadManagementManager _dddManager;
    66: 		public IDTCODownloadManagementManager DddManager
    67  		{
    68: 			get { return _dddManager ?? (_dddManager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>()); }
    69  			set { _dddManager = value; }

   269  				}
   270: 				//TODO: MR: Nicole will let us know what data to use here.
   271  				//carrier.LastAccepted = GetConfigSnapshot(configDetails.LastConfigAccepted);

   456  			var peripheralDetails = DeviceConfigClient.MobileUnits.GetDiagnosticsPeripheralDetails(authToken, assetId).ConfigureAwait(false).GetAwaiter().GetResult();
   457: 			//TODO: MR: When I compare this with eg. the template the "I4/F8" type lines do not display the same way
   458  			foreach (var line in peripheralDetails?.LineDetails?.OrderBy(x => x.SortOrder))

   516  
   517: 				// Get the ODO reading from the entity
   518: 				status.Odometer = (entity.AssetStatus.VehicleLastOdo * 1000) ?? 0;
   519  			}

   522  				status.Speed = tripInfo.Speed.HasValue ? Convert.ToInt16(Math.Ceiling(tripInfo.Speed.Value)) : (int?)null;
   523: 				status.Odometer = tripInfo.Odometer.HasValue ? (float)tripInfo.Odometer : (float?)null;
   524  			}

   526  			status.SpeedUnits = "km/h";
   527: 			status.OdometerUnits = "m";
   528  			status.SubTripDistance = 0;

   531  			UnitsConverter.ConvertSpeedStandardToProfile(status, CurrentUserProfile, s => s.Speed, s => s.SpeedUnits);
   532: 			UnitsConverter.ConvertDistanceStandardToProfile(status, CurrentUserProfile, s => s.Odometer, s => s.OdometerUnits);
   533  			UnitsConverter.ConvertDistanceStandardToProfile(status, CurrentUserProfile, s => s.SubTripDistance, s => s.SubTripDistanceUnits);

   537  
   538: 			//Odometer
   539: 			if (status.Odometer.HasValue) // rather using AssetStatusDetails.AssetStatus.VehicleLastOdo fetched by AssetsManager (rather than GetStatatus Odo)
   540  			{
   541: 				carrier.Odometer = new DistanceCarrier()
   542  				{
   543  					Unit = distanceUnit,
   544: 					Value = Math.Round(status.Odometer.Value, 2)
   545  				};

   592  				carrier.NoOfSatellites = gpsStatus.NoOfSatellites.HasValue ? gpsStatus.NoOfSatellites.Value.ToString() : notavailable;
   593: 				carrier.AgeOfData = gpsStatus.AgeOfData.HasValue ? gpsStatus.AgeOfData.ToString() : notavailable; //TODO: MR: Once we get this from deviceconfig it should be timespan before converting to string
   594  				if (gpsStatus.VelocityUnits == null)

   602  
   603: 			//TODO: MR: Maybe remove all the below refresh hmedia for diagnostics calls
   604  			//carrier.HyperMedia.Links.Add(ModuleRoutes.GetDiagnosticsGPS.ToLinkCarrier("refresh", new { orgId, assetId, device, statusPendingRequestId }));

   662  
   663: 			//TODO (Config dependent): Determine if an asset supports schedules [JB] 
   664: 			//todo jm
   665  

   822  				var internalBatteryTemperatureValue = MiX.Core.Conversion.Converter.ConvertValue(diagnosticInfo.InternalBatteryMilliCelsius / 1000.0, MiX.Core.Conversion.Unit.DegreesCelcius, internalBatteryTemperatureUnit);
   823: 				var odometerUnit = UnitsConverter.GetDistanceUnit(CurrentUserProfile); // UAT-341
   824: 																																							 //var odometerValue = MiX.Core.Conversion.Converter.ConvertValue(diagnosticInfo.Odometer / 1000.0, MiX.Core.Conversion.Unit.Kilometres, odometerUnit);
   825  

   844  
   845: 				if (tripInfo != null && tripInfo.Odometer.HasValue)
   846  				{
   847: 					carrier.Mix2310iDiagnosticInfo.Odometer = new DistanceCarrier() // UAT-341
   848  					{
   849: 						Unit = String.IsNullOrEmpty(odometerUnit) ? "km" : odometerUnit,
   850: 						Value = (double)tripInfo.Odometer.Value / 1000.0
   851  					};

   887  
   888: 			//TODO: MR: Get the info from some command manager
   889  			var mix4kDetails = new AssetMix4kDetails();
   890  			mix4kDetails.vehicleMode = DeviceConfigClient.DeviceState.GetMobileUnitVehicleMode(mobileUnitId).ConfigureAwait(false).GetAwaiter().GetResult();
   891: 			//mix4kDetails.odometer = deviceStateProxy.GetMobileUnitOdometer(mobileUnitId); rather using AssetStatusDetails..AssetStatus.Odometer fetched by AssetsManager above
   892  			mix4kDetails.imsi = DeviceConfigClient.DeviceState.GetMobileUnitImsi(mobileUnitId).ConfigureAwait(false).GetAwaiter().GetResult();

  1168  				sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.RPM, lang) + ": " + Translate(carrier.GeneralStatusInfo.Rpm, lang));
  1169: 				sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.ODOMETER, lang) + ": " + Translate(carrier.GeneralStatusInfo.Odometer, lang));
  1170  				sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.GSM_QUALITY_STATUS, lang) + ": " + Translate(carrier.GeneralStatusInfo.GsmQualityStatus, lang));

  1223  					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.SPEED, lang) + ": " + Translate(generalStatusInfoRemora.Speed, lang));
  1224: 					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.ODOMETER, lang) + ": " + Translate(generalStatusInfoRemora.Odometer, lang));
  1225  					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.IMEI, lang) + ": " + Translate(generalStatusInfoRemora.Imei, lang));

  1256  					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.SPEED, lang) + ": " + Translate(generalStatusInfoOyster.Speed, lang));
  1257: 					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.ODOMETER, lang) + ": " + Translate(generalStatusInfoOyster.Odometer, lang));
  1258  					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.IMEI, lang) + ": " + Translate(generalStatusInfoOyster.Imei, lang));

  1287  					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.SPEED, lang) + ": " + Translate(generalStatusInfoYabby.Speed, lang));
  1288: 					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.ODOMETER, lang) + ": " + Translate(generalStatusInfoYabby.Odometer, lang));
  1289  					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.IMEI, lang) + ": " + Translate(generalStatusInfoYabby.Imei, lang));

  1318  					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.SPEED, lang) + ": " + Translate(generalStatusInfoDigitalMatterGeneral.Speed, lang));
  1319: 					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.ODOMETER, lang) + ": " + Translate(generalStatusInfoDigitalMatterGeneral.Odometer, lang));
  1320  					sb.AppendLine(Translate(Common.Constants.DiagnosticInfo.IMEI, lang) + ": " + Translate(generalStatusInfoDigitalMatterGeneral.Imei, lang));

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\HyperMediaAppender.cs:
    1  using DynaMiX.Api.Carriers.Common.ImportExport;
    2: using DynaMiX.Api.Carriers.DTCODownloadManagement;
    3  using DynaMiX.Api.Carriers.FleetAdmin.Assets.FuelUsage;

    8  using DynaMiX.Api.Carriers.FleetAdmin.Drivers.ExtendedId;
    9: using DynaMiX.Api.NancyModules.DTCODownloadManagement;
   10: using DynaMiX.Api.NancyModules.DTCODownloadManagement.CompanyCards;
   11  using DynaMiX.Api.NancyModules.FleetAdmin.Assets;

  145  			{
  146: 				carrier.HyperMedia.Links.Add(DTCODownloadTaskDetailsModule.ModuleRoutes.POST_DOWNLOAD_TASK_DETAILS.ToLinkCarrier("save", new { orgId }));
  147  			}

  149  			{
  150: 				carrier.HyperMedia.Links.Add(DTCODownloadTaskDetailsModule.ModuleRoutes.PUT_DOWNLOAD_TASK_DETAILS.ToLinkCarrier("save", new { downloadTaskId, orgId }));
  151  			}

  153  			carrier.HyperMedia.Validations = Validator.GetValidationRuleCarriers<DTCORemoteTaskCarrier>();
  154: 			carrier.HyperMedia.Validations.FormName = "dtcoDownloadTaskDetailsForm";
  155  		}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:
   120  			public static readonly RouteDefinition REMOVE_MOBILE_DEVICE = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/assets/commissioning/{orgId}/{assetId}/remove-mobile-device", Constants.HTTPVerbs.PUT);
   121: 			public static readonly RouteDefinition SET_ODOMETER = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/assets/commissioning/{orgId}/{assetId}/odometer", Constants.HTTPVerbs.PUT);
   122  			public static readonly RouteDefinition SET_ENGINEHOURS = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/assets/commissioning/{orgId}/{assetId}/enginehours", Constants.HTTPVerbs.PUT);

   148  			RegisterRoute(ModuleRoutes.REMOVE_MOBILE_DEVICE, args => RemoveMobileDevice(AuthToken, (long)args["orgId"], (long)args["assetId"], Model<AssetRemoveMobileDeviceFormCarrier>()));
   149: 			RegisterRoute(ModuleRoutes.SET_ODOMETER, args => SetOdometer(AuthToken, (long)args["orgId"], (long)args["assetId"], Model<AssetOdometerFormCarrier>()));
   150  			RegisterRoute(ModuleRoutes.SET_ENGINEHOURS, args => SetEngineHours(AuthToken, (long)args["orgId"], (long)args["assetId"], Model<AssetEngineHoursFormCarrier>()));

   349  
   350: 		public VoidGatewayResult SetOdometer(string authToken, long orgId, long assetId, AssetOdometerFormCarrier carrier)
   351  		{

   353  			bool updateAssetDB = !carrier.UsesOnboardOffsets;
   354: 			deviceCapabilityManager.SetOdometer(authToken, orgId, assetId, carrier.Odometer.Value.Value, carrier.Odometer.Unit, carrier.PersistedOdometer.Value.Value, updateAssetDB);
   355  

   616  
   617: 			MiX.DeviceIntegration.Common.Enums.FailReason canSetOdoOffsetAgain = MiX.DeviceIntegration.Common.Enums.FailReason.Success;
   618  			MiX.DeviceIntegration.Common.Enums.FailReason canSetEngineHoursOffsetAgain = MiX.DeviceIntegration.Common.Enums.FailReason.Success;

   732  				{
   733: 					canSetOdoOffsetAgain = DeviceConfigApi.DeviceConfigClient.MobileUnits.CanSetOdo2(authToken, assetId, CorrelationId).ConfigureAwait(false).GetAwaiter().GetResult();
   734  				}

   736  				{
   737: 					DmXLogger.Log($"ConfigApi threw exception on CanSetOdo for AssetId={assetId.ToString()}. Blocking odo set.", LogLevel.Production, CorrelationId.ToString());
   738  					DmXLogger.Log(ex, CorrelationId.ToString());
   739: 					canSetOdoOffsetAgain = MiX.DeviceIntegration.Common.Enums.FailReason.CommandNotYetApplied; //Default to this, in order to block ODO from being set
   740  				}

   755  
   756: 			AssetOdometerFormCarrier setOdoTemplate = new AssetOdometerFormCarrier();
   757  			ThresholdsFormCarrier changeThresholdsFormTemplate = new ThresholdsFormCarrier();

   763  
   764: 				var lastOdo = (isTeltonika) ? AssetsGateway.GetLastOdo(authToken, orgId, assetId) : trackAndTraceMobileUnitManager.GetLastOdometer(authToken, orgId, assetId);
   765  				double value = 0;
   766: 				if (lastOdo != null)
   767  				{
   768: 					Tuple<string, string> tuple = ConfigAdminConverters.ConvertValue(lastOdo.ToString(), ConfigEnums.ValueFormatType.DistanceKilometers, "km", CurrentUserProfile.MeasurementType);
   769  					value = Double.Parse(tuple.Item1);

   771  
   772: 				setOdoTemplate.Odometer = new DistanceCarrier
   773  				{

   785  				string userDistanceUnit = UnitsConverter.GetDistanceUnit(CurrentUserProfile);
   786: 				var lastOdo = AssetsGateway.GetLastOdo(authToken, orgId, assetId);
   787  				double value = 0;
   788: 				if (lastOdo != null)
   789  				{
   790: 					Tuple<string, string> tuple = ConfigAdminConverters.ConvertValue(lastOdo.ToString(), ConfigEnums.ValueFormatType.DistanceKilometers, "km", CurrentUserProfile.MeasurementType);
   791  					value = Double.Parse(tuple.Item1);

   793  
   794: 				setOdoTemplate.Odometer = new DistanceCarrier
   795  				{

   800  
   801: 			setOdoTemplate.PersistedOdometer = setOdoTemplate.Odometer;
   802: 			setOdoTemplate.CanSetOdoOffsetAgain = canSetOdoOffsetAgain;
   803: 			setOdoTemplate.UsesOnboardOffsets = usesOnboardOffsets;
   804  

  1013  				{
  1014: 					configSummaryCarrier.CanSetOdo = true;
  1015: 					carrier.SetOdoTemplate = setOdoTemplate;
  1016: 					carrier.SetOdoTemplate.HyperMedia.Links.Add(ModuleRoutes.SET_ODOMETER.ToLinkCarrier("save", new { orgId = orgId, assetId }));
  1017: 					carrier.SetOdoTemplate.HyperMedia.Validations = Validator.GetValidationRuleCarriers<AssetOdometerFormCarrier>();
  1018: 					carrier.SetOdoTemplate.HyperMedia.Validations.FormName = "setOdoForm";
  1019  

  1052  
  1053: 					configSummaryCarrier.CanSetOdo = true;
  1054: 					carrier.SetOdoTemplate = setOdoTemplate;
  1055  
  1056: 					carrier.SetOdoTemplate.HyperMedia.Links.Add(ModuleRoutes.SET_ODOMETER.ToLinkCarrier("save", new { orgId = orgId, assetId }));
  1057  
  1058: 					carrier.SetOdoTemplate.HyperMedia.Validations = Validator.GetValidationRuleCarriers<AssetOdometerFormCarrier>();
  1059: 					carrier.SetOdoTemplate.HyperMedia.Validations.FormName = "setOdoForm";
  1060  				}

  1082  				{
  1083: 					configSummaryCarrier.CanSetOdo = false;
  1084  					configSummaryCarrier.CanChangeThresholds = false;

  1089  			{
  1090: 				configSummaryCarrier.CanSetOdo = false;
  1091  				configSummaryCarrier.CanSetEngineHours = false;

  1188  					DeviceConfigClient.MobileUnits.DecommissionMiXTalk(authToken, assetId).ConfigureAwait(false).GetAwaiter().GetResult();
  1189: 					//TODO: MR: Send SMS here to also remove numbers and auto-answer
  1190  				}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCostDataModule.cs:
  127  				{
  128: 					carrier.TargetCost.TargetCostPerDistance = new CostPerDistanceCarrier(Math.Round(Convert.ToDouble(targetCpd.Value), 2), cpdUnit);
  129  				}

  134  					var cpd = 1 / converted;
  135: 					carrier.TargetCost.TargetCostPerDistance = new CostPerDistanceCarrier(Math.Round(Convert.ToDouble(cpd), 2), cpdUnit);
  136  				}

  188  				carrier.TransactionId = transaction.TransactionId.ToString();
  189: 				carrier.Odometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(Convert.ToDouble(transaction.Odometer), CurrentUserProfile);
  190  				carrier.TransactionDate = transaction.TransactionDate.ToDateOnlyCarrier();
  191  				carrier.CategoryId = transaction.CategoryId.ToString();
  192: 				carrier.TransactionAmount = new MoneyCarrier(Convert.ToDouble(transaction.Cost), transactionCurrency);
  193: 				carrier.BaseCurrencyAmount = new MoneyCarrier(Convert.ToDouble(transaction.BaseCost), baseCurrency);
  194  				carrier.ExchangeRate = transaction.BaseCost == 0 ? 0 : transaction.Cost / transaction.BaseCost;

  200  
  201: 				carrier.Odometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(asset.Odometer, CurrentUserProfile);
  202  				carrier.TransactionDate = DateTime.Today.ToDateOnlyCarrier();

  270  				carrier.CategoryId = recurringCost.CategoryId.ToString();
  271: 				carrier.TransactionAmount = new MoneyCarrier(Convert.ToDouble(recurringCost.Cost), costCurrency);
  272: 				carrier.BaseCurrencyAmount = new MoneyCarrier(Convert.ToDouble(recurringCost.BaseCost), baseCurrency);
  273  				carrier.ExchangeRate = recurringCost.BaseCost == 0 ? 0 : recurringCost.Cost / recurringCost.BaseCost;

  353  				if (userDistanceUnit.Equals(Unit.Kilometres))
  354: 					carrier.TargetCostPerDistance = new CostPerDistanceCarrier(Math.Round(Convert.ToDouble(targetCpd.Value), 2), cpdUnit);
  355  				else

  359  					var cpd = 1 / converted;
  360: 					carrier.TargetCostPerDistance = new CostPerDistanceCarrier(Math.Round(Convert.ToDouble(cpd), 2), cpdUnit);
  361  				}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetFuelImportExportModule.cs:
  365  				{
  366: 					if (previousTransaction != null && fuelUsageRecord.Odometer < previousTransaction.Odometer)
  367  					{
  368: 						validationResults.Add(new ValidationResult(languaging.GetSimpleTranslation(LanguagingModules.BACKEND, CurrentUserProfile.LanguageCode, ErrorMessages.FuelImport.ODOMETER_MUST_BE_GREATER).Value));
  369  					}
  370  
  371: 					if (nextTransaction != null && fuelUsageRecord.Odometer > nextTransaction.Odometer)
  372  					{
  373: 						validationResults.Add(new ValidationResult(languaging.GetSimpleTranslation(LanguagingModules.BACKEND, CurrentUserProfile.LanguageCode, ErrorMessages.FuelImport.ODOMETER_MUST_BE_LESS).Value));
  374  					}

  395  			fuelUsage.AssetId = asset.AssetId;
  396: 			fuelUsage.Odometer = Converter.ConvertValue(fuelImportCarrier.Odometer, fuelImportCarrier.OdometerUnit, Unit.Kilometres);
  397  			fuelUsage.Litres = Converter.ConvertValue(fuelImportCarrier.Volume, importVolumeUnit, Unit.Litres);

  403  
  404: 			fuelUsage.BaseCost = fuelImportCarrier.ExchangeRate.HasValue ? Convert.ToDecimal(fuelImportCarrier.TransactionAmount / Convert.ToDouble(fuelImportCarrier.ExchangeRate)) :
  405  				fuelImportCarrier.BaseCost.HasValue ? Convert.ToDecimal(fuelImportCarrier.BaseCost) : Convert.ToDecimal(fuelImportCarrier.TransactionAmount);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetFuelUsageModule.cs:
   82  			var profile = CurrentUserProfile;
   83: 			string odoUnit = UnitsConverter.GetDistanceUnit(profile);
   84  			string volumeUnit = UnitsConverter.GetVolumeUnit(profile);
   85  
   86: 			carrier.OdometerUnit = odoUnit;
   87  			carrier.VolumeUnit = volumeUnit;

  105  			foreach (AssetFuelUsage assetFuelUsage in fuelUsage)
  106: 				carrier.FuelUsage.Add(assetFuelUsage.ToAssetFuelUsageListItem(canIEditAssetFuelUsage, canIDeleteAssetFuelUsage, odoUnit, volumeUnit, orgDetails.CurrencyCode, historicalTimeZonesForEntities, sourceDataTimezone));
  107  

  138  
  139: 			string odoUnit = UnitsConverter.GetDistanceUnit(profile);
  140  			string volumeUnit = UnitsConverter.GetVolumeUnit(profile);

  146  				fuelUsage = AssetsManager.GetAssetFuelUsage(authToken, assetId, fuelUsageId.Value);
  147: 				carrier.PopulateFuelUsageData(fuelUsage, baseCurrencyUnit, odoUnit, volumeUnit);
  148  
  149: 				//Odo and engine hours previous and next value for FE validation
  150  				List<AssetFuelUsage> prevAndNextFuelUsage = AssetsManager.GetAssetFuelUsagePreviousAndNextTransactions(authToken, assetId, fuelUsage.FillDate, fuelUsageId.Value);

  153  				{
  154: 					carrier.LastOdometerValues = FuelUsageConverter.GetOdometerForAllAvailableUnits(carrier.Odometer.AvailableUnits, prevFuelUsage.Odometer);
  155  					if (prevFuelUsage.EngineSeconds.HasValue)

  161  				{
  162: 					carrier.NextOdometerValues = FuelUsageConverter.GetOdometerForAllAvailableUnits(carrier.Odometer.AvailableUnits, nextFuelUsage.Odometer);
  163  					if (nextFuelUsage.EngineSeconds.HasValue)

  172  				fuelUsage = AssetsManager.GetAssetFuelUsageLastTransaction(authToken, assetId);
  173: 				carrier.PopulateDefaultFuelUsageData(fuelUsage, baseCurrencyUnit, odoUnit, volumeUnit);
  174  

  177  
  178: 				//Odo and engine hours last value for FE validation
  179  				if (fuelUsage != null)
  180  				{
  181: 					carrier.LastOdometerValues = FuelUsageConverter.GetOdometerForAllAvailableUnits(carrier.Odometer.AvailableUnits, fuelUsage.Odometer);
  182  					if (fuelUsage.EngineSeconds.HasValue)

  205  			{
  206: 				GatewayResult<SaveResultCarrier<AssetFuelUsageCarrier>> validationResult = ValidateOdometerValue<AssetFuelUsageCarrier>(entity, previousAndNextTransactions, isTabsBeacon);
  207  				if (validationResult != null)

  240  			{
  241: 				GatewayResult<SaveResultCarrier<AssetFuelUsageCarrier>> validationResult = ValidateOdometerValue<AssetFuelUsageCarrier>(entity, previousAndNextTransactions, isTabsBeacon);
  242  				if (validationResult != null)

  280  			{
  281: 				Odometer = new DistanceCarrier(),
  282  				TransactionAmount = new MoneyCarrier(),

  308  
  309: 		private GatewayResult<SaveResultCarrier<T>> ValidateOdometerValue<T>(AssetFuelUsage entity, List<AssetFuelUsage> previousAndNextTransactions, bool isTabsBeacon)
  310  		{

  314  
  315: 			if (!IsPreviousTransactionOdoValid(entity, previousTransaction, isTabsBeacon))
  316  			{
  317: 				carrier.Messages.Add("PreviousOdoInvalid", Common.Constants.ErrorMessages.Assets.PREVIOUS_TRANSACTION_INVALID);
  318: 				carrier.Messages.Add("Odometer", previousTransaction.Odometer.ToString());
  319  				carrier.Messages.Add("FillDate", previousTransaction.FillDate.ToString());

  323  
  324: 			if (!IsNextTransactionOdoValid(entity, nextTransaction, isTabsBeacon))
  325  			{
  326: 				carrier.Messages.Add("NextOdoInvalid", Common.Constants.ErrorMessages.Assets.NEXT_TRANSACTION_INVALID);
  327: 				carrier.Messages.Add("Odometer", nextTransaction.Odometer.ToString());
  328  				carrier.Messages.Add("FillDate", nextTransaction.FillDate.ToString());

  360  
  361: 		private bool IsPreviousTransactionOdoValid(AssetFuelUsage fuelUsage, AssetFuelUsage previousTransaction, bool isTabsBeacon)
  362  		{

  364  			{
  365: 				if (previousTransaction != null && previousTransaction.Odometer == fuelUsage.Odometer)
  366  				{

  370  				{
  371: 					return previousTransaction == null || fuelUsage.Odometer > previousTransaction.Odometer;
  372  				}

  375  			{
  376: 				return previousTransaction == null || fuelUsage.Odometer > previousTransaction.Odometer;
  377  			}

  379  
  380: 		private bool IsNextTransactionOdoValid(AssetFuelUsage fuelUsage, AssetFuelUsage nextTransaction, bool isTabsBeacon)
  381  		{

  383  			{
  384: 				if (nextTransaction != null && nextTransaction.Odometer == fuelUsage.Odometer)
  385  				{

  389  				{
  390: 					return nextTransaction == null || fuelUsage.Odometer < nextTransaction.Odometer;
  391  				}

  394  			{
  395: 				return nextTransaction == null || fuelUsage.Odometer < nextTransaction.Odometer;
  396  			}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetKeypadNumbersModule.cs:
  95  
  96: 			OrganisationDetail orgDetail = OrganisationManager.GetOrganisationDetail(authToken, org.GroupId); //TODO: MR: Ensure this is correct (test for site asset)
  97  			var orgIsMiXTalkEnabled = orgDetail.HasFeature(OrgFeature.MiXTalk);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetMeterReadingsModule.cs:
   46  			public static readonly RouteDefinition GET_METER_READINGS = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/organisations/{orgId}/assets/{assetId}/meterreadings", DynaMiX.Core.Http.Constants.HTTPVerbs.GET);
   47: 			public static readonly RouteDefinition GET_ODOMETER_CONVERSIONS= new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/organisations/assets/meterreadings/odometerconversions/{value}/{unit}", DynaMiX.Core.Http.Constants.HTTPVerbs.GET);
   48  		}

   53  			RegisterRoute(ModuleRoutes.GET_METER_READINGS, args => GetAssetMeterReadings(AuthToken, (long)args["orgId"], (long)args["assetId"]));
   54: 			RegisterRoute(ModuleRoutes.GET_ODOMETER_CONVERSIONS, args => GetOdometerConversions(AuthToken, (float)args["value"], (string)args["unit"]));
   55  		}

   95  				var userUnitPref = UnitsConverter.GetDistanceUnit(CurrentUserProfile); //default user pref
   96: 				carrier.UploadAllForm.ActionsOdometer = new DistanceCarrier
   97  				{

  100  				};
  101: 				if (asset.Odometer.HasValue)
  102  				{
  103: 					carrier.CurrentOdomenterDisplay = GetCurrentOdometerDisplay(asset.Odometer.Value);
  104  				}

  114  
  115: 		public GatewayResult<OdometerConversionsCarrier> GetOdometerConversions(string authToken, float value, string unit)
  116  		{
  117  			var convertedValue = Math.Round(MiX.Core.Conversion.Converter.ConvertValue(value, unit, Unit.Kilometres), 2);
  118: 			var carrier = new OdometerConversionsCarrier();
  119: 			carrier.CurrentOdomenterDisplay = GetCurrentOdometerDisplay(convertedValue);
  120: 			return new GatewayResult<OdometerConversionsCarrier>(GatewayResultStatus.Success, carrier);
  121  		}
  122  
  123: 		private Dictionary<string, string> GetCurrentOdometerDisplay(double value)
  124  		{

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetRemindersModule.cs:
  239  				distance.CurrentDistance = new DistanceCarrier();
  240: 				distance.CurrentDistance.Value = Math.Round(Converter.ConvertValue(asset.Odometer.HasValue ? asset.Odometer.Value : 0, Unit.Kilometres, unit.Value), 2);
  241  				distance.CurrentDistance.Unit = unit.Value;

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetServiceHistoryModule.cs:
   81  
   82: 			string odoUnit = UnitsConverter.GetDistanceUnit(profile);
   83  
   84: 			carrier.OdometerUnit = odoUnit;
   85  

   96  			{
   97: 				carrier.ServiceHistory.Add(assetService.ToAssetServiceHistoryListItem(canIEditAssetFuelUsage, canIDeleteAssetFuelUsage, odoUnit, orgBaseCurrency));
   98  			}

  145  			OrganisationSummary orgDetails = OrganisationManager.GetOrganisationSummary(org.GroupId, CorrelationId);
  146: 			string odoUnit = UnitsConverter.GetDistanceUnit(CurrentUserProfile);
  147  			AssetServiceHistoryCarrier carrier = BuildEmptyHistoryCarrier(org.GroupId);

  158  			carrier.ServiceHistoryId = serviceHistory.AssetServiceHistoryId + "";
  159: 			double odo = Math.Round(Converter.ConvertValue(serviceHistory.Odometer, Unit.Kilometres, odoUnit), 2);
  160: 			carrier.Odometer.Value = odo;
  161: 			carrier.Odometer.Unit = odoUnit;
  162  

  178  				AvailableUnits = GetMoneyAvailableUnits(org.GroupId, authToken),
  179: 				Value = Convert.ToDouble(baseAmount),
  180  				Unit = !string.IsNullOrEmpty(serviceHistory.BaseCurrency) ? serviceHistory.BaseCurrency : baseCurrencyUnit.Value

  185  				AvailableUnits = GetMoneyAvailableUnits(org.GroupId, authToken),
  186: 				Value = Convert.ToDouble(transAmount),
  187  				Unit = transactionCurrencyUnit.Value

  201  			{
  202: 				carrier.OdometerRemindersEnabled = true;
  203: 				carrier.NextOdometer.Value = Math.Round(Converter.ConvertValue(reminder.NextServiceDueAtKm.Value, Unit.Kilometres, odoUnit), 2);
  204: 				carrier.NextOdometer.Unit = odoUnit;
  205: 				carrier.OdometerInterval = (int)Math.Round(Converter.ConvertValue(reminder.ServiceIntervalKm.Value, Unit.Kilometres, odoUnit));
  206: 				foreach (var unit in carrier.Odometer.AvailableUnits)
  207  				{
  208: 					carrier.OdometerIntervalValues.Add(unit.Value, Math.Round(Converter.ConvertValue(reminder.ServiceIntervalKm.Value, Unit.Kilometres, unit.Value), 2).ToString());
  209  				}

  223  
  224: 			//Previous and next odo and engine hours
  225  			List<AssetServiceHistory> assetServiceHistoryList = AssetsServicingManager.GetAssetServiceHistoryList(authToken, assetId).OrderBy(a => a.ServiceDate).ToList();

  228  			{
  229: 				foreach (var unit in carrier.Odometer.AvailableUnits)
  230: 					carrier.LastOdometerValues.Add(unit.Value, Math.Round(Converter.ConvertValue(previousServiceHistory.Odometer, Unit.Kilometres, unit.Value), 2).ToString());
  231  				if (serviceHistory.EngineSeconds.HasValue && previousServiceHistory.EngineSeconds.HasValue)

  236  			{
  237: 				foreach (var unit in carrier.Odometer.AvailableUnits)
  238: 					carrier.NextOdometerValues.Add(unit.Value, Math.Round(Converter.ConvertValue(nextServiceHistory.Odometer, Unit.Kilometres, unit.Value), 2).ToString());
  239  				if (serviceHistory.EngineSeconds.HasValue && nextServiceHistory.EngineSeconds.HasValue)

  251  			OrganisationSummary orgDetails = OrganisationManager.GetOrganisationSummary(org.GroupId, CorrelationId);
  252: 			string odoUnit = UnitsConverter.GetDistanceUnit(CurrentUserProfile);
  253  			AssetServiceHistoryCarrier carrier = BuildEmptyHistoryCarrier(org.GroupId);

  265  			carrier.ServiceDate = new ZonedDateTime(serviceDate.DateTime, serviceDate.TimeZone).ToCarrier();
  266: 			carrier.Odometer.Value = 1;
  267: 			carrier.Odometer.Value = carrier.IsTabsBeacon ? 0 : Math.Round(Converter.ConvertValue(reminder.NextServiceDueAtKm.HasValue ? reminder.NextServiceDueAtKm.Value : 0, Unit.Kilometres, odoUnit), 2);
  268  
  269: 			carrier.Odometer.Unit = odoUnit;
  270  			carrier.ExchangeRate = 1;

  274  			{
  275: 				var odo = Math.Round(Converter.ConvertValue(serviceHistory.Odometer, Unit.Kilometres, odoUnit), 2);
  276: 				carrier.Odometer.Value = (odo);
  277  			}

  303  				if (reminder.EnableOnDistance)
  304: 					carrier.OdometerRemindersEnabled = true;
  305  				if (reminder.ServiceIntervalKm.HasValue)
  306  				{
  307: 					carrier.OdometerInterval = (int)Math.Round(Converter.ConvertValue(reminder.ServiceIntervalKm.Value, Unit.Kilometres, odoUnit));
  308: 					foreach (var unit in carrier.Odometer.AvailableUnits)
  309  					{
  310: 						carrier.OdometerIntervalValues.Add(unit.Value, Math.Round(Converter.ConvertValue(reminder.ServiceIntervalKm.Value, Unit.Kilometres, unit.Value), 2).ToString());
  311  					}
  312  				}
  313: 				carrier.NextOdometer = new DistanceCarrier { Value = 0, Unit = odoUnit };
  314  			}

  322  
  323: 			//Last service odo and engine hours
  324  			if (serviceHistory != null)
  325  			{
  326: 				foreach (var unit in carrier.Odometer.AvailableUnits)
  327: 					carrier.LastOdometerValues.Add(unit.Value, Math.Round(Converter.ConvertValue(serviceHistory.Odometer, Unit.Kilometres, unit.Value), 2).ToString());
  328  				if (serviceHistory.EngineSeconds.HasValue)

  341  			if (fromUi.EnableOnDistance)
  342: 				fromUi.NextServiceDueAtKm = (int)Math.Round(Converter.ConvertValue(carrier.NextOdometer.Value.Value, carrier.NextOdometer.Unit, Unit.Kilometres));
  343  

  356  			{
  357: 				GatewayResult<SaveResultCarrier<AssetServiceHistoryCarrier>> validationResult = ValidateOdometerValue<AssetServiceHistoryCarrier>(entity, previousAndNextTransactions);
  358  				if (validationResult != null)

  379  			{
  380: 				var odometer = carrier.Odometer.Value.Value;
  381: 				double nextServiceaOdoValue = 0;
  382: 				if (carrier.NextOdometer != null && carrier.NextOdometer.Value != null)
  383: 					nextServiceaOdoValue = Math.Round(Converter.ConvertValue((double)carrier.NextOdometer.Value, carrier.NextOdometer.Unit, Unit.Kilometres));
  384  				else
  385: 					nextServiceaOdoValue = odometer + (double)Math.Round(Converter.ConvertValue(fromUi.ServiceIntervalKm.Value, carrier.Odometer.Unit, Unit.Kilometres));
  386: 				fromUi.NextServiceDueAtKm = (float)nextServiceaOdoValue;
  387  			}

  398  			{
  399: 				GatewayResult<SaveResultCarrier<AssetServiceHistoryCarrier>> validationResult = ValidateOdometerValue<AssetServiceHistoryCarrier>(entity, previousAndNextTransactions);
  400  				if (validationResult != null)

  423  			{
  424: 				Odometer = new DistanceCarrier() // the value of the service being entred
  425  				{

  428  				},
  429: 				LastOdometer = new DistanceCarrier() // for the help-text
  430  				{

  433  				},
  434: 				NextOdometer = new DistanceCarrier() // to update the reminder
  435  				{

  463  
  464: 		private GatewayResult<SaveResultCarrier<T>> ValidateOdometerValue<T>(AssetServiceHistory entity, List<AssetServiceHistory> previousAndNextTransactions)
  465  		{

  469  
  470: 			if (!IsPreviousTransactionOdoValid(entity, previousTransaction))
  471  			{
  472: 				carrier.Messages.Add("PreviousOdoInvalid", Common.Constants.ErrorMessages.Assets.PREVIOUS_TRANSACTION_INVALID);
  473: 				carrier.Messages.Add("Odometer", previousTransaction.Odometer.ToString());
  474  				carrier.Messages.Add("ServiceDate", previousTransaction.ServiceDate.ToString());

  478  
  479: 			if (!IsNextTransactionOdoValid(entity, nextTransaction))
  480  			{
  481: 				carrier.Messages.Add("NextOdoInvalid", Common.Constants.ErrorMessages.Assets.NEXT_TRANSACTION_INVALID);
  482: 				carrier.Messages.Add("Odometer", nextTransaction.Odometer.ToString());
  483  				carrier.Messages.Add("ServiceDate", nextTransaction.ServiceDate.ToString());

  489  
  490: 		private bool IsPreviousTransactionOdoValid(AssetServiceHistory serviceHistory, AssetServiceHistory previousTransaction)
  491  		{
  492: 			return previousTransaction == null || serviceHistory.Odometer > previousTransaction.Odometer;
  493  		}
  494  
  495: 		private bool IsNextTransactionOdoValid(AssetServiceHistory serviceHistory, AssetServiceHistory nextTransaction)
  496  		{
  497: 			return nextTransaction == null || serviceHistory.Odometer < nextTransaction.Odometer;
  498  		}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetTrailerIDModule.cs:
   46  			public static readonly RouteDefinition POST_CHANGE_TRAILER_ID = new RouteDefinition(ApiBaseUrl, BasePath, "/assets/organisations/{groupId}/{assetId}/change-trailer-id", Constants.HTTPVerbs.POST);
   47: 			public static readonly RouteDefinition POST_CHANGE_ODOMETER = new RouteDefinition(ApiBaseUrl, BasePath, "/assets/organisations/{groupId}/{assetId}/change-odometer", Constants.HTTPVerbs.POST);
   48  		}

   53  			RegisterRoute(ModuleRoutes.POST_CHANGE_TRAILER_ID, args => PostChangeTrailerIdPage(AuthToken, (long)args["groupId"], (long)args["assetId"], Model<ChangeTrailerIdFormCarrier>()));
   54: 			RegisterRoute(ModuleRoutes.POST_CHANGE_ODOMETER, args => PostChangeOdometerPage(AuthToken, (long)args["groupId"], (long)args["assetId"], Model<ChangeOdometerFormCarrier>()));
   55  		}

   61  
   62: 			string odoUnit = UnitsConverter.GetDistanceUnit(CurrentUserProfile);
   63: 			double odo = Math.Round(Converter.ConvertValue(entity.Odometer, Unit.Kilometres, odoUnit), 2);
   64: 			AssetTrailerIDPageCarrier carrier = entity.ToCarrier(odoUnit, odo);
   65  

   81  
   82: 			//Change odometer
   83: 			carrier.ChangeOdometerForm = new ChangeOdometerFormCarrier
   84  			{
   85: 				NewOdometer = new DistanceCarrier { Value = odo, Unit = odoUnit },
   86: 				NewOdometerDate = OrganisationManager.GetCurrentOrganisationTime(organisation.GroupId).ToCarrier(),
   87  				HyperMedia = new HyperMediaCarrier

   90  					{
   91: 						ModuleRoutes.POST_CHANGE_ODOMETER.ToLinkCarrier("save", new { groupId, assetId })
   92  					}

  107  
  108: 		public VoidGatewayResult PostChangeOdometerPage(string authToken, long groupId, long assetId, ChangeOdometerFormCarrier carrier)
  109  		{

  111  			AssetTrailerDetails entity = carrier.ToEntity();
  112: 			AssetTrailerIdManager.ChangeOdometer(authToken, organisation.GroupId, assetId, entity);
  113  			return new VoidGatewayResult(GatewayResultStatus.Success);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\ImportExport\AssetExportCsvClassMapping.cs:
  38  
  39: 			if (columns.Contains("odometer", StringComparer.OrdinalIgnoreCase))
  40: 				Map(a => a.Odometer);
  41  

  45  			if (columns.Contains("status", StringComparer.OrdinalIgnoreCase))
  46: 				Map(a => a.Status); //todo csv conversion
  47  

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\ImportExport\AssetExportXlsxClassMapping.cs:
  63  				}
  64: 				else if (column.Equals("odometer", StringComparison.InvariantCultureIgnoreCase))
  65  				{
  66: 					var lname = Translate(languagingGateway, targetLanguage, Common.Constants.ColumnHeadings.AssetImportTemplate.ODOMETER);
  67: 					Map(a => a.Odometer).Name(lname).ExportUsing(a => a.HasValue ? Math.Round(a.Value, 0) : default(double));
  68  				}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\ImportExport\FuelImportXlsxClassMapping.cs:
  29  			Map(x => x.DateAndTime).Name(GetDateAndTimeFormatHeader(languagingGateway, profile)).FormatAsDate(GetDateFormat(orgDetail));
  30: 			Map(x => x.OdometerUnit).UsingLookup(distanceMeasures).Name(Translate(Common.Constants.ColumnHeadings.FuelImportTemplate.ODOMETER_UNIT, languagingGateway, profile));
  31: 			Map(x => x.Odometer).Name(Translate(Common.Constants.ColumnHeadings.FuelImportTemplate.ODOMETER, languagingGateway, profile));
  32  			Map(x => x.VolumeUnit).UsingLookup(volumeMeasures).Name(Translate(Common.Constants.ColumnHeadings.FuelImportTemplate.VOLUME_UNIT, languagingGateway, profile));

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\ImportExport\FuelXlsxImporter.cs:
  149  
  150: 				if (string.IsNullOrEmpty(item.OdometerUnit))
  151  				{
  152: 					validationResults.Add(new ValidationResult(languaging.GetSimpleTranslation(LanguagingModules.BACKEND, _currentUserProfile.LanguageCode, ErrorMessages.FuelImport.ODOMETER_IS_REQUIRED).Value));
  153  					valid = false;

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\CustomGroups\CustomGroupMembershipModule.cs:
  134  					.FindAll(x => !x.IsConnectedTrailer && groupDictionary.ContainsKey(x.SiteId)) // should not include connected trailers
  135: 					.Select(a => a.ToCarrier(groupDictionary[a.SiteId])) // TODO: perhaps we should let the exception get thrown?
  136  					.ToList();
  137  
  138: 				//todo: use GroupTrees.GetOrgGroupsAssetsTree
  139  				carrier.AssetsTree = TreeConverter.ToGroupAssetsTreeCarrier(groupMemberships, groups, assets);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Drivers\DriverLicencesModule.cs:
  47  
  48: 			//Contact TODO: move to contacts and make generic
  49  			public static readonly RouteDefinition PostContact = DriverRouteDefinition("/organisations/{orgId}/contacts", Constants.HTTPVerbs.POST);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Drivers\ImportExport\DriverExportXlsxClassMapping.cs:
  83  	{
  84: 		//todo: move column headings to constants file
  85  		public DriverExportXlsxClassMapping(IEnumerable<string> columns, ILanguagingGateway languagingGateway, string targetLanguage)

DynaMiX.Backend\API\DynaMiX.API\NancyModules\HoursOfService\HosModuleBase.cs:
  59  			{
  60: 				Logic.UnitsConverter.ConvertProperties(d, CurrentUserProfile, o => o.StartOdometer, o => o.StartOdometerUnits);
  61  				Logic.UnitsConverter.ConvertProperties(d, CurrentUserProfile, o => o.Distance, o => o.DistanceUnits);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\HoursOfService\HosNotificationCrudModule.cs:
  203  
  204: 			//todo: remove MOCK data
  205  			//carrier.Notification.NotificationEscalations = new List<NotificationEscalationCarrier>()

DynaMiX.Backend\API\DynaMiX.API\NancyModules\HoursOfService\HosNotificationsModule.cs:
  92  				{
  93: 					var driverIds = notification.DriverIds.Concat(notification.AllDriverIds).Distinct().ToList(); //todo: check the diff between DriverIds and AllDriverIds					
  94  					driverCount = driverIds.Count;

DynaMiX.Backend\API\DynaMiX.API\NancyModules\HoursOfService\HosOverviewModule.cs:
  363  			{
  364: 				//TODO: As the driver columns become more defined per region we will have to relook this, for now the split is sufficient
  365  				carrier.HosHasEuropeanRulesets = carrier.Items.Any(dl => dl.HosAvailableHours != null && dl.HosAvailableHours.IsEuropeanRuleset);

  576  
  577: 			/*TODO: GHOS-3553 Figure out why this section is here again as the 
  578  			 * AH on the carrier.Items is already set in the loop above -- this might be a waste of valuable time*/

DynaMiX.Backend\API\DynaMiX.API\NancyModules\InfoHub\InfoHubListModule.cs:
  450  
  451: 			//TODO: Remove since this won't be called anymore
  452  			if (streamNotification.HasNotification == "1")

DynaMiX.Backend\API\DynaMiX.API\NancyModules\InsightReports\InsightReportsModule.cs:
   124  		{
   125: 			//TODO: Remove in production
   126  			public static readonly RouteDefinition AuthenticateUser = new RouteDefinition(ApiBaseUrl, BasePath, "/auth", Core.Http.Constants.HTTPVerbs.GET);

   404  
   405: 			//todo: use GroupTrees.GetOrgGroupsAssetsTree
   406  			carrier.AssetsGroupTree = TreeConverter.ToGroupAssetsInsightTreeCarrier(cached.GroupMemberships, cached.Groups, assets);

  1036  
  1037: 			//TODO: Remove this once datawarehouse returns 64bit Ids
  1038  			Dictionary<string, string[]> reportParams = ReportsManager.DeserialiseFormParameters(Request.Form["params"].Value);

  1143  
  1144: 			//TODO: Remove this once datawarehouse returns 64bit Ids
  1145  			selectionCriteria = ReportsManager.ConvertToLegacyIds(authToken, selectionCriteria, orgId);

  1165  
  1166: 				//TODO: check if any new lists have been resolved and get the list
  1167  				var permission = DynaMiX.Common.InsightReports.Constants.Permissions.GetAccessPermission(decodedPath);

  1180  
  1181: 			//TODO: Remove this once datawarehouse returns 64bit Ids
  1182  			selectionCriteria = ReportsManager.ConvertToLegacyIds(authToken, selectionCriteria, orgId);

  1202  
  1203: 			//TODO: Remove this once datawarehouse returns 64bit Ids
  1204  			selectionCriteria = ReportsManager.ConvertToLegacyIds(authToken, selectionCriteria, orgId);

  1247  
  1248: 			//TODO: Remove this once datawarehouse returns 64bit Ids
  1249  			selectionCriteria = ReportsManager.ConvertToLegacyIds(authToken, selectionCriteria, orgId);

  1608  
  1609: 			//TODO: Remove this once datawarehouse returns 64bit Ids
  1610  			Dictionary<string, string[]> reportParams = ReportsManager.ConvertToLegacyIds(authToken, carrier.ReportParameters, orgId);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JobsAndMessaging\MessageCrudModule.cs:
   46  			public static readonly RouteDefinition GET_MESSAGE = new RouteDefinition(APISettings.Current.ApiBaseUrl, APISettings.Current.JobsAndMessagingBaseUrl, "/groups/{orgId}/messages/{id}/info", DynaMiX.Core.Http.Constants.HTTPVerbs.GET);
   47: 			public static readonly RouteDefinition GET_MESSAGE_HISTORY = new RouteDefinition(APISettings.Current.ApiBaseUrl, APISettings.Current.JobsAndMessagingBaseUrl, "/groups/{orgId}/messages/{id}/history", DynaMiX.Core.Http.Constants.HTTPVerbs.GET); //TODO JM: Verify endpoint url + name
   48  

  396  					AssetId = assetId,
  397: 					TransportId = MessageTransports.GPRS, //todo (config dependent): get default transport for asset
  398  					StartDate = DateTime.UtcNow,

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JourneyManagement\CustomerJourneyViewModule.cs:
  393  
  394: 		//TODO ZS UPDATE CALL
  395  		/// <summary>

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JourneyManagement\JourneyListModule.cs:
  425  
  426: 		//TODO ZS UPDATE CALL
  427  		/// <summary>

  440  
  441: 		//TODO ZS UPDATE CALL
  442  		/// <summary>

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JourneyManagement\JourneyModuleBase.cs:
  162  			MeasurementCarrier maxTruckWeight = new MeasurementCarrier();
  163: 			maxTruckWeight.Value = MiX.Core.Conversion.Converter.ConvertValue(Convert.ToDouble(truckRoutingRequest.LimitedWeight), unitDisplay, MiX.Core.Conversion.Unit.Kilograms);
  164  			truckRoutingRequest.LimitedWeight = Math.Round(maxTruckWeight.Value).ToString();

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JourneyManagement\JourneyMonitoringModule.cs:
  439  
  440: 		//TODO ZS UPDATE CALL
  441  		/// <summary>

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JourneyManagement\JourneyWizardModule.cs:
   236  
   237: 			//TODO: Check whether the Journey may be edited before adding the AllowedActions
   238  			carrier.JourneyCargoDetail.AllowedActions.Add(ACTION_REMOVE);

   242  			{
   243: 				//TODO: Check whether the Journey may be edited before adding the remove and edit actions
   244  				journeyCargoDetailCarrier.Actions.Add(ACTION_REMOVE);

   604  				List<DriverSummary> assignedDrivers = new List<DriverSummary>();
   605: 				//todo Zonika Rework to loop the other way round
   606  				if (selected.Count > 0)

   625  
   626: 			//TODO: Check whether the Journey may be edited before adding the AllowedActions
   627  			carrier.AllowedActions.Add(ACTION_REMOVE);

   630  			{
   631: 				//TODO: Check whether the Journey may be edited before adding the remove action
   632  				journeyAssetCarrier.Actions.Add(ACTION_REMOVE);

   635  				{
   636: 					//TODO: Check whether the Journey may be edited before adding the remove action
   637  					if (carrier.CanEditDrivers)

   834  
   835: 			//TODO: Check whether the Journey may be edited before adding the InternalPassengerAllowedActions and ExternalPassengerAllowedActions
   836  			carrier.InternalPassengerAllowedActions.Add(ACTION_REMOVE);

   844  			{
   845: 				//TODO: Check whether the Journey may be edited before adding the actions
   846  				journeyAssetCarrier.Actions.Add(ACTION_EDIT_EXTERNAL_PASSENGER);

   850  				{
   851: 					//TODO: Check whether the Journey may be edited before adding the remove action
   852  					journeyAssetPassenger.Actions.Add(ACTION_REMOVE);

  1159  			carrier.WeightUnit = maxTruckWeight.UnitType;
  1160: 			//TODO: Check whether the Journey may be edited before adding the WaypointActions and StartAndEndActions
  1161  			carrier.WaypointActions.Add(ACTION_EDIT);

  1165  
  1166: 			//TODO: Check whether the Journey may be edited before adding the Actions on Start, End and Waypoint Locations
  1167  			//Start and End Locations may only be edited

  1327  			var unitDistenseDisplay = model.TotalDistanceDisplay.Split(' ');
  1328: 			model.TotalDistance.Value = MiX.Core.Conversion.Converter.ConvertValue(Convert.ToDouble(unitDistenseDisplay[0]), unitDistenseDisplay[1], MiX.Core.Conversion.Unit.Metres);
  1329  

  1449  			var unitDisplay = UnitsConverter.GetWeightUnit(CurrentUser.Profile);
  1450: 			route.TruckWeight = MiX.Core.Conversion.Converter.ConvertValue(Convert.ToDouble(route.TruckWeight.ToString()), MiX.Core.Conversion.Unit.Kilograms, unitDisplay).ToString();
  1451  			route.TruckWeightClass = MiX.Core.Conversion.Converter.ConvertValue(Convert.ToInt32(route.TruckWeightClass), MiX.Core.Conversion.Unit.Kilograms, unitDisplay).ToString();

  1729  
  1730: 			//TODO: Check whether the Journey may be edited before adding the AllowedActions
  1731  			carrier.AllowedActions.Add(ACTION_REMOVE);

  1734  			{
  1735: 				//TODO: Check whether the Journey may be edited before adding the remove action
  1736  				journeyAssetCarrier.Actions.Add(ACTION_REMOVE);

  1739  				{
  1740: 					//TODO: Check whether the Journey may be edited before adding the remove action
  1741  					journeyAssetCargo.Actions.Add(ACTION_REMOVE);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JourneyManagement\RouteModule.cs:
  107  		/// <returns></returns>
  108: 		//TODO ZS UPDATE CALL
  109  		public GatewayResult<RouteLocationListCarrier> GetRouteLocations(string authToken, long orgId, long siteId, long routeId)

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JourneyManagement\LibraryLevel\LibraryRiskAssessmentTemplateQuestionModule.cs:
  47  
  48: 		//TODO ZS UPDATE CALL
  49  		public VoidGatewayResult MakeUnavailable(long orgId, long riskAssessmentTemplateQuestionId)

  86  
  87: 			//TODO: GDS - Check whether AuthoriseOnAnyChild is the correct method to call here as the questions can be made available at site level as well
  88  			bool canEdit = AuthorisationManager.AuthoriseOnAnyChild(authToken, DynaMiX.Common.JourneyManagement.Constants.Permissions.CAN_EDIT_LIBRARY_RISK_ASSESSMENT_TEMPLATE_QUESTIONS, orgId);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\JourneyManagement\LibraryLevel\LibraryRouteModule.cs:
  337  				var unitDisplay = UnitsConverter.GetWeightUnit(CurrentUser.Profile);
  338: 				route.TruckWeight = MiX.Core.Conversion.Converter.ConvertValue(Convert.ToDouble(route.TruckWeight.ToString()), MiX.Core.Conversion.Unit.Kilograms, unitDisplay).ToString();
  339  				route.TruckWeightClass = MiX.Core.Conversion.Converter.ConvertValue(Convert.ToInt32(route.TruckWeightClass), MiX.Core.Conversion.Unit.Kilograms, unitDisplay).ToString();

  505  			var unitDisplay = UnitsConverter.GetWeightUnit(CurrentUser.Profile);
  506: 			carrier.TruckWeight = MiX.Core.Conversion.Converter.ConvertValue(Convert.ToDouble(carrier.TruckWeight.ToString()), unitDisplay, MiX.Core.Conversion.Unit.Kilograms).ToString();
  507  

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Operations\DatabaseAdmin\DatabaseGroupTreeModule.cs:
  388  			carrier.Type = TreeConverter.ConvertGroupType(GroupManager.GetGroupById(authToken, groupId).Type);
  389: 			// TODO SC: if this is multi level org might need to populate items with children
  390  

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Operations\DatabaseAdmin\MultiOrgAdminModule.cs:
  63  
  64: 			// TODO: Revisit when multi-level orgs are implemented more than 1 level deep.
  65  			List<OrganisationDetail> orgsDetailsBelowMloList = OrganisationManager.GetOrganisationDetailsWithFeaturesByMultiLevelGroupId(authToken, multiOrgId);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Operations\DatabaseAdmin\OrganisationDetailsModule.cs:
  203  			{
  204: 				// TODO: Revisit when multi-level orgs are implemented more than 1 level deep. Currently this takes first one.
  205  				var mloGroupId = multiLevelOrgsList[0].GroupId;

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Operations\DataCentreAdmin\ApiAccountAdminModule.cs:
   69  				MeasurementUnitId = ((int)MeasurementType.Metric).ToString(),
   70: 				OdoUnitId = ((int)MeasurementType.Metric).ToString(),
   71  				VolumeUnitId = ((int)MeasurementType.Metric).ToString()

  188  			carrier.ConsumptionUnits = EnumDropDownConverter.EnumToDropDown<ConsumptionType>();
  189: 			carrier.OdoUnits = EnumDropDownConverter.EnumToDropDown<MeasurementType>();
  190  			carrier.VolumeUnits = EnumDropDownConverter.EnumToDropDown<MeasurementType>();

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Operations\OrgSettings\DrivingReasonsModule.cs:
  50  				reason.Reason = new ActiveCell();
  51: 				reason.Reason.Disabled = false; //TODO: Permissions
  52  				reason.Reason.Title = "Reason " + i;

  54  
  55: 				//TODO if reason is system (Business, Private, Commute, Other) then can't delete or edit
  56  				reason.Actions.Add("Edit");

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Scheduler\DownloadScheduleDetailsModule.cs:
  167  					carrier.DownloadTripsAndEventsType = TripsEventsDownloadTypes.Quick.GetDescription();
  168: 					carrier.DownloadTachoType = TachoDownloadType.None.GetDescription();
  169  					carrier.Tabs = new List<TabCarrier>();

  211  			if (carrier.FrequencySpecificDateTime == null)
  212: 					carrier.FrequencySpecificDateTime = orgDisplayDateTime.ToCarrier(); //TODO: MR: Should these rather be null (to be handled by FE)?
  213  			if (carrier.FrequencyRecurringDailyTime == null)

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Scheduler\UploadScheduleDetailsModule.cs:
  253  
  254: 			//Odometer
  255: 			carrier.Form.ActionsOdometer = new DistanceCarrier
  256  			{

  259  			};
  260: 			if (asset.Odometer.HasValue)
  261  			{
  262: 				carrier.CurrentOdomenterDisplay = new Dictionary<string, string>();
  263: 				foreach (UnitCarrier unit in carrier.Form.ActionsOdometer.AvailableUnits)
  264  				{
  265: 					carrier.CurrentOdomenterDisplay.Add(unit.Value, Math.Round(MiX.Core.Conversion.Converter.ConvertValue(asset.Odometer.Value, Unit.Kilometres, unit.Value), 2).ToString());
  266  				}

  292  		{
  293: 			if (carrier.ActionsOdometer?.Value == null)
  294: 				carrier.ActionsOdometer = null;
  295  

  350  		{
  351: 			if (carrier.ActionsOdometer != null)
  352  			{

  354  				var json = new JavaScriptSerializer().Serialize(carrier);
  355: 				DmXLogger.Log($"SaveUploadScheduler: {user.GetFullName()}, Odo values: {carrier.ActionsOdometer.Value} {carrier.ActionsOdometer.Unit}. JSON: {json}", LogLevel.Warning);
  356  			}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\SupportTools\Auditing\AuditingModule.cs:
  279  
  280: 			List<string> columns = new List<string> { "EventId", "AssetName", "Status", "EventType", "EventStatus", "EventStart", "Odometer", "EngineHours", "Remarks", "ProximityLocation", "MapLocation", "SequenceNo", "Origin", "StateCode", "DistanceSinceLast", "PendingEditStatus", "IsSynced", "EditedBy", "EditedOn", "EditState" };
  281  			using (MemoryStream s = new MemoryStream())

DynaMiX.Backend\API\DynaMiX.API\NancyModules\SupportTools\Auditing\DriverAuditExportXlsClassMapping.cs:
  58  				
  59: 				if (column.Equals("Odometer", StringComparison.InvariantCultureIgnoreCase))
  60  				{					
  61: 					var lname = Translate(languagingGateway, targetLanguage, Common.Constants.ColumnHeadings.DriverAuditLogHeadings.ODOMETER) + $" ({distanceUnit})";
  62: 					Map(a => a.Odometer).Name(lname).FormatAsText();
  63  				}

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Timeline\HOSTimelineModule.cs:
   145  			public static readonly RouteDefinition REMOVE_HOS_STATUS = new RouteDefinition(ApiBaseUrl, BasePath, "/status/{statusId}/{driverId}", Core.Http.Constants.HTTPVerbs.DELETE);
   146: 			public static readonly RouteDefinition GET_HOS_STATUS_ODO_RANGE = new RouteDefinition(ApiBaseUrl, BasePath, "/status/sites/{siteId}/asset/{entityId}/odometer/", Core.Http.Constants.HTTPVerbs.GET);
   147  			public static readonly RouteDefinition GET_ASSET_ENGINE_HOURS_RANGE = new RouteDefinition(ApiBaseUrl, BasePath, "/status/sites/{siteId}/asset/{entityId}/engineHours/", Core.Http.Constants.HTTPVerbs.GET);

   214  			RegisterRoute(ModuleRoutes.REMOVE_HOS_STATUS, args => RemoveHosStatus(AuthToken, (long)args["statusId"], (long)args["driverId"], (string)Context.Request.Query["removeReason"]));
   215: 			RegisterRoute(ModuleRoutes.GET_HOS_STATUS_ODO_RANGE, args => GetStatusOdometer(AuthToken, (long)args["siteId"], (Int64)args["entityId"], new DateTime(((DateTime)Context.Request.Query["date"]).Ticks, DateTimeKind.Unspecified)));
   216  			RegisterRoute(ModuleRoutes.GET_ASSET_ENGINE_HOURS_RANGE, args => GetAssetEngineHours(AuthToken, (long)args["siteId"], (Int64)args["entityId"], new DateTime(((DateTime)Context.Request.Query["date"]).Ticks, DateTimeKind.Unspecified)));

   262  							ModuleRoutes.GET_ENABLED_ORG_FEATURES.ToLinkCarrier("getEnabledOrgFeatures"),
   263: 							ModuleRoutes.GET_HOS_STATUS_ODO_RANGE.ToLinkCarrier("getHosStatusOdoRange"),
   264  							ModuleRoutes.GET_ASSET_ENGINE_HOURS_RANGE.ToLinkCarrier("getHosAssetEngineHoursRange"),

   445  			{
   446: 				hw.StartOdometer = decimal.Round(hw.StartOdometer, 1);
   447  				hw.EngineHours = decimal.Round(hw.EngineHours.GetValueOrDefault(), 1);

  1040  		}
  1041: 		internal GatewayResult<HosStatusOdoRangeCarrier> GetStatusOdometer(string authToken, long siteId, long assetId, DateTime dateTime)
  1042  		{

  1044  			{
  1045: 				return new GatewayResult<HosStatusOdoRangeCarrier>(GatewayResultStatus.Success, new HosStatusOdoRangeCarrier());
  1046  			}

  1049  			if (!GetOrganisationIdFromSiteId(authToken, siteId, out orgId))
  1050: 				return GatewayResult<HosStatusOdoRangeCarrier>.Error(GatewayResultStatus.InvalidRequest, Common.Constants.ErrorMessages.Timeline.COULD_NOT_DETERMINE_ORGANISATION_ID);
  1051  

  1056  
  1057: 			var odoRangeValue = HosDataManager.GetWorkstateOdometerRangeValueDatas(authToken, assetId, dateTime);
  1058: 			var odoRangeMaxvalue = new OdometerRangeValueData { OdometerMaxValue = odoRangeValue.OdometerMaxValue, OdometerUnits = odoRangeValue.OdometerUnits };
  1059: 			UnitsConverter.ConvertDistanceStandardToProfile(odoRangeValue, CurrentUserProfile, st => st.OdometerMinValue, st => st.OdometerUnits);
  1060: 			UnitsConverter.ConvertDistanceStandardToProfile(odoRangeMaxvalue, CurrentUserProfile, st => st.OdometerMaxValue, st => st.OdometerUnits);
  1061  
  1062: 			HosStatusOdoRangeCarrier carrier = new HosStatusOdoRangeCarrier();
  1063  			carrier.DefaultUnit = UnitsConverter.GetDistanceUnit(CurrentUserProfile);

  1068  
  1069: 			var tmpMinValue = (odoRangeValue != null) ? Math.Round(Convert.ToDouble(odoRangeValue.OdometerMinValue), 1) : minValue;
  1070: 			var tmpMaxValue = (odoRangeMaxvalue != null && odoRangeMaxvalue.OdometerMaxValue > 0) ? Math.Round(Convert.ToDouble(odoRangeMaxvalue.OdometerMaxValue), 1) : maxValue;
  1071  

  1080  
  1081: 			return new GatewayResult<HosStatusOdoRangeCarrier>(GatewayResultStatus.Success, carrier);
  1082  		}

  1149  
  1150: 				//TODO: what happens when the coordinate covers more than one location?
  1151  				var location = locations.FirstOrDefault();

  1153  				{
  1154: 					//TODO: should return the flag that states that I used reverse geo
  1155  					var mapSettings = OrganisationRepository.GetOrganisationMapSettings(orgId);

  1241  
  1242: 		//TODO: find a central location for this method and reuse in TrackingModuleBase
  1243  		protected LocationCrudCarrier GetLocationCrudCarrier(string authToken, long organisationId /*, long groupId, long? locationId = null*/)

  1266  
  1267: 		//TODO: find a central location for this method and reuse in TrackingModuleBase
  1268  		protected MapSettingsCarrier GetMapSettings(string authToken, long organisationId, bool includeCountriesAndLanguages)

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Timeline\TimelineModule.cs:
  301  			var hasVideoPermissions = AuthorisationManager.Authorise(authToken, Common.Timeline.Permissions.CAN_ACCESS_TRIP_VIDEOS, EntityTypes.ASSET, assetId);
  302: 			var hasVideoDevice = true; // TODO: get device availability on asset.
  303  

  713  			{
  714: 				UnitsConverter.ConvertProperties(td, CurrentUser.Profile, t => t.Odometer, t => t.OdometerUnits);
  715  				UnitsConverter.ConvertProperties(td, CurrentUser.Profile, t => t.TripDistance, t => t.TripDistanceUnits);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Timeline\TimelineModuleBase.cs:
   312  			DoHosStatusDataConversion(hosStatusData);
   313: 			hosStatusData?.ForEach(hw => { hw.StartOdometer = Decimal.Round(hw.StartOdometer, 1); hw.EngineHours = Decimal.Round(hw.EngineHours.GetValueOrDefault(), 1); });
   314  			var libraryEvents = LibraryCapabilityManager.GetAllLibraryEventsIncludingServerSide(authToken, orgId).ToList();

   403  				{
   404: 					//todo: convert fromDateTime to site timezone and make it zoned datetime.
   405  					writer.Write(textToExport);

   457  			{
   458: 				UnitsConverter.ConvertProperties(trip, CurrentUser.Profile, t => t.Odometer, t => t.OdometerUnits);
   459  				UnitsConverter.ConvertProperties(trip, CurrentUser.Profile, t => t.TripDistance, t => t.TripDistanceUnits);

   474  			{
   475: 				UnitsConverter.ConvertProperties(d, CurrentUserProfile, o => o.StartOdometer, o => o.StartOdometerUnits);
   476  				UnitsConverter.ConvertProperties(d, CurrentUserProfile, o => o.Distance, o => o.DistanceUnits);

   738  
   739: 			// TODO: Should change this to GroupId instead of OrganisationId.
   740: 			// TODO: Should this be the organisation ID or the ID of the site?
   741  			carrier.OrganisationId = group.GroupId.ToString();

  1099  
  1100: 			//TODO: Cater here for ambiguous times too
  1101  			if (storageTimeZoneInfo.IsInvalidTime(fromDate))

  1143  
  1144: 			//TODO: Cater here for ambiguous times too
  1145  			if (siteTimeZoneInfo.IsInvalidTime(fromDate))

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Timeline\TripTimelineModule.cs:
  108  		{
  109: 			DataScheduleManager.RequestCurrentStatus(authToken, orgId, assetId, TripsEventsDownloadTypes.Quick, CurrentUserProfile.GetFullName(), TachoDownloadType.Quick);
  110  			return new VoidGatewayResult(GatewayResultStatus.Success);

  587  							break;
  588: 						case InputLineType.Odometer:
  589: 							tuple = ConfigAdminConverters.ConvertValue(interval.Odometer.ToString(), line.FormatType.GetValueOrDefault(), line.Units, userMeasurementType);
  590: 							interval.Odometer = tuple.Item1.ToDecimal();
  591  							break;

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Tracking\HistoricalTrackingModule.cs:
   376  		{
   377: 			//TODO: Have 1 authorise call for all the permissions needed on carrier
   378  			HistoricalTrackingPageCarrier carrier = new HistoricalTrackingPageCarrier();

   428  			var groupIds = new List<long> { groupId };
   429: 			// TODO: Remove this once it's verified in production
   430  			if (!FeatureHelper.FeatureEnabled(UIFeatures.FleetServicesLocationsAuth))

  1180  			Group org = OrganisationGroupManager.GetOrganisationGroupForEntity(groupId, EntityTypes.GROUP); // the groupId could be site, need to make sure we get the orgId for the location call
  1181: 			var positionDictionary = tasks.ToDictionary(t => t.DynamixId.ToLong(), t => new Coordinate(Convert.ToDouble(t.CapturedLongitude), Convert.ToDouble(t.CapturedLatitude)));
  1182  			List<MapLocationLookup> positionLocations = MapLocationManager.GetMapLocationsForCoordinates(authToken, org.GroupId, positionDictionary);

  1187  				.FindAll(t => !positionLocations.Select(l => l.Id).Contains(t.DynamixId.ToLong()))
  1188: 				.ToDictionary(t => t.DynamixId.ToLong(), t => new Coordinate(Convert.ToDouble(t.CapturedLongitude), Convert.ToDouble(t.CapturedLatitude)));
  1189  			if (positionsDict.Count > 0)

  1204  				TaskGPSReading point = new TaskGPSReading();
  1205: 				point.Position = new Coordinate(Convert.ToDouble(tasks[i].CapturedLongitude), Convert.ToDouble(tasks[i].CapturedLatitude));
  1206  				point.TaskId = long.Parse(tasks[i].DynamixId);

  1243  						.Where(w => !positionLocations.Select(l => l.Id).Contains(w.DriverId))
  1244: 						.ToDictionary(w => w.DriverId, w => new Coordinate(Convert.ToDouble(w.Position.Longitude), Convert.ToDouble(w.Position.Latitude)));
  1245  					if (positionsDict.Any())

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Tracking\LiveTrackingModule.cs:
   895  								{
   896: 									double speed = Convert.ToDouble(lastEvent.Speed);
   897  									item.LastActiveEvent.Value = TimelineConverter.GetEventDisplay(authToken, CurrentUserProfile, speed, libraryEvent, org.GroupId, out _, CorrelationId, AssetsManager.GetTrailerDescriptionByFmTrailerUnitId, false);

  1384  							{
  1385: 								double speed = Convert.ToDouble(lastEvent.Speed);
  1386  								carrier.LastActiveEvent.Value = TimelineConverter.GetEventDisplay(authToken, CurrentUserProfile, speed, libraryEvent, org.GroupId, out unitLastActiveEvent, CorrelationId, AssetsManager.GetTrailerDescriptionByFmTrailerUnitId, false);

  1914  		{
  1915: 			//TODO: Use token to validate request
  1916  

DynaMiX.Backend\API\DynaMiX.API\NancyModules\UserManagement\SecurityGroups\SecurityGroupsModule.cs:
  577  
  578: 				//todo jm: remove this, needs FE work too.
  579  				var userSgMemberships = userSgParents.FindAll(m => m.EntityId == user.Account.AccountId);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\UserManagement\Users\UserAccountModule.cs:
   95  				{
   96: 					//TODO RS: Permissions?
   97  					UserSettingsTabs.ADVANCED_SCORING,

  134  
  135: 			// TODO: this should be ordered somehow.
  136  

DynaMiX.Backend\API\DynaMiX.API\NancyModules\UserManagement\Users\UserAdminModule.cs:
   863  
   864: 			// TODO: Will need to call the MFA endpoint to reset MFA, to be done in a future story
   865  

  1129  
  1130: 			form.CanResetMultifactorAuthentication = true; // TODO: Add logic to check if MFA has been setup, most likely a not null check on a column. To be done in a future story
  1131  			if (form.IsMultifactorAuthenticationEnabled == false) // Temporary logic to disable reset functionality when MFA is disabled

DynaMiX.Backend\API\DynaMiX.API\UIModules\ConfigAdmin.cs:
  138  				new UIModuleHyperMediaLink(CommsLogModule.ModuleRoutes.GetCommsLogEH.ToLinkCarrier("getCommsLogEnginehours"), DynaMiX.Common.Scheduler.Permissions.SCHEDULER_ACCESS_DOWNLOAD_DATA),
  139: 			  new UIModuleHyperMediaLink(CommsLogModule.ModuleRoutes.GetCommsLogOdometer.ToLinkCarrier("getCommsLogOdometer"), DynaMiX.Common.Scheduler.Permissions.SCHEDULER_ACCESS_DOWNLOAD_DATA),
  140  				

DynaMiX.Backend\API\DynaMiX.API\UIModules\DTCODownloadManagement.cs:
   1  using System.Collections.Generic;
   2: using DynaMiX.Api.NancyModules.DTCODownloadManagement;
   3: using DynaMiX.Api.NancyModules.DTCODownloadManagement.CompanyCards;
   4  using DynaMiX.Api.NancyModules.Operations.DatabaseAdmin;
   5: using DynaMiX.Common.DTCODownloadManagement;
   6  using DynaMiX.Core.Extensions.Enum;

  11  {
  12: 	public class DTCODownloadManagement : UIModule
  13  	{
  14: 		public const string ID = "dtcoDownloadManager";
  15  
  16: 		public DTCODownloadManagement()
  17  		{

  30  					{
  31: 						new UIModuleMenuLink{ Name = "Settings", Href = APISettings.Current.DTCODownloadManagerBaseUrl + "/settings", AccessPermissionId = Permissions.CAN_ACCESS_SETTINGS },
  32: 						new UIModuleMenuLink{ Name = "Company cards", Href = APISettings.Current.DTCODownloadManagerBaseUrl + "/company-cards", AccessPermissionId = Permissions.CAN_ACCESS_COMPANY_CARDS },
  33: 						new UIModuleMenuLink{ Name = "Remote task management", Href = APISettings.Current.DTCODownloadManagerBaseUrl + "/remote-task-management", AccessPermissionId = Permissions.CAN_ACCESS_REMOTE_TASK_MANAGEMENT },
  34: 						new UIModuleMenuLink{ Name = "DTCO files", Href = APISettings.Current.DTCODownloadManagerBaseUrl + "/files", AccessPermissionId = Permissions.CAN_ACCESS_DTCO_FILES },
  35  					}

  42  				{
  43: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_ORGANISATION_LIST.ToLinkCarrier("getOrganisationList"), (long)Permissions.CAN_ACCESS_DTCO_DOWNLOAD_MODULE),
  44: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_ORGANISATION_SITE_LIST.ToLinkCarrier("getOrganisationSiteList"), (long)Permissions.CAN_ACCESS_DTCO_DOWNLOAD_MODULE),
  45  
  46: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_SETTINGS_PAGE.ToLinkCarrier("getSettingsPage"), (long)Permissions.CAN_ACCESS_SETTINGS),
  47: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_COMPANY_CARDS_PAGE.ToLinkCarrier("getCompanyCardsPage"), (long)Permissions.CAN_ACCESS_COMPANY_CARDS),
  48: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_REMOTE_TASK_MANAGEMENT_PAGE.ToLinkCarrier("getRemoteTaskManagementPage"), (long)Permissions.CAN_ACCESS_REMOTE_TASK_MANAGEMENT),
  49: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_DTCO_FILES_PAGE.ToLinkCarrier("getDTCOFilesPage"), (long)Permissions.CAN_ACCESS_DTCO_FILES),
  50: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.POST_DTCO_FILES_ZIPPED.ToLinkCarrier("getDTCOFilesZipped"), (long)Permissions.CAN_ACCESS_DTCO_FILES),
  51: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_ORGANISATION_DTCO_ENABLED.ToLinkCarrier("getOrganisationDtcoEnabled"), (long)Permissions.CAN_ACCESS_DTCO_DOWNLOAD_MODULE),
  52  					new UIModuleHyperMediaLink(DTCOArchiveSettingsModule.ModuleRoutes.GET_DTCO_GROUP_LIST.ToLinkCarrier("getArchiveSettingsPage"), Permissions.CAN_ACCESS_DTCO_ARCHIVE_SETTINGS),
  53: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_SETTINGS_DOWNLOAD_SERVICE_PAGE.ToLinkCarrier("getSettingsDownloadServicePage"), (long)Permissions.CAN_ACCESS_SETTINGS),
  54: 					new UIModuleHyperMediaLink(DTCODownloadManagementModule.ModuleRoutes.GET_SETTINGS_SCHEDULE_FREQUENCY.ToLinkCarrier("getSettingsScheduleFrequency"), (long)Permissions.CAN_ACCESS_SETTINGS),
  55  					new UIModuleHyperMediaLink(DTCOCompanyCardDetailsModule.ModuleRoutes.GET_DTCO_GROUP_LIST.ToLinkCarrier("getCompanyCardDetailsTemplate"), (long)Permissions.CAN_UPDATE_COMPANY_CARDS),
  56: 					new UIModuleHyperMediaLink(DTCODownloadTaskDetailsModule.ModuleRoutes.GET_DOWNLOAD_TASK_DETAILS_TEMPLATE.ToLinkCarrier("getDownloadTaskDetailsTemplate"), (long)Permissions.CAN_CREATE_REMOTE_TASK_MANAGEMENT),
  57: 					new UIModuleHyperMediaLink(DTCODownloadTaskDetailsModule.ModuleRoutes.GET_DOWNLOAD_TASK_DETAILS.ToLinkCarrier("getDownloadTaskDetails"), (long)Permissions.CAN_UPDATE_REMOTE_TASK_MANAGEMENT),
  58  				};

DynaMiX.Backend\API\DynaMiX.API\UIModules\FleetAdmin.cs:
   59  
   60: 			// TODO: remove these lines and uncomment the server-side events menu item above - ONLY WHEN lightning server side events has been deployed to all environments
   61  			if (CommonSettings.Current.ServerSideEventUrl.IsNotNullOrEmpty())

   85  
   86: 				//TODO: MR: Add unique diagnostics modal endpoint for each mobile device type
   87: 				//TODO: MR: Decide if all this should move to ConfigAdmin, problem will be permission dependencies
   88  				new UIModuleHyperMediaLink(DiagnosticsModule.ModuleRoutes.GetDiagnosticsAsset.ToLinkCarrier("getDiagnosticsAsset"), Permissions.CAN_ACCESS_DIAGNOSTICS),

  118  				new UIModuleHyperMediaLink(AssetMeterReadingsModule.ModuleRoutes.GET_METER_READINGS.ToLinkCarrier("getAssetMeterReadings"), Permissions.CAN_ACCESS_ASSET_METER_READINGS),
  119: 				new UIModuleHyperMediaLink(AssetMeterReadingsModule.ModuleRoutes.GET_ODOMETER_CONVERSIONS.ToLinkCarrier("getOdometerConversions"), Permissions.CAN_ACCESS_ASSET_METER_READINGS),
  120  

DynaMiX.Backend\API\DynaMiX.API\Utilities\FileUpload\FileUploader.cs:
  111  
  112: 			//todo: smarter detection of file type
  113  			if (extension == fileName) //no extension provided. default to jpg

DynaMiX.Backend\API\DynaMiX.API\Utilities\SelectionCriteria\GroupTrees.cs:
   20  using DynaMiX.Logic.BaseApp.Authorisation;
   21: using DynaMiX.Logic.DTCODownloadManagement;
   22  using DynaMiX.Logic.FleetAdmin;

  109  		}
  110: 		private IDTCODownloadManagementManager _dddManager;
  111  
  112: 		public IDTCODownloadManagementManager DddManager
  113  		{
  114: 			get { return _dddManager ?? (_dddManager = DependencyResolver.GetInstance<IDTCODownloadManagementManager>()); }
  115  			set { _dddManager = value; }

DynaMiX.Backend\API\DynaMiX.API\Utilities\Tracking\xLocationCsvImporter.cs:
   81  
   82: 						double radius = Convert.ToDouble(fieldArray[fieldCounter++]);
   83  

  226  
  227: 			// TODO: Not sure what you would want to do with polygon holes.
  228  			//       I assume that the intention is not to support holes and

  246  
  247: 				// TODO: Not sure what you would want to do with polygon holes.
  248  				//       I assume that the intention is not to support holes and

DynaMiX.Backend\API\DynaMiX.API.Test\Converters\TreeConverterTests.cs:
  12  
  13: //todo jm move to new test class
  14  //namespace DynaMiX.Api.Test.Converters

DynaMiX.Backend\API\DynaMiX.API.Test\Converters\ConfigAdmin\EventCarrierConversionExtensionsTests.cs:
  103  					{
  104: 						ActionSettings = "<settings recordtype=\"2\" startOdometer=\"0\" startPosition=\"0\" endOdometer=\"0\" endPosition=\"0\" pulse=\"0\" video=\"0\" />"
  105  					};

  111  			Assert.AreEqual(action.IsEnabled, carrier.IsEnabled);
  112: 			Assert.AreEqual(action.StartOdometer, carrier.StartOdometer);
  113: 			Assert.AreEqual(action.EndOdometer, carrier.EndOdometer);
  114  			Assert.AreEqual(action.StartPosition, carrier.StartPosition);

  233  					Delay = 349,
  234: 					StartOdometer = true,
  235  					StartPosition = true,
  236  					RecordVideo = false,
  237: 					EndOdometer = true,
  238  					EndPosition = true,

  248  			Assert.AreEqual(carrier.Delay, entity.Delay);
  249: 			Assert.AreEqual(carrier.StartOdometer, entity.StartOdometer);
  250  			Assert.AreEqual(carrier.StartPosition, entity.StartPosition);
  251  			Assert.AreEqual(carrier.RecordVideo, entity.RecordVideo);
  252: 			Assert.AreEqual(carrier.EndOdometer, entity.EndOdometer);
  253  			Assert.AreEqual(carrier.EndPosition, entity.EndPosition);

DynaMiX.Backend\API\DynaMiX.API.Test\Converters\ConfigAdmin\TemplateEventCarrierConversionExtensionsTests.cs:
   22  					{
   23: 						ActionSettings = "<settings recordtype=\"2\" startOdometer=\"0\" startPosition=\"0\" endOdometer=\"0\" endPosition=\"0\" pulse=\"0\" video=\"0\" />"
   24  					};

   30  			Assert.AreEqual(action.IsEnabled, carrier.IsEnabled);
   31: 			Assert.AreEqual(action.StartOdometer, carrier.StartOdometer);
   32: 			Assert.AreEqual(action.EndOdometer, carrier.EndOdometer);
   33  			Assert.AreEqual(action.StartPosition, carrier.StartPosition);

  184  					Delay = 349,
  185: 					StartOdometer = true,
  186  					StartPosition = true,
  187  					RecordVideo = false,
  188: 					EndOdometer = true,
  189  					EndPosition = true,

  199  			Assert.AreEqual(carrier.Delay, entity.Delay);
  200: 			Assert.AreEqual(carrier.StartOdometer, entity.StartOdometer);
  201  			Assert.AreEqual(carrier.StartPosition, entity.StartPosition);
  202  			Assert.AreEqual(carrier.RecordVideo, entity.RecordVideo);
  203: 			Assert.AreEqual(carrier.EndOdometer, entity.EndOdometer);
  204  			Assert.AreEqual(carrier.EndPosition, entity.EndPosition);

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\ConfigAdmin\PlugManagement\PlugManagmentModuleTests.cs:
  235  					var asset2 = new AssetSummary { AssetId = 1111, Description = "TestAsset", RegistrationNumber = "12345", EngineHours = new TimeSpan(5, 40, 0) };
  236: 					var asset3 = new AssetSummary { AssetId = 1111, Description = "TestAsset", RegistrationNumber = "12345", Odometer = 12345, OdometerUnits = "km" };
  237  					assetSummaries.Add(asset1);

  251  			Assert.AreEqual(6, result.Value.Assets[1].EngineHours);
  252: 			Assert.AreEqual(12345.0, result.Value.Assets[2].Odometer);
  253  

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\DTCODownloadManagement\DTCOArchiveSettingsModuleTest.cs:
   1: using DynaMiX.Api.Carriers.DTCODownloadManagement;
   2: using DynaMiX.Api.NancyModules.DTCODownloadManagement;
   3: using DynaMiX.Entities.DTCODownloadManagement;
   4  using DynaMiX.Logic.BaseApp.Authorisation;
   5: using DynaMiX.Logic.DTCODownloadManagement;
   6  using Moq;

   8  
   9: namespace DynaMiX.Api.Test.NancyModules.DTCODownloadManagement
  10  {

  14  		private Mock<IAuthorisationManager> _authorisationManager;
  15: 		private Mock<IDTCODownloadManagementManager> _downloadManagementManager;
  16  

  25  
  26: 			_downloadManagementManager = new Mock<IDTCODownloadManagementManager>(MockBehavior.Strict);
  27: 			_module.DTCODownloadManagementManager = _downloadManagementManager.Object;
  28  			_downloadManagementManager.Setup(x => x.GetDtcoArchiveSettings(It.IsAny<string>(), It.IsAny<long>())).Returns(new DTCOArchiveSettings());

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\DTCODownloadManagement\DTCODownloadManagementModuleTests.cs:
   2  using System.Linq;
   3: using DynaMiX.Api.Carriers.DTCODownloadManagement;
   4: using DynaMiX.Api.NancyModules.DTCODownloadManagement;
   5: using DynaMiX.Entities.DTCODownloadManagement;
   6  using DynaMiX.Entities.Users;
   7  using DynaMiX.Logic.BaseApp.Authorisation;
   8: using DynaMiX.Logic.DTCODownloadManagement;
   9  using Moq;

  11  
  12: namespace DynaMiX.Api.Test.NancyModules.DTCODownloadManagement
  13  {
  14  	[TestFixture]
  15: 	internal class DTCODownloadManagementModuleTests
  16  	{
  17: 		private DTCODownloadManagementModule _module;
  18  		private Mock<IAuthorisationManager> _authorisationManager;
  19: 		private Mock<IDTCODownloadManagementManager> _settingsManager;
  20  

  23  		{
  24: 			_module = new DTCODownloadManagementModule();
  25  

  28  
  29: 			_settingsManager = new Mock<IDTCODownloadManagementManager>(MockBehavior.Strict);
  30  			_module.DddManager = _settingsManager.Object;

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\DTCODownloadManagement\DTCODownloadTaskDetailsModuleTests.cs:
    5  using DynaMiX.Api.Carriers.Common;
    6: using DynaMiX.Api.Carriers.DTCODownloadManagement;
    7  using DynaMiX.Api.Converters;
    8: using DynaMiX.Api.NancyModules.DTCODownloadManagement;
    9  using DynaMiX.Common.Groups.Constants;

   11  using DynaMiX.Core.TimeZones;
   12: using DynaMiX.Entities.DTCODownloadManagement;
   13  using DynaMiX.Entities.FleetAdmin.Assets;

   15  using DynaMiX.Logic.BaseApp.Authorisation;
   16: using DynaMiX.Logic.DTCODownloadManagement;
   17  using DynaMiX.Logic.FleetAdmin;

   24  
   25: namespace DynaMiX.Api.Test.NancyModules.DTCODownloadManagement
   26  {
   27  	[TestFixture]
   28: 	class DTCODownloadTaskDetailsModuleTests
   29  	{
   30: 		private DTCODownloadTaskDetailsModule _module;
   31: 		private Mock<IDTCODownloadManagementManager> _downloadManagementManager;
   32  		private Mock<IOrganisationManager> _mockOrganisationManager;

   57  		{
   58: 			_module = new DTCODownloadTaskDetailsModule();
   59  
   60: 			_downloadManagementManager = new Mock<IDTCODownloadManagementManager>(MockBehavior.Strict);
   61: 			_module.DTCODownloadManagementManager = _downloadManagementManager.Object;
   62  

  153  					{
  154: 						DTCODownloadData = new DTCODownloadData(),
  155  						DownloadTaskId = 1,

  189  
  190: 			var downloadData = new DTCODownloadDataCarrier()
  191  			{

  274  			{
  275: 				DTCODownloadData = new DTCODownloadData(),
  276  				DownloadTaskId = 1,

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\DTCODownloadManagement\CompanyCards\DTCOCompanyCardDetailsModuleTest.cs:
   6  using DynaMiX.Api.Carriers.Common;
   7: using DynaMiX.Api.Carriers.DTCODownloadManagement;
   8: using DynaMiX.Api.NancyModules.DTCODownloadManagement.CompanyCards;
   9  using DynaMiX.Core.Gateway;
  10  using DynaMiX.Core.Runtime.Resolver;
  11: using DynaMiX.Entities.DTCODownloadManagement;
  12: using DynaMiX.Logic.DTCODownloadManagement;
  13  using DynaMiX.Logic.Operations;

  16  
  17: namespace DynaMiX.Api.Test.NancyModules.DTCODownloadManagement.CompanyCards
  18  {

  21  		private DTCOCompanyCardDetailsModule _module;
  22: 		private Mock<IDTCODownloadManagementManager> _downloadManagementManager;
  23  		private Mock<IOrganisationManager> _mockOrganisationManager;

  29  
  30: 			_downloadManagementManager = new Mock<IDTCODownloadManagementManager>(MockBehavior.Strict);
  31: 			_module.DTCODownloadManagementManager = _downloadManagementManager.Object;
  32  

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\FleetAdmin\Assets\AssetCommissioningModuleTests.cs:
  155  		[Test]
  156: 		public void SetOdometer_Do()
  157  		{
  158  			//Arrange
  159: 			_trackAndTraceMobileUnitManagerMock.Setup(x => x.SetOdometer(AUTH_TOKEN, 1, 22, 1, true));
  160  			//Act
  161: 			var result = _module.SetOdometer(AUTH_TOKEN, 1, 22, new AssetOdometerFormCarrier() { Odometer = new DistanceCarrier() { Value = 1 } });
  162  			//Assert

  223  			Assert.AreEqual(result.Value.RemoveMobileDeviceTemplate.HyperMedia.Validations.ValidationRules.Count, 0);
  224: 			Assert.IsNull(result.Value.SetOdoTemplate);
  225  			Assert.That(result.Value.Form.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));

  354  			Assert.AreEqual(result.Value.RemoveMobileDeviceTemplate.HyperMedia.Validations.ValidationRules.Count, 0);
  355: 			Assert.IsNull(result.Value.SetOdoTemplate);
  356  			Assert.That(result.Value.Form.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));

  493  			Assert.AreEqual(result.Value.RemoveMobileDeviceTemplate.HyperMedia.Validations.ValidationRules.Count, 0);
  494: 			Assert.IsNull(result.Value.SetOdoTemplate);
  495  			Assert.That(result.Value.Form.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));

  556  			Assert.AreEqual(result.Value.RemoveMobileDeviceTemplate.HyperMedia.Validations.ValidationRules.Count, 0);
  557: 			Assert.IsNull(result.Value.SetOdoTemplate);
  558  			Assert.That(result.Value.Form.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));

  621  			Assert.AreEqual(result.Value.RemoveMobileDeviceTemplate.HyperMedia.Validations.ValidationRules.Count, 0);
  622: 			Assert.IsNull(result.Value.SetOdoTemplate);
  623  			Assert.That(result.Value.Form.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));

  757  			Assert.AreEqual(result.Value.RemoveMobileDeviceTemplate.HyperMedia.Validations.ValidationRules.Count, 0);
  758: 			Assert.That(result.Value.SetOdoTemplate.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));
  759: 			Assert.AreEqual(result.Value.SetOdoTemplate.HyperMedia.Validations.ValidationRules.Count, 1);
  760: 			Assert.AreEqual(result.Value.SetOdoTemplate.HyperMedia.Validations.FormName, "setOdoForm");
  761: 			Assert.AreEqual(result.Value.SetOdoTemplate.UsesOnboardOffsets, false );
  762  			Assert.That(result.Value.Form.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));

  820  			Assert.AreEqual(result.Value.RemoveMobileDeviceTemplate.HyperMedia.Validations.ValidationRules.Count, 0);
  821: 			Assert.IsNull(result.Value.SetOdoTemplate);
  822  			Assert.That(result.Value.Form.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));

  882  			Assert.AreEqual(result.Value.RemoveMobileDeviceTemplate.HyperMedia.Validations.ValidationRules.Count, 0);
  883: 			Assert.IsNull(result.Value.SetOdoTemplate);
  884  			Assert.That(result.Value.Form.HyperMedia.Links.ContainsLink("save", DynaMiX.Core.Http.Constants.HTTPVerbs.PUT));

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\FleetAdmin\Assets\AssetFuelImportExportModuleTests.cs:
  184  				{
  185: 					Odometer = 100,
  186  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  187  					BaseCost = 1,
  188: 					OdometerUnit = "Kilometres",
  189  					RegistrationNumber = "DynaMiX GP",

  231  				{
  232: 					Odometer = 100,
  233  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  234  					BaseCost = 1,
  235: 					OdometerUnit = "Kilometres",
  236  					RegistrationNumber = "DynaMiX GP",

  275  				{
  276: 					Odometer = 100,
  277  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  278  					BaseCost = 1,
  279: 					OdometerUnit = "Kilometres",
  280  					RegistrationNumber = "DynaMiX GP",

  319  				{
  320: 					Odometer = 100,
  321  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  322: 					OdometerUnit = "Kilometres",
  323  					RegistrationNumber = "DynaMiX GP",

  361  				{
  362: 					Odometer = 100,
  363  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  364  					BaseCost = 1,
  365: 					OdometerUnit = "Kilometres",
  366  					RegistrationNumber = "DynaMiX GP",

  404  				{
  405: 					Odometer = 100,
  406  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  407  					BaseCost = 1,
  408: 					OdometerUnit = "Kilometres",
  409  					RegistrationNumber = "DynaMiX GP",

  417  				{
  418: 					Odometer = 100,
  419  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  420  					BaseCost = 1,
  421: 					OdometerUnit = "Kilometres",
  422  					RegistrationNumber = "DynaMiX GP",

  447  		[Test]
  448: 		public void CheckIfOdometerValueIsCorrect()
  449  		{

  458  				{
  459: 					Odometer = 100,
  460  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  461  					BaseCost = 1,
  462: 					OdometerUnit = "Kilometres",
  463  					RegistrationNumber = "DynaMiX GP",

  471  				{
  472: 					Odometer = 50,
  473  					DateAndTime = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd HH:mm:ss"),
  474  					BaseCost = 1,
  475: 					OdometerUnit = "Kilometres",
  476  					RegistrationNumber = "DynaMiX GP",

  496  			VerifyMocks();
  497: 			var cannotBeLessThanOlderTransaction = result.Value.Messages.Any(x => x.Message == ErrorMessages.FuelImport.ODOMETER_MUST_BE_GREATER);
  498: 			var cannotBeMoreThanYoungerTransaction = result.Value.Messages.Any(x => x.Message == ErrorMessages.FuelImport.ODOMETER_MUST_BE_LESS);
  499  			Assert.AreEqual(true, cannotBeLessThanOlderTransaction);

  513  				{
  514: 					Odometer = 100,
  515  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  516  					BaseCost = 1,
  517: 					OdometerUnit = "Kilometres",
  518  					RegistrationNumber = "DynaMiX GP",

  527  				{
  528: 					Odometer = 100,
  529  					DateAndTime = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd HH:mm:ss"),
  530  					BaseCost = 1,
  531: 					OdometerUnit = "Kilometres",
  532  					RegistrationNumber = "DynaMiX GP",

  571  				{
  572: 					Odometer = 100,
  573  					DateAndTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
  574  					BaseCost = 1,
  575: 					OdometerUnit = "Kilometres",
  576  					RegistrationNumber = "DynaMiX GP",

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\FleetAdmin\Assets\AssetFuelUsageModuleTests.cs:
  157  			Date = new ZonedDateTime(DateTime.UtcNow, TimeZoneInfo.Utc).ToCarrier(),
  158: 			Odometer = new DistanceCarrier { Unit = Unit.Kilometres, Value = 400 },
  159  			Volume = new VolumeCarrier { Unit = Unit.Litres, Value = 45 },

  218  			Assert.AreEqual(result.Value.BaseCurrencyUnit, "ZAR");
  219: 			Assert.AreEqual(result.Value.OdometerUnit, Unit.Kilometres);
  220  			Assert.AreEqual(result.Value.VolumeUnit, Unit.Litres);

  277  			Assert.AreEqual(result.Value.BaseCurrencyUnit, "ZAR");
  278: 			Assert.AreEqual(result.Value.OdometerUnit, Unit.Kilometres);
  279  			Assert.AreEqual(result.Value.VolumeUnit, Unit.Litres);

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\FleetAdmin\Assets\AssetServiceHistoryModuleTests.cs:
  142  			ServiceDate = new ZonedDateTime(DateTime.UtcNow, TimeZoneInfo.Utc).ToCarrier(),
  143: 			Odometer = new DistanceCarrier { Unit = Unit.Kilometres, Value = 400 },
  144  			TransactionAmount = new MoneyCarrier { Unit = "KWD", Value = 25 },

  183  			Assert.AreEqual(result.Value.BaseCurrencyUnit, "ZAR");
  184: 			Assert.AreEqual(result.Value.OdometerUnit, Unit.Kilometres);
  185  			Assert.IsTrue(result.Value.ServiceHistory.All(f => f.Actions.Count == 2));

  221  			Assert.AreEqual(result.Value.BaseCurrencyUnit, "ZAR");
  222: 			Assert.AreEqual(result.Value.OdometerUnit, Unit.Kilometres);
  223  			Assert.IsTrue(result.Value.ServiceHistory.All(f => !f.Actions.Contains("Remove")));

  465  			AssetServiceHistoryCarrier carrier = new AssetServiceHistoryCarrier();
  466: 			carrier.Odometer.Value = 123;
  467: 			carrier.Odometer.Unit = Unit.Kilometres;
  468  

  473  
  474: 			carrier.NextOdometer = new DistanceCarrier();
  475: 			carrier.NextOdometer.Value = 1234;
  476: 			carrier.NextOdometer.Unit = Unit.Kilometres;
  477  

  560  			AssetServiceHistoryCarrier carrier = new AssetServiceHistoryCarrier();
  561: 			carrier.Odometer.Value = 123;
  562: 			carrier.Odometer.Unit = Unit.Kilometres;
  563  

  568  
  569: 			carrier.NextOdometer = new DistanceCarrier();
  570: 			carrier.NextOdometer.Value = 1234;
  571: 			carrier.NextOdometer.Unit = Unit.Kilometres;
  572  

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\Scheduler\DownloadScheduleDetailsModuleTests.cs:
  191  				StartDate = ZonedDateTime.UtcNow,
  192: 				TachoDownloadType = TachoDownloadType.None
  193  			};

  401  				StartDate = ZonedDateTime.UtcNow,
  402: 				TachoDownloadType = TachoDownloadType.None
  403  			};

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\Scheduler\UploadScheduleDetailsModuleTests.cs:
   375  				DisarmDriverId = 5,
   376: 				SetOdoKmValue = 500,
   377  				SetEngineHoursValue = TimeSpan.FromHours(500),

   420  			Assert.IsFalse(form.UploadInTrip);
   421: 			Assert.IsNull(form.ActionsOdometer);
   422  			Assert.IsNull(form.ActionsEngineHours);

   647  				DisarmDriverId = 5,
   648: 				SetOdoKmValue = 500,
   649  				SetEngineHoursValue = TimeSpan.FromHours(500),

   731  				DisarmDriverId = 5,
   732: 				SetOdoKmValue = 500,
   733  				SetEngineHoursValue = TimeSpan.FromHours(500),

   799  				DisarmDriverId = 5,
   800: 				SetOdoKmValue = 500,
   801  				SetEngineHoursValue = TimeSpan.FromHours(500),

   867  				DisarmDriverId = 5,
   868: 				SetOdoKmValue = 500,
   869  				SetEngineHoursValue = TimeSpan.FromHours(500),

   943  				DisarmDriverId = 5,
   944: 				SetOdoKmValue = 500,
   945  				SetEngineHoursValue = TimeSpan.FromHours(500),

  1011  				DisarmDriverId = 5,
  1012: 				SetOdoKmValue = 500,
  1013  				SetEngineHoursValue = TimeSpan.FromHours(500),

  1073  				DisarmDriverId = 5,
  1074: 				SetOdoKmValue = 500,
  1075  				SetEngineHoursValue = TimeSpan.FromHours(500),

  1140  				DisarmDriverId = 5,
  1141: 				SetOdoKmValue = 500,
  1142  				SetEngineHoursValue = TimeSpan.FromHours(500),

  1207  				DisarmDriverId = 5,
  1208: 				SetOdoKmValue = 500,
  1209  				SetEngineHoursValue = TimeSpan.FromHours(500),

  1294  				{
  1295: 					Odometer = 55.5f,
  1296  					EngineHours = TimeSpan.FromHours(20)

  1334  
  1335: 			Assert.AreEqual(55.5.ToString(), result.Value.CurrentOdomenterDisplay[Unit.Kilometres]);
  1336  			//check both km and miles and meters are made available
  1337: 			Assert.AreEqual(3, result.Value.Form.ActionsOdometer.AvailableUnits.Count);
  1338: 			Assert.That(result.Value.Form.ActionsOdometer.AvailableUnits.Any(a => a.Value == Unit.Kilometres));
  1339: 			Assert.That(result.Value.Form.ActionsOdometer.AvailableUnits.Any(a => a.Value == Unit.Miles));
  1340: 			Assert.AreEqual(3, result.Value.CurrentOdomenterDisplay.Count);
  1341  

  1362  				DisarmDriverId = 5,
  1363: 				SetOdoKmValue = 500,
  1364  				SetEngineHoursValue = TimeSpan.FromHours(500),

  1382  			carrier.ActionsDriverId = 1.ToString();
  1383: 			carrier.ActionsOdometer = new DistanceCarrier
  1384  			{

  1407  						&& s.DisarmDriverId == carrier.ActionsDriverId.ToLong()
  1408: 						&& s.SetOdoKmValue == carrier.ActionsOdometer.Value.Value
  1409  						&& s.SetEngineHoursValue == TimeSpan.FromHours(carrier.ActionsEngineHours.Value)

  1451  				DisarmDriverId = 5,
  1452: 				SetOdoKmValue = 500,
  1453  				SetEngineHoursValue = TimeSpan.FromHours(500),

  1520  				DisarmDriverId = 5,
  1521: 				SetOdoKmValue = 500,
  1522  				SetEngineHoursValue = TimeSpan.FromHours(500),

  1540  			carrier.ActionsDriverId = 1.ToString();
  1541: 			carrier.ActionsOdometer = new DistanceCarrier
  1542  			{

  1566  						&& s.DisarmDriverId == carrier.ActionsDriverId.ToLong()
  1567: 						&& s.SetOdoKmValue == carrier.ActionsOdometer.Value.Value
  1568  						&& s.SetEngineHoursValue == TimeSpan.FromHours(carrier.ActionsEngineHours.Value)

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\Timeline\HOSTimelineModuleTests.cs:
  294  			Assert.IsTrue(links.ContainsLink("getHosEnabledFromOrg", Core.Http.Constants.HTTPVerbs.GET));
  295: 			Assert.IsTrue(links.ContainsLink("getHosStatusOdoRange", Core.Http.Constants.HTTPVerbs.GET));
  296  			Assert.IsTrue(links.ContainsLink("getStatusCarrier", Core.Http.Constants.HTTPVerbs.GET));

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\Timeline\TripTimelineModuleTests.cs:
  83  		const int NUMBER_TACHO = 10;
  84: ⟪ 489 characters skipped ⟫ype\",\"translate\":true,\"visible\":true},{\"title\":\"Mobile device\",\"field\":\"mobileDeviceType\",\"visible\":true},{\"title\":\"Last trip\",\"field\":\"lastTrip\",\"visible\":true},{\"title\":\"Odometer\",\"field\":\"odometer\",\"visible\":false,\"precision\":0},{\"title\":\"Engine hours\",\"field\":\"engineHours\",\"visible\":false},{\"title\":\"Site\",\"field\":\"site\",\"visible\":true},{\"title\":\"Status\",\"field\":\"currentState\",\"translate\":true,\"visible\":true},{\"title\":\"Fleet number\",\"field\":\"fleetNumber\",\"visible\":false},{\"title\":\"Last position\",\"field\":\"lastAvl\",\"visible\":false},{\"title\":\"Trip Status\",\"field\":\"tripStatus\",\"visible\":false},{\"field\":\"actions\",\"actions\":[{\"title\":\"Edit\",\"key\":\"Edit\",\"iconCssClass\":\"icon-edit icon-green\"},{\"title\":\"Duplicate\",\"key\":\"Duplicate\",\"iconCssClass\":\"icon-copy\"},{\"title\":\"Diagnostics\",\"key\":\"Diagnostics\",\"iconCssClass\":\"icon-statistics\"},{\"title\":\"Remove\",\"key\":\"Remove\",\"iconCssClass\":\"icon-remove-sign icon-red\"}],\"visible\":true},{\"title\":\"Config upload date \",\"field\":\"configUploadDate\",\"visible\":false},{\"title\":\"Configuration group\",\"field\":\"
  85  

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\Tracking\HistoricalTrackingModuleTests.cs:
   55  		private const string AUTH_TOKEN = "authtoken";
   56: ⟪ 489 characters skipped ⟫ype\",\"translate\":true,\"visible\":true},{\"title\":\"Mobile device\",\"field\":\"mobileDeviceType\",\"visible\":true},{\"title\":\"Last trip\",\"field\":\"lastTrip\",\"visible\":true},{\"title\":\"Odometer\",\"field\":\"odometer\",\"visible\":false,\"precision\":0},{\"title\":\"Engine hours\",\"field\":\"engineHours\",\"visible\":false},{\"title\":\"Site\",\"field\":\"site\",\"visible\":true},{\"title\":\"Status\",\"field\":\"currentState\",\"translate\":true,\"visible\":true},{\"title\":\"Fleet number\",\"field\":\"fleetNumber\",\"visible\":false},{\"title\":\"Last position\",\"field\":\"lastAvl\",\"visible\":false},{\"title\":\"Trip Status\",\"field\":\"tripStatus\",\"visible\":false},{\"field\":\"actions\",\"actions\":[{\"title\":\"Edit\",\"key\":\"Edit\",\"iconCssClass\":\"icon-edit icon-green\"},{\"title\":\"Duplicate\",\"key\":\"Duplicate\",\"iconCssClass\":\"icon-copy\"},{\"title\":\"Diagnostics\",\"key\":\"Diagnostics\",\"iconCssClass\":\"icon-statistics\"},{\"title\":\"Remove\",\"key\":\"Remove\",\"iconCssClass\":\"icon-remove-sign icon-red\"}],\"visible\":true},{\"title\":\"Config upload date \",\"field\":\"configUploadDate\",\"visible\":false},{\"title\":\"Configuration group\",\"field\":\"
   57  		private Mock<IAssetManager> _assetsManagerMock;

  708  			ZonedDateTime subEndDate = new ZonedDateTime(DateTime.Now.AddHours(8), TimeZoneInfo.Local);
  709: ⟪ 490 characters skipped ⟫ype\",\"translate\":true,\"visible\":true},{\"title\":\"Mobile device\",\"field\":\"mobileDeviceType\",\"visible\":true},{\"title\":\"Last trip\",\"field\":\"lastTrip\",\"visible\":true},{\"title\":\"Odometer\",\"field\":\"odometer\",\"visible\":false,\"precision\":0},{\"title\":\"Engine hours\",\"field\":\"engineHours\",\"visible\":false},{\"title\":\"Site\",\"field\":\"site\",\"visible\":true},{\"title\":\"Status\",\"field\":\"currentState\",\"translate\":true,\"visible\":true},{\"title\":\"Fleet number\",\"field\":\"fleetNumber\",\"visible\":false},{\"title\":\"Last position\",\"field\":\"lastAvl\",\"visible\":false},{\"title\":\"Trip Status\",\"field\":\"tripStatus\",\"visible\":false},{\"field\":\"actions\",\"actions\":[{\"title\":\"Edit\",\"key\":\"Edit\",\"iconCssClass\":\"icon-edit icon-green\"},{\"title\":\"Duplicate\",\"key\":\"Duplicate\",\"iconCssClass\":\"icon-copy\"},{\"title\":\"Diagnostics\",\"key\":\"Diagnostics\",\"iconCssClass\":\"icon-statistics\"},{\"title\":\"Remove\",\"key\":\"Remove\",\"iconCssClass\":\"icon-remove-sign icon-red\"}],\"visible\":true},{\"title\":\"Config upload date \",\"field\":\"configUploadDate\",\"visible\":false},{\"title\":\"Configuration group\",\"field\":\"
  710  			

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\Tracking\LiveTrackingModuleTests.cs:
  1664  				//.And(e => e.GeoPoint = new Coordinate(1, 1))
  1665: 				//.And(e => e.Odometer = 1000)
  1666  				.And(e => e.Speed = 100)

  1679  				//.And(e => e.GeoPoint = new Coordinate(1, 1))
  1680: 				//.And(e => e.Odometer = 1000)
  1681  				.And(e => e.Speed = 100)

  1694  				//.And(e => e.GeoPoint = new Coordinate(1, 1))
  1695: 				//.And(e => e.Odometer = 1000)
  1696  				.And(e => e.Speed = 100)

  1831  				//.And(e => e.GeoPoint = new Coordinate(1, 1))
  1832: 				//.And(e => e.Odometer = 1000)
  1833  				.And(e => e.Speed = 100)

  1846  				//.And(e => e.GeoPoint = new Coordinate(1, 1))
  1847: 				//.And(e => e.Odometer = 1000)
  1848  				.And(e => e.Speed = 100)

  1861  				//.And(e => e.GeoPoint = new Coordinate(1, 1))
  1862: 				//.And(e => e.Odometer = 1000)
  1863  				.And(e => e.Speed = 100)

  2003  				.And(e => e.GeoPoint = new Coordinate(1, 1))
  2004: 				.And(e => e.Odometer = 1000)
  2005  				.And(e => e.Speed = 100)

  2018  				.And(e => e.GeoPoint = new Coordinate(1, 1))
  2019: 				.And(e => e.Odometer = 1000)
  2020  				.And(e => e.Speed = 100)

  2033  				.And(e => e.GeoPoint = new Coordinate(1, 1))
  2034: 				.And(e => e.Odometer = 1000)
  2035  				.And(e => e.Speed = 100)

DynaMiX.Backend\API\DynaMiX.API.Test\NancyModules\UserManagement\Users\UserAdminModuleTests.cs:
  424  
  425: 		//todo jm
  426  		//[Test]

DynaMiX.Backend\Common\DynaMiX.Common\CommonSettings.cs:
  66  
  67: 		[ConfigurationProperty("DefaultPassengerImage", DefaultValue = "Default_passenger.png")] //TODO JM: add image
  68  		public string DefaultPassengerImage

  72  
  73: 		[ConfigurationProperty("DefaultWorkerImage", DefaultValue = "Default_worker.png")] //TODO: add image
  74  		public string DefaultWorkerImage

DynaMiX.Backend\Common\DynaMiX.Common\Billing\Constants\BillingFilesStatus.cs:
  13  		Processed = 1,
  14: 		FailedToDownload=2,
  15  		Error=3

DynaMiX.Backend\Common\DynaMiX.Common\Comms\ActiveMessage.cs:
   21  			_value = 0D;
   22: 			_odometer = 0F;
   23  			_speed = 0;

  164  
  165: 		[DataMapping("fOdometer, Odometer")]
  166: 		public float Odometer
  167  		{

  169  			{
  170: 				return _odometer;
  171  			}

  173  			{
  174: 				_odometer = (float)SetProperty(_odometer, value);
  175  				Validate();

  251  		{
  252: 			//TODO: add implementation
  253  			MarkValid();

  268  		private double _value;
  269: 		private float _odometer;
  270  		private byte _speed;

DynaMiX.Backend\Common\DynaMiX.Common\Comms\DMPFileGenerator.cs:
   60  		/// <param name="eventValue">A floating point value that might be sent to the user. Example: For overspeeding this is equeal to velocity.</param>
   61: 		/// <param name="odometer">A positive whole number in kilometer.</param>
   62  		/// <param name="longitude">Longitude Example: 18.84097.</param>

   70  		public static string WriteActiveMessage(string sourceIdentifier, string targetFolder, short companyId, short vehicleId, short driverId, DateTime unitTimestamp, short eventId, 
   71: 			float eventValue, double odometer, double longitude, double latitude, int heading, uint velocity, int altitude, uint distance = 0, bool detailedFileName = false)
   72  		{

   83  			{
   84: 				message = new ActiveMessage(companyId, vehicleId, driverId, unitTimestamp, eventId, eventValue, odometer, longitude, latitude, heading, velocity, altitude, distance);
   85  			}

  314  			private readonly uint _distance;
  315: 			private readonly uint _odo;
  316  			private readonly uint _speed;

  335  
  336: 			public ActiveMessage(short CompanyID, short VehicleID, short DriverID, DateTime Timestamp, short EventID, float EventValue, double Odometer, double Longitude, double Latitude, int Heading, uint Velocity, int Altitude, uint Distance)
  337  			{

  353  				_distance = Distance;
  354: 				_odo = (uint)(Odometer * 10); // The odo needs to be in km*10
  355  				_speed = Velocity;

  442  
  443: 			public uint Odo
  444  			{
  445: 				get { return _odo; }
  446  			}

DynaMiX.Backend\Common\DynaMiX.Common\Constants\ColumnHeadings.cs:
   39  			public const string MOBILE_DEVICE = "Mobile device";
   40: 			public const string ODOMETER = "Odometer";
   41  			public const string SITE = "Site";

   71  			public const string ENGINE_HOURS = "Engine hours";
   72: 			public const string ODOMETER = "Odometer";
   73: 			public const string ODOMETER_UNIT = "Odometer unit of measure";
   74  			public const string VOLUME = "Volume";

  454  			public const string EVENT_START = "Event start date/time";
  455: 			public const string ODOMETER = "Odometer";
  456  			public const string ENGINE_HOURS = "Engine hours";

DynaMiX.Backend\Common\DynaMiX.Common\Constants\DiagnosticInfo.cs:
  17  		public const string RPM = "RPM";
  18: 		public const string ODOMETER = "Odometer";
  19  		public const string GSM_QUALITY_STATUS = "GSM quality status";

DynaMiX.Backend\Common\DynaMiX.Common\Constants\ErrorMessages.cs:
  364  			public const string ENGINE_HOURS_MUST_BE_LESS = "The engine hours reading entered in this transaction is greater than the engine hours on a later dated transaction";
  365: 			public const string ODOMETER_MUST_BE_GREATER = "The odometer reading entered in this transaction is lower than the odometer on an earlier dated transaction";
  366: 			public const string ODOMETER_MUST_BE_LESS = "The odometer reading entered in this transaction is higher than the odometer on a later dated transaction";
  367: 			public const string ODOMETER_IS_REQUIRED = "The odometer unit of measure field is required";
  368  			public const string DUPLICATE_FUEL_RECORD = "Duplicate records for the same asset and date time are not allowed";

  450  			public const string RECURRING_COST_NAME_UNIQUE = "Recurring cost name is already in use";
  451: 			public const string ASSET_FUEL_DATA_ODOMETER_RANGE = "Odometer must be between 0 and 9999999.99";
  452  			public const string ASSET_TARGET_FUEL_CONSUMPTION_RANGE = "Target fuel consumption must be between 0 and 9999999.99";

DynaMiX.Backend\Common\DynaMiX.Common\Constants\InformationMessages.cs:
   94  			public const string RES_TIMELINE_SSE_LOCATION_VALUE = "value of {{ eventValue }}";
   95: 			public const string RES_TIMELINE_EVENT_ODO = "Odometer reading {{ odoValue }} {{ odoUnit }}";
   96  			public const string RES_TIMELINE_EVENT_START = "{{ eventTime }} {{ eventDescription }} start";

  111  			public const string RES_TIMELINE_SELECTION = "Select Period: from {{ startDateTime }} until {{ endDateTime }}";
  112: 			public const string RES_TIMELINE_SUB_TRIP_DISTANCE = "Sub Trip distance {{ tripDistance }} {{ tripDistanceUnits }}, with ending Odometer {{ odo }} {{ tripDistanceUnits }}";
  113  			public const string RES_TIMELINE_SUB_TRIP_END = "{{ tripEndDateTime }} Sub Trip end. Driving time {{ subTripDuration }}";

  118  			public const string RES_TIMELINE_TRIP_DEPART = "{{ dateTime }} The vehicle departed";
  119: 			public const string RES_TIMELINE_TRIP_DISTANCE = "Trip distance {{ distance }} {{ unit }}, with ending Odometer {{ odo }} {{ unit }}";
  120  			public const string RES_TIMELINE_TRIP_DRIVER = "Driver {{ driver }}";

DynaMiX.Backend\Common\DynaMiX.Common\DTCODownloadManagement\DTCODownloadManagementSettings.cs:
  2  
  3: namespace DynaMiX.Common.DTCODownloadManagement
  4  {
  5: 	public class DTCODownloadManagementSettings : ConfigurationSection
  6  	{
  7: 		public static DTCODownloadManagementSettings Current = (DTCODownloadManagementSettings)ConfigurationManager.GetSection("dynamix/dynamix.dtco_download_manager");
  8  

DynaMiX.Backend\Common\DynaMiX.Common\DTCODownloadManagement\Permissions.cs:
  1: namespace DynaMiX.Common.DTCODownloadManagement
  2  {

DynaMiX.Backend\Common\DynaMiX.Common\FleetAdmin\Constants\AssetIcons.cs:
  15  		{
  16: 			//todo assetcrud: store a list in the database.
  17  			var icons = new List<string>

DynaMiX.Backend\Common\DynaMiX.Common\Images\ImageUploadHandler.cs:
  115  
  116: 			//todo: smarter detection of file type
  117  			if (extension == fileName) //no extension provided. default to jpg

DynaMiX.Backend\Common\DynaMiX.Common\InsightReports\Constants\General.cs:
  30  
  31: 		//TODO RDT: Replace this with RenderFormat enum from Insight Api
  32  		public static ValidValue[] REPORT_FORMAT_LIST = new ValidValue[3];

DynaMiX.Backend\Common\DynaMiX.Common\PermissionModules\Definitions\DTCODownloadManagement.cs:
  1  using System.Collections.Generic;
  2: using DynaMiX.Common.DTCODownloadManagement;
  3  

  5  {
  6: 	public class DTCODownloadManagement : PermissionModule
  7  	{
  8: 		public DTCODownloadManagement()
  9  		{

DynaMiX.Backend\Common\DynaMiX.Common\Positioning\GPSPosition.cs:
  109  			{
  110:         _latitude = (float)SetProperty(_latitude, Convert.ToSingle(Math.Round(Convert.ToDouble(value), 6)));
  111  				Validate();

  120  			{
  121:         _longitude = (float)SetProperty(_longitude, Convert.ToSingle(Math.Round(Convert.ToDouble(value), 6)));
  122  				Validate();

  164  			{
  165:         _hdop = (float)SetProperty(_hdop, Convert.ToSingle(Math.Round(Convert.ToDouble(value), 2)));
  166  				Validate();

DynaMiX.Backend\Components\DynaMiX.NGCompiler.Tests\CompileTests.cs:
  45  			string html = File.ReadAllText(templateLocation);
  46: 			dynamic assetReminder1 = new { AssetDescription = "Audi", AssetRegistration = "Audi WP", AssetOdometer = 30001, Organisation = "Staff Vehicles1", ExpiryDate = DateTime.Now.AddDays(-2), ExpiredSince = DateTime.Now.AddDays(-3), ExpiredUnit = "Distance" };
  47: 			dynamic assetReminder2 = new { AssetDescription = "BMW", AssetRegistration = "BMW NP", AssetOdometer = 40001, Organisation = "Staff Vehicles2", ExpiryDate = DateTime.Now.AddDays(2), ExpiredSince = DateTime.Now, ExpiredUnit = "Time" };
  48: 			dynamic assetReminder3 = new { AssetDescription = "Chev", AssetRegistration = "Chev GP", AssetOdometer = 30001, Organisation = "Staff Vehicles3", ExpiryDate = DateTime.Now.AddDays(5), ExpiredSince = DateTime.Now.AddDays(2), ExpiredUnit = "Engine Hours" };
  49  			dynamic AssetReminders = new dynamic[3] { assetReminder1, assetReminder2, assetReminder3 };

  81  				string html = File.ReadAllText(templateLocation);
  82: 				dynamic assetReminder1 = new { AssetDescription = "Audi", AssetRegistration = "Audi WP", AssetOdometer = 30001, Organisation = "Staff Vehicles1", ExpiryDate = DateTime.Now.AddDays(-2), ExpiredSince = DateTime.Now.AddDays(-3), ExpiredUnit = "Distance" };
  83: 				dynamic assetReminder2 = new { AssetDescription = "BMW", AssetRegistration = "BMW NP", AssetOdometer = 40001, Organisation = "Staff Vehicles2", ExpiryDate = DateTime.Now.AddDays(2), ExpiredSince = DateTime.Now, ExpiredUnit = "Time" };
  84: 				dynamic assetReminder3 = new { AssetDescription = "Chev", AssetRegistration = "Chev GP", AssetOdometer = 30001, Organisation = "Staff Vehicles3", ExpiryDate = DateTime.Now.AddDays(5), ExpiredSince = DateTime.Now.AddDays(2), ExpiredUnit = "Engine Hours" };
  85  				dynamic AssetReminders = new dynamic[3] { assetReminder1, assetReminder2, assetReminder3 };

DynaMiX.Backend\Components\Tacho\DynaMiX.Tacho.Entities\Entities\TachoInterval.cs:
  54  
  55: 		public decimal Odometer
  56  		{
  57: 			get { return _line[LineIndex(InputLineType.Odometer)]; }
  58: 			set { _line[LineIndex(InputLineType.Odometer)] = value; }
  59  		}

DynaMiX.Backend\Components\Tacho\DynaMiX.Tacho.Entities\Enumerators\InputLineType.cs:
  7  		F3 = 3,
  8: 		Odometer = 4,
  9  		I1 = 5,

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData\TachoExtensions.cs:
  25  
  26: 			newInterval.Odometer = (calibrationInfo[InputLineType.Odometer] != null) ? 
  27: 				calibrationInfo[InputLineType.Odometer].GetUserValue(interval.Odometer) : 
  28: 				interval.Odometer;
  29  

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData\Decoder\TachoBlockDecoder.cs:
   14  			F3 = 0x0080,
   15: 			Odo = 0x0040,
   16  			I1 = 0x0020,

  207  
  208: 			if ((_fieldMask & TachoMask.Odo) == TachoMask.Odo)
  209  			{
  210  				ushort valuePart1 = BitConverter.ToUInt16(_block, 11);
  211: 				_doLines[3] = new DoOdometer(this, interval, valuePart1 + (_block[13] * 65536));
  212  			}

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData\Decoder\TachoBlockLinesDecoder.cs:
  201  
  202: 		private class DoOdometer : DoLine
  203  		{
  204: 			public DoOdometer(TachoBlockDecoder parent, TachoInterval interval, int initialValue) : base(parent, interval, initialValue) { }
  205  

  207  			{
  208: 				get { return Interval.Odometer; }
  209: 				set { Interval.Odometer = value; }
  210  			}

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData.Tests\TachoIntervalsTests.cs:
  427        ret.F3 = (3 * seed);
  428:       ret.Odometer = 1001 * seed;
  429        ret.I1 = (5 * seed);

  441        Assert.AreEqual(3.0, interval.F3, "incorrect F3");
  442:       Assert.AreEqual(1001.0, interval.Odometer, "incorrect Odometer");
  443        Assert.AreEqual(5.0, interval.I1, "incorrect I1");

  453        Assert.AreEqual(6.0, interval.F3, "incorrect F3");
  454:       Assert.AreEqual(2002.0, interval.Odometer, "incorrect Odometer");
  455        Assert.AreEqual(10.0, interval.I1, "incorrect I1");

  465        Assert.AreEqual(9.0, interval.F3, "incorrect F3");
  466:       Assert.AreEqual(3003.0, interval.Odometer, "incorrect Odometer");
  467        Assert.AreEqual(15.0, interval.I1, "incorrect I1");

  477        Assert.AreEqual(12.0, interval.F3, "incorrect F3");
  478:       Assert.AreEqual(4004.0, interval.Odometer, "incorrect Odometer");
  479        Assert.AreEqual(20.0, interval.I1, "incorrect I1");

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData.Tests\TachoBlock\DecodeTachoBlockTests.cs:
   23  
   24: 			b.NextBit = false;  //Odo   010
   25  			b.NextBit = true;

   48  
   49: 			b.NextBit = false;  //Odo   010
   50  			b.NextBit = true;

   73  
   74: 			b.NextBit = false;  //Odo   010
   75  			b.NextBit = true;

   98  
   99: 			b.NextBit = false;  //Odo   010
  100  			b.NextBit = true;

  112  
  113: 		[Test, Description("Skip Odo others +1, then all +2")]
  114: 		public void TachoSkipOdoOthersBy1ThenAll2Test()
  115  		{

  123  
  124: 			b.NextBit = true;   //Odo   skip
  125  

  146  
  147: 			b.NextBit = false;  //Odo   010
  148  			b.NextBit = true;

  171  
  172: 			b.NextBit = false;  //Odo   010
  173  			b.NextBit = true;

  196  
  197: 			b.NextBit = false;  //Odo   010
  198  			b.NextBit = true;

  221  
  222: 			b.NextBit = false;  //Odo   010
  223  			b.NextBit = true;

  284  			IncreaseLineBy1(b); //F3    0110
  285: 			b.NextBit = false;  //Odo   skip to next interval
  286  			b.NextBit = false;

  293  
  294: 		[Test, Description("Odo + 1, skip others, then all +2")]
  295: 		public void TachoOdoBy1SkipOthersThenAll2Test()
  296  		{

  304  
  305: 			b.NextBit = false;  //Odo   010
  306  			b.NextBit = true;

  327  			b.NextBit = true;   //F3    skip
  328: 			b.NextBit = true;   //Odo   skip
  329  			b.NextBit = true;   //I1    skip

  349  																	 TachoTestBlock.TachoMask.F3 |
  350: 																	 TachoTestBlock.TachoMask.Odo |
  351  																	 TachoTestBlock.TachoMask.I1 |

  369  
  370: 			tb.NextBit = false;  //odo
  371  			tb.NextBit = true;

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData.Tests\TachoBlock\TachoBlockOdoTests.cs:
   6  	/// <summary>
   7: 	/// Group of tests to check the logic to convert the Odometer increments from the raw Tacho block
   8  	/// from unit memory into 'processable' structure.
   9: 	/// Odometer can only increase by 1 ( = 100m/second)
  10  	/// </summary>
  11  	[TestFixture]
  12: 	public class TachoBlockOdoTests
  13  	{

  25  										{
  26: 											Mask = TachoTestBlock.TachoMask.Odo,
  27: 											Odometer = HeadValue
  28  										};

  33  		[Test, Description("Increase by 1")]
  34: 		public void IncrementOdometerByOneTest()
  35  		{

  44  		[Test, Description("set to specific")]
  45: 		public void SetOdometerTest()
  46  		{

  54  		[Test, Description("")]
  55: 		public void OdometerOverFlowBitIncrementTest()
  56  		{

  85  			AddSecond();
  86: 			_intervals.NextBit = false; //Odo not skipped
  87: 			_intervals.NextBit = true;  //Odo + 1
  88  			expectedValue++;

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData.Tests\TachoBlock\TachoBlockTestBase.cs:
  25  			Assert.AreEqual((double)expected.F3, (double)result.F3, 0.000001, "not the expected F3");
  26: 			Assert.AreEqual(expected.Odometer, result.Odometer, "not the expected Odometer");
  27  			Assert.AreEqual(expected.I1, result.I1, "not the expected I1");

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData.Tests\TachoBlock\TachoTestBlock.cs:
   14  			F3 = 0x0080,
   15: 			Odo = 0x0040,
   16  			I1 = 0x0020,

  124  
  125: 		public int Odometer
  126  		{

  230  
  231: 		public void DoTest(int expectedDeltas, DateTime expectedEnd, decimal expectedSpeed, decimal expectedRpm, decimal expectedF3, decimal expectedOdo, decimal expectedI1, decimal expectedI2, decimal expectedI3, decimal expectedI4)
  232  		{

  243  												F3 = expectedF3,
  244: 												Odometer = expectedOdo,
  245  												I1 = expectedI1,

DynaMiX.Backend\Components\Tacho\DynaMiX.TachoData.Tests\TachoBlock\TachoTestBlockTests.cs:
   81  		[Test]
   82: 		public void TachoTestBlockHeaderOdoCorrect()
   83  		{

   85  			byte[] b = tb.Data;
   86: 			Assert.AreEqual(0x0064, BitConverter.ToInt16(b, 11), "incorrect odo (low bytes) for default block");
   87: 			Assert.AreEqual(0x00, b[13], "incorrect high odo byte for default block");
   88  		}

  201  		[Test]
  202: 		public void TachoTestBlockSetOdoCorrect()
  203  		{
  204: 			TachoTestBlock tb = new TachoTestBlock { Odometer = 0x965A69 };
  205  
  206  			byte[] b = tb.Data;
  207: 			Assert.AreEqual(0x69, b[11], "incorrect odo (low) after set");
  208: 			Assert.AreEqual(0x5A, b[12], "incorrect odo (mid) after set");
  209: 			Assert.AreEqual(0x96, b[13], "incorrect odo (high) after set");
  210  			Assert.AreEqual(0x99, b[18], "Checksum not correct!");

DynaMiX.Backend\Core\DynaMiX.Core\Constants.cs:
  82  			/// <summary>
  83: 			/// The name of the DNS validation directive. //TODO: MR: Make sure we will leave this in here
  84  			/// </summary>

DynaMiX.Backend\Core\DynaMiX.Core\Extensions\String\Extensions.cs:
  160  
  161: 		public static double ToDouble(this string _this)
  162  		{

DynaMiX.Backend\Core\DynaMiX.Core\Runtime\Resolver\Implementation\Binding.cs:
  58  		{
  59: 			// TODO: In theory this could collide... in theory (in practice it should never collide during normal operation).
  60  			Id = Guid.NewGuid();

DynaMiX.Backend\Core\DynaMiX.Core\Runtime\Resolver\Implementation\ContextBase.cs:
  60  		{
  61: 			// TODO: Make this thread safe.
  62: 			// TODO: Make this use generics throughout (the casting is a little expensive).
  63  

DynaMiX.Backend\Core\DynaMiX.Core\Services\ThreadedServiceBase.cs:
  130  		///			{
  131: 		///				if (thereIsWorkToDo)
  132  		///					AssignWorkToAvailableWorkerThread(someWorkItem);

DynaMiX.Backend\Core\DynaMiX.Core\Validation\Guard.cs:
  6  	/// Guard provides a mechanism for checking and throwing exceptions if the arguments are null or empty.
  7: 	/// It follows Design By Contract (DbC) software correctness methodology.
  8  	/// </summary>

DynaMiX.Backend\Core\DynaMiX.Core\Validation\Validator.cs:
   36  
   37: 			// TODO: Cache this information somewhere as it could end up being a bottleneck.
   38  

   92  		{
   93: 			// TODO: Cache this information somewhere as it could end up being a bottleneck.
   94  

  144  		{
  145: 			// TODO: Cache this information somewhere as it could end up being a bottleneck.
  146  

DynaMiX.Backend\Core\DynaMiX.Core\Validation\Implementation\CreditCardConverter.cs:
  38  				{
  39: 					// TODO: Add support in framework for dmx-creditcard.
  40  					new AttributeCarrier(Constants.AngularDirectives.CreditCard),

DynaMiX.Backend\Core\DynaMiX.Core\Validation\Implementation\StringLengthConverter.cs:
  39  				{
  40: 					// TODO: Add support for minimum string length.
  41  					new AttributeCarrier("dmx-minlength", instance.MinimumLength.ToString(CultureInfo.InvariantCulture)),

DynaMiX.Backend\Core\DynaMiX.Core.DataAccess\BagFormat\BagSerialiser.cs:
  326  			else if (type == typeof(double))
  327: 				result = GetDouble(bag, name, Convert.ToDouble(defaultValue));
  328  			else if (type == typeof(double?))

DynaMiX.Backend\Core\DynaMiX.Core.DataAccess\DALC\Fluent\FluentDataMapper.cs:
  185  
  186: 				// TODO: Complex mappings not supported.
  187  			}

  210  
  211: 				// TODO: Complex mappings not supported.
  212  			}

  258  				//Try to find a complex mapping that uses the parameter name.
  259: 				FluentComplexPropertyMap complexMap = complexMappings.SingleOrDefault(m => m.ColumnNames.Contains(parameterName, StringComparer.InvariantCultureIgnoreCase)); //TODO JM: Differentiate between ColumnNames and ParameterNames
  260  				if (complexMap != null)

DynaMiX.Backend\Core\DynaMiX.Core.Http\Extensions\RouteDefinition\Extensions.cs:
  51  			if (parameters == null) parameters = new Dictionary<string, string>();
  52: 			//todo: use extension method commented out below. check  for regression when adding values to query string
  53  			//var uri = rd.ToUri(parameters);

DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:
  247  			{
  248: 				//ToDo: FLEET-8708 - Fix this ugly hack. Put DynaMiX.Common.UnAuthenticatedException into DynaMiX.Core so that it can be trapped by type without causing a circular reference.
  249  				if (ex.GetType().FullName == "DynaMiX.Common.UnAuthenticatedException")

DynaMiX.Backend\Core\DynaMiX.Core.Tests\DataAccess\Transactions\DmxTransactionScopeTests.cs:
  23  			Assert.AreEqual(IsolationLevel.ReadCommitted, committableTransaction.IsolationLevel);
  24: 			//TODO HM UnitTests: Find out how to assert TransactionScopeOption.Required
  25  			scope.Dispose();

DynaMiX.Backend\Core\DynaMiX.Core.Tests\Validation\ValidatorTests.cs:
  161  
  162: 			// TODO: Make sure that the carriers coming out are correct.
  163  		}

  188  
  189: 			// TODO: Make sure that the carriers coming out are correct.
  190  		}

DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\MiXConnectRepository.cs:
   52  		MiX2310iStatusInfo GetDeviceDiagnosticInfo(string deviceId, ref uint reqCommandId);
   53: 		void UpdateOdometer(string deviceId, float odoKm);
   54  		MiX2310iStatusInfo GetLastKnownDeviceDiagnosticInfo(string deviceId);

  372  
  373: 		public void UpdateOdometer(string deviceId, float odoKm)
  374  		{
  375: 			// create set odo command
  376  			List<DeviceSetting> deviceSettings = new List<DeviceSetting>();
  377: 			deviceSettings.Add(new DeviceSetting(UdpParameterId.Odometer, (uint)(odoKm * 1000)));
  378  

  452  				statusInfo.InternalBatteryState = status.InternalBatteryState.ToString();
  453: 				statusInfo.Odometer = status.Odometer;
  454  				statusInfo.PlatformVersion = status.PlatformVersion.ToString();

DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\Mapping\LibraryLevel\EventActions\RecordingActionMap.cs:
   9  		{
  10: 			this.Ignore(o => o.StartOdometer);
  11: 			this.Ignore(o => o.EndOdometer);
  12  			this.Ignore(o => o.StartPosition);

DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\Mapping\MobileUnitLevel\EventActions\OverridenRecordingActionMap.cs:
   9  		{
  10: 			this.Ignore(o => o.StartOdometer);
  11: 			this.Ignore(o => o.EndOdometer);
  12  			this.Ignore(o => o.StartPosition);

DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\Mapping\TemplateLevel\EventActions\TemplateRecordingActionMap.cs:
   9  		{
  10: 			this.Ignore(o => o.StartOdometer);
  11: 			this.Ignore(o => o.EndOdometer);
  12  			this.Ignore(o => o.StartPosition);

DynaMiX.Backend\Data\DynaMiX.Data\DTCODownloadManagement\DTCODownloadManagementRepository.cs:
    1  using AutoMapper;
    2: using DynaMiX.Common.DTCODownloadManagement;
    3  using DynaMiX.Core.Extensions.DateTime;

    8  using DynaMiX.Data.DALC.OrgInfo;
    9: using DynaMiX.Entities.DTCODownloadManagement;
   10  using MiX.Core.Conversion;

   18  
   19: namespace DynaMiX.Data.DTCODownloadManagement
   20  {
   21: 	public interface IDTCODownloadManagementRepository
   22  	{

   47  	[BindingProvider]
   48: 	public class DTCODownloadManagementRepository : IDTCODownloadManagementRepository
   49  	{

   58  		{
   59: 			Bind<IDTCODownloadManagementRepository>.To(context => new DTCODownloadManagementRepository()).AsSingleton();
   60  		}

   70  
   71: 					_client = new DddApiClient(DTCODownloadManagementSettings.Current.DDDApiUrl);
   72  					_client.Authenticate("DynaMiX_API", Security.AuthenticationKey);

   79  
   80: 		public DTCODownloadManagementRepository()
   81  		{

  120  
  121: 					cfg.CreateMap<DTCODownloadData, DownloadDataResource>();
  122: 					cfg.CreateMap<DownloadDataResource, DTCODownloadData>();
  123  

  132  
  133: 					cfg.CreateMap<MiX.DDD.Web.Api.Client.Resources.ActivityParameters, DynaMiX.Entities.DTCODownloadManagement.ActivityParameters>();
  134: 					cfg.CreateMap<DynaMiX.Entities.DTCODownloadManagement.ActivityParameters, MiX.DDD.Web.Api.Client.Resources.ActivityParameters>();
  135  
  136: 					cfg.CreateMap<MiX.DDD.Web.Api.Client.Resources.DownloadFrequency, DynaMiX.Entities.DTCODownloadManagement.DownloadFrequency>();
  137: 					cfg.CreateMap<DynaMiX.Entities.DTCODownloadManagement.DownloadFrequency, MiX.DDD.Web.Api.Client.Resources.DownloadFrequency>();
  138  
  139  					cfg.CreateMap<DownloadTask, DTCORemoteTask>()
  140: 						.ForMember(dest => dest.DTCODownloadData, opt => opt.MapFrom(src => src.DownloadData));
  141  
  142  					cfg.CreateMap<DTCORemoteTask, DownloadTask>()
  143: 						.ForMember(dest => dest.DownloadData, opt => opt.MapFrom(src => src.DTCODownloadData));
  144  

  222  
  223: 			var registrationNumbers = entityFiles.Where(e => e.Key.EntityType == 1 || e.Key.EntityType == 2).Select(e => e.Key.EntityIdentifier).Distinct().ToList(); // MassData / SiemensVdoDownload
  224  			var extendedIds = entityFiles.Where(e => e.Key.EntityType == 3).Select(e => e.Key.EntityIdentifier.To32ByteHexFrom16ByteAscii()).Distinct().ToList();     //DriverCardData

DynaMiX.Backend\Data\DynaMiX.Data\Events\Mappings\ActiveEventDetailMapping.cs:
  25  			Map(x => x.GeoPoint, new CoordinateConverter("Latitude", "Longitude"));
  26: 			Map(x => x.Odometer);
  27  			Map(x => x.Speed);

DynaMiX.Backend\Data\DynaMiX.Data\Events\Mappings\EventDataMapping.cs:
  23  			Map(e => e.EndDateTime, new AssetDataZonedDateTimeConverter());
  24: 			Map(e => e.StartOdometer);
  25: 			Map(e => e.EndOdometer);
  26  			Map(e => e.StartGpsId);

DynaMiX.Backend\Data\DynaMiX.Data\Events\Mappings\EventDataSummaryMapping.cs:
  23  			Map(x => x.StartPosition, new CoordinateConverter("StartLatitude", "StartLongitude"));
  24: 			Map(x => x.StartOdometer);
  25  			Map(x => x.EndDate, new AssetDataZonedDateTimeConverter());
  26  			Map(x => x.EndPosition, new CoordinateConverter("EndLatitude", "EndLongitude"));
  27: 			Map(x => x.EndOdometer);
  28  			Map(x => x.PhotoKey);

DynaMiX.Backend\Data\DynaMiX.Data\Feeds\DTO\FeedEntryDTOConverter.cs:
  132  				feedEntry.DriverName = eventDetail.DriverName;
  133: 				feedEntry.Odometer = eventDetail.Odometer;
  134  				feedEntry.Speed = eventDetail.Speed;

  193  
  194: 						// TODO: Rovi does not have a subject, only a message, but it's called "DESC" instead of "BODY". If "BODY" doesn't exist, move "DESC" to body.
  195  						msg.Subject = BagSerialiser.GetString(dto.MessageParams, "Desc");

DynaMiX.Backend\Data\DynaMiX.Data\Feeds\DTO\FeedEntryPartialDetailDTO.cs:
  39  
  40: 		public decimal Odometer { get; set; }
  41  

DynaMiX.Backend\Data\DynaMiX.Data\Feeds\Mappings\FeedEntryPartialDetailDTOMapping.cs:
  32  			Map(x => x.GeoPoint, new CoordinateConverter("Latitude", "Longitude"));
  33: 			Map(x => x.Odometer);
  34  			Map(x => x.Speed);

DynaMiX.Backend\Data\DynaMiX.Data\FleetAdmin\AssetTrailerIdRepository.cs:
  13  		void ChangeTrailerId(long orgId, long assetId, AssetTrailerDetails entity);
  14: 		void ChangeOdometer(long orgId, long assetId, AssetTrailerDetails entity);
  15  		bool IsTrailerIdUnique(long orgId, long assetId, int trailerId);

  38  
  39: 		public void ChangeOdometer(long orgId, long assetId, AssetTrailerDetails entity)
  40  		{
  41: 			var sproc = new CommandSproc("[dynamix].[AssetTrailerDetails_UpdateOdometer]");
  42  			sproc.SetParam("assetId", assetId);
  43: 			sproc.SetParam("odometer", entity.Odometer);
  44: 			sproc.SetParam("odometerDate", entity.OdometerDate);
  45  			AssetDbDalc.Do(orgId, sproc);

DynaMiX.Backend\Data\DynaMiX.Data\FleetAdmin\Converters\AssetStatusBagConverter.cs:
  40  			assetStatus.AssetId = values.AssetId;
  41: 			assetStatus.VehicleLastOdo = values.VehicleLastOdo;
  42  

  81  				assetStatus.RPM = BagSerialiser.GetShort(bag, "RPM", 0);
  82: 				assetStatus.Odometer = BagSerialiser.GetFloat(bag, "Odometer");
  83  				assetStatus.SubTripDistance = BagSerialiser.GetDouble(bag, "SubtripDist");

DynaMiX.Backend\Data\DynaMiX.Data\FleetAdmin\DTOs\AssetStatusValues.cs:
  7  		public string DownloadVehicleNow { get; set; }
  8: 		public float? VehicleLastOdo { get; set; }
  9  	}

DynaMiX.Backend\Data\DynaMiX.Data\FleetAdmin\Mappings\Assets\AssetExtendedSummaryMapping.cs:
  23  			Map(a => a.LastTrip, new AssetDataZonedDateTimeConverter());
  24: 			Map(a => a.Odometer);
  25  			Map(a => a.EngineHours, new Int32TimeSpanConverter(TimeSpanUnit.Seconds));

DynaMiX.Backend\Data\DynaMiX.Data\FleetAdmin\Mappings\Assets\AssetFuelUsageMapping.cs:
  15  			Map(f => f.FillDate, new AssetDataZonedDateTimeConverter());
  16: 			Map(f => f.Odometer);
  17  			Map(f => f.EngineSeconds);

DynaMiX.Backend\Data\DynaMiX.Data\FleetAdmin\Mappings\Assets\AssetMapping.cs:
  40  			Map(a => a.CreatedBy);
  41: 			Map(a => a.Odometer);
  42  			Map(a => a.CreatedDate, new AssetDataStorageDateTimeOffsetZonedDateTimeConverter());

DynaMiX.Backend\Data\DynaMiX.Data\FleetAdmin\Mappings\Assets\AssetServiceHistoryMapping.cs:
  15  			Map(f => f.ServiceDate, new AssetDataZonedDateTimeConverter());
  16: 			Map(f => f.Odometer);
  17  			Map(f => f.EngineSeconds);

DynaMiX.Backend\Data\DynaMiX.Data\FleetAdmin\Mappings\Assets\AssetSummaryMapping.cs:
  23  			Map(a => a.LastTrip, new AssetDataZonedDateTimeConverter());
  24: 			Map(a => a.Odometer);
  25  			Map(a => a.EngineHours, new Int32TimeSpanConverter(TimeSpanUnit.Seconds));

DynaMiX.Backend\Data\DynaMiX.Data\Groups\GroupsDb.cs:
  390  
  391: 		//todo jm change this to return groupmemberships.
  392  		public virtual List<Group> GetGroupsThatEntityBelongsTo(long entityId, string entityType, bool excludeInactive)

DynaMiX.Backend\Data\DynaMiX.Data\JobsAndMessaging\JobsAndMessagingRepository.cs:
  261  			if (message.MessageType != MessageType.CommandToFM)
  262: 				message = MessageDTOConverter.ToEntity(dto, history); //todo: call this methon in stead of the code below
  263  			else

DynaMiX.Backend\Data\DynaMiX.Data\JourneyManagement\JourneyRepository.cs:
  1152  
  1153: 		//TODO ZS This seems wrong should check within org???
  1154  		private const string _routeGetByDescriptionSprocName = "[JourneyManagement].[Route_GetByDescription]";

DynaMiX.Backend\Data\DynaMiX.Data\Mapping\PointsOfInterestRepository.cs:
  76  			return pointOfInterest;
  77: 			//TODO:  Zonika Should this read from lightning and return? 
  78  		}

  88  			return pointOfInterest;
  89: 			//TODO:  Zonika Should this read from lightning and return? 
  90  		}

DynaMiX.Backend\Data\DynaMiX.Data\Notifications\Mappings\NotificationHistoryItemMapping.cs:
  33  			Map(n => n.Heading);
  34: 			Map(n => n.Odometer);
  35  			Map(n => n.EventType);

DynaMiX.Backend\Data\DynaMiX.Data\RoviConfig\RoviConfigRepository.cs:
  924  
  925: 			// TODO: We have to create the correct script instance based on the version data stored within it.
  926  			var configuration = ConfigurationBase.FromString(item.RoviConfig);

DynaMiX.Backend\Data\DynaMiX.Data\Scheduler\DTO\AssetUploadScheduleDetailsDTO.cs:
   18  
   19: 		public int? SetOdoKmValue { get; set; }
   20: 		public bool SetOdo { get { return SetOdoKmValue != null; } }
   21  

   28  			{
   29: 				if (Disarm || SetOdo || SetEngineHours)
   30  					return 15;

   79  				DisarmDriverId = entity.DisarmDriverId,
   80: 				SetOdoKmValue = entity.SetOdoKmValue,
   81  				SetEngineHoursValue = entity.SetEngineHoursValue,

  143  				DisarmDriverId = dto.DisarmDriverId,
  144: 				SetOdoKmValue = dto.SetOdoKmValue,
  145  				SetEngineHoursValue = dto.SetEngineHoursValue,

DynaMiX.Backend\Data\DynaMiX.Data\Scheduler\DTO\DownloadScheduleDTO.cs:
  42  
  43: 		public TachoDownloadType TachoDownloadType { get; set; }
  44  		public ZonedDateTime TachoStart { get; set; }

DynaMiX.Backend\Data\DynaMiX.Data\Scheduler\DTO\DownloadScheduleDTOConverter.cs:
   32  				TransportTypeId = dto.TransportTypeId,
   33: 				TachoDownloadType = dto.TachoDownloadType,
   34  				TachoStart = dto.TachoStart,

  136  				TransportTypeId = entity.TransportTypeId,
  137: 				TachoDownloadType = entity.TachoDownloadType,
  138  				TachoStart = entity.TachoStart,

DynaMiX.Backend\Data\DynaMiX.Data\Scheduler\Mappings\AssetUploadScheduleDetailsMapping.cs:
  26  			Map(a => a.Disarm);
  27: 			Map(a => a.SetOdoKmValue);
  28: 			Map(a => a.SetOdo);
  29  			Map(a => a.SetEngineHoursValue, new Int32TimeSpanConverter(TimeSpanUnit.Seconds));

DynaMiX.Backend\Data\DynaMiX.Data\Scheduler\Mappings\DownloadScheduleDTOMapping.cs:
  38  			Map(x => x.Days);
  39: 			Map(x => x.TachoDownloadType);
  40  			Map(x => x.TachoStart, new SystemToOrganisationZonedDateTimeConverter());

DynaMiX.Backend\Data\DynaMiX.Data\Scoring\AdvancedScoringRepository.cs:
  93  				// Add items.
  94: 				// TODO: we should probably have some kind of batch update facility here.
  95  				foreach (var procedure in arrayItems.Select(o => new EntityDoSproc<AdvancedScoringItem>("[dynamix].[Scoring_AddAdvancedItem]", o)))

DynaMiX.Backend\Data\DynaMiX.Data\Tracking\FastTrackRedisCache.cs:
  10  {
  11: 	//todo: This was copied from FMWeb. Maybe use Core2.Caching.Redis.
  12  	internal sealed class FastTrackRedisCache

DynaMiX.Backend\Data\DynaMiX.Data\Tracking\TrackingRepositoryBase.cs:
   95  			HashSet<long> assetIdsLookup = new HashSet<long>(assetIds);
   96: 			//todo perf: may not be optimal to fetch all id's in an org
   97  			return GetAllLegacyVehicleIdsFromCache(orgId, correlationId)

  104  			HashSet<long> assetIdsLookup = new HashSet<long>(assetIds);
  105: 			//todo perf: may not be optimal to fetch all id's in an org
  106  			return GetAllLegacyVehicleIdsFromCache(orgId, correlationId)

DynaMiX.Backend\Data\DynaMiX.Data\Tracking\Mappings\GPSReadingMapping.cs:
  17  			Map(g => g.AssetId);
  18: 			//Map(g => g.TimeOfReading, new OrganisationAndLocationToZonedDateTimeConverter("Latitude", "Longitude", "TimeOfReading")); //todo
  19  			Map(g => g.VehicleId);

DynaMiX.Backend\Data\DynaMiX.Data\Trips\DTO\TripAndSubTripSummaryDTO.cs:
  21  		public decimal SubTripDistance { get; set; }
  22: 		public decimal SubTripOdometer { get; set; }
  23  		

DynaMiX.Backend\Data\DynaMiX.Data\Trips\DTO\TripAndSubTripSummaryDTOConverter.cs:
  50  					Distance = dto.SubTripDistance,
  51: 					Odometer = dto.SubTripOdometer,
  52  					StartPositionId = dto.SubTripStartGpsId,

DynaMiX.Backend\Data\DynaMiX.Data\Trips\Mappings\SubTripDataMapping.cs:
  36  			Map(t => t.TripDistance);
  37: 			Map(t => t.Odometer);
  38  			Map(t => t.MaxAccel);

DynaMiX.Backend\Data\DynaMiX.Data\Trips\Mappings\TripAndSubTripSummaryDTOMapping.cs:
  25  			Map(x => x.SubTripDistance);
  26: 			Map(x => x.SubTripOdometer);
  27  			Map(x => x.FmDriverId);

DynaMiX.Backend\Data\DynaMiX.Data\Trips\Mappings\TripDataMapping.cs:
  36  			Map(t => t.TripDistance);
  37: 			Map(t => t.Odometer);
  38  			Map(t => t.MaxAccel);

DynaMiX.Backend\Data\DynaMiX.Data.Tests\DTCODownloadManagement\DTCODownloadManagementRepositoryTests.cs:
   3  using System.Linq;
   4: using DynaMiX.Entities.DTCODownloadManagement;
   5  using MiX.Core2.Serialization;

  11  
  12: namespace DynaMiX.Data.Tests.DTCODownloadManagement
  13  {

  15  	[Ignore("Marked as ignored")]
  16: 	internal class DTCODownloadManagementRepositoryTests
  17  	{

  23  
  24: 		public DTCODownloadManagementRepositoryTests()
  25  		{

DynaMiX.Backend\Data\DynaMiX.Data.Tests\FleetAdmin\Assets\TestAssetStatusBagConverter.cs:
  16  			//Arrange
  17: 			//todo jm
  18  

  29  			//Arrange
  30: 			//todo jm
  31  

DynaMiX.Backend\Data\DynaMiX.JourneyManagement.Risk.Data\UnitsOfWork\JourneyApprovalOverdueLogic.cs:
  19  				{
  20: 					//TODO: GDS Log the exception and send a message to the UI
  21  					throw;

DynaMiX.Backend\Data\DynaMiX.JourneyManagement.Risk.Data\UnitsOfWork\JourneyApprovalQueue.cs:
  20  			{
  21: 				//TODO: Log message to indicate that AppSetting has not been configured for the specific JourneyQueueName
  22  				return;

DynaMiX.Backend\Data\DynaMiX.JourneyManagement.Risk.Data\UnitsOfWork\RiskAssessmentUnitOfWork.cs:
  134  					RHLookup roadHazard = rhs.Where(x=> x.RHId == roadHazardQuestionAnswer.JourneyRoadHazard.RoadHazardId).First();
  135: 					//TODO: Zonika - Get road hazard from lightning location
  136  					//var pointOfInterest = _pointsOfInterestRepository.GetPointOfInterest(orgId, roadHazard.PointOfInterestId);

DynaMiX.Backend\Data\DynaMiX.JourneyManagement.Tests\RiskAssessmentTests.cs:
  233  											OutcomeStatementText = "It has been [value] hours since your last drink, the safe Threshold is [threshold]",
  234: 											//todo ZONIKA set correct
  235  											OutcomeStatementType = OutcomeStatementType.BelowThreshold,

DynaMiX.Backend\DriverPortal\MiX.DriverPortal.Api\Converters\DynaMiXDataConverters.cs:
  87  					EventValue = serviceEvent.Value,
  88: 					StartOdometer = serviceEvent.StartOdometerKilometres,
  89: 					EndOdometer = serviceEvent.EndOdometerKilometres,
  90  				};

DynaMiX.Backend\DriverPortal\MiX.DriverPortal.Api\Converters\GraphConverters.cs:
  197  
  198: 					var formattedScore = EventDataConverter.GetEventDisplay(authToken, userProfile, Convert.ToDouble(totalScore?.Score), null, ValueFormatType.Decimal, 0, correlationId, null, false);
  199  					var toolTip = new TooltipCarrierBase(formattedScore);

  383  					var totalScore = driverScore.FirstOrDefault(s => s.EventId == 0);
  384: 					string formattedScore = EventDataConverter.GetEventDisplay(authToken, userProfile, Convert.ToDouble(totalScore?.Score), null, ValueFormatType.Decimal, template.OrgId, correlationId, null, false);
  385  					driverGraphData.Add(new MyMiXGraphPlotCarrier(NullRound(totalScore?.Score, 2), countString, FillType.Legend.GetDescription(), new TooltipCarrierBase(formattedScore), UnitsOfMeasureCarrierConverter.GetDistanceCarrier((double) driverDistanceAndDuration.Distance, userProfile), driverDistanceAndDuration.Duration));

  401  
  402: 					string formattedScore = EventDataConverter.GetEventDisplay(authToken, userProfile, Convert.ToDouble(totalScore?.Score), null, ValueFormatType.Decimal, template.OrgId, correlationId, null, false);
  403  					siteGraphData.Add(new GraphPlotCarrier(NullRound(totalScore?.Score, 2), countString, FillType.Legend.GetDescription(), new TooltipCarrierBase(formattedScore), statusType));

DynaMiX.Backend\DriverPortal\MiX.DriverPortal.Api\Converters\LightningDataConverters.cs:
  578  					{
  579: 						roadSpeedLimit = Convert.ToDouble(speedLimitStart).ToSpeedCarrier(userProfile);
  580  					}

  703  
  704: 			return Convert.ToDouble(value.Value).ToSpeedCarrier(userProfile);
  705  		}

DynaMiX.Backend\DriverPortal\MiX.DriverPortal.Api\Data\FlexibleScoringData.cs:
  1235  				{
  1236: 					eventValue = Convert.ToDouble($"{(int)evt.Duration.TotalHours}.{evt.Duration.Minutes}", CultureInfo.InvariantCulture);
  1237  					displayUnits = "Hrs";

DynaMiX.Backend\DriverPortal\MiX.DriverPortal.Api\Data\LightningPositionsData.cs:
  109  									{
  110: 										eventList[index].RoadSpeedLimit = new MobileSpeedCarrier("km/h", Convert.ToDouble(locData.SpeedLimitKilometresPerHour.Value));
  111  									}

DynaMiX.Backend\DriverPortal\MiX.DriverPortal.Api\Extensions\Strings\Extensions.cs:
  140  
  141: 			public static double ToDouble(this string _this)
  142  			{

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\ConfigAdmin\LibraryLevel\EventModuleIntegrationTests.cs:
  55  				Operator = ">=",
  56: 				ParameterId = Parameters.ODOMETER_READING.ToString(),
  57  				Value = "5",

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\ConfigAdmin\TemplateLevel\EventTemplateEventsModuleIntegrationTests.cs:
  66  				Operator = ">=",
  67: 				ParameterId = Parameters.ODOMETER_READING.ToString(),
  68  				Value = "5",

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\FleetAdmin\Assets\AssetCostDataModuleIntegrationTests.cs:
  49  				CategoryId = SqlTestDataConstants.CostData.AJK_CATEGORY_1.ToString(),
  50: 				Odometer = new DistanceCarrier
  51  				{

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\FleetAdmin\Assets\AssetServicingModuleIntegrationTests.cs:
  60  			AssetServiceHistoryCarrier carrier = new AssetServiceHistoryCarrier();
  61: 			carrier.Odometer.Value = 1000;
  62: 			carrier.Odometer.Unit = Unit.Kilometres;
  63  

  68  
  69: 			carrier.NextOdometer = new DistanceCarrier();
  70: 			carrier.NextOdometer.Value = 1234;
  71: 			carrier.NextOdometer.Unit = Unit.Kilometres;
  72  

  83  
  84: 			Assert.AreEqual(1000, result.Value.Value.Odometer.Value);
  85  
  86: 			result.Value.Value.Odometer.Value = 1100;
  87  			result.Value.Value.ServiceDate.IsoDateTimeString = "2012-12-15T12:00:00";

  90  
  91: 			Assert.AreEqual(1100, result.Value.Value.Odometer.Value);
  92  		}

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\JobsAndMessaging\MessageCrudModuleIntegrationTests.cs:
   51  
   52: 		[Test, Ignore("TODO JM: Our test databases are no longer compatible with the tests. Get a db with devices that support messaging")]
   53  		public void MessageFullCycle()

  149  
  150: 		[Test, Ignore("TODO JM: Our test databases are no longer compatible with the tests. Get a db with devices that support messaging")]
  151  		public void JobDraftFullCycle()

  230  
  231: 		[Test, Ignore("TODO JM: Our test databases are no longer compatible with the tests. Get a db with devices that support messaging")]
  232  		public void SendJobFullCycle()

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\Operations\DataCentreApiAccountsIntegrationTests.cs:
   35  			Assert.IsNotEmpty(result.Value.ConsumptionUnits);
   36: 			Assert.IsNotEmpty(result.Value.OdoUnits);
   37  			Assert.IsNotEmpty(result.Value.VolumeUnits);

  123  			carrier.ConsumptionUnitId = "0";
  124: 			carrier.OdoUnitId = "0";
  125  			carrier.VolumeUnitId = "0";

  145  			carrier.ConsumptionUnitId = "0";
  146: 			carrier.OdoUnitId = "0";
  147  			carrier.VolumeUnitId = "0";

  167  			carrier.ConsumptionUnitId = "0";
  168: 			carrier.OdoUnitId = "0";
  169  			carrier.VolumeUnitId = "0";

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\Operations\DriverAccessDefaultsIntegrationTests.cs:
  28  			Assert.That(result.Successful);
  29: 			//Assert.That(result.Value.AllowNewAssetsAccess); TODO unstable test data, fix after migration
  30  			Assert.NotNull(result.Value);

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\Scheduler\UploadScheduleDetailsModuleIntegrationTests.cs:
  55  			var carrier = GetSemiCompletedCarrier();
  56: 			carrier.ActionsOdometer = new DistanceCarrier {Unit = Unit.Kilometres, Value = 500};
  57  			carrier.ActionsEngineHours = 500;

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\UserManagement\Users\ImpersonationModuleIntegrationTests.cs:
  4  	{
  5: 		//TODO HM: Integration tests required
  6  	}

DynaMiX.Backend\DynaMiX.IntegrationTests\Api\UserManagement\Users\UserAccountModuleIntegrationTests.cs:
  19  
  20: 		//TODO HM: Integration tests required
  21  

DynaMiX.Backend\DynaMiX.IntegrationTests\Managers\Events\EventsManagerIntegrationTests.cs:
  38  			Assert.AreEqual(4, result.Count, "Incorrect number of events retrieved");
  39: 			//TODO: Compare the known values of one of the resuls to confirm that all properties are mapped correctly from SQL to the entity
  40  		}

DynaMiX.Backend\DynaMiX.IntegrationTests\Managers\Trips\TripsManagerIntegrationTest.cs:
  31  			var singleTrip = result.FirstOrDefault(t => t.SubTrips == 5);
  32: 			//TODO: Compare the known values of one of the resuls to confirm that all properties are mapped correctly from SQL to the entity
  33  

  46  			var singleTrip = result.FirstOrDefault();
  47: 			//TODO: Compare the known values of one of the resuls to confirm that all properties are mapped correctly from SQL to the entity
  48  		}

  61  			var singleTrip = result.FirstOrDefault(t => t.SubTrips == 5);
  62: 			//TODO: Compare the known values of one of the resuls to confirm that all properties are mapped correctly from SQL to the entity
  63  

  76  			var singleTrip = result.FirstOrDefault();
  77: 			//TODO: Compare the known values of one of the resuls to confirm that all properties are mapped correctly from SQL to the entity
  78  		}

DynaMiX.Backend\DynaMiX.IntegrationTests\OrganisationFeatures\OrganisationFeaturesTests.cs:
   26  
   27: 			orgDetail.AddFeature(OrgFeature.DtcoDownloadManagement);
   28  

   30  			Assert.AreEqual(orgDetail.Features.Count, 1);
   31: 			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
   32  

   38  			Assert.AreEqual(orgDetail.Features.Count, 1);
   39: 			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
   40  		}

   49  
   50: 			orgDetail.AddFeature(OrgFeature.DtcoDownloadManagement);
   51  			orgDetail.AddFeature(OrgFeature.JourneyManagement);

   54  			Assert.AreEqual(orgDetail.Features.Count, 2);
   55: 			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
   56  			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.JourneyManagement));

   63  			Assert.AreEqual(orgDetail.Features.Count, 2);
   64: 			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
   65  			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.JourneyManagement));

   73  
   74: 			orgDetail.AddFeature(OrgFeature.DtcoDownloadManagement);
   75  			orgDetail.AddFeature(OrgFeature.JourneyManagement);

   82  			Assert.AreEqual(orgDetail.Features.Count, 2);
   83: 			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
   84  			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.JourneyManagement));

   94  			Assert.AreEqual(orgDetail.Features.Count, 1);
   95: 			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
   96  			Assert.IsFalse(orgDetail.HasFeature(OrgFeature.JourneyManagement));

  104  
  105: 			orgDetail.AddFeature(OrgFeature.DtcoDownloadManagement);
  106  			orgDetail.AddFeature(OrgFeature.JourneyManagement);

  113  			Assert.AreEqual(orgDetail.Features.Count, 2);
  114: 			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
  115  			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.JourneyManagement));

  133  
  134: 			orgDetail.AddFeature(OrgFeature.DtcoDownloadManagement);
  135  

  141  			Assert.AreEqual(orgDetail.Features.Count, 1);
  142: 			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
  143  
  144  			//Remove feature
  145: 			orgDetail.RemoveFeature(OrgFeature.DtcoDownloadManagement);
  146  			//Add feature

  154  			Assert.AreEqual(orgDetail.Features.Count, 1);
  155: 			Assert.IsFalse(orgDetail.HasFeature(OrgFeature.DtcoDownloadManagement));
  156  			Assert.IsTrue(orgDetail.HasFeature(OrgFeature.JourneyManagement));

DynaMiX.Backend\DynaMiX.IntegrationTests\SqlTestData\DeviceConfigurationTestData.cs:
  176  
  177:         public static long AJK_ODOMETER_READING
  178          {

  181              string sql =
  182:               "SELECT LibraryParameterId FROM [dynamix].[LibraryParameters] WHERE LibraryId = " + SqlTestDataConstants.OrgGroups.ALJULAIAH_KUWAIT + " AND Description = 'Odometer reading'";
  183  

DynaMiX.Backend\DynaMiX.JourneyManagement.Entity.Mapping\EntityMapper.cs:
  241  				OrderIds = routeLocationDto.OrderIds,
  242: 				DepartureOdometer = routeLocationDto.DepartureOdometer,
  243: 				ArrivalOdometer = routeLocationDto.ArrivalOdometer,
  244  				IsOLCustomerLocation = routeLocationDto.IsOLCustomerLocation

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\DefinitionLevel\MessageTransportType.cs:
  14  		public bool CanDoFullDataDownload { get; set; }
  15: 		public bool CanDoFullTachoDownload { get; set; }
  16: 		public bool CanDoQuickTachoDownload { get; set; }
  17  		public bool CanDoFirmwareUpload { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\EventActions\IRecordingAction.cs:
  16  		/// <summary>
  17: 		/// Gets or sets whether to record the start odometer reading.
  18  		/// </summary>
  19: 		bool StartOdometer
  20  		{

  25  		/// <summary>
  26: 		/// Gets or sets whether to record the end odometer reading.
  27  		/// </summary>
  28: 		bool EndOdometer
  29  		{

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\EventActions\RecordingActionHelper.cs:
  11  		{
  12: 			get { return string.Format("<settings recordType='{0}' startOdometer='0' endOdometer='0' startPosition='0' endPosition='0' video='0' pulse='0' />", (int)RecordingTypes.Summarised); }
  13  		}

  65  		/// <summary>
  66: 		/// Gets or sets whether to record the start odometer reading.
  67  		/// </summary>
  68: 		public bool StartOdometer
  69  		{
  70: 			get { return _settings.GetBool("startOdometer"); }
  71: 			set { _settings.Set("startOdometer", value); }
  72  		}

  74  		/// <summary>
  75: 		/// Gets or sets whether to record the end odometer reading.
  76  		/// </summary>
  77: 		public bool EndOdometer
  78  		{
  79: 			get { return _settings.GetBool("endOdometer"); }
  80: 			set { _settings.Set("endOdometer", value); }
  81  		}

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\LibraryLevel\LibraryDeviceProperty.cs:
  28  
  29: 		public virtual PropertyDefinition PropertyDefinition { get; set; } //TODO HM: Figure oeeut how to get rid of this Overlapping aggregates
  30  

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\LibraryLevel\LibraryPeripheralDevice.cs:
  22  		public byte DeviceTypeId { get; set; }
  23: 		public virtual DeviceType DeviceType { get; set; } //TODO DDD: Get rid of this, overlapping aggregates
  24  

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\LibraryLevel\EventActions\RecordingAction.cs:
  20  		/// <summary>
  21: 		/// Gets or sets whether to record the start odometer reading.
  22  		/// </summary>
  23: 		public bool StartOdometer
  24  		{
  25: 			get { return _helper.StartOdometer; }
  26: 			set { _helper.StartOdometer = value; }
  27  		}

  29  		/// <summary>
  30: 		/// Gets or sets whether to record the end odometer reading.
  31  		/// </summary>
  32: 		public bool EndOdometer
  33  		{
  34: 			get { return _helper.EndOdometer; }
  35: 			set { _helper.EndOdometer = value; }
  36  		}

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\MobileUnitLevel\MiX2310iStatusResource.cs:
  27  		public byte NoOfSatellites { get; set; }
  28: 		public int Odometer { get; set; }
  29  		public string PlatformVersion { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\MobileUnitLevel\EventActions\OverridenRecordingAction.cs:
  19  		/// <summary>
  20: 		/// Gets or sets whether to record the start odometer reading.
  21  		/// </summary>
  22: 		public bool StartOdometer
  23  		{
  24: 			get { return _helper.StartOdometer; }
  25: 			set { _helper.StartOdometer = value; }
  26  		}

  28  		/// <summary>
  29: 		/// Gets or sets whether to record the end odometer reading.
  30  		/// </summary>
  31: 		public bool EndOdometer
  32  		{
  33: 			get { return _helper.EndOdometer; }
  34: 			set { _helper.EndOdometer = value; }
  35  		}

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\ResolvedConfig\Event\EventActions\ObjRecordingAction.cs:
  23  
  24: 		public bool StartOdometer
  25  		{
  26: 			get { return _helper.StartOdometer; }
  27: 			set { _helper.StartOdometer = value; }
  28  		}
  29  
  30: 		public bool EndOdometer
  31  		{
  32: 			get { return _helper.EndOdometer; }
  33: 			set { _helper.EndOdometer = value; }
  34  		}

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\TemplateLevel\TemplateDeviceParameter.cs:
  23  
  24: 		//TODO CONFIG: Get rid of the below 2 properties, all you should need are the definition level id's
  25  		public long LibraryParameterId { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\TemplateLevel\EventActions\TemplateRecordingAction.cs:
  19  		/// <summary>
  20: 		/// Gets or sets whether to record the start odometer reading.
  21  		/// </summary>
  22: 		public bool StartOdometer
  23  		{
  24: 			get { return _helper.StartOdometer; }
  25: 			set { _helper.StartOdometer = value; }
  26  		}

  28  		/// <summary>
  29: 		/// Gets or sets whether to record the end odometer reading.
  30  		/// </summary>
  31: 		public bool EndOdometer
  32  		{
  33: 			get { return _helper.EndOdometer; }
  34: 			set { _helper.EndOdometer = value; }
  35  		}

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOArchiveSettings.cs:
  1: namespace DynaMiX.Entities.DTCODownloadManagement
  2  {

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOAuthenticationService.cs:
  1: namespace DynaMiX.Entities.DTCODownloadManagement
  2  {

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOCompanyCardState.cs:
  2  
  3: namespace DynaMiX.Entities.DTCODownloadManagement
  4  {

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOCompanyCardStateTypes.cs:
  1: namespace DynaMiX.Entities.DTCODownloadManagement
  2  {

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOCompanyCardStatus.cs:
  2  
  3: namespace DynaMiX.Entities.DTCODownloadManagement
  4  {

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCODownloadData.cs:
   3  
   4: namespace DynaMiX.Entities.DTCODownloadManagement
   5  {
   6: 	public class DTCODownloadData
   7  	{

  11  
  12: 		public DTCODownloadData()
  13  		{

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOFile.cs:
  2  
  3: namespace DynaMiX.Entities.DTCODownloadManagement
  4  {

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOMappedItem.cs:
  1: namespace DynaMiX.Entities.DTCODownloadManagement
  2  {

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCORemoteTask.cs:
   2  
   3: namespace DynaMiX.Entities.DTCODownloadManagement
   4  {

  13  		public string DownloadType { get; set; }		
  14: 		public DTCODownloadData DTCODownloadData  { get; set; }
  15  		public long AssetId { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCORemoteTaskStateTypes.cs:
  1: namespace DynaMiX.Entities.DTCODownloadManagement
  2  {

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOSettingsScheduleFrequency.cs:
  1: namespace DynaMiX.Entities.DTCODownloadManagement
  2  {

  5  		public long OrgId { get; set; }
  6: 		public DTCODownloadData DTCODownloadData { get; set; }
  7  	}

DynaMiX.Backend\Entities\DynaMiX.Entities\DTCODownloadManagement\DTCOStatusDiagnostics.cs:
  1  using System;
  2: namespace DynaMiX.Entities.DTCODownloadManagement
  3  {

DynaMiX.Backend\Entities\DynaMiX.Entities\Events\ActiveEventDetail.cs:
  34  		public Coordinate GeoPoint { get; set; }
  35: 		public decimal Odometer { get; set; }
  36  		public decimal Speed { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\Events\EventData.cs:
  12  		{
  13: 			OdometerUnits = MiX.Core.Conversion.Unit.Kilometres;
  14  			LitresUnits = MiX.Core.Conversion.Unit.Litres;

  27  		public ZonedDateTime DisplayEndDateTime { get; set; }
  28: 		public float? StartOdometer { get; set; }
  29: 		public float? EndOdometer { get; set; }
  30: 		public string OdometerUnits { get; set; }
  31  		public int? StartGpsId { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\Events\EventDataSummary.cs:
  34  
  35: 		public decimal? StartOdometer { get; set; }
  36  

  42  
  43: 		public decimal? EndOdometer { get; set; }
  44  

  69  				DisplayUnits = item.DisplayUnits,
  70: 				EndOdometer = item.EndOdometer,
  71  				EndPosition = item.EndPosition,

  82  				SpeedLimit = item.SpeedLimit,
  83: 				StartOdometer = item.StartOdometer,
  84  				StartPosition = item.StartPosition,

DynaMiX.Backend\Entities\DynaMiX.Entities\Feeds\FeedEntries\FeedEntry.cs:
  206  
  207: 		public decimal Odometer { get; set; }
  208  

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Assets\Asset.cs:
  119  
  120: 		public float? Odometer { get; set; }
  121  

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Assets\AssetFuelUsage.cs:
  16  		[Required(ErrorMessage = ErrorMessages.GeneralValidation.REQUIRED)]
  17: 		public double Odometer { get; set; }
  18  

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Assets\AssetServiceHistory.cs:
  16  		[Required(ErrorMessage = ErrorMessages.GeneralValidation.REQUIRED)]
  17: 		public double Odometer { get; set; }
  18  

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Assets\AssetSummary.cs:
  12  		{
  13: 			OdometerUnits = Unit.Kilometres;
  14  			TargetFuelConsumptionUnits = MiX.Core.Conversion.Unit.KilometresPerLitre;

  46  
  47: 		public float? Odometer { get; set; }
  48  
  49: 		public string OdometerUnits { get; set; }
  50  

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Assets\AssetTrailerDetails.cs:
  43  		public DateTime TrailerIdDate { get; set; }
  44: 		public double Odometer { get; set; }
  45: 		public DateTime? OdometerDate { get; set; }
  46  	}

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Assets\CostData\CostTransaction.cs:
  27  		[PositiveFloat(ErrorMessage = ErrorMessages.GeneralValidation.POSITIVE_FLOAT)]
  28: 		public decimal Odometer { get; set; }
  29  

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Assets\Reminders\AssetServiceReminder.cs:
  43  		{
  44: 			if (!EnableOnDistance || asset == null || !asset.Odometer.HasValue || !NextServiceDueAtKm.HasValue)
  45  				return null;
  46: 			return NextServiceDueAtKm.Value - asset.Odometer.Value;
  47  		}

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Diagnostics\AssetMix4kDetails.cs:
  11  		public string vehicleMode { get; set; }
  12: 		//public string odometer { get; set; } // rather using AssetStatusDetails.AssetStatus.Odometer fetched by AssetsManager
  13  		public string imsi { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Diagnostics\AssetStatus.cs:
  15  			SpeedUnits = MiX.Core.Conversion.Unit.KilometresPerHour;
  16: 			OdometerUnits = MiX.Core.Conversion.Unit.Kilometres;
  17  			SubTripDistanceUnits = MiX.Core.Conversion.Unit.Kilometres;

  42  
  43: 		[ConvertibleValue(MiX.Core.Conversion.Unit.Kilometres, UnitsPropertyName = "OdometerUnits")]
  44: 		public float? Odometer { get; set; }
  45: 		public string OdometerUnits { get; set; }
  46: 		public float? VehicleLastOdo { get; set; }
  47  

DynaMiX.Backend\Entities\DynaMiX.Entities\HOS\HosWorkStateData.cs:
  19  		public string DistanceUnits { get; set; }
  20: 		public decimal StartOdometer { get; set; }
  21: 		public string StartOdometerUnits { get; set; }
  22  		public HosLocationData Location { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\HOS\OdometerRangeValueData.cs:
   5  {
   6: 	public class OdometerRangeValueData
   7  	{
   8: 		public OdometerRangeValueData()
   9  		{
  10: 			OdometerUnits = Unit.Kilometres;
  11  		}
  12  
  13: 		public decimal OdometerMinValue { get; set; }
  14: 		public decimal OdometerMaxValue { get; set; }
  15: 		public string OdometerUnits { get; set; }
  16  

  18  		{
  19: 			return $"{OdometerMinValue}-{OdometerMaxValue}({OdometerUnits})";
  20  		}

DynaMiX.Backend\Entities\DynaMiX.Entities\JobsAndMessaging\MessageTemplate.cs:
  17  		[Required(ErrorMessage = ErrorMessages.GeneralValidation.REQUIRED)]
  18: 		//todo: length validation
  19  		[StringLength(1000, ErrorMessage = ErrorMessages.GeneralValidation.STRING_LENGTH_1000)]

DynaMiX.Backend\Entities\DynaMiX.Entities\JobsAndMessaging\Messages\CommandMessages\UpdateAssetTimezoneDeviation.cs:
  16  		{
  17: 			//TODO: MR: Do we have a need for this?
  18  			get { return new List<long> {DynaMiX.Common.Tracking.Permissions.COMMANDS_TO_MOBILE_DEVICE}; }

  32  		{
  33: 			//TODO: MR: Do we have a need for this?
  34  			get

  43  
  44: 		//TODO: Should ExpiryDate be more than 1day in future?
  45  

DynaMiX.Backend\Entities\DynaMiX.Entities\Mapping\MapLocationDetail.cs:
  228  					{
  229: 						var dRadius = Convert.ToDouble(location.Radius);
  230  						var centre = new Coordinate(location.CentrePoint.Longitude, location.CentrePoint.Latitude);

DynaMiX.Backend\Entities\DynaMiX.Entities\Notifications\DataEntities\NotificationHistoryItem.cs:
  62  		[AddParameter]
  63: 		public double? Odometer { get; set; }
  64  

DynaMiX.Backend\Entities\DynaMiX.Entities\Operations\OrganisationFeature.cs:
  12  	{
  13: 		DtcoDownloadManagement,
  14  		JourneyManagement,

DynaMiX.Backend\Entities\DynaMiX.Entities\Scheduler\AssetUploadScheduleDetails.cs:
  25  		public long? DisarmDriverId { get; set; }
  26: 		public int? SetOdoKmValue { get; set; }
  27  		public TimeSpan? SetEngineHoursValue { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\Scheduler\DownloadScheduleDetails.cs:
  24  
  25: 		public TachoDownloadType TachoDownloadType { get; set; }
  26  		public ZonedDateTime TachoStart { get; set; }

  40  
  41: 			if (TachoDownloadType == TachoDownloadType.Windowed)
  42  			{

DynaMiX.Backend\Entities\DynaMiX.Entities\Scheduler\ScheduleTargetType.cs:
  8  {
  9: 	//todo jm rename
  10  	public enum ScheduleTargetType : byte

DynaMiX.Backend\Entities\DynaMiX.Entities\Scheduler\TachoDownloadTypes.cs:
   9  {
  10: 	public enum TachoDownloadType : byte
  11  	{

DynaMiX.Backend\Entities\DynaMiX.Entities\SupportTools\DriverAuditLog.cs:
  16  		public string EventStart { get; set; }
  17: 		public string Odometer { get; set; }
  18  		public string EngineHours { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\Trips\TripAndSubTripSummary.cs:
  97  		public decimal Distance { get; set; }
  98: 		public decimal Odometer { get; set; }
  99  		public long? StartPositionId { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\Trips\TripDataSummaries.cs:
   8  		{
   9: 			OdometerUnits = MiX.Core.Conversion.Unit.Kilometres;
  10  			TripDistanceUnits = MiX.Core.Conversion.Unit.Kilometres;

  19  		public string TripDistanceUnits { get; set; }
  20: 		public decimal Odometer { get; set; }
  21: 		public string OdometerUnits { get; set; }
  22  		public decimal MaxSpeed { get; set; }

DynaMiX.Backend\Logic\DynaMiX.Logic\UnitsConverter.cs:
   36  		{
   37: 			//todo jm: cache this
   38  			PropertyInfo valuePropInfo = ReflectionHelper.GetProperty(valueProperty);

   45  			{
   46: 				double currentValue = Convert.ToDouble(objCurrentValue);
   47  				double convertedValue = Converter.ConvertValue(currentValue, currentUnit, toUnit);

   78  
   79: 			//todo jm: cache this
   80  			PropertyInfo valuePropInfo = ReflectionHelper.GetProperty(valueProperty);

   91  			{
   92: 				double currentValue = Convert.ToDouble(objCurrentValue);
   93  				double convertedValue;

  234  		{
  235: 			double currentValue = Convert.ToDouble(val);
  236  			double convertedValue = Converter.ConvertValue(currentValue, StandardUnits.Speed, unit);

  241  		{
  242: 			double currentValue = Convert.ToDouble(val);
  243  			double convertedValue = Converter.ConvertValue(currentValue, StandardUnits.Distance, unit);

  248  		{
  249: 			double currentValue = Convert.ToDouble(val);
  250  			double convertedValue = Converter.ConvertValue(currentValue, unit, StandardUnits.Distance);

  641  				case TypeCode.Decimal:
  642: 					if (convertedValue < Convert.ToDouble(decimal.MinValue) || convertedValue > Convert.ToDouble(decimal.MaxValue))
  643  					{

  651  				case TypeCode.Single:
  652: 					if (convertedValue < Convert.ToDouble(Single.MinValue) || convertedValue > Convert.ToDouble(Single.MaxValue))
  653  					{

  661  				case TypeCode.Int64:
  662: 					if (convertedValue < Convert.ToDouble(Int64.MinValue) || convertedValue > Convert.ToDouble(Int64.MaxValue))
  663  					{

  671  				case TypeCode.UInt64:
  672: 					if (convertedValue < Convert.ToDouble(UInt64.MinValue) || convertedValue > Convert.ToDouble(UInt64.MaxValue))
  673  					{

  681  				case TypeCode.Int32:
  682: 					if (convertedValue < Convert.ToDouble(Int32.MinValue) || convertedValue > Convert.ToDouble(Int32.MaxValue))
  683  					{

  691  				case TypeCode.UInt32:
  692: 					if (convertedValue < Convert.ToDouble(UInt32.MinValue) || convertedValue > Convert.ToDouble(UInt32.MaxValue))
  693  					{

  701  				case TypeCode.Int16:
  702: 					if (convertedValue < Convert.ToDouble(Int16.MinValue) || convertedValue > Convert.ToDouble(Int16.MaxValue))
  703  					{

  711  				case TypeCode.UInt16:
  712: 					if (convertedValue < Convert.ToDouble(UInt16.MinValue) || convertedValue > Convert.ToDouble(UInt16.MaxValue))
  713  					{

  721  				case TypeCode.Byte:
  722: 					if (convertedValue < Convert.ToDouble(Byte.MinValue) || convertedValue > Convert.ToDouble(Byte.MaxValue))
  723  					{

DynaMiX.Backend\Logic\DynaMiX.Logic\BaseApp\Authorisation\IAuthorisationManager.cs:
  94  
  95: 		//todo jm
  96  		ISession AuthoriseSessionOnAnyChild(string authToken, long permissionId, long groupId, string action);

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceCapabilityManager.cs:
   72  		int GetSatDailyLimitForAsset(long orgId, long assetId);
   73: 		void SetOdometer(string authToken, long orgId, long assetId, double value, string unit, double persistedValue, bool deviceMustUpdateAssetDB = true);
   74  		void SetEngineSeconds(string authToken, long orgId, long assetId, long engineSeconds, long oldEngineSeconds, bool deviceMustUpdateAssetDB = true);

  200  
  201: 		//TODO	Herbie needs to optimize this with a stored proc
  202  		public Dictionary<long, string> GetIridiumImeiForAssets(long orgId, List<long> assetIds)

  231  
  232: 		public void SetOdometer(string authToken, long orgId, long assetId, double value, string unit, double persistedValue, bool deviceMustUpdateAssetDB = true)
  233  		{
  234: 			float odometerKilometer = ConvertToKilometer(value, unit);
  235: 			float oldOdoKilometer = ConvertToKilometer(persistedValue, unit);
  236  

  243  				ITrackAndTraceMobileUnitManager trackAndTraceMobileUnitManager = DependencyResolver.GetInstance<ITrackAndTraceMobileUnitManager>();
  244: 				trackAndTraceMobileUnitManager.SetOdometer(authToken, orgId, assetId, odometerKilometer, deviceMustUpdateAssetDB);
  245  			}

  248  				IMesaMobileUnitManager mesaMobileUnitManager = DependencyResolver.GetInstance<IMesaMobileUnitManager>();
  249: 				mesaMobileUnitManager.SetOdometer(authToken, orgId, assetId, odometerKilometer, deviceMustUpdateAssetDB);
  250  			}
  251  
  252: 			var odometerValue = Convert.ToInt64(Math.Round(System.Convert.ToDouble(odometerKilometer.ToString()) * 1000));
  253: 			var oldOdometerValue = Convert.ToInt64(Math.Round(System.Convert.ToDouble(oldOdoKilometer.ToString()) * 1000));
  254  			
  255: 			var result = DeviceConfigClient.MobileUnits.SetMobileUnitOdometerMeters(authToken, orgId, assetId, odometerValue, oldOdometerValue).ConfigureAwait(false).GetAwaiter().GetResult();
  256: 			DmXLogger.Log($"ConfigApi SetMobileUnitOdometerMeters returned {result.ToString().ToUpper()} for AssetId={assetId.ToString()}, OdometerValue={odometerValue}, OldOdometerValue={oldOdometerValue}", LogLevel.Production, CorrelationId.ToString());
  257  		}

  579  			{
  580: 				if (Convert.ToDouble(batteryVoltage) <= 3500)
  581  				{

  583  				}
  584: 				if (Convert.ToDouble(batteryVoltage) <= 3700)
  585  				{

  587  				}
  588: 				else if (Convert.ToDouble(batteryVoltage) <= 3850)
  589  				{

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs:
  120  		void SetConfigurationStatus(string authToken, long assetId, ConfigurationStatus configChanged, string updatedby);
  121: 		string GetDevicePropertyValueForAsset(long orgId, long assetId, long deviceId, long propertyId); // TODO Nuke this
  122  		void UpdateAssetTimezoneDeviation(string authToken, long orgId, long siteId, List<long> assetIds, UserProfile currentUserProfile, long correlationId, DSTOptionalFields dstOptionalFields = null);

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\ConfigAdminConverters.cs:
   40  					DateTimeOffset dateValue = DateTimeOffset.Parse(carrierValue);
   41: 					return (((Convert.ToDouble(dateValue.Hour) * 3600)
   42: 									 + (Convert.ToDouble(dateValue.Minute) * 60)
   43: 									 + Convert.ToDouble(dateValue.Second)) / 86400).ToString();
   44  				}

   67  						MiX.Core.Conversion.Converter.ConvertToSystem(
   68: 							sourceValue.ToDouble(),
   69  							string.IsNullOrEmpty(fromUnit) ? MiX.Core.Conversion.Unit.KilometresPerHour : fromUnit,

   78  					MiX.Core.Conversion.Converter.ConvertToSystem(
   79: 						sourceValue.ToDouble(),
   80  						string.IsNullOrEmpty(fromUnit) ? MiX.Core.Conversion.Unit.Kilometres : fromUnit,

   88  					MiX.Core.Conversion.Converter.ConvertToSystem(
   89: 						sourceValue.ToDouble(),
   90  						string.IsNullOrEmpty(fromUnit) ? MiX.Core.Conversion.Unit.Metres : fromUnit,

   98  					MiX.Core.Conversion.Converter.ConvertToSystem(
   99: 						sourceValue.ToDouble(),
  100  						string.IsNullOrEmpty(fromUnit) ? MiX.Core.Conversion.Unit.Litres : fromUnit,

  112  					MiX.Core.Conversion.Converter.ConvertToSystem(
  113: 						sourceValue.ToDouble(),
  114  						string.IsNullOrEmpty(fromUnit) ? MiX.Core.Conversion.Unit.DegreesCelcius : fromUnit,

  124  						{
  125: 							double uk = Math.Round(MetricTonneToLongTon(sourceValue.ToDouble()), ConfigAdminSettings.Current.Precision);
  126  							return new Tuple<string, string>(uk + "", "t");

  129  						{
  130: 							double us = MetricTonneToShortTon(sourceValue.ToDouble());
  131  							return new Tuple<string, string>(us + "", "t (US)");

  133  
  134: 						return new Tuple<string, string>(sourceValue.ToDouble() + "", "t"); // the user is using metric
  135  					}

  139  						{
  140: 							double uk = Math.Round(KgToLbs(sourceValue.ToDouble()), ConfigAdminSettings.Current.Precision);
  141  							return new Tuple<string, string>(uk + "", "lbs");

  143  
  144: 						return new Tuple<string, string>(sourceValue.ToDouble() + "", "kg"); // the user is using metric
  145  					}

  147  					MiX.Core.Conversion.Converter.ConvertToSystem(
  148: 						sourceValue.ToDouble(),
  149  						string.IsNullOrEmpty(fromUnit) ? MiX.Core.Conversion.Unit.KilometresPerHourPerSecond : fromUnit,

  157  					MiX.Core.Conversion.Converter.ConvertToSystem(
  158: 						sourceValue.ToDouble(),
  159  						string.IsNullOrEmpty(fromUnit) ? MiX.Core.Conversion.Unit.KilometresPerLitre : fromUnit,

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\FirmwareSetResolver.cs:
  22  		{
  23: 			//Todo: DCG-70 - Required Firmware Version 
  24  			bool isFm300V3 = false;

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MesaMobileUnitManager.cs:
  16  	{
  17: 		void SetOdometer(string authToken, long orgId, long assetId, float odometerKilometer, bool deviceMustUpdateAssetDB = true);
  18  

  36  
  37: 		public void SetOdometer(string authToken, long orgId, long assetId, float odometerKilometer, bool deviceMustUpdateAssetDB = true)
  38  		{
  39  			if (deviceMustUpdateAssetDB)
  40: 				AssetsManager.UpdateAssetLastOdo(authToken, orgId, assetId, odometerKilometer);
  41  		}

  47  			{
  48: 				//TODO: log an error message?
  49  				return;

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs:
  1155  					overridenRecordingAction.RecordPulseCount = templateRecordingActionFromUi.RecordPulseCount;
  1156: 					overridenRecordingAction.StartOdometer = templateRecordingActionFromUi.StartOdometer;
  1157  					overridenRecordingAction.StartPosition = templateRecordingActionFromUi.StartPosition;
  1158: 					overridenRecordingAction.EndOdometer = templateRecordingActionFromUi.EndOdometer;
  1159  					overridenRecordingAction.EndPosition = templateRecordingActionFromUi.EndPosition;

  1170  					overridenRecordingAction.RecordPulseCount = templateRecordingActionFromUi.RecordPulseCount;
  1171: 					overridenRecordingAction.StartOdometer = templateRecordingActionFromUi.StartOdometer;
  1172  					overridenRecordingAction.StartPosition = templateRecordingActionFromUi.StartPosition;
  1173: 					overridenRecordingAction.EndOdometer = templateRecordingActionFromUi.EndOdometer;
  1174  					overridenRecordingAction.EndPosition = templateRecordingActionFromUi.EndPosition;

  1451  			|| (templateRecordingActionFromUi.RecordingType != templateRecordingActionFromDb.RecordingType)
  1452: 			|| (templateRecordingActionFromUi.StartOdometer != templateRecordingActionFromDb.StartOdometer)
  1453  			|| (templateRecordingActionFromUi.StartPosition != templateRecordingActionFromDb.StartPosition)
  1454: 			|| (templateRecordingActionFromUi.EndOdometer != templateRecordingActionFromDb.EndOdometer)
  1455  			|| (templateRecordingActionFromUi.EndPosition != templateRecordingActionFromDb.EndPosition)

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\TrackAndTraceMobileUnitManager.cs:
   35  	{
   36: 		void SetOdometer(string authToken, long orgId, long assetId, float odometerKilometer, bool deviceMustUpdateAssetDB = true);
   37  
   38: 		float? GetLastOdometer(string authToken, long orgId, long assetId);
   39  

  155  		[Authorise]
  156: 		public float? GetLastOdometer(string authToken, long orgId, long assetId)
  157  		{
  158: 			float? odo = AssetsManager.GetLastOdo(authToken, orgId, assetId);
  159: 			return odo;
  160  		}

  162  		[Authorise]
  163: 		public void SetOdometer(string authToken, long orgId, long assetId, float odometerKilometer, bool deviceMustUpdateAssetDB = true)
  164  		{

  183  				if (deviceMustUpdateAssetDB)
  184: 					AssetsManager.UpdateAssetLastOdo(authToken, orgId, assetId, odometerKilometer);
  185  			}

  192  					rmd.UnitIdentifier,
  193: 					DeviceCommandType.SetOdometer);
  194: 				deviceCommandMessage.SetProperty(DsiMessagePropertyName.OdometerKilometres, odometerKilometer);
  195  				repo.SendMessage(deviceCommandMessage);

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\EventTemplateManager.cs:
  349  				templateRecordingAction.Delay = libraryRecordingAction.Delay;
  350: 				templateRecordingAction.StartOdometer = libraryRecordingAction.StartOdometer;
  351: 				templateRecordingAction.EndOdometer = libraryRecordingAction.EndOdometer;
  352  				templateRecordingAction.StartPosition = libraryRecordingAction.StartPosition;

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Validation\ValueFormatType\Extensions.cs:
  10  	{
  11: 		//TODO: Make instance method
  12  		public static IEnumerable<ValidationResult> ValidateCustomValueTypes(this LibraryDeviceProperty entity, string authenticationToken, long organisationGroupId, ICustomValidatorResolver validatorResolver)

DynaMiX.Backend\Logic\DynaMiX.Logic\DTCODownloadManagement\DTCODownloadManagementManager.cs:
    6  using DynaMiX.Common.Constants;
    7: using DynaMiX.Common.DTCODownloadManagement;
    8  using DynaMiX.Core.Runtime;
    9  using DynaMiX.Core.Runtime.Resolver;
   10: using DynaMiX.Data.DTCODownloadManagement;
   11  using DynaMiX.Data.FleetAdmin;
   12: using DynaMiX.Entities.DTCODownloadManagement;
   13  using DynaMiX.Entities.FleetAdmin.Assets;

   18  
   19: namespace DynaMiX.Logic.DTCODownloadManagement
   20  {
   21: 	public interface IDTCODownloadManagementManager
   22  	{

   49  	[BindingProvider]
   50: 	public class DTCODownloadManagementManager : ManagerBase, IDTCODownloadManagementManager
   51  	{
   52: 		private IDTCODownloadManagementRepository _dtcoDownloadManagementRepository;
   53  		private IOrganisationManager _organisationManager;
   54  
   55: 		public IDTCODownloadManagementRepository DtcoDownloadManagementRepository
   56  		{
   57: 			get { return _dtcoDownloadManagementRepository ?? (_dtcoDownloadManagementRepository = DependencyResolver.GetInstance<IDTCODownloadManagementRepository>()); }
   58: 			set { _dtcoDownloadManagementRepository = value; }
   59  		}

   82  
   83: 		public DTCODownloadManagementManager(IContext context)
   84  		{

   92  		{
   93: 			Bind<IDTCODownloadManagementManager>.To(context => new DTCODownloadManagementManager(context)).AsSingleton();
   94  		}

   97  		{
   98: 			return DtcoDownloadManagementRepository.GetSettingsScheduleFrequency(orgId);
   99  		}

  102  		{
  103: 			return DtcoDownloadManagementRepository.UpdateSettingsScheduleFrequency(orgId, scheduleFrequency);
  104  		}

  107  		{
  108: 			return DtcoDownloadManagementRepository.GetDtcoStatusDiagnostics(imeiNumber);
  109  		}

  112  		{
  113: 			return DtcoDownloadManagementRepository.GetAutenticationServices(orgId);
  114  		}

  117  		{
  118: 			return DtcoDownloadManagementRepository.GetAutenticationServices(groupIds);
  119  		}

  122  		{
  123: 			var companyCards = DtcoDownloadManagementRepository.GetCompanyCards(groupIds);
  124  

  141  		{
  142: 			return DtcoDownloadManagementRepository.GetDtcoFilesList(orgId, groupId, fromDateTime, toDateTime, assetDataTimeZone);
  143  		}

  146  		{
  147: 			return DtcoDownloadManagementRepository.GetDtcoFilesZipped(dtcoFileIdList);
  148  		}

  151  		{
  152: 			var tasks = DtcoDownloadManagementRepository.GetRemoteTasks(orgId, fromDateTime, toDateTime).ToList();
  153  

  166  		{
  167: 			return DtcoDownloadManagementRepository.GetCompanyCard(cardSerial);
  168  		}

  171  		{
  172: 			return DtcoDownloadManagementRepository.AddCompanyCard(companyCard);
  173  		}

  176  		{
  177: 			return DtcoDownloadManagementRepository.DeleteCompanyCard(companyCard);
  178  		}

  181  		{
  182: 			return DtcoDownloadManagementRepository.GetDownloadTask(orgId, downloadTaskId);
  183  		}

  186  		{
  187: 			return DtcoDownloadManagementRepository.AddDownloadTask(downloadTask);
  188  		}

  191  		{
  192: 			return DtcoDownloadManagementRepository.UpdateDownloadTask(orgId, downloadTask);
  193  		}

  196  		{
  197: 			return DtcoDownloadManagementRepository.GetDtcoArchiveSettings(orgId);
  198  		}

  200  		{
  201: 			return DtcoDownloadManagementRepository.GetDtcoArchiveSettings(groupIds);
  202  		}

  204  		{
  205: 			return DtcoDownloadManagementRepository.UpdateDtcoArchiveSettings(archiveSettings);
  206  		}

  209  		{
  210: 			return VersionCheck.GetLatestVersion(DTCODownloadManagementSettings.Current.AuthServiceVersionFile);
  211  		}

  214  		{
  215: 			return VersionCheck.IsLatestVersion(currentVersion, DTCODownloadManagementSettings.Current.AuthServiceVersionFile);
  216  		}

  219  		{
  220: 			return VersionCheck.GetLatestVersion(DTCODownloadManagementSettings.Current.DownloadServiceVersionFile);
  221  		}

  224  		{
  225: 			return VersionCheck.IsLatestVersion(currentVersion, DTCODownloadManagementSettings.Current.DownloadServiceVersionFile);
  226  		}

  229  		{
  230: 			return DtcoDownloadManagementRepository.GetFileNamingConvention(orgId);
  231  		}

  234  		{
  235: 			return DtcoDownloadManagementRepository.SaveFileNamingConvention(orgId, fileNamingConvention);
  236  		}

DynaMiX.Backend\Logic\DynaMiX.Logic\Events\ActiveEventManager.cs:
  814  				LibraryLevel.LibraryEvent libEventSummary;
  815: 				//TODO: Remove after LRD-28 is fixed
  816  				if (!libraryEventKeyPair.TryGetValue(ev.EventTypeId, out libEventSummary))

  922  				activeEventDetail.Altitude = (short?)serviceEvent.StartPosition.AltitudeMetres;
  923: 				activeEventDetail.Odometer = serviceEvent.StartOdometerKilometres ?? default(decimal);
  924  				activeEventDetail.Speed = (decimal?)serviceEvent.StartPosition.SpeedKilometresPerHour ?? default(decimal);

  976  
  977: 			activeEventDetail.Odometer = serviceEvent.StartOdometerKilometres ?? default(decimal);
  978  			if (serviceEvent.StartPosition != null)

DynaMiX.Backend\Logic\DynaMiX.Logic\Events\EventDataManager.cs:
  687  
  688: 				if (serviceEvent.StartOdometerKilometres.HasValue)
  689: 					eventData.StartOdometer = (float)serviceEvent.StartOdometerKilometres.Value;
  690: 				if (serviceEvent.EndOdometerKilometres.HasValue)
  691: 					eventData.EndOdometer = (float)serviceEvent.EndOdometerKilometres.Value;
  692  				if (serviceEvent.Litres.HasValue)

  794  					EventValue = serviceEvent.Value,
  795: 					StartOdometer = serviceEvent.StartOdometerKilometres,
  796: 					EndOdometer = serviceEvent.EndOdometerKilometres,
  797  					AssetId = serviceEvent.AssetId,

  938  
  939: 			if (serviceResult.StartOdometerKilometres.HasValue)
  940: 				eventData.StartOdometer = (float)serviceResult.StartOdometerKilometres.Value;
  941: 			if (serviceResult.EndOdometerKilometres.HasValue)
  942: 				eventData.EndOdometer = (float)serviceResult.EndOdometerKilometres.Value;
  943  

DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:
  620  						//Updating the unique identifier to something that does not exist, causes the merge statement to delete it from the controller db.
  621: 						AssetsRepository.UpdateTrackAndTraceUnitIdentifiersAsync(orgId, assetId, mdt.DsiMobileDeviceType, null, CurrentSession.FullName, securityAccounts, correlationId).ConfigureAwait(false).GetAwaiter().GetResult(); //TODO: move to assets manager
  622  					}

DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetKeypadManager.cs:
  101  		{
  102: 			//TODO HM: Use resolved mobile device for this
  103  			bool isConfigChanged = false;

  226  		{
  227: 			//TODO HM: Use resolved mobile device for this
  228  			List<MobileUnit> mobileUnits = ConfigAdminRepository.GetMobileUnitAggregates(assetIds);

DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\Assets\AssetConverter.cs:
   49  				MovementStatus = dto.MovementStatus.ToMovementStatus(),
   50: 				Odometer = dto.Odometer,
   51: 				OdometerUnits = dto.OdometerUnits,
   52  				RegistrationNumber = dto.RegistrationNumber,

   80  				VehicleStatus = dto.VehicleStatus,
   81: 				VehicleLastOdo = dto.VehicleLastOdo
   82  			};

  130  				Notes = dto.Notes,
  131: 				Odometer = dto.Odometer,
  132  				RegistrationNumber = dto.RegistrationNumber,

  213  				Location = dto.Location,
  214: 				Odometer = dto.Odometer
  215  			};

  290  				Location = entity.Location,
  291: 				Odometer = entity.Odometer
  292  			};

  492  				MovementStatus = ToMovementStatus(dto.MovementStatus),
  493: 				Odometer = dto.Odometer,
  494: 				OdometerUnits = dto.OdometerUnits,
  495  				RegistrationNumber = dto.RegistrationNumber,

  518  				Notes = entity.Notes,
  519: 				Odometer = entity.Odometer,
  520  				Reference = entity.Reference,

  537  				Notes = dto.Notes,
  538: 				Odometer = dto.Odometer,
  539  				Reference = dto.Reference,

  655  				Memo = dto.Memo,
  656: 				Odometer = dto.Odometer,
  657  				RecurringCostId = dto.RecurringCostId,

  674  				Memo = entity.Memo,
  675: 				Odometer = entity.Odometer,
  676  				RecurringCostId = entity.RecurringCostId,

DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\Assets\AssetManager.cs:
   376  
   377: 		//TODO :CB Check Performance 
   378  		public List<AssetSummary> GetAssetSummaries(string authToken, long orgId, List<long> groupIds)

   518  
   519: 			//TODO: Needs to find a way to manage this scenario
   520  			try

   588  				{
   589: 					if (assetExtendedSummary.Odometer == 0)
   590: 						assetExtendedSummary.Odometer = null;
   591  					else
   592: 						assetExtendedSummary.Odometer = assetExtendedSummary.Odometer;
   593  				}

   625  					assetDetails.AssetConfigDetails.Msisdn = string.Empty;
   626: 					assetDetails.Asset.Odometer = 0;
   627  				}

  1303  			fleetAsset.Notes = asset.Notes;
  1304: 			fleetAsset.Odometer = asset.Odometer;
  1305  			fleetAsset.RegistrationNumber = asset.RegistrationNumber;

  1481  
  1482: 		public void UpdateAssetLastOdo(string authToken, long orgId, long assetId, float lastOdo)
  1483  		{

  1485  			var securityAccounts = AuthenticationManager.GetSecurityAccountsFor(authToken);
  1486: 			AssetsClient.UpdateLastOdoAsync(org.GroupId, assetId, lastOdo, securityAccounts, Id64.NewId()).ConfigureAwait(false).GetAwaiter().GetResult();
  1487  		}

  1755  		[ExcludeFromCodeCoverage]
  1756: 		public float? GetLastOdo(string authToken, long orgId, long assetId)
  1757  		{
  1758  			var securityAccounts = AuthenticationManager.GetSecurityAccountsFor(authToken);
  1759: 			var fleetLastOdo = AssetsClient.GetLastOdoAsync(assetId, securityAccounts).ConfigureAwait(false).GetAwaiter().GetResult();
  1760  
  1761: 			return fleetLastOdo;
  1762  		}
  1763  
  1764: 		[ExcludeFromCodeCoverage] //todo: method doesn't belong here
  1765  		public DateTimeOffset GetOrgCurrentTime(long orgId)

  1772  
  1773: 		[ExcludeFromCodeCoverage] //todo: method doesn't belong here
  1774  		public ZonedDateTime GetOrgCurrentZonedDateTime(long orgId)

  2070  				FillDate = assetFuelUsage.FillDate.DateTime,
  2071: 				FillOdometerKilometres = Convert.ToDecimal(assetFuelUsage.Odometer),
  2072  				FillEngineSeconds = Convert.ToInt32(assetFuelUsage.EngineSeconds),

DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\Assets\AssetTrailerIdManager.cs:
  15  		void ChangeTrailerId(string authToken, long orgId, long assetId, AssetTrailerDetails entity);
  16: 		void ChangeOdometer(string authToken, long orgId, long assetId, AssetTrailerDetails entity);
  17  		bool IsTrailerIdUnique(long orgId, long assetId, int trailerId);

  44  				result.TrailerId = entity.TrailerId;
  45: 				result.Odometer = entity.Odometer;
  46: 				result.OdometerDate = entity.OdometerDate;
  47  				result.TrailerIdDate = entity.TrailerIdDate;

  60  		[AuthoriseFunction(Permissions.CAN_UPDATE_TRAILER_ID)]
  61: 		public void ChangeOdometer(string authToken, long orgId, long assetId, AssetTrailerDetails entity)
  62  		{
  63: 			Repo.ChangeOdometer(orgId, assetId, entity);
  64  		}

DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\Assets\IAssetManager.cs:
  123  		Dictionary<long, AssetDriver> GetDefaultDriversForOrg(string authToken, long orgId, long correlationId);
  124: 		float? GetLastOdo(string authToken, long orgId, long assetId);
  125  		bool HasTrailers(string authToken, long organisationId);

  141  		void UpdateRoadworthyCertificateReminderDefaults(string authToken, long orgId, AssetRoadworthyCertificateReminderDefaults defaults, long correlationId);
  142: 		void UpdateAssetLastOdo(string authToken, long orgId, long assetId, float lastOdo);
  143  		void UpdateEngineSeconds(string authToken, long orgId, long assetId, int engineSeconds);

DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\Drivers\DriverManager.cs:
  1346  		[ExcludeFromCodeCoverage]
  1347: 		[AuthoriseFunctionOnAnyChildGroup(Permissions.DataPermissions.DRIVER_DATA, Permissions.CAN_ACCESS_DRIVER_HOURS_OF_SERVICE)] //todo: only return authorised drivers
  1348  		public List<DriverSummary> GetHOSEnabledDrivers(string authToken, long groupId, long correlationId)

DynaMiX.Backend\Logic\DynaMiX.Logic\Groups\OrganisationGroupManager.cs:
  465  		{
  466: 			//todo jm - create separate sproc for this? might be faster
  467  			var groupMembers = Repository.GetAllMembersInGroupAndSubGroups(groupId);

DynaMiX.Backend\Logic\DynaMiX.Logic\HOS\GhosDataManager.cs:
   398  
   399: 						StartOdometer = entry.Odometer,
   400: 						StartOdometerUnits = Unit.Kilometres,
   401  						DistanceUnits = Unit.Kilometres,

   522  
   523: 		public OdometerRangeValueData GetWorkstateOdometerRangeValueDatas(string authenticationToken, long assetId, DateTime dateTime)
   524  		{

   527  			TimeZoneInfo orgTimeZoneInfo = GetOrgTimeZone(orgid);
   528: 			var odoRange = _apiClient.EventRepository.GetAssetOdometerRangeAsync(assetId, dateTime).ToOdometerRangeValueData(orgTimeZoneInfo);
   529: 			return odoRange;
   530  		}

   982  
   983: 					StartOdometer = w.Odometer,
   984: 					StartOdometerUnits = Unit.Kilometres,
   985  

  1064  			}
  1065: 			_event.Odometer = workStateData.StartOdometer;
  1066  			_event.OriginatingService = Enums.OriginatingService.Dynamix;

  1167  
  1168: 		public static OdometerRangeValueData ToOdometerRangeValueData(this OdometerRange or, TimeZoneInfo orgTimeZoneInfo)
  1169  		{
  1170: 			return new OdometerRangeValueData
  1171  			{
  1172: 				OdometerMinValue = or.OdometerMinValue,
  1173: 				OdometerMaxValue = or.OdometerMaxValue
  1174  			};

DynaMiX.Backend\Logic\DynaMiX.Logic\HOS\IHosDataManager.cs:
  19  
  20: 		OdometerRangeValueData GetWorkstateOdometerRangeValueDatas(string authenticationToken, long assetId, DateTime dateTime);
  21  		EngineHoursRange GetAssetEngineHoursRange(string authenticationToken, long assetId, DateTime dateTime);

DynaMiX.Backend\Logic\DynaMiX.Logic\InsightReports\InsightReportsManager.cs:
  185  		{
  186: 			//TODO RDT: Remove this once the datawarehouse returns fleet 64bit ids.
  187  			int fmOrgId = _converter.ConvertOrganisationIdsFleetToLegacy(new List<long> { organisationId })[0];

  196  		{
  197: 			//TODO RDT: Remove this once the datawarehouse returns fleet 64bit ids.
  198  			int fmOrgId = _converter.ConvertOrganisationIdsFleetToLegacy(new List<long> { organisationId })[0];

  341  		{
  342: 			//TODO RDT: Remove this once the datawarehouse returns fleet 64bit ids.
  343  			List<int> result = _converter.ConvertOrganisationIdsFleetToLegacy(new List<long> { organisationId });

  529  
  530: 		//TODO: This is dangerous. Ask Wayne to make constructors public
  531  		[Authorise]

  582  
  583: 			//TODO:  Need to review the report sizes and output formats with the BI Team
  584  			switch (size)

  656  		{
  657: 			//TODO RDT: Remove this once the datawarehouse returns fleet 64bit ids.
  658  			int fmOrgId = _converter.ConvertOrganisationIdsFleetToLegacy(new List<long> { organisationId })[0];

DynaMiX.Backend\Logic\DynaMiX.Logic\JobsAndMessaging\InstantMessagingManager.cs:
  98  		//SJ : Autohorize the method for use within the DynaMiX Application
  99: 		//TODO : Authorize on group level
  100  		[AuthoriseFunctionOnGroup(DynaMiX.Common.JobsAndMessaging.Permissions.ACCESS_INSTANT_MESSAGING)]

DynaMiX.Backend\Logic\DynaMiX.Logic\JobsAndMessaging\MessagingManager.cs:
  467  			}
  468: 			//todo: validate that all assets are actually in this group
  469  			var personId = GetPersonId(authToken);

  719  		{
  720: 			//todo RS: use CacheProvider
  721  			var key = string.Format("deviceMessagePropertiesForAsset_{0}", assetId);

DynaMiX.Backend\Logic\DynaMiX.Logic\JourneyManagement\JourneyManager.cs:
  2286  								}
  2287: 								//TODO: GDS Remove this else???
  2288  								//This is redundant, but was added to ensure that if for some reason, the Driver Pre Departure Questionnaires are completed, the Status will change to Pending Approval

  8811  				var currentTemplateOutcomeStatements = GetRiskPolicyOutcomeByQuestionId(authToken, orgId, template.RiskAssessmentTemplateQuestionId);
  8812: 				//TODO: Zonika still need a way to get the correct outcomes when in view mode and the question was updated
  8813  

DynaMiX.Backend\Logic\DynaMiX.Logic\JourneyManagement\Queue\JourneyQueue.cs:
  19  			{
  20: 				//TODO: Log message to indicate that AppSetting has not been configured for the specific JourneyQueueName
  21  				return;

DynaMiX.Backend\Logic\DynaMiX.Logic\Mapping\MapLocationManager.cs:
  174  			var orgGroup = OrganisationGroupManager.GetOrganisationGroupForEntity(groupIds[0], EntityTypes.GROUP);
  175: 			// TODO: Remove this once it's released in prod without issues
  176  			if (FeatureHelper.FeatureEnabled(UIFeatures.FleetServicesLocationsAuth))

  249  
  250: 			//TODO: Remove this once it's in production without issues
  251  			if (FeatureHelper.FeatureEnabled(UIFeatures.FleetServicesLocationsAuth))

  878  
  879: 			//TODO: Remove this once it's released to prod without issues
  880  			var groupTypes = new List<GroupType>

DynaMiX.Backend\Logic\DynaMiX.Logic\Mapping\PointsOfInterestManager.cs:
  108  
  109: 		[AuthoriseFunctionOnGroup(Permissions.CREATE_POINTS_OF_INTEREST)] //TODO:Zonika Done
  110  		public PointOfInterest CreatePointOfInterest(string authToken, long groupId, PointOfInterest pointOfInterest)

  156  
  157: 		[AuthoriseFunctionOnGroup(Permissions.POINTS_OF_INTEREST_DATA)] //TODO: Zonika Done
  158  		public List<PointOfInterest> GetPointOfInterestList(string authToken, long orgId)

  169  
  170: 		//[AuthoriseFunction(Permissions.ACCESS_POINTS_OF_INTEREST)] //TODO: Zonika OLD for data migrate
  171  		//public List<PointOfInterestType> GetPointOfInterestTypeList(string authToken, long orgId)

  175  
  176: 		//[AuthoriseFunction(Permissions.ACCESS_POINTS_OF_INTEREST)] //TODO: Zonika OLD for data migrate
  177  		//public List<PointOfInterestSubType> GetPointOfInterestSubTypeList(string authToken, long orgId)

  181  
  182: 		[AuthoriseFunction(Permissions.ACCESS_POINTS_OF_INTEREST)] //TODO: Zonika NEW LIST
  183  		public List<PointOfInterestTypeEnum> GetPointOfInterestTypeListFromEnum(string authToken, long orgId)

  187  
  188: 		[AuthoriseFunction(Permissions.ACCESS_POINTS_OF_INTEREST)] //TODO: Zonika NEW LIST
  189  		public List<RoadHazardSubtype> GetPointOfInterestSubTypeListFromEnum(string authToken, long orgId)

DynaMiX.Backend\Logic\DynaMiX.Logic\Mapping\Validation\MapLocationNameUniqueAsyncValidator.cs:
  40  			if (name == null) return true;
  41: 			if (!parameters.ContainsKey("orgId")) return true;//todo
  42  

DynaMiX.Backend\Logic\DynaMiX.Logic\MiXVision\MiXVisionManager.cs:
  1119  			if (ev.Value != null)
  1120: 				builder.Append(Translate(user, InformationMessages.Timeline.EVENT_TRIGGERED_VALUE + Decimal.Round((decimal)ev.Value).ToString() + " " + ev.OdometerUnits + ". "));
  1121  

DynaMiX.Backend\Logic\DynaMiX.Logic\Mobitech\CloudServicesManager.cs:
  100      //SJ : Autohorize the method for use within the DynaMiX Application
  101:     //TODO : Authorize on group level
  102      [Authorise]

DynaMiX.Backend\Logic\DynaMiX.Logic\Mobitech\TaskTemplateManager.cs:
  129  		//SJ : Autohorize the method for use within the DynaMiX Application
  130: 		//TODO : Authorize on group level
  131  		// [AuthoriseFunctionOnGroup(Permissions.ACCESS_MOBITECH_TASK_TEMPLATES)]

DynaMiX.Backend\Logic\DynaMiX.Logic\Modules\FMImport\DynaMiX.FMImport\Repository\ImportFmUserRepository.cs:
  110  
  111: 		//TODO: Make Private
  112  		internal string GetAuthenticationToken()

  130  
  131: 		//TODO RSI: Make Private
  132  		internal static bool CanUserJoinRole(FmSecurityClient fmSecurityClient, ImportFmUser importFmUser, ExtendedRole role)

  147  
  148: 		////TODO RSI: Make Private
  149  		//internal RoleCarrier GetRoleById(RoleSummaryCarrier role)

  152  		//	string authToken = GetAuthenticationToken();
  153: 		//	//TODO RSI: not yet implemented in Authorisation
  154  		//	GatewayResult<RoleCarrier> result = authorisationAdminGateway.GetRoleById(authToken, long.Parse(role.Id));

  164  
  165: 		//TODO: Make Private
  166  		internal void AddUserToRole(ImportFmUser importFmUser, ExtendedRole role, Group group)

  168  			string authToken = GetAuthenticationToken();
  169: 			//TODO: not yet implemented in Authorisation
  170  			

  173  
  174: 		//TODO: Make Private
  175  		internal List<Group> GetAllOrganisationLevelGroups()

  183  
  184: 		//TODO: Make Private
  185  		internal List<ExtendedRole> GetAllDynaMiXRolesForGroupId(long groupId)

DynaMiX.Backend\Logic\DynaMiX.Logic\Modules\Languaging\Common\Constants\UrlModuleMapping.cs:
  52  			MixFleet_UrlModuleMap["mobiledeviceadmin"] = "mixfleet_mobiledeviceadmin";
  53: 			MixFleet_UrlModuleMap["dtco_download_manager"] = "mixfleet_dtcodownloadmanager";
  54  

DynaMiX.Backend\Logic\DynaMiX.Logic\Modules\Languaging\Converters\LanguageSet\LanguageSetDocument.cs:
  49  
  50: 			// TODO: add custom exception types.
  51  			if (xmlDocument.Root == null) throw new Exception();

DynaMiX.Backend\Logic\DynaMiX.Logic\Notifications\NotificationsManager.cs:
  1364  
  1365: 		//TODO: Add organisationId here and authorise on child
  1366  		[AuthoriseFunction(Permissions.DELETE_NOTIFICATIONS_DATA)]

DynaMiX.Backend\Logic\DynaMiX.Logic\Notifications\NotificationsServiceManager.cs:
   71  		{
   72: 			//ToDo: Get DI to work properly for ILibraryCapabilityManager
   73  			get { return _libraryCapabilityManager ?? (_libraryCapabilityManager = DependencyResolver.GetInstance<ILibraryCapabilityManager>()); }

  269  
  270: 				if (nItem.Odometer != null)
  271  				{
  272: 					evnt.EndOdometer = (decimal)(nItem.Odometer);
  273: 					evnt.StartOdometer = (decimal)(nItem.Odometer);
  274  				}

DynaMiX.Backend\Logic\DynaMiX.Logic\Operations\OrgSettingsManager.cs:
  130  			return new List<DrivingReason>();
  131: 			//TODO
  132  		}

DynaMiX.Backend\Logic\DynaMiX.Logic\RoviConfig\SygicLicenseManager.cs:
  87  			return "FAILED";
  88: 			//TODO: remove the hardcoded mlm once sygic portal is ready in future release
  89  			/*            if (SygicProductId == 3919) return

DynaMiX.Backend\Logic\DynaMiX.Logic\Scheduler\DataScheduleManager.cs:
   56  		void RemoveDownloadSchedule(string authToken, long orgId, int scheduleId);
   57: 		void RequestCurrentStatus(string authToken, long orgId, long assetId, TripsEventsDownloadTypes type, string lastEditBy, TachoDownloadType tachoDownloadType = TachoDownloadType.None);
   58  

  457  
  458: 		public void RequestCurrentStatus(string authToken, long groupId, long assetId, TripsEventsDownloadTypes type, string lastEditBy, TachoDownloadType tachoDownloadType = TachoDownloadType.None)
  459  		{

  475  					TripsEventsDownload = type,
  476: 					TachoDownloadType = tachoDownloadType,
  477  					LastEditedBy = lastEditBy,

DynaMiX.Backend\Logic\DynaMiX.Logic\Scoring\AdvancedScoringManager.cs:
  43  		
  44: 		// TODO: define permissions when we've figured out what we want to actually restrict/allow.
  45  		/// <summary>

  59  
  60: 		// TODO: define permissions when we've figured out what we want to actually restrict/allow.
  61  		/// <summary>

DynaMiX.Backend\Logic\DynaMiX.Logic\Scoring\ScoringAdminManager.cs:
  130  
  131: 			//todo dp: validate for each model
  132  
  133: 			//todo dp: update old scoring model for standard scoring
  134  

DynaMiX.Backend\Logic\DynaMiX.Logic\SupportTools\AuditingManager.cs:
  459  
  460: 			var odometerData = new DynaMiX.Entities.HOS.OdometerRangeValueData { OdometerMinValue = @event.Odometer, OdometerUnits = Unit.Kilometres };
  461: 			UnitsConverter.ConvertDistanceStandardToProfile(odometerData, userProfile, o => o.OdometerMinValue, o => o.OdometerUnits);
  462  			var targetUnits = UnitsConverter.GetDistanceUnit(userProfile);

  470  			var selectedLocale = GlobalizationGateway.GetLocaleById(userProfile.LocaleId).Value;
  471: 			var odometer = odometerData.OdometerMinValue.ToString("N2", CultureInfo.GetCultureInfo(selectedLocale.Id));
  472  			var distance = distanceSinceLast.Distance.ToString("N2", CultureInfo.GetCultureInfo(selectedLocale.Id));

  482  				EventStart = @event.StartDateTime.ToString(Core.Constants.Formats.ISO_DATE_FORMAT),
  483: 				Odometer = odometer,
  484  				Remarks = BuildRemark(@event, driverInfo, assetDataTimeZoneInfo, userProfile),

DynaMiX.Backend\Logic\DynaMiX.Logic\Tracking\TrackingManager.cs:
  1769  						Distance = subTrip.DistanceKilometres,
  1770: 						Odometer = subTrip.EndOdometerKilometres ?? 0,
  1771  						Litres = fuel,

DynaMiX.Backend\Logic\DynaMiX.Logic\Trips\TripDataManager.cs:
  471  					MaxAccel = trip.MaxAccelerationKilometersPerHourPerSecond,
  472: 					Odometer = trip.EndOdometerKilomters ?? 0,
  473  					TripDistance = trip.DistanceKilometers,

  521  						MaxRpm = subTrip.MaxRpm,
  522: 						Odometer = subTrip.EndOdometerKilometres ?? 0,
  523  						TripDistance = subTrip.DistanceKilometres,

DynaMiX.Backend\Logic\DynaMiX.Logic\UserAdmin\UserAdminManager.cs:
  544  
  545: 		//todo jm authorise this method somehow, or refactor.
  546  		public List<UserProfileSummary> GetUserProfileSummaryListByProfileIdList(string authToken, IEnumerable<long> profileIds)

DynaMiX.Backend\Logic\DynaMiX.Logic\UserAdmin\Validations\UserAdminValidator.cs:
  114  
  115: 				//TODO FLEET-3464 remove
  116  				//if (!ValidateUsersCanBeRemovedFromSecurityGroup(authToken, group))

  147  
  148: 		//TODO FLEET-3464 This method is no longer needed; restriction removed.
  149  		//users must be in at least one security group

DynaMiX.Backend\Logic\DynaMiX.Logic.Tests\Authorisation\SecurityGroupRoleManagerTests.cs:
  45  
  46: 		//todo jm
  47  		//[Test]

DynaMiX.Backend\Logic\DynaMiX.Logic.Tests\ConfigAdmin\MobileUnitLevel\MobileUnitManagerTests.cs:
  645  			templateRecordingAction.RecordPulseCount = false;
  646: 			templateRecordingAction.StartOdometer = false;
  647  			templateRecordingAction.StartPosition = false;
  648: 			templateRecordingAction.EndOdometer = false;
  649  			templateRecordingAction.EndPosition = false;

  671  			templateRecordingActionFromUi.RecordPulseCount = templateRecordingAction.RecordPulseCount;
  672: 			templateRecordingActionFromUi.StartOdometer = templateRecordingAction.StartOdometer;
  673  			templateRecordingActionFromUi.StartPosition = templateRecordingAction.StartPosition;
  674: 			templateRecordingActionFromUi.EndOdometer = templateRecordingAction.EndOdometer;
  675  			templateRecordingActionFromUi.EndPosition = templateRecordingAction.EndPosition;

DynaMiX.Backend\Logic\DynaMiX.Logic.Tests\JourneyManagement\JourneyManagerTest.cs:
  6294  			//----------------------------------------------------------------------------------------
  6295: 			//TODO Mock JourneyQueue()
  6296  			// The following call is failing with NullException in JourneyQueue.Send() due to missing 

DynaMiX.Backend\Logic\DynaMiX.Logic.Tests\UserManagement\AuthorisationAdminManagerTests.cs:
  25  {
  26: 	//todo jm
  27  	[TestFixture]

DynaMiX.Backend\Logic\DynaMiX.Logic.Tests\UserManagement\UserAdminManagerTests.cs:
  477  
  478: 		//todo jm remove
  479  		//[Test]

  490  
  491: 		//todo jm remove
  492  		//[Test]

DynaMiX.Backend\MiX.UnitConfiguration\Compilers\ConfigBinaryConverter\ConfigBinaryConverter\ConfigBinWriter.cs:
  108          {
  109:           //TODO: Make this library check configurable (overridable) just in case new (last minute) ddx calls needs to be supported
  110            //if(!theCall.isInLibrary()) throw new Exception("DDCall not supported:" + theCall.ToString());

DynaMiX.Backend\MiX.UnitConfiguration\Compilers\ConfigBinaryConverter\ConfigBinaryConverter\ConfigBuilder.cs:
  115                  bw.Write((UInt16)(bin.BaseStream.Length+8)); // offset to end of events
  116:                 bw.Write(version.getCnfVersion(),4);// 4 bytes seconds since 1970 or version from config.xml (TODO)
  117                  bw.Write(version.D12VerNo);

  122                   --Offset to “End of Lengths”  (1 byte)
  123:                  | List of lengths for each record action (1 bytes)(excl. header/Odo/time) in sequence.
  124                   |       Only actions that require a record to be stored will be added to this list.

  151                  bw.Write((byte)0x55);
  152:                 bw.Write(version.getCnfVersion(), 4);// 4 bytes seconds since 1970 or version from config.xml (TODO)
  153                  bw.WriteCS();

DynaMiX.Backend\MiX.UnitConfiguration\Compilers\ConfigBinaryConverter\ConfigBinaryConverter\FMDefinitions.cs:
  112  new DDCallEntry(6, 7, 5, "Execute OBC TimeSync with seconds since midnight"),
  113: new DDCallEntry(6, 4, 13, "Set the ODO stored on non volatile RAM"),
  114  new DDCallEntry(6, 10, 0, "Current CTime"),  //note not documented in 3rdlink
  115: new DDCallEntry(18, 7, 6, "Set the ODO stored In Active Memory"),
  116: new DDCallEntry(18, 12, 7, "Synchronize Odo in a clean manner"),
  117: new DDCallEntry(8, 5, 1, "Accept ODO From Code Plug"),
  118  new DDCallEntry(8, 5, 0, "Read Plug Time & Date"),

  301  new DDCallEntry(18, 5, 3, "Suppress Acceleration / Deceleration"),
  302: new DDCallEntry(18, 9, 6, "Request \"Always Forward Going Odo\""),
  303  new DDCallEntry(18, 9, 7, "Request High Resolution RPM"),

  410          Engine_Speed,
  411:         IO_VALUE_F3,//TODO: Keep making these friendlier names
  412:         IO_VALUE_ODO,
  413          IO_VALUE_TRIP_DISTANCE,

  480          IO_VALUE_RPM_CALIBRATE_SPEED,
  481:         IO_VALUE_ODO_FRACTION_REQUEST,
  482  

  758  ACTION NUMBER:	A7 A6 A5 A4 A3 A2 A1 A0
  759: ACTION FOR EVNT 1:SB0 SB1 LN1 LN0 INV RT RF RP RN ME1 ME0 REC STM ETM SODO EODO
  760  ACTION TIME:	TIME DELAY BEFORE ACTION BECOMES TRUE.

  836          internal ReactType React;//RT RF RP RN
  837:         internal Boolean RecordStartOdo; //SODO
  838:         internal Boolean RecordEndOdo; //EODO
  839          internal Boolean RecordStartTime;//STM

  931              //            15  14  13  12  11  10 9  8  7  6   5   4   3   2   1    0
  932:             //ACTION DEF: SB0 SB1 LN1 LN0 INV RT RF RP RN ME1 ME0 REC STM ETM SODO EODO
  933              UInt16 o = 0x0;

  942              if (RecordEndTime) o |= 0x0004;
  943:             if (RecordStartOdo) o |= 0x0002;
  944:             if (RecordEndOdo) o |= 0x0001;
  945              if (RecordStartTime) o |= 0x0008;

DynaMiX.Backend\MiX.UnitConfiguration\Compilers\ConfigBinaryConverter\ConfigBinaryConverter\SourceReader.cs:
  165                              break;
  166:                         case "Delay"://TODO: FUTURE: handle more descriptive time values given here
  167                              a.Delay = Convert.ToByte(reader.Value);//0-127=0-127 sec; 128-255=0-127 min

  180                              break;
  181:                         case "StartOdo":
  182:                             a.RecordStartOdo = Convert.ToBoolean(reader.Value);
  183                              break;
  184:                         case "EndOdo":
  185:                             a.RecordEndOdo = Convert.ToBoolean(reader.Value);
  186                              break;

DynaMiX.Backend\MiX.UnitConfiguration\Compilers\ConfigBinaryConverter\UnitTests\UnitTest1.cs:
  263          [TestMethod]
  264:         public void ConditionTestGoodOperators()
  265          {

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Data\MobileUnitConfiguration.cs:
  615  						RecordingType = (RecordingTypes)Convert.ToByte(xSettings.Attribute("recordType").Value),
  616: 						StartOdometer = xSettings.Attribute("startOdometer").Value == "1",
  617  						StartPosition = xSettings.Attribute("startPosition").Value == "1",
  618: 						EndOdometer = xSettings.Attribute("endOdometer").Value == "1",
  619  						EndPosition = xSettings.Attribute("endPosition").Value == "1",

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Entities\Complex Types\EventRecordSettings.cs:
   9  
  10: 		public bool StartOdometer { get; set; }
  11: 		public bool EndOdometer { get; set; }
  12  

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\ConfigXml\ExtractConfigCompileSnapshot.cs:
  197  								eventProperties.AppendLine($"                        Type={settings.RecordingType}");
  198: 								if (settings.StartOdometer)
  199: 									eventProperties.AppendLine("                        Start odometer");
  200: 								if (settings.EndOdometer)
  201: 									eventProperties.AppendLine("                        End odometer");
  202  								if (settings.StartPosition)

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\ConfigXml\EventFragments\BuildEventRecordAction.cs:
   56  					BuildActions.AddRecord("Notification", delay, React.True,
   57: 																StartTime.True, EndTime.True, settings.StartOdometer ? StartOdometer.True : StartOdometer.False,
   58: 																settings.EndOdometer ? EndOdometer.True : EndOdometer.False,
   59  																size, valueFunc: valueFunc, returnValue: value);

  127  				case RecordingTypes.Notification:
  128: 					//  need to record the 'end' of the 'positive edge', hence the end time and odo!
  129  					BuildActions.AddRecord("Notification", delay, react: React.Pos, endTime: EndTime.True,
  130: 																endOdometer: settings.StartOdometer ? EndOdometer.True : EndOdometer.False,
  131  																returnSize: size, valueFunc: "Last", returnValue: value);

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\ConfigXml\Fragments\BuildXmlActions.cs:
   17  	}
   18: 	public enum StartOdometer
   19  	{

   27  	}
   28: 	public enum EndOdometer
   29  	{

   43  
   44: 		public void AddRecord(string action, int delay, React react, StartTime startTime = StartTime.False, EndTime endTime = EndTime.False, StartOdometer startOdometer = StartOdometer.False, EndOdometer endOdometer = EndOdometer.False, byte returnSize = 0, string returnValue = "", string valueFunc = "")
   45  		{
   46: 			AddAction("Record" + action, delay, react, startTime: startTime, endTime: endTime, startOdometer: startOdometer, endOdometer: endOdometer, returnSize: returnSize, valueFunc: valueFunc, text: returnValue);
   47  		}

   99  
  100: 		private void AddAction(string type, int delay, React react, StartTime startTime = StartTime.False, EndTime endTime = EndTime.False, StartOdometer startOdometer = StartOdometer.False, EndOdometer endOdometer = EndOdometer.False, byte returnSize = 0, string valueFunc = "", string text = "")
  101  		{

  121  			if (endTime == EndTime.True) _fragment.Append(@" EndTime=""true""");
  122: 			if (startOdometer == StartOdometer.True) _fragment.Append(@" StartOdo=""true""");
  123: 			if (endOdometer == EndOdometer.True) _fragment.Append(@" EndOdo=""true""");
  124  

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\InLocationSpeedMonitorCompile.cs:
   77  						ovrspd = Convert.ToInt32(dynLocation.SpeedLimit),
   78: 						shapeLineWidth = Convert.ToUInt32(mapLocation.PointRadius), //TODO: Map UI should fill this for polylines in future
   79: 						shapePriority = Convert.ToUInt32(65535 - dynLocation.SpeedLimit), //TODO: also consider shape size in the ranking
   80  						shapeType = 0

  153  
  154: 					//check if the zone fits into any existing shapegroup //todo order groups in ascending shape counts
  155  					//sszg = ssz.groups.OrderBy(c => c.Count).FirstOrDefault(g =>

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\SygicLocationSpeedMonitoringCompile.cs:
   76  						name = mapLocation.LocationName,
   77: 						color = 0xAA0000FF,//** ROVIII-690 ** hardcode RED *** instead of //TODO: mapLocation.LocationColor.ToArgb();//TODO: PAUL the Color to fill the area, in ARGB, 0xAABBGGRR, set to 0x00FFFFFF for invisible zone
   78  						ovrspd = Convert.ToInt32(dynLocation.SpeedLimit),
   79: 						shapeLineWidth = Convert.ToUInt32(mapLocation.PointRadius), //TODO: Map UI should fill this for polylines in future
   80: 						shapePriority = Convert.ToUInt32(65535 - dynLocation.SpeedLimit), //TODO: also consider shape size in the ranking
   81  						shapeType = 0

  252  				Paths polyOut = new Paths();
  253: 				co.Execute(ref polyOut, 1e5 * MetersToDecimalDegrees(Convert.ToDouble(shapeLineWidth), Convert.ToDouble(lineIn[0].Y) / 1e5));
  254  				foreach (IntPoint p in polyOut[0])

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\TachoConfigCompile.cs:
  14  		private const ushort F3_MASK = 0xFF7F;
  15: 		//private const ushort ODOMETER_MASK = 0xFFBF; // Current system does not set odo mask for tacho.
  16  		private const ushort D1_MASK = 0xFFDF;

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\BinaryCompiler\BinaryEnums.cs:
   30  		Engine_Speed,
   31: 		IO_VALUE_F3,//TODO: Keep making these friendlier names
   32: 		IO_VALUE_ODO,
   33  		IO_VALUE_TRIP_DISTANCE,

  100  		IO_VALUE_RPM_CALIBRATE_SPEED,
  101: 		IO_VALUE_ODO_FRACTION_REQUEST,
  102  

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\BinaryCompiler\ConfigBinWriter.cs:
  187  		{
  188: 			//TODO: Make this library check configurable (overridable) just in case new (last minute) ddx calls needs to be supported
  189  			if (!theCall.isInLibrary()) throw new Exception("DDCall not supported: " + theCall.ToString());

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\BinaryCompiler\ConfigBuilder.cs:
  110  			 --Offset to “End of Lengths”  (1 byte)
  111: 			 | List of lengths for each record action (1 bytes)(excl. header/Odo/time) in sequence.
  112  			 |       Only actions that require a record to be stored will be added to this list.

  137  			bin.Write((byte)0x55);
  138: 			bin.Write(version.getCnfVersion(), 4);// 4 bytes seconds since 1970 or version from config.xml (TODO)
  139  			bin.WriteCS();

  160  				bw.Write(eofEvents); // offset to end of events
  161: 				bw.Write(version.getCnfVersion(), 4);// 4 bytes seconds since 1970 or version from config.xml (TODO)
  162  				bw.Write(version.D12VerNo);

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\BinaryCompiler\FMDefinitions.cs:
   160  			F3 = 2,
   161: 			ODO = 3,
   162  			TripDistance = 4,

   226  			RPMCalSpeed = 68,
   227: 			OdoRemainder = 69,
   228  			ClockRAMLong = 70,

   277  			new FMInput("F3",2),
   278: 			new FMInput("ODO",3),
   279  			new FMInput("TripDistance",4),

   343  			new FMInput("RPMCalSpeed",68),
   344: 			new FMInput("OdoRemainder",69),
   345  			new FMInput("ClockRAMLong",70),

   664  					new DDCallEntry(6, 7, 5, "Execute OBC TimeSync with seconds since midnight"),
   665: 					new DDCallEntry(6, 4, 13, "Set the ODO stored on non volatile RAM"),
   666  					new DDCallEntry(6, 9, 9, "Get Adjusted Time"),  //note not documented in 3rdlink
   667  					new DDCallEntry(6, 10, 0, "Current CTime"),  //note not documented in 3rdlink
   668: 					new DDCallEntry(18, 7, 6, "Set the ODO stored In Active Memory"),
   669: 					new DDCallEntry(18, 12, 7, "Synchronize Odo in a clean manner"),
   670: 					new DDCallEntry(8, 5, 1, "Accept ODO From Code Plug"),
   671  					new DDCallEntry(8, 5, 0, "Read Plug Time & Date"),

   864  					new DDCallEntry(18, 5, 3, "Suppress Acceleration / Deceleration"),
   865: 					new DDCallEntry(18, 9, 6, "Request \"Always Forward Going Odo\""),
   866  					new DDCallEntry(18, 9, 7, "Request High Resolution RPM"),

  1113  ACTION NUMBER:	A7 A6 A5 A4 A3 A2 A1 A0
  1114: ACTION FOR EVNT 1:SB0 SB1 LN1 LN0 INV RT RF RP RN ME1 ME0 REC STM ETM SODO EODO
  1115  ACTION TIME:	TIME DELAY BEFORE ACTION BECOMES TRUE.

  1191  		internal ReactType React;//RT RF RP RN
  1192: 		internal Boolean RecordStartOdo; //SODO
  1193: 		internal Boolean RecordEndOdo; //EODO
  1194  		internal Boolean RecordStartTime;//STM

  1288  			//            15  14  13  12  11  10 9  8  7  6   5   4   3   2   1    0
  1289: 			//ACTION DEF: SB0 SB1 LN1 LN0 INV RT RF RP RN ME1 ME0 REC STM ETM SODO EODO
  1290  			UInt16 o = 0x0;

  1299  			if (RecordEndTime) o |= 0x0004;
  1300: 			if (RecordStartOdo) o |= 0x0002;
  1301: 			if (RecordEndOdo) o |= 0x0001;
  1302  			if (RecordStartTime) o |= 0x0008;

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\BinaryCompiler\SourceReader.cs:
  317  							break;
  318: 						case "Delay"://TODO: FUTURE: handle more descriptive time values given here
  319  							var delay = Convert.ToInt32(reader.Value);

  334  							break;
  335: 						case "StartOdo":
  336: 							a.RecordStartOdo = ReadValueAsBoolean();
  337  							break;
  338: 						case "EndOdo":
  339: 							a.RecordEndOdo = ReadValueAsBoolean();
  340  							break;

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\M6k_Modules\GenerateBinaries\SettingsCompile.cs:
    46  				AddSettingsForSpeedSource(buildContext, ref deviceSettings);
    47: 				AddSettingsForOdoSource(buildContext, ref deviceSettings);
    48  				AddSettingsForRpmSource(buildContext, ref deviceSettings);

   467  			{
   468: 				canBus1Config.ProtocolId = CanProtocolId.DtcoDownloadAndLiveData;
   469  			}

   535  
   536: 		private void AddSettingsForOdoSource(IBuildContext buildContext, ref List<DeviceSetting> deviceSettings)
   537  		{
   538: 			var accumulatorType = OdometerAccumulatorType.DeriveFromSourceOdometer;
   539: 			var odoSource = SourceOptions.Gps;
   540  			var automaticSynchronizeSource = SourceOptions.NotConnected;

   543  			{
   544: 				accumulatorType = OdometerAccumulatorType.DeriveFromSpeed;
   545: 				odoSource = SourceOptions.FmScript;
   546  				automaticSynchronizeSource = SourceOptions.FmScript;

   549  			{
   550: 				accumulatorType = OdometerAccumulatorType.DeriveFromSourceOdometer;
   551: 				odoSource = SourceOptions.Dtco;
   552  				automaticSynchronizeSource = SourceOptions.Dtco;

   555  			{
   556: 				accumulatorType = OdometerAccumulatorType.DeriveFromSpeed;
   557  				IDevice speedSenderDevice = buildContext.Devices.FirstOrDefault(d => (d.DeviceId == ConfigConstants.PeripheralDevices.SPEED_SENDER || d.DeviceId == ConfigConstants.PeripheralDevices.HIRES_SPEED_SENDER));

   561  					{
   562: 						case "F1": odoSource = SourceOptions.Frequency1; break;
   563: 						case "F2": odoSource = SourceOptions.Frequency2; break;
   564  					}

   568  
   569: 			deviceSettings.Add(new DeviceSetting(UdpParameterId.OdometerAccumulator, new OdometerAccumulatorParameter()
   570  			{
   571: 				OdometerAccumulatorType = accumulatorType,
   572: 				OdometerSource = odoSource,
   573  			}));
   574  
   575: 			deviceSettings.Add(new DeviceSetting(UdpParameterId.OdometerAutoSync, new OdometerAutoSyncParameter()
   576  			{

   789  			SystemInputLineScalingParameter lineScaling = new SystemInputLineScalingParameter();
   790: 			UInt16 dtcoDownloadButtonFlags = 0; // Default = 0
   791  

   804  						{
   805: 							int dtcoDownloadButtonLineNr = (UInt16)(int.Parse(device.Line[1].ToString()) - 1); // input line the DTCO button is connected
   806: 							dtcoDownloadButtonFlags |= (UInt16)(1 << dtcoDownloadButtonLineNr); // Set the Input PullUp (SYSTEM_INPUT_PULL_UP) bit for the selected line
   807  						}

   830  			deviceSettings.Add(new DeviceSetting(UdpParameterId.SystemInputLineScaling, lineScaling));
   831: 			deviceSettings.Add(new DeviceSetting(UdpParameterId.DtcoButtonSystemInputNumber, (byte)dtcoDownloadButtonFlags)); // DTCO_BUTTON_SYS_INPUT_NUM [0x181F] - casting to byte for now, but this should also be an ushort
   832: 			deviceSettings.Add(new DeviceSetting(UdpParameterId.SystemInputPullUp, dtcoDownloadButtonFlags)); // SYSTEM_INPUT_PULL_UP [0x554]
   833  		}

  1021  			#region Assign DTC-Download Port
  1022: 			IDevice dtcoDownload = buildContext.Devices.FirstOrDefault(d => (d.DeviceId == ConfigConstants.PeripheralDevices.MESA_OB3D_DTCO_DOWNLOAD));
  1023: 			if (dtcoDownload != null && !string.IsNullOrEmpty(dtcoDownload.Line))
  1024  			{
  1025: 				if (dtcoDownload.Line == "K") // when the K-Line is used for download (S4 on M4k and S6 on M6k)
  1026  				{

  1032  				else
  1033: 					AssignSerialPort(uartManagerParameter, dtcoDownload.Line, SerialPortModules.DtcoSerial);
  1034  			}

  1195  			};
  1196: 			IDevice dtcoDownload = buildContext.Devices.FirstOrDefault(d => d.DeviceId == ConfigConstants.PeripheralDevices.MESA_OB3D_DTCO_DOWNLOAD || d.DeviceId == ConfigConstants.PeripheralDevices.MESA_OB3D_DTCO_DOWNLOAD_LIVE);
  1197  

  1206  			};
  1207: 			if (dtcoDownload != null)
  1208  			{

  1211  				downloadSchedule.DtcoScheduleDefinitions = scheduleDefinitionResource.DtcoScheduleDefinitions;
  1212: 				switch (dtcoDownload.Line)
  1213  				{

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Tests\AssembleXml\AllocateVariablesModuleTests.cs:
  247  		{
  248: 			Mock<IBuildContext> testContext = SetupStoreContext(CONDEF_STORE_CALC, "HRODO", true);
  249  			var allocateModule = new FM3x_Modules.Variables.AllocateVariablesModule();
  250  			Assert.That(allocateModule.ProcessModule(testContext.Object, It.IsAny<long>(), It.IsAny<string>()));
  251: 			const string expected = "<Action Type=\"SendCalcToDriver\" Delay=\"0\" React=\"True\"><DDCall DDriver=\"22\" DFunc=\"4\" DFuncAct=\"4\"><B>HRODO</B></DDCall></Action>";
  252  			Assert.That(ReturnedConfigurationDefinition.Contains(expected));

  257  		{
  258: 			Mock<IBuildContext> testContext = SetupStoreContext(CONDEF_STORE_CALC, "HRODO", false);
  259  			var allocateModule = new FM3x_Modules.Variables.AllocateVariablesModule();
  260  			Assert.That(allocateModule.ProcessModule(testContext.Object, It.IsAny<long>(), It.IsAny<string>()));
  261: 			const string expected = "<Action Type=\"SaveCalcInLong\" Delay=\"0\" React=\"True\"><Input>StorageLongs</Input><InputExt>HRODO</InputExt></Action>";
  262  			Assert.That(ReturnedConfigurationDefinition.Contains(expected));

  316  
  317: 		private const string CONDEF_STORE_CALC = CONDEF_SPEED + @"<Action " + "Type=\"StoreCalculation\" Delay=\"0\" React=\"True\">" + "<Var Name=\"HRODO\"/>" + "</Action>" + CONDEF_RPM;
  318  

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Tests\AssembleXml\EventReturnActionsToXmlFragments.cs:
   16  		[Test]
   17: 		public void RecordDetailTimeAndOdometer()
   18  		{

   20  				"<!-- Event --><Conditions><EventId>1</EventId><!-- Parameter --><Input>I1</Input></Conditions>" +
   21: 				@"<Actions><Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" EndOdo=""true"" /></Actions>";
   22  

   31  																								RecordingType = RecordingTypes.Detailed,
   32: 																								StartOdometer = true,
   33: 																								EndOdometer = true
   34  																							}

  398  		[Test]
  399: 		public void RecordNotifyTimeAndOdometer()
  400  		{

  403  				"<!-- Event --><Conditions><EventId>1</EventId><!-- Parameter --><Input>I1</Input></Conditions>" +
  404: 				@"<Actions><Action Type=""RecordNotification"" Delay=""131"" React=""Pos"" EndTime=""true"" EndOdo=""true"" /></Actions>";
  405  

  414  																								RecordingType = RecordingTypes.Notification,
  415: 																								StartOdometer = true
  416  																							}

  423  		[Test]
  424: 		public void RecordNotifyTimeAndOdometerAndValue()
  425  		{

  428  				"<!-- Event --><Conditions><EventId>1</EventId><!-- Parameter --><Input>I1</Input></Conditions>" +
  429: 				@"<Actions><Action Type=""RecordNotification"" Delay=""131"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Last"" MSBByte=""2"" WordLength=""1""><Input>LastDriverID</Input></Action></Actions>";
  430  

  439  																		RecordingType = RecordingTypes.Notification,
  440: 																		StartOdometer = true
  441  																	}

  477  																								RecordingType = RecordingTypes.Notification,
  478: 																								StartOdometer = false,
  479  																								StartPosition = true,

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Tests\AssembleXml\TestCanScriptLoadModule.cs:
  63  		private readonly IList<IValue> _values  = new List<IValue>();
  64: ⟪ 1701 characters skipped ⟫CANFP - Total Fuel Used;FuelUsed;;9;NULL;NULL;NULL;NULL V;U8;CANCT;CAN.CANCT;FM High engine coolant temperature warning;HighCoolantTemp;;8;NULL;NULL;NULL;NULL V;U32;HRESD;CAN.HRESD;FM High resolution odometer;HiResDistance;km;2;0;0;1;0 V;U32;IMTMP;CAN.IMTMP;FM Intake Manifold Temperature;IntakeManifTemp;C;2;32;0;200;0 V;U32;CANFP;System.CAN.FuelQuantity;CAN Fuel Quantity;InTripFuel;Litres;14;0;0;1000;0 V;U8;PTOON;CAN.PTOON;FM Power take off ON (PTO);J1708PtoOn;;8;NULL;NULL;NULL;NULL V;U32;00404;System.Scratch404;Keep the last value of FP to calculate a diff;LastCANFP;;9;NULL;NULL;NULL;NULL V;U32;00405;System.Scratch405;Keep the last value of FT to calculate a diff;LastCANFT;;9;NULL;NULL;NULL;NULL V;U32;0040B;System.Scratch40B;Holds the last engine speed value from the CAN bus set in the OBC;LastOBCRpm;;9;NULL;NULL;NULL;NULL V;U32;0040A;System.Scratch40A;Holds the last speed value from the CAN bus set in the OBC;LastOBCSpeed;;9;NULL;NULL;NULL;NULL V;U8;CANLO;CAN.CANLO;FM Low engine oil level warning;LowOilLevel;;8;NULL;NULL;NULL;NULL V;U8;CANLP;CAN.CANLP;FM Low engine oil pressure warning;LowOilPres;;8;NULL;NULL;NULL;NULL V;U8;TCOOS;CAN.TCOOS;FM TCO overspeed warning;OverSpeed;;8;NU
  65  

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Tests\binary compiling\TestConfigBinaryCompile.cs:
   224      </Action>
   225:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   226        <Input>LastDDriverReturn</Input>
   227      </Action>
   228:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   229        <Input>LastDDriverReturn</Input>

   234      </Action>
   235:     <!--return subtrip time, odos and distance-->
   236      <!--Conditional[NotIsDeviceEnabled] Object[System.Speed.HiRes] Result[False]-->
   237      <!--Conditional[IsDeviceEnabled] Object[System.Speed.HiRes] Result[True]-->
   238:     <Action Type=""RecordSummary"" Delay=""0"" React=""True"" EndTime=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Last"" MSBByte=""0"" WordLength=""3"">
   239        <Input>StorageLongs</Input>

   265      <Action Type=""RecordCount"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" />
   266:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   267        <Input>LastDDriverReturn</Input>
   268      </Action>
   269:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Last"" MSBByte=""2"" WordLength=""1"">
   270        <Input>Mnemonic</Input>

   276      </Action>
   277:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""TerminalData"" ValueFunc=""Last"" MSBByte=""3"" WordLength=""1"">
   278        <Input>IntermediateBuffer</Input>

   287      <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" />
   288:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" />
   289:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Max"" MSBByte=""2"" WordLength=""1"">
   290        <Input>PrecisionSpeed</Input>
   291      </Action>
   292:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Max"" MSBByte=""3"" WordLength=""0"">
   293        <Input>Revs</Input>
   294      </Action>
   295:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" ValueType=""Value"" ValueFunc=""Max"" MSBByte=""3"" WordLength=""0"">
   296        <Input>StorageLongs</Input>

   299      <Action Type=""RecordSummary"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" />
   300:     <Action Type=""RecordNotification"" Delay=""300"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" />
   301      <Action Type=""RecordSummary"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" />
   302:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" ValueType=""Value"" ValueFunc=""Max"" MSBByte=""3"" WordLength=""0"">
   303        <Input>StorageLongs</Input>

   305      </Action>
   306:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Last"" MSBByte=""0"" WordLength=""3"">
   307        <Input>BatteryDisconnect</Input>

   377      </Action>
   378:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   379        <Input>LastDDriverReturn</Input>
   380      </Action>
   381:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   382        <Input>LastDDriverReturn</Input>
   383      </Action>
   384:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   385        <Input>LastDDriverReturn</Input>

   395      <!--Save job to event data space-->
   396:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""TerminalData"" ValueFunc=""Last"" MSBByte=""3"" WordLength=""1"">
   397        <Input>StorageLongs</Input>

   409      </Action>
   410:     <Action Type=""RecordNotification"" Delay=""0"" Invert=""true"" React=""Pos"" EndTime=""true"" EndOdo=""true"" />
   411      <!--Return old Engine Seconds-->

   757      </Action>
   758:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   759        <Input>LastDDriverReturn</Input>
   760      </Action>
   761:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   762        <Input>LastDDriverReturn</Input>

   767      </Action>
   768:     <Action Type=""RecordSummary"" Delay=""0"" React=""True"" EndTime=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Last"" MSBByte=""0"" WordLength=""3"">
   769        <Input>StorageLongs</Input>

   786      <Action Type=""RecordCount"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" />
   787:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   788        <Input>LastDDriverReturn</Input>
   789      </Action>
   790:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Last"" MSBByte=""2"" WordLength=""1"">
   791        <Input>Mnemonic</Input>

   797      </Action>
   798:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""TerminalData"" ValueFunc=""Last"" MSBByte=""3"" WordLength=""1"">
   799        <Input>IntermediateBuffer</Input>

   808      <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" />
   809:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" />
   810:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Max"" MSBByte=""2"" WordLength=""1"">
   811        <Input>PrecisionSpeed</Input>
   812      </Action>
   813:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Max"" MSBByte=""3"" WordLength=""0"">
   814        <Input>Revs</Input>
   815      </Action>
   816:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" ValueType=""Value"" ValueFunc=""Max"" MSBByte=""3"" WordLength=""0"">
   817        <Input>StorageLongs</Input>

   820      <Action Type=""RecordSummary"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" />
   821:     <Action Type=""RecordNotification"" Delay=""300"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" />
   822      <Action Type=""RecordSummary"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" />
   823:     <Action Type=""RecordNotification"" Delay=""0"" React=""True"" StartTime=""true"" EndTime=""true"" StartOdo=""true"" ValueType=""Value"" ValueFunc=""Max"" MSBByte=""3"" WordLength=""0"">
   824        <Input>StorageLongs</Input>

   826      </Action>
   827:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Last"" MSBByte=""0"" WordLength=""3"">
   828        <Input>BatteryDisconnect</Input>

   898      </Action>
   899:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   900        <Input>LastDDriverReturn</Input>
   901      </Action>
   902:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   903        <Input>LastDDriverReturn</Input>
   904      </Action>
   905:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""GPSData"" MSBByte=""3"" WordLength=""2"">
   906        <Input>LastDDriverReturn</Input>

   916      <!--Save job to event data space-->
   917:     <Action Type=""RecordNotification"" Delay=""0"" React=""Pos"" EndTime=""true"" EndOdo=""true"" ValueType=""TerminalData"" ValueFunc=""Last"" MSBByte=""3"" WordLength=""1"">
   918        <Input>StorageLongs</Input>

   930      </Action>
   931:     <Action Type=""RecordNotification"" Delay=""0"" Invert=""true"" React=""Pos"" EndTime=""true"" EndOdo=""true"" />
   932      <!--Return old Engine Seconds-->

  1493  <Actions>
  1494: 		<Action Type=""RecordSummary"" Delay=""0"" React=""True"" EndTime=""true"" EndOdo=""true"" ValueType=""Value"" ValueFunc=""Last"" MSBByte=""2"" WordLength=""1"">
  1495  			<Input>TripDistance</Input>

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Tests\binary compiling\TestFmtScriptCompile.cs:
  38  
  39: 			// ToDo: find the checksum in the fms binary 
  40  			// Assert.AreEqual(xx, results["FmtBinary14"][offset]);

DynaMiX.Backend\MiX.UnitConfiguration\Utilities\ConfigTransformation\ConfigVizSeq\bitAndValueDefs.cs:
  27  
  28: 		//todo: we should also keep track of the order in which buf is modified and used
  29  

DynaMiX.Backend\MiX.UnitConfiguration\Utilities\ConfigTransformation\ConfigVizSeq\Conditions.cs:
  266  		{
  267: 			//todo: this could use a bit or a value - must be registered as used
  268  			if ("IntermediateBuffer" == condition.Value)

DynaMiX.Backend\MiX.UnitConfiguration\Utilities\ConfigTransformation\ConfigVizSeq\VizSeq.cs:
  24  		private BitAndValueDefs bitAndValueDefsEntireConfig;
  25: 		private BitAndValueDefs bitAndValueDefsForWantedItems;  //todo: populate this during discovery
  26  		internal BitAndValueDefs getBitDefs() { return bitAndValueDefsForWantedItems; }

DynaMiX.Backend\MiX.UnitConfiguration\Utilities\ConfigTransformation\ddrLookups\DdrLookups.cs:
   34  						{MAKE_DDR_CALL_SIGNATURE(18, 8, 2), "F3"},
   35: 						{MAKE_DDR_CALL_SIGNATURE(18, 8, 6), "ODO"},
   36  						{MAKE_DDR_CALL_SIGNATURE(18, 8, 7), "TRIP DISTANCE"},

   61  						{MAKE_DDR_CALL_SIGNATURE(6, 8, 4), "VEHICLE id"},
   62: 						{MAKE_DDR_CALL_SIGNATURE(8, 8, 4), "NEW ODO CONFIG"},
   63  						{MAKE_DDR_CALL_SIGNATURE(12, 8, 7), "NEW SOFTWARE DRIVER"},

  104  						{MAKE_DDR_CALL_SIGNATURE(18, 8, 15), "RPM Calibration Speed"},
  105: 						{MAKE_DDR_CALL_SIGNATURE(18, 8, 11), "Odo Fraction Request"},
  106  						{MAKE_DDR_CALL_SIGNATURE(6, 8, 8), "FRAM/Clock Ram contents request"},

  208  						{MAKE_DDR_CALL_SIGNATURE(6, 7, 5), "Execute OBC TimeSync with seconds since midnight"},
  209: 						{MAKE_DDR_CALL_SIGNATURE(6, 4, 13), "Set the ODO stored on non volatile RAM"},
  210: 						{MAKE_DDR_CALL_SIGNATURE(18, 7, 6), "Set the ODO stored In Active Memory"},
  211: 						{MAKE_DDR_CALL_SIGNATURE(18, 12, 7), "Synchronize Odo in a clean manner"},
  212: 						{MAKE_DDR_CALL_SIGNATURE(8, 5, 1), "Accept ODO From Code Plug"},
  213  						{MAKE_DDR_CALL_SIGNATURE(8, 5, 0), "Read Plug Time & Date"},

  380  						{MAKE_DDR_CALL_SIGNATURE(18, 5, 3), "Suppress Acceleration / Deceleration"},
  381: 						{MAKE_DDR_CALL_SIGNATURE(18, 9, 6), "Request 'Always Forward Going Odo'"},
  382  						{MAKE_DDR_CALL_SIGNATURE(18, 9, 7), "Request High Resolution RPM"},

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api\APISettings.cs:
  11  
  12: 		//todo jm: find a better way to do this.
  13  		[ConfigurationProperty("APIHost", IsRequired = true)]

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api\Carriers\Trips\Converter.cs:
  68  			carrier.MaxSpeed = entity.MaxSpeed;
  69: 			carrier.Odometer = entity.Odometer;
  70  			carrier.Sequence = entity.Sequence;

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api\Carriers\Trips\TripsCarrier.cs:
  78  		public decimal Distance { get; set; }
  79: 		public decimal Odometer { get; set; }
  80  		public long? StartPositionId { get; set; }

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api\NancyModules\UpdateModule.cs:
  52  			{
  53: 				//TODO: RDT - to be languaged sometime
  54  				updateText = Common.Constants.InformationMessages.ConfigAdmin.PLUG_TOOL_UPDATE_AVAILABLE;

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api\NancyModules\Config\LargeFileTransferModule.cs:
   73  			RegisterRouteUnhandled(ModuleRoutes.NEW_FILE_AVAILABLE, args => NewFileAvailable(Model<LargeFileTransferCarrier>()));
   74: 			RegisterRoute(ModuleRoutes.GET_NEXT_FILE_PART, args => GetNextFilePartToDownload(Convert.ToInt32(QueryStringValue("transferId")), Convert.ToInt32(QueryStringValue("maxPartSize"))));
   75  			RegisterRouteUnhandled(ModuleRoutes.STORE_FILE_PART, args => StoreFilePart(Model<LargeFileTransferCarrier>()));

  142  		/// </summary>
  143: 		public GatewayResult<LargeFileTransferCarrier> GetNextFilePartToDownload(int transferID, int maxPartSize)
  144  		{
  145: 			DmXLogger.Log($"LFT NancyModule GetNextFilePartToDownload({transferID}, {maxPartSize})", LogLevel.Warning);
  146  			LargeFileTransferCarrier carrier = new LargeFileTransferCarrier();

  149  			LargeFileTransferStatus status = LargeFileTransferManager.RequestDownloadOffset(transferID, maxPartSize, out offset);
  150: 			DmXLogger.Log($"LFT NancyModule GetNextFilePartToDownload: call to LFTManager.RequestDownloadOffset({transferID}, {maxPartSize}, -1) returned {status}, offset = {offset}", LogLevel.Warning);
  151  			

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api\NancyModules\Groups\GroupModule.cs:
  96  					var organisation = OrganisationManager.GetOrganisationDetail(authToken, group.GroupId);
  97: 					if (!organisation.HasFeature(OrgFeature.DtcoDownloadManagement))
  98  						continue;

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api\NancyModules\Locations\LocationModule.cs:
  483  					{
  484: 						//TODO: take a look at this again I do not think the below is right.
  485  						var polyLine = new PolylineShape();

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api.LargeFileTransfer.Client\LargeFileTransfer.cs:
  79  		/// </summary>
  80: 		public LargeFileTransferStatus GetNextFilePartToDownload(int scheduleID, int maxPartSize, out int offset, out int partSize)
  81  		{
  82  			RestCalls rest = new RestCalls(_baseUrl + "getnextfilepart/");
  83: 			return rest.GetNextFilePartToDownload(scheduleID, maxPartSize, out offset, out partSize);
  84  		}

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api.LargeFileTransfer.Client\RestCalls.cs:
  164  
  165: 		public LargeFileTransferStatus GetNextFilePartToDownload(int scheduleID, int maxPartSize, out int offset, out int partSize)
  166  		{

DynaMiX.Backend\Services\Api\DynaMiX.Services.Api.LargeFileTransfer.Client.Test\Program.cs:
  119  			int partSize = 0;
  120: 			LargeFileTransferStatus status = rest.GetNextFilePartToDownload(1001, 256, out offset, out partSize);
  121  

  149  			partSize = 0;
  150: 			status = rest.GetNextFilePartToDownload(1001, 256, out offset, out partSize);
  151  

DynaMiX.Backend\Services\AssetDriverReminders\DynaMiX.Services.AssetDriverReminders\DTOs\AssetLicenceReminderDto.cs:
  6  		public string AssetRegistration { get; set; }
  7: 		public string AssetOdometer { get; set; }
  8  		public string Organisation { get; set; }

DynaMiX.Backend\Services\AssetDriverReminders\DynaMiX.Services.AssetDriverReminders\DTOs\AssetRoadworthyReminderDto.cs:
  6  		public string AssetRegistration { get; set; }
  7: 		public string AssetOdometer { get; set; }
  8  		public string Organisation { get; set; }

DynaMiX.Backend\Services\AssetDriverReminders\DynaMiX.Services.AssetDriverReminders\DTOs\AssetServiceReminderDto.cs:
  6  		public string AssetRegistration { get; set; }
  7: 		public string AssetOdometer { get; set; }
  8  		public string EngineHours { get; set; }

DynaMiX.Backend\Services\AssetDriverReminders\DynaMiX.Services.AssetDriverReminders\ScheduledTasks\AssetLicenceReminderTask.cs:
  243  				assetLicenseReminderItem.AssetDescription = asset.Description;
  244: 				if (asset.Odometer.HasValue)
  245  				{

  247  					{
  248: 						assetLicenseReminderItem.AssetOdometer = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(asset.Odometer.Value), MiX.Core.Conversion.Unit.Miles).ToString("N", new CultureInfo(locale.Id));
  249  					}

  251  					{
  252: 						assetLicenseReminderItem.AssetOdometer = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(asset.Odometer.Value), MiX.Core.Conversion.Unit.Metres).ToString("N", new CultureInfo(locale.Id));
  253  					}

  255  					{
  256: 						assetLicenseReminderItem.AssetOdometer = asset.Odometer.Value.ToString("N", new CultureInfo(locale.Id));
  257  					}

DynaMiX.Backend\Services\AssetDriverReminders\DynaMiX.Services.AssetDriverReminders\ScheduledTasks\AssetRoadworthyReminderTask.cs:
  234  				assetRoadworthyReminderItem.AssetDescription = asset.Description;
  235: 				if (asset.Odometer.HasValue)
  236  				{

  238  					{
  239: 						assetRoadworthyReminderItem.AssetOdometer = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(asset.Odometer.Value), MiX.Core.Conversion.Unit.Miles).ToString("N", new CultureInfo(locale.Id));
  240  					}

  242  					{
  243: 						assetRoadworthyReminderItem.AssetOdometer = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(asset.Odometer.Value), MiX.Core.Conversion.Unit.Metres).ToString("N", new CultureInfo(locale.Id));
  244  					}

  246  					{
  247: 						assetRoadworthyReminderItem.AssetOdometer = asset.Odometer.Value.ToString("N", new CultureInfo(locale.Id));
  248  					}

DynaMiX.Backend\Services\AssetDriverReminders\DynaMiX.Services.AssetDriverReminders\ScheduledTasks\AssetServicingReminderTask.cs:
  437  						float? nextServiceDueAtKm = assetServiceMetricReminderList[j].AssetServiceReminders[i].NextServiceDueAtKm;
  438: 						if (nextServiceDueAtKm.HasValue && asset.Odometer.HasValue)
  439  						{

  442  							{
  443: 								assetServiceReminderItem.ExpiryDate = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(nextServiceDueAtKm.Value), MiX.Core.Conversion.Unit.Miles).ToString("N", new CultureInfo(locale.Id));
  444: 								assetServiceReminderItem.ExpiredSince = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(Math.Abs(nextServiceDueAtKm.Value - asset.Odometer.Value)), MiX.Core.Conversion.Unit.Miles).ToString("N", new CultureInfo(locale.Id));
  445  								assetServiceReminderItem.ServiceDueAtUnit = AssetDriverRemindersManagers.LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, organisation.LanguageCode, Common.Constants.UnitDescriptionShort.MILES).Value ?? Common.Constants.UnitDescriptionShort.MILES;

  449  							{
  450: 								assetServiceReminderItem.ExpiryDate = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(nextServiceDueAtKm.Value), MiX.Core.Conversion.Unit.Metres).ToString("N", new CultureInfo(locale.Id));
  451: 								assetServiceReminderItem.ExpiredSince = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(Math.Abs(nextServiceDueAtKm.Value - asset.Odometer.Value)), MiX.Core.Conversion.Unit.Metres).ToString("N", new CultureInfo(locale.Id));
  452  								assetServiceReminderItem.ServiceDueAtUnit = AssetDriverRemindersManagers.LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, organisation.LanguageCode, Common.Constants.CopyOfMixCore2Units.Metres).Value ?? Common.Constants.CopyOfMixCore2Units.Metres;

  457  								assetServiceReminderItem.ExpiryDate = nextServiceDueAtKm.Value.ToString("N", new CultureInfo(locale.Id));
  458: 								assetServiceReminderItem.ExpiredSince = Math.Abs(nextServiceDueAtKm.Value - asset.Odometer.Value).ToString("N", new CultureInfo(locale.Id));
  459  								assetServiceReminderItem.ServiceDueAtUnit = AssetDriverRemindersManagers.LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, organisation.LanguageCode, Common.Constants.UnitDescriptionShort.KILOMETRES).Value ?? Common.Constants.UnitDescriptionShort.KILOMETRES;

  464  
  465: 					if (!asset.Odometer.HasValue)
  466  					{
  467: 						asset.Odometer = 0;
  468  					}

  471  					{
  472: 						assetServiceReminderItem.AssetOdometer = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(asset.Odometer.Value), MiX.Core.Conversion.Unit.Miles).ToString("N", new CultureInfo(locale.Id));
  473: 						assetServiceReminderItem.AssetOdometer += " " + AssetDriverRemindersManagers.LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, organisation.LanguageCode, "mi").Value;
  474  					}

  476  					{
  477: 						assetServiceReminderItem.AssetOdometer = DynaMiX.Logic.UnitsConverter.ConvertDistanceStandardToUnit<double>(Convert.ToDouble(asset.Odometer.Value), MiX.Core.Conversion.Unit.Metres).ToString("N", new CultureInfo(locale.Id));
  478: 						assetServiceReminderItem.AssetOdometer += " " + AssetDriverRemindersManagers.LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, organisation.LanguageCode, "m").Value;
  479  					}

  481  					{
  482: 						assetServiceReminderItem.AssetOdometer = asset.Odometer.Value.ToString("N", new CultureInfo(locale.Id));
  483: 						assetServiceReminderItem.AssetOdometer += " " + AssetDriverRemindersManagers.LanguagingGateway.GetSimpleTranslation(LanguagingModules.BACKEND, organisation.LanguageCode, "km").Value;
  484  					}

  486  					{
  487: 						assetServiceReminderItem.AssetOdometer = "-";
  488  					}

DynaMiX.Backend\Services\AssetDriverReminders\DynaMiX.Services.Reminders.Tests\ScheduledTasksTests.cs:
  387  													 var assetSummaries = new List<AssetSummary>();
  388: 													 assetSummaries.Add(new AssetSummary { AssetId = 1, Description = "TestAsset1", Odometer = 20, EngineHours = new TimeSpan(0, 2, 0, 0) });
  389: 													 assetSummaries.Add(new AssetSummary { AssetId = 2, Description = "TestAsset2", Odometer = 20, EngineHours = new TimeSpan(0, 2, 0, 0) });
  390  													 return assetSummaries;

DynaMiX.Backend\Services\Assets Import\DynaMiX.Services.AssetsImport\Tasks\ImportAssetFuelTask.cs:
  316  			fuelUsage.AssetId = asset.AssetId;
  317: 			fuelUsage.Odometer = Converter.ConvertValue(fuelImportCarrier.Odometer, fuelImportCarrier.OdometerUnit, Unit.Kilometres);
  318  			fuelUsage.Litres = Converter.ConvertValue(fuelImportCarrier.Volume, importVolumeUnit, Unit.Litres);

  324  
  325: 			fuelUsage.BaseCost = fuelImportCarrier.ExchangeRate.HasValue ? Convert.ToDecimal(fuelImportCarrier.TransactionAmount / Convert.ToDouble(fuelImportCarrier.ExchangeRate)) :
  326  				fuelImportCarrier.BaseCost.HasValue ? Convert.ToDecimal(fuelImportCarrier.BaseCost) : Convert.ToDecimal(fuelImportCarrier.TransactionAmount);

  344  				{
  345: 					if (previousTransaction != null && fuelUsageRecord.Odometer < previousTransaction.Odometer)
  346: 						AddValidationResult(currentIndex + 2, ErrorMessages.FuelImport.ODOMETER_MUST_BE_GREATER);
  347  
  348: 					if (nextTransaction != null && fuelUsageRecord.Odometer > nextTransaction.Odometer)
  349: 						AddValidationResult(currentIndex + 2, ErrorMessages.FuelImport.ODOMETER_MUST_BE_LESS);
  350  				}

DynaMiX.Backend\Services\Billing\DynaMiX.Services.IridiumBilling\ScheduledTasks\ProcessIridiumBillingTask.cs:
  226  			//Only get a list of files that have not been downloaded and processed
  227: 			var filesToDownload = remoteFiles.Except(alreadyProcessedFiles).ToList();
  228  
  229: 			filesToDownload = DownloadFiles(processDirectory, filesToDownload);
  230  			var actualLocalFiles = Array.ConvertAll(Directory.GetFiles(processDirectory), Path.GetFileName).ToList();

  232  			//Failed downloads will be all the files that is not on disk.
  233: 			var failedDownloads = filesToDownload.Except(actualLocalFiles).Except(alreadyProcessedFiles).ToList();
  234  			failedDownloadCount = failedDownloads.Count;

  237  			{
  238: 				Managers.BillingManager.AddBillingFile(_authToken, new BillingFile() { BillingFileStatus = BillingFilesStatus.FailedToDownload, FileName = failedDownload });
  239  			}
  240  			//Only process files that didn`t fail to download
  241: 			var filesToProcess = filesToDownload.Except(failedDownloads).ToList();
  242  			var billingFilesToProcess = new List<BillingFile>();

DynaMiX.Backend\Services\Billing\DynaMiX.Services.IridiumBilling.Tests\ProcessIridiumBillingTaskTest.cs:
  123  			{
  124: 				 new BillingFile(){BillingFileId = 101,BillingFileStatus = BillingFilesStatus.FailedToDownload,FileName ="CDUSA77MIXTL00111.dat" } 
  125  			});

DynaMiX.Backend\Services\Database Maintenance\DynaMiX.Services.DatabaseMaintenance\MigrationTasks\MigrateCostData.cs:
  217  						TransactionDate = costDataItem.Date.Value.Date,
  218: 						Odometer = costDataItem.Odometer,
  219  						Memo = string.IsNullOrEmpty(costDataItem.Memo) ? "-" : costDataItem.Memo,

  331  			item.CostCategoryId = BagSerialiser.GetInt(bag, "CategoryID", 0);
  332: 			item.Odometer = BagSerialiser.GetDecimal(bag, "Odo", 0);
  333  			item.Ongoing = BagSerialiser.GetBool(bag, "Continue", false);

  375  			trCmd.Parameters.AddWithValueNullable("transactionDate", transaction.TransactionDate);
  376: 			trCmd.Parameters.AddWithValueNullable("odometer", transaction.Odometer);
  377  			trCmd.Parameters.AddWithValueNullable("memo", transaction.Memo);

  426  			public DateTime? Date { get; set; }
  427: 			public decimal Odometer { get; set; }
  428  			public int CostCategoryId { get; set; }

  444  			public DateTime TransactionDate { get; set; }
  445: 			public decimal Odometer { get; set; }
  446  			public string Memo { get; set; }

DynaMiX.Backend\Services\Daylight Saving Adjustment\DynaMiX.Services.DaylightSavingAdjustment\DaylightSavingAdjustmentService.cs:
  213  
  214: 				//TODO: MR: Add the config setting switch in here
  215  
  216: 				//TODO: MR: IF NOT that, then still do the following
  217  

DynaMiX.Backend\Services\GenericNotifications\DynaMiX.Services.GenericNotifications\DynaMiXGenericNotificationsService.cs:
  1309  				pushNotificationHistory.Heading = otherDataInfo.Heading;
  1310: 				pushNotificationHistory.Odometer = otherDataInfo.Odometer;
  1311  				pushNotificationHistory.Speed = otherDataInfo.Speed;// Formated in Orgs unit

DynaMiX.Backend\Services\GenericNotifications\DynaMiX.Services.GenericNotifications\OtherDataHelper.cs:
  18  		public string SpeedUnit { get; set; }
  19: 		public double? Odometer { get; set; }
  20  		public int? Heading { get; set; }

  34  			SpeedUnit = GetValue("speedUnitsOfMeasure", correlationId);
  35: 			Odometer = GetValue<double>("odometer", correlationId);
  36  			Heading = GetValue<int>("heading", correlationId);

DynaMiX.Backend\Services\JourneyManagement\DynaMiX.Services.Journey.ServerSideEvents\JourneyServerSideEventsService.cs:
  100  				{
  101: 					//		if (thereIsWorkToDo)
  102  					//			AssignWorkToAvailableWorkerThread(someWorkItem);

DynaMiX.Backend\Services\JourneyManagement\JMActions\DynaMiX.Services.JMActionsService\JMActionsService.cs:
   58  		public static string ServiceName = "";
   59: 		public static long OdoPositionTimeCutOff = 0;
   60: 		public static long OdoJourneyfinalArrivalAge = 0;
   61  		public static long _serviceUserAccountID = 0;
   62  		public static Dictionary<long, int> organizationLocationSize = new Dictionary<long, int>();
   63: 		public static List<long> JourneysForOdoChecks = new List<long>();
   64  		public static DateTime newFetchDue = DateTime.UtcNow;
   65: 		public static Dictionary<long, DateTime> JourneysForOdoChecksExclude = new Dictionary<long, DateTime>();
   66  	}

  112  		private const string XMIN_OUT_JOURNEY = "XMinOutJourneyTask";
  113: 		private const string QUEUE_JOURNEY_ROUTE_ODO = "QueueJourneyRouteOdoTask";
  114: 		private const string QUEUE_JOURNEY_ROUTE_TASK_ODO_KEY = "QueueJourneyRouteOdoTaskKey";
  115  		private const string JM_STOPLOCATION_TYPE = "JMStopLocations";

  211  
  212: 				GlobalVar.OdoPositionTimeCutOff = Properties.Settings.Default.OdoPositionTimeCutOff;
  213: 				GlobalVar.OdoJourneyfinalArrivalAge = Properties.Settings.Default.OdoJourneyfinalArrivalAge;
  214  				GlobalVar._serviceUserAccountID = _serviceUserAccountID;
  215  
  216: 				DmXLogger.Log($"OdoPositionTimeCutOff: {GlobalVar.OdoPositionTimeCutOff}, OdoJourneyfinalArrivalAge: {GlobalVar.OdoJourneyfinalArrivalAge}", LogLevel.Production);
  217  

  349  
  350: 		public void OdoJourneyRouteTaskExecuted(ScheduledTask task)
  351  		{
  352: 			DmXLogger.Log("Executed Odometer Journey Route Location Update task : " + task.Description + " " + task.Key + " " + task.ScheduledTaskId);
  353  		}

  423  
  424: 				//Added task to update Odo for Journey
  425: 				if (_jmActionsScheduler.GetTask(QUEUE_JOURNEY_ROUTE_TASK_ODO_KEY) is QueueJourneyRouteOdoTask odoJourneyRouteTask)
  426  				{
  427: 					DmXLogger.Log($"Remove Old QUEUE_JOURNEY_ROUTE_TASK_ODO_KEY Tasks: '{odoJourneyRouteTask.Description}', ScheduledTaskId[{odoJourneyRouteTask.ScheduledTaskId}]");
  428: 					_jmActionsScheduler.DeleteTask(odoJourneyRouteTask.ScheduledTaskId);
  429  				}

  907  
  908: 			//end Added task to update Odo for Journey
  909  			JourneyRoute currentJourneyRoute = JourneyRouteClient.GetJourneyRoute(journeyCleanupActionMessage.JourneyId);

DynaMiX.Backend\Services\JourneyManagement\JMActions\DynaMiX.Services.JMActionsService\Properties\Settings.Designer.cs:
  193          [global::System.Configuration.DefaultSettingValueAttribute("60")]
  194:         public int OdoPositionTimeCutOff {
  195              get {
  196:                 return ((int)(this["OdoPositionTimeCutOff"]));
  197              }

  202          [global::System.Configuration.DefaultSettingValueAttribute("360")]
  203:         public int OdoJourneyfinalArrivalAge {
  204              get {
  205:                 return ((int)(this["OdoJourneyfinalArrivalAge"]));
  206              }

  211          [global::System.Configuration.DefaultSettingValueAttribute("60")]
  212:         public int OdoAdjustmentFrequencyMinutes {
  213              get {
  214:                 return ((int)(this["OdoAdjustmentFrequencyMinutes"]));
  215              }

  220          [global::System.Configuration.DefaultSettingValueAttribute("60")]
  221:         public double ForceOdoListReloadMinutes {
  222              get {
  223:                 return ((double)(this["ForceOdoListReloadMinutes"]));
  224              }

  229          [global::System.Configuration.DefaultSettingValueAttribute("10")]
  230:         public int ThreadsPerOdoTask {
  231              get {
  232:                 return ((int)(this["ThreadsPerOdoTask"]));
  233              }

DynaMiX.Backend\Services\JourneyManagement\JMActions\DynaMiX.Services.JMActionsService\ScheduledTasks\QueueJourneyRouteOdoTask.cs:
   20  	[Serializable]
   21: 	public class QueueJourneyRouteOdoTask : ScheduledTask
   22  	{

   31  
   32: 		public QueueJourneyRouteOdoTask(string description, Schedule schedule, string key = null, string[] groupKeys = null) : base(description, schedule, key, groupKeys) { }
   33  

   35  		{
   36: 			DmXLogger.Log("Hit Odo task");
   37  			try
   38  			{
   39: 				if (!GlobalVar.JourneysForOdoChecks.Any() || GlobalVar.newFetchDue < DateTime.UtcNow)
   40  				{
   41: 					GlobalVar.newFetchDue = DateTime.UtcNow.AddMinutes(Properties.Settings.Default.ForceOdoListReloadMinutes);
   42: 					DmXLogger.Log($"Journeys to odo: Count: {GlobalVar.JourneysForOdoChecks.Count()} old", LogLevel.Debug);
   43  					JourneyClient journeyClient = new JourneyClient(Properties.Settings.Default.SafetyInternalApiUrl, GlobalVar._serviceUserAccountID);
   44: 					GlobalVar.JourneysForOdoChecks = journeyClient.GetJourneyUpdateActualOdometerList(GlobalVar.OdoJourneyfinalArrivalAge);
   45: 					DmXLogger.Log($"Journeys to odo: Count: {GlobalVar.JourneysForOdoChecks.Count()} new", LogLevel.Debug);
   46: 					foreach (var item in GlobalVar.JourneysForOdoChecksExclude)
   47  					{

   50  							DmXLogger.Log($"Skip for Recheck Journey: Key: {item.Key}, Value: {item.Value}", LogLevel.Debug);
   51: 							GlobalVar.JourneysForOdoChecks.Remove(item.Key);
   52  						}

   54  				}
   55: 				int getTop = Properties.Settings.Default.ThreadsPerOdoTask;
   56  
   57  				//filter out pending journeys
   58: 				if (GlobalVar.JourneysForOdoChecks.Count() < getTop)
   59: 					getTop = GlobalVar.JourneysForOdoChecks.Count();
   60  
   61: 				List<long> updateJourneyIds = GlobalVar.JourneysForOdoChecks.GetRange(0, getTop);
   62: 				GlobalVar.JourneysForOdoChecks.RemoveRange(0, getTop);
   63  				List<Thread> threads = new List<Thread>();

   65  				{
   66: 					DmXLogger.Log($"QueueJourneyRouteOdoTask kick off new thread for JourneyId[{journeyId}]", LogLevel.Debug);
   67  					Thread a = new Thread(() =>

   70  						/* run your code here */
   71: 						UpdateJourneyOdo(journeyId);
   72  

   79  			{
   80: 				DmXLogger.Log(new Exception($"QueueJourneyRouteOdoTask", exception));
   81  			}

   83  
   84: 		public static void UpdateJourneyOdo(long journeyId)
   85  		{

  122  					{
  123: 						float departureOdometer = 0;
  124: 						float arrivalOdometer = 0;
  125  

  127  						{
  128: 							DateTime from = DateTime.SpecifyKind(journeyRouteLocation.ActualDepartureDate.DateTime.AddSeconds(GlobalVar.OdoPositionTimeCutOff * -1), DateTimeKind.Utc);//might change to seconds
  129: 							DateTime to = DateTime.SpecifyKind(journeyRouteLocation.ActualDepartureDate.DateTime.AddSeconds(GlobalVar.OdoPositionTimeCutOff), DateTimeKind.Utc);//might change to seconds
  130  

  134  							{
  135: 								var validPositions = positions.Where(x => x.OdometerKilometres != 0 && x.OdometerKilometres != null);
  136  								var enumerable = validPositions as Position[] ?? validPositions.ToArray();

  159  									}
  160: 									departureOdometer = (float)closestPositionDeparture.OdometerKilometres;
  161  								}

  166  						{
  167: 							DateTime from = DateTime.SpecifyKind(journeyRouteLocation.ActualArrivalDate.DateTime.AddMinutes(GlobalVar.OdoPositionTimeCutOff * -1), DateTimeKind.Utc);//might change to seconds
  168: 							DateTime to = DateTime.SpecifyKind(journeyRouteLocation.ActualArrivalDate.DateTime.AddMinutes(GlobalVar.OdoPositionTimeCutOff), DateTimeKind.Utc);//might change to seconds
  169  

  173  							{
  174: 								var validPositions = positions.Where(x => x.OdometerKilometres != 0 && x.OdometerKilometres != null);
  175  								var enumerable = validPositions as Position[] ?? validPositions.ToArray();

  198  									}
  199: 									arrivalOdometer = (float)closestPositionArrival.OdometerKilometres;
  200  								}

  203  
  204: 						var journeyRouteLocationOdometer = new JourneyRouteLocationOdometer()
  205  						{
  206  							JourneyRouteLocationId = journeyRouteLocation.JourneyRouteLocationId,
  207: 							DepartureOdometer = departureOdometer,
  208: 							ArrivalOdometer = arrivalOdometer
  209  						};
  210  
  211: 						if (departureOdometer != 0 || arrivalOdometer != 0 || saveZeroes)
  212  						{
  213: 							journeyRouteClient.UpdateJourneyRouteLocationOdometer(journeyRouteLocationOdometer);//add back
  214  						}

  217  							DmXLogger.Log($"Recheck JourneyId[{journeyId}], RecheckTime: {recheck}");
  218: 							GlobalVar.JourneysForOdoChecksExclude.AddIfMissing(journeyId, recheck);
  219  						}
  220  					}
  221: 					DmXLogger.Log($"JourneyId[{journeyId}], Odo Calculation completed in {(object)StopwatchSlim.GetElapsedMilliseconds(startTicks).ToString((IFormatProvider)CultureInfo.InvariantCulture)}");
  222  				}

  225  			{
  226: 				DmXLogger.Log(new Exception($"Exception while updating routeLocation Odo, journeyId[{journeyId}]", exception));
  227: 				//TODO: GDS Log the exception and send a message to the UI
  228  			}

DynaMiX.Backend\Services\JourneyManagement\JourneyDeparture\DynaMiX.Services.JourneyDeparture\JourneyDepartureService.cs:
  162  		/// <returns>true - the lead asset is NOT 'In Progress' on another Journey, false - the lead asset is 'In Progress' on another Journey</returns>
  163: 		/// TODO: Move this code to JM.API, so we can have one call for this service and the Departure Service.
  164  		private static bool CheckJourneyLeadAssetNOTInProgress(long leadAssetId, long journeyId)

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\OdoService.cs:
    4  using DynaMiX.Core.Logging;
    5: using DynaMiX.Services.JourneyOdos.DTO;
    6  using MiX.Core.Caching;

   20  
   21: namespace DynaMiX.Services.JourneyOdos
   22  {
   23  	[ExcludeFromCodeCoverage]
   24: 	public class OdoService : ServiceBase
   25  	{

   27  
   28: 		private JourneyOdoTask _journeyOdoTask = null;
   29  		public static ObjectMemoryCache<JourneyRouteInfoCache> _journeyRouteInfoCache = null;

   71  				};
   72: 				ResourceDataClient.RegisterRepository("JM Odos Service", GlobalVar.LightningTrackingUrl, retryFactory);
   73  

   99  		{
  100: 			_journeyOdoTask = new JourneyOdoTask();
  101  

  112  				var startDateTimeNow = new DateTimeOffset(DateTime.UtcNow.Year, DateTime.UtcNow.Month, DateTime.UtcNow.Day, DateTime.UtcNow.Hour, DateTime.UtcNow.Minute, 0, 0, new TimeSpan(0)).AddMinutes(2);
  113: 				var journeyIntervalSeconds = GlobalVar.JourneyOdoIntervalSeconds;
  114  				var hours = journeyIntervalSeconds / 60 / 60;

  133  				{
  134: 					_journeyOdoTask.PerformTask();
  135  				}

  137  				{
  138: 					DmXLogger.Log(new Exception("_calculateOdoTask failed", exception));
  139  					errors++;

  176  		{
  177: 			// OdoService
  178: 			this.ServiceName = "DynaMiX.Services.JourneyOdos";
  179  		}

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\OdoServiceInstaller.cs:
  3  
  4: namespace DynaMiX.Services.JourneyOdos
  5  {
  6  	[ExcludeFromCodeCoverage]
  7: 	public class OdoServiceInstaller : ThreadedServiceInstallerBase
  8  	{

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\Program.cs:
   4  
   5: namespace DynaMiX.Services.JourneyOdos
   6  {

  14  		{
  15: 			EnhancedServiceBase.Run(new ServiceBase[] { new OdoService() });
  16  		}

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\ServiceConfiguration.cs:
   3  
   4: namespace DynaMiX.Services.JourneyOdos
   5  {

  14  			(
  15: 				"DynaMiX Journey Odos Service", // service name e.g. "MiX DSI Calamp Incoming Service"
  16: 				"Processes journey odometer readings", // descrption e.g. "Processes incoming messages from Calamp units, transforms them into DSI messages and publishes them on the DSI incoming queues"
  17  				Properties.Settings.Default.LogFilePath,

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\Settings.cs:
  1: namespace DynaMiX.Services.JourneyOdos.Properties {
  2      

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\DTO\GlobalVar.cs:
   5  
   6: namespace DynaMiX.Services.JourneyOdos.DTO
   7  {

  10  	{
  11: 		public static int OdoPositionTimeCutOff = Convert.ToInt16(ConfigurationManager.AppSettings["OdoPositionTimeCutOff"]);
  12: 		public static int OdoJourneyFinalArrivalAge = Convert.ToInt16(ConfigurationManager.AppSettings["OdoJourneyFinalArrivalAge"]);
  13  		public static long ServiceUserAccountID = 40000000010016;
  14: 		public static double ForceOdoListReloadMinutes = Convert.ToDouble(ConfigurationManager.AppSettings["ForceOdoListReloadMinutes"]);
  15  		public static string SafetyInternalApiUrl = ConfigurationManager.AppSettings["SafetyInternalApiUrl"];
  16: 		public static int ThreadsPerOdoTask = Convert.ToInt16(ConfigurationManager.AppSettings["ThreadsPerOdoTask"]);
  17: 		public static List<long> JourneysForOdoChecks = new List<long>();
  18  		public static DateTime NewFetchDue = DateTime.UtcNow;
  19: 		public static Dictionary<long, DateTime> JourneysForOdoChecksExclude = new Dictionary<long, DateTime>();
  20: 		public static int JourneyOdoIntervalSeconds = Convert.ToInt16(ConfigurationManager.AppSettings["JourneyOdoIntervalSeconds"]);
  21  		public static string LightningTrackingUrl = ConfigurationManager.AppSettings["LightningTrackingUrl"];
  22: 		public static double JourneyRouteInfoCacheHours = Convert.ToDouble(ConfigurationManager.AppSettings["JourneyRouteInfoCacheHours"]);
  23  		public static ObjectMemoryCache<JourneyRouteInfoCache> JourneyRouteInfoCache = new ObjectMemoryCache<JourneyRouteInfoCache>(TimeSpan.FromHours(JourneyRouteInfoCacheHours));

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\DTO\JourneyRouteInfoCache.cs:
  4  
  5: namespace DynaMiX.Services.JourneyOdos.DTO
  6  {

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\Properties\AssemblyInfo.cs:
  3  
  4: [assembly: AssemblyTitle("DynaMiX.Services.JourneyOdos")]
  5  [assembly: AssemblyDescription("")]

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\Properties\Settings.Designer.cs:
  10  
  11: namespace DynaMiX.Services.JourneyOdos.Properties {
  12      

  36          [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
  37:         [global::System.Configuration.DefaultSettingValueAttribute("L:\\Services\\DynaMiX.Services.JourneyOdos\\DynaMiX.Services.JourneyOdos.log")]
  38          public string LogFilePath {

DynaMiX.Backend\Services\JourneyManagement\JourneyOdos\DynaMiX.Services.JourneyOdos\ScheduledTasks\JourneyOdoTask.cs:
    1  using DynaMiX.Core.Logging;
    2: using DynaMiX.Services.JourneyOdos.DTO;
    3  using MiX.Core;

   15  
   16: namespace DynaMiX.Services.JourneyOdos
   17  {

   19  	[Serializable]
   20: 	public class JourneyOdoTask
   21  	{

   24  
   25: 		public JourneyOdoTask()
   26  		{

   37  			DmXLogger.Log($"CorrelationId[{correlationId}] == CorrelationId[{longCorrelationId}]", LogLevel.Production, correlationId: correlationId);
   38: 			DmXLogger.Log("Hit Odo Task - Started", LogLevel.Production, correlationId: correlationId);
   39  

   41  			{
   42: 				if (!GlobalVar.JourneysForOdoChecks.Any() || GlobalVar.NewFetchDue < DateTime.UtcNow)
   43  				{
   44: 					GlobalVar.NewFetchDue = DateTime.UtcNow.AddMinutes(GlobalVar.ForceOdoListReloadMinutes);
   45: 					DmXLogger.Log($"Journeys to do odo check on, found '{GlobalVar.JourneysForOdoChecks.Count()}' journeys, Attempting to load from JourneyClient.", LogLevel.Production, correlationId: correlationId);
   46  					JourneyClient journeyClient = new JourneyClient(GlobalVar.SafetyInternalApiUrl, GlobalVar.ServiceUserAccountID);
   47: 					GlobalVar.JourneysForOdoChecks = journeyClient.GetJourneyUpdateActualOdometerList(GlobalVar.OdoJourneyFinalArrivalAge);
   48: 					DmXLogger.Log($"Journeys to do odo check on, found '{GlobalVar.JourneysForOdoChecks.Count()}' after reload from JourneyClient.", LogLevel.Production, correlationId: correlationId);
   49: 					foreach (var item in GlobalVar.JourneysForOdoChecksExclude)
   50  					{

   53  							DmXLogger.Log($"Journey Skipped for Recheck, Key: '{item.Key}', Value: '{item.Value}', Removing Journey from checklist.", LogLevel.Debug, correlationId: correlationId);
   54: 							GlobalVar.JourneysForOdoChecks.Remove(item.Key);
   55  						}

   57  				}
   58: 				int getTop = GlobalVar.ThreadsPerOdoTask;
   59  
   60: 				//TODO: filter out pending journeys
   61  
   62  
   63: 				if (GlobalVar.JourneysForOdoChecks.Count() < getTop)
   64: 					getTop = GlobalVar.JourneysForOdoChecks.Count();
   65  
   66: 				List<long> updateJourneyIds = GlobalVar.JourneysForOdoChecks.GetRange(0, getTop);
   67: 				GlobalVar.JourneysForOdoChecks.RemoveRange(0, getTop);
   68  				List<Thread> threads = new List<Thread>();

   70  				{
   71: 					DmXLogger.Log($"JourneyId[{journeyId}], QueueJourneyRouteOdoTask kick off new thread for this Journey", LogLevel.Debug, correlationId: correlationId);
   72  					Thread a = new Thread(() =>

   74  						Thread.CurrentThread.IsBackground = true;
   75: 						UpdateJourneyOdo(journeyId);
   76  					});

   87  
   88: 				DmXLogger.Log("Hit Odo Task - Ended", LogLevel.Production, correlationId: correlationId);
   89  			}

   91  			{
   92: 				DmXLogger.Log(new Exception("Exception while starting updating routeLocation Odo Thread", exception), correlationId);
   93  			}

   95  
   96: 		public void UpdateJourneyOdo(long journeyId)
   97  		{

  132  					{
  133: 						float departureOdometer = 0;
  134: 						float arrivalOdometer = 0;
  135  

  137  						{
  138: 							DateTime from = DateTime.SpecifyKind(journeyRouteLocation.ActualDepartureDate.DateTime.AddSeconds(GlobalVar.OdoPositionTimeCutOff * -1), DateTimeKind.Utc);//might change to seconds
  139: 							DateTime to = DateTime.SpecifyKind(journeyRouteLocation.ActualDepartureDate.DateTime.AddSeconds(GlobalVar.OdoPositionTimeCutOff), DateTimeKind.Utc);//might change to seconds
  140  

  144  							{
  145: 								var validPositions = positions.Where(x => x.OdometerKilometres != 0 && x.OdometerKilometres != null);
  146  								if (validPositions.Count() > 0)

  168  									}
  169: 									departureOdometer = (float)closestPositionDeparture.OdometerKilometres;
  170  								}

  176  						{
  177: 							DateTime from = DateTime.SpecifyKind(journeyRouteLocation.ActualArrivalDate.DateTime.AddMinutes(GlobalVar.OdoPositionTimeCutOff * -1), DateTimeKind.Utc);//might change to seconds
  178: 							DateTime to = DateTime.SpecifyKind(journeyRouteLocation.ActualArrivalDate.DateTime.AddMinutes(GlobalVar.OdoPositionTimeCutOff), DateTimeKind.Utc);//might change to seconds
  179  

  183  							{
  184: 								var validPositions = positions.Where(x => x.OdometerKilometres != 0 && x.OdometerKilometres != null);
  185  								if (validPositions.Count() > 0)

  207  									}
  208: 									arrivalOdometer = (float)closestPositionArrival.OdometerKilometres;
  209  								}

  212  
  213: 						var journeyRouteLocationOdometer = new MiX.JourneyManagement.Services.Dto.Dtos.JourneyRouteLocationOdometer()
  214  						{
  215  							JourneyRouteLocationId = journeyRouteLocation.JourneyRouteLocationId,
  216: 							DepartureOdometer = departureOdometer,
  217: 							ArrivalOdometer = arrivalOdometer
  218  						};
  219  
  220: 						if (departureOdometer != 0 || arrivalOdometer != 0 || saveZeroes)
  221  						{
  222: 							_journeyRouteClient.UpdateJourneyRouteLocationOdometer(journeyRouteLocationOdometer);
  223  							GlobalVar.JourneyRouteInfoCache.Remove($"JourneyId:{journeyId}");

  227  							DmXLogger.Log($"JourneyId[{journeyId}], Attempting to Recheck Journey: Time: ({recheck})", LogLevel.Debug, correlationId: correlationId);
  228: 							GlobalVar.JourneysForOdoChecksExclude.AddIfMissing(journeyId, recheck);
  229  						}

  231  
  232: 					DmXLogger.Log($"JourneyId[{journeyId}], Odo Calculation completed in ({(object)StopwatchSlim.GetElapsedMilliseconds(startTicks).ToString((IFormatProvider)CultureInfo.InvariantCulture)}ms)", LogLevel.Production, correlationId: correlationId);
  233  				}

  236  			{
  237: 				DmXLogger.Log(new Exception($"JourneyId[{journeyId}], Exception while updating routeLocation Odo", exception), correlationId);
  238: 				//TODO: GDS Log the exception and send a message to the UI
  239  			}

DynaMiX.Backend\Services\JourneyManagement\JourneyReminders\DynaMiX.Services.JourneyReminders\DTOs\JourneyApprovalReminderDto.cs:
  5  		public string Description { get; set; }
  6: 		//TODO: MR: Add other members here
  7  	}

DynaMiX.Backend\Services\JourneyManagement\JourneyReprocess\DynaMiX.Services.JourneyReprocess\JourneyReprocessService.cs:
   702  				{
   703: 					//TODO: look into adding the start buffer to a cache
   704  					buffer = JourneyClient.GetAutoStartBuffer(currentJourney.SiteId);

  1320  		/// <returns>true - terminate the thread</returns>
  1321: 		/// TODO: Move this code to JM.API, so we can have one call for this service and the Departure Service.
  1322  		private bool CheckJourneyLeadAssetNOTInProgress(MiX.JourneyManagement.Services.Dto.Dtos.Journey currentJourney, long journeyId, JourneyRoute currentJourneyRoute, ref bool journeyMustComplete)

  1353  			var correlationId = Trace.CorrelationManager.ActivityId.ToString();
  1354: 			var slightDeviationThresholdInMetres = Convert.ToDouble(settings.FirstOrDefault(s => s.Key == JourneyManagementOrganisationProperty.JMSlightDeviationThreshold.ToString()).Value, CultureInfo.InvariantCulture);
  1355: 			var offPlanThresholdInMetres = Convert.ToDouble(settings.FirstOrDefault(s => s.Key == JourneyManagementOrganisationProperty.JMOffPlanThreshold.ToString()).Value, CultureInfo.InvariantCulture);
  1356: 			var deviationTimeLimitInSeconds = Convert.ToDouble(settings.FirstOrDefault(s => s.Key == JourneyManagementOrganisationProperty.JMDeviationTimeLimit.ToString()).Value, CultureInfo.InvariantCulture);
  1357  

  1705  					case JourneyManagementOrganisationProperty.JMOffPlanThreshold:
  1706: 						if (Convert.ToDouble(propertyValue.Value, CultureInfo.InvariantCulture) > 0)
  1707  						{

  1711  					case JourneyManagementOrganisationProperty.JMSlightDeviationThreshold:
  1712: 						if (Convert.ToDouble(propertyValue.Value, CultureInfo.InvariantCulture) > 0)
  1713  						{

DynaMiX.Backend\Services\JourneyManagement\JourneyReprocess\DynaMiX.Services.JourneyReprocess\Properties\Settings.Designer.cs:
  164          [global::System.Configuration.DefaultSettingValueAttribute("60")]
  165:         public int OdoPositionTimeCutOff {
  166              get {
  167:                 return ((int)(this["OdoPositionTimeCutOff"]));
  168              }

  173          [global::System.Configuration.DefaultSettingValueAttribute("360")]
  174:         public int OdoJourneyfinalArrivalAge {
  175              get {
  176:                 return ((int)(this["OdoJourneyfinalArrivalAge"]));
  177              }

  182          [global::System.Configuration.DefaultSettingValueAttribute("60")]
  183:         public int OdoAdjustmentFrequencyMinutes {
  184              get {
  185:                 return ((int)(this["OdoAdjustmentFrequencyMinutes"]));
  186              }

DynaMiX.Backend\Services\JourneyManagement\JourneyRouteProgressUpdate\DynaMiX.Services.JourneyRouteProgressUpdate\JourneyRouteProgressUpdateService.cs:
  369  					tempPosition.NumberOfSatellites = (byte)(position.NumberOfSatellites == null ? 0 : position.NumberOfSatellites);
  370: 					tempPosition.OdometerKilometres = (float)(position.OdometerKilometres == null ? 0 : position.OdometerKilometres);
  371  					tempPosition.Pdop = (byte)(position.Pdop == null ? 0 : position.Pdop);

DynaMiX.Backend\Services\JourneyManagement\JourneyServerSideEvents\DynaMiX.Services.Journey.ServerSideEvents\JourneyServerSideEventsService.cs:
  799  					case JourneyManagementOrganisationProperty.JMOffPlanThreshold:
  800: 						if (Convert.ToDouble(propertyValue.Value, CultureInfo.InvariantCulture) > 0)
  801  						{

  806  					case JourneyManagementOrganisationProperty.JMSlightDeviationThreshold:
  807: 						if (Convert.ToDouble(propertyValue.Value, CultureInfo.InvariantCulture) > 0)
  808  						{

DynaMiX.Backend\Services\MiXFleet.Mobile\DynaMiX.Services.PushNotification.QueueService\DynaMiXServicesPushNotificationQueueService.cs:
  106  						gnNotification.OtherData.Add("heading", ((int) dsiEvent.Position.Heading).ToString());
  107: 						gnNotification.OtherData.Add("odometer", dsiEvent.Position.OdometerKilometres.ToString());
  108  

DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleet.Mobile.Api\Converters\DataConverter.cs:
   246  				CreatedBy = asset.CreatedBy,
   247: 				Odometer = asset.Odometer,
   248  				EngineHours = asset.EngineHours,

   276  				Unit = asset.TargetFuelConsumptionUnits,
   277: 				Value = targetFuelConsumption != 0 ? Convert.ToDouble(targetFuelConsumption) : (double?)null,
   278  			};

   283  				Unit = asset.TargetHourlyFuelConsumptionUnits,
   284: 				Value = targetHourlyFuelConsumption != 0 ? Convert.ToDouble(targetHourlyFuelConsumption) : (double?)null,
   285  			};

   582  			carrier.MaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(trip.MaxSpeed, userProfile, langGateway);
   583: 			carrier.Odometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(trip.SubTrips.OrderBy(st => st.Sequence).Last().Odometer, userProfile, langGateway);
   584: 			carrier.FuelUsage = (totalFuel.HasValue && totalFuel.Value != 0) ? UnitsOfMeasureCarrierConverter.GetVolumeCarrier(decimal.ToDouble(totalFuel.GetValueOrDefault()), userProfile) : null;
   585: 			carrier.FuelConsumption = (totalConsumption.HasValue && totalConsumption.Value != 0) ? UnitsOfMeasureCarrierConverter.GetConsumptionCarrier(decimal.ToDouble(totalConsumption.GetValueOrDefault()), userProfile) : null;
   586  

   704  
   705: 			var odometer = trip.EndOdometerKilomters ?? 0;
   706  			var totalConsumption = (totalFuel != 0) ? trip.DistanceKilometers / totalFuel : 0;

   722  			carrier.MaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(trip.MaxSpeedKilometersPerHour, userProfile, langGateway);
   723: 			carrier.Odometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(odometer, userProfile, langGateway);
   724: 			carrier.FuelUsage = totalFuel != 0 ? UnitsOfMeasureCarrierConverter.GetVolumeCarrier(decimal.ToDouble(totalFuel), userProfile) : null;
   725: 			carrier.FuelConsumption = totalConsumption != 0 ? UnitsOfMeasureCarrierConverter.GetConsumptionCarrier(decimal.ToDouble(totalConsumption), userProfile) : null;
   726  

   905  				MaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(subTrip.MaxSpeed, userProfile, langGateway),
   906: 				Odometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(subTrip.Odometer, userProfile, langGateway),
   907: 				FuelUsage = (subTrip.Litres.HasValue && subTrip.Litres.Value != 0) ? UnitsOfMeasureCarrierConverter.GetVolumeCarrier(decimal.ToDouble(subTrip.Litres.GetValueOrDefault()), userProfile) : null,
   908: 				FuelConsumption = (totalConsumption.HasValue && totalConsumption.Value != 0) ? UnitsOfMeasureCarrierConverter.GetConsumptionCarrier(decimal.ToDouble(totalConsumption.GetValueOrDefault()), userProfile) : null
   909  			};

  1026  			carrier.MaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(subTrip.MaxSpeedKilometersPerHour, userProfile, langGateway);
  1027: 			carrier.Odometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(subTrip.EndOdometerKilometres ?? 0, userProfile, langGateway);
  1028: 			carrier.FuelUsage = totalFuel != 0 ? UnitsOfMeasureCarrierConverter.GetVolumeCarrier(decimal.ToDouble(totalFuel), userProfile) : null;
  1029: 			carrier.FuelConsumption = totalConsumption != 0 ? UnitsOfMeasureCarrierConverter.GetConsumptionCarrier(decimal.ToDouble(totalConsumption), userProfile) : null;
  1030  

  2429  				Address = position.FormattedAddress,
  2430: 				Odometer = position.OdometerKilometres ?? 0,
  2431  				AgeOfReading = position.AgeOfReadingSeconds.HasValue ? (int)position.AgeOfReadingSeconds.Value : 0,

  2521  		public string Location { get; set; }
  2522: 		public float Odometer { get; set; }
  2523  		public int AgeOfReading { get; set; }

DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleet.Mobile.Api\Converters\UnitsOfMeasureCarrierConverter.cs:
  20  		{
  21: 			return GetDistanceCarrier(!value.HasValue ? (double?)null : Convert.ToDouble(value.Value), userProfile, langGateway);
  22  		}

  40  		{
  41: 			return GetSpeedCarrier(!value.HasValue ? (double?)null : Convert.ToDouble(value.Value), userProfile, langGateway);
  42  		}

DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleet.Mobile.Api\Modules\Data\DataModule.cs:
  492  		{
  493: 			//todo
  494  

DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleet.Mobile.Api\Shared\Carriers\Data\Selections\AssetDetailsCarrier.cs:
  17  		public string CreatedBy { get; set; }	
  18: 		public float? Odometer { get; set; }
  19  		public TimeSpan? EngineHours { get; set; }

DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleet.Mobile.Api\Shared\Carriers\Data\Trips\TripsCarrier.cs:
  31  		public SpeedCarrier MaxSpeed { get; set; }
  32: 		public DistanceCarrier Odometer { get; set; }
  33  

  54  		public SpeedCarrier MaxSpeed { get; set; }
  55: 		public DistanceCarrier Odometer { get; set; }
  56  

DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleet.Mobile.Api.Client\Clients\MiXFleetPositionApiClient.cs:
  56  			};
  57: 			var carrier = new EventIdsRequestCarrier(); //TODO: make this a GET route so a carrier is not necessary
  58  			return await SubmitRequestAsync<EventIdsRequestCarrier, List<PositionCarrier>>(DataModuleRoutes.GET_POSITIONS_FOR_TRIP, carrier, parameters);

DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleetPushConsole\Push.cs:
  50             
  51:             //TODO SerializerFactory.JSONSerializer.Serialize(notification);
  52              switch (platform)

DynaMiX.Backend\Services\MiXFleet.Mobile\MiXFleetPushConsole\Push3.cs:
  14  {
  15: 	//TODO - Update to PushSharp 3, and use this class instead
  16  

  90  
  91: 			//  TODO SerializerFactory.JSONSerializer.Serialize(notification);
  92  			switch (platform)

DynaMiX.Backend\Services\MiXGo\CloudServices\DynaMiX.Services.MiXGo.CloudServices\MiXGo.CloudServices.cs:
  129  				//Archive Request
  130: 				//TODO: Update the return value
  131  				MyRepositories.CommandRepository.ArchiveCloudCommand(command.DynamixId, returnValue);

DynaMiX.Backend\Services\SchedulerBot\SchedulerMaintenanceService.cs:
   39  		{
   40: 			// TODO: Add code here to perform any tear-down necessary to stop your service.
   41  		}

  156  		{
  157: 			//todo se4nd mail via email helpers 
  158  			//var emailer = new EmailHelper.EmailHelper()

DynaMiX.Backend\Utilities\DynaMiX.Migration.Compare\CompareProcess.cs:
  605  			/*
  606: 			TODO
  607  			If anything used R1 Power

DynaMiX.Backend\Utilities\DynaMiX.Migration.Compare\DataAccess\Events\ActionData.cs:
   27  			public byte ucEventType { get; set; }
   28: 			public bool bStartOdo { get; set; }
   29  			public bool bStartPosition { get; set; }
   30: 			public bool bEndOdo { get; set; }
   31  			public bool bEndPosition { get; set; }

   62  	ve.[ucEventType],
   63: 	ve.[bStartOdo],
   64  	ve.[bStartPosition],
   65: 	ve.[bEndOdo],
   66  	ve.[bEndPosition],

  158  
  159: 				ra.StartOdometer = actionDetail.bStartOdo;
  160: 				ra.EndOdometer = actionDetail.bEndOdo;
  161  				ra.StartPosition = actionDetail.bStartPosition;

  355  			a.RecordingType = settings.GetInt("recordType");
  356: 			a.StartOdometer = settings.GetBool("startOdometer");
  357: 			a.EndOdometer = settings.GetBool("endOdometer");
  358  			a.StartPosition = settings.GetBool("startPosition");

DynaMiX.Backend\Utilities\DynaMiX.Migration.Compare\Model\Events\Actions\RecordingAction.cs:
  7  		public int RecordingType { get; set; }
  8: 		public bool StartOdometer { get; set; }
  9: 		public bool EndOdometer { get; set; }
  10  		public bool StartPosition { get; set; }

DynaMiX.Backend\Utilities\IridiumWebServiceTestHarness\IridiumTestHarness\IridiumWrapper.cs:
  180  									deliveryMethod = deliveryMethodTypeEnum.DIRECT_IP, 
  181: 									destination = "10.10.1.1", //ToDo: Create a config entry for this. This is a per datacenter value
  182  									geoDataFlag = "TRUE", //Send geographical data?

DynaMiX.Backend\Utilities\Languaging\DynaMiX.Languaging.Converters\LanguageSet\LanguageSetDocument.cs:
  49  
  50: 			// TODO: add custom exception types.
  51  			if (xmlDocument.Root == null) throw new Exception();

DynaMiX.Backend\Utilities\Languaging\DynaMiX.Languaging.Converters.LngCompiler\Compiler.cs:
   9  			var languageSet = LanguageSet.FromLs2File(fmWebLs2, compileInsightOnly, writePoFormat);
  10: 			languageSet.MergeInsightRdlPoDocs(insightRdlFolder);
  11  			languageSet.AddNewInsightResourcesToTemplate(insightRdlFolder);

DynaMiX.Backend\Utilities\Languaging\DynaMiX.Languaging.Converters.LngCompiler\LanguageSet.cs:
   98  
   99: 		public void MergeInsightRdlPoDocs(string insightRdlFolder)
  100  		{

  178  			{
  179: 				var poDocument = new PortableObjectDocument();
  180: 				poDocument.Header.Properties["AppId"] = AppId;
  181: 				poDocument.Header.Properties["Language"] = language.FmWebLanguage;
  182: 				poDocument.Header.Properties["Culture"] = language.DynaMiXCulture;
  183  				foreach (var record in language.InsightResources.Any() ? language.InsightResources : language.Resources)
  184  				{
  185: 					poDocument.Records.Add(record, allowDuplicates: true);
  186  				}

  188  				if (!Directory.Exists(outputFolder)) Directory.CreateDirectory(outputFolder);
  189: 				poDocument.Save(Path.Combine(outputFolder, language.FileName));
  190  				Console.WriteLine("  {0}", language.FileName);

DynaMiX.Backend\Utilities\Languaging\DynaMiX.Languaging.Converters.Tests\PortableObject\PortableObjectDocumentTests.cs:
  298  
  299: 			// TODO: Cannot test PootleSample as pootle.po is incorrectly escaped.
  300  			//source = PortableObjectDocument.Load(SampleData.PootleSample);

DynaMiX.Backend\Utilities\MiX.CustomerStore.LocationMigration\Program.cs:
  88  		{
  89: 			// TODO: Remove below line once results are at a satisfactory level.
  90  			return false;

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\Carriers\Assets\AssetCarrier.cs:
  14  		public int EngineHours { get; set; }
  15: 		public float? Odometer { get; set; }
  16: 		public string OdometerUnit { get; set; }
  17  		public int StorageRatio { get; set; }

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\Carriers\Assets\AssetSummaryCarrier.cs:
  26  
  27: 			public string Odometer { get; set; }
  28  

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\Constants\Constants.cs:
  27  		public const string SETEXTRACTION = "SetExtraction";
  28: 		public const string SETODO = "SetOdo";
  29  		public const string LOADBINCONFIG = "LoadBinConfig";

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\Constants\PlugType.cs:
  11  		/** Green Normal Plug. */
  12: 		public static readonly PlugType NORMAL = new PlugType(1, new string[] { PlugCommandString.SETPLUGTYPE, PlugCommandString.STOREVEHICLEID, PlugCommandString.SETEXTRACTION, PlugCommandString.SETODO, PlugCommandString.LOADBINCONFIG, PlugCommandString.LOADDEVICEDRIVERSEX, PlugCommandString.LOADDEVICEDRIVERS, PlugCommandString.SETUPTACHO }, "Asset Plug", true, true, true);
  13  		///** Red Master Plug. */

  35  		/** Hour Meter Plug. */
  36: 		public static readonly PlugType ENGINEHOURS = new PlugType(13, new string[] { PlugCommandString.STOREVEHICLEID, PlugCommandString.SETODO }, "Engine Hours Plug", true, false, true);
  37  		/** Fuel Browser Info Plug. */

  53  		public static readonly PlugType FORMATHOS = new PlugType(25, new string[] { PlugCommandString.SETPLUGTYPE, PlugCommandString.STOREVEHICLEID, PlugCommandString.SETHOSDATA, PlugCommandString.SETHOSDRIVERDEF }, "Format HOS Data Plug", false, false, false);
  54: 		public static readonly PlugType FORMATENGINEHOURS = new PlugType(26, new string[] { PlugCommandString.SETPLUGTYPE, PlugCommandString.STOREVEHICLEID, PlugCommandString.SETODO }, "Format Engine hours plug", true, false, true);
  55  

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugControls\Plugs\ConfigPlug.cs:
   44  
   45: 			tbVehicleOdo.Visible = false;
   46  			dtTachoTripDownloadDate.Visible = false;

  119  
  120: 					//TODO: MR: Use enums for these statusses in BE & in PMU system
  121  					if (assetConfig.ConfigurationStatus.Equals("Ready for upload")

  329  
  330: 				lblUpdateOdo.Text = translator1.GetSimpleTranslation("Update vehicle odometer to") + " " + ((string.IsNullOrEmpty(tbVehicleOdo.Text.ToString()) ? "0" : tbVehicleOdo.Text)) + " " + Program.Asset.OdometerUnit;
  331  				tblOptions.RowStyles[5].Height = 25;
  332  				tblSummary.RowStyles[4].Height = 25;
  333: 				tbVehicleOdo.Visible = true;
  334: 				tbVehicleOdo.Focus();
  335  			}

  337  			{
  338: 				lblUpdateOdo.Text = "";
  339  				tblOptions.RowStyles[5].Height = 0;
  340  				tblSummary.RowStyles[4].Height = 0;
  341: 				tbVehicleOdo.Visible = false;
  342  			}

  453  			{
  454: 				var unit = Program.Asset.OdometerUnit;
  455: 				var value = float.Parse((string.IsNullOrEmpty(tbVehicleOdo.Text.Replace(" ", "").Trim())) ? "0" : tbVehicleOdo.Text.Replace(" ", "").Trim());
  456: 				float odometerKilometer = ConvertOdoToSystem(value, unit);
  457  
  458: 				plugHelper.Odometer = (int)Math.Round(odometerKilometer, 0);
  459  			}

  465  			{
  466: 				plugHelper.DateTime = dtTachoTripDownloadDate.Value.ToString("yyMMdd,HHmmss"); //TODO: MR: This is currently hidden. If this gets activated it should mimic the backend logic of timezones here.
  467  			}

  479  
  480: 		private float ConvertOdoToSystem(float value, string unit)
  481  		{

  505  			tbStorageRatio.Enabled = false;
  506: 			tbVehicleOdo.Enabled = false;
  507  			chkLoadConfig.Enabled = false;

  522  			tbStorageRatio.Enabled = true;
  523: 			tbVehicleOdo.Enabled = true;
  524  			chkLoadConfig.Enabled = true;

  581  
  582: 		private void tbVehicleOdo_TextChanged(object sender, EventArgs e)
  583  		{
  584: 			lblUpdateOdo.Text = translator1.GetSimpleTranslation("Update vehicle odometer to") + " " + tbVehicleOdo.Value.ToString() + " " + Program.Asset.OdometerUnit;
  585  		}
  586  
  587: 		private void tbVehicleOdo_KeyPress(object sender, KeyPressEventArgs e)
  588  		{

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugControls\Plugs\ConfigPlug.Designer.cs:
   46  			this.tbStorageRatio = new System.Windows.Forms.TrackBar();
   47: 			this.tbVehicleOdo = new System.Windows.Forms.NumericUpDown();
   48  			this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();

   62  			this.lblTerminal = new System.Windows.Forms.Label();
   63: 			this.lblUpdateOdo = new System.Windows.Forms.Label();
   64  			this.lblRequestTacho = new System.Windows.Forms.Label();

   78  			((System.ComponentModel.ISupportInitialize)(this.tbStorageRatio)).BeginInit();
   79: 			((System.ComponentModel.ISupportInitialize)(this.tbVehicleOdo)).BeginInit();
   80  			this.tableLayoutPanel1.SuspendLayout();

  120  			this.tblOptions.Controls.Add(this.tbStorageRatio, 0, 9);
  121: 			this.tblOptions.Controls.Add(this.tbVehicleOdo, 0, 5);
  122  			this.tblOptions.Location = new System.Drawing.Point(3, 7);

  177  			this.chkUpdateTacho.TabIndex = 4;
  178: 			this.chkUpdateTacho.Text = "Update vehicle odometer";
  179  			this.chkUpdateTacho.UseVisualStyleBackColor = true;

  234  			// 
  235: 			// tbVehicleOdo
  236  			// 
  237: 			this.tbVehicleOdo.Location = new System.Drawing.Point(3, 128);
  238: 			this.tbVehicleOdo.Maximum = new decimal(new int[] {
  239              9999999,

  242              0});
  243: 			this.tbVehicleOdo.Name = "tbVehicleOdo";
  244: 			this.tbVehicleOdo.Size = new System.Drawing.Size(322, 20);
  245: 			this.tbVehicleOdo.TabIndex = 9;
  246: 			this.tbVehicleOdo.ValueChanged += new System.EventHandler(this.tbVehicleOdo_TextChanged);
  247  			// 

  361  			this.tblSummary.Controls.Add(this.lblTerminal, 0, 3);
  362: 			this.tblSummary.Controls.Add(this.lblUpdateOdo, 0, 4);
  363  			this.tblSummary.Controls.Add(this.lblRequestTacho, 0, 5);

  411  			// 
  412: 			// lblUpdateOdo
  413  			// 
  414: 			this.lblUpdateOdo.AutoSize = true;
  415: 			this.lblUpdateOdo.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
  416: 			this.lblUpdateOdo.Location = new System.Drawing.Point(3, 105);
  417: 			this.lblUpdateOdo.Name = "lblUpdateOdo";
  418: 			this.lblUpdateOdo.Size = new System.Drawing.Size(0, 13);
  419: 			this.lblUpdateOdo.TabIndex = 4;
  420  			// 

  532  			((System.ComponentModel.ISupportInitialize)(this.tbStorageRatio)).EndInit();
  533: 			((System.ComponentModel.ISupportInitialize)(this.tbVehicleOdo)).EndInit();
  534  			this.tableLayoutPanel1.ResumeLayout(false);

  577  		private System.Windows.Forms.Label lblTerminal;
  578: 		private System.Windows.Forms.Label lblUpdateOdo;
  579  		private System.Windows.Forms.Label lblRequestTacho;

  584  		private System.Windows.Forms.Panel panel1;
  585:     private System.Windows.Forms.NumericUpDown tbVehicleOdo;
  586  		private System.Windows.Forms.LinkLabel linkLabel1;

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugControls\Plugs\DriverPlug.cs:
  177  
  178: 			//TODO: MR: WARN the user if only first 50 could be written
  179  

  248  
  249: 					(this.Parent.Parent as MainWindow).ChangeStatusLabel("Getting driver assets...."); //TODO: MR: Need to language these strings
  250  					btnGeneratePlug.Enabled = false;

  260  					btnGeneratePlug.Enabled = true;
  261: 					var listType = (dac != null && dac.DefaultAllowVehicleAccess) ? "whitelist" : "blacklist"; //TODO: MR: Language
  262  					var listCount = (dac != null && dac.Assets != null) ? dac.Assets.Count : 0;
  263: 					(this.Parent.Parent as MainWindow).ChangeStatusLabel("Done"); //TODO: MR: Need to language these strings
  264  

  326  			{
  327: 				MessageBox.Show("Driver timezones not found."); //TODO: MR: Fix this with languaging
  328  				return;

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugControls\Plugs\FormatPlug.cs:
  148  					var parent = ((MainWindow)((Panel)Parent).Parent);
  149: 					updateStatus("Problem setting " + commandExecuted); //TODO: MR: Need to language these strings
  150  					var descr = "Re-insert the plug and try again";

  161  					{
  162: 						updateStatus("Problem setting " + commandExecuted); //TODO: MR: Need to language these strings
  163  						lblError.Text = "Error : " + errorObj["ResultStr"];

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugControls\Plugs\PlugInformation.cs:
    46  
    47: 			//TODO: MR: HERE look for pod and driver, set accordingly and then call the changed event
    48  

   607  							{
   608: 								MessageBox.Show("You do not have permission to view the asset configured on this plug"); //TODO: MR: Language
   609  							}

   633  								DisableAllButtons();
   634: 								MessageBox.Show("You do not have permission to view the driver configured on this plug"); //TODO: MR: Language
   635  							}

   995  								var errorObj = PlugInfoConverter.textToJson(tachoDataResult);
   996: 								lblOrgCheckResult.Text = "Error : " + errorObj["ResultStr"]; //TODO: MR Force in here to check if it bombs! as this is new
   997  								lblOrgCheckResult.Visible = true;

  1005  						{
  1006: 							lblOrgCheckResult.Text = "Error : Couldn't read the event data. " + eventDataResult; //TODO: MR: Ensure all these are languaged
  1007  							lblOrgCheckResult.Visible = true;

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugControls\Plugs\USBPlug.cs:
  195  
  196: 			//TODO: MR: Ensure what should happen in the next two scenarios
  197  

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugHelpers\PlugHelper.cs:
   18  		public short? StorageRatio { get; set; }
   19: 		public int? Odometer { get; set; }
   20  		public int? EngineHours { get; set; }

  120  						}
  121: 						else if (command.Equals(PlugCommandString.SETODO))
  122  						{
  123: 							if (Odometer != null)
  124  							{
  125: 								plugCommand.Value = Odometer.ToString();
  126  
  127: 								plugCommand.FriendlyCommand = "Odometer";
  128  								es.commands.Add(plugCommand);

  598  						}
  599: 						else if (command.Equals(PlugCommandString.SETODO))
  600  						{
  601  							plugCommand.Value = (Convert.ToInt64(EngineHours * 3600)).ToString();
  602: 							plugCommand.FriendlyCommand = "Odometer";
  603  							es.commands.Add(plugCommand);

  625  						}
  626: 						else if (command.Equals(PlugCommandString.SETODO))
  627  						{
  628  							plugCommand.Value = "4294967295"; //As set in FMDealer.net
  629: 							plugCommand.FriendlyCommand = "Odometer";
  630  							es.commands.Add(plugCommand);

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugHelpers\PlugInterface.cs:
  258  				{
  259: 					//TODO: Return base64 byte[]
  260  					var bytes = File.ReadAllBytes(file);

  269  				{
  270: 					//TODO: Return base64 byte[]
  271  					var allBytes = File.ReadAllBytes(file);

  284  				{
  285: 					//TODO: Return base64 byte[]
  286  					var allBytes = File.ReadAllBytes(file);

DynaMiX.Backend\Utilities\SubscriptionMigrationTool\Models\DynamixApiSettings.cs:
   13  
   14: 		//todo jm: find a better way to do this.
   15  		[ConfigurationProperty("APIHost", IsRequired = true)]

  278  
  279: 		[ConfigurationProperty("DTCODownloadManagerBaseUrl", DefaultValue = "/dtco_download_manager")]
  280: 		public string DTCODownloadManagerBaseUrl
  281  		{
  282: 			get { return (string)base["DTCODownloadManagerBaseUrl"]; }
  283  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\EF\Tables\DefinitionLevel\DefinitionMessageTransportType.cs:
  12  		public bool CanDoFullDataDownload { get; set; }
  13: 		public bool CanDoFullTachoDownload { get; set; }
  14: 		public bool CanDoQuickTachoDownload { get; set; }
  15  		public bool CanDoFirmwareUpload { get; set; }

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\MiXConnect\MiXConnectRepository.cs:
  247  
  248: 		public void UpdateOdometer(string deviceId, float odoKm)
  249  		{
  250: 			// create set odo command
  251  			List<DeviceSetting> deviceSettings = new List<DeviceSetting>();
  252: 			deviceSettings.Add(new DeviceSetting(UdpParameterId.Odometer, (uint)(odoKm * 1000)));
  253  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\MobileUnitLevel\Command.cs:
   46  		MobileUnitCommand GetLastCommandSentToMobileUnit(long mobileUnitId, CommandIdType commandIdType);
   47: 		bool HasOdometerBeenSetByTheMobileUnit(long mobileUnitId, DateTime commandDate);
   48  		long GetNextConfigurationVersionIdForMobileUnit(long assetId);

  560  
  561: 		public bool HasOdometerBeenSetByTheMobileUnit(long mobileUnitId, DateTime commandDate)
  562  		{

  567  
  568: 				result = conn.Query<bool>("[staging].[HasOdoBeenSet]",
  569  					new { mobileUnitId, commandDate },

  573  
  574: 			Logger.Log($"Checking if odometer has been set by the mobile unit returns {result.ToString()}", LogLevel.Debug);
  575  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\Scheduler\DataScheduleManager.cs:
   56  		void RemoveDownloadSchedule(string authToken, long orgId, int scheduleId);
   57: 		void RequestCurrentStatus(string authToken, long orgId, long assetId, TripsEventsDownloadTypes type, string lastEditBy, TachoDownloadType tachoDownloadType = TachoDownloadType.None);
   58  

  457  
  458: 		public void RequestCurrentStatus(string authToken, long groupId, long assetId, TripsEventsDownloadTypes type, string lastEditBy, TachoDownloadType tachoDownloadType = TachoDownloadType.None)
  459  		{

  475  					TripsEventsDownload = type,
  476: 					TachoDownloadType = tachoDownloadType,
  477  					LastEditedBy = lastEditBy,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.DataAccess\Repository\TemplateLevel\EventTemplates.cs:
  154  		{
  155: 			//TODO: GET EventTemplate incl TemplateEvents, TemplateEventActions & TemplateEventConditions
  156  			EventTemplate eventTemplate = GetEventTemplateById(eventTemplateId);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\LargeFileTransfer\LargeFileTransferManager.cs:
   50  		Task StoreFilePart(string authToken, int scheduleID, int offset, int partSize, byte[] data);
   51: 		Task<LargeFileTransferEntities.LargeFileTransfer> GetNextFilePartToDownload(string authToken, int transferID, int maxPartSize);
   52  	}

  814  		/// </summary>
  815: 		public async Task<LargeFileTransferEntities.LargeFileTransfer> GetNextFilePartToDownload(string authToken, int transferID, int maxPartSize)
  816  		{
  817: 			Logger.Log($"LFT NancyModule GetNextFilePartToDownload({transferID}, {maxPartSize})", LogLevel.Debug);
  818  			LargeFileTransferEntities.LargeFileTransfer lft = new LargeFileTransferEntities.LargeFileTransfer();

  820  			LargeFileTransferStatus status = await RequestDownloadOffset(transferID, maxPartSize).ConfigureAwait(false);
  821: 		  Logger.Log($"LFT NancyModule GetNextFilePartToDownload: call to LFTManager.RequestDownloadOffset({transferID}, {maxPartSize}, -1) returned {status}, offset = {offset}", LogLevel.Debug);
  822  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\DeviceStateManager.cs:
  218  				Logger.Log($"MobileUnitId:{mobileUnitId} DeviceId:{deviceId} PropertyId:{propertyIdTripEnd} dateTime:{dateTime} tripeEndState.Value:{tripeEndState.Value} tripeEndState.DateUpdated:{tripeEndState.DateUpdated}", LogLevel.Debug);
  219: 				if (dateTime > tripeEndState.DateUpdated) //Is there a trip end Odo event after the command was sent?
  220  				{

  222  				}
  223: 				else //If there is a trip end Odo event after the command was sent, ie, trip has been completed
  224  				{

  228  						Logger.Log($"MobileUnitId:{mobileUnitId} DeviceId:{deviceId} PropertyId:{propertyIdCmdApplied} dateTime:{dateTime} tripeEndCmdAppliedState.Value:{tripeEndCmdAppliedState.Value} tripeEndCmdAppliedState.DateUpdated:{tripeEndCmdAppliedState.DateUpdated}", LogLevel.Debug);
  229: 						return dateTime > tripeEndCmdAppliedState.DateUpdated; //Was the Odo/EH value applied after the command was sent?
  230  					}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitCommandsManager.cs:
   46  
   47: 		long SendOdometerOffsetCommandToMobileUnit(long groupId, long mobileUnitId, int? preferredTransport, long odoOffsetMeters, string authToken);
   48  		long SendEngineHoursOffsetCommandToMobileUnit(long groupId, long mobileUnitId, int? preferredTransport, int engineHoursOffsetSeconds2, string authToken);

  141  		/// <param name="preferredTransport"></param>
  142: 		/// <param name="odoOffsetMeters"></param>
  143  		/// <returns></returns>
  144: 		public long SendOdometerOffsetCommandToMobileUnit(long groupId, long mobileUnitId, int? preferredTransport, long odoOffsetMeters, string authToken)
  145  		{

  149  				mobileUnitId,
  150: 				(int)CommandIdType.SetOdometerOffset,
  151  				preferredTransport,

  154  				null,
  155: 				odoOffsetMeters.ToString()).ConfigureAwait(false).GetAwaiter().GetResult();
  156  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitConfigurationManager.cs:
  402  
  403: 			var stateValue = _deviceConfigRepo.GetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET).ConfigureAwait(false).GetAwaiter().GetResult();
  404  			if (stateValue != null)
  405  			{
  406: 				int odometerMeters;
  407  
  408: 				if (Int32.TryParse(stateValue.Value, out odometerMeters))
  409  				{
  410: 					result.OdometerOffsetSeed_ReadOnly = odometerMeters;
  411  				}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:
   143  		void SetMobileUnitEngineSecondsOffset(string authToken, long orgId, long mobileUnitId, long value, long oldvalue);
   144: 		void SetMobileUnitOdometerMetersOrOffset(string authToken, long orgId, long mobileUnitId, long value, long oldvalue);
   145  		void SetMobileUnitUpdateScheduleForUpload(string authToken, long orgId, long mobileUnitId);

   197  		string AddMobileUnit(string authToken, long groupId, long configGroupId, long mobileUnitId, string uniqueIdentifier);
   198: 		bool CanSetOdoOrEngineHours(string authToken, long mobileUnitId, CommandIdType commandTypeId);
   199: 		FailReason CanSetOdoOrEngineHours2(string authToken, long mobileUnitId, CommandIdType commandTypeId);
   200: 		void ClearServersideOffsets(string authToken, long orgId, long mobileUnitId, bool clearOdoOffset = false, bool clearEngineHoursOffset = false);
   201  		bool UsesOnboardOffsets(string authToken, long orgId, long mobileUnitId);

   396  
   397: 				if (mobileUnitConfigCounters.Odometer.HasValue)
   398: 					_deviceConfigRepo.SetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET,
   399: 						mobileUnitConfigCounters.Odometer.ToString()).ConfigureAwait(false).GetAwaiter();
   400  				if (mobileUnitConfigCounters.EngineHours.HasValue)

   407  			{
   408: 				if (mobileUnitConfigCounters.Odometer.HasValue)
   409: 					_deviceConfigRepo.SetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET,
   410: 												mobileUnitConfigCounters.Odometer.ToString()).ConfigureAwait(false).GetAwaiter();
   411  				if (mobileUnitConfigCounters.EngineHours.HasValue)

   417  			{
   418: 				// Cannot set odo of DME/Calamp units with this method yet.
   419: 				Logger.Log($"Cannot set odo of Calamp units with this method yet (OrgId={orgId}, MobileUnitId={mobileUnitId})", LogLevel.Production);
   420  				return;

   438  
   439: 			ds.SetOdoKmValue = mobileUnitConfigCounters.Odometer.HasValue ? (int)Math.Round(mobileUnitConfigCounters.Odometer.Value / 1000.0) : mobileUnitConfigCounters.Odometer;
   440  			ds.TimeoutInMinutes = 15;

   513  			{
   514: 				// Cannot set odo of DME/Calamp units with this method yet.
   515  				Logger.Log($"Cannot set engine seconds of FMunits with this method yet (OrgId={orgId}, MobileUnitId={mobileUnitId})", LogLevel.Production);

   538  			ds.TransportTypeId = transportTypeId;
   539: 			ds.SetOdoKmValue = null;
   540  

   546  
   547: 		public void SetMobileUnitOdometerMetersOrOffset(string authToken, long orgId, long mobileUnitId, long meters, long oldmeters)
   548  		{

   571  				{
   572: 					DeviceStateValue state = _deviceConfigRepo.GetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.ODOMETER_OFFSET).ConfigureAwait(false).GetAwaiter().GetResult();
   573: 					//var ododOffset = (long)double.TryParse(state.Value, out long serverSideOdoOffset))
   574  
   575: 					if (state == null || !double.TryParse(state.Value, out double serverSideOdoOffset))
   576  					{
   577: 						serverSideOdoOffset = 0;
   578  						if (state == null)

   586  					}
   587: 					long diffMeters = meters - oldmeters + (long)serverSideOdoOffset;
   588: 					Logger.Log($"MobileUnitId:({mobileUnitId}), Calculated odometer offset to be sent to unit: Meters({meters}) - Oldmeters({oldmeters}) + ServerSideOdoOffset({serverSideOdoOffset}) = {diffMeters}", LogLevel.Debug);
   589: 					mucm.SendOdometerOffsetCommandToMobileUnit(orgId, mobileUnitId, (int)MessageTransport.Default, diffMeters, authToken);
   590  				}

   593  			{
   594: 				SetMobileUnitOdometerMeters(authToken, orgId, mobileUnitId, meters);
   595  			}

   634  
   635: 		private void SetMobileUnitOdometerMeters(string authToken, long orgId, long mobileUnitId, long meters)
   636  		{

   646  			{
   647: 				_deviceConfigRepo.SetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET, meters.ToString()).ConfigureAwait(false).GetAwaiter();
   648: 				_deviceConfigRepo.SetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.ASSET_LAST_DISPLAY_ODOMETER, meters.ToString()).ConfigureAwait(false).GetAwaiter();
   649  				return;

   651  
   652: 			#region Set Odo for Streamax Standalone
   653  			ISettingsProvider apiSettings = SettingsProviderFactory.GetProvider(Services.API.Constants.ServiceName);

   659  				var nativeDeviceIdentifier = new NativeDeviceIdentifier(DevicesDomain.EntityTypeOrRole.Streamax, $"{dataCentreName}.{mobileUnitId}");
   660: 				ThirdPartyConnectClient.AssetStateRepository.SetOdoAsync(nativeDeviceIdentifier, meters, userId: userName);
   661  				return;

   666  			{
   667: 				// Cannot set odo of DME/Calamp units with this method yet.
   668: 				Logger.Log($"Cannot set odo of Calamp units with this method yet (OrgId={orgId}, MobileUnitId={mobileUnitId})", LogLevel.Production);
   669  				return;

   684  
   685: 			ds.SetOdoKmValue = (int)Math.Round(meters / 1000.0); //int is OK for km values
   686  			ds.TimeoutInMinutes = 15;

  1521  
  1522: 				// TODO: implement in new CommandManager project
  1523: 				// TODO: add support for FM GPRS
  1524: 				// TODO: add support for Iridium/Satamatics
  1525  

  2354  			{
  2355: 				//TODO: MR: Loaded was null but maybe more accurate?
  2356  				configDetails.LastConfigAccepted = man.GetLatestCompileSnapshotForMobileUnit(authToken, mobileUnitId); //GetLoadedCompileSnapshotForMobileUnit

  3635  
  3636: 					_deviceConfigRepo.SetState(newMobileUnitConfig.MobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.ASSET_LAST_DISPLAY_ODOMETER, "0").ConfigureAwait(false).GetAwaiter();
  3637  

  3868  
  3869: 			var stateValue = _deviceConfigRepo.GetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET).ConfigureAwait(false).GetAwaiter().GetResult();
  3870  			if (stateValue != null)
  3871  			{
  3872: 				int odometerMeters;
  3873  
  3874: 				if (Int32.TryParse(stateValue.Value, out odometerMeters))
  3875  				{
  3876: 					result.OdometerOffsetSeed_ReadOnly = odometerMeters;
  3877  				}

  4815  
  4816: 		public bool CanSetOdoOrEngineHours(string authToken, long mobileUnitId, CommandIdType commandTypeId)
  4817  		{
  4818: 			return CanSetOdoOrEngineHours2(authToken, mobileUnitId, commandTypeId) == FailReason.Success;
  4819  		}
  4820  
  4821: 		public FailReason CanSetOdoOrEngineHours2(string authToken, long mobileUnitId, CommandIdType commandTypeId)
  4822  		{

  4826  
  4827: 				if (commandTypeId != CommandIdType.SetOdometerOffset && commandTypeId != CommandIdType.SetEngineHoursOffset)
  4828  					return FailReason.UnsupportedCommandType;

  4852  
  4853: 				//SR-12246 verify that the odometer readings are still being updated after trips when this is called.
  4854  				if (GetLastPendingCommand(muCmd) != null)

  4857  				// check if the unit has completed a trip and applied the offset last offset command
  4858: 				long displayUpdateParam = commandTypeId == CommandIdType.SetOdometerOffset ? Properties.LAST_TRIP_END_ODOMETER : Properties.LAST_TRIP_END_ENGINESECONDS;
  4859: 				//To check if the latest raw odo/eh values have been updated after the trip end
  4860: 				long displayCmdAppliedParam = commandTypeId == CommandIdType.SetOdometerOffset ? Properties.UNIT_RAW_ODOMETER : Properties.UNIT_RAW_ENGINESECONDS;
  4861  

  4920  		/// <summary>
  4921: 		/// Clears servers-side offsets for odo and/or engine hours. This is for the transition between server-side to unit-based odo/engine hours.
  4922  		/// </summary>

  4925  		/// <param name="mobileUnitId"></param>
  4926: 		/// <param name="clearOdoOffset"></param>
  4927  		/// <param name="clearEngineHoursOffset"></param>
  4928: 		public void ClearServersideOffsets(string authToken, long orgId, long mobileUnitId, bool clearOdoOffset = false, bool clearEngineHoursOffset = false)
  4929  		{
  4930: 			if (clearOdoOffset)
  4931  			{
  4932: 				bool canClearOdoOffset = false;
  4933  				if (IsDeviceEnabled(mobileUnitId, LogicalDevices.MIX4XXX_MOBILE_DEVICE_RANGE).ConfigureAwait(false).GetAwaiter().GetResult())
  4934  				{
  4935: 					canClearOdoOffset = IsLoadedFirmwareVersionGreaterThanOrEqualTo(mobileUnitId, 400080000); //4.8
  4936  				}

  4938  				{
  4939: 					canClearOdoOffset = IsLoadedFirmwareVersionGreaterThanOrEqualTo(mobileUnitId, 400080000);
  4940  				}

  4942  				{
  4943: 					canClearOdoOffset = IsLoadedFirmwareVersionGreaterThanOrEqualTo(mobileUnitId, 400080000);
  4944  				}

  4946  				{
  4947: 					canClearOdoOffset = IsLoadedFirmwareVersionGreaterThanOrEqualTo(mobileUnitId, 400080000);
  4948  				}
  4949: 				if (canClearOdoOffset)
  4950  				{
  4951: 					_deviceConfigRepo.SetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.ODOMETER_OFFSET, "0").ConfigureAwait(false).GetAwaiter();
  4952: 					_deviceConfigRepo.SetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.ASSET_LAST_DISPLAY_ODOMETER, "0").ConfigureAwait(false).GetAwaiter();
  4953  
  4954: 					// set Properties.NEW_ODOMETER_SET so that we do not trigger a recalculate on the next trip start
  4955: 					_deviceConfigRepo.SetState(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET, string.Empty).ConfigureAwait(false).GetAwaiter();
  4956  				}

  5718  				OrganisationDetail orgDetails = await _groupsRepo.GetOrganisationDetailAsync(org.GroupId, securityaccounts, null).ConfigureAwait(false);
  5719: 				companyId = orgDetails.CompanyId;//TODO-Pallavi:If called frequently then use caching(Timothy advised)
  5720  			}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\CommandSenders\MiX2kCommandSender.cs:
  48  
  49: 					// TODO: supported transports to be confirmed
  50  

  79  				CommandIdType.SendFirmware,
  80: 				CommandIdType.SetOdometerOffset,
  81  				CommandIdType.SetEngineHoursOffset

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\CommandSenders\MiX4k6kCommandSender.cs:
  215  				CommandIdType.SendFirmware,
  216: 				CommandIdType.SetOdometerOffset,
  217  				CommandIdType.SetEngineHoursOffset,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\CommandSenders\MobileUnitCommandSender.cs:
   99  				case CommandIdType.SendConfigurationToStandAloneDevice: // no parameters
  100: 				case CommandIdType.SetOdometerOffset:                 // no parameters
  101  				case CommandIdType.SetEngineHoursOffset:              // no parameters

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\CommandSenders\TeltonikaCommandSender.cs:
  54  
  55: 			//TODO : switch on CommandId? Currently CommandId is always set to CommandIdType.SendConfiguration.
  56  			long? result = await _ttkMessageSender.SendCommand(session, muc).ConfigureAwait(false);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MessageSenders\GprsAndSatamaticsMessageSender.cs:
  39  		{
  40: 			muc.MessageStatus = MessageStateType.Pending; // TODO: Check requirement for Draft messages (MobileUnitMessageState.New is then assigned)
  41  			muc.MessageId = _assetsProxy.AddCommandMessage(muc, username).ConfigureAwait(false).GetAwaiter().GetResult();
  42  			_assetsProxy.UpdateCommandMessageStatus(muc, MessageStateType.New).ConfigureAwait(false).GetAwaiter().GetResult();
  43: 			//if (!isDraftMessage) // TODO: Check requirement for Draft messages (MobileUnitMessageState.New is then assigned)
  44  			_assetsProxy.UpdateCommandMessageStatus(muc, MessageStateType.Pending).ConfigureAwait(false).GetAwaiter().GetResult();

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MessageSenders\MiXConnectMessageSender.cs:
  121  
  122: 					case CommandIdType.SetOdometerOffset:
  123  						{

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MessageSenders\TalkConnectMessageSender.cs:
  97  
  98: 			//TODO: MR: Changing of MasterNumber is a future story
  99  			long propertyId = GetPropertyIdToSet(muc);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MessageSenders\TeltonikaMessageSender.cs:
  28  		{
  29: 			if (!DependencyRegistry.IsRegistered<IMiXConnectTeltonikaProxy>())//TODO : Does this need device family?
  30  			{

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\EventTemplateManager.cs:
  180  				templateRecordingAction.Delay = libraryRecordingAction.Delay;
  181: 				templateRecordingAction.StartOdometer = libraryRecordingAction.StartOdometer;
  182: 				templateRecordingAction.EndOdometer = libraryRecordingAction.EndOdometer;
  183  				templateRecordingAction.StartPosition = libraryRecordingAction.StartPosition;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\TimeZones\TimeZoneCalculations.cs:
  22  			if (string.IsNullOrEmpty(siteTimeZoneName))
  23: 				throw new InvalidOperationException("The timezone for the site was not found."); //TODO: MR: ErrorMessages.ConfigAdmin.DEVIATION_SITE_TIMEZONE_NOT_FOUND
  24  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\TimeZones\TimeZonesHelper.cs:
  19  		{
  20: 			//TODO: MR: TECHDEBT-372: Dyanamix Core has DynaMiX.Globalisation.Api.Client.GlobalisationClient
  21  			if (timezoneId == null || timezoneId == string.Empty)

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic.UnitTests\Managers\MobileUnitLevel\MobileUnitManagerTests.cs:
  227  		[Category("CICDTests")]
  228: 		public void SetODO_MESA_Returns()
  229  		{

  249  
  250: 			//repoMock.Setup(x => x.SetState(456, LogicalDevices.BASE_MESA_FUNCTIONALITY, Properties.UNIT_RAW_ODOMETER, "1000", null));
  251: 			repoMock.Setup(x => x.SetState(456, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET, "1000", null)).Returns(Task.CompletedTask);
  252  

  254  			var mobileUnitConfigCounters = new MobileUnitConfigCounters();
  255: 			mobileUnitConfigCounters.Odometer = 1000;
  256  			mum.UpdateMobileUnitConfigCounters("SOME TOKEN", 123, 456, mobileUnitConfigCounters);

  265  		[Category("CICDTests")]
  266: 		public void SetODO_M2K_Returns()
  267  		{

  288  				.ReturnsAsync(true);
  289: 			//repoMock.Setup(x => x.SetState(456, LogicalDevices.MIX2XXX_MOBILE_DEVICE_RANGE, Properties.UNIT_RAW_ODOMETER, "1000", null));
  290: 			repoMock.Setup(x => x.SetState(456, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET, "1000", null)).Returns(Task.CompletedTask);
  291  

  293  			var mobileUnitConfigCounters = new MobileUnitConfigCounters();
  294: 			mobileUnitConfigCounters.Odometer = 1000;
  295  			mum.UpdateMobileUnitConfigCounters("SOME TOKEN", 123, 456, mobileUnitConfigCounters);

  304  		[Category("CICDTests")]
  305: 		public void SetODO_DME_Returns()
  306  		{

  328  				.ReturnsAsync(true);
  329: 			//repoMock.Setup(x => x.SetState(456, LogicalDevices.DME_HIDDEN, Properties.UNIT_RAW_ODOMETER, "1000", null));
  330: 			repoMock.Setup(x => x.SetState(456, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET, "1000", null)).Returns(Task.CompletedTask);
  331  

  333  			var mobileUnitConfigCounters = new MobileUnitConfigCounters();
  334: 			mobileUnitConfigCounters.Odometer = 1000;
  335  			mum.UpdateMobileUnitConfigCounters("SOME TOKEN", 123, 456, mobileUnitConfigCounters);

  482  			repoMock.Setup(x => x.SetState(456, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ENGINESECONDS_SET, "1000", null)).Returns(Task.CompletedTask);
  483: 			//repoMock.Setup(x => x.SetState(456, LogicalDevices.BASE_MESA_FUNCTIONALITY, Properties.UNIT_RAW_ODOMETER, "1000", null));
  484: 			repoMock.Setup(x => x.SetState(456, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET, "1000", null)).Returns(Task.CompletedTask);
  485  
  486  			MobileUnitManager mum = new MobileUnitManager();
  487: 			var mobileUnitConfigCounters = new MobileUnitConfigCounters() { EngineHours = 1000, Odometer = 1000 };
  488  

  522  			repoMock.Setup(x => x.SetState(456, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ENGINESECONDS_SET, "1000", null)).Returns(Task.CompletedTask);
  523: 			repoMock.Setup(x => x.SetState(456, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET, "1000", null)).Returns(Task.CompletedTask);
  524: 			//repoMock.Setup(x => x.SetState(456, LogicalDevices.MIX2XXX_MOBILE_DEVICE_RANGE, Properties.UNIT_RAW_ODOMETER, "1000", null));
  525  

  528  			mobileUnitConfigCounters.EngineHours = 1000;
  529: 			mobileUnitConfigCounters.Odometer = 1000;
  530  			mum.UpdateMobileUnitConfigCounters("SOME TOKEN", 123, 456, mobileUnitConfigCounters);

  564  			//repoMock.Setup(x => x.SetState(456, LogicalDevices.DME_HIDDEN, Properties.NEW_ENGINESECONDS_SET, "1000", null));
  565: 			//repoMock.Setup(x => x.SetState(456, LogicalDevices.DME_HIDDEN, Properties.UNIT_RAW_ODOMETER, "1000", null));
  566: 			repoMock.Setup(x => x.SetState(456, LogicalDevices.ALL_MOBILE_UNITS, Properties.NEW_ODOMETER_SET, "1000", null)).Returns(Task.CompletedTask);
  567  

  570  			mobileUnitConfigCounters.EngineHours = 1000;
  571: 			mobileUnitConfigCounters.Odometer = 1000;
  572  			mum.UpdateMobileUnitConfigCounters("SOME TOKEN", 123, 456, mobileUnitConfigCounters);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Controllers\LargeFileTransfer\LargeFileTransferController.cs:
  114  		/// <returns></returns>
  115: 		[Route(LargeFileTransferControllerRoutes.GetNextFilePartToDownload, Name = "GetNextFilePartToDownload")]
  116  		[ResponseType(typeof(LargeFileTransferEntities.LargeFileTransfer))]
  117  		[HttpGet]
  118: 		public async Task<HttpResponseMessage> GetNextFilePartToDownload(string authToken, int fileTransferId, int maxPartSize)
  119  		{

  123  				{
  124: 					return await man.GetNextFilePartToDownload(authToken, fileTransferId, maxPartSize).ConfigureAwait(false);
  125  				}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Controllers\MobileUnitLevel\MobileUnitController.cs:
   910  		/// <summary>
   911: 		/// Set mobile unit odometer in meters
   912  		/// </summary>

   918  		/// <returns></returns>
   919: 		[Route(MobileUnitControllerRoutes.SetMobileUnitOdometerMeters, Name = "SetMobileUnitOdometerMeters")]
   920  		[HttpPost]
   921: 		public HttpResponseMessage SetMobileUnitOdometerMeters(string authToken, long groupId, long mobileUnitId, long meters, long oldmeters)
   922  		{
   923: 			return HandledVoidResponse(MobileUnitControllerRoutes.SetMobileUnitOdometerMeters, () =>
   924  			{

   926  				{
   927: 					man.SetMobileUnitOdometerMetersOrOffset(authToken, groupId, mobileUnitId, meters, oldmeters);
   928  				}

  1620  		/// <returns></returns>
  1621: 		[Obsolete("CanSetOdoOrEngineHours is deprecated, please use CanSetOdoOrEngineHours2 instead.")]
  1622: 		[Route(MobileUnitControllerRoutes.CanSetOdoOrEngineHours, Name = "CanSetOdoOrEngineHours")]
  1623  		[ResponseType(typeof(bool))]
  1624  		[HttpGet]
  1625: 		public HttpResponseMessage CanSetOdoOrEngineHours(string authToken, long mobileUnitId, CommandIdType commandTypeId)
  1626  		{
  1627: 			return HandledResponse(MobileUnitControllerRoutes.CanSetOdoOrEngineHours, () =>
  1628  			{

  1630  				{
  1631: 					return man.CanSetOdoOrEngineHours(authToken, mobileUnitId, commandTypeId);
  1632  				}

  1642  		/// <returns>FailReason</returns>
  1643: 		[Route(MobileUnitControllerRoutes.CanSetOdoOrEngineHours2, Name = "CanSetOdoOrEngineHours2")]
  1644  		[ResponseType(typeof(FailReason))]
  1645  		[HttpGet]
  1646: 		public HttpResponseMessage CanSetOdoOrEngineHours2(string authToken, long mobileUnitId, CommandIdType commandTypeId)
  1647  		{
  1648: 			return HandledResponse(MobileUnitControllerRoutes.CanSetOdoOrEngineHours2, () =>
  1649  			{

  1651  				{
  1652: 					return man.CanSetOdoOrEngineHours2(authToken, mobileUnitId, commandTypeId);
  1653  				}

  1658  		/// <summary>
  1659: 		/// Clears servers-side offsets for odo and/or engine hours. This is for the TRANSITION between server-side to unit-based odo/engine hours.
  1660  		/// </summary>

  1663  		/// <param name="mobileUnitId"></param>
  1664: 		/// <param name="clearOdoOffset"></param>
  1665  		/// <param name="clearEngineHoursOffset"></param>

  1668  		[HttpPut]
  1669: 		public HttpResponseMessage ClearServersideOffsets(string authToken, long groupId, long mobileUnitId, bool clearOdoOffset=false, bool clearEngineHoursOffset=false)
  1670  		{

  1674  				{
  1675: 					man.ClearServersideOffsets(authToken, groupId, mobileUnitId, clearOdoOffset, clearEngineHoursOffset);
  1676  				}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Routes\LargeFileTransfer\LargeFileTransferControllerRoutes.cs:
  34  		/// </summary>
  35: 		public const string GetNextFilePartToDownload =
  36  			"large-file-transfer/transfer-ids/{fileTransferId}/max-part-size/{maxPartSize}/next-file-part-to-download";

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Routes\MobileUnitLevel\MobileUnitControllerRoutes.cs:
  239  		/// <summary>
  240: 		/// Set Engine hours and Odometer for a mobile unit
  241  		/// </summary>

  244  		/// <summary>
  245: 		/// Set Odometer for a mobile unit
  246  		/// </summary>
  247: 		public const string SetMobileUnitOdometerMeters = "groupId/{groupId}/mobile-units/{mobileUnitId}/odometer/{meters}/{oldmeters}";
  248  
  249  		/// <summary>
  250: 		/// Set Odometer offset for a mobile unit
  251  		/// </summary>
  252: 		public const string SetMobileUnitOdometerOffsetMeters = "groupId/{groupId}/mobile-units/{mobileUnitId}/odometer-offset/{meters}";
  253  

  449  		/// <summary>
  450: 		/// Check if the device is enabled for odo or enginehours set given mobile unit
  451  		/// </summary>
  452: 		//[Obsolete("CanSetOdoOrEngineHours is deprecated, please use CanSetOdoOrEngineHours2 instead.")]
  453: 		public const string CanSetOdoOrEngineHours = "mobile-units/{mobileUnitId}/command-type/{commandTypeId}/can-set-odo-or-enginehours";
  454  
  455  		/// <summary>
  456: 		/// Check if the device is enabled for odo or enginehours set given mobile unit
  457  		/// </summary>
  458: 		public const string CanSetOdoOrEngineHours2 = "mobile-units/{mobileUnitId}/command-type/{commandTypeId}/can-set-odo-or-enginehours2";
  459  
  460  		/// <summary>
  461: 		/// Clear server-side offsets for Odometer/Engine hours
  462  		/// </summary>

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API.Client\Proxies\MobileUnitLevel\DeviceStateProxy.cs:
   18  		string GetMobileUnitVehicleMode(long mobileUnitId);
   19: 		string GetMobileUnitOdometer(long mobileUnitId);
   20  		string GetMobileUnitImsi(long mobileUnitId);

  141  
  142: 		public string GetMobileUnitOdometer(long mobileUnitId)
  143  		{
  144: 			return GetDeviceStateValueForMobileUnit(mobileUnitId, LogicalDevices.ALL_MOBILE_UNITS, Properties.UNIT_RAW_ODOMETER);
  145  		}

  201  
  202: 		public void SetMobileUnitOdometer(long mobileUnitId, string value)
  203  		{

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API.Client\Proxies\MobileUnitLevel\MobileUnitProxy.cs:
   43  		bool IsMobileUnitM2kEngineHoursEnabled(long mobileUnitId);
   44: 		List<long> GetMobileUnitsThatHaveEstimatedOdo(long orgId);
   45: 		bool DoesUnitHaveEstimatedOdometer(long mobileUnitId);
   46  		List<MobileUnitHealthCheckData> GetMobileUnitHealthCheck(long orgId, List<long> mobileUnitIds);

   61  		void UpdateMobileUnitConfigCounters(string authToken, long groupId, long mobileUnitId, MobileUnitConfigCounters mobileUnitConfigCounters);
   62: 		void SetMobileUnitOdometerMeters(string authToken, long groupId, long mobileUnitId, long meters, long oldmeters);
   63  		void SetMobileUnitEngineSeconds(string authToken, long groupId, long mobileUnitId, long seconds, long oldseconds);

  326  
  327: 		public List<long> GetMobileUnitsThatHaveEstimatedOdo(long orgId)
  328  		{
  329: 			return GetMobileUnitIdsThatHaveDeviceAvailableForOrg(orgId, LogicalDevices.ESTIMATED_ODOMETER);
  330  		}
  331  
  332: 		public bool DoesUnitHaveEstimatedOdometer(long mobileUnitId)
  333  		{
  334: 			return IsDeviceEnabled(mobileUnitId, LogicalDevices.ESTIMATED_ODOMETER);
  335  		}

  467  
  468: 		public void SetMobileUnitOdometerMeters(string authToken, long groupId, long mobileUnitId, long meters, long oldmeters)
  469  		{
  470: 			DoPost(MobileUnitControllerRoutes.SetMobileUnitOdometerMeters, null,
  471  				new RequestParameter("authToken", authToken, RequestParameter.RequestParameterType.QueryString),

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Api.Client.IntegrationTests\LibraryLevel\LibraryLocationsProxyTests.cs:
  23          {
  24: 			//TODO: Unable to add a locations in UI
  25              ILibraryLocationsProxy libraryLocationsProxy = new LibraryLocationsProxy(Settings.ConfigServerUrl);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Api.Client.IntegrationTests\MobileUnitLevel\MobileUnitConfigurationProxyTests.cs:
  169  		[Test, Category("Integration")]
  170: 		public void GetMobileUnitOdometer()
  171  		{
  172  			IDeviceStateProxy mobileUnitProxy = new DeviceStateProxy(Settings.ConfigServerUrl);
  173: 			string odometer = mobileUnitProxy.GetMobileUnitOdometer(1687195454390615896);
  174: 			Assert.IsNotNull(odometer);
  175  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Api.Client.IntegrationTests\MobileUnitLevel\MobileUnitProxyTests.cs:
  126  			bool result = proxy.IsMobileUnitM2kEngineHoursEnabled(DatabaseIds.MobileUnitIds.Steve2kEngine);
  127: 			Assert.That(result, "device is a mix2k with engine hours enabled"); //TODO: MR: Couldn't test.
  128  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Api.Client.IntegrationTests\TemplateLevel\LocationTemplateProxyTests.cs:
  24  		{
  25: 			//TODO: Unable to add a locations in UI
  26  			ILocationTemplateProxy LocationTemplateProxy = new LocationTemplateProxy(Settings.ConfigServerUrl);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataAccess\Entities\ConfigAcceptedBuildContext.cs:
  126  
  127: 						if(bool.TryParse(Actions[i].Settings[StartOdometerString].ToString(), out bool sob))
  128  						{
  129: 							result.StartOdometer = sob;
  130  						}

  132  						{
  133: 							Logger.Log($"Could not parse StartOdometer from action settings for event {EventId}", LogLevel.Error);
  134  							return null;

  136  
  137: 						if (bool.TryParse(Actions[i].Settings[EndOdometerString].ToString(), out bool eob))
  138  						{
  139: 							result.EndOdometer = eob;
  140  						}

  142  						{
  143: 							Logger.Log($"Could not parse EndOdometer from action settings for event {EventId}", LogLevel.Error);
  144  							return null;

  197  		private const string RecordingTypeString = "RecordingType";
  198: 		private const string StartOdometerString = "StartOdometer";
  199: 		private const string EndOdometerString = "EndOdometer";
  200  		private const string StartPositionString = "StartPosition";

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataAccess\Entities\LegacyEventDetails.cs:
  11  		public bool? RecordVideo { get; set; }
  12: 		public bool? RequiresOdometer { get; set; }
  13  	}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataAccess\Repository\DeviceConfigRepository.cs:
  510  							result.RecordVideo = helpers[result.EventId].RecordVideo;
  511: 							result.RequiresOdometer = helpers[result.EventId].StartOdometer;
  512  						}

  582  					{
  583: 						return new RecordingActionHelper("<settings recordType=\"1\" startOdometer=\"1\" endOdometer=\"1\" startPosition=\"1\" endPosition=\"1\" video=\"0\" pulse=\"0\"/>");
  584  					}

  586  					{
  587: 						return new RecordingActionHelper("<settings recordType=\"3\" startOdometer=\"1\" endOdometer=\"0\" startPosition=\"0\" endPosition=\"0\" video=\"0\" pulse=\"0\"/>");
  588  					}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\DataAccess\Constants.cs:
  59  
  60: 			public const string GetVehicleLatestState = @"  SELECT  fLastOdo AS LastOdo, 
  61  																														liLastEngineSeconds AS LastEngineSeconds, 

  70  																													dtLastTrip          = @LastTrip,
  71: 																													fLastOdo            = @LastOdo,
  72  																													liLastEngineSeconds = @LastEngineSeconds,

  75  
  76: 			public const string LoadAssetLastDetails = @"SELECT  fLastOdo AS LastOdo, 
  77  																													liLastEngineSeconds AS LastEngineSeconds, 

  87  			public const string InsertPassengerData = @"INSERT INTO tbPassengerData
  88: 						( VehicleID,  BlockSequence,  PassengerID,  IdentifiedDate,  Odometer)
  89  						VALUES
  90: 						(@VehicleID, @BlockSequence, @PassengerID, @IdentifiedDate, @Odometer)";
  91  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Entities\PersistorLastMobileUnitUpdate.cs:
  6  	{
  7: 		public decimal? LastOdo { get; set; }
  8  		public long? LastEngineSeconds { get; set; }

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\ActiveEventPersistor.cs:
  100  
  101: 					evnt.Position.Odometer = evnt.Position.Odometer / Calibration.ODOMETER_SCALAR;
  102  				}
  103  
  104: 				// Odometer Scaling Calibration
  105: 				evnt.Odometer = evnt.Odometer / Calibration.ODOMETER_SCALAR;
  106  			}

  184  						cmd.Parameters.AddWithValue("Value", evnt.Value);
  185: 						cmd.Parameters.AddWithValue("Odometer", evnt.Odometer);
  186  						cmd.Parameters.AddWithValue("Speed", evnt.Speed);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\Calibration.cs:
  6  
  7: 		public const int ODOMETER_SCALAR = 1000;
  8  	}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\FuelDataPersistor.cs:
  51  							cmd.Parameters.AddWithValue("FillDate", evnt.DeviceDateTime);
  52: 							cmd.Parameters.AddWithValue("FillOdometer", evnt.Odometer);
  53  							cmd.Parameters.AddWithValue("Litres", evnt.Litres);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\LoggableDataPersistor.cs:
   65  
   66: 				evnt.DataPosition.Odometer = evnt.DataPosition.Odometer / Calibration.ODOMETER_SCALAR;
   67  			}

  118  						cmd.Parameters.AddWithValue("NumberValue", evnt.NumberValue);
  119: 						cmd.Parameters.AddWithValue("Odometer", evnt.Odometer / Calibration.ODOMETER_SCALAR);
  120  						cmd.Parameters.AddWithValue("StringValue", evnt.LoggableStringVal);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\PassengerIdentifiedPersistor.cs:
  35  						cmd.Parameters.AddWithValue("IdentifiedDate", identifiedDateForTimeZone);
  36: 						cmd.Parameters.AddWithValue("Odometer", passengerIdentified.Odometer);
  37  						cmd.Parameters.AddWithValue("RID", 0);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\PassiveEventPersistor.cs:
  117  
  118: 					evnt.StartPosition.Odometer = evnt.StartPosition.Odometer / Calibration.ODOMETER_SCALAR;
  119  				}

  129  
  130: 					evnt.EndPosition.Odometer = evnt.EndPosition.Odometer / Calibration.ODOMETER_SCALAR;
  131  				}
  132  
  133: 				// Odometer Scaling Calibration
  134: 				evnt.StartOdometer = evnt.StartOdometer / Calibration.ODOMETER_SCALAR;
  135  
  136: 				evnt.EndOdometer = evnt.EndOdometer / Calibration.ODOMETER_SCALAR;
  137  			}

  192  							cmd.Parameters.AddWithValue("OriginalDriverID", context.LegacyOriginalDriverId);
  193: 							cmd.Parameters.AddWithValue("StartOdometer", evnt.StartOdometer);
  194: 							cmd.Parameters.AddWithValue("EndOdometer", evnt.EndOdometer);
  195  							cmd.Parameters.AddWithValue("StartSequence", evnt.StartTime.Get32bitSequenceNumber());

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\PositionPersistor.cs:
  62  
  63: 				pos.Odometer = pos.Odometer / Calibration.ODOMETER_SCALAR;
  64  			}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\TripPersistor.cs:
   86  						{
   87: 							if(lti.EndOdometer.HasValue)
   88  							{
   89: 								lastUpdate.LastOdo = lti.EndOdometer.HasValue ? lti.EndOdometer.Value / Calibration.ODOMETER_SCALAR : (decimal?)null;
   90  							}

   92  							{
   93: 								lastUpdate.LastOdo += (lti.TripDistance.Value / Calibration.ODOMETER_SCALAR);
   94  							}

   96  							{
   97: 								HandleError($"Failed to set trip last odo", lti);
   98  							}

  115  								cmd.Parameters.AddWithValue("LastTrip", lti.TripEnd);
  116: 								cmd.Parameters.AddWithValue("LastOdo", lastUpdate.LastOdo);
  117  								cmd.Parameters.AddWithValue("LastEngineSeconds", lastUpdate.LastEngineSeconds);

  302  
  303: 							subtrip.SubTripStart.Position.Odometer = subtrip.SubTripStart.Position.Odometer / Calibration.ODOMETER_SCALAR;
  304  						}

  316  
  317: 							subtrip.SubTripEnd.Position.Odometer = subtrip.SubTripEnd.Position.Odometer / Calibration.ODOMETER_SCALAR;
  318  						}

  427  							lastUpdate.LastEngineSeconds = trip.LastTripInfo.EndEngineSeconds;
  428: 							lastUpdate.LastOdo = trip.LastTripInfo.EndOdometer;
  429  							lastUpdate.LastTrip = trip.LastTripInfo.TripEnd;

  433  
  434: 						if(trip.EndOdometer != 0)
  435  						{
  436: 							lastUpdate.LastTripDistance = trip.SubTrips[trip.SubTrips.Count - 1].Distance.HasValue ? trip.SubTrips[trip.SubTrips.Count - 1].Distance.Value / Calibration.ODOMETER_SCALAR : 0;
  437  
  438: 							lastUpdate.LastOdo = trip.EndOdometer / Calibration.ODOMETER_SCALAR;
  439  						}

  441  						{
  442: 							lastUpdate.LastTripDistance = trip.TotalTripDistance.Value / Calibration.ODOMETER_SCALAR;
  443  
  444: 							lastUpdate.LastOdo += (trip.TotalTripDistance.Value / Calibration.ODOMETER_SCALAR);
  445  

  447  							{
  448: 								trip.SubTrips[trip.SubTrips.Count - 1].SubTripEnd.Odometer = lastUpdate.LastOdo * Calibration.ODOMETER_SCALAR; // sub trip persistor scales this down again
  449  							}

  555  						cmd.Parameters.AddWithValue("TripDistance", subTrip.Distance.HasValue ? subTrip.Distance.Value / 1000 : subTrip.Distance.Value == 0 ? 0 : 0);
  556: 						cmd.Parameters.AddWithValue("Odometer", subTrip.Odometer.HasValue ? subTrip.Odometer.Value / 1000 : 0);
  557  						cmd.Parameters.AddWithValue("MaxSpeed", subTrip.MaxSpeed);

  624  						cmd.Parameters.AddWithValue("LastTrip", tripEnd);
  625: 						cmd.Parameters.AddWithValue("LastOdo", lastUpdate.LastOdo);
  626  						cmd.Parameters.AddWithValue("LastEngineSeconds", lastUpdate.LastEngineSeconds);

  645  						cmd.Parameters.AddWithValue("LastTrip", tripEnd);
  646: 						cmd.Parameters.AddWithValue("LastOdo", lastUpdate.LastOdo);
  647  						cmd.Parameters.AddWithValue("LastEngineSeconds", lastUpdate.LastEngineSeconds);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataPersistor\Modules\Tacho\MesaToFmTachoProcessor.cs:
    20  		F3_VALID = 0x0080,
    21: 		ODO_VALID = 0x0040,
    22  		D1_VALID = 0x0020,

   133  					fmTachoRec.SetRPM(rec.RPM);
   134: 					fmTachoRec.SetOdo(rec.OdometerMeters);
   135  					fmTachoRec.SetF3_Hz(rec.F3Hz);

   199  		{
   200: 			// TODO: Actually copy all blocks, not just the last one!
   201  			Array.Copy(fmTachoBlock.aucTachoBlock, 0, aucFmTachoBlock, 0, FmTachoBlockClass.FM_TACHO_BLOCK_SIZE);

   484  			{
   485: 				// Time, Speed, RPM, F3, OdoP, D1, D2, D3, D4
   486  				TIME = 0,

   489  				F3 = 3,
   490: 				ODO = 4,
   491  				D1 = 5,

   504  			internal byte u8_F3;
   505: 			internal UInt32 u32_Odo_km;       // Warning - Using bottom 3 bytes only
   506  			internal byte u8_D1_mV;

   619  				{
   620: 					// TODO: verify multipliers
   621  					int nTemp = (int)nVal;

   651  			{
   652: 				// TODO: confirm scaling
   653  				int nIdx = (u16_Status & (UInt16)FM_TACHO_PARAM_STATUS.F3_EXTRA) >> 10;

   657  
   658: 			public void SetOdo(int? nVal)
   659  			{

   661  				{
   662: 					u32_Odo_km = (UInt32)nVal & 0x00FFFFFF; // only bottom 3 bytes used
   663: 					u16_Status |= (UInt16)FM_TACHO_PARAM_STATUS.ODO_VALID;
   664  				}
   665  			}
   666: 			public bool IsOdoValid()
   667  			{
   668: 				return ((u16_Status & (UInt16)FM_TACHO_PARAM_STATUS.ODO_VALID) != 0);
   669  			}
   670: 			public int GetOdo_km()
   671  			{
   672: 				return ((int)u32_Odo_km);
   673  			}

   840  						break;
   841: 					case BITSTREAM_PARAM.ODO:
   842: 						bValid = IsOdoValid();
   843  						break;

   888  						break;
   889: 					case BITSTREAM_PARAM.ODO:
   890: 						nVal = (int)u32_Odo_km;
   891  						break;

   916  
   917: 				Utils.PackBytes(BitConverter.GetBytes(u32_Odo_km & 0x00FFFFFF), 0, aucData, ref nOffset, 3); // only bottom three bytes used!
   918  

  1054  				u8_F3 = 0;
  1055: 				u32_Odo_km = 0;
  1056  				u8_D1_mV = 0;

  1069  				u8_F3 = _fmTachoRec.u8_F3;
  1070: 				u32_Odo_km = _fmTachoRec.u32_Odo_km;
  1071  				u8_D1_mV = _fmTachoRec.u8_D1_mV;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\Process\CompleteTrip.cs:
   57  
   58: 			bool calculateOdometer = false;
   59  

   89  
   90: 				calculateOdometer = false;
   91  

  134  						if (_stagingRepo.InsertTrip(dto.MobileUnitId, mobileUnit.OrganisationId, currentTripNumber, tripStart.StartTime, tripEnd.StartTime,
  135: 							$"Starting trip with {numOfSubTrips} subtrip(s)", null, null, null, null, null, null, tripStart.StartOdometer, tripEnd.StartOdometer,
  136  							_unknownDriverid, _unknownDriverid, null, null) == 2)

  246  
  247: 					calculateOdometer = FindCriticalTripPart(EventIds.FM_TRIP_START, ActionSequenceNumbers.CalculateOdo, tripStart.StartSequenceNumber, tripEnd.StartSequenceNumber, subTripDTOs) != null;
  248  
  249: 					Logger.Log($"{dto.MobileUnitId}, Calculate odometer = {calculateOdometer}", LogLevel.Debug);
  250  

  354  
  355: 						if (calculateOdometer)
  356  						{

  521  							maxRevs.Value.Value, maxRevs.TotalTimeTrue.Value, maxRevs.NumberOfOccurances.Value, 100, 0, 100, 0, 0, 100, 0, 0, null,
  522: 							subTripStartPulseCount != null ? (float?)subTripStartPulseCount.Value : null, currentSubTripStart.StartOdometer, currentSubTripEnd.StartOdometer,
  523  							subTripStartEngineSecondsValue, startOriginal: currentSubTripStart.StartTime, endOriginal: currentSubTripEnd.StartTime));

  658  							_stagingRepo.UpdateTripCompletion(dto.MobileUnitId, currentTripNumber, tripEnd.DriverId, tripStart.DriverId, "Completed", tripEndTime,
  659: 							startPulse, endPulse, pulseParameterId, pulseIsFuel, startEngineSeconds, endEngineSeconds, tripStart.StartOdometer, tripEnd.StartOdometer);
  660  						}

  670  							pulseParameterId,
  671: 							calculateOdometer,
  672  							(float?)startPulse,
  673  							(float?)endPulse,
  674: 							tripStart.StartOdometer, tripEnd.StartOdometer, // SR-3918 odo jump
  675  							true, // SR-11708 always reset sub trip distances

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\Process\TripProcessor.cs:
  103  				new EngineHours(),
  104: 				new FinaliseOdoStates(this),
  105  				new ElectricVehicle(),

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\TripPostProcessing\000075 CompletePassiveEvents.cs:
  100  				// clearing in-memory offset in case they were previously cleared on another instance, to force read from state DB
  101: 				DependencyRegistry.GetInstance<IOdometerState>(true).ClearOdoOffsetCacheOnly(trip.MobileUnitId); 
  102  				DependencyRegistry.GetInstance<IEngineHoursState>(true).ClearEngineSecondsCache(trip.MobileUnitId);

  264  
  265: 									if (!helper.StartOdometer) matching[0].Odometer = null;
  266  
  267: 									if (!helper.EndOdometer) matching[1].Odometer = null;
  268  

  290  
  291: 								//decimal? odometer = helper == null ? null : helper.StartOdometer ? currentEvent.Odometer ?? (decimal?)null : null;
  292  

  303  											results.Add(PassiveEventFactory.CreateNotificationEventDTO(currentEvent.StagedEventId.ToString(), currentEvent.MobileUnitId, currentEvent.EventId, 
  304: 												currentEvent.EventSequenceNumber, currentEvent.Timestamp, currentEvent.Value, currentEvent.ActionSequenceNumber, recordVideo, currentEvent.Odometer));
  305  										}

  315  												results.Add(PassiveEventFactory.CreateNotificationEventDTO(currentEvent.StagedEventId.ToString(), currentEvent.MobileUnitId, currentEvent.EventId, 
  316: 													currentEvent.EventSequenceNumber, currentEvent.Timestamp, null, currentEvent.ActionSequenceNumber, recordVideo, currentEvent.Odometer));
  317  											}

  323  												results.Add(PassiveEventFactory.CreateNotificationEventDTO(currentEvent.StagedEventId.ToString(), currentEvent.MobileUnitId, currentEvent.EventId, 
  324: 												currentEvent.EventSequenceNumber, currentEvent.Timestamp, currentEvent.Value, currentEvent.ActionSequenceNumber, recordVideo, currentEvent.Odometer, 
  325  												rawValue: (uint?)currentEvent.RawValue));

  336  										results.Add(PassiveEventFactory.CreateNotificationEventDTO(currentEvent.StagedEventId.ToString(), currentEvent.MobileUnitId, currentEvent.EventId, 
  337: 												currentEvent.EventSequenceNumber, currentEvent.Timestamp, currentEvent.Value, currentEvent.ActionSequenceNumber, recordVideo, currentEvent.Odometer,
  338  												rawValue: (uint?)currentEvent.RawValue));

  402  						.FirstOrDefault(e => e.ActionSequenceNumber == ActionSequenceNumbers.ROVI_Fuel_Cost
  403: 														&& e.Odometer == fuelAmountEvent.Odometer);
  404  
  405: 					if(costEvent == null) // could not match on odo
  406  					{

  615  							startEvent.EventSequenceNumber, endEvent.EventSequenceNumber, startEvent.Timestamp, endEvent.Timestamp,
  616: 							startEvent.Odometer, endEvent.Odometer, pulseCount, null, endEvent.ActionSequenceNumber, recordVideo, rawValue: null));
  617  					}

  621  							startEvent.EventSequenceNumber, endEvent.EventSequenceNumber, startEvent.Timestamp, endEvent.Timestamp,
  622: 							startEvent.Odometer, endEvent.Odometer, pulseCount, endEvent.Value, endEvent.ActionSequenceNumber, recordVideo, rawValue: (uint?)endEvent.RawValue));
  623  					}

  651  				DeviceDateTime = fuelCostEvent.Timestamp,				
  652: 				Odometer = (float)(fuelCostEvent.Odometer / 1000) 
  653  			};

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\TripPostProcessing\000250 GatherTripPositions.cs:
   19  		private readonly PositionComparer _positionComparer;
   20: 		private readonly IOdometerState _odometerState;
   21  

   34  
   35: 			_odometerState = DependencyRegistry.GetInstance<IOdometerState>(true);
   36  		}

  215  
  216: 			// set sub trip start- and end odometer
  217: 			if (!dto.CalculateOdometer)
  218  			{

  220  				{
  221: 					if (!dto.SubTrips[i].SubTripStart.Odometer.HasValue && dto.SubTrips[i].SubTripStart.Position != null)
  222  					{
  223: 						dto.SubTrips[i].SubTripStart.Odometer = dto.SubTrips[i].SubTripStart.Position.Odometer;
  224  					}

  226  					{
  227: 						dto.SubTrips[i].SubTripStart.Odometer += _odometerState.GetOdometerOffset(dto.MobileUnitId);
  228: 						Logger.Log($"{dto.MobileUnitId}, {Name}, Applied offset of {_odometerState.GetOdometerOffset(dto.MobileUnitId)} to sub trip start", LogLevel.Debug);
  229  					}
  230  
  231: 					if (!dto.SubTrips[i].SubTripEnd.Odometer.HasValue && dto.SubTrips[i].SubTripEnd.Position != null)
  232  					{
  233: 						dto.SubTrips[i].SubTripEnd.Odometer = dto.SubTrips[i].SubTripEnd.Position.Odometer;
  234  					}

  236  					{
  237: 						dto.SubTrips[i].SubTripEnd.Odometer += _odometerState.GetOdometerOffset(dto.MobileUnitId);
  238: 						Logger.Log($"{dto.MobileUnitId}, {Name}, Applied offset of {_odometerState.GetOdometerOffset(dto.MobileUnitId)} to sub trip end", LogLevel.Debug);
  239  					}

  241  
  242: 				// If we could not find a position for the last sub trip end then we dont have an end odo
  243: 				// for this trip. Instead of showing nothing, we'll get the highest in trip odo we can find.
  244: 				// Showing an incorrect but still ball-park odo is better than not having a value.
  245: 				if (!dto.SubTrips[dto.SubTrips.Count - 1].SubTripEnd.Odometer.HasValue)
  246  				{
  247: 					dto.SubTrips[dto.SubTrips.Count - 1].SubTripEnd.Odometer = dto.Positions.Max(p => p.Odometer);
  248  				}
  249  
  250: 				//make sure we use the higher odo value attached on the subtrip - SR-10565
  251  				for (int i = 0; i < dto.SubTrips.Count; i++)
  252  				{
  253: 					if (dto.SubTrips[i].SubTripStart.Position != null && dto.SubTrips[i].SubTripStart.Odometer.HasValue && dto.SubTrips[i].SubTripStart.Position.Odometer.HasValue)
  254: 						if (dto.SubTrips[i].SubTripStart.Odometer < dto.SubTrips[i].SubTripStart.Position.Odometer)
  255: 							dto.SubTrips[i].SubTripStart.Odometer = dto.SubTrips[i].SubTripStart.Position.Odometer;
  256  				}

  260  				{
  261: 					dto.SubTrips[0].Distance = dto.SubTrips[0].SubTripEnd.Odometer - dto.SubTrips[0].SubTripStart.Odometer;
  262  					

  270  			StringBuilder sb = new StringBuilder();
  271: 			sb.AppendLine($"{dto.MobileUnitId} TN {dto.TripNumber}, Start {dto.StartOdometer}, End {dto.EndOdometer}");
  272  			foreach (var item in dto.SubTrips)
  273  			{
  274: 				sb.AppendLine($"ST {item.Sequence}, Start {item.SubTripStart.Odometer}, End {item.SubTripEnd.Odometer}");
  275  			}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\TripPostProcessing\000500 FinaliseOdoStates.cs:
   19  {
   20: 	public class FinaliseOdoStates : IProcessing<Trip>
   21  	{

   23  
   24: 		private readonly IOdometerState _odometerState;
   25  		private readonly IDeviceConfigRepository _dataProcessingRepo;

   27  
   28: 		public FinaliseOdoStates(IQueueWriter queueWriter)
   29  		{

   33  
   34: 			_odometerState = DependencyRegistry.GetInstance<IOdometerState>(true);
   35  		}

   40  			{
   41: 				decimal? lastDisplayOdo = 0;
   42: 				decimal startOdo = 0;
   43  
   44: 				if (trip.CalculateOdometer)
   45  				{
   46: 					Logger.Log($"{trip.MobileUnitId}, Finalising Odo States", LogLevel.Debug);
   47  

   49  					{
   50: 						lastDisplayOdo = _odometerState.GetAssetLastDisplayOdometer(trip.MobileUnitId);
   51  					}

   56  
   57: 					if (!lastDisplayOdo.HasValue)
   58  					{
   59: 						Logger.Log($"{trip.MobileUnitId}, Could not find last odo for {trip.MobileUnitId} trip# {trip.TripNumber}. Trying to get last trip end raw odo.", LogLevel.Production);
   60  
   61: 						decimal? lastTripEndRawOdometer = null;
   62  						try
   63  						{
   64: 							lastTripEndRawOdometer = _odometerState.GetAssetLastTripEndOdometer(trip.MobileUnitId);
   65  						}

   71  						// CONFIG-2128
   72: 						if (lastTripEndRawOdometer.HasValue)
   73  						{
   74: 							Logger.Log($"{trip.MobileUnitId}, Found Last Trip End Odo of {lastTripEndRawOdometer}", LogLevel.Debug);
   75  
   76: 							decimal? odoOffset = _odometerState.GetOdometerOffset(trip.MobileUnitId);
   77  
   78: 							if (odoOffset.HasValue)
   79  							{
   80: 								Logger.Log($"{trip.MobileUnitId}, Found odo offset of {odoOffset}", LogLevel.Debug);
   81  							}

   83  							{
   84: 								odoOffset = 0;
   85  							}
   86  
   87: 							lastDisplayOdo = lastTripEndRawOdometer + odoOffset;
   88  
   89: 							Logger.Log($"{trip.MobileUnitId}, Thus last display odo is {lastDisplayOdo}", LogLevel.Debug);
   90  						}

   92  						{
   93: 							_odometerState.SetAssetLastDisplayOdometer(trip.MobileUnitId, 0);
   94: 							_odometerState.SetRawOdometerFromTripEnd(trip.MobileUnitId, 0);
   95: 							lastDisplayOdo = 0;
   96  						}

   98  
   99: 					Logger.Log($"{trip.MobileUnitId}, Parsed asset last odo for trip# {trip.TripNumber} as odo = {lastDisplayOdo}", LogLevel.Debug);
  100  
  101: 					startOdo = lastDisplayOdo.Value;
  102  

  106  
  107: 						lastDisplayOdo += subtrip.Distance ?? 0;
  108  
  109: 						subtrip.SubTripStart.Odometer = startOdo;
  110  

  112  						{
  113: 							subtrip.SubTripStart.Position.Odometer = startOdo;
  114  						}
  115  
  116: 						subtrip.SubTripEnd.Odometer = lastDisplayOdo;
  117  

  119  						{
  120: 							subtrip.SubTripEnd.Position.Odometer = lastDisplayOdo;
  121  						}
  122  
  123: 						Logger.Log($"{trip.MobileUnitId}, Calculated Start odo {subtrip.SubTripStart.Odometer} and End Odo {subtrip.SubTripEnd.Odometer}", LogLevel.Debug);
  124  
  125: 						startOdo = lastDisplayOdo.Value;
  126  					}

  139  							outgoing.Process(ActiveEventFactory.GetActiveEvent(trip.OrgId, trip.MobileUnitId,
  140: 								trip.DriverId, EventIds.SUB_TRIP_START, DateTime.UtcNow, trip.TripStartTime, 0, startOdo,
  141: 								null, false, trip.SubTrips[0].SubTripStart.Position, null, null, false, adjustOdo: false));
  142  							
  143  							outgoing.Process(ActiveEventFactory.GetActiveEvent(trip.OrgId, trip.MobileUnitId,
  144: 									trip.DriverId, EventIds.SUB_TRIP_END, DateTime.UtcNow, trip.TripEndTime, 0, lastDisplayOdo,
  145: 									null, false, trip.SubTrips[0].SubTripEnd.Position, null, null, false, adjustOdo: false));
  146  

  159  				{
  160: 					Logger.Log($"{trip.MobileUnitId}, Not calculating trip Odo", LogLevel.Debug);
  161  				}
  162  
  163: 				decimal? lastDisplay = trip.SubTrips[trip.SubTrips.Count - 1].SubTripEnd.Odometer;
  164  

  166  				{
  167: 					_odometerState.SetAssetLastDisplayOdometer(trip.MobileUnitId, lastDisplay.Value);
  168  				}

  170  				StringBuilder sb = new StringBuilder();
  171: 				sb.AppendLine($"{trip.MobileUnitId} TN {trip.TripNumber}, Start {trip.StartOdometer}, End {trip.EndOdometer}");
  172  				foreach (var item in trip.SubTrips)
  173  				{
  174: 					sb.AppendLine($"ST {item.Sequence}, Start {item.SubTripStart.Odometer}, End {item.SubTripEnd.Odometer}");
  175  				}

  178  
  179: 				Logger.Log($"{trip.MobileUnitId}, Set Properties.ASSET_LAST_DISPLAY_ODOMETER to {lastDisplay}", LogLevel.Debug);
  180  			}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\TripPostProcessing\000525 VideoEvents.cs:
  43  				//STM-790
  44: 				//TODO: Remove commented code once all parts are done
  45  				Logger.Log($"Checking if Streamax is commissioned on MobileUnitId={dto.MobileUnitId}...", LogLevel.Debug);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\TripPostProcessing\000600 EventPositions.cs:
  38  		/// Used to handle QA-3674 here but its now handled in the ClearDeviceCacheValues module
  39: 		/// QA-3674 SetOdo timing issue so a stale offset is applied before/on trip start
  40  		/// </summary>

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\TripPostProcessing\000975 LastTripInfo.cs:
   63  					"Completed", dto.StartPulseValue, dto.EndPulseValue, dto.PulseParameterId, dto.PulseIsFuel,
   64: 					dto.TripStartEngineSeconds, dto.TripEndEngineSeconds, dto.StartOdometer, dto.EndOdometer, dto.DriverId, dto.OriginalDriverId,
   65  					fuelUsed, tripDistance);

  101  					EndEngineSeconds = (int?)dto.TripEndEngineSeconds,
  102: 					EndOdometer = dto.EndOdometer,
  103  					TripEnd = dto.TripEndTime,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor\TripPostProcessing\001000 ClearDeviceCacheValues.cs:
  15  
  16: 		private readonly IOdometerState _odometerState;
  17  		private readonly IEngineHoursState _engineHoursState;

  27  		/// correct data.
  28: 		/// QA-3674 SetOdo timing issue so a stale offset is applied before/on trip start
  29  		/// </summary>

  31  		{
  32: 			_odometerState = DependencyRegistry.GetInstance<IOdometerState>(true);
  33  			_engineHoursState = DependencyRegistry.GetInstance<IEngineHoursState>(true);

  41  			{
  42: 				_odometerState.ClearOdoOffsetCacheOnly(dto.MobileUnitId);
  43  				
  44: 				if (_odometerState.WasOdometerSetViaCommand(dto.MobileUnitId))
  45: 					_odometerState.ClearOdometerOffsets(dto.MobileUnitId);
  46  				

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor.UnitTests\Incoming.Core\ThirdPartyTripProcessingTests.cs:
   21  		Mock<IStagingRepository> _stagingRepoMock;
   22: 		Mock<IOdometerState> _odometerStateMock;
   23  

   30  			_stagingRepoMock = new Mock<IStagingRepository>(MockBehavior.Loose);
   31: 			_odometerStateMock = new Mock<IOdometerState>(MockBehavior.Loose);
   32  		}
   33  
   34: 		public void ProcessTripStart_With_OdometerSupplied()
   35  		{

   39  		[Test, Category("CICDTests")]
   40: 		public void ProcessTripStart_With_NoOdometerSupplied()
   41  		{

   44  			_stagingRepoMock.Setup(x => x.GetCompletedTripInfo(It.IsAny<long>(), 5, false))
   45: 				.Returns(() => TestHelper.GetTripTestData_WithBrokenOdometers());
   46  

   66  
   67: 			_odometerStateMock.Verify();
   68  

   72  		[Test, Category("CICDTests")]
   73: 		public void ProcessTripEnd_With_OdometerSupplied()
   74  		{

   76  			
   77: 			DependencyRegistry.Register<IOdometerState>(() => _odometerStateMock.Object);
   78  
   79: 			long tripEndOdometer = 60000;
   80  
   81  			_stagingRepoMock.Setup(x => x.GetCompletedTripInfo(It.IsAny<long>()))
   82: 				.Returns(() => TestHelper.GetTripTestData_WithBrokenOdometers());
   83  

   86  
   87: 			_odometerStateMock.Setup(x => x.SetRawOdometerFromTripEnd(It.IsAny<long>(), It.IsAny<decimal>()));
   88  

   92  			Trip result = TripProcessing.ProcessTripEnd(TestHelper._assetId, TestHelper._orgId, 
   93: 				new DateTime(2023, 4, 15, 17, 23, 29, DateTimeKind.Utc), null, tripEndOdometer, TestHelper._driverId, null, out _, out _);
   94  

  100  
  101: 			Assert.That(result.SubTrips[0].SubTripStart.Odometer == 36178.5365M);
  102  

  104  
  105: 			Assert.That(result.SubTrips[0].SubTripEnd.Odometer == tripEndOdometer);
  106  
  107: 			_odometerStateMock.Verify();
  108  

  112  		[Test, Category("CICDTests")]
  113: 		public void ProcessTripEnd_With_NoOdometerSupplied_BrokenStartOdometer()
  114  		{

  116  			
  117: 			DependencyRegistry.Register<IOdometerState>(() => _odometerStateMock.Object);
  118  
  119  			_stagingRepoMock.Setup(x => x.GetCompletedTripInfo(It.IsAny<long>()))
  120: 				.Returns(() => TestHelper.GetTripTestData_WithBrokenOdometers());
  121  

  124  
  125: 			_odometerStateMock.Setup(x => x.SetRawOdometerFromTripEnd(It.IsAny<long>(), It.IsAny<decimal>()));
  126  

  138  
  139: 			Assert.That(result.SubTrips[0].SubTripStart.Odometer == 0);
  140  

  142  
  143: 			Assert.That(result.SubTrips[0].SubTripEnd.Odometer == 23821.4635M);
  144  
  145: 			_odometerStateMock.Verify();
  146  

  150  		[Test, Category("CICDTests")]
  151: 		public void ProcessTripEnd_With_NoOdometerSupplied_WorkingStartOdometer()
  152  		{

  154  			
  155: 			DependencyRegistry.Register<IOdometerState>(() => _odometerStateMock.Object);
  156  			
  157: 			decimal startOdometer = 50000;
  158  
  159: 			var stagedTrips = TestHelper.GetTripTestData_WithBrokenOdometers();
  160  			
  161: 			stagedTrips[stagedTrips.Count - 3].StartOdometer = startOdometer;
  162  

  168  
  169: 			_odometerStateMock.Setup(x => x.SetRawOdometerFromTripEnd(It.IsAny<long>(), It.IsAny<decimal>()));
  170  

  182  
  183: 			Assert.That(result.SubTrips[0].SubTripStart.Odometer == startOdometer);
  184  

  186  
  187: 			Assert.That(result.SubTrips[0].SubTripEnd.Odometer == 73821.4635M);
  188  
  189: 			_odometerStateMock.Verify();
  190  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor.UnitTests\Modules\TestHelper.cs:
   19  		public static long _driverId = -509933614468629805;
   20: 		public static decimal Odometer = 100000;
   21  		public static readonly List<long> CNILSpeedEventsToDiscard = new List<long>()

   93  			position.OriginalDriverId = _driverId;
   94: 			position.Odometer = Odometer;
   95  			position.Values = null;
   96  			position.ProceedWithProcessing = true;
   97: 			position.CalculateOdometer = false;
   98  			return position;

  127  			position.OriginalDriverId = _driverId;
  128: 			position.Odometer = Odometer;
  129  			position.Values = null;
  130  			position.ProceedWithProcessing = true;
  131: 			position.CalculateOdometer = false;
  132  

  161  
  162: 		public static Trip GetBasicTrip(bool proceedWithProcessing, bool calculateOdometer, bool addPositions)
  163  		{

  169  			trip.ProceedWithProcessing = proceedWithProcessing;
  170: 			trip.CalculateOdometer = calculateOdometer;
  171  

  218  					{
  219: 						eventId, new RecordingActionHelper("<settings recordType=\"3\" startOdometer=\"1\" endOdometer=\"0\" startPosition=\"0\" endPosition=\"0\" video=\"0\" pulse=\"0\"/>")
  220  					}

  228  					{
  229: 						eventId, new RecordingActionHelper("<settings recordType=\"2\" startOdometer=\"0\" endOdometer=\"0\" startPosition=\"0\" endPosition=\"0\" video=\"0\" pulse=\"0\"/>")
  230  					}

  238  					{
  239: 						eventId, new RecordingActionHelper("<settings recordType=\"1\" startOdometer=\"1\" endOdometer=\"1\" startPosition=\"0\" endPosition=\"0\" video=\"0\" pulse=\"1\"/>")
  240  					}

  253  			start.EventSequenceNumber = 123;
  254: 			start.Odometer = 50;
  255  

  268  			end.Value = 7;
  269: 			end.Odometer = 60;
  270  

  340  
  341: 		public static List<TripComplete> GetTripTestData_WithBrokenOdometers()
  342  		{

  367  					FailReason = bits[4],
  368: 					StartOdometer = decimal.TryParse(bits[5], out decimal startOdo) ? startOdo : (decimal?)null,
  369: 					EndOdometer = decimal.TryParse(bits[6], out decimal endOdo) ? endOdo : (decimal?)null,
  370  				});

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor.UnitTests\Modules\TripPostProcessing\CalculateTripDistance.cs:
   19  		Mock<IDeviceConfigRepository> _deviceConfigRepoMock;
   20: 		Mock<IOdometerState> _odometerstateMock;
   21  		Mock<IQueueWriter> _queueWriterMock;

   29  			_deviceConfigRepoMock = new Mock<IDeviceConfigRepository>(MockBehavior.Strict);
   30: 			_odometerstateMock = new Mock<IOdometerState>(MockBehavior.Strict);
   31  			_queueWriterMock = new Mock<IQueueWriter>(MockBehavior.Loose);

   34  			DependencyRegistry.Register(() => _deviceConfigRepoMock.Object);
   35: 			DependencyRegistry.Register(() => _odometerstateMock.Object);
   36  			DependencyRegistry.Register(() => _queueWriterMock.Object, Constants.DependancyNames.ProcessorDtoReaderWriter);

   65  		[Test]
   66: 		public void CalculateOdo_And_HasNoDistance()
   67  		{

   71  
   72: 			trip.CalculateOdometer = true;
   73  			trip.SubTrips[0].Distance = 0;
   74  
   75: 			_odometerstateMock.Setup(x => x.GetAssetLastDisplayOdometer(It.IsAny<long>())).Returns(0);
   76: 			_odometerstateMock.Setup(x => x.SetAssetLastDisplayOdometer(It.IsAny<long>(), It.IsAny<decimal>()));
   77  			_deviceConfigRepoMock.Setup(x => x.GetOrganisationSummary(It.IsAny<long>())).Returns(GetOrganisationSummary(false));

   84  
   85: 			_odometerstateMock.Verify();
   86  			_deviceConfigRepoMock.Verify();

   90  		[Test]
   91: 		public void CalculateOdo_And_AlreadyHasDistance()
   92  		{

   96  
   97: 			trip.CalculateOdometer = true;
   98  			trip.SubTrips[0].Distance = 500;
   99  
  100: 			_odometerstateMock.Setup(x => x.GetAssetLastDisplayOdometer(It.IsAny<long>())).Returns(0);
  101: 			_odometerstateMock.Setup(x => x.SetAssetLastDisplayOdometer(It.IsAny<long>(), It.IsAny<decimal>()));
  102  			_deviceConfigRepoMock.Setup(x => x.GetOrganisationSummary(It.IsAny<long>())).Returns(GetOrganisationSummary(true));

  110  
  111: 			_odometerstateMock.Verify();
  112  			_deviceConfigRepoMock.Verify();

  116  		[Test]
  117: 		public void DontCalculateOdo_And_HasNoDistance()
  118  		{

  122  
  123: 			trip.CalculateOdometer = false;
  124  			trip.SubTrips[0].Distance = 0;

  126  
  127: 			_odometerstateMock.Setup(x => x.SetAssetLastDisplayOdometer(It.IsAny<long>(), It.IsAny<decimal>()));
  128  			_deviceConfigRepoMock.Setup(x => x.GetOrganisationSummary(It.IsAny<long>())).Returns(GetOrganisationSummary(false));

  134  
  135: 			_odometerstateMock.Verify();
  136  			_deviceConfigRepoMock.Verify();

  140  		[Test]
  141: 		public void DontCalculateOdo_And_HasDistance()
  142  		{

  145  			Trip trip = GetTypicalThirdPartyDeviceTrip();
  146: 			trip.SubTrips[0].SubTripEnd.Odometer = 60;
  147  
  148: 			trip.CalculateOdometer = false;
  149  			trip.SubTrips[0].Distance = 500;

  152  			_deviceConfigRepoMock.Setup(x => x.GetOrganisationSummary(It.IsAny<long>())).Returns(GetOrganisationSummary(false));
  153: 			_odometerstateMock.Setup(x => x.SetAssetLastDisplayOdometer(It.IsAny<long>(), It.IsAny<decimal>()));
  154  

  159  
  160: 			_odometerstateMock.Verify();
  161  			_deviceConfigRepoMock.Verify();

  165  		[Test]
  166: 		public void NoLastDisplayOdometerButLastTripEndRawOdometer()
  167  		{

  170  			Trip trip = GetTypicalThirdPartyDeviceTrip();
  171: 			trip.SubTrips[0].SubTripEnd.Odometer = 60;
  172  
  173: 			trip.CalculateOdometer = false;
  174  			trip.SubTrips[0].Distance = 500;

  177  			_deviceConfigRepoMock.Setup(x => x.GetOrganisationSummary(It.IsAny<long>())).Returns(GetOrganisationSummary(false));
  178: 			_odometerstateMock.Setup(x => x.GetAssetLastDisplayOdometer(It.IsAny<long>())).Returns<decimal?>(null);
  179: 			_odometerstateMock.Setup(x => x.GetAssetLastTripEndOdometer(It.IsAny<long>())).Returns(5000);
  180: 			_odometerstateMock.Setup(x => x.SetAssetLastDisplayOdometer(It.IsAny<long>(), It.IsAny<decimal>()));
  181  

  183  
  184: 			_odometerstateMock.Verify();
  185  			_deviceConfigRepoMock.Verify();

  189  		[Test]
  190: 		public void Both_NoLastDisplayOdometer_And_NoLastTripEndOdometer()
  191  		{

  194  			Trip trip = GetTypicalThirdPartyDeviceTrip();
  195: 			trip.SubTrips[0].SubTripEnd.Odometer = 60;
  196  
  197: 			trip.CalculateOdometer = false;
  198  			trip.SubTrips[0].Distance = 500;

  201  			_deviceConfigRepoMock.Setup(x => x.GetOrganisationSummary(It.IsAny<long>())).Returns(GetOrganisationSummary(false));
  202: 			_odometerstateMock.Setup(x => x.GetAssetLastDisplayOdometer(It.IsAny<long>())).Returns<decimal?>(null);
  203: 			_odometerstateMock.Setup(x => x.GetAssetLastTripEndOdometer(It.IsAny<long>())).Returns<decimal?>(null);
  204: 			_odometerstateMock.Setup(x => x.GetOdometerOffset(It.IsAny<long>())).Returns(777);
  205: 			_odometerstateMock.Setup(x => x.SetAssetLastDisplayOdometer(It.IsAny<long>(), It.IsAny<decimal>()));
  206  

  208  
  209: 			_odometerstateMock.Verify();
  210  			_deviceConfigRepoMock.Verify();

  214  		[Test]
  215: 		public void CalculateOdo_And_HasNoDistance_AlreadyHasMaxSpeed()
  216  		{

  220  
  221: 			trip.CalculateOdometer = true;
  222  			trip.SubTrips[0].Distance = 0;

  224  
  225: 			_odometerstateMock.Setup(x => x.GetAssetLastDisplayOdometer(It.IsAny<long>())).Returns(0);
  226: 			_odometerstateMock.Setup(x => x.SetAssetLastDisplayOdometer(It.IsAny<long>(), It.IsAny<decimal>()));
  227  			_deviceConfigRepoMock.Setup(x => x.GetOrganisationSummary(It.IsAny<long>())).Returns(GetOrganisationSummary(false));

  234  
  235: 			_odometerstateMock.Verify();
  236  			_deviceConfigRepoMock.Verify();

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor.UnitTests\Modules\TripPostProcessing\ClearDeviceCacheValuesTest.cs:
   20  	{
   21: 		Mock<IOdometerState> odometerState;
   22  		Mock<IEngineHoursState> engineHoursState;

   32  
   33: 			odometerState = new Mock<IOdometerState>(MockBehavior.Strict);
   34  			engineHoursState = new Mock<IEngineHoursState>(MockBehavior.Strict);

   37  
   38: 			DependencyRegistry.Register(() => odometerState.Object);
   39  			DependencyRegistry.Register(() => engineHoursState.Object);

   47  		[Test, Category("CICDTests")]
   48: 		[Description(@"If Odometer was set via command clear the odometer offsets")]
   49: 		public void ShouldClearOdometerOffsets()
   50  		{

   56  
   57: 			odometerState.Setup(o => o.ClearOdoOffsetCacheOnly(It.IsAny<long>()));
   58: 			odometerState.Setup(o => o.WasOdometerSetViaCommand(It.IsAny<long>())).Returns(true);
   59: 			odometerState.Setup(o => o.ClearOdometerOffsets(It.IsAny<long>()));
   60  

   71  
   72: 			odometerState.Verify(o => o.ClearOdometerOffsets(It.IsAny<long>()), "Should Clear Odometer Offsets");
   73  		}

   84  
   85: 			odometerState.Setup(o => o.ClearOdoOffsetCacheOnly(It.IsAny<long>()));
   86: 			odometerState.Setup(o => o.WasOdometerSetViaCommand(It.IsAny<long>())).Returns(true);
   87: 			odometerState.Setup(o => o.ClearOdometerOffsets(It.IsAny<long>()));
   88  

  118  
  119: 			odometerState.Setup(o => o.ClearOdoOffsetCacheOnly(It.IsAny<long>()));
  120: 			odometerState.Setup(o => o.WasOdometerSetViaCommand(It.IsAny<long>())).Returns(true);
  121: 			odometerState.Setup(o => o.ClearOdometerOffsets(It.IsAny<long>()));
  122  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor.UnitTests\Modules\TripPostProcessing\CompletePassiveEventsTest.cs:
   25  		Mock<IStagingRepository> stagingRepoMock;
   26: 		Mock<IOdometerState> odometerstateMock;
   27  		Mock<IEngineHoursState> engineHoursStateMock;

   44  			stagingRepoMock = new Mock<IStagingRepository>(MockBehavior.Loose);
   45: 			odometerstateMock = new Mock<IOdometerState>(MockBehavior.Strict);
   46  			engineHoursStateMock = new Mock<IEngineHoursState>(MockBehavior.Strict);

   54  			DependencyRegistry.Register(() => stagingRepoMock.Object);
   55: 			DependencyRegistry.Register(() => odometerstateMock.Object);
   56  			DependencyRegistry.Register(() => engineHoursStateMock.Object);

   62  				.Returns(new List<PassiveEventDTO>(0));
   63: 			odometerstateMock
   64: 				.Setup(x => x.ClearOdoOffsetCacheOnly(It.IsAny<long>()));
   65  			engineHoursStateMock

   84  			idleEvent.EventSequenceNumber = 123;
   85: 			idleEvent.Odometer = 50;
   86  			Assert.That(idleEvent.EventType == null, "No recording type should be set for test.");

  132  			userEvent.EventSequenceNumber = 123;
  133: 			userEvent.Odometer = 40;
  134  			Assert.That(userEvent.EventType == null, "No recording type should be set for test.");

  401  			Assert.That(result.PulseCount == 50, "PulseCount should be synced from staged events.");
  402: 			Assert.That(result.StartOdometer == 50, "StartOdometer should be synced from staged events.");
  403: 			Assert.That(result.EndOdometer == 60, "EndOdometer should be synced from staged events.");
  404  		}

  418  			fuelVolume.ActionSequenceNumber = ActionSequenceNumbers.ROVI_Fuel_Volume;
  419: 			fuelVolume.Odometer = 500;
  420  			fuelVolume.Value = 65.18M;

  425  			fuelCost.ActionSequenceNumber = ActionSequenceNumbers.ROVI_Fuel_Cost;
  426: 			fuelCost.Odometer = fuelVolume.Odometer; // they match up on odometer
  427  			fuelCost.Value = 998.35M;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DataProcessor.UnitTests\Modules\TripPostProcessing\GatherTripPositionsTests.cs:
   20  		Mock<IStagingRepository> _stagingRepoMock;
   21: 		Mock<IOdometerState> _odometerstateMock;
   22  

   27  			_stagingRepoMock = new Mock<IStagingRepository>(MockBehavior.Loose);
   28: 			_odometerstateMock = new Mock<IOdometerState>(MockBehavior.Strict);
   29  

   36  			DependencyRegistry.Register(() => _stagingRepoMock.Object);
   37: 			DependencyRegistry.Register(() => _odometerstateMock.Object);
   38  		}

   40  		[Test]//, Category("CICDTests")]
   41: 		public void Apply_Zero_Odometer_Offset()
   42  		{
   43: 			decimal odometer = 100000;
   44  

   47  			dto.TripEndTime = DateTime.Now;
   48: 			dto.SubTrips[0].SubTripStart.Odometer = odometer;
   49: 			dto.SubTrips[0].SubTripEnd.Odometer = odometer;
   50  
   51: 			_odometerstateMock.Setup(o => o.GetOdometerOffset(It.IsAny<long>())).Returns(0);
   52  

   63  			Assert.IsTrue(dto.ProceedWithProcessing);
   64: 			Assert.IsFalse(dto.CalculateOdometer);
   65: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Odometer.Value == odometer);
   66: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Odometer.Value == odometer);
   67: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Position.Odometer.Value == odometer);
   68: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Position.Odometer.Value == odometer);
   69  
   70: 			_odometerstateMock.VerifyAll();
   71  		}

   76  			decimal offset = 0;
   77: 			decimal odometer = 100000;
   78  
   79: 			decimal result = odometer + offset;
   80  

   83  			dto.TripEndTime = DateTime.Now;
   84: 			dto.SubTrips[0].SubTripStart.Odometer = odometer;
   85: 			dto.SubTrips[0].SubTripEnd.Odometer = odometer;
   86  
   87: 			_odometerstateMock.Setup(o => o.GetOdometerOffset(It.IsAny<long>())).Returns(offset);
   88  

   99  			Assert.IsTrue(dto.ProceedWithProcessing);
  100: 			Assert.IsFalse(dto.CalculateOdometer);
  101: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Odometer.Value == result);
  102: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Odometer.Value == result);
  103  			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Position == null);

  105  
  106: 			_odometerstateMock.VerifyAll();
  107  		}

  109  		[Test]//, Category("CICDTests")]
  110: 		public void Apply_Odometer_Offset_NoPositions()
  111  		{
  112  			decimal offset = 500;
  113: 			decimal odometer = 100000;
  114  
  115: 			decimal result = odometer + offset;
  116  

  119  			dto.TripEndTime = DateTime.Now;
  120: 			dto.SubTrips[0].SubTripStart.Odometer = odometer;
  121: 			dto.SubTrips[0].SubTripEnd.Odometer = odometer;
  122  
  123: 			_odometerstateMock.Setup(o => o.GetOdometerOffset(It.IsAny<long>())).Returns(offset);
  124  

  135  			Assert.IsTrue(dto.ProceedWithProcessing);
  136: 			Assert.IsFalse(dto.CalculateOdometer);
  137: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Odometer.Value == result);
  138: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Odometer.Value == result);
  139  
  140: 			_odometerstateMock.VerifyAll();
  141  		}

  143  		[Test]//, Category("CICDTests")]
  144: 		public void Apply_Odometer_Offset()
  145  		{
  146  			decimal offset = 500;
  147: 			decimal odometer = 100000;
  148  
  149: 			decimal result = odometer + offset;
  150  

  153  			dto.TripEndTime = DateTime.Now;
  154: 			dto.SubTrips[0].SubTripStart.Odometer = odometer;
  155: 			dto.SubTrips[0].SubTripEnd.Odometer = odometer;
  156  
  157: 			_odometerstateMock.Setup(o => o.GetOdometerOffset(It.IsAny<long>()))
  158  				.Returns(offset);

  170  			Assert.IsTrue(dto.ProceedWithProcessing);
  171: 			Assert.IsFalse(dto.CalculateOdometer);
  172: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Odometer.Value == result);
  173: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Odometer.Value == result);
  174: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Position.Odometer.Value == odometer);
  175: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Position.Odometer.Value == odometer);
  176  
  177: 			_odometerstateMock.VerifyAll();
  178  		}

  180  		[Test]//, Category("CICDTests")]
  181: 		public void Apply_Odometer_From_Position()
  182  		{
  183  			decimal offset = 500;
  184: 			decimal odometer = 100000;
  185  
  186: 			decimal result = odometer + offset;
  187  

  202  			Assert.IsTrue(dto.ProceedWithProcessing);
  203: 			Assert.IsFalse(dto.CalculateOdometer);
  204: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Odometer.Value == odometer);
  205: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Odometer.Value == odometer);
  206: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Position.Odometer.Value == odometer);
  207: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Position.Odometer.Value == odometer);
  208  

  213  		{
  214: 			decimal odometer = 100000;
  215  

  218  			dto.TripEndTime = DateTime.Now;
  219: 			dto.SubTrips[0].SubTripStart.Odometer = odometer;
  220: 			dto.SubTrips[0].SubTripEnd.Odometer = odometer;
  221  

  232  			Assert.IsTrue(dto.ProceedWithProcessing);
  233: 			Assert.IsTrue(dto.CalculateOdometer);
  234: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Odometer.Value == odometer);
  235: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Odometer.Value == odometer);
  236: 			Assert.IsTrue(dto.SubTrips[0].SubTripStart.Position.Odometer.Value == odometer);
  237: 			Assert.IsTrue(dto.SubTrips[0].SubTripEnd.Position.Odometer.Value == odometer);
  238  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Form1.cs:
   936  							adjustedDateTime = message.DeviceDateTime.AddSeconds((int)nudAdjustSeconds.Value);
   937: ⟪ 421 characters skipped ⟫.GpsData.GpsFixStatus, message.GpsData.NoOfSatellites, message.FirmwareVersion, null, null, message.FirmwareVersion.Build, message.PlatformInfo, message.SettingsVersion, message.SystemValues, message.Odometer, message.BatteryState, message.StatusFlags);
   938  						}

   945  
   946: 							dtTripStartMessages.Rows.Add(message.DeviceDateTime, adjustedDateTime, message.TripStartData.DateTime, message.TripStartData.OdometerInMetres, message.SystemFrequency.FrequencyInputInHertz, message.SystemFrequency.PulseCount, message.GpsData.SpeedMetresPerHour, message.GpsData.Latitude, message.GpsData.Longitude, message.GpsData.Heading, message.GpsData.DeviceDateTime, message.GpsData.Hdop, message.GpsData.GpsFixStatus, message.GpsData.NoOfSatellites);
   947  						}

   954  							adjustedDateTime = message.DeviceDateTime.AddSeconds((int)nudAdjustSeconds.Value);
   955: 							dtTripEndMessages.Rows.Add(message.DeviceDateTime, adjustedDateTime, message.TripEndData.DateTime, message.TripEndData.OdometerInMetres, message.TripEndData.DistanceInMetres, message.TripEndData.DurationInSeconds, message.DriverId.DriverId, message.DriverId.DriverIdType, message.SystemFrequency.FrequencyInputInHertz, message.SystemFrequency.PulseCount, message.MaxTripSpeed, message.EngineInfo.TripEngineHoursInSeconds, message.EngineInfo.TripIdleTimeInSeconds, message.EngineInfo.TripExcessiveIdleTimeInSeconds, message.GpsData.SpeedMetresPerHour, message.GpsData.Latitude, message.GpsData.Longitude, message.GpsData.Heading, message.GpsData.DeviceDateTime, message.GpsData.Hdop, message.GpsData.GpsFixStatus, message.GpsData.NoOfSatellites, message.TripStartGpsData.SpeedMetresPerHour, message.TripStartGpsData.Latitude, message.TripStartGpsData.Longitude, message.TripStartGpsData.Heading, message.TripStartGpsData.DeviceDateTime, message.TripStartGpsData.Hdop, message.TripStartGpsData.GpsFixStatus, message.TripStartGpsData.NoOfSatellites, message.FleetSummarySpeed.Occurrences, message.FleetSummarySpeed.TotalDurationInMilliseconds, message.FleetSummarySpeed.MaxEventPeakValue, message.FleetSummarySpeed.MaxEventTimeStamp, message.FleetSummarySpeed.MaxEventDurationInMilliseconds, message.FleetSummarySpeed.MaxEventOdometerInMeters, message.FleetSummarySpeed.MaxEventLatitude, message.FleetSummarySpeed.MaxEventLongitude, message.FleetSummaryAcceleration.Occurrences, message.FleetSummaryAcceleration.TotalDurationInMilliseconds, message.FleetSummaryAcceleration.MaxEventPeakValue, message.FleetSummaryAcceleration.MaxEventTimeStamp, message.FleetSummaryAcceleration.MaxEventDurationInMilliseconds, message.FleetSummaryAcceleration.MaxEventOdometerInMeters, message.FleetSummaryAcceleration.MaxEventLatitude, message.FleetSummaryAcceleration.MaxEventLongitude, message.FleetSummaryBraking.Occurrences, message.FleetSummaryBraking.TotalDurationInMilliseconds, message.FleetSummaryBraking.MaxEventPeakValue, message.FleetSummaryBraking.MaxEventTimeStamp, message.FleetSummaryBraking.MaxEventDurationInMilliseconds, message.FleetSummaryBraking.MaxEventOdometerInMeters, message.FleetSummaryBraking.MaxEventLatitude, message.FleetSummaryBraking.MaxEventLongitude, message.FleetSummaryCornering.Occurrences, message.FleetSummaryCornering.TotalDurationInMilliseconds, message.FleetSummaryCornering.MaxEventPeakValue, message.FleetSummaryCornering.MaxEventTimeStamp, message.FleetSummaryCornering.MaxEventDurationInMilliseconds, message.FleetSummaryCornering.MaxEventOdometerInMeters, message.FleetSummaryCornering.MaxEventLatitude, message.FleetSummaryCornering.MaxEventLongitude, message.InsuranceSummarySpeed.Occurrences, message.InsuranceSummarySpeed.TotalDurationInMilliseconds, message.InsuranceSummarySpeed.MaxEventPeakValue, message.InsuranceSummarySpeed.MaxEventTimeStamp, message.InsuranceSummarySpeed.MaxEventDurationInMilliseconds, message.InsuranceSummarySpeed.MaxEventOdometerInMeters, message.InsuranceSummarySpeed.MaxEventLatitude, message.InsuranceSummarySpeed.MaxEventLongitude, message.InsuranceSummaryAcceleration.Occurrences, message.InsuranceSummaryAcceleration.TotalDurationInMilliseconds, message.InsuranceSummaryAcceleration.MaxEventPeakValue, message.InsuranceSummaryAcceleration.MaxEventTimeStamp, message.InsuranceSummaryAcceleration.MaxEventDurationInMilliseconds, message.InsuranceSummaryAcceleration.MaxEventOdometerInMeters, message.InsuranceSummaryAcceleration.MaxEventLatitude, message.InsuranceSummaryAcceleration.MaxEventLongitude, message.InsuranceSummaryBraking.Occurrences, message.InsuranceSummaryBraking.TotalDurationInMilliseconds, message.InsuranceSummaryBraking.MaxEventPeakValue, message.InsuranceSummaryBraking.MaxEventTimeStamp, message.InsuranceSummaryBraking.MaxEventDurationInMilliseconds, message.InsuranceSummaryBraking.MaxEventOdometerInMeters, message.InsuranceSummaryBraking.MaxEventLatitude, message.InsuranceSummaryBraking.MaxEventLongitude, message.InsuranceSummaryCornering.Occurrences, message.InsuranceSummaryCornering.TotalDurationInMilliseconds, message.InsuranceSummaryCornering.MaxEventPeakValue, message.InsuranceSummaryCornering.MaxEventTimeStamp, message.InsuranceSummaryCornering.MaxEventDurationInMilliseconds, message.InsuranceSummaryCornering.MaxEventOdometerInMeters, message.InsuranceSummaryCornering.MaxEventLatitude, message.InsuranceSummaryCornering.MaxEventLongitude);
   956  						}

  1026  								message.SystemValuesParameter.AdReferenceVoltageInMillivolts,
  1027: 								message.Odometer,
  1028  								message.InternalBatteryState.VoltageInMillivolts,

  1173  								message.SettingsVersion, 
  1174: 								message.Odometer,
  1175  								message.BatteryState.VoltageInMillivolts, 

  1408  			unitType = "M4K/M6K";
  1409: 			double odoDiff = 0;
  1410: 			double lastOdo = 0;			
  1411  

  1425  				string trueTime = string.Empty;
  1426: 				string odo = string.Empty;
  1427  				string eventName = string.Empty;

  1431  				DateTime adjustedDateTime = msg.DeviceDateTime.AddSeconds((int)nudAdjustSeconds.Value);
  1432: 				odoDiff = 0;
  1433  

  1441  					trueTime = (msg.Message as FmConfigEventMessage).FmEventTrueTime.ToString();
  1442: 					odo = (msg.Message as FmConfigEventMessage).SystemOdometer.ToString();
  1443  					eventName = ConfigEventUtilities.GetConfigEventName((msg.Message as FmConfigEventMessage).FmEventHeader, new List<TestAppEventDescription>());

  1449  
  1450: 					summary = $"Type5Code {type5Code}, ActSeq# {actionSeqNumber}, Value {value}, Occurrances {occurrances}, TrueTime {trueTime}, {eventName}, Odo {odo} ";
  1451  

  1482  
  1483: ⟪ 421 characters skipped ⟫.GpsData.GpsFixStatus, message.GpsData.NoOfSatellites, message.FirmwareVersion, null, null, message.FirmwareVersion.Build, message.PlatformInfo, message.SettingsVersion, message.SystemValues, message.Odometer, message.BatteryState, message.StatusFlags);
  1484  						}

  1490  							adjustedDateTime = message.DeviceDateTime.AddSeconds((int)nudAdjustSeconds.Value);
  1491: 							dtTripStartMessages.Rows.Add(message.DeviceDateTime, adjustedDateTime, message.TripStartData.DateTime, message.TripStartData.OdometerInMetres, message.SystemFrequency.FrequencyInputInHertz, message.SystemFrequency.PulseCount, message.GpsData.SpeedMetresPerHour, message.GpsData.Latitude, message.GpsData.Longitude, message.GpsData.Heading, message.GpsData.DeviceDateTime, message.GpsData.Hdop, message.GpsData.GpsFixStatus, message.GpsData.NoOfSatellites);
  1492  						}

  1498  							adjustedDateTime = message.DeviceDateTime.AddSeconds((int)nudAdjustSeconds.Value);
  1499: 							dtTripEndMessages.Rows.Add(message.DeviceDateTime, adjustedDateTime, message.TripEndData.DateTime, message.TripEndData.OdometerInMetres, message.TripEndData.DistanceInMetres, message.TripEndData.DurationInSeconds, message.DriverId.DriverId, message.DriverId.DriverIdType, message.SystemFrequency.FrequencyInputInHertz, message.SystemFrequency.PulseCount, message.MaxTripSpeed, message.EngineInfo.TripEngineHoursInSeconds, message.EngineInfo.TripIdleTimeInSeconds, message.EngineInfo.TripExcessiveIdleTimeInSeconds, message.GpsData.SpeedMetresPerHour, message.GpsData.Latitude, message.GpsData.Longitude, message.GpsData.Heading, message.GpsData.DeviceDateTime, message.GpsData.Hdop, message.GpsData.GpsFixStatus, message.GpsData.NoOfSatellites, message.TripStartGpsData.SpeedMetresPerHour, message.TripStartGpsData.Latitude, message.TripStartGpsData.Longitude, message.TripStartGpsData.Heading, message.TripStartGpsData.DeviceDateTime, message.TripStartGpsData.Hdop, message.TripStartGpsData.GpsFixStatus, message.TripStartGpsData.NoOfSatellites, message.FleetSummarySpeed.Occurrences, message.FleetSummarySpeed.TotalDurationInMilliseconds, message.FleetSummarySpeed.MaxEventPeakValue, message.FleetSummarySpeed.MaxEventTimeStamp, message.FleetSummarySpeed.MaxEventDurationInMilliseconds, message.FleetSummarySpeed.MaxEventOdometerInMeters, message.FleetSummarySpeed.MaxEventLatitude, message.FleetSummarySpeed.MaxEventLongitude, message.FleetSummaryAcceleration.Occurrences, message.FleetSummaryAcceleration.TotalDurationInMilliseconds, message.FleetSummaryAcceleration.MaxEventPeakValue, message.FleetSummaryAcceleration.MaxEventTimeStamp, message.FleetSummaryAcceleration.MaxEventDurationInMilliseconds, message.FleetSummaryAcceleration.MaxEventOdometerInMeters, message.FleetSummaryAcceleration.MaxEventLatitude, message.FleetSummaryAcceleration.MaxEventLongitude, message.FleetSummaryBraking.Occurrences, message.FleetSummaryBraking.TotalDurationInMilliseconds, message.FleetSummaryBraking.MaxEventPeakValue, message.FleetSummaryBraking.MaxEventTimeStamp, message.FleetSummaryBraking.MaxEventDurationInMilliseconds, message.FleetSummaryBraking.MaxEventOdometerInMeters, message.FleetSummaryBraking.MaxEventLatitude, message.FleetSummaryBraking.MaxEventLongitude, message.FleetSummaryCornering.Occurrences, message.FleetSummaryCornering.TotalDurationInMilliseconds, message.FleetSummaryCornering.MaxEventPeakValue, message.FleetSummaryCornering.MaxEventTimeStamp, message.FleetSummaryCornering.MaxEventDurationInMilliseconds, message.FleetSummaryCornering.MaxEventOdometerInMeters, message.FleetSummaryCornering.MaxEventLatitude, message.FleetSummaryCornering.MaxEventLongitude, message.InsuranceSummarySpeed.Occurrences, message.InsuranceSummarySpeed.TotalDurationInMilliseconds, message.InsuranceSummarySpeed.MaxEventPeakValue, message.InsuranceSummarySpeed.MaxEventTimeStamp, message.InsuranceSummarySpeed.MaxEventDurationInMilliseconds, message.InsuranceSummarySpeed.MaxEventOdometerInMeters, message.InsuranceSummarySpeed.MaxEventLatitude, message.InsuranceSummarySpeed.MaxEventLongitude, message.InsuranceSummaryAcceleration.Occurrences, message.InsuranceSummaryAcceleration.TotalDurationInMilliseconds, message.InsuranceSummaryAcceleration.MaxEventPeakValue, message.InsuranceSummaryAcceleration.MaxEventTimeStamp, message.InsuranceSummaryAcceleration.MaxEventDurationInMilliseconds, message.InsuranceSummaryAcceleration.MaxEventOdometerInMeters, message.InsuranceSummaryAcceleration.MaxEventLatitude, message.InsuranceSummaryAcceleration.MaxEventLongitude, message.InsuranceSummaryBraking.Occurrences, message.InsuranceSummaryBraking.TotalDurationInMilliseconds, message.InsuranceSummaryBraking.MaxEventPeakValue, message.InsuranceSummaryBraking.MaxEventTimeStamp, message.InsuranceSummaryBraking.MaxEventDurationInMilliseconds, message.InsuranceSummaryBraking.MaxEventOdometerInMeters, message.InsuranceSummaryBraking.MaxEventLatitude, message.InsuranceSummaryBraking.MaxEventLongitude, message.InsuranceSummaryCornering.Occurrences, message.InsuranceSummaryCornering.TotalDurationInMilliseconds, message.InsuranceSummaryCornering.MaxEventPeakValue, message.InsuranceSummaryCornering.MaxEventTimeStamp, message.InsuranceSummaryCornering.MaxEventDurationInMilliseconds, message.InsuranceSummaryCornering.MaxEventOdometerInMeters, message.InsuranceSummaryCornering.MaxEventLatitude, message.InsuranceSummaryCornering.MaxEventLongitude);
  1500  						}

  1547  								message.SystemValuesParameter?.AdReferenceVoltageInMillivolts, 
  1548: 								message.Odometer, 
  1549  								message.InternalBatteryState?.VoltageInMillivolts, 

  1603  
  1604: 							summary = $"Type5Code {type5Code}, ActSeq# {actionSeqNumber}, Value {value}, Occurrances {occurrances}, TrueTime {trueTime}, {eventName}, Odo {odo} ";
  1605  

  1617  
  1618: 							if (lastOdo > 0 && Convert.ToDouble(odo) != 0)
  1619  							{
  1620: 								odoDiff = (Convert.ToDouble(odo) / 1000) - lastOdo;
  1621: 								lastOdo = Convert.ToDouble(Convert.ToDouble(odo)) / 1000;
  1622  							}
  1623: 							else if (lastOdo == 0 && Convert.ToDouble(odo) > 0)
  1624  							{
  1625: 								lastOdo = Convert.ToDouble(Convert.ToDouble(odo)) / 1000;
  1626  							}

  1658  								eventHeader, message.FmEventHeader.EventActionSequenceNumber, message.FmEventHeader.FmEventActionDefinitionFlags, 
  1659: 								message.FmEventSequenceNumber, null, message.SystemOdometer, Math.Round(odoDiff, 3), message.FmEventOccurrences, message.FmEventTrueTime, 
  1660  								message.FmEventValue.EventValue, message.FmEventValue.ExtendedInputId, message.FmEventValue.InputId, 

  1674  								eventHeader, message.FmEventHeader.EventActionSequenceNumber, message.FmEventHeader.FmEventActionDefinitionFlags, 
  1675: 								message.FmEventSequenceNumber, null, message.SystemOdometer, Math.Round(odoDiff, 3), message.FmEventOccurrences, message.FmEventTrueTime, 
  1676  								message.FmEventValue.EventValue, message.FmEventValue.ExtendedInputId, message.FmEventValue.InputId,

  1696  
  1697: ⟪ 1312 characters skipped ⟫osition.NoOfSatellites, message.FmEventPosition.Hdop, message.FmEventPosition.PositionTimestamp, message.FmEventPosition.DistanceMovedSinceReading, message.FmEventPosition.GpsFixStatus, message.SystemOdometer, message.SystemSpeed, message.StatusFlags.StatusFlags, message.StatusFlags.IgnitionOn, message.StatusFlags.BeameOn, message.StatusFlags.GpsOn, message.StatusFlags.RelayOn, message.StatusFlags.InTrip, message.StatusFlags.FixedBaseStation, message.StatusFlags.GpsLocked, message.StatusFlags.GpsExternalAntenna, message.StatusFlags.PrimaryBatteryOk, message.StatusFlags.BackupBatteryOk, message.StatusFlags.DriverValid, message.StatusFlags.SmsClamped, message.StatusFlags.PairedBeaconOk, message.StatusFlags.RfTransceiverOk, message.StatusFlags.PairedBeaconOnList, message.StatusFlags.GsmRssiGood, message.StatusFlags.RecoveryBeaconSmsOn);
  1698  						}

  1810  								message.SettingsVersion,
  1811: 								message.Odometer,
  1812  								message.BatteryState.VoltageInMillivolts,

  2046  
  2047: 					dtTacho.Rows.Add(tachoRecord.Timestamp, tachoRecord.SpeedMetersPerHour, tachoRecord.RPM, tachoRecord.F3Hz, tachoRecord.OdometerMeters,
  2048  						tachoRecord.Analog1MilliVolt, tachoRecord.Analog2MilliVolt, tachoRecord.Analog3MilliVolt, tachoRecord.Analog4MilliVolt, timeJump.ToString());

  2068  
  2069: 					dtTacho.Rows.Add(tl.Time, tl.Speed, tl.RPM, tl.F3, tl.Odometer, tl.I1, tl.I2, tl.I3, tl.I4, timeJump);
  2070  

  2202  						"Depart", 
  2203: 						subTrip.StartOdometerKilometres,
  2204: 						subTrip.EndOdometerKilometres,
  2205: 						Math.Round(subTrip.EndOdometerKilometres - subTrip.StartOdometerKilometres, 4),
  2206  						"", 

  2255  							"Sub Trip Start Position", 
  2256: 							subTrip.StartPosition.OdometerKilometres,
  2257: 							subTrip.StartPosition.OdometerKilometres,
  2258  							"0",

  2732  							"Sub Trip End Position",
  2733: 							subTrip.EndPosition.OdometerKilometres,
  2734: 							subTrip.EndPosition.OdometerKilometres, 
  2735  							"0",

  2757  						"Halt",
  2758: 						subTrip.StartOdometerKilometres,
  2759: 						subTrip.EndOdometerKilometres,
  2760: 						subTrip.EndOdometerKilometres - subTrip.StartOdometerKilometres,
  2761  						"", 

  2839  
  2840: 				string StartOdometer = "";
  2841: 				if (evnt.OtherData.ContainsKey("StartOdometer"))
  2842  				{
  2843: 					StartOdometer = evnt.OtherData["StartOdometer"];
  2844  				}
  2845  
  2846: 				string EndOdometer = "";
  2847: 				if (evnt.OtherData.ContainsKey("EndOdometer"))
  2848  				{
  2849: 					EndOdometer = evnt.OtherData["EndOdometer"];
  2850  				}

  2883  
  2884: 				double.TryParse(EndOdometer, out double endOdo);
  2885: 				double.TryParse(StartOdometer, out double startOdo);
  2886: 				double odoDiff = Math.Round(endOdo - startOdo, 4);
  2887  

  2904  						source,
  2905: 						StartOdometer,
  2906: 						EndOdometer,
  2907: 						odoDiff,
  2908  						value, 

  2935  						source,
  2936: 						StartOdometer,
  2937: 						EndOdometer, 
  2938: 						odoDiff,
  2939  						value, 

  2963  					source,
  2964: 					StartOdometer,
  2965: 					EndOdometer,
  2966: 					odoDiff,
  2967  					value, 

  3001  						eventName,
  3002: 						StartOdometer,
  3003: 						EndOdometer,
  3004: 						odoDiff,
  3005  						value,

  3038  						source, 
  3039: 						position.OdometerKilometres, position.Longitude, position.Latitude, position.SpeedKilometresPerHour, position.AltitudeMetres, position.Heading, position.NumberOfSatellites, position.Hdop);
  3040  				}

  3047  						source,
  3048: 						position.OdometerKilometres, position.Longitude, position.Latitude, position.SpeedKilometresPerHour, position.AltitudeMetres, position.Heading, position.NumberOfSatellites, position.Hdop);
  3049  					string eventCode = "32050";

  3061  						"Position", 
  3062: 						position.OdometerKilometres,
  3063: 						position.OdometerKilometres,
  3064  						"0",

  3082  						source,
  3083: 						position.OdometerKilometres, position.Longitude, position.Latitude, position.SpeedKilometresPerHour, position.AltitudeMetres, position.Heading, position.NumberOfSatellites, position.Hdop);
  3084  			}

  3159  
  3160: 			double odoDiff = 0;
  3161: 			double lastOdo = 0;
  3162  

  3169  				DateTime adjustedDateTime = calampLog.DeviceTimestamp.AddSeconds((int)nudAdjustSeconds.Value);
  3170: 				odoDiff = 0;
  3171  				
  3172: 				if (lastOdo > 0 && calampLog.OdometerKilometres != 0)
  3173  				{
  3174: 					odoDiff = (calampLog.OdometerKilometres) - lastOdo;
  3175: 					lastOdo = calampLog.OdometerKilometres;
  3176  				}
  3177: 				else if (lastOdo == 0 && calampLog.OdometerKilometres > 0)
  3178  				{
  3179: 					lastOdo = calampLog.OdometerKilometres;
  3180  				}

  3195  					calampLog.InTrip,
  3196: 					calampLog.OdometerKilometres,
  3197: 					Math.Round(odoDiff, 3),
  3198  					calampLog.TripMaxSpeed,

  3231  
  3232: 			double odoDiff = 0;
  3233: 			double lastOdo = 0;
  3234  

  3241  
  3242: 				odoDiff = 0;
  3243  
  3244: 				if (lastOdo > 0 && fmIncomingLog.OdometerKilometres != 0)
  3245  				{
  3246: 					odoDiff = (fmIncomingLog.OdometerKilometres) - lastOdo;
  3247: 					lastOdo = fmIncomingLog.OdometerKilometres;
  3248  				}
  3249: 				else if (lastOdo == 0 && fmIncomingLog.OdometerKilometres > 0)
  3250  				{
  3251: 					lastOdo = fmIncomingLog.OdometerKilometres;
  3252  				}

  3266  					fmIncomingLog.InTrip,
  3267: 					fmIncomingLog.OdometerKilometres,
  3268: 					Math.Round(odoDiff, 3),
  3269  					fmIncomingLog.TripMaxSpeed,

  3481  			int lastSequence = 0;
  3482: 			double? lastEndOdometer = null;
  3483  			bool timeJump = false;
  3484  			BaseDatRecord previousPosition = null;
  3485: 			bool stuckOdo = false;
  3486  			int minSpeed = Convert.ToInt32(ConfigurationManager.AppSettings["MinimumSpeedForDistance"]);
  3487: 			double odoDiff = 0;
  3488  

  3490  			{
  3491: 				odoDiff = 0;
  3492  				if (lastSequence == 0)

  3527  						(item.HasStartDate) ? item.StartDate.ToString("yyyy/MM/dd HH:mm:ss") : "---",
  3528: 						(item.HasStartOdometer) ? item.StartOdometer.ToString() : "---");
  3529  

  3531  					startSection.SectionDate = item.StartDate;
  3532: 					startSection.Odometer = item.StartOdometer;
  3533  

  3539  						(item.HasEndDate) ? item.EndDate.ToString("yyyy/MM/dd HH:mm:ss") : "---",
  3540: 						(item.HasEndOdometer) ? item.EndOdometer.ToString() : "---", item.TotalOccurances, item.TotalTime);
  3541  

  3543  					endSection.SectionDate = item.EndDate;
  3544: 					endSection.Odometer = item.EndOdometer;
  3545  					endSection.TotalOccurances = item.TotalOccurances;

  3584  
  3585: 				if ((lastEndOdometer.HasValue && lastEndOdometer.Value > 0) && item.EndOdometer > 0)
  3586  				{
  3587: 					odoDiff = (Convert.ToDouble(item.EndOdometer) / 10) - lastEndOdometer.Value;
  3588: 					lastEndOdometer = Convert.ToDouble(item.EndOdometer) / 10;
  3589  				}
  3590: 				else if (!lastEndOdometer.HasValue && item.EndOdometer > 0)
  3591  				{
  3592: 					lastEndOdometer = Convert.ToDouble(item.EndOdometer) / 10;
  3593  				}

  3621  					TimeJump = timeJump,
  3622: 					StuckOdo = stuckOdo,
  3623  					StartSection = startSection,

  3696  					timeJump, 
  3697: 					stuckOdo,
  3698  					interpretedDatRecord.EndSection?.TotalOccurances,

  3700  					duration,
  3701: 					Convert.ToDouble(item.EndOdometer) / 10,
  3702: 					Math.Round(odoDiff, 2),
  3703  					interpretedDatRecord.Position?.Latitude,

  3732  						timeJump, 
  3733: 						stuckOdo,
  3734  						interpretedDatRecord.EndSection?.TotalOccurances,

  3736  						duration,
  3737: 						Convert.ToDouble(item.EndOdometer) / 10,
  3738: 						Math.Round(odoDiff, 2),
  3739  						interpretedDatRecord.Position?.Latitude,

  3755  				timeJump = false;
  3756: 				stuckOdo = false;
  3757  

  3798  			MarkTimeJumps();
  3799: 			CheckStuckOdo();
  3800  			GetAllTripNumbers();

  4121  			dataGridView.Columns["Delayed (seconds)"].DefaultCellStyle.BackColor = Color.LightGray;
  4122: 			dataGridView.Columns["OdoDifference"].DefaultCellStyle.BackColor = Color.LightGray;
  4123  		}

  4133  				}
  4134: 				if ((dr.DataBoundItem as DataRowView).Row.Field<double?>("OdoDifference") != null &&
  4135: 						(dr.DataBoundItem as DataRowView).Row.Field<double?>("OdoDifference") < 0)
  4136  				{
  4137: 					dr.Cells["OdoDifference"].Style.BackColor = Color.Red;
  4138: 					dr.Cells["OdoDifference"].Style.ForeColor = Color.White;
  4139  				}

  4148  				dataGridView.Columns["SequenceDiff"].DefaultCellStyle.BackColor = Color.LightGray;
  4149: 				dataGridView.Columns["OdoDifference"].DefaultCellStyle.BackColor = Color.LightGray;
  4150  				dataGridView.Columns["Delayed (seconds)"].DefaultCellStyle.BackColor = Color.LightGray;

  4167  					}
  4168: 					if ((dr.DataBoundItem as DataRowView).Row.Field<double?>("OdoDifference") != null &&
  4169: 						(dr.DataBoundItem as DataRowView).Row.Field<double?>("OdoDifference") < 0)
  4170  					{
  4171: 						dr.Cells["OdoDifference"].Style.BackColor = Color.Red;
  4172: 						dr.Cells["OdoDifference"].Style.ForeColor = Color.White;
  4173  					}

  4690  
  4691: 		private void CheckStuckOdo()
  4692  		{
  4693: 			lblStuckOdo.Visible = false;
  4694: 			btnNextStuckOdo.Visible = false;
  4695: 			btnPrevStuckOdo.Visible = false;
  4696  

  4706  					{
  4707: 						if (Convert.ToBoolean(dr.Cells["StuckOdo"].Value))
  4708  						{

  4710  							dr.DefaultCellStyle.ForeColor = Color.Black;
  4711: 							lblStuckOdo.Visible = true;
  4712: 							btnNextStuckOdo.Visible = true;
  4713: 							btnPrevStuckOdo.Visible = true;
  4714  						}

  7300  			MarkTimeJumps();
  7301: 			CheckStuckOdo();
  7302  			GetAllTripNumbers();

  7456  
  7457: 		private void btnNextStuckOdo_Click(object sender, EventArgs e)
  7458  		{

  7466  				{
  7467: 					if (dgv.Rows[i].Cells["StuckOdo"].Value.ToString() == "True")
  7468  					{

  7476  
  7477: 		private void btnPrevStuckOdo_Click(object sender, EventArgs e)
  7478  		{

  7485  				{
  7486: 					if (dgv.Rows[i].Cells["StuckOdo"].Value.ToString() == "True")
  7487  					{

  8115  							string trueTime = string.Empty;
  8116: 							string odo = string.Empty;
  8117  							string eventName = string.Empty;

  8136  									sb.AppendLine($"DriverId: {message.DriverId?.DriverId}");
  8137: 									sb.AppendLine($"Odometer: {message.Odometer}");
  8138  									sb.AppendLine($"CommsPowerMicroVersion: {message.CommsPowerMicroVersion}");

  8161  										sb.AppendLine($"DateTime: {message.TripStartData.DateTime}");
  8162: 										sb.AppendLine($"OdometerInMetres: {message.TripStartData.OdometerInMetres}");
  8163  										sb.AppendLine($"FrequencyInputInHertz: {message.SystemFrequency.FrequencyInputInHertz}");

  8175  										sb.AppendLine($"DateTime: {message.TripEndData.DateTime}");
  8176: 										sb.AppendLine($"OdometerInMetres: {message.TripEndData.OdometerInMetres}");
  8177  										sb.AppendLine($"DistanceInMetres: {message.TripEndData.DistanceInMetres}");

  8213  										sb.AppendLine($"DeviceSerialNumber: {message.DeviceSerialNumber}");
  8214: 										sb.AppendLine($"Odometer: {message.Odometer}");
  8215  										sb.AppendLine($"ModuleHalted: {message.LoggedHaltParameter.ModuleHalted}");

  8252  									trueTime = (msg.Message as FmConfigEventMessage).FmEventTrueTime.ToString();
  8253: 									odo = (msg.Message as FmConfigEventMessage).SystemOdometer.ToString();
  8254  									eventName = ConfigEventUtilities.GetConfigEventName((msg.Message as FmConfigEventMessage).FmEventHeader, new List<TestAppEventDescription>());

  8260  
  8261: 									summary = $"Type5Code {type5Code}, ActSeq# {actionSeqNumber}, Value {value}, Occurrances {occurrances}, TrueTime {trueTime}, {eventName}, Odo {odo} ";
  8262  

  8303  										sb.AppendLine($"EventSequenceNumber: {message.FmEventSequenceNumber}");
  8304: 										if (message.FmConfigEventParameterFlags.HasFlag(FmConfigEventParameterFlags.SystemOdometer))
  8305: 											sb.AppendLine($"SystemOdometer: {message.SystemOdometer}");
  8306  										if (message.FmConfigEventParameterFlags.HasFlag(FmConfigEventParameterFlags.EventOccurences))

  8374  										sb.AppendLine($"DriverId: {message.DriverIdValueParameter.DriverIdValue}"); 
  8375: 										if (message.FmActiveEventParameterFlags.HasFlag(FmActiveEventParameterFlags.SystemOdometer))
  8376: 											sb.AppendLine($"SystemOdometer: {message.SystemOdometer}");
  8377  										sb.AppendLine($"SystemSpeed: {message.SystemSpeed}");

  8528  										sb.AppendLine($"SettingsVersion: {message.SettingsVersion}");
  8529: 										sb.AppendLine($"Odometer: {message.Odometer}");
  8530  										sb.AppendLine($"VoltageInMillivolts: {message.BatteryState.VoltageInMillivolts}");

  8668  							case 199:
  8669: 								sb.AppendLine($"TRIP ODOMETER (m) - {teltonikaIoElement.Value}");
  8670  								break;
  8671  							case 16:
  8672: 								sb.AppendLine($"TOTAL ODOMETER (m) - {teltonikaIoElement.Value}");
  8673  								break;

  9033  			calampLog.IgnitionOn = bool.Parse(GetValuePart(columns[10]));
  9034: 			calampLog.OdometerKilometres = double.Parse(GetValuePart(columns[11]));
  9035  

  9085  			calampLog.IgnitionOn = bool.Parse(GetValuePart(columns[18]));
  9086: 			calampLog.OdometerKilometres = double.Parse(GetValuePart(columns[19]));
  9087  

  9143  			fmIncomingLog.IgnitionOn = bool.Parse(GetValuePart(columns[10]));
  9144: 			fmIncomingLog.OdometerKilometres = double.Parse(GetValuePart(columns[11]));
  9145  

  9202  			fmIncomingLog.IgnitionOn = bool.Parse(GetValuePart(columns[18]));
  9203: 			fmIncomingLog.OdometerKilometres = double.Parse(GetValuePart(columns[19]));
  9204  

  9257  			fmIncomingLog.IgnitionOn = bool.Parse(GetValuePart(columns[31]));
  9258: 			fmIncomingLog.OdometerKilometres = double.Parse(GetValuePart(columns[32]));
  9259  

  9298  			fmIncomingLog.IgnitionOn = bool.Parse(GetValuePart(columns[32]));
  9299: 			fmIncomingLog.OdometerKilometres = double.Parse(GetValuePart(columns[33]));
  9300  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Form1.designer.cs:
   186  			this.panelDatTop = new System.Windows.Forms.Panel();
   187: 			this.btnNextStuckOdo = new System.Windows.Forms.Button();
   188: 			this.btnPrevStuckOdo = new System.Windows.Forms.Button();
   189: 			this.lblStuckOdo = new System.Windows.Forms.Label();
   190  			this.btnNextTimeJump = new System.Windows.Forms.Button();

  1638  			// 
  1639: 			this.panelDatTop.Controls.Add(this.btnNextStuckOdo);
  1640: 			this.panelDatTop.Controls.Add(this.btnPrevStuckOdo);
  1641: 			this.panelDatTop.Controls.Add(this.lblStuckOdo);
  1642  			this.panelDatTop.Controls.Add(this.btnNextTimeJump);

  1650  			// 
  1651: 			// btnNextStuckOdo
  1652  			// 
  1653: 			this.btnNextStuckOdo.Location = new System.Drawing.Point(467, 7);
  1654: 			this.btnNextStuckOdo.Name = "btnNextStuckOdo";
  1655: 			this.btnNextStuckOdo.Size = new System.Drawing.Size(27, 23);
  1656: 			this.btnNextStuckOdo.TabIndex = 42;
  1657: 			this.btnNextStuckOdo.Text = ">>";
  1658: 			this.btnNextStuckOdo.UseVisualStyleBackColor = true;
  1659: 			this.btnNextStuckOdo.Visible = false;
  1660: 			this.btnNextStuckOdo.Click += new System.EventHandler(this.btnNextStuckOdo_Click);
  1661  			// 
  1662: 			// btnPrevStuckOdo
  1663  			// 
  1664: 			this.btnPrevStuckOdo.Location = new System.Drawing.Point(433, 7);
  1665: 			this.btnPrevStuckOdo.Name = "btnPrevStuckOdo";
  1666: 			this.btnPrevStuckOdo.Size = new System.Drawing.Size(28, 23);
  1667: 			this.btnPrevStuckOdo.TabIndex = 41;
  1668: 			this.btnPrevStuckOdo.Text = "<<";
  1669: 			this.btnPrevStuckOdo.UseVisualStyleBackColor = true;
  1670: 			this.btnPrevStuckOdo.Visible = false;
  1671: 			this.btnPrevStuckOdo.Click += new System.EventHandler(this.btnPrevStuckOdo_Click);
  1672  			// 
  1673: 			// lblStuckOdo
  1674  			// 
  1675: 			this.lblStuckOdo.AutoSize = true;
  1676: 			this.lblStuckOdo.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
  1677: 			this.lblStuckOdo.ForeColor = System.Drawing.Color.DarkRed;
  1678: 			this.lblStuckOdo.Location = new System.Drawing.Point(274, 12);
  1679: 			this.lblStuckOdo.Name = "lblStuckOdo";
  1680: 			this.lblStuckOdo.Size = new System.Drawing.Size(193, 13);
  1681: 			this.lblStuckOdo.TabIndex = 40;
  1682: 			this.lblStuckOdo.Text = "This dataset contains stuck odo!";
  1683: 			this.lblStuckOdo.Visible = false;
  1684  			// 

  2174  		private System.Windows.Forms.ToolStripMenuItem toolStripExportDAT;
  2175: 		private System.Windows.Forms.Button btnNextStuckOdo;
  2176: 		private System.Windows.Forms.Button btnPrevStuckOdo;
  2177: 		private System.Windows.Forms.Label lblStuckOdo;
  2178  		private System.Windows.Forms.Button btnNextTimeJump;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\MapForm.cs:
   382  						index = dr.Index;
   383: 						current = Convert.ToDouble(dr.Cells["Latitude"].Value);
   384  

   386  						if (index == 0)
   387: 							previous = Convert.ToDouble(dataGridView.Rows[0].Cells["Latitude"].Value);
   388  						else
   389: 							previous = Convert.ToDouble(dataGridView.Rows[index - 1].Cells["Latitude"].Value);
   390  
   391  						if (index < dataGridView.RowCount - 1)
   392: 							next = Convert.ToDouble(dataGridView.Rows[index + 1].Cells["Latitude"].Value);
   393  						else

   402  						//longitude
   403: 						current = Convert.ToDouble(dr.Cells["Longitude"].Value);
   404  						if (index == 0)
   405: 							previous = Convert.ToDouble(dataGridView.Rows[0].Cells["Longitude"].Value);
   406  						else
   407: 							previous = Convert.ToDouble(dataGridView.Rows[index - 1].Cells["Longitude"].Value);
   408  
   409  						if (index < dataGridView.RowCount - 1)
   410: 							next = Convert.ToDouble(dataGridView.Rows[index + 1].Cells["Longitude"].Value);
   411  						else

   747  
   748: 				TripCalculator.StartLatitude = Convert.ToDouble(startLat);
   749: 				TripCalculator.EndLatitude = Convert.ToDouble(endLat);
   750: 				TripCalculator.StartLongitude = Convert.ToDouble(startLong);
   751: 				TripCalculator.EndLongitude = Convert.ToDouble(endLong);
   752  				TripCalculator.MaxSpeed = Convert.ToInt16(numMaxSpeed.Value);

  1062  			PointLatLng fposition = new PointLatLng(
  1063: 				Convert.ToDouble(dataGridView.CurrentRow.Cells["Latitude"].Value.ToString()),
  1064: 				Convert.ToDouble(dataGridView.CurrentRow.Cells["Longitude"].Value.ToString()));
  1065  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\CalampLogRecord.cs:
  17  		public bool IgnitionOn { get; set; }
  18: 		public double OdometerKilometres { get; set; }
  19  		public GpsCoordinates Position { get; set; }

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\DataTableManager.cs:
    68  
    69: 			dt.Columns.Add("Odometer", typeof(string));
    70  			dt.Columns.Add("InternalBatteryStateVoltageInMillivolts", typeof(string));

   119  			dt.Columns.Add("SettingsVersion", typeof(string));
   120: 			dt.Columns.Add("Odometer", typeof(string));
   121  			dt.Columns.Add("InternalBatteryStateVoltageInMillivolts", typeof(string));

   199  
   200: 			dt.Columns.Add("SystemOdometer", typeof(string));
   201: 			dt.Columns.Add("OdoDifference", typeof(double));
   202  			dt.Columns.Add("FmEventOccurrences", typeof(string));

   287  			dt.Columns.Add("FmEventPositionGpsFixStatus", typeof(string));
   288: 			dt.Columns.Add("SystemOdometer", typeof(string));
   289  			dt.Columns.Add("SystemSpeed", typeof(string));

   690  			dt.Columns.Add("SystemValues", typeof(string));
   691: 			dt.Columns.Add("Odometer", typeof(string));
   692  			dt.Columns.Add("BatteryState", typeof(string));

   729  			dt.Columns.Add("TripStartDataDateTime", typeof(DateTime));
   730: 			dt.Columns.Add("TripStartDataOdometerInMetres", typeof(string));
   731  			dt.Columns.Add("SystemFrequencyFrequencyInputInHertz", typeof(string));

   755  			dt.Columns.Add("TripEndDataDateTime", typeof(DateTime));
   756: 			dt.Columns.Add("TripEndDataOdometerInMetres", typeof(string));
   757  			dt.Columns.Add("TripEndDataDistanceInMetres", typeof(string));

   792  			dt.Columns.Add("FleetSummarySpeedMaxEventDurationInMilliseconds", typeof(string));
   793: 			dt.Columns.Add("FleetSummarySpeedMaxEventOdometerInMeters", typeof(string));
   794  			dt.Columns.Add("FleetSummarySpeedMaxEventLatitude", typeof(string));

   800  			dt.Columns.Add("FleetSummaryAccelerationMaxEventDurationInMilliseconds", typeof(string));
   801: 			dt.Columns.Add("FleetSummaryAccelerationMaxEventOdometerInMeters", typeof(string));
   802  			dt.Columns.Add("FleetSummaryAccelerationMaxEventLatitude", typeof(string));

   808  			dt.Columns.Add("FleetSummaryBrakingMaxEventDurationInMilliseconds", typeof(string));
   809: 			dt.Columns.Add("FleetSummaryBrakingMaxEventOdometerInMeters", typeof(string));
   810  			dt.Columns.Add("FleetSummaryBrakingMaxEventLatitude", typeof(string));

   816  			dt.Columns.Add("FleetSummaryCorneringMaxEventDurationInMilliseconds", typeof(string));
   817: 			dt.Columns.Add("FleetSummaryCorneringMaxEventOdometerInMeters", typeof(string));
   818  			dt.Columns.Add("FleetSummaryCorneringMaxEventLatitude", typeof(string));

   824  			dt.Columns.Add("InsuranceSummarySpeedMaxEventDurationInMilliseconds", typeof(string));
   825: 			dt.Columns.Add("InsuranceSummarySpeedMaxEventOdometerInMeters", typeof(string));
   826  			dt.Columns.Add("InsuranceSummarySpeedMaxEventLatitude", typeof(string));

   832  			dt.Columns.Add("InsuranceSummaryAccelerationMaxEventDurationInMilliseconds", typeof(string));
   833: 			dt.Columns.Add("InsuranceSummaryAccelerationMaxEventOdometerInMeters", typeof(string));
   834  			dt.Columns.Add("InsuranceSummaryAccelerationMaxEventLatitude", typeof(string));

   840  			dt.Columns.Add("InsuranceSummaryBrakingMaxEventDurationInMilliseconds", typeof(string));
   841: 			dt.Columns.Add("InsuranceSummaryBrakingMaxEventOdometerInMeters", typeof(string));
   842  			dt.Columns.Add("InsuranceSummaryBrakingMaxEventLatitude", typeof(string));

   848  			dt.Columns.Add("InsuranceSummaryCorneringMaxEventDurationInMilliseconds", typeof(string));
   849: 			dt.Columns.Add("InsuranceSummaryCorneringMaxEventOdometerInMeters", typeof(string));
   850  			dt.Columns.Add("InsuranceSummaryCorneringMaxEventLatitude", typeof(string));

  1262  			dt.Columns.Add("F3Hz", typeof(int));
  1263: 			dt.Columns.Add("OdometerMeters", typeof(int));
  1264  			dt.Columns.Add("Analog1MilliVolt", typeof(int));

  1300  			dt.Columns.Add("TimeJump", typeof(bool));
  1301: 			dt.Columns.Add("StuckOdo", typeof(bool));
  1302  			dt.Columns.Add("TotalOccurrances", typeof(int));

  1304  			dt.Columns.Add("Duration", typeof(int));
  1305: 			dt.Columns.Add("Odometer", typeof(double));
  1306: 			dt.Columns.Add("OdoDifference", typeof(double));
  1307  			dt.Columns.Add("Latitude", typeof(decimal));

  1346  			dt.Columns.Add("InTrip", typeof(bool));
  1347: 			dt.Columns.Add("OdometerKilometres", typeof(double));
  1348: 			dt.Columns.Add("OdoDifference", typeof(double));
  1349  			dt.Columns.Add("TripMaxSpeed", typeof(int));

  1398  			dt.Columns.Add("InTrip", typeof(bool));
  1399: 			dt.Columns.Add("OdometerKilometres", typeof(double));
  1400: 			dt.Columns.Add("OdoDifference", typeof(double));
  1401  			dt.Columns.Add("TripMaxSpeed", typeof(int));

  1537  
  1538: 			dt.Columns.Add("SystemOdometer - Start", typeof(string));
  1539: 			dt.Columns.Add("SystemOdometer - End", typeof(string));
  1540: 			dt.Columns.Add("Odo Difference", typeof(string));
  1541  			dt.Columns.Add("FmEventValueEventValue", typeof(string));

  1572  
  1573: 			dt.Columns.Add("SystemOdometer", typeof(string));
  1574  

  1607  
  1608: 			dt.Columns.Add("SystemOdometer - Start", typeof(string));
  1609: 			dt.Columns.Add("SystemOdometer - End", typeof(string));
  1610: 			dt.Columns.Add("Odo Difference", typeof(string));
  1611  			dt.Columns.Add("FmEventValueEventValue", typeof(string));

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\DISRecord.cs:
  18  		public string MappedEventName { get { return EnumReader.GetEnumDescription(EventMessage); } }
  19: 		public float? StartOdometer { get; set; }
  20: 		public float? EndOdometer { get; set; }
  21  		public int TotalOccurances { get; set; }

  35  		public bool HasStartDate { get; set; }
  36: 		public bool HasStartOdometer { get; set; }
  37  		public bool HasEnd { get; set; }
  38  		public bool HasEndDate { get; set; }
  39: 		public bool HasEndOdometer { get; set; }
  40  		public bool MatchedWithMiXConnect { get; set; }

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\EventIds.cs:
  73  		public static long FM_OBC_DATE_UPDATED = 2715425441390540159;
  74: 		public static long FM_OBC_ODODOMETER_UPDATED = -6717396111168447572;
  75  		public static long FM_OBC_UNIT_RESET = 6455806276341189645;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\FmConstantEventId.cs:
   31  			{ SystemEventIds.Fm_OBCUnitReset, EventIds.FM_OBC_UNIT_RESET},
   32: 			{ SystemEventIds.Fm_OBCOdometerUpdated, EventIds.FM_OBC_ODODOMETER_UPDATED},
   33  			{ SystemEventIds.Fm_ExtDriverId, EventIds.EXTENDED_DRIVERID },

  157  				{
  158: 					EventIds.FM_OBC_ODODOMETER_UPDATED, new Dictionary<byte, RecordingTypes>()
  159  					{
  160: 						[ActionSequenceNumbers.Fm_OBC_Odometer_Updated] = RecordingTypes.Notification
  161  					}

  245  		TCODriver2Resting = 30,
  246: 		TCODoorOpen = 31,
  247  		TrailerA = 32,

  308  		CANFuelLevelPercentage = 107,
  309: 		CANHighResolutionVehicleOdometer = 108,
  310  		CANLowOilLevelDetected = 109,

  334  		OBCDateUpdated = 29983,
  335: 		OBCOdometerUpdated = 29984,
  336  		OBCUnitReset = 29985,

  422  		public const short SetTime = 32554;
  423: 		public const short SetOdo = 32563;
  424  		public const short SetEngineHours = 32568;

  443  		public const short Fm_OBCDateUpdated = 29983;
  444: 		public const short Fm_OBCOdometerUpdated = 29984;
  445  		public const short Fm_OBCUnitReset = 29985;

  538  		/// </summary>
  539: 		public static byte Fm_OBC_Odometer_Updated = 0;
  540  		public static byte Fm_Extended_Driver_Id = 0;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\FmIncomingLogRecord.cs:
  17  		public bool IgnitionOn { get; set; }
  18: 		public double OdometerKilometres { get; set; }
  19  		public GpsCoordinates Position { get; set; }

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\GPSData.cs:
   67  			{
   68: 				double speed = Convert.ToDouble(Velocity) * 0.54;
   69  				return speed.ToString();

   75  			string text;
   76: 			text = Convert.ToDouble(Latitude) < 0 ? "S" : "N";
   77  			return text;

   82  			string text;
   83: 			text = Convert.ToDouble(Longitude) < 0 ? "W" : "E";
   84  			return text;

  113  
  114: 			DotNetCoords.LatLng latlng = new LatLng(Convert.ToDouble(Latitude), Convert.ToDouble(Longitude));
  115  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

  134  			text += "A,"; //Status A=active or V=Void
  135: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
  136  			text += NorthOrSouth() + ","; //Latitude N or S
  137: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
  138  			text += EastOrWest() + ","; //Longitude E or W

  168  		{
  169: 			DotNetCoords.LatLng latlng = new LatLng(Convert.ToDouble(Latitude), Convert.ToDouble(Longitude));
  170  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

  184  			text += TimeOnly + ","; //time
  185: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
  186  			text += NorthOrSouth() + ","; //Latitude N or S
  187: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
  188  			text += EastOrWest() + ","; //Longitude E or W

  244  		{
  245: 			DotNetCoords.LatLng latlng = new LatLng(Convert.ToDouble(Latitude), Convert.ToDouble(Longitude));
  246  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

  259  			string text = "$GPGLL,";
  260: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
  261  			text += NorthOrSouth() + ","; //Latitude N or S
  262: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
  263  			text += EastOrWest() + ","; //Longitude E or W

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\GPSPosition.cs:
  55  			{
  56: 				double speed = Convert.ToDouble(Velocity) * 0.54;
  57  				return speed.ToString();

  63  			string text;
  64: 			text = Convert.ToDouble(Latitude) < 0 ? "S" : "N";
  65  			return text;

  70  			string text;
  71: 			text = Convert.ToDouble(Longitude) < 0 ? "W" : "E";
  72  			return text;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\InterpretedDatRecord.cs:
  26  		public bool TimeJump { get; set; }
  27: 		public bool StuckOdo { get; set; }
  28  		public Section StartSection { get; set; }

  57  		public DateTime? SectionDate { get; set; }
  58: 		public int? Odometer { get; set; }
  59  		public int? TotalOccurances { get; set; }

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.DISViewer\Classes\TripCreator.cs:
  82  
  83: 			double incdec = Convert.ToDouble(lstGps[lstGps.Count / 2].Velocity) / max;
  84  			double velocity = 0;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Core\Processing\MesaFwVersionChanged.cs:
  37  
  38: 				var serverSideOdoOffset = DependencyRegistry.GetInstance<IOdometerState>(true).GetOdometerOffset(e.MobileUnitId);
  39: 				Logger.Log($"{e.MobileUnitId}, Tracking {e.TrackingId}, New firmware version={e.NewVersion}, Previous firmware version={e.PreviousVersion}, Server-side odometer offset={serverSideOdoOffset}", LogLevel.Debug);
  40  

  42  				// send command with 0 values - we only need the offset value to get to the unit, so the calculation will be:
  43: 				// 0 - 0 + offset = offset - goes to the unit and sets the correct odo
  44: 				if ((newFwVersion >= 400080000) && (prevFwVersion < 400080000) && (serverSideOdoOffset != 0))
  45  				{
  46: 					var result = DeviceConfigClient.MobileUnits.SetMobileUnitOdometerMeters(authToken, mum.OrganisationId, mum.MobileUnitId, 0, 0)
  47  						.ConfigureAwait(false).GetAwaiter().GetResult();

  49  					if (result == false)
  50: 						Logger.Log($"{e.MobileUnitId}, Tracking {e.TrackingId}, Odometer set command with offset value {serverSideOdoOffset} for mobile unit {mum.MobileUnitId} failed to send to the unit.", LogLevel.Error);
  51  					else
  52: 						Logger.Log($"{e.MobileUnitId}, Tracking {e.TrackingId}, Odometer set command with offset value {serverSideOdoOffset} for mobile unit {mum.MobileUnitId} sent successfully to the unit.", LogLevel.Debug);
  53  				}

  55  				{
  56: 					Logger.Log($"{e.MobileUnitId}, Tracking {e.TrackingId}, The unit has already been upgraded to a version that handles odo: Prev Version {e.PreviousVersion} and new version {e.NewVersion}", LogLevel.Debug);
  57  				}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Core\Processing\MesaTripProcessing.cs:
   30  
   31: 			DependencyRegistry.GetInstance<IOdometerState>(true).CheckIfOdoOffsetRecalculationIsNeeded(mum.MobileUnitId, message.TripStartData.OdometerInMetres);
   32  
   33: 			DependencyRegistry.GetInstance<IOdometerState>(true).SetUnitRawOdometer(mum.MobileUnitId, message.TripStartData.OdometerInMetres);
   34  			
   35: 			DependencyRegistry.GetInstance<IOdometerState>(true).SetAssetSubTripStartOdometer(mum.MobileUnitId, message.TripStartData.OdometerInMetres);
   36  
   37: 			ProcessTripPosition(preprocessor, serviceName, mum.MobileUnitId, message.GpsData, message.TrackingID, message.DeviceDateTime, message.TripStartData.OdometerInMetres);
   38  

   56  
   57: 			decimal startOdo = tripEndMsg3.TripEndData.OdometerInMetres - tripEndMsg3.TripEndData.DistanceInMetres;
   58  

   60  			ProcessTripPosition(preprocessor, serviceName, mum.MobileUnitId, tripEndMsg3.TripStartGpsData, tripEndMsg3.TrackingID, 
   61: 				tripEndMsg3.TripStartGpsData.DeviceDateTime, startOdo, false);
   62  

   64  			ProcessTripPosition(preprocessor, serviceName, mum.MobileUnitId, tripEndMsg3.GpsData, tripEndMsg3.TrackingID, 
   65: 				tripEndMsg3.TripEndData.DateTime, tripEndMsg3.TripEndData.OdometerInMetres);
   66  

   91  					(int)tripEndMsg3.EngineInfo.TripIdleTimeInSeconds, tripEndMsg3.EngineInfo.TripIdleTimeInSeconds > 0 ? 1 : 0,
   92: 					null, null, startOdo, tripEndMsg3.TripEndData.OdometerInMetres,
   93  					startEH, null, null, tripEndMsg3.TripStartGpsData.DeviceDateTime, tripEndMsg3.TripEndData.DateTime));

   99  				tripNumber, subtrips, driverId, driverId, startTime,
  100: 				tripEndMsg3.TripEndData.DateTime, null, false, null, null, startOdo, tripEndMsg3.TripEndData.OdometerInMetres, // SR-3918 odo jump
  101  				false, 

  107  
  108: 			DependencyRegistry.GetInstance<IOdometerState>(true).SetUnitRawOdometer(mum.MobileUnitId, tripEndMsg3.TripEndData.OdometerInMetres);
  109  
  110: 			DependencyRegistry.GetInstance<IOdometerState>(true).SetRawOdometerFromTripEnd(mum.MobileUnitId, tripEndMsg3.TripEndData.OdometerInMetres);
  111  

  117  
  118: 		private static void ProcessTripPosition(IPreProcessor preprocessor, string serviceName, long mobileUnitId, GpsData gpsData, string trackingId, DateTime deviceTime, decimal odometer, bool setGpsInfo = true)
  119  		{

  130  				(int)gpsData.SpeedMetresPerHour, gpsData.Latitude, gpsData.Longitude, (short)gpsData.Hdop,
  131: 				gpsData.NoOfSatellites, deviceTime, null, null, null, odometer, true, null, false, true, trackingId, true);
  132  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Core\Processing\ThirdPartyTripProcessing.cs:
   30  		public static Trip ProcessTripStart(long mobileUnitId, long organisationId, DateTime tripStartTime,
   31: 			long? engineSeconds, decimal? startOdometer, long driverId, Position startPosition, out bool duplicate, out bool oldData)
   32  		{

   69  			{
   70: 				if(!startOdometer.HasValue)
   71  				{
   72: 					startOdometer = DependencyRegistry.GetInstance<IOdometerState>(true).GetAssetLastTripEndOdometer(mobileUnitId);
   73  
   74: 					if(!startOdometer.HasValue) // if no last trip end odometer exist and none supplied then start at 0
   75  					{
   76: 						startOdometer = 0;
   77  					}

   81  				staging.InsertTrip(mobileUnitId, organisationId, 1, tripStartTime, tripStartTime, RequiresTripEnd,
   82: 					null, null, null, null, engineSeconds, null, startOdometer, null, driverId, driverId, null, null);
   83  

   88  
   89: 			decimal? potentialStartOdometer = null;
   90  

  100  
  101: 				potentialStartOdometer = stagedTrips[i].EndOdometer;
  102  			}

  112  					{
  113: 						if(!startOdometer.HasValue)
  114  						{

  116  							
  117: 							if(!potentialStartOdometer.HasValue)
  118  							{
  119: 								potentialStartOdometer = 0;
  120  							}
  121  
  122: 							result.SubTrips[0].SubTripStart.Odometer = potentialStartOdometer;
  123: 							result.SubTrips[0].SubTripEnd.Odometer = potentialStartOdometer + result.SubTrips[0].Distance;
  124  						}

  128  							result.TripStartEngineSeconds, result.TripEndEngineSeconds,
  129: 							result.StartOdometer, result.EndOdometer);
  130  					}

  135  					
  136: 					// DP still needs this flag to finalise odo states
  137: 					result.CalculateOdometer = true; 
  138  					return result;

  141  
  142: 			if(!startOdometer.HasValue)
  143  			{
  144: 				startOdometer = DependencyRegistry.GetInstance<IOdometerState>(true).GetAssetLastTripEndOdometer(mobileUnitId);
  145  
  146: 				if(!startOdometer.HasValue) // if no last trip end odometer exist and none supplied then start at 0
  147  				{
  148: 					startOdometer = 0;
  149  				}

  154  			staging.InsertTrip(mobileUnitId, organisationId, highestTripNumber + 1, tripStartTime, tripStartTime, RequiresTripEnd,
  155: 				null, null, null, null, engineSeconds, null, startOdometer, null, driverId, driverId, null, null);
  156  

  166  		private static Trip BuildTripFromExistingEnd(TripComplete endPart, DateTime tripStartTime,
  167: 			long? engineSeconds, decimal? odometer, Position startPosition, IStagingRepository staging)
  168  		{

  173  				// is already present and then continue to determine max speed
  174: 				CalculateOdometer = true, 
  175  				MobileUnitId = endPart.MobileUnitId,

  178  				PulseIsFuel = false,
  179: 				AdjustOdometer = true,
  180  				TripEndTime = endPart.EndDateTime,

  189  			
  190: 			if(odometer.HasValue)
  191  			{
  192: 				distance = endPart.EndOdometer - odometer;
  193: 				trip.CalculateOdometer = false;
  194  			}

  196  			{
  197: 				trip.CalculateOdometer = true;
  198  			}

  233  					EngineSeconds = engineSeconds,
  234: 					Odometer = odometer
  235  				},

  242  					EngineSeconds = (long?)endPart.EndEngineSeconds,
  243: 					Odometer = endPart.EndOdometer
  244  				},

  254  		public static Trip ProcessTripEnd(long mobileUnitId, long organisationId, DateTime tripEndTime,
  255: 			long? engineSeconds, decimal? tripEndOdometer, long driverId, Position endPosition, out bool duplicate, out bool oldData)
  256  		{

  289  				staging.InsertTrip(mobileUnitId, organisationId, 1, tripEndTime, tripEndTime, RequiresTripStart,
  290: 					null, null, null, null, null, engineSeconds, null, tripEndOdometer, driverId, driverId, null, null);
  291  

  323  
  324: 						var result = BuildTripFromExistingStart(target, tripEndTime, engineSeconds, tripEndOdometer, endPosition, staging);
  325  					

  327  
  328: 						if(!tripEndOdometer.HasValue)
  329  						{
  330: 							if(!result.SubTrips[0].SubTripStart.Odometer.HasValue)
  331  							{
  332: 								result.SubTrips[0].SubTripStart.Odometer = 0;
  333  							}
  334  
  335: 							result.SubTrips[0].SubTripEnd.Odometer = result.SubTrips[0].SubTripStart.Odometer + result.SubTrips[0].Distance;
  336  						}
  337  
  338: 						// make sure trip start odometer is correct
  339: 						result.SubTrips[0].SubTripStart.Odometer = result.SubTrips[0].SubTripEnd.Odometer - result.SubTrips[0].Distance;
  340  
  341: 						DependencyRegistry.GetInstance<IOdometerState>(true).SetRawOdometerFromTripEnd(mobileUnitId, result.SubTrips[0].SubTripEnd.Odometer.Value);
  342  
  343: 						// DP still needs this flag to finalise odo states
  344: 						result.CalculateOdometer = true; 
  345  

  350  							result.TripStartEngineSeconds, result.TripEndEngineSeconds,
  351: 								target.StartOdometer, result.EndOdometer);
  352  						}

  368  				staging.InsertTrip(mobileUnitId, organisationId, highestTripNumber + 1, tripEndTime, tripEndTime, RequiresTripStart,
  369: 					null, null, null, null, null, engineSeconds, null, tripEndOdometer, driverId, driverId, null, null);
  370  

  383  		private static Trip BuildTripFromExistingStart(TripComplete startPart, DateTime tripEndTime,
  384: 			long? engineSeconds, decimal? tripEndOdometer, Position endPosition, IStagingRepository staging)
  385  		{

  390  				// is already present and then continue to determine max speed
  391: 				CalculateOdometer = true, 
  392  				MobileUnitId = startPart.MobileUnitId,

  395  				PulseIsFuel = false,
  396: 				AdjustOdometer = true,
  397  				TripEndTime = tripEndTime,

  406  			
  407: 			if(tripEndOdometer.HasValue)
  408  			{
  409: 				distance = tripEndOdometer - startPart.StartOdometer;
  410: 				trip.CalculateOdometer = false;
  411  			}

  413  			{
  414: 				trip.CalculateOdometer = true;
  415  			}

  450  					EngineSeconds = (long?)startPart.StartEngineSeconds,
  451: 					Odometer = startPart.StartOdometer
  452  				},

  459  					EngineSeconds = engineSeconds,
  460: 					Odometer = tripEndOdometer
  461  				},

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.G52S\DmePositionTranslator.cs:
  12  	{
  13: 		// TODO: Confirm with Sean if documented multipliers should be used here
  14  		internal static Position TranslateG52Position(PublisherMessage message, MobileUnitMapping mum) 

  23  
  24: 					CalculateOdometer = true,
  25  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.G52S\PublisherMessageTwo.cs:
  75  			// SR-11941
  76: 			DependencyRegistry.GetInstance<IOdometerState>(true).ForceNewOdoSetToLastDisplayOdo(mum.MobileUnitId);
  77  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.G52S\TripFidelity\TripFidelity.cs:
  308  					false,
  309: 					calculateOdo: true);
  310  				}

  329  					false,
  330: 					calculateOdo: true);
  331  				}

  335  					TripStartTime = tripStartMessage.DeviceDateTime,
  336: 					CalculateOdometer = true,
  337  					MobileUnitId = mum.MobileUnitId,

  340  					PulseIsFuel = false,
  341: 					AdjustOdometer = true,
  342  					TripEndTime = tripEndMessage.DeviceDateTime,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Iridium\IridiumService.cs:
  437  				DateTime.UtcNow, mpem.DeviceDateTime.DateTime, mpem.FmEventValue,
  438: 				0,      // odometer
  439  				null,   // speed

  454  				DateTime.UtcNow, mem.DeviceDateTime.DateTime, mem.FmEventValue, 
  455: 				0,			// odometer
  456  				0,			// speed

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.M2K\M2KService.cs:
  105  
  106: 		private IOdometerState _odometerState;
  107: 		public IOdometerState OdometerState
  108  		{

  110  			{
  111: 				if (_odometerState == null)
  112  				{
  113: 					_odometerState = DependencyRegistry.GetInstance<IOdometerState>(true);
  114  				}
  115: 				return _odometerState;
  116  			}

  546  		{
  547: 			//DIE-272 if no odometer flag is present, we need to send null and not 0
  548: 			decimal? odo = null;
  549: 			if (avlMessage.AvlParameterFlags.HasFlag(AvlParameterFlags.Odometer))
  550  			{
  551: 				odo = avlMessage.Odometer;
  552  
  553  				// Don't worry this writes to redis now and only updates the state table once every minute
  554: 				DependencyRegistry.GetInstance<IOdometerState>(true).SetUnitRawOdometer(mum.MobileUnitId, odo.Value); 
  555  			}

  572  				avlMessage.GpsData.NoOfSatellites, avlMessage.DeviceDateTime, null, 0, 0, driverId,
  573: 				odo, false, new LegacyIds(mum.LegacyVehicleId, legacyDriverId), tripMode: MobileUnitState.GetTripMode(mum.MobileUnitId, avlMessage.DeviceDateTime));
  574  

  591  				msg.Imei, msg.DeviceDateTime, (uint?)msg.ActionReplyParameterFlags,
  592: 				msg.StatusFlags?.InTrip, msg.Odometer, msg.Imsi, msg.FirmwareVersion?.ToString(), 
  593  				msg.PlatformInfo.PlatformVersion?.ToString(), msg.SystemValuesParameter?.ExternalSupplyVoltageInMillivolts.ToString(), 

  597  
  598: 			ProcessActionReplyOdoAndEngineHours(msg, mum); //QA-4815
  599  

  628  
  629: 		private void ProcessActionReplyOdoAndEngineHours(ActionReplyMessage4 msg, MobileUnitMapping mum)
  630  		{

  636  					bool? tripMode = MobileUnitState.GetTripMode(mum.MobileUnitId, msg.DeviceDateTime);
  637: 					if (cmdDetails.MessageSubType == CommandIdType.SetOdometerOffset)
  638  					{

  640  						{
  641: 							OdometerState.SetMessageIdForOdometerViaCommand(cmdDetails.MobileUnitId, cmdDetails.MessageId);
  642: 							Logger.Log($"{msg.TrackingID}, MessageId {msg.MessageId}, Handling ActionReply for setting Odometer offset: SetMessageIdForOdometerViaCommand", LogLevel.Debug);
  643  						}

  645  						{
  646: 							OdometerState.ClearOdometerOffsets(mum.MobileUnitId);
  647: 							Logger.Log($"{msg.TrackingID}, MessageId {msg.MessageId}, Handling ActionReply for setting Odometer offset (MessageId={cmdDetails.MessageId}): ClearOdometerOffsets", LogLevel.Debug);
  648  						}

  668  		private ActiveEventDTO GetActiveEvent(GpsData gpsData, DateTime eventDateTime, MobileUnitMapping mum, long eventId, float? value,
  669: 			decimal odometer = 0, long? driverId = null, bool calibrate = true, short? legacyEventId = null)
  670  		{

  688  				driverId.Value, eventId, DateTime.UtcNow, eventDateTime, value,
  689: 				odometer, gpsData?.SpeedMetresPerHour, false, position, new LegacyIds(mum.LegacyVehicleId, null, legacyEventId), null, calibrate);
  690  		}

  770  				{
  771: 					proc.ProcessActiveEvent(GetActiveEvent(message.GpsData, message.DeviceDateTime, mum, EventIds.SUB_TRIP_START, 0, message.TripStartData.OdometerInMetres, driverId: driverId));
  772  				}

  802  				{
  803: 					PreProcessor.ProcessActiveEvent(GetActiveEvent(tripEndMsg3.GpsData, tripEndMsg3.DeviceDateTime, mum, EventIds.SUB_TRIP_END, 0, tripEndMsg3.TripEndData.OdometerInMetres, driverId: driverId));
  804  				}

  839  				message.Imei, message.DeviceDateTime, null, message.StatusFlags?.InTrip,
  840: 				message.Odometer, message.Imsi, message.FirmwareVersion?.ToString(),
  841  				message.PlatformInfo.PlatformVersion?.ToString(), message.SystemValuesParameter?.ExternalSupplyVoltageInMillivolts.ToString(),

  921  				message.Imei, message.DeviceDateTime, null, message.StatusFlags?.InTrip,
  922: 				message.Odometer, message.Imsi, message.FirmwareVersion.ToString(), null, 
  923  				message.SystemValuesParameter.ExternalSupplyVoltageInMillivolts.ToString(), 

  925  
  926: 			coldbootStatus.Odometer = message.Odometer; //needed for Config-2618
  927  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.M2K\DataAccess\ConvertToTachoDto.cs:
  123  							break;
  124: 						case UdpParameterId.SystemOdometer: // =1307 (SYSTEM_ODOMETER) - M6k Only Parameter
  125: 							trec.OdometerMeters = nVal;
  126: 							sLog = string.Format("SYSTEM_ODOMETER = {0}", nVal);
  127  							bStoreCurrRec = true;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.M6K\M6KService.cs:
   114  
   115: 		private IOdometerState _odometerState;
   116: 		public IOdometerState OdometerState
   117  		{

   119  			{
   120: 				if (_odometerState == null)
   121  				{
   122: 					_odometerState = DependencyRegistry.GetInstance<IOdometerState>(true);
   123  				}
   124: 				return _odometerState;
   125  			}

   504  
   505: 			//DIE-272 if no odometer flag is present, we need to send null and not 0
   506: 			decimal? odo = null;
   507: 			if (avlMessage.AvlParameterFlags.HasFlag(AvlParameterFlags.Odometer))
   508  			{
   509: 				odo = avlMessage.Odometer;
   510  
   511: 				DependencyRegistry.GetInstance<IOdometerState>(true).SetUnitRawOdometer(mum.MobileUnitId, odo.Value);
   512  			}

   543  				avlMessage.GpsData.NoOfSatellites, avlMessage.DeviceDateTime, null, 0, 0, driverId.Value,
   544: 				odo, false, null);
   545  

   595  		private ActiveEventDTO GetActiveEventFromMesaEvent(GpsData gpsData, DateTime eventDateTime, MobileUnitMapping mum, long eventId, uint? value,
   596: 			decimal odometer = 0, bool calibrate = true, bool? sseIgnore = null)
   597  		{

   612  				driverId, eventId, DateTime.UtcNow, eventDateTime, value,
   613: 				odometer, gpsData?.SpeedMetresPerHour, false, position, null, null, calibrate, rawValue: value);
   614  		}

   662  				message.Imei, message.DeviceDateTime, null, message.StatusFlags?.InTrip,
   663: 				message.Odometer, message.Imsi, message.FirmwareVersion.ToString(), null, 
   664  				message.SystemValuesParameter.ExternalSupplyVoltageInMillivolts.ToString(), 

   940  						null, // no altitude in any GPS positions for MiX 4k/6k
   941: 						fmActiveMsg.SystemOdometer, false);
   942  

  1002  					// SR-9144 do not cast value to int
  1003: 					ActiveEventDTO activeEvent = GetActiveEventFromMesaEvent(null, fmActiveMsg.DeviceDateTime, mum, ed.EventId, fmActiveMsg.GenericValue, fmActiveMsg.SystemOdometer);
  1004  					activeEvent.Position = position;

  1022  				{
  1023: 					var loggable = LoggableFmDataFactory.GetLoggableFmDataEvent(driverId.Value, fmActiveMsg.DeviceDateTime, 0, fmActiveMsg.SystemOdometer, mum.MobileUnitId, mum.OrganisationId,
  1024  						fmActiveMsg.FmEventLoggableArray.AcronymA, fmActiveMsg.FmEventLoggableArray.AcronymB, fmActiveMsg.FmEventLoggableArray.DataLength, fmActiveMsg.FmEventLoggableArray.Data, position);

  1031  				{
  1032: 					var loggable = LoggableFmDataFactory.GetLoggableFmDataEvent(driverId.Value, fmActiveMsg.DeviceDateTime, 0, fmActiveMsg.SystemOdometer, mum.MobileUnitId, mum.OrganisationId,
  1033  						fmActiveMsg.FmEventLoggableValue.AcronymA, fmActiveMsg.FmEventLoggableValue.AcronymB, fmActiveMsg.FmEventLoggableValue.DataLength, fmActiveMsg.FmEventLoggableValue.Data, position);

  1081  
  1082: 				decimal? odometer = null;
  1083  
  1084: 				if (m.FmConfigEventParameterFlags.HasFlag(FmConfigEventParameterFlags.SystemOdometer))
  1085  				{
  1086: 					odometer = m.SystemOdometer;
  1087  
  1088: 					DependencyRegistry.GetInstance<IOdometerState>(true).SetUnitRawOdometer(mum.MobileUnitId, m.SystemOdometer);
  1089  				}

  1097  						PositionFactory.Utilities.ScaleConfigHdopToMesa(m.FmEventPosition.Hdop),
  1098: 						m.FmEventPosition.NoOfSatellites, m.DeviceDateTime, null, 0, null, odometer, null);
  1099  

  1124  					{
  1125: 						var loggable = LoggableFmDataFactory.GetLoggableFmDataEvent(driverId, m.DeviceDateTime, m.FmEventSequenceNumber, m.SystemOdometer, mum.MobileUnitId, mum.OrganisationId,
  1126  								m.FmEventLoggableValue.AcronymA, m.FmEventLoggableValue.AcronymB, m.FmEventLoggableValue.DataLength, m.FmEventLoggableValue.Data, position);

  1133  					{
  1134: 						var loggable = LoggableFmDataFactory.GetLoggableFmDataEvent(driverId, m.DeviceDateTime, m.FmEventSequenceNumber, m.SystemOdometer, mum.MobileUnitId, mum.OrganisationId,
  1135  								m.FmEventLoggableArray.AcronymA, m.FmEventLoggableArray.AcronymB, m.FmEventLoggableArray.DataLength, m.FmEventLoggableArray.Data, position);

  1141  				{
  1142: 					PreProcessor.ProcessBasicEvent(EventFactory.GetBasicEvent(ed.EventId, ed.RecordingType, mum.MobileUnitId, m.DeviceDateTime, odometer,
  1143  						m.FmEventHeader.EventActionSequenceNumber, m.FmEventSequenceNumber, m.FmEventValue.EventValue, (int)m.FmEventOccurrences, (int)m.FmEventTrueTime,

  1186  		{
  1187: 			decimal? odometer = null;
  1188  
  1189: 			if (m.FmConfigEventParameterFlags.HasFlag(FmConfigEventParameterFlags.SystemOdometer))
  1190  			{
  1191: 				odometer = m.SystemOdometer;
  1192  			}

  1197  					.ProcessPassiveEvent(PassiveEventFactory.CreateNotificationEventDTO(m.TrackingID, mum.MobileUnitId, ed.EventId, 
  1198: 						m.FmEventSequenceNumber, m.DeviceDateTime, m.FmEventValue.EventValue, m.FmEventHeader.EventActionSequenceNumber, odometer: odometer, rawValue: m.FmEventValue.EventValue));
  1199  			}

  1202  				PreProcessor
  1203: 					.ProcessBasicEvent(EventFactory.GetBasicEvent(ed.EventId, ed.RecordingType, mum.MobileUnitId, m.DeviceDateTime, odometer,
  1204  						m.FmEventHeader.EventActionSequenceNumber, m.FmEventSequenceNumber, m.FmEventValue.EventValue, (int)m.FmEventOccurrences, (int)m.FmEventTrueTime, rawValue: m.FmEventValue.EventValue));

  1258  
  1259: 			if(m.FmConfigEventParameterFlags.HasFlag(FmConfigEventParameterFlags.SystemOdometer))
  1260  			{
  1261: 				DependencyRegistry.GetInstance<IOdometerState>(true).SetAssetSubTripStartOdometer(mum.MobileUnitId, m.SystemOdometer);
  1262  			}

  1350  					PositionFactory.Utilities.GetAgeOfReading(m.DeviceDateTime, m.FmEventPosition.PositionTimestamp),
  1351: 					m.FmEventPosition.Hdop, //Todo: Should probably be this PositionFactory.Utilities.ScaleConfigHdopToMesa(m.FmEventPosition.Hdop), 
  1352  					m.FmEventPosition.NoOfSatellites, m.FmEventPosition.Velocity);

  1354  				// MR-170
  1355: 				if (m.FmConfigEventParameterFlags.HasFlag(FmConfigEventParameterFlags.SystemOdometer))
  1356  				{
  1357: 					DependencyRegistry.GetInstance<IOdometerState>(true).SetRawOdometerFromTripEnd(mum.MobileUnitId, m.SystemOdometer);
  1358  
  1359: 					DependencyRegistry.GetInstance<IOdometerState>(true).SetUnitRawOdometer(mum.MobileUnitId, m.SystemOdometer);
  1360  				}

  1464  		{
  1465: 			decimal? odometer = null;
  1466  
  1467: 			if (m.FmConfigEventParameterFlags.HasFlag(FmConfigEventParameterFlags.SystemOdometer))
  1468  			{
  1469: 				odometer = m.SystemOdometer;
  1470  			}

  1472  			PassiveEventDTO departHalt = PassiveEventFactory.CreateNotificationEventDTO(m.TrackingID, mum.MobileUnitId, ed.EventId, 
  1473: 				m.FmEventSequenceNumber, m.DeviceDateTime, m.FmEventValue.EventValue, 1, false, odometer, false, rawValue: m.FmEventValue.EventValue); // action 1 = end or Halt
  1474  

  1557  				msg.Imei, msg.DeviceDateTime, (uint?)msg.ActionReplyParameterFlags,
  1558: 				msg.StatusFlags?.InTrip, msg.Odometer, msg.Imsi,
  1559  				msg.FirmwareVersion.ToString(), msg.PlatformInfo.PlatformVersion.ToString(), msg.SystemValuesParameter.ExternalSupplyVoltageInMillivolts.ToString(),

  1562  			MobileUnitState.UpdateMobileUnitStatus(mum.MobileUnitId, statusMessage, msg.TrackingID);
  1563: 			ProcessActionReplyOdoAndEngineHours(msg, mum);
  1564  

  1592  
  1593: 		private void ProcessActionReplyOdoAndEngineHours(ActionReplyMessage4 msg, MobileUnitMapping mum)
  1594  		{

  1600  					bool? tripMode = MobileUnitState.GetTripMode(mum.MobileUnitId, msg.DeviceDateTime);
  1601: 					if (cmdDetails.MessageSubType == CommandIdType.SetOdometerOffset)
  1602  					{

  1604  						{
  1605: 							OdometerState.SetMessageIdForOdometerViaCommand(cmdDetails.MobileUnitId, cmdDetails.MessageId);
  1606: 							Logger.Log($"{mum.UniqueIdentifier}, Mobile Unit {mum.MobileUnitId}, Tracking {msg.TrackingID}, Handling ActionReply for setting Odometer offset (MessageId={cmdDetails.MessageId}): SetMessageIdForOdometerViaCommand", LogLevel.Debug);
  1607  						}

  1609  						{
  1610: 							OdometerState.ClearOdometerOffsets(mum.MobileUnitId);
  1611: 							Logger.Log($"{mum.UniqueIdentifier}, Mobile Unit {mum.MobileUnitId}, Tracking {msg.TrackingID}, Handling ActionReply for setting Odometer offset (MessageId={cmdDetails.MessageId}): ClearOdometerOffsets", LogLevel.Debug);
  1612  						}

  1637  				msg.Imei, msg.DeviceDateTime, null, msg.StatusFlags?.InTrip,
  1638: 				msg.Odometer, msg.Imsi, msg.FirmwareVersion.ToString(), msg.PlatformInfo.PlatformVersion.ToString(),
  1639  				msg.SystemValuesParameter.ExternalSupplyVoltageInMillivolts.ToString(),

  1813  		{
  1814: 			decimal? odometer = null;
  1815  
  1816: 			if (m.FmConfigEventParameterFlags.HasFlag(FmConfigEventParameterFlags.SystemOdometer))
  1817  			{
  1818: 				odometer = m.SystemOdometer;
  1819  
  1820  				// MR-170
  1821: 				DependencyRegistry.GetInstance<IOdometerState>(true).CheckIfOdoOffsetRecalculationIsNeeded(mum.MobileUnitId, odometer.Value);
  1822  				
  1823: 				DependencyRegistry.GetInstance<IOdometerState>(true).SetUnitRawOdometer(mum.MobileUnitId, odometer.Value);
  1824  
  1825: 				DependencyRegistry.GetInstance<IOdometerState>(true).SetAssetSubTripStartOdometer(mum.MobileUnitId, odometer.Value);
  1826  			}

  1831  					.ProcessPassiveEvent(PassiveEventFactory.CreateNotificationEventDTO(m.TrackingID, mum.MobileUnitId, EventIds.TRIP_START,
  1832: 						m.FmEventSequenceNumber, m.DeviceDateTime, m.FmEventValue.EventValue, ActionSequenceNumbers.TripStart_TripNumber, false, odometer, false, rawValue: m.FmEventValue.EventValue));
  1833  

  1854  						m.FmEventSequenceNumber, m.DeviceDateTime, driverId, m.FmEventHeader.EventActionSequenceNumber, 
  1855: 						false, odometer, false, rawValue: m.FmEventValue.EventValue));
  1856  				}

  1868  						m.FmEventSequenceNumber, m.DeviceDateTime, pulseParameterId, m.FmEventHeader.EventActionSequenceNumber,
  1869: 						false, odometer, false, rawValue: m.FmEventValue.EventValue));
  1870  			}

  1875  						m.FmEventSequenceNumber, m.DeviceDateTime, m.FmEventValue.EventValue, m.FmEventHeader.EventActionSequenceNumber,
  1876: 						false, odometer, false, rawValue: m.FmEventValue.EventValue));
  1877  			}

  1938  			PassengerIdentified passengerIdentified = new PassengerIdentified(mum.MobileUnitId, mum.OrganisationId, m.FmEventSequenceNumber,
  1939: 				mum.LegacyVehicleId, (short)m.FmEventValue.EventValue, m.DeviceDateTime, m.SystemOdometer, m.TrackingID);
  1940  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.M6K\DataAccess\ConvertToHighResolutionTachoDto.cs:
  127  							break;
  128: 						case UdpParameterId.SystemOdometer: // =1307 (SYSTEM_ODOMETER) - M6k Only Parameter
  129: 							trec.OdometerMeters = nVal;
  130: 							sLog = string.Format("SYSTEM_ODOMETER = {0}", nVal);
  131  							bStoreCurrRec = true;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.M6K\DataAccess\ConvertToTachoDto.cs:
  119  							break;
  120: 						case UdpParameterId.SystemOdometer: // =1307 (SYSTEM_ODOMETER) - M6k Only Parameter
  121: 							trec.OdometerMeters = nVal;
  122: 							sLog = string.Format("SYSTEM_ODOMETER = {0}", nVal);
  123  							bStoreCurrRec = true;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.TDI\TdiMessageProcessor.cs:
  401  				heading, position.GpsPosition.SpeedMetresPerHour, position.GpsPosition.Latitude, position.GpsPosition.Longitude, (short)position.GpsPosition.Hdop,
  402: 				position.GpsPosition.NoOfSatellites, position.GpsPosition.GpsDateTimeUtc.DateTime, null, 0, null, driverId, null, true, leg, calculateOdo: true); 
  403  			

  440  		private Event GetBasicEvent(long eventId, RecordingTypes? recordingType,  DateTime eventDateTime, MobileUnitMapping mum, decimal? value,
  441: 			int? totalOccurances, int? totalTime, string extendedDriverId, decimal odometer = 0)
  442  		{
  443  			return EventFactory.GetBasicEvent(eventId, recordingType, mum.MobileUnitId, 
  444: 				eventDateTime, odometer, 0, eventDateTime.Get32bitSequenceNumber(), value,
  445  				totalOccurances.Value, totalTime.Value);

  448  		private ActiveEventDTO GetActiveEvent(Position position, DateTime eventDateTime, MobileUnitMapping mum, long eventId, double? value,
  449: 			string extendedDriverId, decimal odometer = 0, bool calibrate = true)
  450  		{

  463  				driverId, eventId, DateTime.UtcNow, eventDateTime, value,
  464: 				odometer, position.Speed, false, position, new LegacyIds(mum.LegacyVehicleId, null), null, calibrate);
  465  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Teltonika\IoElementCodes.cs:
   71  		/// Bytes 4
   72: 		/// Trip Odometer Value in meters
   73  		/// </summary>
   74: 		public static int TripOdometer = 199;
   75  		public static int iButton = 78; // TEL-13

  171  		public static int EngineRpmObd = 85;
  172: 		public static int OdometerTotal = 16;
  173: 		public static int OdometerObd = 389; // from dashboard
  174: 		public static int OdometerLvcan = 87; // from dashboard
  175: 		public static int OdometerLvcanCounted = 105; // from public device GPS
  176  		public static int EngineHoursIgnitionCounted = 449;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Teltonika\IoElementGroups.cs:
  32  
  33: 		internal static readonly IList<int> TripOdometerElements = new List<int>(4)
  34  		{
  35: 			IoElementCodes.OdometerTotal,
  36: 			IoElementCodes.OdometerObd,
  37: 			IoElementCodes.OdometerLvcan,
  38: 			IoElementCodes.OdometerLvcanCounted
  39  		};

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Teltonika\TeltonikaMessageProcessor.cs:
   494  			{
   495: 				long? startOdometer = GetCurrentTripValueForFirstElement(avl, IoElementGroups.TripOdometerElements, mud.MobileUnitId);
   496  				long? startEngineSeconds = GetCurrentTripValueForFirstElement(avl, IoElementGroups.TripEngineSecondsElements, mud.MobileUnitId);

   503  				// SR-13998
   504: 				Trip trip = TripProcessing.ProcessTripStart(mud.MobileUnitId, mud.OrganisationId, avl.DeviceDateTime, startEngineSeconds, startOdometer, driverId, position, 
   505  					out bool duplicate, out bool oldData);

   525  
   526: 				var odoState = DependencyRegistry.GetInstance<IOdometerState>(true);
   527  
   528: 				if(startOdometer.HasValue)
   529  				{
   530: 					odoState.CheckIfOdoOffsetRecalculationIsNeeded(mud.MobileUnitId, startOdometer.Value);
   531: 					odoState.SetUnitRawOdometer(mud.MobileUnitId, startOdometer.Value);
   532: 					odoState.SetAssetSubTripStartOdometer(mud.MobileUnitId, startOdometer.Value);
   533  				}

   536  					//SR-11941
   537: 					odoState.ForceNewOdoSetToLastDisplayOdo(mud.MobileUnitId);
   538  				}

   549  
   550: 				long? endOdometer = GetCurrentTripValueForFirstElement(avl, IoElementGroups.TripOdometerElements, mud.MobileUnitId);
   551  				long? endEngineSeconds = GetCurrentTripValueForFirstElement(avl, IoElementGroups.TripEngineSecondsElements, mud.MobileUnitId);

   558  				// SR-13998
   559: 				Trip trip = TripProcessing.ProcessTripEnd(mud.MobileUnitId, mud.OrganisationId, avl.DeviceDateTime, endEngineSeconds, endOdometer, driverId, position, out bool duplicate, out bool oldData);
   560  				

   958  				{
   959: 					faultCodes = (string)element.Deserialize(element.VariableData, 0); // TODO: find out from Comms if this is correct
   960  				}

  1044  				{
  1045: 					originalValue = (string)element.Deserialize(element.VariableData, 0); // TODO: find out from Comms if this is correct
  1046  				}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Teltonika\TripFidelity\TeltonikaPositionTranslator.cs:
  28  
  29: 					CalculateOdometer = true,
  30  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Teltonika\TripFidelity\TripFidelity.cs:
  332  					false,
  333: 					calculateOdo: true);
  334  				}

  356  					false,
  357: 					calculateOdo: true);
  358  				}

  365  					TripStartTime = tripStartMessage.DeviceDateTime,
  366: 					CalculateOdometer = true,
  367  					MobileUnitId = mum.MobileUnitId,

  370  					PulseIsFuel = false,
  371: 					AdjustOdometer = true,
  372  					TripEndTime = tripEndMessage.DeviceDateTime,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.Teltonika.UnitTests\CommandResponseTest.cs:
   55  			Mock<IDriverState> driverStateMock = new Mock<IDriverState>();
   56: 			Mock<IOdometerState> odometerStateMock = new Mock<IOdometerState>();
   57  			Mock<IPreProcessor> processorMock = new Mock<IPreProcessor>();

   65  			DependencyRegistry.Register<IDeviceStateRepository>(() => deviceStateMock.Object);
   66: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
   67  			DependencyRegistry.Register<IDriverIdStateManager>(() => driverIdStateMock.Object);

   98  
   99: 			odometerStateMock
  100: 				.Setup(x => x.GetOdometerOffset(It.IsAny<long>()))
  101  				.Returns(0);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageBackup\MessageBackupService.cs:
  144  
  145: 			// todo: this needs to send a normal message, not an error
  146  			//"30 second timeout elapsed. Service is resuming its reading of messages from the queue");

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\DeserializeMiX2000Messages.cs:
   352  						}
   353: 					case UdpParameterId.SystemOdometer:
   354  						{
   355: 							fmae.SystemOdometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   356: 							fmae.FmActiveEventParameterFlags |= FmActiveEventParameterFlags.SystemOdometer;
   357  							break;

   422  						}
   423: 					case UdpParameterId.SystemOdometer:
   424  						{
   425: 							cem.SystemOdometer = MessageSerializer.Deserialize<uint>(p.Value);
   426: 							cem.FmConfigEventParameterFlags |= FmConfigEventParameterFlags.SystemOdometer;
   427  							break;

   615  						}
   616: 					case UdpParameterId.Odometer:
   617  						{
   618: 							stm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   619  							break;

   921  						}
   922: 					case UdpParameterId.Odometer:
   923  						{
   924: 							arm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   925: 							arm.ActionReplyParameterFlags |= ActionReplyParameterFlags.Odometer;
   926  							break;
   927  						}
   928: 					case UdpParameterId.SystemOdometer:
   929  						{
   930: 							arm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   931: 							arm.ActionReplyParameterFlags |= ActionReplyParameterFlags.Odometer;
   932  							break;

  1318  						}
  1319: 					case UdpParameterId.Odometer:
  1320  						{
  1321: 							avl.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
  1322: 							avl.AvlParameterFlags |= AvlParameterFlags.Odometer;
  1323  							break;
  1324  						}
  1325: 					case UdpParameterId.SystemOdometer:
  1326  						{
  1327: 							avl.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
  1328: 							avl.AvlParameterFlags |= AvlParameterFlags.Odometer;
  1329  							break;

  1394  			SystemValuesParameter systemValuesParameter = null;
  1395: 			uint odometer = 0;
  1396  			InternalBatteryStateParameter internalBatteryStateParameter = null;

  1437  						}
  1438: 					case UdpParameterId.Odometer:
  1439  						{
  1440: 							odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
  1441  							break;
  1442  						}
  1443: 					case UdpParameterId.SystemOdometer:
  1444  						{
  1445: 							odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
  1446  							break;

  1504  			systemValuesParameter,
  1505: 			odometer,
  1506  			internalBatteryStateParameter,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\DeserializeMiX6000Messages.cs:
   596  						}
   597: 					case UdpParameterId.Odometer:
   598  						{
   599: 							arm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   600: 							arm.ActionReplyParameterFlags |= ActionReplyParameterFlags.Odometer;
   601  							break;
   602  						}
   603: 					case UdpParameterId.SystemOdometer:
   604  						{
   605: 							arm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   606: 							arm.ActionReplyParameterFlags |= ActionReplyParameterFlags.Odometer;
   607  							break;

   693  						}
   694: 					case UdpParameterId.Odometer:
   695  						{
   696: 							avl.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   697: 							avl.AvlParameterFlags |= AvlParameterFlags.Odometer;
   698  							break;
   699  						}
   700: 					case UdpParameterId.SystemOdometer:
   701  						{
   702: 							avl.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   703: 							avl.AvlParameterFlags |= AvlParameterFlags.Odometer;
   704  							break;

   768  			SystemValuesParameter systemValuesParameter = null;
   769: 			uint odometer = 0;
   770  			InternalBatteryStateParameter internalBatteryStateParameter = null;

   811  						}
   812: 					case UdpParameterId.Odometer:
   813  						{
   814: 							odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   815  							break;
   816  						}
   817: 					case UdpParameterId.SystemOdometer:
   818  						{
   819: 							odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   820  							break;

   878  			systemValuesParameter,
   879: 			odometer,
   880  			internalBatteryStateParameter,

  1008  						}
  1009: 					case UdpParameterId.SystemOdometer:
  1010  						{
  1011: 							fmae.SystemOdometer = MessageSerializer.Deserialize<uint>(parameter.Value);
  1012: 							fmae.FmActiveEventParameterFlags |= FmActiveEventParameterFlags.SystemOdometer;
  1013  							break;

  1078  						}
  1079: 					case UdpParameterId.SystemOdometer:
  1080  						{
  1081: 							cem.SystemOdometer = MessageSerializer.Deserialize<uint>(p.Value);
  1082: 							cem.FmConfigEventParameterFlags |= FmConfigEventParameterFlags.SystemOdometer;
  1083  							break;

  1506  						}
  1507: 					case UdpParameterId.Odometer:
  1508  						{
  1509: 							stm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
  1510  							break;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\MessageFilterForm.cs:
  51  				string s = ptype.ToString();
  52: 				if (!s.Contains("FmConfig") && !s.Contains("TripStart") && !s.Contains("TripEnd")) // excluding trip start/end to prevent odo offset recalculations
  53  					MsgFilterList.Add(s);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\ProcessTachoData.cs:
  127  							break;
  128: 						case UdpParameterId.SystemOdometer: // =1307 (SYSTEM_ODOMETER) - M6k Only Parameter
  129: 							trec.OdometerMeters = nVal;
  130: 							sLog = string.Format("SYSTEM_ODOMETER = {0}", nVal);
  131  							bStoreCurrRec = true;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\Conversions\M6KM4KM2K.cs:
   320  						}
   321: 					case UdpParameterId.Odometer:
   322  						{
   323: 							arm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   324: 							arm.ActionReplyParameterFlags |= ActionReplyParameterFlags.Odometer;
   325  							break;
   326  						}
   327: 					case UdpParameterId.SystemOdometer:
   328  						{
   329: 							arm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   330: 							arm.ActionReplyParameterFlags |= ActionReplyParameterFlags.Odometer;
   331  							break;

   717  						}
   718: 					case UdpParameterId.Odometer:
   719  						{
   720: 							avl.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   721: 							avl.AvlParameterFlags |= AvlParameterFlags.Odometer;
   722  							break;
   723  						}
   724: 					case UdpParameterId.SystemOdometer:
   725  						{
   726: 							avl.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   727: 							avl.AvlParameterFlags |= AvlParameterFlags.Odometer;
   728  							break;

   827  						}
   828: 					case UdpParameterId.Odometer:
   829  						{
   830: 							cbm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   831  							break;
   832  						}
   833: 					case UdpParameterId.SystemOdometer:
   834  						{
   835: 							cbm.Odometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   836  							break;

   987  						}
   988: 					case UdpParameterId.SystemOdometer:
   989  						{
   990: 							fmae.SystemOdometer = MessageSerializer.Deserialize<uint>(parameter.Value);
   991: 							fmae.FmActiveEventParameterFlags |= FmActiveEventParameterFlags.SystemOdometer;
   992  							break;

  1057  						}
  1058: 					case UdpParameterId.SystemOdometer:
  1059  						{
  1060: 							cem.SystemOdometer = MessageSerializer.Deserialize<uint>(p.Value);
  1061: 							cem.FmConfigEventParameterFlags |= FmConfigEventParameterFlags.SystemOdometer;
  1062  							break;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\IO\DatabaseIO.cs:
  671  									Value / 256 as TN, Value % 256 as sTN,
  672: 									CAST(DriverId AS VARCHAR(25)), EventSequenceNumber, ActionSequenceNumber, Value, Odometer, 
  673  									TotalTime, TotalOccurs, PositionId, EventType, StagingComplete, GenericValues

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\Utilities\ConfigEventUtilities.cs:
   57  						{
   58: 							case 0: return "GOS Odo & Time since stopped";
   59  							case 1: return "Sub Trip End - Trip Number";

  426  			{ 24, new ElementInfo() { ElementDescription = "Speed", ElementId = 24}},
  427: 			{ 199, new ElementInfo() { ElementDescription = "TripOdometer", ElementId = 199}},
  428: 			{ 16, new ElementInfo() { ElementDescription = "TotalOdometer", ElementId = 16}},
  429  			{ 78, new ElementInfo() { ElementDescription = "iButton", ElementId = 78}},

  461  			{ 85, new ElementInfo() { ElementDescription = "EngineRpmObd", ElementId = 85}},
  462: 			{ 389, new ElementInfo() { ElementDescription = "OdometerObd", ElementId = 389}},
  463: 			{ 87, new ElementInfo() { ElementDescription = "OdometerLvcan", ElementId = 87}},
  464: 			{ 105, new ElementInfo() { ElementDescription = "OdometerLvcanCounted", ElementId = 105}},
  465  			{ 449, new ElementInfo() { ElementDescription = "EngineHoursIgnitionCounted", ElementId = 449}},

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\Utilities\TypeConverters.cs:
   74  				other = $"Type5Code {fm.FmEventHeader.Type5Code}, ActSeq# {fm.FmEventHeader.EventActionSequenceNumber}, Value {fm.FmEventValue.EventValue}, Occurrances {fm.FmEventOccurrences}, TrueTime {fm.FmEventTrueTime}, " +
   75: 					$"Odo {fm.SystemOdometer}";
   76  			}

   79  				descr = ConfigEventUtilities.GetActiveEventName(fma, eventDescriptions);
   80: 				other = $"Type5Code {fma.FmEventType5Code}, Value {fma.GenericValue}, Odo {fma.SystemOdometer}";
   81  			}

   85  				{
   86: 					other = $"GpsTime {avl.GpsData.DeviceDateTime.ToString(dateFormat)}, Speed {avl.GpsData.SpeedMetresPerHour}, DriverId {avl.DriverId.DriverId}, DriverIdShort {((short)avl.DriverId.DriverId)}, DriverIdType {avl.DriverId.DriverIdType.ToString()}, Odo {avl.Odometer}, GpsFix {avl.GpsData.GpsFixStatus}, " +
   87  						$"FW Version {avl.FirmwareVersion.Major}.{avl.FirmwareVersion.Value}.{avl.FirmwareVersion.Value}";

   90  				{
   91: 					other = $"GpsTime {avl.GpsData.DeviceDateTime.ToString(dateFormat)}, Speed {avl.GpsData.SpeedMetresPerHour}, DriverId NULL, Odo {avl.Odometer}, GpsFix {avl.GpsData.GpsFixStatus}, " +
   92  						$"FW Version {avl.FirmwareVersion.Major}.{avl.FirmwareVersion.Value}.{avl.FirmwareVersion.Value}";

  113  				{
  114: 					other = $"EndOdo {tem.TripEndData.OdometerInMetres}, Distance {tem.TripEndData.DistanceInMetres}, Duration {tem.TripEndData.DurationInSeconds}";
  115  				}

  117  				{
  118: 					other = $"DriverId {(short)tem.DriverId.DriverId}, DriverType {tem.DriverId.DriverIdType}, EndOdo {tem.TripEndData.OdometerInMetres}, Distance {tem.TripEndData.DistanceInMetres}, Duration {tem.TripEndData.DurationInSeconds}";
  119  				}

  126  			{
  127: 				other = $"StartOdo {tsm.TripStartData.OdometerInMetres}";
  128  			}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\Utilities\TeltonikaConversion\TeltonikaDataSetCreator.cs:
  123  
  124: 			// ODOMETER
  125: 			result.Columns.Add(GetDataColumn(IoElementCodes.OdometerObd));
  126: 			result.Columns.Add(GetDataColumn(IoElementCodes.OdometerLvcan));
  127: 			result.Columns.Add(GetDataColumn(IoElementCodes.OdometerLvcanCounted));
  128: 			result.Columns.Add(GetDataColumn(IoElementCodes.OdometerTotal));
  129: 			result.Columns.Add(GetDataColumn(IoElementCodes.TripOdometer));
  130  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\Utilities\TeltonikaConversion\TeltonikaElementIdAndNames.cs:
   29  			{ 15,	"Eco Score"},
   30: 			{ 16,	"Total Odometer"},
   31  			{ 17,	"Axis X"},

  209  			{ 198,	"Geofence zone 32"},
  210: 			{ 199,	"Trip Odometer"},
  211  			{ 200,	"Sleep Mode"},

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Outgoing.HOS\HosService.cs:
  233  					IsActiveEvent = true,
  234: 					OdometerKilometres = o.Odometer.HasValue ? o.Odometer.Value / 1000 : 0,
  235  					OrganisationGroupId = o.OrgId,

  265  					IsActiveEvent = true,
  266: 					OdometerKilometres = o.Odometer.HasValue ? o.Odometer.Value / 1000 : 0,
  267  					OrganisationGroupId = o.OrgId,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Outgoing.Lightning\OutgoingLightningService.cs:
  249  				
  250: 				DependencyRegistry.Register<IOdometerState>(() => new OdometerState(stateRepository, mobileUnitStateCache, CacheFactory.GetNewVolatileCache()));
  251  				

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Outgoing.Lightning\DTOConvertors\events.cs:
   72  
   73: 			if(evtReceived.EndOdometer.HasValue)
   74  			{
   75: 				evnt.EndOdometerKilometres = (float)System.Decimal.Round((decimal)evtReceived.EndOdometer / (decimal)1000.0, 1, System.MidpointRounding.AwayFromZero);
   76  
   77: 				evnt.OtherData[MiX.ResourceData.Entities.Event.OtherDataKeys.EndOdometer] = System.Decimal.Round((decimal)evtReceived.EndOdometer/ (decimal)1000.0, 1, System.MidpointRounding.AwayFromZero).ToString();
   78  			}
   79  
   80: 			if(evtReceived.StartOdometer.HasValue)
   81  			{
   82: 				evnt.StartOdometerKilometres = (float)System.Decimal.Round((decimal)evtReceived.StartOdometer / (decimal)1000.0, 1, System.MidpointRounding.AwayFromZero);
   83  
   84: 				evnt.OtherData[MiX.ResourceData.Entities.Event.OtherDataKeys.StartOdometer] = System.Decimal.Round((decimal)evtReceived.StartOdometer / (decimal)1000.0, 1, System.MidpointRounding.AwayFromZero).ToString();
   85  			}

  246  
  247: 			if (evtReceived.Odometer > 0M)
  248  			{
  249: 				evnt.StartOdometerKilometres = (float)(evtReceived.Odometer / 1000);
  250  			}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Outgoing.Lightning\DTOConvertors\LoggableData.cs:
  35  
  36: 				loggableDataEvent.StartOdometerKilometres = (float)System.Decimal.Round((decimal)evtReceived.Odometer / (decimal)1000.0, 1, System.MidpointRounding.AwayFromZero);
  37  

  39  
  40: 				loggableDataEvent.OtherData[MiX.ResourceData.Entities.Event.OtherDataKeys.StartOdometer] = System.Decimal.Round((decimal)evtReceived.Odometer / (decimal)1000.0, 1, System.MidpointRounding.AwayFromZero).ToString();
  41  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Outgoing.Lightning\DTOConvertors\Positions.cs:
  52  				NumberOfSatellites = disPosition.NumberOfSatellites,
  53: 				OdometerKilometres = disPosition.Odometer.HasValue ? (float?)(disPosition.Odometer / 1000) : null,
  54  				Pdop = (byte?)disPosition.Pdop,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Outgoing.Lightning\DTOConvertors\Trips.cs:
   97  
   98: 			#region - Process odometer readings -
   99  			if (asset.MobileUnitType == MiX.Core.Entities.DevicesDomain.EntityTypeOrRole.MiX2000 ||

  103  			{
  104: 				if (subTrip.SubTripEnd.Odometer.HasValue && subTrip.SubTripEnd.Odometer > 0)
  105  				{
  106: 					lightningSubTrip.EndOdometerKilometres = subTrip.SubTripEnd.Odometer.HasValue ? subTrip.SubTripEnd.Odometer.Value / 1000 : 0;
  107  
  108: 					if (subTrip.SubTripStart.Odometer.HasValue)
  109  					{
  110: 						lightningSubTrip.StartOdometerKilometres = (subTrip.SubTripStart.Odometer.Value / 1000); // SR-11962
  111  					}

  113  					{
  114: 						lightningSubTrip.StartOdometerKilometres = subTrip.Odometer.HasValue ? (subTrip.Odometer.Value / 1000) - (subTrip.Distance.Value / 1000) : 0;
  115  					}

  118  				{
  119: 					decimal? lastOdo = null;
  120  					try
  121  					{
  122: 						lastOdo = DependencyRegistry.GetInstance<IOdometerState>(true).GetAssetLastDisplayOdometer(asset.MobileUnitId);
  123  					}

  128  
  129: 					if (lastOdo.HasValue)
  130  					{
  131: 						lightningSubTrip.StartOdometerKilometres = lastOdo.Value / 1000;
  132: 						lightningSubTrip.EndOdometerKilometres = (lastOdo.Value + subTrip.Distance.Value) / 1000;
  133  					}

  135  					{
  136: 						lightningSubTrip.StartOdometerKilometres = 0;
  137: 						lightningSubTrip.EndOdometerKilometres = subTrip.Distance.Value / 1000;
  138  					}

  142  			{
  143: 				lightningSubTrip.StartOdometerKilometres = subTrip.SubTripStart.Odometer.HasValue ? subTrip.SubTripStart.Odometer.Value / 1000 : 0;
  144: 				lightningSubTrip.EndOdometerKilometres = subTrip.SubTripEnd.Odometer.HasValue ? subTrip.SubTripEnd.Odometer.Value / 1000 : 0;
  145  			}

  308  				// Efficiency (kWh/km) = Total energy/ distance
  309: 				double efficiency = totalEnergy / (double)(lightningSubTrip.EndOdometerKilometres - lightningSubTrip.StartOdometerKilometres);
  310  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\ActiveEvents\300 MobileUnitStateUpdate.cs:
  22  				}
  23: 				else if (evnt.EventId == EventIds.DIS_TRIP_START_ODOMETER && evnt.Odometer.HasValue)
  24  				{
  25: 					DependencyRegistry.GetInstance<IOdometerState>(true).CheckIfOdoOffsetRecalculationIsNeeded(evnt.MobileUnitId, evnt.Odometer.Value);
  26  					evnt.ProceedWithProcessing = false;
  27  				}
  28: 				else if (evnt.EventId == EventIds.DIS_TRIP_END_ODOMETER && evnt.Odometer.HasValue)
  29  				{
  30: 					DependencyRegistry.GetInstance<IOdometerState>(true).SetRawOdometerFromTripEnd(evnt.MobileUnitId, evnt.Odometer.Value);
  31  					evnt.ProceedWithProcessing = false;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\ActiveEvents\500 AdjustOdometer.cs:
   8  {
   9: 	public class AdjustOdometerActive : IProcessing<ActiveEventDTO>
  10  	{
  11: 		public string Name => "Active Events: Apply odometer offset";
  12  

  14  		{
  15: 			if (evnt.Odometer >= 0 && evnt.AdjustOdometer)
  16  			{

  18  				{
  19: 					evnt.Odometer += DependencyRegistry.GetInstance<IOdometerState>(true).GetOdometerOffset(evnt.MobileUnitId);
  20  
  21: 					if (evnt.Position != null && evnt.Position.Odometer.HasValue)
  22  					{
  23: 						evnt.Position.Odometer += DependencyRegistry.GetInstance<IOdometerState>(true).GetOdometerOffset(evnt.MobileUnitId);
  24  					}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\ActiveEvents\700 ValueCalibration.cs:
  48  				// QA-5662 Always calibrate using LibraryParameterId
  49: 				evnt.Value = new OdometerUnwrapper().UnwrapEventValue(calibration.ParameterIDForEvent(evnt.EventId),
  50  																					calibration.GetEventValue(evnt.EventId, (uint)evnt.RawValue.Value));
  51  
  52: 				// QA-5662 Then apply odo or E/H offsets afterwards
  53  				IConfigAcceptedBuildContext cabc = deviceConfigRepo.GetConfigAcceptedBuildContext(evnt.MobileUnitId);

  62  					{
  63: 						if (bcEvent.ReturnParameter != null && bcEvent.ReturnParameter.ParameterId == Parameters.ODOMETER_READING)
  64  						{
  65: 							IOdometerState odometerState = DependencyRegistry.GetInstance<IOdometerState>(true);
  66  
  67  							// SR-7240
  68: 							decimal odometerOffset = odometerState.GetOdometerOffset(evnt.MobileUnitId); 
  69: 							if (odometerOffset != 0)
  70  							{

  72  								{
  73: 									evnt.Value += (double)(odometerOffset / 1000);
  74  								}

  76  								{
  77: 									evnt.Value += (double)odometerOffset;
  78  								}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\LoggableData\400 FuelData.cs:
  61  				ActionSequenceNumber = ActionSequenceNumbers.ROVI_Fuel_Cost,
  62: 				Odometer = (decimal)dto.Odometer,
  63  				DriverId = dto.DriverId,

  82  				ActionSequenceNumber = ActionSequenceNumbers.ROVI_Fuel_Volume,
  83: 				Odometer = (decimal)dto.Odometer,
  84  				DriverId = dto.DriverId,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\PassiveEvents\300 AdjustOdometer.cs:
   8  {
   9: 	public class AdjustOdometerPassiveEvents : IProcessing<PassiveEventDTO>
  10  	{
  11: 		public string Name => "Passive Events: Apply odometer offset";
  12  

  16  			{
  17: 				decimal odometerOffest = DependencyRegistry.GetInstance<IOdometerState>(true).GetOdometerOffset(dto.MobileUnitId);
  18  
  19: 				if(odometerOffest == 0)
  20  				{

  23  
  24: 				if (dto.StartOdometer.HasValue)
  25  				{
  26: 					dto.StartOdometer += odometerOffest;
  27  				}
  28  
  29: 				if (dto.StartPosition != null && dto.StartPosition.Odometer.HasValue)
  30  				{
  31: 					dto.StartPosition.Odometer += odometerOffest;
  32  				}
  33  
  34: 				if (dto.EndOdometer.HasValue)
  35  				{
  36: 					dto.EndOdometer += odometerOffest;
  37  				}
  38  
  39: 				if (dto.EndPosition != null && dto.EndPosition.Odometer.HasValue)
  40  				{
  41: 					dto.EndPosition.Odometer += odometerOffest;
  42  				}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\PassiveEvents\400 ValueCalibration.cs:
  45  				// QA-5662 Always calibrate using LibraryParameterId
  46: 				dto.Value = (decimal)(new OdometerUnwrapper().UnwrapEventValue(calibration.ParameterIDForEvent(dto.EventId),
  47  																								calibration.GetEventValue(dto.EventId, (uint)dto.RawValue.Value)));
  48  
  49: 				// QA-5662 Then apply odo or E/H offsets afterwards
  50  				IConfigAcceptedBuildContext cabc = deviceConfigRepo.GetConfigAcceptedBuildContext(dto.MobileUnitId);

  59  					{
  60: 						if (bcEvent.ReturnParameter != null && bcEvent.ReturnParameter.ParameterId == Parameters.ODOMETER_READING)
  61  						{
  62: 							IOdometerState odometerState = DependencyRegistry.GetInstance<IOdometerState>(true);
  63  
  64  							// SR-7240
  65: 							decimal odometerOffset = odometerState.GetOdometerOffset(dto.MobileUnitId); 
  66: 							if (odometerOffset != 0)
  67  							{

  69  								{
  70: 									dto.Value += (odometerOffset / 1000);
  71  								}

  73  								{
  74: 									dto.Value += odometerOffset;
  75  								}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\Positions\500 AdjustOdometer.cs:
   8  {
   9: 	public class AdjustOdometer : IProcessing<Position>
  10  	{
  11: 		public string Name => "Positions: Apply odometer offset";
  12  
  13: 		private readonly IOdometerState _odometerState;
  14  
  15: 		public AdjustOdometer()
  16  		{
  17: 			_odometerState = DependencyRegistry.GetInstance<IOdometerState>(true);
  18  		}

  21  		{
  22: 			if(pos.Odometer.HasValue && pos.Odometer != 0)
  23  			{

  25  				{
  26: 					pos.Odometer += _odometerState.GetOdometerOffset(pos.MobileUnitId);
  27  				}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\Positions\700 StorePosition.cs:
  27  
  28: 				if (pos.Stage && (pos.CalculateOdometer || !pos.IsAvl))
  29  				{

  32  
  33: 				if (pos.CalculateOdometer || pos.TripMode.HasValue)
  34  				{

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\Process\Processor.cs:
   57  				new ValidationPositions(_configClient, _fleetClient, _deviceConfigRepository),
   58: 				new AdjustOdometer(),
   59  				new StorePosition(cacheWhenStaging),

   70  					new ExtendedDriverIdActive(),
   71: 					new AdjustOdometerActive(),
   72  					new LegacyEventIds(),

  112  				new EngineSecondsOffsetCalculation(),
  113: 				new AdjustOdometerPassiveEvents(),
  114  				new ValueCalibrationPassiveEvents(),

  124  				new ValidationPassiveEvents(_configClient, _fleetClient),
  125: 				new AdjustOdometerPassiveEvents(),
  126  				new ValueCalibrationPassiveEvents(),

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing\Process\RegisterDependencies.cs:
  62  				coreSettings.GetString(DataCentreName),
  63: 				MiX.DeviceIntegration.Common.Constants.TeamNames.DI_DP));  // TODO: fix this (moving this setting to Alerts project setting)
  64  			

  94  			DependencyRegistry.Register<IActiveState>(() => new ActiveState(stateRepository));
  95: 			DependencyRegistry.Register<IOdometerState>(() => new OdometerState(stateRepository, mobileUnitStateCache, cache));
  96  			DependencyRegistry.Register<IMobileUnitState>(() => new MobileUnitState(stateRepository, mobileUnitStateCache, CacheFactory.GetNewVolatileCache()));

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing.UnitTests\Modules\TestHelper.cs:
   21  		public static long _driverId = -509933614468629805;
   22: 		public static decimal Odometer = 100000;
   23  		public static readonly List<long> CNILSpeedEventsToDiscard = new List<long>()

   88  			position.OriginalDriverId = _driverId;
   89: 			position.Odometer = Odometer;
   90  			position.Values = null;
   91  			position.ProceedWithProcessing = true;
   92: 			position.CalculateOdometer = false;
   93  			return position;

  122  			position.OriginalDriverId = _driverId;
  123: 			position.Odometer = Odometer;
  124  			position.Values = null;
  125  			position.ProceedWithProcessing = true;
  126: 			position.CalculateOdometer = false;
  127  

  156  
  157: 		public static Trip GetBasicTrip(bool proceedWithProcessing, bool calculateOdometer, bool addPositions)
  158  		{

  164  			trip.ProceedWithProcessing = proceedWithProcessing;
  165: 			trip.CalculateOdometer = calculateOdometer;
  166  

  208  					{
  209: 						eventId, new RecordingActionHelper("<settings recordType=\"3\" startOdometer=\"1\" endOdometer=\"0\" startPosition=\"0\" endPosition=\"0\" video=\"0\" pulse=\"0\"/>")
  210  					}

  218  					{
  219: 						eventId, new RecordingActionHelper("<settings recordType=\"2\" startOdometer=\"0\" endOdometer=\"0\" startPosition=\"0\" endPosition=\"0\" video=\"0\" pulse=\"0\"/>")
  220  					}

  228  					{
  229: 						eventId, new RecordingActionHelper("<settings recordType=\"1\" startOdometer=\"1\" endOdometer=\"1\" startPosition=\"0\" endPosition=\"0\" video=\"0\" pulse=\"1\"/>")
  230  					}

  243  			start.EventSequenceNumber = 123;
  244: 			start.Odometer = 50;
  245  

  258  			end.Value = 7;
  259: 			end.Odometer = 60;
  260  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing.UnitTests\Modules\ActiveEvents\AdjustOdometer.cs:
   8  {
   9: 	public class ActiveEventAdjustOdometerTests
  10  	{

  13  		{
  14: 			var odometerstateMock = new Mock<IOdometerState>(MockBehavior.Strict);
  15  
  16: 			odometerstateMock.Setup(o => o.GetOdometerOffset(TestHelper._assetId)).Returns(0);
  17  

  19  
  20: 			DependencyRegistry.Register<IOdometerState>(() => odometerstateMock.Object);
  21  
  22  			ActiveEventDTO dto = TestHelper.GetBasicActiveEventDTO(5);
  23: 			dto.AdjustOdometer = true;
  24: 			dto.Odometer = TestHelper.Odometer;
  25  			dto.Position = TestHelper.GetBasicPosition(false);

  27  
  28: 			AdjustOdometerActive module = new AdjustOdometerActive();
  29  			module.Process(dto);

  32  
  33: 			Assert.IsTrue(dto.Odometer.Value == TestHelper.Odometer);
  34: 			Assert.IsTrue(dto.Position.Odometer.Value == TestHelper.Odometer);
  35  
  36: 			odometerstateMock.VerifyAll();
  37  		}

  43  
  44: 			var odometerstateMock = new Mock<IOdometerState>(MockBehavior.Strict);
  45  
  46: 			odometerstateMock.Setup(o => o.GetOdometerOffset(TestHelper._assetId)).Returns(offset);
  47  

  49  
  50: 			DependencyRegistry.Register<IOdometerState>(() => odometerstateMock.Object);
  51  
  52: 			decimal result = TestHelper.Odometer + offset;
  53  
  54  			ActiveEventDTO dto = TestHelper.GetBasicActiveEventDTO(5);
  55: 			dto.AdjustOdometer = true;
  56: 			dto.Odometer = TestHelper.Odometer;
  57  			dto.Position = TestHelper.GetBasicPosition(false);

  59  
  60: 			AdjustOdometerActive module = new AdjustOdometerActive();
  61  			module.Process(dto);

  64  
  65: 			Assert.IsTrue(dto.Odometer.Value == result);
  66: 			Assert.IsTrue(dto.Position.Odometer.Value == result);
  67  
  68: 			odometerstateMock.VerifyAll();
  69  		}

  73  		{
  74: 			var odometerstateMock = new Mock<IOdometerState>(MockBehavior.Strict);
  75  

  77  
  78: 			DependencyRegistry.Register<IOdometerState>(() => odometerstateMock.Object);
  79  
  80  			ActiveEventDTO dto = TestHelper.GetBasicActiveEventDTO(5);
  81: 			dto.AdjustOdometer = false;					// flag
  82: 			dto.Odometer = TestHelper.Odometer;
  83  			dto.Position = TestHelper.GetBasicPosition(false);

  85  
  86: 			AdjustOdometerActive module = new AdjustOdometerActive();
  87  			module.Process(dto);

  90  
  91: 			Assert.IsTrue(dto.Odometer.Value == TestHelper.Odometer);
  92: 			Assert.IsTrue(dto.Position.Odometer.Value == TestHelper.Odometer);
  93  
  94: 			odometerstateMock.VerifyAll();
  95  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing.UnitTests\Modules\ActiveEvents\MobileUnitStateUpdate.cs:
   27  		{
   28: 			Mock<IOdometerState> odometerStateMock = new Mock<IOdometerState>();
   29  			Mock<IEngineHoursState> engineHoursStateMock = new Mock<IEngineHoursState>();

   32  			DependencyRegistry.ClearRegistry();
   33: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
   34  			DependencyRegistry.Register<IEngineHoursState>(() => engineHoursStateMock.Object);

   45  			engineHoursStateMock.Verify();
   46: 			odometerStateMock.Verify();
   47  			ignitionStateMock.Verify();

   50  		[Test, Category("CICDTests")]
   51: 		public void MobileUnitStateUpdate_Case_EventId_DIS_TRIP_START_ODOMETER_execute_CheckIfOdoOffsetRecalculationIsNeeded()
   52  		{
   53: 			Mock<IOdometerState> odometerStateMock = new Mock<IOdometerState>(MockBehavior.Strict);
   54  			Mock<IEngineHoursState> engineHoursStateMock = new Mock<IEngineHoursState>();

   57  			DependencyRegistry.ClearRegistry();
   58: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
   59  			DependencyRegistry.Register<IEngineHoursState>(() => engineHoursStateMock.Object);

   61  
   62: 			testEvent.EventId = EventIds.DIS_TRIP_START_ODOMETER;
   63: 			testEvent.Odometer = 0;
   64: 			odometerStateMock.Setup(x => x.CheckIfOdoOffsetRecalculationIsNeeded(testEvent.MobileUnitId, testEvent.Odometer.Value));
   65  

   69  			engineHoursStateMock.Verify();
   70: 			odometerStateMock.Verify();
   71  			ignitionStateMock.Verify();

   74  		[Test, Category("CICDTests")]
   75: 		public void MobileUnitStateUpdate_Case_EventId_DIS_TRIP_END_ODOMETER_execute_SetMobileUnitRawOdometerFromTripEnd()
   76  		{
   77: 			Mock<IOdometerState> odometerStateMock = new Mock<IOdometerState>(MockBehavior.Strict);
   78  			Mock<IEngineHoursState> engineHoursStateMock = new Mock<IEngineHoursState>();

   81  			DependencyRegistry.ClearRegistry();
   82: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
   83  			DependencyRegistry.Register<IEngineHoursState>(() => engineHoursStateMock.Object);

   85  
   86: 			testEvent.EventId = EventIds.DIS_TRIP_END_ODOMETER;
   87: 			testEvent.Odometer = 0;
   88: 			odometerStateMock.Setup(x => x.SetRawOdometerFromTripEnd(testEvent.MobileUnitId, testEvent.Odometer.Value));
   89  

   93  			engineHoursStateMock.Verify();
   94: 			odometerStateMock.Verify();
   95  			ignitionStateMock.Verify();

  100  		{
  101: 			Mock<IOdometerState> odometerStateMock = new Mock<IOdometerState>();
  102  			Mock<IEngineHoursState> engineHoursStateMock = new Mock<IEngineHoursState>(MockBehavior.Strict);

  105  			DependencyRegistry.ClearRegistry();
  106: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
  107  			DependencyRegistry.Register<IEngineHoursState>(() => engineHoursStateMock.Object);

  117  			engineHoursStateMock.Verify();
  118: 			odometerStateMock.Verify();
  119  			ignitionStateMock.Verify();

  122  		[Test, Category("CICDTests")]
  123: 		public void MobileUnitStateUpdate_Case_EventId_DIS_TRIP_END_ENGINESECONDS_execute_SetMobileUnitRawOdometerFromTripEnd()
  124  		{
  125: 			Mock<IOdometerState> odometerStateMock = new Mock<IOdometerState>();
  126  			Mock<IEngineHoursState> engineHoursStateMock = new Mock<IEngineHoursState>(MockBehavior.Strict);

  129  			DependencyRegistry.ClearRegistry();
  130: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
  131  			DependencyRegistry.Register<IEngineHoursState>(() => engineHoursStateMock.Object);

  141  			engineHoursStateMock.Verify();
  142: 			odometerStateMock.Verify();
  143  			ignitionStateMock.Verify();

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing.UnitTests\Modules\ActiveEvents\ValueCalibrationTest.cs:
   68  
   69: 		[Test, Category("CICDTests"), Description("If the build context has a parameter ID of ODOMETER_READING the odometer" + 
   70  																							"offset should be applied to the value. If the build context event's build " +
   71: 																							"context parameter is set to DistanceMeters, the odometer offset should remain in default meters.")]
   72: 		public void Calibrate_Return_Parameter_Odo_Meters()
   73  		{

   81  			var buildContextEventMock = new Mock<IBuildContextEvent>(MockBehavior.Strict);
   82: 			var odometerStateMock = new Mock<IOdometerState>(MockBehavior.Strict);
   83  

   86  
   87: 			eventParametersMock.Setup(cal => cal.ParameterIDForEvent(It.IsAny<long>())).Returns(Parameters.ODOMETER_READING);
   88  			eventParametersMock.Setup(cal => cal.GetEventValue(It.IsAny<long>(), It.IsAny<uint>())).Returns(dto.RawValue ?? 0.0);

   92  			var buildContextParameter = new BuildContextParameter();
   93: 			buildContextParameter.ParameterId = Parameters.ODOMETER_READING;
   94  			buildContextParameter.ValueFormat = (byte)MiX.DeviceIntegration.DataProcessing.DataAccess.Entities.ValueFormatType.DistanceMeters;

   96  
   97: 			odometerStateMock.Setup(odo => odo.GetOdometerOffset(It.IsAny<long>())).Returns(500); // offset is 500 meters
   98  

  100  			DependencyRegistry.Register<IDeviceConfigRepository>(() => deviceConfigRepository.Object);
  101: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
  102  

  105  			Assert.IsTrue(dto.ProceedWithProcessing, "Should proceed with processing");
  106: 			odometerStateMock.Verify(odo => odo.GetOdometerOffset(It.IsAny<long>()), Times.Once(), "The odometer offset should be called once.");
  107  			Assert.IsTrue(dto.Value == 5500, "Value + Offset should be as expected"); // value + offset = 5500 meters

  113  
  114: 		[Test, Category("CICDTests"), Description("If the build context has a parameter ID of ODOMETER_READING the odometer" + 
  115  																							"offset should be applied to the value. If the build context event's build " +
  116: 																							"context parameter is set to DistanceKilometers, the odometer offset should be " + 
  117  																							"converted from default meters to kilometers.")]
  118: 		public void Calibrate_Return_Parameter_Odo_Kilometers()
  119  		{

  127  			var buildContextEventMock = new Mock<IBuildContextEvent>(MockBehavior.Strict);
  128: 			var odometerStateMock = new Mock<IOdometerState>(MockBehavior.Strict);
  129  

  132  
  133: 			eventParametersMock.Setup(cal => cal.ParameterIDForEvent(It.IsAny<long>())).Returns(Parameters.ODOMETER_READING);
  134  			eventParametersMock.Setup(cal => cal.GetEventValue(It.IsAny<long>(), It.IsAny<uint>())).Returns(dto.RawValue ?? 0.0);

  138  			var buildContextParameter = new BuildContextParameter();
  139: 			buildContextParameter.ParameterId = Parameters.ODOMETER_READING;
  140  			buildContextParameter.ValueFormat = (byte)MiX.DeviceIntegration.DataProcessing.DataAccess.Entities.ValueFormatType.DistanceKilometers;

  142  
  143: 			odometerStateMock.Setup(odo => odo.GetOdometerOffset(It.IsAny<long>())).Returns(500); // offset is 500 meters
  144  

  146  			DependencyRegistry.Register<IDeviceConfigRepository>(() => deviceConfigRepositoryMock.Object);
  147: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
  148  

  151  			Assert.IsTrue(dto.ProceedWithProcessing, "Should proceed with processing");
  152: 			odometerStateMock.Verify(odo => odo.GetOdometerOffset(It.IsAny<long>()), Times.Once(), "The odometer offset should be called once.");
  153  			Assert.IsTrue(dto.Value == 5.5, "Value + Offset should be as expected"); // value + offset = 5.5 kilometers;

  196  			Assert.IsTrue(dto.ProceedWithProcessing, "Should proceed with processing");
  197: 			engineHoursStateMock.Verify(odo => odo.GetEngineSecondsOffset(It.IsAny<long>()), Times.Once(), "The engine seconds offset should be called once.");
  198  			Assert.IsTrue(dto.Value == 2); // value + offset = 1 + 1 = 2 hours

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing.UnitTests\Modules\PassiveEvents\AdjustOdometer.cs:
  10  {
  11: 	public class PassiveEventAdjustOdometerTests
  12  	{

  15  		{
  16: 			var odometerstateMock = new Mock<IOdometerState>(MockBehavior.Strict);
  17  
  18: 			odometerstateMock.Setup(o => o.GetOdometerOffset(TestHelper._assetId)).Returns(0);
  19  

  27  
  28: 			DependencyRegistry.Register<IOdometerState>(() => odometerstateMock.Object);
  29  			DependencyRegistry.Register(() => queueWriterMock.Object, "MonitoringQueueWriter");

  31  			PassiveEventDTO dto = TestHelper.GetBasicPassiveEventDTO(5);
  32: 			dto.StartOdometer = TestHelper.Odometer;
  33: 			dto.EndOdometer = TestHelper.Odometer;
  34  			dto.StartPosition = TestHelper.GetBasicPosition(false);

  37  
  38: 			AdjustOdometerPassiveEvents module = new AdjustOdometerPassiveEvents();
  39  			module.Process(dto);

  42  
  43: 			Assert.IsTrue(dto.StartOdometer.Value == TestHelper.Odometer);
  44: 			Assert.IsTrue(dto.EndOdometer.Value == TestHelper.Odometer);
  45: 			Assert.IsTrue(dto.StartPosition.Odometer.Value == TestHelper.Odometer);
  46: 			Assert.IsTrue(dto.EndPosition.Odometer.Value == TestHelper.Odometer);
  47  
  48: 			odometerstateMock.VerifyAll();
  49  		}

  55  
  56: 			var odometerstateMock = new Mock<IOdometerState>(MockBehavior.Strict);
  57  
  58: 			odometerstateMock.Setup(o => o.GetOdometerOffset(TestHelper._assetId)).Returns(offset);
  59  

  67  
  68: 			DependencyRegistry.Register<IOdometerState>(() => odometerstateMock.Object);
  69  			DependencyRegistry.Register(() => queueWriterMock.Object, "MonitoringQueueWriter");
  70  
  71: 			decimal result = TestHelper.Odometer + offset;
  72  
  73  			PassiveEventDTO dto = TestHelper.GetBasicPassiveEventDTO(5);
  74: 			dto.StartOdometer = TestHelper.Odometer;
  75: 			dto.EndOdometer = TestHelper.Odometer;
  76  			dto.StartPosition = TestHelper.GetBasicPosition(false);

  79  
  80: 			AdjustOdometerPassiveEvents module = new AdjustOdometerPassiveEvents();
  81  			module.Process(dto);

  84  
  85: 			Assert.IsTrue(dto.StartOdometer.Value == result);
  86: 			Assert.IsTrue(dto.EndOdometer.Value == result);
  87: 			Assert.IsTrue(dto.StartPosition.Odometer.Value == result);
  88: 			Assert.IsTrue(dto.EndPosition.Odometer.Value == result);
  89  
  90: 			odometerstateMock.VerifyAll();
  91  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.PreProcessing.UnitTests\Modules\PassiveEvents\ValueCalibrationTest.cs:
   20  		Mock<IBuildContextEvent> buildContextEventMock;
   21: 		Mock<IOdometerState> odometerStateMock;
   22  		Mock<IEngineHoursState> engineHoursStateMock;

   36  			buildContextEventMock = new Mock<IBuildContextEvent>(MockBehavior.Strict);
   37: 			odometerStateMock = new Mock<IOdometerState>(MockBehavior.Strict);
   38  			engineHoursStateMock = new Mock<IEngineHoursState>(MockBehavior.Strict);

   41  			DependencyRegistry.Register<IEngineHoursState>(() => engineHoursStateMock.Object);
   42: 			DependencyRegistry.Register<IOdometerState>(() => odometerStateMock.Object);
   43  		}

   80  		[Test, Category("CICDTests")] 
   81: 		[Description(@"If the build context has a parameter ID of ODOMETER_READING the odometer offset should be applied to 
   82: 									 the value. If the build context event's build context parameter is set to DistanceMeters, the odometer 
   83  									 offset should remain in default meters.")]
   84: 		public void CalibrateReturnParameterOdoMeters()
   85  		{

   93  
   94: 			eventParametersMock.Setup(cal => cal.ParameterIDForEvent(It.IsAny<long>())).Returns(Parameters.ODOMETER_READING);
   95  			eventParametersMock.Setup(cal => cal.GetEventValue(It.IsAny<long>(), It.IsAny<uint>())).Returns((double)dto.RawValue);

   99  			var buildContextParameter = new BuildContextParameter();
  100: 			buildContextParameter.ParameterId = Parameters.ODOMETER_READING;
  101  			buildContextParameter.ValueFormat = (byte)MiX.DeviceIntegration.DataProcessing.DataAccess.Entities.ValueFormatType.DistanceMeters;

  103  
  104: 			decimal odometerOffsetInMeters = 500m;
  105: 			odometerStateMock.Setup(odo => odo.GetOdometerOffset(It.IsAny<long>())).Returns(odometerOffsetInMeters);
  106  

  110  			Assert.IsTrue(dto.ProceedWithProcessing, "Should always proceed with processing");
  111: 			odometerStateMock.Verify(odo => odo.GetOdometerOffset(It.IsAny<long>()), Times.Once(), "The odometer offset should be called once.");
  112  
  113: 			Assert.IsTrue(dto.Value == uncalibratedValueInMeters + odometerOffsetInMeters, "Value + Offset should be as expected"); // value + offset = 5500 meters
  114  		}

  116  		[Test, Category("CICDTests")] 
  117: 		[Description(@"If the build context has a parameter ID of ODOMETER_READING the odometer offset should be applied to 
  118  									 the value. If the build context event's build context parameter is set to DistanceKilometers, the 
  119: 									 odometer offset should be converted from default meters to kilometers.")]
  120: 		public void CalibrateReturnParameterOdoKilometers()
  121  		{

  129  
  130: 			eventParametersMock.Setup(cal => cal.ParameterIDForEvent(It.IsAny<long>())).Returns(Parameters.ODOMETER_READING);
  131  			eventParametersMock.Setup(cal => cal.GetEventValue(It.IsAny<long>(), It.IsAny<uint>())).Returns((double)dto.RawValue);

  135  			var buildContextParameter = new BuildContextParameter();
  136: 			buildContextParameter.ParameterId = Parameters.ODOMETER_READING;
  137  			buildContextParameter.ValueFormat = (byte)MiX.DeviceIntegration.DataProcessing.DataAccess.Entities.ValueFormatType.DistanceKilometers;

  139  
  140: 			decimal odometerOffsetInMeters = 500m;
  141: 			odometerStateMock.Setup(odo => odo.GetOdometerOffset(It.IsAny<long>())).Returns(odometerOffsetInMeters);
  142  

  145  
  146: 			odometerStateMock.Verify(odo => odo.GetOdometerOffset(It.IsAny<long>()), Times.Once(), "The odometer offset should be called once.");
  147: 			Assert.IsTrue(dto.Value != uncalibratedValueInKms + odometerOffsetInMeters, "Offset should be calibrated to meters");
  148  			Assert.IsTrue(dto.Value == 5.5m, "Value + Offset should be in Km's"); // value + offset = 5.5 kilometers;

  178  
  179: 			engineHoursStateMock.Verify(odo => odo.GetEngineSecondsOffset(It.IsAny<long>()), Times.Once(), "The engine seconds offset should be called once.");
  180  			Assert.IsTrue(dto.Value != engineTimeInHours + engineTimeOffsetInSeconds, "Engine time offset should be calibrated to hours");

  226  				EventId = 9034937898691067936,
  227: 				Description = "Ignition On with Odo",
  228  				LegacyEventId = -7,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Staging\Validation.cs:
   12  
   13: 		void ValidateTripValue(ref decimal? odometer, string taskDesc, long mobileUnitId);
   14  

   20  	{
   21: 		private const decimal MaxOdometer = 99999999999999.999999M;									// decimal (20,6)
   22  		private const decimal MaxSpeed = 99999999999999.999999M;										// decimal (20,6)

   39  			{
   40: 				if (position.Odometer.HasValue)
   41  				{
   42: 					if (position.Odometer.Value > MaxOdometer)
   43  					{

   46  							StagedDTO = position,
   47: 							OffendingProperty = "Odometer",
   48: 							ValueBefore = position.Odometer.ToString(),
   49: 							ValueAfter = MaxOdometer.ToString()
   50  						});
   51  
   52: 						position.Odometer = MaxOdometer;
   53  					}
   54  
   55: 					if (position.Odometer.Value < 0)
   56  					{

   59  							StagedDTO = position,
   60: 							OffendingProperty = "Odometer",
   61: 							ValueBefore = position.Odometer.ToString(),
   62  							ValueAfter = "0"

   64  
   65: 						position.Odometer = 0;
   66  					}

  159  			{
  160: 				if (evnt.Odometer.HasValue)
  161  				{
  162: 					if (evnt.Odometer.Value > MaxOdometer)
  163  					{

  166  							StagedDTO = evnt,
  167: 							OffendingProperty = "Odometer",
  168: 							ValueBefore = evnt.Odometer.ToString(),
  169: 							ValueAfter = MaxOdometer.ToString()
  170  						});
  171  
  172: 						evnt.Odometer = MaxOdometer;
  173  					}
  174  
  175: 					if (evnt.Odometer.Value < 0)
  176  					{

  179  							StagedDTO = evnt,
  180: 							OffendingProperty = "Odometer",
  181: 							ValueBefore = evnt.Odometer.ToString(),
  182  							ValueAfter = "0"

  184  
  185: 						evnt.Odometer = 0;
  186  					}

  198  			{
  199: 				if (evnt.StartOdometer.HasValue)
  200  				{
  201: 					if (evnt.StartOdometer.Value > MaxOdometer)
  202  					{

  205  							StagedDTO = evnt,
  206: 							OffendingProperty = "StartOdometer",
  207: 							ValueBefore = evnt.StartOdometer.ToString(),
  208: 							ValueAfter = MaxOdometer.ToString()
  209  						});
  210  
  211: 						evnt.StartOdometer = MaxOdometer;
  212  					}
  213  
  214: 					if (evnt.StartOdometer.Value < 0)
  215  					{

  218  							StagedDTO = evnt,
  219: 							OffendingProperty = "StartOdometer",
  220: 							ValueBefore = evnt.StartOdometer.ToString(),
  221  							ValueAfter = "0"

  223  
  224: 						evnt.StartOdometer = 0;
  225  					}

  227  
  228: 				if (evnt.EndOdometer.HasValue)
  229  				{
  230: 					if (evnt.EndOdometer.Value > MaxOdometer)
  231  					{

  234  							StagedDTO = evnt,
  235: 							OffendingProperty = "EndOdometer",
  236: 							ValueBefore = evnt.EndOdometer.ToString(),
  237: 							ValueAfter = MaxOdometer.ToString()
  238  						});
  239  
  240: 						evnt.EndOdometer = MaxOdometer;
  241  					}
  242  
  243: 					if (evnt.EndOdometer.Value < 0)
  244  					{

  247  							StagedDTO = evnt,
  248: 							OffendingProperty = "EndOdometer",
  249: 							ValueBefore = evnt.EndOdometer.ToString(),
  250  							ValueAfter = "0"

  252  
  253: 						evnt.EndOdometer = 0;
  254  					}

  329  
  330: 				bool allOdometerValuesPresent = true;
  331  

  380  
  381: 						if (subTrip.SubTripStart.Odometer.HasValue)
  382  						{
  383: 							if (subTrip.SubTripStart.Odometer.Value > MaxOdometer)
  384  							{

  387  									StagedDTO = trip,
  388: 									OffendingProperty = "SubTripStart Odometer",
  389: 									ValueBefore = subTrip.SubTripStart.Odometer.ToString(),
  390: 									ValueAfter = MaxOdometer.ToString()
  391  								});
  392  
  393: 								subTrip.SubTripStart.Odometer = MaxOdometer;
  394  							}
  395  
  396: 							if (subTrip.SubTripStart.Odometer.Value < 0)
  397  							{

  400  									StagedDTO = trip,
  401: 									OffendingProperty = "SubTripStart Odometer",
  402: 									ValueBefore = subTrip.SubTripStart.Odometer.ToString(),
  403  									ValueAfter = "0"

  405  
  406: 								subTrip.SubTripStart.Odometer = 0;
  407  							}

  410  						{
  411: 							allOdometerValuesPresent = false;
  412  						}

  461  
  462: 						if (subTrip.SubTripEnd.Odometer.HasValue)
  463  						{
  464: 							if (subTrip.SubTripEnd.Odometer.Value > MaxOdometer)
  465  							{

  468  									StagedDTO = trip,
  469: 									OffendingProperty = "SubTripEnd Odometer",
  470: 									ValueBefore = subTrip.SubTripEnd.Odometer.ToString(),
  471: 									ValueAfter = MaxOdometer.ToString()
  472  								});
  473  
  474: 								subTrip.SubTripEnd.Odometer = MaxOdometer;
  475  							}
  476  
  477: 							if (subTrip.SubTripEnd.Odometer.Value < 0)
  478  							{

  481  									StagedDTO = trip,
  482: 									OffendingProperty = "SubTripEnd Odometer",
  483: 									ValueBefore = subTrip.SubTripEnd.Odometer.ToString(),
  484  									ValueAfter = "0"

  486  
  487: 								subTrip.SubTripEnd.Odometer = 0;
  488  							}

  492  					{
  493: 						allOdometerValuesPresent = false;
  494  					}

  515  
  516: 				if (!trip.TripWithNoDriving && !allOdometerValuesPresent)
  517  				{

  520  						StagedDTO = trip,
  521: 						OffendingProperty = "Some trip odometer values are missing",
  522  						ValueBefore = string.Empty,

  526  
  527: 				if (recalculateSubTripDistances && allOdometerValuesPresent)
  528  				{

  532  						{
  533: 							trip.SubTrips[i].Distance = trip.SubTrips[i + 1].SubTripStart.Odometer - trip.SubTrips[i].SubTripStart.Odometer;
  534  						}

  536  						{
  537: 							trip.SubTrips[i].Distance = trip.SubTrips[i].SubTripEnd.Odometer - trip.SubTrips[i].SubTripStart.Odometer;
  538  						}

  569  
  570: 					tripValue = MaxOdometer;
  571  				}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Staging\DataAccess\StagingRepository.cs:
   30  			decimal? startPulse, decimal? endPulse, long? pulseParameterId, bool? pulseIsFuel, decimal? startEngineSeconds, decimal? endEngineSeconds, 
   31: 			decimal? startOdo, decimal? endOdo, long? driverId, long? originalDriverId, decimal? fuel, int? distance);
   32  

   37  			decimal? startPulse, decimal? endPulse, long? pulseParameterId, bool? pulseIsFuel, decimal? startEngineSeconds, decimal? endEngineSeconds, 
   38: 			decimal? startOdometer, decimal? endOdometer);
   39  
   40  		int UpdateTripCompletionForThirdParty(long mobileUnitId, int tripNumber, long driverId, string failReason, DateTime tripStart, DateTime tripEnd,
   41: 			decimal? startEngineSeconds, decimal? endEngineSeconds, decimal? startOdometer, decimal? endOdometer);
   42  
   43: 		void UpdateTripOdometer(long mobileUnitId, int tripNumber, DateTime startDateTime, decimal startOdo, decimal endOdo);
   44  

  520  			decimal? startPulse, decimal? endPulse, long? pulseParameterId, bool? pulseIsFuel, decimal? startEngineSeconds, decimal? endEngineSeconds,
  521: 			decimal? startOdo, decimal? endOdo, long? driverId, long? originalDriverId, decimal? fuel, int? distance)
  522  		{

  526  							new { mobileUnitId, orgId, tripNumber, startDateTime, endDateTime, notes, startPulse, endPulse, pulseParameterId, pulseIsFuel,
  527: 								startEngineSeconds, endEngineSeconds, startOdo, endOdo, driverId, originalDriverId, fuel, distance },
  528  								commandType: CommandType.StoredProcedure);

  556  			decimal? startPulse, decimal? endPulse, long? pulseParameterId, bool? pulseIsFuel, decimal? startEngineSeconds, decimal? endEngineSeconds, 
  557: 			decimal? startOdometer, decimal? endOdometer)
  558  		{

  562  						new { mobileUnitId, tripNumber, driverId, originalDriverId, failReason, tripEnd, startPulse, endPulse, pulseParameterId,
  563: 							pulseIsFuel, startEngineSeconds, endEngineSeconds, startOdometer, endOdometer },
  564  						commandType: CommandType.StoredProcedure);

  569  		public int UpdateTripCompletionForThirdParty(long mobileUnitId, int tripNumber, long driverId, string failReason, DateTime tripStart, DateTime tripEnd,
  570: 			decimal? startEngineSeconds, decimal? endEngineSeconds, decimal? startOdometer, decimal? endOdometer)
  571  		{ 

  574  				return connection.Execute("[staging].[UpdateTripCompletedForThirdParty]",
  575: 						new { mobileUnitId, tripNumber, driverId, failReason, tripStart, tripEnd, startEngineSeconds, endEngineSeconds, startOdometer, endOdometer },
  576  						commandType: CommandType.StoredProcedure);

  581  
  582: 		public void UpdateTripOdometer(long mobileUnitId, int tripNumber, DateTime tripStart, decimal startOdometer, decimal endOdometer)
  583  		{

  585  			{
  586: 				return connection.Execute("[staging].[UpdateTripOdometer]",
  587: 						new { mobileUnitId, tripNumber, tripStart, startOdometer, endOdometer },
  588  						commandType: CommandType.StoredProcedure);
  589  			},
  590: 			"UpdateTripOdometer");
  591  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Staging\Staging\StagingEvent.cs:
  17  				ActionSequenceNumber = e.ActionSequenceNumber,
  18: 				Odometer = e.Odometer,
  19  				Value = e.Value,

  40  
  41: 		public decimal? Odometer { get; set; }
  42  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Staging\Staging\StagingPassiveEvent.cs:
  18  		public DateTime? EndTime {get; set;}
  19: 		public decimal? StartOdometer {get; set;}
  20: 		public decimal? EndOdometer {get; set;}
  21  		public long StartSequenceNumber {get; set;}

  44  				EndTime = dto.EndTime,
  45: 				StartOdometer = dto.StartOdometer,
  46: 				EndOdometer = dto.EndOdometer,
  47  				StartSequenceNumber = dto.StartSequenceNumber,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Staging\Staging\StagingPosition.cs:
  25  			result.NumberOfSatellites = p.NumberOfSatellites;
  26: 			result.Odometer = p.Odometer;
  27  			result.Speed = p.Speed;

  29  			result.AgeOfReadingSeconds = p.AgeOfReadingSeconds;
  30: 			result.CalculateOdometer = p.CalculateOdometer;
  31  			result.TripMode = p.TripMode;

  54  		public byte? NumberOfSatellites { get; set; }
  55: 		public decimal? Odometer { get; set; }
  56  		public decimal? Speed { get; set; }

  59  		public string Values { get; set; }
  60: 		public bool CalculateOdometer { get; set; }
  61  		public bool? TripMode { get; set; }

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Staging\Staging\TripComplete.cs:
  13  		public DateTime EndDateTime { get; set; }
  14: 		public decimal? StartOdometer { get; set; }
  15: 		public decimal? EndOdometer { get; set; }
  16  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.TachoTest\MainForm.cs:
   40  						break;
   41: 					case (int)FmTachoRecClass.BITSTREAM_PARAM.ODO:
   42: 						_tachoRec.SetOdo((int)anPrevVals[indexChecked] + Properties.Settings.Default.Odo_Inc);
   43: 						anPrevVals[indexChecked] += Properties.Settings.Default.Odo_Inc;
   44: 						s = string.Format("Odometer:\t{0}\r\n", _tachoRec.GetOdo_km()); ;
   45  						break;

  114  			anPrevVals[(int)FmTachoRecClass.BITSTREAM_PARAM.TIME] = 0; // not used
  115: 			anPrevVals[(int)FmTachoRecClass.BITSTREAM_PARAM.ODO] = Properties.Settings.Default.Odo_Start - Properties.Settings.Default.Odo_Inc;
  116  			anPrevVals[(int)FmTachoRecClass.BITSTREAM_PARAM.SPEED] = Properties.Settings.Default.Speed_Start - Properties.Settings.Default.Speed_Inc;

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.TachoTest\Properties\Settings.Designer.cs:
   28          [global::System.Configuration.DefaultSettingValueAttribute("180")]
   29:         public int Odo_Inc {
   30              get {
   31:                 return ((int)(this["Odo_Inc"]));
   32              }
   33              set {
   34:                 this["Odo_Inc"] = value;
   35              }

  136          [global::System.Configuration.DefaultSettingValueAttribute("1234567")]
  137:         public int Odo_Start {
  138              get {
  139:                 return ((int)(this["Odo_Start"]));
  140              }
  141              set {
  142:                 this["Odo_Start"] = value;
  143              }

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.TDI.Logic\Managers\TdiMessageManager.cs:
  120  
  121: 			// TODO: Add asset/template validation for this specific subtype
  122  		}

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Fm.ActiveMessageProcessor\Processors\NewConfigProcessor.cs:
  26  		{
  27: 			var currentLoadedConfigVersion = Convert.ToDouble(GetLoadedConfigVersion(mobileUnit.MobileUnitId));
  28: 			var pendingConfigVersion = Convert.ToDouble(GetPendingConfigVersion(mobileUnit.MobileUnitId));
  29  			int saveCTime = 0;

  70  
  71: 			//TODO the following we want to get rid of in the long run
  72  			InsertOrUpdateMobileUnitProperty(mobileUnit.MobileUnitId, Constants.FmBaseDeviceId, Constants.LastConfigPropertyId, configAcceptedTime, evnt.DeviceTimestamp, "FM.ActiveMessageProcessor");

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Monitoring\MissingTrips\TripReplayProcessing.cs:
  241  
  242: 					//TODO - this needs to be streamlined
  243  

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Monitoring.UnitTests\MonitoringServiceTests.cs:
  23  
  24: ⟪ 830 characters skipped ⟫:01\",\"Hdop\":159,\"Pdop\":0,\"Vdop\":null,\"Heading\":0,\"IgnitionOn\":true,\"Latitude\":-37.541731428354979,\"Longitude\":144.94409311562777,\"SequenceNumber\":620801101,\"NumberOfSatellites\":6,\"Odometer\":null,\"Speed\":0.0,\"AgeOfReadingSeconds\":0,\"Values\":null,\"CalculateOdometer\":false,\"TripMode\":null,\"OrgId\":5394682115533284740,\"MobileUnitId\":1176494442816673225,\"DriverId\":-436392511002858036,\"ProceedWithProcessing\":true,\"TrackingId\":\"dec9a46a-05a9-46ac-ac3e-46daaa7f417e\",\"Stage\":true},\"EngineSeconds\":null,\"Odometer\":0.0},\"SubTripEnd\":{\"TimeStamp\":\"2000-01-01T11:00:15\",\"PulseCount\":null,\"PositionId\":0,\"Position\":{\"StagedPositionId\":0,\"OriginalDriverId\":-436392511002858036,\"IsAvl\":false,\"AltitudeMetres\":null,\"Timestamp\":\"2000-01-01T11:00:15\",\"Hdop\":0,\"Pdop\":0,\"Vdop\":null,\"Heading\":105,\"IgnitionOn\":true,\"Latitude\":-38.072974942624569,\"Longitude\":145.39417994208634,\"SequenceNumber\":15,\"NumberOfSatellites\":0,\"Odometer\":338234.0,\"Speed\":0.0,\"AgeOfReadingSeconds\":0,\"Values\":null,\"CalculateOdometer\":false,\"TripMode\":null,\"OrgId\":5394682115533284740,\"MobileUnitId\":1176494442816673225,\"DriverId\":-436392511002858036,\"ProceedWithProcessing\":true,\"TrackingId\":\"aa779a8c-5e98-4ff1-a6c0-0fd1605e5998\",\"Stage\":true},\"EngineSeconds\":null,\"Odometer\":338234.0},\"StandingTime\":0,\"TotalEngineSeconds\":null,\"Distance\":338234.0,\"MaxSpeed\":107.0,\"SpeedTime\":0,\"SpeedOccurs\":0,\"SpeedScore\":100.0,\"MaxBrake\":0.0,\"BrakeTime\":0,\"BrakeOccurs\":0,\"BrakeScore\":100.0,\"MaxAccel\":0.0,\"AccelTime\":0,\"AccelOccurs\":0,\"AccelScore\":100.0,\"MaxRPM\":0.0,\"RPMTime\":0,\"RPMOccurs\":0,\"RPMScore\":100.0,\"GBTime\":0,\"GBScore\":100.0,\"ExIdleTime\":0,\"ExIdleOccurs\":0,\"ExIdleScore\":100.0,\"NIdleTime\":0,\"NIdleOccurs\":0,\"Litres\":null,\"PulseValue\":null,\"Odometer\":338234.0}],\"PulseParameterId\":null,\"PulseIsFuel\":false,\"CalculateOdometer\":false,\"GenerateActiveEventsForHos\":false,\"AdjustOdometer\":true,\"TripWithNoDriving\":false,\"EndOdometer\":338234.0,\"TotalTripDistance\":null,\"OriginalDriverId\":-436392511002858036,\"TotalEngineSeconds\":null,\"TripStartEngineSeconds\":null,\"TripEndEngineSeconds\":null,\"OrgId\":5394682115533284740,\"MobileUnitId\":1176494442816673225,\"DriverId\":-436392511002858036,\"ProceedWithProcessing\":false,\"TrackingId\":\"357520070186313-20190903-114550-208-0-1\",\"Stage\":true}\",\"StackTrace\":\"";	}
  25  }

DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\AssetsProxy.cs:
  88  							[Description] = v.sDesc,
  89: 							[LastOdo] = v.fLastOdo,
  90  							[LastTrip] = v.dtLastTrip,

DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\DataSchedulesProxy.cs:
  25  					{
  26: 						assetId = sched.AssetId, setOdoKmValue =sched.SetOdoKmValue, timeoutInMinutes =sched.TimeoutInMinutes, lastEditedBy =sched.LastEditedBy,
  27  						nextRun = sched.NextRun, syncDateTime=sched.SyncDateTime, customerInitiated=sched.CustomerInitiated, disarm = sched.Disarm,
  28: 					  disarmDriverId = sched.DisarmDriverId, setOdo = sched.SetOdo, setEngineHours = sched.SetEngineHours, setEngineHoursValue = sched.SetEngineHoursValue,
  29  					  uploadInTrip = sched.UploadInTrip, uploadConfig = sched.UploadConfig, uploadExtendedConfig = sched.UploadExtendedConfig,

DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\DTOs\AssetSummary.cs:
  10  		public string Description { get; set; }
  11: 		public decimal LastOdo { get; set; }
  12  		public DateTime LastTrip { get; set; }

DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\DTOs\DataSchedule.cs:
  17  		/// <summary>
  18: 		/// Odometer in KM
  19  		/// </summary>
  20: 		public int? SetOdoKmValue { get; set; }
  21  		/// <summary>
  22: 		/// Inferred from SetOdoKmValue
  23  		/// </summary>
  24: 		public bool SetOdo { get { return SetOdoKmValue != null; } }
  25  

  35  		/// <summary>
  36: 		/// if (Disarm || SetOdo || SetEngineHours)return 15;
  37  		/// </summary>

DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\MiX.Connect\MiXConnectMiX4k6kProxy.cs:
  138  
  139: 				case CommandIdType.SetOdometerOffset:
  140  					{
  141: 						cmdDetails = new AdjustOdoDetails
  142  						{

DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\MiX.Connect\MiXConnectMiX2310Proxy.cs:
   99  
  100: 				case CommandIdType.SetOdometerOffset:
  101  					{
  102: 						cmdDetails = new AdjustOdoDetails()
  103  						{

DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\MiX.Connect\MiXConnectProxy.cs:
  211  				diagnostics.InternalBatteryState = status.InternalBatteryState.ToString();
  212: 				//diagnostics.Odometer = status.Odometer.ToString();
  213  				diagnostics.PlatformVersion = status.PlatformVersion.ToString();

DynaMiX.DeviceConfig\StandAloneUtilities\IftaDataFix\Process.cs:
   51  
   52: 		public static void ProcessOdoJumps()
   53  		{

   80  						{
   81: 							if (ProcessOdoJumps(assetDb, vid, fromDate, toDate))
   82  								vehcilesCorrected++;

   89  			{
   90: 				Logger.Log("Could not process odo jumps at all", LogLevel.Error);
   91  				Logger.Log(ex);

   95  
   96: 		private static bool ProcessOdoJumps(SqlConnection assetDb, short vid, DateTime fromDate, DateTime toDate)
   97  		{

  106  
  107: 			List<RecordedEvent> odoResets1 = AssetDb.GetEvents(assetDb, fromDate, toDate, vid, 29984);
  108: 			List<RecordedEvent> odoResets2 = AssetDb.GetEvents(assetDb, fromDate, toDate, vid, 32563);
  109: 			List<RecordedEvent> odoResets3 = AssetDb.GetEvents(assetDb, fromDate, toDate, vid, 108);
  110  
  111: 			Logger.Log("Event 29984 " + odoResets1.Count, LogLevel.Debug);
  112: 			Logger.Log("Event 32563 " + odoResets2.Count, LogLevel.Debug);
  113: 			Logger.Log("Event 108 " + odoResets3.Count, LogLevel.Debug);
  114  
  115: 			List<RecordedEvent> odoResets = new List<RecordedEvent>();
  116: 			odoResets.AddRange(odoResets1);
  117: 			odoResets.AddRange(odoResets2);
  118: 			odoResets.AddRange(odoResets3);
  119  
  120: 			Logger.Log("Found " + odoResets.Count + " odo resets for " + vid, LogLevel.Debug);
  121  

  128  
  129: 			while (GetSubtripOdoJump(vid, subtripsToProcess, out goodBefore, out badMiddle, out goodAfter, true))
  130  			{
  131  				numberOfJumpsFound++;
  132: 				if (JumpHasInverseOdoReset(subtripsToProcess, goodBefore, goodAfter, odoResets))
  133  				{
  134: 					if (!JumpHasOdoReset(subtripsToProcess, goodBefore, badMiddle, odoResets))
  135  					{
  136  						numberOfJumpsCorrected++;
  137: 						AssetDb.InsertOdoReset(assetDb, badMiddle.TripStart.AddSeconds(-1), vid, badMiddle.Odometer);
  138  					}

  140  					{
  141: 						Logger.Log("odo jump already has reset event vid:" + vid + " bad odo " + badMiddle.Odometer, LogLevel.Debug);
  142  					}

  145  				{
  146: 					if (!JumpHasOdoReset(subtripsToProcess, goodBefore, badMiddle, odoResets))
  147  					{
  148: 						Logger.Log("Only single jump, so insert odo reset to this value", LogLevel.Debug);
  149  						numberOfJumpsCorrected++;
  150: 						AssetDb.InsertOdoReset(assetDb, badMiddle.TripStart.AddSeconds(-1), vid, badMiddle.Odometer);
  151  					}

  155  
  156: 			Logger.Log($"Found {numberOfJumpsFound} odo jumps for {vid} and corrected {numberOfJumpsCorrected}", numberOfJumpsCorrected > 0 ? LogLevel.Warning : LogLevel.Debug);
  157  

  160  
  161: 		private static bool JumpHasOdoReset(List<Subtrip> subtrips, Subtrip goodBefore, Subtrip badMimddle, List<RecordedEvent> odoResets)
  162  		{

  165  
  166: 			foreach (RecordedEvent evnt in odoResets)
  167  			{

  169  				{
  170: 					if (evnt.StartOdometer.DifferenceLessThan(badMimddle.Odometer, resetThreshold))
  171  					{
  172: 						Logger.Log("ODO RESET FOUND EventId " + evnt.EventId + " " + evnt.StartDate.ToIsoString() + " odo " + evnt.StartOdometer, LogLevel.Debug);
  173  						return true;

  179  		}
  180: 		private static bool JumpHasInverseOdoReset(List<Subtrip> subtrips, Subtrip goodBefore, Subtrip goodAfter, List<RecordedEvent> odoResets)
  181  		{

  193  
  194: 			foreach (RecordedEvent evnt in odoResets)
  195  			{

  197  				{
  198: 					if (evnt.StartOdometer.DifferenceLessThan(goodAfter == null ? goodBefore.Odometer : goodAfter.Odometer, resetThreshold))
  199  						return true;

  221  
  222: 		private static bool GetSubtripOdoJump(short vid, List<Subtrip> subtripsInRange, out Subtrip goodBefore, out Subtrip badMiddle, out Subtrip goodAfter, bool log)
  223  		{

  239  
  240: 					if (!g1.Odometer.DifferenceLessThan(b.Odometer, threshold)) // odo dropped by more than 1000 km from one subtrip to the next
  241  					{

  247  						{
  248: 							Logger.Log("good before : tripstart " + goodBefore.TripStart.ToIsoString() + " tripid " + goodBefore.TripId + " sequence " + goodBefore.Sequence + " odo " + goodBefore.Odometer, LogLevel.Debug);
  249: 							Logger.Log("bad middle : tripstart " + badMiddle.TripStart.ToIsoString() + " tripid " + badMiddle.TripId + " sequence " + badMiddle.Sequence + " odo " + badMiddle.Odometer, LogLevel.Debug);
  250  
  251: 							goodAfter = FindNextgoodSubtrip(subtripsInRange, i + 1, goodBefore.Odometer, badMiddle.Odometer, threshold);
  252  

  273  
  274: 		private static Subtrip FindNextgoodSubtrip(List<Subtrip> subtripsInRange, int index, decimal goodOdo, decimal badOdo, int threshold)
  275  		{

  279  
  280: 				Logger.Log("odo " + st.Odometer, LogLevel.Debug);
  281  
  282: 				if (goodOdo > badOdo)
  283  				{
  284: 					if (!badOdo.DifferenceLessThan(st.Odometer, threshold) && st.Odometer > badOdo)
  285  						return st;

  288  				{
  289: 					if (!badOdo.DifferenceLessThan(st.Odometer, threshold) && st.Odometer < badOdo)
  290  						return st;

DynaMiX.DeviceConfig\StandAloneUtilities\IftaDataFix\Program.cs:
   9  			//Process.ProcessUnitSwops();
  10: 			Process.ProcessOdoJumps();
  11  		}

DynaMiX.DeviceConfig\StandAloneUtilities\IftaDataFix\DataAccess\AssetDb.cs:
  22  	EventID,
  23: 	[StartOdometer] = ISNULL(StartOdometer, Value),
  24  	StartDate

  51  	st.Sequence,
  52: 	st.Odometer,
  53  	[Halt] = ISNULL(st.Halt, t.TripEnd),

  72  
  73: 		public static void InsertOdoReset(SqlConnection assestDb, DateTime dt, short vehicleId, decimal odo)
  74  		{

  76  
  77: 			Logger.Log(assestDb.Database + ": inserting reset odo vehicle " + vehicleId + " date " + dt.ToIsoString() + " odo " + odo + " to server " + assestDb.DataSource + " commit = " + commit, LogLevel.Warning);
  78  

  80  INSERT INTO dbo.tbEventData 
  81: (VehicleID,   DriverID,OriginalDriverID,EventID,EventType,StartSequence, StartDate,  StartOdometer,TotalOccurs,TotalTime) VALUES
  82  (@vehicleId,  0,       0,               29984,  3,
  83  ISNULL((SELECT MAX(StartSequence) FROM dbo.TbEventData WHERE VehicleId = @vehicleId AND StartSequence < 0),-2147483648) + 1,
  84: @startDate, @startOdo,    1, -1)";
  85  

  90  					startDate = dt,
  91: 					startOdo = odo,
  92  					vehicleId

DynaMiX.DeviceConfig\StandAloneUtilities\IftaDataFix\DTO\RecordedEvent.cs:
  11  		public short EventId { get; set; }
  12: 		public decimal StartOdometer { get; set; }
  13  		public DateTime StartDate { get; set; }

DynaMiX.DeviceConfig\StandAloneUtilities\IftaDataFix\DTO\Subtrip.cs:
   7  		public short VehicleId { get; set; }
   8: 		public decimal Odometer { get; set; }
   9  		public int TripId { get; set; }

  16  		{
  17: 			return "TripId " + TripId + " sequence " + Sequence + " TripStart " + TripStart.ToIsoString() + " odometer " + Odometer; 
  18  		}

Fleet.Services\MiX.Fleet.Services.Api.Client\Repositories\AssetsRepository.cs:
  395  
  396: 		public async Task<float?> GetLastOdoAsync(long assetId, SecurityAccounts securityAccounts, long? correlationId = null)
  397  		{
  398: 			string route = string.Concat(ApiUrl, RouteBuilderHelper.GenerateUrl(ApiControllerRoutes.MiXFleetServicesApi.AssetController.GetLastOdometer, "assetId", assetId));
  399  

  694  
  695: 		public async Task UpdateLastOdoAsync(long organisationId, long assetId, float lastOdo, SecurityAccounts securityAccounts, long? correlationId = null)
  696  		{

  700  
  701: 			FloatRequest fuel = new FloatRequest { Value = lastOdo };
  702  
  703: 			string route = string.Concat(ApiUrl, RouteBuilderHelper.GenerateUrl(ApiControllerRoutes.MiXFleetServicesApi.AssetController.UpdateLastOdo, queryParameters));
  704  			await HttpRetries.ExecuteAsync(() =>

Fleet.Services\MiX.Fleet.Services.Api.Client\Repositories\Interfaces\IAssetsRepository.cs:
  53  		Task<AssetCommsDetails> GetLegacyDetailsAsync(long organisationId, long assetId, SecurityAccounts securityAccounts, long? correlationId = null);
  54: 		Task<float?> GetLastOdoAsync(long assetId, SecurityAccounts securityAccounts, long? correlationId = null);
  55  		Task<AssetAccessDetails> GetAssetDefaultDriverAsync(long organisationId, long assetId, SecurityAccounts securityAccounts, long? correlationId = null);

  83  		Task UpdateMobileDeviceSettingsAsync(MobileDeviceSettings mobileDeviceSettings, SecurityAccounts securityAccounts, long? correlationId = null);
  84: 		Task UpdateLastOdoAsync(long organisationId, long assetId, float lastOdo, SecurityAccounts securityAccounts, long? correlationId = null);
  85  		Task UpdateEngineSecondsAsync(long organisationId, long assetId, Int32 engineSeconds, SecurityAccounts securityAccounts, long? correlationId = null);

Fleet.Services\MiX.Fleet.Services.Api.Client.Tests\UnitTests\AssetControllerTest.cs:
  252  			Asset asset = await FleetServicesDataClient.Assets.GetAsync(TestParams.AssetId, _securityAccountsWithAudit).ConfigureAwait(false);
  253: 			MobileDeviceSettings vinIDUpdate = new MobileDeviceSettings { AssetId = asset.AssetId, SiteId = asset.SiteId, EngineSeconds = 123, Odometer = 23 };
  254  

Fleet.Services\MiX.Fleet.Services.Api.Client.Tests\UnitTests\FuelControllerTest.cs:
  52  				FillEngineSeconds = 0,
  53: 				FillOdometerKilometres = 20,
  54  				FuelTransactionId = 0,

Fleet.Services\MiX.Fleet.Services.Api.Core\Controllers\AssetsController.cs:
   763  		/// <summary>
   764: 		/// Asset last odo update
   765  		/// </summary>

   767  		/// <param name="assetId"></param>
   768: 		/// <param name="lastOdo"></param>
   769  		/// <response code="200">OK </response>

   776  		/// <response code="500">Internal Server Error</response>
   777: 		[Route(ApiControllerRoutes.MiXFleetServicesApi.AssetController.UpdateLastOdoOld)]
   778  		[HttpGet] //put?
   779: 		public async Task<IActionResult> UpdateLastOdoOldAsync(long organisationId, long assetId, float lastOdo)
   780  		{

   789  
   790: 			await _assetManager.UpdateLastOdoAsync(organisationId, assetId, lastOdo).ConfigureAwait(false);
   791  

   795  		/// <summary>
   796: 		/// Asset last odo update
   797  		/// </summary>

   799  		/// <param name="assetId"></param>
   800: 		/// <param name="lastOdo"></param>
   801  		/// <response code="200">OK </response>

   808  		/// <response code="500">Internal Server Error</response>
   809: 		[Route(ApiControllerRoutes.MiXFleetServicesApi.AssetController.UpdateLastOdo)]
   810  		[HttpPut]
   811: 		public async Task<IActionResult> UpdateLastOdoAsync([FromBody] FloatRequest lastOdo, long organisationId, long assetId)
   812  		{

   818  
   819: 			await _assetManager.UpdateLastOdoAsync(organisationId, assetId, lastOdo.Value).ConfigureAwait(false);
   820  

  1900  		/// <summary>
  1901: 		/// Asset last odometer
  1902  		/// </summary>

  1911  		/// <returns></returns>
  1912: 		[Route(ApiControllerRoutes.MiXFleetServicesApi.AssetController.GetLastOdometer)]
  1913  		[ProducesResponseType(typeof(NullableFloatRequest), 200)]
  1914  		[HttpGet]
  1915: 		public async Task<IActionResult> GetLastOdometerAsync(long assetId)
  1916  		{

  1919  
  1920: 			var result = await _assetManager.GetLastOdometerAsync(assetId).ConfigureAwait(false);
  1921  

Fleet.Services\MiX.Fleet.Services.Api.Tests\IntegrationTests\IntTests_Api_FuelController.cs:
  92  				FillEngineSeconds = 0,
  93: 				FillOdometerKilometres = 20,
  94  				FuelTransactionId = 0,

Fleet.Services\MiX.Fleet.Services.Api.Tests\UnitTests\UnitTests_Api_AssetsController.cs:
  331  			mockAssetManager.SetupSequence(assetManager => assetManager.UpdateMobileDeviceSettingsAsync(It.IsAny<long>(), It.IsAny<MobileDeviceSettings>(), It.IsAny<bool>()))
  332: 				.Returns(Task.FromResult<MobileDeviceSettings>(new MobileDeviceSettings() { AssetId = 1, SiteId = 1, EngineSeconds = 123, Odometer = 23 }))
  333  				.Returns(Task.FromResult<MobileDeviceSettings>(null))

  341  
  342: 			MobileDeviceSettings newMobileDeviceSettings = new MobileDeviceSettings() { AssetId = 1, SiteId = 1, EngineSeconds = 321, Odometer = 32 };
  343  

Fleet.Services\MiX.Fleet.Services.Api.Tests\UnitTests\UnitTests_Api_TripsController.cs:
  511  					DistanceKilometres = 80,
  512: 					StartOdometerKilometres = 30000,
  513  					StartPositionId = null,

Fleet.Services\MiX.Fleet.Services.Common\Constants.cs:
   76  			/// <summary>
   77: 			/// The name of the DNS validation directive. //TODO: MR: Make sure we will leave this in here
   78  			/// </summary>

  200  				public const string RES_TIMELINE_SSE_LOCATION_VALUE = "value of {{ eventValue }}";
  201: 				public const string RES_TIMELINE_EVENT_ODO = "Odometer reading {{ odoValue }} {{ odoUnit }}";
  202  				public const string RES_TIMELINE_EVENT_START = "{{ eventTime }} {{ eventDescription }} start";

  218  				public const string RES_TIMELINE_SELECTION = "Select Period: from {{ startDateTime }} until {{ endDateTime }}";
  219: 				public const string RES_TIMELINE_SUB_TRIP_DISTANCE = "Sub Trip distance {{ tripDistance }} {{ tripDistanceUnits }}, with ending Odometer {{ odo }} {{ tripDistanceUnits }}";
  220  				public const string RES_TIMELINE_SUB_TRIP_END = "{{ tripEndDateTime }} Sub Trip end. Driving time {{ subTripDuration }}";

  225  				public const string RES_TIMELINE_TRIP_DEPART = "{{ dateTime }} The vehicle departed";
  226: 				public const string RES_TIMELINE_TRIP_DISTANCE = "Trip distance {{ distance }} {{ unit }}, with ending Odometer {{ odo }} {{ unit }}";
  227  				public const string RES_TIMELINE_TRIP_DRIVER = "Driver {{ driver }}";

  275  				public const string AVERAGE = "{{ average }}";
  276: 				public const string ODO = "{{ odo }}";
  277: 				public const string ODO_VALUE = "{{ odoValue }}";
  278: 				public const string ODO_UNIT = "{{ odoUnit }}";
  279  				public const string SPEED = "{{ speed }}";

Fleet.Services\MiX.Fleet.Services.Common\Core\DataAccess\BagFormat\BagSerialiser.cs:
  315  			else if (type == typeof(double))
  316: 				result = GetDouble(bag, name, Convert.ToDouble(defaultValue));
  317  			else if (type == typeof(double?))

Fleet.Services\MiX.Fleet.Services.Common\Helpers\ImageHelper.cs:
  55  
  56: 			//todo: smarter detection of file type
  57  			if (extension == filename) //no extension provided. default to jpg

Fleet.Services\MiX.Fleet.Services.Data\DataHelper.cs:
  135  			dt.Columns.Add("TransactionDate", typeof(DateTime));
  136: 			dt.Columns.Add("Odometer", typeof(decimal));
  137  			dt.Columns.Add("Memo", typeof(string));

  150  				
  151: 				dt.Rows.Add(id, entry.AssetId, entry.CategoryId, entry.TransactionDate, entry.Odometer, 
  152  					entry.Memo, entry.Cost, entry.Currency, entry.BaseCost, entry.BaseCurrency, entry.RecurringCostId, entry.AutoAdded);

Fleet.Services\MiX.Fleet.Services.Data\Assets\AssetsRepository.cs:
   475  
   476: 		public async Task UpdateLastOdo(long organisationId, long assetId, float lastOdo)
   477  		{
   478: 			string sp = await _controllerRepository.FormatSqlWithDbName(organisationId, "[dynamix].[Assets_Update_LastOdo]").ConfigureAwait(false);
   479  			await WithConnection(async db =>

   485  						assetId = assetId,
   486: 						fLastOdo = lastOdo
   487  					},

   546  						engineHours = asset.EngineHoursFromSql,
   547: 						odometer = asset.Odometer,
   548  						country = asset.Country,

  1101  						serviceDate = assetServiceHistory.ServiceDate,
  1102: 						odometer = assetServiceHistory.Odometer,
  1103  						engineSeconds = assetServiceHistory.EngineSeconds,

  1132  						serviceDate = assetServiceHistory.ServiceDate,
  1133: 						odometer = assetServiceHistory.Odometer,
  1134  						engineSeconds = assetServiceHistory.EngineSeconds,

Fleet.Services\MiX.Fleet.Services.Data\Assets\IAssetsRepository.cs:
  29  		Task UpdateVinClear(long organisationId, List<long> assetIds);
  30: 		Task UpdateLastOdo(long organisationId, long assetId, float lastOdo);
  31  		Task UpdateEngineSeconds(long organisationId, long assetId, int engineSeconds);

Fleet.Services\MiX.Fleet.Services.Data\Cost\CostRespository.cs:
  187  						transactionDate = costEntry.TransactionDate,
  188: 						odometer = costEntry.Odometer,
  189  						memo = costEntry.Memo,

  308  			{
  309: 				decimal odometer = 0;
  310  				var from = new DateTime(nextTransactionDate.Year, nextTransactionDate.Month, nextTransactionDate.Day, 0, 0, 0);

  315  					var lastEvent = activeEvents[activeEvents.Count - 1];
  316: 					if (lastEvent.EndPosition != null && (lastEvent.EndPosition.OdometerKilometres.HasValue && lastEvent.EndOdometerKilometres.HasValue))
  317  					{
  318: 						// end position and end odometer have values, choose the biggest one
  319: 						var decimalPositionOdometer = (decimal)lastEvent.EndPosition.OdometerKilometres.Value;
  320: 						if (decimalPositionOdometer > lastEvent.EndOdometerKilometres.Value)
  321: 							odometer = decimalPositionOdometer;
  322  						else
  323: 							odometer = lastEvent.EndOdometerKilometres.Value;
  324  					}
  325: 					else if (lastEvent.EndPosition != null && lastEvent.EndPosition.OdometerKilometres.HasValue)
  326  					{
  327  						// only the end position has a value
  328: 						odometer = (decimal)lastEvent.EndPosition.OdometerKilometres.Value;
  329  					}
  330: 					else if (lastEvent.EndOdometerKilometres.HasValue)
  331  					{
  332: 						// only the end odometer has a value
  333: 						odometer = lastEvent.EndOdometerKilometres.Value;
  334  					}

  336  
  337: 				if (odometer == 0 && asset.Odometer.HasValue)
  338  				{
  339: 					// no values found from event, default to asset's current odometer value
  340: 					odometer = (decimal)asset.Odometer.Value;
  341  				}
  342  
  343: 				dateLookup[nextTransactionDate] = odometer;
  344  				nextTransactionDate = nextTransactionDate.AddMonths(1);

  359  						TransactionDate = item.Key,
  360: 						Odometer = item.Value,
  361  						Memo = recurringCost.Memo,

  407  						transactionDate = transaction.TransactionDate,
  408: 						odometer = transaction.Odometer,
  409  						memo = transaction.Memo,

Fleet.Services\MiX.Fleet.Services.Data\Fuel\FuelRepository.cs:
   28  			.MapProperty(x => x.FuelTransactionId).ToColumn("AssetFuelUsageId")
   29: 			.MapProperty(x => x.FillOdometerKilometres).ToColumn("Odometer")
   30  			.MapProperty(x => x.FillEngineSeconds).ToColumn("EngineSeconds");

  205  						assetId = assetFuelUsage.AssetId,
  206: 						odometer = assetFuelUsage.Odometer,
  207  						engineSeconds = assetFuelUsage.EngineSeconds,

  230  						assetId = assetFuelUsage.AssetId,
  231: 						odometer = assetFuelUsage.Odometer,
  232  						engineSeconds = assetFuelUsage.EngineSeconds,

  255  						assetFuelUsageId = assetFuelUsage.AssetFuelUsageId,
  256: 						odometer = assetFuelUsage.Odometer,
  257  						engineSeconds = assetFuelUsage.EngineSeconds,

  280  						assetFuelUsageId = assetFuelUsage.AssetFuelUsageId,
  281: 						odometer = assetFuelUsage.Odometer,
  282  						engineSeconds = assetFuelUsage.EngineSeconds,

  335  						assetId = transaction.AssetId,
  336: 						odometer = transaction.FillOdometerKilometres,
  337  						engineSeconds = transaction.FillEngineSeconds,

Fleet.Services\MiX.Fleet.Services.Data\Groups\GroupRepository.cs:
  858  			{
  859: 				//Todo: Use Proc that only return GroupIds
  860  				string sp = "[DynaMiX_Groups].[Groups_GetByMemberEntityIdsAndGroupType]";

Fleet.Services\MiX.Fleet.Services.Data\Helpers\EventMappingHelper.cs:
  172  
  173: 			if (otherData.TryGetValue(EventOtherDataTypes.StartOdometer, out strValue) && decimal.TryParse(strValue, NumberStyles.Number, CultureInfo.InvariantCulture, out decValue))
  174: 				oEvent.StartOdometerKilometres = decValue;
  175  			else
  176: 				oEvent.StartOdometerKilometres = (decimal?)lEvent.StartPosition?.OdometerKilometres;
  177  
  178: 			if (otherData.TryGetValue(EventOtherDataTypes.EndOdometer, out strValue) && decimal.TryParse(strValue, NumberStyles.Number, CultureInfo.InvariantCulture, out decValue))
  179: 				oEvent.EndOdometerKilometres = decValue;
  180  			else
  181: 				oEvent.EndOdometerKilometres = (decimal?)lEvent.EndPosition?.OdometerKilometres;
  182  

Fleet.Services\MiX.Fleet.Services.Data\Helpers\PositionMappingHelper.cs:
  40  			pos.DistanceSinceReadingKilometres = lpos.DistanceSinceReadingKilometres;
  41: 			pos.OdometerKilometres = lpos.OdometerKilometres;
  42  			pos.FormattedAddress = lpos.FormattedAddress;

Fleet.Services\MiX.Fleet.Services.Data\Helpers\TripMappingHelper.cs:
   17  		/// <summary>
   18: 		/// This is to fix where StartOdometerKilometres is recorded in meters instead of kilometers
   19  		/// </summary>

   24  			if (lSubTrip == null) return null;
   25: 			if (lSubTrip.EndOdometerKilometres > 0)
   26  			{
   27: 				if (lSubTrip.DistanceKilometres < 0 & lSubTrip.StartOdometerKilometres / lSubTrip.EndOdometerKilometres > 100)
   28  				{
   29: 					lSubTrip.StartOdometerKilometres = lSubTrip.StartOdometerKilometres / 1000;
   30  				}

   47  				DistanceKilometres = lSubTrip.DistanceKilometres,
   48: 				StartOdometerKilometres = lSubTrip.StartOdometerKilometres,
   49: 				EndOdometerKilometres = lSubTrip.EndOdometerKilometres
   50  			};

  198  					trip.LastHalt = subTrip.Halt;
  199: 				if (subTrip.EndOdometerKilometres.HasValue)
  200: 					trip.EndOdometerKilomters = subTrip.EndOdometerKilometres;
  201  				if (!trip.StartEngineSeconds.HasValue)

  365  				NumberOfSatellites = lPosition.NumberOfSatellites,
  366: 				OdometerKilometres = lPosition.OdometerKilometres,
  367  				Pdop = lPosition.Pdop,

Fleet.Services\MiX.Fleet.Services.Data\Passengers\PassengersRepository.cs:
  158  
  159: 		//TODO swap this out for a JM call when available
  160  		public async Task<bool> InUseAsync(long organisationId, long passengerId)

Fleet.Services\MiX.Fleet.Services.Data\Trips\TripsRepository.cs:
  439  		/// <returns></returns>
  440: 		public async Task<List<TripSummary>> GetTripSummariesForEntitiesAsync(List<long> entityIds, DateTime fromDateTime, DateTime toDateTime) //TODO: LOOK INTO THIS!!!!
  441  		{

Fleet.Services\MiX.Fleet.Services.Data\Trips\TripsRepositoryMock.cs:
  486  			{
  487: 				StartOdometerKilometres = 100.0M,
  488: 				EndOdometerKilometres = 110.5M,
  489  				StartPosition = CreatePosition(593830843803099100, Id64.NewId(), DateTime.UtcNow),

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData\Decoder\TachoBlockDecoder.cs:
   14  			F3 = 0x0080,
   15: 			Odo = 0x0040,
   16  			I1 = 0x0020,

  188  
  189: 			if ((_fieldMask & TachoMask.Odo) == TachoMask.Odo)
  190  			{
  191  				ushort valuePart1 = BitConverter.ToUInt16(_block, 11);
  192: 				_doLines[3] = new DoOdometer(this, interval, valuePart1 + (_block[13] * 65536));
  193  			}

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData\Decoder\TachoBlockLinesDecoder.cs:
  199  
  200: 		private class DoOdometer : DoLine
  201  		{
  202: 			public DoOdometer(TachoBlockDecoder parent, TachoInterval interval, int initialValue) : base(parent, interval, initialValue)
  203  			{

  207  			{
  208: 				get { return Interval.Odometer; }
  209: 				set { Interval.Odometer = value; }
  210  			}

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData\Entities\TachoInterval.cs:
  19  				F3 = this.F3,
  20: 				Odometer = this.Odometer,
  21  				I1 = this.I1,

  32  		public decimal F3 { get; set; }
  33: 		public decimal Odometer { get; set; }
  34  		public decimal I1 { get; set; }

  40  		{
  41: 			return String.Format($"{Time:yyyy/MM/dd HH:mm:ss} F1:{Speed} F2:{RPM} F3:{F3} O:{Odometer} I1:{I1} I2:{I2} I3:{I3} I4:{I4}");
  42  		}

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData.Tests\TachoIntervalsTests.cs:
  438  			ret.F3 = (3 * seed);
  439: 			ret.Odometer = 1001 * seed;
  440  			ret.I1 = (5 * seed);

  452  			Assert.AreEqual(3.0m, interval.F3, "incorrect F3");
  453: 			Assert.AreEqual(1001.0m, interval.Odometer, "incorrect Odometer");
  454  			Assert.AreEqual(5.0m, interval.I1, "incorrect I1");

  464  			Assert.AreEqual(6.0m, interval.F3, "incorrect F3");
  465: 			Assert.AreEqual(2002.0m, interval.Odometer, "incorrect Odometer");
  466  			Assert.AreEqual(10.0m, interval.I1, "incorrect I1");

  476  			Assert.AreEqual(9.0m, interval.F3, "incorrect F3");
  477: 			Assert.AreEqual(3003.0m, interval.Odometer, "incorrect Odometer");
  478  			Assert.AreEqual(15.0m, interval.I1, "incorrect I1");

  488  			Assert.AreEqual(12.0m, interval.F3, "incorrect F3");
  489: 			Assert.AreEqual(4004.0m, interval.Odometer, "incorrect Odometer");
  490  			Assert.AreEqual(20.0m, interval.I1, "incorrect I1");

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData.Tests\TachoBlock\DecodeTachoBlockTests.cs:
   23  
   24: 			b.NextBit = false;  //Odo   010
   25  			b.NextBit = true;

   48  
   49: 			b.NextBit = false;  //Odo   010
   50  			b.NextBit = true;

   73  
   74: 			b.NextBit = false;  //Odo   010
   75  			b.NextBit = true;

   98  
   99: 			b.NextBit = false;  //Odo   010
  100  			b.NextBit = true;

  112  
  113: 		[TestMethod, TestCategory("LegacyTachoData"), Description("Skip Odo others +1, then all +2")]
  114: 		public void TachoSkipOdoOthersBy1ThenAll2Test()
  115  		{

  123  
  124: 			b.NextBit = true;   //Odo   skip
  125  

  146  
  147: 			b.NextBit = false;  //Odo   010
  148  			b.NextBit = true;

  171  
  172: 			b.NextBit = false;  //Odo   010
  173  			b.NextBit = true;

  196  
  197: 			b.NextBit = false;  //Odo   010
  198  			b.NextBit = true;

  221  
  222: 			b.NextBit = false;  //Odo   010
  223  			b.NextBit = true;

  284  			IncreaseLineBy1(b); //F3    0110
  285: 			b.NextBit = false;  //Odo   skip to next interval
  286  			b.NextBit = false;

  293  
  294: 		[TestMethod, TestCategory("LegacyTachoData"), Description("Odo + 1, skip others, then all +2")]
  295: 		public void TachoOdoBy1SkipOthersThenAll2Test()
  296  		{

  304  
  305: 			b.NextBit = false;  //Odo   010
  306  			b.NextBit = true;

  327  			b.NextBit = true;   //F3    skip
  328: 			b.NextBit = true;   //Odo   skip
  329  			b.NextBit = true;   //I1    skip

  349  																	 TachoTestBlock.TachoMask.F3 |
  350: 																	 TachoTestBlock.TachoMask.Odo |
  351  																	 TachoTestBlock.TachoMask.I1 |

  369  
  370: 			tb.NextBit = false;  //odo
  371  			tb.NextBit = true;

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData.Tests\TachoBlock\TachoBlockOdoTests.cs:
   6  	/// <summary>
   7: 	/// Group of tests to check the logic to convert the Odometer increments from the raw Tacho block
   8  	/// from unit memory into 'processable' structure.
   9: 	/// Odometer can only increase by 1 ( = 100m/second)
  10  	/// </summary>
  11  	[TestClass]
  12: 	public class TachoBlockOdoTests
  13  	{

  25  			{
  26: 				Mask = TachoTestBlock.TachoMask.Odo,
  27: 				Odometer = HeadValue
  28  			};

  34  		[TestMethod, TestCategory("LegacyTachoData"), Description("Increase by 1")]
  35: 		public void IncrementOdometerByOneTest()
  36  		{

  47  		[TestMethod, TestCategory("LegacyTachoData"), Description("set to specific")]
  48: 		public void SetOdometerTest()
  49  		{

  57  		[TestMethod, TestCategory("LegacyTachoData"), Description("")]
  58: 		public void OdometerOverFlowBitIncrementTest()
  59  		{

  90  			AddSecond();
  91: 			_intervals.NextBit = false; //Odo not skipped
  92: 			_intervals.NextBit = true;  //Odo + 1
  93  			expectedValue++;

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData.Tests\TachoBlock\TachoBlockTestBase.cs:
  22  			Assert.AreEqual((double)expected.F3, (double)result.F3, 0.000001, "not the expected F3");
  23: 			Assert.AreEqual(expected.Odometer, result.Odometer, "not the expected Odometer");
  24  			Assert.AreEqual(expected.I1, result.I1, "not the expected I1");

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData.Tests\TachoBlock\TachoTestBlock.cs:
   14  			F3 = 0x0080,
   15: 			Odo = 0x0040,
   16  			I1 = 0x0020,

  125  
  126: 		public int Odometer
  127  		{

  231  
  232: 		public void DoTest(int expectedDeltas, DateTime expectedEnd, decimal expectedSpeed, decimal expectedRpm, decimal expectedF3, decimal expectedOdo, decimal expectedI1, decimal expectedI2, decimal expectedI3, decimal expectedI4)
  233  		{

  244  				F3 = expectedF3,
  245: 				Odometer = expectedOdo,
  246  				I1 = expectedI1,

Fleet.Services\MiX.Fleet.Services.Data.LegacyTachoData.Tests\TachoBlock\TachoTestBlockTests.cs:
   83  		[TestMethod, TestCategory("LegacyTachoData")]
   84: 		public void TachoTestBlockHeaderOdoCorrect()
   85  		{

   87  			byte[] b = tb.Data;
   88: 			Assert.AreEqual(0x0064, BitConverter.ToInt16(b, 11), "incorrect odo (low bytes) for default block");
   89: 			Assert.AreEqual(0x00, b[13], "incorrect high odo byte for default block");
   90  		}

  205  		[TestMethod, TestCategory("LegacyTachoData")]
  206: 		public void TachoTestBlockSetOdoCorrect()
  207  		{
  208: 			TachoTestBlock tb = new TachoTestBlock { Odometer = 0x965A69 };
  209  
  210  			byte[] b = tb.Data;
  211: 			Assert.AreEqual(0x69, b[11], "incorrect odo (low) after set");
  212: 			Assert.AreEqual(0x5A, b[12], "incorrect odo (mid) after set");
  213: 			Assert.AreEqual(0x96, b[13], "incorrect odo (high) after set");
  214  			Assert.AreEqual(0x99, b[18], "Checksum not correct!");

Fleet.Services\MiX.Fleet.Services.Data.Tests\IntegrationTests\IntTests_Data_FuelRepository.cs:
   83  			DateTime fillDateTime = DateTime.UtcNow;
   84: 			float odometer = 0;
   85: 			if (asset.Odometer != null)
   86  			{
   87: 				odometer = asset.Odometer.Value;
   88  			}

  100  				FillDate = fillDateTime - TimeSpan.FromDays(3),
  101: 				FillOdometerKilometres = (decimal)odometer + 150,
  102  			};

  113  				FillDate = fillDateTime - TimeSpan.FromDays(2),
  114: 				FillOdometerKilometres = (decimal)odometer + 300,
  115  			};

Fleet.Services\MiX.Fleet.Services.Entities\Assets\AssetServiceHistory.cs:
  14  
  15: 		public double Odometer { get; set; }
  16  

Fleet.Services\MiX.Fleet.Services.Entities\Cost\CostEntry.cs:
  10  		public DateTime TransactionDate { get; set; }
  11: 		public decimal Odometer { get; set; }
  12  		public string Memo { get; set; }

Fleet.Services\MiX.Fleet.Services.Entities\Events\EventOtherDataTypes.cs:
   8  		public const string TotalOccurances = "TotalOccurances";
   9: 		public const string StartOdometer = "StartOdometer";
  10: 		public const string EndOdometer = "EndOdometer";
  11  		public const string VideoKey = "VideoKey";

Fleet.Services\MiX.Fleet.Services.Entities\Mapping\LocationCarrierConverter.cs:
  51  					{
  52: 						var dRadius = Convert.ToDouble(location.Radius);
  53  						var centre = new Coordinate(location.CentrePoint.Longitude, location.CentrePoint.Latitude);

Fleet.Services\MiX.Fleet.Services.Entities\Operations\OrganisationFeature.cs:
  13  	{
  14: 		DtcoDownloadManagement,
  15  		JourneyManagement,

Fleet.Services\MiX.Fleet.Services.Logic\ManagerBase.cs:
  26  
  27: 		///TODO: convert this to auto-property
  28  		protected IAuthorisationManager AuthorisationManager

  33  
  34: 		///TODO: moodify the constructors of all classes derived from ManagerBase to accept an IAuthorisationManager
  35  		protected ManagerBase(IAuthorisationManager authorisationManager)

Fleet.Services\MiX.Fleet.Services.Logic\Assets\AssetConverter.cs:
  21  				Notes = item.Notes,
  22: 				Odometer = item.Odometer,
  23  				Reference = item.Reference,

  39  				Notes = item.Notes,
  40: 				Odometer = item.Odometer,
  41  				Reference = item.Reference,

Fleet.Services\MiX.Fleet.Services.Logic\Assets\AssetsManager.cs:
  1572  				await _assetsRepository.UpdateEngineSeconds(orgId, mobileDeviceSettings.AssetId, mobileDeviceSettings.EngineSeconds.Value).ConfigureAwait(false);
  1573: 			if (mobileDeviceSettings.Odometer.HasValue)
  1574: 				await _assetsRepository.UpdateLastOdo(orgId, mobileDeviceSettings.AssetId, mobileDeviceSettings.Odometer.Value).ConfigureAwait(false);
  1575  

  1856  
  1857: 		public async Task UpdateLastOdoAsync(long organisationId, long assetId, float lastOdo)
  1858  		{
  1859: 			await _assetsRepository.UpdateLastOdo(organisationId, assetId, lastOdo).ConfigureAwait(false);
  1860  		}

  2093  
  2094: 		public async Task<float?> GetLastOdometerAsync(long assetId)
  2095  		{

  2099  			if (asset != null)
  2100: 				return asset.Odometer;
  2101  			else

Fleet.Services\MiX.Fleet.Services.Logic\Assets\AssetsManagerMock.cs:
  310  
  311: 		public Task<float?> GetLastOdometerAsync(long assetId)
  312  		{

  375  
  376: 		public Task UpdateLastOdoAsync(long organisationId, long assetId, float lastOdo)
  377  		{

Fleet.Services\MiX.Fleet.Services.Logic\Assets\IAssetsManager.cs:
  44  		Task<List<AssetSummary>> GetSummariesAsync(long accountId, List<long> groupIds);
  45: 		Task<float?> GetLastOdometerAsync(long assetId);
  46  		Task<List<Asset>> GetAssetSearchAsync(string authToken, long organisationId, List<long> groupIds, string wildCard, string searchBy, long? correlationId = null, bool useCanProtocol = false);

  62  		Task<AssetCommsDetails> GetLegacyDetailsAsync(long organisationId, long assetId);
  63: 		Task UpdateLastOdoAsync(long organisationId, long assetId, float lastOdo);
  64  		Task UpdateEngineSecondsAsync(long organisationId, long assetId, int engineSeconds);

Fleet.Services\MiX.Fleet.Services.Logic\Cost\CostConverter.cs:
  112  				Memo = entity.Memo,
  113: 				Odometer = entity.Odometer,
  114  				RecurringCostId = entity.RecurringCostId,

  131  				Memo = entity.Memo,
  132: 				Odometer = entity.Odometer,
  133  				RecurringCostId = entity.RecurringCostId,

Fleet.Services\MiX.Fleet.Services.Logic\Events\ActiveEventsManagerMock.cs:
  51  							Value = 1.5,
  52: 							StartOdometerKilometres = 100,
  53: 							EndOdometerKilometres = 150,
  54  							StartPosition = new Position(i * 2 - 1, 1 + (i % 3), DateTime.UtcNow.AddDays(-days).AddSeconds(secondsBetweenEvents * i), -34, 24) { DriverId = 1 + (i % 3) },

  87  					Value = 1.5,
  88: 					StartOdometerKilometres = 100,
  89: 					EndOdometerKilometres = 150,
  90  					StartPosition = new Position(i * 2 - 1, 1 + (i % 3), DateTime.UtcNow.AddDays(-days).AddSeconds(secondsBetweenEvents * i), -34, 24) { DriverId = 1 + (i % 3) },

Fleet.Services\MiX.Fleet.Services.Logic\Fuel\FuelManagerMock.cs:
   85  					DateTime? minDate = null, DateTime? maxDate = null,
   86: 					decimal? odometer = null,
   87  					decimal? litres = null,

  105  				FillDate = minDate.Value.AddSeconds(Random.Next(0, span)),
  106: 				FillOdometerKilometres = odometer ?? (decimal)(Random.Next(100000, 500000) / 100.0),
  107  				Litres = litres.Value,

Fleet.Services\MiX.Fleet.Services.Logic\Helper\TripTextSummaryHelper.cs:
  151  			{
  152: 				double odo = (double)(trip.EndOdometerKilomters ?? 0);
  153  				text = new SummaryText(TripMessages.RES_TIMELINE_TRIP_DISTANCE, 3);
  154  				text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.DISTANCE, tripDistance.ToString(CultureInfo.InvariantCulture), ClassType.Double, DistanceUnit));
  155: 				text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.ODO, odo.ToString(CultureInfo.InvariantCulture), ClassType.Double, DistanceUnit));
  156  				text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.UNIT, DistanceUnit, ClassType.String, translateValue: true));

  387  				text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.TRIP_DISTANCE, subTrip.DistanceKilometres.ToString(CultureInfo.InvariantCulture), ClassType.Decimal, DistanceUnit));
  388: 				text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.ODO, subTrip.EndOdometerKilometres.GetValueOrDefault().ToString(CultureInfo.InvariantCulture), ClassType.Decimal, DistanceUnit));
  389  				text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.TRIP_DISTANCE_UNITS, DistanceUnit, ClassType.String, translateValue: true));

  556  
  557: 			if (ev.StartOdometerKilometres == null || ev.StartOdometerKilometres.Value == 0)
  558  				return;
  559  
  560: 			text = new SummaryText(TripMessages.RES_TIMELINE_EVENT_ODO, 2);
  561: 			text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.ODO_VALUE, ev.StartOdometerKilometres.Value.ToString(CultureInfo.InvariantCulture), ClassType.Decimal, DistanceUnit));
  562: 			text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.ODO_UNIT, DistanceUnit, ClassType.String, translateValue: true));
  563  			timestampTexts.Add(text);

  610  
  611: 					bool validFuelEntry = ev.Litres > 0.0005 && ev.StartOdometerKilometres.HasValue && ev.EndOdometerKilometres.HasValue && (ev.EndOdometerKilometres.Value != ev.StartOdometerKilometres.Value);
  612  					decimal fuelConsumption = 0;

  614  					{
  615: 						fuelConsumption = (decimal)ev.Litres / (ev.EndOdometerKilometres.Value - ev.StartOdometerKilometres.Value);
  616  						text = new SummaryText(TripMessages.RES_TIMELINE_FUEL_CONSUMPTION, 2);

  670  
  671: 			if (!ev.EndOdometerKilometres.HasValue || ev.EndOdometerKilometres.Value == 0)
  672  				return;
  673  
  674: 			text = new SummaryText(TripMessages.RES_TIMELINE_EVENT_ODO, 2);
  675: 			text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.ODO_VALUE, ev.EndOdometerKilometres.Value.ToString(CultureInfo.InvariantCulture), ClassType.Decimal, DistanceUnit));
  676: 			text.TemplateReplacements.Add(new TextTemplateReplacement(TripMessageTokens.ODO_UNIT, DistanceUnit, ClassType.String, translateValue: true));
  677  			timestampTexts.Add(text);

Fleet.Services\MiX.Fleet.Services.Logic\Positions\PositionsManagerMock.cs:
  325  
  326: 		private Position MakeAPosition(long? positionId = null, long? assetId = null, long? driverId = null, DateTime? timestamp = null, float? odometerKilometres = null, bool includeActiveAvl = true)
  327  		{

  344  				DistanceSinceReadingKilometres = null,
  345: 				OdometerKilometres = (odometerKilometres.HasValue) ? odometerKilometres.Value : (float)(20000 + 20000 * Random.NextDouble()),
  346  				FormattedAddress = "Stellenbosch, 7600, South Africa",

Fleet.Services\MiX.Fleet.Services.Logic\Trips\TripsManagerMock.cs:
  551  
  552: 		private async Task<Trip> MakeATrip(long tripId, long assetId, long driverId, int subtripcount, DateTime? start = null, decimal? odometerKilometres = null)
  553  		{
  554  			DateTime tripStart = (start.HasValue) ? start.Value : DateTime.UtcNow.AddMinutes(-Random.Next(5 * 60, 12 * 60));
  555: 			decimal startOdometerKilometres = (odometerKilometres.HasValue) ? odometerKilometres.Value : (decimal)(Random.Next(2000000, 5000000) / 100f);
  556  			Trip trip = new Trip()

  576  				decimal distancePerTrip = Math.Round(Random.Next(90, 100) * distanceKilometres / subtripcount / 100, 2);
  577: 				SubTrip subTrip = await MakeASubTrip(trip.TripStart, trip.TripEnd, startOdometerKilometres, distancePerTrip).ConfigureAwait(false);
  578  				trip.SubTrips.Add(subTrip);
  579: 				startOdometerKilometres += distancePerTrip;
  580  			}

  584  
  585: 		private async Task<SubTrip> MakeASubTrip(DateTime subTripStart, DateTime subTripEnd, decimal startOdometerKilometres, decimal distanceKilometres)
  586  		{

  596  				DistanceKilometres = distanceKilometres,
  597: 				StartOdometerKilometres = startOdometerKilometres,
  598: 				EndOdometerKilometres = startOdometerKilometres + distanceKilometres,
  599  				StartEngineSeconds = Random.Next(100, 300),

Fleet.Services\MiX.Fleet.Services.Logic.Tests\IntegrationTests\IntTests_Logic_AssetsManager.cs:
  429  			var originalEngineHours = asset.EngineHours;
  430: 			var originalOdometer = asset.Odometer;
  431: 			MobileDeviceSettings mobileDeviceSettings = new MobileDeviceSettings { AssetId = TestParams.AssetId, SiteId = asset.SiteId, EngineSeconds = 123, Odometer = 23 };
  432  

  449  			{
  450: 				await _assetsManager.UpdateMobileDeviceSettingsAsync(TestParams.OrganisationGroupId, new MobileDeviceSettings { AssetId = TestParams.AssetId, SiteId = asset.SiteId, EngineSeconds = originalOdometer.HasValue ? Convert.ToInt32(originalEngineHours.Value.TotalSeconds) : defaultIntNull, Odometer = originalOdometer }, false).ConfigureAwait(false);
  451  			}

Fleet.Services\MiX.Fleet.Services.Logic.Tests\UnitTests\UnitTests_Logic_EventManager.cs:
  188  
  189: 		private Position MakeAPosition(long? positionId = null, long? assetId = null, long? driverId = null, DateTime? timestamp = null, float? odometerKilometres = null)
  190  		{

  207  				DistanceSinceReadingKilometres = null,
  208: 				OdometerKilometres = (odometerKilometres.HasValue) ? odometerKilometres.Value : (float)(20000 + 20000 * Random.NextDouble()),
  209  				FormattedAddress = "Stellenbosch, 7600, South Africa",

Fleet.Services\MiX.Fleet.Services.Logic.Tests\UnitTests\UnitTests_Logic_TripsManager.cs:
  370  					DistanceKilometres = 200,
  371: 					StartOdometerKilometres = 10200,
  372: 					EndOdometerKilometres = 10400,
  373  					StartEngineSeconds = 1000,

Fleet.Services\MiX.Fleet.Services.Shared\Constants\APIControllerRoutes.cs:
  109  				public const string GetTrailers = "/api/assets/organisation/{organisationId:long}/trailers";
  110: 				public const string GetLastOdometer = "/api/assets/asset/{assetId:long}/lastodometer";
  111  				public const string GetSearch = "/api/assets/asset/search";

  123  				public const string GetSummary = "/api/assets/organisation/{organisationId:long}/summary/asset/{assetId}";
  124: 				public const string UpdateLastOdo = "/api/assets/organisation/{organisationId:long}/asset/{assetId}/lastodometer";
  125: 				public const string UpdateLastOdoOld = "/api/assets/organisation/{organisationId:long}/asset/{assetId}/lastodometer/{lastOdo}";
  126  				public const string UpdateEngineSeconds = "/api/assets/organisation/{organisationId:long}/asset/{assetId}/engineseconds/{engineSeconds}";

Fleet.Services\MiX.Fleet.Services.Shared\Constants\ErrorMessages.cs:
  336  			public const string ENGINE_HOURS_MUST_BE_LESS = "The engine hours reading entered in this transaction is greater than the engine hours on a later dated transaction";
  337: 			public const string ODOMETER_MUST_BE_GREATER = "The odometer reading entered in this transaction is lower than the odometer on an earlier dated transaction";
  338: 			public const string ODOMETER_MUST_BE_LESS = "The odometer reading entered in this transaction is higher than the odometer on a later dated transaction";
  339  			public const string DUPLICATE_FUEL_RECORD = "Duplicate records for the same asset and date time are not allowed";

  387  			public const string RECURRING_COST_NAME_UNIQUE = "Recurring cost name is already in use";
  388: 			public const string ASSET_FUEL_DATA_ODOMETER_RANGE = "Odometer must be between 0 and 9999999.99";
  389  			public const string NOT_A_VALID_YEAR = "Not a valid year number";

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\Asset.cs:
  151  
  152: 		public float? Odometer { get; set; }
  153  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\AssetFuelUsage.cs:
  18  		[Required(ErrorMessage = ErrorMessages.GeneralValidation.REQUIRED)]
  19: 		public double Odometer { get; set; }
  20  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\AssetIcons.cs:
  12  		{
  13: 			//todo assetcrud: store a list in the database.
  14  			var icons = new List<string>

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\AssetServiceHistory.cs:
  18  		[Required(ErrorMessage = ErrorMessages.GeneralValidation.REQUIRED)]
  19: 		public double Odometer { get; set; }
  20  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\AssetStatusValues.cs:
  11  		public string DownloadVehicleNow { get; set; }
  12: 		public float? VehicleLastOdo { get; set; }
  13  	}

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\AssetSummary.cs:
  10  		{
  11: 			OdometerUnits = UnitsOfMeasure.Kilometres;
  12  			TargetFuelConsumptionUnits = UnitsOfMeasure.KilometresPerLitre;

  40  
  41: 		public float? Odometer { get; set; }
  42  
  43: 		public string OdometerUnits { get; set; }
  44  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\AssetTrailerDetails.cs:
  34  		public DateTime TrailerIdDate { get; set; }
  35: 		public double Odometer { get; set; }
  36: 		public DateTime? OdometerDate { get; set; }
  37  	}

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\MobileDeviceSettings.cs:
   9  		public Int32? EngineSeconds { get; set; }
  10: 		public float? Odometer { get; set; }
  11  	}

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\Trailer.cs:
  45  
  46: 		// Last odometer that was set for the trailer
  47: 		public decimal? SetOdometer { get; set; }
  48  
  49: 		// Time that the odometer was last set
  50: 		public DateTime? SetOdometerDate { get; set; }
  51  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Cost\CostTransaction.cs:
  24  		[PositiveFloat(Message = ErrorMessages.GeneralValidation.POSITIVE_FLOAT)]
  25: 		public decimal Odometer { get; set; }
  26  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Events\Event.cs:
  52  		/// <summary>
  53: 		/// Odometer of the asset at the end of the trip.
  54  		/// </summary>
  55: 		public decimal? StartOdometerKilometres { get; set; }
  56  

  67  		/// <summary>
  68: 		/// Odometer of the asset at the end of the event.
  69  		/// </summary>
  70: 		public decimal? EndOdometerKilometres { get; set; }
  71  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Fuel\FuelTransaction.cs:
  22  		/// <summary>
  23: 		/// Odometer of the asset at the time the fuel was purchased
  24  		/// </summary>
  25: 		public decimal FillOdometerKilometres { get; set; }
  26  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Messages\ActiveMessage.cs:
  17  		public double Value;
  18: 		public float Odometer;
  19  		public byte Speed;

  34  			Value = 0D;
  35: 			Odometer = 0F;
  36  			Speed = 0;

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Organisation\OrganisationFeature.cs:
  12  	{
  13: 		DtcoDownloadManagement,
  14  		JourneyManagement,

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Positions\Position.cs:
  21  		public ushort? DistanceSinceReadingKilometres { get; set; }
  22: 		public float? OdometerKilometres { get; set; }
  23  		public string FormattedAddress { get; set; }

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Reminders\AssetServiceReminder.cs:
  38  		{
  39: 			if (!EnableOnDistance || asset == null || !asset.Odometer.HasValue || !NextServiceDueAtKm.HasValue)
  40  				return null;
  41: 			return NextServiceDueAtKm.Value - asset.Odometer.Value;
  42  		}

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Trips\SubTrip.cs:
  113  		/// <summary>
  114: 		/// Odometer of the asset at the start of the sub trip.
  115  		/// </summary>
  116: 		public decimal? StartOdometerKilometres { get; set; }
  117  
  118  		/// <summary>
  119: 		/// Odometer of the asset at the end of the sub trip.
  120  		/// </summary>
  121: 		public decimal? EndOdometerKilometres { get; set; }
  122  

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Trips\Trip.cs:
  118  		/// <summary>
  119: 		/// Odometer of the asset at the end of the trip.
  120  		/// </summary>
  121: 		public decimal? EndOdometerKilomters { get; set; }
  122  

Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.Logic\AssetStatusManager\AssetStatusManagerConverter.cs:
  66  				Notes = Asset.Notes,
  67: 				Odometer = Asset.Odometer,
  68  				RegistrationNumber = Asset.RegistrationNumber,

Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.Logic\CanAdminManager\CanAdminManagerMock.cs:
  64  			"Ignition on",
  65: 			"Odometer reading",
  66  			"Road speed",

  74  			(true, null),
  75: 			(false, "Duplicate VIN error message - TODO")
  76  		};

Fleet.Services.Operations.API\Fleet.Services.Operations.Entities\DEMT\Offline\TripResult.cs:
  11  		public DateTime EndDateTime { get; set; }
  12: 		public decimal? StartOdometerKilometres { get; set; }
  13: 		public decimal? EndOdometerKilometres { get; set; }
  14  		public decimal DistanceKilometres { get; set; }

Fleet.Services.Operations.API\Fleet.Services.Operations.Entities\DEMT\Offline\TripResultCacheItem.cs:
  22  		public DateTime TripEndUtc { get; set; }
  23: 		public decimal? StartOdometerKilometres { get; set; }
  24: 		public decimal? EndOdometerKilometres { get; set; }
  25  		public decimal DistanceKilometres { get; set; }

Fleet.Services.Operations.API\Fleet.Services.Operations.Entities\DEMT\Offline\TripResultEntity.cs:
  25  		public DateTime TripEndUtc { get; set; }
  26: 		public string StartOdometer { get; set; }
  27: 		public string EndOdometer { get; set; }
  28  		public string Distance { get; set; }

  35  		public string ClassificationNote { get; set; }
  36: 		public double SortingStartOdometer { get; set; }
  37: 		public double SortingEndOdometer { get; set; }
  38  		public double SortingDistance { get; set; }

  96  				(!string.IsNullOrWhiteSpace(ClassificationNote) && !hiddenColumns.Contains("comment") && ClassificationNote.ToLower().Contains(wildCard)) ||
  97: 				(!hiddenColumns.Contains("startOdometer") && StartOdometer.ToString().ToLower().Contains(wildCard)) ||
  98: 				(!hiddenColumns.Contains("endOdometer") && EndOdometer.ToString().ToLower().Contains(wildCard)) ||
  99  				(!hiddenColumns.Contains("distance") && Distance.ToString().ToLower().Contains(wildCard)) ||

Fleet.Services.Operations.API\Fleet.Services.Operations.Entities\Positions\Position.cs:
  24  		public ushort? DistanceSinceReadingKilometres { get; set; }
  25: 		public float? OdometerKilometres { get; set; }
  26  		public string FormattedAddress { get; set; }

Fleet.Services.Operations.API\Fleet.Services.Operations.Hypermedia\Carriers\DEMT\Offline\TripResultCarrier.cs:
  19  		public ZonedDateTimeCarrier TripEnd { get; set; }
  20: 		public string StartOdometer { get; set; }
  21: 		public string EndOdometer { get; set; }
  22  		public string Distance { get; set; }

Fleet.Services.Operations.API\Fleet.Services.Operations.Logic\DataExclusionManager\DataExclusionConverter.cs:
  71  				EndDateTime = lightningTrip.EndDateTime,
  72: 				StartOdometerKilometres = lightningTrip.StartOdometerKilometres,
  73: 				EndOdometerKilometres = lightningTrip.EndOdometerKilometres,
  74  				DistanceKilometres = lightningTrip.DistanceKilometres,

Fleet.Services.Operations.API\Fleet.Services.Operations.Logic\DataExclusionManager\DataExclusionManagerMock.cs:
  140  					EndDateTime = new DateTime(2021, 6, 17, 13, 30, 0, 0),
  141: 					StartOdometerKilometres = 0,
  142: 					EndOdometerKilometres = 50,
  143  					DistanceKilometres = 50,

  156  					EndDateTime = new DateTime(2021, 6, 18, 13, 30, 0, 0),
  157: 					StartOdometerKilometres = 50,
  158: 					EndOdometerKilometres = 100,
  159  					DistanceKilometres = 50,

  172  					EndDateTime = new DateTime(2021, 6, 19, 13, 30, 0, 0),
  173: 					StartOdometerKilometres = 100,
  174: 					EndOdometerKilometres = 150,
  175  					DistanceKilometres = 50,

  188  					EndDateTime = new DateTime(2021, 6, 20, 13, 30, 0, 0),
  189: 					StartOdometerKilometres = 150,
  190: 					EndOdometerKilometres = 200,
  191  					DistanceKilometres = 50,

Fleet.Services.Operations.API\Fleet.Services.Operations.Logic\ElectricFleetManager\ElectricFleetManager.cs:
  235  					DistanceTrip = GetDistanceValue(distanceLastTrip, toUnitName),
  236: 					DistanceToday = GetDistanceValue(decimal.ToDouble(distanceTrip), toUnitName),
  237  					Efficiency = efficiency,

Fleet.Services.Operations.API\Fleet.Services.Operations.Logic\EventManager\EventManagerConverter.cs:
  90  				EventValue = item.EventValue,
  91: 				RoadSpeedLimit = Convert.ToDouble(item.RoadSpeedLimit),
  92: 				PositionLatitude = Convert.ToDouble(item.PositionLatitude),
  93: 				PositionLongitude = Convert.ToDouble(item.PositionLongitude),
  94  				LocationName = item.LocationName,

Fleet.Services.Operations.API\Fleet.Services.Operations.Logic\PositionManager\PositionManagerConverter.cs:
  46  			pos.DistanceSinceReadingKilometres = lpos.DistanceSinceReadingKilometres;
  47: 			pos.OdometerKilometres = lpos.OdometerKilometres;
  48  			pos.FormattedAddress = lpos.FormattedAddress;

Fleet.Services.Operations.API\Fleet.Services.Operations.Web.API\Controllers\TrackingOptionsController.cs:
   83  			var speedUnit = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(item.DefaultPositionFilter.SpeedThreshold, orgMeasurementType, orgConsumptionType);
   84: 			item.DefaultPositionFilter.SpeedThreshold = Convert.ToDouble(speedUnit.Value);
   85  			item.DefaultPositionFilter.SpeedUnit = MiX.Core.Conversion.Unit.KilometresPerHour;

  120  			var standardValue = UnitsConverter.ConvertSpeedUnitToStandard(carrier.DefaultPositionFilter.SpeedThreshold, UnitsConverter.GetSpeedUnit(profile));
  121: 			carrier.DefaultPositionFilter.SpeedThreshold = Convert.ToDouble(standardValue);
  122  

Fleet.Services.Operations.API\Fleet.Services.Operations.Web.API\Converters\DEMTConverter.cs:
   190  				MaxSpeed = trip.MaxSpeed,
   191: 				StartOdometer = trip.StartOdometer,
   192: 				EndOdometer = trip.EndOdometer
   193  			};

   227  				MaxSpeed = trip.MaxSpeed,
   228: 				StartOdometerKilometres = trip.StartOdometerKilometres,
   229: 				EndOdometerKilometres = trip.EndOdometerKilometres,
   230  			};

   680  			}
   681: 			else if (sortField == "startOdometer")
   682  			{
   683  				if (sortOrder == "desc")
   684: 					entities.Sort((itemA, itemB) => itemB.SortingStartOdometer.CompareTo(itemA.SortingStartOdometer));
   685  				else
   686: 					entities.Sort((itemA, itemB) => itemA.SortingStartOdometer.CompareTo(itemB.SortingStartOdometer));
   687  			}
   688: 			else if (sortField == "endOdometer")
   689  			{
   690  				if (sortOrder == "desc")
   691: 					entities.Sort((itemA, itemB) => itemB.SortingEndOdometer.CompareTo(itemA.SortingEndOdometer));
   692  				else
   693: 					entities.Sort((itemA, itemB) => itemA.SortingEndOdometer.CompareTo(itemB.SortingEndOdometer));
   694  			}

  1059  			{
  1060: 				var roundedValue = Convert.ToDouble(cachedItem.SpeedLimit.Value.ToString("F2"));
  1061  				var convertedSpeedLimit = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(roundedValue, measurementType, consumptionType);

  1079  						var difference = Math.Abs(cachedItem.Value - cachedItem.MaxSpeedKilometresPerHour.Value);
  1080: 						var roundedValue = Convert.ToDouble(difference.ToString("F2"));
  1081  						var convertedSpeedLimit = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(roundedValue, measurementType, consumptionType);

  1142  				SortingMaxSpeed = 0,
  1143: 				SortingStartOdometer = 0,
  1144: 				SortingEndOdometer = 0,
  1145  				SortingDistance = 0

  1147  
  1148: 			var roundedValue = Convert.ToDouble(cachedItem.DistanceKilometres.ToString("F2"));
  1149  			var convertedDistance = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(roundedValue, measurementType, consumptionType);

  1155  
  1156: 			roundedValue = (cachedItem.MaxSpeed.HasValue) ? Convert.ToDouble(cachedItem.MaxSpeed.Value.ToString("F2")) : 0.0;
  1157  			var convertedMaxSpeed = UnitsOfMeasureCarrierConverter.GetSpeedCarrier(roundedValue, measurementType, consumptionType);

  1163  
  1164: 			roundedValue = (cachedItem.StartOdometerKilometres.HasValue) ? Convert.ToDouble(cachedItem.StartOdometerKilometres.Value.ToString("F2")) : 0.0;
  1165: 			var convertedStartOdometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(roundedValue, measurementType, consumptionType);
  1166: 			if (convertedStartOdometer.Value.HasValue)
  1167  			{
  1168: 				entity.StartOdometer = NumberFormatter.NumberToUserFormat(convertedStartOdometer.Value.Value, cultureInfo.PositiveNumberPattern, 2);
  1169: 				entity.SortingStartOdometer = roundedValue;
  1170  			}
  1171  
  1172: 			roundedValue = (cachedItem.EndOdometerKilometres.HasValue) ? Convert.ToDouble(cachedItem.EndOdometerKilometres.Value.ToString("F2")) : 0.0;
  1173: 			var convertedEndOdometer = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(roundedValue, measurementType, consumptionType);
  1174: 			if (convertedEndOdometer.Value.HasValue)
  1175  			{
  1176: 				entity.EndOdometer = NumberFormatter.NumberToUserFormat(convertedEndOdometer.Value.Value, cultureInfo.PositiveNumberPattern, 2);
  1177: 				entity.SortingEndOdometer = roundedValue;
  1178  			}

Fleet.Services.Operations.API\Fleet.Services.Operations.Web.API\Converters\EventConverter.cs:
  104  				var distanceCarrier = UnitsOfMeasureCarrierConverter.GetDistanceCarrier(eventValue, sessionService.MeasurementType, sessionService.ConsumptionType);
  105: 				carrier.Value = distanceCarrier.Value.HasValue ? Math.Round(Convert.ToDouble(distanceCarrier.Value), 2).ToString() : "0";
  106  				carrier.ValueUnits = distanceCarrier.Unit;

  110  				var accelerationCarrier = UnitsOfMeasureCarrierConverter.GetAccelerationCarrier(eventValue, sessionService.MeasurementType, sessionService.ConsumptionType);
  111: 				carrier.Value = accelerationCarrier.Value.HasValue ? Math.Round(Convert.ToDouble(accelerationCarrier.Value), 2).ToString() : "0";
  112  				carrier.ValueUnits = accelerationCarrier.Unit;

  143  						{
  144: 							entity.Value = Convert.ToDouble(UnitsConverter.ConvertSpeedUnitToStandard((float)eventValue, UnitsConverter.GetSpeedUnit(profile)));
  145  						}

  147  						{
  148: 							entity.Value = Convert.ToDouble(UnitsConverter.ConvertDistanceUnitToStandard((float)eventValue, UnitsConverter.GetDistanceUnit(profile)));
  149  						}

  151  						{
  152: 							entity.Value = Convert.ToDouble(UnitsConverter.ConvertAccelerationToStandard((float)eventValue, UnitsConverter.GetAccelerationUnit(profile)));
  153  						}

Fleet.Services.Operations.API\Fleet.Services.Operations.Web.API\Converters\TripConverter.cs:
  17  		{
  18: 			double maxSpeed = Convert.ToDouble(trip.MaxSpeed.ToString("F2"));
  19  

GPSDriftDetecting\BorderPatroll\BorderPatroll\PositionConvertor.cs:
   35  
   36: 			DotNetCoords.LatLng latlng = new (Convert.ToDouble(_position.Latitude), Convert.ToDouble(_position.Longitude));
   37  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

   56  			text += "A,"; //Status A=active or V=Void
   57: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
   58  			text += NorthOrSouth() + ","; //Latitude N or S
   59: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
   60  			text += EastOrWest() + ","; //Longitude E or W

   90  		{
   91: 			DotNetCoords.LatLng latlng = new(Convert.ToDouble(_position.Latitude), Convert.ToDouble(_position.Longitude));
   92  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

  106  			text += TimeOnly + ","; //time
  107: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
  108  			text += NorthOrSouth() + ","; //Latitude N or S
  109: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
  110  			text += EastOrWest() + ","; //Longitude E or W

  139  		{
  140: 			DotNetCoords.LatLng latlng = new (Convert.ToDouble(_position.Latitude), Convert.ToDouble(_position.Longitude));
  141  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

  154  			string text = "$GPGLL,";
  155: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
  156  			text += NorthOrSouth() + ","; //Latitude N or S
  157: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
  158  			text += EastOrWest() + ","; //Longitude E or W

  196  			{
  197: 				double speed = Convert.ToDouble(_position.SpeedKilometresPerHour) * 0.54;
  198  				return speed.ToString();

  204  			string text;
  205: 			text = Convert.ToDouble(_position.Latitude) < 0 ? "S" : "N";
  206  			return text;

  211  			string text;
  212: 			text = Convert.ToDouble(_position.Longitude) < 0 ? "W" : "E";
  213  			return text;

GPSDriftDetecting\BorderPatroll\BorderPatrollUi\Classes\GPSData.cs:
   68  			{
   69: 				double speed = Convert.ToDouble(Velocity) * 0.54;
   70  				return speed.ToString();

   76  			string text;
   77: 			text = Convert.ToDouble(Latitude) < 0 ? "S" : "N";
   78  			return text;

   83  			string text;
   84: 			text = Convert.ToDouble(Longitude) < 0 ? "W" : "E";
   85  			return text;

  114  
  115: 			DotNetCoords.LatLng latlng = new LatLng(Convert.ToDouble(Latitude), Convert.ToDouble(Longitude));
  116  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

  135  			text += "A,"; //Status A=active or V=Void
  136: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
  137  			text += NorthOrSouth() + ","; //Latitude N or S
  138: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
  139  			text += EastOrWest() + ","; //Longitude E or W

  169  		{
  170: 			DotNetCoords.LatLng latlng = new LatLng(Convert.ToDouble(Latitude), Convert.ToDouble(Longitude));
  171  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

  185  			text += TimeOnly + ","; //time
  186: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
  187  			text += NorthOrSouth() + ","; //Latitude N or S
  188: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
  189  			text += EastOrWest() + ","; //Longitude E or W

  245  		{
  246: 			DotNetCoords.LatLng latlng = new LatLng(Convert.ToDouble(Latitude), Convert.ToDouble(Longitude));
  247  			string latSec = Math.Round((latlng.LatitudeSeconds / 60), 5).ToString().Replace("0.", "");

  260  			string text = "$GPGLL,";
  261: 			text += dblLat + ","; //Math.Round(Convert.ToDouble(lat), 6)  + ","; //Latitude
  262  			text += NorthOrSouth() + ","; //Latitude N or S
  263: 			text += dblLng + ","; //Math.Round(Convert.ToDouble(lng), 6) + ","; //Longitude
  264  			text += EastOrWest() + ","; //Longitude E or W

GPSDriftDetecting\BorderPatroll\BorderPatrollUi\Classes\TripCreator.cs:
  83  
  84: 			double incdec = Convert.ToDouble(lstGps[lstGps.Count / 2].Velocity) / max;
  85  			double velocity = 0;

GPSDriftDetecting\BorderPatroll\BorderPatrollUi\Forms\BuildTripForm.cs:
  277  
  278: 				PointLatLng fposition = new PointLatLng(Convert.ToDouble(routePoints[0].Latitude), Convert.ToDouble(routePoints[0].Longitude));
  279: 				PointLatLng lposition = new PointLatLng(Convert.ToDouble(routePoints[routePoints.Count - 1].Latitude), Convert.ToDouble(routePoints[routePoints.Count - 1].Longitude));
  280  

GPSDriftDetecting\Wibci.CountryReverseGeocode-master\Sample\Wibci.CountryReverseGeocode.Xamarin\Wibci.CountryReverseGeocode.Xamarin.UWP\App.xaml.cs:
  54                  {
  55:                     //TODO: Load state from previously suspended application
  56                  }

  92              var deferral = e.SuspendingOperation.GetDeferral();
  93:             //TODO: Save application state and stop any background activity
  94              deferral.Complete();

GPSDriftDetecting\Wibci.CountryReverseGeocode-master\Wibci.CountryReverseGeocode\CountryReverseGeocodeService.cs:
  28  
  29:         //TODO: Check again if exposed via .NET Standard
  30          //private string FetchCurrencySymbol(string threeLetterISO)

GPSDriftDetecting\Wibci.CountryReverseGeocode-master\Wibci.CountryReverseGeocode\Data\CountryData.cs:
  6      {
  7:         //TODO: more accurate data from https://gist.github.com/neilkennedy/6423661 or https://raw.githubusercontent.com/datasets/geo-boundaries-world-110m/master/countries.geojson
  8          public static List<string> DATA = new List<string>

GPSDriftDetecting\Wibci.CountryReverseGeocode-master\Wibci.CountryReverseGeocode-master\SampleProject\WibciCountryStateGeocode.XamarinSample.UWP\App.xaml.cs:
   63                  {
   64:                     //TODO: Load state from previously suspended application
   65                  }

  101              var deferral = e.SuspendingOperation.GetDeferral();
  102:             //TODO: Save application state and stop any background activity
  103              deferral.Complete();

MiX.DeviceConfig\MiX.DeviceConfig.Api.Client\DeviceConfigClient.cs:
  669  
  670:         if (string.IsNullOrEmpty(currentApplicationName))//TODO: Modify repositories to start using this param for logging purposes
  671  					throw new ArgumentNullException(nameof(currentApplicationName));

MiX.DeviceConfig\MiX.DeviceConfig.Api.Client\Interfaces\IMobileUnitRepository.cs:
  37  		Task<bool> IsDeviceEnabled(long mobileUnitId, long deviceId, long? correlationId = null);
  38: 		Task<bool> SetMobileUnitOdometerMeters(string authToken, long orgId, long mobileUnitId, long value, long oldValue, long? correlationId = null);
  39  		Task<List<long>> SendCommandToMobileUnits(string authToken, long groupId, List<long> mobileUnitIds, int commandId, uint commandType, long? correlationId = null);

  57  		Task<List<MessageStatusPerType>> GetLastMessageStatusesForTypes(string authToken, long groupId, long mobileUnitId, List<long> typeIds, long? correlationId = null);
  58: 		Task ClearServersideOffsets(string authToken, long orgId, long mobileUnitId, bool clearOdoOffset = false, bool clearEngineHoursOffset = false);
  59  		Task UpdateMobileUnitMessageStatus(string authToken, long groupId, long mobileUnitId, long messageId, MessageStateType messageStatus, long? correlationId = null);

  78  
  79: 		[Obsolete("CanSetOdo is deprecated, please use CanSetOdo2 instead.")]
  80: 		Task<bool> CanSetOdo(string authToken, long mobileUnitId, long? correlationId = null);
  81: 		Task<FailReason> CanSetOdo2(string authToken, long mobileUnitId, long? correlationId = null);
  82  

MiX.DeviceConfig\MiX.DeviceConfig.Api.Client\Repositories\MobileUnitRepository.cs:
   325  
   326: 		public async Task<bool> SetMobileUnitOdometerMeters(string authToken, long orgId, long mobileUnitId, long value, long oldValue, long? correlationId = null)
   327  		{

   329  			{
   330: 				var request = NewPostRequest($"{PostPutApiUrl}/groupId/{orgId}/mobile-units/{mobileUnitId}/odometer/{value}/{oldValue}?authToken={authToken}", new object { }, correlationId);
   331  				return request;

   417  
   418: 		public async Task ClearServersideOffsets(string authToken, long orgId, long mobileUnitId, bool clearOdoOffset = false, bool clearEngineHoursOffset = false)
   419  		{

   421  			{
   422: 				var request = NewPutRequest($"{PostPutApiUrl}/groupId/{orgId}/mobile-units/{mobileUnitId}/clear-serverside-offsets?authToken={authToken}&clearOdoOffset={clearOdoOffset}&clearEngineHoursOffset={clearEngineHoursOffset}", new object { });
   423  				return request;

   977  
   978: 		public async Task<bool> CanSetOdo(string authToken, long mobileUnitId, long? correlationId = null)
   979  		{

   981  			{
   982: 				CommandIdType commandTypeId = CommandIdType.SetOdometerOffset;
   983: 				var request = NewGetRequest($"{PostPutApiUrl}/mobile-units/{mobileUnitId}/command-type/{commandTypeId}/can-set-odo-or-enginehours?authToken={authToken}", correlationId);
   984  				return request;

   990  
   991: 		public async Task<FailReason> CanSetOdo2(string authToken, long mobileUnitId, long? correlationId = null)
   992  		{

   994  			{
   995: 				CommandIdType commandTypeId = CommandIdType.SetOdometerOffset;
   996: 				var request = NewGetRequest($"{PostPutApiUrl}/mobile-units/{mobileUnitId}/command-type/{commandTypeId}/can-set-odo-or-enginehours2?authToken={authToken}", correlationId);
   997  				return request;

  1013  				CommandIdType commandTypeId = CommandIdType.SetEngineHoursOffset;
  1014: 				var request = NewGetRequest($"{PostPutApiUrl}/mobile-units/{mobileUnitId}/command-type/{commandTypeId}/can-set-odo-or-enginehours?authToken={authToken}", correlationId);
  1015  				return request;

  1026  				CommandIdType commandTypeId = CommandIdType.SetEngineHoursOffset;
  1027: 				var request = NewGetRequest($"{PostPutApiUrl}/mobile-units/{mobileUnitId}/command-type/{commandTypeId}/can-set-odo-or-enginehours2?authToken={authToken}", correlationId);
  1028  				return request;

MiX.DeviceConfig\MiX.DeviceConfig.Api.Client.Tests\MobileUnitTests.cs:
  263  		[TestMethod]
  264: 		public void SetMobileUnitOdometerMeters()
  265  		{

  271  			//Run
  272: 			var result = DeviceConfigClient.MobileUnits.SetMobileUnitOdometerMeters(authtoken, groupId, mobileUnitId, meters, oldMeters, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  273: 			var setOdo = DeviceConfigClient.MobileUnits.GetMobileUnitConfiguration(authtoken, mobileUnitId);
  274  			//Assert
  275  			Assert.IsTrue(result); //Has to return TRUE in order to verify the change has been sent.			
  276: 														 //Assert.AreEqual(setOdo, meters);
  277  			#endregion M2K

  283  			//Run
  284: 			var resultM4K = DeviceConfigClient.MobileUnits.SetMobileUnitOdometerMeters(authtoken, groupIdM4K, mobileUnitIdM4K, metersM4K, oldMeters, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  285: 			var setOdoM4K = DeviceConfigClient.MobileUnits.GetMobileUnitConfiguration(authtoken, mobileUnitIdM4K);
  286  			//Assert
  287  			Assert.IsTrue(resultM4K); //Has to return TRUE in order to verify the change has been sent.			
  288: 																//Assert.AreEqual(setOdoM4K, metersM4K);
  289  			#endregion M4K

  295  			//Run
  296: 			var resultM6K = DeviceConfigClient.MobileUnits.SetMobileUnitOdometerMeters(authtoken, groupIdM6K, mobileUnitIdM6K, metersM6K, oldMeters, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  297: 			var setOdoM6K = DeviceConfigClient.MobileUnits.GetMobileUnitConfiguration(authtoken, mobileUnitIdM6K);
  298  			//Assert
  299  			Assert.IsTrue(resultM6K); //Has to return TRUE in order to verify the change has been sent.			
  300: 																//Assert.AreEqual(setOdoM6K, metersM6K);
  301  			#endregion M6K

  307  			//Run
  308: 			var resultFM = DeviceConfigClient.MobileUnits.SetMobileUnitOdometerMeters(authtoken, groupIdFM, mobileUnitIdFM, metersFM, oldMeters, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  309: 			var setOdoFM = DeviceConfigClient.MobileUnits.GetMobileUnitConfiguration(authtoken, mobileUnitIdFM);
  310  			//Assert
  311  			Assert.IsTrue(resultFM); //Has to return TRUE in order to verify the change has been sent.			
  312: 															 //Assert.AreEqual(setOdoFM, metersFM);
  313  			#endregion FM

  326  			var result = DeviceConfigClient.MobileUnits.SetMobileUnitEngineSeconds(authtoken, groupId, mobileUnitId, seconds, oldseconds, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  327: 			var setOdo = DeviceConfigClient.MobileUnits.GetMobileUnitConfiguration(authtoken, mobileUnitId);
  328  			//Assert
  329  			Assert.IsTrue(result); //Has to return TRUE in order to verify the change has been sent.			
  330: 														 //Assert.AreEqual(setOdo, meters);
  331  			#endregion M2K

  338  			var resultM4K = DeviceConfigClient.MobileUnits.SetMobileUnitEngineSeconds(authtoken, groupIdM4K, mobileUnitIdM4K, secondsM4K, oldseconds, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  339: 			var setOdoM4K = DeviceConfigClient.MobileUnits.GetMobileUnitConfiguration(authtoken, mobileUnitIdM4K);
  340  			//Assert
  341  			Assert.IsTrue(resultM4K); //Has to return TRUE in order to verify the change has been sent.			
  342: 																//Assert.AreEqual(setOdoM4K, metersM4K);
  343  			#endregion M4K

  350  			var resultM6K = DeviceConfigClient.MobileUnits.SetMobileUnitEngineSeconds(authtoken, groupIdM6K, mobileUnitIdM6K, secondsM6K, oldseconds, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  351: 			var setOdoM6K = DeviceConfigClient.MobileUnits.GetMobileUnitConfiguration(authtoken, mobileUnitIdM6K);
  352  			//Assert
  353  			Assert.IsTrue(resultM6K); //Has to return TRUE in order to verify the change has been sent.			
  354: 																//Assert.AreEqual(setOdoM6K, metersM6K);
  355  			#endregion M6K

  362  			var resultFM = DeviceConfigClient.MobileUnits.SetMobileUnitEngineSeconds(authtoken, groupIdFM, mobileUnitIdFM, secondsFM, oldseconds, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  363: 			var setOdoFM = DeviceConfigClient.MobileUnits.GetMobileUnitConfiguration(authtoken, mobileUnitIdFM);
  364  			//Assert
  365  			Assert.IsTrue(resultFM); //Has to return TRUE in order to verify the change has been sent.			
  366: 															 //Assert.AreEqual(setOdoFM, metersFM);
  367  			#endregion FM

  472  			//Assert
  473: 			Assert.IsTrue(result.Count > 0); //TODO: MR: This might be wrong - might need to be something else
  474  		}

  626  			mobileUnitConfigCounters.EngineHours = 100;
  627: 			mobileUnitConfigCounters.Odometer = 100;
  628  

  818  			//Run Test
  819: 			//TODO: Compare to values from GetEffectiveDevicePropertyForAssets once it's implemented
  820  			var result = DeviceConfigClient.MobileUnits.GetAvlFrequenciesForOrganisation(1686880341835301320).ConfigureAwait(false).GetAwaiter().GetResult();

  851  		[TestMethod]
  852: 		public void CanSetOdo2()
  853  		{

  860  				//Run
  861: 				var result = DeviceConfigClient.MobileUnits.CanSetOdo2(authtoken, mobileUnitId, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();
  862  

  867  			{
  868: 				throw new Exception($"CanSetOdo2 Exception Response:{ex.InnerException}.");
  869  			}

MiX.DeviceConfig\MiX.DeviceConfig.Api.TestApp\Program.cs:
  100  				//AddMobilePhoneToConfigurationGroup(authToken.Result.AuthToken).Wait();
  101: 				//CanSetOdo(authToken.Result.AuthToken, correlationId).Wait();
  102  				//CanSetEngineHours(authToken.Result.AuthToken, correlationId).Wait();

  547  
  548: 		//TODO: MR: Wil be replaces with the correct one after the new client release
  549  		/*

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Constants\LogicalDevices.cs:
  145  		public const long ELVIST = -7357202562364966061;
  146: 		public const long SSC_DTCO_ODOMETER = 4934038548513523645;
  147  		public const long STATE_LINE_CROSSING = -4508727509657924314;

  183  		public const long WIRELESS_TRAILER = 7698308803231676529;
  184: 		public const long ESTIMATED_ODOMETER = 1819976686812319282;
  185  

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Constants\Parameters.cs:
  23  		public const long SECURITY_DOOR_OPENED = -4233166622477704110;
  24: 		public const long ODOMETER_READING = -1713759862616416942;
  25  

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Constants\Properties.cs:
  293  		public const long VEHICLE_MODE = 861815269745509287;								// in trip or out of trip
  294: 		public const long UNIT_RAW_ODOMETER = -3166755750272960197;					// latest/current unit raw odometer
  295  		public const long IMSI = 6851923534434202573;

  306  		public const long LAST_ENGINE_SECONDS = 6893797481547706791;
  307: 		public const long ODOMETER_OFFSET = 8490551348185075979;
  308: 		public const long NEW_ODOMETER_SET = -2956425554789101238;            // display value used trigger offset calc, is set back to null after calc
  309: 		public const long ASSET_LAST_DISPLAY_ODOMETER = 3244460969911708137;  // we are now also keeping display odometer on this property
  310: 		public const long LAST_TRIP_END_ODOMETER = -4403033164446606692;      // raw/unadjusted value
  311: 		public const long LAST_SUB_TRIP_START_ODOMETER = 6773359667847016217;
  312: 		public const long NEW_ODOMETER_SET_VIA_COMMAND = -4689082902081293200;
  313  		public const long IGNITION_STATE_CHANGE = 6401396132085856906;

  316  		public const long LAST_TRIP_END_ENGINESECONDS = 3216237213180461524;	// raw/unadjusted value
  317: 		public const long UNIT_RAW_ENGINESECONDS = 4381654912478035426;       // latest/current unit raw odometer at sub trip start, sub trip end or trip end
  318  		public const long ENGINE_SECONDS_FROM_FW = 7137212167058343636;       // Holds value of FW-reported EngineSeconds - indicates that unit has transitioned from Config to FW based E/H (MX46-977)

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\EventActions\IRecordingAction.cs:
  12  		/// <summary>
  13: 		/// Gets or sets whether to record the start odometer reading.
  14  		/// </summary>
  15: 		bool StartOdometer { get; set; }
  16  
  17  		/// <summary>
  18: 		/// Gets or sets whether to record the end odometer reading.
  19  		/// </summary>
  20: 		bool EndOdometer { get; set; }
  21  

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\EventActions\RecordingActionHelper.cs:
   9  	{
  10: 		public static string ActionSettings => $"<settings recordType='{(int)RecordingTypes.Summarised}' startOdometer='0' endOdometer='0' startPosition='0' endPosition='0' video='0' pulse='0' />"; 
  11  		

  62  		/// <summary>
  63: 		/// Gets or sets whether to record the start odometer reading.
  64  		/// </summary>
  65: 		public bool StartOdometer
  66  		{
  67: 			get { return _settings.GetBool("startOdometer"); }
  68: 			set { _settings.Set("startOdometer", value); }
  69  		}

  71  		/// <summary>
  72: 		/// Gets or sets whether to record the end odometer reading.
  73  		/// </summary>
  74: 		public bool EndOdometer
  75  		{
  76: 			get { return _settings.GetBool("endOdometer"); }
  77: 			set { _settings.Set("endOdometer", value); }
  78  		}

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\LibraryLevel\LibraryDeviceProperty.cs:
  21  		public int UiSortOrder { get; set; }
  22: 		public virtual DefinitionProperty PropertyDefinition { get; set; } //TODO HM: Figure out how to get rid of this Overlapping aggregates
  23  		public IEnumerable<ValidationResult> Validate()

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\LibraryLevel\EventActions\RecordingAction.cs:
  19  		/// <summary>
  20: 		/// Gets or sets whether to record the start odometer reading.
  21  		/// </summary>
  22: 		public bool StartOdometer
  23  		{
  24: 			get { return _helper.StartOdometer; }
  25: 			set { _helper.StartOdometer = value; }
  26  		}

  28  		/// <summary>
  29: 		/// Gets or sets whether to record the end odometer reading.
  30  		/// </summary>
  31: 		public bool EndOdometer
  32  		{
  33: 			get { return _helper.EndOdometer; }
  34: 			set { _helper.EndOdometer = value; }
  35  		}

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\MobileUnitLevel\AssetConfigFileEventsSection.cs:
   9          public bool Video { get; set; }
  10:         public bool StartOdometer { get; set; }
  11:         public bool EndOdometer { get; set; }
  12          public bool StartPosition { get; set; }

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\MobileUnitLevel\EventCameraDetail.cs:
  6  {
  7: 	//TODO: look to remove as it may only have been used by STM-768 old version
  8  	public class EventCameraDetail

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\MobileUnitLevel\MobileUnitConfigCounters.cs:
  10  	{
  11: 		public int? Odometer { get; set; }
  12  		public int? EngineHours { get; set; }

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\MobileUnitLevel\MobileUnitConfiguration.cs:
  18  		public string ErrorMessage { get; set; }
  19: 		public decimal OdometerOffsetSeed_ReadOnly { get; set; }
  20  		public long MobileDeviceId { get; set; }

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\MobileUnitLevel\MobileUnitDiagnosticsTripInformation.cs:
  10  		public decimal? Speed { get; set; }
  11: 		public decimal? Odometer { get; set; }
  12  		public long? EngineHours { get; set; }

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\MobileUnitLevel\MobileUnitStatusMessage.cs:
  11  		public string VehicleMode { get; set; }
  12: 		public uint? Odometer { get; set; }
  13  		public ulong? Imsi { get; set; }

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\MobileUnitLevel\EventActions\OverridenRecordingAction.cs:
  19  		/// <summary>
  20: 		/// Gets or sets whether to record the start odometer reading.
  21  		/// </summary>
  22: 		public bool StartOdometer
  23  		{
  24: 			get { return _helper.StartOdometer; }
  25: 			set { _helper.StartOdometer = value; }
  26  		}

  28  		/// <summary>
  29: 		/// Gets or sets whether to record the end odometer reading.
  30  		/// </summary>
  31: 		public bool EndOdometer
  32  		{
  33: 			get { return _helper.EndOdometer; }
  34: 			set { _helper.EndOdometer = value; }
  35  		}

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\Operations\OrganisationFeature.cs:
  12  	{
  13: 		DtcoDownloadManagement,
  14  		JourneyManagement,

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\ResolvedConfig\Event\EventActions\ObjRecordingAction.cs:
  24  
  25: 		public bool StartOdometer
  26  		{
  27: 			get { return _helper.StartOdometer; }
  28: 			set { _helper.StartOdometer = value; }
  29  		}
  30  
  31: 		public bool EndOdometer
  32  		{
  33: 			get { return _helper.EndOdometer; }
  34: 			set { _helper.EndOdometer = value; }
  35  		}

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\TemplateLevel\TemplateDeviceParameter.cs:
  21  
  22: 		//TODO CONFIG: Get rid of the below 2 properties, all you should need are the definition level id's
  23  		public long LibraryParameterId { get; set; }

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\TemplateLevel\EventActions\TemplateRecordingAction.cs:
  19  		/// <summary>
  20: 		/// Gets or sets whether to record the start odometer reading.
  21  		/// </summary>
  22: 		public bool StartOdometer
  23  		{
  24: 			get { return _helper.StartOdometer; }
  25: 			set { _helper.StartOdometer = value; }
  26  		}

  28  		/// <summary>
  29: 		/// Gets or sets whether to record the end odometer reading.
  30  		/// </summary>
  31: 		public bool EndOdometer
  32  		{
  33: 			get { return _helper.EndOdometer; }
  34: 			set { _helper.EndOdometer = value; }
  35  		}

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Enums\CommandIdType.cs:
  126  		/// <summary>
  127: 		/// Send command to request change in unit set odometer offset
  128  		/// </summary>
  129  		[Languaging(isLanguaged: false)]
  130: 		SetOdometerOffset = 104,
  131  

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Extensions\String\Extensions.cs:
  126  
  127: 		public static double ToDouble(this string _this)
  128  		{

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Utilities\CommsMessageTypeConverter.cs:
  112  		/// <param name="statusFlagsParameter"></param>
  113: 		/// <param name="odometer"></param>
  114  		/// <param name="imsi"></param>

  121  		public static MobileUnitStatusMessage GetMobileUnitStatusMessage(long imei, DateTime deviceDateTime, uint? actionReplyParameterFlagsVal,
  122: 			bool? vehicleInTrip, uint? odometer, ulong? imsi, string firmwareVersion,
  123  			string platformVersion, string externalSupplyVoltageInMillivolts, MobileUnitGPSData gpsData)

  140  			}
  141: 			if (!actionReplyParameterFlags.HasValue || actionReplyParameterFlags.Value.HasFlag(ActionReplyParameterFlags.Odometer))
  142: 				muStatus.Odometer = odometer;
  143  			if (!actionReplyParameterFlags.HasValue || actionReplyParameterFlags.Value.HasFlag(ActionReplyParameterFlags.Imsi))

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Utilities\ExternalEnums.cs:
  106  		PlatformInfo = 256,
  107: 		Odometer = 512,
  108  		BatteryState = 1024,

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Validation\Guard.cs:
  6  	/// Guard provides a mechanism for checking and throwing exceptions if the arguments are null or empty.
  7: 	/// It follows Design By Contract (DbC) software correctness methodology.
  8  	/// </summary>

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core\Extensions\String\Extensions.cs:
  160  
  161: 		public static double ToDouble(this string _this)
  162  		{

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core\Validation\Validator.cs:
   19  
   20: 		//	// TODO: Cache this information somewhere as it could end up being a bottleneck.
   21  

   75  		//{
   76: 		//	// TODO: Cache this information somewhere as it could end up being a bottleneck.
   77  

  127  		//{
  128: 		//	// TODO: Cache this information somewhere as it could end up being a bottleneck.
  129  

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core.DeviceState\DeviceStateRepository.cs:
  144  
  145: 					// TODO: solve the problem of detecting duplicates and then updating their value's and update times
  146  					while (_updateQueueTenSeconds.TryDequeue(out DeviceStateValue item))

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core.DeviceState\MobileUnitState.cs:
   55  		private readonly IEngineHoursState _engineHoursState;
   56: 		private readonly IOdometerState _odometerState;
   57  		

   66  			_engineHoursState = new EngineHoursState(deviceStateRepository, redisCache, cache);
   67: 			_odometerState = new OdometerState(deviceStateRepository, redisCache, cache);
   68  		}

  203  
  204: 			decimal odometerOffset = _odometerState.GetOdometerOffset(mobileUnitId);
  205  

  211  
  212: 				info.Odometer = _odometerState.GetAssetLastTripEndOdometer(mobileUnitId) + odometerOffset;
  213  

  240  
  241: 				info.Odometer = _odometerState.GetUnitRawOdometer(mobileUnitId) + odometerOffset;
  242  

  244  
  245: 				info.CurrentSubTripDistance =  info.Odometer - _odometerState.GetAssetSubTripStartOdometer(mobileUnitId);
  246  

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core.DeviceState\OdometerState.cs:
    7  {
    8: 	public interface IOdometerState
    9  	{
   10: 		decimal GetOdometerOffset(long mobileUnitId);
   11  
   12: 		void SetRawOdometerFromTripEnd(long mobileUnitId, decimal rawOdo);
   13  		
   14: 		void CheckIfOdoOffsetRecalculationIsNeeded(long mobileUnitId, decimal tripStartOdometer = 0);
   15  
   16: 		decimal? GetAssetLastDisplayOdometer(long mobileUnitId);
   17  
   18: 		decimal? GetAssetLastTripEndOdometer(long mobileUnitId);
   19  
   20: 		void ClearOdoOffsetCacheOnly(long mobileUnitId);
   21  
   22: 		void ClearOdometerOffsets(long mobileUnitId);
   23  
   24: 		void SetUnitRawOdometer(long mobileUnitId, decimal odometer);
   25  
   26: 		decimal GetUnitRawOdometer(long mobileUnitId);
   27  
   28: 		void SetAssetLastDisplayOdometer(long mobileUnitId, decimal odometer);
   29  
   30: 		void SetAssetSubTripStartOdometer(long mobileUnitId, decimal odometer);
   31  
   32: 		decimal GetAssetSubTripStartOdometer(long mobileUnitId);
   33: 		bool WasLastTripEndOdoUpdatedAfterTime(long mobileUnitId, DateTime dateTime);
   34: 		void SetMessageIdForOdometerViaCommand(long mobileUnitId, long messageId);
   35: 		bool WasOdometerSetViaCommand(long mobileUnitId);
   36  
   37: 		void ForceNewOdoSetToLastDisplayOdo(long mobileUnitId);
   38  

   40  
   41: 	public class OdometerState : IOdometerState
   42  	{

   46  
   47: 		public OdometerState(IDeviceStateRepository deviceStateRepository, IRedisMobileUnitStateCache redisCache, ICache cache)
   48  		{

   53  
   54: 		public void CheckIfOdoOffsetRecalculationIsNeeded(long mobileUnitId, decimal tripStartOdometer = 0)
   55  		{
   56: 			DeviceStateValue deviceStateValueNewOdo = _deviceStateRepository.GetState(mobileUnitId, Properties.NEW_ODOMETER_SET);
   57  
   58: 			if (deviceStateValueNewOdo != default && !string.IsNullOrWhiteSpace(deviceStateValueNewOdo.Value))
   59  			{
   60: 				if (decimal.TryParse(deviceStateValueNewOdo.Value, out decimal newDisplayOdometer))
   61  				{
   62: 					DeviceStateValue deviceStateValue = _deviceStateRepository.GetState(mobileUnitId, Properties.LAST_TRIP_END_ODOMETER);
   63  

   66  					if (deviceStateValue != default && !string.IsNullOrWhiteSpace(deviceStateValue.Value) && 
   67: 						decimal.TryParse(deviceStateValue.Value, out decimal lastTripEndOdometer))
   68  					{
   69: 						newOffset = newDisplayOdometer - lastTripEndOdometer;
   70  					}

   72  					{
   73: 						newOffset = newDisplayOdometer - tripStartOdometer;
   74  					}
   75  
   76: 					_cache.SetItem(CommonState.GetPropertyCacheKey(mobileUnitId, Properties.ODOMETER_OFFSET), newOffset, CommonState.TimeoutOneHour);
   77  
   78: 					_deviceStateRepository.SetState(mobileUnitId, Properties.ODOMETER_OFFSET, newOffset.Normalize().ToString(), interval: UpdateInterval.Immediate);
   79  
   80: 					_deviceStateRepository.SetState(mobileUnitId, Properties.NEW_ODOMETER_SET, string.Empty, interval: UpdateInterval.Immediate);
   81  				}

   84  
   85: 		public decimal? GetAssetLastDisplayOdometer(long mobileUnitId)
   86  		{
   87: 			string redisRawOdo = _redisCache.GetItem(mobileUnitId, Properties.ASSET_LAST_DISPLAY_ODOMETER);
   88  
   89: 			if (!string.IsNullOrWhiteSpace(redisRawOdo))
   90  			{
   91: 				return DecimalParse(redisRawOdo);
   92  			}
   93  
   94: 			DeviceStateValue dvs = _deviceStateRepository.GetState(mobileUnitId, Properties.ASSET_LAST_DISPLAY_ODOMETER);
   95  

   99  			{
  100: 				_redisCache.SetItem(mobileUnitId, result.Normalize().ToString(), Properties.ASSET_LAST_DISPLAY_ODOMETER);
  101  

  107  
  108: 		public decimal? GetAssetLastTripEndOdometer(long mobileUnitId)
  109  		{
  110: 			string redisRawOdo = _redisCache.GetItem(mobileUnitId, Properties.LAST_TRIP_END_ODOMETER);
  111  
  112: 			if (!string.IsNullOrWhiteSpace(redisRawOdo))
  113  			{
  114: 				return DecimalParse(redisRawOdo);
  115  			}

  118  
  119: 			DeviceStateValue dvs = _deviceStateRepository.GetState(mobileUnitId, Properties.LAST_TRIP_END_ODOMETER);
  120  

  122  			{
  123: 				_redisCache.SetItem(mobileUnitId, result.Normalize().ToString(), Properties.LAST_TRIP_END_ODOMETER);
  124  

  130  
  131: 		public decimal GetOdometerOffset(long mobileUnitId)
  132  		{
  133: 			decimal odometerOffset = 0;
  134  

  136  			{
  137: 				string key = CommonState.GetPropertyCacheKey(mobileUnitId, Properties.ODOMETER_OFFSET);
  138  

  143  
  144: 				DeviceStateValue deviceStateValue = _deviceStateRepository.GetState(mobileUnitId, Properties.ODOMETER_OFFSET);
  145  

  147  				{ 
  148: 					odometerOffset = DecimalParse(deviceStateValue.Value);
  149  				}
  150  
  151: 				_cache.SetItem(key, odometerOffset, CommonState.TimeoutOneHour);
  152  			}

  157  
  158: 			return odometerOffset;
  159  		}

  179  
  180: 		public void SetRawOdometerFromTripEnd(long mobileUnitId, decimal rawOdo)
  181  		{
  182: 			_redisCache.SetItem(mobileUnitId, rawOdo.Normalize().ToString(), Properties.LAST_TRIP_END_ODOMETER);
  183: 			_deviceStateRepository.SetState(mobileUnitId, Properties.LAST_TRIP_END_ODOMETER, rawOdo.Normalize().ToString(), interval: UpdateInterval.Immediate);
  184  		}
  185  
  186: 		public void SetUnitRawOdometer(long mobileUnitId, decimal odometer)
  187  		{
  188: 			_redisCache.SetItem(mobileUnitId, odometer.Normalize().ToString(), Properties.UNIT_RAW_ODOMETER);
  189  
  190: 			_deviceStateRepository.SetState(mobileUnitId, Properties.UNIT_RAW_ODOMETER, odometer.Normalize().ToString(), interval: UpdateInterval.OneMinute);
  191  		}
  192  
  193: 		public void ClearOdoOffsetCacheOnly(long mobileUnitId)
  194  		{

  197  			{
  198: 				_deviceStateRepository.LogAsDebug($"Safely clearing odometer cached offsets because vehicle is confirmed to be out of trip");
  199  
  200: 				_cache.RemoveItem(CommonState.GetPropertyCacheKey(mobileUnitId, Properties.ODOMETER_OFFSET));
  201  			}

  203  			{
  204: 				_deviceStateRepository.LogAsDebug($"Cannot clearing odometer cached offsets because vehicle is confirmed to be in trip");
  205  			}

  221  
  222: 		public void ClearOdometerOffsets(long mobileUnitId)
  223  		{

  226  			{ 
  227: 				_deviceStateRepository.LogAsDebug($"Safely clearing odometer offsets in state DB and Redis because vehicle is confirmed to be out of trip");
  228  				
  229: 				_deviceStateRepository.SetState(mobileUnitId, Properties.ODOMETER_OFFSET, "0", interval: UpdateInterval.Immediate);
  230  
  231: 				_deviceStateRepository.SetState(mobileUnitId, Properties.NEW_ODOMETER_SET, string.Empty, interval: UpdateInterval.Immediate);
  232  
  233: 				_deviceStateRepository.SetState(mobileUnitId, Properties.NEW_ODOMETER_SET_VIA_COMMAND, string.Empty, interval: UpdateInterval.Immediate);
  234  			}

  236  			{
  237: 				_deviceStateRepository.LogAsDebug($"Cannot clearing odometer offsets in state DB and Redis because vehicle is confirmed to be in trip");
  238  			}

  240  
  241: 		public void SetAssetLastDisplayOdometer(long mobileUnitId, decimal odometer)
  242  		{
  243: 			// CONFIG-3697 Do not set Asset Last Display Odo if New Odo Set value present
  244: 			DeviceStateValue deviceStateValueNewOdo = _deviceStateRepository.GetState(mobileUnitId, Properties.NEW_ODOMETER_SET);
  245  
  246: 			if (deviceStateValueNewOdo == null || deviceStateValueNewOdo == default || string.IsNullOrWhiteSpace(deviceStateValueNewOdo.Value))
  247  			{
  248: 				_redisCache.SetItem(mobileUnitId, odometer.Normalize().ToString(), Properties.ASSET_LAST_DISPLAY_ODOMETER);
  249: 				_deviceStateRepository.SetState(mobileUnitId, Properties.ASSET_LAST_DISPLAY_ODOMETER, odometer.Normalize().ToString(), interval: UpdateInterval.Immediate);
  250  			}

  252  
  253: 		public decimal GetUnitRawOdometer(long mobileUnitId)
  254  		{

  258  			{
  259: 				string redisRawOdo = _redisCache.GetItem(mobileUnitId, Properties.UNIT_RAW_ODOMETER);
  260  
  261: 				if(decimal.TryParse(redisRawOdo, out decimal result))
  262  				{

  265  
  266: 				DeviceStateValue value = _deviceStateRepository.GetState(mobileUnitId, Properties.UNIT_RAW_ODOMETER);
  267  
  268  				if(value != default && !string.IsNullOrWhiteSpace(value.Value) 
  269: 					&& decimal.TryParse(value.Value, out decimal rawOdo))
  270  				{
  271: 					_redisCache.SetItem(mobileUnitId, value.Value, Properties.UNIT_RAW_ODOMETER);
  272  
  273: 					return rawOdo;
  274  				}

  283  
  284: 		public void SetAssetSubTripStartOdometer(long mobileUnitId, decimal odometer)
  285  		{
  286: 			_redisCache.SetItem(mobileUnitId, odometer.Normalize().ToString(), Properties.LAST_SUB_TRIP_START_ODOMETER);
  287  
  288: 			_deviceStateRepository.SetState(mobileUnitId, Properties.LAST_SUB_TRIP_START_ODOMETER, odometer.Normalize().ToString(), interval: UpdateInterval.OneMinute);
  289  		}
  290  
  291: 		public decimal GetAssetSubTripStartOdometer(long mobileUnitId)
  292  		{

  294  			{
  295: 				string redisRawOdo = _redisCache.GetItem(mobileUnitId, Properties.LAST_SUB_TRIP_START_ODOMETER);
  296  
  297: 				if (decimal.TryParse(redisRawOdo, out decimal result))
  298  				{

  301  
  302: 				DeviceStateValue value = _deviceStateRepository.GetState(mobileUnitId, Properties.LAST_SUB_TRIP_START_ODOMETER);
  303  
  304  				if (value != default && !string.IsNullOrWhiteSpace(value.Value) 
  305: 					&& decimal.TryParse(value.Value, out decimal rawOdo))
  306  				{
  307: 					return rawOdo;
  308  				}

  316  		}
  317: 		public bool WasLastTripEndOdoUpdatedAfterTime(long mobileUnitId, DateTime dateTime)
  318  		{
  319: 			DeviceStateValue state = _deviceStateRepository.GetState(mobileUnitId, Properties.LAST_TRIP_END_ODOMETER);
  320  			if (state != null && !string.IsNullOrEmpty(state.Value))

  326  
  327: 		public void SetMessageIdForOdometerViaCommand(long mobileUnitId, long messageId)
  328  		{
  329: 			_deviceStateRepository.SetState(mobileUnitId, Properties.NEW_ODOMETER_SET_VIA_COMMAND, messageId.ToString(), messageDateTime: DateTime.UtcNow, interval: UpdateInterval.Immediate);
  330  		}
  331  
  332: 		public bool WasOdometerSetViaCommand(long mobileUnitId)
  333  		{
  334: 			DeviceStateValue state = _deviceStateRepository.GetState(mobileUnitId, Properties.NEW_ODOMETER_SET_VIA_COMMAND);
  335  			return (state != null && !string.IsNullOrEmpty(state.Value));

  337  
  338: 		public void ForceNewOdoSetToLastDisplayOdo(long mobileUnitId)
  339  		{
  340: 			DeviceStateValue deviceStateValueNewOdo = _deviceStateRepository.GetState(mobileUnitId, Properties.NEW_ODOMETER_SET);
  341  
  342: 			if (deviceStateValueNewOdo != default && !string.IsNullOrWhiteSpace(deviceStateValueNewOdo.Value))
  343  			{
  344: 				if (decimal.TryParse(deviceStateValueNewOdo.Value, out decimal newDisplayOdometer))
  345  				{
  346: 					SetAssetLastDisplayOdometer(mobileUnitId, newDisplayOdometer);
  347  
  348: 					_deviceStateRepository.SetState(mobileUnitId, Properties.NEW_ODOMETER_SET, string.Empty, interval: UpdateInterval.OneMinute);
  349  				}

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core.DeviceState.Tests\EngineHoursStateTests.cs:
  126  
  127: 			// Intentionally not setting the LAST_TRIP_END_ODOMETER
  128  

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core.DeviceState.Tests\OdometerStateTests.cs:
   10  {
   11: 	public class OdometerStateTests
   12  	{

   15  		[Test]
   16: 		public void SetSetRawOdometerFromTripEndTest()
   17  		{
   18: 			decimal tripEndOdo = 1000;
   19  

   25  
   26: 			OdometerState odometerState = new OdometerState(deviceStateRepository, new FakeSharedCacheForTesting(), cache);
   27  
   28: 			deviceStateRepository.ClearState(5, Properties.LAST_TRIP_END_ODOMETER);
   29  
   30: 			odometerState.SetRawOdometerFromTripEnd(5, tripEndOdo);
   31  

   33  
   34: 			DeviceStateValue stateTripEndOdo = deviceStateRepository.GetState(5, Properties.LAST_TRIP_END_ODOMETER);
   35  
   36: 			Assert.IsNotNull(stateTripEndOdo);
   37  
   38: 			Assert.AreEqual(tripEndOdo.ToString(), stateTripEndOdo.Value);
   39  		}

   41  		[Test]
   42: 		public void GetOdometerOffsetTest()
   43  		{
   44: 			decimal odoOffset = 1000;
   45  

   51  
   52: 			OdometerState odometerState = new OdometerState(deviceStateRepository, new FakeSharedCacheForTesting(), cache);
   53  
   54: 			deviceStateRepository.ClearState(5, Properties.ODOMETER_OFFSET);
   55  
   56: 			deviceStateRepository.SetState(5, Properties.ODOMETER_OFFSET, "1000", DateTime.UtcNow, UpdateInterval.Immediate);
   57  
   58: 			decimal stateOdoOffset = odometerState.GetOdometerOffset(5);
   59  
   60: 			Assert.AreEqual(odoOffset, stateOdoOffset); // Test that the public GET loaded the value from state table correctly
   61  
   62: 			decimal cachedOdoOffset = cache.GetItem<decimal>(CommonState.GetPropertyCacheKey(5, Properties.ODOMETER_OFFSET));
   63  
   64: 			Assert.AreEqual(odoOffset, cachedOdoOffset); // Test that the public GET method updated the cache correctly
   65  

   68  		[Test]
   69: 		public void TriggerOdoOffseRecalculationTestUsingTripEnd()
   70  		{
   71: 			decimal tripEndOdo = 1000;
   72  
   73: 			decimal newDisplayOdo = 2000;
   74  
   75: 			decimal expectedOdoOffset = 1000;
   76  

   82  
   83: 			OdometerState odometerState = new OdometerState(deviceStateRepository, new FakeSharedCacheForTesting(), cache);
   84  
   85: 			deviceStateRepository.ClearState(5, Properties.LAST_TRIP_END_ODOMETER);
   86  
   87: 			deviceStateRepository.ClearState(5, Properties.ODOMETER_OFFSET);
   88  
   89: 			odometerState.SetRawOdometerFromTripEnd(5, tripEndOdo);
   90  
   91: 			deviceStateRepository.SetState(5, Properties.NEW_ODOMETER_SET, newDisplayOdo.ToString(), DateTime.UtcNow, UpdateInterval.Immediate);
   92  
   93: 			odometerState.CheckIfOdoOffsetRecalculationIsNeeded(5);
   94  
   95: 			decimal mainOdoOffset = odometerState.GetOdometerOffset(5);
   96  
   97: 			Assert.AreEqual(expectedOdoOffset, mainOdoOffset); // Test that the public GET method calculated and stored the new offset value
   98  
   99: 			DeviceStateValue stateNewOdoSet = deviceStateRepository.GetState(5, Properties.NEW_ODOMETER_SET);
  100  
  101: 			Assert.IsNotNull(stateNewOdoSet);
  102  
  103: 			Assert.AreEqual(string.Empty, stateNewOdoSet.Value); // Test that the public GET method cleared the NEW_ODOMETER_SET state table correctly
  104  		}

  106  		[Test]
  107: 		public void TriggerOdoOffseRecalculationTestUsingTripStart()
  108  		{
  109: 			decimal tripStartOdo = 100;
  110  
  111: 			decimal newDisplayOdo = 2000;
  112  
  113: 			decimal expectedOdoOffset = 1900;
  114  

  120  
  121: 			OdometerState odometerState = new OdometerState(deviceStateRepository, new FakeSharedCacheForTesting(), cache);
  122  
  123: 			deviceStateRepository.ClearState(5, Properties.LAST_TRIP_END_ODOMETER);
  124  
  125: 			deviceStateRepository.ClearState(5, Properties.ODOMETER_OFFSET);
  126  
  127: 			// Intentionally not setting the LAST_TRIP_END_ODOMETER
  128  
  129: 			deviceStateRepository.SetState(5, Properties.NEW_ODOMETER_SET, newDisplayOdo.ToString(), DateTime.UtcNow, UpdateInterval.Immediate);
  130  
  131: 			odometerState.CheckIfOdoOffsetRecalculationIsNeeded(5, tripStartOdo);
  132  
  133: 			decimal mainOdoOffset = odometerState.GetOdometerOffset(5);
  134  
  135: 			Assert.AreEqual(expectedOdoOffset, mainOdoOffset); // Test that the public GET method calculated and stored the new offset value
  136  
  137: 			DeviceStateValue stateNewOdoSet = deviceStateRepository.GetState(5, Properties.NEW_ODOMETER_SET);
  138  
  139: 			Assert.IsNotNull(stateNewOdoSet);
  140  
  141: 			Assert.AreEqual(string.Empty, stateNewOdoSet.Value); // Test that the public GET method cleared the NEW_ODOMETER_SET state table correctly
  142  		}

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core.DeviceState.UnitTests\OdometerStateTests.cs:
  11  {
  12: 	public class OdometerStateTests
  13  	{

  32  		[Test, Category("CICDTests")]
  33: 		public void GetOdometerOffsetFromDbDoesNotThrowExceptionTest()
  34  		{
  35  			//Arrange
  36: 			decimal stateOdoOffset = 123.3M;
  37: 			_cacheMock.Setup(o => o.HasItem(It.IsAny<string>(), out stateOdoOffset)).Returns(false);
  38: 			_cacheMock.Setup(o => o.SetItem(It.IsAny<string>(), stateOdoOffset, CommonState.TimeoutOneHour));
  39: 			_redisCacheMock.Setup(o => o.GetItem(It.IsAny<long>(), Properties.ODOMETER_OFFSET)).Returns((string)null);
  40: 			_redisCacheMock.Setup(o => o.SetItem(It.IsAny<long>(), stateOdoOffset.ToString(), Properties.ODOMETER_OFFSET));
  41  			
  42: 			_deviceStateRepositoryMock.Setup(o => o.GetState(It.IsAny<long>(), Properties.ODOMETER_OFFSET)).Returns(
  43  				new DeviceStateValue
  44  				{
  45: 					Value = stateOdoOffset.ToString(),
  46  				});

  48  			//Act
  49: 			OdometerState odometerState = new OdometerState(_deviceStateRepositoryMock.Object, _redisCacheMock.Object, _cacheMock.Object);
  50: 			decimal result = odometerState.GetOdometerOffset(5);
  51  
  52  			//Assert
  53: 			Assert.AreEqual(result, stateOdoOffset);
  54  		}

  56  		[Test, Category("CICDTests")]
  57: 		public void GetOdometerOffsetFromDbThrowsExceptionTest()
  58  		{

  61  			_cacheMock.Setup(o => o.HasItem(It.IsAny<string>(), out dummy)).Returns(false);
  62: 			_redisCacheMock.Setup(o => o.GetItem(It.IsAny<long>(), Properties.ODOMETER_OFFSET)).Returns((string)null);
  63  
  64: 			_deviceStateRepositoryMock.Setup(o => o.GetState(It.IsAny<long>(), Properties.ODOMETER_OFFSET)).Returns(
  65  				new DeviceStateValue

  71  			//Act
  72: 			OdometerState odometerState = new OdometerState(_deviceStateRepositoryMock.Object, _redisCacheMock.Object, _cacheMock.Object);
  73  
  74  			//Assert
  75: 			Assert.Throws<FormatException>(() => odometerState.GetOdometerOffset(5));
  76  		}

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Core.Messages.TDI\Messages\TdiTripMessage.cs:
  13  		/// <summary>
  14: 		/// Required to update calculation for Odometer
  15  		/// </summary>

MIX.DeviceIntegration.DynamicCAN\MiX.DIConfig.DCAN.GetFilesForPartialVIN.Tests\FunctionTest.cs:
  39  			//Mocking the response check for now.
  40: 			//TODO Test check
  41  			Assert.Equal((int)System.Net.HttpStatusCode.OK, (int)System.Net.HttpStatusCode.OK);

sam-app\core-app\src\HelloWorld\Function.cs:
  39  
  40: 			context.Logger.Log($"MARTY TEST BRANCH NEW CLASSES: {environment}"); //TODO: MR: Remove
  41: 			context.Logger.Log($"Input: {input.ToString()}."); //TODO: MR: Remove
  42  
