---
wiki_ingested: 2026-05-28
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-04T10:35
---

# OPEN-1186 Alert column should be a number

Date: 2025-11-28 Time: 10:55
Parent:: ==xxxx==
Friend:: [[2025-11-28]]
JIRA:OPEN-1186 Alert column should be number
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1186)


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

![[Pasted image 20251128112204.png|80]]

## Problem

Please look at the giraffe number mentioned above. Currently, below you can see the results I get from the two API calls. The one API call is a config group alert and the other one is an asset alert. Both of these get alerts which are then used to build up the number of alerts. Currently, that number of alerts is seen as a string in the drop-down list. I want it to be seen as a number so that when I click on it, the filter will work correctly. How will I be able to do this?

### CG Alerts Returned from API

[
  {
    "configurationGroupId": "1223784011986591945",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-7653538731568077332",
    "alert1": 1,
    "alert2": 1,
    "alert3": 2,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "2557659825063191210",
    "alert1": 1,
    "alert2": 1,
    "alert3": 0,
    "alert4": 0,
    "alert5": 3
  },
  {
    "configurationGroupId": "-1323496424401963304",
    "alert1": 2,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "4208572072426061348",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-7392764503748298046",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-6084966262084607888",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "3168786260864673578",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "8235264728202292851",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-7629839428314466340",
    "alert1": 0,
    "alert2": 0,
    "alert3": 2,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "2505696365882641504",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-5390337933230695538",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "6143152948325390557",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-8126655682067440340",
    "alert1": 2,
    "alert2": 0,
    "alert3": 10,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "4631052128945276764",
    "alert1": 0,
    "alert2": 1,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-2374899645906010889",
    "alert1": 2,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "1287625066743264402",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-2723417818245426945",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-4067179943998429825",
    "alert1": 4,
    "alert2": 7,
    "alert3": 0,
    "alert4": 0,
    "alert5": 3
  },
  {
    "configurationGroupId": "-3251388662902899727",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-3798194295803321659",
    "alert1": 0,
    "alert2": 3,
    "alert3": 3,
    "alert4": 0,
    "alert5": 2
  },
  {
    "configurationGroupId": "-8507561780508819492",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-2310911944299775966",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "1364631742777966163",
    "alert1": 2,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "2237002883694620525",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-1136609960426082090",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-2147059355369176559",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-6328313109361883502",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "7518319533563758380",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-5912082017677079777",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "1989001888637459309",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "3813205176926613669",
    "alert1": 0,
    "alert2": 1,
    "alert3": 3,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "8312559892687542597",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 2
  },
  {
    "configurationGroupId": "5916945531324722255",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "3739189965094689367",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "60036256406525452",
    "alert1": 0,
    "alert2": 1,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-5159253166163790691",
    "alert1": 0,
    "alert2": 1,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-8642220154752102213",
    "alert1": 1,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-5340634987676521615",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "5621177276048465690",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "7115023718153513169",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "767833652034630589",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-6366678994605550120",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "5918913735931167160",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-9078750292130215188",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "4505193432618700901",
    "alert1": 0,
    "alert2": 0,
    "alert3": 2,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-3366261590319731458",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "8724893352726780856",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-2803813420773469362",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "3189959622678903378",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-6039078778185809084",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "881148683257612107",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "1232298188016006398",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "8799631723342597089",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "3362884251134407151",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-2110415703208626075",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-3836116117686479120",
    "alert1": 2,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-7382401016514304197",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-5801394207784667707",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "4309917650092943416",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-3274353763833670263",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-7944209854350725335",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "3559248872843565414",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "1735562267874004226",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-6257508969252238550",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-1806774282659967806",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-1307004388228739243",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-1923500799342536831",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-2320806248371712183",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-383605210349505097",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-7668187040444806181",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-3893536691584770708",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "5009320484667002586",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "4263282101255212968",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "1240957115574012888",
    "alert1": 0,
    "alert2": 0,
    "alert3": 1,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "7187708927592996236",
    "alert1": 1,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  },
  {
    "configurationGroupId": "-8871627763454545305",
    "alert1": 0,
    "alert2": 0,
    "alert3": 0,
    "alert4": 0,
    "alert5": 0
  }
]

