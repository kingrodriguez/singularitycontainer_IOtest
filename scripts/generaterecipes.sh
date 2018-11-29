#!/usr/bin/env bash

numberofimages=$(head -n 1 ./settings)

rm -f ./recipes/ubuntugroup[0-9]*

i=1
while [ $i -le $numberofimages ]; do
	cat ./recipes/ubuntugroupmaster.recipe > ./recipes/ubuntugroup$i.recipe
	echo "	echo 'export VMID=$i' >> \$SINGULARITY_ENVIRONMENT" >> ./recipes/ubuntugroup$i.recipe
	echo "%runscript" >> ./recipes/ubuntugroup$i.recipe
	echo "~/singularity/scripts/runallmeasurements.sh" >> ./recipes/ubuntugroup$i.recipe
	#echo "	env | grep VMID > ~/singularity/localstorage/\$VMID" >> ./recipes/ubuntugroup$i.recipe
	let i+=1
done
