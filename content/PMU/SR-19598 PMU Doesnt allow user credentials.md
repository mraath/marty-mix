---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-11-06T16:55
---

# SR-19598 PMU Doesnt allow user credentials

Date: 2024-11-06 Time: 16:06
Parent:: [[PMU]]
Friend:: [[2024-11-06]]
JIRA:SR-19598 PMU Doesnt allow user credentials
[SR-19598 PMU: Application Does Not Allow User To Insert User Credentials - Jira](https://csojiramixtelematics.atlassian.net/browse/SR-19598)


## TODO
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

## Shorter Description

Reported Issue: ==SLB users== are unable to insert the target URL and User Credentials

Was on a call with these users and they all seem have the same issue.

The application tells them the ==requested URL could not be retrieved==, like they have **Proxy settings** configured.

You can select the Advanced Option, but all the proxy settings fields are cleared and once saved, it raises the same error and the rest remains greyed out as shown in the below screenshot.

For us, the application works fine.

I tested entering incorrect proxy settings and then got the same error, but once you clear and save it works, so this is not a widespread issue or we would've had multiple reports.

Suspect this is a local IT issue that they need to fix because its **only their machines** affected, but is causing some issues in their operations as they cannot create:
- driver plugs and 
- config plugs

Please advise if there is any suggested checks or solutions they can try to get this resolved in order for them use the application in their daily operations

![[SR-19598 PMU Doesnt allow user credentials Disabled fields.png|400]]

- Advanced, but all Proxy Settings fields

- Semi related other issue: [[The PMU keeps closing]]
- Check the log file?

## Proxy files

pdetails.mix 

## User file

details.mix

