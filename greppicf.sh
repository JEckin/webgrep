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

if [[ "$1" == "" ]]
then
echo "./grep file.txt"
exit
fi

mkdir $t
mv "$1" $t
cd $t

cat "$1" | grep -oP '(?<=https://).*?(?=.jpg)' > temp.txt
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
