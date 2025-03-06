Date: 2022-04-07 Time: 09:56
Status: #done
Friend: [[DIE-485 DI Config Asset config file]]
JIRA:DIE-491
[DIE-491 Mobile Device Section - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/DIE-491)

# DIE-491 Mobile Device Section

## Notes

MobileUnit_GetMobileUnitConfigFileMobileDevice.sql


## Learned

- Went on page... 
- Found Network call Settings
	Request URL: http://localhost/DynaMiX.API/config-admin/organisations/3222089765699420885/assets/1230279699646066688/mobile-device/settings
- RegisterRoute(ModuleRoutes.GET_DEVICE_DETAILS, args => GetDeviceDetails(AuthToken, (long)args["orgId"], (long)args["assetId"]));

![](https://lh3.googleusercontent.com/pw/AM-JKLUUNDFvWqWaCxJuZKt11z1SpsXwRP8e-vY-dNWr_4yp43pgEw4ybjmsgRS3fe2NyoTQ5Oj2GA10pKEG0EqhMyBTdxrh1F4gn_Gb7BKPelPb0T3hFPfo2j7lFHnB4cmisvGmSL27SpK970fUimH59Ar2=w633-h462-no?authuser=0)


## Description

This is the look for the Asset Config File - Mobile Device Section

![[Pasted image 20220302103144.png]]

Nowhere else in the system do we collect all of this information.
1) Make use of the BE calls which currently gets all the information for the Edit Mobile Device Settings, just rework it or move it into a stored procedure rather.



## Code sections

## Files

## Resources

## Notes

