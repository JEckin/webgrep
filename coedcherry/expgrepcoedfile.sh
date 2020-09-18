#!/bin/bash
#Expant Grep Coedcherry for files
#Full Download from Contents
#########################
clear
if [[ $1 == "" ]]
then
	echo "File:"
	read e
else
e=$1
fi
echo "Folder:"
read tx
mkdir $tx
cd $tx
cat "../$e" | grep "pics" | grep -v "random" | awk '{print $3'} | sed 's/ng-href="//g' | sed 's/"//g' > tempx.txt
rm tempx.html

t=0;

while read x
do
	clear
	echo "Folder: $tx/$t"
	mkdir $t
	cd $t
	wget -qO- "https://coedcherry.com$x" > temp.html
	cat temp.html | grep "jpg" | awk '{print $2'} | sed 's/href="//g' | sed 's/"//g' > temp.txt
	rm temp.html
	while read p; do
		echo "Get: $p"
		wget -q "$p" && echo "Finished: $p"
	done < temp.txt
	echo "$x" > info.txt
	t=$(($t+1))
	cd ..

done < tempx.txt