### Asset Alerts Returned from API
[
  {
    "alerts": "10000",
    "mobileUnitId": "-9103134062234322075",
    "serialnumber": null,
    "configurationGroupId": "1223784011986591945",
    "commsLog": "2018/06/15 11:12 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "11100",
    "mobileUnitId": "-8798513244981487643",
    "serialnumber": "0",
    "configurationGroupId": "-7653538731568077332",
    "commsLog": "2022/05/30 10:56 (CAT/SAST)",
    "fwVersion": "4.4.0",
    "preferredFWVersion": "1.10.10"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-8154404092019945206",
    "serialnumber": null,
    "configurationGroupId": "2557659825063191210",
    "commsLog": "2018/04/13 16:00 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "-7944612955031932038",
    "serialnumber": "0",
    "configurationGroupId": "-1323496424401963304",
    "commsLog": "2018/08/20 08:56 (CAT/SAST)",
    "fwVersion": "3.9.0",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-7898078755312382716",
    "serialnumber": null,
    "configurationGroupId": "4208572072426061348",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E15.09.02"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-7372220517297457835",
    "serialnumber": null,
    "configurationGroupId": "-7392764503748298046",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00001",
    "mobileUnitId": "-6093589015108786614",
    "serialnumber": "41001539",
    "configurationGroupId": "2557659825063191210",
    "commsLog": "2019/06/11 08:07 (UTC)",
    "fwVersion": "4.4.9",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-5571036686525372154",
    "serialnumber": null,
    "configurationGroupId": "-6084966262084607888",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E15.08.09"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-5398209883147130589",
    "serialnumber": null,
    "configurationGroupId": "3168786260864673578",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-5289234407494698690",
    "serialnumber": null,
    "configurationGroupId": "8235264728202292851",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.207_beta-lte-fallback-lockup-logging"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "-3568704900018955967",
    "serialnumber": "0",
    "configurationGroupId": "-7629839428314466340",
    "commsLog": "2019/04/01 13:26 (CAT/SAST)",
    "fwVersion": "4.4.9",
    "preferredFWVersion": "1.6.7"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-2566631210551839364",
    "serialnumber": null,
    "configurationGroupId": "2505696365882641504",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "10000",
    "mobileUnitId": "-2010430715896929118",
    "serialnumber": "359739071743991",
    "configurationGroupId": "-5390337933230695538",
    "commsLog": "2019/07/24 16:07 (CAT/SAST)",
    "fwVersion": "0.0.0",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-1629872805059908821",
    "serialnumber": null,
    "configurationGroupId": "6143152948325390557",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "10100",
    "mobileUnitId": "-1509415348226618365",
    "serialnumber": null,
    "configurationGroupId": "-8126655682067440340",
    "commsLog": "2017/08/17 11:30 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "01000",
    "mobileUnitId": "-1436518455494287400",
    "serialnumber": null,
    "configurationGroupId": "4631052128945276764",
    "commsLog": "2018/06/15 11:32 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "10000",
    "mobileUnitId": "-1420821188649460346",
    "serialnumber": "6917529027641081856",
    "configurationGroupId": "-2374899645906010889",
    "commsLog": "2019/06/19 10:08 (CAT/SAST)",
    "fwVersion": "0.0.260",
    "preferredFWVersion": ""
  },
  {
    "alerts": "10000",
    "mobileUnitId": "-1048316439302019403",
    "serialnumber": "0",
    "configurationGroupId": "-1323496424401963304",
    "commsLog": "2018/11/12 13:43 (CAT/SAST)",
    "fwVersion": "3.9.0",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "-487099210781207563",
    "serialnumber": null,
    "configurationGroupId": "1287625066743264402",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "-77084972695804791",
    "serialnumber": null,
    "configurationGroupId": "-2723417818245426945",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "1.5.9"
  },
  {
    "alerts": "11001",
    "mobileUnitId": "285627126655899114",
    "serialnumber": null,
    "configurationGroupId": "-4067179943998429825",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "4.0.2",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "10001",
    "mobileUnitId": "385546989186155125",
    "serialnumber": "41001244",
    "configurationGroupId": "2557659825063191210",
    "commsLog": "2019/06/11 08:08 (UTC)",
    "fwVersion": "4.4.9",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00001",
    "mobileUnitId": "428038740665402589",
    "serialnumber": "41001540",
    "configurationGroupId": "2557659825063191210",
    "commsLog": "2019/06/11 08:07 (UTC)",
    "fwVersion": "4.4.9",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "718292796933432336",
    "serialnumber": null,
    "configurationGroupId": "-3251388662902899727",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.07"
  },
  {
    "alerts": "01000",
    "mobileUnitId": "815570521779811467",
    "serialnumber": "0",
    "configurationGroupId": "-4067179943998429825",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "4.9.1000",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "01100",
    "mobileUnitId": "875152636819304448",
    "serialnumber": "61002101",
    "configurationGroupId": "-3798194295803321659",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "4.8.38",
    "preferredFWVersion": "4.8.36"
  },
  {
    "alerts": "01101",
    "mobileUnitId": "875153008833097728",
    "serialnumber": "0",
    "configurationGroupId": "-3798194295803321659",
    "commsLog": "2024/10/25 02:11 (CAT/SAST)",
    "fwVersion": "1.6.6",
    "preferredFWVersion": "4.8.36"
  },
  {
    "alerts": "01101",
    "mobileUnitId": "875153519347003392",
    "serialnumber": "0",
    "configurationGroupId": "-3798194295803321659",
    "commsLog": "2024/10/25 02:11 (CAT/SAST)",
    "fwVersion": "1.6.6",
    "preferredFWVersion": "4.8.36"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "877710264581238784",
    "serialnumber": "61001314",
    "configurationGroupId": "-8507561780508819492",
    "commsLog": "2023/02/17 15:50 (CAT/SAST)",
    "fwVersion": "4.8.66",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "897912059234684928",
    "serialnumber": null,
    "configurationGroupId": "-2310911944299775966",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "902610260701687808",
    "serialnumber": "61002252",
    "configurationGroupId": "-5390337933230695538",
    "commsLog": "2019/12/12 11:36 (CAT/SAST)",
    "fwVersion": "0.0.0",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "910581628547760128",
    "serialnumber": null,
    "configurationGroupId": "8235264728202292851",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.207_beta-lte-fallback-lockup-logging"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "918999411886190592",
    "serialnumber": "0",
    "configurationGroupId": "1364631742777966163",
    "commsLog": "2025/11/05 11:54 (CAT/SAST)",
    "fwVersion": "4.4.11",
    "preferredFWVersion": ""
  },
  {
    "alerts": "01000",
    "mobileUnitId": "921876619485716480",
    "serialnumber": "20252999",
    "configurationGroupId": "-4067179943998429825",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "929075052857430016",
    "serialnumber": "47001017",
    "configurationGroupId": "-7653538731568077332",
    "commsLog": "2019/11/07 10:50 (CAT/SAST)",
    "fwVersion": "4.6.3",
    "preferredFWVersion": "1.10.10"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "939666162685087744",
    "serialnumber": "0",
    "configurationGroupId": "1364631742777966163",
    "commsLog": "2025/11/05 09:14 (CAT/SAST)",
    "fwVersion": "4.9.50010",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "961771371649101824",
    "serialnumber": null,
    "configurationGroupId": "2237002883694620525",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "963923937065295872",
    "serialnumber": "48000052",
    "configurationGroupId": "-8126655682067440340",
    "commsLog": "2020/02/11 14:34 (CAT/SAST)",
    "fwVersion": "4.9.0",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "991822140767916032",
    "serialnumber": "359739075955369",
    "configurationGroupId": "-1136609960426082090",
    "commsLog": "2020/07/29 11:18 (CAT/SAST)",
    "fwVersion": "4.8.10",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "992584879909847040",
    "serialnumber": null,
    "configurationGroupId": "1364631742777966163",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "994671091961847808",
    "serialnumber": null,
    "configurationGroupId": "8235264728202292851",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.207_beta-lte-fallback-lockup-logging"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1001613961174667264",
    "serialnumber": "0",
    "configurationGroupId": "-8126655682067440340",
    "commsLog": "2021/07/09 21:38 (CAT/SAST)",
    "fwVersion": "4.8.62",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "11000",
    "mobileUnitId": "1012760267171442688",
    "serialnumber": "21000244",
    "configurationGroupId": "-4067179943998429825",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "4.9.9973",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1025877634710908928",
    "serialnumber": null,
    "configurationGroupId": "-2147059355369176559",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.07"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1032708589107937280",
    "serialnumber": "359739075958892",
    "configurationGroupId": "-6328313109361883502",
    "commsLog": "2022/03/11 14:07 (CAT/SAST)",
    "fwVersion": "4.8.55",
    "preferredFWVersion": "4.8.55"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1049836233367126016",
    "serialnumber": null,
    "configurationGroupId": "7518319533563758380",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.07"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1050512003934437376",
    "serialnumber": null,
    "configurationGroupId": "7518319533563758380",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.07"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1058508924801683456",
    "serialnumber": "0",
    "configurationGroupId": "-5912082017677079777",
    "commsLog": "2021/02/18 10:25 (CAT/SAST)",
    "fwVersion": "5.0.14",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1086004667345240064",
    "serialnumber": "40000808",
    "configurationGroupId": "1989001888637459309",
    "commsLog": "2025/11/26 15:55 (CAT/SAST)",
    "fwVersion": "5.18.0",
    "preferredFWVersion": "4.12.12"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1086005172591616000",
    "serialnumber": "40000690",
    "configurationGroupId": "3813205176926613669",
    "commsLog": "2025/10/31 16:36 (CAT/SAST)",
    "fwVersion": "5.10.6",
    "preferredFWVersion": "5.10.6"
  },
  {
    "alerts": "00001",
    "mobileUnitId": "1090810795210461184",
    "serialnumber": "41001399",
    "configurationGroupId": "8312559892687542597",
    "commsLog": "2021/04/06 14:12 (CAT/SAST)",
    "fwVersion": "4.8.37",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "01100",
    "mobileUnitId": "1103468413108256768",
    "serialnumber": null,
    "configurationGroupId": "3813205176926613669",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "5.10.26"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1126282101021749248",
    "serialnumber": "66000112",
    "configurationGroupId": "5916945531324722255",
    "commsLog": "2023/07/26 16:28 (CAT/SAST)",
    "fwVersion": "5.5.3",
    "preferredFWVersion": "5.0.17"
  },
  {
    "alerts": "10100",
    "mobileUnitId": "1129866710152437760",
    "serialnumber": "0",
    "configurationGroupId": "-8126655682067440340",
    "commsLog": "2025/06/26 14:56 (CAT/SAST)",
    "fwVersion": "5.17.0",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1165090258749702144",
    "serialnumber": "66000105",
    "configurationGroupId": "3739189965094689367",
    "commsLog": "2021/09/02 13:59 (CAT/SAST)",
    "fwVersion": "5.1.2",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1174121359466622976",
    "serialnumber": "57007878",
    "configurationGroupId": "-8126655682067440340",
    "commsLog": "2025/11/14 22:14 (CAT/SAST)",
    "fwVersion": "5.17.0",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "01000",
    "mobileUnitId": "1203125089031266304",
    "serialnumber": "22000213",
    "configurationGroupId": "60036256406525452",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "5.0.17",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "01000",
    "mobileUnitId": "1218337931713843200",
    "serialnumber": "20193661",
    "configurationGroupId": "-5159253166163790691",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "4.8.57",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "10100",
    "mobileUnitId": "1218663808783880192",
    "serialnumber": "0",
    "configurationGroupId": "-8642220154752102213",
    "commsLog": "2025/11/06 08:43 (CAT/SAST)",
    "fwVersion": "5.10.0",
    "preferredFWVersion": "4.8.62"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1260466398248566784",
    "serialnumber": "57000146",
    "configurationGroupId": "-5340634987676521615",
    "commsLog": "2022/05/10 09:03 (CAT/SAST)",
    "fwVersion": "5.1.2",
    "preferredFWVersion": "4.8.62"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1261022055236780032",
    "serialnumber": "40000418",
    "configurationGroupId": "5621177276048465690",
    "commsLog": "2023/12/19 14:58 (CAT/SAST)",
    "fwVersion": "4.14.10",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1268715391402156032",
    "serialnumber": "57000138",
    "configurationGroupId": "3813205176926613669",
    "commsLog": "2025/11/27 09:41 (CAT/SAST)",
    "fwVersion": "5.19.0",
    "preferredFWVersion": "5.10.26"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1271956122944516096",
    "serialnumber": "0",
    "configurationGroupId": "7115023718153513169",
    "commsLog": "2025/10/03 14:32 (CAT/SAST)",
    "fwVersion": "5.10.0",
    "preferredFWVersion": "4.8.62"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1281416329857847296",
    "serialnumber": "34000074",
    "configurationGroupId": "767833652034630589",
    "commsLog": "2023/12/20 15:36 (CAT/SAST)",
    "fwVersion": "5.6.2",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1286359368359346176",
    "serialnumber": "57002899",
    "configurationGroupId": "-6366678994605550120",
    "commsLog": "2025/08/29 11:52 (CAT/SAST)",
    "fwVersion": "5.8.2",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1300872402540445696",
    "serialnumber": null,
    "configurationGroupId": "-8126655682067440340",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1300900116186021888",
    "serialnumber": null,
    "configurationGroupId": "-8126655682067440340",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1304944792448704512",
    "serialnumber": null,
    "configurationGroupId": "5918913735931167160",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E15.09.02"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1312134441394237440",
    "serialnumber": "51001690",
    "configurationGroupId": "-9078750292130215188",
    "commsLog": "2025/08/11 16:07 (CAT/SAST)",
    "fwVersion": "4.12.17",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1328864713399943168",
    "serialnumber": "57000165",
    "configurationGroupId": "4505193432618700901",
    "commsLog": "2022/11/18 17:07 (CAT/SAST)",
    "fwVersion": "4.12.2",
    "preferredFWVersion": "4.8.44"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1330271646099005440",
    "serialnumber": "57000147",
    "configurationGroupId": "4505193432618700901",
    "commsLog": "2022/11/18 17:08 (CAT/SAST)",
    "fwVersion": "4.12.2",
    "preferredFWVersion": "4.8.44"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1352074163187445760",
    "serialnumber": null,
    "configurationGroupId": "-7629839428314466340",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "1.6.7"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1357761845640413184",
    "serialnumber": "57005077",
    "configurationGroupId": "-3366261590319731458",
    "commsLog": "2023/02/16 15:40 (CAT/SAST)",
    "fwVersion": "4.12.16",
    "preferredFWVersion": ""
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1367583529694339072",
    "serialnumber": "0",
    "configurationGroupId": "3739189965094689367",
    "commsLog": "2023/08/04 10:34 (CAT/SAST)",
    "fwVersion": "5.5.3",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1383257475299938304",
    "serialnumber": null,
    "configurationGroupId": "8724893352726780856",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1401709835162300416",
    "serialnumber": "31000129",
    "configurationGroupId": "767833652034630589",
    "commsLog": "2024/04/08 14:05 (CAT/SAST)",
    "fwVersion": "5.6.4",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1403102293298126848",
    "serialnumber": "31000165",
    "configurationGroupId": "-2803813420773469362",
    "commsLog": "2024/04/09 11:05 (CAT/SAST)",
    "fwVersion": "5.5.8",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1415760817642536960",
    "serialnumber": null,
    "configurationGroupId": "3189959622678903378",
    "commsLog": "2025/04/15 12:18 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1450923827225116672",
    "serialnumber": "68023440",
    "configurationGroupId": "-6039078778185809084",
    "commsLog": "2025/10/07 11:06 (CAT/SAST)",
    "fwVersion": "6.3.0",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1469076319857348608",
    "serialnumber": "57018960",
    "configurationGroupId": "881148683257612107",
    "commsLog": "2025/09/03 16:26 (CAT/SAST)",
    "fwVersion": "4.16.8",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1469096269519065088",
    "serialnumber": "57019521",
    "configurationGroupId": "1232298188016006398",
    "commsLog": "2025/11/26 11:32 (CAT/SAST)",
    "fwVersion": "5.10.14",
    "preferredFWVersion": "4.12.12"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1473200846719332352",
    "serialnumber": "57019544",
    "configurationGroupId": "8799631723342597089",
    "commsLog": "2025/07/14 10:38 (CAT/SAST)",
    "fwVersion": "4.12.17",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1487203582401446190",
    "serialnumber": null,
    "configurationGroupId": "3362884251134407151",
    "commsLog": "2018/06/04 14:41 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1488621931651624960",
    "serialnumber": null,
    "configurationGroupId": "-8126655682067440340",
    "commsLog": "2025/05/02 09:58 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1530033300976836608",
    "serialnumber": "0",
    "configurationGroupId": "8312559892687542597",
    "commsLog": "2024/05/24 11:48 (CAT/SAST)",
    "fwVersion": "6.0.0",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1535591859690287104",
    "serialnumber": null,
    "configurationGroupId": "-2110415703208626075",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1535592576039804928",
    "serialnumber": null,
    "configurationGroupId": "-2110415703208626075",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1544808996514410496",
    "serialnumber": null,
    "configurationGroupId": "60036256406525452",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "01000",
    "mobileUnitId": "1557797963201785856",
    "serialnumber": "67000101",
    "configurationGroupId": "2557659825063191210",
    "commsLog": "2024/09/18 08:30 (CAT/SAST)",
    "fwVersion": "6.0.0",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1567997168892022784",
    "serialnumber": null,
    "configurationGroupId": "-8126655682067440340",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1582451417241710592",
    "serialnumber": "0",
    "configurationGroupId": "8312559892687542597",
    "commsLog": null,
    "fwVersion": "6.0.0",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1586129270148222976",
    "serialnumber": null,
    "configurationGroupId": "2557659825063191210",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1598735770993434624",
    "serialnumber": "0",
    "configurationGroupId": "-3836116117686479120",
    "commsLog": "2025/02/04 14:23 (CAT/SAST)",
    "fwVersion": "5.14.0",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1600655192215437312",
    "serialnumber": null,
    "configurationGroupId": "-7382401016514304197",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1606741934927376384",
    "serialnumber": null,
    "configurationGroupId": "-5801394207784667707",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.107_beta-gnss-sbas-disable"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1606747458683396096",
    "serialnumber": null,
    "configurationGroupId": "4309917650092943416",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E19.03.107_beta-gnss-sbas-disable"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1641882519627407360",
    "serialnumber": null,
    "configurationGroupId": "-8126655682067440340",
    "commsLog": "2025/03/27 10:02 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "4.8.13"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1641988948138713088",
    "serialnumber": null,
    "configurationGroupId": "-3274353763833670263",
    "commsLog": "2025/06/25 10:51 (CAT/SAST)",
    "fwVersion": "5.14.3",
    "preferredFWVersion": ""
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1656098505605554176",
    "serialnumber": null,
    "configurationGroupId": "-7944209854350725335",
    "commsLog": "2025/09/22 09:10 (CAT/SAST)",
    "fwVersion": "5.14.3",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1656405429011656704",
    "serialnumber": "57019436",
    "configurationGroupId": "3559248872843565414",
    "commsLog": "2025/11/27 16:04 (CAT/SAST)",
    "fwVersion": "5.10.14",
    "preferredFWVersion": "4.12.12"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1664067769899745280",
    "serialnumber": "0",
    "configurationGroupId": "-3836116117686479120",
    "commsLog": "2025/07/29 12:27 (CAT/SAST)",
    "fwVersion": "5.17.0",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1679258452349202432",
    "serialnumber": null,
    "configurationGroupId": "-7382401016514304197",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1686533945327812608",
    "serialnumber": "0",
    "configurationGroupId": "1735562267874004226",
    "commsLog": "2025/09/10 10:41 (CAT/SAST)",
    "fwVersion": "6.3.0",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1691208498223011120",
    "serialnumber": null,
    "configurationGroupId": "2557659825063191210",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "1702485427164585984",
    "serialnumber": null,
    "configurationGroupId": "1735562267874004226",
    "commsLog": "2025/09/10 15:34 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1707887810328231936",
    "serialnumber": null,
    "configurationGroupId": "-6257508969252238550",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1712260484074815488",
    "serialnumber": null,
    "configurationGroupId": "-1806774282659967806",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1714371290488709120",
    "serialnumber": null,
    "configurationGroupId": "-1307004388228739243",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1714767569528655872",
    "serialnumber": "0",
    "configurationGroupId": "-1923500799342536831",
    "commsLog": "2025/10/14 14:45 (CAT/SAST)",
    "fwVersion": "5.19.0",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "1715336455762432000",
    "serialnumber": null,
    "configurationGroupId": "881148683257612107",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1716945467118514176",
    "serialnumber": "0",
    "configurationGroupId": "-2320806248371712183",
    "commsLog": "2025/11/07 11:12 (CAT/SAST)",
    "fwVersion": "5.19.0",
    "preferredFWVersion": "5.10.6"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "1960215487085322743",
    "serialnumber": null,
    "configurationGroupId": "-383605210349505097",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "1.2.6"
  },
  {
    "alerts": "01000",
    "mobileUnitId": "2470993014782142827",
    "serialnumber": null,
    "configurationGroupId": "-4067179943998429825",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "2605092282528473783",
    "serialnumber": null,
    "configurationGroupId": "-7668187040444806181",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "E15.08.09"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "3065190090238196290",
    "serialnumber": null,
    "configurationGroupId": "-2374899645906010889",
    "commsLog": "2019/06/18 15:48 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "3980370543921406804",
    "serialnumber": null,
    "configurationGroupId": "-3893536691584770708",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "4330632591323826186",
    "serialnumber": null,
    "configurationGroupId": "5009320484667002586",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "4652568470569725043",
    "serialnumber": "0",
    "configurationGroupId": "2557659825063191210",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00000",
    "mobileUnitId": "5471039436101346631",
    "serialnumber": null,
    "configurationGroupId": "2557659825063191210",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00001",
    "mobileUnitId": "6110269613484206734",
    "serialnumber": "41001234",
    "configurationGroupId": "8312559892687542597",
    "commsLog": "2019/06/11 08:08 (UTC)",
    "fwVersion": "4.4.9",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "6202634302154772208",
    "serialnumber": "40001491",
    "configurationGroupId": "4263282101255212968",
    "commsLog": "2019/11/14 16:18 (CAT/SAST)",
    "fwVersion": "4.2.18",
    "preferredFWVersion": "1.6.7"
  },
  {
    "alerts": "00100",
    "mobileUnitId": "6352868507267210399",
    "serialnumber": "41000789",
    "configurationGroupId": "1240957115574012888",
    "commsLog": "2022/02/14 10:07 (CAT/SAST)",
    "fwVersion": "4.8.65",
    "preferredFWVersion": "4.8.37"
  },
  {
    "alerts": "10000",
    "mobileUnitId": "6619140184874941023",
    "serialnumber": null,
    "configurationGroupId": "7187708927592996236",
    "commsLog": "2017/11/08 11:12 (CAT/SAST)",
    "fwVersion": "1.6.2",
    "preferredFWVersion": ""
  },
  {
    "alerts": "00000",
    "mobileUnitId": "6965744936508783037",
    "serialnumber": null,
    "configurationGroupId": "-8871627763454545305",
    "commsLog": null,
    "fwVersion": "",
    "preferredFWVersion": ""
  },
  {
    "alerts": "11001",
    "mobileUnitId": "8591433084324666187",
    "serialnumber": "0",
    "configurationGroupId": "-4067179943998429825",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "4.8.14",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "00001",
    "mobileUnitId": "9037182319420900846",
    "serialnumber": "41001230",
    "configurationGroupId": "-4067179943998429825",
    "commsLog": "2019/06/11 08:07 (UTC)",
    "fwVersion": "4.4.9",
    "preferredFWVersion": "4.8.57"
  },
  {
    "alerts": "11000",
    "mobileUnitId": "9041905456165491651",
    "serialnumber": null,
    "configurationGroupId": "-4067179943998429825",
    "commsLog": "2024/09/17 09:26 (CAT/SAST)",
    "fwVersion": "",
    "preferredFWVersion": "4.8.57"
  }
]


