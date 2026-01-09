#!/bin/bash

folder_wget="/home/$USER/folder_wget"
fisier_evidenta="/home/$USER/fisier_evidenta"
fisier_evidenta_secund="/home/$USER/fisier_evidenta_secund"
fisier_cnt="/home/$USER/fisier_cnt"
link=$1

if ! [ -d "$folder_wget" ] && ! [ -f "$fisier_evidenta" ]; then
	mkdir "$folder_wget"
	touch "$fisier_evidenta"
	touch "$fisier_cnt"
	echo "1" > $fisier_cnt
fi

if [ -z "$(ls "$folder_wget")" ]; then
		wget -q -O $folder_wget/link1 $link
		grep -Po '(?<=href=")[^"]*' "$folder_wget/link1" >> $fisier_evidenta
else
	if ! [ -z "$(cat $fisier_evidenta)" ]; then
		cat $fisier_evidenta | while read linie;do
			cnt=$(cat $fisier_cnt)
			((cnt++))
			wget -q -O $folder_wget/link$cnt $linie
			grep -Po '(?<=href=")[^"]*' "$folder_wget/link$cnt" > $fisier_evidenta_secund
			echo $cnt > $fisier_cnt
		done
		cat $fisier_evidenta_secund > $fisier_evidenta	
	else
		echo "Toate resursele au fost extrase, se gasesc la $folder_wget !"
	fi
fi
