## Intro

Ford OEM mobile device, but will later be needed for other OEMs, MiX OBCs and CalAmp device once we start processing the DTC messages.
LibraryDevices level

API: Pass in GroupId and DeviceId
Receive True if OK

CLIENT: Only send in GroupId

Code overview:
- Client: IsDeviceAvailableForLibraryForFordOEM
- API: IsDeviceAvailableForLibrary(authToken, groupId, MobileDevices.FORD_OEM
	- FORD_OEM = -3492265442579611717

## Tests to be done
- [x] Swagger test
	- [[DeviceConfig API Swagger Pages]]
- [x] Client test werk

## Test Results

### Swagger Tests

- Case 1: **AVAILABLE**
	- Org: Mr Org 
	- orgId: -5785682803802374635
	- It has been made **available**
	- ![[OEM-489 TEST FordOEM Swagger Available.png]]

- Case 2: **NOT AVAILABLE**
	- Org: MR Org Empty 2
	- OrgId: 8226497664686357989
	- It has **not been made available**
	- ![[OEM-489 TEST FordOEM Swagger Unavailable Success.png]]

### Client Tests

- Case 1: **AVAILABLE**
	- Org: Mr Org 
	- orgId: -5785682803802374635
	- It has been made **available**
	- ![[OEM-489 TEST FordOEM client Available.png]]

- Case 2: **NOT AVAILABLE**
	- Org: MR Org Empty 2
	- OrgId: 8226497664686357989
	- It has **not been made available**
	- ![[OEM-489 TEST FordOEM Swagger and client.png]]


