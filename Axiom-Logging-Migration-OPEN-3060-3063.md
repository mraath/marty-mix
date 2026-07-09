---
created: 2026-07-09T00:00
tags: [axiom, logging, opstools, aws, ado]
---

# Axiom Logging Migration — OPEN-3060/3061/3062/3063

Added `AxiomLogger` dual-logging (alongside existing `TextFileLogger`) to 4 Operations Tools repos. All confirmed live and logging on INT as of 2026-07-09 — see [[Need Parent/LOG]] for the query.

## Tickets & PRs

| Ticket | Repo | Original PR | Dataset-name fix PR | Other fixes |
|---|---|---|---|---|
| [OPEN-3060](https://powerfleet.atlassian.net/browse/OPEN-3060) | Powerfleet.Automation | [#149903](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation/pullrequest/149903) | [#149971](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation/pullrequest/149971) | — |
| [OPEN-3061](https://powerfleet.atlassian.net/browse/OPEN-3061) | ConfigTools.API | [#149905](https://dev.azure.com/MiXTelematics/OperationsTools/_git/ConfigTools.API/pullrequest/149905) | [#149972](https://dev.azure.com/MiXTelematics/OperationsTools/_git/ConfigTools.API/pullrequest/149972) | — |
| [OPEN-3062](https://powerfleet.atlassian.net/browse/OPEN-3062) | Powerfleet.Analyzer | [#149970](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Analyzer/pullrequest/149970) | [#149974](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Analyzer/pullrequest/149974) (re-submit — first fix commit dropped by a merge race) | — |
| [OPEN-3063](https://powerfleet.atlassian.net/browse/OPEN-3063) | SupportTools | [#149967](https://dev.azure.com/MiXTelematics/OperationsTools/_git/SupportTools/pullrequest/149967) | [#149973](https://dev.azure.com/MiXTelematics/OperationsTools/_git/SupportTools/pullrequest/149973) | [#149975](https://dev.azure.com/MiXTelematics/OperationsTools/_git/SupportTools/pullrequest/149975) blank-token fix |

All 4 tickets: reviewed and approved by me (Marthinus) directly on 2026-07-09, transitioned to **Ready for QA**.

## Azure DevOps pipelines

| Repo | Pipeline | ID |
|---|---|---|
| Powerfleet.Analyzer.API | build+deploy | 2544 |
| Powerfleet.Analyzer.UI | build+deploy | 2545 |

## AWS — INT environment

- Account: `601704920959`, region `eu-west-1`
- Cluster: `INT-Config`
- Service (Analyzer): `int-powerfleet-analyzer-api`
- CloudWatch log group: `/ecs/int-powerfleet-analyzer-api`
- Login: see [[AWS-CLI-Login]]

## Axiom dataset mapping (all 4 repos, corrected 2026-07-09)

Only 3 real Axiom datasets exist org-wide — never invent per-repo names:
- `int-logs` — DEV, INT
- `uat-logs` — UAT
- `prod-logs` — everything else (AU, ENT, NL, Nordic, UAE, UK, US, ZA, ZAGOV, base appsettings.json)

Field to filter on: `appName` (lowercase). Values: `Powerfleet.Automation.Api`, `ConfigTools.API.Api`, `Powerfleet.Analyzer.Api`, `SupportTools.Api`. Full query in [[Need Parent/LOG]].
