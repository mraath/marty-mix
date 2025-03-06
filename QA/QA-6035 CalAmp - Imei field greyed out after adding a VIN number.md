---
status: busy
date: 2023-09-14
comment: 
priority: 1
---

# QA-6035 CalAmp - Imei field greyed out after adding a VIN number

Date: 2023-09-14 Time: 14:31
Parent:: ==xxxx==
Friend:: [[2023-09-14]]
JIRA:QA-6035 CalAmp - Imei field greyed out after adding a VIN number
[QA-6035 QA - CalAmp - Imei field greyed out after adding a VIN number - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-6035)

## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Outstanding in this file


## Branch

- Config/MR/Feature/Template Jira Issue_INT_ORI

## Description

Database name: Calamp2  
org id: -2559222217879735280  

==INT: ORG: NewCalamp==
  
Replication steps:

-Once the a new asset is ==created== 
add a ==VIN== number to the asset and click save.  
-Navigate to ==mobile device settings== and you will see that the ==IMEI field is greyed out==  
-Even when the ==VIN is removed== the the imei field remains greyed out

**Zonika**: This needs a change from both ~~fleet~~ and Config. Fleet is currently calling the ==config group update== call even when it did not change.
While investigating I found a regression issue causing the ==configuration status to be set incorrectly in some scenarios== that all also needs to be addressed.

**Chad**: I have made a change to only update the config group if the config group is actually changed

## Investigate

### Steps

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number Save 1.png | 500]]

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number.png  | 300]]

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number-1.png | 500]]

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number Save 2.png | 500]]

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number ISSUE or BUG.png | 300]]


Step 2, UAT Update VIN
- POST: https://fleetadminapi.uat.mixtelematics.com/api/asset-details/group/-2559222217879735280/asset/%7BassetId%7D/update
- Payload
```json
{"assetId":"1439183366885748736","assetTypeId":"4","description":"MR Test Calamp","registrationNumber":"MRTC1","mobileNumber":null,"siteId":"7410098436085871171","fuelType":null,"targetFuelConsumption":null,"targetFuelConsumptionUnits":"gal (US)/100mi","targetHourlyFuelConsumption":null,"targetHourlyFuelConsumptionUnits":"gal (US)/h","fuelTankCapacity":null,"fleetNumber":null,"make":"AC","model":null,"year":null,"vinNumber":"11111222223333311","vinSource":"MANUAL","engineNumber":null,"fmVehicleId":1,"additionalMobileDevice":null,"notes":null,"icon":"boat-right","iconColour":"blue","colour":null,"assetImage":"asset-boat.jpg","assetImageUrl":null,"status":null,"createdBy":"Marthinus RaathLimited","configurationGroupId":"1737655599867582938","createdDate":null,"country":null,"miXAccountNumber":null,"additionalDetailFields":[],"canProtocol":null,"requiredProperties":{},"volumeUnits":"gal (US)","wltp":null,"batteryCapacity":null,"usableBatteryCapacity":null,"distanceUnit":"mi"}
```
- ...
- GET: https://fleetadminapi.uat.mixtelematics.com/api/asset-details/group/-2559222217879735280/asset/1439183366885748736/duplicate/false/get
- Preview
```json
{
    "canEdit": true,
    "assetDetails": {
        "assetId": "1439183366885748736",
        "assetTypeId": "4",
        "eld": false,
        "description": "MR Test Calamp",
        "isConnectedTrailer": false,
        "registrationNumber": "MRTC1",
        "mobileNumber": null,
        "siteId": "7410098436085871171",
        "fuelType": null,
        "targetFuelConsumption": null,
        "targetFuelConsumptionUnits": "gal (US)/100mi",
        "targetHourlyFuelConsumption": null,
        "targetHourlyFuelConsumptionUnits": "gal (US)/h",
        "fuelTankCapacity": null,
        "fleetNumber": null,
        "make": "AC",
        "model": null,
        "year": null,
        "vinNumber": "11111222223333311",
        "vinSource": "MANUAL",
        "isNotCanVin": false,
        "vinNumberMatched": false,
        "engineNumber": null,
        "fmVehicleId": 1,
        "additionalMobileDevice": null,
        "notes": null,
        "icon": "boat-right",
        "iconColour": "blue",
        "colour": null,
        "assetImage": "asset-boat.jpg",
        "isDefaultImage": false,
        "assetImageUrl": null,
        "status": null,
        "createdBy": "Marthinus RaathLimited",
        "configurationGroupId": "1737655599867582938",
        "createdDate": null,
        "country": null,
        "miXAccountNumber": null,
        "isNewAsset": false,
        "isMobilePhone": false,
        "additionalDetailFields": [],
        "isStreamaxCommissioned": false,
        "decommissionStreamaxDevice": false,
        "canProtocol": null,
        "isScaniaOem": false,
        "isOnJourney": false,
        "requiredProperties": {
            "vin": false,
            "canProtocol": false,
            "fuelType": false
        },
        "volumeUnits": "gal (US)",
        "wltp": null,
        "batteryCapacity": null,
        "usableBatteryCapacity": null,
        "distanceUnit": "mi",
        "hyperMedia": null
    },
    "isNewAsset": false,
    "assetTypes": [
        {
            "value": "4",
            "text": "Boat"
        },
        {
            "value": "8",
            "text": "Dangerous Goods Vehicle"
        },
        {
            "value": "7",
            "text": "Emergency Service Vehicle"
        },
        {
            "value": "18",
            "text": "Fluid Transport Vehicle"
        },
        {
            "value": "11",
            "text": "Heavy Passenger Vehicle - Bus - Articulated"
        },
        {
            "value": "13",
            "text": "Heavy Passenger Vehicle - Bus - Double Decker"
        },
        {
            "value": "12",
            "text": "Heavy Passenger Vehicle - Bus - Single Decker"
        },
        {
            "value": "28",
            "text": "Heavy Vehicle"
        },
        {
            "value": "14",
            "text": "Heavy Vehicle - Articulated"
        },
        {
            "value": "15",
            "text": "Heavy Vehicle - Non-Articulated"
        },
        {
            "value": "16",
            "text": "Heavy Vehicle - Refrigerated Transport"
        },
        {
            "value": "22",
            "text": "Light Delivery Vehicle"
        },
        {
            "value": "10",
            "text": "Light Passenger Vehicle - Minibus"
        },
        {
            "value": "17",
            "text": "Light Vehicle"
        },
        {
            "value": "25",
            "text": "Medium Commercial Vehicle"
        },
        {
            "value": "27",
            "text": "Mobile Phone"
        },
        {
            "value": "5",
            "text": "Mobile Plant Equipment"
        },
        {
            "value": "1",
            "text": "Motorcycle"
        },
        {
            "value": "26",
            "text": "Non-Powered Asset"
        },
        {
            "value": "24",
            "text": "Off-Road Vehicle"
        },
        {
            "value": "20",
            "text": "Other"
        },
        {
            "value": "9",
            "text": "Passenger Vehicle"
        },
        {
            "value": "6",
            "text": "Stationary Plant Equipment"
        },
        {
            "value": "2",
            "text": "Trailer"
        },
        {
            "value": "21",
            "text": "Train"
        }
    ],
    "sites": [
        {
            "value": "7410098436085871171",
            "text": "Default Site"
        }
    ],
    "configGroups": [
        {
            "value": "1737655599867582938",
            "text": "Default configuration group for CalAmp Premium"
        }
    ],
    "countries": [
        {
            "value": "AF",
            "text": "Afghanistan"
        },
        {
            "value": "AX",
            "text": "Åland Islands"
        },
        {
            "value": "AL",
            "text": "Albania"
        },
        {
            "value": "DZ",
            "text": "Algeria"
        },
        {
            "value": "AS",
            "text": "American Samoa"
        },
        {
            "value": "AD",
            "text": "Andorra"
        },
        {
            "value": "AO",
            "text": "Angola"
        },
        {
            "value": "AI",
            "text": "Anguilla"
        },
        {
            "value": "AQ",
            "text": "Antarctica"
        },
        {
            "value": "AG",
            "text": "Antigua and Barbuda"
        },
        {
            "value": "AR",
            "text": "Argentina"
        },
        {
            "value": "AM",
            "text": "Armenia"
        },
        {
            "value": "AW",
            "text": "Aruba"
        },
        {
            "value": "AU",
            "text": "Australia"
        },
        {
            "value": "AT",
            "text": "Austria"
        },
        {
            "value": "AZ",
            "text": "Azerbaijan"
        },
        {
            "value": "BS",
            "text": "Bahamas (the)"
        },
        {
            "value": "BH",
            "text": "Bahrain"
        },
        {
            "value": "BD",
            "text": "Bangladesh"
        },
        {
            "value": "BB",
            "text": "Barbados"
        },
        {
            "value": "BY",
            "text": "Belarus"
        },
        {
            "value": "BE",
            "text": "Belgium"
        },
        {
            "value": "BZ",
            "text": "Belize"
        },
        {
            "value": "BJ",
            "text": "Benin"
        },
        {
            "value": "BM",
            "text": "Bermuda"
        },
        {
            "value": "BT",
            "text": "Bhutan"
        },
        {
            "value": "BO",
            "text": "Bolivia, Plurinational State of"
        },
        {
            "value": "BQ",
            "text": "Bonaire, Sint Eustatius and Saba"
        },
        {
            "value": "BA",
            "text": "Bosnia and Herzegovina"
        },
        {
            "value": "BW",
            "text": "Botswana"
        },
        {
            "value": "BV",
            "text": "Bouvet Island"
        },
        {
            "value": "BR",
            "text": "Brazil"
        },
        {
            "value": "IO",
            "text": "British Indian Ocean Territory (the)"
        },
        {
            "value": "BN",
            "text": "Brunei Darussalam"
        },
        {
            "value": "BG",
            "text": "Bulgaria"
        },
        {
            "value": "BF",
            "text": "Burkina Faso"
        },
        {
            "value": "BI",
            "text": "Burundi"
        },
        {
            "value": "CV",
            "text": "Cabo Verde"
        },
        {
            "value": "KH",
            "text": "Cambodia"
        },
        {
            "value": "CM",
            "text": "Cameroon"
        },
        {
            "value": "CA",
            "text": "Canada"
        },
        {
            "value": "KY",
            "text": "Cayman Islands (the)"
        },
        {
            "value": "CF",
            "text": "Central African Republic (the)"
        },
        {
            "value": "TD",
            "text": "Chad"
        },
        {
            "value": "CL",
            "text": "Chile"
        },
        {
            "value": "CN",
            "text": "China"
        },
        {
            "value": "CX",
            "text": "Christmas Island"
        },
        {
            "value": "CC",
            "text": "Cocos (Keeling) Islands (the)"
        },
        {
            "value": "CO",
            "text": "Colombia"
        },
        {
            "value": "KM",
            "text": "Comoros"
        },
        {
            "value": "CG",
            "text": "Congo"
        },
        {
            "value": "CD",
            "text": "Congo (the Democratic Republic of the)"
        },
        {
            "value": "CK",
            "text": "Cook Islands (the)"
        },
        {
            "value": "CR",
            "text": "Costa Rica"
        },
        {
            "value": "CI",
            "text": "Côte d'Ivoire"
        },
        {
            "value": "HR",
            "text": "Croatia"
        },
        {
            "value": "CU",
            "text": "Cuba"
        },
        {
            "value": "CW",
            "text": "Curaçao"
        },
        {
            "value": "CY",
            "text": "Cyprus"
        },
        {
            "value": "CZ",
            "text": "Czech Republic (the)"
        },
        {
            "value": "DK",
            "text": "Denmark"
        },
        {
            "value": "DJ",
            "text": "Djibouti"
        },
        {
            "value": "DM",
            "text": "Dominica"
        },
        {
            "value": "DO",
            "text": "Dominican Republic (the)"
        },
        {
            "value": "EC",
            "text": "Ecuador"
        },
        {
            "value": "EG",
            "text": "Egypt"
        },
        {
            "value": "SV",
            "text": "El Salvador"
        },
        {
            "value": "GQ",
            "text": "Equatorial Guinea"
        },
        {
            "value": "ER",
            "text": "Eritrea"
        },
        {
            "value": "EE",
            "text": "Estonia"
        },
        {
            "value": "ET",
            "text": "Ethiopia"
        },
        {
            "value": "FK",
            "text": "Falkland Islands (the) [Malvinas]"
        },
        {
            "value": "FO",
            "text": "Faroe Islands (the)"
        },
        {
            "value": "FJ",
            "text": "Fiji"
        },
        {
            "value": "FI",
            "text": "Finland"
        },
        {
            "value": "FR",
            "text": "France"
        },
        {
            "value": "GF",
            "text": "French Guiana"
        },
        {
            "value": "PF",
            "text": "French Polynesia"
        },
        {
            "value": "TF",
            "text": "French Southern Territories (the)"
        },
        {
            "value": "GA",
            "text": "Gabon"
        },
        {
            "value": "GM",
            "text": "Gambia (The)"
        },
        {
            "value": "GE",
            "text": "Georgia"
        },
        {
            "value": "DE",
            "text": "Germany"
        },
        {
            "value": "GH",
            "text": "Ghana"
        },
        {
            "value": "GI",
            "text": "Gibraltar"
        },
        {
            "value": "GR",
            "text": "Greece"
        },
        {
            "value": "GL",
            "text": "Greenland"
        },
        {
            "value": "GD",
            "text": "Grenada"
        },
        {
            "value": "GP",
            "text": "Guadeloupe"
        },
        {
            "value": "GU",
            "text": "Guam"
        },
        {
            "value": "GT",
            "text": "Guatemala"
        },
        {
            "value": "GG",
            "text": "Guernsey"
        },
        {
            "value": "GN",
            "text": "Guinea"
        },
        {
            "value": "GW",
            "text": "Guinea-Bissau"
        },
        {
            "value": "GY",
            "text": "Guyana"
        },
        {
            "value": "HT",
            "text": "Haiti"
        },
        {
            "value": "HM",
            "text": "Heard Island and McDonald Islands"
        },
        {
            "value": "VA",
            "text": "Holy See (the) [Vatican City State]"
        },
        {
            "value": "HN",
            "text": "Honduras"
        },
        {
            "value": "HK",
            "text": "Hong Kong"
        },
        {
            "value": "HU",
            "text": "Hungary"
        },
        {
            "value": "IS",
            "text": "Iceland"
        },
        {
            "value": "IN",
            "text": "India"
        },
        {
            "value": "ID",
            "text": "Indonesia"
        },
        {
            "value": "IR",
            "text": "Iran (the Islamic Republic of)"
        },
        {
            "value": "IQ",
            "text": "Iraq"
        },
        {
            "value": "IE",
            "text": "Ireland"
        },
        {
            "value": "IM",
            "text": "Isle of Man"
        },
        {
            "value": "IL",
            "text": "Israel"
        },
        {
            "value": "IT",
            "text": "Italy"
        },
        {
            "value": "JM",
            "text": "Jamaica"
        },
        {
            "value": "JP",
            "text": "Japan"
        },
        {
            "value": "JE",
            "text": "Jersey"
        },
        {
            "value": "JO",
            "text": "Jordan"
        },
        {
            "value": "KZ",
            "text": "Kazakhstan"
        },
        {
            "value": "KE",
            "text": "Kenya"
        },
        {
            "value": "KI",
            "text": "Kiribati"
        },
        {
            "value": "KP",
            "text": "Korea (the Democratic People's Republic of)"
        },
        {
            "value": "KR",
            "text": "Korea (the Republic of)"
        },
        {
            "value": "KW",
            "text": "Kuwait"
        },
        {
            "value": "KG",
            "text": "Kyrgyzstan"
        },
        {
            "value": "LA",
            "text": "Lao People's Democratic Republic (the)"
        },
        {
            "value": "LV",
            "text": "Latvia"
        },
        {
            "value": "LB",
            "text": "Lebanon"
        },
        {
            "value": "LS",
            "text": "Lesotho"
        },
        {
            "value": "LR",
            "text": "Liberia"
        },
        {
            "value": "LY",
            "text": "Libya"
        },
        {
            "value": "LI",
            "text": "Liechtenstein"
        },
        {
            "value": "LT",
            "text": "Lithuania"
        },
        {
            "value": "LU",
            "text": "Luxembourg"
        },
        {
            "value": "MO",
            "text": "Macao"
        },
        {
            "value": "MK",
            "text": "Macedonia (the former Yugoslav Republic of)"
        },
        {
            "value": "MG",
            "text": "Madagascar"
        },
        {
            "value": "MW",
            "text": "Malawi"
        },
        {
            "value": "MY",
            "text": "Malaysia"
        },
        {
            "value": "MV",
            "text": "Maldives"
        },
        {
            "value": "ML",
            "text": "Mali"
        },
        {
            "value": "MT",
            "text": "Malta"
        },
        {
            "value": "MH",
            "text": "Marshall Islands (the)"
        },
        {
            "value": "MQ",
            "text": "Martinique"
        },
        {
            "value": "MR",
            "text": "Mauritania"
        },
        {
            "value": "MU",
            "text": "Mauritius"
        },
        {
            "value": "YT",
            "text": "Mayotte"
        },
        {
            "value": "MX",
            "text": "Mexico"
        },
        {
            "value": "FM",
            "text": "Micronesia (the Federated States of)"
        },
        {
            "value": "MD",
            "text": "Moldova (the Republic of)"
        },
        {
            "value": "MC",
            "text": "Monaco"
        },
        {
            "value": "MN",
            "text": "Mongolia"
        },
        {
            "value": "ME",
            "text": "Montenegro"
        },
        {
            "value": "MS",
            "text": "Montserrat"
        },
        {
            "value": "MA",
            "text": "Morocco"
        },
        {
            "value": "MZ",
            "text": "Mozambique"
        },
        {
            "value": "MM",
            "text": "Myanmar"
        },
        {
            "value": "NA",
            "text": "Namibia"
        },
        {
            "value": "NR",
            "text": "Nauru"
        },
        {
            "value": "NP",
            "text": "Nepal"
        },
        {
            "value": "NL",
            "text": "Netherlands (the)"
        },
        {
            "value": "NC",
            "text": "New Caledonia"
        },
        {
            "value": "NZ",
            "text": "New Zealand"
        },
        {
            "value": "NI",
            "text": "Nicaragua"
        },
        {
            "value": "NE",
            "text": "Niger (the)"
        },
        {
            "value": "NG",
            "text": "Nigeria"
        },
        {
            "value": "NU",
            "text": "Niue"
        },
        {
            "value": "NF",
            "text": "Norfolk Island"
        },
        {
            "value": "MP",
            "text": "Northern Mariana Islands (the)"
        },
        {
            "value": "NO",
            "text": "Norway"
        },
        {
            "value": "OM",
            "text": "Oman"
        },
        {
            "value": "PK",
            "text": "Pakistan"
        },
        {
            "value": "PW",
            "text": "Palau"
        },
        {
            "value": "PS",
            "text": "Palestine, State of"
        },
        {
            "value": "PA",
            "text": "Panama"
        },
        {
            "value": "PG",
            "text": "Papua New Guinea"
        },
        {
            "value": "PY",
            "text": "Paraguay"
        },
        {
            "value": "PE",
            "text": "Peru"
        },
        {
            "value": "PH",
            "text": "Philippines (the)"
        },
        {
            "value": "PN",
            "text": "Pitcairn"
        },
        {
            "value": "PL",
            "text": "Poland"
        },
        {
            "value": "PT",
            "text": "Portugal"
        },
        {
            "value": "PR",
            "text": "Puerto Rico"
        },
        {
            "value": "QA",
            "text": "Qatar"
        },
        {
            "value": "RE",
            "text": "Réunion"
        },
        {
            "value": "RO",
            "text": "Romania"
        },
        {
            "value": "RU",
            "text": "Russian Federation (the)"
        },
        {
            "value": "RW",
            "text": "Rwanda"
        },
        {
            "value": "BL",
            "text": "Saint Barthélemy"
        },
        {
            "value": "SH",
            "text": "Saint Helena, Ascension and Tristan da Cunha"
        },
        {
            "value": "KN",
            "text": "Saint Kitts and Nevis"
        },
        {
            "value": "LC",
            "text": "Saint Lucia"
        },
        {
            "value": "MF",
            "text": "Saint Martin (French part)"
        },
        {
            "value": "PM",
            "text": "Saint Pierre and Miquelon"
        },
        {
            "value": "VC",
            "text": "Saint Vincent and the Grenadines"
        },
        {
            "value": "WS",
            "text": "Samoa"
        },
        {
            "value": "SM",
            "text": "San Marino"
        },
        {
            "value": "ST",
            "text": "Sao Tome and Principe"
        },
        {
            "value": "SA",
            "text": "Saudi Arabia"
        },
        {
            "value": "SN",
            "text": "Senegal"
        },
        {
            "value": "RS",
            "text": "Serbia"
        },
        {
            "value": "SC",
            "text": "Seychelles"
        },
        {
            "value": "SL",
            "text": "Sierra Leone"
        },
        {
            "value": "SG",
            "text": "Singapore"
        },
        {
            "value": "SX",
            "text": "Sint Maarten (Dutch part)"
        },
        {
            "value": "SK",
            "text": "Slovakia"
        },
        {
            "value": "SI",
            "text": "Slovenia"
        },
        {
            "value": "SB",
            "text": "Solomon Islands (the)"
        },
        {
            "value": "SO",
            "text": "Somalia"
        },
        {
            "value": "ZA",
            "text": "South Africa"
        },
        {
            "value": "GS",
            "text": "South Georgia and the South Sandwich Islands"
        },
        {
            "value": "SS",
            "text": "South Sudan"
        },
        {
            "value": "ES",
            "text": "Spain"
        },
        {
            "value": "LK",
            "text": "Sri Lanka"
        },
        {
            "value": "SD",
            "text": "Sudan (the)"
        },
        {
            "value": "SR",
            "text": "Suriname"
        },
        {
            "value": "SJ",
            "text": "Svalbard and Jan Mayen"
        },
        {
            "value": "SZ",
            "text": "Swaziland"
        },
        {
            "value": "SE",
            "text": "Sweden"
        },
        {
            "value": "CH",
            "text": "Switzerland"
        },
        {
            "value": "SY",
            "text": "Syrian Arab Republic (the)"
        },
        {
            "value": "TW",
            "text": "Taiwan (Province of China)"
        },
        {
            "value": "TJ",
            "text": "Tajikistan"
        },
        {
            "value": "TZ",
            "text": "Tanzania, United Republic of"
        },
        {
            "value": "TH",
            "text": "Thailand"
        },
        {
            "value": "TL",
            "text": "Timor-Leste"
        },
        {
            "value": "TG",
            "text": "Togo"
        },
        {
            "value": "TK",
            "text": "Tokelau"
        },
        {
            "value": "TO",
            "text": "Tonga"
        },
        {
            "value": "TT",
            "text": "Trinidad and Tobago"
        },
        {
            "value": "TN",
            "text": "Tunisia"
        },
        {
            "value": "TR",
            "text": "Turkey"
        },
        {
            "value": "TM",
            "text": "Turkmenistan"
        },
        {
            "value": "TC",
            "text": "Turks and Caicos Islands (the)"
        },
        {
            "value": "TV",
            "text": "Tuvalu"
        },
        {
            "value": "UG",
            "text": "Uganda"
        },
        {
            "value": "UA",
            "text": "Ukraine"
        },
        {
            "value": "AE",
            "text": "United Arab Emirates (the)"
        },
        {
            "value": "GB",
            "text": "United Kingdom (the)"
        },
        {
            "value": "US",
            "text": "United States (the)"
        },
        {
            "value": "UM",
            "text": "United States Minor Outlying Islands (the)"
        },
        {
            "value": "UY",
            "text": "Uruguay"
        },
        {
            "value": "UZ",
            "text": "Uzbekistan"
        },
        {
            "value": "VU",
            "text": "Vanuatu"
        },
        {
            "value": "VE",
            "text": "Venezuela, Bolivarian Republic of"
        },
        {
            "value": "VN",
            "text": "Viet Nam"
        },
        {
            "value": "VG",
            "text": "Virgin Islands (British)"
        },
        {
            "value": "VI",
            "text": "Virgin Islands (U.S.)"
        },
        {
            "value": "WF",
            "text": "Wallis and Futuna"
        },
        {
            "value": "EH",
            "text": "Western Sahara"
        },
        {
            "value": "YE",
            "text": "Yemen"
        },
        {
            "value": "ZM",
            "text": "Zambia"
        },
        {
            "value": "ZW",
            "text": "Zimbabwe"
        }
    ],
    "fuelTypes": [
        {
            "id": "Bi-fuel using diesel",
            "description": "Bi-fuel using diesel"
        },
        {
            "id": "Bi-fuel vehicle using battery",
            "description": "Bi-fuel vehicle using battery"
        },
        {
            "id": "Bi-fuel vehicle using battery and combustion engine",
            "description": "Bi-fuel vehicle using battery and combustion engine"
        },
        {
            "id": "Bi-fuel vehicle using CNG",
            "description": "Bi-fuel vehicle using CNG"
        },
        {
            "id": "Bi-fuel vehicle using ethanol",
            "description": "Bi-fuel vehicle using ethanol"
        },
        {
            "id": "Bi-fuel vehicle using LPG",
            "description": "Bi-fuel vehicle using LPG"
        },
        {
            "id": "Bi-fuel vehicle using methanol",
            "description": "Bi-fuel vehicle using methanol"
        },
        {
            "id": "Bi-fuel vehicle using natural gas",
            "description": "Bi-fuel vehicle using natural gas"
        },
        {
            "id": "Bi-fuel vehicle using petrol",
            "description": "Bi-fuel vehicle using petrol"
        },
        {
            "id": "Bi-fuel vehicle using propane",
            "description": "Bi-fuel vehicle using propane"
        },
        {
            "id": "Compressed Natural Gas",
            "description": "Compressed Natural Gas"
        },
        {
            "id": "Diesel",
            "description": "Diesel"
        },
        {
            "id": "Dual fuel - diesel and compressed natural gas",
            "description": "Dual fuel - diesel and compressed natural gas"
        },
        {
            "id": "Dual fuel - diesel and liquid natural gas",
            "description": "Dual fuel - diesel and liquid natural gas"
        },
        {
            "id": "Electric",
            "description": "Electric"
        },
        {
            "id": "Ethanol",
            "description": "Ethanol"
        },
        {
            "id": "Hybrid vehicle in regeneration mode",
            "description": "Hybrid vehicle in regeneration mode"
        },
        {
            "id": "Hybrid vehicle using battery",
            "description": "Hybrid vehicle using battery"
        },
        {
            "id": "Hybrid vehicle using battery and combustion engine",
            "description": "Hybrid vehicle using battery and combustion engine"
        },
        {
            "id": "Hybrid vehicle using diesel engine",
            "description": "Hybrid vehicle using diesel engine"
        },
        {
            "id": "Hybrid vehicle using gasoline engine",
            "description": "Hybrid vehicle using gasoline engine"
        },
        {
            "id": "Hybrid vehicle using gasoline engine on ethanol",
            "description": "Hybrid vehicle using gasoline engine on ethanol"
        },
        {
            "id": "Liquified Petroleum Gas",
            "description": "Liquified Petroleum Gas"
        },
        {
            "id": "Methanol",
            "description": "Methanol"
        },
        {
            "id": "Natural gas",
            "description": "Natural gas"
        },
        {
            "id": "Natural gas (compressed or liquefied natural gas)",
            "description": "Natural gas (compressed or liquefied natural gas)"
        },
        {
            "id": "Petrol",
            "description": "Petrol"
        },
        {
            "id": "Propane",
            "description": "Propane"
        },
        {
            "id": "Not available",
            "description": "Not available"
        },
        {
            "id": "Other",
            "description": "Other"
        }
    ],
    "icons": [
        "van-right",
        "truck-right",
        "trailer-right",
        "trailer2-right",
        "tipper-right",
        "tanker-right",
        "plough-right",
        "crane2-right",
        "crane-right",
        "ems-right",
        "generator2-right",
        "generator-right",
        "forklift-right",
        "key-right",
        "motorcycle-right",
        "car-right",
        "car5-right",
        "car4-right",
        "car3-right",
        "car2-right",
        "bus-right",
        "boat-right",
        "batmobile2-right",
        "batmobile-right",
        "phone",
        "person",
        "ldv-right",
        "train-right",
        "container",
        "ewp-right",
        "chipper-right",
        "truck-logging-right",
        "saw-blade1",
        "saw-blade2",
        "crane-logging"
    ],
    "iconColours": [
        "black",
        "blue",
        "green",
        "teal",
        "deepSkyBlue",
        "aqua",
        "forestGreen",
        "limeGreen",
        "indigo",
        "dimGray",
        "maroon",
        "purple",
        "lightGreen",
        "lightBlue",
        "fireBrick",
        "indianRed",
        "orchid",
        "crimson",
        "lightCoral",
        "red",
        "deepPink",
        "darkOrange",
        "lightPink",
        "yellow"
    ],
    "makesAndModels": [
        "A Trinity Trailer",
        "Abarth",
        "AC",
        "ADL",
        "Adly",
        "Advanced Power",
        "Advantec",
        "Aebi Schmidt",
        "Afrit",
        "Agco Allis (agrotec)",
        "Agrale",
        "Agria",
        "Agria-deutz",
        "Agrico",
        "Air Stream",
        "Alcom LLC",
        "Alfa Romeo",
        "Alimak",
        "Allight",
        "Allmand",
        "Alum-Line",
        "AMC",
        "Amco Vebo",
        "American Crawler",
        "American Trailers",
        "Anglo International",
        "Appalachian Trailers",
        "Aprilia",
        "Arctic Cat",
        "Arising Industries",
        "Arora",
        "Ashok Leyland",
        "Asia Wing",
        "Aston Martin",
        "ASTRA",
        "ATE",
        "Atlas Copco",
        "ATLAS",
        "Atoka Trailer & Mfg.",
        "Atul Auto",
        "Audi",
        "Autocar",
        "B.A.W",
        "Backdraft Racing",
        "Baic",
        "Bajaj",
        "Baoli forklift",
        "Barford",
        "BARKER",
        "Bartlett",
        "BCI",
        "Beiben",
        "Beiqi Foton",
        "Bell Equipment",
        "Belmont Machine",
        "Belshe Industries",
        "Bennche",
        "Bennelli",
        "Bentley",
        "Bestar China",
        "Beta Racing",
        "Big Bubba's Trailer",
        "Big Tex Trailer",
        "Bimota",
        "Bitelli",
        "Blackstone Trailer ",
        "Blackwood hodge",
        "Blue Bird",
        "Blue Diamond",
        "BMC",
        "BMW",
        "Bobcat",
        "Bomag",
        "Bombardiercanam",
        "Bonluck",
        "Bravo Trailers",
        "Brazos",
        "Brindle Products",
        "Brooks Brothers",
        "BRUCE ROCK END",
        "Buick",
        "Busaf",
        "Buyang",
        "BYD",
        "Cadillac",
        "Cagiva",
        "Can-am",
        "Capacity",
        "Cargo Craft",
        "Carry-On Trailer",
        "Case International",
        "Caterpillar",
        "CBH",
        "Centralia Machine",
        "Century Built",
        "CF Moto",
        "Chana - Changan",
        "Changjiang",
        "Chengliwei",
        "Chery",
        "Chevrolet",
        "Choice Trailers",
        "Chrysler",
        "CIMC",
        "Citroen",
        "Claas",
        "CM",
        "Cnhtc",
        "Coachcraft Technologies",
        "Coachmen",
        "Colt",
        "Combilift",
        "CompAir",
        "Conel",
        "Cooper",
        "Covered Wagon Trailers",
        "Crane Carrier",
        "Crown",
        "CRRC",
        "Cummins",
        "Currahee Trailers",
        "D & P Welding and AUTO",
        "D A F",
        "Dacia",
        "Daewoo",
        "DAF",
        "Daihatsu",
        "Daimler",
        "Dakota Manufacturing",
        "Datsun",
        "Demag",
        "Denning",
        "Derbi",
        "Deutz Fahr",
        "Deutz",
        "DFSK",
        "Diamond C Trailer",
        "Dingli",
        "Dinli",
        "Display Solutions",
        "Ditch Witch",
        "Dodge",
        "Dongben",
        "Dongfeng Yangtse",
        "Doosan",
        "DORIC ENGINEERING",
        "Ducati",
        "Dunlite",
        "Dyna",
        "Dynapac",
        "Eager Beaver",
        "Eagle",
        "East Texas Trailers",
        "Ebusco",
        "Echo",
        "Econoline Trailer",
        "Eicher",
        "Electric Motion",
        "Enforcer",
        "Etnyre",
        "Evans Steel",
        "Falcon Trailerworks",
        "Fantuzzi",
        "Farmtrac",
        "Faw",
        "Felling Trailers",
        "Fendt",
        "Ferrari",
        "FG Wilson",
        "Fiat",
        "Flextool",
        "Fontaine Trailers",
        "Ford",
        "Forest River",
        "Fork lift",
        "Foshan Shunde",
        "Fosti",
        "Foton",
        "Fraker Manufacturing",
        "Freedom Trailers",
        "FREIGHTER",
        "Freightliner",
        "FREIGHTQUIP",
        "FS Curtis",
        "FTE",
        "FUSO",
        "GasGas",
        "GAZ",
        "Geely",
        "Genelite",
        "Genesis",
        "Genie",
        "Ghel",
        "GM",
        "GMC",
        "Golden Dragon",
        "Gomoto",
        "Gravely",
        "Great Dane Trailers",
        "Great Northern Trailers",
        "Grove",
        "GTE",
        "Guleryuz",
        "GWM",
        "H & H Trailers",
        "Hafei",
        "Hajadu",
        "Hangcha",
        "Harley Davidson",
        "Hatz",
        "Haulmark",
        "Haval",
        "Hayvan",
        "Heil Trailers",
        "Hendrickson",
        "Henred Fruehauf",
        "Hensim",
        "Higer",
        "Hilite",
        "Hillsboro",
        "Hino",
        "Hitachi",
        "HMC",
        "Holden Industries",
        "Holden",
        "HOLMWOOD",
        "Homesteader",
        "Honda",
        "Horse Creek Manufacturing",
        "Hudson Brothers",
        "Hummer",
        "Husaberg",
        "Husqvarna",
        "Hustler",
        "Hydrovane",
        "Hyosung",
        "Hyster",
        "Hyundai",
        "Ibhubezi",
        "IC BUS",
        "Indian",
        "Indotrac",
        "Infiniti",
        "Ingersoll Rand",
        "Innovative Trailer",
        "InTech Trailers",
        "International",
        "Interstate",
        "Irisbus",
        "Irizar",
        "Isuzu",
        "Iveco",
        "J & L's Cargo express",
        "JAC",
        "Jaguar",
        "Jawa",
        "JCB",
        "Jeep",
        "Jet Company",
        "Jialing",
        "Jianshe",
        "Jimmy's Custom Built Trailers",
        "Jinma",
        "Jlg",
        "John deere",
        "Jonway",
        "JRW Trailers",
        "Jubilee",
        "Kamaz",
        "Karavan Trailer",
        "Karcher",
        "KARSAN",
        "Kaufman Trailers",
        "Kawasaki",
        "Kenworth",
        "Keogh",
        "Kerr-bilt",
        "Kia",
        "King Long",
        "Kinroad Xintian",
        "Kioti",
        "Kobelco",
        "Kohler",
        "Komatsu",
        "Konecranes",
        "Kotzur",
        "KRAZ",
        "KRUEGER",
        "KTM",
        "KTMMEX",
        "Kubota",
        "Kwik Kleen",
        "KYMCO",
        "La Padona",
        "Lada",
        "Lamar Trailers",
        "Lamborghini",
        "Lambretta",
        "Lancia",
        "Land rover",
        "Landini",
        "Lark United Manufacturing",
        "Larson Cable Trailers",
        "Laverda",
        "LDV",
        "Leeboy",
        "Lemco Tool",
        "Lexus",
        "LGS Industries",
        "LiAZ",
        "Liebherr",
        "Lifan",
        "Lincoln",
        "Linde",
        "Link-Belt",
        "Lister Petter",
        "Liugong",
        "Load Trail",
        "Lobstar",
        "Lone Star Oryogenics",
        "Lotus",
        "Loudo Trailers",
        "Luba",
        "Luigong",
        "M.D. Products",
        "MACK",
        "MAGIRUS",
        "Mahindra",
        "MAN",
        "Manitou",
        "MARSHALL LETHLEAN",
        "MarutiSuzuki",
        "Maserati",
        "Massey ferguson",
        "Master Tow",
        "Maxey Trailers",
        "MAXICUBE",
        "MaxiTRANS",
        "MAZ",
        "Mazda",
        "Mccormick",
        "McFarland",
        "Mclaren",
        "Mclaughlin",
        "MCT",
        "Mercedes Benz",
        "Merlo",
        "Merritt Equipment",
        "Mertz Manufacturing",
        "METRO",
        "MG",
        "MICK MURRAY WELDING",
        "Miller",
        "Mini",
        "Mitsubishi",
        "Mobi",
        "Mobile Tech Trailers",
        "Monon",
        "Monroe Towmaster",
        "Montracon",
        "Moto guzzi",
        "Motomia",
        "Motor Coach Industries",
        "Munsch",
        "MV Agusta",
        "National Motors",
        "NAVISTAR",
        "NefAZ",
        "Neoplan",
        "New Holland",
        "Nissan",
        "North Alabama Trailer",
        "Opel",
        "Operbus",
        "OPHEE",
        "Optare",
        "Orteq Energy Services",
        "Oshkosh",
        "Other",
        "Pace American",
        "Paiute Trailers",
        "Palfinger",
        "Parkwood",
        "PAZ",
        "Pegson",
        "PEKI",
        "Penske",
        "Peterbilt",
        "Peugeot",
        "PFI",
        "Piaggio",
        "Pierce Manufacturing",
        "PJ",
        "PLAN",
        "Polaris",
        "Polarsun",
        "Ponderosa Trailers",
        "Pontiac",
        "Porsche",
        "Powerscreen",
        "Powerstar",
        "PR Power",
        "Pratt Industries",
        "Prevost",
        "Priefert",
        "PTES",
        "Putzmeister",
        "R and I Holding",
        "Ram",
        "RAVO",
        "RC Trailers",
        "Redi-Haul",
        "Renault",
        "Rice Trailers",
        "Rig Works",
        "Ring-O-Matic Manufacturing",
        "ROADWEST",
        "Rokbak",
        "Rolls Rite Trailers",
        "Rolls Royce",
        "Rover",
        "Royal Enfield",
        "RTS",
        "SA Truck Bodies",
        "Saab",
        "Salvation Trailers",
        "Samil",
        "Sandvik",
        "Sany",
        "Saturn",
        "Scania",
        "Scanmaskin",
        "SCE",
        "SCHMITZ CARGO BULL",
        "Schmitz Cargobull",
        "Schwarzmüller",
        "Scion",
        "SDC Trailers",
        "Seat",
        "Secma",
        "Sennenbogen",
        "Serco",
        "Service King",
        "Setra",
        "Shacman",
        "Shanghai meitian motorcycle ",
        "Shaolin",
        "Shatui",
        "SHEPHARD",
        "Sherco",
        "Shermac",
        "Sherman + Reilly",
        "SIMAZ",
        "Sinotruk",
        "SISU",
        "Skoda",
        "Skyline",
        "Slingshot",
        "SMP",
        "Solaris",
        "Solartech",
        "Sonalika",
        "Soosan",
        "SOUTHERN CROSS",
        "Southern Heritage Trailers",
        "Soyat",
        "Ssangyong",
        "STEELBRO",
        "Sterling",
        "Still",
        "Storm",
        "Stoughton trailers",
        "Strick Trailer",
        "Subaru",
        "Sundowner",
        "Sunlong",
        "Super Products DURASUCKER",
        "Sure-Trac Trailers",
        "Suzhou Eagle",
        "Suzuki",
        "Sykes",
        "Sym",
        "T&J Trailers",
        "Tadano",
        "Tafe",
        "Takeuchi",
        "TAM Motors VIVAIR 104WL",
        "Tampa Trailerworks",
        "Tarter Industries",
        "Tata",
        "Tatra",
        "Temsa",
        "Terberg",
        "Terex",
        "Texas Bragg Enterprises",
        "Texas Pride Trailers",
        "TGB",
        "Thomas Built",
        "Thomas",
        "TIEMAN",
        "Timpte",
        "Tm racing",
        "Top Hat Industries",
        "Top trailers",
        "TORO",
        "Towmaster",
        "Toyota",
        "Trail Master",
        "Trail-Rite",
        "Tramontina",
        "Transcraft",
        "Trinity trailer",
        "Triton",
        "Triumph",
        "Trophy Boat Trailers",
        "TVS",
        "TX Bragg",
        "UAZ",
        "UD trucks",
        "United Trailers",
        "Ural",
        "Ursus",
        "Us truck",
        "Utility Trailer Manufacturer",
        "Vac-Tron Equipment",
        "Valtra (valmet)",
        "Van Hool",
        "Vanguard",
        "VAWDREY",
        "VDL",
        "Venieri",
        "Venturetech",
        "Vermeer",
        "Vespa",
        "Vic Grain",
        "Victory Trailers",
        "Volare",
        "Volkswagen",
        "Volvo",
        "Vuka",
        "Wabash",
        "Wacker Neuson",
        "Wallinga",
        "Wanco",
        "Wausau-Everest SD3131",
        "Welling & Crossley",
        "Wells Cargo",
        "Western Star",
        "Wheeler Reeler",
        "White Oliver",
        "Wilson",
        "Wirtgen",
        "Workhorse ",
        "WRIGHT",
        "WTM",
        "Wyatt's",
        "Wylie",
        "XCMG",
        "Xingyue",
        "Yale",
        "Yamaha",
        "Yamoto",
        "Yangste River",
        "Yanmar",
        "YEO TR ENGRG & TRDG",
        "YTO",
        "Yutong",
        "Zhejiang cf moto",
        "Zhejiang leike",
        "Zhejiang renli",
        "Zhejiang riya",
        "Zhongtong",
        "ZiL",
        "Zongshen",
        "Zontes",
        "Zoomlion",
        "Zotye",
        "Zx Auto"
    ],
    "assetImageUploadUrl": null,
    "organisationId": null,
    "organisationName": null,
    "canEditVin": true,
    "canEditConfigGroups": true,
    "canUpdateConfigGroupMembers": true,
    "engineHoursEnabled": false,
    "canResendCommissioningRequest": false,
    "canEditMobileNumber": false,
    "defaultIcons": {
        "1": "motorcycle-right",
        "2": "trailer2-right",
        "4": "boat-right",
        "5": "forklift-right",
        "6": "generator2-right",
        "7": "ems-right",
        "8": "tanker-right",
        "9": "car4-right",
        "10": "van-right",
        "11": "bus-right",
        "12": "bus-right",
        "13": "bus-right",
        "14": "truck-right",
        "15": "truck-right",
        "16": "truck-right",
        "17": "car-right",
        "18": "tanker-right",
        "19": "plough-right",
        "20": "truck-right",
        "21": "train-right",
        "22": "ldv-right",
        "24": "ldv-right",
        "25": "flatbed-truck-right",
        "26": "container",
        "27": "phone",
        "28": "truck-right"
    },
    "isOnJourney": false,
    "isStreamaxCommissioned": false,
    "hyperMedia": null
}
```

