#!/bin/bash
#Download multiple pics from like models
#https://www.coedcherry.com/models/mila-azul
#######################
tx=0;
wait="true"
while [[ $wait == "true" ]]
do
	if [[ -d $tx ]]
	then
		tx=$(($tx+1))
	else
		wait="false"
	fi
done

while [ 1 ]
do
	clear
	echo "Link:"
	read e
	mkdir $tx
	cd $tx
	wget -qO- $e > tempx.html
	cat tempx.html | grep "pics" | grep -v "random" | awk '{print $3'} | sed 's/href="//g' | sed 's/"//g' > tempx.txt
	rm tempx.html
	t=0;

	while read x
	do
		clear
		echo "Folder: $tx/$f"
	        f=$(echo $x | rev | cut -d "/" -f 1 | rev)
		mkdir $f
		cd $f
		wget -qO- $x > temp.html
		cat temp.html | grep "jpg" | awk '{print $2'} | sed 's/href="//g' | sed 's/"//g' > temp.txt
		rm temp.html

		while read p; do
			echo "Get: $p"
			wget -q "$p" && echo "Finished: $p"
		done < temp.txt
		echo "$x" > info.txt
		rm temp.txt
		t=$(($t+1))
		cd ..
	done < tempx.txt
	cd ..
	rm tempx.txt
	tx=$(($tx+1))
done
