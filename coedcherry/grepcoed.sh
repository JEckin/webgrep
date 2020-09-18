#!/bin/bash
#use: ./grepcoed.sh
#and then post the link https://www.coedcherry.com/models/eva-elfie/pics/eva-elfie-sunny-stairs
##################
t=0;
wait="true"
while [[ $wait == "true" ]]
do
	if [[ -d $t ]]
	then
		t=$(($t+1))
	else
		wait="false"
	fi
done

while [ 1 ]
do
	clear
	echo "Folder: $t"
	read a
	wget -qO- $a > temp.html
	cat temp.html | grep "jpg" | awk '{print $2'} | sed 's/href="//g' | sed 's/"//g' > temp.txt
	rm temp.html

	while read p; do
		echo "Get: $p"
		wget -q "$p" && echo "Finished: $p"
	done < temp.txt
	mkdir $t
	echo "$a" > $t/info.txt
	mv *.jpg $t
	rm temp.txt
	t=$(($t+1))
	#remove empty folder
	rmdir *
	#If folder does exist
	wait="true"
	while [[ $wait == "true" ]]
	do
		if [[ -d $t ]]
		then
			t=$(($t+1))
		else
			wait="false"
		fi
	done

done
