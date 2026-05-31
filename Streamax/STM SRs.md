---
wiki_ingested: 2026-05-28
created: 2023-10-30T07:36
updated: 2023-10-30T16:57
---
## Image

- [ ] ![[Video Download Uplodad Issues.excalidraw]]


## Add my stuff here


## Team findings

I've created a script that I am running in all environments
I did not make it pretty ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/30_f.png?v=v82)  but is shows me what I need

![[SQL Mobile Device Channels for Streamax devices non complete]]

UK  (1 template)

LibraryKey  MobileDeviceTemplateKey DeviceKey   LibraryKey  MobileDeviceTemplateKey DeviceKey  
----------- ----------------------- ----------- ----------- ----------------------- -----------  
1928        48605                   5254        1928        48605                   4906  

AU (0 templates)

ZA (2 templates)

LibraryKey  MobileDeviceTemplateKey DeviceKey   LibraryKey  MobileDeviceTemplateKey DeviceKey  
----------- ----------------------- ----------- ----------- ----------------------- -----------  
3090        52729                   6055        3090        52729                   6191  
404         56561                   6191        404         56561                   6055  

ENT (0 Templates)

US (1 template)

LibraryKey  MobileDeviceTemplateKey DeviceKey   LibraryKey  MobileDeviceTemplateKey DeviceKey  
----------- ----------------------- ----------- ----------- ----------------------- -----------  
1299        40579                   5089        1299        40579                   4775


Zeshan Khan
0 on AU 

Zonika Smit
I know - I think we should confirm all assets in those templates to make sure they are correct in DynamoDB and then update the template record

Pallavi Jadhav
For UK all assets are point to correct template. Data verified by Zeshan.

Zeshan Khan
UK Dynamo DB shows that for the one org id -4421359098195938760, all the cameras in the template(template key 48605) on SR-16677 are Streamax Cameras(M1N).

Zeshan Khan
Checking ZA and US now. . .
AU 0 

Zonika Smit
UAE is also 0

Zeshan Khan
US has only one asset on the template, which belongs to the Default Streamax CG. The asset is not commissioned. Org: INTERNAL - MiX MX DEMO; INTERNALMiXMXDEMO_2021. Vehicle ID 18

Zeshan Khan
ZA:
52729 is not linked to any config group
56561 has two config groups, 
	58149 - Scania Configs (internet) MIX4000 Heavy vehicles + Ad plus has 1 asset on Africa - Cellstop - XCCS Trucking (PTY) Ltd; AfricaCellstopEXTREMECUSTOMSCLEARINGSERVICESCC_2015; Vehicle ID 106. Not Commissioned.
	58150 - Scania Configs (internet) MIX4000 Heavy vehicles has 0 assets

Zonika Smit
ok so this is a great find causing very little issues except potentially in UK in the UI
has context menu

