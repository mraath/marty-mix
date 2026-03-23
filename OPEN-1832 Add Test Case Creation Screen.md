---
status: In Progress Dev
priority: 1
created: 2026-03-18T00:00
updated: 2026-03-20T10:13
---

# OPEN-1832 Add Test Case Creation Screen

JIRA: [OPEN-1832](https://powerfleet.atlassian.net/browse/OPEN-1832)
Parent: [[OPEN-1624 Config Change Analysis Tool]] — Config change analysis tool
Labels: OpsTools
Assignee: Marthinus Raath
Status: In Progress Dev

---

## Start Here Tomorrow — Priority Checklist

### Phase 1 — BLAST Blueprint (Data Schemas & Architecture)
- [ ] Define TypeScript interfaces in `contracts.ts`: `Organisation`, `ConfigGroup`, `AssetSummary`, `TestCaseReferences`, `CreateTestCaseRequest`
- [ ] Create `architecture/test-case-creation.md` — SOP: data flow, API calls, file storage, edge cases

### Phase 2 — BLAST Link (Proxy Routes)
- [ ] Add `config` host entry to `api-urls.ts` for Automation API config endpoints
- [ ] Create proxy route `src/app/api/proxy/config/organisations/route.ts` → `api/config-allowed-organisations/` (OPEN-1833)
- [ ] Create proxy route `src/app/api/proxy/config/groups/route.ts` → `api/config-configurationgroups/groupId/{groupId}` (OPEN-1845)
- [ ] Create proxy route `src/app/api/proxy/config/assets/route.ts` → `api/config/assets/{organisationId}` (OPEN-1834)
- [ ] Verify all 3 proxy routes return data (smoke test against dev environment)

### Phase 3 — BLAST Architect (Service Layer)
- [ ] Create `src/services/testCaseService.ts` — typed fetch functions for orgs, config groups, assets (wraps proxy routes)

### Phase 4 — BLAST Architect (UI — Creation Form)
- [ ] Create `src/components/delta/TestCaseCreationModal.tsx`:
  - [ ] Test case name input + inline duplicate validation (red border, "Already in use" tooltip, disabled submit)
  - [ ] Standard file path input (text field for now — points to path on server)
  - [ ] Organisation single-select dropdown (populated from API)
  - [ ] Config group multi-select (enabled after org selected; cleared on org change)
  - [ ] Asset multi-select (enabled after config group(s) selected; display: `description - registrationNumber - imei`; cleared on config group change; client-side filter by selected config groups)
  - [ ] Submit button — disabled until all fields valid
- [ ] Update `ConfigDeltaView.tsx` — add "New Test Case" button to header, wire to modal

### Phase 5 — BLAST Architect (Persistence API Route)
- [ ] Create `src/app/api/delta/create-case/route.ts`:
  - [ ] Accept `CreateTestCaseRequest` payload
  - [ ] Call Automation API diff endpoint (OPEN-1744 — `ActionConfigDeltaAsync`) with selected assets and standard
  - [ ] Write response to `public/data/{testCaseName}/diff.json`
  - [ ] Append `testCaseName` to `public/data/cases.json`
  - [ ] Return success/error

### Phase 6 — BLAST Stylize
- [ ] Style modal: glassmorphism panel, premium CSS, consistent with existing ConfigDeltaView dark theme
- [ ] Loading states: spinner on org/group/asset dropdowns while fetching
- [ ] Error states: friendly inline messages if API calls fail

### Phase 7 — Verification
- [ ] End-to-end test: create a new test case → verify `diff.json` + `cases.json` updated → verify new case appears in dropdown
- [ ] Verify existing test cases still load from file (no regression)
- [ ] `dotnet build` / `next build` — zero errors

---

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

---

## Description (from Jira)

Add a test case creation screen to the Config Change Analysis Tool UI (`Powerfleet.Automation.UI`).

A test case represents a comparison between a group of asset configuration files and a single standard configuration file. The creation screen allows the user to:
- Name the test case
- Select a standard configuration file
- Select an organisation
- Select one or more config groups within that organisation
- Choose assets from those groups to compare

The test case is stored as `public/data/{testCaseName}/diff.json`. On first run, configs are fetched and the comparison is performed. On subsequent runs, results are loaded directly from the saved file.

**No changes to the Automation API layer** — this story consumes existing endpoints only.

---

## Further Chat Notes

### Architecture Decision (from Q&A session 2026-03-18)

**Data flow for new test case creation:**
1. User completes form (name, standard path, org, config groups, assets)
2. UI calls Automation API → Automation API fetches asset configs from Config API (with staleness/caching)
3. Automation API serves selected standard from `/standards/`
4. UI receives raw asset configs + standard, **runs existing diff logic** (already in ConfigDeltaView)
5. UI calls Next.js API route → writes `diff.json` to `public/data/{testCaseName}/` and appends name to `cases.json`

**Existing test cases:** Load directly from `public/data/{testName}/diff.json` — no change.

| Layer | Owns |
|-------|------|
| Config API | Source of truth for asset configs |
| Automation API | Fetch, cache, staleness-check configs; serve standards |
| Next.js API route | Write `diff.json` + update `cases.json` |
| UI | Form, diff logic, display |

### Dependency Chain (for planning)

```
OPEN-1832 (UI — this story)
  ├── OPEN-1833  →  api/config-allowed-organisations/         [org dropdown]
  ├── OPEN-1845  →  api/config-configurationgroups/groupId/{groupId}  [config group multi-select]
  │     └── OPEN-1844  (blocks OPEN-1845 — Grant's story, In Code Review)
  ├── OPEN-1834  →  api/config/assets/{organisationId}        [asset multi-select]
  └── OPEN-1744  →  ActionConfigDeltaAsync                    [diff execution]
```

**Build UI shells now with placeholder field names. Wire up once each dependency lands.**

### Answered Open Questions

| # | Question | Decision |
|---|----------|----------|
| Q1 | Storage location | `public/data/{testName}/diff.json`. Automation API caches configs; UI runs diff; Next.js route writes result. Future story: S3 migration. |
| Q2 | References file schema | Deferred — build against placeholder schema; finalise once OPEN-1834 confirmed. New story for changes. |
| Q3 | Results file naming | `diff.json` under `public/data/{testName}/`. Folder = unique identity. |
| Q4 | Folder name collision | Inline validation: red input, disabled submit, "Already in use" tooltip. No overwrite. |
| Q5 | IMEI in asset response | Display: `{description} - {registrationNumber} - {imei}` (placeholders until OPEN-1834 confirmed). |
| Q6 | Config group contract | Build multi-select shell now; wire once OPEN-1845 delivers. New story for display changes. |
| Q7 | Asset filtering | Client-side for now (load all assets for org, filter by config groups). Future story: move filtering to API. |

### Boss Context (2026-03-18)

Story relationship overview:
- OPEN-1832 = main UI story (this one)
- OPEN-1833 = get orgs (for org dropdown)
- OPEN-1845 + OPEN-1844 = get config groups (for config group multi-select)
- OPEN-1834 = get asset list (for asset multi-select)
- OPEN-1835 = TBD — investigate where this slots in
- OPEN-1744 = diff endpoint — invoked at creation time

**Approach:** Build all UI shells now. Wire each component as its dependency API story lands. Keep shells behind "stub" data until wired.

---

## TEST DATA

```
[
  {
    "AssetId": 1631447698450665472
  }
]
```

|     |     |     |         | Name                     | AssetID             |                            |                 |     |     |
| --- | --- | --- | ------- | ------------------------ | ------------------- | -------------------------- | --------------- | --- | --- |
|     |     |     |         | _001 MiX4000 + STM 2.0   | 1646589414582132736 | 19.03.26 1:24 (GMT+08:00)  | 354762110254171 |     |     |
|     | 2   |     | MiX4000 | _002 Streamax Standalone | 1639409265540190208 | 29.10.25 23:49 (GMT+08:00) | 564113543154535 |     |     |
|     | 1   |     | MiX4000 | 002 MiX4000 预告片 垃圾车      | 1631447698450665472 |                            |                 |     |     |

RESULT:

```
504 Gateway Time-out
```


---
## Branch

> Branch: `Config/MR/Feature/OPEN-1832_TestCaseCreationScreen` (Powerfleet.Automation.UI)

---

## PR Checklist

- [ ] OPEN-1832 → DEV
- [ ] OPEN-1832 → INT
- [ ] OPEN-1832 → UAT
- [ ] OPEN-1832 → PROD
