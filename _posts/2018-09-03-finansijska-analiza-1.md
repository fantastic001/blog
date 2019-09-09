---
layout: post
title:  "Uvod u finansijsku analizu - 1. deo"
date:   2018-09-03 18:15:00 +0100
categories: finance
---
Finansijska analiza je oblast koja spaja finansije, matematiku a od skoro i računarske nauke. 
Ona ne samo da nam može značiti kada je reč o novcu nego i bilo čemu što iziskuje procenjivanje vrednosti nečega 
u nekoj jedinici za koju smo se dogovorili da je jedinica vrednovanja. U praksi je najčešće to novac jer njime možemo 
kupiti proizvode i usluge i ceo svet se njime koristi ali se neka grupa ljudi interno može dogovoriti o svoj internoj jedinici
vrednosti ali je važno da se ona može prikazati brojem. 

U ovom članku i u nastavcima će se za jedinicu uzimati novac.


Osnovni zadaci finansijske analize
------------------------------------

Koliko god oblast bila kompleksna, ona ima samo dva zadatka a to su: procena vrednosti i donošenje odluka. Zadatak se svodi 
na procenu vrednosti svih mogućih opcija i uzimanje one najvrednije. Dakle, suština je procena vrednosti. U ovom članku ću prikazati 
kako izgleda procena vrednosti za neka jednostavna finansijska instrumenta koj ne uključuju rizik u svoju kalkulaciju i time su jako prediktabilni. 

Šta je imovina?
---------------

Mi svi koristimo pojam imovina da označimo šta neko poseduje. Međutim, za nas je važno i da matematički definišemo šta znači imovina 
kako bismo lakše mogli da koristimo matematičke modele za procenu njene vrednosti. 

Mi možemo posedovati imovinu u raznim oblicima, ljudima najčešće pada na pamet nekretnine kao što je kuća, stan, automobil ali imovina može biti i nematerijalna kao što su znanje, reputacija, patent, poslovna tajna. Ostali tipovi imovine su: akcije, opcije, obveznice itd...

Kao što vidimo, imovina može biti svašta a nama treba matematička definicija iste, zbog ovoga uvodimo sledeću definiciju (koja je opet apstraktna za sada):

Imovina u trenutak T je lista protoka novca u budućnosti.

Dakle, imovina je zapravo: (P(T), P(T + dt), P(t + 2dt), ...)

Protok novca u datom trenutku može biti i negativna vrednost. Za takvu imovinu kažemo da je "obaveza" (eng. liability).

Principi finansijske analize
----------------------------------

Sada, kada smo uveli pojam imovine, treba uvesti i neke pretpostavke na kojima ćemo bazirati svo naše dalje izlaganje a to su:

1. Ništa nije besplatno 
2. Ljudi preferiraju uvek više novca nego manje novca 
3. Ljudi preferiraju novac sada umesto novac kasnije 
4. Ljudi ne preferiraju rizik
5. Svako radi u svom najboljem interesu 
6. Finansijska tržišta teže da izjednače ponudu i potražnju
7. Finansijska tržišta su jako adaptibilna
8. Podela rizika je centralna stavka finansijske inovacije


Okej, verujem da neki principi izgledaju jako logično dok neki su nerazumljivi. Ovde smo ih samo naveli a kasnije ćemo u praksi pokazati kako svaki od ovih principa prirodno nadolazi kao priroda čoveka. Ove hipoteze ne zavise od političkog i ekonomskog modela neke države. Ove hipoteze su posledica čovekovog razmišljanja koje je duboko usađeno u njemu. Ako mislite da nije tako, pišite u komentarima i rado ću dati kontra-argument. :)

Procena vrednosti
------------------

Kao što se vidi iz gornje definicije imovine, imovina je definisana kao nešto što zavisi od vremena. Zbog ovoga, kada računamo vrednost 
imovine, jako je važno da tu vrednost računamo u zavisnosti od vremena. Trenutna vrednost neke imovine se može izraziti kao V = V(P(T), P(T + dt), ....) dakle kao funkcija svih budućih protoka novca (kojih može biti i beskonačno mnogo). 

ada treba da odredimo funkciju V koja će nam dati vrednost imovine opisane sa listom protoka novca P. 

Pre toga, uvedimo da je T vreme na godinu dana tako da dt = 1 znači vreme od jedne godine a dt = 2 znači vreme od dve godine itd. 

Isto tako, uvedimo da se mi nalazimo u trenutku T=0 kako bismo lakše mogli zapisati naredne delove. 

Posle ovakvog dogovora (koji ne umanjuje opštost) imamo da je V = V(P(0), P(1), ....).

Pre nego što definišemo funkciju V, treba uvesti fenomen koji je posledica gore-navedenih principa.

Vremenska vrednost novca
-------------------------

