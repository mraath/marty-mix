---
created: 2026-05-13
tags: [demo, deployment, aws, azure-devops]
wiki_ingested: 2026-05-28
---

# Powerfleet Automation — Deployment Demo Script
> 30-minute walkthrough · 4 sections

---

## Section 1: The Big Picture — "The Pizza Restaurant" (AWS in Plain English)

Think of the whole cloud setup as a **pizza restaurant**. Every part of AWS maps to something in that restaurant.

| AWS Component | Restaurant Analogy | What it does in our system |
|---|---|---|
| **Route 53 (DNS)** | Phone book / Yellow Pages | Translates `automation.za.mixtelematics.com` → ALB IP address |
| **ALB (Load Balancer)** | The Receptionist at the front desk | Single entry point for all traffic. Customers never walk into the kitchen. |
| **ALB Listener Rules** | The Menu Board | "If you ask for `automation-api.*`, I'll route you to the API kitchen" |
| **Target Group** | The Order Ticket Rail | List of healthy tasks ready to take traffic. Empty rail = 503 error. |
| **Security Group** | The Bouncer | "Only the ALB can talk to the kitchen. Nobody else." |
| **ECR (Image Registry)** | The Ingredient Warehouse | Where Docker images are stored. If the task can't reach ECR, it can't start. |
| **ECS Task Definition** | The Recipe Card | Blueprint: which image, which ports, how much RAM, what env vars |
| **ECS Task** | A Pizza in the oven | One running instance of the app |
| **ECS Service** | The Kitchen Manager | "I want 1 pizza in the oven AT ALL TIMES. If it burns, start a new one." |
| **ECS Cluster** | The Kitchen itself | Logical grouping — `INT-Config`, `AU-Config`, `ZA-Config`, etc. |
| **CloudWatch Logs** | The Health Inspector's clipboard | Where all container logs go for debugging |

### The Complete Flow (when a user hits the app)

```
User types automation.za.mixtelematics.com
    → Route 53 (phone book) → ALB (receptionist)
    → Listener Rule matches hostname → Target Group (ticket rail)
    → Healthy ECS Task (pizza in oven) → Response back to user
```

### Why things break — common errors

| Error | Restaurant meaning | Root cause |
|---|---|---|
| `503 Service Unavailable` | Receptionist has no kitchen to send orders to | No healthy tasks in Target Group / missing Listener Rule |
| `Site can't be reached` | Phone number doesn't exist | Route 53 DNS record missing or wrong |
| Tasks keep restarting | Chef burns every pizza | Health check failing, app crash on startup |
| `/#/login` (shows wrong app) | Order went to the wrong kitchen | ECS tasks aren't running — ALB defaulting to Frangular |

---

## Section 2: Adding a New Region — The AWS Deployment Skill

When we want to launch the app in a **brand new region** (e.g. ZA, AU, UK, US), we use the **`w-aws-regional-deployment` AI skill**. This is a step-by-step Claude skill that sets up all the AWS plumbing from scratch.

### The 9 Steps (what the skill does)

```
Step 1: ECR Repos        → Create "int-powerfleet-automation-api" and "-ui" image stores
Step 2: CloudWatch       → Create log groups so we can see container output
Step 3: Target Groups    → Create API target group (port 80) + UI target group (port 3000)
Step 4: ALB Rules        → Wire the new hostnames into the existing Load Balancer (HTTPS rules first)
Step 5: Task Definitions → Register the "recipe" — image, ports, env vars, SQL connection strings
Step 6: ECS Services     → Launch the services (manager says "keep 1 task running")
Step 7: Route 53 DNS     → Create DNS records pointing the friendly URL → ALB
Step 8: Tagging          → Tag all resources (TeamResponsible=OpsTools / =Config for target groups)
Step 9: AI Keys          → Inject OpenAI / Groq / Gemini keys into the UI task definition
```

### Key gotchas the skill knows about

- **SSL certificate naming**: `automation-au.mixtelematics.com` ✅ vs `automation.au.mixtelematics.com` ❌ (wildcard only covers one level)
- **Cross-account**: ZA/AU/ENT are **separate AWS accounts** — can't use DEV ECR images across accounts
- **Private subnets only**: Tasks must use private subnets with NAT, not public subnets
- **ALB Security Group — both directions**: Inbound on ECS SG AND outbound on ALB SG must allow ports 80+3000
- **Aurora PostgreSQL**: configdiff (Config Delta tool) needs its own DB migration per environment
- **Create the ADO Environment first**: Azure DevOps pipeline will fail with "Environment not found" if you skip this

### Environment Reference (quick lookup)

| Env | Region | Domain | AWS Account |
|---|---|---|---|
| DEV | eu-west-1 | `*.dev.mixtelematics.com` | 601704920959 |
| INT | eu-west-1 | `*.mixdevelopment.com` | 601704920959 |
| AU | ap-southeast-2 | `automation-au.mixtelematics.com` | 365528985733 |
| ZA | eu-west-1 | `automation.za.mixtelematics.com` | 668736068906 |
| UK | eu-west-1 | `automation.uk.mixtelematics.com` | 365528985733 |
| US | us-east-1 | `automation.us.mixtelematics.com` | 365528985733 |

