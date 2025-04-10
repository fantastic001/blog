Title: SSH reversni tunel
Date: 2017-05-10 23:15:00 +0100
Slug: 2017-05-10-ssh-tunnel


Ovaj članak objašnjava kako podesiti reversni SSH tunel i time omogućiti forvardovanje portova preko mreže. Ovo je 
izuzetno korisno iz dva razloga:

1. Enkripcija neenkriptovanog protokola
2. Zaobilaženje NAT-a 

Uzmimo za primer da želimo da pošaljemo poruku računaru A sa računara B. Računar A je iza NAT-a koji brani sve konekcije koje počinju sa porukom od B do A ali ne rani konekcije koje su inicijalizovane sa porukom od A do B. 

Ovo se rešava tako što se računaru B od računara A pristupi preko SSH i uradi se mapiranje portova. 

Primer ovoga je dat sledećom linijom:

	ssh -fN -R 7000:localhost:50 username@B-ip

Sada sve što se pošalje na port 7000 na računaru B, biće prosleđeno računaru A na port 50.

Na primer, da omogućimo SSH konekciju na računar A na port 22 sa porta 7000 možemo uraditi:

	ssh -fN -R 7000:localhost:22 username@B-ip

I sada na računaru B treba izvršiti

	ssh -p 22 username@localhost

Pored svega ovoga, treba obratiti pažnju da li je mapiranje portova preko SSH odobreno u sshd.conf. 

Ovim putem zaobilazimo NAT + dobijamo enkriptovanu komunikaciju.
