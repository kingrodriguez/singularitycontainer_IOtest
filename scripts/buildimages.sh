#!/usr/bin/env bash

numberofimages=$(head -n 1 ./settings)
i=1

rm -rf ./localstorage/*

sudo singularity build ./images/ubuntusolo.simg ./recipes/ubuntusolo.recipe

while [ $i -le $numberofimages ]; do
	sudo singularity build ./images/ubuntugroup$i.simg ./recipes/ubuntugroup$i.recipe
        let i+=1
done
