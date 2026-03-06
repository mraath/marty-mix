---
created: 2026-03-04T09:57
updated: 2026-03-06T10:50
---
# Step-by-Step Guide: Fixing the AU DNS Routing

## The Problem

Right now, if you go to `https://automation.au.mixtelematics.com/`, the traffic never reaches the AWS ECS containers we just fixed.

Instead, it gets intercepted by a corporate DNS wildcard rule (`*.au.mixtelematics.com`) which points all unmatched traffic to `MiX-SYD-AU-DynaMiXUI`. Because that old ALB doesn't know what "automation" is, it just shows the default DynaMiX login screen.

Since this wildcard is managed outside of the specific AWS Route53 zone (likely by Corporate IT, Active Directory DNS, or Cloudflare), **I cannot run a script to fix it from here.**

You or the Networking/IT team must perform the following steps:

## Who to Contact

Raise a ticket with the **Networking, IT, or DevOps team** that controls the external DNS (	or the corporate `mix.local` Windows AD DNS).

## What to Ask Them to Do

Provide them with this exact request:

> "We have deployed new backend services for Powerfleet Automation in the AU region. However, the existing wildcard DNS rule (`*.au.mixtelematics.com`) is hijacking our traffic and sending it to the wrong load balancer (`MiX-SYD-AU-DynaMiXUI`).
>
> Please create **two explicit DNS A-Record Aliases (or CNAMEs)** to bypass the wildcard.
>
> **Record 1:**
>
> * **Type:** CNAME (or Alias)
> * **Name:** `automation.au.mixtelematics.com`
> * **Target:** `internal-AU-Config-InternalALB-850324176.ap-southeast-2.elb.amazonaws.com`
>
> **Record 2:**
>
> * **Type:** CNAME (or Alias)
> * **Name:** `automation-api.au.mixtelematics.com`
> * **Target:** `internal-AU-Config-InternalALB-850324176.ap-southeast-2.elb.amazonaws.com`
>
> *(Note: If the internal ALB is not exposed to the public internet via an API Gateway/Cloudflare, we will need you to expose `automation.au` through the same ingress proxy you use for other AU internal tools, pointing to the internal ALB above).*

## How to Verify It Worked

Once IT confirms the change has been made, run this command in your terminal:

```bash
nslookup automation.au.mixtelematics.com
```

**If it is still broken:**
It will return IPs like `15.134.166.177` or `54.206.151.118` (The wrong DynaMiXUI ALB).

**If it is fixed:**
It should return IPs like `10.70.1.30` and `10.70.3.83` (or the IP of your new ingress proxy). The UI and Swagger pages (`/swagger/index.html`) will instantly start working!
