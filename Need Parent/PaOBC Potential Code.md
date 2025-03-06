---
created: 2025-02-12T15:14
updated: 2025-02-12T15:14
---
146 results - 58 files

_MiXTelematicsFiles\OBC_291_ConfigurationGroupsModule.cs:
  371: 				carrier.IsPhoneBased = false;
  391: 				carrier.IsPhoneBased = false;
  409: 				carrier.IsPhoneBased = false;
  426: 				carrier.IsPhoneBased = false;
  442: 				carrier.IsPhoneBased = false;
  449: 				carrier.IsPhoneBased = false;
  456: 				carrier.IsPhoneBased = true;
  462: 				carrier.IsPhoneBased = false;
  998: 					IsPhoneBased = mobileUnit.MobileDeviceType == MiX.DeviceConfig.Dtos.Enums.MobileDeviceType.PHONE ? true : false

_MiXTelematicsFiles\SQL\RandomSqlTests.sql:
  235: -- OBC-404 UnitqueIdentifier, IMEI, Mobile Phone
  326: -- Add Mobile Phone Group Device

Config.Api\Config.Api.Logic\Managers\LargeFileTransfer\LargeFileTransferManager.cs:
  15: /// LFT Download: sending a file from an OBC peripheral device to DynaMix.
  16: /// LFT Upload: sending a file from DynaMix to an OBC peripheral

Config.Api\Config.Api.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:
  1134: 				case MobileDevices.PHONE:
  1846: 			case MobileDeviceType.PHONE:
  5403: 			if (mobileDeviceId.Value != MobileDevices.PHONE)
  5404: 				throw new System.ArgumentException("The configuration group that you supplied is not for the Mobile Phone Devices.");

Config.Api\Config.Api.Logic\Managers\TemplateLevel\ConfigurationGroupManager.cs:
  289: 			carrier.IsPhoneBased = false;
  295: 			carrier.IsPhoneBased = false;
  301: 			carrier.IsPhoneBased = false;
  307: 			carrier.IsPhoneBased = false;
  313: 			carrier.IsPhoneBased = false;
  319: 			carrier.IsPhoneBased = false;
  325: 			carrier.IsPhoneBased = false;
  331: 			carrier.IsPhoneBased = false;
  339: 			carrier.IsPhoneBased = true;

Database\DeviceConfiguration\Scripts\DeploymentScripts\CleanEarlyReleaseRecords.sql:
  431: --OBC-335 Rename mobile phone event

Database\DeviceConfiguration\Scripts\DeploymentScripts\DeviceCleanup.sql:
  597:   --Get all Default event template for Mobile Phone
  602:   WHERE NAME = 'Default event template for Mobile Phone' 

Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\DevicesData.xml:
  2513: 			<event id="3465058858626632398" eventId="-225322217624061558" info="* OBC unit reset" />
  2547: 			<event id="5320008082012799173" eventId="-225322217624061558" info="* OBC unit reset" />

Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\EventsData.xml:
  6206: 	<event id="-2148292423658317961" type="2" returnActionType="1" returnParameterId="6854231364719584597" legacyId="15015" description="Diagnostic: OBC temperature exceeded 55 deg C">
  6231: 	<event id="-3794943235681097690" type="2" returnActionType="1" returnParameterId="6854231364719584597" legacyId="15016" description="Diagnostic: OBC temperature exceeded 60 deg C">
  6256: 	<event id="1711430310470369692" type="2" returnActionType="1" returnParameterId="6854231364719584597" legacyId="15017" description="Diagnostic: OBC temperature exceeded 70 deg C">
  6281: 	<event id="7379696852981340284" type="2" returnActionType="1" returnParameterId="6854231364719584597" legacyId="15018" description="Diagnostic: OBC temperature exceeded 80 deg C">
  6536: 	<event id="-225322217624061558"  type="4" legacyId="32070" description="* OBC unit reset" />

Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\PropertiesData.xml:
  319: 	<property id="-5623005516231031891" name="EnableFreeFormHandy" displayLabel="Enable free text messages to mobile phones" description="Enable free text messages to mobile phones." format="1" uisortorder="1500450" />
  762: 	<!--Phone as OBC Settings-->

