---
created: 2023-09-22T09:26
updated: 2025-01-27T09:46
---

## Intro

[[MiX]] has a LOT of code.

Thirdparty
[[Third Party Usage Policy]]

Setup:
- There is a doc
- Can also use VM: Hyper-V

Usually:
- [[FE]] which is the MiXFleet UI
- [[BE]] which mostly makes us of the Dynamix.api to get data
	- This in turn connects to lots of different teams' APIs:
		- [[DynaMiX.DeviceConfig]]
		- etc
- [[DB]] most of the time refers to the following legacy databases
	- [[FMOnlineDB]]
	- [[Asset DB]]s for each Organisation
	- Dynamix?
	- Other?

## DEV Process

- [[DEV Process]]

## Deployments

- Check the pipelines in this chat: **Team Device Integration (QA Related)**: [Pipeline eg](https://teams.microsoft.com/l/message/19:e4580a88f5824999975a7d02294adab4@thread.v2/1737725384424?context=%7B%22contextType%22%3A%22chat%22%7D).
- Notify them when you start - ensure you are deploying to the correct PROD server
- Notify them when you are done
- Then sign the completed tab: [Roster](https://teams.microsoft.com/l/entity/1c256a65-83a6-4b5c-9ccf-78f8afb6f1e8/_djb2_msteams_prefix_859873898?context=%7B%22chatId%22%3A%2219%3A878b21fcb61845b8bed6e4686e21a892%40thread.v2%22%2C%22contextType%22%3A%22chat%22%7D&tenantId=d19b542a-1500-4712-a713-be8d79882cb5)

## Azure Overview

- Workflow: https://youtu.be/4BibQ69MD8c
- See everything, future enhancement: [Azure DevOps Jira integration to see builds, commits, deployments, pull requests (youtube.com)](https://www.youtube.com/watch?v=eGV2R7VvX7M)

## Tips

[[Coding tips]]

## Logging

- [Logging - Device Integration Team - MiX Telematics Confluence](https://confluence.mixtelematics.com/display/CT/Logging)
- Epic to change: [[TECHDEBT-471] MiX.DeviceIntegration.Core.Logging improvements - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/TECHDEBT-471)
- 
## Environments

- Local
- DEV
- INT
- [[PROD]]
- [[Development Servers]]

## Setup

[[Environment Setup]]
[[Confluence]]

## High level overview

![[MiX Overview]]

## AWS

- [[CodeWisperer]]

## Adding aspire orchestrator support to existing projects

![[Code Adding aspire.png|600]]

