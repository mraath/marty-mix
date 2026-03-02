---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-03-02T13:15
---

# OPEN-1715 Setup UI and API on AWS for AU

Date: 2026-03-02 Time: 12:24
Parent:: ==xxxx==
Friend:: [[2026-03-02]]
JIRA:OPEN-1715 Setup UI and API on AWS for AU
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1715)

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
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Description

Please set up the AWS environments for both the Automation UI and API.
Once done we can deploy to these environment to start testing on AU.

## CODE

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1715 Setup UI and API on AWS for AU.INT

## PR

- [ ] OPEN-1715 Setup UI and API on AWS for AU > DEV
- [ ] OPEN-1715 Setup UI and API on AWS for AU > INT
- [ ] OPEN-1715 Setup UI and API on AWS for AU > UAT
- [ ] OPEN-1715 Setup UI and API on AWS for AU > PROD

## Do this

Based on the infrastructure documentation and the specific requirements for your **AU (Australia)** environment, here is the simplified, step-by-step setup guide. This guide replaces all generic variables with the specific values for the **operationsmixtelematics (365528985733)** account in the **ap-southeast-2** region.

---

## Part 1: Target Group Setup

Before creating the services, you must define where the Load Balancer should send traffic.

### 1.1 UI Target Group

- **Name**: `au-powerfleet-automation-ui`
- **Target Type**: **IP** (Required for Fargate)
- **Protocol / Port**: **HTTP : 3000**
- **Health Check Path**: `/`

### 1.2 API Target Group

- **Name**: `au-powerfleet-automation-api`
- **Target Type**: **IP** (Required for Fargate)
- **Protocol / Port**: **HTTP : 80**
- **Health Check Path**: `/health`

---

## Part 2: Task Definitions

These are the "blueprints" for your containers. Ensure you use the **MiX-DevOpsAdmin** role to create these.

### 2.1 UI Task Definition (`au-powerfleet-automation-ui`)

- **Container Name**: `au-powerfleet-automation-ui`
    
- **Image**: Use the existing image from your ECR (e.g., `powerfleet-automation-ui:latest`)
    365528985733.dkr.ecr.ap-southeast-2.amazonaws.com/powerfleet-automation-ui:latest
- **Port Mapping**: `3000`
- **Environment Variables**:
    - `NEXT_PUBLIC_API_URL`: `https://automation-api.au.mixtelematics.com`

### 2.2 API Task Definition (`au-powerfleet-automation-api`)

- **Container Name**: `au-powerfleet-automation-api`
    
- **Image**: Use the existing image from your ECR (e.g., `powerfleet-automation-api:latest`)
    
- **Port Mapping**: `80`
    
- **Environment Variables**:
    
    - `ASPNETCORE_ENVIRONMENT`: `Production`
        
    - `Environment`: `AU`
        

---

## Part 3: ECS Service Deployment

Now, run the tasks inside your existing cluster.

- **Cluster**: `AU-Config`
    
- **Launch Type**: **FARGATE**
    
- **Security Group**: `sg-09d97cfc127d25b95` (Reused as requested)
    
- **Services**:
    
    1. **UI Service**: Create `au-powerfleet-automation-ui` linked to its Target Group.
        
    2. **API Service**: Create `au-powerfleet-automation-api` linked to its Target Group.
        

---

## Part 4: Network Routing (ALB & DNS)

This makes the services reachable via your Public URLs.

### 4.1 ALB Listener Rules

Go to the **AU-Config-InternalALB** (HTTPS:443 Listener) and add these rules:

|**Rule Type**|**Host Header (Condition)**|**Forward To (Action)**|
|---|---|---|
|**UI Rule**|`automation.au.mixtelematics.com`|`au-powerfleet-automation-ui`|
|**API Rule**|`automation-api.au.mixtelematics.com`|`au-powerfleet-automation-api`|

### 4.2 Route 53 DNS

In the hosted zone for `mixtelematics.com`, create two **A (Alias)** records:

1. `automation.au.mixtelematics.com` → Alias to **AU-Config-InternalALB**
    
2. `automation-api.au.mixtelematics.com` → Alias to **AU-Config-InternalALB**
    

---

### Summary Checklist

| **Component**  | **AU Value**                                         |
| -------------- | ---------------------------------------------------- |
| **Region**     | ap-southeast-2 (Sydney)                              |
| **UI URL**     | `https://automation.au.mixtelematics.com`            |
| **API Health** | `https://automation-api.au.mixtelematics.com/health` |
| **API Env**    | `Production` / `AU`                                  |