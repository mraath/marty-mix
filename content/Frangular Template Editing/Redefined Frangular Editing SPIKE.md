---
wiki_ingested: 2026-05-28
created: 2025-06-03T09:20
updated: 2025-06-05T09:32
---
## Introduction

The 4 links of interest to this spike:
    1) Asset Description
    2) Mobile Device Template
    3) Event Template
    4) Location Template

![[Untitled.png]]

In order to rewrite the editing Templates into the new Frangular way, there is a lot to consider.
Although in the screenshot above we see 4 distinct templates, in reality there are a lot more.

## Initial findings

We have the top level templates:
- Location
- Events
- Mobile Devices

Each of these are available in:
- Libraries
- Templates
- Editing Templates
- Asset Templates

All of these templates also include other templates being used. 
This drill down all the way to types / components, eg. Boolean (to handle the display of Boolean values). 
It also re-uses eg. parameters, conditions, properties. 
It furthermore re-uses higher up templates like: Peripherals, Parameters, Firmware, and CAN libraries
Finally it will reach the top level templates: Locations, Events and Mobile Devices.
These are found in (library, template, edit, asset edit)

> [!Important] Please note:
> I mostly focussed on the **ConfigAdmin/Templates** directory.
> In order to find dependencies this search was used mostly: **ng:include** / ng-include

## Potential way forward

I would suggest we start with the simplest Template. Herewith my proposed order:
- Locations
- Events
- Mobile Device

For each of these we need to create a main story with many sub-stories.
There is a LOT to do here.

I would suggest... if we start with Locations, that we work all the way down to the bottom "components" mentioned earlier. Then rewrite those first, eg. Boolean Templates. 
We should then go up one level and see if it needs any eg. parameters, conditions, properties, then rewrite those.
After this we should go up another level and see if it needs any eg. Peripherals, Parameters, Firmware, and CAN libraries, then rewrite those.

There are also potential Validation to consider to be re-written.

The testing would be huge, seeing so many of these components are shares and we need to ensure it works everywhere.
Further more Justus already did some work on CAN.

## Important considerations

- Dynamic Calibration Templates: Templates dynamically included via **controller.getCalibrationTemplate**(parameter). They are included in: MobileDeviceTemplatePeripheralTemplate.html, AssetMobileDevicePeripheralEditTemplate.html
- Dynamic Property Templates: Templates dynamically included via **property.templateUrl**. They render specific input controls for parameters. Included by: LogicalDeviceSettingsTemplate.html, LogicalCameraDeviceSettings.html
- Certain templates are being reused a LOT: MobileDeviceTemplatePeripheralTemplate.html, AssetMobileDevicePeripheralEditTemplate.html
- Also, the user can click on Lines to do Connections. There will also need more work.

## Attempted diagram (might have missed some dynamic templates)

![[Frangular Editing Templates Diagram.excalidraw.png]]


## Summary

I have a few more Mermaid charts that COULD be helpful when we finally start with this.
I would definitely break it up into the main 3 template types.
Working from the bottom up could be a good idea.
Justus could be helpful, for the work he has already done on 

