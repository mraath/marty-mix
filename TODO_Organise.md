---
created: 2026-03-25
---

# Vault Organisation Plan

> Move files **inside Obsidian** (drag & drop in file explorer) to preserve WikiLink integrity.

---

## Folder Moves

### Daily Merge/ ← already exists
Move all loose `Daily Merge YYYYMMDD.md` files from root (~60 files), including:
- `Daily Merge NOU.md`
- `Daily Merge.md`

### WeeklyNotes/ ← already exists
- `2025-W46.md`
- `2025-W49.md`
- `2026-W06.md`
- `2026-W07.md`
- `2026-W11.md`

### Tickets/OPEN/ ← create new subfolder
All `OPEN-xxx.md` files from root (~50+ files)

### Tickets/OE/ ← create new subfolder
All `OE-xxx.md` files from root (~18 files)

### Tickets/ETS/ ← create new subfolder
All `ETS-xxxx.md` files from root (~9 files)

### Tickets/CONFIG/ ← create new subfolder
- `Config-1248 Config Group Count not Refreshing.md`
- `CONFIG-4667 API, Core, Client.md`
- `CONFIG-4709 CAN script not showing.md`

### QA/ ← already exists
- `QA-7242 Cant view Black Flag modal.md`
- `QA-7444 Not locking Odometer field.md`
- `QA-7654 Edit Camera Name Case.md`
- `QA-7657 Camera Name not Chinese friendly.md`
- `QA-7744 Language Kendo Items Selected.md`
- `QA-7752 Sidebar Config Only Not Persist.md`
- `QA-7818 Config Groups Link goes to Legacy.md`

### SRs/ ← already exists
- `SR-14585 FM idling though distance and speed greater than 5km`
- `SR-19946 ALG DTS fix.md`
- `SR-21085 Alert Timeout.md`

### Infrastructure/ ← create new folder
AWS + AU + Automation setup files:
- `AWS api.deviceconfig.dev.priv.md`
- `AWS Discovery api.deviceconfig.configdev.mix.local.md`
- `AWS Pizza Restaurant Analogy.md`
- `AWS Troubleshooting and Python Learnings.md`
- `AWS_TAGS.md`
- `AU_DNS_Fix_Instructions.md`
- `au_infrastructure_audit_and_fixes.md`
- `AU_Setup.md`
- `AU-Automation-Setup-Summary.md`
- `Automation API 20260311 Feedback.md`
- `Automation API Build Fixes 20260311.md`
- `Automation Infrastructure Setup Guide.md`

### Frangular/ ← create new folder
- `Frangular Edit Templates Grok Mirmaid prompts.md`
- `Frangular Editing Spike ALL.md`
- `Frangular Editing Spike Events.md`
- `Frangular Editing Spike Locations.md`
- `Frangular Editing Spike Mobile Devices.md`
- `Frangular Editing Templates CoPilot Prompt.md`
- `Frangular Initialise Test Data.md`
- `CORS Unity Frangular UI.md`
- `Environment Issue FR UI.md`
- `FR UI Removing Console Logs.md`

### AI Tools/ ← create new folder
- `gemini.md`
- `Gemini Cli Tips.md`
- `Github Copilot.md`
- `Roo Code Code Analysis.md`
- `Roo Code Why my Original Stored Proc didnt work.md`
- `ROO Prompt to get Rewrite Edit Templates.md`
- `Claude-Code-Remote-Control.md`
- `Shuan Notes AI.md`

### Personal/ ← already exists
- `Bamboo HR Goals Zonika.md`
- `Leave - overtime.md`
- `Public Holiday.md`
- `whatsapp-norton-bali.html`
- `whatsapp-stores-temp.json`
- `whatsapp-stores-uluwatu.html`
- `whatsapp-uluwatu-ram.html`

### Deployments/ ← create new folder
- `Deployments 25.11.md`
- `Deployments 25.17.md`
- `BUILD Point to CFG fix.md`
- `Global_Deployment_Guide.md`

---

## Leave in Root (intentionally)

| File | Reason |
|---|---|
| `package.json`, `package-lock.json`, `tsconfig.json` | Quartz site generator — must stay in root |
| `quartz.config.ts`, `quartz.layout.ts` | Quartz site generator — must stay in root |
| `CLAUDE.md`, `README.md`, `LICENSE.txt`, `CODE_OF_CONDUCT.md` | Root-level by convention |
| `excalibrain.md` | ExcaliBrain plugin requires root placement |
| `Operations Tools.md` | Main sprint dashboard — keep visible |
| `Operations Tools Looking forward 20260316.md` | Boss directive transcript — keep visible |

---

## Priority Order

1. `Daily Merge/` — ~60 files, biggest single win
2. `Tickets/OPEN/` — ~50 files, second biggest
3. `Tickets/OE/`, `Tickets/ETS/`, `Tickets/CONFIG/` — group all in one session
4. `QA/` and `SRs/` — quick, folders already exist
5. `Infrastructure/`, `Frangular/`, `AI Tools/`, `Deployments/` — one sitting
6. `Personal/` — last, low urgency
