---
created: 2024-05-16T12:09
updated: 2024-07-30T17:50
---
## Background

In the OLD UI we make use of an iFrame to call the new Frangular UI.
The OLD UI for instance has the breadcrumb bar with the selected organisation.
The OLD UI needs to send this value to the Frangular UI (FR-UI).

You can look at this in this component:
file://.../mix.config.frangular.ui/src/app/configgroups/configgroups.component
I will break it up below.

## OLD UI

### HTML

The HTML contains the following element which connects this iFrame with the FR-UI.
The channelname attribute connects it specifically to the same channel name in the FR-UI.
In this case the channelname is set to configGroupsMultiselectChannel in the controller.

```html
<dmx-iframe-host-adapter iframename="$controller.iframeName" iframeurl="$controller.iframeUrl" channelname="$controller.channelName" width="100%" height="100%" fleet-loader scrolling="no"></dmx-iframe-host-adapter>
```

### TS Controller

A big problem for me was the timing of when to send the initial values.
Also to ensure eg. the old UI already has the correct data, before I trigger to send it through to the FR UI.
I used to have it in the initializer, however, the timing was often off.
After inspecting the Fleet team's operations UI, I tried the below and it seems to be working fine.
If anything changes I will change it here.

> We still need to pass in the xAuth in the example from the OLD UI, it is already consumed in FR UI

```ts
//THIS Data structure, just for explanation benefit
export interface IConfigData {
	id: string;
	organisationId: string;
	extra: string; //Used eg. lineId, mobileDevice
}

export interface IPayload {
	data: IConfigData
	action: Actions,
	uid: string
}

//The channel name and other things are set to make the iFrame host adapter element unique.
static controllerName: string = 'configGroupsMultiselect';
iframeName: string = "iframeConfigGroupsMultiselectHost";
iframeUrl: string = angularNextConfigUrl + "/configuration-groups-multiselect";
channelName: string = "configGroupsMultiselectChannel";


//Used to send data to the FR-UI
private iframePayload: IPayload; 

//Storing the currently selected org id
organisationId: string;


//Registering both the send and receive of messages now happens in the constructor
constructor(...) {
	super(...);
	this.registerSendReceiveMessages(); //This is where the registering happens!
}

//The above method looks like this
registerSendReceiveMessages(): void {
	this.scope.$on("iframeReady", (ev, args) => { //This ensures the iFrame is ready and has all the correct values, eg. Channel name...
		if (args && args.length === 2 && args[0] === this.iframeName && args[1] === this.channelName) {
			
			//This just initialises some data to be sent
			//For now I just want the org Id
			
			//The iframePayload moves data between the OLD UI and FR UI
			//I have included THIS data structure, but this could be different for your page
			//THIS data structure is seen above
			
			var data = <IConfigData>{ 
				organisationId: this.organisationId
			}

			this.iframePayload = <IPayload>{
				data: data,
				action: Actions.Load,
				uid: new Date().valueOf().toString()
			};

			this.sendMessage(); //Triggers an initial send
			this.receiveMessage(); //Triggers an initial receive
		}
	});
}

//Each time the user selects a different org in the OLD UI, this also needs to be sent to the FR UI
//This happens on selection criteria changed
public onSelectionCriteriaChanged(eventArgs: DynaMiX.Services.SelectionCriteria.SelectionCriteriaChangedEventArgs): void {
	if (!eventArgs.changedProperties.contains("breadcrumbSelection"))
		return;

	var group: IGroup = this.globalSelectionCriteria.breadcrumbSelection.selectedItems[0];
	if (group.type === "asset" && this.globalSelectionCriteria.breadcrumbSelection.selectedTrail.length > 0) {
		group = this.globalSelectionCriteria.breadcrumbSelection.selectedTrail[this.globalSelectionCriteria.breadcrumbSelection.selectedTrail.length - 1];
	}

	//Setting the currently selected org id, which will then be sent to the FR UI
	//Sending this to FR UI happens by populating the iframePayload
	this.organisationId = group.id; //Updating locally
	var data = <IConfigData>{
		organisationId: this.organisationId
	}

	this.iframePayload = <IPayload>{
		data: data,
		action: Actions.Load,
		uid: new Date().valueOf().toString()
	};

	this.sendMessage(); //Sending the info to the FR UI
}

//Sending values to the FR-UI
sendMessage(): void {
	//Ensure there is an org id, before notifying the FR UI (this was crucial for this page, otherwise the FR UI receive blank info and had many issues)
	if (this.organisationId && this.organisationId !== undefined) {
		console.log("ORG sendMessage: " + this.organisationId);
		this.scope.$broadcast("sendIframeMessage", [this.iframeName, this.channelName, this.iframePayload]);
	}
}

//Receiving a message from the FR-UI
receiveMessage(): void {
	this.scope.$on("receiveIframeMessage", (ev, args) => {
		if (args && args.length >= 2 && args[0] === this.iframeName && args[1] === this.channelName && args[2].data) { //This ensures the correct iFrame is receiving the message
			
			var payloadData = JSON.parse(args[2].data); //Strip out the iframPayload for easy use

			//In this example we look at the action type, based on that we change the OLD UI to a different page
			switch (payloadData.action) {
				case MiXFleet.ConfigAdmin.Controllers.ConfigGroupsMultiselect.Actions.EditMobileDeviceTemplate:
					return this.location.setPath("config-admin/templates/mobile-devices/edit", { id: payloadData.data.id });
				...
				default:
					return;
			}
		}
	})
}
```


## Frangular UI

### HTML

At the top of the HTML the following iFrame Adapter is used to connect the HTML with the ts.
This will in turn connect the FR-UI with the OLD UI

```html
<dmx-iframe-adapter *ngIf="enableIFrame" (messageReceived)="onMessageReceived($event)"
	[channelName]="'configGroupsMultiselectChannel'" [newMessage]="iFrameMessage">
</dmx-iframe-adapter>
```

Notice all mentions of **message**.
- The newMessage attribute is used to send the message (iFrameMessage) to the OLD UI
- The messageReceived attribute specifies which method in the ts file should be called when a new message is received from the OLD UI ($event)
- The channelName attribute makes it unique between the FR-UI component and the this OLD UI iFrame

### TS Controller

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