- requiredProperties was added on update, get
### Code

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number Code.png]]

### Swagger step 2

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number Swagger step 2.png]]

- id=1438935604688781312
- orgId=1085003241271469083
- configuration-groups_id=-3859349747606875553
- IsCalampPremium = true
- [ ] Add all other calams.... logical test?
	- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs
	- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetDetailsModule.cs
	- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs
	- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitConfigurationManager.cs
	- Nie regtig van pas
		- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Controllers\MobileUnitLevel\MobileUnitCommissioningController.cs
		- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.API\Routes\MobileUnitLevel\MobileUnitCommissioningRoutes.cs
		- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.Services.API.Client\CalampConnect\CalampConnectProxy.cs
		- C:\Projects\MiX.DeviceConfig\MiX.ConfigInternal.Api.Client\Repositories\InternalMobileUnitCommissioningRepository.cs
		- C:\Projects\MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Constants\MobileDevices.cs
- This swagger does what is expected, I will now check the UI logic as much as I can

## Testing via INT

### MR Test Calamp 3 (via UI)
- Status changed to: Configuration Changed
- [x] WHY is the IMEI greyed out? ✅ 2023-09-15
- [x] What happens in the Logs when VIN is updated? ✅ 2023-09-15
- UI
	- VIN: Still there, NOT greyed out
	- ==IMEI==: Blank, ==greyed== out

### MR Test Calamp 4 (Via swagger - no VIN update)
- Swagger seems fine
- Status remains: Not Commissioned
- UI
	- VIN still blank and not greyed out
	- IMEI still blank and not greyed out
- I think the issue is when the VIN is filled in...
### MR TEST Calamp 5 (Fill in VIN from the beginning and see UI)
- POST: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/1085003241271469083/asset/%7BassetId%7D/add
- Payload:
```json
{"assetId":"0","assetTypeId":"4","description":"MR TEST Calamp 5","registrationNumber":"MRTC5","mobileNumber":null,"siteId":"8850589907655221562","fuelType":null,"targetFuelConsumption":null,"targetFuelConsumptionUnits":"mpg (US)","targetHourlyFuelConsumption":null,"targetHourlyFuelConsumptionUnits":"gal (US)/h","fuelTankCapacity":null,"fleetNumber":null,"make":"AC","model":null,"year":null,"vinNumber":"11111222223333312","vinSource":null,"engineNumber":null,"fmVehicleId":null,"additionalMobileDevice":null,"notes":null,"icon":"boat-right","iconColour":"blue","colour":null,"assetImage":null,"assetImageUrl":null,"status":null,"createdBy":null,"configurationGroupId":"-3859349747606875553","createdDate":null,"country":null,"miXAccountNumber":null,"isNewAsset":true,"additionalDetailFields":[],"canProtocol":null,"requiredProperties":{},"volumeUnits":"gal (US)","wltp":null,"batteryCapacity":null,"usableBatteryCapacity":null,"distanceUnit":"mi"}
```

- Calamp 5 (all at once saved)
	- Get: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/1085003241271469083/asset/1439196099836575744/duplicate/false/get
