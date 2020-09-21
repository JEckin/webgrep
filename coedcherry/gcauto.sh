#!/bin/bash
#use: ./gcauto
#Use it as a service
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


		while read x
		do
			if [[ ! $x == "" ]]
			then
			        f=$(echo $x | rev | cut -d "/" -f 1 | rev)
				clear
				echo "Wait... Folder: $f"
				wget -qO- $x > temp.html
				cat temp.html | grep "jpg" | awk '{print $2'} | sed 's/href="//g' | sed 's/"//g' > temp.txt
				rm temp.htm

				while read p; do
					wget "$p"
				done < temp.txt
				mkdir $f
				echo "$a" > $f/info.txt
				mv *.jpg $f
				rm temp.txt
				#remove empty folder
				rmdir *
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
