---
tags: [aios, hackathon, pitch, slides, roasted]
created: 2026-07-10
---

# AIOS Hackathon — Slide Script (Roasted & Reconciled)

This is the slide-by-slide script for a NotebookLM slideshow, for a **15-minute internal Powerfleet hackathon talk**, mixed technical audience.

**Process note:** the user's original 7 "popcorn" slide ideas were run through **The Roast** — three independent agents (Advocate, Devil's Advocate, Analyst) argued for, against, and neutrally about the plan. All three converged on the same core fix even from different angles: **the router (swap the AI backend) was invisible in the original plan and needed to be the star**, and **SDLC's hooks limitation needed to be stated upfront as the argument FOR the router, not hidden as a footnote**. This script applies all the reconciled fixes. Full Roast transcripts are preserved in memory if you want the raw arguments later.

**Status: this is a brainstorm concept, nothing is built yet.** Every slide below is written to be honest about that — say "we're building," not "we built," unless referring to AIOS's files/SDLC/Paperclip, which genuinely already exist and run today.

---

## Slide 1 — The Insight

**Visual:** Just the one line, large, centered. Nothing else on the slide.

**Script:**
> "AI is changing faster than any of us can keep up with. Whatever model is best today — Claude, Copilot, Gemini — will probably be replaced by something better within the year. If we build our hackathon entry around one specific AI tool, we've built something that expires.
>
> But there's one thing that doesn't expire: **files.** Every AI, past and future, still has to read text to know what's going on. So here's our bet: **don't build around the AI. Build around the files — and make the AI swappable underneath them.**"

---

## Slide 2 — What Already Exists (SDLC + Paperclip) — and the Honest Catch

**Visual:** Two boxes side by side — "SDLC: 13 AI agents running our software delivery pipeline, live today" / "Paperclip: open-source AI task-orchestration tool, already running our personal task queue." Underneath both, one line: **"Both are real. Both are running. But both have the same hidden limitation."**

**Script:**
> "Before we pitch an idea, let's show you what's already real, so you know we're not starting from nothing.
>
> We already run **SDLC** — a system where 13 specialized AI agents handle our actual software delivery: writing code, reviewing it, testing it, moving Jira tickets through our real workflow. This isn't a demo. It's running in production, today, for a real team.
>
> We also already use **Paperclip** — a mature open-source tool that manages AI agents like a company org chart: tasks get assigned, agents wake up on a schedule, work gets tracked. Also real, also running.
>
> Here's the catch, and we want to be upfront about it: **both of these are wired tightly to one specific AI tool.** SDLC's automation only works because of a feature that's exclusive to one AI coding assistant — swap in a different one, and all that automation silently stops working. We checked. It's not a small gap, it's a hard wall.
>
> That's not a criticism of what we built — it's the exact problem our hackathon entry is going to solve."

**Speaker note:** This is deliberately reframing SDLC from "proof point" (the original, Roast-rejected framing) to "cautionary tale that motivates the ask." Say the limitation yourselves, before anyone in the room asks "does this work with Copilot?"

---

## Slide 3 — The Build: A Swappable Router

**Visual:** Simple before/after diagram. Before: "Task → [hardwired to one AI] → Result." After: "Task → [Router] → any AI (Claude / Copilot / Gemini) → Result," with the AI box shown as interchangeable/sliding in and out.

**Script:**
> "So here's what we're actually proposing to build this hackathon: a small, simple **router**.
>
> Think of it like a receptionist. A task comes in. The router checks: which AI is on duty today — Claude or Copilot? It hands that AI the relevant context, lets it do the work, and writes down what happened for next time. The router doesn't care which AI is behind the desk. That's the whole point.
>
> This is genuinely the missing piece. We looked at several existing systems that claim to support multiple AI tools — including a serious, actively-developed open-source project — and even they don't have a clean version of this. They wire up each AI tool by hand, one at a time, with separate code for each. **Nobody has actually solved this cleanly yet.** That's exactly why it's worth a hackathon."

**Speaker note:** This is the star slide. Give it real time — don't rush past it. If you only get through 4 slides live, this is the one that must land.

---

## Slide 4 — The Files: Memory That Outlives the Model

**Visual:** A folder icon with a few markdown file icons inside, labeled "memory/" — connect it with an arrow to three logos/labels: Claude, Copilot, "whatever's next."

