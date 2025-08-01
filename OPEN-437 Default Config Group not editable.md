---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-08-01T09:05
---

# OPEN-437 Default Config Group not editable

Date: 2025-07-22 Time: 14:54
Parent:: ==xxxx==
Friend:: [[2025-07-22]]
JIRA:OPEN-437 Default Config Group not editable
==URL TO JIRA==

## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Description


## SP 2


### BE
- [x] Task 1 ✅ 2025-08-01
	- https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-1983255592473789111/config_groups
	- Request Method: POST
		- GET_CONFIG_GROUPS_LIST
		- GetConfigGroupListPage
			- In class ConfigGroup add IsDefault
			- DeviceConfigClient.ConfigurationGroups.GetConfigurationGroupSummaries
			- MiX.DeviceConfig.Api.Client, Version=25.13.0.0: GetConfigurationGroupSummaries
			- 
      PR: xxxxxxxxxx

### FR UI
- [x] https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-1983255592473789111 ✅ 2025-08-01
	- Request Method: GET
	- getConfigurationGroupsMultiselect
      PR: xxxxxxxxxx

### FR API
- [x] Need IsDefault on the Carrier For Single Edits ✅ 2025-08-01
- [x] ALSO need IsDefault on the Carrier for lists, this will be a much longer one.... ✅ 2025-08-01
      PR: xxxxxxxxxx




==GetConfigGroupListPage==





- **OLD Page**
	- [ ] BE > 
		- [ ] PR INT
			- Get Latest Client
			- xxxxxxxxxxxx
			- Pull in latest common
			- xxxxxxxxxxxx
		- [x] PR DEV ✅ 2025-08-01
			- Pull in latest client: MiX.ConfigInternal.Api.Client.2025.14.20250729.1-beta.nupkg
			- Pull in latest common: MiX.DeviceIntegration.Common
			- MANY merge issue: [[Accept All Incoming Files Command Line]]
	- [x] Client > ✅ 2025-07-31
		- [ ] PR INT
			- [ ] Need Latest MiX.DeviceIntegration.COMMON
			- xxxxxxxxxxxxxxx
		- [x] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/128087) ✅ 2025-07-29
			- MiX.ConfigInternal.Api.Client.2025.14.20250729.1-beta.nupkg
			- [SWAGGER TEST](http://api.deviceconfig.dev.priv/api/configuration-groups/groupId/5474499515462821884?authToken=c1bed22f-670d-4cc1-b1c6-96a64c13f7fd&includeMobileUnitCounts=true)
			- 
	- [x] API > ✅ 2025-07-31
		- [ ] PR INT
			- [ ] Need Latest MiX.DeviceIntegration.Common: MiX.DeviceIntegration.Common.2025.14.20250731.1.nupkg
			- [ ] AND MiX.DeviceIntegration.Core
		- [x] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/128086) ✅ 2025-07-31
	- [x] Common > ✅ 2025-07-28
		- [x] [PR INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/128253) ✅ 2025-07-31
			- MiX.DeviceIntegration.Common.2025.14.20250731.1.nupkg
		- [x] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/128018) ✅ 2025-07-28
			- MiX.DeviceIntegration.Common.2025.14.20250728.1-beta.nupkg
	- [x] EF ✅ 2025-07-29
		- [x] PR INT ✅ 2025-07-29
		- [x] PR DEV ✅ 2025-07-29

- **BETA Page**
	- [x] **FR UI** > ✅ 2025-07-31
		- [ ] PR INT
		- [x] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/127855) ✅ 2025-07-24
		- [x] https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/128252 ✅ 2025-07-31
	- [x] **FR API** > ✅ 2025-07-24
		- [ ] PR INT
			- [ ] MUST pull new INT client
		- [x] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/127853) ✅ 2025-07-24
		- [x] [PR DEV with new client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/127854) ✅ 2025-07-24
	- [x] **Client** > ✅ 2025-07-24
		- [ ] PR INT
		- [x] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/127852) ✅ 2025-07-24
			- MiX.ConfigInternal.Api.Client.2025.14.20250724.1-beta
	- [x] **API** > ✅ 2025-07-31
		- [ ] PR INT
		- [x] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/127851) ✅ 2025-07-24
	- [x] **Common** > ✅ 2025-07-24
		- [x] [PR INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/127808) ✅ 2025-07-23
			- MiX.DeviceIntegration.Common.2025.7.23.1.nuspec
			- https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/127810
			- MiX.DeviceIntegration.Common.2025.14.20250723.2.nupkg
		- ~~PR DEV~~
	- [x] **DB** ✅ 2025-07-24
		- [ ] PR INT
		- [x] [PR DEV](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/127850) Manually put on DEV ✅ 2025-07-24

## Gameplan

- OLD Page
	- UI > BE > Client > API > Common > EF
- BETA Page
	- FR UI > FR API > Client > API > Common > DB


## Testing

### DEV

- [ ] UI
	- Data shows TRUE for 2, after testing the API on DEV
- [ ] FR API
- [x] API ✅ 2025-07-28
	- http://api.deviceconfig.dev.priv/api/configuration-groups-multiselect/groupId/5474499515462821884?authToken=ef003406-0f9f-4642-8b54-7aeef3c8c1b9
- [x] DB ✅ 2025-07-28

![[OPEN-437 Default Config Group not editable Test DEV.png|200]]

![[OPEN-437 Default Config Group not editable Legacy Working.png|200]]
### INT


## Branch

> **Branch**: 
> Config/MR/Feature/OPEN-437-Default-Config-Group-not-editable.INT

==GetConfigurationGroupsMultiselect==
MiX.DeviceIntegration.Common.2025.14.20250723.2
OPEN-437: Disable edit and remove for default groups
public bool IsDefault { get; set; }
MiX.ConfigInternal.Api.Client.2025.14.20250724.1



TEST DEV: 
	https://config.dev.mixtelematics.com/#/fleet-admin/driver/details?id=-8383490494337834621&orgId=5373602768183155046
	https://config.dev.mixtelematics.com/#/fleet-admin/asset/details?id=1684661151430238208&orgId=4036779219063094058
	ORGID: 5474499515462821884
TEST INT: https://integration.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1466026638581260288&orgId=-1983255592473789111

> [!warning] Some Default groups are not set as IsDefault = 1



- DB
	- g.LocationTemplateName,
	- g.IsDefault, <<<<<<<<<<<<<

- Config.Api
	- ConfigurationGroupAddEdit : class ConfigurationGroup (MiX.DeviceIntegration.Common, Version=2025.7.11.1)
		- public bool IsDefault { get; set; }
		- "[template].[Template_GetConfigurationGroupsMultiselect]"
- Client
	- OLDER Class - not has above...
	- [ ] UPgrade the common class
- FR API
	- [ ] ensure it gets pulled through
- FR UI
	- [ ] enure it gets pulled through
	- [ ] BLOCK Edit and delete

- OLD BE
	- [ ] Ensure you make use of new common
- OLD FE
	- [ ] Ensure pulled through
	- [ ] BLOCK Edit and delete