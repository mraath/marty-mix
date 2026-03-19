OPEN-1832 Questions

## Question

1) Storage location — where are test case folders created? Local filesystem path, configurable root, or fixed convention?

### Decision

**Existing test cases:** Loaded directly from `public/data/{testName}/diff.json` — no change to current behaviour.

**New test case flow:**
1. User completes creation form (name, standard, org, config groups, assets)
2. UI calls Automation API → Automation API fetches asset configs from Config API
3. Automation API caches each config in `/config/{assetId}.json` with staleness tracking — only assets updated since last save are re-fetched
4. Automation API serves the selected standard from `/standards/`
5. UI receives raw asset configs + standard, runs existing diff logic
6. UI calls a Next.js API route which writes `diff.json` to `public/data/{testName}/` and appends the name to `cases.json`
7. The new test appears in the dropdown; future loads read from file with no API call

**Responsibility split:**
| Layer | Owns |
|-------|------|
| Config API | Source of truth for asset configs |
| Automation API | Fetch, cache, staleness-check configs; serve standards |
| Next.js API route | Write `diff.json` + update `cases.json` |
| UI | Form, diff logic, display |

**Future story — Cloud storage migration:** The local filesystem storage (`/config/`, `/standards/`, `public/data/`) can be migrated to S3 (or equivalent) in a separate story. The interface between layers stays the same — only the read/write target changes.

### Jira summary
> Test case files are stored in `public/data/{testName}/diff.json` following the existing convention. For new test cases, the Automation API fetches and caches asset configs from the Config API (with staleness checking), the UI performs the diff, and a Next.js API route persists the result to the filesystem. Existing test cases load directly from file — no API call needed. A future story will migrate file storage to S3 or equivalent cloud storage.

2) JSON references file schema — what is the exact structure of the references JSON file? (field names, asset identifier type — IMEI, AssetId, or MobileUnitId?)

### Decision

The exact schema (field names, asset identifier type) cannot be confirmed until the OPEN-1834 API contract is known. The "references file" may overlap with the diff output, the standard JSON, or the asset config JSON — this will become clear once OPEN-1834 is defined.

For now, build the UI with a placeholder schema and finalise it once OPEN-1834 is confirmed. If the schema needs to change after that, raise a new story to handle the change — do not block this story on it.

**Deferred to:** New story linked to OPEN-1834.

### Jira summary
> The references file schema depends on the OPEN-1834 API contract which is not yet confirmed. Build the UI against a placeholder schema and finalise field names and asset identifier type (IMEI, AssetId, or MobileUnitId) once OPEN-1834 is defined. Any schema changes after that point will be handled in a separate story.

3) Results file format and naming — what is the format and naming convention of the results file (e.g. results.json)?

### Decision

The results file is named `diff.json` and lives inside a folder named after the test case — `public/data/{testName}/diff.json`. No ambiguity needed; the folder name provides the unique identity.

### Jira summary
> The results file is named `diff.json` and is stored under `public/data/{testName}/diff.json`. The test case name (folder) provides uniqueness — no additional naming convention is required.

4) Folder name collision — what happens when a test case folder with the provided name already exists? (overwrite, error, auto-rename?)

### Decision

Validate the name inline as the user types. If the name matches an existing test case:
- The input field turns red
- The save/submit button is disabled
- An info icon appears next to the field; hovering over it shows "Already in use"

No overwrite, no auto-rename — the user must choose a different name before proceeding.

### Jira summary
> If a test case name already exists, the name input turns red, the submit button is disabled, and an info icon with tooltip "Already in use" is shown. The user must enter a unique name before proceeding. No overwrite or auto-rename behaviour.

5) IMEI availability in asset response — OPEN-1834 returns List<AssetSummary>. Confirm that AssetSummary exposes Description, RegistrationNumber, and IMEI (or equivalent) for the display format Description - Registration Number - IMEI.

### Decision

For now, concatenate a display name from whatever fields are available in the asset response. Use the template `{description} - {registrationNumber} - {imei}` as the target format, but treat the field names as placeholders until OPEN-1834 is confirmed.

Once the OPEN-1834 contract is known, update the display name logic under a new story if the field names differ.

**Deferred to:** New story linked to OPEN-1834 to verify and finalise field mapping.

### Jira summary
> Build the asset multi-select using a concatenated display name in the format `{description} - {registrationNumber} - {imei}`. Field names are placeholders until OPEN-1834 confirms the `AssetSummary` shape. Any changes to the display name logic once the contract is confirmed will be handled in a separate story.

6) Config group API contract — what does the config group endpoint return? (identifier, display name, structure?)

### Decision

Build the config group multi-select shell now using placeholder field names. Wire it up to the actual OPEN-1845 response once that story lands. If the contract requires display changes, raise a new story to handle it.

**Deferred to:** New story linked to OPEN-1845 to verify and finalise field mapping.

### Jira summary
> Build the config group multi-select shell with placeholder field names. Wire it to the actual endpoint once OPEN-1845 is delivered. Any display or field mapping changes required after the contract is confirmed will be handled in a separate story.

7) Asset filtering by config group — does OPEN-1834 accept config group identifiers as a filter parameter, or must filtering be done client-side after loading all assets for the org?

### Decision

The preferred long-term solution is server-side filtering — the API should only return assets belonging to the selected config group(s), avoiding unnecessary data being sent to the UI. This is the cleaner approach and avoids over-fetching.

For now, load all assets for the selected organisation from OPEN-1834 and filter client-side in the UI to match the selected config groups. This unblocks the story immediately.

**Future story:** Move filtering to the Automation API so it passes config group identifiers to OPEN-1834 (or filters internally) and returns only the relevant assets to the UI.

### Jira summary
> For now, all assets for the selected organisation are loaded from OPEN-1834 and filtered client-side by config group. The preferred solution — server-side filtering in the Automation API to avoid over-fetching — will be handled in a separate future story.

---

Q1 — Storage location
Following the existing convention: public/data/{testName}/diff.json. For new test cases, the Automation API fetches and caches asset configs from the Config API (with staleness checking), the UI runs the diff, and a Next.js API route writes the result to the filesystem. Existing test cases load straight from file — no API call needed. Future story to migrate to S3/cloud when the time comes.

Q2 — References file schema
Can't finalise this until OPEN-1834 is confirmed. We'll build against a placeholder schema for now and raise a new story to update it once the contract is known.

Q3 — Results file naming
diff.json, stored under public/data/{testName}/. The folder name handles the uniqueness — no extra naming needed.

Q4 — Folder name collision
Inline validation as the user types. If the name already exists: input goes red, submit disabled, info icon shows tooltip "Already in use". No overwrite or auto-rename.

Q5 — IMEI in asset response
Build the multi-select using {description} - {registrationNumber} - {imei} as the display template. Field names are placeholders until OPEN-1834 confirms the AssetSummary shape. New story to update if anything changes.

Q6 — Config group API contract
Same approach as Q5 — build the multi-select shell now, wire it once OPEN-1845 lands. New story if the contract requires display changes.

Q7 — Asset filtering by config group
We prefer the API to handle this — only returning assets for the selected config group(s) rather than sending everything to the UI. To get going, we'll filter client-side for now (load all assets for the org, filter in the UI by selected config groups). A follow-up story will move this to the API properly.
