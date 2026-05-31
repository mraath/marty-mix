---
wiki_ingested: 2026-05-28
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-11-28T10:38
---

# ETS-6874

Date: 2025-11-21 Time: 09:56
Parent:: ==xxxx==
Friend:: [[2025-11-21]]
JIRA:ETS-6874
[JIRA](https://powerfleet.atlassian.net/browse/ETS-6874)


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

## Shorter Description

IDC: US  
Database examples:

NOV  
Baker Hughes North America

Issue: Multiple Firmware versions reported on Config Beta page in US for MiX 4000 devices. Looks like we reporting FM CAN DDM firmware with the MiX4000’s.  
Also pretty sure this should be labeled as Default Firmware version too as this is against the config group not the asset!

![[Pasted image 20251121095750.png|800]]


---

I'm looking into an issue where the config groups will return more than one firmware version. This should never be the case as a config group is a template that is connected to a mobile device. And that mobile device has a preferred firmware version. So there should always just be one. From the issue, it seems like it's connecting FM devices and stuff, where it should actually only be connecting to the device specified within the template. So the template config group is connected to a template mobile device and to some other templates. On that template mobile device it will specify the device, for instance a MIX 4000, and that will also specify the preferred firmware version. Please investigate the following stored proc and let me know what extra joins I should potentially add, or just investigate it and tell me what's wrong, how should I fix it. HEre is the path to the stored proc where I think it might be happening: C:\Projects\Database\DeviceConfiguration\Schemas\template\Stored Procedures\Template_GetConfigurationGroupsOtherColumns.sql

---

Easily found on US, also INT > Bench Units

![[Pasted image 20251121131455.png|450]]

https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-7094567047859310012

-7094567047859310012



**This should give you:**
- Config Group -7668187040444806181 → **E15.08.09** (only)
- Config Group -3251388662902899727 → **E19.03.07** (only)

TESTING on INT

![[Pasted image 20251124155429.png]]



## MAIN FIX

```sql
-- FW VERSION - Pure data-driven approach using DeviceDependencies
DECLARE @FWVersions TABLE  
(
  [ConfigurationGroupId] BIGINT,
  [FWName]               NVARCHAR(50)
);

INSERT INTO @FWVersions
SELECT DISTINCT
  [ConfigurationGroupId] = g.ConfigurationGroupId,
  [FWName] = fw.Name
FROM @GeneralConfigGroupInfo g
  -- Find optional logical device dependencies for the main mobile device
  INNER JOIN [definition].[DeviceDependencies] dep WITH (NOLOCK)
    ON dep.ParentDeviceKey = g.DeviceKey
    AND dep.DependencyType = 1
  -- Join template.Devices on the child device from dependencies
  INNER JOIN [template].[Devices] td WITH (NOLOCK)
    ON td.MobileDeviceTemplateKey = g.MobileDeviceTemplateKey
    AND td.LibraryKey = g.LibraryKey
    AND td.DeviceKey = dep.ChildDeviceKey
  -- Get firmware properties from the dependency device
  INNER JOIN [template].[DeviceProperties] tdpr WITH (NOLOCK)
    ON tdpr.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey
    AND tdpr.DeviceKey = td.DeviceKey
    AND tdpr.PropertyKey = @FWVersion
  -- Get the firmware version details
  INNER JOIN [definition].[FirmwareVersions] fw WITH (NOLOCK) 
    ON fw.FirmwareVersionId = tdpr.Value
WHERE tdpr.Value IS NOT NULL
```


- The above  worked but it became REALLY SLOW....
- I then enhanced this, but thought to just enhance the whole thing with Claude

## Tests

Online Excel compare

- OLD vs NEW ✅
	- Correctly showing only whats needed
	- Have few nulls
		- [x] need to ensure these are actually like this ✅ 2025-11-26
		- -2310911944299775966 (15.05.02 > NULL) [Tom_Bench_FM3617i]
			- NULL is correct 
		- 2505696365882641504 (15.05.02 > NULL) [Martha FM36]
			- NULL is correct 
- New vs Optimized (expecting 0 change) As it as only a speed change
	- Stayed exactly the same as NEW (PASS)
- New vs Optimized2 (expecting 0 change) As it as only a speed change
	- CAN changed.... but this could be correct 
		- [x] Test if this is correct? ✅ 2025-11-26
		- Findings:
			- 1989001888637459309 (CanScriptLineId: 401558247868188484, -2043420209342905840 > 401558247868188484) (CanScript: Script.CAN.J1939.500KBPS.ACK_ENBL.v1.33.0.12, Script.CAN.VOLKSWAGEN.PQ-PLATFORM.v1.19.1.0_MG__BETA_ > Script.CAN.VOLKSWAGEN.PQ-PLATFORM.v1.19.1.0_MG__BETA_) [AlexMMiX4000]
				- It SHOULD have both ❌
			- 3813205176926613669 (CanScriptLineId: 401558247868188484, -2043420209342905840 > 401558247868188484) (CanScript: Script.CAN.SUZUKI.SX-4.POS3.JSAGYA51_00.v1.15.1.0_MG, Script.CAN.FORD.RANGER.POS4.MNACMFF7_NW.v1.16.1.0_MG > Script.CAN.SUZUKI.SX-4.POS3.JSAGYA51_00.v1.15.1.0_MG) [Marco MiX4000]
				- It SHOULD have both ❌

AlexMMiX4000 CAN
![[Pasted image 20251126091443.png]]

Marco MiX4000 CAN
![[Pasted image 20251126091749.png]]


## Branch

> Config/MR/Bug/ETS-6874_CGOtherColumns.INT

## Repo
ETS-6874: Multiple FW Versions - fixed
- [x] FR UI: [PR to INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/134994) ✅ 2025-11-28
- [x] DB: [PR to INT](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/134987?_a=files) ✅ 2025-11-28

