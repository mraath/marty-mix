---
created: 2026-07-15T09:00
updated: 2026-07-15T09:00
---

# SDLC Agent Rules

Standing rules for how Claude/the Coding Agent should behave in the [[SDLC]] repo, learned the hard way. Check this before assuming "the agent will just ask if it needs something."

## Rule: A compliance/review gate halt = open a PR immediately, never paste a diff in chat

**What happened (2026-07-15, OPEN-3195 and OPEN-3201):** When the Coding Agent hit the Step 6c compliance gate (no automated Compliance Agent available in this harness — needs human sign-off instead), the orchestrating session pasted the diff content directly into the chat thread and asked for review there.

**Why that's wrong:** A long chat thread is not a review surface. There's no stable link, no way to find it again later, and no way to act on it independently of scrolling back through everything else happening in the conversation. My own words at the time: *"you say I have to do a review - but I dont see ANY link to a review... even now if I want to I CANT because I dont know WHERE theis diff is."*

**The fix, going forward:** Whenever a ticket hits this gate (or any point where a diff needs human eyes), the agent should:
1. Commit the code.
2. Push the branch.
3. Open the PR — noting the compliance situation in the PR description itself, same as it would document build/test/lint results.
4. Transition the Jira ticket to In Code Review and comment with the PR link.

The PR *is* the review, and it's the only thing worth waiting on my end for. Do not insert an extra "let me show you the diff first" step before a PR exists — that's slower for me, not safer.

## Rule: Sign-off must be tied to the specific artifact, not a general "you may continue"

Related mistake, same day: a "you may continue" sign-off given via a Jira comment reply got treated as authorization for a completely different, not-yet-existing PR. If I say something like "approved" or "go ahead" without a PR link attached, the agent should confirm what specifically I reviewed before acting on it — especially if no PR/diff existed yet when I said it.

## Why this matters

Every minute I spend hunting for "the thing I'm supposed to look at" is a minute the loop isn't actually moving. A PR link in a Jira comment is something I can act on from my phone, from Telegram, days later — a chat message is not.