## Code

- SetCGAlertsRows
	- currentRow.alerts = alerts?.toString();
- SetAlertsRows

class ConfigGroupsGrid > alerts: string
class AssetsGrid > alerts: string

## FIX summary - thanks AI

  The goal was to enable correct numerical **sorting** on the "**Alerts**" column for both the **Configuration Groups** and **Assets grids**, as they were incorrectly sorting as strings. The final solution also fixed an issue where the sort direction did not toggle between ascending and descending.

  The following changes were made in src/app/configgroups/configgroups.component.ts:

  1. Added a Numeric **alertCount** Property for Sorting

  A new property, alertCount, was added to the ConfigGroupsGrid and AssetsGrid classes to hold the numeric value of the alert count, which is used for sorting.

    1 export class ConfigGroupsGrid implements IConfigurationGroupsMultiselectCarrier {
    2   alerts: string;
    3   alertCount: number;
    4   flagged: number | null;
    5   // ... rest of the properties
    6 }
    7 
    8 export class AssetsGrid implements IConfigurationGroupsMultiselectAssetsCarrier {
    9   alerts: string;
   10   alertCount: number;
   11   flagged: number;
   12   // ... rest of the properties
   13 }

  2. Created **countOnesAsNumber** Helper Function

  A new helper function was created to calculate the alert count for the Assets grid from its string representation (e.g., "11100") and return it as a number.

   1   countOnesAsNumber(value: string | null | undefined): number {
   2     if (!value) {
   3       return 0;
   4     }
   5     return [...value].filter(c => c === '1').length;
   6   }

  3. **Populated alertCount** in Data Handling Functions

  The new alertCount property was populated in the functions that process the data for each grid.

   * For Configuration Groups in SetCGAlertsRows():

   1           // ... existing summation of alerts
   2           alerts += row.alert5;
   3         }
   4         currentRow.alertCount = **alerts**; // The numeric sum is assigned
   5         if (alerts > 0 && !this.IsNullOrEmpty('alerts', alerts?.toString())) currentRow.alerts = alerts?.toString();
   6       });

   * For Assets in PopulateAssetsGrid():

   1           let gridItem: AssetsGrid = {
   2             alerts: item.alerts,
   3             alertCount: this.**countOnesAsNumber**(item.alerts), // alertCount is populated here
   4             flagged: item.flagged,
   5             // ... rest of the properties
   6           };
   * A similar change was made in PopulateConfigGroupGrid() to ensure alertCount was passed to the grid data:
   1           this.filteredConfigGroups.data.push({
   2             alerts: item.alerts,
   3             alertCount: item.**alertCount**,
   4             flagged: item.flagged,
   5             // ... rest of the properties
   6           });

  4. Implemented **Custom Sorting Logic**

  To fix the sort direction toggling, the logic was moved into the load...GridSortItems methods. These methods now check if the sort is on the alerts field and, if so, use a temporary sort descriptor with the alertCount field for the actual orderBy operation. This correctly sorts the data numerically while allowing the grid's UI to manage the  sort state (including direction) for the alerts column properly.

   * For Configuration Groups grid in **loadConfigGroupsGridSortItems**():

    1       loadConfigGroupsGridSortItems(): void {
    2         let sortDescriptor = this.sortConfigGroups;
    3         if (sortDescriptor.length > 0 && sortDescriptor[0].field === 'alerts') {
    4             const tempSort = JSON.parse(JSON.stringify(sortDescriptor));
    5             tempSort[0].field = 'alertCount';
    6             this.filteredConfigGroups.data = orderBy(this.filteredConfigGroups.data, tempSort);      
    7         } else {
    8             this.filteredConfigGroups.data = orderBy(this.filteredConfigGroups.data, sortDescriptor);
    9         }
   10       }

   * For Assets grid in **loadAssetsGridSortItems**():

    1       loadAssetsGridSortItems(): void {
    2         let sortDescriptor = this.sortAssets;
    3         if (sortDescriptor.length > 0 && sortDescriptor[0].field === 'alerts') {
    4           const tempSort = JSON.parse(JSON.stringify(sortDescriptor));
    5           tempSort[0].field = 'alertCount';
    6           this.filteredAssets.data = orderBy(this.filteredAssets.data, tempSort);
    7         } else {
    8           this.filteredAssets.data = orderBy(this.filteredAssets.data, sortDescriptor);
    9         }
   10       }

## Branch

> Config/MR/Bug/OPEN-1186_Alert_column_should_be_a_number.INT

- [x] [Alert Sort > DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135189) ✅ 2025-11-28
- [x] [Alert Sort > INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135593) ✅ 2025-12-04

