#!/usr/bin/env bash

count=$(($(find ~/singularity/results -type f -name '*.result' | wc -l) -1))
result="./results/$count.result"
resultlocal="./localstorage/$VMID"

echo "###<<<<<<<$VMID>>>>>>>###" > $resultlocal
echo "<<<<<<<1KB>>>>>>>" >> $resultlocal
{ time python3 ~/singularity/scripts/readdata.py 1KB ; } 2>> $resultlocal
echo "<<<<<<<10KB>>>>>>>" >> $resultlocal
{ time python3 ~/singularity/scripts/readdata.py 10KB ; } 2>> $resultlocal
echo "<<<<<<<100KB>>>>>>>" >> $resultlocal
{ time python3 ~/singularity/scripts/readdata.py 100KB ; } 2>> $resultlocal
echo "<<<<<<<1MB>>>>>>>" >> $resultlocal
{ time python3 ~/singularity/scripts/readdata.py 1MB ; } 2>> $resultlocal
echo "<<<<<<<10MB>>>>>>>" >> $resultlocal
{ time python3 ~/singularity/scripts/readdata.py 10MB ; } 2>> $resultlocal
echo "<<<<<<<100MB>>>>>>>" >> $resultlocal
{ time python3 ~/singularity/scripts/readdata.py 100MB ; } 2>> $resultlocal
echo "<<<<<<<1GB>>>>>>>" >> $resultlocal
{ time python3 ~/singularity/scripts/readdata.py 1GB ; } 2>> $resultlocal

cat $resultlocal >> $result
