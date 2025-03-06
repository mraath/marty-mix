---
status: closed
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2023-11-20T20:31
---

# QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one

Date: 2023-11-17 Time: 08:18
Parent:: ==xxxx==
Friend:: [[2023-11-17]]
JIRA:QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one
[QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-6193)

## Lesson

- This is by design. When the devices share the logical it allows you to set the value once on the library level but it can be set independently on templates.

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



## Investigation

I just testes this for eg. MiX6000 and MiX6000 LTE, it does the same
![[QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one Same for 6K and 6KLTE.png]]
- It also happens on the MiX4000
- Data 6000
	- GET: https://integration.mixtelematics.com/DynaMiX.API/config-admin/-1983255592473789111/modile_device_types/-7681409220681262334
{
    "Data": {
        "Id": "-7681409220681262334",
        "LibraryMobileDeviceId": "6280832013296781761",
        "Name": "MiX6000",
        "PropertyData": [],
        "LogicalDeviceData": {
            "2661058860026395155": {
                "Id": "2661058860026395155",
                "PropertyData": [
                    {
                        "Id": "1508651406423902247",
                        "Name": "Arming delay",
                        "Description": "Duration the vehicle should be standing with the ignition and engine off before a trip will be considered complete.",
                        "MinValue": 3.000000000,
                        "MaxValue": 600.000000000,
                        "Increment": 1.000000000,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "8979802813014332919",
                        "Name": "Standing delay",
                        "Description": "Duration the vehicle should be stationary before the next movement starts a new sub-trip.",
                        "MinValue": 3.000000000,
                        "MaxValue": 1800.000000000,
                        "Increment": 1.000000000,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-5344935385812294901",
                        "Name": "The start of a trip will be recorded when Speed or Revs are detected OR",
                        "Description": "A trip is started when Speed or Engine Revs or selected ignition state.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [
                            {
                                "Id": "0",
                                "Title": "A driver is identified and the ignition is turned on"
                            },
                            {
                                "Id": "1",
                                "Title": "As soon as the ignition is turned on even if no driver has been identified"
                            }
                        ],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-2475046500834127373",
                        "Name": "Only disarm the immobiliser relay while a valid driver code plug is in the socket or identification card is in the card reader",
                        "Description": "Immobilise the mobile device when a valid driver plug or card is not detected. This could cause the asset to stop if identification removed during a trip depending on how the immobiliser connected.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "7136723115333608633",
                        "Name": "Ignition wired",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    }
                ],
                "ParentDevices": []
            },
            "7031964624791253468": {
                "Id": "7031964624791253468",
                "PropertyData": [],
                "ParentDevices": []
            },
            "-7820597904635727713": {
                "Id": "-7820597904635727713",
                "PropertyData": [],
                "ParentDevices": []
            },
            "-3995196683189720759": {
                "Id": "-3995196683189720759",
                "PropertyData": [
                    {
                        "Id": "-5927860527781082616",
                        "Name": "Enable progressive shut down OTA",
                        "Description": "Enable progressive shut down Over The Air (OTA). This requires the Relay drive to be connected correctly to stop the asset's engine.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    }
                ],
                "ParentDevices": []
            },
            "-3519111760369312923": {
                "Id": "-3519111760369312923",
                "PropertyData": [
                    {
                        "Id": "-3481298004341248209",
                        "Name": "Lift off Detection Sensitivity",
                        "Description": "Lift off Detection Sensitivity",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "5388982636505504846",
                        "Name": "Impact Detection Sensitivity",
                        "Description": "Impact Detection Sensitivity",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-6766525515324849066",
                        "Name": "Road Roughness Detection Sensitivity",
                        "Description": "Road roughness detection sensitivity",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "8111357347728818643",
                        "Name": "Pitch And Roll Detection Sensitivity",
                        "Description": "Pitch and Roll Detection Sensitivity",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "",
                        "ParentPropertyId": null
                    }
                ],
                "ParentDevices": []
            },
            "7282441175981548584": {
                "Id": "7282441175981548584",
                "PropertyData": [],
                "ParentDevices": []
            },
            "9156217035291766525": {
                "Id": "9156217035291766525",
                "PropertyData": [
                    {
                        "Id": "-4492868516500592703",
                        "Name": "Record engine hours:",
                        "Description": "Specifies if both ignition on, and engine revs are required to record engine hours.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [
                            {
                                "Id": "1",
                                "Title": "Ignition on AND engine revs"
                            },
                            {
                                "Id": "0",
                                "Title": "Ignition on OR engine revs"
                            }
                        ],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    }
                ],
                "ParentDevices": []
            },
            "-5215845406465777006": {
                "Id": "-5215845406465777006",
                "PropertyData": [
                    {
                        "Id": "-3560624981974086174",
                        "Name": "When the ignition is turned on:",
                        "Description": "Specify how long the unit should beep to request Driver Id if not identified when ignition is turned on.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [
                            {
                                "Id": "0",
                                "Title": "Do not sound the buzzer"
                            },
                            {
                                "Id": "3",
                                "Title": "Sound the buzzer for 10 seconds only"
                            },
                            {
                                "Id": "1",
                                "Title": "Sound the buzzer until the driver is identified"
                            }
                        ],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-2030131949647844098",
                        "Name": "Buzzer frequency",
                        "Description": "The frequency the buzzer will sound at.",
                        "MinValue": 1000.000000000,
                        "MaxValue": 8000.000000000,
                        "Increment": 100.000000000,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "2147375478367590898",
                        "Name": "Buzzer volume",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [
                            {
                                "Id": "1",
                                "Title": "20%"
                            },
                            {
                                "Id": "2",
                                "Title": "40%"
                            },
                            {
                                "Id": "3",
                                "Title": "60%"
                            },
                            {
                                "Id": "4",
                                "Title": "80%"
                            },
                            {
                                "Id": "5",
                                "Title": "Full Volume"
                            },
                            {
                                "Id": "0",
                                "Title": "Off"
                            }
                        ],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    }
                ],
                "ParentDevices": []
            },
            "1618831221688219249": {
                "Id": "1618831221688219249",
                "PropertyData": [
                    {
                        "Id": "2303581812880699834",
                        "Name": "Send AVL in trip frequency",
                        "Description": "Minimum frequency at which to send Automatic Vehicle Location (AVL) packets while mobile device is recording a trip.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-6008442899517614778",
                        "Name": "Send AVL in trip if heading changes by more than",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-2082315608032776800",
                        "Name": "Send AVL in trip if distance covered is more than",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "3952806317936118051",
                        "Name": "Send AVL out of trip",
                        "Description": "Specifies whether to send Automatic Vehicle Location (AVL) packets when not in trip mode.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "3656428653267292008",
                        "Name": "Send AVL out of trip frequency",
                        "Description": "Minimum frequency at which to send Automatic Vehicle Location (AVL) packets when not in trip mode.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": "3952806317936118051"
                    }
                ],
                "ParentDevices": []
            },
            "898881372534391990": {
                "Id": "898881372534391990",
                "PropertyData": [
                    {
                        "Id": "-4645894425392195380",
                        "Name": "Turn mobile device off when battery voltage falls below",
                        "Description": "When the voltage drops below the specified value, the unit will start a 15 minute timer before switching off.  If the unit is still in trip when the time expires, it will wait until it has come out of trip before turning the unit off.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-8685861324706274058",
                        "Name": "Automatic shutdown of mobile device",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-3801771936091074438",
                        "Name": "- Turn mobile device off when asset is parked for more than",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": "-8685861324706274058"
                    }
                ],
                "ParentDevices": []
            },
            "2677889019027395017": {
                "Id": "2677889019027395017",
                "PropertyData": [
                    {
                        "Id": "8266709798085597103",
                        "Name": "Automatic shutdown of peripheral devices",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-8336152798953249770",
                        "Name": "- Turn peripheral devices off when asset is parked for more than",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": "8266709798085597103"
                    },
                    {
                        "Id": "6279620892998879824",
                        "Name": "After waking up, leave peripheral devices on for",
                        "Description": "Duration to leave peripheral devices powered after surfacing",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "1693052817843468367",
                        "Name": "Surfacing",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-9119495101607490850",
                        "Name": "- Switch peripheral devices on every",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": "1693052817843468367"
                    },
                    {
                        "Id": "-1173326505406020345",
                        "Name": "- Limit number of times to surface",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": "1693052817843468367"
                    },
                    {
                        "Id": "-9118181039314512717",
                        "Name": "-- Only surface a maximum of",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": "-1173326505406020345"
                    }
                ],
                "ParentDevices": []
            },
            "5877065296627456209": {
                "Id": "5877065296627456209",
                "PropertyData": [
                    {
                        "Id": "-4936028342195377168",
                        "Name": "Region",
                        "Description": "Region in which assets operate in. This will ensure that the correct baud rate is applied.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [
                            {
                                "Id": "0",
                                "Title": "Americas (excluding Brazil)"
                            },
                            {
                                "Id": "2",
                                "Title": "Rest of world (including Brazil)"
                            },
                            {
                                "Id": "1",
                                "Title": "South Africa"
                            }
                        ],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    }
                ],
                "ParentDevices": []
            },
            "295760960565509331": {
                "Id": "295760960565509331",
                "PropertyData": [],
                "ParentDevices": []
            },
            "2367844559655421507": {
                "Id": "2367844559655421507",
                "PropertyData": [
                    {
                        "Id": "-3841853637330271693",
                        "Name": "Driver ID range from:",
                        "Description": "Driver keys within this ID range will put the asset into private mode when inserted",
                        "MinValue": -32768.000000000,
                        "MaxValue": 32767.000000000,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": true,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-5211601870276674553",
                        "Name": "Driver ID range to:",
                        "Description": null,
                        "MinValue": -32768.000000000,
                        "MaxValue": 32767.000000000,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": true,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    }
                ],
                "ParentDevices": []
            }
        }
    },
    "Form": {
        "PropertyValues": [],
        "LogicalDevices": [
            {
                "Id": "2661058860026395155",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Base mobile device feature set",
                "PropertyValues": [
                    {
                        "Id": "1508651406423902247",
                        "Value": "300",
                        "ValueFormatType": 29,
                        "DisplayUnits": "seconds"
                    },
                    {
                        "Id": "8979802813014332919",
                        "Value": "120",
                        "ValueFormatType": 29,
                        "DisplayUnits": "seconds"
                    },
                    {
                        "Id": "-5344935385812294901",
                        "Value": "0",
                        "ValueFormatType": 20,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-2475046500834127373",
                        "Value": "0",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "7136723115333608633",
                        "Value": "1",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "7031964624791253468",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Firmware version",
                "PropertyValues": [],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "-7820597904635727713",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Location speed monitoring",
                "PropertyValues": [],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "-3995196683189720759",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Command interpreter",
                "PropertyValues": [
                    {
                        "Id": "-5927860527781082616",
                        "Value": "0",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "-3519111760369312923",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Three Axis Accelerometer",
                "PropertyValues": [
                    {
                        "Id": "-3481298004341248209",
                        "Value": "50",
                        "ValueFormatType": 18,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "5388982636505504846",
                        "Value": "50",
                        "ValueFormatType": 18,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-6766525515324849066",
                        "Value": "50",
                        "ValueFormatType": 18,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "8111357347728818643",
                        "Value": "50",
                        "ValueFormatType": 18,
                        "DisplayUnits": null
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "7282441175981548584",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Require Company ID on driver plug",
                "PropertyValues": [],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "9156217035291766525",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Engine hours",
                "PropertyValues": [
                    {
                        "Id": "-4492868516500592703",
                        "Value": "0",
                        "ValueFormatType": 20,
                        "DisplayUnits": null
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "-5215845406465777006",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Buzzer",
                "PropertyValues": [
                    {
                        "Id": "-3560624981974086174",
                        "Value": "3",
                        "ValueFormatType": 20,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-2030131949647844098",
                        "Value": "4000",
                        "ValueFormatType": 16,
                        "DisplayUnits": "Hz"
                    },
                    {
                        "Id": "2147375478367590898",
                        "Value": "5",
                        "ValueFormatType": 20,
                        "DisplayUnits": null
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "1618831221688219249",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Send AVLs",
                "PropertyValues": [
                    {
                        "Id": "2303581812880699834",
                        "Value": "37",
                        "ValueFormatType": 3,
                        "DisplayUnits": "seconds"
                    },
                    {
                        "Id": "-6008442899517614778",
                        "Value": "10",
                        "ValueFormatType": 16,
                        "DisplayUnits": "°"
                    },
                    {
                        "Id": "-2082315608032776800",
                        "Value": "1000",
                        "ValueFormatType": 202,
                        "DisplayUnits": "m"
                    },
                    {
                        "Id": "3952806317936118051",
                        "Value": "0",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "3656428653267292008",
                        "Value": "3600",
                        "ValueFormatType": 3,
                        "DisplayUnits": "seconds"
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "898881372534391990",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Unit power management",
                "PropertyValues": [
                    {
                        "Id": "-4645894425392195380",
                        "Value": "11500",
                        "ValueFormatType": 16,
                        "DisplayUnits": "mV"
                    },
                    {
                        "Id": "-8685861324706274058",
                        "Value": "1",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-3801771936091074438",
                        "Value": "259200",
                        "ValueFormatType": 3,
                        "DisplayUnits": "seconds"
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "2677889019027395017",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Peripheral power management",
                "PropertyValues": [
                    {
                        "Id": "8266709798085597103",
                        "Value": "1",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-8336152798953249770",
                        "Value": "64800",
                        "ValueFormatType": 3,
                        "DisplayUnits": "seconds"
                    },
                    {
                        "Id": "6279620892998879824",
                        "Value": "900",
                        "ValueFormatType": 3,
                        "DisplayUnits": "seconds"
                    },
                    {
                        "Id": "1693052817843468367",
                        "Value": "1",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-9119495101607490850",
                        "Value": "14400",
                        "ValueFormatType": 3,
                        "DisplayUnits": "seconds"
                    },
                    {
                        "Id": "-1173326505406020345",
                        "Value": "1",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-9118181039314512717",
                        "Value": "10",
                        "ValueFormatType": 16,
                        "DisplayUnits": "times"
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "5877065296627456209",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Magix",
                "PropertyValues": [
                    {
                        "Id": "-4936028342195377168",
                        "Value": "",
                        "ValueFormatType": 20,
                        "DisplayUnits": null
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "295760960565509331",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "GSM jamming detection",
                "PropertyValues": [],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "2367844559655421507",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Private mode plug",
                "PropertyValues": [
                    {
                        "Id": "-3841853637330271693",
                        "Value": "0",
                        "ValueFormatType": 33,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-5211601870276674553",
                        "Value": "0",
                        "ValueFormatType": 33,
                        "DisplayUnits": null
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            }
        ],
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/config-admin/-1983255592473789111/modile_device_types/-7681409220681262334",
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
    }
}

- After seeing the above I quickly compared the MiX6000 to the Calamp. They have different values, if the same property is linked to a different logical device for that mobile unit. If however the mobile units share a logical device, then the property value is always the same.
![[QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one Explaining when they are the same.png]]

- [[SQL QA-6193 Devices with Logicals and Properties that share values]]
- 
## Image learned from this issue

ADD IMAGE

## Move what you learned into the bigger picture

ADD IMAGE

## Shorter Summary



## Description

Database name: Calamp3  
orgId=9176829199651808262  
  
Replication steps:

-Navigate to Manage>Config Group Libraries  
Select either Calamp Lite or Calamp Premium  
Edit any of the below settings on one device template and notice that the changes applied are also on the other device template.

![[QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one.png]]

Wording also incorrect see below screenshot when saving changes “FM range…” we are editing Calamp units and not FM

![[QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one Wrong Wording.png]]

Premium: https://integration.mixtelematics.com/#/config-admin/mobile-devices/edit?id=878914713632096376
Lite: https://integration.mixtelematics.com/#/config-admin/mobile-devices/edit?id=444495132628514264

Values on both before changing
Send AVLs: 0:2:0
Unit power management: 4:0:0

Values on both after changing
Logicals
	"Id": "3364864933379765396",
		"IsEnabled": true,
		"CanEnableOrDisable": false,
		"ShowEnableDisableCheckBox": false,
		"DeviceName": "Send AVLs",
		"PropertyValues"
				"Id": "-5245223235251311592",
				"Value": "133",
				"ValueFormatType": 3,
				"DisplayUnits": "seconds"
	"Id": "3961414075318095609",
		"IsEnabled": true,
		"CanEnableOrDisable": false,
		"ShowEnableDisableCheckBox": false,
		"DeviceName": "Unit power management",
			Property
				"Id": "-3801771936091074438",
				"Value": "14416",
				"ValueFormatType": 3,
				"DisplayUnits": "seconds"



### Changing Premium

PUT: https://integration.mixtelematics.com/DynaMiX.API/config-admin/-1983255592473789111/modile_device_types/878914713632096376
![[QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one Get from other devices Values changed.png|265]]

- Lite: Get: https://integration.mixtelematics.com/DynaMiX.API/config-admin/-1983255592473789111/modile_device_types/444495132628514264
![[QA-6193 QA - Trimble Lite and Calamp avl and unit power changes applies to both templates when editing one Get from other devices Values changed.png]]


## Comparing Data

- Lite: GET: https://integration.mixtelematics.com/DynaMiX.API/config-admin/-1983255592473789111/modile_device_types/444495132628514264
{
    "Data": {
        "Id": "444495132628514264",
        "LibraryMobileDeviceId": "-955843431424727002",
        "Name": "CalAmp Lite",
        "PropertyData": [],
        "LogicalDeviceData": {
            "3364864933379765396": {
                "Id": "3364864933379765396",
                "PropertyData": [
                    {
                        "Id": "-2304440007775417086",
                        "Name": "Send AVL In trip",
                        "Description": "Specifies whether to send Automatic Vehicle Location(AVL) packets while in trip mode.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-5245223235251311592",
                        "Name": "- Send AVL In trip frequency",
                        "Description": "Minimum frequency to send data packet while mobile device recording a trip.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": "-2304440007775417086"
                    }
                ],
                "ParentDevices": []
            },
            "9156217035291766525": {
                "Id": "9156217035291766525",
                "PropertyData": [
                    {
                        "Id": "-4492868516500592703",
                        "Name": "Record engine hours:",
                        "Description": "Specifies if both ignition on, and engine revs are required to record engine hours.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [
                            {
                                "Id": "1",
                                "Title": "Ignition on AND engine revs"
                            },
                            {
                                "Id": "0",
                                "Title": "Ignition on OR engine revs"
                            }
                        ],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    }
                ],
                "ParentDevices": []
            },
            "3961414075318095609": {
                "Id": "3961414075318095609",
                "PropertyData": [
                    {
                        "Id": "-4645894425392195380",
                        "Name": "Turn mobile device off when battery voltage falls below",
                        "Description": "When the voltage drops below the specified value, the unit will start a 15 minute timer before switching off.  If the unit is still in trip when the time expires, it will wait until it has come out of trip before turning the unit off.",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-8685861324706274058",
                        "Name": "Automatic shutdown of mobile device",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": null
                    },
                    {
                        "Id": "-3801771936091074438",
                        "Name": "- Turn mobile device off when asset is parked for more than",
                        "Description": "",
                        "MinValue": null,
                        "MaxValue": null,
                        "Increment": null,
                        "IsRequired": false,
                        "IsReadOnly": false,
                        "IsUniqueGlobally": false,
                        "IsUniquePerLibrary": false,
                        "IsMobileUnitOnly": false,
                        "IsValueTranslatable": true,
                        "AllowedValues": [],
                        "EmptyValue": "0",
                        "ParentPropertyId": "-8685861324706274058"
                    }
                ],
                "ParentDevices": []
            }
        }
    },
    "Form": {
        "PropertyValues": [],
        "LogicalDevices": [
            {
                "Id": "3364864933379765396",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Send AVLs",
                "PropertyValues": [
                    {
                        "Id": "-2304440007775417086",
                        "Value": "1",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-5245223235251311592",
                        "Value": "133",
                        "ValueFormatType": 3,
                        "DisplayUnits": "seconds"
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "9156217035291766525",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Engine hours",
                "PropertyValues": [
                    {
                        "Id": "-4492868516500592703",
                        "Value": "0",
                        "ValueFormatType": 20,
                        "DisplayUnits": null
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            },
            {
                "Id": "3961414075318095609",
                "IsEnabled": true,
                "CanEnableOrDisable": false,
                "ShowEnableDisableCheckBox": false,
                "DeviceName": "Unit power management",
                "PropertyValues": [
                    {
                        "Id": "-4645894425392195380",
                        "Value": "11800",
                        "ValueFormatType": 16,
                        "DisplayUnits": "mV"
                    },
                    {
                        "Id": "-8685861324706274058",
                        "Value": "1",
                        "ValueFormatType": 1,
                        "DisplayUnits": null
                    },
                    {
                        "Id": "-3801771936091074438",
                        "Value": "14416",
                        "ValueFormatType": 3,
                        "DisplayUnits": "seconds"
                    }
                ],
                "CameraChannelData": [],
                "CameraNames": [],
                "CanChangeCameraNames": false,
                "Rows": [],
                "AddCameraName": {
                    "Id": null,
                    "Description": null,
                    "Actions": [],
                    "IsEditable": false,
                    "HyperMedia": {
                        "Links": [],
                        "Validations": {
                            "FormName": null,
                            "ValidationRules": {},
                            "HasMonitoredEvents": false
                        }
                    }
                }
            }
        ],
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/config-admin/-1983255592473789111/modile_device_types/444495132628514264",
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
    }
}

## SQL

```sql
USE Deviceconfiguration;

-- Follow the money - get those values
-- Only one for each value, so this already shows that both CalAmps point to the same values, else we would see two for each
SELECT * FROM library.DeviceProperties WHERE value IN ('133', '14416')

-- Get the definition values
-- They were the base values expected
SELECT * FROM definition.Devices where DeviceKey IN (27245,27244)
SELECT * FROM definition.Properties WHERE PropertyKey IN (487,164)

-- Let's see whats in the libraries
-- Only the two devices - that is fine
-- Only two properties with values, surely each device should save its own properties
--  In this case each device saved one property :-)
SELECT * FROM library.Devices where DeviceKey IN (27245,27244) AND LibraryKey = 2715
SELECT * FROM library.DeviceProperties WHERE PropertyKey IN (487,164) AND LibraryKey = 2715 AND DeviceKey IN (27245,27244)

-- NEXT, find out how the library linked up the same DeviceProperty for both these devices
-- Must be set up wrong are read wrong
/*
OK maar wag - ek sien nou daai twee properties behoort wel aan daai twee devices... want die devices na wie hul verwys is die logicals wat jy ook noem:
System.Logical.CalAmpAVLs
System.Logical.CalAmp.UnitPowerManagement

OK - so my verwagting sal dan wees dat elke ACTUAL device, eg. Calamp LITE + PREMIUM sy eie properties moet stoor... dis wat ek volgende sou investigate

--SELECT TOP 10 * FROM definition.Devices WHERE systemName like '%Calamp%'
--Lite, Premium
-- 27176, 27085

SELECT * FROM library.DeviceProperties WHERE LibraryKey = 2715 AND DeviceKey IN (27176, 27085)
-- AND PropertyKey IN (487,164)

--They don't have their own properties... WHAT?
-- OK - I'm going on weekend now :P
*/

```
## Ideas

- [x] Duplicate on INT ✅ 2023-11-20
- [x] Check DB, Logs ✅ 2023-11-20

## SR Meeting Notes


## Useful Comments from Jira


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing



## Follow the code path

### Log


### Data


### Code


## Final Findings for Jira

- 
