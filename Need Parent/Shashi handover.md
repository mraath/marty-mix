Contents

Handover document 1

1)  Scripts repository  2

2)  Legacy Parameter Id issues  2

a)  Issue - Script parameters are not being recorded  2

Fix script: 2

b)  Issue – Parameter Id conflicts  2

Fix script  2

c)  Issue – NULL Legacy Parameter Ids 2

Fix script  3

3)  OLTP Deployment data clean-up scripts 3

a)  CleanEarlyReleaseRecords.sql  3

b)  DeviceCleanup.sql 3

Note  3

4)  Restoring a deleted Org Library using the Audit tables  4

a)  Issue – sometimes an Org may be accidentally deleted from DynaMiX and we are required to restore Config Data. 4

Fix 4

  
  
  
  
  
  
  
  
  
  
  
  
  

1)  Scripts repository

https://mixtelematics.visualstudio.com/DeviceIntegration/DeviceIntegration%20Team/_git/Scripts

This is where the Device Integration Team shares various scripts.  Anything that can be re-used or might be useful to other devs / support people should go in here.

  

2)  Legacy Parameter Id issues

  

In order to satisfy requirements from the ConfigGen service, Legacy Parameters Ids for script devices must be above 10200. In some cases, the Ids have been generated with negative values or conflicting values.

  

a)  Issue - Script parameters are not being recorded  

In order to satisfy requirements from the ConfigGen service, Legacy Parameters Ids for script devices must be above 10200. In some cases, the Ids have been generated with negative values. This will result in those parameters not being recorded to. (see example in CONFIG-350 on JIRA)

Fix script:

https://mixtelematics.visualstudio.com/DeviceIntegration/_git/Scripts?path=%2Fuseful%20scripts%2FLegacy%20Parameter%20Id%20fixes%2FFix%20LegacyParameterIds.sql&version=GBmaster

b)  Issue – Parameter Id conflicts

Some parameters have been created with legacy ids that conflict with system reserved Ids. When these system-reserved parameters need to be made available, conflicts occur.

Note: this fix will not touch any parameters that are already in use by any mobile units. Any change to their legacy parameter Ids will affect the downloader. Step 3 of the script will return a list of all parameters that are broken, but could not be fixed, as well as the mobile units that are using them. The solution here is to notify the support consultant of this, and enquire as to whether these parameters can be modified. If the answer is “yes”, then re-run this entire script with Step 3 commented out.

Fix script

https://mixtelematics.visualstudio.com/DeviceIntegration/_git/Scripts?path=%2Fuseful%20scripts%2FLegacy%20Parameter%20Id%20fixes%2FFix%20Duplicate%20Legacy%20Parameter%20Ids.sql&version=GBmaster

c)  Issue – NULL Legacy Parameter Ids

In some cases, Parameters were created with NULLs for Legacy Parameter Ids, which will also break the Downloader. Error in the downloader log usually looks similar to this:

Process0 20180910 00:24:50.750895 2585| Error: 5: Unexpected exception: Data is Null. This method or property cannot be called on Null values (see also SR-1850 in JIRA)

Fix script

https://mixtelematics.visualstudio.com/DeviceIntegration/_git/Scripts?path=%2Fuseful%20scripts%2FLegacy%20Parameter%20Id%20fixes%2FFix%20NULL%20Legacy%20Parameters%20Ids.sql&version=GBmaster

  

3)  OLTP Deployment data clean-up scripts

  

There are currently two ways to do clean up in the OLTP solution for the DeviceConfiguration database.

a)  CleanEarlyReleaseRecords.sql

This will happen as an initial step, which means that anything that needs to be removed/modified before the data XML is loaded should happen in here. This is the legacy way to do data clean-up, but is still useful when trying to avoid conflicts with new records from the various data XML files.

b)  DeviceCleanup.sql

This will happen after all deployment steps for DeviceConfiguration.  This is a useful way to remove features on certain environments but keep them on others. E.g.

  

Note

Both of these scripts should be cleaned up after each release, however this is not always possible. If unsure as to what can or can’t be removed, ask Paul Roux and/or Ettienne Steenkamp.

  
  
  
  

4)  Restoring a deleted Org Library using the Audit tables

  

Note that this is very risky, and may have unintended consequences even if it works. This should always be treated as a “reasonable best effort” type of solution. Important to note that we are only restoring records in the DeviceConfiguration DB, no other DBs or domains are covered here.

a)  Issue – sometimes an Org may be accidentally deleted from DynaMiX and we are required to restore Config Data.

This should only be attempted in cases where it is absolutely necessary – larger orgs, for example. For example, an org of under 10 vehicles should be manually re-captured by Support.

Fix

First, a new Org must be created in DynaMiX. The 64-bit group Id of this new Org AND the deleted Org will be used to port data from the audit tables. The scripts included will also need the date that the delete occurred. All library data that can be retrieved will be as it was at the time of deletion.

There are currently 4 scripts available, and they must be executed in their numerical order:

https://mixtelematics.visualstudio.com/DeviceIntegration/DeviceIntegration%20Team/_git/Scripts?path=%2Fuseful%20scripts%2Frestore%20db%20from%20audit&version=GBmaster

If any data cannot be retrieved for any reason, it is preferable to provide the H&O / Support person responsible with the audit data as it was at the deletion time and manually capture it into DynaMiX.