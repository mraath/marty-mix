---
created: 2024-07-24T12:30
updated: 2024-07-25T17:02
---
The **layout.service.ts** was changed quite a bit.
But this is only a once off thing


## app.component.html

```html
<dmx-notification-popup></dmx-notification-popup>
```

## app.component.ts

### Imports

```c#
import { LayoutService } from "./shared/layout.service";
import { NotificationItemModel } from "./shared/components/notification-popup/notification-item.model";
```

### Class

```c#
export class AppComponent implements OnInit, OnDestroy {
	userNotification: NotificationItemModel;
```
### Constructor

```c#
constructor(
	private layoutService: LayoutService,
```

### ngOnInit

```c#
ngOnInit() {
		this.layoutService.notifyUser$
			.pipe(takeWhile(() => this.alive))
			.subscribe((notification: NotificationItemModel) => {
				this.userNotification = notification;
			});
```


## app.module.ts

### Import

```c#
import { NotificationPopupComponent } from "./shared/components/notification-popup/notification-popup.component";
```

### NgModule

```c#
@NgModule({
	declarations: [
		NotificationPopupComponent
```



## Component
### Import

```c#
import { LayoutService } from "../shared/layout.service";
```
### Constructor

```c#
constructor(
		private layoutService: LayoutService,
```
### Call the notification

```c#
this.layoutService.showUserNotification({ showModal: true, messageText: this.languageService.translate("Label already in use"), success: false });
return;
```

