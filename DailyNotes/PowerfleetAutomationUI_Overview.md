---
created: 2026-02-18T08:09
updated: 2026-02-18T08:17
---
# Powerfleet Automation UI - High Level Overview

> [!NOTE]
> This document explains the architecture of the Powerfleet Automation UI in simple terms.

## How it Works (The Pizza Restaurant Analogy)

Imagine the application as a **Pizza Restaurant**:

1.  **The Customer (You)**: You use the **UI** (the Menu) to place an order (Trigger an Automation).
2.  **The Waiter (ApiService)**: Take your order to the kitchen. It doesn't cook the pizza, it just delivers the message.
3.  **The Kitchen Door (Next.js Proxy)**: The waiter can't just walk into the kitchen (Security). They pass the order through a secure window. This hides the kitchen's messy details (Internal IP addresses) from the customers.
4.  **The Chef (Backend API)**: The actual worker who makes the pizza (Runs the automation).

## Architecture Layers

### 1. The "Face" (UI Layer)
-   **Where**: `src/app/page.tsx`, `src/components/`
-   **What**: The buttons, forms, and colors you see.
-   **Tech**: React, Next.js.
-   **Job**: Collects input (Salesforce Case ID) and shows results (Success/Fail).

### 2. The "Messenger" (Service Layer)
-   **Where**: `src/lib/services/ApiService.ts`
-   **What**: TypeScript functions.
-   **Tech**: `fetch` API.
-   **Job**: Takes data from the UI and sends it to the Proxy.

### 3. The "Security Guard" (Proxy Layer)
-   **Where**: `src/app/api/proxy/`
-   **What**: Server-side API routes.
-   **Tech**: Next.js API Routes.
-   **Job**:
    -   Hides the real backend URL.
    -   Handles CORS (Cross-Origin Resource Sharing) issues.
    -   Adds security headers if needed.

### 4. The "Brain" (Backend Layer)
-   **Where**: Internal Powerfleet Network
-   **What**: C# / .NET Core API.
-   **Job**: actually executes the Selenium/Playwright automation scripts.

## Visual Diagram

![Powerfleet Automation UI Architecture](/C:/Projects/marty-mix/Excalidraw/PowerfleetAutomationUI_Overview.excalidraw)

## Key Files

-   **Frontend Entry**: [page.tsx](file:///C:/Projects/Powerfleet.Automation.UI/src/app/page.tsx)
-   **API Logic**: [ApiService.ts](file:///C:/Projects/Powerfleet.Automation.UI/src/lib/services/ApiService.ts)
-   **Proxy Route**: [route.ts](file:///C:/Projects/Powerfleet.Automation.UI/src/app/api/proxy/qc/route.ts)
