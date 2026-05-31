---
wiki_ingested: 2026-05-28
status: In Progress Dev
priority: 1
created: 2026-03-16T00:00
updated: 2026-03-16T08:50
---

# OPEN-1788 Add AI ChatBot Panel to the Configuration Delta Tool

JIRA: [OPEN-1788](https://powerfleet.atlassian.net/browse/OPEN-1788)
Parent: [[OPEN-1624]] — Config change analysis tool
Labels: operations-tools
Assignee: Marthinus Raath
Status: In Progress Dev

## Start Here Tomorrow — Priority Checklist

- [ ] Add `OPENROUTER_API_KEY` value to `.env.local`
- [ ] Test ChatBot panel opens/closes correctly
- [ ] Verify startup analysis triggers on panel open
- [ ] Test suggested prompt chips update per diff
- [ ] Test user_feedback.json read/write flow
- [ ] Test error states (missing diff, missing API key, API failure)
- [x] Add Groq fallback support (free tier models)

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

Add an AI-powered chat panel (slide-in from right) to the Configuration Delta Tool that allows users to ask natural language questions about the loaded `diff.json`.

**Key features:**
- "Chat Bot" toggle button added to the view toggle row (to the right of Matrix View)
- Panel slides in from right edge, main view shrinks to ~60% width
- Auto-loads the active test case's `diff.json` as working context
- Startup analysis: chatbot performs auto-analysis on panel open
- Suggested prompt chips (2–4, context-aware, e.g. "What changed?", "Any risks?")
- User can correct/annotate interpretations → persisted to `user_feedback.json`
- AI provider: OpenRouter (free tier), key from `OPENROUTER_API_KEY` env var
- Glassmorphism panel style, consistent with Powerfleet Operations Tools aesthetic

**Files created:**
- `src/components/delta/ChatBotPanel.tsx`
- `src/services/chatbotService.ts`
- `src/app/api/chat/route.ts`
- `agents/json_diff_analyst.md` (also copied to `public/agents/`)

**Files modified:**
- `src/components/delta/ConfigDeltaView.tsx` — toggle state + layout split
- `.env.local` — OPENROUTER_API_KEY + OPENROUTER_MODEL
- `.env.local.example` — placeholder entries

## Implementation Summary (2026-03-16)

### Files Created
| File | Purpose |
|---|---|
| `agents/json_diff_analyst.md` | AI system prompt — JSON Diff Analyst agent (also copied to `public/agents/`) |
| `src/app/api/chat/route.ts` | Next.js server-side API route — calls OpenRouter, auto-falls back to Groq free models on 429/402 |
| `src/services/chatbotService.ts` | Client service — system prompt loader, diff context builder, user feedback persistence, suggested prompts |
| `src/components/delta/ChatBotPanel.tsx` | Glassmorphism sliding chat panel — startup analysis, suggested chips, animated loading, close button |

### Files Modified
| File | Change |
|---|---|
| `src/components/delta/ConfigDeltaView.tsx` | Added `chatOpen` state, Chat Bot toggle button (to the right of Matrix View), flex layout split (~60/40) |
| `.env.local` | Added `OPENROUTER_API_KEY`, `OPENROUTER_MODEL`, `GROQ_API_KEY` |
| `.env.local.example` | Added placeholder entries for all three vars |

### Architecture Decisions
- **API keys are server-side only** — all AI calls go through `/api/chat` route, keys never exposed to client
- **Groq fallback** — `/api/chat` auto-falls back to Groq free models (`llama-3.1-8b-instant` → `llama3-8b-8192` → `gemma2-9b-it`) when OpenRouter returns 429 or 402
- **System prompt served statically** — `agents/json_diff_analyst.md` copied to `public/agents/` so client can fetch it
- **Layout split** — CSS flex on outer wrapper; panel animates in via CSS transition (`slideIn` keyframe)
- **User feedback** — `user_feedback.json` persisted per test case in `public/data/<testCase>/` via `/api/feedback` route (route to be wired up)

### Jira Status
Transitioned: Authoring → **Proposed**. Workflow requires PM/Scrum Master to advance to In Progress Dev — cannot be done via API from Proposed.

## Further Chat Notes

> User noted: if OpenRouter free tokens run out, also make use of free Groq models as fallback. ✅ Implemented in `/api/chat/route.ts`.

## Branch

> Branch: Config/MR/Feature/OPEN-1788_AIChatBotPanel

## PR Checklist

- [ ] OPEN-1788 → DEV
- [ ] OPEN-1788 → INT
- [ ] OPEN-1788 → UAT
- [ ] OPEN-1788 → PROD
