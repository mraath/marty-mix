---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2023-11-29T07:13
---

# SR-16877 Airtime management Module - Contract column not displaying any data

Date: 2023-11-20 Time: 06:39
Parent:: [[Iridium]]
Friend:: [[2023-11-20]]
JIRA:SR-16877 Airtime management Module - Contract column not displaying any data
[SR-16877 Airtime management Module - "Contract" column not displaying any data - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-16877)

Strong link to: [SR-14237 Mobile Device Admin: Airtime Package Name Has Changed - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14237)

## Above important info

- Airtime Contract: form.iridiumContract
- Plan name: form.iridiumPlanName
- Issue was: space in front of the plan name caused it not to match the name in the cache

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

## Investigating

![[SR-16877 Airtime management Module - Contract column not displaying any data Null Contract name.png]]

- On INT it seems to still display what it should, although the contract name in the two screens seem a bit different
![[SR-16877 Airtime management Module - Contract column not displaying any data Mobile Device Settings OK.png]]
![[SR-16877 Airtime management Module - Contract column not displaying any data Airtime Management OK.png]]


Iridium > Airtime Contract > SPNET portal > Plan Name, Contract Name > Iridium Billing service, Status Update service (NOT on OMAN) > no billing Service on OMAN > iridium billing files (CDR files) > asset iridium history table >  Iridium Billing Report
## Image learned from this issue

ADD IMAGE

## Move what you learned into the bigger picture

ADD IMAGE

## Shorter Summary



## Description


## Ideas

- [ ] Duplicate in Prod
- [ ] Duplicate on INT
- [ ] Check DB, Logs

## SR Meeting Notes


## Useful Comments from Jira


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing



## Follow the code path

### Log


### Data


### Code


## Final Findings for Jira

- 
