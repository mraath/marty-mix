---
status: Committed
priority: 1
created: 2026-04-09T00:00
updated: 2026-04-14T16:48
---

# OPEN-2029 Persist Config Diff to Database

JIRA: [OPEN-2029](https://powerfleet.atlassian.net/browse/OPEN-2029)
Parent: [[OPEN-1624]] — Config change analysis tool
Labels: OpsTools
Assignee: Marthinus Raath
Status: Committed

## Start Here Tomorrow — Priority Checklist

- [ ] Create database table in DynaMiX.DeviceConfig for test cases
- [ ] Implement API endpoints in Powerfleet.Automation (CRUD for cases, diff retrieval)
- [ ] Update Automation UI to fetch/persist cases from database
- [ ] Remove container filesystem storage (cases.json, asset JSONs, case folders)
- [ ] Test persistence across ECS task restarts
- [ ] Deploy to DEV, INT, UAT, PROD

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

### Problem
Currently, test cases are stored in a static `cases.json` file and individual folders on the container filesystem (`public/data/<caseName>/`). The computed `diff.json` also lives on the filesystem. Both are **lost on every ECS task restart**, making test cases and diffs non-persistent across sessions.

### Proposed Solution
Move test case storage entirely to the database. All fields currently in `cases.json` are stored in a new DB table, including the computed diff. The standards folder remains on the filesystem — it holds the reusable standard JSON files used as comparison baselines. All other container files (`asset JSONs`, `case folders`, `cases.json`, `diff.json`) are removed.

### Scope

#### 1. DynaMiX.DeviceConfig — Database Migration
- Create a new table `TestCases` (schema TBD by API requirements)
- Fields: CaseId, CaseName, CreatedDate, StandardId, CaseData (JSON), ComputedDiff (JSON), UpdatedDate
- Add entity model, DbContext mapping
- Add migration script

#### 2. Powerfleet.Automation (API)
- Add GET `/api/testcases` — list all cases
- Add POST `/api/testcases` — create new case
- Add GET `/api/testcases/{caseId}` — fetch single case
- Add PUT `/api/testcases/{caseId}` — update case
- Add DELETE `/api/testcases/{caseId}` — delete case

#### 3. Automation UI
- Update case creation/edit UI to POST to new API endpoints
- Fetch cases from `/api/testcases` on page load
- Persist case name, uploaded standards, and computed diff to database
- Remove localStorage/sessionStorage fallback for cases
- Remove public/data folder reference
- Update diff display to show database-persisted results

### Output
Test cases and diffs are fully persistent across ECS restarts. The container filesystem holds only the standards folder. No S3, EFS, or file-based hacks required.

## Further Chat Notes

> See POW-11 task context: This story touches 3 repos (DynaMiX.DeviceConfig for DB, Automation API for CRUD endpoints, Automation UI for client integration). Boss expects the feature to work before tackling persistence — confirm feature works first in existing filesystem mode, then migrate.

## Branch

> Branch: `Config/MR/Feature/OPEN-2029_ConfigDiffDatabase`

## Some feedback from my side

- You mentioned that you will add database tables to store associated assets with configs. We dont need to store the Assets' configs.... only the DIFFs per test (for now)
- So if this means it is the endpoint to save the actual config for assets - then we could remove that as well "- POST `/api/configdiff/cases/{caseId}/assets` - save asset configs for a case"
- You asked about this and I also think it should go to the API "For the diff generation script, I need to decide whether to keep it as a Node script that reads from the database or refactor it into an API endpoint. The current flow has the UI calling `POST /api/delta/generate` which triggers the script to read files and write the diff. After migration, I could either update the script to fetch data from the database and write results back, or move the logic entirely into an API route that handles the database operations directly."
- 

## PR Checklist

- [ ] OPEN-2029 → DEV
- [ ] OPEN-2029 → INT
- [ ] OPEN-2029 → UAT
- [ ] OPEN-2029 → PROD
