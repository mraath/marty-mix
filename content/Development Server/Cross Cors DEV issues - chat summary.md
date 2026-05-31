---
wiki_ingested: 2026-05-28
created: 2025-03-26T09:22
updated: 2025-03-26T09:23
---
Here are the successful steps taken to fix the issue:

1. **Identified the Problem**:
    
    - The team discovered CORS policy issues and API endpoint errors.
2. **Checked Deployments**:
    
    - Multiple deploys were run and monitored to ensure the changes were applied correctly.
3. **Updated Configuration**:
    
    - The team updated the `AllowedOrigins` in the appsettings file to include necessary URLs.
4. **Debugged and Tested**:
    
    - Team members tested the changes locally and identified missing transformations.
    - They refreshed the iframe and checked for correct results.
5. **Fixed API URLs**:
    
    - Correct URLs were added to the load balancer rules and appsettings.
    - Ensured the API was up and running for the Dev environment.
6. **Final Deployments**:
    
    - Final deploys were triggered, and the team confirmed that the CORS issues were resolved and the API was functioning correctly.

Would you like more details on any of these steps?

The specific URLs that were updated in the `AllowedOrigins` section of the appsettings file are:

- **mixconfigfrangularui.uat.mixtelematics.com**
- **mixconfigfrangularapi.uat.mixtelematics.com**
- **selectioncriteria.uatss.mixuat.com**

These updates were crucial to resolving the CORS policy issues and ensuring the API endpoints functioned correctly.

Would you like more details on any of these URLs or the process?