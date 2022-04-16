#!/bin/bash
echo "Hello, std from getData.sh."

n=$SLURM_ARRAY_TASK_ID
#n=9
if [ "$n" -lt 10 ]; then
#    echo "$n is less than 10"
#    LINK="http://pages.stat.wisc.edu/~jgillett/479/HPC/airlines/0$n.csv.bz2"
    LINK="https://www.kaggle.com/datasets/danilpan/yellow-new-york-taxi/download/jpVtjYp32hOLiGENal3T%2Fversions%2Feksalb68jHFWIKnJBGfo%2Ffiles%2Fyellow_tripdata_2009-0$n.csv?datasetVersionNumber=3"
    RESULT="my_file_09_0$n.zip"
#    echo ${LINK}
    wget -x --load-cookies cookies.txt ${LINK} -O ${RESULT}
    unzip ${RESULT}
else
#    echo "$n is greater than or equal to 10"
#    LINK="http://pages.stat.wisc.edu/~jgillett/479/HPC/airlines/$n.csv.bz2"
    LINK="https://www.kaggle.com/datasets/danilpan/yellow-new-york-taxi/download/jpVtjYp32hOLiGENal3T%2Fversions%2Feksalb68jHFWIKnJBGfo%2Ffiles%2Fyellow_tripdata_2009-$n.csv?datasetVersionNumber=3"
    RESULT="my_file_09_$n.zip"
#    echo ${LINK}
    wget -x --load-cookies cookies.txt ${LINK} -O ${RESULT}
    unzip ${RESULT}
fi
#wget http://pages.stat.wisc.edu/~jgillett/479/HPC/airlines/$n.csv.bz2
#bzip2 -d $n.csv.bz2
