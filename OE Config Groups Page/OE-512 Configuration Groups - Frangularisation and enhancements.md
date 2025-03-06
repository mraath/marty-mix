---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-02-29T08:32
---

# OE-512 Configuration Groups - Frangularisation and enhancements

Date: 2024-02-29 Time: 08:20
Parent:: [[Configuration Groups]]
Friend:: [[2024-02-29]]
JIRA:OE-512 Configuration Groups - Frangularisation and enhancements
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-512)

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

## Image Summary

ADD IMAGE

## Description

### OVERVIEW

We need to upgrade the angular version on the Configuration groups page

As part of this process we will also be refreshing the user interface and adding additional features such as the ability to multi-select configuration groups etc

The drag and drop asset to config group feautre is no longer supported and will be catered for in a different way

All other functionality will remain as is and is simply being improved upon

### HIGH-LEVEL REQUIREMENTS

Create a new Configuration groups page called “Configuration groups (Beta)”

This will be the new page and Beta will be removed once develolment is complete

The page is still only accessible on an organisation level and all permissions remain as is

The page loads with a 50/50 splt screen with Configuration groups on the left and Assets on the right

Users are able to fully collapse either by clicking the arrows in the middle bar as well as resize using the elipsis icon

### CONFIGURATION GROUPS

Header in bold: Configuration groups

To the right of this is a count of all the configuration groups in the org

To the right of this is an actions dropdown which only becomes available once the user has selected a configuration group

### Add Configuration Group

To the right of this is the green add icon

Tooltip: Add configuration group

When this is selected then display the Add config group modal as per usual

Below this is a filter called: Filter by Mobile device

### Filter by Mobile device

When this is selected display the list of available mobile devices

The user can select more than one

Once selected filter the configuration groups based on the selected filter

Below this is a free text filter box

### Free text filter

Users should be able to enter 255 characters

Search on all cells

Below this is the list of configuration groups

### Columns

Select all checkbox

Alerts icon - display error count - see below for details

Flagged assets icon - Nr of assets flagged within config group

Name - Configuration group name

Asset count - Nr of assets assigned to config group

Mobile device - Mobile device associated to config group

Mobile device template - Mobile device template linked to config group - green hyperlink that opens the template

Event template - Event template linked to config group - green hyperlink that opens the template

Location template - Location template linked to config group - green hyperlink that opens the template

FW version - Preferred FW version configured on Mobile device connected to the Mobile device template

CAN script - CAN script connected to Mobile device template (if 2 connected then display names belo each other) - green hyperlink that opens CAN script

Speed - Speed source connected to Mobile device template such as Speed sender, J1708 CAN Speed, GPS velocity as speed

RPM - RPM source connected to Mobile device template such as RPM signal or J1708 CAN RPM

Fuel - Fuel source connected to Mobile device template such as EDM fuel flow meter or J1708 CAN Fuel

SP - shows whether Streamax connected or not. Configured on Mobile device template

HOS - Shows wheter DTCO or BYOD/ELD is in use. Configured on the Mobile device template

Users are able to select all, multi-select or select a single config group at a time

When a group is selected then enable the Actions dropdown list at the top of the page

### Actions

#### Compile:

Compile all assets in selected config groups that are in a configuration changed status

When selecting “Compile” open a config compile and upload modal:

Green header: Compile and upload configuration

Text: Select when to upload configuration to x (amount) configuration groups once the compile has successfully completed

Below are 2 radio buttons

Immediately (via default transport)

Not now (compiled configuration saved to database)

In the bottom right corner is a grey Cancel and green Submit button

When the user says cancel then don’t proceed with the compile or upload

If the user selects Immediately or not now and selects submit then submit the request and display a green toast message once the modal is closed that says “Request submitted successfully

#### Upload

Upload to all assets in selected config groups that are in a Ready for upload status

When selecting “Upload” open the Upload configuration modal

Green header: Upload configuration

