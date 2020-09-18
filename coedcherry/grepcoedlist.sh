#!/bin/bash
#use: ./grepcoedlist.sh file.txt
####################
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

while read x
do
	clear
	echo "Wait... Folder: $t"
	wget -qO- $x > temp.html
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
done < $1

clear
echo "Done"
ls
echo "========================="
cat $1
