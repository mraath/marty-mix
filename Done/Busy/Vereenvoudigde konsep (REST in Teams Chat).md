# Vereenvoudigde konsep

**end result**: _Notify_ die user daar was n trip met n false (of potential fake) borderline crossing


So.... ons **speel n trip** deur (waas ons weet daar was n fake borderline crossing)

Aan die einde v.d. trip.... 

1) **check** ons was daar n borderline crossing... if ja 
2) **Waar** was die borderline crossing... 
3) **plot** daai **deeltjie** van die trip uit 
4) vat selfde begin punt en eindpunt van daai deeltjie en plot dit op **google maps** uit 
5) **vergelyk**... as die een radikaal anders lyk (machine learning) dan goed moontlik was daar n fake bordeline crossing - 
6) so **flag**

## William notes

- obviously gaan sy vraag wees "wat is die voordeel vir die kliënt en wat gaan hy daarmee maak?"
- ook, hoe sien jy die konsep verder ontwikkel binne die groter stelsel
- Wibci.CountryReverseGeocode
- ![[MicrosoftTeams-image (7).png]]
- sorry, hierdie is net my akademiese brein wat operate, so ignoreer as dit irrelevant is
- hier is paar vrae om dit te pitch
	- wat is die probleem wat wil oplos? 
	- hoekom is dit 'n probleem?
	- is daar al iewers in ons stelsel wat iets van die probleem uitwys?
	- wat is die doel van die SLC's en watter voordele hou dit in vir die users?
	- wat is die nadeel as daar verkeerde SLC's gebeur?
	- wat is die oplossing(s) wat jy wil bied vir die probleem? 
	- (komponente, visuals, reports, kommunikasies, ens.)
	- hoe sal die oplossing(s) die voordele en nadele aanspreek?
	- is daar iewers in die huidige stelsel iets wat probeer om soortgelyke oplossing te bied?
	- hoe kan die oplossing vorentoe in die monster wat ons het geïntegreer word?

- hierdie is hoe jy daai api gebruik:
- GeoLocation location = new GeoLocation { Longitude = positions[index].Longitude, Latitude = positions[index].Latitude };
	- info = _service.FindUsaState(location);
	- country = _service.FindCountry(location);


_service verteenwoordig daai nuget package

ek moes dit gebruik om SLC events te fix toe daar 'n groot boggerop was

Shashi moes weer iets skryf om die jumps reguit te maak, m.a.w. waar daar jumps heen en weer was op 'n "reguit lyn" na aan die border, moes hy die verkeerde posisies wipe

so hy moes die 1ste entrance en laaste exit gebruik om te weet watter kant van die border moet hy wees

en of dit werklik SLC moes wees

gou met Edwin gechat

![[MicrosoftTeams-image (11).png]]


![[MicrosoftTeams-image (12).png]]

![[MicrosoftTeams-image (13).png]]

so daar is dit, jy wil 'n routing engine bou ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v1/assets/emoticons/smile/default/20_f.png "Smile") 

as jy vir Mike aan jou kant kry op hierdie, het jy 'n toetser wat weet waarna om te kyk

hy ken hierdie goed en weet waarvoor om te kyk uit verbruikersoogpunt

ek het mos vantevore tool geskryf wat die trips gaan haal vir replay en dit op 'n map display. Dit generate ook 'n file wat die toetsers gebruik om oor en oor te replay

Moes kort terug vir Mike fixes maak daar



