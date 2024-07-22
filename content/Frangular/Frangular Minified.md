---
created: 2024-05-21T15:26
updated: 2024-05-22T11:26
---

## Video Available

[video](https://mixtelematics-my.sharepoint.com/personal/zonika_smit_mixtelematics_com/_layouts/15/stream.aspx?id=%2Fpersonal%2Fzonika%5Fsmit%5Fmixtelematics%5Fcom%2FDocuments%2FRecordings%2FFrangularisation%20UI%20using%20S3%20and%20Lambdas%2D20240514%5F163201%2DMeeting%20Recording%2Emp4&referrer=Teams%2ETEAMS%2DELECTRON&referrerScenario=RecapOpenInStreamButton%2Eview%2Eview&ga=1)
## Source code of Dashboard eg.

[GHOS.Dashboard - Repos (azure.com)](https://dev.azure.com/MiXTelematics/GHOS/_git/GHOS.Dashboard)

## My notes

![[Frangular Minified Video Notes]]

Van die video op Minified Frangular het ek die volgende gesien.
(Jammer vir die boek)

Ons kode:
- Ons kode behoort **fine** te wees soos dit is
- Ons kan dit wel net **verbeter** indien benodig

Goed om te consider om ons kode te verbeter:
- Op die oomblik is ons kode in twee **repos**: UI & API
- Ons kan die kode **merge** (dit kan ook vorentoe gebeur)
- Ons het null unit **tests**, ons kan dalk in GHOS Dashboard idees kry van toetse: beide UI & API
- Add ons **CDK** in kode

Goed om te consider op deployments:
- Ek het daai basiese **pipeline** sonder deployment
- Aangesien ons nog nerens heen **deploy** nie kan ons dalk als probeer op **Lambda**?
- Ons kan net seker maak die data wat inkom is nie groter as **1MB** nie (soos ek dit verstaan) (Ons kan n groot prod org vat en die stored proc teen dit run, selfs al is dit te groot klink dit my van Stephan, dan page ons dit net en load net x aantal elke keer?)
- Die ander constraint was die tech wat ons nie moet gebruik op dit nie, maar ek kan nie lekker onthou nie... Cashka? **Kafka**? Maar ek dink nie ons maak gebruik van dit nie.
- Indien ons OK is met dit kan ons iemand klaar sit op die... maak n **storie** om die CDK (in kode), Pipeline (upadate) en deploy (na lambda?) te doen
- Dan hou die devs wat op die oomblik Frangular code nie die dev terug wat die CDK, pipeline en deploy lambda toe moet uitfigure nie (**parallel** frangular coding)
- Die deploy kan ook eers gebeur na ons "**subdomains**" opgestel is, wat jy reeds begin uitfigure het

OK - ek dink dis ALS waaraan ek gedink het.
Se asb indien jy verder wil chat.
Dalk kan Zeshan n goeie cdk, pipeline, lambda ou wees.
Ek sal ook graag wil leer maar neem aan ons moet nou parallel code om dinge klaar te kry
Hy kan altyd dit mooi documenteer en n code review met ons doen
Ekt ook die Frangular goed tot op hede gedocumenteer met updated goed wat Pallavi gevra het.
Ek kan dit alles finaliseer in pdfs, etc en dan net die overview (hoe om die pdfs te benader) code review gee
Hopelik kan almal binnekort op die Frangular goed spring, maar ons moet def. eers die deployment uitfigure.
Rede vir dit is beide ek en Pallavi het baie overhead om alles elke keer locally te run en toets en te veel kan verkeerd gaan.
So as mens eg n Frangular UI change maak, moet jy al die repos locally call, waar indien ons dit op DEV kon call behoort dit meer stable te wees vir toets,

OK - sorry vir die boek :-)