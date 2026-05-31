---
wiki_ingested: 2026-05-28
---
# AWS Infrastructure and Powerfleet Automation Deployment Briefing

## Executive Summary

The Powerfleet Automation infrastructure utilizes a comprehensive suite of Amazon Web Services (AWS) managed via a conceptual "Pizza Restaurant" framework. This analogy simplifies the complex interactions between networking, compute, and container orchestration components. The system is designed for high availability and regional scalability, employing a structured deployment strategy across multiple AWS accounts (DEV/INT, AU/UK/US, ZA, and ENT). 

Core operations are governed by two primary mechanisms: the **w-aws-regional-deployment** AI skill for initial regional setup and **Azure DevOps (ADO) pipelines** for ongoing CI/CD. This briefing details the architectural components, deployment protocols, and troubleshooting methodologies necessary for maintaining the Powerfleet Automation ecosystem.

---

## The "Pizza Restaurant" Architectural Framework

AWS components are mapped to specific roles within a restaurant to ensure clear communication and troubleshooting.

### Core Compute and Orchestration
| AWS Component | Restaurant Analogy | Functional Role |
| :--- | :--- | :--- |
| **ECS Cluster** | The Kitchen | A logical grouping of resources (e.g., INT-Config, ZA-Config) where work occurs. |
| **EC2 Server** | The Ovens | The physical or virtual computer performing the work. |
| **ECS Task Definition** | The Recipe | The blueprint specifying Docker images, ports, RAM, and environment variables. |
| **ECS Task** | A Pizza | A single running instance of the application. |
| **ECS Service** | The Kitchen Manager | Ensures the correct number of tasks are running; replaces "burned" (crashed) tasks. |
| **ECR (Registry)** | Ingredient Warehouse | The storage location for Docker images. |

### Networking and Security
| AWS Component | Restaurant Analogy | Functional Role |
| :--- | :--- | :--- |
| **Route 53** | Phone Book | Translates friendly URLs (e.g., automation.za...) into Load Balancer addresses. |
| **ALB (Load Balancer)** | The Receptionist | The single entry point for traffic; routes customers to the correct "kitchen." |
| **Listener Rules** | The Menu Board | Rules that route traffic based on hostname or path. |
| **Target Group** | Order Ticket Rail | A group of healthy tasks ready to receive traffic from the ALB. |
| **Security Group** | The Bouncer | Firewalls that allow/deny traffic. The Container SG only permits the ALB to communicate with it. |
| **Health Check** | Food Inspector | Regularly pings tasks (e.g., `/health`) to ensure they are functional. |

---

## Regional Deployment and Infrastructure Scaling

Expanding the application into new regions (ZA, AU, UK, US) follows a standardized 9-step process facilitated by the **w-aws-regional-deployment** AI skill.

### Regional Configuration Matrix
| Environment | Region | Domain | AWS Account ID |
| :--- | :--- | :--- | :--- |
| **DEV** | eu-west-1 | `*.dev.mixtelematics.com` | 601704920959 |
| **INT** | eu-west-1 | `*.mixdevelopment.com` | 601704920959 |
| **AU** | ap-southeast-2 | `automation-au.mixtelematics.com` | 365528985733 |
| **ZA** | eu-west-1 | `automation.za.mixtelematics.com` | 668736068906 |
| **UK** | eu-west-1 | `automation.uk.mixtelematics.com` | 365528985733 |
| **US** | us-east-1 | `automation.us.mixtelematics.com` | 365528985733 |

### Critical Deployment Constraints ("Gotchas")
*   **SSL Certificate Naming:** Wildcard certificates only cover one level. Use `automation-au.mixtelematics.com` rather than `automation.au.mixtelematics.com` if necessary to fit certificate constraints.
*   **Cross-Account Isolation:** ZA, AU, and ENT are separate AWS accounts. Docker images from the DEV ECR cannot be used directly across these boundaries.
*   **Networking:** Tasks must reside in **private subnets** with a NAT Gateway; they cannot use public subnets.
*   **Security Group Bi-Directionality:** Inbound rules on the ECS Security Group and outbound rules on the ALB Security Group must both allow ports 80 and 3000.
*   **Database Migrations:** The `configdiff` (Config Delta tool) requires a unique Aurora PostgreSQL DB migration for every environment.

---

## CI/CD Pipeline Architecture

Daily code deployments are handled via Azure DevOps, utilizing two distinct pipelines for the API and UI components.

### Branch Deployment Logic
*   **Development Branch:** Auto-deploys to the **DEV** environment.
*   **Integration Branch:** Auto-deploys to the **INT** environment.
*   **Production Branch:** Triggers simultaneous deployments to all production environments (**AU, ZA, ENT, UK, US**).
*   *Note: Manual overrides are available via "ForceDeploy" checkboxes for specific environments.*

### Pipeline Technical Specifications
| Feature | API (Powerfleet.Automation) | UI (Powerfleet.Automation.UI) |
| :--- | :--- | :--- |
| **Build Tool** | .NET 8 (`dotnet publish`) | Node 20 (`npm run build`) |
| **Output** | Compiled .NET app + Dockerfile | Next.js `.next/` folder + Dockerfile |
| **Deployment Strategy** | Updates Service via new Task Def revision | Updates Service via `--force-new-deployment` |
| **Image Tagging** | Pinned to specific image versions | Uses `:latest` tag |

---

## Operational Health and Troubleshooting

### Common Error Resolutions
*   **503 Service Unavailable:** This indicates the "Receptionist" (ALB) has no "Kitchen" (Target Group) to send orders to. This is caused by missing Listener Rules or a lack of healthy tasks in the Target Group.
*   **Site Can't Be Reached:** This is a DNS failure ("Phone number missing"). The Route 53 Alias record must be updated to point to the ALB.
*   **Tasks Keep Restarting:** Often caused by a failing Health Check ("Inspector marks chef unfit") or an app crash on startup. Checking CloudWatch logs is the primary diagnostic step.
*   **Redirect Issues:** If the application redirects HTTP to HTTPS (302), the Health Check inspector may mark the task as unhealthy. A dedicated `/health` endpoint returning `200 OK` is required.

---

## Key Contextual Quotes

> **On the Service (ECS Service):** "The manager who screams 'WE NEED 3 PIZZAS IN THE OVEN AT ALL TIMES!' If one pizza burns (crashes), the manager immediately starts a new one."

> **On the Registry (ECR):** "The huge warehouse where the chefs get their ingredients. If the chef (Task) can't reach the warehouse... because the road is closed (No Public IP/NAT Gateway), they can't cook anything."

> **On the Security Group:** "A bouncer standing at the door of the Kitchen... 'I only let the Receptionist (ALB) talk to me. Nobody else.'"

---

## Actionable Insights

1.  **Standardize Health Endpoints:** Ensure every application has a non-redirecting `/health` path to satisfy the ALB Health Check and prevent unnecessary task restarts.
2.  **Verify ADO Environments:** Before running a deployment for a new region, the Azure DevOps Environment must be created manually, or the pipeline will fail with an "Environment not found" error.
3.  **Monitor Target Groups:** A 503 error is frequently a "Target Group" issue. Always check if the "Order Ticket Rail" has healthy tasks before investigating deeper networking layers.
4.  **Use Private Subnets:** Ensure all ECS tasks are configured for private subnets to comply with the architectural standard; failing to provide a NAT Gateway for these tasks will result in ECR pull failures.