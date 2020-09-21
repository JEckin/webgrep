#!/bin/bash
#use: ./grepcoed.sh
#and then post the link https://www.coedcherry.com/models/eva-elfie/pics/eva-elfie-sunny-stairs
##################
while [ 1 ]
do
	clear
	echo "Link: "
	read a
	clear
        f=$(echo $a | rev | cut -d "/" -f 1 | rev)
	echo "Folder: $f"
	mkdir $f
	cd $f
	wget -qO- $a > temp.html
	cat temp.html | grep "jpg" | awk '{print $2'} | sed 's/href="//g' | sed 's/"//g' > temp.txt
	rm temp.html

	while read p; do
		echo "Get: $p"
		wget -q "$p" && echo "Finished: $p"
	done < temp.txt
	echo "$a" > info.txt
	rm temp.txt
	cd ..
	#remove empty folder
	rmdir *
done