Text: Select when to upload configuration to x (amount) configuration groups

Below are 2 radio buttons

Immediately (via default transport)

Not now (compiled configuration saved to database)

In the bottom right corner is a grey Cancel and green Submit button

When the user says cancel then close the modal

If the user selects Immediately or not now and selects submit then submit the request and display a green toast message once the modal is closed that says “Upload request submitted successfully

#### Upload FW

Upload FW to all assets in selected config groups that are not running the selected preferred FW version (ensure you ignore assets that are on the version and don’t reload)

When selecting “Upload FW” open the Upload FW modal

Green header: Upload firmware

Text: Are you sure you want to upload Firmware to x config groups?

In the bottom right corner is a grey Cancel and green Upload button

When the user sleects cancel then close the modal and don’t submit anything

When the user selects Upload then queue the upload

Close the modal and display a green toast message on screen that states: Firmware upload request succesful

#### Reset flag

Reset flag for multi-selected config groups will be done at a later stage

We will however have it available on the Assets screen

### Alerts logic:

We’ll start with 4 alert states and add more in future

Assets in config Upload requested state for more than 5 days

Assets in FW upload requested state for more than 3 days

Preferred FW version that is older than 2 releases back

Assets that have events with a status of “Events not monitored - missing parameters”

The alerts column should display the number of alerts for the config group (so max 4 at the moment)

The alert count should be a clickable link

Green header Alerts

Below this display each alert and the asset count associated to the alert

Alert Asset count

Configuration upload request expired 5

FW upload request expired 5

Preferred FW version not supported 5

Event not monitored - missing parameters 1

In the bottom right corner is a green Close button

### ASSETS

Header: Assets

To the right of this is an asset count

At the end of the header row is an export button which allows a user to export the config details

As the user selects config groups on the left panel it should load the assets in order on the Assets screen

### Filter by Config status

When this is selected display the list of available configuration statuses

The user can select more than one

Once selected filter the configuration groups based on the selected filter

### Filter by FW version

When this is selected display the list of available FW versions (MESA only)

The user can select more than one

Once selected filter the configuration groups based on the selected filter

Below this is a free text filter box

### Free text filter

Users should be able to enter 255 characters

Search on all cells

Below this is the list of configuration groups

### Columns

Select all checkbox

Alerts icon - display alert count for each asset

Flagged assets icon - Nr of assets flagged within config group

Asset ID

Asset description - clickable link to navigate to asset level config

Registration - Asset registration

Site

Fleet number

Last position - if possible the last position. Only needs to be updated when the page is refreshed?

IMEI

Serial number

Mobile device - Mobile device associated to config group

Config compile status

Config compile status time

Configuration status

Configuration status time

Comms log

Configuration group name

Mobile device template - Mobile device template linked to config group - green hyperlink that opens the template

Event template - Event template linked to config group - green hyperlink that opens the template

Location template - Location template linked to config group - green hyperlink that opens the template

FW version - Preferred FW version configured on Mobile device connected to the Mobile device template

CAN script - CAN script connected to Mobile device template (if 2 connected then display names belo each other) - green hyperlink that opens CAN script

Speed - Speed source connected to Mobile device template such as Speed sender, J1708 CAN Speed, GPS velocity as speed

RPM - RPM source connected to Mobile device template such as RPM signal or J1708 CAN RPM

Fuel - Fuel source connected to Mobile device template such as EDM fuel flow meter or J1708 CAN Fuel

SP - shows whether Streamax connected or not. Configured on Mobile device template

HOS - Shows whether DTCO or BYOD/ELD is in use. Configured on the Mobile device template

Users are able to select all, multi-select or select a single asset at a time

When at leaset 1 asser is selected then enable the Actions dropdown list at the top of the page

### Actions

#### Compile:

Compile all assets that have been selected and that are in a configuration changed status

When selecting “Compile” open a config compile and upload modal:

Green header: Compile and upload configuration

