---
created: 2024-05-17T12:03
updated: 2024-05-17T12:04
---
## Should the Video event configuration page open on dev? Currently throwing an error

It wont work, because we dont yet have a public domain set up...
Re STM-1074, we still need some subdomains, Zonika will work on that once done with her work.
This will help us make calls between UI > Frangular UI > Frangular API
So you need to run it all on your local machine

## I have created a new API endpoint. Code is on Dev. In frangular API do I need to update reference for MiX.DeviceConfig.API.Client from dev(beta) version?

Once you made MiX.DeviceConfig.API.Client changes, you can update the API's references


## I see that Frangular API Dev branch is different from INT. My code should go to Dev right?

Yes, they are different. For now we will develop against DEV, branched from INT. 
Once DEV works we will properly merge to INT.
Things will make more sense then.

## How do we add files in FR-UI?

- In VS Code
- To add a new component, you have to make use of the create component angular command (as shown in the documentation above)
- Adding a normal, eg, class, just right click on the folder where you want it and click on add file

## What is the data flow to the FR-UI?

The flow is:
OLD UI > FR-UI > FR-API > Internal Client > Old API > Repo (DB)

- [Frangular UI calling the Frangular API.pdf](https://mixtelematics-my.sharepoint.com/personal/marthinus_raath_mixtelematics_com/Documents/Microsoft%20Teams%20Chat%20Files/Frangular%20UI%20calling%20the%20Frangular%20API.pdf)
- [Frangular Moving parts UI calling API.mp4](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/EYeJ1AmCq8pMiQQrNSsBb1YBaZnhwG894v8hqH2iVNrAMA?e=den0Ge "https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/eyej1amcq8pmiqqrnssbb1ybaznhwg894v8hqh2ivnrama?e=den0ge")

[[Frangular UI calling the Frangular API]]

## Changes I have made on UI are not reflecting after building project

npm run dev
And then if you follow the provided link you should see your changes?
If you are already in this mode, purely saving changes should reflect it in the page.
This is a beauty of Angular projects now.
