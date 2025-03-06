---
created: 2025-03-06T08:46
updated: 2025-03-06T10:26
---

## Moving parts

This will just be the moving parts to get the basic components in place. 
Going forward you will need to add:
- BE logic, eg. Permission based tab that comes from the back-end, displaying this tab
- Styling, see [[STM-1074 Moving Shuans html to our component]]

## A new page

I will explain the BASIC parts we need below. Just have a look at this to get the idea.

![[Frangular New Page.svg]]


## Overview

In the sections below I will walk through:

- OLD UI
	- iFrame - HTML
	- Messages
- Frangular UI
	- iFrame Adapter - HTML
	- Messages

## Old UI

- In the old UI, you will need a way to get to the new page. Let's call it a **holding page**.
	- This holding page, will have an **iFrame**
	- This iFrame will "pull in" the Frangular UI
- In the above example we have a menu item which will call this new (iFrame) holding page
```c#
//ConfigGroupsMultiselectLanding
customRouteProvider.route(Routes.ConfigGroupsMultiselectLanding, {
	title: "Configuration groups (Beta)",
	organisation: "miller",
	controller: Controllers.ConfigGroupsMultiselect.ConfigGroupsMultiselectController.controllerName,
	templateUrl: "_cdn/Templates/ConfigAdmin/ConfigGroupsMultiselectTemplate.html"
});
```
- In the above, the menu makes use of routing to go to this new holding page "ConfigGroupsMultiselectTemplate.html"
- It could also have been a set-path.... like the eg. below
```c#
videoEventConfigurationClicked(row): void {
	this.location.setPath(MiXFleet.ConfigAdmin.Routes.VideoEventConfigurationLanding, { id: row.configGroupId });
}
```

- If the user has now clicked on the menu item (or link the setPath to your holding page), you will now be on your new holding page.
	- This will still be within the OLD UI
	- In this new holding page you now need to set up a few things
		- The iFrame to display the Frangular UI
		- Messaging: for the OLD UI and FR UI to talk to each other
			- This is to SEND messages to the FR UI
			- Also to RECEIVE messaged from the FR UI

### iFrame

#### HTML

The HTML contains the following element which connects this iFrame with the FR-UI.
The channelname attribute connects it specifically to the same channel name in the FR-UI.
In this case the channelname is set to configGroupsMultiselectChannel in the controller.

```html
<div class="row-fluid container-content container-fixed">
	<div class="container-fluid full-height">
		<dmx-iframe-host-adapter iframename="$controller.iframeName" iframeurl="$controller.iframeUrl" channelname="$controller.channelName" width="100%" height="100%" fleet-loader scrolling="no"></dmx-iframe-host-adapter>
	</div>
</div>
<div class="loading-overlay" ng-show="$controller.isLoading"></div>
```

#### Controller (.ts)

```c#
// This links the HTML values and controller values
// In order to display the iFrame

iframeName: string = "iframeConfigGroupsMultiselectHost";
iframeUrl: string = angularNextConfigFrangularUrl + "/configuration-groups-multiselect";
channelName: string = "configGroupsMultiselectChannel";
```

### Messages

#### Controller (.ts)

A big problem for me was the timing of when to send the initial values.
Also to ensure eg. the old UI already has the correct data, before I trigger to send it through to the FR UI.
I used to have it in the initializer, however, the timing was often off.
After inspecting the Fleet team's operations UI, I tried the below and it seems to be working fine.
If anything changes I will change it here.

> We also pass in the xAuth from the OLD UI, it is then consumed in FR UI

