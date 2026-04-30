---
status: In Progress Dev
priority: 1
created: 2026-04-23T00:00
updated: 2026-04-23T00:00
---

# OPEN-2104 UI - Add Custom Standard File Selection to Config Delta Tool

JIRA: [OPEN-2104](https://powerfleet.atlassian.net/browse/OPEN-2104)
Parent: [[OPEN-1624]] — Config change analysis tool
Labels: OpsTools
Assignee: Marthinus Raath
Status: In Progress Dev

## Start Here Tomorrow — Priority Checklist

- [x] Replace standard file `<select>` with MultiSelectList singleSelect combobox (search + sort)
- [x] Add "Custom (Asset)..." option — opens inline org → config group → asset picker (single-select)
- [x] On asset selection: combobox trigger updates to "[asset] · [org]", picker collapses
- [x] create-case route: fetches custom standard asset config, stores as `__custom_standard__` sentinel
- [x] generate route: detects sentinel, writes its JSON as standard.json
- [ ] Test end-to-end: select custom asset standard, create case, run diff, verify correct baseline used

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

The Config Delta tool in `Powerfleet.Automation.UI` currently only supports a pre-supplied standard file as the baseline for configuration comparison. Users have no way to designate a custom asset's config as the comparison standard, limiting the tool's flexibility for real-world comparison scenarios.

The goal is to add a **Custom** option to the standard file selector that allows the user to pick any single asset from the system and use its config JSON as the comparison baseline.

### User Story

As a user of the Config Delta tool, I want to select a custom asset as the comparison standard, so that I can compare other assets' configurations against any asset's config JSON — not just the pre-supplied standard file.

### Potential UI Behaviour

- The standard file selector gains a new **"Custom"** option alongside the existing supplied options.
- When the user selects **"Custom"**, the same asset selection flow as the "+" (add) icon is triggered:
  - Step 1: Select an **Organisation**
  - Step 2: Select a **Config Group**
  - Step 3: Select an **Asset** (single-select only)
- The asset selection in this flow is **single-select only** — multi-selection is not permitted.
- Once an asset is selected, its config JSON file is loaded and used as the comparison standard.
- The selection of assets being **compared** (right-hand side) is **not affected** by this change — existing behaviour is preserved entirely.
- If the user previously selected "Custom" and then switches back to the supplied option, the custom selection is cleared.

### Functional Requirements

1. Add a "Custom" option to the standard file selector dropdown/list in the Config Delta tool.
2. When "Custom" is selected, open the org → config group → asset selection flow (matching the existing "+" icon flow).
3. In this flow, enforce **single-asset selection** — disable or hide multi-select controls.
4. On asset confirmation, fetch and use the selected asset's **config JSON file** as the standard for comparison.
5. Do **not** modify the existing selection mechanism for the assets being compared.
6. Do **not** change the behaviour of the supplied standard file option.

### Out of Scope

- Changes to the assets-to-compare selection (right-hand side of the delta tool).
- Any new backend API endpoints — the existing config JSON fetch for an asset is confirmed to already be available.
- Multi-asset selection for the custom standard.
- Persisting the custom standard selection across sessions.

### Notes

- The selection UX for "Custom" must mirror the existing "+" icon flow exactly, except limited to single-asset selection.
- The term "standard file" refers to the baseline config used for comparison; the custom path simply changes the source of that baseline.
- The config JSON fetch for a given asset already exists as a service call — no new backend call is needed.

## Further Chat Notes

> Add any context from chat/boss instructions that is NOT in the Jira description.

## Branch

> Branch: `Config/MR/Feature/OPEN-2104_CustomStandardFile`
> Repo: `Powerfleet.Automation.UI` (UI-only change; no backend work needed)

## PR Checklist

- [ ] OPEN-2104 → DEV
- [ ] OPEN-2104 → INT
- [ ] OPEN-2104 → UAT
- [ ] OPEN-2104 → PROD