Database\FMAsset\Schemas\dbo\Stored Procedures\sprEventData_InsertGeneratedOverSpeedEvents.proc.sql:
  11: -- NOTE: For first version of RSL monitoring cannot mix event source, so remove any that OBC recorded:

Database\FMAsset\Scripts\DeploymentScripts\DatabaseCreation\InitialData.xml:
  80: 			<state id="1" description="Original status change from OBC or Time Clock" />

DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\TemplateLevel\ConfiguationGruops\ConfiguratioGroupAssetList.cs:
  32: 		public bool IsPhoneBased { get; set; }

DynaMiX.Backend\API\DynaMiX.API\Carriers\ConfigAdmin\TemplateLevel\ConfiguationGruops\ConfigurationGroupListPage.cs:
  43: 		public bool IsPhoneBased { get; set; }

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:
   401: 				carrier.IsPhoneBased = false;
   420: 				carrier.IsPhoneBased = false;
   438: 				carrier.IsPhoneBased = false;
   456: 				carrier.IsPhoneBased = false;
   473: 				carrier.IsPhoneBased = false;
   489: 				carrier.IsPhoneBased = false;
   496: 				carrier.IsPhoneBased = false;
   503: 				carrier.IsPhoneBased = false;
   520: 				carrier.IsPhoneBased = true;
  1241: 					IsPhoneBased = mobileUnit.MobileDeviceType == MiX.DeviceIntegration.Common.Enums.MobileDeviceType.PHONE ? true : false,

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:
   568: 			if (ifailed > 0) return false; //Something went wrong while calling PaOBC client
   573: 			if ((int)commConfig?.State == (int)MessageStateType.Failed) return false; //During decommissioning PaOBC DecommissionByAssetId returned false
   808: 				mobileDeviceCarrier.IsMobilePhone = mobileDeviceCarrier.DeviceTypeId == ConfigConstants.MobileDevices.PHONE.ToString();
  1278: 			//Strip out spaces for Mobile Phone Number

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetDetailsModule.cs:
  188: 			if (ifailed > 0) return false; //Something went wrong while calling PaOBC client
  193: 			if ((int)commConfig?.State == (int)MessageStateType.Failed) return false; //During decommissioning PaOBC DecommissionByAssetId returned false

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetImportExportModule.cs:
  205: 			var mobilePhoneAssetIds = assetSummaries.FindAll(x => x.MobileDeviceTypeId == 157).ConvertAll(a => a.AssetId);

DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetsListModule.cs:
  269: 				List<long> mobilePhoneAssetIds = new List<long>(result.Count);
  293: 				var mobilePhoneStatusMap = AssetsGateway.SetAssetStatusForMobilePhones(myMiXAuthToken, mobileUnits, commStatusesLookup, currentAssetStates, CurrentUserProfile, false, CorrelationId);
  300: 					bool canResendCommissioningRequest = mobilePhoneStatusMap.TryGetValue(assetDetails.Asset.AssetId, out var mobilePhoneStatus)
  303: 																							&& mobilePhoneStatus.CanResendCommissioningRequest;

DynaMiX.Backend\API\DynaMiX.API\NancyModules\Tracking\LiveTrackingModule.cs:
  2664: 			var mobilePhones = new List<long>();
  2677: 			var mobilePhoneLookup = new HashSet<long>(mobilePhones);
  2696: 			var mobilePhones = new List<long>();
  2709: 			var mobilePhoneLookup = new HashSet<long>(mobilePhones);

DynaMiX.Backend\Common\DynaMiX.Common\Constants\ErrorMessages.cs:
  442: 			public const string MOBILE_PHONE_ASSET_TYPE = "Cannot change asset type for mobile phones";
  781: 			public const string INVALID_MOBILE_NUMBER_UPDATE = "Invalid mobile number. The value must be a valid phone number, e.g. +27 12 345 6789";
  782: 			public const string INVALID_MOBILE_NUMBER_ADD = "Invalid mobile number. The value must be a valid phone number, e.g. 27 12 345 6789";

