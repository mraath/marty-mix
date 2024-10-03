---
created: 2024-09-25T08:24
updated: 2024-10-03T08:23
---
### Should we Implement this?

The testers logged these bugs... should they be implemented or should we just hide these?

- [ ] OE-528: Refresh tab not refreshing after click (Only on asset side, no paging)
- [ ] OE-532: Individual Config Group rows' actions don't work (Only Remove, Hyperlink name to edit)
- [ ] OE-530: Individual Asset rows' actions don't work (Only Remove)

### Wording enhancements?

The testers have picked this up. Should we change this?

- [ ] OE-534: Singular form of an error needed (asset(s), Nicole will rework the wording)

### Business Rules needed

- [ ] OE-533: If the asset is from a different mobile device type, it says it will be moved to unallocated, however, this doesn't happen. I reused the old logic, so I think this never happened. It might have been that in some cases half-way it broke and then it was in an unallocated state. Should we re-word it that it COULD end up unallocated? (Nicole will change the wording - dont move the incorrectly selected ones)
- [ ] OE-490: I asked previously about the business logic needed here. Previously it would just run the upload FW logic for each asset in the config group, based off of the asset's settings, however, in this story it want some other logic. I then asked if we should just remove the asset's overwritten preferred FW Version in order for the CG FW version to be selected. (Just dont reload the same version, ignore flagged vehicles, compare to FW field...)

### Other questions to be put into stories

- [ ] The FW Versions filter will continue to just show MESA units with that version.
- [ ] Permissions and Authentication logic for loading Orgs, Groups, Sites, Assets has to be added before we release this. (OE-538 Created)
- [ ] Justus: If an Asset is linked to a CG, should we be able to remove the CG? (Keep as the old one is currently working) (**Nicole** to think about Remove logic enhancements for a future enhancement)
- [ ] Pallavi to add in her new Video Event Configuration page in the actions (OE-539 Created)
- [ ] Justus: Compile AND Upload for 3rd party... not supported... what is the supported list? To hide button for unsupported devices. (Future story which will be through about by **Nicole**)
- [ ] Justus: Comms Status... not coming through on FM. (**Devs** will figure out)