```c#
// Action enum is used to identify the type of message being sent
// The enum is the same on both sides in order to talk to one another

export enum Actions {
	//Page load started
	Load,
	EditEventTemplate,
	...
}

// Data interface... used for the data being sent back and forth
// This will go into the payload object
// Based on your needs you will create this

export interface IConfigData {
	id: string;
	organisationId: string;
	xAuth: string;
	extra: string; //Used eg. lineId, mobileDevice
}

// The payload is sent back and forth
// It is then also read to determine the type of message received to know what action to take

export interface IPayload {
	data: IConfigData
	action: Actions,
	uid: string, 
	result?: boolean
}

private iframePayload: IPayload;

// I saw this, I am not sure we make use of it, however, in the FR API we have modules set up
// Once again, I dont think we use it in the OLD UI, but just in case you need this

get moduleName(): string { return "configAdmin"; }


// SENDING a message to FR UI

sendMessage(): void {
	if (this.organisationId && this.organisationId !== undefined) {
		console.log("ORG sendMessage: " + this.organisationId);
		this.scope.$broadcast("sendIframeMessage", [this.iframeName, this.channelName, this.iframePayload]);
	}
}

// RECEIVING a message from FR UI
receiveMessage(): void {
	this.scope.$on("receiveIframeMessage", (ev, args) => {
		if (args && args.length >= 2 && args[0] === this.iframeName && args[1] === this.channelName && args[2].data) {
			console.log("Received Message for CGML");
			var payloadData = JSON.parse(args[2].data);
			//const payloadData: IPayload = JSON.parse(payload.data);
			//this.updateSelectedOrganisation(payloadData.organisationId, payloadData.organisationName);
			switch (payloadData.action) { //BASED ON THE ACTION ENUM We do things in the OLD UI - I will keep only a few for eg.
				case MiXFleet.ConfigAdmin.Controllers.ConfigGroupsMultiselect.Actions.UploadeCompleted:
					if (payloadData.result) {
						this.scope.$popAlert('success', 'Request submitted successfully');
					}
					else {
						this.scope.$popAlert('error', 'Upload failed');
					}
					return;
				case MiXFleet.ConfigAdmin.Controllers.ConfigGroupsMultiselect.Actions.EditAssetCANScript:
					return this.location.setPath("config-admin/configuration-groups/asset/mobile-device/edit", { assetId: payloadData.data.id, lineId: payloadData.data.extra });
				default:
					return;
			}
		}
	})
}


// In order for the SEND and RECEIVE to work well, you need to instantiate it
// I remember struggling with the best place to do this
// This is where I now add it and it workd well

registerSendReceiveMessages(): void {
	console.log("WIP Register Send Receive");
	this.scope.$on("iframeReady", (ev, args) => {
		if (args && args.length === 2 && args[0] === this.iframeName && args[1] === this.channelName) {
			console.log("Registering Send Receive");
			
			//This just initialises some data to be sent
			//For now I just want the org Id
			
			//The iframePayload moves data between the OLD UI and FR UI
			//I have included THIS data structure, but this could be different for your page
			//THIS data structure is seen above
			
			var data = <IConfigData>{
				xAuth: this.authentication.authenticationToken,
				organisationId: this.organisationId
			}

			this.iframePayload = <IPayload>{
				data: data,
				action: Actions.Load,
				uid: new Date().valueOf().toString()
			};

			this.sendMessage(); //Initial send, eg. to get AuthToken and OrgId through to FR UI
			this.receiveMessage(); //Initiates the scope.on to listen
		}
	});
}

// The above registerSendReceive needs to be instantiated
// I used to do it in initialise, however, this didnt consistently work
// Moving it to the contructer did the job

constructor(...) {
	super(...);
	this.registerSendReceiveMessages(); // Initialise the send receive
}

// Herewith just a few egs. of sending data to the FR UI

//Each time the user selects a different org in the OLD UI, this also needs to be sent to the FR UI
public onSelectionCriteriaChanged ... {
	//...
	//Set new data
	this.organisationId = group.id;
	var data = <IConfigData>{
		xAuth: this.authentication.authenticationToken,
		organisationId: this.organisationId
	}
	
	this.iframePayload = <IPayload>{
		data: data,
		action: Actions.Load,
		uid: new Date().valueOf().toString()
	};
	//Send data
	this.sendMessage();
}

updateSelectedOrganisation ... {
	//...
	this.iframePayload.data.organisationId = organisationId;
	this.sendMessage();
}
```

##  Frangular UI

### HTML

At the top of the HTML the following iFrame Adapter is used to connect the HTML with the ts.
This will in turn connect the FR-UI with the OLD UI

```html
<dmx-iframe-adapter *ngIf="enableIFrame" (messageReceived)="onMessageReceived($event)"
	[channelName]="'configGroupsMultiselectChannel'" [newMessage]="iFrameMessage">
</dmx-iframe-adapter>

<!-- REST OF YOUR HTML ELEMENTS WILL COME HERE -->
```

Notice all mentions of **message**.
- The newMessage attribute is used to send the message (iFrameMessage) to the OLD UI
- The messageReceived attribute specifies which method in the ts file should be called when a new message is received from the OLD UI ($event)
- The channelName attribute makes it unique between the FR-UI component and the this OLD UI iFrame

### Controller (.ts)

The onMessageReceived is called when a new message ($event), is received from the OLD UI.
Here is an example

#### Receiving a message

```ts
onMessageReceived(msg: Message) {
    //This is how the org Id is set from the OLD UI
    this.organisationId = msg.data.message.data.organisationId;

	//Here more values could be set or actions taken

    //This is how we set the auth token
    this.sessionService.setAuthToken(msg.data.xAuth).pipe(takeWhile(() => this.alive))
      .subscribe((data) => {
        if (!data)
          return;

        this.authTokenSet = true;
        if (!this.searched && this.organisationId && this.organisationId !== undefined) {
          console.log("Getting the config groups from FR-UI");
          this.getConfigGroups(); //This will call the method on the hypermedia to call the data
        }
        this.spinnerService.show(false);
      });
  }
```

#### Sending a message

When the sendMessage method is called, it sends values to the OLD UI.
Herewith some code to explain how to set it up.

```ts
//Initialising an iFrameMessage object as a string this will become a JSON object which will be sent to the OLD UI iFrame
iFrameMessage: string;

//Writing the sendMessage method, in this page this just gets called from other places based on the action and what needs to be sent to the OLD UI
private sendMessage(id: string, action: Actions, extra: string = "") { //Please note that you can add more values here which you might want to send
    const payload: IPayload = { //This will be made into a JSON object
      action: action,
      uid: new Date().valueOf().toString(),
      data: {
        id: id.trim(),                        //This sends through an Id, needed to open the template
        organisationId: this.organisationId,
        extra: extra.trim()                   //For this page, it just uses this for extra values need in the OLD UI
      }
    };

    this.iFrameMessage = JSON.stringify(payload); //Here the iFrameMessage gets the JSON(ified) version of Payload, which the OLD UI will unpack to use the data
  }

//Eg. of Calling the sendMessage method
editMobileDeviceTemplateClicked(dataItem: IConfigurationGroupsMultiselectCarrier) {
	this.sendMessage(dataItem.mobileDeviceTemplateId, Actions.editMobileDeviceTemplate)
}
```


## Older reading - NA

[[Frangular Messaging OLD UI to FR-UI]]
