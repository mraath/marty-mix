---
created: 2024-05-16T12:09
updated: 2024-07-26T16:09
---
## Background

In the OLD UI we make use of an iFrame to call the new Frangular UI.
The OLD UI for instance has the breadcrumb bar with the selected organisation.
The OLD UI needs to send this value to the Frangular UI (FR-UI).

You can look at the to see how this is done:
file://.../mix.config.frangular.ui/src/app/configgroups/configgroups.component
I will break it up below.

## OLD UI

^31a822

### HTML

The HTML contains the following element which connects this iFrame with the FR-UI.
The channelname attribute connects it specifically to the same channel name in the FR-UI.
In this case the channelname is set to configGroupsMultiselectChannel in the controller.

```html
<dmx-iframe-host-adapter iframename="$controller.iframeName" iframeurl="$controller.iframeUrl" channelname="$controller.channelName" width="100%" height="100%" fleet-loader scrolling="no"></dmx-iframe-host-adapter>
```

### TS Controller


```ts
//The channel name and other things are set to make the iFrame host adapter element unique.
static controllerName: string = 'configGroupsMultiselect';
iframeName: string = "iframeConfigGroupsMultiselectHost";
iframeUrl: string = angularNextConfigUrl + "/configuration-groups-multiselect";
channelName: string = "configGroupsMultiselectChannel";

private iframePayload: IPayload; //Used to send data to the FR-UI

//Sending values to the FR-UI
sendMessage(): void {
	this.scope.$broadcast("sendIframeMessage", [this.iframeName, this.channelName, this.iframePayload]); //Here you can see how it makes this unique with the use of the iFrameName and channelName
}

//Receiving a message from the FR-UI
receiveMessage(event: ng.Event, iframeName?: string, channelName?: string, payload?: any): void {
	if (iframeName !== this.iframeName || channelName !== this.channelName || !payload) //This ensures the correct iFrame is receiving the message
		return;

	const payloadData: IPayload = JSON.parse(payload.data); //Breaking up the payload

	//An example of how, based on the Action value from the FR-UI, the action in the OLD UI is performed
	//this.updateSelectedOrganisation(payloadData.organisationId, payloadData.organisationName);
	switch (payloadData.action) {
		case MiXFleet.ConfigAdmin.Controllers.ConfigGroupsMultiselect.Actions.EditMobileDeviceTemplate:
			return this.location.setPath("config-admin/templates/mobile-devices/edit", { id: payloadData.data.id });
		default:
			return;
	}
}

//Register the sending and receiving of messages
registerSendReceiveMessages(event: ng.Event, iframeName?: string, channelName?: string): void {
	if (iframeName !== this.iframeName || channelName !== this.channelName) //Ensure only this iFrame's messages are sent and received here
		return;

	//Breadcrumb bar / selection criteria
	//  I am still having an issue whereby it doesn't always set the orgId
	//  It seems like it sometimes times out and then the authToken is lost
	//  This then results in an authentication error in the FR-API
	var group: IGroup = this.globalSelectionCriteria.breadcrumbSelection.selectedItems[0]; //Getting the Breadcrumb org selected
	if (group.type === "asset" && this.globalSelectionCriteria.breadcrumbSelection.selectedTrail.length > 0) {
		group = this.globalSelectionCriteria.breadcrumbSelection.selectedTrail[this.globalSelectionCriteria.breadcrumbSelection.selectedTrail.length - 1];
	}

	//Setting default data to send FR-UI
	this.organisationId = group.id;
	var data = <IConfigData>{
		organisationId: this.organisationId
	}
	this.iframePayload = <IPayload>{
		data: data,
		action: Actions.Load,
		uid: new Date().valueOf().toString()
	};

	this.sendMessage(); //Forcing an initial send to FR-UI
	this.scope.$on("receiveIframeMessage", (ev, args) => this.receiveMessage(ev, ...args)); //Listening to the Receiving of FR-UI messages
}

//Initialising to load the registerSendReceiveMessages
initialize(): ng.Promise<any> {
	return super.initialize().then(() => {
		this.scope.$emit('cancelCloseButtonText', 'Close');
		this.scope.$on('iframeReady', (ev, args) => this.registerSendReceiveMessages(ev, ...args)); //Registering the send and receive of messages
	});
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
onMessageReceived(msg: Message) { //As you can see the $event is read as the msg object
    //This is how the org Id is set from the OLD UI
    this.organisationId = msg.data.message.data.organisationId; //Here is an example of how the msg ($event) is unpacked to get the data needed

	//More values could be received here from the OLD UI
    
    //This is where the authToken gets set from the OLD UI
    this.sessionService.setAuthToken(msg.data.xAuth).pipe(takeWhile(() => this.alive))
      .subscribe((data) => {
        if (!data)
          return;

		//All of these are used in other sections of logic to determine workflow
        this.authTokenSet = true;
        this.fetchSelectionCriteriaGrid(); //This will call the method on the hypermedia to call the data
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

//Writing the sendMessage method
private sendMessage(id: string, action: Actions, lineId: string = "") { //Please note that you can add more values here which you might want to send
	const payload: IPayload = { //This will be made into a JSON object
	  action: action,
	  uid: new Date().valueOf().toString(),
	  data: {
		id: id.trim(),          //This sends through an Id, needed to open the template
		lineId: lineId.trim()   //This example sends in the line Id, for which the template info needs to load data
	  }
	};
	
	this.iFrameMessage = JSON.stringify(payload); //Here the iFrameMessage gets the JSON(ified) version of Payload, which the OLD UI will unpack to use the data
}

//Eg. of Calling the sendMessage method
editMobileDeviceTemplateClicked(dataItem: IConfigurationGroupsMultiselectCarrier) {
	this.sendMessage(dataItem.mobileDeviceTemplateId, Actions.editMobileDeviceTemplate)
}
```




