---
status: In Progress Dev
priority: 1
created: 2026-04-24T00:00
updated: 2026-04-24T00:00
---

# OPEN-1653 UI - Select source and comparison configs for same-asset config comparison

JIRA: [OPEN-1653](https://powerfleet.atlassian.net/browse/OPEN-1653)
Parent: [[OPEN-1624]] — Config change analysis tool
Labels: OpsTools
Assignee: Marthinus Raath
Status: In Progress Dev

## Start Here Tomorrow — Priority Checklist

- [x] Add same-asset / cross-asset toggle to the config comparison page
- [x] Wire org and config group filters for asset selection
- [x] Build asset picker (filtered list, single select)
- [x] Build two version pickers from selected asset's config history
- [x] Disable "Compare" action until both versions are selected
- [x] Handle <2 versions edge case with user-facing message
- [x] Wire up actual MiX API method in `MiXServiceWrapper.GetAssetConfigVersionsAsync` — uses `GetLoadedConfigTextSummaryForMobileUnit` + `GetPendingConfigTextSummaryForMobileUnit` via IMEI → mobileUnitId mapping; returns "Currently Loaded" and "Pending" versions
- [x] Implement real version history: queries `[dynamix].[ConfigurationVersions]` directly via `IConfigRepository` (same `DeviceConfigDb` connection) — returns all historical versions with real `ConfigurationVersionId`, `Version` string, and `DateGenerated` timestamp. NOTE: never call DynaMiX.Backend directly — always go via the shared DB or Config.Api.

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

The config change analysis tool (OPEN-1624) allows operators to compare two configurations. When the source and compared configs belong to the same asset, the user needs to select that asset once (using organisation/configuration group filters) and then choose two different versions from that asset's config history — an earlier version as the source and a later version as the comparison target. This story covers only the same-asset selection flow.

### User Story

As an operator using the config change analysis tool, I want to select a single asset and then choose two different config versions for that asset (source and compared), so that I can see what configuration changes were made to that asset over time.

### Potential UI Behaviour

- The user is presented with a toggle or selector to indicate whether the comparison is same-asset or cross-asset. This story covers the same-asset path.
- When same-asset is selected, the user filters by organisation and/or configuration group to narrow the asset list, then selects a single asset.
- Once the asset is selected, two version pickers are shown: one for the source (earlier version) and one for the compared (later/newer version), each populated from that asset's config history.
- The user must select both a source and a compared version before proceeding. The UI prevents proceeding with only one selection.

### Functional Requirements

1. Display a selector for the user to indicate whether the comparison involves the same asset or different assets. This story covers the same-asset path only.
2. When same-asset is selected, provide organisation and configuration group filters to narrow the asset list.
3. Allow the user to select a single asset from the filtered list.
4. Once an asset is selected, display two version pickers populated from that asset's config history: one for source (earlier) and one for compared (later/newer).
5. Both version pickers must be populated and a selection made in each before the comparison can proceed.
6. If the asset has fewer than two config versions in history, display an appropriate message and prevent the comparison from being initiated.

### Out of Scope

- Cross-asset comparison (different source and compared assets) — covered by the new split story.
- Performing or rendering the actual config comparison — separate story.
- Defining what constitutes a "config version" or how version history is stored/retrieved — backend concern.
- Organisation/configuration group filter data loading — organisations are loaded via `IMiXServiceWrapper.GetAvailableOrganisationGroupsAsync` and configuration groups via `IMiXServiceWrapper.GetConfigurationGroupSummaries`; wiring these to the UI filter controls is in scope but the wrapper methods themselves are not.

### Notes

1. The same-asset / cross-asset toggle establishes the two paths for config selection. Only the same-asset path is in scope here; the cross-asset path is in the new split story.
2. "Earlier" vs "later" version ordering in the version picker should be confirmed with the PO — it is not yet clear whether the UI enforces ordering or just labels them source/compared.

## Further Chat Notes

> Add any context from chat/boss instructions that is NOT in the Jira description.

## Branch

> Branch: `Config/MR/Feature/OPEN-1653_SameAssetConfigComparison`
> - `Powerfleet.Automation` (backend — .NET API)
> - `Powerfleet.Automation.UI` (frontend — Next.js)

## PR Checklist

- [ ] OPEN-1653 → DEV
- [ ] OPEN-1653 → INT
- [ ] OPEN-1653 → UAT
- [ ] OPEN-1653 → PROD
