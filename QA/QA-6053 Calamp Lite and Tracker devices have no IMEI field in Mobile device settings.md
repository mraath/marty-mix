---
status: busy
date: 2023-09-18
comment: 
priority: 1
---

# QA-6053 Calamp Lite and Tracker devices have no IMEI field in Mobile device settings

Date: 2023-09-18 Time: 15:19
Parent:: [[Calamp]]
Friend:: [[2023-09-18]]
JIRA:QA-6053 Calamp Lite and Tracker devices have no IMEI field in Mobile device settings
[QA-6053 QA - Calamp - Lite and Tracker devices affected - Imei field does not exist - not able to add imei - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-6053)

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


## Testing notes

- Zonika will live drop api
- Marthinus to test the flow of things
- [ ] Lite
- [ ] Tracker

## Description

- ADD
	- C:\Projects\Fleet.Services.FleetAdmin.API\Fleet.Services.FleetAdmin.API\Constants\ApiControllerRoutes.cs
		- AddAssetDetailAsync
		- FleetServicesDataClient.Assets.AddWithSiteIdAvailabilityExtendedAsync
		- AddWithSiteIdAvailabilityExtendedAsync
		- InsertWithSiteIdAvailabilityExtended
		- AddExtendedAsync
		- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs
			- AddExtendedAsync
			- UpdateAssetConfigGroup
			- CanAutoCommissionAssetsIntoConfigGroup
			- 
- GET: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040
	- 
- ng-disabled="assetConfigSummary.isMobilePhone || !changeMobileDeviceTemplate.identifierTitle || !form.hasDeviceTypeIdentifier || form.hasBeenCommissioned || assetConfigSummary.isTDI || assetConfigSummary.isScaniaOem"
```json
{
    "Form": {
        "AssetName": "Default mobile device template for CalAmp Tracker",
        "HasBeenCommissioned": true,
        "DeviceTypeName": "CalAmp Tracker",
        "MobileDeviceId": "3034920122348823316",
        "HasDeviceTypeIdentifier": true,
        "DeviceTypeIdentifierTitle": "Unique identifier",
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
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "updateTabs",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/tabs",
                    "Verb": "GET",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "sendCommissioningRequest",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/send-obc-commissioning-request",
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
        "ConfigGroupId": "1442786046695754077",
        "MobileNumber": null,
        "IsMobilePhone": false,
        "IsStreamax": false,
        "WasMobilePhone": false,
        "WasStreamax": false,
        "WasStreamaxPeripheral": false,
        "IsFM": false,
        "IdentifierTitle": "Unique identifier",
        "Devices": [
            {
                "DeviceTypeId": "444495132628514264",
                "Name": "CalAmp Lite",
                "IdentifierTitle": "Unique identifier",
                "IsBeacon": false,
                "IsMobilePhone": false,
                "IsStreamax": false,
                "IsFM": false,
                "IsStreamaxStandAlone": false,
                "IsUniqueIdentifierVIN": false
            },
            {
                "DeviceTypeId": "878914713632096376",
                "Name": "CalAmp Premium",
                "IdentifierTitle": "Unique identifier",
                "IsBeacon": false,
                "IsMobilePhone": false,
                "IsStreamax": false,
                "IsFM": false,
                "IsStreamaxStandAlone": false,
                "IsUniqueIdentifierVIN": false
            },
            {
                "DeviceTypeId": "3034920122348823316",
                "Name": "CalAmp Tracker",
                "IdentifierTitle": "Unique identifier",
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
                "ConfigGroupId": "-4868412667112573861",
                "Name": "Default configuration group for CalAmp Lite",
                "DeviceTypeId": "444495132628514264"
            },
            {
                "ConfigGroupId": "-3859349747606875553",
                "Name": "Default configuration group for CalAmp Premium",
                "DeviceTypeId": "878914713632096376"
            },
            {
                "ConfigGroupId": "1442786046695754077",
                "Name": "Default configuration group for CalAmp Tracker",
                "DeviceTypeId": "3034920122348823316"
            }
        ],
        "HyperMedia": {
            "Links": [
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "save",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/change-mobile-device",
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
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/remove-mobile-device",
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
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/change-satellite-modem",
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
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/change-streamax-device",
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
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/remove-satellite-modem",
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
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/remove-moblie-phone",
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
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/compile_and_upload",
                    "Verb": "PUT",
                    "Params": {},
                    "Host": null,
                    "SuppressAuthentication": false
                },
                {
                    "ModifyData": false,
                    "ExcludeBodyFromResponse": false,
                    "Rel": "uploadConfig",
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/upload",
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
                    "Uri": "DynaMiX.API/fleet-admin/assets/commissioning/1085003241271469083/1440396199977431040/remove-streamax-serial-no",
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