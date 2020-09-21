#!/bin/bash
#Download multiple pics from like models
#https://www.coedcherry.com/
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

if [[ $1 == "" ]]
then
	echo "./coedcherry.sh (how many pages) (newest,popularity)"
	exit
fi

if [[ $2 == "" ]]
then
sort="newest"
else
sort=$2
fi

#site=1

for (( site=1; site<=$1;site++))
#while [[ ! $site > $1 ]]
do
	clear
	mkdir $tx
	cd $tx
	wget -qO- "https://www.coedcherry.com/galleries?sort=$sort&page=$site" > tempx.html
	cat tempx.html | grep "pics" | grep -v "random" | awk '{print $3'} | sed 's/href="//g' | sed 's/"//g' > tempx.txt
	rm tempx.html

	while read x
	do
		clear
	        f=$(echo $x | rev | cut -d "/" -f 1 | rev)
		echo "Folder: $tx/$f"
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
		cd ..
	done < tempx.txt
	rm tempx.txt
	#site=$(($site+1))
done
cd ..
rdfind -deleteduplicates true . || apt install rdfind & rdfind -deleteduplicates true .
find -empty -type d -delete
