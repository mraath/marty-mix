---
created: 2026-02-11T15:46
updated: 2026-03-04T16:00
---

# Marty-Mix: Second Brain & Knowledge Base

## What This Project Is

This is **Marthinus's personal second brain** - an Obsidian-based knowledge management system that serves as a comprehensive work journal and technical reference for MiX Telematics development work.

## Purpose

- **Work Documentation**: Daily notes, weekly summaries, and monthly reviews tracking development activities
- **Technical Knowledge Base**: Solutions to bugs, configuration issues, deployment procedures, and system architecture
- **Issue Tracking**: Detailed notes on JIRA tickets (ETS, OPEN, OE, QA, SR prefixes) with solutions and workarounds
- **Server & Environment Info**: Production servers, database configurations, API endpoints, and deployment targets
- **Code Snippets & SQL**: Reusable queries, scripts, and code patterns
- **Project Context**: Background on various MiX Telematics systems including Config, Frangular UI, Operations Enablement, etc.

## Key Areas

### Daily Operations
- **DailyNotes/**: Daily work logs (976 files) tracking day-to-day activities
- **WeeklyNotes/**: Weekly summaries and planning
- **MonthlyNotes/**: Monthly reviews and retrospectives
- **Daily Merge**: Merge tracking and deployment notes

### Technical Documentation
- **DST/**: Daylight Savings Time tools and Command 45 setup
- **SQL/**: Database queries and scripts (41 files)
- **Templates/**: Reusable templates for various tasks
- **Excalidraw/**: Technical diagrams and flowcharts

### Issue Tracking
- **Done/**: Completed tickets and resolved issues (59 files)
- **WIP/**: Work in progress
- **Busy/**: Active tasks
- **Parked/**: Deferred items
- **SRs/**: Service requests (63 files)

### Environments & Servers
- **Production Servers**: OMAN (HSOMNIIS18,19), ALG, INT, DEV, UAT
- **Config Groups**: Beta page, asset management, firmware uploads
- **APIs**: Device Config, FMTimeAdjuster, various microservices

## Technology Stack

The notes cover work on:
- **Frontend**: Frangular UI (Angular + Unity framework)
- **Backend**: .NET Framework, C#, SQL Server
- **DevOps**: Azure DevOps, IIS, AWS (ECR, ECS)
- **Tools**: Obsidian, Quartz (for publishing), Git

## Publishing

This knowledge base uses **Quartz v4** to publish notes as a digital garden/website, making it accessible and shareable.

## Key Patterns

- **JIRA Integration**: Most notes link to JIRA tickets with format `[TICKET-NUMBER] Description`
- **Date-Based Organization**: Heavy use of daily notes with YYYYMMDD format
- **Cross-Linking**: Extensive use of Obsidian's `[[WikiLinks]]` for connecting related concepts
- **Status Tracking**: Files tagged with status (busy, done, parked) and priority levels
- **Screenshots**: Many notes include visual references stored in Attachments/

## Common Queries

When searching this knowledge base:
- Look in **DailyNotes/** for recent work (date descending)
- Check **DST/** for daylight savings/timezone tools
- Search **SRs/** for service request solutions
- Review **SQL/** for database queries
- Check **Need Parent/** for items needing categorization

---

*This is a living document that grows with each day's work, capturing institutional knowledge and technical solutions for future reference.*

## Second Brain Policy (Agent Instructions)

- When creating or updating .md files that contain useful knowledge (guides, summaries, setup notes, learnings, architecture docs), **always save a copy into C:\Projects\marty-mix\** in an appropriate location.
- Whenever new .md files are created during a session, **add wiki links for ALL new notes into the daily note** at C:\Projects\marty-mix\DailyNotes\YYYY-MM-DD.md under a ### Notes created today section.
- Wiki link format: [[NoteFilenameWithoutExtension]]  brief one-line description.
- The daily note date should match the current date (from the system metadata).