```json
{
    "canEdit": true,
    "assetDetails": {
        "assetId": "1439196099836575744",
        "assetTypeId": "4",
        "eld": false,
        "description": "MR TEST Calamp 5",
        "isConnectedTrailer": false,
        "registrationNumber": "MRTC5",
        "mobileNumber": null,
        "siteId": "8850589907655221562",
        "fuelType": null,
        "targetFuelConsumption": null,
        "targetFuelConsumptionUnits": "mpg (US)",
        "targetHourlyFuelConsumption": null,
        "targetHourlyFuelConsumptionUnits": "gal (US)/h",
        "fuelTankCapacity": null,
        "fleetNumber": null,
        "make": "AC",
        "model": null,
        "year": null,
        "vinNumber": "11111222223333312",
        "vinSource": "MANUAL",
        "isNotCanVin": false,
        "vinNumberMatched": false,
        "engineNumber": null,
        "fmVehicleId": 7,
        "additionalMobileDevice": null,
        "notes": null,
        "icon": "boat-right",
        "iconColour": "blue",
        "colour": null,
        "assetImage": "asset-boat.jpg",
        "isDefaultImage": false,
        "assetImageUrl": null,
        "status": null,
        "createdBy": "Marthinus Raath",
        "configurationGroupId": "-3859349747606875553",
        "createdDate": null,
        "country": null,
        "miXAccountNumber": null,
        "isNewAsset": false,
        "isMobilePhone": false,
        "additionalDetailFields": [],
        "isStreamaxCommissioned": false,
        "decommissionStreamaxDevice": false,
        "canProtocol": null,
        "isScaniaOem": false,
        "isOnJourney": false,
        "requiredProperties": {
            "vin": false,
            "canProtocol": false,
            "fuelType": false
        },
        "volumeUnits": "gal (US)",
        "wltp": null,
        "batteryCapacity": null,
        "usableBatteryCapacity": null,
        "distanceUnit": "mi",
        "hyperMedia": null
    },
    "isNewAsset": false,
    "assetTypes": [
        {
            "value": "4",
            "text": "Boat"
        },
        {
            "value": "8",
            "text": "Dangerous Goods Vehicle"
        },
        {
            "value": "7",
            "text": "Emergency Service Vehicle"
        },
        {
            "value": "18",
            "text": "Fluid Transport Vehicle"
        },
        {
            "value": "11",
            "text": "Heavy Passenger Vehicle - Bus - Articulated"
        },
        {
            "value": "13",
            "text": "Heavy Passenger Vehicle - Bus - Double Decker"
        },
        {
            "value": "12",
            "text": "Heavy Passenger Vehicle - Bus - Single Decker"
        },
        {
            "value": "28",
            "text": "Heavy Vehicle"
        },
        {
            "value": "14",
            "text": "Heavy Vehicle - Articulated"
        },
        {
            "value": "15",
            "text": "Heavy Vehicle - Non-Articulated"
        },
        {
            "value": "16",
            "text": "Heavy Vehicle - Refrigerated Transport"
        },
        {
            "value": "22",
            "text": "Light Delivery Vehicle"
        },
        {
            "value": "10",
            "text": "Light Passenger Vehicle - Minibus"
        },
        {
            "value": "17",
            "text": "Light Vehicle"
        },
        {
            "value": "25",
            "text": "Medium Commercial Vehicle"
        },
        {
            "value": "27",
            "text": "Mobile Phone"
        },
        {
            "value": "5",
            "text": "Mobile Plant Equipment"
        },
        {
            "value": "1",
            "text": "Motorcycle"
        },
        {
            "value": "26",
            "text": "Non-Powered Asset"
        },
        {
            "value": "24",
            "text": "Off-Road Vehicle"
        },
        {
            "value": "20",
            "text": "Other"
        },
        {
            "value": "9",
            "text": "Passenger Vehicle"
        },
        {
            "value": "6",
            "text": "Stationary Plant Equipment"
        },
        {
            "value": "2",
            "text": "Trailer"
        },
        {
            "value": "21",
            "text": "Train"
        }
    ],
    "sites": [
        {
            "value": "8850589907655221562",
            "text": "Default Site"
        }
    ],
    "configGroups": [
        {
            "value": "-3859349747606875553",
            "text": "Default configuration group for CalAmp Premium"
        }
    ],
    "countries": [
        {
            "value": "AF",
            "text": "Afghanistan"
        },
        {
            "value": "AX",
            "text": "Åland Islands"
        },
        {
            "value": "AL",
            "text": "Albania"
        },
        {
            "value": "DZ",
            "text": "Algeria"
        },
        {
            "value": "AS",
            "text": "American Samoa"
        },
        {
            "value": "AD",
            "text": "Andorra"
        },
        {
            "value": "AO",
            "text": "Angola"
        },
        {
            "value": "AI",
            "text": "Anguilla"
        },
        {
            "value": "AQ",
            "text": "Antarctica"
        },
        {
            "value": "AG",
            "text": "Antigua and Barbuda"
        },
        {
            "value": "AR",
            "text": "Argentina"
        },
        {
            "value": "AM",
            "text": "Armenia"
        },
        {
            "value": "AW",
            "text": "Aruba"
        },
        {
            "value": "AU",
            "text": "Australia"
        },
        {
            "value": "AT",
            "text": "Austria"
        },
        {
            "value": "AZ",
            "text": "Azerbaijan"
        },
        {
            "value": "BS",
            "text": "Bahamas (the)"
        },
        {
            "value": "BH",
            "text": "Bahrain"
        },
        {
            "value": "BD",
            "text": "Bangladesh"
        },
        {
            "value": "BB",
            "text": "Barbados"
        },
        {
            "value": "BY",
            "text": "Belarus"
        },
        {
            "value": "BE",
            "text": "Belgium"
        },
        {
            "value": "BZ",
            "text": "Belize"
        },
        {
            "value": "BJ",
            "text": "Benin"
        },
        {
            "value": "BM",
            "text": "Bermuda"
        },
        {
            "value": "BT",
            "text": "Bhutan"
        },
        {
            "value": "BO",
            "text": "Bolivia, Plurinational State of"
        },
        {
            "value": "BQ",
            "text": "Bonaire, Sint Eustatius and Saba"
        },
        {
            "value": "BA",
            "text": "Bosnia and Herzegovina"
        },
        {
            "value": "BW",
            "text": "Botswana"
        },
        {
            "value": "BV",
            "text": "Bouvet Island"
        },
        {
            "value": "BR",
            "text": "Brazil"
        },
        {
            "value": "IO",
            "text": "British Indian Ocean Territory (the)"
        },
        {
            "value": "BN",
            "text": "Brunei Darussalam"
        },
        {
            "value": "BG",
            "text": "Bulgaria"
        },
        {
            "value": "BF",
            "text": "Burkina Faso"
        },
        {
            "value": "BI",
            "text": "Burundi"
        },
        {
            "value": "CV",
            "text": "Cabo Verde"
        },
        {
            "value": "KH",
            "text": "Cambodia"
        },
        {
            "value": "CM",
            "text": "Cameroon"
        },
        {
            "value": "CA",
            "text": "Canada"
        },
        {
            "value": "KY",
            "text": "Cayman Islands (the)"
        },
        {
            "value": "CF",
            "text": "Central African Republic (the)"
        },
        {
            "value": "TD",
            "text": "Chad"
        },
        {
            "value": "CL",
            "text": "Chile"
        },
        {
            "value": "CN",
            "text": "China"
        },
        {
            "value": "CX",
            "text": "Christmas Island"
        },
        {
            "value": "CC",
            "text": "Cocos (Keeling) Islands (the)"
        },
        {
            "value": "CO",
            "text": "Colombia"
        },
        {
            "value": "KM",
            "text": "Comoros"
        },
        {
            "value": "CG",
            "text": "Congo"
        },
        {
            "value": "CD",
            "text": "Congo (the Democratic Republic of the)"
        },
        {
            "value": "CK",
            "text": "Cook Islands (the)"
        },
        {
            "value": "CR",
            "text": "Costa Rica"
        },
        {
            "value": "CI",
            "text": "Côte d'Ivoire"
        },
        {
            "value": "HR",
            "text": "Croatia"
        },
        {
            "value": "CU",
            "text": "Cuba"
        },
        {
            "value": "CW",
            "text": "Curaçao"
        },
        {
            "value": "CY",
            "text": "Cyprus"
        },
        {
            "value": "CZ",
            "text": "Czech Republic (the)"
        },
        {
            "value": "DK",
            "text": "Denmark"
        },
        {
            "value": "DJ",
            "text": "Djibouti"
        },
        {
            "value": "DM",
            "text": "Dominica"
        },
        {
            "value": "DO",
            "text": "Dominican Republic (the)"
        },
        {
            "value": "EC",
            "text": "Ecuador"
        },
        {
            "value": "EG",
            "text": "Egypt"
        },
        {
            "value": "SV",
            "text": "El Salvador"
        },
        {
            "value": "GQ",
            "text": "Equatorial Guinea"
        },
        {
            "value": "ER",
            "text": "Eritrea"
        },
        {
            "value": "EE",
            "text": "Estonia"
        },
        {
            "value": "ET",
            "text": "Ethiopia"
        },
        {
            "value": "FK",
            "text": "Falkland Islands (the) [Malvinas]"
        },
        {
            "value": "FO",
            "text": "Faroe Islands (the)"
        },
        {
            "value": "FJ",
            "text": "Fiji"
        },
        {
            "value": "FI",
            "text": "Finland"
        },
        {
            "value": "FR",
            "text": "France"
        },
        {
            "value": "GF",
            "text": "French Guiana"
        },
        {
            "value": "PF",
            "text": "French Polynesia"
        },
        {
            "value": "TF",
            "text": "French Southern Territories (the)"
        },
        {
            "value": "GA",
            "text": "Gabon"
        },
        {
            "value": "GM",
            "text": "Gambia (The)"
        },
        {
            "value": "GE",
            "text": "Georgia"
        },
        {
            "value": "DE",
            "text": "Germany"
        },
        {
            "value": "GH",
            "text": "Ghana"
        },
        {
            "value": "GI",
            "text": "Gibraltar"
        },
        {
            "value": "GR",
            "text": "Greece"
        },
        {
            "value": "GL",
            "text": "Greenland"
        },
        {
            "value": "GD",
            "text": "Grenada"
        },
        {
            "value": "GP",
            "text": "Guadeloupe"
        },
        {
            "value": "GU",
            "text": "Guam"
        },
        {
            "value": "GT",
            "text": "Guatemala"
        },
        {
            "value": "GG",
            "text": "Guernsey"
        },
        {
            "value": "GN",
            "text": "Guinea"
        },
        {
            "value": "GW",
            "text": "Guinea-Bissau"
        },
        {
            "value": "GY",
            "text": "Guyana"
        },
        {
            "value": "HT",
            "text": "Haiti"
        },
        {
            "value": "HM",
            "text": "Heard Island and McDonald Islands"
        },
        {
            "value": "VA",
            "text": "Holy See (the) [Vatican City State]"
        },
        {
            "value": "HN",
            "text": "Honduras"
        },
        {
            "value": "HK",
            "text": "Hong Kong"
        },
        {
            "value": "HU",
            "text": "Hungary"
        },
        {
            "value": "IS",
            "text": "Iceland"
        },
        {
            "value": "IN",
            "text": "India"
        },
        {
            "value": "ID",
            "text": "Indonesia"
        },
        {
            "value": "IR",
            "text": "Iran (the Islamic Republic of)"
        },
        {
            "value": "IQ",
            "text": "Iraq"
        },
        {
            "value": "IE",
            "text": "Ireland"
        },
        {
            "value": "IM",
            "text": "Isle of Man"
        },
        {
            "value": "IL",
            "text": "Israel"
        },
        {
            "value": "IT",
            "text": "Italy"
        },
        {
            "value": "JM",
            "text": "Jamaica"
        },
        {
            "value": "JP",
            "text": "Japan"
        },
        {
            "value": "JE",
            "text": "Jersey"
        },
        {
            "value": "JO",
            "text": "Jordan"
        },
        {
            "value": "KZ",
            "text": "Kazakhstan"
        },
        {
            "value": "KE",
            "text": "Kenya"
        },
        {
            "value": "KI",
            "text": "Kiribati"
        },
        {
            "value": "KP",
            "text": "Korea (the Democratic People's Republic of)"
        },
        {
            "value": "KR",
            "text": "Korea (the Republic of)"
        },
        {
            "value": "KW",
            "text": "Kuwait"
        },
        {
            "value": "KG",
            "text": "Kyrgyzstan"
        },
        {
            "value": "LA",
            "text": "Lao People's Democratic Republic (the)"
        },
        {
            "value": "LV",
            "text": "Latvia"
        },
        {
            "value": "LB",
            "text": "Lebanon"
        },
        {
            "value": "LS",
            "text": "Lesotho"
        },
        {
            "value": "LR",
            "text": "Liberia"
        },
        {
            "value": "LY",
            "text": "Libya"
        },
        {
            "value": "LI",
            "text": "Liechtenstein"
        },
        {
            "value": "LT",
            "text": "Lithuania"
        },
        {
            "value": "LU",
            "text": "Luxembourg"
        },
        {
            "value": "MO",
            "text": "Macao"
        },
        {
            "value": "MK",
            "text": "Macedonia (the former Yugoslav Republic of)"
        },
        {
            "value": "MG",
            "text": "Madagascar"
        },
        {
            "value": "MW",
            "text": "Malawi"
        },
        {
            "value": "MY",
            "text": "Malaysia"
        },
        {
            "value": "MV",
            "text": "Maldives"
        },
        {
            "value": "ML",
            "text": "Mali"
        },
        {
            "value": "MT",
            "text": "Malta"
        },
        {
            "value": "MH",
            "text": "Marshall Islands (the)"
        },
        {
            "value": "MQ",
            "text": "Martinique"
        },
        {
            "value": "MR",
            "text": "Mauritania"
        },
        {
            "value": "MU",
            "text": "Mauritius"
        },
        {
            "value": "YT",
            "text": "Mayotte"
        },
        {
            "value": "MX",
            "text": "Mexico"
        },
        {
            "value": "FM",
            "text": "Micronesia (the Federated States of)"
        },
        {
            "value": "MD",
            "text": "Moldova (the Republic of)"
        },
        {
            "value": "MC",
            "text": "Monaco"
        },
        {
            "value": "MN",
            "text": "Mongolia"
        },
        {
            "value": "ME",
            "text": "Montenegro"
        },
        {
            "value": "MS",
            "text": "Montserrat"
        },
        {
            "value": "MA",
            "text": "Morocco"
        },
        {
            "value": "MZ",
            "text": "Mozambique"
        },
        {
            "value": "MM",
            "text": "Myanmar"
        },
        {
            "value": "NA",
            "text": "Namibia"
        },
        {
            "value": "NR",
            "text": "Nauru"
        },
        {
            "value": "NP",
            "text": "Nepal"
        },
        {
            "value": "NL",
            "text": "Netherlands (the)"
        },
        {
            "value": "NC",
            "text": "New Caledonia"
        },
        {
            "value": "NZ",
            "text": "New Zealand"
        },
        {
            "value": "NI",
            "text": "Nicaragua"
        },
        {
            "value": "NE",
            "text": "Niger (the)"
        },
        {
            "value": "NG",
            "text": "Nigeria"
        },
        {
            "value": "NU",
            "text": "Niue"
        },
        {
            "value": "NF",
            "text": "Norfolk Island"
        },
        {
            "value": "MP",
            "text": "Northern Mariana Islands (the)"
        },
        {
            "value": "NO",
            "text": "Norway"
        },
        {
            "value": "OM",
            "text": "Oman"
        },
        {
            "value": "PK",
            "text": "Pakistan"
        },
        {
            "value": "PW",
            "text": "Palau"
        },
        {
            "value": "PS",
            "text": "Palestine, State of"
        },
        {
            "value": "PA",
            "text": "Panama"
        },
        {
            "value": "PG",
            "text": "Papua New Guinea"
        },
        {
            "value": "PY",
            "text": "Paraguay"
        },
        {
            "value": "PE",
            "text": "Peru"
        },
        {
            "value": "PH",
            "text": "Philippines (the)"
        },
        {
            "value": "PN",
            "text": "Pitcairn"
        },
        {
            "value": "PL",
            "text": "Poland"
        },
        {
            "value": "PT",
            "text": "Portugal"
        },
        {
            "value": "PR",
            "text": "Puerto Rico"
        },
        {
            "value": "QA",
            "text": "Qatar"
        },
        {
            "value": "RE",
            "text": "Réunion"
        },
        {
            "value": "RO",
            "text": "Romania"
        },
        {
            "value": "RU",
            "text": "Russian Federation (the)"
        },
        {
            "value": "RW",
            "text": "Rwanda"
        },
        {
            "value": "BL",
            "text": "Saint Barthélemy"
        },
        {
            "value": "SH",
            "text": "Saint Helena, Ascension and Tristan da Cunha"
        },
        {
            "value": "KN",
            "text": "Saint Kitts and Nevis"
        },
        {
            "value": "LC",
            "text": "Saint Lucia"
        },
        {
            "value": "MF",
            "text": "Saint Martin (French part)"
        },
        {
            "value": "PM",
            "text": "Saint Pierre and Miquelon"
        },
        {
            "value": "VC",
            "text": "Saint Vincent and the Grenadines"
        },
        {
            "value": "WS",
            "text": "Samoa"
        },
        {
            "value": "SM",
            "text": "San Marino"
        },
        {
            "value": "ST",
            "text": "Sao Tome and Principe"
        },
        {
            "value": "SA",
            "text": "Saudi Arabia"
        },
        {
            "value": "SN",
            "text": "Senegal"
        },
        {
            "value": "RS",
            "text": "Serbia"
        },
        {
            "value": "SC",
            "text": "Seychelles"
        },
        {
            "value": "SL",
            "text": "Sierra Leone"
        },
        {
            "value": "SG",
            "text": "Singapore"
        },
        {
            "value": "SX",
            "text": "Sint Maarten (Dutch part)"
        },
        {
            "value": "SK",
            "text": "Slovakia"
        },
        {
            "value": "SI",
            "text": "Slovenia"
        },
        {
            "value": "SB",
            "text": "Solomon Islands (the)"
        },
        {
            "value": "SO",
            "text": "Somalia"
        },
        {
            "value": "ZA",
            "text": "South Africa"
        },
        {
            "value": "GS",
            "text": "South Georgia and the South Sandwich Islands"
        },
        {
            "value": "SS",
            "text": "South Sudan"
        },
        {
            "value": "ES",
            "text": "Spain"
        },
        {
            "value": "LK",
            "text": "Sri Lanka"
        },
        {
            "value": "SD",
            "text": "Sudan (the)"
        },
        {
            "value": "SR",
            "text": "Suriname"
        },
        {
            "value": "SJ",
            "text": "Svalbard and Jan Mayen"
        },
        {
            "value": "SZ",
            "text": "Swaziland"
        },
        {
            "value": "SE",
            "text": "Sweden"
        },
        {
            "value": "CH",
            "text": "Switzerland"
        },
        {
            "value": "SY",
            "text": "Syrian Arab Republic (the)"
        },
        {
            "value": "TW",
            "text": "Taiwan (Province of China)"
        },
        {
            "value": "TJ",
            "text": "Tajikistan"
        },
        {
            "value": "TZ",
            "text": "Tanzania, United Republic of"
        },
        {
            "value": "TH",
            "text": "Thailand"
        },
        {
            "value": "TL",
            "text": "Timor-Leste"
        },
        {
            "value": "TG",
            "text": "Togo"
        },
        {
            "value": "TK",
            "text": "Tokelau"
        },
        {
            "value": "TO",
            "text": "Tonga"
        },
        {
            "value": "TT",
            "text": "Trinidad and Tobago"
        },
        {
            "value": "TN",
            "text": "Tunisia"
        },
        {
            "value": "TR",
            "text": "Turkey"
        },
        {
            "value": "TM",
            "text": "Turkmenistan"
        },
        {
            "value": "TC",
            "text": "Turks and Caicos Islands (the)"
        },
        {
            "value": "TV",
            "text": "Tuvalu"
        },
        {
            "value": "UG",
            "text": "Uganda"
        },
        {
            "value": "UA",
            "text": "Ukraine"
        },
        {
            "value": "AE",
            "text": "United Arab Emirates (the)"
        },
        {
            "value": "GB",
            "text": "United Kingdom (the)"
        },
        {
            "value": "US",
            "text": "United States (the)"
        },
        {
            "value": "UM",
            "text": "United States Minor Outlying Islands (the)"
        },
        {
            "value": "UY",
            "text": "Uruguay"
        },
        {
            "value": "UZ",
            "text": "Uzbekistan"
        },
        {
            "value": "VU",
            "text": "Vanuatu"
        },
        {
            "value": "VE",
            "text": "Venezuela, Bolivarian Republic of"
        },
        {
            "value": "VN",
            "text": "Viet Nam"
        },
        {
            "value": "VG",
            "text": "Virgin Islands (British)"
        },
        {
            "value": "VI",
            "text": "Virgin Islands (U.S.)"
        },
        {
            "value": "WF",
            "text": "Wallis and Futuna"
        },
        {
            "value": "EH",
            "text": "Western Sahara"
        },
        {
            "value": "YE",
            "text": "Yemen"
        },
        {
            "value": "ZM",
            "text": "Zambia"
        },
        {
            "value": "ZW",
            "text": "Zimbabwe"
        }
    ],
    "fuelTypes": [
        {
            "id": "Bi-fuel using diesel",
            "description": "Bi-fuel using diesel"
        },
        {
            "id": "Bi-fuel vehicle using battery",
            "description": "Bi-fuel vehicle using battery"
        },
        {
            "id": "Bi-fuel vehicle using battery and combustion engine",
            "description": "Bi-fuel vehicle using battery and combustion engine"
        },
        {
            "id": "Bi-fuel vehicle using CNG",
            "description": "Bi-fuel vehicle using CNG"
        },
        {
            "id": "Bi-fuel vehicle using ethanol",
            "description": "Bi-fuel vehicle using ethanol"
        },
        {
            "id": "Bi-fuel vehicle using LPG",
            "description": "Bi-fuel vehicle using LPG"
        },
        {
            "id": "Bi-fuel vehicle using methanol",
            "description": "Bi-fuel vehicle using methanol"
        },
        {
            "id": "Bi-fuel vehicle using natural gas",
            "description": "Bi-fuel vehicle using natural gas"
        },
        {
            "id": "Bi-fuel vehicle using petrol",
            "description": "Bi-fuel vehicle using petrol"
        },
        {
            "id": "Bi-fuel vehicle using propane",
            "description": "Bi-fuel vehicle using propane"
        },
        {
            "id": "Compressed Natural Gas",
            "description": "Compressed Natural Gas"
        },
        {
            "id": "Diesel",
            "description": "Diesel"
        },
        {
            "id": "Dual fuel - diesel and compressed natural gas",
            "description": "Dual fuel - diesel and compressed natural gas"
        },
        {
            "id": "Dual fuel - diesel and liquid natural gas",
            "description": "Dual fuel - diesel and liquid natural gas"
        },
        {
            "id": "Electric",
            "description": "Electric"
        },
        {
            "id": "Ethanol",
            "description": "Ethanol"
        },
        {
            "id": "Hybrid vehicle in regeneration mode",
            "description": "Hybrid vehicle in regeneration mode"
        },
        {
            "id": "Hybrid vehicle using battery",
            "description": "Hybrid vehicle using battery"
        },
        {
            "id": "Hybrid vehicle using battery and combustion engine",
            "description": "Hybrid vehicle using battery and combustion engine"
        },
        {
            "id": "Hybrid vehicle using diesel engine",
            "description": "Hybrid vehicle using diesel engine"
        },
        {
            "id": "Hybrid vehicle using gasoline engine",
            "description": "Hybrid vehicle using gasoline engine"
        },
        {
            "id": "Hybrid vehicle using gasoline engine on ethanol",
            "description": "Hybrid vehicle using gasoline engine on ethanol"
        },
        {
            "id": "Liquified Petroleum Gas",
            "description": "Liquified Petroleum Gas"
        },
        {
            "id": "Methanol",
            "description": "Methanol"
        },
        {
            "id": "Natural gas",
            "description": "Natural gas"
        },
        {
            "id": "Natural gas (compressed or liquefied natural gas)",
            "description": "Natural gas (compressed or liquefied natural gas)"
        },
        {
            "id": "Petrol",
            "description": "Petrol"
        },
        {
            "id": "Propane",
            "description": "Propane"
        },
        {
            "id": "Not available",
            "description": "Not available"
        },
        {
            "id": "Other",
            "description": "Other"
        }
    ],
    "icons": [
        "van-right",
        "truck-right",
        "trailer-right",
        "trailer2-right",
        "tipper-right",
        "tanker-right",
        "plough-right",
        "crane2-right",
        "crane-right",
        "ems-right",
        "generator2-right",
        "generator-right",
        "forklift-right",
        "key-right",
        "motorcycle-right",
        "car-right",
        "car5-right",
        "car4-right",
        "car3-right",
        "car2-right",
        "bus-right",
        "boat-right",
        "batmobile2-right",
        "batmobile-right",
        "phone",
        "person",
        "ldv-right",
        "train-right",
        "container",
        "ewp-right",
        "chipper-right",
        "truck-logging-right",
        "saw-blade1",
        "saw-blade2",
        "crane-logging"
    ],
    "iconColours": [
        "black",
        "blue",
        "green",
        "teal",
        "deepSkyBlue",
        "aqua",
        "forestGreen",
        "limeGreen",
        "indigo",
        "dimGray",
        "maroon",
        "purple",
        "lightGreen",
        "lightBlue",
        "fireBrick",
        "indianRed",
        "orchid",
        "crimson",
        "lightCoral",
        "red",
        "deepPink",
        "darkOrange",
        "lightPink",
        "yellow"
    ],
    "makesAndModels": [
        "A Trinity Trailer",
        "Abarth",
        "AC",
        "ADL",
        "Adly",
        "Advanced Power",
        "Advantec",
        "Aebi Schmidt",
        "Afrit",
        "Agco Allis (agrotec)",
        "Agrale",
        "Agria",
        "Agria-deutz",
        "Agrico",
        "Air Stream",
        "Alcom LLC",
        "Alfa Romeo",
        "Alimak",
        "Allight",
        "Allmand",
        "Alum-Line",
        "AMC",
        "Amco Vebo",
        "American Crawler",
        "American Trailers",
        "Anglo International",
        "Appalachian Trailers",
        "Aprilia",
        "Arctic Cat",
        "Arising Industries",
        "Arora",
        "Ashok Leyland",
        "Asia Wing",
        "Aston Martin",
        "ASTRA",
        "ATE",
        "Atlas Copco",
        "ATLAS",
        "Atoka Trailer & Mfg.",
        "Atul Auto",
        "Audi",
        "Autocar",
        "B.A.W",
        "Backdraft Racing",
        "Baic",
        "Bajaj",
        "Baoli forklift",
        "Barford",
        "BARKER",
        "Bartlett",
        "BCI",
        "Beiben",
        "Beiqi Foton",
        "Bell Equipment",
        "Belmont Machine",
        "Belshe Industries",
        "Bennche",
        "Bennelli",
        "Bentley",
        "Bestar China",
        "Beta Racing",
        "Big Bubba's Trailer",
        "Big Tex Trailer",
        "Bimota",
        "Bitelli",
        "Blackstone Trailer ",
        "Blackwood hodge",
        "Blue Bird",
        "Blue Diamond",
        "BMC",
        "BMW",
        "Bobcat",
        "Bomag",
        "Bombardiercanam",
        "Bonluck",
        "Bravo Trailers",
        "Brazos",
        "Brindle Products",
        "Brooks Brothers",
        "BRUCE ROCK END",
        "Buick",
        "Busaf",
        "Buyang",
        "BYD",
        "Cadillac",
        "Cagiva",
        "Can-am",
        "Capacity",
        "Cargo Craft",
        "Carry-On Trailer",
        "Case International",
        "Caterpillar",
        "CBH",
        "Centralia Machine",
        "Century Built",
        "CF Moto",
        "Chana - Changan",
        "Changjiang",
        "Chengliwei",
        "Chery",
        "Chevrolet",
        "Choice Trailers",
        "Chrysler",
        "CIMC",
        "Citroen",
        "Claas",
        "CM",
        "Cnhtc",
        "Coachcraft Technologies",
        "Coachmen",
        "Colt",
        "Combilift",
        "CompAir",
        "Conel",
        "Cooper",
        "Covered Wagon Trailers",
        "Crane Carrier",
        "Crown",
        "CRRC",
        "Cummins",
        "Currahee Trailers",
        "D & P Welding and AUTO",
        "D A F",
        "Dacia",
        "Daewoo",
        "DAF",
        "Daihatsu",
        "Daimler",
        "Dakota Manufacturing",
        "Datsun",
        "Demag",
        "Denning",
        "Derbi",
        "Deutz Fahr",
        "Deutz",
        "DFSK",
        "Diamond C Trailer",
        "Dingli",
        "Dinli",
        "Display Solutions",
        "Ditch Witch",
        "Dodge",
        "Dongben",
        "Dongfeng Yangtse",
        "Doosan",
        "DORIC ENGINEERING",
        "Ducati",
        "Dunlite",
        "Dyna",
        "Dynapac",
        "Eager Beaver",
        "Eagle",
        "East Texas Trailers",
        "Ebusco",
        "Echo",
        "Econoline Trailer",
        "Eicher",
        "Electric Motion",
        "Enforcer",
        "Etnyre",
        "Evans Steel",
        "Falcon Trailerworks",
        "Fantuzzi",
        "Farmtrac",
        "Faw",
        "Felling Trailers",
        "Fendt",
        "Ferrari",
        "FG Wilson",
        "Fiat",
        "Flextool",
        "Fontaine Trailers",
        "Ford",
        "Forest River",
        "Fork lift",
        "Foshan Shunde",
        "Fosti",
        "Foton",
        "Fraker Manufacturing",
        "Freedom Trailers",
        "FREIGHTER",
        "Freightliner",
        "FREIGHTQUIP",
        "FS Curtis",
        "FTE",
        "FUSO",
        "GasGas",
        "GAZ",
        "Geely",
        "Genelite",
        "Genesis",
        "Genie",
        "Ghel",
        "GM",
        "GMC",
        "Golden Dragon",
        "Gomoto",
        "Gravely",
        "Great Dane Trailers",
        "Great Northern Trailers",
        "Grove",
        "GTE",
        "Guleryuz",
        "GWM",
        "H & H Trailers",
        "Hafei",
        "Hajadu",
        "Hangcha",
        "Harley Davidson",
        "Hatz",
        "Haulmark",
        "Haval",
        "Hayvan",
        "Heil Trailers",
        "Hendrickson",
        "Henred Fruehauf",
        "Hensim",
        "Higer",
        "Hilite",
        "Hillsboro",
        "Hino",
        "Hitachi",
        "HMC",
        "Holden Industries",
        "Holden",
        "HOLMWOOD",
        "Homesteader",
        "Honda",
        "Horse Creek Manufacturing",
        "Hudson Brothers",
        "Hummer",
        "Husaberg",
        "Husqvarna",
        "Hustler",
        "Hydrovane",
        "Hyosung",
        "Hyster",
        "Hyundai",
        "Ibhubezi",
        "IC BUS",
        "Indian",
        "Indotrac",
        "Infiniti",
        "Ingersoll Rand",
        "Innovative Trailer",
        "InTech Trailers",
        "International",
        "Interstate",
        "Irisbus",
        "Irizar",
        "Isuzu",
        "Iveco",
        "J & L's Cargo express",
        "JAC",
        "Jaguar",
        "Jawa",
        "JCB",
        "Jeep",
        "Jet Company",
        "Jialing",
        "Jianshe",
        "Jimmy's Custom Built Trailers",
        "Jinma",
        "Jlg",
        "John deere",
        "Jonway",
        "JRW Trailers",
        "Jubilee",
        "Kamaz",
        "Karavan Trailer",
        "Karcher",
        "KARSAN",
        "Kaufman Trailers",
        "Kawasaki",
        "Kenworth",
        "Keogh",
        "Kerr-bilt",
        "Kia",
        "King Long",
        "Kinroad Xintian",
        "Kioti",
        "Kobelco",
        "Kohler",
        "Komatsu",
        "Konecranes",
        "Kotzur",
        "KRAZ",
        "KRUEGER",
        "KTM",
        "KTMMEX",
        "Kubota",
        "Kwik Kleen",
        "KYMCO",
        "La Padona",
        "Lada",
        "Lamar Trailers",
        "Lamborghini",
        "Lambretta",
        "Lancia",
        "Land rover",
        "Landini",
        "Lark United Manufacturing",
        "Larson Cable Trailers",
        "Laverda",
        "LDV",
        "Leeboy",
        "Lemco Tool",
        "Lexus",
        "LGS Industries",
        "LiAZ",
        "Liebherr",
        "Lifan",
        "Lincoln",
        "Linde",
        "Link-Belt",
        "Lister Petter",
        "Liugong",
        "Load Trail",
        "Lobstar",
        "Lone Star Oryogenics",
        "Lotus",
        "Loudo Trailers",
        "Luba",
        "Luigong",
        "M.D. Products",
        "MACK",
        "MAGIRUS",
        "Mahindra",
        "MAN",
        "Manitou",
        "MARSHALL LETHLEAN",
        "MarutiSuzuki",
        "Maserati",
        "Massey ferguson",
        "Master Tow",
        "Maxey Trailers",
        "MAXICUBE",
        "MaxiTRANS",
        "MAZ",
        "Mazda",
        "Mccormick",
        "McFarland",
        "Mclaren",
        "Mclaughlin",
        "MCT",
        "Mercedes Benz",
        "Merlo",
        "Merritt Equipment",
        "Mertz Manufacturing",
        "METRO",
        "MG",
        "MICK MURRAY WELDING",
        "Miller",
        "Mini",
        "Mitsubishi",
        "Mobi",
        "Mobile Tech Trailers",
        "Monon",
        "Monroe Towmaster",
        "Montracon",
        "Moto guzzi",
        "Motomia",
        "Motor Coach Industries",
        "Munsch",
        "MV Agusta",
        "National Motors",
        "NAVISTAR",
        "NefAZ",
        "Neoplan",
        "New Holland",
        "Nissan",
        "North Alabama Trailer",
        "Opel",
        "Operbus",
        "OPHEE",
        "Optare",
        "Orteq Energy Services",
        "Oshkosh",
        "Other",
        "Pace American",
        "Paiute Trailers",
        "Palfinger",
        "Parkwood",
        "PAZ",
        "Pegson",
        "PEKI",
        "Penske",
        "Peterbilt",
        "Peugeot",
        "PFI",
        "Piaggio",
        "Pierce Manufacturing",
        "PJ",
        "PLAN",
        "Polaris",
        "Polarsun",
        "Ponderosa Trailers",
        "Pontiac",
        "Porsche",
        "Powerscreen",
        "Powerstar",
        "PR Power",
        "Pratt Industries",
        "Prevost",
        "Priefert",
        "PTES",
        "Putzmeister",
        "R and I Holding",
        "Ram",
        "RAVO",
        "RC Trailers",
        "Redi-Haul",
        "Renault",
        "Rice Trailers",
        "Rig Works",
        "Ring-O-Matic Manufacturing",
        "ROADWEST",
        "Rokbak",
        "Rolls Rite Trailers",
        "Rolls Royce",
        "Rover",
        "Royal Enfield",
        "RTS",
        "SA Truck Bodies",
        "Saab",
        "Salvation Trailers",
        "Samil",
        "Sandvik",
        "Sany",
        "Saturn",
        "Scania",
        "Scanmaskin",
        "SCE",
        "SCHMITZ CARGO BULL",
        "Schmitz Cargobull",
        "Schwarzmüller",
        "Scion",
        "SDC Trailers",
        "Seat",
        "Secma",
        "Sennenbogen",
        "Serco",
        "Service King",
        "Setra",
        "Shacman",
        "Shanghai meitian motorcycle ",
        "Shaolin",
        "Shatui",
        "SHEPHARD",
        "Sherco",
        "Shermac",
        "Sherman + Reilly",
        "SIMAZ",
        "Sinotruk",
        "SISU",
        "Skoda",
        "Skyline",
        "Slingshot",
        "SMP",
        "Solaris",
        "Solartech",
        "Sonalika",
        "Soosan",
        "SOUTHERN CROSS",
        "Southern Heritage Trailers",
        "Soyat",
        "Ssangyong",
        "STEELBRO",
        "Sterling",
        "Still",
        "Storm",
        "Stoughton trailers",
        "Strick Trailer",
        "Subaru",
        "Sundowner",
        "Sunlong",
        "Super Products DURASUCKER",
        "Sure-Trac Trailers",
        "Suzhou Eagle",
        "Suzuki",
        "Sykes",
        "Sym",
        "T&J Trailers",
        "Tadano",
        "Tafe",
        "Takeuchi",
        "TAM Motors VIVAIR 104WL",
        "Tampa Trailerworks",
        "Tarter Industries",
        "Tata",
        "Tatra",
        "Temsa",
        "Terberg",
        "Terex",
        "Texas Bragg Enterprises",
        "Texas Pride Trailers",
        "TGB",
        "Thomas Built",
        "Thomas",
        "TIEMAN",
        "Timpte",
        "Tm racing",
        "Top Hat Industries",
        "Top trailers",
        "TORO",
        "Towmaster",
        "Toyota",
        "Trail Master",
        "Trail-Rite",
        "Tramontina",
        "Transcraft",
        "Trinity trailer",
        "Triton",
        "Triumph",
        "Trophy Boat Trailers",
        "TVS",
        "TX Bragg",
        "UAZ",
        "UD trucks",
        "United Trailers",
        "Ural",
        "Ursus",
        "Us truck",
        "Utility Trailer Manufacturer",
        "Vac-Tron Equipment",
        "Valtra (valmet)",
        "Van Hool",
        "Vanguard",
        "VAWDREY",
        "VDL",
        "Venieri",
        "Venturetech",
        "Vermeer",
        "Vespa",
        "Vic Grain",
        "Victory Trailers",
        "Volare",
        "Volkswagen",
        "Volvo",
        "Vuka",
        "Wabash",
        "Wacker Neuson",
        "Wallinga",
        "Wanco",
        "Wausau-Everest SD3131",
        "Welling & Crossley",
        "Wells Cargo",
        "Western Star",
        "Wheeler Reeler",
        "White Oliver",
        "Wilson",
        "Wirtgen",
        "Workhorse ",
        "WRIGHT",
        "WTM",
        "Wyatt's",
        "Wylie",
        "XCMG",
        "Xingyue",
        "Yale",
        "Yamaha",
        "Yamoto",
        "Yangste River",
        "Yanmar",
        "YEO TR ENGRG & TRDG",
        "YTO",
        "Yutong",
        "Zhejiang cf moto",
        "Zhejiang leike",
        "Zhejiang renli",
        "Zhejiang riya",
        "Zhongtong",
        "ZiL",
        "Zongshen",
        "Zontes",
        "Zoomlion",
        "Zotye",
        "Zx Auto"
    ],
    "assetImageUploadUrl": null,
    "organisationId": null,
    "organisationName": null,
    "canEditVin": true,
    "canEditConfigGroups": true,
    "canUpdateConfigGroupMembers": true,
    "engineHoursEnabled": false,
    "canResendCommissioningRequest": false,
    "canEditMobileNumber": false,
    "defaultIcons": {
        "1": "motorcycle-right",
        "2": "trailer2-right",
        "4": "boat-right",
        "5": "forklift-right",
        "6": "generator2-right",
        "7": "ems-right",
        "8": "tanker-right",
        "9": "car4-right",
        "10": "van-right",
        "11": "bus-right",
        "12": "bus-right",
        "13": "bus-right",
        "14": "truck-right",
        "15": "truck-right",
        "16": "truck-right",
        "17": "car-right",
        "18": "tanker-right",
        "19": "plough-right",
        "20": "truck-right",
        "21": "train-right",
        "22": "ldv-right",
        "24": "ldv-right",
        "25": "flatbed-truck-right",
        "26": "container",
        "27": "phone",
        "28": "truck-right"
    },
    "isOnJourney": false,
    "isStreamaxCommissioned": false,
    "hyperMedia": null
}
```
- UI
	- VIN: There - not greyed out
	- IMEI: Blank, not greyed out