DynaMiX.Backend\Entities\DynaMiX.Entities\ConfigAdmin\MobileUnitLevel\ConfigurationFirmwareSets.cs:
  5: 		public string OBC { get; set; }

DynaMiX.Backend\Entities\DynaMiX.Entities\FleetAdmin\Assets\AssetTypes.cs:
  50: 		public static readonly AssetType MobilePhone = new AssetType(27, "Mobile Phone", "asset-mobile-phone.jpg");

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:
  220: 				//Is it Any OBC event with the Record video option - Road

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LargeFileTransfer\LargeFileTransferManager.cs:
  32: 	/// LFT Download: sending a file from an OBC peripheral device to DynaMix.
  33: 	/// LFT Upload: sending a file from DynaMix to an OBC peripheral

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\FirmwareSetResolver.cs:
  95: 				DmXLogger.Log("Found a stored OBC firmware version of " + firmwareSets.OBC, LogLevel.Info);

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\MobileUnitManager.cs:
  2115: 			return (mobileDevice.ConfigHandler == ConfigEnums.ConfigHandlerType.Fm || mobileDevice.ConfigHandler == ConfigEnums.ConfigHandlerType.MiX2000 || mobileDevice.ConfigHandler == ConfigEnums.ConfigHandlerType.MiX6000 || mobileDevice.ConfigHandler == ConfigEnums.ConfigHandlerType.Dme || mobileDevice.ConfigHandler == ConfigEnums.ConfigHandlerType.Phone);

DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\MobileUnitLevel\TrackAndTraceMobileUnitManager.cs:
  326: 			bool isPhone = mobileUnitManager.IsTheDeviceAvailableForAsset(assetId, ConfigConstants.LogicalDevices.PHONE_COMMUNICATIONS);

DynaMiX.Backend\MiX.UnitConfiguration\Compilers\ConfigBinaryConverter\ConfigBinaryConverter\ConfigBinWriter.cs:
  13:     /// The <c>ConfigBinWriter</c> takes managed data structure and writes them to the BIN file in the exact sequence and precision expected by the OBC D10/D12 firmware.

DynaMiX.Backend\MiX.UnitConfiguration\Compilers\ConfigBinaryConverter\ConfigBinaryConverter\FMDefinitions.cs:
  112: new DDCallEntry(6, 7, 5, "Execute OBC TimeSync with seconds since midnight"),

DynaMiX.Backend\MiX.UnitConfiguration\Compilers\ConfigBinaryConverter\ConfigBinaryConverter\IBinaryConverter.cs:
  12:     /// The same interface may also be implemented by other required OBC specific converters such as CCI, FMT, WLAN, etc.  

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\BinaryCompiler\ConfigBinWriter.cs:
  7: 	/// The <c>ConfigBinWriter</c> takes managed data structure and writes them to the BIN file in the exact sequence and precision expected by the OBC D10/D12 firmware.

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\BinaryCompiler\FMDefinitions.cs:
  664: 					new DDCallEntry(6, 7, 5, "Execute OBC TimeSync with seconds since midnight"),

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Generation\FM3x_Modules\GenerateBinaries\BinaryCompiler\IBinaryConverter.cs:
  8: 	/// The same interface may also be implemented by other required OBC specific converters such as CCI, FMT, WLAN, etc.  

DynaMiX.Backend\MiX.UnitConfiguration\Utilities\ConfigTransformation\ddrLookups\DdrLookups.cs:
  208: 						{MAKE_DDR_CALL_SIGNATURE(6, 7, 5), "Execute OBC TimeSync with seconds since midnight"},

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugControls\Plugs\ConfigPlug.cs:
  299: 				lblOBDDriver.Text = translator1.GetSimpleTranslation("Upload OBC device drivers");

DynaMiX.Backend\Utilities\PlugManagement\DynaMiX.PlugManagement.Standalone\MiX.PlugMangment.WinUI\PlugControls\Plugs\ConfigPlug.Designer.cs:
  156: 			this.chkLoadOBC.Text = "Load OBC device drivers";

