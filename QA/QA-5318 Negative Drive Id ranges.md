---
status: uat testing
date: 2022-11-08
comment: New object works but value format type breaks things. New Value format type or FIX int object... I think second!
priority: 7
---

Date: 2022-11-08 Time: 09:25
Parent:: xxxx
Friend:: [[2022-11-08]]
JIRA:QA-5318 Negative Drive Id ranges

# QA-5318 Negative Drive Id ranges

## Testing

## Next Steps

## Story Description

Relates to: QA-5329

Testing on UAT 22.11  
Org: QA Salesforce 1  
Org id: -3239007612472481813  
Unit types: **FM** and **MiX4000**

Steps to replicate:

1.  Navigate to MANAGE - ==CONFIG== ADMIN -> Configuration groups
2.  On the asset page click on ==Mobile device template==
3.  Click on ==Mobile device type== to edit the template
4.  On the mobile device template, scroll down to the bottom and enable "==Private mode plug=="

**BUG:** The user is unable to make use of negative Driver Id ranges when enabling Private mode plug  
**Note:** Bug was discovered while testing the Negative Driver ID Handling feature R22.11:  
[https://confluence.mixtelematics.com/display/HTQ/Fleet+Enhancements+-+Negative+Driver+ID](https://confluence.mixtelematics.com/display/HTQ/Fleet+Enhancements+-+Negative+Driver+ID "Follow link")

## Image

## Element

- Features and settings
	- Private mode plug
		- Driver ID range from
		- Driver ID range to

```html
<input type="text" dmx:focus-select="" dmx:required="" ng-disabled="!property.isEnabled" dmx:required-enabled="!!property.isRequired &amp;&amp; property.isEnabled" dmx:range="{ min: property.minValue, max: property.maxValue }" dmx:range-enabled="(property.minValue == 0 || property.minValue) &amp;&amp; (property.maxValue == 0 || property.maxValue) &amp;&amp; property.isEnabled" validation-message-container="#property_-3841853637330271693_errors" ng:model="property.value" class="ng-valid-dmx-required ng-dirty ng-invalid ng-invalid-dmx-range show-validity">
```

## Paul comment

[Marthinus Raath](https://jira.mixtelematics.com/secure/ViewProfile.jspa?name=marthinusr) can you check which of these will allow only numbers (negative and positive) it was previously on **16 - Integer** but that does not allow negatives. It is currently on **13 - Driver ID** but that allows all characters. :

```xml

        <valueFormat type="0">No value</valueFormat>  
        <valueFormat type="1">Boolean</valueFormat>  
        <valueFormat type="2">Value</valueFormat>  
        <valueFormat type="3">Seconds</valueFormat>  
        <valueFormat type="4">Date</valueFormat>  
        <valueFormat type="5">Time</valueFormat>  
        <valueFormat type="6">Date Time</valueFormat>  
        <valueFormat type="7">Day Of Week</valueFormat>  
        <valueFormat type="8">Latitude</valueFormat>  
        <valueFormat type="9">Longitude</valueFormat>  
        <valueFormat type="10">Location</valueFormat>  
        <valueFormat type="11">Passenger Id</valueFormat>  
        <valueFormat type="12">Trailer Unit Id</valueFormat>  
        <valueFormat type="13">Driver Id</valueFormat>  
        <valueFormat type="14">US State Id</valueFormat>  
        <valueFormat type="15">Combined Company Id | Driver Id</valueFormat>  
        <valueFormat type="16">Integer</valueFormat>  
        <valueFormat type="17">Decimal</valueFormat>  
        <valueFormat type="18">String</valueFormat>  
        <valueFormat type="19">IPv4 Address</valueFormat>  
        <valueFormat type="20">Value list</valueFormat>  
        <valueFormat type="21">Site Id</valueFormat>  
        <valueFormat type="22">VehicleConfigurationGroup Id</valueFormat>  
        <valueFormat type="23">DriverConfigurationGroup Id</valueFormat>  
        <valueFormat type="24">BitMask</valueFormat>  
        <valueFormat type="25">Transport Types</valueFormat>  
        <valueFormat type="26">GPRS APN Address</valueFormat>  
        <valueFormat type="27">Telephone number</valueFormat>  
        <valueFormat type="28">Message handler</valueFormat>  
        <valueFormat type="29">Delay</valueFormat>  
        <valueFormat type="30">DNS</valueFormat>  
        <valueFormat type="31">Telephone Or Short Code Number</valueFormat>  
        <valueFormat type="200">Speed (km/h)</valueFormat>  
        <valueFormat type="201">Distance (Km)</valueFormat>  
        <valueFormat type="202">Distance (m)</valueFormat>  
        <valueFormat type="203">Fuel Quantity (l)</valueFormat>  
        <valueFormat type="204">Temperature (°C)</valueFormat>  
        <valueFormat type="205">Weight (tonnes)</valueFormat>  
        <valueFormat type="206">Weight (Kg)</valueFormat>  
        <valueFormat type="207">Acceleration (Km/h/s)</valueFormat>  
        <valueFormat type="208">Consumption (Km/l)</valueFormat>
```

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| FE    | DB     |
| ----- | ------ |
| 22.16 | 22.16  |
| Local | Local  |
| INT   | PR INT | 

## Branch
Config/MR/Bug/QA-5318NegativeDriveIdRanges.22.16.ORI