### Calamp 6 (Could test Local, Asset Details wont load)
- Local
- First no VIN save, but config group
	- hasbeencommissioned = xxxxxxxxx
- Add VIN and save
	- hasbeencommissioned = xxxxxxxxx
Cant do this locally
![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number Not Allowed Locally.png|400]]

### MR Test Calamp 7 (INT, check payload to determine program flow)

#### First no VIN save, but config group

- Add: POST: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/1085003241271469083/asset/%7BassetId%7D/add
- Regex: asset-details/group.*\/add$
```json
{"assetId":"0","assetTypeId":"4","description":"MR Test Calamp 7","registrationNumber":"MRTC7","mobileNumber":null,"siteId":"8850589907655221562","fuelType":null,"targetFuelConsumption":null,"targetFuelConsumptionUnits":"mpg (US)","targetHourlyFuelConsumption":null,"targetHourlyFuelConsumptionUnits":"gal (US)/h","fuelTankCapacity":null,"fleetNumber":null,"make":"AC","model":null,"year":null,"vinNumber":null,"vinSource":null,"engineNumber":null,"fmVehicleId":null,"additionalMobileDevice":null,"notes":null,"icon":"boat-right","iconColour":"blue","colour":null,"assetImage":null,"assetImageUrl":null,"status":null,"createdBy":null,"configurationGroupId":"-3859349747606875553","createdDate":null,"country":null,"miXAccountNumber":null,"isNewAsset":true,"additionalDetailFields":[],"canProtocol":null,"requiredProperties":{},"volumeUnits":"gal (US)","wltp":null,"batteryCapacity":null,"usableBatteryCapacity":null,"distanceUnit":"mi"}
```
- Get: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/1085003241271469083/asset/1439217777257938944/duplicate/false/get
	- hasbeencommissioned = false
