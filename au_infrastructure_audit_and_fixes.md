---
created: 2026-03-04T09:25
updated: 2026-03-06T10:50
---
# AU Environment - Infrastructure Audit & Fixes Report

This document outlines the findings from the comprehensive audit of the AU (Sydney) AWS infrastructure for the Powerfleet Automation UI and API services. It details what was misconfigured, why the deployments were failing, and the exact steps taken to fix them.

## 1. Cross-Region ECR Image URIs
**Finding**: The AU Task Definitions for both `au-powerfleet-automation-ui` and `au-powerfleet-automation-api` were configured to pull their Docker images from the DEV (`eu-west-1`) account (`601704920959.dkr.ecr.eu-west-1.amazonaws.com`).
**Impact**: The deployment pipelines were pushing to the newly created AU ECR repositories, but the ECS tasks were attempting to pull the old DEV images.
**Fix**: Registered new Task Definition revisions (Revision 5) for both services, updating the container image URIs to point to the correct AU ECR (`365528985733.dkr.ecr.ap-southeast-2.amazonaws.com/au-powerfleet-automation-ui:latest`).

## 2. Missing Security Group Outbound Rules (CRITICAL)
**Finding**: The Security Group assigned to both the UI and API ECS services (`sg-09d97cfc127d25b95` / `AU-ConfigAPI-SG`) had **zero** outbound (egress) rules allowing HTTP/HTTPS traffic to the internet.
**Impact**: Even after updating the Task Definitions to point to the correct AU ECR, the tasks failed to start with a `ResourceInitializationError: unable to pull secrets or registry auth: i/o timeout`. Because the tasks run in private subnets, they rely on the NAT Gateway to reach the ECR API over the internet. Without an outbound rule allowing port 443, the Fargate tasks were completely blocked from pulling the Docker images.
**Fix**: Added an `All Traffic` (Protocol `-1`) outbound rule destined for `0.0.0.0/0` to the ECS Security Group, restoring outbound connectivity.

## 3. Subnet Configuration Alignment
**Finding**: The `AU-Config-InternalALB` Load Balancer is configured to use only two Availability Zones: `ap-southeast-2a` and `ap-southeast-2b` (subnets `subnet-c339d4b4` and `subnet-4c935229`). However, the ECS service network configuration loosely allowed tasks to run in other AZs as well.
**Impact**: If a task were placed in an AZ not actively routed by the ALB, it could lead to potential health check failures and traffic drops.
**Fix**: Updated the ECS service network configurations to explicitly target only the two subnets aligned with the Load Balancer.

## 4. Stale Deployment and Circuit Breaker Loop
**Finding**: Due to the initial continuous failures to pull the eu-west-1 DEV images, the ECS Deployment Circuit Breaker kicked in. The ECS Services were stuck rapidly spinning up failing tasks while maintaining "zombie" tasks from older stale deployments. 
**Impact**: Standard pipeline deployments would hang or fail immediately because the service was marked unstable.
**Fix**: Executed a "Clean Redeploy" by forcibly stopping all stale running tasks, temporarily scaling the Desired Count to 0 to drain the connections, and then scaling back up to 1 targeting the new fixed Task Definition (Revision 5).

---

## Utility Scripts Created

During this audit, I created several utility Python scripts in `c:\Projects\Powerfleet.Automation` that you can use for future debugging. They do not require configuring profiles as long as your SAML AWS CLI session is active:

1. **`audit_au.py`**: Performs a comprehensive dump of all Services, Task Definitions, Target Groups, Listeners, Security Groups, and Subnets for the cluster.
2. **`check_status.py`**: A fast, polling-friendly script that prints the current running vs pending count, deployment states, and the exact reasons why the latest tasks stopped or started.
3. **`check_vpc.py` & `check_sgs.py`**: Network debugging scripts that map out VPC Endpoints, NAT Gateways, Route Tables, and explicitly dump Security Group Egress/Ingress rules to verify connectivity.
4. **`clean_deploy.py`**: A "nuke-and-pave" rescue script that wipes out all stuck tasks for a service and forces ECS to freshly deploy from the latest Task Definition. 

## Status

**SUCCESS**: Both the `au-powerfleet-automation-ui` and `au-powerfleet-automation-api` services have now reached a **steady state** in ECS and are successfully running the AU container images.
