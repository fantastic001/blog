Title: Neke strukture podataka - hip
Date: 2017-05-10 22:00:00 +0100
Slug: 2017-05-10-data-structures-heap


Hip je struktura podataka koja nam omogućava da brzo i lako dođemo do maksimalnog elementa. Često se predstavlja kao stablo 
zbog lakšeg objašnjavanja ali se tokom implementacije koristi niz. Hip se predstavlja kao stablo na sledeći način: za svaki čvor, njegova deca su uvek manja od tog čvora. Ovakva reprezentacija podataka nam omogućava da nam na vrhu stabla (korenu stabla) uvek bude najveći element. Slično, možemo i obrnuti situaciju, da za svaki čvor su njegova deca manja od tog čvora. U ovom slučaju dobijamo strukturu
gde nam je na vrhu uvek najmanji element. U implementaciji, za izvedbu hipa koristimo niz tako da nam element a(i) bude čvor a elementi 
a(2i+1) i a(2i + 2) su njegova deca. Isto tako, ako imamo čvor a(i) onda njegovom roditelju pristupamo kao elementu a((i-1)/2).

Hip nam omogućava dodavanje elemenata u O(n log n) vremenu kao i brisanje u O(n log n) vremenu. Ipak, ako želimo najveći (najmanji) element onda to možemo dobiti u O(1) vremenu, mnogo brže nego u listi gde moramo proći kroz celu listu da bismo našli najveći element. 
U hipu da bismo našli najveći element, dovoljno je da pristupimo njegovom čvoru, tačnije elementu a(0) jer znamo da su svi ostali sigurno manji od njega. 

Kako koristimo niz da u njemu čuvamo naše podatke, ovo znači da od bilo kog niza možemo napraviti hip. Kako se ovo izvodi? Pretpostavimo da želimo da napravimo hip u nizu od indeksa i pa do kraja. Ovo radimo na sledeći način:

1. Vidimo koji je najveći element od elemenata a(i), a(2i) i a(2i+1), uzmemo njegov indeks i nazovemo ga j 
2. zamenimo elemente na indeksima i i j 
3. pozovemo funkciju za izradu hipa rekurzivno za dati niz sa početnim indeksom j

Da od celog niza napravimo hip, potrebno je da krenemo od n/2-tog elementa i sve do početka niza pozivamo funkciju za izradu hipa.

U pseudokodu bi to izgledalo ovako:

	func max_heapify(A, i):
		l,r = 2*i, 2*i+1
		m = max(A(i), A(l), A(r))
		j = 0 
		if A(i) = max: j = i
		if A(l) = max: j = l
		if A(r) = max: j = r
		swap(A(i), A(j))
		max_heapify(A, j)
	
	func build_heap(A):
		n = A.size 
		for i=n/2 downto 1:
			max_heapify(A, i)

Funkcija za određivanje maksimalnog elementa bi onda u tom slučaju bila ovako:

	func maximum(A):
		return A(1)

Pored toga, imamo u funkciju za brisanje maksimalnog elementa:

	func max_extract(A):
		max = A(1)
		n = A.size 
		swap(A(1), A(n))
		A.size = A.size - 1
		max_heapify(A, 1)
		return max
	
za ubacivanje elementa u hip:

	func insert(A, x):
		A.size = A.size + 1
		A(A.size) = x
		i = A.size
		while i>1 and A(i/2) < A(i):
			swap(A(i/2), A(i))
			i = i/2

Dakle ova funkcija ubaci element na dno hipa i podiže ga gore sve dok mu je trenutni roditelj manji od datog elementa.

Sada e može lako implementirati i jedan algoritam za sortiranje koji je baziran na upotrebi hipa (heapsort). On se svodi na sledeće:

1. Želimo da sortiramo niz A
2. Napravimo niz B koji će nam biti rezultat sortiranja
3. Napravimo hip od niza A(1...n) 
4. radimo extract sve dok ne ispraznimo hip A, maksimalne elemente ubacujemo u niz B 


