#!/bin/bash
#https://nakedlady.ru/
t=0;
mkdir -p nakedlady

while [ 1 ]
do
	t=$(($t+1))
	####
	clear
	echo "$t"
	####
	wget -qO- https://nakedlady.ru/index.php?p=$t > web.html
	cat web.html | grep "jpg" | awk '{print $2'} | sed 's/href="//g' | sed 's/"//g'	> temp.txt
	rm web.html
	while read p; do
		wget -q https://nakedlady.ru/$p && echo "Finished: "$p
	done < temp.txt
	mv *.jpg nakedlady
	rm temp.txt
done