- Result
```json
{
    "canEdit": true,
    "assetDetails": {
        "assetId": "1439217777257938944",
        "assetTypeId": "4",
        "eld": false,
        "description": "MR Test Calamp 7",
        "isConnectedTrailer": false,
        "registrationNumber": "MRTC7",
        "mobileNumber": null,
        "siteId": "8850589907655221562",
        "fuelType": null,
        "targetFuelConsumption": null,
        "targetFuelConsumptionUnits": "mpg (US)",
        "targetHourlyFuelConsumption": null,
        "targetHourlyFuelConsumptionUnits": "gal (US)/h",
        "fuelTankCapacity": null,
        "fleetNumber": null,
        "make": "AC",
        "model": null,
        "year": null,
        "vinNumber": null,
        "vinSource": "MANUAL",
        "isNotCanVin": false,
        "vinNumberMatched": false,
        "engineNumber": null,
        "fmVehicleId": 8,
        "additionalMobileDevice": null,
        "notes": null,
        "icon": "boat-right",
        "iconColour": "blue",
        "colour": null,
        "assetImage": "asset-boat.jpg",
        "isDefaultImage": false,
        "assetImageUrl": null,
        "status": null,
        "createdBy": "Marthinus Raath",
        "configurationGroupId": "-3859349747606875553",
        "createdDate": null,
        "country": null,
        "miXAccountNumber": null,
        "isNewAsset": false,
        "isMobilePhone": false,
        "additionalDetailFields": [],
        "isStreamaxCommissioned": false,
        "decommissionStreamaxDevice": false,
        "canProtocol": null,
        "isScaniaOem": false,
        "isOnJourney": false,
        "requiredProperties": {
            "vin": false,
            "canProtocol": false,
            "fuelType": false
        },
        "volumeUnits": "gal (US)",
        "wltp": null,
        "batteryCapacity": null,
        "usableBatteryCapacity": null,
        "distanceUnit": "mi",
        "hyperMedia": null
    },
    "isNewAsset": false,
    "assetTypes": [
        {
            "value": "4",
            "text": "Boat"
        },
        {
            "value": "8",
            "text": "Dangerous Goods Vehicle"
        },
        {
            "value": "7",
            "text": "Emergency Service Vehicle"
        },
        {
            "value": "18",
            "text": "Fluid Transport Vehicle"
        },
        {
            "value": "11",
            "text": "Heavy Passenger Vehicle - Bus - Articulated"
        },
        {
            "value": "13",
            "text": "Heavy Passenger Vehicle - Bus - Double Decker"
        },
        {
            "value": "12",
            "text": "Heavy Passenger Vehicle - Bus - Single Decker"
        },
        {
            "value": "28",
            "text": "Heavy Vehicle"
        },
        {
            "value": "14",
            "text": "Heavy Vehicle - Articulated"
        },
        {
            "value": "15",
            "text": "Heavy Vehicle - Non-Articulated"
        },
        {
            "value": "16",
            "text": "Heavy Vehicle - Refrigerated Transport"
        },
        {
            "value": "22",
            "text": "Light Delivery Vehicle"
        },
        {
            "value": "10",
            "text": "Light Passenger Vehicle - Minibus"
        },
        {
            "value": "17",
            "text": "Light Vehicle"
        },
        {
            "value": "25",
            "text": "Medium Commercial Vehicle"
        },
        {
            "value": "27",
            "text": "Mobile Phone"
        },
        {
            "value": "5",
            "text": "Mobile Plant Equipment"
        },
        {
            "value": "1",
            "text": "Motorcycle"
        },
        {
            "value": "26",
            "text": "Non-Powered Asset"
        },
        {
            "value": "24",
            "text": "Off-Road Vehicle"
        },
        {
            "value": "20",
            "text": "Other"
        },
        {
            "value": "9",
            "text": "Passenger Vehicle"
        },
        {
            "value": "6",
            "text": "Stationary Plant Equipment"
        },
        {
            "value": "2",
            "text": "Trailer"
        },
        {
            "value": "21",
            "text": "Train"
        }
    ],
    "sites": [
        {
            "value": "8850589907655221562",
            "text": "Default Site"
        }
    ],
    "configGroups": [
        {
            "value": "-3859349747606875553",
            "text": "Default configuration group for CalAmp Premium"
        }
    ],
    "countries": [
        {
            "value": "AF",
            "text": "Afghanistan"
        },
        {
            "value": "AX",
            "text": "Åland Islands"
        },
        {
            "value": "AL",
            "text": "Albania"
        },
        {
            "value": "DZ",
            "text": "Algeria"
        },
        {
            "value": "AS",
            "text": "American Samoa"
        },
        {
            "value": "AD",
            "text": "Andorra"
        },
        {
            "value": "AO",
            "text": "Angola"
        },
        {
            "value": "AI",
            "text": "Anguilla"
        },
        {
            "value": "AQ",
            "text": "Antarctica"
        },
        {
            "value": "AG",
            "text": "Antigua and Barbuda"
        },
        {
            "value": "AR",
            "text": "Argentina"
        },
        {
            "value": "AM",
            "text": "Armenia"
        },
        {
            "value": "AW",
            "text": "Aruba"
        },
        {
            "value": "AU",
            "text": "Australia"
        },
        {
            "value": "AT",
            "text": "Austria"
        },
        {
            "value": "AZ",
            "text": "Azerbaijan"
        },
        {
            "value": "BS",
            "text": "Bahamas (the)"
        },
        {
            "value": "BH",
            "text": "Bahrain"
        },
        {
            "value": "BD",
            "text": "Bangladesh"
        },
        {
            "value": "BB",
            "text": "Barbados"
        },
        {
            "value": "BY",
            "text": "Belarus"
        },
        {
            "value": "BE",
            "text": "Belgium"
        },
        {
            "value": "BZ",
            "text": "Belize"
        },
        {
            "value": "BJ",
            "text": "Benin"
        },
        {
            "value": "BM",
            "text": "Bermuda"
        },
        {
            "value": "BT",
            "text": "Bhutan"
        },
        {
            "value": "BO",
            "text": "Bolivia, Plurinational State of"
        },
        {
            "value": "BQ",
            "text": "Bonaire, Sint Eustatius and Saba"
        },
        {
            "value": "BA",
            "text": "Bosnia and Herzegovina"
        },
        {
            "value": "BW",
            "text": "Botswana"
        },
        {
            "value": "BV",
            "text": "Bouvet Island"
        },
        {
            "value": "BR",
            "text": "Brazil"
        },
        {
            "value": "IO",
            "text": "British Indian Ocean Territory (the)"
        },
        {
            "value": "BN",
            "text": "Brunei Darussalam"
        },
        {
            "value": "BG",
            "text": "Bulgaria"
        },
        {
            "value": "BF",
            "text": "Burkina Faso"
        },
        {
            "value": "BI",
            "text": "Burundi"
        },
        {
            "value": "CV",
            "text": "Cabo Verde"
        },
        {
            "value": "KH",
            "text": "Cambodia"
        },
        {
            "value": "CM",
            "text": "Cameroon"
        },
        {
            "value": "CA",
            "text": "Canada"
        },
        {
            "value": "KY",
            "text": "Cayman Islands (the)"
        },
        {
            "value": "CF",
            "text": "Central African Republic (the)"
        },
        {
            "value": "TD",
            "text": "Chad"
        },
        {
            "value": "CL",
            "text": "Chile"
        },
        {
            "value": "CN",
            "text": "China"
        },
        {
            "value": "CX",
            "text": "Christmas Island"
        },
        {
            "value": "CC",
            "text": "Cocos (Keeling) Islands (the)"
        },
        {
            "value": "CO",
            "text": "Colombia"
        },
        {
            "value": "KM",
            "text": "Comoros"
        },
        {
            "value": "CG",
            "text": "Congo"
        },
        {
            "value": "CD",
            "text": "Congo (the Democratic Republic of the)"
        },
        {
            "value": "CK",
            "text": "Cook Islands (the)"
        },
        {
            "value": "CR",
            "text": "Costa Rica"
        },
        {
            "value": "CI",
            "text": "Côte d'Ivoire"
        },
        {
            "value": "HR",
            "text": "Croatia"
        },
        {
            "value": "CU",
            "text": "Cuba"
        },
        {
            "value": "CW",
            "text": "Curaçao"
        },
        {
            "value": "CY",
            "text": "Cyprus"
        },
        {
            "value": "CZ",
            "text": "Czech Republic (the)"
        },
        {
            "value": "DK",
            "text": "Denmark"
        },
        {
            "value": "DJ",
            "text": "Djibouti"
        },
        {
            "value": "DM",
            "text": "Dominica"
        },
        {
            "value": "DO",
            "text": "Dominican Republic (the)"
        },
        {
            "value": "EC",
            "text": "Ecuador"
        },
        {
            "value": "EG",
            "text": "Egypt"
        },
        {
            "value": "SV",
            "text": "El Salvador"
        },
        {
            "value": "GQ",
            "text": "Equatorial Guinea"
        },
        {
            "value": "ER",
            "text": "Eritrea"
        },
        {
            "value": "EE",
            "text": "Estonia"
        },
        {
            "value": "ET",
            "text": "Ethiopia"
        },
        {
            "value": "FK",
            "text": "Falkland Islands (the) [Malvinas]"
        },
        {
            "value": "FO",
            "text": "Faroe Islands (the)"
        },
        {
            "value": "FJ",
            "text": "Fiji"
        },
        {
            "value": "FI",
            "text": "Finland"
        },
        {
            "value": "FR",
            "text": "France"
        },
        {
            "value": "GF",
            "text": "French Guiana"
        },
        {
            "value": "PF",
            "text": "French Polynesia"
        },
        {
            "value": "TF",
            "text": "French Southern Territories (the)"
        },
        {
            "value": "GA",
            "text": "Gabon"
        },
        {
            "value": "GM",
            "text": "Gambia (The)"
        },
        {
            "value": "GE",
            "text": "Georgia"
        },
        {
            "value": "DE",
            "text": "Germany"
        },
        {
            "value": "GH",
            "text": "Ghana"
        },
        {
            "value": "GI",
            "text": "Gibraltar"
        },
        {
            "value": "GR",
            "text": "Greece"
        },
        {
            "value": "GL",
            "text": "Greenland"
        },
        {
            "value": "GD",
            "text": "Grenada"
        },
        {
            "value": "GP",
            "text": "Guadeloupe"
        },
        {
            "value": "GU",
            "text": "Guam"
        },
        {
            "value": "GT",
            "text": "Guatemala"
        },
        {
            "value": "GG",
            "text": "Guernsey"
        },
        {
            "value": "GN",
            "text": "Guinea"
        },
        {
            "value": "GW",
            "text": "Guinea-Bissau"
        },
        {
            "value": "GY",
            "text": "Guyana"
        },
        {
            "value": "HT",
            "text": "Haiti"
        },
        {
            "value": "HM",
            "text": "Heard Island and McDonald Islands"
        },
        {
            "value": "VA",
            "text": "Holy See (the) [Vatican City State]"
        },
        {
            "value": "HN",
            "text": "Honduras"
        },
        {
            "value": "HK",
            "text": "Hong Kong"
        },
        {
            "value": "HU",
            "text": "Hungary"
        },
        {
            "value": "IS",
            "text": "Iceland"
        },
        {
            "value": "IN",
            "text": "India"
        },
        {
            "value": "ID",
            "text": "Indonesia"
        },
        {
            "value": "IR",
            "text": "Iran (the Islamic Republic of)"
        },
        {
            "value": "IQ",
            "text": "Iraq"
        },
        {
            "value": "IE",
            "text": "Ireland"
        },
        {
            "value": "IM",
            "text": "Isle of Man"
        },
        {
            "value": "IL",
            "text": "Israel"
        },
        {
            "value": "IT",
            "text": "Italy"
        },
        {
            "value": "JM",
            "text": "Jamaica"
        },
        {
            "value": "JP",
            "text": "Japan"
        },
        {
            "value": "JE",
            "text": "Jersey"
        },
        {
            "value": "JO",
            "text": "Jordan"
        },
        {
            "value": "KZ",
            "text": "Kazakhstan"
        },
        {
            "value": "KE",
            "text": "Kenya"
        },
        {
            "value": "KI",
            "text": "Kiribati"
        },
        {
            "value": "KP",
            "text": "Korea (the Democratic People's Republic of)"
        },
        {
            "value": "KR",
            "text": "Korea (the Republic of)"
        },
        {
            "value": "KW",
            "text": "Kuwait"
        },
        {
            "value": "KG",
            "text": "Kyrgyzstan"
        },
        {
            "value": "LA",
            "text": "Lao People's Democratic Republic (the)"
        },
        {
            "value": "LV",
            "text": "Latvia"
        },
        {
            "value": "LB",
            "text": "Lebanon"
        },
        {
            "value": "LS",
            "text": "Lesotho"
        },
        {
            "value": "LR",
            "text": "Liberia"
        },
        {
            "value": "LY",
            "text": "Libya"
        },
        {
            "value": "LI",
            "text": "Liechtenstein"
        },
        {
            "value": "LT",
            "text": "Lithuania"
        },
        {
            "value": "LU",
            "text": "Luxembourg"
        },
        {
            "value": "MO",
            "text": "Macao"
        },
        {
            "value": "MK",
            "text": "Macedonia (the former Yugoslav Republic of)"
        },
        {
            "value": "MG",
            "text": "Madagascar"
        },
        {
            "value": "MW",
            "text": "Malawi"
        },
        {
            "value": "MY",
            "text": "Malaysia"
        },
        {
            "value": "MV",
            "text": "Maldives"
        },
        {
            "value": "ML",
            "text": "Mali"
        },
        {
            "value": "MT",
            "text": "Malta"
        },
        {
            "value": "MH",
            "text": "Marshall Islands (the)"
        },
        {
            "value": "MQ",
            "text": "Martinique"
        },
        {
            "value": "MR",
            "text": "Mauritania"
        },
        {
            "value": "MU",
            "text": "Mauritius"
        },
        {
            "value": "YT",
            "text": "Mayotte"
        },
        {
            "value": "MX",
            "text": "Mexico"
        },
        {
            "value": "FM",
            "text": "Micronesia (the Federated States of)"
        },
        {
            "value": "MD",
            "text": "Moldova (the Republic of)"
        },
        {
            "value": "MC",
            "text": "Monaco"
        },
        {
            "value": "MN",
            "text": "Mongolia"
        },
        {
            "value": "ME",
            "text": "Montenegro"
        },
        {
            "value": "MS",
            "text": "Montserrat"
        },
        {
            "value": "MA",
            "text": "Morocco"
        },
        {
            "value": "MZ",
            "text": "Mozambique"
        },
        {
            "value": "MM",
            "text": "Myanmar"
        },
        {
            "value": "NA",
            "text": "Namibia"
        },
        {
            "value": "NR",
            "text": "Nauru"
        },
        {
            "value": "NP",
            "text": "Nepal"
        },
        {
            "value": "NL",
            "text": "Netherlands (the)"
        },
        {
            "value": "NC",
            "text": "New Caledonia"
        },
        {
            "value": "NZ",
            "text": "New Zealand"
        },
        {
            "value": "NI",
            "text": "Nicaragua"
        },
        {
            "value": "NE",
            "text": "Niger (the)"
        },
        {
            "value": "NG",
            "text": "Nigeria"
        },
        {
            "value": "NU",
            "text": "Niue"
        },
        {
            "value": "NF",
            "text": "Norfolk Island"
        },
        {
            "value": "MP",
            "text": "Northern Mariana Islands (the)"
        },
        {
            "value": "NO",
            "text": "Norway"
        },
        {
            "value": "OM",
            "text": "Oman"
        },
        {
            "value": "PK",
            "text": "Pakistan"
        },
        {
            "value": "PW",
            "text": "Palau"
        },
        {
            "value": "PS",
            "text": "Palestine, State of"
        },
        {
            "value": "PA",
            "text": "Panama"
        },
        {
            "value": "PG",
            "text": "Papua New Guinea"
        },
        {
            "value": "PY",
            "text": "Paraguay"
        },
        {
            "value": "PE",
            "text": "Peru"
        },
        {
            "value": "PH",
            "text": "Philippines (the)"
        },
        {
            "value": "PN",
            "text": "Pitcairn"
        },
        {
            "value": "PL",
            "text": "Poland"
        },
        {
            "value": "PT",
            "text": "Portugal"
        },
        {
            "value": "PR",
            "text": "Puerto Rico"
        },
        {
            "value": "QA",
            "text": "Qatar"
        },
        {
            "value": "RE",
            "text": "Réunion"
        },
        {
            "value": "RO",
            "text": "Romania"
        },
        {
            "value": "RU",
            "text": "Russian Federation (the)"
        },
        {
            "value": "RW",
            "text": "Rwanda"
        },
        {
            "value": "BL",
            "text": "Saint Barthélemy"
        },
        {
            "value": "SH",
            "text": "Saint Helena, Ascension and Tristan da Cunha"
        },
        {
            "value": "KN",
            "text": "Saint Kitts and Nevis"
        },
        {
            "value": "LC",
            "text": "Saint Lucia"
        },
        {
            "value": "MF",
            "text": "Saint Martin (French part)"
        },
        {
            "value": "PM",
            "text": "Saint Pierre and Miquelon"
        },
        {
            "value": "VC",
            "text": "Saint Vincent and the Grenadines"
        },
        {
            "value": "WS",
            "text": "Samoa"
        },
        {
            "value": "SM",
            "text": "San Marino"
        },
        {
            "value": "ST",
            "text": "Sao Tome and Principe"
        },
        {
            "value": "SA",
            "text": "Saudi Arabia"
        },
        {
            "value": "SN",
            "text": "Senegal"
        },
        {
            "value": "RS",
            "text": "Serbia"
        },
        {
            "value": "SC",
            "text": "Seychelles"
        },
        {
            "value": "SL",
            "text": "Sierra Leone"
        },
        {
            "value": "SG",
            "text": "Singapore"
        },
        {
            "value": "SX",
            "text": "Sint Maarten (Dutch part)"
        },
        {
            "value": "SK",
            "text": "Slovakia"
        },
        {
            "value": "SI",
            "text": "Slovenia"
        },
        {
            "value": "SB",
            "text": "Solomon Islands (the)"
        },
        {
            "value": "SO",
            "text": "Somalia"
        },
        {
            "value": "ZA",
            "text": "South Africa"
        },
        {
            "value": "GS",
            "text": "South Georgia and the South Sandwich Islands"
        },
        {
            "value": "SS",
            "text": "South Sudan"
        },
        {
            "value": "ES",
            "text": "Spain"
        },
        {
            "value": "LK",
            "text": "Sri Lanka"
        },
        {
            "value": "SD",
            "text": "Sudan (the)"
        },
        {
            "value": "SR",
            "text": "Suriname"
        },
        {
            "value": "SJ",
            "text": "Svalbard and Jan Mayen"
        },
        {
            "value": "SZ",
            "text": "Swaziland"
        },
        {
            "value": "SE",
            "text": "Sweden"
        },
        {
            "value": "CH",
            "text": "Switzerland"
        },
        {
            "value": "SY",
            "text": "Syrian Arab Republic (the)"
        },
        {
            "value": "TW",
            "text": "Taiwan (Province of China)"
        },
        {
            "value": "TJ",
            "text": "Tajikistan"
        },
        {
            "value": "TZ",
            "text": "Tanzania, United Republic of"
        },
        {
            "value": "TH",
            "text": "Thailand"
        },
        {
            "value": "TL",
            "text": "Timor-Leste"
        },
        {
            "value": "TG",
            "text": "Togo"
        },
        {
            "value": "TK",
            "text": "Tokelau"
        },
        {
            "value": "TO",
            "text": "Tonga"
        },
        {
            "value": "TT",
            "text": "Trinidad and Tobago"
        },
        {
            "value": "TN",
            "text": "Tunisia"
        },
        {
            "value": "TR",
            "text": "Turkey"
        },
        {
            "value": "TM",
            "text": "Turkmenistan"
        },
        {
            "value": "TC",
            "text": "Turks and Caicos Islands (the)"
        },
        {
            "value": "TV",
            "text": "Tuvalu"
        },
        {
            "value": "UG",
            "text": "Uganda"
        },
        {
            "value": "UA",
            "text": "Ukraine"
        },
        {
            "value": "AE",
            "text": "United Arab Emirates (the)"
        },
        {
            "value": "GB",
            "text": "United Kingdom (the)"
        },
        {
            "value": "US",
            "text": "United States (the)"
        },
        {
            "value": "UM",
            "text": "United States Minor Outlying Islands (the)"
        },
        {
            "value": "UY",
            "text": "Uruguay"
        },
        {
            "value": "UZ",
            "text": "Uzbekistan"
        },
        {
            "value": "VU",
            "text": "Vanuatu"
        },
        {
            "value": "VE",
            "text": "Venezuela, Bolivarian Republic of"
        },
        {
            "value": "VN",
            "text": "Viet Nam"
        },
        {
            "value": "VG",
            "text": "Virgin Islands (British)"
        },
        {
            "value": "VI",
            "text": "Virgin Islands (U.S.)"
        },
        {
            "value": "WF",
            "text": "Wallis and Futuna"
        },
        {
            "value": "EH",
            "text": "Western Sahara"
        },
        {
            "value": "YE",
            "text": "Yemen"
        },
        {
            "value": "ZM",
            "text": "Zambia"
        },
        {
            "value": "ZW",
            "text": "Zimbabwe"
        }
    ],
    "fuelTypes": [
        {
            "id": "Bi-fuel using diesel",
            "description": "Bi-fuel using diesel"
        },
        {
            "id": "Bi-fuel vehicle using battery",
            "description": "Bi-fuel vehicle using battery"
        },
        {
            "id": "Bi-fuel vehicle using battery and combustion engine",
            "description": "Bi-fuel vehicle using battery and combustion engine"
        },
        {
            "id": "Bi-fuel vehicle using CNG",
            "description": "Bi-fuel vehicle using CNG"
        },
        {
            "id": "Bi-fuel vehicle using ethanol",
            "description": "Bi-fuel vehicle using ethanol"
        },
        {
            "id": "Bi-fuel vehicle using LPG",
            "description": "Bi-fuel vehicle using LPG"
        },
        {
            "id": "Bi-fuel vehicle using methanol",
            "description": "Bi-fuel vehicle using methanol"
        },
        {
            "id": "Bi-fuel vehicle using natural gas",
            "description": "Bi-fuel vehicle using natural gas"
        },
        {
            "id": "Bi-fuel vehicle using petrol",
            "description": "Bi-fuel vehicle using petrol"
        },
        {
            "id": "Bi-fuel vehicle using propane",
            "description": "Bi-fuel vehicle using propane"
        },
        {
            "id": "Compressed Natural Gas",
            "description": "Compressed Natural Gas"
        },
        {
            "id": "Diesel",
            "description": "Diesel"
        },
        {
            "id": "Dual fuel - diesel and compressed natural gas",
            "description": "Dual fuel - diesel and compressed natural gas"
        },
        {
            "id": "Dual fuel - diesel and liquid natural gas",
            "description": "Dual fuel - diesel and liquid natural gas"
        },
        {
            "id": "Electric",
            "description": "Electric"
        },
        {
            "id": "Ethanol",
            "description": "Ethanol"
        },
        {
            "id": "Hybrid vehicle in regeneration mode",
            "description": "Hybrid vehicle in regeneration mode"
        },
        {
            "id": "Hybrid vehicle using battery",
            "description": "Hybrid vehicle using battery"
        },
        {
            "id": "Hybrid vehicle using battery and combustion engine",
            "description": "Hybrid vehicle using battery and combustion engine"
        },
        {
            "id": "Hybrid vehicle using diesel engine",
            "description": "Hybrid vehicle using diesel engine"
        },
        {
            "id": "Hybrid vehicle using gasoline engine",
            "description": "Hybrid vehicle using gasoline engine"
        },
        {
            "id": "Hybrid vehicle using gasoline engine on ethanol",
            "description": "Hybrid vehicle using gasoline engine on ethanol"
        },
        {
            "id": "Liquified Petroleum Gas",
            "description": "Liquified Petroleum Gas"
        },
        {
            "id": "Methanol",
            "description": "Methanol"
        },
        {
            "id": "Natural gas",
            "description": "Natural gas"
        },
        {
            "id": "Natural gas (compressed or liquefied natural gas)",
            "description": "Natural gas (compressed or liquefied natural gas)"
        },
        {
            "id": "Petrol",
            "description": "Petrol"
        },
        {
            "id": "Propane",
            "description": "Propane"
        },
        {
            "id": "Not available",
            "description": "Not available"
        },
        {
            "id": "Other",
            "description": "Other"
        }
    ],
    "icons": [
        "van-right",
        "truck-right",
        "trailer-right",
        "trailer2-right",
        "tipper-right",
        "tanker-right",
        "plough-right",
        "crane2-right",
        "crane-right",
        "ems-right",
        "generator2-right",
        "generator-right",
        "forklift-right",
        "key-right",
        "motorcycle-right",
        "car-right",
        "car5-right",
        "car4-right",
        "car3-right",
        "car2-right",
        "bus-right",
        "boat-right",
        "batmobile2-right",
        "batmobile-right",
        "phone",
        "person",
        "ldv-right",
        "train-right",
        "container",
        "ewp-right",
        "chipper-right",
        "truck-logging-right",
        "saw-blade1",
        "saw-blade2",
        "crane-logging"
    ],
    "iconColours": [
        "black",
        "blue",
        "green",
        "teal",
        "deepSkyBlue",
        "aqua",
        "forestGreen",
        "limeGreen",
        "indigo",
        "dimGray",
        "maroon",
        "purple",
        "lightGreen",
        "lightBlue",
        "fireBrick",
        "indianRed",
        "orchid",
        "crimson",
        "lightCoral",
        "red",
        "deepPink",
        "darkOrange",
        "lightPink",
        "yellow"
    ],
    "makesAndModels": [
        "A Trinity Trailer",
        "Abarth",
        "AC",
        "ADL",
        "Adly",
        "Advanced Power",
        "Advantec",
        "Aebi Schmidt",
        "Afrit",
        "Agco Allis (agrotec)",
        "Agrale",
        "Agria",
        "Agria-deutz",
        "Agrico",
        "Air Stream",
        "Alcom LLC",
        "Alfa Romeo",
        "Alimak",
        "Allight",
        "Allmand",
        "Alum-Line",
        "AMC",
        "Amco Vebo",
        "American Crawler",
        "American Trailers",
        "Anglo International",
        "Appalachian Trailers",
        "Aprilia",
        "Arctic Cat",
        "Arising Industries",
        "Arora",
        "Ashok Leyland",
        "Asia Wing",
        "Aston Martin",
        "ASTRA",
        "ATE",
        "Atlas Copco",
        "ATLAS",
        "Atoka Trailer & Mfg.",
        "Atul Auto",
        "Audi",
        "Autocar",
        "B.A.W",
        "Backdraft Racing",
        "Baic",
        "Bajaj",
        "Baoli forklift",
        "Barford",
        "BARKER",
        "Bartlett",
        "BCI",
        "Beiben",
        "Beiqi Foton",
        "Bell Equipment",
        "Belmont Machine",
        "Belshe Industries",
        "Bennche",
        "Bennelli",
        "Bentley",
        "Bestar China",
        "Beta Racing",
        "Big Bubba's Trailer",
        "Big Tex Trailer",
        "Bimota",
        "Bitelli",
        "Blackstone Trailer ",
        "Blackwood hodge",
        "Blue Bird",
        "Blue Diamond",
        "BMC",
        "BMW",
        "Bobcat",
        "Bomag",
        "Bombardiercanam",
        "Bonluck",
        "Bravo Trailers",
        "Brazos",
        "Brindle Products",
        "Brooks Brothers",
        "BRUCE ROCK END",
        "Buick",
        "Busaf",
        "Buyang",
        "BYD",
        "Cadillac",
        "Cagiva",
        "Can-am",
        "Capacity",
        "Cargo Craft",
        "Carry-On Trailer",
        "Case International",
        "Caterpillar",
        "CBH",
        "Centralia Machine",
        "Century Built",
        "CF Moto",
        "Chana - Changan",
        "Changjiang",
        "Chengliwei",
        "Chery",
        "Chevrolet",
        "Choice Trailers",
        "Chrysler",
        "CIMC",
        "Citroen",
        "Claas",
        "CM",
        "Cnhtc",
        "Coachcraft Technologies",
        "Coachmen",
        "Colt",
        "Combilift",
        "CompAir",
        "Conel",
        "Cooper",
        "Covered Wagon Trailers",
        "Crane Carrier",
        "Crown",
        "CRRC",
        "Cummins",
        "Currahee Trailers",
        "D & P Welding and AUTO",
        "D A F",
        "Dacia",
        "Daewoo",
        "DAF",
        "Daihatsu",
        "Daimler",
        "Dakota Manufacturing",
        "Datsun",
        "Demag",
        "Denning",
        "Derbi",
        "Deutz Fahr",
        "Deutz",
        "DFSK",
        "Diamond C Trailer",
        "Dingli",
        "Dinli",
        "Display Solutions",
        "Ditch Witch",
        "Dodge",
        "Dongben",
        "Dongfeng Yangtse",
        "Doosan",
        "DORIC ENGINEERING",
        "Ducati",
        "Dunlite",
        "Dyna",
        "Dynapac",
        "Eager Beaver",
        "Eagle",
        "East Texas Trailers",
        "Ebusco",
        "Echo",
        "Econoline Trailer",
        "Eicher",
        "Electric Motion",
        "Enforcer",
        "Etnyre",
        "Evans Steel",
        "Falcon Trailerworks",
        "Fantuzzi",
        "Farmtrac",
        "Faw",
        "Felling Trailers",
        "Fendt",
        "Ferrari",
        "FG Wilson",
        "Fiat",
        "Flextool",
        "Fontaine Trailers",
        "Ford",
        "Forest River",
        "Fork lift",
        "Foshan Shunde",
        "Fosti",
        "Foton",
        "Fraker Manufacturing",
        "Freedom Trailers",
        "FREIGHTER",
        "Freightliner",
        "FREIGHTQUIP",
        "FS Curtis",
        "FTE",
        "FUSO",
        "GasGas",
        "GAZ",
        "Geely",
        "Genelite",
        "Genesis",
        "Genie",
        "Ghel",
        "GM",
        "GMC",
        "Golden Dragon",
        "Gomoto",
        "Gravely",
        "Great Dane Trailers",
        "Great Northern Trailers",
        "Grove",
        "GTE",
        "Guleryuz",
        "GWM",
        "H & H Trailers",
        "Hafei",
        "Hajadu",
        "Hangcha",
        "Harley Davidson",
        "Hatz",
        "Haulmark",
        "Haval",
        "Hayvan",
        "Heil Trailers",
        "Hendrickson",
        "Henred Fruehauf",
        "Hensim",
        "Higer",
        "Hilite",
        "Hillsboro",
        "Hino",
        "Hitachi",
        "HMC",
        "Holden Industries",
        "Holden",
        "HOLMWOOD",
        "Homesteader",
        "Honda",
        "Horse Creek Manufacturing",
        "Hudson Brothers",
        "Hummer",
        "Husaberg",
        "Husqvarna",
        "Hustler",
        "Hydrovane",
        "Hyosung",
        "Hyster",
        "Hyundai",
        "Ibhubezi",
        "IC BUS",
        "Indian",
        "Indotrac",
        "Infiniti",
        "Ingersoll Rand",
        "Innovative Trailer",
        "InTech Trailers",
        "International",
        "Interstate",
        "Irisbus",
        "Irizar",
        "Isuzu",
        "Iveco",
        "J & L's Cargo express",
        "JAC",
        "Jaguar",
        "Jawa",
        "JCB",
        "Jeep",
        "Jet Company",
        "Jialing",
        "Jianshe",
        "Jimmy's Custom Built Trailers",
        "Jinma",
        "Jlg",
        "John deere",
        "Jonway",
        "JRW Trailers",
        "Jubilee",
        "Kamaz",
        "Karavan Trailer",
        "Karcher",
        "KARSAN",
        "Kaufman Trailers",
        "Kawasaki",
        "Kenworth",
        "Keogh",
        "Kerr-bilt",
        "Kia",
        "King Long",
        "Kinroad Xintian",
        "Kioti",
        "Kobelco",
        "Kohler",
        "Komatsu",
        "Konecranes",
        "Kotzur",
        "KRAZ",
        "KRUEGER",
        "KTM",
        "KTMMEX",
        "Kubota",
        "Kwik Kleen",
        "KYMCO",
        "La Padona",
        "Lada",
        "Lamar Trailers",
        "Lamborghini",
        "Lambretta",
        "Lancia",
        "Land rover",
        "Landini",
        "Lark United Manufacturing",
        "Larson Cable Trailers",
        "Laverda",
        "LDV",
        "Leeboy",
        "Lemco Tool",
        "Lexus",
        "LGS Industries",
        "LiAZ",
        "Liebherr",
        "Lifan",
        "Lincoln",
        "Linde",
        "Link-Belt",
        "Lister Petter",
        "Liugong",
        "Load Trail",
        "Lobstar",
        "Lone Star Oryogenics",
        "Lotus",
        "Loudo Trailers",
        "Luba",
        "Luigong",
        "M.D. Products",
        "MACK",
        "MAGIRUS",
        "Mahindra",
        "MAN",
        "Manitou",
        "MARSHALL LETHLEAN",
        "MarutiSuzuki",
        "Maserati",
        "Massey ferguson",
        "Master Tow",
        "Maxey Trailers",
        "MAXICUBE",
        "MaxiTRANS",
        "MAZ",
        "Mazda",
        "Mccormick",
        "McFarland",
        "Mclaren",
        "Mclaughlin",
        "MCT",
        "Mercedes Benz",
        "Merlo",
        "Merritt Equipment",
        "Mertz Manufacturing",
        "METRO",
        "MG",
        "MICK MURRAY WELDING",
        "Miller",
        "Mini",
        "Mitsubishi",
        "Mobi",
        "Mobile Tech Trailers",
        "Monon",
        "Monroe Towmaster",
        "Montracon",
        "Moto guzzi",
        "Motomia",
        "Motor Coach Industries",
        "Munsch",
        "MV Agusta",
        "National Motors",
        "NAVISTAR",
        "NefAZ",
        "Neoplan",
        "New Holland",
        "Nissan",
        "North Alabama Trailer",
        "Opel",
        "Operbus",
        "OPHEE",
        "Optare",
        "Orteq Energy Services",
        "Oshkosh",
        "Other",
        "Pace American",
        "Paiute Trailers",
        "Palfinger",
        "Parkwood",
        "PAZ",
        "Pegson",
        "PEKI",
        "Penske",
        "Peterbilt",
        "Peugeot",
        "PFI",
        "Piaggio",
        "Pierce Manufacturing",
        "PJ",
        "PLAN",
        "Polaris",
        "Polarsun",
        "Ponderosa Trailers",
        "Pontiac",
        "Porsche",
        "Powerscreen",
        "Powerstar",
        "PR Power",
        "Pratt Industries",
        "Prevost",
        "Priefert",
        "PTES",
        "Putzmeister",
        "R and I Holding",
        "Ram",
        "RAVO",
        "RC Trailers",
        "Redi-Haul",
        "Renault",
        "Rice Trailers",
        "Rig Works",
        "Ring-O-Matic Manufacturing",
        "ROADWEST",
        "Rokbak",
        "Rolls Rite Trailers",
        "Rolls Royce",
        "Rover",
        "Royal Enfield",
        "RTS",
        "SA Truck Bodies",
        "Saab",
        "Salvation Trailers",
        "Samil",
        "Sandvik",
        "Sany",
        "Saturn",
        "Scania",
        "Scanmaskin",
        "SCE",
        "SCHMITZ CARGO BULL",
        "Schmitz Cargobull",
        "Schwarzmüller",
        "Scion",
        "SDC Trailers",
        "Seat",
        "Secma",
        "Sennenbogen",
        "Serco",
        "Service King",
        "Setra",
        "Shacman",
        "Shanghai meitian motorcycle ",
        "Shaolin",
        "Shatui",
        "SHEPHARD",
        "Sherco",
        "Shermac",
        "Sherman + Reilly",
        "SIMAZ",
        "Sinotruk",
        "SISU",
        "Skoda",
        "Skyline",
        "Slingshot",
        "SMP",
        "Solaris",
        "Solartech",
        "Sonalika",
        "Soosan",
        "SOUTHERN CROSS",
        "Southern Heritage Trailers",
        "Soyat",
        "Ssangyong",
        "STEELBRO",
        "Sterling",
        "Still",
        "Storm",
        "Stoughton trailers",
        "Strick Trailer",
        "Subaru",
        "Sundowner",
        "Sunlong",
        "Super Products DURASUCKER",
        "Sure-Trac Trailers",
        "Suzhou Eagle",
        "Suzuki",
        "Sykes",
        "Sym",
        "T&J Trailers",
        "Tadano",
        "Tafe",
        "Takeuchi",
        "TAM Motors VIVAIR 104WL",
        "Tampa Trailerworks",
        "Tarter Industries",
        "Tata",
        "Tatra",
        "Temsa",
        "Terberg",
        "Terex",
        "Texas Bragg Enterprises",
        "Texas Pride Trailers",
        "TGB",
        "Thomas Built",
        "Thomas",
        "TIEMAN",
        "Timpte",
        "Tm racing",
        "Top Hat Industries",
        "Top trailers",
        "TORO",
        "Towmaster",
        "Toyota",
        "Trail Master",
        "Trail-Rite",
        "Tramontina",
        "Transcraft",
        "Trinity trailer",
        "Triton",
        "Triumph",
        "Trophy Boat Trailers",
        "TVS",
        "TX Bragg",
        "UAZ",
        "UD trucks",
        "United Trailers",
        "Ural",
        "Ursus",
        "Us truck",
        "Utility Trailer Manufacturer",
        "Vac-Tron Equipment",
        "Valtra (valmet)",
        "Van Hool",
        "Vanguard",
        "VAWDREY",
        "VDL",
        "Venieri",
        "Venturetech",
        "Vermeer",
        "Vespa",
        "Vic Grain",
        "Victory Trailers",
        "Volare",
        "Volkswagen",
        "Volvo",
        "Vuka",
        "Wabash",
        "Wacker Neuson",
        "Wallinga",
        "Wanco",
        "Wausau-Everest SD3131",
        "Welling & Crossley",
        "Wells Cargo",
        "Western Star",
        "Wheeler Reeler",
        "White Oliver",
        "Wilson",
        "Wirtgen",
        "Workhorse ",
        "WRIGHT",
        "WTM",
        "Wyatt's",
        "Wylie",
        "XCMG",
        "Xingyue",
        "Yale",
        "Yamaha",
        "Yamoto",
        "Yangste River",
        "Yanmar",
        "YEO TR ENGRG & TRDG",
        "YTO",
        "Yutong",
        "Zhejiang cf moto",
        "Zhejiang leike",
        "Zhejiang renli",
        "Zhejiang riya",
        "Zhongtong",
        "ZiL",
        "Zongshen",
        "Zontes",
        "Zoomlion",
        "Zotye",
        "Zx Auto"
    ],
    "assetImageUploadUrl": null,
    "organisationId": null,
    "organisationName": null,
    "canEditVin": true,
    "canEditConfigGroups": true,
    "canUpdateConfigGroupMembers": true,
    "engineHoursEnabled": false,
    "canResendCommissioningRequest": false,
    "canEditMobileNumber": false,
    "defaultIcons": {
        "1": "motorcycle-right",
        "2": "trailer2-right",
        "4": "boat-right",
        "5": "forklift-right",
        "6": "generator2-right",
        "7": "ems-right",
        "8": "tanker-right",
        "9": "car4-right",
        "10": "van-right",
        "11": "bus-right",
        "12": "bus-right",
        "13": "bus-right",
        "14": "truck-right",
        "15": "truck-right",
        "16": "truck-right",
        "17": "car-right",
        "18": "tanker-right",
        "19": "plough-right",
        "20": "truck-right",
        "21": "train-right",
        "22": "ldv-right",
        "24": "ldv-right",
        "25": "flatbed-truck-right",
        "26": "container",
        "27": "phone",
        "28": "truck-right"
    },
    "isOnJourney": false,
    "isStreamaxCommissioned": false,
    "hyperMedia": null
}
```
- Mobile Device Settings
	- GET: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944
	- form.HasBeenCommissioned = mobileUnit.ConfigurationStatus != ConfigEnums.ConfigurationStatus.NotCommissioned;
	- [x] OK, what sets this to !ConfigurationStatus.NotCommissioned ✅ 2023-09-15

