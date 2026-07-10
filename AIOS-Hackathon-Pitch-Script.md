---
tags: [aios, hackathon, pitch, script]
created: 2026-07-10
---

# AIOS Hackathon Pitch — Script & Talking Points

Source material for a NotebookLM slideshow. Written for a **broad, non-technical internal audience** (hackathon judges/colleagues who may not code daily). Framing: **proven-first** — lead with what already works, then pitch the consolidated platform as the next step.

Related: [[AIOS-Hackathon-Architecture-Brief]] (technical backup deck / Q&A reference)

---

## 1. The Hook (30 seconds)

> "Every one of us has, at some point, wished we had a personal assistant who already knew our job, remembered everything, and could actually go do the work — not just answer questions about it.
>
> That's not science fiction anymore. Over the last few months, three of us have independently built pieces of exactly that — a system that doesn't just chat, it **acts**: writes code, manages projects, tracks tickets, and talks to us over Telegram or Discord like a colleague.
>
> Today we want to show you the core of that system, and pitch how we bring it together as one platform."

---

## 2. The Problem (1 minute)

- AI chat tools are everywhere now — but almost all of them are **stateless conversations**. Close the tab, lose the context. Every session starts from zero.
- The real unlock isn't a smarter chatbot. It's an assistant that:
  1. **Remembers** — your projects, your preferences, your history — across days and weeks, not just one conversation.
  2. **Acts** — can actually open a file, write code, update a ticket, run a test — not just describe what you should do.
  3. **Is reachable anywhere** — Discord, Telegram, a web page — not locked to one terminal window.
  4. **Isn't tied to one AI vendor** — because model pricing, capability, and availability shift every few months. Lock-in is a real business risk.

That's the gap we're closing.

---

## 3. What We've Already Built (the "proven" core — 2–3 minutes)

### 3a. AIOS — the personal base layer

- **AIOS** is a personal command center — a structured set of memory, context, and configuration that any AI tool can read before it acts.
- Concretely: it's a "second brain" (an Obsidian knowledge base) plus a routing layer, so when you talk to it, it already knows who you are, what project you mean, and what you did last week — instead of you re-explaining everything every single time.
- **We've already connected this to a live Discord bot.** Different channels are different "personas" — one for work, one for personal life, one for a specific side project — and each one talks to the underlying AI with the right context loaded automatically. Type a message in the "Work" channel, and it responds as if it's been sitting in on your work all along.
- We've also connected it to more than one AI model (Claude, Gemini) — proving the "not locked to one vendor" idea isn't theoretical.

**This is the base. Everything else is a layer on top of it.**

### 3b. SDLC — proof the pattern scales to real, governed work

- Completely separately, we built a system that runs actual software delivery for one of our teams: from a business requirement, through coding, code review, testing, and deployment — with **13 specialized AI agents**, each responsible for one stage, handing work to each other like a relay team.
- It's plugged straight into **Jira** — it reads tickets, writes comments, moves tickets through the workflow, exactly like a person would.
- The important part for this pitch: it proves that AI agents can be trusted with **governed, high-stakes work** — not just chat — as long as you build in the guardrails: a shared record of what's happening (so agents don't step on each other), rules that get enforced automatically (not just suggested), and a human able to step in at key checkpoints.
- **Why this matters for AIOS:** AIOS's Discord bot today is a simple relay — one message in, one response out. SDLC proves the *next* piece: a governed way for AI agents to do multi-step, checked, handed-off work. That's the missing piece we'd bring into AIOS.
- **One honest caveat, and it's actually the interesting part:** SDLC's governance today only works because it's plugged into one specific AI tool. To bring it into AIOS — where we deliberately want to swap between Claude, Gemini, or others — we can't just copy the code across. We have to rebuild the *pattern* (shared memory, automatic rule enforcement) in a way that works no matter which AI is doing the work. That's genuine, valuable engineering — not a copy-paste job — and it's exactly the kind of problem a hackathon should tackle.

### 3c. ThePopeBot — proof someone else is racing toward the same idea

- We also looked at an open-source project called **ThePopeBot** — built by someone completely outside our company, with no knowledge of AIOS or SDLC.
- It independently arrived at almost the exact same shape: one central hub, multiple chat channels (Telegram, web), a choice of AI "coding agents" you can swap in, and the ability to fire off a background job that writes code, opens a pull request, and messages you back when it's done.
- **We're not adopting their code.** But it's strong external validation: this is the direction the whole industry is converging on, not just an idea we invented in isolation. It also shows us the next milestone — full background job automation with PR creation — as a concrete, working example of "what good looks like."

---

## 4. Why AIOS Should Be the Base (1–2 minutes)

Three reasons this is the right foundation to build on, not a from-scratch platform:

1. **It already separates "memory" from "the AI doing the work."** The knowledge base doesn't care whether Claude, Gemini, or something else next year is answering — it's just readable context. That's what keeps us out of vendor lock-in.
2. **It's already proven across more than one interface.** Discord works today. Adding a web page or a Telegram bridge is a new *door into the same house* — not a rebuild.
3. **It's ours.** We're not dependent on a third party's roadmap, pricing, or shutdown risk. We can shape it exactly around how our teams actually work — Jira, our repos, our processes.

---

## 5. Where We Take It (the pitch — 2 minutes)

**The ask: consolidate the best proven piece of each system into one platform, with AIOS as the base.**

| From | We take | Into AIOS as |
|---|---|---|
| AIOS itself | Memory, context, multi-persona routing, multi-model support | The foundation — unchanged, just strengthened |
| SDLC | The *pattern* of governed multi-agent hand-off (shared state, automatic rule enforcement, human checkpoints) — rebuilt so it works no matter which AI tool is running, not tied to one specific one | A general-purpose "task pipeline" any AIOS persona can use, not just software delivery |
| ThePopeBot (as inspiration, not code) | Background job execution + automatic pull-request creation + "message me back on Telegram/Discord when it's done" | The next milestone on our roadmap |

**Concretely, over the next quarter, this means:**
- Any AIOS persona can hand off a real task (not just answer a question) to a governed pipeline, and get pinged back when it's done.
- New channels (web, Telegram) plug into the same base with no rework — because the memory and routing layer is already separate from the interface.
- We stay model-agnostic on purpose — new AI models get swapped in without re-architecting.

---

## 6. The Close (30 seconds)

> "This isn't a hackathon demo we're hoping might work someday. Two of these three systems are running right now, doing real work, for real teams, today. The third just proved the wider world is racing toward the exact same design.
>
> What we're proposing is to stop building these in three separate silos, and consolidate them — with AIOS as the base — into one platform our whole team can extend. That's what we want your support to go and build."

---

## Notes for delivery

- **Bold anchor words** above are chosen for spoken delivery — hit those words with emphasis, let the rest flow.
- Keep section 3 concrete and demo-flavored if possible (a screenshot of the Discord bot responding in a "Work" persona channel is worth more than any slide of architecture boxes).
- Save the deep technical detail (state.json schema, hook mechanics, provider abstraction specifics) for [[AIOS-Hackathon-Architecture-Brief]] — pull it out only if a judge asks a follow-up.
- Do **not** claim AIOS, SDLC, and ThePopeBot are technically integrated today — they aren't. The honest claim is "three independent proofs of the same pattern," which is a *stronger* argument than an inflated integration claim would be if someone probes it.
