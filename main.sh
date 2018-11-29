#!/usr/bin/env bash

data1=./data/1KB
data2=./data/10KB
data3=./data/100KB
data4=./data/1MB
data5=./data/10MB
data6=./data/100MB
data7=./data/1GB

image0=./images/ubuntusolo.simg
numberofimages=$(head -n 1 ./settings)
i=1
while [ $i -le $numberofimages ]; do
	export image$i=./images/ubuntugroup$i.simg
	let i+=1
done

if [ -e "$data1" ] && [ -e "$data2" ] && [ -e "$data3" ] && [ -e "$data4" ] && [ -e "$data5" ] && [ -e "$data6" ] && [ -e "$data7" ]; then
	echo "data found - nothing to do"
else
	echo "no data found - generating now"
	./scripts/generatedata.sh
fi

allimagesexist=true
i=0
while [ $i -le $numberofimages ]; do
	eval 'tmp=${'"image$i"'}'
	if [ ! -f $tmp ]; then
		export allimagesexist=false
	fi
	let i+=1
done

if $allimagesexist ; then
	echo "all images exist - nothing to do"
	#while true; do
	#	read -p "images found - build anyway? [y/N]" yn
	#	case $yn in
	#		[y]* ) echo "building now"; rm -rf ./images/*; ./scripts/generaterecipes.sh; ./scripts/buildimages.sh; break;;
	#		[N]* ) echo "nothing to do"; break;;
        #		* ) echo "Please answer with [y/N].";;
	#	esac
	#done
else
	echo "not all images found - building now"
	rm -rf ./images/*
	./scripts/generaterecipes.sh
	./scripts/buildimages.sh
fi

result="./results/$(find ~/singularity/results -type f -name '*.result' | wc -l).result"
touch $result
echo "running measurement on host"
export VMID=host
./scripts/runallmeasurements.sh
echo "running measurement in singularity"

./scripts/runallimages.sh

