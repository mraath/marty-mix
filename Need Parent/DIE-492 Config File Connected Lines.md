	Date: 2022-03-17 Time: 11:24
Status: #done
Friend: [[DIE-485 DI Config Asset config file]]
JIRA:DIE-492
[DIE-492 Connected Lines - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/DIE-492)

# DIE-492 Config File Connected Lines

## Description

This is how the Asset Config File - Connected Lines look.

![[Pasted image 20220302103553.png]]

The next part shows all the lines on the device and what it is connected to.
It the also summarises some of the connected device / peripheral's settings in an additional column.
1) We can make use of the existing stored procedure to get all the lines with the connected devices info. This could form part of a new stored proc.
2) We need to add the additional column to the above stored proc to return the summary of the connected device / peripheral's settings.

## Notes

AssetConfigFileLinesSection
MobileUnit_GetMobileUnitConfigFileLines.sql

Columns:
Line
Tacho
ConnectedDevice
Settings

## Code sections

[mobileunit].[MobileUnit_GetAllMobileUnitLines]

## Files

## Resources
SQL: [[GetConfigLocationTemplates (1) 4.sql]]
Tables: [[Diagram ConfigFile.excalidraw]]
New SQL for this section only: [[DIE-492 MobileUnit_GetAllMobileUnitLines 1.sql]]
