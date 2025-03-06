Date: 2022-07-20 Time: 09:23
Status: #closed
Parent:: [[AC]]
JIRA:AC-363
[AC-363 Make Org ID optional for call to return the friendly parameter description - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/AC-363)

# AC-363 MakeOrgIDOptional_FriendlyParameter

## Image


## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Client                           | API   | DB    |
| -------------------------------- | ----- | ----- |
| 22.12                            | 22.12 | 22.12 |
| INT                              | INT   | INT   |
| Test App - merged in with AC-357 | DEV   | DEV   |

==SQL== think by default we need to pull in -1 and then append org library
	
## Branch
Config/MR/Bug/AC-363_MakeOrgIDOptional_FriendlyParameter.22.12.ORI

## PRs
**DB**: [Pull request 70973: AC-363 Add logic to all for null group id - Repos (visualstudio.com)](https://mixtelematics.visualstudio.com/Common/_git/Database/pullrequest/70973)
**API**: [Pull request 70995: AC-363: Changed the groupId to be nullable - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/70995)
**Client**: xxxx

## TEST

INT: Not real test
id=1180585053986516992&orgId=-8441185520557948197

DEV
id=1154902265568632832
orgId=3222089765699420885

DSDEVCFGSQL01
3222089765699420885
WDB9066592S202912
4) Behind Instrument Cluster


## Description
### DB
[library].[GetAllLibraryParameterDescriptionsForSystemNames]
### API
### Client

## Code sections

## Files

## Resources
[[AC-350 Add DynamicCAN endpoints to the Config API]]

## Notes

