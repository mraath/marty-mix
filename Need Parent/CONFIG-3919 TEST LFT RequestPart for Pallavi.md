---
created: 2024-02-28T17:19
updated: 2024-03-05T14:01
---

```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Memory Pointer

- [x] **NOT SURE** (Should this return memory pointers as per the old code?) ✅ 2024-03-04

## Pallavi Jadhav  26 Feb 2024 Edited

- Free memory where this function is called from. (Comms team)
- Here byte* is used as referred with backend code but using managed types like arrays, streams, or IntPtr is preferred.
- Await is forbidden in unsafe sections.
- unsafe code was not compiling. I have made following changes to project properties.  
    Solution: To use unsafe code blocks, the project has to be compiled with the /unsafe switch on. Open the properties for the project, go to the `Build` tab and check the `Allow unsafe code` checkbox.

## Pallavi DEV Notes

- Connected to INT DB
![[CONFIG-3919 TEST LFT RequestPart for Pallavi Dev Test Notes.png|300]]
- Part of this PR? [Pull request 98753: Config-3508: Large file transfer RequestPart modified as per Backend code - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/98753?_a=files)
- Swagger Test:
	- RequestStatus
		- /large-file-transfer/transfer-ids/{fileTransferId}/request-status
	- Old Client: GetFileTransferStatus
		- x
	- New Client: RequestStatus
		- x
- RequestPart
	- large-file-transfer/transfer-ids/{fileTransferId}/offset/{offset}/block-size/{blockSize}/pad-byte/{padByte}/request-part
	- Old Client: RequestPart
		- Findings: The byte value is the same, but the old client uses a memory pointer.
	- New Client: RequestPart
		- Findings: The byte value is the same. Doesn't use a memory pointer.
- 20240305 (Was on INT branch - just moved to DEV) with INT data
	- Swagger
		- ![[CONFIG-3919 TEST LFT RequestPart for Pallavi Swagger 1.png|500]]
	- Old Client
		- ![[CONFIG-3919 TEST LFT RequestPart for Pallavi Old Client 1.png]]
	- New Client
		- ![[CONFIG-3919 TEST LFT RequestPart for Pallavi New Client 1-1.png]]
- 20240305 Against DEV data
	- Old Client
		- ![[CONFIG-3919 TEST LFT RequestPart for Pallavi DEV data Old Client.png]]
	- New Client
		- ![[CONFIG-3919 TEST LFT RequestPart for Pallavi DEV Data New Client.png]]
