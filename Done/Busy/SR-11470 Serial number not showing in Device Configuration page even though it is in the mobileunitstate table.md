JIRA:SR-11470

Request URL: http://localhost/DynaMiX.API/config-admin/organisations/-8386191436408769566/config_groups/6195278869291132898/assetlist

SerialNumber = mobileUnit.MobileUnitSerialNumber
DeviceConfigClient.MobileUnits.GetMobileUnitSummariesForConfigurationGroupMobileUnitSummary

									from EF.Tables.MobileUnitLevel.MobileUnitProperty serialNumberProp in Context.MobileUnitProperties.Where(x => x.MobileUnitKey == mu.MobileUnitKey && x.PropertyKey == serialNumberPropertyKey).DefaultIfEmpty()

			int serialNumberPropertyKey = (from dp in Context.DefinitionProperties where dp.PropertyId == Properties.SERIAL_NUMBER select dp.PropertyKey).First();

    public const long SERIAL_NUMBER = -6167220489794283114;

Not the same tables!!

## Russell Wilmott

### What he looked at

```sql
use deviceconfiguration

select sOrganisationName,LegacyVehicleId,dp.PropertyName,mus2.value,* from  
[DeviceConfiguration.DataProcessing].[state].[MobileUnitState] mus2 with (nolock)  
inner join Deviceconfiguration.mobileunit.AssetMobileUnits amu on mus2.MobileUnitId=amu.assetid  
inner join DeviceConfiguration.definition.Properties dp on mus2.PropertyId=dp.PropertyId  
inner join FMOnlineDB.dbo.organisation o on amu.legacyorgid=o.liorgid

--where assetid=1104406037795794944 

and mus2.PropertyId = -6167220489794283114
```

## Where it actually found it (Palavi might have changed this)

MobileUnitProperties

```sql
SELECT TOP 5 *
FROM mobileunit.mobileunitproperties mup
WHERE mup.mobileUnitPropertyId = -6167220489794283114

```


