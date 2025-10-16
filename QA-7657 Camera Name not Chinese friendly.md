---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-16T10:23
---

# QA-7657 Camera Name not Chinese friendly

Date: 2025-10-16 Time: 09:49
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-10-16]]
JIRA:QA-7657 Camera Name not Chinese friendly
[JIRA](https://powerfleet.atlassian.net/browse/QA-7657)


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


While performing some additional text support testing for Special characters, Case, Numbers, Special letters etc I discovered that Arabic and Mandarin are not supported.

The following ORG and inputs were used to test:

orgId=-7845718844570610389
/peripherals/edit?id=-565349616809011552

Inputs:

预告片 垃圾车

على الطريق

Result:

![[QA-7657 Camera Name not Chinese friendly.png|500]]

## Investigation

```sql
USE DeviceConfiguration;

SELECT TOP 10 * FROM [library].[CameraNames]
Order by DateUpdated DESC
```

:red cr The above returns ???, this points to the characters being displaced somewhere - I will work it back.... API.... etc...


## BE

✅ Inspecting the payload, it is there. I will now check the Client and API 

## API





