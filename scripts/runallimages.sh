#!/usr/bin/env bash

echo "measuring single machine"
singularity run ./images/ubuntusolo.simg

numberofimages=$(head -n 1 ./settings)

i=1
echo "measuring $numberofimages machines parallel"
while [ $i -le $numberofimages ]; do
	singularity run ./images/ubuntugroup$i.simg &
	export BACK_PID$i=$!
        let i+=1
done

i=1
while [ $i -le $numberofimages ]; do
	eval 'wait ${'"BACK_PID$i"'}'
        let i+=1
done

echo "measuring done"
