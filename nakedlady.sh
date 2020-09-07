#!/bin/bash
#https://nakedlady.ru

t=0;
while [ 1 ]
do
	t=$(($t+1))
	wget -qO- https://nakedlady.ru/index.php?p=$t > web.html
	cat web.html | grep "jpg" | awk '{print $2'} | sed 's/href="//g' | sed 's/"//g'	> temp.txt
	rm web.html
	while read p; do
		wget https://nakedlady.ru/$p
	done < temp.txt
	rm temp.txt
done
