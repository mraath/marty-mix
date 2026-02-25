---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-25T10:22
---

# OPEN-1494 Config Analysis Tool

Date: 2026-02-25 Time: 09:42
Parent:: ==xxxx==
Friend:: [[2026-02-25]]
JIRA:OPEN-1494 Config Analysis Tool
==URL TO JIRA==

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

## Quick overview Question 1

I want to do I high level check for the following. We need the brainstorm and planning skills to look into this. For now I would maybe ask to give me the high level of how we should be doing this and then drill down and show me the best way to visualise this to the user....

...the main things to, for now, visualise are these:

1) a Diff (to compare the template to what config is loaded)
2) Analysis of the changes
3) Chatbot setup to ask the changes and analysis more questions

HEre is the link for more info:
https://powerfleet.atlassian.net/browse/OPEN-1494

HEre is a grab of the text on that page.

The Problem: Configuration Drift & Lack of Visibility

Core Issues:

No Simple Visualisation: No easy way to show customers a vehicle's full config. Current methods are manual screenshots or incomprehensible and incomplete reports.

No Change Tracking: No automated way to ensure fleet configs stay synced with a standard template.

Root Cause: Visualisation

The platform's high configurability, while a strength, creates complexity that is difficult to manage, especially on a broader scale.

Consequences of Drift:

Total Energies Fiji Migration: A standard config was pushed to ~300 vehicles with non-standard installations, causing widespread camera rotation errors (flipped, upside down). Fixing this required manual, per-vehicle access.

Dormant Changes: Uncompiled UI changes can sit for months before being uploaded, creating unexpected and potentially hazardous behaviour.

Critical Data Gaps: A bus with a fatal accident reported zero speed for months because its config used a non-existent DTCO source with no GPS fallback. This was only discovered by an external AI analysis.

Use Case: Total Energies "Standard"

Context: The Total Energies "standard" is a complex baseline, allowing regional affiliates to make event thresholds more strict but not less strict.

Challenge: This flexibility makes automated validation difficult, as it requires complex logic to determine if a change is compliant.

Initial Approach: For the Fiji project, the team ignored this nuance and pushed the head office standard directly to all vehicles to get them synced.

Proof of Concept: The Fiji org is the ideal test case for the delta tool because its recent migration means it is out of sync and will undergo changes, providing real-world data for validation.

Camera Configuration Data

Current State: Camera configs are a major blind spot, only accessible by logging into a live device.

New Data Source: Stefan's team is developing a service to pull daily camera snapshots for all active devices.

Significance: This data is the key to integrating camera configs into the delta tool, providing a unified view of an asset's entire setup.

Related Work: William is already using these snapshots in the PowerFleet Analyzer desktop tool to visualise raw camera parameters, proving the data's accessibility.

Current Process:

Data Source: The "Asset Event Configuration" and "Asset Device Configuration" reports.

Key Insight: These reports pull live data directly from the database, not compiled files. This is critical because it captures UI changes before they are uploaded to a device.

Process:

Daily Pull: Pull the two CSV reports.

Comparison: Diff today's reports against yesterday's to flag changes.

I want to do I high level check for the following. We need the brainstorm and planning skills to look into this. For now I would maybe ask to give me the high level of how we should be doing this and then drill down and show me the best way to visualise this to the user....  
  
...the main things to, for now, visualise are these:  
  
1) a Diff (to compare the template to what config is loaded)

2) Analysis of the changes

3) Chatbot setup to ask the changes and analysis more questions  
  
HEre is the link for more info:  
https://powerfleet.atlassian.net/browse/OPEN-1494  
  
HEre is a grab of the text on that page.  
  
The Problem: Configuration Drift & Lack of Visibility

  

Core Issues:

  

No Simple Visualisation: No easy way to show customers a vehicle's full config. Current methods are manual screenshots or incomprehensible and incomplete reports.

  

No Change Tracking: No automated way to ensure fleet configs stay synced with a standard template.

  

Root Cause: Visualisation

  

The platform's high configurability, while a strength, creates complexity that is difficult to manage, especially on a broader scale.

  

Consequences of Drift:

  

Total Energies Fiji Migration: A standard config was pushed to ~300 vehicles with non-standard installations, causing widespread camera rotation errors (flipped, upside down). Fixing this required manual, per-vehicle access.

  

Dormant Changes: Uncompiled UI changes can sit for months before being uploaded, creating unexpected and potentially hazardous behaviour.

  

Critical Data Gaps: A bus with a fatal accident reported zero speed for months because its config used a non-existent DTCO source with no GPS fallback. This was only discovered by an external AI analysis.

  

Use Case: Total Energies "Standard"

  

Context: The Total Energies "standard" is a complex baseline, allowing regional affiliates to make event thresholds more strict but not less strict.

  

Challenge: This flexibility makes automated validation difficult, as it requires complex logic to determine if a change is compliant.

  

Initial Approach: For the Fiji project, the team ignored this nuance and pushed the head office standard directly to all vehicles to get them synced.

  

Proof of Concept: The Fiji org is the ideal test case for the delta tool because its recent migration means it is out of sync and will undergo changes, providing real-world data for validation.

  

Camera Configuration Data

  

Current State: Camera configs are a major blind spot, only accessible by logging into a live device.

  

New Data Source: Stefan's team is developing a service to pull daily camera snapshots for all active devices.

  

Significance: This data is the key to integrating camera configs into the delta tool, providing a unified view of an asset's entire setup.

  

Related Work: William is already using these snapshots in the PowerFleet Analyzer desktop tool to visualise raw camera parameters, proving the data's accessibility.

  

Current Process:

  

Data Source: The "Asset Event Configuration" and "Asset Device Configuration" reports.

  

Key Insight: These reports pull live data directly from the database, not compiled files. This is critical because it captures UI changes before they are uploaded to a device.

  

Process:

  

Daily Pull: Pull the two CSV reports.

  

Comparison: Diff today's reports against yesterday's to flag changes.

## Image inspiration

![[Pasted image 20260225101944.png]]

### Diff Cards

![[Pasted image 20260225102220.png]]



## CODE

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1494 Config Analysis Tool.INT

## PR

- [ ] OPEN-1494 Config Analysis Tool > DEV
- [ ] OPEN-1494 Config Analysis Tool > INT
- [ ] OPEN-1494 Config Analysis Tool > UAT
- [ ] OPEN-1494 Config Analysis Tool > PROD

