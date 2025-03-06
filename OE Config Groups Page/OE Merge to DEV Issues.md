---
created: 2024-08-06T09:11
updated: 2024-08-06T09:18
---

Merging FR UI to DEV (OE work)
- [Pull Request](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequestcreate?sourceRef=Config/MR/Feature/OE-491-Asset-List-Panel.24.9.DEV.ORI&targetRef=Development&sourceRepositoryId=03d31640-4d3a-403e-b223-acef8eb64482&targetRepositoryId=03d31640-4d3a-403e-b223-acef8eb64482)
- WIP: Still busy with a lot of this
- I temporarily removed some Layout things we dont need, in future I will remove it in full

API: Config/MR/Feature/OE-496-CG-OE-497-Asset.DEV.NAc
```

    

	MiX.Core << 2024.2.28.2 (NO as this will be a downgrade)
	
    BETA: 25.1 Beta
    MiX.DeviceIntegration.Common
    MiX.DeviceIntegration.Core
    MiX.DeviceIntegration.Queueing.Kafka
    
    MiX.DeviceIntegration.DataProcessing << 2023.16.20231010.1
    MiX.Connect.Dmt << 2024.2.1.1
    MiX.Connect.Serialization << 2024.2.1.1
    
```

---

- OE MErge
Config/MR/Feature/OE-496-CG-OE-497-Asset.DEV.NAc

- FR API
	- MiX.ConfigInternal.Api.Client (2024.9.20240520.2-alpha) **NEED TO UPGRADE**
	- MiX.DeviceIntegration.Common (2024.9.20240510.3) << Should be fine
	- MiX.Core.Serialization.Jil (2024.5.9.1) << MAYBE ok

---

- UI and API
	- API not merged
	- UI outstanding
		- https://config.dev.mixtelematics.com/#/config-admin/configuration-groups-multiselect
		- https://config.dev.mixtelematics.com/_cdn/Templates/ConfigAdmin/ConfigGroupsMultiselectTemplate.html?version=1.0.8976.18091
		- MiXFleet.UI.csproj
			-  Content Include="Js\ConfigAdmin\Templates\ConfigGroupsMultiselectTemplate.html" /> *X*

---

- MERGE with DEV
	- https://config.dev.mixtelematics.com/dynamix.api/mixmodules/deviceConfigurationModule
	- https://mixconfigfrangularui.dev.mixtelematics.com/api/mixmodules/cultureModule
	- https://mixconfigfrangularui.dev.mixtelematics.com/api/mixmodules/videoEventConfigurationModule
	- **mixconfigfrangularapi**
	- mixmodules/**selectionCritriaModule**
	- selectionCriteriaModule

---

- FR UI
	- https://config.dev.mixtelematics.com/configuration-groups-multiselect
	- Config/MR/Feature/OE-MERGE-issues-DEV
	- angularNextConfigUrl|mixconfigfrangularapi.dev.mixtelematics.com|mixconfigfrangularui.dev.mixtelematics.com|APIURL_DEV|mixconfigfrangularui.dev.mixtelematics.com|mixconfigfrangularui.mixdevelopment.com|mixconfigfrangularapi.mixdevelopment.com|angularNextConfigFrangularUrl

---

- DEV OE issues
https://config.dev.mixtelematics.com/dynamix.api/mixmodules/deviceConfigurationModule
/userprofile/user
/api/mixmodules/userProfileModule
https://mixconfigfrangularapi.dev.mixtelematics.com/api/mixmodules/userProfileModule
https://mixconfigfrangularapi.dev.mixtelematics.com/api/userprofile/user
### Undefined
https://mixconfigfrangularui.dev.mixtelematics.com/undefined/api/mixmodules/cultureModule
https://mixconfigfrangularui.dev.mixtelematics.com/undefined/api/mixmodules/baseApp
https://mixconfigfrangularui.dev.mixtelematics.com/undefined/api/mixmodules/selectionCritriaModule

---

FR UI: localhost:5001
5000
5012

User DEV:
https://mixconfigfrangularapi.dev.mixtelematics.com/api/userprofile/user

User INT working:
https://uiapi-int-config-eas.mixdevelopment.com/api/userprofile/user

userprofile/user

---

