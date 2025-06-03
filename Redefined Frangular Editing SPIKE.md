---
created: 2025-06-03T09:20
updated: 2025-06-03T10:14
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
This drill down all the way to types, eg. Boolean (to handle the display of Boolean values). 
It also re-uses eg. parameters, conditions, properties. 
It furthermore re-uses higher up templates like: Peripherals, Parameters, Firmware, and CAN libraries
Finally it will reach the top level templates: Locations, Events and Mobile Devices.
These are found in (library, template, edit, asset edit)

**Note**: I mostly focussed on the ConfigAdmin/Templates directory.

## Potential way forward

I would suggest we start with the simplest Template. Herewith my proposed order:
- Locations
- Events
- Mobile Device

For each of these we need to create a main story with many sub-stories.
There is a LOT to do here.

I would suggest... if we start with Locations, that we work all the way down to the bottom "templates" mentioned earlier. Then rewrite those first, eg. Boolean Templates. 
We should then go up one level and see if it needs any eg. parameters, conditions, properties, then rewrite those.
After this we should go up another level and see if it needs any eg. Peripherals, Parameters, Firmware, and CAN libraries, then rewrite those.

## Important considerations











There is a lot to consider when working with the templates. There are shared templates, shared components, and some of these templates even reuse other templates.

The main areas to consider would be the above-mentioned 4. These might link with the library templates and will have shared templates.

We will have to break up the stories into small enough sections to handle, as there is a lot to do here, which will result in a lot of testing. Also, seeing that certain sections are shared, we will need to ensure that they all work well within all the templates that use them.





Okay, I'm working on refactoring AngularJS templates in the UI/Js/ConfigAdmin/Templates/ directory of my project. I've previously had some difficulty ensuring I've identified all relevant template files and understood their dependencies, especially nested or dynamically included ones.  
Could you please help me perform a deep scan and analysis?  
Here's what I need you to find and report on:  
1.  
List all HTML files: Recursively list all .html files located within the UI/Js/ConfigAdmin/Templates/ directory and any subdirectories it might contain (like CommsLog, Diagnostics). Include their full paths.  
2.  
Analyse each HTML file for dependencies: For every HTML file found in step 1, analyze its content and report the following:  
◦  
Static Includes: Identify all instances of <ng:include src="..."> or <ng-include src="...">. For each instance, list the src path value.  
◦  
Dynamic Includes: Identify patterns where templates are included dynamically, specifically looking for:  
▪  
ng:include="property.templateUrl" or ng-include="property.templateUrl"  
▪  
ng:include="controller.getCalibrationTemplate(...)" or ng-include="controller.getCalibrationTemplate(...)"  
▪  
Any other similar patterns where the ng:include source is bound to a variable or controller method.  
▪  
For dynamic includes, note the pattern and indicate that the specific template path needs to be determined by analyzing the corresponding JavaScript controller or service code where property.templateUrl or the getCalibrationTemplate method is defined and assigns the template URL.  
◦  
AngularJS Bindings: List common AngularJS bindings used (ng-model, dmx-validate, ng-change, ng-click) and, if possible from the template context, identify the controller variables or methods they appear to bind to (e.g., ng-model="form.name" suggests a form object in the controller).  
This helps map template usage to controller/service dependencies.  
◦  
Custom Directives: List any custom directives used (e.g., fleet-_, dmx-_, ui-*)  
.  
3.  
Cross-Directory Includes: Expand the search for <ng:include src="..."> patterns to the entire UI/Js/ directory. The goal here is to identify if any templates outside of ConfigAdmin/Templates/ are including templates from within ConfigAdmin/Templates/, or if any ConfigAdmin templates are including templates from other top-level areas (like Operations, JourneyManagement, etc.)  
. Report any such cross-directory includes.  
4.  
Related Components/Services: Based on the binding analysis in step 2, make a note of the types of JavaScript components (controllers, services, directives) that seem most heavily integrated with these templates.  
This reinforces the need to consider the JavaScript side during the rewrite.  
5.  
Report Structure: Present the findings clearly, perhaps starting with the list of all files, and then detailing the dependencies found for each file. Highlight any dynamic inclusions or dependencies that point outside the immediate template file.