---
status: closed
date: 2022-10-04
comment: Lance to give feedback
priority: 
---

Date: 2022-10-04 Time: 10:07
Parent:: xxxx
Friend:: [[2022-10-04]]
JIRA:SR-13706 Showing date time for VIN

# SR-13706 Showing date time for VIN

## Used to fix (Asked Martin)

```sql
USE HalliburtonNorthAmerica_2015;

-- FIND THE ISSUE
SELECT a.VinNumber, a.VinSource, a.VehicleId
FROM dynamix.Assets a
WHERE VinNumber like '%:%'

-- FIX DATA
Update dynamix.Assets
SET VinNumber = '', VinSource = 'MANUAL'
WHERE VinNumber like '%:%'
```

## USED TO INVESTIGATE

- [[SQL Organisation]]
- [[SQL Assets]]

## Description

- North America
- Multiple Decomm'd assets are showing date/time where the VIN number is supposed to be. In the VIN section it's locked for editing (Source: CAN Bus).
- Halliburton North America
	- Clear VIN
	- SET CAN SOURCE to nothing

```sql
declare @64bitorgid bigint = 2689930065400163162  
declare @64bitassetid bigint = 3056091971474160310  
declare @Entity varchar (15)= 'Vehicles' -- 'Assets'  
declare @startdate datetime = '2018-01-01'  
declare @enddate datetime = '2022-09-13'  
SELECT [AssetsAuditKey]  
,[Operation]  
,[UpdateMask]  
,[CreatedDateTime]  
,[UserName]  
,[Entity]  
,[AssetId]  
,[VehicleId]  
,[OrganisationId]  
,[NewValues]  
FROM [DynaMiX].[DynaMiX_Audit].[Assets]with (nolock)  
where OrganisationId = @64bitorgid and AssetId = @64bitassetid  
and Entity = @Entity  
and CreatedDateTime between @startdate and @enddate  
--and PATINDEX('%liSiteID>0%', CAST(NewValues AS NVARCHAR(MAX))) > 0  
-- order by AssetsAuditKey desc;  
SELECT [AssetsAuditKey]  
,[Operation]  
,[UpdateMask]  
,[CreatedDateTime]  
,[UserName]  
,[Entity]  
,[AssetId]  
,[VehicleId]  
,[OrganisationId]  
,[NewValues]  
FROM [_DynaMiXArchive].[archive].[DynaMiX_Audit_Assets] with (nolock)  
where OrganisationId = @64bitorgid and AssetId = @64bitassetid  
and Entity = @Entity  
and CreatedDateTime between @startdate and @enddate  
--and PATINDEX('%liSiteID>0%', CAST(NewValues AS NVARCHAR(MAX))) > 0  
-- order by AssetsAuditKey desc;
```


## Code sections

## Files

## Resources

## Notes