---

## Section 3: The CI/CD Pipeline — Azure DevOps YML (Day-to-day deploys)

Once the infrastructure exists (Section 2), **normal code deploys** use Azure DevOps pipelines. There are two: one for the **API**, one for the **UI**.

### How it works — the two files

```
azure-pipelines.yml   → The traffic controller (when + where to deploy)
deploy-template.yaml  → The actual deploy steps (build Docker image → push ECR → update ECS)
```

### azure-pipelines.yml — When does it trigger?

| Branch | Auto-deploy to |
|---|---|
| `development` | DEV only |
| `integration` | INT only |
| `production` | AU + ZA + ENT + UK + US (all prod envs at once) |

> Manual override: any environment can be force-deployed by checking a checkbox when running the pipeline manually (e.g. `ForceDeployINT = true`).

### deploy-template.yaml — The 3 steps every deploy does

```
Step 1: Build Docker image
        → Takes the published build artifact (compiled .NET or Next.js output)
        → Builds a Docker image named e.g. "int-powerfleet-automation-api:latest"

Step 2: Push to ECR
        → Pushes that image to the environment's ECR repository in AWS
        → Uses the ADO service connection (pre-configured AWS credentials)

Step 3: Update ECS Service
        → Tells ECS "use the new image"
        → API: registers a new task definition revision first, then updates the service
        → UI: simpler — just force-new-deployment (no task def revision step)
```

### UI vs API Pipeline — key differences

| | **API** (`Powerfleet.Automation`) | **UI** (`Powerfleet.Automation.UI`) |
|---|---|---|
| Build tool | .NET 8 (`dotnet publish`) | Node 20 (`npm run build`) |
| Build output | Compiled .NET app + Dockerfile | Next.js `.next/` folder + Dockerfile |
| NuGet auth | Yes (private feed) | No |
| Deploy step 3 | `describe-task-definition` → register new revision → `update-service` | Docker task → `ECRPushImage` → `update-service --force-new-deployment` |
| Reason for difference | API needs exact image pinned in task def revision | UI uses `:latest` tag — ECS just pulls newest |

### The Parameters (what you see when running manually)

```yaml
ForceDeployDEV  → bypass branch check, deploy to DEV now
ForceDeployINT  → bypass branch check, deploy to INT now
DeployToAU      → manually trigger AU deploy (normally only on production branch)
DeployToZA      → same for ZA
DeployToENT     → same for ENT
ForceDeployUK   → same for UK
ForceDeployUS   → same for US
```

### The Service Connections (how ADO authenticates to AWS per account)

| Service Connection | AWS Account | Used for |
|---|---|---|
| `srvcdeploy-mixdevelopment-OperationsTools` | 601704920959 | DEV + INT |
| `srvcdeploy-operationsmixtelematics-OperationsTools` | 365528985733 | AU + UK + US |
| `srvcdeploy-mix-cpt-operations-OperationsTools` | 668736068906 | ZA |
| `srvcdeploy-mix-ent-operations-OperationsTools` | 522301445307 | ENT |

---

## Section 4: The Full Picture — How All Three Fit Together

```
┌─────────────────────────────────────────────────────────┐
│  NEW REGION (one-time setup)                            │
│  AWS Deployment Skill (Section 2)                       │
│  Creates: ECR, CloudWatch, Target Groups, ALB Rules,    │
│           Task Defs, ECS Services, DNS, Tags            │
└───────────────────────┬─────────────────────────────────┘
                        │ "Kitchen is built"
                        ▼
┌─────────────────────────────────────────────────────────┐
│  CODE CHANGE (every PR / release)                       │
│  Azure DevOps Pipeline (Section 3)                      │
│  1. Build app (dotnet / npm)                            │
│  2. Build Docker image                                  │
│  3. Push to ECR (the ingredient warehouse)              │
│  4. Update ECS Service → new task spins up              │
└───────────────────────┬─────────────────────────────────┘
                        │ "New pizza recipe delivered to kitchen"
                        ▼
┌─────────────────────────────────────────────────────────┐
│  LIVE TRAFFIC (always on)                               │
│  AWS Infrastructure (Section 1)                         │
│  User → Route 53 → ALB → Target Group → ECS Task       │
│  ECS Service manager watches: if task dies, restart it  │
└─────────────────────────────────────────────────────────┘
```

### Demo talking points (< 30 mins)

1. **Show the pipeline in Azure DevOps** — point out branch triggers + manual checkboxes
2. **Open `deploy-template.yaml`** — show the 3 steps (build → ECR → ECS update)
3. **Open AWS Console → ECS → INT-Config cluster** — show the running services + task definitions
4. **Open ALB → Listener Rules** — show the host-header routing rules (the "menu board")
5. **Open Route 53** — show the alias records pointing to the ALB
6. **Pull up the Pizza analogy** — tie each thing you just clicked to its restaurant equivalent
7. **Explain the skill** — "When we add a new country, we run through 9 manual steps — the skill automates and remembers all of this for us"
