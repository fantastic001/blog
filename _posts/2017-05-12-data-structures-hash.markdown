---
layout: post
title:  "Neke strukture podataka - heš tabele"
date:   2017-05-12 18:15:00 +0100
categories: algorithms data-structures
---

Heš tabele su jedan od jako dobrih načina čuvanja podataka. Pretpostavimo da imamo ogromnu količinu podataka kojoj želimo
da pristupamo jako brzo. Svaki element ima neku vrstu identifikacije. Na primer ako imamo podatke o osobama, identifikacija može biti
JMBG osobe. Heš tabela je zapravo niz lista gde svaki element je lista koja sadrži elemente čiji se heš poklapa. E sada, šta nam je ovde heš? Iz primera sa osobama, znamo da imamo mnogo JMBG brojeva i znamo da sa običnom listom da bismo našli određenu osobu, treba da prođemo kroz celu listu dok je ne nađemo. Ovo može predstavljati problem ukoliko imamo veliki broj osoba. Drugo rešenje je da koristimo niz i da osobi pristupamo na osnovu njenog identifikacionog broja odnosno da identifikacioni broj osobe bude njen indeks u nizu. Ovo je ponovo teško realizovati ako se uzme u obzir veliki broj osoba pa samim tim bi i naš niz zauzimao mnogo memorije. Zbog ove dve činjenice, heš tabela predstavlja kompromis. Prvo, nemamo niz onoliko veliki koliko imamo osoba nego manji niz a svaka osoba ima svoj identifikacioni broj, mi kada želimo da pristupimo određenoj osobi mi njen identifikacioni broj transformišemo u indeks niza. Ovaj postupak se naziva
heširanje. E sada, kako imamo mnogo osoba a manje mogućih indeksa, desiće se da dve osobe imaju isti indeks u nizu. Zbog ovoga svaki element niza je zapravo lista osoba koje imaju isti indeks u nizu (heš). 

Sada se postavlja pitanje da li nam je isplativo da sve ovo implementiramo kad opet prolazimo kroz listu. Odgovor je da je ta lista mnogo manja nego lista svih osoba pa je prolazak kroz tu listu mnogo brži. 

Dakle, ako želimo pristupiti osobi za identifikacionim brojem ID, tada prvo primenimo transformaciju hash(ID) pa pristupimo listi osoba
sa tim hešom i onda u toj maloj listi nađemo osobu koja nas interesuje. 

