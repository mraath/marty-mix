# OPEN-2103 — UI: Config Delta Selection Boxes — Sortable & Searchable

**Jira:** https://powerfleet.atlassian.net/browse/OPEN-2103  
**Parent Epic:** OPEN-1624 (Config change analysis tool)  
**Status:** Reopened for implementation  
**Priority:** To be set  
**Assignee:** Marthinus Raath

## Branch
`Config/MR/Feature/OPEN-2103_ConfigDeltaSearchSort`

## Background and Goal

The Config Delta tool in `Powerfleet.Automation.UI` contains three selection boxes:
- Organisations
- Configuration Groups  
- Assets

These boxes offer no search or sort capability, making it difficult for users to locate specific items when lists are long. This story adds search and sort functionality to all three boxes.

## User Story

As a user of the Config Delta tool, I want to search and sort the Organisations, Configuration Groups, and Assets selection boxes, so that I can quickly locate and select the correct items without scrolling through unsorted lists.

## Potential UI Behaviour

Each of the three selection boxes will gain:
1. A search/filter input field at the top to filter items in real-time
2. Sorting toggles or options (alphabetical A-Z / Z-A)
3. Clear button to reset search/filters
4. Item count display showing filtered vs total items
5. Keyboard navigation support (arrow keys, Enter to select)

## Functional Requirements

1. Search input must filter list items in real-time as the user types
2. Search must be case-insensitive
3. Sort options (ascending/descending) must be available for each box
4. Sorted order must persist across user interactions within the same session
5. Clear button must reset both search and sort to defaults
6. Item count must display as "X of Y items" format
7. Search must support partial matching (e.g., searching "org" finds "Organisation")
8. No API calls required — sorting/searching happens client-side
9. Visual indicators must show which column is currently sorted (icon, color, etc.)
10. Mobile responsiveness must be maintained

## Out of Scope

1. Remembering sort preferences across sessions/page reloads
2. Advanced filter options (multiple criteria, date ranges, etc.)
3. Pagination — assume lists fit in viewport
4. Custom sort order (drag-and-drop reordering)

## Dependencies

None.

## Notes

1. The three selection boxes are used in the Config Delta form — keep styling consistent with existing form elements
2. Coordinate with the backend if needed to understand list data structure (though search/sort is client-side)

## Priority Checklist

- [x] Create/update search and sort components or enhance existing select components
  - Enhanced MultiSelectList with sort toggle and clear button
  - Created new SingleSelectDropdown for single-select with search/sort
- [x] Wire search input to filter visible items
  - Case-insensitive substring matching on all items
  - Real-time filtering as user types
- [x] Implement sort toggle/dropdown
  - A-Z ▲ / Z-A ▼ buttons on all boxes
  - Affects both filtered and full lists
- [x] Add item count display
  - MultiSelectList: "X of Y items" in select-all row
  - SingleSelectDropdown: "Showing X of Y items" at bottom
- [ ] Implement keyboard navigation (if not already present)
  - Auto-focus on search input when dropdown opens
  - Standard browser keyboard navigation for selects (Tab, Arrow keys, Enter)
- [ ] Test across Organisations, Configuration Groups, and Assets boxes
- [ ] Verify mobile responsiveness
- [ ] Update Jira with completion details
