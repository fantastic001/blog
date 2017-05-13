---
layout: post
title:  "Git + CMake + unit testovi = kako se softver pravilno razvija"
date:   2017-05-13 13:15:00 +0100
categories: software development
---

Dosta godina se bavim programiranjem i mogu reći da sam video zaista dosta primera o tome kako se razvija softver. Dosta faktora
utiče na razvoj softvera, pre svega utiču resursi poput finansija, ljudi, vremena i samog okruženja i konteksta. Pored ovih, postoje 
i tehnički razlozi zašto neki softver ugleda svetlost dana a zašto neki ne. Pored svih ovih resursa, tehnički resursi 
značajno mogu da umanje i troškove i vreme potrebno za razvoj i broj ljudi koji je potreban da razvija softver. Naravno, nekada
dodatni slojevi u razvoju mogu i uvećati sve ove stavke ali to se uglavnom dešava zbog nesposobnosti da se dati tehnički alati 
koriste pravilno ili zato što ti alati ne zadovoljavaju potrebe onog ko razvija softver. Ova druga mogućnost je manje verovatna 
i ona se obično dešava u velikim kompanijama poput Gugla, Fejsbuka i sl. 

U ovom članku ću pokazati kakvi su sve tipovi alata potrebni za kvalitetan razvoj softvera i dati neke primere istih. 

Prilikom razvoja softvera važe neke činjenice kao na primer da je često potrebno uraditi neku inovaciju. Da bismo došli do toga, 
stalno moramo da pravimo eksperimente. Da bismo tako nešto uspeli, potrebno nam je okruženje koje nam omogućava da eventualne 
greške i pogrešne odluke eliminišemo vraćanjem na stariju verziju softvera. U ovome nam pomaže sistem za kontrolu verzija a jedan 
primer takvog alata je Git o kom će biti više reči kasnije. 

Tokom razvoja, treba znati kada je određeni posao završen. Pre svega, čitav razvoj je potrebno podeliti u manje delove 
kako bismo mogli da radimo delić po delić. Ovo je značajno i iz tehničke i iz pihološke strane. Prvo, psihološki, čoveku je lakše
da održ motivaciju kada radi deo po deo i kada vidi napredak u tom radu. Sa tehničke strane, rad deo po deo nam omogućava 
da svaki delić izolujemo i zasebno testiramo. U ovome nam pomažu unit testovi koji upravo tome služe. Napišemo testove 
za modul koji razvijamo i razvijamo ga sve dok taj modul ne prođe sve napisane testove. Ovako znamo i kada je posao završen - onog trenutka kada modul prolazi sve unit testove. Ovim e eliminiše i još jedna, danas loša, osobina - perfekcionizam. Danas, kada je važno biti
brz i brzo menjati stvari u malim iteracijama perfekcionizmu nema mesta i posao je završen onog trenutka kada je modul dovoljno dobar. 

I treći alat je alat za distribuiranje i izgradnju softvera. Ovaj alat treba da se postara da se svi vaši fajlovi 
uredno kompajliraju, da se dokumentacija spakuje i da se to sve može instalirati na sistem korisnika. Primer ovakvog alata je 
svakako CMake ali ovde ne mogu da kažem da samo njega koristim. Sve zavisi u kom jeziku radite. Ako koristite C++, CMake je 
svakako way-to-go ali nije ako koristite Python jer on ima svoj sistem. 


Git
----

Kao što je već napomenuto, Git je sistem za kontrolu verzija. Omogućava nam da zabeležimo svaku promenu i da se u svakom trenutku možemo vratiti na bilo koju verziju od ranije. Ima dosta opcija, može se raditi i grananje. Grananje je metod da u jednom trenutku krenete da razvijate softver u dva pravca. Na primer, niste sigurni koji algoritam će rešiti konkretan problem bolje. Razvoj možete razdvojiti u dva pravca (branch-a) i razvijati svaki posebno. Kasnije kada znate koji je algoritam bolji, ovaj drugi možete samo izbrisati i nastaviti razvoj normalno. Nema copy-paste koda pa da testirate neke izmene. Sve možete u postojećem kodu. Pored ovoga, Git je distribuirani sistem što nam omogućava da softver razvijamo na više računara i da ne brinemo kako ćemo raditi sync svega toga. Postoje i onlajn servisi gde možete čuvati kod poput GitHaba koji je ada postao kao jedna društvena mreža sa bogatom bazom softvera. 
Git omogućava lagan rad u timovima, rade svi zajedno ali svako svoj posao. Sve se radi na istom projektu.


CMake
------

Kao što sam gore naveo, ne mogu baš da kažem da je CMake jedini alat za ovu svrhu koji koristim ali je definitivno vredan da 
se izdvoji kao lider. Možete napisati kako se vaš softver kompajlira, koji fajlovi se instaliraju i gde u sistemu. CMake radi na više različitih platformi a koristi ga dosta veliki broj softvera. Jako se lako uči i koristi a dokumentacije ima dosta. Olakšaćete život distributerima i korisnicima ali i sebi ako planirate da pravite instalacije za različite platforme. 

Unit testovi
--------------

Već sam dosta pisao o ovome iznad. Ovaj metod omogućava da radite modul po modul. Da svaki modul testirate i tako da znate kada ste završili. Postoje i razne metrike kao što je pokrivenost koda testovima i sl. Pored ovoga, svaki put kada uvidite bag ili vam ga neko prijavi, prvo napišite test koji otkriva taj bag a onda krenite da ga ispravljate. Nemojte da budete lenji, nekoliko linija više će vam spasiti vreme. Na ovaj način nećete stalno ponavljati iste greške i tako težite ka tome da vam softver sve manje bude bagovit. 


