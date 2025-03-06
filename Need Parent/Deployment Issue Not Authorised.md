---
created: 2023-11-01T07:38
updated: 2023-11-01T07:39
---
So and FYI... if you ever see an error containing this

> Not Authorised accountId:**40000000010021**, permissionId:**410000002**, entityType:Driver, entityId:-2304588864851382801 at MiX.Fleet.Services.Logic.Authorisation.AuthorisationManager.AuthoriseWithExceptionAsync

with ID's like the highlighted ones above (having lots of 0's in them) and there was DB maintenance or a deployment, then it is normally an issue with Fleet Services API or the MiX.Auth API's and just restarting them fixes the issue

Something to do with caching that goes pear shaped

(Shared by [[Stephan Visagie]])