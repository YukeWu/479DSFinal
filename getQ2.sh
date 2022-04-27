#!/bin/sh
find . -type f -name 'mergedQ2*.csv' -delete
find . -type f -name 'headers.csv' -delete

n=$(($SLURM_ARRAY_TASK_ID+2008))
head -1 yellow_tripdata_2009-01.csv | cut -d, -f2,4,5,12,16,18 > headers.csv
cat headers.csv > mergedQ2_$n.csv

if [ $n -eq 2011 ]
then
    echo "year 2011"
    cat yellow_tripdata_$n-05.csv | cut -d, -f2,3,4,5,12,16,18 | sed 1,2d >> mergedQ2_$n.csv
    cat yellow_tripdata_$n-06.csv | cut -d, -f2,3,4,5,12,16,18 | sed 1,2d >> mergedQ2_$n.csv
else
i=4
while [ "$i" -le 6 ]; do
    echo $i
    cat yellow_tripdata_$n-0$i.csv | cut -d, -f2,3,4,5,12,16,18 | sed 1,2d >> mergedQ2_$n.csv
    i=$(( i + 1 ))
done
fi
