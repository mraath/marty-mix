---
status: closed
date: 2023-03-08
comment: 
priority: 8
---

# SR-14824

Date: 2023-03-08 Time: 14:57
Parent:: ==xxxx==
Friend:: [[2023-03-08]]
JIRA:SR-14824
[SR-14824 EXCEPTION! Violation of UNIQUE KEY constraint 'UQ_Events_LibraryKey_Description'. Cannot insert duplicate key in object 'library.Events'. The duplicate key value is (692, Possible impact). - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14824)

## Read Description

EXCEPTION! Violation of UNIQUE KEY constraint 'UQ_Events_LibraryKey_Description'. Cannot insert duplicate key in object 'library.Events'. The duplicate key value is (692, Possible impact).

IDC : US 
Database : MX TLH
Group ID : 8948032822309075507

Unable to make available MIX4000 from the mobile device library for database “ MX TLH “  in US server.
Fails with the error : 
EXCEPTION! Violation of UNIQUE KEY constraint 'UQ_Events_LibraryKey_Description'. Cannot insert duplicate key in object 'library.Events'. The duplicate key value is (692, Possible impact). 67The statement has been terminated.

Reminds me of [[Shashi handover]]

## See it happen

- Duplicate this on the environment mentioned using MFM

## If EVENT

- Search in VSCode in Projects folder
	- found: XXXX
- Searched in Config.XML for Event
	- found:  XXXX
	- Active / Passive
	- Conditions
- Searched in DIS Viewer for Event ID
	- found:  XXXX
- Searched the DB
	- found: XXXX

## Search md in Projects folder for keywords

- Might have handled this before
- Update Links in Obsidian

## Units

- Check config file: zip > bin
- Check Files: UDP / Dat > DIS Viewer

## Workflow

- See where the data stopped
- Update Graphs in Obsidian
- Decide if we are still the correct team
- Sanity check William (DP)

## Any Development done?

? ==Replace with Template Development note==

