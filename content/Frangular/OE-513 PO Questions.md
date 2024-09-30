---
created: 2024-09-25T08:24
updated: 2024-09-30T17:07
---
### Final Approval needed

- [ ] OE-480
- [ ] OE-481

### Should we Implement this?

The testers logged these bugs... should they be implemented or should we just hide these?

- [ ] OE-528: Refresh tab not refreshing after click
- [ ] OE-532: Individual Config Group rows' actions don't work
- [ ] OE-530: Individual Asset rows' actions don't work

### Wording enhancements?

The testers have picked this up. Should we change this?

- [ ] OE-534: Singular form of an error needed

### Business Rules needed

- [ ] OE-533: If the asset is from a different mobile device type, it says it will be moved to unallocated, however, this doesn't happen. I reused the old logic, so I think this never happened. It might have been that in some cases half-way it broke and then it was in an unallocated state. Should we re-word it that it COULD end up unallocated?
- [ ] OE-490: I asked previously about the business logic needed here. Previously it would just run the upload FW logic for each asset in the config group, based off of the asset's settings, however, in this story it want some other logic. I then asked if we should just remove the asset's overwritten preferred FW Version in order for the CG FW version to be selected.

### Other questions

- [ ] Should FW Versions be shown and or filtered for MESA only?
- [ ] Permissions and Authentication logic for loading Orgs, Groups, Sites, Assets has not been added. Is it OK to do this at a later stage?
