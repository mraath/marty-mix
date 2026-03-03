---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-03-03T08:17
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

## MORE HELP ON ABOVE

Yes, you are in exactly the right place! Your screenshot shows the **Create new task definition** screen for the **ap-southeast-2 (Sydney)** region.

Since you are setting up the **UI** first, here is exactly what to fill into those fields based on your requirements:

### 1. Task definition configuration

* **Task definition family**: `au-powerfleet-automation-ui`

### 2. Infrastructure requirements

* **Launch type**: **AWS Fargate** (Ensure this is checked)
* **Operating system/Architecture**: `Linux/X86_64`
* **Task size**:
* **CPU**: `.25 vCPU` (This is usually sufficient for the UI)
* **Memory**: `.5 GB`



---

### 3. Container - 1

This is the section shown in the middle of your screenshot.

* **Name**: `au-powerfleet-automation-ui`
* **Image URI**: `365528985733.dkr.ecr.ap-southeast-2.amazonaws.com/powerfleet-automation-ui:latest`
* **Essential container**: Yes (Should be checked by default)
* **Port mappings**:
* **Container port**: `3000`
* **Protocol**: `TCP`
* **App protocol**: `HTTP`



---

### 4. Environment variables

Scroll down to the **Environment variables** section within the Container definition:

* **Click "Add environment variable"**
* **Key**: `NEXT_PUBLIC_API_URL`
* **Value**: `https://automation-api.au.mixtelematics.com`

---

### 5. Logging (Optional but Recommended)

In your screenshot, I see the **Log collection** section is open.

* **Log driver**: `awslogs`
* **Log group**: It should auto-populate, but you can set it to `/ecs/au-powerfleet-automation-ui` to match the DEV pattern.

---

**Next Step:**
Once you click **Create** at the bottom, repeat this process for the **API** using these changes:

* **Family & Name**: `au-powerfleet-automation-api`
* **Image**: `365528985733.dkr.ecr.ap-southeast-2.amazonaws.com/powerfleet-automation-api:latest`
* **Port**: `80`
* **Env Var 1**: `ASPNETCORE_ENVIRONMENT` = `Production`
* **Env Var 2**: `Environment` = `AU`

Would you like me to clarify the **API Environment Variables** again before you start the second one?

---

Based on your last screenshot, it looks like `AU-Config-InternalALB` only has an **HTTP:80** listener active right now, rather than the HTTPS:443 one we were looking for. This is perfectly fine; it just means we will perform the "association" on Port 80 instead.

To fix the error and link your Target Groups to the Load Balancer, follow these steps directly in the screen shown in your last image:

### 1. Associate the UI Target Group

1. In the **Listeners and rules** tab, click on the **4 rules** link next to the **HTTP:80** listener.
    
2. Click **Add rule**.
    
3. **Name**: Give it a name like `AU-Automation-UI`.
    
4. **Add condition**: Select **Host header** and enter `automation.au.mixtelematics.com`.
    
5. **Add action**: Select **Forward to target groups** and choose `au-powerfleet-automation-ui`.
    
6. Click **Create**.
    

### 2. Associate the API Target Group

1. Repeat the process above for the API.
    
2. **Name**: `AU-Automation-API`.
    
3. **Add condition**: Select **Host header** and enter `automation-api.au.mixtelematics.com`.
    
4. **Add action**: Select **Forward to target groups** and choose `au-powerfleet-automation-api`.
    
5. Click **Create**.

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
When you create these **ECS Services**, there are a few critical "Networking" and "Load Balancing" settings you must select to ensure the containers can talk to the internet and the Load Balancer can find them.

### 1. Networking Settings

In the **Networking** section of the Service creation:

- **VPC**: Select the same VPC you used for the Target Groups (`vpc-1553a770`).
- **Subnets**: Select the **Private subnets** associated with your cluster (usually labeled `Private-app` or similar).
- **Security Group**: Use the one specifically requested: `sg-09d97cfc127d25b95`.
- **Public IP**: Set this to **DISABLED** (since these are in private subnets and will be reached via the Internal ALB).
    

### 2. Load Balancing Section

This is where you "hook up" the service to the Target Groups you made in Part 1:

- **Load balancer type**: Select **Application Load Balancer**.
- **Load balancer name**: Select `AU-Config-InternalALB`.
- **Container to load balance**: 
    
    - For the **UI Service**: Choose the `au-powerfleet-automation-ui` container and the port `3000`.
    - For the **API Service**: Choose the `au-powerfleet-automation-api` container and the port `80`.
        
- **Target Group**: Select the existing Target Groups you created (`au-powerfleet-automation-ui` or `au-powerfleet-automation-api`) rather than creating new ones.
    

### 3. Deployment Configuration

- **Desired tasks**: Start with **1** (you can increase this later if needed).
    
- **Deployment type**: **Rolling update** is standard for this setup.
    

---

### Important Reminder: The "Image Error"

Since you haven't pushed the actual code to ECR yet, these services **will initially fail** with an `ImageNotFoundException` or `Essential container in task exited`.

> **Don't panic!** This is expected. Once you run your first build/deploy cycle and the images exist in ECR, the services will automatically pull the new images and start running correctly.
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

### Step 4.2: Route 53 DNS Configuration (UI)

Follow these steps in the Route 53 console to point your URL to the Load Balancer:

1. **Open the Route 53 Console**: Go to **Hosted Zones** and select `mixtelematics.com`.
    
2. **Create Record**:
    
    - **Record Name**: Enter `automation.au`.
        
    - **Record Type**: Select **A - Routes traffic to an IPv4 address and some AWS resources**.
        
    - **Alias**: Toggle this switch to **Yes**.
        
3. **Route traffic to**:
    
    - Choose **Alias to Application and Classic Load Balancer**.
        
    - **Region**: Select **ap-southeast-2 (Sydney)**.
        
    - **Load Balancer**: Select `AU-Config-InternalALB`.
        
4. **Routing Policy**: Leave as **Simple routing**.
    
5. **Save**: Click **Create records**.

---

### Summary Checklist

| **Component**  | **AU Value**                                         |
| -------------- | ---------------------------------------------------- |
| **Region**     | ap-southeast-2 (Sydney)                              |
| **UI URL**     | `https://automation.au.mixtelematics.com`            |
| **API Health** | `https://automation-api.au.mixtelematics.com/health` |
| **API Env**    | `Production` / `AU`                                  |