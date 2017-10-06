#!/bin/bash
IFS=$(echo -en "\n\b")
function RecursionCp() {
	echo $1
	cd $1
	for file in `ls`
	do 
		if [ -f $file ]
		then 
			mv $file /Volumes/NO\ NAME
		fi
		if [ -d $file ]
		then 
			RecursionCp $file
		fi
	done
	cd ..
}
cd /Users/zhuyichen/Music/iTunes/iTunes\ Media/Apple\ Music
echo `pwd`
for file in `ls`
do
	if [ -d $file ]
	then 
		RecursionCp $file
	fi
done

