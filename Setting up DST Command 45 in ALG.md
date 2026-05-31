---
created: 2025-03-25T07:11
updated: 2025-03-25T15:33
wiki_ingested: 2026-05-28
---
## Setting up in ALG

### Setting up the API

- I copied the FMTimeAdjuster API from OMN IIS to ALG HSATSDMXIIS01
- ON HSATSDMXIIS01, the API is running: http://localhost/DynaMiX.DeviceConfig.FMTimeAdjuster.Api

![[SR-19946 ALG DTS fix API Running.png]]
- **Please note**: It could be that the config file still has some OMN settings. I had a quick look, but we will need to ensure this is in order when we test.

### Setting up the APP

- I copied the old 18.17 app from OMN Jumpbox to ALG Jumpbox.
- It seems to be running there

![[SR-19946 ALG DTS fix App Running.png]]
- **Please note**: We just need to test this. I don't have logins for this server currently. I will speak to Russell re testing this.

## Logs

Russell W: LOGS on HSATSDMXIIS01 L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api

## Testing


I changed the FM Adjuster API's config file to reflect that of ALG's Dynamix Config file.
I then tested it for the following Org, Asset:

orgId=5142497371717118183
assetId=-5612607933938248877



It seems to be working well:

APP:

![[Setting up DST Command 45 in ALG APP.png]]

LOG:

![[Setting up DST Command 45 in ALG LOG.png]]
