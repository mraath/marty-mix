CONFIG-1471 Diff IMEI versions displayed

Parent:: [[Diagnostic Modal]]

>> These devices used to be FM3306 units and have been upgraded to FM3717 devices

1. Navigate to ASSET PAGE; Filter to example VID 1403, Capture IMEI displayed there. i.e. 358625051634824.

2. Open DIAGNOSTICS Window for VID 1043, IMEI displayed there is 359108043532694 (which is incorrect, as per client as well on SR)

3. Navigate to CONFIG PAGE VID 1043, IMEI displayed there is 359108043532694 (which is incorrect).

4. Checked DiagVehList log on HSSYDGPRS03 IMEI connected for the VID 1403 is 358625051634824

(2916 -17974 1403 358625051634824 )

5. Checked [DeviceConfiguration].[mobileunit].[MobileUnitProperties] on SQL, only 358625051634824 is showing.

6. Checked [DeviceConfiguration] audit for the vehicle 359108043532694 is an old IMEI, 358625051634824 is the most recent.

7. Checked CommsDB (sq), 358625051634824 is coming up for the vehicle (1403)

Other vehicles affected as well on the database, seems config/diagnostics not updating changes

8. Checked with Matthew, comms has a stored proc that gets IMEI and other details every time unit connects 

---------------------------------- 1403

Assets [y]
	Items[0].Imei =358625051634824
	https://au.mixtelematics.com/DynaMiX.API/fleet-admin/assets/groups/4089036243479131134

		AssetListModule.cs [GetAssetListPage]

			(DevicConfiguration.assetDetails.AssetConfigDetails.Imei)
			DevicConfiguration.mobileunit.mobileUnitproperties ?? mobileunit.mobileunits.UniqueIdentifier



Diagnostics Window [x]
	GeneralStatusInfo.Imei = 359108043532694
	https://au.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/4089036243479131134/7067540819735335969/diagnostics/0

		
		DiagnosticsModule.cs [GetAssetDiagnosticInfo]

			4k > DeviceConfiguration.DataProcessing. [state].[MobileUnitState] (-9029889041188248996)
			2k > _commsServiceApiClient.Devices[deviceid].Imei
			Other:
			xxx > assetConfigDetails.Imei
					mobileUnit.UniqueIdentifier ?? mobileUnitproperties
			G52 > mobileUnit.UniqueIdentifier (los)



Config page[x]
	Items[1].Imei = 359108043532694
	https://au.mixtelematics.com/DynaMiX.API/config-admin/organisations/4089036243479131134/config_groups/0/assetlist

		ConfigurationGroupsModule.cs [GetConfigGroupAssetList]

			mobileUnit.UniqueIdentifier



-------------------------    -3903968495135836314


assetConfigDetails.Imei = mobileUnit.UniqueIdentifier;
if (string.IsNullOrEmpty(assetConfigDetails.Imei))
{
	MobileUnitProperty imeiProperty = null;
	if (instanceMobileUnitPropertiesDictionary.TryGetValue(Properties.UNIT_IMEI, out imeiProperty))
		assetConfigDetails.Imei = imeiProperty.Value;
}


BECAME


//This change is made for FC-410. The MobileUnitProperties is supposed to have the correct IMEI for units.
//When there is no IMEI on the properties, use the one in MobileUnits (which is probably and incorrect value, as it is not updated)
MobileUnitProperty imeiProperty = null;
if (instanceMobileUnitPropertiesDictionary.TryGetValue(Properties.UNIT_IMEI, out imeiProperty))
	assetConfigDetails.Imei = imeiProperty.Value;

if (string.IsNullOrEmpty(assetConfigDetails.Imei))
	assetConfigDetails.Imei = mobileUnit.UniqueIdentifier;


PROBEER HIERDIE


//FC-410. The MobileUnitProperties is supposed to have the correct IMEI for units. If none, use MobileUnits (which is probably and incorrect value, as it is not updated)
MobileUnitProperty imeiProperty = mobileUnit.MobileUnitProperties.FirstOrDefault(x => x.DefinitionPropertyId == Properties.UNIT_IMEI);
assetConfigDetails.Imei = imeiProperty != null ? imeiProperty.Value : mobileUnit.UniqueIdentifier;


-----------------------

Diagnostics window: other > Code done > ISSUE with view > Data issue > TOETS ander
Diagnostics window: G52 > TOETS

Config page


//TODO: MR: 



IDeviceIntegrationManager deviceIntegrationManager = DependencyResolver.GetInstance<IDeviceIntegrationManager>();

List<MobileUnitProperty> mobileUnitProperties = deviceIntegrationManager.GetMobileUnitPropertiesForOrgAssets(orgId, new List<long>()
				{
					Properties.DRIVER_SET_VERSION, Properties.DRIVER_SET_LOAD_DATE, Properties.LAST_CONFIG, Properties.DDM_LOAD_DATE, Properties.DDM_VERSION, Properties.UNIT_IMSI, Properties.MSISDN, Properties.UNIT_IMEI
				});

Dictionary<long, List<MobileUnitProperty>> unitProperties = mobileUnitProperties.GroupBy(o => o.MobileUnitId).ToDictionary(o => o.Key, o => o.ToList());

if (unitProperties.ContainsKey(mobileUnit.Id))
					instanceMobileUnitProperties = unitProperties[mobileUnit.Id];
				else
					instanceMobileUnitProperties = new List<MobileUnitProperty>();

