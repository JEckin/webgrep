#!/bin/bash
#
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
	read link
	echo "Extra Filter?"
	read filt
	mkdir $t
	cd $t

	wget -qO- "$link" > web.html
	if [[ $filt == "" ]]
	then
	cat web.html | grep -oP '(?<=https://).*?(?=.jpg)' > temp.txt
	else
	cat web.html | grep $filt | grep -oP '(?<=https://).*?(?=.jpg)' > temp.txt
	fi

	cat temp.txt
	echo "Press Enter to Start:"
	read temp

	rm web.html
	while read p; do
		wget -q "https://$p.jpg" && echo "Finished: https://"$p".jpg"
		#echo "https$p.jpg" >> $t/links.txt
		echo "https$p.jpg" >> links.txt
	done < temp.txt
	rm temp.txt
	#mv "*.jpg*" $t
	#echo $link >> $t/link.txt
	echo $link >> link.txt

	cd ..
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
