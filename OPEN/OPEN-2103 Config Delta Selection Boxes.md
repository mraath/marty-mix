---
wiki_ingested: 2026-05-28
status: Ready for Sprint
priority: 1
created: 2026-04-14T00:00
updated: 2026-04-15T00:00
---

# OPEN-2103 UI - Make Config Delta Selection Boxes Sortable and Searchable

JIRA: [OPEN-2103](https://powerfleet.atlassian.net/browse/OPEN-2103)
Parent: [[OPEN-1624]] — Config change analysis tool
Labels: OpsTools
Assignee: Marthinus Raath
Status: Ready for Sprint

## Start Here Tomorrow — Priority Checklist

- [x] Implement search functionality for Organisations selection box
- [x] Implement search functionality for Configuration Groups selection box
- [x] Implement search functionality for Assets selection box
- [x] Implement sort functionality for Organisations selection box
- [x] Implement sort functionality for Configuration Groups selection box
- [x] Implement sort functionality for Assets selection box
- [ ] Test search/sort across all three boxes
- [ ] Verify UI behavior matches design requirements

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
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Description (from Jira)

### Background and Goal

The Config Delta tool in `Powerfleet.Automation.UI` contains three selection boxes - Organisations, Configuration Groups, and Assets - that users interact with to define the scope of a delta comparison. Currently these boxes offer no search or sort capability, making it difficult to locate specific items when the lists are long. This story adds search and sort functionality to all three boxes so users can quickly find and select the items they need.

### User Story

As a user of the Config Delta tool, I want to search and sort the Organisations, Configuration Groups, and Assets selection boxes, so that I can quickly locate and select the correct items without scrolling through unsorted lists.

### Potential UI Behaviour

Each of the three selection boxes (Organisations, Configuration Groups, Assets) will gain:
- A search input field
- Real-time filtering of items based on search text
- Sort options (ascending/descending)
- Sort indicators
- Keyboard navigation support

### Functional Requirements

1. Search box shall filter items in real-time as the user types
2. Search shall be case-insensitive
3. Search shall match partial text in item names
4. Sort buttons/options shall allow ascending/descending sort
5. Current sort order shall be visually indicated
6. Selections shall be maintained when filtering/sorting
7. Empty state message when no results match search
8. Clear search button to reset filtering
9. Default sort order shall be by name ascending
10. Performance shall be maintained with large item lists

### Out of Scope

- Changing the underlying data structure
- API modifications
- Multi-select enhancements beyond search/sort
- Integration with other tools
- Mobile-specific optimizations

### Dependencies

None.

### Notes

1. There is already some search logic for some of those drop-downs - review existing implementations
2. Apply the pattern consistently to all three boxes

## Further Chat Notes

> Add any context from chat/boss instructions that is NOT in the Jira description.

## Branch

> Branch: `Config/MR/Feature/OPEN-2103_SearchSortDropdowns`
> Repo: `Powerfleet.Automation` (API is backend only; most work is in UI)
> Note: Check `Powerfleet.Automation.UI` for the actual Config Delta component

## PR Checklist

- [ ] OPEN-2103 → DEV
- [ ] OPEN-2103 → INT
- [ ] OPEN-2103 → UAT
- [ ] OPEN-2103 → PROD
