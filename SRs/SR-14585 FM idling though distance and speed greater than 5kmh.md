---
status: 
date: 2023-02-10
comment: 
priority: 5
---

# SR-14585 FM idling though distance and speed greater than 5kmh

Date: 2023-02-10 Time: 09:42
Parent:: [[Events]]
Friend:: [[2023-02-10]]
JIRA:SR-14585 FM idling though distance and speed greater than 5kmh
[SR-14585 FM unit is showing idling for the duration of the trip ,though you can see distance and speed way greater than 5km/h. - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14585)

## Read Description

- Device Info
	- IDC : **UK**
	- Database : Greece - Tafiadis Nikos Trans EPE [1]
	- ORG ID : 2828
	- Group ID : -6537539417465203359
	- Asset description : EKA - 3565 - Tafiadis - ID 11
	- Asset ID : 11
	- 64 bit asset ID : -8816580308122767783
	- Last config loaded : 2020/10/17 10:54 PM (EEST)
	- Mobile device : **FM** 3516i (Tracer) - CAN
- Get this from Jira
	- Can you please advise as to why this unit is showing ==idling==/ Ρελαντί  for the duration of the trip ,for  all the trips.
	- Though you can see distance and speed way greater than 5km/h.
	- Example: Idling / Ρελαντί is showing duration of 99,40% in trip summary.
	- ![[SR-14585 FM idling though distance and speed greater than 5kmh.png | 500]]
	- 


## See it happen

- Duplicate this on the environment mentioned using MFM

## Search md in Projects folder for keywords

- Might have handled this before
- Update Links in Obsidian
- Update Graphs in Obsidian

## Units

- Check config file: zip
	- GSM_IDLE? 4363?
	- < EventId>32903</EventId>
- Check Files: UDP / Dat


## If EVENT

- Check if event in bin
	- Active / Passive
	- Conditions
- Check if event triggered in DIS Viewer
	- Find ID
	- Look for it in DIS Viewer

## Workflow

- See where the data stopped
- Decide if we are still the correct team
- Sanity check William (DP)

## Development done?

? ==Replace with Template Development note==

