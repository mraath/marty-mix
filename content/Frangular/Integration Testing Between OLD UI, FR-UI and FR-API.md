---
created: 2024-05-17T12:07
updated: 2024-05-17T12:09
---
## Integration Intro

Currently this is very tricky, as we don't yet have this on dev.
For this reason you have to test things on your local environment.

Ensure all of you code is checked into your branch.
For a different Dev to test this, either merge it into DEV and have them pull the latest.
Another way could be for them to pull your latest branches and test it locally.

Pull all the different repos and start testing them.
I think the best would be to test in the following order.

- Old API (swagger)
- Internal Client (Unit test)
- FR-API (swagger)
- FR-UI (might need to hardcode the authtoken, orgid, other ids, as there is no OLD UI at this point feeding in the data)
- UI (Check the Networking tab, ensure it gets the module, hypermedia and lastly successfully call the data via a method)
- BE (this is needed if the BE notifies the UI of eg. a menu item)

## Old API

- API: Swagger: Worked
![[Frangular Chat Pallavi Swagger Worked.png|600]]

## Internal Client

I ran the following test. It succeeded.
![[Frangular Chat Pallavi Internal Client Passed.png|600]]

## FR-API

FR-API: Worked
![[Frangular Chat Pallavi FR Swagger Worked.png|600]]

## FR-UI

We still had some disconnected parts.
I will explain this more in a section below, but in short, the FR-UI by itself doesnt have the authtoken, orgid, etc.
This is because it gets sent in via the iFrame messages from the OLD UI.

In order to just test all of this, I forced the download button to call the hypermedia method "getVideoEventConfigurationDetail".
I will explain below why I forced it and how.
This is not a permanent solution, but I needed to see if it reached the method and it did.
And it did, I could set a break point in the FR-API
![[Frangular Chat Pallavi FR-UI Hardcoded values calls FR-API.png|1000]]

The reason why I needed to hardcode the values are as follows.
![[Frangular Chat Pallavi FR-API call made to get Data.png|1000]]
You will see in the URL it shows undefined for eg. OrgId...
This is because this page doesn't yet receive the messages from the OLD UI to set the AuthToken and OrgId.
(Data is not being populated from the Breadcrumb Org Selected etc)

It also doesn't yet send back messages to the OLD UI to eg. open editing pages.
Since I needed to test if this FR-UI can get the data, I hardcoded some values.
Herewith an eg. of how I hardcoded the values in FR-UI for testing.
![[Frangular Chat Pallavi FR-UI BreadCrumb set.png|1000]]

Now you need to change all this, so that the hardcoding is not needed.
Do this by setting up the sending and receiving of messages.
Both on the OLD UI and FR-UI.
You can follow this:
[[Frangular Messaging OLD UI to FR-UI]]

## UI

For this story we added the "Video event configuration" action menu to the config group
![[Frangular Chat Pallavi FE Menu item to call iFrame Page.png|1000]]

Clicking on this should then open the iFrame page: success
The iFrame page should then call the FR-UI

The first time the iFrame didn't show the FR-UI.
There was a few reasons:
1) It wasn't running
2) Once it was running (npm run dev) it still didn't load as the port was not correct
The reason the port was incorrect, was while I was testing I spoke to Fleet.
They mentioned that the cross cors issue happened if the ports were not specified correctly.
I changed our FR-UI port to 5001.
I also changed the FR-API port to 5000.
The UI still pointed to the wrong port though.
So I just changed the following to:
var angularNextConfigUrl = "http://localhost:5001";

![[Frangular Chat Pallavi UI iFrame Port value.png|1000]]

Now the iFrame loaded the FR-UI correctly.
Next step is to check if the UI goes via the FR-UI to the FR-API to get:
- The Module (on which the hypermedia is)
- The Hypermedia (on which the calls is)
- The actual call

The FR-API is reached and the module sent down with the hypermedia.
![[Frangular Chat Pallavi FR-API MOdule found.png|1000]]

It also gets the hypermedia.
![[Frangular Chat Pallavi FR-API Hypermedia found.png|1000]]

In the FR-UI section above, you can see how the OLD UI and FR-UI sends messages to each other.
This is used to sync the authToken, orgids, etc and to notify the OLD UI to perform some tasks.

## BE

![[Frangular Chat Pallavi Green Monster.png|300]]
Successful
If you struggle try the below
[[BE Issue Not opening]]
