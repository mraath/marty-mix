---
created: 2025-11-20T10:23
updated: 2025-11-20T10:23
---
I'm busy with the alerts optimization. The following path is where the current optimization is. 
C:\Projects\OPEN-862_4Alerts_OPtimized.sql
I am a bit confused now - it might even be the one below... please check both to see which you know will be correct:
C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized.sql


This was based off the original alerts stored proc which only had 4 alerts. Here is the path to that one.
C:\Projects\OPEN-862_4Alerts_MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql


Currently though, there is an additional alert, alert 5, which has not been optimized. Please see the latest alert stored prop here, 
C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized.sql




Please only compare the latest and the original I worked from and let me know what I should add in the optimized to also optimize alert 5.

ALERT 5 can now be see in the latest version of: C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql
in the line following: CAST(ISNULL(ur.IsMissingParameters, 0) AS CHAR(1)),  -- Alert 4

Here is the logic for alert 5: (CASE WHEN (ur.InstalledFirmwareAlpha < ur.PreferredFirmwareAlpha) AND 								(ur.InstalledFirmwareAlpha <> '') AND (ur.PreferredFirmwareAlpha) <> '' THEN '1' ELSE '0' END)),


----

What is the difference between: C:\Projects\OPEN-862_4Alerts_MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql AND C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql ? HOW will I have need to adjust C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Optimized.sql to include this, but still optimized.

