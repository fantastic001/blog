---
layout: post
title:  "Uvod u finansijsku analizu - 2. deo"
date:   2018-10-18 10:15:00 +0100
categories: finance
---

U prethodnom delu sam uveo neke osnovne termine i koncepte u finansijskoj analizi. Ovde ću nastaviti sa analizom još nekih finansijskih instrumenata
koje možemo upotrebiti bilo direktno bilo u modelovanju. 


Akcije
--------

Akcija je udeo u kompaniji. Ona investitoru omogućava glasačko pravo za biranje upravnog odbora kao i pravo na dividendu. Dividenda je deo profita koji, na odluku upravnog
odbora, idu investitorima. Najčešće u intervalima od 3 meseca ili godinu dana ali to opet zavisi od odluke upravnog odbora. 

Investitoor svoju zarad može da dobije na 2 načina: od dividendi ili od prodaje akcije (kapitalna dobit). U analizi koja sledi pretpostavićemo da investitor ne prodaje akciju i da zarađuje samo od dividendi. 

Dakle, jedini protok novca koji postoji u tom slučaju jeste zarada od dividendi: 

Akcija = {D1, D2, ....}

ako uzmemo model procene vrednosti po kom smo procenjivali i obveznice, dobijamo da je cena akcija: $$ V = \sum_{i=1}^\infty \frac{D_i}{(1 + r)^i} $$ 

Ovde r izražava rizik kao i kamatnu stopu.

Sada možemo analizirati neke trivijalne slučajeve koji nam mogu pomoći da lakše razumemo prirodu cene akcije. 

Akcije koje imaju konstantnu dividendu
----------------------------------------

Iako većina kompanija nema fiksnu dividendu (težnja za rastom), analiza ovog slučaja daje rezultat koji nam može pomoći da analiziramo kompleksnije slučajeve:

U ovom slučaju je akcija = {D, D, D, ...} i onda dobijamo model kao kod fiksnih večnih obveznica da je $$ v = D / r $$

Dakle, sa povećanjem rizika se cena smanjuje a sa povećanjem dividende se cena povećava. 

Akcije sa konstantnim rastom
-------------------------------

Naravno, gornji model nije realan jer ne uzima u obzir da profit kompanije može da raste. Zbog ovoga uvodimo malo kompleksniji model koji kaže da se dividenda u svakoj iteraciji povećava 
za g procenata i time dobijamo da je akcija = {D, D(1+g), D(1+g)^2, ...}. Iz ovoga se dobija da je $$ V = \frac{D}{r - g} $$ 

Odavde se može zaključiti da što je rast veći (manji od r) i što je početna dividenda veća, to je cena akcije veća. Ako je rast mali u poređenju sa rizikom, onda to utiče na smanjenje
vrednosti akcije. iz ovog modela se može i izraziti rizik koji kaže da je: $$ r = \frac{D}{P} + g $$ . Izraz D/P se može videti sa listinga akcije na berzi i on
predstavlja odnos poslednje isplaćene dividende i trenutne cene akcije. Ako znamo koliki je potencijalni rast ove kompanije, znamo i koliki je rizik. 

Berza
------


Berza je mesto za trgovanje akcijama i drugim hartijama od vrednosti. Što se akcije tiče, bitno je napomenuti da tu imamo dva tržišta: primarno i sekundarno. Na primarnom tržištu je prodavac uvek kompanija koja svoje akcije prodaje po prvi put (Initial Public Offering - IPO) koja ima potrebu za investiranjem u svoju tehnologiju i time traži finansijsku pomoć javnosti 
kako bi finansirala svoje operacije. Na sekundarnom tržištu investitori trguju akcijama i tu se cene određuju principom ponude i potražnje a koje smo modelovali gore sa dva jednostavna modela. 

Trgovanje izgleda tako što investitori koji žele akciju da kupe kažu koliko su spremni da plate za nju dok investitori koji prodaju akciju kažu koliko su spremni da dobiju za akciju (koliko je cene). Kada se izjednači minimalna cena prodavca (ona najmanja) i maksimalna cena koju je ponudio neki kupac, onda se desi transakcija između ta dva investitora. Ovo se danas uglavnom radi elektronski preko Interneta.


Opcije
---------

Ovde ću samo ukratko objasniti šta su opcije i kako rade, mislim da ova dva blogposta ne treba da budu literatura iz finansijske analize. Dakle, opcije su hartije od vrednosti
sa kojima se isto može trgovati kao i sa bilo kojim drugim hartijama od vrednosti. Opcija nam daje pravo da kupimo ili prodamo akciju po ceni koja je određena opcijom u zadatom terminu ili do zadatog termina. Dakle, one nas ne obavezuju da izvršimo transakciju već nam daju pravo da po fiksnoj ceni izvršimo transakciju. Tako, na primer, ako imamo opciju koja kaže da možemo kupiti akciju A po ceni od $500 u roku od mesec dana a cena akcije posle 15 bude $650 onda mi možemo iskoristiti opciju i kupiti po $500 a prodati po $650 i profitirati $150. Međutim, pošto ništa nije besplatno, u ovu računicu moramo uračunati i cenu opcije C tako da bismo zapravo dobili $150 - C. 

Literatura
-----------

MIT ima dobar kurs na ovu temu: https://ocw.mit.edu/courses/sloan-school-of-management/15-401-finance-theory-i-fall-2008/video-lectures-and-slides/

Dobra knjiga: M. Capihski T. Zastawniak - Mathematics for finance


