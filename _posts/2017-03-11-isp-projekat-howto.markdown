---
layout: post
title:  "Kako izgleda rad na projektu u IS Petnica na seminaru računarstva - smernice za nove polaznike"
date:   2017-03-11 22:15:00 +0100
categories: petnica 
---

![IS Petnica]({{ site.url}}/images/petnica.jpg)

Za 4 godine koliko sam proveo u [Istraživačkoj Stanici "Petnica"](http://www.petnica.rs) kao polaznik seminara računarstva, imao sam 
priliku da iskusim kako je to raditi na naučno-istraživačkom projektu. Ovo mi je mnogo značilo da naučim dosta važne stvari i o računarstvu ali i o tome kako da se organizujem, kako da planiram, kako da završim projekat do kraja, kako da obradim rezultate i na kraju kako da te iste rezultate predstavim drugima. 

U Petnici se polaznici dele na mlađe i starije, ovi mlađi su polaznici koji su tek prvi put u Petnici a stariji su svi ostali (oni koji su već prisustvovali nekom letnjem seminaru u ISP). Mlađi polaznici na seminarima slušaju predavanja, rade u laboratorijama, rade konkretne male problemčiće iz oblasti kojom se bave dok stariji rade na konkretnim istraživačkim projektima. Od starijih polaznika se očekuje da osmisle svoj predlog projekta, organizuju rad na projektu tokom cele godine i da kasnije, ako je projekat završen, da svoje rezultate
predstave široj publici na naučnoj konferenciji. Kao neko ko ima 2 objavljena rada u zbornicima radova ISP (treći je na putu), mislim
da mogu i da kažem nešto o tome kako sam ja to sve radio i šta bih preporučio mlađima da se pridržavaju. Tekst je namenjen 
polaznicima računarstva ali dosta delova može da posluži i ostalim polaznicima sa drugih seminara a i svima ostalima koji nameravaju
da se bave naukom ili da se upuste u izradu nekog projekta van ISP, kod kuće,  na fakultetu ili negde drugde. 

Kao stariji polaznik sam često dobijao pitanja od mlađih o tome kako se radi projekat, šta da predlože itd. Zbog svega ovoga sam odlučio da napišem ovo ovde pa ako nekome bar delić bude koristan, odlično! Treba naglasiti da je tekst u većem delu moje lično iskustvo i moji lični stavovi pa ako se neko ne slaže, neka napiše u komentar ili pošalje mejl, vredi naučiti i čuti nešto novo. 

Odabir projekta
=================

Odabir projekta je prva aza i ona se obavlja prilikom prijave na seminar. Predlog projekta se šalje u sklopu dokumentacije prilikom
konkurisanja na seminar kao stariji polaznik. Ovde je bitno napomenuti da taj predlog projekta koji se šalje u prijavi za seminar ne mora biti konačan. Predlog se dodatno izrađuje tokom zimskog seminara uz konsultacije sa rukovodiocem i saradnicima na seminaru. 
Ipak, važno je taj predlog tokom prijavljivanja na seminar napisati što bolje, kako bi se na zimskom moglo diskutovati o konkretnoj izradi projekta bez gubljenja vremena na traženje novog projekta. 

Ovde je pre svega važno biti svestan koji je cilj projekta i čime se Petnica bavi. Zbog ovoga, treba prvo da razmotrimo kog karaktera bi trebalo da bude projekat koji ćete izrađivati tokom godine. 

Naučni metod
------------

Dakle, kao što joj i samo ime kaže, Petnica je naučno-istraživačka stanica. Ovo znači da se bavi edukacijom polaznika tako što ih uči 
da zaključke donose na osnovu naučno prihvatljivih činjenica i na osnovu logike. Zbog ovoga se posebna pažnja posvećuje obrazovanju
polaznika kako da dolaze do rezultata i saznanja upotrebom naučne metodologije. 

Naučni metod, u svojoj najbazičnijoj formi, se svodi na tri faze: 

1. Postavljanje hipoteze
2. Izrada i obavljanje eksperimenta i implementacije 
3. Merenja i prezentacija rezultata sa zaključcima.

Za svaku fazu je namenjen poseban seminar: zimski, letnji i jesenji. 

Odabir projekta se zapravo svodi na prvu fazu - postavljanje hipoteze. 

Naučni metod u računarstvu
----------------------------

Ako ovo sve deluje previše opširno, evo malo konkretnih primera. Računarstvo je nauka, isto kao i astronomija, fizika, psihologija, istorija... Dakle, metode se primenjuje i na ovu oblast kao i na svaku drugu. 

Hipoteza može biti da će određeni metod da pokaže očekivane rezultate koje mi sami postavljamo. Taj metod je obično neki algoritam 
koji smo sami smislili ili smo ga negde našli pa želimo da ga primenimo na način na koji ga do sada niko nije primenio. Takođe, možemo
i kombinovati nekoliko postojećih algoritama ili modifikovati neki algoritam i onda meriti njegovu uspešnost u rešavanju problema.

Na primer, u mašinskom učenju možemo da merimo preciznost nekog algoritma za prepoznavanje određenih obrazaca. Ako se bavimo
operativnim sistemima, možemo posmatrati kako određeni algoritmi za rukovanje procesima funkcionišu ili recimo kako najbolje 
da organizujemo sistem datoteka (eng. file system) tako da HDD najmanje ima upisa/čitanja. Ako se bavimo primenom računara za numeričku
simulaciju fizičkih sistema, možemo meriti preciznost određenog algoritma za numeričku aproksimaciju za određeni fizički fenomen ili 
možemo meriti stabilnost fizičkog sistema upotrebom datog numeričkog algoritma. Ako se bavimo izradom novog jezika, možemo posmatrati
kako se uz pomoć tog novog jezika rešavaju određeni problemi pa ga porediti sa postojećim jezicima. Možemo i da izrađujemo neku 
novu arhitekturu računara sa ciljem da je primenimo na specifičan problem. 

Zaključak je da za svaku oblast računarstva, imamo dosta stvari koje možemo da postavimo kao hipotezu i da nam to bude polazna tačka. 

Kao što se već moglo primetiti iz primera, za svaku hipotezu nam treba referentna vrednost. Ne možemo reći da je nešto bolje ili lošije
ako nemamo referentnu vrednost. Dakle, da bismo mogli da pričamo o nekom merenju, MORAMO znati sa čim to poredimo. Ako radimo neki nov
algoritam i za njega nešto merimo, moramo znati šta radi neko postojeće rešenje. Rad koji daje vrednost nekog merenja za neki novi 
algoritam a ne poredi ga sa nečim što nam je poznato - ne znači ništa! 

Ne možete reći da je nešto dobro ili loše ako nemate sa čim da uporedite. Ako se ispostavi da je vaš algoritam lošiji od postojećeg, to je isto validan rad. Bolje rad sa prikazom novog, lošijeg algoritma nego rad sa prikazom algoritma za koji ne znamo kakav je - ne znamo ni da je loš ni da je dobar. 

Dake, moramo imati nešto sa čim poredimo i moramo imati način kako da izmerimo šta nas zanima. 

Merenje može biti bilo šta, na primer, preciznost prepoznavanja obrazaca u mašinskom učenju, odstupanje od tačne vrednosti kod numeričkih simulacija, brzina algoritma, broj linija koda kod novog jezika itd... 

Ali ....kako do ideje za kul projekat?
-----------------------------------------

OK, sad znamo šta nam treba sve da imamo dobar predlog projekta ali još uvek ne znamo kako da dođemo na ideju. Do dobre ideje se ne 
dolazi preko noći, nikad niko nije došao na kul ideju preko noći. Ne postoji lampica u glavi niti jabuka koja je Njutnu pala na glavu. Ideje se dobijaju kada se nečim već bavite, kada čitate svašta, kada pričate sa kolegama, sa prijateljima. Kada naiđete na problem koji vas nervira i želite da ga rešite i spremni ste da posvetite svoje vreme tom problemu i znate kako biste mogli da ga rešite i želite da 
to proverite - to je ideja koju tražite. 

Zbog ovoga, nabavite svesku i beležite svoje ideje. Ideje vam nastaju kad se najmanje nadate pa bi trebalo da budete spremni da ih "uhvatite". Ideja vam može nastati tokom priče sa nekim asistentom, prijateljem, dok čitate nešto na netu, dok programirate već nešto. Beležite svoje ideje, trebaće vam.


Teorija, teorija i teorija i teorija i ...... 
===============================================

Ako bih bio upitan da kažem neki svoj najveći propust u Petnici, onda bi to definitivno bilo neposvećivanje dovoljno pažnje teoriji. 
Teorija je izuzetno važna da razumete oblast i problem kojim se bavite i da kasnije lakše možete da isplanirate implementaciju
projekta. Na kraju, kada budete pisali rad, poznavanje teorije će vam pomoći da tokom revizije ne budete vraćeni jer ste pogrešno 
upotrebili terminologiju. Jeste smor, zanimljivije je kucati kod ali je jako važno pre implementacije razumeti teorijsku podlogu svega. 

Ovo pre svega znači da je potrebno upoznavanje sa svom matematikom koja stoji iza svega, od linearne algebre do analize, od grafova do
teorije grupa, sve što je relevantno za vaš problem koji rešavate, treba se upoznati sa tim. Ako se bavite mašinskim učenjem onda 
ćete se baviti statistikom, verovatnoćom, linearnog algebrom, linearnog regresijom, linearnom klasifikacijom, neuronskim mrežama, Markovljijevim modelima itd. 

Ako se bavite ispitivanjem numeričkih metoda za simulaciju određenog fenomena, onda će vam trebati prvo poznavanje kako se brojevi 
čuvaju u računaru, kako se aproksimiraju funkcije, Tejlorov red, kako se aproksimira izvod ali će vam trebati i poznavanje konkretnog
fenomena kojim se bavite kao i jednačina koje opisuju dati fenomen. 

Ako se bavite izradom sopstvenog jezika, treba da znate za leksičku analizu, za abstraktno sintaksno stablo, možda i za neke algoritme 
optimizacije koda itd.

Treba da pronađete dobru literaturu koja objašnjava potrebne teorijske koncepte kako biste kasnije lakše mogli da razumete radove 
koji se bave konkretnim problemom kojim se i vi bavite. 

Kada ste završili sa upoznavanje sa osnovnom potrebnom teorijom, na red dolazi istraživanje o postojećim rešenjima za vaš problem. Velika je verovatnoća da niste jedini koji pokušava da reši dati problem pa tako verovatno postoje već gotova rešenja za dati problem. U ovom
koraku ćete verovatno pronaći dobre referentne metode sa kojima možete da poredite vaš metod. Radovi se mogu naći na raznim mestima, za računarstvo se radovi uglavnom vrlo lako nalaze na Internetu a moja preporuka za pretraživač je Gugl ili, još preciznije, [Google Scholar](https://scholar.google.com/).


Implementacija
================

Sada kada imamo ideju šta hoćemo, treba i da to napravimo. U ovom delu izrade projekta mnogi projekti propadaju jer se ispostavi
da ili imaju loše poznavanje teorije ili loše poznavanje programiranja. Kako smo teoriju rešili (I hope so), ostalo je da rešimo
i ove "inženjerske" stvari. Pa da krenemo...



Odabir alata
--------------

Prvi korak je odabir alata, dakle jezik i frejmvork. 

Ovde je najbolje da uzmete nešto gde se snalazite, rad na projektu nije prilika da naučite novi jezik. Uzmite ono što vam radi 
posao. Isto važi i za frejmvork s tim da ovde može biti izuzetak ako rešavate problem kojim se nikada do sada niste bavili
pa koristite nešto što do sada nikada niste koristili. U tom slučaju, dobro treba iščitati dokumentaciju a ne površno koristit
frejmvork. Ovde je jako bitno i obratiti pažnju na konvencije i terminologiju koju koristi frejmvork jer se može desiti da se ne 
poklapa sa onim na šta ste navikli pa ćete morati da se prilagodite, bar dok čitate dokumentaciju. 

Takođe je bitno naglasiti da ne bi trebalo suviše preterivati sa upotrebom više različitih alata i frejmvorkova. Keep it simple. 
Računajte i da frejmvork može imati bag, ne uzimajte ga zdravo za gotovo. Trudite se da koristite proverene alate sa velikom 
zajednicom i bogatom dokumentacijom. 

Pre nego što krenete sa konkretnom izradom projekta, treba se prvo upoznati sa alatima. Pokušajte da napravite nešto sitno kako 
biste se upoznali sa alatima i kako bi vam oni ušli "pod prste".

Izdizajniraj sve
-----------------

Sada treba isplanirati konkretnu implementaciju. Napravite mali skicu kako želite da organizujete projekat i kod. Podelite sve u manje
module i trudite se da moduli što manje zavise jedni od drugih. Trudite se da ovde što bolje uradite planiranje jer dobro planirane 
i dobro izdizajnirane stvari rade bolje i lakše se kasnije modifikuju i nadograđuju. 

Posao implementacije izdelite na male zadatke od kojih svaki traje najviše 2 sata. Usitnite sve u sitna crevca. Ovim postižete pre
svega psihološki efekat da stalno napredujete jer ćete stalno čekirati nešto kao "done" i to će držati vašu motivaciju. Ima mnogo 
tekstova na ovu emu i kako se radi estimacija vremena tako da možete to detaljnije da pročitate. 

Unit testovi
------------

Ovo je jako važan deo. Unit testovi su delovi koda koji automatski testiraju pojedinačne funkcionalnosti modula vašeg projekta. 
Ovim postižete da stalno možete testirati vaš kod kad napravite izmenu i da se to sve radi automatski. Na Internetu ima mnogo objašnjenja i primera kako se koriste i prave unit testovi. Ako radite u Pajtonu, pogledajte [ovo](https://docs.python.org/3.6/library/unittest.html). 

Git i CMake 
------------

Jako je važno da imate prostor za eksperimentisanje i mogućnost da se vratite na prethodno stanje kada nešto pokvarite. Zbog ovoga 
je jako korisno da koristite neki sistem za verzionisanje kao što je [Git](https://git-scm.com/) a projekat možete da imate i na 
[GitHabu](https://github.com/) kako biste osigurali, ako izgubite kod na vašem računaru, isti imate i onlajn. Pored ovoga, ako objavite kod kao open source, možete tražiti pomoć od drugih kolega i lako im proslediti link do vašeg projekta. Githab nudi i istem za prijavljivanje bagova, upravljanje zadacima kao i mesto za pisanje dokumentacije tako da vam i to može koristiti. 

[CMake](https://cmake.org/) je sistem za automatizaciju kompajliranja vašeg projekta. Ima dosta mogućnosti kao što su i pokretanje testova, traženje potrebnih biblioteka da se linkuju sa programom koji se kompajlira, izrada man stranica iz izvornih fajlova za dokumentaciju, instalacija projekta na sistem itd. Jako korisno pa pogledajte, značiće vam. 


Pisanje rada
============

U ovoj fazi već možete da predahnete, težak deo je završen. Sada je potrebno da rezultate vašeg istraživanja predstavite kroz rad 
koji bi trebalo da bude objavljen u zborniku radova ISP.

Prvo je važno napisati naslov. Iako zvuči jednostavno, pisanje naslova može biti dosta zamarajuće jer je to prvo što će vaši budući čitaoci da vide. Ako taj naslov ne opisuje šta ste radili, može zbuniti buduće čitaoce rada. Sa druge strane, naslov ne treba da bude ni previše dugačak ni opširan jer to smara. 

Dobar metod koji su meni saradnici u Petnici pokazali za pisanje naslova jeste da razmislite o tome koje su ključne reči koje opisuju vaš rad. Šta je ono za šta mislite da treba da istaknete? Kada to odredite, povežite to u jednu celinu i to je prva verzija naslova. Sada vidite šta tu fali i šta je suvišno i sve tako dok ne budete zadovoljni. Pitajte i kolege da vam pomognu. 

Ostatak rada prvo organizujte. Organizujte sadržaj samog rada. Uvod bi trebalo da sadrži opis problema kao i dosadašnja rešenja. Pored ovoga, u uvod možete i uvesti neke teorijske napomene i terminologiju. 

Metod je onaj deo koji ste vi radli tokom leta. To je ono šta ste radili. Ovde opišite detaljan pristup i kako ste uradili svaku stvar. Naravno, nema potrebe da pišete stvari koje nisu vezane za konkretno rešavanje problema. Nemojte da pišete kako ste koristili Git, Cmake, u koliko ste sati jeli i da li ste uopšte jeli i spavali. Pišite samo ono što je vezano za izradu konkretnog metoda koji se bavi rešavanjem problema koji ste opisali u uvodu. 

U rezultatima i diskusiji treba navesti ... rezultate. Dakle, grafici, primeri generisanog koda itd. 
Rezultate merenja obavezno čuvajte u nekom sirovom formatu kao npr CSV jer se može desiti da vaši grafici nisu prikladni za zbornik
radova pa će biti potrebna ponovna izrada grafika pa vam ponovo mogu zatrebati podaci.

Za kraj
=======

Ovo je samo ukratko objašnjeno šta i kako se radi. Ponovo moram da naglasim da je sve ovo prikupljeno iz nekog mog ličnog iskustva. 
Treba naglasiti da je najvažnije na kraju koliko ste naučili i koliko ste napredovali. Nemojte da vam cilj bude konferencija, neka vam cilj bude napredak vas samih. Cilj je da naučite nešto novo, da nešto otkrijete, da se družite i da uživate u radu. Kada ovo postavite kao cilj, konferencija je samo alat i usputna stanica. Ona vam služi da se dodatno isprobate u prezentovanju rada ljudima koji nisu iz
vaše oblasti, da naučite da napravite poster i prezentaciju. 

Sve u svemu, nadam se da će ovaj tekst bar malo pomoći u tome da dostignete vaš cilj i da naučite nešto bolje i da Petnica za va bude isto ono što je i za mene - mesto gde volim da odem i gde se osećam sjajno.