```json
{
    "Form": {
        "AssetName": "Default mobile device template for CalAmp Premium",
        "HasBeenCommissioned": false,
        "DeviceTypeName": "CalAmp Premium",
        "MobileDeviceId": "878914713632096376",
        "HasDeviceTypeIdentifier": true,
        "DeviceTypeIdentifierTitle": "IMEI Number",
        "DeviceTypeIdentifierValue": null,
        "ConfigChanged": false,
        "IridiumImei": "",
        "IridiumContract": "",
        "IridiumPlanName": "",
        "IridiumError": null,
        "IridiumSatelliteCapable": false,
        "HasIridiumImei": false,
        "CanDeactivateIridiumAccount": false,
        "CommunicationCapable": false,
        "SimCardPinCode": "",
        "GprsCapable": false,
        "GprsEnabled": false,
        "GprsApnPointName": null,
        "GprsApnUsername": null,
        "GprsApnPassword": null,
        "GsmCapable": false,
        "GsmEnabled": false,
        "GsmMsisdnNumber": null,
        "SmsCapable": false,
        "SmsEnabled": false,
        "SmsMobileDeviceNumber": null,
        "SmsMessageCentreNumber": null,
        "SatelliteCapable": false,
        "SatalliteDeviceId": "",
        "UploadScheduleId": null,
        "HasUploadSchedule": false,
        "IsMesaBased": false,
        "CanEditDetails": true,
        "CanEditSmsDetails": true,
        "CanEditGsmDetails": true,
        "CanEditSimPin": true,
        "CanEditApnName": true,
        "CanEditMobileDevice": true,
        "CanRemoveMobileDevice": true,
        "CanEditSatelliteDetails": true,
        "CanEditIridiumSatelliteDetails": true,
        "CompileCapable": false,
        "CanCompileConfig": true,
        "CanUploadConfig": true,
        "CanViewCommsLog": true,
        "OrgIsMiXTalkEnabled": false,
        "MiXTalkIMEI": null,
        "MiXTalkSIMNumber": null,
        "MiXTalkCarrierID": 0,
        "MiXTalkCarriers": null,
        "CommissioningStatus": null,
        "ShowOBCResendCommissioningSMS": false,
        "Tabs": null,
        "OrgIsStreamaxEnabled": false,
        "StreamaxDeviceTypes": null,
        "StreamaxSerialNumber": null,
        "DeviceIsStreamaxEnabled": true,
        "CanEditStreamaxDetails": true,
        "IsStreamaxStandAlone": false,
        "IsStreamaxPeripheralConnected": false,...
    },
    ...
}
```
#### Add VIN and save

- UPDATE: POST: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/1085003241271469083/asset/%7BassetId%7D/update
- Regextp: asset-details/group.*\/update
- Payload
```json
{"assetId":"1439217777257938944","assetTypeId":"4","description":"MR Test Calamp 7","registrationNumber":"MRTC7","mobileNumber":null,"siteId":"8850589907655221562","fuelType":null,"targetFuelConsumption":null,"targetFuelConsumptionUnits":"mpg (US)","targetHourlyFuelConsumption":null,"targetHourlyFuelConsumptionUnits":"gal (US)/h","fuelTankCapacity":null,"fleetNumber":null,"make":"AC","model":null,"year":null,"vinNumber":"11111222221111122","vinSource":"MANUAL","engineNumber":null,"fmVehicleId":8,"additionalMobileDevice":null,"notes":null,"icon":"boat-right","iconColour":"blue","colour":null,"assetImage":"asset-boat.jpg","assetImageUrl":null,"status":null,"createdBy":"Marthinus Raath","configurationGroupId":"-3859349747606875553","createdDate":null,"country":null,"miXAccountNumber":null,"additionalDetailFields":[],"canProtocol":null,"requiredProperties":{},"volumeUnits":"gal (US)","wltp":null,"batteryCapacity":null,"usableBatteryCapacity":null,"distanceUnit":"mi"}
```
- GET: https://fleetadminapi.mixdevelopment.com/api/asset-details/group/1085003241271469083/asset/1439217777257938944/duplicate/false/get
```json
{
    "canEdit": true,
    "assetDetails": {
        "assetId": "1439217777257938944",
        "assetTypeId": "4",
        "eld": false,
        "description": "MR Test Calamp 7",
        "isConnectedTrailer": false,
        "registrationNumber": "MRTC7",
        "mobileNumber": null,
        "siteId": "8850589907655221562",
        "fuelType": null,
        "targetFuelConsumption": null,
        "targetFuelConsumptionUnits": "mpg (US)",
        "targetHourlyFuelConsumption": null,
        "targetHourlyFuelConsumptionUnits": "gal (US)/h",
        "fuelTankCapacity": null,
        "fleetNumber": null,
        "make": "AC",
        "model": null,
        "year": null,
        "vinNumber": "11111222221111122",
        "vinSource": "MANUAL",
        "isNotCanVin": false,
        "vinNumberMatched": false,
        "engineNumber": null,
        "fmVehicleId": 8,
        "additionalMobileDevice": null,
        "notes": null,
        "icon": "boat-right",
        "iconColour": "blue",
        "colour": null,
        "assetImage": "asset-boat.jpg",
        "isDefaultImage": false,
        "assetImageUrl": null,
        "status": null,
        "createdBy": "Marthinus Raath",
        "configurationGroupId": "-3859349747606875553",
        "createdDate": null,
        "country": null,
        "miXAccountNumber": null,
        "isNewAsset": false,
        "isMobilePhone": false,
        "additionalDetailFields": [],
        "isStreamaxCommissioned": false,
        "decommissionStreamaxDevice": false,
        "canProtocol": null,
        "isScaniaOem": false,
        "isOnJourney": false,
        "requiredProperties": {
            "vin": false,
            "canProtocol": false,
            "fuelType": false
        },
        "volumeUnits": "gal (US)",
        "wltp": null,
        "batteryCapacity": null,
        "usableBatteryCapacity": null,
        "distanceUnit": "mi",
        "hyperMedia": null
    },
    "isNewAsset": false,
    "assetTypes": [
        {
            "value": "4",
            "text": "Boat"
        },
        {
            "value": "8",
            "text": "Dangerous Goods Vehicle"
        },
        {
            "value": "7",
            "text": "Emergency Service Vehicle"
        },
        {
            "value": "18",
            "text": "Fluid Transport Vehicle"
        },
        {
            "value": "11",
            "text": "Heavy Passenger Vehicle - Bus - Articulated"
        },
        {
            "value": "13",
            "text": "Heavy Passenger Vehicle - Bus - Double Decker"
        },
        {
            "value": "12",
            "text": "Heavy Passenger Vehicle - Bus - Single Decker"
        },
        {
            "value": "28",
            "text": "Heavy Vehicle"
        },
        {
            "value": "14",
            "text": "Heavy Vehicle - Articulated"
        },
        {
            "value": "15",
            "text": "Heavy Vehicle - Non-Articulated"
        },
        {
            "value": "16",
            "text": "Heavy Vehicle - Refrigerated Transport"
        },
        {
            "value": "22",
            "text": "Light Delivery Vehicle"
        },
        {
            "value": "10",
            "text": "Light Passenger Vehicle - Minibus"
        },
        {
            "value": "17",
            "text": "Light Vehicle"
        },
        {
            "value": "25",
            "text": "Medium Commercial Vehicle"
        },
        {
            "value": "27",
            "text": "Mobile Phone"
        },
        {
            "value": "5",
            "text": "Mobile Plant Equipment"
        },
        {
            "value": "1",
            "text": "Motorcycle"
        },
        {
            "value": "26",
            "text": "Non-Powered Asset"
        },
        {
            "value": "24",
            "text": "Off-Road Vehicle"
        },
        {
            "value": "20",
            "text": "Other"
        },
        {
            "value": "9",
            "text": "Passenger Vehicle"
        },
        {
            "value": "6",
            "text": "Stationary Plant Equipment"
        },
        {
            "value": "2",
            "text": "Trailer"
        },
        {
            "value": "21",
            "text": "Train"
        }
    ],
    "sites": [
        {
            "value": "8850589907655221562",
            "text": "Default Site"
        }
    ],
    "configGroups": [
        {
            "value": "-3859349747606875553",
            "text": "Default configuration group for CalAmp Premium"
        }
    ],
    "countries": [
        {
            "value": "AF",
            "text": "Afghanistan"
        },
        {
            "value": "AX",
            "text": "Åland Islands"
        },
        {
            "value": "AL",
            "text": "Albania"
        },
        {
            "value": "DZ",
            "text": "Algeria"
        },
        {
            "value": "AS",
            "text": "American Samoa"
        },
        {
            "value": "AD",
            "text": "Andorra"
        },
        {
            "value": "AO",
            "text": "Angola"
        },
        {
            "value": "AI",
            "text": "Anguilla"
        },
        {
            "value": "AQ",
            "text": "Antarctica"
        },
        {
            "value": "AG",
            "text": "Antigua and Barbuda"
        },
        {
            "value": "AR",
            "text": "Argentina"
        },
        {
            "value": "AM",
            "text": "Armenia"
        },
        {
            "value": "AW",
            "text": "Aruba"
        },
        {
            "value": "AU",
            "text": "Australia"
        },
        {
            "value": "AT",
            "text": "Austria"
        },
        {
            "value": "AZ",
            "text": "Azerbaijan"
        },
        {
            "value": "BS",
            "text": "Bahamas (the)"
        },
        {
            "value": "BH",
            "text": "Bahrain"
        },
        {
            "value": "BD",
            "text": "Bangladesh"
        },
        {
            "value": "BB",
            "text": "Barbados"
        },
        {
            "value": "BY",
            "text": "Belarus"
        },
        {
            "value": "BE",
            "text": "Belgium"
        },
        {
            "value": "BZ",
            "text": "Belize"
        },
        {
            "value": "BJ",
            "text": "Benin"
        },
        {
            "value": "BM",
            "text": "Bermuda"
        },
        {
            "value": "BT",
            "text": "Bhutan"
        },
        {
            "value": "BO",
            "text": "Bolivia, Plurinational State of"
        },
        {
            "value": "BQ",
            "text": "Bonaire, Sint Eustatius and Saba"
        },
        {
            "value": "BA",
            "text": "Bosnia and Herzegovina"
        },
        {
            "value": "BW",
            "text": "Botswana"
        },
        {
            "value": "BV",
            "text": "Bouvet Island"
        },
        {
            "value": "BR",
            "text": "Brazil"
        },
        {
            "value": "IO",
            "text": "British Indian Ocean Territory (the)"
        },
        {
            "value": "BN",
            "text": "Brunei Darussalam"
        },
        {
            "value": "BG",
            "text": "Bulgaria"
        },
        {
            "value": "BF",
            "text": "Burkina Faso"
        },
        {
            "value": "BI",
            "text": "Burundi"
        },
        {
            "value": "CV",
            "text": "Cabo Verde"
        },
        {
            "value": "KH",
            "text": "Cambodia"
        },
        {
            "value": "CM",
            "text": "Cameroon"
        },
        {
            "value": "CA",
            "text": "Canada"
        },
        {
            "value": "KY",
            "text": "Cayman Islands (the)"
        },
        {
            "value": "CF",
            "text": "Central African Republic (the)"
        },
        {
            "value": "TD",
            "text": "Chad"
        },
        {
            "value": "CL",
            "text": "Chile"
        },
        {
            "value": "CN",
            "text": "China"
        },
        {
            "value": "CX",
            "text": "Christmas Island"
        },
        {
            "value": "CC",
            "text": "Cocos (Keeling) Islands (the)"
        },
        {
            "value": "CO",
            "text": "Colombia"
        },
        {
            "value": "KM",
            "text": "Comoros"
        },
        {
            "value": "CG",
            "text": "Congo"
        },
        {
            "value": "CD",
            "text": "Congo (the Democratic Republic of the)"
        },
        {
            "value": "CK",
            "text": "Cook Islands (the)"
        },
        {
            "value": "CR",
            "text": "Costa Rica"
        },
        {
            "value": "CI",
            "text": "Côte d'Ivoire"
        },
        {
            "value": "HR",
            "text": "Croatia"
        },
        {
            "value": "CU",
            "text": "Cuba"
        },
        {
            "value": "CW",
            "text": "Curaçao"
        },
        {
            "value": "CY",
            "text": "Cyprus"
        },
        {
            "value": "CZ",
            "text": "Czech Republic (the)"
        },
        {
            "value": "DK",
            "text": "Denmark"
        },
        {
            "value": "DJ",
            "text": "Djibouti"
        },
        {
            "value": "DM",
            "text": "Dominica"
        },
        {
            "value": "DO",
            "text": "Dominican Republic (the)"
        },
        {
            "value": "EC",
            "text": "Ecuador"
        },
        {
            "value": "EG",
            "text": "Egypt"
        },
        {
            "value": "SV",
            "text": "El Salvador"
        },
        {
            "value": "GQ",
            "text": "Equatorial Guinea"
        },
        {
            "value": "ER",
            "text": "Eritrea"
        },
        {
            "value": "EE",
            "text": "Estonia"
        },
        {
            "value": "ET",
            "text": "Ethiopia"
        },
        {
            "value": "FK",
            "text": "Falkland Islands (the) [Malvinas]"
        },
        {
            "value": "FO",
            "text": "Faroe Islands (the)"
        },
        {
            "value": "FJ",
            "text": "Fiji"
        },
        {
            "value": "FI",
            "text": "Finland"
        },
        {
            "value": "FR",
            "text": "France"
        },
        {
            "value": "GF",
            "text": "French Guiana"
        },
        {
            "value": "PF",
            "text": "French Polynesia"
        },
        {
            "value": "TF",
            "text": "French Southern Territories (the)"
        },
        {
            "value": "GA",
            "text": "Gabon"
        },
        {
            "value": "GM",
            "text": "Gambia (The)"
        },
        {
            "value": "GE",
            "text": "Georgia"
        },
        {
            "value": "DE",
            "text": "Germany"
        },
        {
            "value": "GH",
            "text": "Ghana"
        },
        {
            "value": "GI",
            "text": "Gibraltar"
        },
        {
            "value": "GR",
            "text": "Greece"
        },
        {
            "value": "GL",
            "text": "Greenland"
        },
        {
            "value": "GD",
            "text": "Grenada"
        },
        {
            "value": "GP",
            "text": "Guadeloupe"
        },
        {
            "value": "GU",
            "text": "Guam"
        },
        {
            "value": "GT",
            "text": "Guatemala"
        },
        {
            "value": "GG",
            "text": "Guernsey"
        },
        {
            "value": "GN",
            "text": "Guinea"
        },
        {
            "value": "GW",
            "text": "Guinea-Bissau"
        },
        {
            "value": "GY",
            "text": "Guyana"
        },
        {
            "value": "HT",
            "text": "Haiti"
        },
        {
            "value": "HM",
            "text": "Heard Island and McDonald Islands"
        },
        {
            "value": "VA",
            "text": "Holy See (the) [Vatican City State]"
        },
        {
            "value": "HN",
            "text": "Honduras"
        },
        {
            "value": "HK",
            "text": "Hong Kong"
        },
        {
            "value": "HU",
            "text": "Hungary"
        },
        {
            "value": "IS",
            "text": "Iceland"
        },
        {
            "value": "IN",
            "text": "India"
        },
        {
            "value": "ID",
            "text": "Indonesia"
        },
        {
            "value": "IR",
            "text": "Iran (the Islamic Republic of)"
        },
        {
            "value": "IQ",
            "text": "Iraq"
        },
        {
            "value": "IE",
            "text": "Ireland"
        },
        {
            "value": "IM",
            "text": "Isle of Man"
        },
        {
            "value": "IL",
            "text": "Israel"
        },
        {
            "value": "IT",
            "text": "Italy"
        },
        {
            "value": "JM",
            "text": "Jamaica"
        },
        {
            "value": "JP",
            "text": "Japan"
        },
        {
            "value": "JE",
            "text": "Jersey"
        },
        {
            "value": "JO",
            "text": "Jordan"
        },
        {
            "value": "KZ",
            "text": "Kazakhstan"
        },
        {
            "value": "KE",
            "text": "Kenya"
        },
        {
            "value": "KI",
            "text": "Kiribati"
        },
        {
            "value": "KP",
            "text": "Korea (the Democratic People's Republic of)"
        },
        {
            "value": "KR",
            "text": "Korea (the Republic of)"
        },
        {
            "value": "KW",
            "text": "Kuwait"
        },
        {
            "value": "KG",
            "text": "Kyrgyzstan"
        },
        {
            "value": "LA",
            "text": "Lao People's Democratic Republic (the)"
        },
        {
            "value": "LV",
            "text": "Latvia"
        },
        {
            "value": "LB",
            "text": "Lebanon"
        },
        {
            "value": "LS",
            "text": "Lesotho"
        },
        {
            "value": "LR",
            "text": "Liberia"
        },
        {
            "value": "LY",
            "text": "Libya"
        },
        {
            "value": "LI",
            "text": "Liechtenstein"
        },
        {
            "value": "LT",
            "text": "Lithuania"
        },
        {
            "value": "LU",
            "text": "Luxembourg"
        },
        {
            "value": "MO",
            "text": "Macao"
        },
        {
            "value": "MK",
            "text": "Macedonia (the former Yugoslav Republic of)"
        },
        {
            "value": "MG",
            "text": "Madagascar"
        },
        {
            "value": "MW",
            "text": "Malawi"
        },
        {
            "value": "MY",
            "text": "Malaysia"
        },
        {
            "value": "MV",
            "text": "Maldives"
        },
        {
            "value": "ML",
            "text": "Mali"
        },
        {
            "value": "MT",
            "text": "Malta"
        },
        {
            "value": "MH",
            "text": "Marshall Islands (the)"
        },
        {
            "value": "MQ",
            "text": "Martinique"
        },
        {
            "value": "MR",
            "text": "Mauritania"
        },
        {
            "value": "MU",
            "text": "Mauritius"
        },
        {
            "value": "YT",
            "text": "Mayotte"
        },
        {
            "value": "MX",
            "text": "Mexico"
        },
        {
            "value": "FM",
            "text": "Micronesia (the Federated States of)"
        },
        {
            "value": "MD",
            "text": "Moldova (the Republic of)"
        },
        {
            "value": "MC",
            "text": "Monaco"
        },
        {
            "value": "MN",
            "text": "Mongolia"
        },
        {
            "value": "ME",
            "text": "Montenegro"
        },
        {
            "value": "MS",
            "text": "Montserrat"
        },
        {
            "value": "MA",
            "text": "Morocco"
        },
        {
            "value": "MZ",
            "text": "Mozambique"
        },
        {
            "value": "MM",
            "text": "Myanmar"
        },
        {
            "value": "NA",
            "text": "Namibia"
        },
        {
            "value": "NR",
            "text": "Nauru"
        },
        {
            "value": "NP",
            "text": "Nepal"
        },
        {
            "value": "NL",
            "text": "Netherlands (the)"
        },
        {
            "value": "NC",
            "text": "New Caledonia"
        },
        {
            "value": "NZ",
            "text": "New Zealand"
        },
        {
            "value": "NI",
            "text": "Nicaragua"
        },
        {
            "value": "NE",
            "text": "Niger (the)"
        },
        {
            "value": "NG",
            "text": "Nigeria"
        },
        {
            "value": "NU",
            "text": "Niue"
        },
        {
            "value": "NF",
            "text": "Norfolk Island"
        },
        {
            "value": "MP",
            "text": "Northern Mariana Islands (the)"
        },
        {
            "value": "NO",
            "text": "Norway"
        },
        {
            "value": "OM",
            "text": "Oman"
        },
        {
            "value": "PK",
            "text": "Pakistan"
        },
        {
            "value": "PW",
            "text": "Palau"
        },
        {
            "value": "PS",
            "text": "Palestine, State of"
        },
        {
            "value": "PA",
            "text": "Panama"
        },
        {
            "value": "PG",
            "text": "Papua New Guinea"
        },
        {
            "value": "PY",
            "text": "Paraguay"
        },
        {
            "value": "PE",
            "text": "Peru"
        },
        {
            "value": "PH",
            "text": "Philippines (the)"
        },
        {
            "value": "PN",
            "text": "Pitcairn"
        },
        {
            "value": "PL",
            "text": "Poland"
        },
        {
            "value": "PT",
            "text": "Portugal"
        },
        {
            "value": "PR",
            "text": "Puerto Rico"
        },
        {
            "value": "QA",
            "text": "Qatar"
        },
        {
            "value": "RE",
            "text": "Réunion"
        },
        {
            "value": "RO",
            "text": "Romania"
        },
        {
            "value": "RU",
            "text": "Russian Federation (the)"
        },
        {
            "value": "RW",
            "text": "Rwanda"
        },
        {
            "value": "BL",
            "text": "Saint Barthélemy"
        },
        {
            "value": "SH",
            "text": "Saint Helena, Ascension and Tristan da Cunha"
        },
        {
            "value": "KN",
            "text": "Saint Kitts and Nevis"
        },
        {
            "value": "LC",
            "text": "Saint Lucia"
        },
        {
            "value": "MF",
            "text": "Saint Martin (French part)"
        },
        {
            "value": "PM",
            "text": "Saint Pierre and Miquelon"
        },
        {
            "value": "VC",
            "text": "Saint Vincent and the Grenadines"
        },
        {
            "value": "WS",
            "text": "Samoa"
        },
        {
            "value": "SM",
            "text": "San Marino"
        },
        {
            "value": "ST",
            "text": "Sao Tome and Principe"
        },
        {
            "value": "SA",
            "text": "Saudi Arabia"
        },
        {
            "value": "SN",
            "text": "Senegal"
        },
        {
            "value": "RS",
            "text": "Serbia"
        },
        {
            "value": "SC",
            "text": "Seychelles"
        },
        {
            "value": "SL",
            "text": "Sierra Leone"
        },
        {
            "value": "SG",
            "text": "Singapore"
        },
        {
            "value": "SX",
            "text": "Sint Maarten (Dutch part)"
        },
        {
            "value": "SK",
            "text": "Slovakia"
        },
        {
            "value": "SI",
            "text": "Slovenia"
        },
        {
            "value": "SB",
            "text": "Solomon Islands (the)"
        },
        {
            "value": "SO",
            "text": "Somalia"
        },
        {
            "value": "ZA",
            "text": "South Africa"
        },
        {
            "value": "GS",
            "text": "South Georgia and the South Sandwich Islands"
        },
        {
            "value": "SS",
            "text": "South Sudan"
        },
        {
            "value": "ES",
            "text": "Spain"
        },
        {
            "value": "LK",
            "text": "Sri Lanka"
        },
        {
            "value": "SD",
            "text": "Sudan (the)"
        },
        {
            "value": "SR",
            "text": "Suriname"
        },
        {
            "value": "SJ",
            "text": "Svalbard and Jan Mayen"
        },
        {
            "value": "SZ",
            "text": "Swaziland"
        },
        {
            "value": "SE",
            "text": "Sweden"
        },
        {
            "value": "CH",
            "text": "Switzerland"
        },
        {
            "value": "SY",
            "text": "Syrian Arab Republic (the)"
        },
        {
            "value": "TW",
            "text": "Taiwan (Province of China)"
        },
        {
            "value": "TJ",
            "text": "Tajikistan"
        },
        {
            "value": "TZ",
            "text": "Tanzania, United Republic of"
        },
        {
            "value": "TH",
            "text": "Thailand"
        },
        {
            "value": "TL",
            "text": "Timor-Leste"
        },
        {
            "value": "TG",
            "text": "Togo"
        },
        {
            "value": "TK",
            "text": "Tokelau"
        },
        {
            "value": "TO",
            "text": "Tonga"
        },
        {
            "value": "TT",
            "text": "Trinidad and Tobago"
        },
        {
            "value": "TN",
            "text": "Tunisia"
        },
        {
            "value": "TR",
            "text": "Turkey"
        },
        {
            "value": "TM",
            "text": "Turkmenistan"
        },
        {
            "value": "TC",
            "text": "Turks and Caicos Islands (the)"
        },
        {
            "value": "TV",
            "text": "Tuvalu"
        },
        {
            "value": "UG",
            "text": "Uganda"
        },
        {
            "value": "UA",
            "text": "Ukraine"
        },
        {
            "value": "AE",
            "text": "United Arab Emirates (the)"
        },
        {
            "value": "GB",
            "text": "United Kingdom (the)"
        },
        {
            "value": "US",
            "text": "United States (the)"
        },
        {
            "value": "UM",
            "text": "United States Minor Outlying Islands (the)"
        },
        {
            "value": "UY",
            "text": "Uruguay"
        },
        {
            "value": "UZ",
            "text": "Uzbekistan"
        },
        {
            "value": "VU",
            "text": "Vanuatu"
        },
        {
            "value": "VE",
            "text": "Venezuela, Bolivarian Republic of"
        },
        {
            "value": "VN",
            "text": "Viet Nam"
        },
        {
            "value": "VG",
            "text": "Virgin Islands (British)"
        },
        {
            "value": "VI",
            "text": "Virgin Islands (U.S.)"
        },
        {
            "value": "WF",
            "text": "Wallis and Futuna"
        },
        {
            "value": "EH",
            "text": "Western Sahara"
        },
        {
            "value": "YE",
            "text": "Yemen"
        },
        {
            "value": "ZM",
            "text": "Zambia"
        },
        {
            "value": "ZW",
            "text": "Zimbabwe"
        }
    ],
    "fuelTypes": [
        {
            "id": "Bi-fuel using diesel",
            "description": "Bi-fuel using diesel"
        },
        {
            "id": "Bi-fuel vehicle using battery",
            "description": "Bi-fuel vehicle using battery"
        },
        {
            "id": "Bi-fuel vehicle using battery and combustion engine",
            "description": "Bi-fuel vehicle using battery and combustion engine"
        },
        {
            "id": "Bi-fuel vehicle using CNG",
            "description": "Bi-fuel vehicle using CNG"
        },
        {
            "id": "Bi-fuel vehicle using ethanol",
            "description": "Bi-fuel vehicle using ethanol"
        },
        {
            "id": "Bi-fuel vehicle using LPG",
            "description": "Bi-fuel vehicle using LPG"
        },
        {
            "id": "Bi-fuel vehicle using methanol",
            "description": "Bi-fuel vehicle using methanol"
        },
        {
            "id": "Bi-fuel vehicle using natural gas",
            "description": "Bi-fuel vehicle using natural gas"
        },
        {
            "id": "Bi-fuel vehicle using petrol",
            "description": "Bi-fuel vehicle using petrol"
        },
        {
            "id": "Bi-fuel vehicle using propane",
            "description": "Bi-fuel vehicle using propane"
        },
        {
            "id": "Compressed Natural Gas",
            "description": "Compressed Natural Gas"
        },
        {
            "id": "Diesel",
            "description": "Diesel"
        },
        {
            "id": "Dual fuel - diesel and compressed natural gas",
            "description": "Dual fuel - diesel and compressed natural gas"
        },
        {
            "id": "Dual fuel - diesel and liquid natural gas",
            "description": "Dual fuel - diesel and liquid natural gas"
        },
        {
            "id": "Electric",
            "description": "Electric"
        },
        {
            "id": "Ethanol",
            "description": "Ethanol"
        },
        {
            "id": "Hybrid vehicle in regeneration mode",
            "description": "Hybrid vehicle in regeneration mode"
        },
        {
            "id": "Hybrid vehicle using battery",
            "description": "Hybrid vehicle using battery"
        },
        {
            "id": "Hybrid vehicle using battery and combustion engine",
            "description": "Hybrid vehicle using battery and combustion engine"
        },
        {
            "id": "Hybrid vehicle using diesel engine",
            "description": "Hybrid vehicle using diesel engine"
        },
        {
            "id": "Hybrid vehicle using gasoline engine",
            "description": "Hybrid vehicle using gasoline engine"
        },
        {
            "id": "Hybrid vehicle using gasoline engine on ethanol",
            "description": "Hybrid vehicle using gasoline engine on ethanol"
        },
        {
            "id": "Liquified Petroleum Gas",
            "description": "Liquified Petroleum Gas"
        },
        {
            "id": "Methanol",
            "description": "Methanol"
        },
        {
            "id": "Natural gas",
            "description": "Natural gas"
        },
        {
            "id": "Natural gas (compressed or liquefied natural gas)",
            "description": "Natural gas (compressed or liquefied natural gas)"
        },
        {
            "id": "Petrol",
            "description": "Petrol"
        },
        {
            "id": "Propane",
            "description": "Propane"
        },
        {
            "id": "Not available",
            "description": "Not available"
        },
        {
            "id": "Other",
            "description": "Other"
        }
    ],
    "icons": [
        "van-right",
        "truck-right",
        "trailer-right",
        "trailer2-right",
        "tipper-right",
        "tanker-right",
        "plough-right",
        "crane2-right",
        "crane-right",
        "ems-right",
        "generator2-right",
        "generator-right",
        "forklift-right",
        "key-right",
        "motorcycle-right",
        "car-right",
        "car5-right",
        "car4-right",
        "car3-right",
        "car2-right",
        "bus-right",
        "boat-right",
        "batmobile2-right",
        "batmobile-right",
        "phone",
        "person",
        "ldv-right",
        "train-right",
        "container",
        "ewp-right",
        "chipper-right",
        "truck-logging-right",
        "saw-blade1",
        "saw-blade2",
        "crane-logging"
    ],
    "iconColours": [
        "black",
        "blue",
        "green",
        "teal",
        "deepSkyBlue",
        "aqua",
        "forestGreen",
        "limeGreen",
        "indigo",
        "dimGray",
        "maroon",
        "purple",
        "lightGreen",
        "lightBlue",
        "fireBrick",
        "indianRed",
        "orchid",
        "crimson",
        "lightCoral",
        "red",
        "deepPink",
        "darkOrange",
        "lightPink",
        "yellow"
    ],
    "makesAndModels": [
        "A Trinity Trailer",
        "Abarth",
        "AC",
        "ADL",
        "Adly",
        "Advanced Power",
        "Advantec",
        "Aebi Schmidt",
        "Afrit",
        "Agco Allis (agrotec)",
        "Agrale",
        "Agria",
        "Agria-deutz",
        "Agrico",
        "Air Stream",
        "Alcom LLC",
        "Alfa Romeo",
        "Alimak",
        "Allight",
        "Allmand",
        "Alum-Line",
        "AMC",
        "Amco Vebo",
        "American Crawler",
        "American Trailers",
        "Anglo International",
        "Appalachian Trailers",
        "Aprilia",
        "Arctic Cat",
        "Arising Industries",
        "Arora",
        "Ashok Leyland",
        "Asia Wing",
        "Aston Martin",
        "ASTRA",
        "ATE",
        "Atlas Copco",
        "ATLAS",
        "Atoka Trailer & Mfg.",
        "Atul Auto",
        "Audi",
        "Autocar",
        "B.A.W",
        "Backdraft Racing",
        "Baic",
        "Bajaj",
        "Baoli forklift",
        "Barford",
        "BARKER",
        "Bartlett",
        "BCI",
        "Beiben",
        "Beiqi Foton",
        "Bell Equipment",
        "Belmont Machine",
        "Belshe Industries",
        "Bennche",
        "Bennelli",
        "Bentley",
        "Bestar China",
        "Beta Racing",
        "Big Bubba's Trailer",
        "Big Tex Trailer",
        "Bimota",
        "Bitelli",
        "Blackstone Trailer ",
        "Blackwood hodge",
        "Blue Bird",
        "Blue Diamond",
        "BMC",
        "BMW",
        "Bobcat",
        "Bomag",
        "Bombardiercanam",
        "Bonluck",
        "Bravo Trailers",
        "Brazos",
        "Brindle Products",
        "Brooks Brothers",
        "BRUCE ROCK END",
        "Buick",
        "Busaf",
        "Buyang",
        "BYD",
        "Cadillac",
        "Cagiva",
        "Can-am",
        "Capacity",
        "Cargo Craft",
        "Carry-On Trailer",
        "Case International",
        "Caterpillar",
        "CBH",
        "Centralia Machine",
        "Century Built",
        "CF Moto",
        "Chana - Changan",
        "Changjiang",
        "Chengliwei",
        "Chery",
        "Chevrolet",
        "Choice Trailers",
        "Chrysler",
        "CIMC",
        "Citroen",
        "Claas",
        "CM",
        "Cnhtc",
        "Coachcraft Technologies",
        "Coachmen",
        "Colt",
        "Combilift",
        "CompAir",
        "Conel",
        "Cooper",
        "Covered Wagon Trailers",
        "Crane Carrier",
        "Crown",
        "CRRC",
        "Cummins",
        "Currahee Trailers",
        "D & P Welding and AUTO",
        "D A F",
        "Dacia",
        "Daewoo",
        "DAF",
        "Daihatsu",
        "Daimler",
        "Dakota Manufacturing",
        "Datsun",
        "Demag",
        "Denning",
        "Derbi",
        "Deutz Fahr",
        "Deutz",
        "DFSK",
        "Diamond C Trailer",
        "Dingli",
        "Dinli",
        "Display Solutions",
        "Ditch Witch",
        "Dodge",
        "Dongben",
        "Dongfeng Yangtse",
        "Doosan",
        "DORIC ENGINEERING",
        "Ducati",
        "Dunlite",
        "Dyna",
        "Dynapac",
        "Eager Beaver",
        "Eagle",
        "East Texas Trailers",
        "Ebusco",
        "Echo",
        "Econoline Trailer",
        "Eicher",
        "Electric Motion",
        "Enforcer",
        "Etnyre",
        "Evans Steel",
        "Falcon Trailerworks",
        "Fantuzzi",
        "Farmtrac",
        "Faw",
        "Felling Trailers",
        "Fendt",
        "Ferrari",
        "FG Wilson",
        "Fiat",
        "Flextool",
        "Fontaine Trailers",
        "Ford",
        "Forest River",
        "Fork lift",
        "Foshan Shunde",
        "Fosti",
        "Foton",
        "Fraker Manufacturing",
        "Freedom Trailers",
        "FREIGHTER",
        "Freightliner",
        "FREIGHTQUIP",
        "FS Curtis",
        "FTE",
        "FUSO",
        "GasGas",
        "GAZ",
        "Geely",
        "Genelite",
        "Genesis",
        "Genie",
        "Ghel",
        "GM",
        "GMC",
        "Golden Dragon",
        "Gomoto",
        "Gravely",
        "Great Dane Trailers",
        "Great Northern Trailers",
        "Grove",
        "GTE",
        "Guleryuz",
        "GWM",
        "H & H Trailers",
        "Hafei",
        "Hajadu",
        "Hangcha",
        "Harley Davidson",
        "Hatz",
        "Haulmark",
        "Haval",
        "Hayvan",
        "Heil Trailers",
        "Hendrickson",
        "Henred Fruehauf",
        "Hensim",
        "Higer",
        "Hilite",
        "Hillsboro",
        "Hino",
        "Hitachi",
        "HMC",
        "Holden Industries",
        "Holden",
        "HOLMWOOD",
        "Homesteader",
        "Honda",
        "Horse Creek Manufacturing",
        "Hudson Brothers",
        "Hummer",
        "Husaberg",
        "Husqvarna",
        "Hustler",
        "Hydrovane",
        "Hyosung",
        "Hyster",
        "Hyundai",
        "Ibhubezi",
        "IC BUS",
        "Indian",
        "Indotrac",
        "Infiniti",
        "Ingersoll Rand",
        "Innovative Trailer",
        "InTech Trailers",
        "International",
        "Interstate",
        "Irisbus",
        "Irizar",
        "Isuzu",
        "Iveco",
        "J & L's Cargo express",
        "JAC",
        "Jaguar",
        "Jawa",
        "JCB",
        "Jeep",
        "Jet Company",
        "Jialing",
        "Jianshe",
        "Jimmy's Custom Built Trailers",
        "Jinma",
        "Jlg",
        "John deere",
        "Jonway",
        "JRW Trailers",
        "Jubilee",
        "Kamaz",
        "Karavan Trailer",
        "Karcher",
        "KARSAN",
        "Kaufman Trailers",
        "Kawasaki",
        "Kenworth",
        "Keogh",
        "Kerr-bilt",
        "Kia",
        "King Long",
        "Kinroad Xintian",
        "Kioti",
        "Kobelco",
        "Kohler",
        "Komatsu",
        "Konecranes",
        "Kotzur",
        "KRAZ",
        "KRUEGER",
        "KTM",
        "KTMMEX",
        "Kubota",
        "Kwik Kleen",
        "KYMCO",
        "La Padona",
        "Lada",
        "Lamar Trailers",
        "Lamborghini",
        "Lambretta",
        "Lancia",
        "Land rover",
        "Landini",
        "Lark United Manufacturing",
        "Larson Cable Trailers",
        "Laverda",
        "LDV",
        "Leeboy",
        "Lemco Tool",
        "Lexus",
        "LGS Industries",
        "LiAZ",
        "Liebherr",
        "Lifan",
        "Lincoln",
        "Linde",
        "Link-Belt",
        "Lister Petter",
        "Liugong",
        "Load Trail",
        "Lobstar",
        "Lone Star Oryogenics",
        "Lotus",
        "Loudo Trailers",
        "Luba",
        "Luigong",
        "M.D. Products",
        "MACK",
        "MAGIRUS",
        "Mahindra",
        "MAN",
        "Manitou",
        "MARSHALL LETHLEAN",
        "MarutiSuzuki",
        "Maserati",
        "Massey ferguson",
        "Master Tow",
        "Maxey Trailers",
        "MAXICUBE",
        "MaxiTRANS",
        "MAZ",
        "Mazda",
        "Mccormick",
        "McFarland",
        "Mclaren",
        "Mclaughlin",
        "MCT",
        "Mercedes Benz",
        "Merlo",
        "Merritt Equipment",
        "Mertz Manufacturing",
        "METRO",
        "MG",
        "MICK MURRAY WELDING",
        "Miller",
        "Mini",
        "Mitsubishi",
        "Mobi",
        "Mobile Tech Trailers",
        "Monon",
        "Monroe Towmaster",
        "Montracon",
        "Moto guzzi",
        "Motomia",
        "Motor Coach Industries",
        "Munsch",
        "MV Agusta",
        "National Motors",
        "NAVISTAR",
        "NefAZ",
        "Neoplan",
        "New Holland",
        "Nissan",
        "North Alabama Trailer",
        "Opel",
        "Operbus",
        "OPHEE",
        "Optare",
        "Orteq Energy Services",
        "Oshkosh",
        "Other",
        "Pace American",
        "Paiute Trailers",
        "Palfinger",
        "Parkwood",
        "PAZ",
        "Pegson",
        "PEKI",
        "Penske",
        "Peterbilt",
        "Peugeot",
        "PFI",
        "Piaggio",
        "Pierce Manufacturing",
        "PJ",
        "PLAN",
        "Polaris",
        "Polarsun",
        "Ponderosa Trailers",
        "Pontiac",
        "Porsche",
        "Powerscreen",
        "Powerstar",
        "PR Power",
        "Pratt Industries",
        "Prevost",
        "Priefert",
        "PTES",
        "Putzmeister",
        "R and I Holding",
        "Ram",
        "RAVO",
        "RC Trailers",
        "Redi-Haul",
        "Renault",
        "Rice Trailers",
        "Rig Works",
        "Ring-O-Matic Manufacturing",
        "ROADWEST",
        "Rokbak",
        "Rolls Rite Trailers",
        "Rolls Royce",
        "Rover",
        "Royal Enfield",
        "RTS",
        "SA Truck Bodies",
        "Saab",
        "Salvation Trailers",
        "Samil",
        "Sandvik",
        "Sany",
        "Saturn",
        "Scania",
        "Scanmaskin",
        "SCE",
        "SCHMITZ CARGO BULL",
        "Schmitz Cargobull",
        "Schwarzmüller",
        "Scion",
        "SDC Trailers",
        "Seat",
        "Secma",
        "Sennenbogen",
        "Serco",
        "Service King",
        "Setra",
        "Shacman",
        "Shanghai meitian motorcycle ",
        "Shaolin",
        "Shatui",
        "SHEPHARD",
        "Sherco",
        "Shermac",
        "Sherman + Reilly",
        "SIMAZ",
        "Sinotruk",
        "SISU",
        "Skoda",
        "Skyline",
        "Slingshot",
        "SMP",
        "Solaris",
        "Solartech",
        "Sonalika",
        "Soosan",
        "SOUTHERN CROSS",
        "Southern Heritage Trailers",
        "Soyat",
        "Ssangyong",
        "STEELBRO",
        "Sterling",
        "Still",
        "Storm",
        "Stoughton trailers",
        "Strick Trailer",
        "Subaru",
        "Sundowner",
        "Sunlong",
        "Super Products DURASUCKER",
        "Sure-Trac Trailers",
        "Suzhou Eagle",
        "Suzuki",
        "Sykes",
        "Sym",
        "T&J Trailers",
        "Tadano",
        "Tafe",
        "Takeuchi",
        "TAM Motors VIVAIR 104WL",
        "Tampa Trailerworks",
        "Tarter Industries",
        "Tata",
        "Tatra",
        "Temsa",
        "Terberg",
        "Terex",
        "Texas Bragg Enterprises",
        "Texas Pride Trailers",
        "TGB",
        "Thomas Built",
        "Thomas",
        "TIEMAN",
        "Timpte",
        "Tm racing",
        "Top Hat Industries",
        "Top trailers",
        "TORO",
        "Towmaster",
        "Toyota",
        "Trail Master",
        "Trail-Rite",
        "Tramontina",
        "Transcraft",
        "Trinity trailer",
        "Triton",
        "Triumph",
        "Trophy Boat Trailers",
        "TVS",
        "TX Bragg",
        "UAZ",
        "UD trucks",
        "United Trailers",
        "Ural",
        "Ursus",
        "Us truck",
        "Utility Trailer Manufacturer",
        "Vac-Tron Equipment",
        "Valtra (valmet)",
        "Van Hool",
        "Vanguard",
        "VAWDREY",
        "VDL",
        "Venieri",
        "Venturetech",
        "Vermeer",
        "Vespa",
        "Vic Grain",
        "Victory Trailers",
        "Volare",
        "Volkswagen",
        "Volvo",
        "Vuka",
        "Wabash",
        "Wacker Neuson",
        "Wallinga",
        "Wanco",
        "Wausau-Everest SD3131",
        "Welling & Crossley",
        "Wells Cargo",
        "Western Star",
        "Wheeler Reeler",
        "White Oliver",
        "Wilson",
        "Wirtgen",
        "Workhorse ",
        "WRIGHT",
        "WTM",
        "Wyatt's",
        "Wylie",
        "XCMG",
        "Xingyue",
        "Yale",
        "Yamaha",
        "Yamoto",
        "Yangste River",
        "Yanmar",
        "YEO TR ENGRG & TRDG",
        "YTO",
        "Yutong",
        "Zhejiang cf moto",
        "Zhejiang leike",
        "Zhejiang renli",
        "Zhejiang riya",
        "Zhongtong",
        "ZiL",
        "Zongshen",
        "Zontes",
        "Zoomlion",
        "Zotye",
        "Zx Auto"
    ],
    "assetImageUploadUrl": null,
    "organisationId": null,
    "organisationName": null,
    "canEditVin": true,
    "canEditConfigGroups": true,
    "canUpdateConfigGroupMembers": true,
    "engineHoursEnabled": false,
    "canResendCommissioningRequest": false,
    "canEditMobileNumber": false,
    "defaultIcons": {
        "1": "motorcycle-right",
        "2": "trailer2-right",
        "4": "boat-right",
        "5": "forklift-right",
        "6": "generator2-right",
        "7": "ems-right",
        "8": "tanker-right",
        "9": "car4-right",
        "10": "van-right",
        "11": "bus-right",
        "12": "bus-right",
        "13": "bus-right",
        "14": "truck-right",
        "15": "truck-right",
        "16": "truck-right",
        "17": "car-right",
        "18": "tanker-right",
        "19": "plough-right",
        "20": "truck-right",
        "21": "train-right",
        "22": "ldv-right",
        "24": "ldv-right",
        "25": "flatbed-truck-right",
        "26": "container",
        "27": "phone",
        "28": "truck-right"
    },
    "isOnJourney": false,
    "isStreamaxCommissioned": false,
    "hyperMedia": null
}
```
- Mobile Device Settings
	- GEt: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944
	- ==hasbeencommissioned = true==
	- Reason: "ConfigurationStatus": "Configuration changed",
