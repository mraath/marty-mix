---
created: 2024-02-20T17:27
updated: 2024-03-28T11:11
---

![[OE-478 Cross Domain Blocker.excalidraw]]


## Operations Eg

| UI                                                                         | API                                                         |
| -------------------------------------------------------------------------- | ----------------------------------------------------------- |
| .js ...OperationsUrl = "http://localhost:5000"                             |                                                             |
| .js.VIRUS ...OperationsUrl = "https://operationsui.us.mixtelematics.com"   | APIURL_US = "https://operationsapi.us.mixtelematics.com";   |
| .js.DSDEV ...OperationsUrl = ""                                            |                                                             |
| .js.DSINT ...OperationsUrl = "https://operations.mixdevelopment.com"       | APIURL_INT = "https://operationsapi.mixdevelopment.com";    |
| .js.DSSTBCFG ...OperationsUrl = ""                                         |                                                             |
| .js.DUBENT ...OperationsUrl = "https://operationsui.ent.mixtelematics.com" | APIURL_ENT = "https://operationsapi.ent.mixtelematics.com"; |
| .js.DUBUK ...OperationsUrl = "https://operationsui.uk.mixtelematics.com"   | APIURL_UK = "https://operationsapi.uk.mixtelematics.com";   |
| .js.DUBZA ...OperationsUrl = "https://operationsui.za.mixtelematics.com"   | APIURL_ZA = "https://operationsapi.za.mixtelematics.com";   |
| .js.HSATS ...OperationsUrl = "https://operations.mixdevelopment.com"       |                                                             |
| .js.HSOMN ...OperationsUrl = ""                                            |                                                             |
| .js.HSSYD ...OperationsUrl = "https://operationsui.au.mixtelematics.com"   | APIURL_AU = "https://operationsapi.au.mixtelematics.com";   |
| .js.HSUAE ...OperationsUrl = "https://operationsui.ae.mixtelematics.com"   | APIURL_UAE = "https://operationsapi.ae.mixtelematics.com";  |
| .js.HSUAT ...OperationsUrl = "https://operations.uat.mixtelematics.com"    | APIURL_UAT = "https://operationsapi.uat.mixtelematics.com"; |

## Message to SOC

Hi. I hope someone can help me.
I know that Fleet has set up a lot of subdomains for the Frangular work they have done.
One such example is their **operations** story they worked on.
For each environment (eg. DEV, ZA, VIR) they need two subdomains.
One for the **UI** and one for the **API**.
eg UI for ZA: https://operationsui.za.mixtelematics.com
eg API for ZA: https://operationsapi.za.mixtelematics.com
Please let me know who we should speak to or what you need from us?
Thanks