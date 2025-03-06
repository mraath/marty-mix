# CONFIG-3138 Location Import issue

  [[BUSY]], [[Location]], [[Services]]
  

  DSSTBCFGIIS01
  
  LocationImportPath="\\DSSTBCFGIIS01\LocationImports

  ![[Pasted image 20220301113648.png]]
  
        <endpoint name="LocationServiceRequestQueue" value="dynamix.import.location.requests=EDF9ECB1-BA5D-4FFD-9257-49228CCA2BE5"/>

Service (app05) Queue was: BB06D40A-6F6A-46E5-8875-019AE770FA02


## Message from the BE

  BE: Location import request for {0} queued to MSMQ ID {1}

      Location import request for MR Org queued to MSMQ ID edf9ecb1-ba5d-4ffd-9257-49228cca2be5




  MiX.Core2.Messaging.Msmq

  The log to the location import service. ! Not showing any activity

![[Pasted image 20220301112535.png]]

Logz.IO is working fine

![[Pasted image 20220301112636.png]]

## Potential fix
The MSMQ value in the service app's config file seems to have been the problem
This value was different from the one in the IIS Web.Config file
![[Pasted image 20220301115138.png]]

The log is starting to show the imports
![[Pasted image 20220301115519.png]]

I will now test with a branch new import to see what happens