```json
{
    "Form": {
        "AssetName": "Default mobile device template for CalAmp Premium",
        "HasBeenCommissioned": true,
        "DeviceTypeName": "CalAmp Premium",
        "MobileDeviceId": "878914713632096376",
        "HasDeviceTypeIdentifier": true,
        "DeviceTypeIdentifierTitle": "IMEI Number",
        "DeviceTypeIdentifierValue": null,
        "ConfigChanged": false,
        "IridiumImei": "",
        "IridiumContract": "",
        "IridiumPlanName": "",
        "IridiumError": null,
        "IridiumSatelliteCapable": false,
        "HasIridiumImei": false,
        "CanDeactivateIridiumAccount": false,
        "CommunicationCapable": false,
        "SimCardPinCode": "",
        "GprsCapable": false,
        "GprsEnabled": false,
        "GprsApnPointName": null,
        "GprsApnUsername": null,
        "GprsApnPassword": null,
        "GsmCapable": false,
        "GsmEnabled": false,
        "GsmMsisdnNumber": null,
        "SmsCapable": false,
        "SmsEnabled": false,
        "SmsMobileDeviceNumber": null,
        "SmsMessageCentreNumber": null,
        "SatelliteCapable": false,
        "SatalliteDeviceId": "",
        "UploadScheduleId": null,
        "HasUploadSchedule": false,
        "IsMesaBased": false,
        "CanEditDetails": true,
        "CanEditSmsDetails": true,
        "CanEditGsmDetails": true,
        "CanEditSimPin": true,
        "CanEditApnName": true,
        "CanEditMobileDevice": true,
        "CanRemoveMobileDevice": true,
        "CanEditSatelliteDetails": true,
        "CanEditIridiumSatelliteDetails": true,
        "CompileCapable": false,
        "CanCompileConfig": true,
        "CanUploadConfig": true,
        "CanViewCommsLog": true,
        "OrgIsMiXTalkEnabled": false,
        "MiXTalkIMEI": null,
        "MiXTalkSIMNumber": null,
        "MiXTalkCarrierID": 0,
        "MiXTalkCarriers": null,
        "CommissioningStatus": null,
        "ShowOBCResendCommissioningSMS": false,
        "Tabs": null,
        "OrgIsStreamaxEnabled": false,
        "StreamaxDeviceTypes": null,
        "StreamaxSerialNumber": null,
        "DeviceIsStreamaxEnabled": true,
        "CanEditStreamaxDetails": true,
        "IsStreamaxStandAlone": false,
        "IsStreamaxPeripheralConnected": false,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "updateTabs",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/tabs",
                    "Verb": "GET",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "sendCommissioningRequest",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/send-obc-commissioning-request",
                    "Verb": "POST",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": "assetCommissioningForm",
                "ValidationRules": {
                    "IridiumImei": [
                        {
                            "Attribute": "fleet-mobile-unit-satallite-iridium-imei-unique-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-satallite-iridium-imei-unique-async-message",
                            "Value": "'IMEI is already in use'"
                        },
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "15"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 15 characters'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "15"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 15 characters'"
                        }
                    ],
                    "SimCardPinCode": [
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "0"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 8 characters or less'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "8"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 8 characters or less'"
                        },
                        {
                            "Attribute": "dmx-integer",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-integer-message",
                            "Value": "'This field must contain numeric characters only'"
                        }
                    ],
                    "GprsApnPointName": [
                        {
                            "Attribute": "dmx-required",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-required-message",
                            "Value": "'This field is required'"
                        }
                    ],
                    "GsmMsisdnNumber": [
                        {
                            "Attribute": "dmx-required",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-required-message",
                            "Value": "'This field is required'"
                        },
                        {
                            "Attribute": "dmx-phonenumber",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonenumber-message",
                            "Value": "'The value must be a valid phone number, e.g. +27 12 345 6789'"
                        },
                        {
                            "Attribute": "dmx-phonecountrycode",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonecountrycode-message",
                            "Value": "'Invalid country code'"
                        }
                    ],
                    "SmsMobileDeviceNumber": [
                        {
                            "Attribute": "dmx-required",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-required-message",
                            "Value": "'This field is required'"
                        },
                        {
                            "Attribute": "dmx-phonenumber",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonenumber-message",
                            "Value": "'The value must be a valid phone number, e.g. +27 12 345 6789'"
                        },
                        {
                            "Attribute": "dmx-phonecountrycode",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonecountrycode-message",
                            "Value": "'Invalid country code'"
                        }
                    ],
                    "SmsMessageCentreNumber": [
                        {
                            "Attribute": "dmx-required",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-required-message",
                            "Value": "'This field is required'"
                        },
                        {
                            "Attribute": "dmx-phonenumber",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonenumber-message",
                            "Value": "'The value must be a valid phone number, e.g. +27 12 345 6789'"
                        },
                        {
                            "Attribute": "dmx-phonecountrycode",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonecountrycode-message",
                            "Value": "'Invalid country code'"
                        }
                    ],
                    "SatalliteDeviceId": [
                        {
                            "Attribute": "dmx-alphanumeric",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-alphanumeric-message",
                            "Value": "'This field must be alphanumeric'"
                        },
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "0"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 30 characters or less'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "30"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 30 characters or less'"
                        },
                        {
                            "Attribute": "fleet-mobile-unit-satallite-device-id-unique-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-satallite-device-id-unique-async-message",
                            "Value": "'Satellite device id is already in use'"
                        }
                    ],
                    "DeviceTypeIdentifierValueTDI": [
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "0"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 50 characters or less'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "50"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 50 characters or less'"
                        },
                        {
                            "Attribute": "fleet-mobile-unit-unique-identifier-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-unique-identifier-async-message",
                            "Value": "'Unique identifier already in use'"
                        }
                    ],
                    "DeviceTypeIdentifierValue": [
                        {
                            "Attribute": "fleet-mobile-unit-unique-identifier-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-unique-identifier-async-message",
                            "Value": "'Unique identifier already in use'"
                        }
                    ],
                    "SIMCardTypeIdentifierValue": [
                        {
                            "Attribute": "fleet-sim-card-unique-number-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-sim-card-unique-number-async-message",
                            "Value": "'SIM number already in use'"
                        }
                    ],
                    "DeviceTypeIdentifierValueMobileNumber": [
                        {
                            "Attribute": "fleet-mobile-number-unique-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-number-unique-async-message",
                            "Value": "'Mobile number already in use'"
                        }
                    ],
                    "STMSerialNumberIdentifierValue": [
                        {
                            "Attribute": "stm-unique-serial-number-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "stm-unique-serial-number-async-message",
                            "Value": "'Serial number already in use'"
                        }
                    ]
                },
                "HasMonitoredEvents": false
            }
        }
    },
    "ChangeMobileDeviceTemplate": {
        "ConfigGroupId": "-3859349747606875553",
        "MobileNumber": null,
        "IsMobilePhone": false,
        "IsStreamax": false,
        "WasMobilePhone": false,
        "WasStreamax": false,
        "WasStreamaxPeripheral": false,
        "IsFM": false,
        "IdentifierTitle": "IMEI Number",
        "Devices": [
            {
                "DeviceTypeId": "878914713632096376",
                "Name": "CalAmp Premium",
                "IdentifierTitle": "IMEI Number",
                "IsBeacon": false,
                "IsMobilePhone": false,
                "IsStreamax": false,
                "IsFM": false,
                "IsStreamaxStandAlone": false,
                "IsUniqueIdentifierVIN": false
            }
        ],
        "ConfigGroups": [
            {
                "ConfigGroupId": "-3859349747606875553",
                "Name": "Default configuration group for CalAmp Premium",
                "DeviceTypeId": "878914713632096376"
            }
        ],
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/change-mobile-device",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "RemoveMobileDeviceTemplate": {
        "MoveToDecommissionedSite": false,
        "SiteId": null,
        "MakeAssetInactive": false,
        "Sites": [],
        "Notes": null,
        "WasStreamax": false,
        "WasStreamaxPeripheral": false,
        "IsUniqueIdentifierVIN": false,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/remove-mobile-device",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "SetOdoTemplate": null,
    "SetEngineHoursTemplate": null,
    "ChangeThresholdsTemplate": null,
    "AssetConfigSummary": {
        "Id": null,
        "PendingConfigurationVersionId": null,
        "PendingConfigurationVersion": null,
        "PendingConfigurationGeneratedBy": null,
        "PendingConfigurationGeneratedDateTime": null,
        "CurrentConfigurationVersionId": null,
        "CurrentConfigurationVersion": null,
        "CurrentConfigurationGeneratedBy": null,
        "CurrentConfigurationGeneratedDateTime": null,
        "CanSetOdo": false,
        "CanChangeThresholds": false,
        "CanSendDefaults": false,
        "CanDownloadConfig": true,
        "IsTrackAndTrace": false,
        "IsTeltonika": false,
        "IsBeacon": false,
        "IsMix2K": false,
        "IsTDI": false,
        "IsVT1310": false,
        "IsLommyEye": false,
        "IsPhoneTdi": false,
        "IsPhoneTrackTrace": false,
        "IsSatTrackTrace": false,
        "IsGoSafeTracker": false,
        "IsMobilePhone": false,
        "IsStreamaxStandAlone": false,
        "IsScaniaOem": false,
        "ConfigurationStatus": "Configuration changed",
        "ConfigStatusCanCompile": true,
        "ConfigStatusCanUpload": false,
        "CanSetEngineHours": false,
        "IsEngineHoursSelected": false,
        "EngineHours": null,
        "IsUniqueIdentifierVIN": false
    },
    "AssetDownloadConfigTemplate": {
        "PlugSizeOptions": {
            "AvailableUnits": [
                {
                    "Value": "256",
                    "Display": "256 kb",
                    "Extended": false,
                    "UnitType": null
                },
                {
                    "Value": "96",
                    "Display": "96 kb",
                    "Extended": false,
                    "UnitType": null
                },
                {
                    "Value": "32",
                    "Display": "32 kb",
                    "Extended": false,
                    "UnitType": null
                }
            ],
            "UnitType": null,
            "Unit": null,
            "Value": null,
            "DisplayValue": null
        },
        "EventRatio": 80,
        "PlugSize": "256",
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "downloadConfig",
                    "Uri": "DynaMiX.API/fleet-admin/organisations/:orgId/assets/:assetId/configuration/:configurationVersionId/plugsize/:plugSizeKb/eventdata/:eventDataPercentage",
                    "Verb": "POST",
                    "Params": {
                        "orgId": "@orgId",
                        "assetId": "@assetId",
                        "configurationVersionId": "@configurationVersionId",
                        "plugSizeKb": "@plugSizeKb",
                        "eventDataPercentage": "@eventDataPercentage"
                    },
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "AssetChangeSatelliteModemTemplate": {
        "OldImeiNumber": null,
        "RemoveMode": null,
        "Note": null,
        "NewImeiNumber": null,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/change-satellite-modem",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": "assetChangeSatelliteModemForm",
                "ValidationRules": {
                    "NewImeiNumber": [
                        {
                            "Attribute": "fleet-mobile-unit-satallite-iridium-imei-unique-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-satallite-iridium-imei-unique-async-message",
                            "Value": "'IMEI is already in use'"
                        },
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "15"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 15 characters'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "15"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 15 characters'"
                        }
                    ]
                },
                "HasMonitoredEvents": false
            }
        }
    },
    "AssetChangeStreamaxDeviceTemplate": {
        "StreamaxSerialNumber": null,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/change-streamax-device",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "AssetRemoveSatelliteModemTemplate": {
        "ImeiNumber": null,
        "RemoveMode": null,
        "Note": null,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/remove-satellite-modem",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": "removeStreamaxModalForm",
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "ReSendCommissioningRequestTemplate": null,
    "RemoveMobilePhoneTemplate": {
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/remove-moblie-phone",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "AssetCompileConfigTemplate": null,
    "AssetUploadConfigTemplate": {
        "WhenToUpload": 0,
        "WhenToUploadDateTime": null,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "compileAndUploadConfig",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/compile_and_upload",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "uploadConfig",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/upload",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "OrgId": "1085003241271469083",
    "RemoveStreamaxSerialNoTemplate": {
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "remove",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439217777257938944/remove-streamax-serial-no",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "HyperMedia": {
        "Links": [],
        "Validations": {
            "FormName": null,
            "ValidationRules": {},
            "HasMonitoredEvents": false
        }
    }
}
```
- 

