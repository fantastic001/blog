---
layout: post
title:  "Neke strukture podataka"
date:   2017-05-10 18:15:00 +0100
categories: algorithms data-structures
---

U ovom članku ću dati pregled nekih struktura podataka čije razumevanje je dosta važno za razumevanje algoritama i uopšteno za razumevanje dosta principa u računarstvu. Treba napomenuti da je dosta nabrojanih struktura opisano [ovde](https://github.com/fantastic001/alg-implementations).

Za svaku strukturu je bitno znati koliko vremenski "koštaju" određene operacije. Ovo znači koliko vremenski traje određena implementacija da se izvrši. Naravno, vreme izvršavanja zavisi od mnogih faktora. Na primer, ako se pored naše aplikacije izvršava još neka aplikacija sasvim je jasno da CU neće operaciju izvršiti jednako brzo kao i kada bi se samo ta operacija izvršavala. Zbog ovoga, za opisivanje vremena se koristi [O-notacija](https://en.wikipedia.org/wiki/Big_O_notation)..

Pa da krenemo....


Lista
------

Lista se sadrži od struktura (čvorova) gde svaki čvor ima u sebi vrednost koju čuva i pokazivač na sledeći čvor u listi. Pored ovoga, čvor može imati i pokazivač na prethodni čvor u listi i tada je lista dvostruko povezana. 

Implementacija čvora u programskom jeziku C bi izgledala ovako: 

	typedef int TYPE;
	typedef struct node_st 
	{
		TYPE val; 
		node_st *next;
		node_st* prev; // za dvostruko povezanu listu 
	} node;

Ovde smo koristili celobrojni tip kao primer tipa koju vrednost čvora može da ima. U ovom primeru je lista zapravo lista celobrojnih elemenata.

Listta podržava dodavanje elementa na kraj u O(1) vremenu, iteraciju kroz celu strukturu i pristupanje određenom 
elementu u O(n) vremenu. Brisanje elementa se radi u O(1) ako nam je dat pokazivač na element koji treba da obrišemo
ili u slučaju jednostruko povezane liste, pokazivač na prethodnika elementa koji treba obrisati. 

Stek 
-----

Ova struktura ima u sebi pokazivač na gornji element i podržava samo tri operacije: push, pop i top. 

1. push: dodavanje elementa na stek;
2. pop: brisanje elementa sa vrha steka i;
3. top: pristupanje elementu sa vrha steka.

Sve nabrojane operacije je moguće realizovati u O(1) vremenu. 

Red
-----

Ova struktura podržava dodavanje elemenata na početak reda, uklanjanje elemenata sa kraja reda i pristup elementima na krajevima i sve ove operacije se realizuju u O(1) vremenu.

I stek i red se mogu implementirati preko lista. 

Pored ovih struktura postoje i još neke dosta značajne koje su zauzele ceo jedan tekst a to su: binarno stablo pretrage, hip, heš tabela i graf.
