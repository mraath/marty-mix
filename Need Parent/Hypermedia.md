
## Back End

- It is driven from the Back-end
- An eg could be the ConfigurationGroupsModule

### The route

![[Pasted image 20221129013546.png]]
- The route is usually defined in the beginning.
- The name here is GET_CONFIG_DIFFERENCE
- The url expects orgId and assetId
- You could for instance pass in the orgId from the BE as you would know it already
- Then you only need to send the assetId from the FE as that would be a variable

### The method

![[Pasted image 20221129013842.png]]
- As can be seen here, next the method which will be called when the FE calls this route is declared.
- In this case GetConfigDifference.

### Hypermedia

- The FE will usually first call a method to initialise the page.
- For the example we use it would call GetConfigGroupListPage
![[Pasted image 20221129014102.png]]
- Within this method it calls the AppendHypermedia
- It is not always split out like this
- Sometimes the hypermedia gets added in here directly
![[Pasted image 20221129014157.png]]
- Herewith the example of the hypermedia being added
- The hypermedia will be sent with the carrier (dto) to the FE
- We can see here that our route GET_CONFIG_DIFFERENCE it added
- It gets a user-friendly name "configDiff" which would be used from the FE
- Seeing we already know the orgId, we add it in here already

## Front End

- In the frontend we usually first have a call to the backend
- This call will build up the carrier (dto) on which we will find the data and in this case the hypermedia
- Herewith an example of where it gets called and how we then apply the results
![[Pasted image 20221129014652.png]]
- Usually the results will be applied to something like pageData
- Then in your method where you want to call the route, you will do something like this
![[Pasted image 20221129014810.png]]
- In this case, in our method showGroupDiffInfo
- We call the configDiff
- This is in our pageData object as shown in the previous slide
- Seeing we have already added the orgId from the BE, we now only specify the assetId
- The ".then" is a promise
- This will happen once the route returns the data... 
- We then work with that data

