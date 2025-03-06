---
Parent:: [[MIX_BE_MobileDeviceTemplateCrudModule]]
---

```json
{
  "Form": {
    "DoTacho": false,
    "SelectedPeripheralDevice": null,
    "LogicalDevices": [
      {
        "Id": "4999121101837382283",
        "IsEnabled": true,
        "CanEnableOrDisable": false,
        "ShowEnableDisableCheckBox": true,
        "DeviceName": "Firmware version",
        "PropertyValues": [
          {
            "Id": "4015466679217121645",          //<---------- LINK
            "Value": "",
            "ValueFormatType": 20,
            "DisplayUnits": ""
          }
        ],
        "CameraChannelData": null,
        "CameraNames": null,
        "CanChangeCameraNames": false,
        "Rows": null,
        "AddCameraName": null
      },
    ],
    "PropertyValues": null,
    "CalibratableParameters": [],
    "HyperMedia": {
      "Links": [
        {
          "ModifyData": false,
          "ExcludeBodyFromResponse": false,
          "Rel": "save",
          "Uri": "DynaMiX.API/config-admin/organisations/-5785682803802374635/mobile-device-template-settings/7307815284908181933",
          "Verb": "POST",
          "Params": {},
          "Host": null,
          "SuppressAuthentication": false
        }
      ],
      "Validations": {
        "FormName": "mobileDeviceTemplateForm",
        "ValidationRules": {
          "SelectedPeripheralDevice": [
            {
              "Attribute": "dmx-required",
              "Value": ""
            }
          ]
        },
        "HasMonitoredEvents": false
      }
    }
  },
  "Data": {
    "ViewOnly": false,
    "Name": "MiX4000",
    "TemplateName": null,
    "CanDisconnect": false,
    "CanDoTacho": false,
    "AllowedPeripheralDevices": null,
    "PropertyData": [],
    "PeripheralDevicePropertyData": {},
    "LogicalDeviceData": {
      "4999121101837382283": {
        "Id": "4999121101837382283",
        "PropertyData": [
          {
            "Id": "4015466679217121645",            //<---------- LINK
            "Name": "Preferred firmware version",
            "Description": "....",
            "MinValue": null,
            "MaxValue": null,
            "Increment": null,
            "IsRequired": false,
            "IsReadOnly": false,
            "IsUniqueGlobally": false,
            "IsUniquePerLibrary": false,
            "IsMobileUnitOnly": false,
            "IsValueTranslatable": false,
            "AllowedValues": [
              {
                "Id": "-5104899097280480869",
                "Title": "1.10.0"
              } //<---- MISSING
            ],
            "EmptyValue": "0",
            "ParentPropertyId": null
          }
        ],
        "ParentDevices": [
          {
            "ParentDeviceId": "6183256567829462590",
            "AutoEnable": true,
            "AutoConnect": true
          }
        ]
      },
    "DisableTacho": false,
    "IsSPLine": false
  }
}
```