Text: Select when to upload configuration to x (amount) assets once the compile has successfully completed

Below are 2 radio buttons

Immediately (via default transport)

Not now (compiled configuration saved to database)

In the bottom right corner is a grey Cancel and green Submit button

When the user says cancel then don’t proceed with the compile or upload

If the user selects Immediately or not now and selects submit then submit the request and display a green toast message once the modal is closed that says “Request submitted successfully

#### Upload

Upload to all selected assets that are in a Ready for upload status

When selecting “Upload” open the Upload configuration modal

Green header: Upload configuration

Text: Select when to upload configuration to x (amount) assets

Below are 2 radio buttons

Immediately (via default transport)

Not now (compiled configuration saved to database)

In the bottom right corner is a grey Cancel and green Submit button

When the user says cancel then close the modal

If the user selects Immediately or not now and selects submit then submit the request and display a green toast message once the modal is closed that says “Upload request submitted successfully

#### Upload FW

Upload FW to the selected assets that are not running the selected preferred FW version (ensure you ignore assets that are on the version and don’t reload)

When selecting “Upload FW” open the Upload FW modal

Green header: Upload firmware

Text: Are you sure you want to upload Firmware to x (amount) assets?

In the bottom right corner is a grey Cancel and green Upload button

When the user sleects cancel then close the modal and don’t submit anything

When the user selects Upload then queue the upload

Close the modal and display a green toast message on screen that states: Firmware upload request succesful

#### Reset flag

Action name: Reset to group config

This option is only available when a user has selected assets that have black flags

When this option is selected then display the reset modal

Green header: Reset to group config

Are you sure you want to reset x (amount) assets' configuration to that of the configuration group?

In the bottom right corner is a grey Cancel and green Reset button

When the user sleects cancel then close the modal and don’t submit anything

When the user selects Reset then reset the configuration

Close the modal and display a green toast message on screen that states: Reset request succesful

#### Move to config group

When one or more assets have been selected then the user should be able to select the Move to config group option

When this is selected then open the modal

Green header: Move to config group

Help text: You have selected x assets. Please select a configuration group to move these to:

Below this is a drop down list of available configration groups

The user needs to be able to also easily search for a specific config group so the select box should also double as a searchable field

Once the user has selected the config group then the user can select “Move”

This should then move the selected assets to said config group

Close the modal and display a green toast message on screen with text: Assets moved successfully

If it does fail for whatever reason then display the error on the screen as per usual

We need to keep the existing move logic in place where a user can only move to config groups with the same mobile device etc

### UNALLOCATED ASSETS

Tot the right of the Assets header is a “Show unallocated” checkbox

To the right of the is an information icon

When hovering over this display the following help text:

Assets that have not been assigned to a config group are considered unallocated.

When a user selects the checkbox then display all unallocated assets (assets that have not been assigned to a config group) and hide all other assets

There will be limited info available for these assets as they don’t have a config so we’ll only display what we have and leave the cells blank where we don’t have info

A user is then able to select all or multi-select a number of assets

When this is done then the actions dropdown should become available

The user should then be able to select “Move to config group”

When this is selected then open the modal

Green header: Move to config group

Help text: You have selected x assets. Please select a configuration group to move these to:

Below this is a drop down list of available configrationg groups

The user needs to be able to also easily search for a specific config group so the select box should also double as a searchable field

Once the user has selected the config group then the user can select “Move”

This shoulld then move the selected assets to said config group

Close the modal and display a green toast message on screen with text: Assets moved successfully

If it does fail for whatever reason then display the error on the screen as per usual

When the user deselects the Show unallocated checkbox then display the users previous config group selection

### NOTES

Currently users aren’t able to schedule FW uploads to FMs from the Config groups page

When a user selects to Upload FW then send the requet to the Scheduler the same as would happen if a user requested it from the Scheduler uploads page

We won’t manage the schedule from config groups but should be able to send the request to the Scheduler system

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

