USE Deviceconfiguration;

IF OBJECT_ID('[dynamix].[OrganisationGetAssetDataTimeZones]', 'P') IS NOT NULL
    PRINT 'The stored procedure exists.'
ELSE
    PRINT 'The stored procedure does not exist.'

USE [DeviceConfiguration.DataProcessing];

IF OBJECT_ID('[state].[OrganisationUpdateDaylightSavings]', 'P') IS NOT NULL
    PRINT 'The stored procedure exists.'
ELSE
    PRINT 'The stored procedure does not exist.'

