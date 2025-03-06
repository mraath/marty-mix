USE DeviceConfiguration;
DECLARE @id BIGINT = 1426140713474596864;
SELECT * FROM mobileunit.mobileunits WHERE mobileunitid = @id;
SELECT amu.ChangeDate, dc.Description, * 
FROM audit.mobileunit_mobileunits_CT amu
INNER JOIN definition.ConfigurationStatuses dc ON dc.ConfigurationStatus = amu.ConfigurationStatus
WHERE mobileunitid = @id 
ORDER BY amu.ChangeDate ASC;
