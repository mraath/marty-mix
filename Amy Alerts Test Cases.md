---
wiki_ingested: 2026-05-28
created: 2025-04-09T07:49
updated: 2025-04-09T07:58
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


Hey Marthinus!
 
Sooooo, regarding the alerts... I don't know that I have the best data for you as it stands BUT...

## Alert 1: Config Upload

I have just done a config compile and upload on my bench MiX3000 (Amy Bench Units | 004 Rodger MiX3000)
Before I did the compile, the config upload expired alert was displayed
![[Amy Alerts Test Cases 3k before.png]]
 
After the compile, the alert was gone (which is good!)
![[Amy Alerts Test Cases 3K after.png]]
 
I did the same thing with my MiX6000LTE 
![[Amy Alerts Test Cases 6KLTE before.png]]
![[Amy Alerts Test Cases 6KLTE After.png]]
 
- [ ] So, now you should be able to check both those assets in ==5 days== and the **config upload expired** alerts should be present... (13 Apr)

## ALERT 2: FW Upload

Then, re firmware upload expired alerts, my bench MiX6000LTE has a preferred fw version that differs from the current fw version on the unit so I did a firmware upload there now as well, 
- [ ] so in ==3 days== the **fw upload expired** alert should appear for that asset. (11 Apr)

![[Amy Alerts Test Cases FW Before.png]]

![[Amy Alerts Test Cases FW Comms.png]]



## ALERT 3: FW Version OLD

In terms of the Preferred FW version not supported alert... I am still not sure what parameters dictate which versions will be considered supported and which won't so I am not sure how one would go about testing that reliably..

- [ ] Get the rules for Amy

## ALERT 4: Event not monitored

As for the Event not monitored - missing parameters alert:
I am going to leave the offending events on the MiX6000LTE event template so that you can test whether the alert works as expected.
remove the offending events from the event list and make sure the alert is gone
then add the events back and the alert should reappear
- [ ] Can test this one now
![[Amy Alerts Test Cases Missing Param.png]]

 