Zamislite da vam ja dam ugovor koji kaže da ću vam dati 1000 dinara za godinu dana. Koliko biste platili sada za taj ugovor? Ako biste platili tačno 1000 dinara onda mi je velika čast da poslujem sa vama. :) Realnost je da nećete dati 1000 dinara kako bih vam ja vratio tih istih 1000 dinara za godinu dana. Zašto? Zato što su ljudi nestrpljivi, rekli smo da preferiraju novac sada a ne novac kasnije. Kako možete da kompenzujete tih godinu dana čekanja? Tako što možete da mi date manje para sada za godinu dana kasnije. Zamislimo sada situaciju da ja odem i ponudim ugovor na tržištu od 100 ljudi. Svako može da ponudi cenu i onaj ko ponudi najviše dobija ugovor. Dakle princip aukcije. Zamislimo sada da je poslednja cena 990 dinara. Dakle, neko će se strpeti godinu dana za 10 dinara dobitka. Kao što vidimo, danas dinar ne vredi kao dinar za godinu dana. Ovde nisam ni pomenuo inflaciju i slično, to dolazi kasnije. Ovde sam samo rekao da ljudi preferiraju pare sada a ne pare kasnije. Dakle i bez inflacije i bez rizika i slično, opet ću morati da platim kamatu na pozajmljenih 990 dinara tako da ću za godinu dana morati da vratim 1000. Upravo smo, uz pomoć tržišta, odredili cenu ovog mog ugovora. Kako izgleda protok novca za vas koji dobijete taj ugovor: 

P = (0, 1000, 0, ...., 0)

Dakle sada ne dobijate ništa a za godinu dana dobijate 1000 dinara. Cenu smo odredili isto i znamo da je V = 990. 

Dakle znamo da je cena niža od protoka novca za godinu dana tako da je 990 = k * 1000.

Ovo je posledica nestrpljenja kod tržišta i tako zaključujemo da 1000 dinara danas nije iste vrednosti kao 1000 dinara sutra ili bilo kad u vremenu. Novac gubi vrednost samim tim što vreme protiče. 

A sada, procena vrednosti
---------------------------

Našu funkciju V možemo definisati kao zbir svih protoka novca ALI moramo paziti da ne sabiramo babe i žabe. Protok novca u budućnosti moramo konvertovati u ekvivalentnu vrednost danas.

V = P(0) + k(1)P(1) + k(2)P(2) + ...

k(T) je smanjenje u trenutku t. Naravno kako T raste, k(T) opada jer sve više moramo da čekamo i zato manje vrednujemo protoke novca koji su dalje u budućnosti. 

Naravno, k može varirati tokom vremena ali zbog jednostavnosti uvedimo da je K(T) = 1 / (1+r)^T gde je r kamatna stopa uzrokovana
vremenskom vrednošću novca. Iz ove jednakosti vidimo da je k uvek manje od 1 i da se sa porastom T, k smanjuje. 

r se lako može utvrditi na tržištu kao što smo videli u primeru. 

Sada ćemo uvesti neke primere finansijskih instrumenata i njihove vrednosti kako se računaju. 

Večne obveznice
-----------------

Zamislimo da imamo ugovor koji večno isplaćuje C tokom svake godine i tako zauvek. Ovo čak postoji i u praksi, na primer, Britanska vlada izdaje večne obveznice. 

Dakle, V = C/(1+r) + C/(1+r)^2 + ...

ovu sumu možemo zapisati i u zatvorenoj formi kao: V = C / r.

Dakle, ako znamo vrednost obveznice i godišnju isplatu, možemo lako izračunati kamatu r. 

Večne obveznice sa rastom
---------------------------

Sada zamislimo da imamo obveznicu koja isplaćuje C i svake godine raste za g procenata, onda je vrednost:

V = C(1+g)/(1+r) + C(1+g)^2 / (1 + r)^2 + ....

Kao i gornja, i ova suma se može izračunati što daje: V = C / (r - g) uz uslov da je g < r. 

Pored matematičkog smisla, ovaj uslov ima smisla i u realnosti. Dakle ne možemo imati rast veći od kamate a da je to održivo večno. Na primer, Kina ima rast oko 10% ali pošto su kamate znatno niže, ona taj rast ne može da ima večno. Ako to ne bi važilo, ceo univerzum bi pričao kineski i bili bi toliko bogati da bi sve na ovom svetu bilo njihovo što naravno nije moguće.


Ograničene obveznice
----------------------

Većina obveznica je ograničeno i ne izdaju se na period od beskonačno vremena nego su ograničene na N godina. Za njih dobijamo: 

V = C / (1 + r) + C / (1+r)^2 + .... C / (1 + r)^N = C((1 - 1/(1 + r)^N) / r)

U praksi ovakve obveznice su jao česte. Na primer, na sajtu za javni dug Republike Srbije se mogu naći obveznice koje država nudi građanima. Građani daju pare državi sada kako bi ona finansirala svoje potrebe a onda država isplaćuje rate građanu na određeni vremenski period. Ovo je i najsigurniji finansijski instrument pogotovo ako vam obveznice izdaje država jer ona garantuje da će vam ih uvek isplatiti. Ako država nema para da vam ih isplati, može da ih odštampa u najgorem slučaju. Kod korporativnih obveznica postoji rizik da firma bankrotira ali to je već tema za neki naredni ćlanak.
