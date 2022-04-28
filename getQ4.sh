#!/bin/sh
find . -type f -name 'mergedQ4*.csv' -delete
find . -type f -name 'headers.csv' -delete

n=$(($SLURM_ARRAY_TASK_ID+2008))
# n=2009
head -1 yellow_tripdata_2009-01.csv | cut -d, -f2,3,4,5,12,16,18 > headers.csv
cat headers.csv > mergedQ4_$n.csv

if [ $n -eq 2010 ]
then
    echo "year 2010"
    cat yellow_tripdata_$n-12.csv | cut -d, -f2,3,4,5,12,16,18 | sed 1,2d >> mergedQ4_$n.csv
else
i=10
while [ "$i" -le 12 ]; do
    echo $i
    cat yellow_tripdata_$n-$i.csv | cut -d, -f2,3,4,5,12,16,18 | sed 1,2d >> mergedQ4_$n.csv
    i=$(( i + 1 ))
done
fi
