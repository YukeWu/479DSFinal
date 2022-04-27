#!/bin/sh
find . -type f -name 'mergedQ1*.csv' -delete
find . -type f -name 'headers.csv' -delete

n=$(($SLURM_ARRAY_TASK_ID+2008))
head -1 yellow_tripdata_2009-01.csv | cut -d, -f2,4,5,12,16,18 > headers.csv
cat headers.csv > mergedQ1_$n.csv

if [ $n -eq 2011 ]
then
    echo "year 2011"
    cat yellow_tripdata_$n-03.csv | cut -d, -f2,3,4,5,12,16,18 | sed 1,2d >> mergedQ1_$n.csv
else
i=1
while [ "$i" -le 3 ]; do
    echo $i
    cat yellow_tripdata_$n-0$i.csv | cut -d, -f2,3,4,5,12,16,18 | sed 1,2d >> mergedQ1_$n.csv
    i=$(( i + 1 ))
done
fi