**Script:**
> "The router needs somewhere to keep context — what's been done, what's pending, what this project is about. We're keeping that dead simple: **plain markdown files.** No database, no proprietary format.
>
> Why does this matter? Because plain text is the one format every AI — the ones we use today and whatever wins next year — can already read. We've actually already proven this works in miniature: our SDLC system already keeps its own shared memory this way, in plain files, and it's held up fine in production.
>
> The idea itself has a name in the AI community — sometimes called the 'wiki method': raw notes go in, get organized into a structured wiki over time, and that structure compounds instead of starting from zero every session. We're not claiming it beats every possible alternative at every scale — just that for a project like this, plain files you can open and read yourself beat a black-box database every time."

**Speaker note:** This replaces the original standalone "4 C's" and "Karpathy method" slides. Per the Roast, bare framework-recitation reads as filler to an engineer audience — so this version only mentions the method by reputation in passing, and immediately grounds it in something the audience can verify themselves (SDLC's actual memory files). Don't over-explain the external framework; one sentence of credit is enough.

---

## Slide 5 — Reachable From Where You Already Work

**Visual:** One channel, clearly primary: Microsoft Teams logo, large. Small, faded mention below: "Web — maybe, if there's time."

**Script:**
> "Where do you actually talk to this thing? We're deliberately keeping this simple and picking the channel that matches how this company actually works: **Microsoft Teams.**
>
> That's it. Not Discord, not WhatsApp — Teams, because that's where you already are. If there's time, we might add a simple web page too. Swapping which chat app we're reachable from turns out to be the easy part — the hard part was the router, which is where we spent our real effort."

**Speaker note:** Per the Roast, the original list mixed in WhatsApp (doesn't match company toolset) and "SDLC" (a category error — SDLC is a whole separate system, not a chat channel). Both are cut here. Keep this slide short — it's a minor point, not a selling point.

---

## Slide 6 — What We're Not Rebuilding (Stretch Goals)

**Visual:** Two logos side by side, both slightly greyed out to signal "not core scope": Paperclip, Jira.

**Script:**
> "Last thing, quickly: we're not trying to reinvent task tracking or ticket management this weekend. Paperclip already does agent task-scheduling well, and we already use it personally — no reason to rebuild that. And for anything Jira-related, if we have time, we'd borrow a pattern we already know works from SDLC. Both of these are 'nice if we get to it,' not part of what we're demoing today."

**Speaker note:** This replaces the original dedicated "Connecting with Paperclip/Jira" slide, per the Roast's strongest shared objection: Paperclip has no real connection to Powerfleet's Jira today, and re-touching task-tracking directly contradicts the team's own decision not to rebuild that layer. Keeping this to one slide, clearly labeled "not rebuilding," avoids the scope-creep trap while still mentioning it.

---

## Slide 7 — The Close

**Visual:** Return to slide 1's single line, now with one addition beneath it: "The bet: build the router. The files were never the hard part."

**Script:**
> "So, to bring it back to the start: every AI tool will be outdated within a year. We're not betting on one. We're betting on the one thing that doesn't expire — plain files — and building the one piece that's actually still missing: a router that can hand real work to whichever AI is best that month, starting with the two we already use, Claude and Copilot.
>
> That's what we want to spend this hackathon building."

---

## Delivery notes

- **Total slide count: 7** (matches the original ask), but the content is substantially different from the "popcorn" list — three of the original slides (4 C's, Karpathy, Paperclip/Jira) were cut or merged based on the Roast; the router was promoted from an invisible bullet point to its own headline slide (3), and SDLC's framing flipped from "proof point" to "cautionary tale that motivates the ask" (slide 2).
- **Bold anchor words** are chosen for spoken delivery — hit those with emphasis.
- If a judge/colleague asks "does this run yet?" — the honest answer is: "AIOS's files and SDLC and Paperclip are real and running today. The router is what we're proposing to build this hackathon — it doesn't exist yet." Say this plainly if asked; don't let slide 2's realness bleed into implying slide 3 already exists.
- If asked "why not just use ThePopeBot / an existing multi-agent tool?" — we checked; even mature, funded projects solve this by hand-wiring each AI tool separately, not with a clean interface. That's evidence this is a real, unsolved, worthwhile problem — not something to feel behind on.