## Findings

- The initial SAVE has different logic from the UPDATE
- The UPDATE causes the IMEI to be greyed out
- [x] The IMEI is greyed out because: form.hasBeenCommissioned = true ✅ 2023-09-15
	- Because: ConfigurationStatus != ConfigEnums.ConfigurationStatus.NotCommissioned
	- Because: Status = Configuration changed
	- [x] What sets it to this? ✅ 2023-09-15
		- I think Fleet's Update code
- [x] The Update logic that is different is: xxxxxxxxx ✅ 2023-09-15

## Imei greyed out

- C:\Projects\MiX.Fleet.UI\UI\Js\FleetAdmin\Templates\asset-commissioning.html
- +- Line 28

### HTML

```html
<input type="text" ng-hide="assetConfigSummary.isTDI || assetConfigSummary.isMobilePhone || assetConfigSummary.isStreamaxStandAlone" ng-disabled="assetConfigSummary.isMobilePhone || !changeMobileDeviceTemplate.identifierTitle || !form.hasDeviceTypeIdentifier || form.hasBeenCommissioned || assetConfigSummary.isTDI || assetConfigSummary.isScaniaOem" ng-model="form.deviceTypeIdentifierValue" name="deviceTypeIdentifierValue" dmx-validate="deviceTypeIdentifierValue" class="span12 ng-pristine ng-valid-fleet-mobile-unit-unique-identifier-async ng-valid ng-valid-dmx-required" dmx-required="" fleet:mobile-unit-unique-identifier-async-params="{ assetId: assetId }" fleet:mobile-unit-unique-identifier-async="" fleet:mobile-unit-unique-identifier-async-message="'Unique identifier already in use'" fleet-mobile-unit-unique-identifier-async="" fleet-mobile-unit-unique-identifier-async-message="'Unique identifier already in use'" disabled="disabled">
```

### Call

- GET: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696

### Preview Values

```json
{
    "Form": {
        "AssetName": "Default mobile device template for CalAmp Premium",
        "HasBeenCommissioned": true,
        "DeviceTypeName": "CalAmp Premium",
        "MobileDeviceId": "878914713632096376",
        "HasDeviceTypeIdentifier": true,
        "DeviceTypeIdentifierTitle": "IMEI Number",
        "DeviceTypeIdentifierValue": null,
        "ConfigChanged": false,
        "IridiumImei": "",
        "IridiumContract": "",
        "IridiumPlanName": "",
        "IridiumError": null,
        "IridiumSatelliteCapable": false,
        "HasIridiumImei": false,
        "CanDeactivateIridiumAccount": false,
        "CommunicationCapable": false,
        "SimCardPinCode": "",
        "GprsCapable": false,
        "GprsEnabled": false,
        "GprsApnPointName": null,
        "GprsApnUsername": null,
        "GprsApnPassword": null,
        "GsmCapable": false,
        "GsmEnabled": false,
        "GsmMsisdnNumber": null,
        "SmsCapable": false,
        "SmsEnabled": false,
        "SmsMobileDeviceNumber": null,
        "SmsMessageCentreNumber": null,
        "SatelliteCapable": false,
        "SatalliteDeviceId": "",
        "UploadScheduleId": null,
        "HasUploadSchedule": false,
        "IsMesaBased": false,
        "CanEditDetails": true,
        "CanEditSmsDetails": true,
        "CanEditGsmDetails": true,
        "CanEditSimPin": true,
        "CanEditApnName": true,
        "CanEditMobileDevice": true,
        "CanRemoveMobileDevice": true,
        "CanEditSatelliteDetails": true,
        "CanEditIridiumSatelliteDetails": true,
        "CompileCapable": false,
        "CanCompileConfig": true,
        "CanUploadConfig": true,
        "CanViewCommsLog": true,
        "OrgIsMiXTalkEnabled": false,
        "MiXTalkIMEI": null,
        "MiXTalkSIMNumber": null,
        "MiXTalkCarrierID": 0,
        "MiXTalkCarriers": null,
        "CommissioningStatus": null,
        "ShowOBCResendCommissioningSMS": false,
        "Tabs": null,
        "OrgIsStreamaxEnabled": false,
        "StreamaxDeviceTypes": null,
        "StreamaxSerialNumber": null,
        "DeviceIsStreamaxEnabled": true,
        "CanEditStreamaxDetails": true,
        "IsStreamaxStandAlone": false,
        "IsStreamaxPeripheralConnected": false,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "updateTabs",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/tabs",
                    "Verb": "GET",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "sendCommissioningRequest",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/send-obc-commissioning-request",
                    "Verb": "POST",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": "assetCommissioningForm",
                "ValidationRules": {
                    "IridiumImei": [
                        {
                            "Attribute": "fleet-mobile-unit-satallite-iridium-imei-unique-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-satallite-iridium-imei-unique-async-message",
                            "Value": "'IMEI is already in use'"
                        },
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "15"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 15 characters'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "15"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 15 characters'"
                        }
                    ],
                    "SimCardPinCode": [
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "0"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 8 characters or less'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "8"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 8 characters or less'"
                        },
                        {
                            "Attribute": "dmx-integer",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-integer-message",
                            "Value": "'This field must contain numeric characters only'"
                        }
                    ],
                    "GprsApnPointName": [
                        {
                            "Attribute": "dmx-required",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-required-message",
                            "Value": "'This field is required'"
                        }
                    ],
                    "GsmMsisdnNumber": [
                        {
                            "Attribute": "dmx-required",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-required-message",
                            "Value": "'This field is required'"
                        },
                        {
                            "Attribute": "dmx-phonenumber",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonenumber-message",
                            "Value": "'The value must be a valid phone number, e.g. +27 12 345 6789'"
                        },
                        {
                            "Attribute": "dmx-phonecountrycode",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonecountrycode-message",
                            "Value": "'Invalid country code'"
                        }
                    ],
                    "SmsMobileDeviceNumber": [
                        {
                            "Attribute": "dmx-required",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-required-message",
                            "Value": "'This field is required'"
                        },
                        {
                            "Attribute": "dmx-phonenumber",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonenumber-message",
                            "Value": "'The value must be a valid phone number, e.g. +27 12 345 6789'"
                        },
                        {
                            "Attribute": "dmx-phonecountrycode",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonecountrycode-message",
                            "Value": "'Invalid country code'"
                        }
                    ],
                    "SmsMessageCentreNumber": [
                        {
                            "Attribute": "dmx-required",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-required-message",
                            "Value": "'This field is required'"
                        },
                        {
                            "Attribute": "dmx-phonenumber",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonenumber-message",
                            "Value": "'The value must be a valid phone number, e.g. +27 12 345 6789'"
                        },
                        {
                            "Attribute": "dmx-phonecountrycode",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-phonecountrycode-message",
                            "Value": "'Invalid country code'"
                        }
                    ],
                    "SatalliteDeviceId": [
                        {
                            "Attribute": "dmx-alphanumeric",
                            "Value": ""
                        },
                        {
                            "Attribute": "dmx-alphanumeric-message",
                            "Value": "'This field must be alphanumeric'"
                        },
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "0"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 30 characters or less'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "30"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 30 characters or less'"
                        },
                        {
                            "Attribute": "fleet-mobile-unit-satallite-device-id-unique-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-satallite-device-id-unique-async-message",
                            "Value": "'Satellite device id is already in use'"
                        }
                    ],
                    "DeviceTypeIdentifierValueTDI": [
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "0"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 50 characters or less'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "50"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 50 characters or less'"
                        },
                        {
                            "Attribute": "fleet-mobile-unit-unique-identifier-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-unique-identifier-async-message",
                            "Value": "'Unique identifier already in use'"
                        }
                    ],
                    "DeviceTypeIdentifierValue": [
                        {
                            "Attribute": "fleet-mobile-unit-unique-identifier-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-unique-identifier-async-message",
                            "Value": "'Unique identifier already in use'"
                        }
                    ],
                    "SIMCardTypeIdentifierValue": [
                        {
                            "Attribute": "fleet-sim-card-unique-number-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-sim-card-unique-number-async-message",
                            "Value": "'SIM number already in use'"
                        }
                    ],
                    "DeviceTypeIdentifierValueMobileNumber": [
                        {
                            "Attribute": "fleet-mobile-number-unique-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-number-unique-async-message",
                            "Value": "'Mobile number already in use'"
                        }
                    ],
                    "STMSerialNumberIdentifierValue": [
                        {
                            "Attribute": "stm-unique-serial-number-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "stm-unique-serial-number-async-message",
                            "Value": "'Serial number already in use'"
                        }
                    ]
                },
                "HasMonitoredEvents": false
            }
        }
    },
    "ChangeMobileDeviceTemplate": {
        "ConfigGroupId": "-3859349747606875553",
        "MobileNumber": null,
        "IsMobilePhone": false,
        "IsStreamax": false,
        "WasMobilePhone": false,
        "WasStreamax": false,
        "WasStreamaxPeripheral": false,
        "IsFM": false,
        "IdentifierTitle": "IMEI Number",
        "Devices": [
            {
                "DeviceTypeId": "878914713632096376",
                "Name": "CalAmp Premium",
                "IdentifierTitle": "IMEI Number",
                "IsBeacon": false,
                "IsMobilePhone": false,
                "IsStreamax": false,
                "IsFM": false,
                "IsStreamaxStandAlone": false,
                "IsUniqueIdentifierVIN": false
            }
        ],
        "ConfigGroups": [
            {
                "ConfigGroupId": "-3859349747606875553",
                "Name": "Default configuration group for CalAmp Premium",
                "DeviceTypeId": "878914713632096376"
            }
        ],
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/change-mobile-device",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "RemoveMobileDeviceTemplate": {
        "MoveToDecommissionedSite": false,
        "SiteId": null,
        "MakeAssetInactive": false,
        "Sites": [],
        "Notes": null,
        "WasStreamax": false,
        "WasStreamaxPeripheral": false,
        "IsUniqueIdentifierVIN": false,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/remove-mobile-device",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "SetOdoTemplate": null,
    "SetEngineHoursTemplate": null,
    "ChangeThresholdsTemplate": null,
    "AssetConfigSummary": {
        "Id": null,
        "PendingConfigurationVersionId": null,
        "PendingConfigurationVersion": null,
        "PendingConfigurationGeneratedBy": null,
        "PendingConfigurationGeneratedDateTime": null,
        "CurrentConfigurationVersionId": null,
        "CurrentConfigurationVersion": null,
        "CurrentConfigurationGeneratedBy": null,
        "CurrentConfigurationGeneratedDateTime": null,
        "CanSetOdo": false,
        "CanChangeThresholds": false,
        "CanSendDefaults": false,
        "CanDownloadConfig": true,
        "IsTrackAndTrace": false,
        "IsTeltonika": false,
        "IsBeacon": false,
        "IsMix2K": false,
        "IsTDI": false,
        "IsVT1310": false,
        "IsLommyEye": false,
        "IsPhoneTdi": false,
        "IsPhoneTrackTrace": false,
        "IsSatTrackTrace": false,
        "IsGoSafeTracker": false,
        "IsMobilePhone": false,
        "IsStreamaxStandAlone": false,
        "IsScaniaOem": false,
        "ConfigurationStatus": "Configuration changed",
        "ConfigStatusCanCompile": true,
        "ConfigStatusCanUpload": false,
        "CanSetEngineHours": false,
        "IsEngineHoursSelected": false,
        "EngineHours": null,
        "IsUniqueIdentifierVIN": false
    },
    "AssetDownloadConfigTemplate": {
        "PlugSizeOptions": {
            "AvailableUnits": [
                {
                    "Value": "256",
                    "Display": "256 kb",
                    "Extended": false,
                    "UnitType": null
                },
                {
                    "Value": "96",
                    "Display": "96 kb",
                    "Extended": false,
                    "UnitType": null
                },
                {
                    "Value": "32",
                    "Display": "32 kb",
                    "Extended": false,
                    "UnitType": null
                }
            ],
            "UnitType": null,
            "Unit": null,
            "Value": null,
            "DisplayValue": null
        },
        "EventRatio": 80,
        "PlugSize": "256",
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "downloadConfig",
                    "Uri": "DynaMiX.API/fleet-admin/organisations/:orgId/assets/:assetId/configuration/:configurationVersionId/plugsize/:plugSizeKb/eventdata/:eventDataPercentage",
                    "Verb": "POST",
                    "Params": {
                        "orgId": "@orgId",
                        "assetId": "@assetId",
                        "configurationVersionId": "@configurationVersionId",
                        "plugSizeKb": "@plugSizeKb",
                        "eventDataPercentage": "@eventDataPercentage"
                    },
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "AssetChangeSatelliteModemTemplate": {
        "OldImeiNumber": null,
        "RemoveMode": null,
        "Note": null,
        "NewImeiNumber": null,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/change-satellite-modem",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": "assetChangeSatelliteModemForm",
                "ValidationRules": {
                    "NewImeiNumber": [
                        {
                            "Attribute": "fleet-mobile-unit-satallite-iridium-imei-unique-async",
                            "Value": ""
                        },
                        {
                            "Attribute": "fleet-mobile-unit-satallite-iridium-imei-unique-async-message",
                            "Value": "'IMEI is already in use'"
                        },
                        {
                            "Attribute": "dmx-minlength",
                            "Value": "15"
                        },
                        {
                            "Attribute": "dmx-minlength-message",
                            "Value": "'The entered field must be 15 characters'"
                        },
                        {
                            "Attribute": "dmx-maxlength",
                            "Value": "15"
                        },
                        {
                            "Attribute": "dmx-maxlength-message",
                            "Value": "'The entered field must be 15 characters'"
                        }
                    ]
                },
                "HasMonitoredEvents": false
            }
        }
    },
    "AssetChangeStreamaxDeviceTemplate": {
        "StreamaxSerialNumber": null,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/change-streamax-device",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "AssetRemoveSatelliteModemTemplate": {
        "ImeiNumber": null,
        "RemoveMode": null,
        "Note": null,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/remove-satellite-modem",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": "removeStreamaxModalForm",
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "ReSendCommissioningRequestTemplate": null,
    "RemoveMobilePhoneTemplate": {
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/remove-moblie-phone",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "AssetCompileConfigTemplate": null,
    "AssetUploadConfigTemplate": {
        "WhenToUpload": 0,
        "WhenToUploadDateTime": null,
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "compileAndUploadConfig",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/compile_and_upload",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "uploadConfig",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/upload",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "OrgId": "1085003241271469083",
    "RemoveStreamaxSerialNoTemplate": {
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "remove",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1439188832338333696/remove-streamax-serial-no",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                }
            ],
            "Validations": {
                "FormName": null,
                "ValidationRules": {},
                "HasMonitoredEvents": false
            }
        }
    },
    "HyperMedia": {
        "Links": [],
        "Validations": {
            "FormName": null,
            "ValidationRules": {},
            "HasMonitoredEvents": false
        }
    }
}
```


## Where is the hasBeenCommissioned set in the BE

![[hasBeenCommissioned.code-search]]



### There is a workaround

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number Workaround.png | 300]]



## Fleet code

Update
- Api: 
	- C:\Projects\Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.API\Constants\ApiControllerRoutes.cs
	- public const string UpdateAssetDetailAsync = "api/asset-details/group/{groupId}/asset/{assetId}/update";
- C:\Projects\Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.API\Controllers\AssetDetailsController.cs
	- POST
	- Hypermedia: updateAssetDetail
	- await _assetDetailsManager.UpdateAssetDetailAsync(assetDetails.ToEntity(userProfileSettings), _sessionService.AuthToken).ConfigureAwait(true);
- C:\Projects\Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.Logic\AssetDetailsManager\AssetDetailsManager.cs
	- await FleetServicesDataClient.Assets.UpdateExtendedAsync(asset.ToEntity(), false, securityAccounts, updateAdditionalAssets: true, updateCanProtocol: !String.IsNullOrEmpty(asset.CanProtocol)).ConfigureAwait(false);
- C:\Projects\Fleet.Services\MiX.Fleet.Services.Api.Client\Repositories\AssetsRepository.cs
	-       await HttpRetries.ExecuteAsync(() =>NewPutRequest(route, asset, correlationId).AddCustomHeaders(securityAccounts)).ConfigureAwait(false);
	- (goes to)
- C:\Projects\Fleet.Services\MiX.Fleet.Services.Logic\Assets\AssetsManager.cs
	- UpdateExtendedAsync
	- +-887
```c#
if (existing.SiteId != asset.SiteId || existing.VinNumber != asset.VinNumber)
	await _deviceConfigRepository.UpdateConfigurationStatus(authToken, asset.AssetId, ConfigurationStatus.ConfigurationChanged).ConfigureAwait(false);
```
![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number Fleet code setting config status to Config Changed causing the imei to be greyed out.png]]

- VIN is in two places
	- AssetDetails page
	- Mobile device settings
- [ ] FIX
	- Should the Mobile Device Settings be set to AssetDetails VIN value?
	- Should above first check if this is a specific type before doing this?
	- NO, I think it should check the SOURCE of the VIN, only if from Mobile Device Settings, should it do something like "Configuration Changed"

## Message to Chad

Hi Chad, sorry for yet another question :-)

So working on QA-6035 (IMEI field greyed out after adding a VIN number), I looked through all our code related. Somewhere it was setting the configuration status to Configuration Changed, which causes this IMEI to be greyed out.
I couldn't find it anywhere in our code, however, I then had a look at the Fleet code and found that whenever the VIN number changes, the configuration status is set to "Configuration changed" which would explain the IMEI being greyed out.

I know the VIN is used in the Asset Details page and in this case the Mobile Device Settings page.
Not sure what this code should look like, or what the business logic should be, but the below seems to be the cause.
Could you please have a look.
(sorry for involving you in so many things, please let me know if I should ask someone else :-))

![[QA-6035 CalAmp - Imei field greyed out after adding a VIN number Chad Code input.png]]

