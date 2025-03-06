SR-2119 Battery Level not updating

Parent:: [[Diagnostic Modal]]
Child:: [[Battery]]

Thursday, 28 June 2018

13:57

 

1.  **Request URL:  
    > <https://za.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/647816741700508016/8866936673104399972/diagnostics/0>**

2.  **Request Method:  
    > **GET

>  
>
> ORG: ZA &gt; MiX Telematics / AF-Direct / AF-Komatel sprl-DRC / Africa - Komatel - Muzuri Sana
>
> Asset ID 2165
>
>  

**BACKEND:**

 

C:\\Projects\\DynaMiX\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\DiagnosticsModule.cs

 

GetAssetDiagnosticInfo

 

C:\\Projects\\DynaMiX\\API\\DynaMiX.API\\Carriers\\FleetAdmin\\Assets\\Diagnostics\\Converter.cs

 

GeneralStatusInfoRemora ToCarrier

 

 

C:\\Projects\\DynaMiX\\Logic\\DynaMiX.Logic\\ConfigAdmin\\Integration\\MobileUnitLevel\\DeviceCapabilityManager.cs

 

GetRemoraDevice

 

GetRemoraProperties

 

 

 

**DEVICE CONFIG PROXY**

 

MobileUnitLevel

 

GetDMEDiagnosticData

 

C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitManager.cs

 

GetDMEDiagnosticData

 

 

<img src="media/image32.png" style="width:6in;height:3.05208in" alt="{Orgld: &quot;647816741703538016&quot;, HasStatusInfo: false, LastConmsLogEntry: null, a Asset: {Assetld: &quot;8866936673104399972&quot;, status: &quot;Available&quot;, RegistrationNumber: &quot;5791 AJ,&#39;OS&quot;,.&#39;, OTCOStatusOiagnostics: null ExportLink: &quot;https://za.mixtelematics.com/DynaMiX.API/fIeet-admin/assets/organisations/6478167417øaSaE FirmwareHistory: General Statuslnfo: {RequestStatus: &quot;Not scheduled&quot;, General StatusInfoGS2: null General Statuslnfocyster: null GeneralStatusInfoRemora: { AdjustedUnitOateTime: {DateTime: : &quot;Good&quot; Satterypercentage: &quot;5%&quot; SatteryVoItage: &quot;4350 mV&quot; Driver: &quot;Unknown&quot; cpsonTime: &quot; GsrQuaIityStatus: &quot;35 : &quot;359686a72ae2564&quot; Imel LoadedVoItage: &quot;2876 rrV Ctoneter: &quot;29492.8 km Speed: &quot; e km/h&quot; Temperature: &quot;11 TripCount: &quot; LastRequestStatus: null, IsoDateTimeString: LastRequestStatusDate : " />

 

This is similar to the issue we are seeing in: SR-2119

 

I had a look at the logic for this.

It currently doesn't use the required value to determine the battery level.

The old spec spoke about battery percentage, etc. however, it should be looking at the digital 25 value.

 

The logic should be as such:

-   If the value is set (or 1), then the battery is GOOD

-   If the value is not set (null) or zero (0), then the battery is LOW

 

The problem is that currently the property which needs to be tested against is not available.

It seems like in the old spec it was not needed, however, the spec has changed and it was never updated in the backend.

 

We will need to change a few things. Here is what I can quickly think of:  
1) Save the digital 25 value as a property  
2) Add this property to the DeviceConfig proxy when getting the DMEDiagnosticData for Remora and Oyster  
3) Change the logic which determines the battery level to look at this new property value

 

 

 

These conditions should apply

The *Internal Battery Good* flag is set based on the following explanation. Remember, if set or 1, the battery is fine. If clear or 0, the battery is low.

<img src="media/image33.png" style="width:9.79167in;height:3.625in" alt="var result = DNEDiagnosticData(); result. MobileUnitId = mobileUnitId; result. BatteryVoItage = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties .652SOLAR BATTERY VOLTAGE); result. SolarVoItage = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties.G52SOLAR SOLAR BATTERY VOLTAGE); result. ExternalVoItage = _deviceStateManager.GetStateVaIue (mobileUnitId, deviceld, Properties.G52SOLAR EXTERNAL BATTERY VOLTAGE); result. Temperature = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties .652SOLAR TEMPERATURE); result.GsmQuaIityStatus = _deviceStateManager.GetStateVaIue (mobileUnitId, deviceld, Properties.G52SOLAR GSM SIGNAL STRENGTH); result. Vehicle&quot;ode = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties .652SOLAR TRPSTATLIS); result.LlnitDateTime = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties.G52SOLAR UNIT DATE TIME); result. Vehicle&quot;odeDateTime = _deviceStatemanager.6etStateVaIue(mobiIeUnitId, deviceld, Properties.652SOLAR VEHICLE &#39;ODE DATE TIME); if (deviceld MobileDevices. REFORA deviceld MobileDevices .OYSTER) result. Batterypercentage = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties. BATTERY PERCENTAGE); result. Uploadsuccess = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties. REMORA UPLOAD SUCCESS); result.LlpIoadFaiIed = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties. REI&#39;&quot;ORA UPLOAD FAILED); result.GpsFixAttempts = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties. REI&#39;&quot;ORA GPS FIX ATTEMPT); result.GpsOnTime = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties. REMORA GPS ON TIME); result. TripCount = _deviceStateManager.GetStateVaIue(mobiIeUnitId, deviceld, Properties. REFORA TRIP COUNT); return result; " />

 

Things change to consider digit 25…. OR MORE

 

<img src="media/image34.png" style="width:4.36458in;height:1.54167in" alt="Alex Pope, 15:25 So our records work with data fields. Each record (AVC in your world) is composed of data fields. The digital data field has 3 parts: inputs; outputs; and status flags. Bit 1 (zero indexed) of the Status Falgs is Battery Good. " />

 

<img src="media/image35.png" style="width:3.625in;height:2.64583in" alt="FID = 2: Digital Data Length = 8 Offset Data ulNT32 UINT16 VINT16 Digital Inputs 0-31 ition Oi ital out tsiM5 Device Status Flags bo•b7: common •cross devices SO • trip status. 1 • &quot;in trip&quot; bl internal battery good external : to OSM Shunting power from battery power alert reserved OB-blS: 5 Citic " />