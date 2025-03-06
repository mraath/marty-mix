---
created: 2023-12-04T08:03
updated: 2023-12-04T08:13
---
You can always do something like this:

```html
<div class="aClassThatHasAnOverflowIfTheListGetsTooLong">
	<ul class="someClass">
		<li ng-repeat="item in items"> {{item}} </li>
	</ul>
</div>
```

Wait - here is a better eg. from code
file:///C:/Projects/MiX.Fleet.UI/UI/Js/ConfigAdmin/Templates/ConfigGroupsLandingTemplate.html
Search for: fleet-modal name="mobileDeviceIncompatibleVinModal"

```c#
<fleet-modal name="xxxx" buttons="xxxxButtons" header-title="xxxx" css-class="alert alert-info">
	<ul>
		<li ng-repeat="item in items">
			{{ item }}
		</li>
	</ul>
</fleet-modal>
```
