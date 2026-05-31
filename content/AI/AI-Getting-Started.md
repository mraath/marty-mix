---
wiki_ingested: 2026-05-28
created: 2026-04-10T15:20
updated: 2026-04-10T15:32
---
# Getting Started with AI — A Practical Guide

> Stop overthinking it. Just start. The rest comes naturally.

Most people already know how to use a chatbot — you know how to type a question and get an answer. That's honestly 90% of what you need. You don't need to understand how it all works under the hood. You just need to start talking to it.

---

## Step 1: Install Antigravity and Start Talking

What I would do first is install **Antigravity**. The reason I say that is it's built on top of VS Code — so if you've used VS Code before, you're already halfway there. It just feels familiar from day one. That's the whole point.

> **Watch this first:**
> [Intro to Antigravity — YouTube](https://www.youtube.com/watch?v=cCIiRnlyipE)
> *(This guy has a lot of great resources. Worth bookmarking his channel.)*

Once it's installed, just open **a single project folder** — something you already know well — and start talking to it:

- *"Hey, change this button to blue."*
- *"What does this function do?"*
- *"Why am I getting this error?"*

That's it. You're using AI.

What helps here is that most people are already familiar with chatbots — so you already know how to talk to it. Just talk to your code the same way.

After any change, go and check **Git** — see exactly what it touched. Nothing is committed until you say so. This is what builds confidence that it's doing what you expect.

![[git-example.png]]

On the left you can see the diff (red = removed, green = added). On the right is every file the agent touched. You can see it all clearly before committing anything. It's a great habit to build from day one.

---

## Step 2: Move Up to Your Root Projects Folder

Once you're okay working on a single repo and simple changes, I would say go one level up — open your **root projects folder**, the one that has all your repos in it.

Now you can start asking questions that span multiple repos:

> *"I need to make a change on the UI, but I know it also affects the API. The two repos are X and Y..."*

The agent will figure out how they connect, decide what it wants to change, and walk you through it. It feels almost exactly the same as working on a single repo — just across your whole codebase now.

Until you're confident, I would say always stick to **one task at a time**. Keep it simple. Check what it wants to change. Stay in control.

---

## Step 3: MCPs — Let the Agent Talk to Your Other Tools

This is where it starts getting really interesting.

**MCP** (Model Context Protocol) is basically a way for your agent to talk to other tools — Jira, GitHub, Slack, AWS — without you needing to know any API calls. Think of it as **agent speaking to agent**.

A good first test: install the **Jira MCP**, then just ask:

> *"Hey, open my Jira ticket OPEN-1234 and tell me what needs to be done."*

No API calls. No documentation. Just ask.

What goes hand-in-hand with MCPs is API keys. For tools that need authentication — GitHub, AWS, etc. — you get your personal access token, store it in a `.env` file (stays hidden, never gets committed to Git), and the agent picks it up from there. Once it's set up, you just talk to it normally. I use my AWS keys this way all the time. In the beginning it takes a bit of figuring out, but once you've done it once — it's fast every time after.

Another great thing about having the API keys set up: when an MCP disconnects, the agent can still use those keys to run CLI commands or API calls directly.

---

## Step 4: Skills — Teaching the Agent Your Way of Doing Things

Once the agent has done something and you're happy with it — **before you close the chat** — just say:

> *"I like what you did here. Please generate a skill from this."*

It'll create a **skill file** in your skills folder. Think of it as a recipe the agent can follow next time.

Then in future you can just say:

> *"Use the AWS resource skill to set up the same thing, but on this new production server."*

The agent reads the skill and knows exactly what to do. What's also nice is it will often generate its own scripts (Python, bash, etc.) so a lot of the heavy lifting runs locally — which also means you use fewer tokens.

> **Before you create your first skill, watch this:**
> [Building Skills for AI Agents — YouTube](https://www.youtube.com/watch?v=cgl5tFN2zxA)

There's a really good prompt in there that helps you build a skill. What I would do is make your **first** skill a **skill-building skill** — so from then on you can just say:

> *"Use the skill-building skill to create a skill from this conversation."*

One thing though — only make skills for stuff you'll actually reuse a lot. Otherwise you end up with a drawer full of things you never open again.

---

## Step 5: Agents — Building Your Own Team

The next level from here is agents. You give the agent a specific role:

> *"You are my AWS agent. Whenever I ask about infrastructure, act in this role and make use of these skills."*

It's almost like having specialists in your team, and you becoming the coordinator who just points them in the right direction.

Fair warning — that does use a lot of credits and tokens. I've pulled back on this myself until I have more tokens. But it's good to know it's there when you're ready.

(And it goes further than this)

---

## Where to Start — Seriously

1. **Just use Gemini first.** It's free, it's fast, and it's more than enough to get going.
2. Once you feel like you want more — then get into **Claude**.

Stop overthinking it. Just start playing with it. The learning curve isn't technical — it's just getting comfortable. And the only way to do that is to start.

---

## Resources

| Resource             | Link                                        |
| -------------------- | ------------------------------------------- |
| Intro to Antigravity | https://www.youtube.com/watch?v=cCIiRnlyipE |
| Building AI Skills   | https://www.youtube.com/watch?v=cgl5tFN2zxA |

---

*I hope all this helps. Feel free to message me when you get stuck — but trust me, just starting is the hardest part.*
