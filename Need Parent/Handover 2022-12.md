## Zonika

Handover (aangesien vandag my laaste dag is voor vakansie - yeah!)

- **QA-5318**: moes ek die XML terug rol. Paul het so 3 maande terug n format type 13 gebruik vir driver ID, maar dit gee (na my UI validation mooi werk) issues verder down the line. So vir nou is dit weer soos dit was (net possible as mens eers die getal tik en DAN die -) .... so 2 opsies waaraan ek dink. 
	1) Die mense wat daai control gemaak het moet dit dalk fix vir minus (dalk is dit nog ons, maar ek dink nie so nie 
	2) ons moet n nuwe format type add vir daai driver range text boxes, anders breek dit goed verder down the line.... ek dink nommer 1 is die skoner opsie....
- **SR-13967**: Stored proc taking too long. Dis daai ongoing een wat ons met Hedayat toets. Persoonlik dink ek dis OK vir nou.
- **MiX3K-9**: Gaan n handover doc vir Justus en Zeshan stuur.
- **QA-5075**: Detailed trip, specific scenario. Op INT vir dev test al vanaf 2 Nov. So ek dink dis nou al op prod :-)
- **SR-13904**: GSM Modem settings hidden. Pending release to Prod.
- Die res is almal in waiting response of parked of testing, maar nie nodig vir die handover nie.

BAIE DANKIE vir n lekker jaar se werk saam met jou. Jy is regtig n goeie en gracious manager en dis maklik om in jou span te werk. Mag jy n BAIE lekker res van die jaar he en mag Christmas en nuwe jaar n lekker tyd wees om te ontspan en uitrus. Lekker een verder!!

## Justus and Zeshan

Seeing today is my last day before my leave, herewith my handover:

- **MiX3K-9**: I finally got to test some code yesterday without it bombing out. I do think we have a great starting point just adding the new Model3000. We will just need to change it. Some issues I ran into (please note, I was pulled into many other things, so I couldn't focus just on this).
	- UpdateMobileDeviceTemplate. This broke because the 6 logical devices we sent into that function couldn't be found on the mobileDevice.AlllogicalDevices (something like that). So we just need to redefine this to make it work. I know Justus knows a lot about this :-) I then just bypassed this.
	- UpdateLines: This then went through successfully, however, I then has MSSQL issues in the next section. I then commented out the next session and then the issue moved to this section.... So personally I think this part will be in order, but at the time of writing this I haven't been able to test this successfully.
	- UpdateEvents: It would pass the update lines, but then get an issue with opening MSSQL. Justus, this feels like something we had in the past.
	- **BRANCH**: Config/MR/Bug/MIX3K-9MiX3000DefaultConfigGroup.23.01.ORI
	- You will see there is also a DEV one which I would use to merge this code into dev before merging to dev. For some reason it was needed. It might no longer be needed.
	- I also have comments here and there which can be taken out, but you will see them when merging to DEV. I usually comment as "TODO: MR: "
	- I will write more here if I can think of more :-)
	- Oh, testing takes forever :-P
	- I merged INT back into my branch - only locally, but didn't push it, as I had many BE issues this morning, so wasn't sure it is all OK. So you will just need to merge INT back in.