DynaMiX.Backend\Utilities\Webservice.Tester\Service References\CoreWS\Reference.cs:
  360:         private string mobilePhoneField;
  518:         public string MobilePhone {

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\LargeFileTransfer\LargeFileTransferManager.cs:
  26: 	/// LFT Download: sending a file from an OBC peripheral device to DynaMix.
  27: 	/// LFT Upload: sending a file from DynaMix to an OBC peripheral

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:
   981: 					case MobileDevices.PHONE:
  1698: 				case MobileDeviceType.PHONE:
  5215: 				if (mobileDeviceId.Value != MobileDevices.PHONE)
  5216: 					throw new System.ArgumentException("The configuration group that you supplied is not for the Mobile Phone Devices.");

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\TemplateLevel\ConfigurationGroupManager.cs:
  260: 				carrier.IsPhoneBased = false;
  266: 				carrier.IsPhoneBased = false;
  272: 				carrier.IsPhoneBased = false;
  278: 				carrier.IsPhoneBased = false;
  284: 				carrier.IsPhoneBased = false;
  290: 				carrier.IsPhoneBased = false;
  296: 				carrier.IsPhoneBased = false;
  302: 				carrier.IsPhoneBased = false;
  310: 				carrier.IsPhoneBased = true;

DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\PaOBC.Connect\PaOBCProxy.cs:
   54: 				Logger.Log($"{ErrorMessages.ConfigAdmin.COMMS_CLIENT_CREATION_FAILED}: PaOBC Device Management Client. PaOBCConfigUploadApiUrl={paOBCConfigUploadApiUrl}", LogLevel.Error);
   71: 				Logger.Log($"Commissioning request sent to PaOBC (CommandId={muc.CommandId} MobileUnitId={muc.MobileUnitId}, Transport={muc.MessageTransport}, CommandTrackingGuid={guid}, Parameter1={muc.Param1}, Parameter2={muc.Param2}, Parameter3={muc.Param3}, Value={muc.Value})", LogLevel.Production);
   75: 				var error = $"PaOBC error when trying to Send Commissioning request. Unique identifier: [{muc.UnitIdentifier}]. Mobile unit id: {muc.MobileUnitId}.";
   98: 				Logger.Log($"Decommissioning request sent to PaOBC (CommandId={muc.CommandId} MobileUnitId={muc.MobileUnitId}, Transport={muc.MessageTransport}, CommandTrackingGuid={guid}, Parameter1={muc.Param1}, Parameter2={muc.Param2}, Parameter3={muc.Param3}, Value={muc.Value})", LogLevel.Production);
  102: 				var error = $"PaOBC error when trying to Send Decommissioning request. Unique identifier: [{muc.UnitIdentifier}]. Mobile unit id: {muc.MobileUnitId}.";
  119: 				Logger.Log($"Send command request sent to PaOBC (CommandId={muc.CommandId} MobileUnitId={muc.MobileUnitId}, Transport={muc.MessageTransport}, CommandTrackingGuid={guid}, Parameter1={muc.Param1}, Parameter2={muc.Param2}, Parameter3={muc.Param3}, Value={muc.Value})", LogLevel.Production);
  123: 				var error = $"PaOBC error when trying to Send Command request. Unique identifier: [{muc.UnitIdentifier}]. Mobile unit id: {muc.MobileUnitId}.";
  148: 				var error = $"PaOBC Proxy error in the Send Commissioning Request method. Asset id: {obcCommand.AssetId}. Exception: {ex.Message}. Inner Exception: {ex.InnerException}. Stack Trace: {ex.StackTrace}";
  162: 				var error = $"PaOBC Proxy error in the Send Decommissioning Request method. Asset id: {mobileUnitId}. Exception: {ex.Message}. Inner Exception: {ex.InnerException}. Inner Exception: {ex.InnerException}. Stack Trace: {ex.StackTrace}";
  181: 				var error = $"PaOBC Proxy error in the Send Shadow Request method. Asset id: {muc.MobileUnitId}. Exception: {ex.Message}. Inner Exception: {ex.InnerException}. Inner Exception: {ex.InnerException}. Stack Trace: {ex.StackTrace}";

Fleet.Services\MiX.Fleet.Services.Entities\Mapping\MapLocationContact.cs:
  7: 		public string MobilePhone { get; set; }

Fleet.Services\MiX.Fleet.Services.Shared\Constants\ErrorMessages.cs:
  657: 			public const string INVALID_MOBILE_NUMBER_UPDATE = "Invalid mobile number. The value must be a valid phone number, e.g. +27 12 345 6789";
  658: 			public const string INVALID_MOBILE_NUMBER_ADD = "Invalid mobile number. The value must be a valid phone number, e.g. 27 12 345 6789";

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\AssetsNotSelfPropelled.cs:
  27: 		public static readonly AssetsNotSelfPropelled MobilePhone = new AssetsNotSelfPropelled(27, "Mobile Phone");

Fleet.Services\MiX.Fleet.Services.Shared\Entities\Assets\AssetType.cs:
  50: 		public static readonly AssetType MobilePhone = new AssetType(27, "Mobile Phone", "asset-mobile-phone.jpg");

MiX.Config.Frangular.API\MiX.Config.Frangular.API\Converters\ConfigurationGroupConverters.cs:
  42: 					IsPhoneBased = configurationGroup.IsPhoneBased

MiX.Config.Frangular.API\MiX.Config.Frangular.Hypermedia\Carriers\ConfigurationGroups\ConfigurationGroupsMultiselectCarrier.cs:
  32: 		public bool IsPhoneBased { get; set; } // Just adding this in for now but should be removed going forward.

MiX.Config.Frangular.UI\src\app\configgroups\configgroups.component.ts:
   131:   isPhoneBased: boolean;
  1449:         isPhoneBased: item.isPhoneBased,

MiX.Config.Frangular.UI\src\app\shared\hypermedia\device-configuration\configuration-groups\configuration-groups-multiselect-carrier.ts:
  26:   isPhoneBased: boolean;

MiX.DeviceConfig\MiX.DeviceConfig.Api.Client\Repositories\ConfigurationGroupsRepository.cs:
  100:       return await GetConfigurationGroupSummaries(authToken, groupId, MobileDevices.PHONE, includeMobileUnitCounts, correlationId).ConfigureAwait(false);

MiX.DeviceConfig\MiX.DeviceConfig.Api.TestApp\Program.cs:
  224:       long mobileUnitId = 1010254937276825600; //Any Phone device

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Constants\LogicalDevices.cs:
  155: 		// PaOBC Record Events

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Entities\TemplateLevel\ConfigurationGroupMultiselectCarrier.cs:
  29:     public bool IsPhoneBased { get; set; } // JA: Look at removing this later 

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Enums\CommandIdType.cs:
  139: 		/// Send Commissioning Request to mobile phone unit
  145: 		/// Send Decommissioning Request to mobile phone unit

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Enums\MessageStateType.cs:
  165: 		#region OBC SMS Message States
  168: 		/// OBC SMS Notification sent
  174: 		/// OBC SMS Rejected by user
  180: 		/// OBC SMS Pending config
  186: 		/// OBC SMS Pending shadow
  192: 		/// OBC SMS Committed shadow
  198: 		/// OBC SMS Finalised
  204: 		#endregion OBC SMS Message States

MiX.Fleet.UI\UI\index.html:
  157: 			<p style="font-size: 14px; line-height: 26px;">{{'This application is not supported for mobile phone. Please use a tablet or PC to use our application.'|translate}}</p>

MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\ConfigGroupsLandingTemplate.html:
  114: 			<label class="radio" ng:show="controller.currentRow.canScheduleUploads && !controller.currentRow.isMesaBased && !controller.currentRow.isPhoneBased">
  122: 			<label class="radio" ng:show="!controller.currentRow.isPhoneBased"><input type="radio" ng-model="uploadTemplate.whenToUpload" value="2"> <span dmx-translate>Not now <span class="muted">(compiled configuration saved to the database)</span></span></label>
  129: 			<label class="radio" ng:show="controller.currentRow.canScheduleUploads && !controller.currentRow.isMesaBased && !controller.currentRow.isPhoneBased">
