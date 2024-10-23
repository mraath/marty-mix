---
created: 2024-10-22T14:08
updated: 2024-10-23T16:56
---
### Individual issues

- [ ] UpdateAssetsConfigurationGroup: This method still uses proxies - replace
- [ ] **Languaging**
	- [ ] Languaging doesnt always change, eg. to En / Pig
	- [ ] OE-509: Are you sure you want to upload Firmware to {{xxxxx}} assets?
	- [ ] OE-509: {{notUploadedFWAssets.length}} of the selected assets were unable to upload firmware
	- [ ] OE-490: Are you sure you want to upload Firmware to x config groups?
- [ ] Grid Ordering / Sort
- [ ] Timeout issues on API calls
- [ ] Activate menu for prod & UAT (MUCH **LATER**)
- [ ] OE-538: **Permissions** and Authentication logic for loading Orgs, Groups, Sites, Assets has to be added before we release this.
	- [ ] CAN Upload FW permissions? (Part of OE-509) - Doesn't seem like the old one did this
- [ ] OE-539: Pallavi to add in her new Video Event Configuration page in the actions

### Done

- [x] Add in SelectionCriteria ✅ 2024-10-02
	- AllowedOrigins: "https://mixconfigfrangularui.mixdevelopment.com", "https://mixconfigfrangularapi.mixdevelopment.com",
- [x] Authentication and Authori ✅ 2024-10-03
- [x] Only show these actions when the user has access ✅ 2024-10-03
- [x] Only show other actions when the user has ✅ 2024-10-03
- [x] Permissions and Authentication logic for loading Orgs, Groups, Sites, Assets has not been added. Is it OK to do this at a later stage? - WE put this into a story ✅ 2024-10-03
- [x] Spinners ✅ 2024-08-08
- [x] //TODO: MR: Add GetVideoEventConfigurationDetails back on DEV once DONE with this - Added into a story ✅ 2024-08-06
- [x] OE-490: I asked previously about the business logic needed here. Previously it would just run the upload FW logic for each asset in the config group, based off of the asset's settings, however, in this story it want some other logic. I then asked if we should just remove the asset's overwritten preferred FW Version in order for the CG FW version to be selected. (Just dont reload the same version, ignore flagged vehicles, compare to FW field...) ✅ 2024-10-23