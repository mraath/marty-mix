---
wiki_ingested: 2026-05-28
created: 2025-08-06T16:41
updated: 2025-08-06T16:41
---
Took me a while to find this - almost exactly a decade ago (6 days out). But this is the intent of ordering in the DeviceData.xml |

[Commit 0c3e76dc: Reorder devices in DevicesData.xml... - Repos](https://dev.azure.com/MiXTelematics/Common/_git/Database/commit/0c3e76dce0a6afe436cd758c52e9999a39b11c47?tab=details "https://dev.azure.com/mixtelematics/common/_git/database/commit/0c3e76dce0a6afe436cd758c52e9999a39b11c47?tab=details") 

Reorder devices in DevicesData.xml  
MobileDevices: by handler, description  
Peripheral Devices

- 'simple' by systemName or Description
- 'Output' by systemName or description
- complex by systemName or Description
- Power by systemName or Description  
    Logical devices by UISortOrder, system name or display

Zonika Smit I am not sure if we need to create a task for someone to do a reorder based on the above?