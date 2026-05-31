# Wiki Log — Powerfleet Engineering Knowledge Base

> Append-only. Format: `## [YYYY-MM-DD] {operation} | {title}`
> Parse tip: `grep "^## \[" log.md | tail -10`

## [2026-05-29] ingest | raw/GitHub Login.md
- Pages created: Powerfleet-GitHub-Enterprise (entity), github-login (source)
- Pages updated: index.md
- Contradictions flagged: none

## [2026-05-28] ingest | Final batch — journals, diagrams, Need Parent, misc (2,149 files)
- Folders: Need Parent (374), Daily Merge (120), DailyNotes (1036), WeeklyNotes (189), MonthlyNotes (4), textgenerator (228), Excalidraw (49), docs (55), WIP (11), Some Day (9), Streamax (4), Personal (3), DST stragglers (3), misc (62)
- Pages created: none (journals and prompts — no new entities)
- Result: ALL vault .md files outside wiki/ now carry wiki_ingested: 2026-05-28

## [2026-05-28] ingest | Remaining clusters — batch (356 files)
- Folders: SRs (53), SQL (37), Done (54), QA (27), AC (7), Frangular (7), content (77), Notes (2), Parked (2), I3 (4), Spaces (1), Root (85)
- Pages created: Alerts-Feature (concept), DynaMiX-Backend (entity), Decommissioning-Automation (concept)
- Pages updated: Config-Groups-Page, Ops-Tools, Config-Api
- Contradictions flagged: none

## [2026-05-28] ingest | Cluster 4 — ETS tickets (9 files)
- Files tagged: ETS-2017, 2199, 2241, 2976, 3021, 3234, 6021, 6168, 6874 (ETS-8669 already done)
- Pages created: ets-tickets-cluster4 (source)
- Pages updated: Config-Groups-Page (known bugs)

## [2026-05-28] ingest | Cluster 3 — OE/Config Groups (71 files)
- Files tagged: 71 files across OE/, OE Config Groups Page/, OE BUGS/
- Pages created: Config-Groups-Page (concept), oe-config-groups-cluster3 (source)
- Pages updated: Ops-Tools

## [2026-05-28] ingest | Cluster 2 — OPEN tickets (79 files)
- Files tagged: OPEN-235 through OPEN-2320 (all 79)
- Pages created: open-tickets-cluster2 (source)
- Pages updated: Ops-Tools, Config-Delta-Tool, Powerfleet-Automation-AWS

## [2026-05-28] ingest | Cluster 1 — AWS/Automation Infrastructure (22 files)
- Files tagged: Automation Infrastructure Setup Guide, Global_Deployment_Guide, Production Servers, AWS Servers, AU-Automation-Setup-Summary, AWS Troubleshooting and Python Learnings, au_infrastructure_audit_and_fixes, Notes/ZAGOV-AWS-Deployment, Automation API Build Fixes 20260311, Automation API 20260311 Feedback, Automation UI URLs, AWS_TAGS, AWS New, Deployments 25.11/25.17, Config Settings Production Lightning, Demo - Powerfleet Automation Deployment Walkthrough
- Pages created: AWS-Environments, Powerfleet-Automation-AWS, ZAGOV-Environment (entities); AWS-Deployment-Pattern (concept); automation-infra-setup-guide, global-deployment-guide, au-automation-setup, zagov-aws-deployment (sources)
- Pages updated: Ops-Tools
- Contradictions flagged: none

## [2026-05-28] ingest | Remaining DST files tagged (batch 2)
- Files tagged: TECHDEBT-190, TECHDEBT-427, SAAS-10447, SRE-212 (×2), LOG Command 45, SR-12935, SR-12041, SR-14647, SR-15476, SR-15477, SR-15627, QA-5861, CONFIG-3387, SQL Command 45 (×5), DaylightSavingsManager, DaylightSavingsTimeAdjuster, DynaMiX.Services.DaylightSavingAdjustment, Adjust* DST controller/method/route (×4)
- Pages updated: none (reference/ticket files, content already captured in entity pages)
- Contradictions flagged: none

## [2026-05-28] skill-update | p-llm-wiki skill updated + committed
- Added wiki_ingested frontmatter tagging convention to SKILL.md
- Updated SCHEMA.md in vault to document the convention
- Committed and pushed to github.com/mraath/Skills.git (branch: skill-audit-cleanup)

## [2026-05-28] ingest | DST Daylight Saving Times/DST Code Paths.md
- Pages created: Command-45, DST, FMTimeAdjuster, DaylightSavingAdjustmentService, Config-Api, dst-code-paths (source)
- Pages updated: none (first ingest)
- Contradictions flagged: none

## [2026-05-28] ingest | DST Daylight Saving Times/DST Debug Guide.md
- Pages created: OMAN-Environment, dst-debug-guide (source)
- Pages updated: FMTimeAdjuster, DaylightSavingAdjustmentService, Command-45
- Contradictions flagged: none

## [2026-05-28] ingest | ETS/ETS-8669 OMAN Command 45 DST issue.md
- Pages created: ETS-8669, ets-8669-oman-dst (source)
- Pages updated: FMTimeAdjuster, OMAN-Environment, Command-45
- Contradictions flagged: none

## [2026-05-28] ingest | Operations Tools.md + Operations Tools Looking forward 20260316.md + supporting Ops Tools files
- Pages created: Ops-Tools, Config-Delta-Tool, QC-Automation, operations-tools-master (source), operations-tools-looking-forward (source)
- Pages updated: none (new cluster)
- Contradictions flagged: none

## [2026-05-28] ingest | DST source files tagged (wiki_ingested frontmatter added)
- Files tagged: DST/Command 45.md, Need Parent/DST.md, Need Parent/DST Moving Parts.md, Setting up DST Command 45 in ALG.md, OMAN DST Command 45 Setup.md, OMAN-DST-Server-Quick-Reference.md, Need Parent/TECHDEBT-372…md, ETS-8669…md, DST Code Paths.md, DST Debug Guide.md
- Files tagged (Ops Tools): Operations Tools.md, Operations Tools Looking forward 20260316.md, Operations Enablement.md, ConfigTools URLs.md, Diff Ideas — Future Roadmap.md, Ops Tools Antigravity training.md

## [2026-05-28] setup | Wiki initialized
- Domain: Work knowledge base for Powerfleet/MiX Telematics engineering
- Entity types: Person, Project, System, Ticket, Concept
- Source types: Daily/Weekly/Monthly notes, Jira tickets, Technical guides, Confluence pages, Web articles, Chat/meeting notes, Code analysis sessions
- Output formats: Dataview frontmatter, Marp slide decks, Comparison tables, Timelines, Standard markdown
