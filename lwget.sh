#!/bin/bash

urmeazaVerif="/home/$USER/urmeazaVerif"
verificate="/home/$USER/verificate"
fisierHTML=$1


if ! [ -d "$urmeazaVerif" ] && ! [ -d "$verificate" ]; then
	mkdir "$urmeazaVerif"
	mkdir "$verificate"
fi

if [ -z "$(ls "$urmeazaVerif")" ]; then
	if [ -z "$(ls "$verificate")" ]; then #cazul de inceput, prima parsare a html-ului
		cat $fisierHTML | while read linie;do	
			link=$(echo "$linie" | awk -F'"' '{print $2}')
			if [ ! -z "$link" ] && [ "${linie:0:7}" == "<a href" ];then
				echo $link
				wget -q -O $urmeazaVerif/$link $link
				echo "done"
			fi
		done 
	else 
		echo "Toate resursele au fost extrase, se gasesc la $verificate !"
	fi
else
	echo "$(ls -1 "$urmeazaVerif")" | while read link_neverificat;do
		cat $urmeazaVerif/$link_neverificat | while read linie;do
			link=$(echo "$linie" | awk -F'"' '{print $2}')
				if [ ! -z "$link" ]  && [ "${linie:0:7}" == "<a href" ];then
					echo $link
					wget -q -O $urmeazaVerif/$link $link
					echo "done"
				fi
		done
	done
fi
