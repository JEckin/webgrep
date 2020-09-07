#!/bin/bash
#use: ./grepcoedlist.sh file.txt
####################
while [ 1 ]
do
	if [[ ! -f ./do.txt ]]
	then
		echo "0" > ./do.txt
	fi

	if [[ ! -f  ./links.txt ]]
	then
		touch ./links.txt
	fi

	temp=$(cat ./do.txt)
	if [[ $temp == "1" ]]
	then

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
			if [[ ! $x == "" ]]
			then
				clear
				echo "Wait... Folder: $t"
				wget -qO- $x > temp.html
				cat temp.html | grep "jpg" | awk '{print $2'} | sed 's/href="//g' | sed 's/"//g' > temp.txt
				rm temp.htm

				while read p; do
					wget "$p"
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
			fi
		done < ./links.txt
		echo "" > ./links.txt
		echo "0" > ./do.txt
		clear
	fi
	sleep 10
done


clear
echo "Done"
ls
echo "========================="
cat $1
