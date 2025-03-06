---
status: closed
date: 2022-10-13
comment: Feedback Gershen
priority: 
---

Date: 2022-10-13 Time: 10:00
Parent:: xxxx
Friend:: [[2022-10-13]]
JIRA:FE-2399 Location imports
Jira: [FE-2399 REG Libraries: Locations imports - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/FE-2399)

# FE-2399 Location imports

## Image

## The reason why this doesn't do anything

- If the import location is available, but the location doesn't exist for the org, it gets added (this is not the case here)
- If the import location is available and the location exists for the org, it gets updated (which is also not the case here)
- If the import location isn't available and the location exists for the org, it gets removed (temporarily not available) (which is also not the case)

There are no other cases, so nothing will happen


## Tips

- result.ImportLink = "https://localhost/DynaMiX.API/config-admin/locations/organisations/770706242597273175/import"
- From what I can see in the code it will try to find the location (which is specified within the excel file) for this organisation and then apply the changes. If this is not found, nothing will happen.  
I double-checked the data and the ids found within this mentioned excel file are not found for this org.

[Gershwin Jacobs](https://jira.mixtelematics.com/secure/ViewProfile.jspa?name=gershwinj) , seeing that the locations within this org are empty, I don't think this will work, as the logic indicates that you can only update existing data using this method. I will just double-check that this is indeed the desired result.


## Steps

Environment: ==Integration==  
Steps to replicate:  
Test org: MiX Telematics / # Gershwin1_RSO / # Dealer_cathexis / ==BFMV==

1.Navigate to Manage > Config Admin > Libraries  
2.Click Location library  
3.Click ==import== library location  
4.Choose file > Use attached file

BUG: A success banner is displayed, but the locations is not added to the library, the same issue occurs on UAT.

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.13 |     |
| Local |     |

## Branch
Config/MR/Bug/FE-2399 Location imports.xx.xx.ORI

## Learned

## Description

## Code sections

## Files

## Resources

## Notes

