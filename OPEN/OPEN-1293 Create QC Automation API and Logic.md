---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-06T10:24
---

# OPEN-1293 Create QC Automation API and Logic

Date: 2026-02-06 Time: 10:18
Parent:: ==xxxx==
Friend:: [[2026-02-06]]
JIRA:OPEN-1293 Create QC Automation API and Logic
==URL TO JIRA==


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
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## OPEN-1293 – Create QC Automation API and Logic

## Description
Create an API and logic to manage automations of commonly repeated support tasks, currently done manually and prone to errors. First candidates:
- **Quality control** after installation
- **Decommissioning** of devices

The API endpoint will be a conduit between the originating platform (e.g. **Salesforce**) and the different APIs that perform the tasks. It does not interact directly with the source or target platforms. Helper methods may be implemented but also do not interact directly.

### Technical Notes
- Should follow the Daemon pattern for consistency.
- Logging is done to a text file.
- Pending / Failed cases are stored in JSON format.

### APIs Used
- Config API
- ResourceData API
- Salesforce API
- Fleet Authentication API

### Database Changes
- For QC automation, `mobileunit.MobileUnits` needs a new QC inspection status field:
  - `QCStatus` (byte): 0 = Pass, 1 = Fail, 2 = Pending
  - May impact stored procedures that load from this table but should not break current functionality.

### Dependencies & Blockers
- All child stories must be completed for this to be marked as done.

## Acceptance Criteria

### Service Architecture
- When a request is received, it routes to the appropriate automation workflow without directly interacting with source/target platforms.
- Given multiple API integrations, when the service processes a request, it delegates to the correct helper methods/adapters.
- When processing begins, the service logs the request.

### Quality Control After Installation Automation
- Given QC automation is triggered from Salesforce, when the service receives installation details, it actions the QC workflow through the appropriate APIs and logs each step.
- When QC automation completes and all checks pass, the service returns success with validation results and logs the pass.
- When QC automation fails, the service returns detailed error information, halts processing, and logs the failure.
- When QC automation lacks information (e.g. trip info), the service persists the case with a reason, logs it, and later retries; it returns a pending status with validation results.

### Device Decommissioning Automation
- Given a decommissioning request from Salesforce, when processed, the service executes all required decommissioning steps in the correct sequence and logs each step.
- Given a decommissioning workflow, when each step completes, the service validates the result before the next step.
- Given decommissioning fails at any step, the service rolls back completed steps (where applicable) and reports the failure state.

### Error Handling & Resilience
- Given an API call fails transiently, the service retries with backoff and logs the failure.
- In such failures, the service persists the case with full error context, logs it, and later retries processing.

## Meta

- Type: Story
- Epic: OPEN-1264 – Unity MX Installation QC Automation – Phase 1
- Labels: Automation, OpsTools
- Assignee: William King
- Story Points: 8
- Sprint: Operations Tools Sprint 26.5
- Team: Operations Tools
- Created: 9 December 2025, 13:20
- Updated: 4 days ago

## Code


## Branch

> Branch: Config/MR/Feature/OPEN-1293 Create QC Automation API and Logic.INT

## PR

- [ ] OPEN-1293 Create QC Automation API and Logic > DEV
- [ ] OPEN-1293 Create QC Automation API and Logic > INT
- [ ] OPEN-1293 Create QC Automation API and Logic > UAT
- [ ] OPEN-1293 Create QC Automation API and Logic > PROD
