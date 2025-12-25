#!/bin/bash

urmeazaVerif="/home/nico/itbi/proiect_itbi/urmeazaVerif"
verificate="/home/nico/itbi/proiect_itbi/verificate"
fisierHTML=$1
cnt=1

if ! [ -d "$urmeazaVerif" ] && ! [ -d "$verificate" ]; then
	mkdir "$urmeazaVerif"
	mkdir "$verificate"
fi

if [ -z "$(ls "$urmeazaVerif")" ]; then
	if [ -z "$(ls "$verificate")" ]; then #cazul de inceput, prima parsare a html-ului
		cat $fisierHTML | while read linie;do	
			link=$(echo "$linie" | awk -F'"' '{print $2}')
			wget -q -O /home/nico/itbi/proiect_itbi/urmeazaVerif/link${cnt} ${link}
			((cnt++))
		done 
	else 
		echo "ultimul caz, cand au fost verificate toate resursele"
	fi
else
	echo " " #cazul clasic in care se face parsarea noilor resurse si se memorizeaza resursele gasite pentru a fi parsate la nivelul urmator
fi
