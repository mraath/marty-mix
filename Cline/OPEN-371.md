---
wiki_ingested: 2026-05-28
created: 2025-08-07T10:31
updated: 2025-08-08T09:43
---
Here's the detailed comparison of the variables and their handling:

1. Initialization Differences:

Config Groups:
- Initialized in fetchGroupsSelectionCriteriaGrid()
- configGroupsColumnSettings comes from gridSelectionCriteriaService.getDefaultColumnSettings()
- configGroupsHiddenColumnSettings from getAllowedHiddenColumns()
- Uses ConfigGroupsColumnSettings.items as local defaults

Assets:  
- Initialized in fetchAssetsSelectionCriteriaGrid()
- assetsColumnSettings comes from same service but with assets key
- assetsHiddenColumnSettings similarly from assets key
- Uses ConfigGroupsAssetsColumnSettings.items as local defaults

2. Array Maintenance:

Config Groups:
- configGroupsColumns array built from hiddenColumnSettings
- Maintained through setupConfigGroupsGrid()
- Persisted via columnReordered()

Assets:
- assetsColumns array built similarly but with assets settings  
- Additional date formatting logic applied
- Persisted via assetsColumnReordered()

3. Key Differences That Could Affect Persistence:

- Assets grid has more complex column definitions (date formatting)
- Assets grid has lazy loading which might reset state
- The locked columns differ between grids ("configurationGroupName" vs "assetDescription")
- Assets grid might refresh more frequently due to lazy loading

4. Potential Issues:

- If assetsColumns array gets rebuilt during lazy loading, it might lose ordering
- Date formatting might cause unexpected behavior in persistence
- Different refresh patterns between grids could affect consistency

Would you like me to:
1. Examine the gridSelectionCriteriaService implementation
2. Analyze the lazy loading impact on assets grid  
3. Or focus on another specific aspect?

---

Here's the analysis of how lazy loading impacts assets column ordering persistence:

1. Lazy Loading Implementation in Assets Grid:
- Three types of lazy loading:
  * Alerts (lazyLoadingAlerts)
  * CAN lines (lazyLoadingLines)
  * Flags (lazyLoadingFlags)
- Each makes API calls when certain columns are accessed
- Updates the assetsColumns array with new data

2. Impact on Column Ordering:
- Each lazy load triggers UpdateAlertsRows() or UpdateLinesRows()
- These methods modify the assetsColumns array directly
- The grid refreshes/re-renders after lazy loads
- Current implementation doesn't explicitly preserve column order during these updates

3. Key Differences from Config Groups:
- Config groups grid has no lazy loading mechanism
- Assets grid's frequent data updates may interfere with persistence
- Column order state might get lost during lazy load refreshes

4. Potential Issues Found:
- No explicit column order preservation in lazy load handlers
- Grid refreshes may reset column states
- Modified assetsColumns array might not maintain ordering
- Persisted order not being reapplied after lazy loads

5. Suggested Solutions:
- Store column order before lazy loads and reapply after
- Modify lazy load handlers to preserve ordering
- Add order persistence logic to UpdateAlertsRows/UpdateLinesRows

Would you like me to:
1. Propose specific code changes to fix this
2. Examine the service layer's role in this issue
3. Or analyze another aspect of the lazy loading impact?

Please let me know how you'd like to proceed with addressing the lazy loading impact on column persistence.

---

Based on this new information, here are the most likely new areas to investigate:

- [ ] grid-selection-criteria.service.ts: Check the persistence logic within the changeColumnOrdering method of this service. It's possible the service is not correctly saving the data it receives for assets. The logic may have a bug or a different variable name in its internal state that is causing the failure.
  - [ ] CHECK what goes in
  - [ ] CHECK what goes out
- [ ] The Component Initialization: Another possibility is that the assetsColumnSettings are not being correctly loaded when the component initializes. Check the ngOnInit method and related functions to ensure the persisted data is correctly retrieved and used to set the initial column order.
- [ ] The Persistence Mechanism Itself: The issue may not be in the front-end code at all. There could be a problem with the API call or database persistence on the backend that handles saving the column order for assets.

